From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: Gracefully handle NULL master->cs_gpios" to the spi tree
Date: Mon, 26 Sep 2016 09:15:54 -0700
Message-ID: <E1boYZO-0005bT-O5@finisterre>
References: <20160926121453.8380-1-marex@denx.de>
Cc: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160926121453.8380-1-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: Gracefully handle NULL master->cs_gpios

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

>From f13d4e189d209af0f552e9900acd06ee4a35e601 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Date: Mon, 26 Sep 2016 14:14:53 +0200
Subject: [PATCH] spi: imx: Gracefully handle NULL master->cs_gpios

It is possible that master->cs_gpios is NULL after spi_bitbang_start(),
this happens if the master has no CS GPIOs specified in DT. Check for
this case after spi_bitbang_start() to prevent NULL pointer dereference
in the subsequent for loop, which accesses the master->cs_gpios field.

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 53e7a326c213..1ef5429afcb6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1268,6 +1268,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
+	if (!master->cs_gpios) {
+		dev_err(&pdev->dev, "No CS GPIOs available\n");
+		goto out_clk_put;
+	}
+
 	for (i = 0; i < master->num_chipselect; i++) {
 		if (!gpio_is_valid(master->cs_gpios[i]))
 			continue;
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
