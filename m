From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 1/2] spi: imx: use wait_for_completion_timeout() while waiting transfer done
Date: Mon, 28 Nov 2016 11:02:59 +0800
Message-ID: <1480302180-15550-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It's a potential problem to use wait_for_completion() because the
completion condition may never come. Thus, it's better to repalce
wait_for_completion() with wait_for_completion_timeout().

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 539c971..47a97ad 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -348,7 +348,12 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 
 	reinit_completion(&fsl_lpspi->xfer_done);
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
-	wait_for_completion(&fsl_lpspi->xfer_done);
+
+	ret = wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ);
+	if (!ret) {
+		dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
+		return -ETIMEDOUT;
+	}
 
 	ret = fsl_lpspi_txfifo_empty(fsl_lpspi);
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
