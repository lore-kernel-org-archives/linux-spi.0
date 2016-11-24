From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 3/3] spi: imx: use prepare_transfer_hardware() for lpspi
Date: Thu, 24 Nov 2016 19:04:44 +0800
Message-ID: <1479985484-6641-3-git-send-email-pandy.gao@nxp.com>
References: <1479985484-6641-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479985484-6641-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The old driver enable clk in fsl_lpspi_prepare_message() and
disable clk in fsl_lpspi_unprepare_message().

Rather than doing this per message it's a bit better to do it
in prepare_transfer_hardware(), that way if there's a sequence
of messages queued one after another we don't turn the clock on
and off all the time.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index bc4a605..539c971 100644
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
