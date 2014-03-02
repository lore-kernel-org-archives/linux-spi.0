From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh-msiof: Kill sh_msiof_spi_bits and sh_msiof_spi_hz
 functions
Date: Sun, 02 Mar 2014 22:30:32 +0800
Message-ID: <1393770632.4044.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In the implementation of __spi_validate(), spi core will set transfer
bits_per_word and max speed as spi device default if it is not set for
this transfer. So we can remove the same implementation in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 1b59804..739eb2f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -416,26 +416,6 @@ static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
 		put_unaligned(swab32(sh_msiof_read(p, RFDR) >> fs), &buf_32[k]);
 }
 
-static int sh_msiof_spi_bits(struct spi_device *spi, struct spi_transfer *t)
-{
-	int bits;
-
-	bits = t ? t->bits_per_word : 0;
-	if (!bits)
-		bits = spi->bits_per_word;
-	return bits;
-}
-
-static u32 sh_msiof_spi_hz(struct spi_device *spi, struct spi_transfer *t)
-{
-	u32 hz;
-
-	hz = t ? t->speed_hz : 0;
-	if (!hz)
-		hz = spi->max_speed_hz;
-	return hz;
-}
-
 static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
@@ -573,7 +553,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	int n;
 	bool swab;
 
-	bits = sh_msiof_spi_bits(spi, t);
+	bits = t->bits_per_word;
 
 	if (bits <= 8 && t->len > 15 && !(t->len & 3)) {
 		bits = 32;
@@ -623,8 +603,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	}
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk),
-				  sh_msiof_spi_hz(spi, t));
+	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
 	/* transfer in fifo sized chunks */
 	words = t->len / bytes_per_word;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
