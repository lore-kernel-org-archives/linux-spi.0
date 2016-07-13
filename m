From: Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH RFCv1 1/1] spi: Expand tx_nbits/rx_nbits to add 8-bit transfer
Date: Wed, 13 Jul 2016 13:34:37 -0600
Message-ID: <1468438477-18883-2-git-send-email-girishm@codeaurora.org>
References: <1468438477-18883-1-git-send-email-girishm@codeaurora.org>
Cc: sboyd@codeaurora.org, sdharia@codeaurora.org,
	girishm@codeaurora.org, linux-arm-msm@vger.kernel.org
To: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1468438477-18883-1-git-send-email-girishm@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Expand the tx_nbits/rx_nbits member of the spi_transfer struct to a 4 bit
value to allow specifying 8 bit transfers (SPI_NBITS_OCTO).

Change-Id: I0b7ab41b2caa8495da431944ccbc0b90942d5dd9
Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
---
 include/linux/spi/spi.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1..45b958a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -717,10 +717,11 @@ extern void spi_res_release(struct spi_master *master,
  * by the results of previous messages and where the whole transaction
  * ends when the chipselect goes intactive.
  *
- * When SPI can transfer in 1x,2x or 4x. It can get this transfer information
+ * When SPI can transfer in 1x,2x,4x or 8x. It can get this transfer information
  * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
  * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
- * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
+ * SPI_NBITS_DUAL(2x) SPI_NBITS_QUAD(4x) and SPI_NBITS_OCTO(8x) to support
+ * these four transfers.
  *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
@@ -744,11 +745,12 @@ struct spi_transfer {
 	struct sg_table rx_sg;
 
 	unsigned	cs_change:1;
-	unsigned	tx_nbits:3;
-	unsigned	rx_nbits:3;
+	unsigned	tx_nbits:4;
+	unsigned	rx_nbits:4;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
+#define	SPI_NBITS_OCTO		0x08 /* 4bits transfer */
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
