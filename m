From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v2] spi: loopback-test: provide loop_req option.
Date: Fri, 14 Jul 2017 11:19:36 +0200
Message-ID: <20170714091936.22440-1-o.rempel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
To: kernel@pengutronix.de, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Provide a module parameter to request internal loop by the SPI master
controller.
This should make loop testing easier without extra HW modification.

For test automation can be also used logic analyzer.
If some one wish to reproduce my test. Here is used setup:
  i.MX6S RIoRBoard           Logic Analyzer
  -----------------------------------------
  (J13  4) GND ------------- GND
  (J13  6) CSPI3-CLK ------> PIN 3
  (J13  8) CSPI3-MOSI <----- PIN 2
     ^ - internal loop configured by SPI_LOOP
     |
  (J13 10) CSPI3-MISO -----> PIN 1

grub some data and decode it:
sigrok-cli -d fx2lafw --time 160000 --config samplerate=10m  \
  --channels 0-2 -o dump.sr
sigrok-cli -i dump.sr -P spi:mosi=1:clk=2 > result_for_regression_tests

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v2:
- some spelling fixes
- add more background about testing setup
- reword error message.

 drivers/spi/spi-loopback-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index f4875f177df0..cfc7222f0a85 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -51,6 +51,12 @@ MODULE_PARM_DESC(loopback,
 		 "is checked to match tx_buf after the spi_message "	\
 		 "is executed");
 
+int loop_req;
+module_param(loop_req, int, 0);
+MODULE_PARM_DESC(loop_req,
+		 "if set controller will be asked to enable test loop mode. " \
+		 "If controller supported it, MISO and MOSI will be connected");
+
 /* run only a specific test */
 int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -313,6 +319,16 @@ static int spi_loopback_test_probe(struct spi_device *spi)
 {
 	int ret;
 
+	if (loop_req) {
+		spi->mode = SPI_LOOP | spi->mode;
+		ret = spi_setup(spi);
+		if (ret) {
+			dev_err(&spi->dev, "SPI setup with SPI_LOOP failed (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
 	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
 
 	ret = spi_test_run_tests(spi, spi_tests);
-- 
2.11.0
