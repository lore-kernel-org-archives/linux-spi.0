From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS" to the spi tree
Date: Mon,  8 Apr 2019 14:33:24 +0700 (+07)
Message-ID: <20190408073324.BFBA8441D3B@finisterre.ee.mobilebroadband>
References: <20190406151457.32104-1-yuehaibing@huawei.com>
Cc: Hulk Robot <hulkci@huawei.com>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        eric@anholt.net, stefan.wahren@i2se.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190406151457.32104-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS

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

>From 9b186e9a65bffaef5ed56878095544b64584c29c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 6 Apr 2019 23:14:57 +0800
Subject: [PATCH] spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS

When building CONFIG_DEBUG_FS is not set
gcc warn this:

drivers/spi/spi-bcm2835aux.c: In function bcm2835aux_spi_probe:
drivers/spi/spi-bcm2835aux.c:591:2: error: too many arguments to function bcm2835aux_debugfs_create
  bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
  ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/spi-bcm2835aux.c:145:13: note: declared here
 static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8048d151eb4d ("spi: bcm2835aux: add driver stats to debugfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index fd8252dce4a2..bbf87adb3ff8 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -142,7 +142,8 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
 	bs->debugfs_dir = NULL;
 }
 #else
-static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
 {
 }
 
-- 
2.20.1
