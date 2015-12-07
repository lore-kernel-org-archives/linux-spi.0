From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: add function to check for IMX51 family controller" to the spi tree
Date: Mon, 07 Dec 2015 19:54:14 +0000
Message-ID: <E1a61rS-0003bP-AJ@debutante>
References: <1449334629-4715-5-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449334629-4715-5-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: add function to check for IMX51 family controller

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

>From f8a876176f38e00aab200d308506ca4a4ba57b39 Mon Sep 17 00:00:00 2001
From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 5 Dec 2015 17:57:02 +0100
Subject: [PATCH] spi: imx: add function to check for IMX51 family controller

Similar to other controller type checks add check function for
IMX51. It includes IMX53 and IMX6.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index beba40b08ed1..410522fdd4c9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -122,9 +122,14 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
 	return d->devtype_data->devtype == IMX35_CSPI;
 }
 
+static inline int is_imx51_ecspi(struct spi_imx_data *d)
+{
+	return d->devtype_data->devtype == IMX51_ECSPI;
+}
+
 static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
 {
-	return (d->devtype_data->devtype == IMX51_ECSPI) ? 64 : 8;
+	return is_imx51_ecspi(d) ? 64 : 8;
 }
 
 #define MXC_SPI_BUF_RX(type)						\
@@ -1210,8 +1215,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	 * Only validated on i.mx6 now, can remove the constrain if validated on
 	 * other chips.
 	 */
-	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data
-	    && spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
+	if (is_imx51_ecspi(spi_imx) &&
+	    spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
 		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
 
 	spi_imx->devtype_data->reset(spi_imx);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
