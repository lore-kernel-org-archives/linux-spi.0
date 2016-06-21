From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Use local struct spi_master pointer in pump_transfers()" to the spi tree
Date: Tue, 21 Jun 2016 19:53:10 +0100
Message-ID: <E1bFQnO-00005I-QQ@debutante>
References: <1466504494-8984-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466504494-8984-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use local struct spi_master pointer in pump_transfers()

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

>From 2d7537d8f64184debed89a57aa7bea5d27b76a90 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 21 Jun 2016 13:21:33 +0300
Subject: [PATCH] spi: pxa2xx: Use local struct spi_master pointer in
 pump_transfers()

We will find more use for struct spi_master pointer in pump_transfers()
and code will be more readable if we access it using local pointer than
through the drv_data->master.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 27e03076f379..e5c457abb596 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -915,6 +915,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 static void pump_transfers(unsigned long data)
 {
 	struct driver_data *drv_data = (struct driver_data *)data;
+	struct spi_master *master = drv_data->master;
 	struct spi_message *message = NULL;
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
@@ -1072,12 +1073,12 @@ static void pump_transfers(unsigned long data)
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
 	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz
+			master->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			drv_data->dma_mapped ? "DMA" : "PIO");
 	else
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			drv_data->master->max_speed_hz / 2
+			master->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			drv_data->dma_mapped ? "DMA" : "PIO");
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
