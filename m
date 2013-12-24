From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 2/8] spi: rspi: Add more QSPI register documentation
Date: Tue, 24 Dec 2013 12:40:42 +0100
Message-ID: <1387885248-28425-3-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index afd7466c65cd..46232e3b6e8c 100644
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
@@ -90,6 +90,9 @@
 #define SPPCR_SPLP2		0x02
 #define SPPCR_SPLP		0x01	/* Loopback */
 
+#define SPPCR_IO3FV		0x04	/* Single-/Dual-SPI Mode IO3 Output Fixed Value */
+#define SPPCR_IO2FV		0x04	/* Single-/Dual-SPI Mode IO2 Output Fixed Value */
+
 /* SPSR - Status Register */
 #define SPSR_SPRF		0x80	/* Receive Buffer Full Flag */
 #define SPSR_TEND		0x40	/* Transmit End */
@@ -109,7 +112,7 @@
 /* SPDCR - Data Control Register */
 #define SPDCR_TXDMY		0x80	/* Dummy Data Transmission Enable */
 #define SPDCR_SPLW1		0x40	/* Access Width Specification */
-#define SPDCR_SPLW0		0x20
+#define SPDCR_SPLW0		0x20	/* Access Width Specification */
 #define SPDCR_SPLLWORD		(SPDCR_SPLW1 | SPDCR_SPLW0)
 #define SPDCR_SPLWORD		SPDCR_SPLW1
 #define SPDCR_SPLBYTE		SPDCR_SPLW0
@@ -148,12 +151,15 @@
 #define SPCMD_SPB_20BIT		0x0000
 #define SPCMD_SPB_24BIT		0x0100
 #define SPCMD_SPB_32BIT		0x0200
-#define SPCMD_SSLKP		0x0080
+#define SPCMD_SSLKP		0x0080	/* SSL Signal Level Keeping */
 #define SPCMD_SSLA_MASK		0x0030
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
 
+#define SPCMD_SPIMOD_MASK	0x0060	/* SPI Operating Mode */
+#define SPCMD_SPRW		0x0060	/* SPI Read/Write Access */
+
 /* SPBFCR - Buffer Control Register */
 #define SPBFCR_TXRST		0x80	/* Transmit Buffer Data Reset (qspi only) */
 #define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset (qspi only) */
-- 
1.7.9.5

