From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH V2 1/8] spi: rspi: Add more RSPI register documentation
Date: Sun, 12 Jan 2014 11:27:37 +0100
Message-ID: <1389522464-1569-2-git-send-email-geert@linux-m68k.org>
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
  - Add more legacy SH docs, based on the SH7753 datasheet

 drivers/spi/spi-rspi.c |  185 ++++++++++++++++++++++++++----------------------
 1 file changed, 99 insertions(+), 86 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 239354618eac..53e6e07251c1 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -37,27 +37,29 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
 
-#define RSPI_SPCR		0x00
-#define RSPI_SSLP		0x01
-#define RSPI_SPPCR		0x02
-#define RSPI_SPSR		0x03
-#define RSPI_SPDR		0x04
-#define RSPI_SPSCR		0x08
-#define RSPI_SPSSR		0x09
-#define RSPI_SPBR		0x0a
-#define RSPI_SPDCR		0x0b
-#define RSPI_SPCKD		0x0c
-#define RSPI_SSLND		0x0d
-#define RSPI_SPND		0x0e
-#define RSPI_SPCR2		0x0f
-#define RSPI_SPCMD0		0x10
-#define RSPI_SPCMD1		0x12
-#define RSPI_SPCMD2		0x14
-#define RSPI_SPCMD3		0x16
-#define RSPI_SPCMD4		0x18
-#define RSPI_SPCMD5		0x1a
-#define RSPI_SPCMD6		0x1c
-#define RSPI_SPCMD7		0x1e
+#define RSPI_SPCR		0x00	/* Control Register */
+#define RSPI_SSLP		0x01	/* Slave Select Polarity Register */
+#define RSPI_SPPCR		0x02	/* Pin Control Register */
+#define RSPI_SPSR		0x03	/* Status Register */
+#define RSPI_SPDR		0x04	/* Data Register */
+#define RSPI_SPSCR		0x08	/* Sequence Control Register */
+#define RSPI_SPSSR		0x09	/* Sequence Status Register */
+#define RSPI_SPBR		0x0a	/* Bit Rate Register */
+#define RSPI_SPDCR		0x0b	/* Data Control Register */
+#define RSPI_SPCKD		0x0c	/* Clock Delay Register */
+#define RSPI_SSLND		0x0d	/* Slave Select Negation Delay Register */
+#define RSPI_SPND		0x0e	/* Next-Access Delay Register */
+#define RSPI_SPCR2		0x0f	/* Control Register 2 */
+#define RSPI_SPCMD0		0x10	/* Command Register 0 */
+#define RSPI_SPCMD1		0x12	/* Command Register 1 */
+#define RSPI_SPCMD2		0x14	/* Command Register 2 */
+#define RSPI_SPCMD3		0x16	/* Command Register 3 */
+#define RSPI_SPCMD4		0x18	/* Command Register 4 */
+#define RSPI_SPCMD5		0x1a	/* Command Register 5 */
+#define RSPI_SPCMD6		0x1c	/* Command Register 6 */
+#define RSPI_SPCMD7		0x1e	/* Command Register 7 */
+#define RSPI_SPBFCR		0x20	/* Buffer Control Register */
+#define RSPI_SPBFDR		0x22	/* Buffer Data Count Setting Register */
 
 /*qspi only */
 #define QSPI_SPBFCR		0x18
@@ -67,87 +69,98 @@
 #define QSPI_SPBMUL2		0x24
 #define QSPI_SPBMUL3		0x28
 
