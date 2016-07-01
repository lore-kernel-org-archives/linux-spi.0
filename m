From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] spi: imx: wait_for_completion_timeout(..) for PIO transfers
Date: Fri,  1 Jul 2016 14:32:58 +0200
Message-ID: <1467376378-21535-1-git-send-email-christian.gmeiner@gmail.com>
References: <20160621185100.GD28202@sirena.org.uk>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
	Christian Gmeiner <christian.gmeiner@gmail.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621185100.GD28202@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In some rare cases I see the following 'task blocked' information. It
looks like the PIO transfer has some problems and never succeeds. Make
use of wait_for_completion_timeout(..) to detect this case and
return -ETIMEDOUT.

v2: remove backtrace from commit message

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/spi/spi-imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 50769078..d2b96b1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1050,6 +1050,8 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
+	unsigned long transfer_timeout;
+	unsigned long timeout;
 
 	spi_imx->tx_buf = transfer->tx_buf;
 	spi_imx->rx_buf = transfer->rx_buf;
@@ -1062,7 +1064,15 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 
 	spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
 
-	wait_for_completion(&spi_imx->xfer_done);
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
+	timeout = wait_for_completion_timeout(&spi_imx->xfer_done,
+					      transfer_timeout);
+	if (!timeout) {
+		dev_err(&spi->dev, "I/O Error in PIO\n");
+		spi_imx->devtype_data->reset(spi_imx);
+		return -ETIMEDOUT;
+	}
 
 	return transfer->len;
 }
-- 
2.7.4
