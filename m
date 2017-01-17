From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Factor out handle_bad_msg" to the spi tree
Date: Tue, 17 Jan 2017 18:46:20 +0000
Message-ID: <E1cTYlw-0000Vs-Kw@debutante>
References: <776c72d3de4b75ff0a8b91791740389950d8abe8.1484592296.git.jan.kiszka@siemens.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Sascha Weisenberger <sascha.weisenberger-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <776c72d3de4b75ff0a8b91791740389950d8abe8.1484592296.git.jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Factor out handle_bad_msg

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b03124825b8612bf371e5b4ccc2cd812ed3c2dbb Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 16 Jan 2017 19:44:54 +0100
Subject: [PATCH] spi: pxa2xx: Factor out handle_bad_msg

As suggested by Andy Shevchenko: Decouple this corner cause from the
general handling logic in ssp_int.

Signed-off-by: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d6239fa718be..8c65bc1823f3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -732,6 +732,20 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	return IRQ_HANDLED;
 }
 
+static void handle_bad_msg(struct driver_data *drv_data)
+{
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+	pxa2xx_spi_write(drv_data, SSCR1,
+			 pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1);
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, 0);
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
+
+	dev_err(&drv_data->pdev->dev,
+		"bad message state in interrupt handler\n");
+}
+
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
@@ -772,20 +786,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (!drv_data->master->cur_msg) {
-
-		pxa2xx_spi_write(drv_data, SSCR0,
-				 pxa2xx_spi_read(drv_data, SSCR0)
-				 & ~SSCR0_SSE);
-		pxa2xx_spi_write(drv_data, SSCR1,
-				 pxa2xx_spi_read(drv_data, SSCR1)
-				 & ~drv_data->int_cr1);
-		if (!pxa25x_ssp_comp(drv_data))
-			pxa2xx_spi_write(drv_data, SSTO, 0);
-		write_SSSR_CS(drv_data, drv_data->clear_sr);
-
-		dev_err(&drv_data->pdev->dev,
-			"bad message state in interrupt handler\n");
-
+		handle_bad_msg(drv_data);
 		/* Never fail */
 		return IRQ_HANDLED;
 	}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
