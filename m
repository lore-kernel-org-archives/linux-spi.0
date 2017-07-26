From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: loopback-test: implement testing with no CS" to the spi tree
Date: Wed, 26 Jul 2017 15:18:06 +0100
Message-ID: <E1daN8Y-0003tW-Ee@debutante>
References: <20170725075709.27438-1-o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725075709.27438-1-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: loopback-test: implement testing with no CS

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

>From 8bc85a871436525cc38f819bbc122d216730e905 Mon Sep 17 00:00:00 2001
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Tue, 25 Jul 2017 09:57:08 +0200
Subject: [PATCH] spi: loopback-test: implement testing with no CS

To run spi-loopback-tests on HW without modifications, we need to
disable Chip Select. This should avoid surprising side effects for
SPI devices by testing patterns.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
