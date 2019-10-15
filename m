From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-loopback-test: use new `delay` field" to the spi tree
Date: Tue, 15 Oct 2019 12:12:23 +0100 (BST)
Message-ID: <20191015111224.0F45627419E4@ypsilon.sirena.org.uk>
References: <20190926105147.7839-13-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-13-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-loopback-test: use new `delay` field

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 867bd8868bbd16e17bbd26c5959abc3118902218 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:40 +0300
Subject: [PATCH] spi: spi-loopback-test: use new `delay` field

This change replaces the use of the `delay_usecs` field with the new
`delay` field. The code/test still uses micro-seconds, but they are now
configured and used via the `struct spi_delay` format of the `delay` field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-13-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6f18d4952767..b6d79cd156fb 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -298,12 +298,18 @@ static struct spi_test spi_tests[] = {
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 			{
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
-				.delay_usecs = 1000,
+				.delay = {
+					.value = 1000,
+					.unit = SPI_DELAY_UNIT_USECS,
+				},
 			},
 		},
 	},
@@ -537,7 +543,7 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 		unsigned long long nbits = (unsigned long long)BITS_PER_BYTE *
 					   xfer->len;
 
-		delay_usecs += xfer->delay_usecs;
+		delay_usecs += xfer->delay.value;
 		if (!xfer->speed_hz)
 			continue;
 		estimated_time += div_u64(nbits * NSEC_PER_SEC, xfer->speed_hz);
-- 
2.20.1
