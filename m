From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bitbang: Introduce spi_bitbang_init()" to the spi tree
Date: Mon,  8 Apr 2019 14:32:24 +0700 (+07)
Message-ID: <20190408073224.76C3B441D3C@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-12-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-12-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bitbang: Introduce spi_bitbang_init()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 45beec3519983cb11768cd3ee350f44975bf4cea Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:32 -0700
Subject: [PATCH] spi: bitbang: Introduce spi_bitbang_init()

Move all of the code doing struct spi_bitbang initialization, so that
it can be paired with devm_spi_register_master() in order to avoid
having to call spi_bitbang_stop() explicitly.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bitbang.c       | 66 +++++++++++++++++++--------------
 include/linux/spi/spi_bitbang.h |  1 +
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index dd9a8c54a693..4243e53f9f7b 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -335,6 +335,42 @@ static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 
 /*----------------------------------------------------------------------*/
 
+int spi_bitbang_init(struct spi_bitbang *bitbang)
+{
+	struct spi_master *master = bitbang->master;
+
+	if (!master || !bitbang->chipselect)
+		return -EINVAL;
+
+	mutex_init(&bitbang->lock);
+
+	if (!master->mode_bits)
+		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
+
+	if (master->transfer || master->transfer_one_message)
+		return -EINVAL;
+
+	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
+	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
+	master->transfer_one = spi_bitbang_transfer_one;
+	master->set_cs = spi_bitbang_set_cs;
+
+	if (!bitbang->txrx_bufs) {
+		bitbang->use_dma = 0;
+		bitbang->txrx_bufs = spi_bitbang_bufs;
+		if (!master->setup) {
+			if (!bitbang->setup_transfer)
+				bitbang->setup_transfer =
+					 spi_bitbang_setup_transfer;
+			master->setup = spi_bitbang_setup;
+			master->cleanup = spi_bitbang_cleanup;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_init);
+
 /**
  * spi_bitbang_start - start up a polled/bitbanging SPI master driver
  * @bitbang: driver handle
@@ -368,33 +404,9 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
 	struct spi_master *master = bitbang->master;
 	int ret;
 
-	if (!master || !bitbang->chipselect)
-		return -EINVAL;
-
-	mutex_init(&bitbang->lock);
-
-	if (!master->mode_bits)
-		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;
-
-	if (master->transfer || master->transfer_one_message)
-		return -EINVAL;
-
-	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
-	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
-	master->transfer_one = spi_bitbang_transfer_one;
-	master->set_cs = spi_bitbang_set_cs;
-
-	if (!bitbang->txrx_bufs) {
-		bitbang->use_dma = 0;
-		bitbang->txrx_bufs = spi_bitbang_bufs;
-		if (!master->setup) {
-			if (!bitbang->setup_transfer)
-				bitbang->setup_transfer =
-					 spi_bitbang_setup_transfer;
-			master->setup = spi_bitbang_setup;
-			master->cleanup = spi_bitbang_cleanup;
-		}
-	}
+	ret = spi_bitbang_init(bitbang);
+	if (ret)
+		return ret;
 
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index b7e021b274dc..4444c2a992cb 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -44,6 +44,7 @@ extern int spi_bitbang_setup_transfer(struct spi_device *spi,
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);
+extern int spi_bitbang_init(struct spi_bitbang *spi);
 extern void spi_bitbang_stop(struct spi_bitbang *spi);
 
 #endif	/* __SPI_BITBANG_H */
-- 
2.20.1
