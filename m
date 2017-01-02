From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/2] spi: pxa2xx: fix indentation of the comments in header
Date: Mon,  2 Jan 2017 13:44:29 +0200
Message-ID: <20170102114429.128094-2-andriy.shevchenko@linux.intel.com>
References: <20170102114429.128094-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170102114429.128094-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Just for sake of readability fix the indentation of the comments in
pxa2xx_ssp.h header file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/pxa2xx_ssp.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 2d6f0c39ed68..a0522328d7aa 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -90,9 +90,9 @@
 #define SSSR_RFL_MASK	(0xf << 12)	/* Receive FIFO Level mask */
 
 #define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
-#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..16] */
 #define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
-#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..16] */
 
 #define RX_THRESH_CE4100_DFLT	2
 #define TX_THRESH_CE4100_DFLT	2
@@ -106,9 +106,9 @@
 #define CE4100_SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..4] */
 
 /* QUARK_X1000 SSCR0 bit definition */
-#define QUARK_X1000_SSCR0_DSS	(0x1F)		/* Data Size Select (mask) */
-#define QUARK_X1000_SSCR0_DataSize(x)  ((x) - 1)	/* Data Size Select [4..32] */
-#define QUARK_X1000_SSCR0_FRF	(0x3 << 5)	/* FRame Format (mask) */
+#define QUARK_X1000_SSCR0_DSS		(0x1F << 0)	/* Data Size Select (mask) */
+#define QUARK_X1000_SSCR0_DataSize(x)	((x) - 1)	/* Data Size Select [4..32] */
+#define QUARK_X1000_SSCR0_FRF		(0x3 << 5)	/* FRame Format (mask) */
 #define QUARK_X1000_SSCR0_Motorola	(0x0 << 5)	/* Motorola's Serial Peripheral Interface (SPI) */
 
 #define RX_THRESH_QUARK_X1000_DFLT	1
@@ -121,8 +121,8 @@
 #define QUARK_X1000_SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..32] */
 #define QUARK_X1000_SSCR1_RFT	(0x1F << 11)	/* Receive FIFO Threshold (mask) */
 #define QUARK_X1000_SSCR1_RxTresh(x) (((x) - 1) << 11)	/* level [1..32] */
-#define QUARK_X1000_SSCR1_STRF       (1 << 17)		/* Select FIFO or EFWR */
-#define QUARK_X1000_SSCR1_EFWR	(1 << 16)		/* Enable FIFO Write/Read */
+#define QUARK_X1000_SSCR1_STRF	(1 << 17)	/* Select FIFO or EFWR */
+#define QUARK_X1000_SSCR1_EFWR	(1 << 16)	/* Enable FIFO Write/Read */
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
