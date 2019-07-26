From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Remove redundant address bits setting" to the spi tree
Date: Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Message-ID: <20190726121224.BD6AA2742B66@ypsilon.sirena.org.uk>
References: <3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        sherry.zong@unisoc.com, vincent.guittot@linaro.org,
        weicx@spreadst.com, zhang.lyra@gmail.com
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Remove redundant address bits setting

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From c627c58acdc48055a9e4d40d6f9f1b434222a68d Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 26 Jul 2019 15:20:48 +0800
Subject: [PATCH] spi: sprd: adi: Remove redundant address bits setting

The ADI default transfer address bits is 12bit on Spreadtrum SC9860
platform, thus there is no need to set again, remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index df5960bddfe6..11880db08ce9 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -380,9 +380,6 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 	const __be32 *list;
 	u32 tmp;
 
-	/* Address bits select default 12 bits */
-	writel_relaxed(0, sadi->base + REG_ADI_CTRL0);
-
 	/* Set all channels as default priority */
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIL);
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIH);
-- 
2.20.1
