From: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Wed, 12 Mar 2014 16:53:36 +0100
Message-ID: <1394639617-26917-3-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394639617-26917-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The bitbang spi driver currently only supports the MSB mode. This patch
adds the possibility to clock the data in LSB mode.

Signed-off-by: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-bitbang-txrx.h | 98 +++++++++++++++++++++++++++++-------------
 drivers/spi/spi-bitbang.c      |  3 +-
 2 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index b6e348d..7f9c020 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,22 +49,42 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
-	/* clock starts at inactive polarity */
-	for (word <<= (32 - bits); likely(bits); bits--) {
-
-		/* setup MSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
-		spidelay(nsecs);	/* T(setup) */
-
-		setsck(spi, !cpol);
-		spidelay(nsecs);
-
-		/* sample MSB (from slave) on leading edge */
-		if ((flags & SPI_MASTER_NO_RX) == 0)
-			word |= getmiso(spi);
-		setsck(spi, cpol);
-		word <<= 1;
+	if (spi->mode & SPI_LSB_FIRST) {
+		/* clock starts at inactive polarity */
+		for (; likely(bits); bits--) {
+
+			/* setup MSB (to slave) on trailing edge */
+			if ((flags & SPI_MASTER_NO_TX) == 0)
+				setmosi(spi, word & 1);
+			spidelay(nsecs);	/* T(setup) */
+
+			setsck(spi, !cpol);
+			spidelay(nsecs);
+
+			/* sample LSB (from slave) on leading edge */
+			if ((flags & SPI_MASTER_NO_RX) == 0)
+				word |= getmiso(spi);
+			setsck(spi, cpol);
+			word >>= 1;
+		}
+	} else {
+		/* clock starts at inactive polarity */
+		for (word <<= (32 - bits); likely(bits); bits--) {
+
+			/* setup MSB (to slave) on trailing edge */
+			if ((flags & SPI_MASTER_NO_TX) == 0)
+				setmosi(spi, word & (1 << 31));
+			spidelay(nsecs);        /* T(setup) */
+
+			setsck(spi, !cpol);
+			spidelay(nsecs);
+
+			/* sample MSB (from slave) on leading edge */
+			if ((flags & SPI_MASTER_NO_RX) == 0)
+				word |= getmiso(spi);
+			setsck(spi, cpol);
+			word <<= 1;
+		}
 	}
 	return word;
 }
@@ -76,22 +96,42 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
-	/* clock starts at inactive polarity */
-	for (word <<= (32 - bits); likely(bits); bits--) {
+	if (spi->mode & SPI_LSB_FIRST) {
+		/* clock starts at inactive polarity */
+		for (; likely(bits); bits--) {
+
+			/* setup MSB (to slave) on leading edge */
+			setsck(spi, !cpol);
+			if ((flags & SPI_MASTER_NO_TX) == 0)
+				setmosi(spi, word & 1);
+			spidelay(nsecs); /* T(setup) */
+
+			setsck(spi, cpol);
+			spidelay(nsecs);
+
+			/* sample MSB (from slave) on trailing edge */
+			if ((flags & SPI_MASTER_NO_RX) == 0)
+				word |= getmiso(spi);
+			word >>= 1;
+		}
+	} else {
+		/* clock starts at inactive polarity */
+		for (word <<= (32 - bits); likely(bits); bits--) {
 
-		/* setup MSB (to slave) on leading edge */
-		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
-		spidelay(nsecs); /* T(setup) */
+			/* setup MSB (to slave) on leading edge */
+			setsck(spi, !cpol);
+			if ((flags & SPI_MASTER_NO_TX) == 0)
+				setmosi(spi, word & (1 << 31));
+			spidelay(nsecs); /* T(setup) */
 
-		setsck(spi, cpol);
-		spidelay(nsecs);
+			setsck(spi, cpol);
+			spidelay(nsecs);
 
-		/* sample MSB (from slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_RX) == 0)
-			word |= getmiso(spi);
-		word <<= 1;
+			/* sample MSB (from slave) on trailing edge */
+			if ((flags & SPI_MASTER_NO_RX) == 0)
+				word |= getmiso(spi);
+			word <<= 1;
+		}
 	}
 	return word;
 }
diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index bd222f6..3624f96 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -432,7 +432,8 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	spin_lock_init(&bitbang->lock);
 
 	if (!master->mode_bits)
-		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
+		master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST
+			| bitbang->flags;
 
 	if (master->transfer || master->transfer_one_message)
 		return -EINVAL;
-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