-/* SPCR */
-#define SPCR_SPRIE		0x80
-#define SPCR_SPE		0x40
-#define SPCR_SPTIE		0x20
-#define SPCR_SPEIE		0x10
-#define SPCR_MSTR		0x08
-#define SPCR_MODFEN		0x04
-#define SPCR_TXMD		0x02
-#define SPCR_SPMS		0x01
-
-/* SSLP */
-#define SSLP_SSL1P		0x02
-#define SSLP_SSL0P		0x01
-
-/* SPPCR */
-#define SPPCR_MOIFE		0x20
-#define SPPCR_MOIFV		0x10
+/* SPCR - Control Register */
+#define SPCR_SPRIE		0x80	/* Receive Interrupt Enable */
+#define SPCR_SPE		0x40	/* Function Enable */
+#define SPCR_SPTIE		0x20	/* Transmit Interrupt Enable */
+#define SPCR_SPEIE		0x10	/* Error Interrupt Enable */
+#define SPCR_MSTR		0x08	/* Master/Slave Mode Select */
+#define SPCR_MODFEN		0x04	/* Mode Fault Error Detection Enable */
+/* RSPI on SH only */
+#define SPCR_TXMD		0x02	/* TX Only Mode (vs. Full Duplex) */
+#define SPCR_SPMS		0x01	/* 3-wire Mode (vs. 4-wire) */
+
+/* SSLP - Slave Select Polarity Register */
+#define SSLP_SSL1P		0x02	/* SSL1 Signal Polarity Setting */
+#define SSLP_SSL0P		0x01	/* SSL0 Signal Polarity Setting */
+
+/* SPPCR - Pin Control Register */
+#define SPPCR_MOIFE		0x20	/* MOSI Idle Value Fixing Enable */
+#define SPPCR_MOIFV		0x10	/* MOSI Idle Fixed Value */
 #define SPPCR_SPOM		0x04
-#define SPPCR_SPLP2		0x02
-#define SPPCR_SPLP		0x01
-
-/* SPSR */
-#define SPSR_SPRF		0x80
-#define SPSR_SPTEF		0x20
-#define SPSR_PERF		0x08
-#define SPSR_MODF		0x04
-#define SPSR_IDLNF		0x02
-#define SPSR_OVRF		0x01
-
-/* SPSCR */
-#define SPSCR_SPSLN_MASK	0x07
-
-/* SPSSR */
-#define SPSSR_SPECM_MASK	0x70
-#define SPSSR_SPCP_MASK		0x07
-
-/* SPDCR */
-#define SPDCR_SPLW		0x20
-#define SPDCR_SPRDTD		0x10
+#define SPPCR_SPLP2		0x02	/* Loopback Mode 2 (non-inverting) */
+#define SPPCR_SPLP		0x01	/* Loopback Mode (inverting) */
+
+/* SPSR - Status Register */
+#define SPSR_SPRF		0x80	/* Receive Buffer Full Flag */
+#define SPSR_TEND		0x40	/* Transmit End */
+#define SPSR_SPTEF		0x20	/* Transmit Buffer Empty Flag */
+#define SPSR_PERF		0x08	/* Parity Error Flag */
+#define SPSR_MODF		0x04	/* Mode Fault Error Flag */
+#define SPSR_IDLNF		0x02	/* RSPI Idle Flag */
+#define SPSR_OVRF		0x01	/* Overrun Error Flag */
+
+/* SPSCR - Sequence Control Register */
+#define SPSCR_SPSLN_MASK	0x07	/* Sequence Length Specification */
+
+/* SPSSR - Sequence Status Register */
+#define SPSSR_SPECM_MASK	0x70	/* Command Error Mask */
+#define SPSSR_SPCP_MASK		0x07	/* Command Pointer Mask */
+
+/* SPDCR - Data Control Register */
+#define SPDCR_TXDMY		0x80	/* Dummy Data Transmission Enable */
+#define SPDCR_SPLW1		0x40	/* Access Width Specification (RZ) */
+#define SPDCR_SPLW0		0x20	/* Access Width Specification (RZ) */
+#define SPDCR_SPLLWORD		(SPDCR_SPLW1 | SPDCR_SPLW0)
+#define SPDCR_SPLWORD		SPDCR_SPLW1
+#define SPDCR_SPLBYTE		SPDCR_SPLW0
+#define SPDCR_SPLW		0x20	/* Access Width Specification (SH) */
+#define SPDCR_SPRDTD		0x10	/* Receive Transmit Data Select */
 #define SPDCR_SLSEL1		0x08
 #define SPDCR_SLSEL0		0x04
