From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1] spi: loopback-test: provide loop request option.
Date: Wed, 12 Jul 2017 15:40:20 +0200
Message-ID: <20170712134020.17927-1-o.rempel@pengutronix.de>
Cc: Oleksij Rempel <linux@rempel-privat.de>
To: kernel@pengutronix.de, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Oleksij Rempel <linux@rempel-privat.de>

Provide a module parameter to request internal
loop by the SPI master controller.
This should make loop testing easier without extra HW modification.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 drivers/spi/spi-loopback-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index f4875f177df0..34e1544d7d0e 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -51,6 +51,14 @@ MODULE_PARM_DESC(loopback,
 		 "is checked to match tx_buf after the spi_message "	\
 		 "is executed");
 
+/* the device is jumpered for loopback - enabling some rx_buf tests */
+int loop_req;
+module_param(loop_req, int, 0);
+MODULE_PARM_DESC(loop_req,
+		 "if set enable controller will be asked to enable "	\
+		 "test loop mode. If supported, MISO and MOSI will be "  \
+		 "jumpered by SPI controller");
+
 /* run only a specific test */
 int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -313,6 +321,16 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 {
 	int ret;
 
+	if (loop_req) {
+		spi->mode = SPI_LOOP | spi->mode;
+		ret = spi_setup(spi);
+		if (ret) {
+			dev_err(&spi->dev, "SPI setup wasn't successful %d\n", ret);
+			dev_err(&spi->dev, "SPI_LOOP is not supported by SPI master.");
+			return -ENODEV;
+		}
+	}
+
 	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
 
 	ret = spi_test_run_tests(spi, spi_tests);
-- 
2.11.0
