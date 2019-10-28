From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting" to the spi tree
Date: Mon, 28 Oct 2019 14:56:49 +0000 (GMT)
Message-ID: <20191028145650.137E127403E4@ypsilon.sirena.org.uk>
References: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
Cc: baolin.wang7@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        baolin.wang@linaro.org, broonie@kernel.org,
        ling_ling.xu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
To: Lingling Xu <ling_ling.xu@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting

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

>From 1d00a67c2da2d8d82e6dcc5b398d9f6db656d9be Mon Sep 17 00:00:00 2001
From: Lingling Xu <ling_ling.xu@unisoc.com>
Date: Mon, 28 Oct 2019 18:10:31 +0800
Subject: [PATCH] spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting

When rebooting system, the PMIC watchdog time loading may not be loaded
correctly when another system is feeding the PMIC watchdog, since we did
not check the watchdog busy status before loading time values.

Thus we should set the BIT_WDG_NEW bit before loading time values, that
can support multiple loads without checking busy status to make sure the
time values can be loaded successfully to avoid this potential issue.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/5655318a7252c9ea518c2f7950a61228ab8f42bf.1572257085.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9613cfe3c0a2..87dadb6b8ebf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -77,6 +77,7 @@
 
 /* Bits definitions for register REG_WDG_CTRL */
 #define BIT_WDG_RUN			BIT(1)
+#define BIT_WDG_NEW			BIT(2)
 #define BIT_WDG_RST			BIT(3)
 
 /* Registers definitions for PMIC */
@@ -383,6 +384,10 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	/* Unlock the watchdog */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, WDG_UNLOCK_KEY);
 
+	sprd_adi_read(sadi, sadi->slave_pbase + REG_WDG_CTRL, &val);
+	val |= BIT_WDG_NEW;
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
+
 	/* Load the watchdog timeout value, 50ms is always enough. */
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOAD_LOW,
 		       WDG_LOAD_VAL & WDG_LOAD_MASK);
-- 
2.20.1
