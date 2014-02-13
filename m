From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3] spi: fsl-spi: Convert to let spi core validate
 xfer->bits_per_word
Date: Thu, 13 Feb 2014 19:05:38 +0800
Message-ID: <1392289538.20787.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set bits_per_word_mask so spi core will reject transfers that attempt to use
an unsupported bits_per_word value.

fsl_spi_grlib_probe() may update mpc8xxx_spi->max_bits_per_word setting.
So set master->bits_per_word_mask after fsl_spi_grlib_probe().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
v3: revise based on Andreas' suggestion.
v2:
Make sure bits_per_word can not be greater than mpc8xxx_spi->max_bits_per_word.

 drivers/spi/spi-fsl-spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 4dcb292..f35488e 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -239,12 +239,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 	if (!bits_per_word)
 		bits_per_word = spi->bits_per_word;
 
-	/* Make sure its a bit width we support [4..16, 32] */
-	if ((bits_per_word < 4)
-	    || ((bits_per_word > 16) && (bits_per_word != 32))
-	    || (bits_per_word > mpc8xxx_spi->max_bits_per_word))
-		return -EINVAL;
-
 	if (!hz)
 		hz = spi->max_speed_hz;
 
@@ -651,6 +645,10 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
+	master->bits_per_word_mask =
+		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
+
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
 		mpc8xxx_spi->set_shifts = fsl_spi_qe_cpu_set_shifts;
 
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
