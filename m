From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: added support for HW-loopback mode" to the spi tree
Date: Tue, 05 Jan 2016 19:15:25 +0000
Message-ID: <E1aGX4n-0005eg-SS@debutante>
References: <1450698772-2379-9-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-9-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: added support for HW-loopback mode

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b0632bfe5ec416a30d2e72bb1cc5dde5c6864e41 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Tue, 22 Dec 2015 18:03:28 +0000
Subject: [PATCH] spi: loopback-test: added support for HW-loopback mode

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7f79a77c4b68..a194d4bab7fa 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -282,8 +282,34 @@ static struct spi_test spi_tests[] = {
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
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
