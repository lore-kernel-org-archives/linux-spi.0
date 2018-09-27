From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: don't mark remove function as __exit" to the spi tree
Date: Thu, 27 Sep 2018 23:40:31 +0100 (BST)
Message-ID: <20180927224031.61209440078@finisterre.ee.mobilebroadband>
References: <20180926125833.2225931-1-arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926125833.2225931-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: don't mark remove function as __exit

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

>From 71d9a846fbcac1113b3810c06a8a3ddd936ada01 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 14:58:21 +0200
Subject: [PATCH] spi: sprd: don't mark remove function as __exit

The __exit section is left out for built-in drivers, so a
'remove' callback must not be marked as such to avoid breaking when
we unbind a device at runtime. This was pointed out by kbuild:

`sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a9a6c5ed443f..8daa24eec624 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sprd_spi_remove(struct platform_device *pdev)
+static int sprd_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr = platform_get_drvdata(pdev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
-- 
2.19.0
