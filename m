From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 8/8] spi: loopback-test: added support for HW-loopback mode
Date: Tue, 22 Dec 2015 18:03:28 +0000
Message-ID: <1450807408-2422-9-git-send-email-kernel@martin.sperl.org>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450807408-2422-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

If the module parameter "loopback" for testing RX to match TX
is not set and the spi_master supports SPI_LOOP then
SPI_LOOP as well as RX-data testing will get enabled.

When the "loopback" module parameter is set
then the SPI_LOOP support in spi_master will not get enabled,
which means that MOSI needs to get connected to MISO by some
other means (possibly via a simple jumper connection
or a SN74AHCT125 connecting MOSI/MISO)

Suggested-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 001f463..b49065a 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -288,8 +288,34 @@ static struct spi_test spi_tests[] = {
 static int spi_loopback_test_probe(struct spi_device *spi)
 {
 	int ret;
+	char *msg;
 
-	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
+	/*
+	 * Enable HW-loopback automatically if the master supports it
+	 * and we have the have_rx_buf unset (set means that we have
+	 * got an external loopback enabled, so no need to use SPI_LOOP)
+	 */
+	if (!check_rx_buf && (spi->master->mode_bits & SPI_LOOP)) {
+		spi->mode |= SPI_LOOP;
+		ret = spi_setup(spi);
+		if (ret) {
+			dev_err(&spi->dev,
+				"spi_setup failed to enable loopback: %i\n",
+				ret);
+			return ret;
+		}
+
+		/* force checking rx_buf for valid (loopback) data */
+		check_rx_buf = 1;
+
+		msg = "with SPI_LOOP support";
+	} else {
+		msg = (check_rx_buf) ?
+		      "with external loopback" :
+		      "without any loopback - rx_buf content is not checked";
+	}
+
+	dev_info(&spi->dev, "Executing spi-loopback-tests %s\n", msg);
 
 	ret = spi_test_run_tests(spi, spi_tests);
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
