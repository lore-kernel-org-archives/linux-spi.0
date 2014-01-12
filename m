From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH V2 2/8] spi: rspi: Add more QSPI register documentation
Date: Sun, 12 Jan 2014 11:27:38 +0100
Message-ID: <1389522464-1569-3-git-send-email-geert@linux-m68k.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389522464-1569-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
V2:
  - Add Acked-by
  - Add Word/Byte Swap of read-data for DMAC on R-Car M2 only
  - Add Dual/Quad bits
  - Fix SPCMD_SPRW

 drivers/spi/spi-rspi.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 53e6e07251c1..eded530763ca 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -62,12 +62,12 @@
 #define RSPI_SPBFDR		0x22	/* Buffer Data Count Setting Register */
 
 /*qspi only */
-#define QSPI_SPBFCR		0x18
-#define QSPI_SPBDCR		0x1a
-#define QSPI_SPBMUL0		0x1c
-#define QSPI_SPBMUL1		0x20
-#define QSPI_SPBMUL2		0x24
-#define QSPI_SPBMUL3		0x28
+#define QSPI_SPBFCR		0x18	/* Buffer Control Register */
+#define QSPI_SPBDCR		0x1a	/* Buffer Data Count Register */
+#define QSPI_SPBMUL0		0x1c	/* Transfer Data Length Multiplier Setting Register 0 */
+#define QSPI_SPBMUL1		0x20	/* Transfer Data Length Multiplier Setting Register 1 */
+#define QSPI_SPBMUL2		0x24	/* Transfer Data Length Multiplier Setting Register 2 */
+#define QSPI_SPBMUL3		0x28	/* Transfer Data Length Multiplier Setting Register 3 */
 
 /* SPCR - Control Register */
 #define SPCR_SPRIE		0x80	/* Receive Interrupt Enable */
@@ -79,6 +79,9 @@
 /* RSPI on SH only */
 #define SPCR_TXMD		0x02	/* TX Only Mode (vs. Full Duplex) */
 #define SPCR_SPMS		0x01	/* 3-wire Mode (vs. 4-wire) */
+/* QSPI on R-Car M2 only */
+#define SPCR_WSWAP		0x02	/* Word Swap of read-data for DMAC */
+#define SPCR_BSWAP		0x01	/* Byte Swap of read-data for DMAC */
 
 /* SSLP - Slave Select Polarity Register */
 #define SSLP_SSL1P		0x02	/* SSL1 Signal Polarity Setting */
@@ -91,6 +94,9 @@
 #define SPPCR_SPLP2		0x02	/* Loopback Mode 2 (non-inverting) */
 #define SPPCR_SPLP		0x01	/* Loopback Mode (inverting) */
 
+#define SPPCR_IO3FV		0x04	/* Single-/Dual-SPI Mode IO3 Output Fixed Value */
+#define SPPCR_IO2FV		0x04	/* Single-/Dual-SPI Mode IO2 Output Fixed Value */
+
 /* SPSR - Status Register */
 #define SPSR_SPRF		0x80	/* Receive Buffer Full Flag */
 #define SPSR_TEND		0x40	/* Transmit End */
@@ -151,6 +157,13 @@
 #define SPCMD_SPB_24BIT		0x0100
 #define SPCMD_SPB_32BIT		0x0200
 #define SPCMD_SSLKP		0x0080	/* SSL Signal Level Keeping */
+#define SPCMD_SPIMOD_MASK	0x0060	/* SPI Operating Mode (QSPI only) */
+#define SPCMD_SPIMOD1		0x0040
+#define SPCMD_SPIMOD0		0x0020
+#define SPCMD_SPIMOD_SINGLE	0
+#define SPCMD_SPIMOD_DUAL	SPCMD_SPIMOD0
+#define SPCMD_SPIMOD_QUAD	SPCMD_SPIMOD1
+#define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
 #define SPCMD_SSLA_MASK		0x0030	/* SSL Assert Signal Setting (RSPI) */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
