From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 6/9] spi/pxa2xx: Consider CE4100's FIFO depth
Date: Wed, 24 Nov 2010 12:13:24 +0100
Message-ID: <1290597207-29838-7-git-send-email-bigeasy@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1290597207-29838-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

For PXA the default threshold is FIFO_DEPTH / 2. Adjust this value for
CE4100.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/include/asm/pxa2xx_ssp.h |   15 +++++++++++++++
 arch/x86/include/asm/pxa2xx_ssp.h |   15 +++++++++++++++
 drivers/spi/pxa2xx_spi.c          |    2 --
 include/linux/pxa2xx_ssp.h        |    7 +------
 4 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/include/asm/pxa2xx_ssp.h
 create mode 100644 arch/x86/include/asm/pxa2xx_ssp.h

diff --git a/arch/arm/include/asm/pxa2xx_ssp.h b/arch/arm/include/asm/pxa2xx_ssp.h
new file mode 100644
index 0000000..49eaab7
--- /dev/null
+++ b/arch/arm/include/asm/pxa2xx_ssp.h
@@ -0,0 +1,15 @@
+#ifndef ASM_PXA2XX_SSP_H
+#define ASM_PXA2XX_SSP_H
+
+#define RX_THRESH_DFLT	8
+#define TX_THRESH_DFLT	8
+
+#define SSSR_TFL_MASK	(0xf << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK	(0xf << 12)	/* Receive FIFO Level mask */
+
+#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
+#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
+
+#endif
diff --git a/arch/x86/include/asm/pxa2xx_ssp.h b/arch/x86/include/asm/pxa2xx_ssp.h
new file mode 100644
index 0000000..217e584
--- /dev/null
+++ b/arch/x86/include/asm/pxa2xx_ssp.h
@@ -0,0 +1,15 @@
+#ifndef ASM_PXA2XX_SSP_H
+#define ASM_PXA2XX_SSP_H
+
+#define RX_THRESH_DFLT	2
+#define TX_THRESH_DFLT	2
+
+#define SSSR_TFL_MASK	(0x3 << 8)	/* Transmit FIFO Level mask */
+#define SSSR_RFL_MASK	(0x3 << 12)	/* Receive FIFO Level mask */
+
+#define SSCR1_TFT	(0x000000c0)	/* Transmit FIFO Threshold (mask) */
+#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..4] */
+#define SSCR1_RFT	(0x00000c00)	/* Receive FIFO Threshold (mask) */
+#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..4] */
+
+#endif
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 17c1bfb..fcb5d67 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -43,8 +43,6 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define MAX_BUSES 3
 
-#define RX_THRESH_DFLT 	8
-#define TX_THRESH_DFLT 	8
 #define TIMOUT_DFLT		1000
 
 #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 84465d4..12d3b19 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -21,6 +21,7 @@
 
 #include <linux/list.h>
 #include <linux/io.h>
+#include <asm/pxa2xx_ssp.h>
 
 /*
  * SSP Serial Port Registers
@@ -71,10 +72,6 @@
 #define SSCR1_SPO	(1 << 3)	/* Motorola SPI SSPSCLK polarity setting */
 #define SSCR1_SPH	(1 << 4)	/* Motorola SPI SSPSCLK phase setting */
 #define SSCR1_MWDS	(1 << 5)	/* Microwire Transmit Data Size */
-#define SSCR1_TFT	(0x000003c0)	/* Transmit FIFO Threshold (mask) */
-#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..16] */
-#define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
-#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
 
 #define SSSR_TNF	(1 << 2)	/* Transmit FIFO Not Full */
 #define SSSR_RNE	(1 << 3)	/* Receive FIFO Not Empty */
@@ -82,8 +79,6 @@
 #define SSSR_TFS	(1 << 5)	/* Transmit FIFO Service Request */
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
-#define SSSR_TFL_MASK   (0xf << 8)	/* Transmit FIFO Level mask */
-#define SSSR_RFL_MASK   (0xf << 12)	/* Receive FIFO Level mask */
 
 /* extra bits in PXA255, PXA26x and PXA27x SSP ports */
 #define SSCR0_TISSP		(1 << 4)	/* TI Sync Serial Protocol */
-- 
1.7.3.2


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
