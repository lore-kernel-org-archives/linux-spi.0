From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] spi: sh-msiof: Do not redefine STR while compile testing
Date: Tue,  7 Jan 2020 17:56:58 +0100
Message-ID: <1578416218-11112-1-git-send-email-krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

STR is a well-known stringify macro so it should be avoided in drivers
to avoid warnings like this (MIPS architecture while compile testing):

    drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
     #define STR 0x40 /* Status Register */
    arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
     #define STR(x) __STR(x)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8f134735291f..f36f0d5165f6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -73,7 +73,7 @@ struct sh_msiof_spi_priv {
 #define RSCR	0x22	/* Receive Clock Select Register (SH, A1, APE6) */
 #define CTR	0x28	/* Control Register */
 #define FCTR	0x30	/* FIFO Control Register */
-#define STR	0x40	/* Status Register */
+#define STATR	0x40	/* Status Register */
 #define IER	0x44	/* Interrupt Enable Register */
 #define TDR1	0x48	/* Transmit Control Data Register 1 (SH, A1) */
 #define TDR2	0x4c	/* Transmit Control Data Register 2 (SH, A1) */
@@ -161,19 +161,19 @@ struct sh_msiof_spi_priv {
 #define FCTR_RFUA_SHIFT	4
 #define FCTR_RFUA(i)	((i) << FCTR_RFUA_SHIFT)
 
-/* STR */
-#define STR_TFEMP	BIT(29) /* Transmit FIFO Empty */
-#define STR_TDREQ	BIT(28) /* Transmit Data Transfer Request */
-#define STR_TEOF	BIT(23) /* Frame Transmission End */
-#define STR_TFSERR	BIT(21) /* Transmit Frame Synchronization Error */
-#define STR_TFOVF	BIT(20) /* Transmit FIFO Overflow */
-#define STR_TFUDF	BIT(19) /* Transmit FIFO Underflow */
-#define STR_RFFUL	BIT(13) /* Receive FIFO Full */
-#define STR_RDREQ	BIT(12) /* Receive Data Transfer Request */
-#define STR_REOF	BIT(7)  /* Frame Reception End */
-#define STR_RFSERR	BIT(5)  /* Receive Frame Synchronization Error */
-#define STR_RFUDF	BIT(4)  /* Receive FIFO Underflow */
-#define STR_RFOVF	BIT(3)  /* Receive FIFO Overflow */
+/* STATR */
+#define STATR_TFEMP	BIT(29) /* Transmit FIFO Empty */
+#define STATR_TDREQ	BIT(28) /* Transmit Data Transfer Request */
+#define STATR_TEOF	BIT(23) /* Frame Transmission End */
+#define STATR_TFSERR	BIT(21) /* Transmit Frame Synchronization Error */
+#define STATR_TFOVF	BIT(20) /* Transmit FIFO Overflow */
+#define STATR_TFUDF	BIT(19) /* Transmit FIFO Underflow */
+#define STATR_RFFUL	BIT(13) /* Receive FIFO Full */
+#define STATR_RDREQ	BIT(12) /* Receive Data Transfer Request */
+#define STATR_REOF	BIT(7)  /* Frame Reception End */
+#define STATR_RFSERR	BIT(5)  /* Receive Frame Synchronization Error */
+#define STATR_RFUDF	BIT(4)  /* Receive FIFO Underflow */
+#define STATR_RFOVF	BIT(3)  /* Receive FIFO Overflow */
 
 /* IER */
 #define IER_TDMAE	BIT(31) /* Transmit Data DMA Transfer Req. Enable */
@@ -403,8 +403,8 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 {
-	sh_msiof_write(p, STR,
-		       sh_msiof_read(p, STR) & ~(STR_TDREQ | STR_RDREQ));
+	sh_msiof_write(p, STATR,
+		       sh_msiof_read(p, STATR) & ~(STATR_TDREQ | STATR_RDREQ));
 }
 
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
-- 
2.7.4
