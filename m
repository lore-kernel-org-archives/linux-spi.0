From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance" to the spi tree
Date: Thu, 16 Feb 2017 12:45:40 +0000
Message-ID: <E1ceLRM-0004vm-Qg@debutante>
References: <1486584904-29124-1-git-send-email-kdasu.kdev@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486584904-29124-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance

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

>From 345309fa7c0c9206a5344d379b174499952d79d9 Mon Sep 17 00:00:00 2001
From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 8 Feb 2017 15:15:04 -0500
Subject: [PATCH] spi: bcm-qspi: Fix bcm_qspi_bspi_read() performance

Let bcm_qspi_bspi_flash_read() return all the requested bytes by breaking
up the reads for BSPI block into optimal chunks size that a BSPI block can
handle.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 83 +++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index b50b6dfc8c48..99b3057531a5 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -89,7 +89,7 @@
 #define BSPI_BPP_MODE_SELECT_MASK		BIT(8)
 #define BSPI_BPP_ADDR_SELECT_MASK		BIT(16)
 
-#define BSPI_READ_LENGTH			256
+#define BSPI_READ_LENGTH			512
 
 /* MSPI register offsets */
 #define MSPI_SPCR0_LSB				0x000
@@ -824,7 +824,7 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 				    struct spi_flash_read_message *msg)
 {
 	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
-	u32 addr = 0, len, len_words;
+	u32 addr = 0, len, rdlen, len_words;
 	int ret = 0;
 	unsigned long timeo = msecs_to_jiffies(100);
 	struct bcm_qspi_soc_intc *soc_intc = qspi->soc_intc;
@@ -837,7 +837,7 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
 	bcm_qspi_write(qspi, MSPI, MSPI_WRITE_LOCK, 0);
 
 	/*
-	 * when using flex mode mode we need to send
+	 * when using flex mode we need to send
 	 * the upper address byte to bspi
 	 */
 	if (bcm_qspi_bspi_ver_three(qspi) == false) {
@@ -851,47 +851,56 @@ static int bcm_qspi_bspi_flash_read(struct spi_device *spi,
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
