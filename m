From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 6/8] hwspinlock: sprd: Use devm_hwspin_lock_register()
Date: Fri, 22 Jun 2018 16:09:03 +0800
Message-ID: <e5f5f315a882fe5cdd161c8cb1790c9f3de0920a.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller to
avoid unregistering the device explicitly.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index dc42bf5..ba5daf6 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -120,8 +120,9 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sprd_hwlock);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = hwspin_lock_register(&sprd_hwlock->bank, &pdev->dev,
-				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
+	ret = devm_hwspin_lock_register(&pdev->dev, &sprd_hwlock->bank,
+					&sprd_hwspinlock_ops, 0,
+					SPRD_HWLOCKS_NUM);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
 		clk_disable_unprepare(sprd_hwlock->clk);
@@ -135,7 +136,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
 {
 	struct sprd_hwspinlock_dev *sprd_hwlock = platform_get_drvdata(pdev);
 
-	hwspin_lock_unregister(&sprd_hwlock->bank);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(sprd_hwlock->clk);
 	return 0;
-- 
1.7.9.5
