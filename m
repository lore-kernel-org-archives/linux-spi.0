From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/8] hwspinlock: Remove redundant config
Date: Fri, 22 Jun 2018 16:09:01 +0800
Message-ID: <a36034ffba1e2416270bce9ecf40bfa33f12f017.1529654288.git.baolin.wang@linaro.org>
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

The hardware core can not be built as a module, so remove the redundant
CONFIG_HWSPINLOCK_MODULE config.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/hwspinlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 94064cc..0afe693 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -52,7 +52,7 @@ struct hwspinlock_pdata {
 	int base_id;
 };
 
-#if defined(CONFIG_HWSPINLOCK) || defined(CONFIG_HWSPINLOCK_MODULE)
+#ifdef CONFIG_HWSPINLOCK
 
 int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		const struct hwspinlock_ops *ops, int base_id, int num_locks);
-- 
1.7.9.5
