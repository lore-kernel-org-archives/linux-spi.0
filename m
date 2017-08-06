From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: use of_property_read_bool()
Date: Sun, 06 Aug 2017 23:15:31 +0300
Message-ID: <20170806201546.905810410@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=spi-use-of_property_read_bool.patch
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use a bit more compact of_property_read_bool() calls instead of the
of_find_property() calls -- symmetrically with the of_property_read_u32()
calls already done in of_spi_parse_dt().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>

---
The patch is against the 'for-next' branch of Mark Brown's 'spi.git' repo.

 drivers/spi/spi.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: spi/drivers/spi/spi.c
===================================================================
--- spi.orig/drivers/spi/spi.c
+++ spi/drivers/spi/spi.c
@@ -1532,15 +1532,15 @@ static int of_spi_parse_dt(struct spi_co
 	int rc;
 
 	/* Mode (clock phase/polarity/etc.) */
-	if (of_find_property(nc, "spi-cpha", NULL))
+	if (of_property_read_bool(nc, "spi-cpha"))
 		spi->mode |= SPI_CPHA;
-	if (of_find_property(nc, "spi-cpol", NULL))
+	if (of_property_read_bool(nc, "spi-cpol"))
 		spi->mode |= SPI_CPOL;
-	if (of_find_property(nc, "spi-cs-high", NULL))
+	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
-	if (of_find_property(nc, "spi-3wire", NULL))
+	if (of_property_read_bool(nc, "spi-3wire"))
 		spi->mode |= SPI_3WIRE;
-	if (of_find_property(nc, "spi-lsb-first", NULL))
+	if (of_property_read_bool(nc, "spi-lsb-first"))
 		spi->mode |= SPI_LSB_FIRST;
 
 	/* Device DUAL/QUAD mode */

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
