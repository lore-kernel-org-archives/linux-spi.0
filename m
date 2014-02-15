From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: omap-uwire: Convert to use bits_per_word_mask
Date: Sat, 15 Feb 2014 14:26:21 +0800
Message-ID: <1392445581.32256.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap-uwire.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 462ddd4..95cc694 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -99,7 +99,6 @@ struct uwire_spi {
 };
 
 struct uwire_state {
-	unsigned	bits_per_word;
 	unsigned	div1_idx;
 };
 
@@ -210,9 +209,8 @@ static void uwire_chipselect(struct spi_device *spi, int value)
 
 static int uwire_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
-	struct uwire_state *ust = spi->controller_state;
 	unsigned	len = t->len;
-	unsigned	bits = ust->bits_per_word;
+	unsigned	bits = t->bits_per_word ? : spi->bits_per_word;
 	unsigned	bytes;
 	u16		val, w;
 	int		status = 0;
@@ -322,7 +320,6 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	struct uwire_state	*ust = spi->controller_state;
 	struct uwire_spi	*uwire;
 	unsigned		flags = 0;
-	unsigned		bits;
 	unsigned		hz;
 	unsigned long		rate;
 	int			div1_idx;
@@ -332,17 +329,6 @@ static int uwire_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	uwire = spi_master_get_devdata(spi->master);
 
-	bits = spi->bits_per_word;
-	if (t != NULL && t->bits_per_word)
-		bits = t->bits_per_word;
-
-	if (bits > 16) {
-		pr_debug("%s: wordsize %d?\n", dev_name(&spi->dev), bits);
-		status = -ENODEV;
-		goto done;
-	}
-	ust->bits_per_word = bits;
-
 	/* mode 0..3, clock inverted separately;
 	 * standard nCS signaling;
 	 * don't treat DI=high as "not ready"
@@ -509,7 +495,7 @@ static int uwire_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 16);
 	master->flags = SPI_MASTER_HALF_DUPLEX;
 
 	master->bus_num = 2;	/* "official" */
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
