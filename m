From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/8] hwspinlock: Add devm_xxx() APIs to register/unregister one hwlock controller
Date: Fri, 22 Jun 2018 16:09:00 +0800
Message-ID: <52f3abc65549f6b412587a2c5938ee1347bccde7.1529654288.git.baolin.wang@linaro.org>
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

This patch introduces devm_hwspin_lock_register() and devm_hwspin_lock_unregister()
interfaces to help to register or unregister one hardware spinlock controller, that
will help to simplify the cleanup code for hwspinlock drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |   82 ++++++++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |    6 +++
 2 files changed, 88 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index d542b6f..ba27465 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -529,6 +529,88 @@ int hwspin_lock_unregister(struct hwspinlock_device *bank)
 }
 EXPORT_SYMBOL_GPL(hwspin_lock_unregister);
 
+static void devm_hwspin_lock_unreg(struct device *dev, void *res)
+{
+	hwspin_lock_unregister(*(struct hwspinlock_device **)res);
+}
+
+static int devm_hwspin_lock_device_match(struct device *dev, void *res,
+					 void *data)
+{
+	struct hwspinlock_device **bank = res;
+
+	if (WARN_ON(!bank || !*bank))
+		return 0;
+
+	return *bank == data;
+}
+
+/**
+ * devm_hwspin_lock_unregister() - unregister an hw spinlock device for
+ *				   a managed device
+ * @dev: the backing device
+ * @bank: the hwspinlock device, which usually provides numerous hw locks
+ *
+ * This function should be called from the underlying platform-specific
+ * implementation, to unregister an existing (and unused) hwspinlock.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_unregister(struct device *dev,
+				struct hwspinlock_device *bank)
+{
+	int ret;
+
+	ret = devres_release(dev, devm_hwspin_lock_unreg,
+			     devm_hwspin_lock_device_match, bank);
+	WARN_ON(ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_unregister);
+
+/**
+ * devm_hwspin_lock_register() - register a new hw spinlock device for
+ *				 a managed device
+ * @dev: the backing device
+ * @bank: the hwspinlock device, which usually provides numerous hw locks
+ * @ops: hwspinlock handlers for this device
+ * @base_id: id of the first hardware spinlock in this bank
+ * @num_locks: number of hwspinlocks provided by this device
+ *
+ * This function should be called from the underlying platform-specific
+ * implementation, to register a new hwspinlock device instance.
+ *
+ * Should be called from a process context (might sleep)
+ *
+ * Returns 0 on success, or an appropriate error code on failure
+ */
+int devm_hwspin_lock_register(struct device *dev,
+			      struct hwspinlock_device *bank,
+			      const struct hwspinlock_ops *ops,
+			      int base_id, int num_locks)
+{
+	struct hwspinlock_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_hwspin_lock_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = hwspin_lock_register(bank, dev, ops, base_id, num_locks);
+	if (!ret) {
+		*ptr = bank;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_hwspin_lock_register);
+
 /**
  * __hwspin_lock_request() - tag an hwspinlock as used and power it up
  *
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index dfd0593..94064cc 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -71,6 +71,12 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 struct hwspinlock *devm_hwspin_lock_request(struct device *dev);
 struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 						     unsigned int id);
+int devm_hwspin_lock_unregister(struct device *dev,
+				struct hwspinlock_device *bank);
+int devm_hwspin_lock_register(struct device *dev,
+			      struct hwspinlock_device *bank,
+			      const struct hwspinlock_ops *ops,
+			      int base_id, int num_locks);
 
 #else /* !CONFIG_HWSPINLOCK */
 
-- 
1.7.9.5
