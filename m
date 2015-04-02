From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 2/2][RFC] spi: fsl-dspi: use double baud rate in approximation
Date: Thu,  2 Apr 2015 12:11:47 +0300
Message-ID: <1427965907-28125-3-git-send-email-andy.shevchenko@gmail.com>
References: <1427965907-28125-1-git-send-email-andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427965907-28125-1-git-send-email-andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The CTAR register has DBR bit which allows to double a baud rate, though
it makes duty cycle deviate from 50/50.

This patch tries to approximate better using DBR. It helps in case of
highest possible baud rates.

Signed-off-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 31cdee5..92d387a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -47,6 +47,7 @@
 #define SPI_TCR			0x08
 
 #define SPI_CTAR(x)		(0x0c + (((x) & 0x3) * 4))
+#define SPI_CTAR_DBR(x)		(((x) & 0x00000001) << 31)
 #define SPI_CTAR_FMSZ(x)	(((x) & 0x0000000f) << 27)
 #define SPI_CTAR_CPOL(x)	((x) << 26)
 #define SPI_CTAR_CPHA(x)	((x) << 25)
@@ -139,8 +140,8 @@ static inline int is_double_byte_mode(struct fsl_dspi *dspi)
 	return ((val & SPI_FRAME_BITS_MASK) == SPI_FRAME_BITS(8)) ? 0 : 1;
 }
 
-static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
-		unsigned long clkrate)
+static void hz_to_spi_baud(char *dbr, char *pbr, char *br,
+		int speed_hz, unsigned long clkrate)
 {
 	/* Valid baud rate pre-scaler values */
 	int pbr_tbl[4] = {2, 3, 5, 7};
@@ -151,17 +152,21 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 		4096,	8192,	16384,	32768,
 	};
 	unsigned long r = INT_MAX, tmp;
-	int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(brs); i++)
-		for (j = 0; j < ARRAY_SIZE(pbr_tbl); j++) {
-			tmp = abs(clkrate / pbr_tbl[j] / brs[i] - speed_hz);
-			if (tmp >= r)
-				continue;
-			r = tmp;
-			*br = i;
-			*pbr = j;
+	int i, j, k;
+
+	for (k = 0; k < 2; k++) {
+		for (i = 0; i < ARRAY_SIZE(brs); i++) {
+			for (j = 0; j < ARRAY_SIZE(pbr_tbl); j++) {
+				tmp = abs(clkrate / pbr_tbl[j] / brs[i] - speed_hz);
+				if (tmp >= r)
+					continue;
+				r = tmp;
+				*br = i;
+				*pbr = j;
+				*dbr = k;
+			}
 		}
+	}
 }
 
 static int dspi_transfer_write(struct fsl_dspi *dspi)
@@ -342,7 +347,7 @@ static int dspi_setup(struct spi_device *spi)
 {
 	struct chip_data *chip;
 	struct fsl_dspi *dspi = spi_master_get_devdata(spi->master);
-	unsigned char br = 0, pbr = 0, fmsz = 0;
+	unsigned char br = 0, pbr = 0, dbr = 0, fmsz = 0;
 
 	if ((spi->bits_per_word >= 4) && (spi->bits_per_word <= 16)) {
 		fmsz = spi->bits_per_word - 1;
@@ -364,13 +369,14 @@ static int dspi_setup(struct spi_device *spi)
 
 	chip->void_write_data = 0;
 
-	hz_to_spi_baud(&pbr, &br,
+	hz_to_spi_baud(&dbr, &pbr, &br,
 			spi->max_speed_hz, clk_get_rate(dspi->clk));
 
 	chip->ctar_val =  SPI_CTAR_FMSZ(fmsz)
 		| SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
 		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0)
 		| SPI_CTAR_LSBFE(spi->mode & SPI_LSB_FIRST ? 1 : 0)
+		| SPI_CTAR_DBR(dbr)
 		| SPI_CTAR_PBR(pbr)
 		| SPI_CTAR_BR(br);
 
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
