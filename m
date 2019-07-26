From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 5/6] spi: sprd: adi: Change hwlock to be optional
Date: Fri, 26 Jul 2019 15:20:52 +0800
Message-ID: <2abe7dcf210e4197f8c5ece7fc6d6cc1eda8c655.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Cc: weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Now Spreadtrum ADI controller supplies multiple master accessing channel
to support multiple subsystems accessing, instead of using a hardware
spinlock to synchronize between the multiple subsystems.

To keep backward compatibility, we should change the hardware spinlock
to be optional. Moreover change to use of_hwspin_lock_get_id() function
which return -ENOENT error number to indicate no hwlock support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |   68 +++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0d767eb..9a05128 100644
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
1.7.9.5
