From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] SPI: spi_sh_msiof: cosmetic clean-up
Date: Fri, 21 Jan 2011 16:56:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101211654280.18867@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

1. sort headers alphabetically
2. use fixed-size types u8, u16, u32 for register values and transferred data
3. simplify some arithmetic operations
4. remove leading spaces in front of labels

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_sh_msiof.c |   78 ++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 56f60c8..07b4ead 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -9,22 +9,22 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
+#include <linux/bitmap.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/completion.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
-#include <linux/bitmap.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/err.h>
 
+#include <linux/spi/sh_msiof.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
-#include <linux/spi/sh_msiof.h>
 
 #include <asm/unaligned.h>
 
@@ -67,7 +67,7 @@ struct sh_msiof_spi_priv {
 #define STR_TEOF  (1 << 23)
 #define STR_REOF  (1 << 7)
 
-static unsigned long sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
+static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
 {
 	switch (reg_offs) {
 	case TSCR:
@@ -79,7 +79,7 @@ static unsigned long sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
 }
 
 static void sh_msiof_write(struct sh_msiof_spi_priv *p, int reg_offs,
-			   unsigned long value)
+			   u32 value)
 {
 	switch (reg_offs) {
 	case TSCR:
@@ -93,10 +93,10 @@ static void sh_msiof_write(struct sh_msiof_spi_priv *p, int reg_offs,
 }
 
 static int sh_msiof_modify_ctr_wait(struct sh_msiof_spi_priv *p,
-				    unsigned long clr, unsigned long set)
+				    u32 clr, u32 set)
 {
-	unsigned long mask = clr | set;
-	unsigned long data;
+	u32 mask = clr | set;
+	u32 data;
 	int k;
 
 	data = sh_msiof_read(p, CTR);
@@ -166,10 +166,10 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 }
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
-				      int cpol, int cpha,
-				      int tx_hi_z, int lsb_first)
+				      u32 cpol, u32 cpha,
+				      u32 tx_hi_z, u32 lsb_first)
 {
-	unsigned long tmp;
+	u32 tmp;
 	int edge;
 
 	/*
@@ -187,7 +187,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	tmp |= cpol << 30; /* TSCKIZ */
 	tmp |= cpol << 28; /* RSCKIZ */
 
-	edge = cpol ? cpha : !cpha;
+	edge = cpol ^ !cpha;
 
 	tmp |= edge << 27; /* TEDG */
 	tmp |= edge << 26; /* REDG */
@@ -197,11 +197,9 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 
 static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, void *rx_buf,
-				       int bits, int words)
+				       u32 bits, u32 words)
 {
-	unsigned long dr2;
-
-	dr2 = ((bits - 1) << 24) | ((words - 1) << 16);
+	u32 dr2 = ((bits - 1) << 24) | ((words - 1) << 16);
 
 	if (tx_buf)
 		sh_msiof_write(p, TMDR2, dr2);
@@ -222,7 +220,7 @@ static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
 				      const void *tx_buf, int words, int fs)
 {
-	const unsigned char *buf_8 = tx_buf;
+	const u8 *buf_8 = tx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -232,7 +230,7 @@ static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, int words, int fs)
 {
-	const unsigned short *buf_16 = tx_buf;
+	const u16 *buf_16 = tx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -242,7 +240,7 @@ static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
 					const void *tx_buf, int words, int fs)
 {
-	const unsigned short *buf_16 = tx_buf;
+	const u16 *buf_16 = tx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -252,7 +250,7 @@ static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, int words, int fs)
 {
-	const unsigned int *buf_32 = tx_buf;
+	const u32 *buf_32 = tx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -262,7 +260,7 @@ static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
 					const void *tx_buf, int words, int fs)
 {
-	const unsigned int *buf_32 = tx_buf;
+	const u32 *buf_32 = tx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -272,7 +270,7 @@ static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
 				     void *rx_buf, int words, int fs)
 {
-	unsigned char *buf_8 = rx_buf;
+	u8 *buf_8 = rx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -282,7 +280,7 @@ static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
 				      void *rx_buf, int words, int fs)
 {
-	unsigned short *buf_16 = rx_buf;
+	u16 *buf_16 = rx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -292,7 +290,7 @@ static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
 				       void *rx_buf, int words, int fs)
 {
-	unsigned short *buf_16 = rx_buf;
+	u16 *buf_16 = rx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -302,7 +300,7 @@ static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
 				      void *rx_buf, int words, int fs)
 {
-	unsigned int *buf_32 = rx_buf;
+	u32 *buf_32 = rx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -312,7 +310,7 @@ static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
 static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
 				       void *rx_buf, int words, int fs)
 {
-	unsigned int *buf_32 = rx_buf;
+	u32 *buf_32 = rx_buf;
 	int k;
 
 	for (k = 0; k < words; k++)
@@ -324,7 +322,8 @@ static int sh_msiof_spi_bits(struct spi_device *spi, struct spi_transfer *t)
 	int bits;
 
 	bits = t ? t->bits_per_word : 0;
-	bits = bits ? bits : spi->bits_per_word;
+	if (!bits)
+		bits = spi->bits_per_word;
 	return bits;
 }
 
@@ -334,7 +333,8 @@ static unsigned long sh_msiof_spi_hz(struct spi_device *spi,
 	unsigned long hz;
 
 	hz = t ? t->speed_hz : 0;
-	hz = hz ? hz : spi->max_speed_hz;
+	if (!hz)
+		hz = spi->max_speed_hz;
 	return hz;
 }
 
@@ -453,7 +453,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 
 	return words;
 
- err:
+err:
 	sh_msiof_write(p, IER, 0);
 	return ret;
 }
@@ -617,13 +617,13 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(&pdev->dev);
- err3:
+err3:
 	iounmap(p->mapbase);
- err2:
+err2:
 	clk_put(p->clk);
- err1:
+err1:
 	spi_master_put(master);
- err0:
+err0:
 	return ret;
 }
 
-- 
1.7.2.3

