From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Add a reset reason for TOS panic" to the spi tree
Date: Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Message-ID: <20190726121224.8440C2742BAB@ypsilon.sirena.org.uk>
References: <97583aad1f2b849d69b4e76e8d29113da72a9fff.1564125131.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, robh+dt@kernel.org, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, weicx@spreadst.com,
        zhang.lyra@gmail.com
To: Chenxu Wei <weicx@spreadst.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <97583aad1f2b849d69b4e76e8d29113da72a9fff.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Add a reset reason for TOS panic

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

>From cc6b3431b36a1109d44cb8e4015cc68dddc75208 Mon Sep 17 00:00:00 2001
From: Chenxu Wei <weicx@spreadst.com>
Date: Fri, 26 Jul 2019 15:20:49 +0800
Subject: [PATCH] spi: sprd: adi: Add a reset reason for TOS panic

Add a new reset flag to indicate the reset reason is caused by TOS.

Signed-off-by: Chenxu Wei <weicx@spreadst.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/97583aad1f2b849d69b4e76e8d29113da72a9fff.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 11880db08ce9..0b3f23ad6479 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -86,6 +86,7 @@
 #define BIT_WDG_EN			BIT(2)
 
 /* Definition of PMIC reset status register */
+#define HWRST_STATUS_SECURITY		0x02
 #define HWRST_STATUS_RECOVERY		0x20
 #define HWRST_STATUS_NORMAL		0x40
 #define HWRST_STATUS_ALARM		0x50
@@ -336,6 +337,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_IQMODE;
 	else if (!strncmp(cmd, "sprdisk", 7))
 		reboot_mode = HWRST_STATUS_SPRDISK;
+	else if (!strncmp(cmd, "tospanic", 8))
+		reboot_mode = HWRST_STATUS_SECURITY;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
2.20.1
