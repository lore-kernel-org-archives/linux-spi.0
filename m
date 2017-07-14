From: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3] spi: loopback-test: provide loop_req option.
Date: Fri, 14 Jul 2017 11:42:46 +0200
Message-ID: <20170714094246.32003-1-o.rempel@pengutronix.de>
Cc: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Provide a module parameter to request internal loop by the SPI master
controller.
This should make loop testing easier without extra HW modification.

For test automation a logic analyzer is recommended for host
controller-independent verification.
An example test rig configuration and procedure:
  i.MX6S RIoRBoard           Logic Analyzer
  -----------------------------------------
  (J13  4) GND ------------- GND
  (J13  6) CSPI3-CLK ------> PIN 3
  (J13  8) CSPI3-MOSI <----- PIN 2
     ^ - internal loop configured by SPI_LOOP
     |   or can be user external jamper.
  (J13 10) CSPI3-MISO -----> PIN 1

grab some data and decode it:
sigrok-cli -d fx2lafw --time 160000 --config samplerate=10m  \
  --channels 0-2 -o dump.sr
sigrok-cli -i dump.sr -P spi:mosi=1:clk=2 > result_for_regression_tests

Signed-off-by: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
v3:
- more rewording after feed back provided by Paul Ferster 

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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
