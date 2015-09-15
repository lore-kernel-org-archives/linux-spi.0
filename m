From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 10/16] spi: atmel: Remove needless bits_per_word and speed_hz tests
Date: Tue, 15 Sep 2015 16:26:22 +0300
Message-ID: <1442323588-29642-10-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set. This makes possible to remove two if
statements and remove one code block that is never executed.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
