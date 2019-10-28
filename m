From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Add missing lock protection when rebooting" to the spi tree
Date: Mon, 28 Oct 2019 14:56:50 +0000 (GMT)
Message-ID: <20191028145650.4A9B627403EE@ypsilon.sirena.org.uk>
References: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Cc: baolin.wang7@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        baolin.wang@linaro.org, broonie@kernel.org,
        ling_ling.xu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
To: Lingling Xu <ling_ling.xu@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Add missing lock protection when rebooting

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

>From 91ea1d70607e374b014b4b9bea771ce661f9f64b Mon Sep 17 00:00:00 2001
From: Lingling Xu <ling_ling.xu@unisoc.com>
Date: Mon, 28 Oct 2019 18:10:30 +0800
Subject: [PATCH] spi: sprd: adi: Add missing lock protection when rebooting

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9a051286f120..9613cfe3c0a2 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -393,6 +393,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
+	/* Lock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+
 	mdelay(1000);
 
 	dev_emerg(sadi->dev, "Unable to restart system\n");
-- 
2.20.1
