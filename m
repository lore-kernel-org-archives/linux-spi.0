From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V1 2/2] spi: fsl-lpspi: quit reading rx fifo under error condition
Date: Fri, 2 Dec 2016 11:50:01 +0800
Message-ID: <1480650601-12810-2-git-send-email-pandy.gao@nxp.com>
References: <1480650601-12810-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480650601-12810-1-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In case that error occurs during waiting for txfifo empty, it is
not necessary to read rx fifo. It's better to return directly.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c4a4e262..52551f6 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -350,9 +350,12 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 	}
 
 	ret = fsl_lpspi_txfifo_empty(fsl_lpspi);
+	if (ret)
+		return ret;
+
 	fsl_lpspi_read_rx_fifo(fsl_lpspi);
 
-	return ret;
+	return 0;
 }
 
 static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
