From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Add a reset reason for watchdog mode" to the spi tree
Date: Fri, 26 Jul 2019 13:12:24 +0100 (BST)
Message-ID: <20190726121224.0FE5C2742B9F@ypsilon.sirena.org.uk>
References: <1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        orsonzhai@gmail.com, robh+dt@kernel.org, sherry.zong@unisoc.com,
        vincent.guittot@linaro.org, weicx@spreadst.com,
        zhang.lyra@gmail.com
To: Sherry Zong <sherry.zong@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Add a reset reason for watchdog mode

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

>From e6d722ca09c1eebba5660e58b6bcac30c1ccc7ca Mon Sep 17 00:00:00 2001
From: Sherry Zong <sherry.zong@unisoc.com>
Date: Fri, 26 Jul 2019 15:20:51 +0800
Subject: [PATCH] spi: sprd: adi: Add a reset reason for watchdog mode

When the system was rebooted by watchdog, now we did not save the watchdog
reset mode which will make system enter a incorrect mode after rebooting.

Thus we should set the watchdog reset mode as default when opening the
watchdog configuration, that means if the system was rebooted by other
reason through the restart_handler(), then we will clear the default
watchdog reset mode to save the correct reset mode.

Signed-off-by: Sherry Zong <sherry.zong@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/1563f3de43c6c2262d597a25d6138b5de61ea23d.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 509ce6943adc..0d767eb67fcf 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -99,6 +99,7 @@
 #define HWRST_STATUS_IQMODE		0xb0
 #define HWRST_STATUS_SPRDISK		0xc0
 #define HWRST_STATUS_FACTORYTEST	0xe0
+#define HWRST_STATUS_WATCHDOG		0xf0
 
 /* Use default timeout 50 ms that converts to watchdog values */
 #define WDG_LOAD_VAL			((50 * 1000) / 32768)
@@ -309,6 +310,18 @@ static int sprd_adi_transfer_one(struct spi_controller *ctlr,
 	return 0;
 }
 
+static void sprd_adi_set_wdt_rst_mode(struct sprd_adi *sadi)
+{
+#ifdef CONFIG_SPRD_WATCHDOG
+	u32 val;
+
+	/* Set default watchdog reboot mode */
+	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val |= HWRST_STATUS_WATCHDOG;
+	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
+#endif
+}
+
 static int sprd_adi_restart_handler(struct notifier_block *this,
 				    unsigned long mode, void *cmd)
 {
@@ -347,6 +360,7 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 
 	/* Record the reboot mode */
 	sprd_adi_read(sadi, sadi->slave_pbase + PMIC_RST_STATUS, &val);
+	val &= ~HWRST_STATUS_WATCHDOG;
 	val |= reboot_mode;
 	sprd_adi_write(sadi, sadi->slave_pbase + PMIC_RST_STATUS, val);
 
@@ -475,6 +489,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	sprd_adi_hw_init(sadi);
+	sprd_adi_set_wdt_rst_mode(sadi);
 
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->bus_num = pdev->id;
-- 
2.20.1