-#define SPDCR_SLSEL_MASK	0x0c
+#define SPDCR_SLSEL_MASK	0x0c	/* SSL1 Output Select */
 #define SPDCR_SPFC1		0x02
 #define SPDCR_SPFC0		0x01
+#define SPDCR_SPFC_MASK		0x03	/* Frame Count Setting (1-4) */
 
-/* SPCKD */
-#define SPCKD_SCKDL_MASK	0x07
+/* SPCKD - Clock Delay Register */
+#define SPCKD_SCKDL_MASK	0x07	/* Clock Delay Setting (1-8) */
 
-/* SSLND */
-#define SSLND_SLNDL_MASK	0x07
+/* SSLND - Slave Select Negation Delay Register */
+#define SSLND_SLNDL_MASK	0x07	/* SSL Negation Delay Setting (1-8) */
 
-/* SPND */
-#define SPND_SPNDL_MASK		0x07
+/* SPND - Next-Access Delay Register */
+#define SPND_SPNDL_MASK		0x07	/* Next-Access Delay Setting (1-8) */
 
-/* SPCR2 */
-#define SPCR2_PTE		0x08
-#define SPCR2_SPIE		0x04
-#define SPCR2_SPOE		0x02
-#define SPCR2_SPPE		0x01
+/* SPCR2 - Control Register 2 */
+#define SPCR2_PTE		0x08	/* Parity Self-Test Enable */
+#define SPCR2_SPIE		0x04	/* Idle Interrupt Enable */
+#define SPCR2_SPOE		0x02	/* Odd Parity Enable (vs. Even) */
+#define SPCR2_SPPE		0x01	/* Parity Enable */
 
-/* SPCMDn */
-#define SPCMD_SCKDEN		0x8000
-#define SPCMD_SLNDEN		0x4000
-#define SPCMD_SPNDEN		0x2000
-#define SPCMD_LSBF		0x1000
-#define SPCMD_SPB_MASK		0x0f00
+/* SPCMDn - Command Registers */
+#define SPCMD_SCKDEN		0x8000	/* Clock Delay Setting Enable */
+#define SPCMD_SLNDEN		0x4000	/* SSL Negation Delay Setting Enable */
+#define SPCMD_SPNDEN		0x2000	/* Next-Access Delay Enable */
+#define SPCMD_LSBF		0x1000	/* LSB First */
+#define SPCMD_SPB_MASK		0x0f00	/* Data Length Setting */
 #define SPCMD_SPB_8_TO_16(bit)	(((bit - 1) << 8) & SPCMD_SPB_MASK)
 #define SPCMD_SPB_8BIT		0x0000	/* qspi only */
 #define SPCMD_SPB_16BIT		0x0100
 #define SPCMD_SPB_20BIT		0x0000
 #define SPCMD_SPB_24BIT		0x0100
 #define SPCMD_SPB_32BIT		0x0200
-#define SPCMD_SSLKP		0x0080
-#define SPCMD_SSLA_MASK		0x0030
-#define SPCMD_BRDV_MASK		0x000c
-#define SPCMD_CPOL		0x0002
-#define SPCMD_CPHA		0x0001
-
-/* SPBFCR */
-#define SPBFCR_TXRST		0x80	/* qspi only */
-#define SPBFCR_RXRST		0x40	/* qspi only */
+#define SPCMD_SSLKP		0x0080	/* SSL Signal Level Keeping */
+#define SPCMD_SSLA_MASK		0x0030	/* SSL Assert Signal Setting (RSPI) */
+#define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
+#define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
+#define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
+
+/* SPBFCR - Buffer Control Register */
+#define SPBFCR_TXRST		0x80	/* Transmit Buffer Data Reset (qspi only) */
+#define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset (qspi only) */
+#define SPBFCR_TXTRG_MASK	0x30	/* Transmit Buffer Data Triggering Number */
+#define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number */
 
 #define DUMMY_DATA		0x00
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
