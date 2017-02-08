From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance
Date: Wed,  8 Feb 2017 15:15:04 -0500
Message-ID: <1486584904-29124-1-git-send-email-kdasu.kdev@gmail.com>
Cc: f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Let bcm_qspi_bspi_flash_read() return all the requested bytes by breaking
up the reads for BSPI block into optimal chunks size that a BSPI block can
handle.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 83 +++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 14f9dea..5d9d063 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -89,7 +89,7 @@
 #define BSPI_BPP_MODE_SELECT_MASK		BIT(8)
 #define BSPI_BPP_ADDR_SELECT_MASK		BIT(16)
 
-#define BSPI_READ_LENGTH			256
+#define BSPI_READ_LENGTH			512
 
 /* MSPI register offsets */
 #define MSPI_SPCR0_LSB				0x000
@@ -813,7 +813,7 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 				    struct spi_flash_read_message *msg)
 {
 	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
-	u32 addr = 0, len, len_words;
+	u32 addr = 0, len, rdlen, len_words;
 	int ret = 0;
 	unsigned long timeo = msecs_to_jiffies(100);
 	struct bcm_qspi_soc_intc *soc_intc = qspi->soc_intc;
@@ -826,7 +826,7 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
 
 	/*
-	 * when using flex mode mode we need to send
+	 * when using flex mode we need to send
 	 * the upper address byte to bspi
 	 */
 	if (bcm_qspi_bspi_ver_three(qspi) == false) {
@@ -840,47 +840,56 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 	else
 		addr = msg->from & 0x00ffffff;
 
-	/* set BSPI RAF buffer max read length */
-	len = msg->len;
-	if (len > BSPI_READ_LENGTH)
-		len = BSPI_READ_LENGTH;
-
 	if (bcm_qspi_bspi_ver_three(qspi) == true)
 		addr = (addr + 0xc00000) & 0xffffff;
 
-	reinit_completion(&qspi->bspi_done);
-	bcm_qspi_enable_bspi(qspi);
-	len_words = (len + 3) >> 2;
-	qspi->bspi_rf_msg = msg;
-	qspi->bspi_rf_msg_status = 0;
+	/*
+	 * read into the entire buffer by breaking the reads
+	 * into RAF buffer read lengths
+	 */
+	len = msg->len;
 	qspi->bspi_rf_msg_idx = 0;
-	qspi->bspi_rf_msg_len = len;
-	dev_dbg(&qspi->pdev->dev, "bspi xfr addr 0x%x len 0x%x", addr, len);
-
-	bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
-	bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
-	bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
 
-	if (qspi->soc_intc) {
-		/*
-		 * clear soc MSPI and BSPI interrupts and enable
-		 * BSPI interrupts.
-		 */
-		soc_intc->bcm_qspi_int_ack(soc_intc, MSPI_BSPI_DONE);
-		soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE, true);
-	}
+	do {
+		if (len > BSPI_READ_LENGTH)
+			rdlen = BSPI_READ_LENGTH;
+		else
+			rdlen = len;
+
+		reinit_completion(&qspi->bspi_done);
+		bcm_qspi_enable_bspi(qspi);
+		len_words = (rdlen + 3) >> 2;
+		qspi->bspi_rf_msg = msg;
+		qspi->bspi_rf_msg_status = 0;
+		qspi->bspi_rf_msg_len = rdlen;
+		dev_dbg(&qspi->pdev->dev,
+			"bspi xfr addr 0x%x len 0x%x", addr, rdlen);
+		bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
+		bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
+		bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
+		if (qspi->soc_intc) {
+			/*
+			 * clear soc MSPI and BSPI interrupts and enable
+			 * BSPI interrupts.
+			 */
+			soc_intc->bcm_qspi_int_ack(soc_intc, MSPI_BSPI_DONE);
+			soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE, true);
+		}
 
-	/* Must flush previous writes before starting BSPI operation */
-	mb();
+		/* Must flush previous writes before starting BSPI operation */
+		mb();
+		bcm_qspi_bspi_lr_start(qspi);
+		if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
+			dev_err(&qspi->pdev->dev, "timeout waiting for BSPI\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
 
-	bcm_qspi_bspi_lr_start(qspi);
-	if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
-		dev_err(&qspi->pdev->dev, "timeout waiting for BSPI\n");
-		ret = -ETIMEDOUT;
-	} else {
-		/* set the return length for the caller */
-		msg->retlen = len;
-	}
+		/* set msg return length */
+		msg->retlen += rdlen;
+		addr += rdlen;
+		len -= rdlen;
+	} while (len);
 
 	return ret;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
