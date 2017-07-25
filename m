From: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v1 1/2] spi: loopback-test: implement testing with no CS
Date: Tue, 25 Jul 2017 09:57:08 +0200
Message-ID: <20170725075709.27438-1-o.rempel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To run spi-loopback-tests on HW without modifications, we need to
disable Chip Select. This should avoid surprising side effects for
SPI devices by testing patterns.

Signed-off-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 64a1e6f212c1..bed7403bb6b3 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -57,6 +57,11 @@ MODULE_PARM_DESC(loop_req,
 		 "if set controller will be asked to enable test loop mode. " \
 		 "If controller supported it, MISO and MOSI will be connected");
 
+static int no_cs;
+module_param(no_cs, int, 0);
+MODULE_PARM_DESC(no_cs,
+		 "if set Chip Select (CS) will not be used");
+
 /* run only a specific test */
 static int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -319,11 +324,12 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 {
 	int ret;
 
-	if (loop_req) {
-		spi->mode = SPI_LOOP | spi->mode;
+	if (loop_req || no_cs) {
+		spi->mode |= loop_req ? SPI_LOOP : 0;
+		spi->mode |= no_cs ? SPI_NO_CS : 0;
 		ret = spi_setup(spi);
 		if (ret) {
-			dev_err(&spi->dev, "SPI setup with SPI_LOOP failed (%d)\n",
+			dev_err(&spi->dev, "SPI setup with SPI_LOOP or SPI_NO_CS failed (%d)\n",
 				ret);
 			return ret;
 		}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
