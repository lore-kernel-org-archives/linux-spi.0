From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 4/4] spi: loopback-test: added support for HW-loopback mode
Date: Fri, 18 Dec 2015 12:44:27 +0000
Message-ID: <1450442668-2391-5-git-send-email-kernel@martin.sperl.org>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450442668-2391-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

If the module parameter "loopback" for testing RX to match TX
is not set and the spi_master supports SPI_LOOP then
SPI_LOOP as well as RX-data testing will get enabled.

When the "loopback" module parameter is set
then the SPI_LOOP support in spi_master will not get enabled,
which means that MOSI needs to get connected to MISO by some
other means (possibly via a jumper connection or a SN74AHCT125)

Suggested-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Note: this has been tested by faking SPI_LOOP support
inside spi-bcm2835 (master->mode_bits |= SPI_LOOP;)
and retaining the external link between MOSI and MISO.

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6e76c3e..15207a7 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -289,7 +289,21 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 {
 	int ret;

-	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
+	/* enable HW-loopback automatically if the master supports it
+	 * and we have the loopback module parameter unset
+	 */
+	if ((!loopback) && (spi->master->mode_bits & SPI_LOOP)) {
+		spi->mode |= SPI_LOOP;
+		ret = spi_setup(spi);
+		if (ret)
+			dev_err(&spi->dev,
+				"spi_setup failed to enable loopback: %i\n",
+				ret);
+		loopback = 1;
+	}
+
+	dev_info(&spi->dev, "Executing spi-loopback-tests%s\n",
+		 loopback ? " with loopback tests enabled" : "");

 	ret = spi_test_run_tests(spi, spi_tests);

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
