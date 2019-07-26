From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd: adi: Change hwlock to be optional" to the spi tree
Date: Fri, 26 Jul 2019 13:12:23 +0100 (BST)
Message-ID: <20190726121223.D105E2742B66@ypsilon.sirena.org.uk>
References: <2abe7dcf210e4197f8c5ece7fc6d6cc1eda8c655.1564125131.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        sherry.zong@unisoc.com, vincent.guittot@linaro.org,
        weicx@spreadst.com, zhang.lyra@gmail.com
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2abe7dcf210e4197f8c5ece7fc6d6cc1eda8c655.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd: adi: Change hwlock to be optional

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

>From f9adf61e983f5d03334d841bc30f0e967a340b37 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 26 Jul 2019 15:20:52 +0800
Subject: [PATCH] spi: sprd: adi: Change hwlock to be optional

Now Spreadtrum ADI controller supplies multiple master accessing channel
to support multiple subsystems accessing, instead of using a hardware
spinlock to synchronize between the multiple subsystems.

To keep backward compatibility, we should change the hardware spinlock
to be optional. Moreover change to use of_hwspin_lock_get_id() function
which return -ENOENT error number to indicate no hwlock support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/2abe7dcf210e4197f8c5ece7fc6d6cc1eda8c655.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 68 +++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0d767eb67fcf..9a051286f120 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -165,14 +165,16 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	int read_timeout = ADI_READ_TIMEOUT;
 	unsigned long flags;
 	u32 val, rd_addr;
-	int ret;
-
-	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-					  ADI_HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret) {
-		dev_err(sadi->dev, "get the hw lock failed\n");
-		return ret;
+	int ret = 0;
+
+	if (sadi->hwlock) {
+		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+						  ADI_HWSPINLOCK_TIMEOUT,
+						  &flags);
+		if (ret) {
+			dev_err(sadi->dev, "get the hw lock failed\n");
+			return ret;
+		}
 	}
 
 	/*
@@ -219,7 +221,8 @@ static int sprd_adi_read(struct sprd_adi *sadi, u32 reg_paddr, u32 *read_val)
 	*read_val = val & RD_VALUE_MASK;
 
 out:
-	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	if (sadi->hwlock)
+		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
 	return ret;
 }
 
@@ -230,12 +233,14 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 	unsigned long flags;
 	int ret;
 
-	ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
-					  ADI_HWSPINLOCK_TIMEOUT,
-					  &flags);
-	if (ret) {
-		dev_err(sadi->dev, "get the hw lock failed\n");
-		return ret;
+	if (sadi->hwlock) {
+		ret = hwspin_lock_timeout_irqsave(sadi->hwlock,
+						  ADI_HWSPINLOCK_TIMEOUT,
+						  &flags);
+		if (ret) {
+			dev_err(sadi->dev, "get the hw lock failed\n");
+			return ret;
+		}
 	}
 
 	ret = sprd_adi_drain_fifo(sadi);
@@ -261,7 +266,8 @@ static int sprd_adi_write(struct sprd_adi *sadi, u32 reg_paddr, u32 val)
 	}
 
 out:
-	hwspin_unlock_irqrestore(sadi->hwlock, &flags);
+	if (sadi->hwlock)
+		hwspin_unlock_irqrestore(sadi->hwlock, &flags);
 	return ret;
 }
 
@@ -476,16 +482,26 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
-	ret = of_hwspin_lock_get_id_byname(np, "adi");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "can not get the hardware spinlock\n");
-		goto put_ctlr;
-	}
-
-	sadi->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
-	if (!sadi->hwlock) {
-		ret = -ENXIO;
-		goto put_ctlr;
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
+		sadi->hwlock =
+			devm_hwspin_lock_request_specific(&pdev->dev, ret);
+		if (!sadi->hwlock) {
+			ret = -ENXIO;
+			goto put_ctlr;
+		}
+	} else {
+		switch (ret) {
+		case -ENOENT:
+			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"failed to find hwlock id, %d\n", ret);
+			/* fall-through */
+		case -EPROBE_DEFER:
+			goto put_ctlr;
+		}
 	}
 
 	sprd_adi_hw_init(sadi);
-- 
2.20.1
