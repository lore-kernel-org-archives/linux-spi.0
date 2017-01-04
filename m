From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: fix indentation of the comments in header" to the spi tree
Date: Wed, 04 Jan 2017 18:37:18 +0000
Message-ID: <E1cOqR4-00020s-D4@debutante>
References: <20170102114429.128094-2-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170102114429.128094-2-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: fix indentation of the comments in header

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

>From 63971c5682bf89e15083733dcd7b4610e789e843 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 2 Jan 2017 13:44:29 +0200
Subject: [PATCH] spi: pxa2xx: fix indentation of the comments in header

Just for sake of readability fix the indentation of the comments in
pxa2xx_ssp.h header file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
