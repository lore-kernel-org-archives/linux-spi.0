From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: use prepare_transfer_hardware() for lpspi" to the spi tree
Date: Fri, 25 Nov 2016 13:10:37 +0000
Message-ID: <E1cAGGz-0005K6-GC@debutante>
References: <1479985484-6641-3-git-send-email-pandy.gao@nxp.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pandy.gao-3arQi8VN3Tc@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org,
        fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479985484-6641-3-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: use prepare_transfer_hardware() for lpspi

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

>From 3ffa1a5dc696f661754bf145813433fda92371b2 Mon Sep 17 00:00:00 2001
From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Date: Thu, 24 Nov 2016 19:04:44 +0800
Subject: [PATCH] spi: imx: use prepare_transfer_hardware() for lpspi

The old driver enable clk in fsl_lpspi_prepare_message() and
disable clk in fsl_lpspi_unprepare_message().

Rather than doing this per message it's a bit better to do it
in prepare_transfer_hardware(), that way if there's a sequence
of messages queued one after another we don't turn the clock on
and off all the time.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index bcb7b284d2f2..d7ce32aa083b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -148,16 +148,14 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
 
-static int fsl_lpspi_prepare_message(struct spi_master *master,
-				     struct spi_message *msg)
+static int lpspi_prepare_xfer_hardware(struct spi_master *master)
 {
 	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
 
 	return clk_prepare_enable(fsl_lpspi->clk);
 }
 
-static int
-fsl_lpspi_unprepare_message(struct spi_master *master, struct spi_message *msg)
+static int lpspi_unprepare_xfer_hardware(struct spi_master *master)
 {
 	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
 
@@ -438,8 +436,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->dev = &pdev->dev;
 
 	master->transfer_one_message = fsl_lpspi_transfer_one_msg;
-	master->prepare_message = fsl_lpspi_prepare_message;
-	master->unprepare_message = fsl_lpspi_unprepare_message;
+	master->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
+	master->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 	master->dev.of_node = pdev->dev.of_node;
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
