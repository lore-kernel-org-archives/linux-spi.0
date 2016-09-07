From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: Default thresholds to PXA configuration
Date: Wed,  7 Sep 2016 03:35:12 +0300
Message-ID: <20160907003512.33040-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Most of the devices in the supported list have PXA configuration of FIFO. In
particularly Intel Merrifield has bigger FIFO, than it's defined for CE4100.

Split CE4100 in the similar way how it was done for Intel Quark, i.e. prefix
definitions by CE4100 and append necessary pieces of code to switch case
conditions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c   | 38 +++++++++++++++++++++++++++++++++-----
 include/linux/pxa2xx_ssp.h | 20 ++++++++------------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7bb7db0..711015a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -186,6 +186,8 @@ pxa2xx_spi_get_rx_default_thre(const struct driver_data *drv_data)
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		return RX_THRESH_QUARK_X1000_DFLT;
+	case CE4100_SSP:
+		return RX_THRESH_CE4100_DFLT;
 	default:
 		return RX_THRESH_DFLT;
 	}
@@ -199,6 +201,9 @@ static bool pxa2xx_spi_txfifo_full(const struct driver_data *drv_data)
 	case QUARK_X1000_SSP:
 		mask = QUARK_X1000_SSSR_TFL_MASK;
 		break;
+	case CE4100_SSP:
+		mask = CE4100_SSSR_TFL_MASK;
+		break;
 	default:
 		mask = SSSR_TFL_MASK;
 		break;
@@ -216,6 +221,9 @@ static void pxa2xx_spi_clear_rx_thre(const struct driver_data *drv_data,
 	case QUARK_X1000_SSP:
 		mask = QUARK_X1000_SSCR1_RFT;
 		break;
+	case CE4100_SSP:
+		mask = CE4100_SSCR1_RFT;
+		break;
 	default:
 		mask = SSCR1_RFT;
 		break;
@@ -230,6 +238,9 @@ static void pxa2xx_spi_set_rx_thre(const struct driver_data *drv_data,
 	case QUARK_X1000_SSP:
 		*sccr1_reg |= QUARK_X1000_SSCR1_RxTresh(threshold);
 		break;
+	case CE4100_SSP:
+		*sccr1_reg |= CE4100_SSCR1_RxTresh(threshold);
+		break;
 	default:
 		*sccr1_reg |= SSCR1_RxTresh(threshold);
 		break;
@@ -589,6 +600,9 @@ static void reset_sccr1(struct driver_data *drv_data)
 	case QUARK_X1000_SSP:
 		sccr1_reg &= ~QUARK_X1000_SSCR1_RFT;
 		break;
+	case CE4100_SSP:
+		sccr1_reg &= ~CE4100_SSCR1_RFT;
+		break;
 	default:
 		sccr1_reg &= ~SSCR1_RFT;
 		break;
@@ -1225,6 +1239,11 @@ static int setup(struct spi_device *spi)
 		tx_hi_thres = 0;
 		rx_thres = RX_THRESH_QUARK_X1000_DFLT;
 		break;
+	case CE4100_SSP:
+		tx_thres = TX_THRESH_CE4100_DFLT;
+		tx_hi_thres = 0;
+		rx_thres = RX_THRESH_CE4100_DFLT;
+		break;
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
 	case LPSS_BSW_SSP:
@@ -1310,6 +1329,10 @@ chip->enable_dma = 1;
 				   | (QUARK_X1000_SSCR1_TxTresh(tx_thres)
 				   & QUARK_X1000_SSCR1_TFT);
 		break;
+	case CE4100_SSP:
+		chip->threshold = (CE4100_SSCR1_RxTresh(rx_thres) & CE4100_SSCR1_RFT) |
+			(CE4100_SSCR1_TxTresh(tx_thres) & CE4100_SSCR1_TFT);
+		break;
 	default:
 		chip->threshold = (SSCR1_RxTresh(rx_thres) & SSCR1_RFT) |
 			(SSCR1_TxTresh(tx_thres) & SSCR1_TFT);
@@ -1631,15 +1654,20 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
-		tmp = QUARK_X1000_SSCR1_RxTresh(RX_THRESH_QUARK_X1000_DFLT)
-		      | QUARK_X1000_SSCR1_TxTresh(TX_THRESH_QUARK_X1000_DFLT);
+		tmp = QUARK_X1000_SSCR1_RxTresh(RX_THRESH_QUARK_X1000_DFLT) |
+		      QUARK_X1000_SSCR1_TxTresh(TX_THRESH_QUARK_X1000_DFLT);
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 
 		/* using the Motorola SPI protocol and use 8 bit frame */
-		pxa2xx_spi_write(drv_data, SSCR0,
-				 QUARK_X1000_SSCR0_Motorola
-				 | QUARK_X1000_SSCR0_DataSize(8));
+		tmp = QUARK_X1000_SSCR0_Motorola | QUARK_X1000_SSCR0_DataSize(8);
+		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
+	case CE4100_SSP:
+		tmp = CE4100_SSCR1_RxTresh(RX_THRESH_CE4100_DFLT) |
+		      CE4100_SSCR1_TxTresh(TX_THRESH_CE4100_DFLT);
+		pxa2xx_spi_write(drv_data, SSCR1, tmp);
+		tmp = SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
+		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 	default:
 		tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
 		      SSCR1_TxTresh(TX_THRESH_DFLT);
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 2a097d1..2d6f0c39 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -83,7 +83,6 @@
 #define SSSR_RFS	(1 << 6)	/* Receive FIFO Service Request */
 #define SSSR_ROR	(1 << 7)	/* Receive FIFO Overrun */
 
-#ifdef CONFIG_ARCH_PXA
 #define RX_THRESH_DFLT	8
 #define TX_THRESH_DFLT	8
 
@@ -95,19 +94,16 @@
 #define SSCR1_RFT	(0x00003c00)	/* Receive FIFO Threshold (mask) */
 #define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..16] */
 
-#else
-
-#define RX_THRESH_DFLT	2
-#define TX_THRESH_DFLT	2
+#define RX_THRESH_CE4100_DFLT	2
+#define TX_THRESH_CE4100_DFLT	2
 
-#define SSSR_TFL_MASK	(0x3 << 8)	/* Transmit FIFO Level mask */
-#define SSSR_RFL_MASK	(0x3 << 12)	/* Receive FIFO Level mask */
+#define CE4100_SSSR_TFL_MASK	(0x3 << 8)	/* Transmit FIFO Level mask */
+#define CE4100_SSSR_RFL_MASK	(0x3 << 12)	/* Receive FIFO Level mask */
 
-#define SSCR1_TFT	(0x000000c0)	/* Transmit FIFO Threshold (mask) */
-#define SSCR1_TxTresh(x) (((x) - 1) << 6) /* level [1..4] */
-#define SSCR1_RFT	(0x00000c00)	/* Receive FIFO Threshold (mask) */
-#define SSCR1_RxTresh(x) (((x) - 1) << 10) /* level [1..4] */
-#endif
+#define CE4100_SSCR1_TFT	(0x000000c0)	/* Transmit FIFO Threshold (mask) */
+#define CE4100_SSCR1_TxTresh(x) (((x) - 1) << 6)	/* level [1..4] */
+#define CE4100_SSCR1_RFT	(0x00000c00)	/* Receive FIFO Threshold (mask) */
+#define CE4100_SSCR1_RxTresh(x) (((x) - 1) << 10)	/* level [1..4] */
 
 /* QUARK_X1000 SSCR0 bit definition */
 #define QUARK_X1000_SSCR0_DSS	(0x1F)		/* Data Size Select (mask) */
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
