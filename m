From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: provide loop_req option." to the spi tree
Date: Mon, 17 Jul 2017 17:06:52 +0100
Message-ID: <E1dX8Xs-0005FU-1r@debutante>
References: <20170714091936.22440-1-o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        linux-spi@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170714091936.22440-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: provide loop_req option.

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

>From f12a616e0cdee71440b72f7602825db424d37879 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 14 Jul 2017 11:42:46 +0200
Subject: [PATCH] spi: loopback-test: provide loop_req option.

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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 3459965004f8..0d3c56e2526c 100644
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
2.13.2
