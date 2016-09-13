From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] spi: fsl-espi: simplify fsl_espi_setup_transfer
Date: Tue, 13 Sep 2016 23:15:45 +0200
Message-ID: <b3d6f046-0331-3482-ca87-9205ffd380d4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If t is not null then the SPI core takes care that bits_per_word and
speed_hz are populated. This allows to simplify fsl_espi_setup_transfer.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index bef0676..060624f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -176,23 +176,11 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	int bits_per_word = 0;
+	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
+	u32 hz = t ? t->speed_hz : spi->max_speed_hz;
 	u8 pm;
-	u32 hz = 0;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 
-	if (t) {
-		bits_per_word = t->bits_per_word;
-		hz = t->speed_hz;
-	}
-
-	/* spi_transfer level calls that work per-word */
-	if (!bits_per_word)
-		bits_per_word = spi->bits_per_word;
-
-	if (!hz)
-		hz = spi->max_speed_hz;
-
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
 	cs->get_rx = mpc8xxx_spi_rx_buf_u32;
-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
