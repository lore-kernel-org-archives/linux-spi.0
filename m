From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Add a reset reason for factory test mode" to the spi tree
Date: Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Message-ID: <20190726121224.491122742B63@ypsilon.sirena.org.uk>
References: <8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, robh+dt@kernel.org, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, weicx@spreadst.com,
        zhang.lyra@gmail.com
To: Sherry Zong <sherry.zong@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Add a reset reason for factory test mode

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

>From 9d9aa1cc91d68e2140e5948c15947b8254e008e2 Mon Sep 17 00:00:00 2001
From: Sherry Zong <sherry.zong@unisoc.com>
Date: Fri, 26 Jul 2019 15:20:50 +0800
Subject: [PATCH] spi: sprd: adi: Add a reset reason for factory test mode

Add a new reset flag to indicate that the system need enter factory test
mode after restarting system.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/8ae5651e876b527920ff878721a8a8ef47b099ac.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0b3f23ad6479..509ce6943adc 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -98,6 +98,7 @@
 #define HWRST_STATUS_AUTODLOADER	0xa0
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
+#define HWRST_STATUS_FACTORYTEST	0xe0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -339,6 +340,8 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 		reboot_mode = HWRST_STATUS_SPRDISK;
 	else if (!strncmp(cmd, "tospanic", 8))
 		reboot_mode = HWRST_STATUS_SECURITY;
+	else if (!strncmp(cmd, "factorytest", 11))
+		reboot_mode = HWRST_STATUS_FACTORYTEST;
 	else
 		reboot_mode = HWRST_STATUS_NORMAL;
 
-- 
2.20.1
