From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH RESEND] spi: atmel: Remove needless bits_per_word and speed_hz tests
Date: Fri, 25 Sep 2015 09:03:01 +0300
Message-ID: <1443160981-15608-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This makes possible to remove two if
statements and remove one code block that is never executed.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 63318e2afba1..41e37a6a1368 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -871,14 +871,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	 * Calculate the lowest divider that satisfies the
 	 * constraint, assuming div32/fdiv/mbz == 0.
 	 */
-	if (xfer->speed_hz)
-		scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
-	else
-		/*
-		 * This can happend if max_speed is null.
-		 * In this case, we set the lowest possible speed
-		 */
-		scbr = 0xff;
+	scbr = DIV_ROUND_UP(bus_hz, xfer->speed_hz);
 
 	/*
 	 * If the resulting divider doesn't fit into the
@@ -1300,14 +1293,12 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	if (xfer->bits_per_word) {
-		asd = spi->controller_state;
-		bits = (asd->csr >> 4) & 0xf;
-		if (bits != xfer->bits_per_word - 8) {
-			dev_dbg(&spi->dev,
+	asd = spi->controller_state;
+	bits = (asd->csr >> 4) & 0xf;
+	if (bits != xfer->bits_per_word - 8) {
+		dev_dbg(&spi->dev,
 			"you can't yet change bits_per_word in transfers\n");
-			return -ENOPROTOOPT;
-		}
+		return -ENOPROTOOPT;
 	}
 
 	/*
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
