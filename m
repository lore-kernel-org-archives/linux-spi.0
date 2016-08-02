From: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: [PATCH] spi/fsl-espi: fix support for all available clock rates
Date: Tue,  2 Aug 2016 14:38:05 -0300
Message-ID: <1470159485-7926-1-git-send-email-paulo.zaneti@datacom.ind.br>
Cc: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

According to NXP ESPI datasheet, the SPI clock rate is:

    spi_clk = System_Clock / ( 2 * DIV16 * ( 1 + PM ) )

Where System_Clock is the platform clock divided by 2,
DIV16 may be 1 or 16, and PM is a 4 bits integer (0 to 15).

Isolating PM on the expression, we get:

    PM = (System_Clock / ( 2 * DIV16 * spi_clk ) ) - 1

Where System_Clock = mpc8xxx_spi->spibrg / 2, spi_clk = hz,
and DIV16 = 1 or DIV16 = 16. So,

    PM = (mpc8xxx_spi->spibrg / ( 4 * hz) ) - 1
or
    PM = (mpc8xxx_spi->spibrg / ( 16 * 4 * hz) ) - 1

Current spi-fsl-espi driver can't configure the HW for all
supported clock rates. It filters out clock rates for PM = 0
and PM = 1.

This patch allows all range of supported clock rates to be
configured on the ESPI controller.

Signed-off-by: Paulo Zaneti <paulo.zaneti-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 8d85a3c..947ded2 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -136,7 +136,7 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int bits_per_word = 0;
-	u8 pm;
+	u32 pm;
 	u32 hz = 0;
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
 
@@ -176,22 +176,18 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
 
 	cs->hw_mode |= CSMODE_LEN(bits_per_word);
 
-	if ((mpc8xxx_spi->spibrg / hz) > 64) {
+	pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4) - 1;
+
+	if (pm > 15) {
 		cs->hw_mode |= CSMODE_DIV16;
-		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4);
+		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4) - 1;
 
-		WARN_ONCE(pm > 33, "%s: Requested speed is too low: %d Hz. "
+		WARN_ONCE(pm > 15, "%s: Requested speed is too low: %d Hz. "
 			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
-				hz, mpc8xxx_spi->spibrg / (4 * 16 * (32 + 1)));
-		if (pm > 33)
-			pm = 33;
-	} else {
-		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4);
+				hz, mpc8xxx_spi->spibrg / (4 * 16 * (15 + 1)));
+		if (pm > 15)
+			pm = 15;
 	}
-	if (pm)
-		pm--;
-	if (pm < 2)
-		pm = 2;
 
 	cs->hw_mode |= CSMODE_PM(pm);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
