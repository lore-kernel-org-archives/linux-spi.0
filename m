From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] hwspinlock: Add one new API to support getting a specific hwlock by the name
Date: Fri,  1 Jun 2018 17:04:52 +0800
Message-ID: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The hardware spinlock binding already supplied the 'hwlock-names' property
to match and get a specific hwlock, but did not supply one API for users
to get a specific hwlock by the hwlock name. So this patch introduces one
API to support this requirement.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |   29 +++++++++++++++++++++++++++++
 include/linux/hwspinlock.h           |    7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 5278d05..00bde06 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -375,6 +375,35 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id);
 
+/**
+ * of_hwspin_lock_get_id_byname() - get lock id for an specified hwlock name
+ * @np: device node from which to request the specific hwlock
+ * @name: hwlock name
+ *
+ * This function provides a means for DT users of the hwspinlock module to
+ * get the global lock id of a specific hwspinlock using the specified name of
+ * the hwspinlock device, so that it can be requested using the normal
+ * hwspin_lock_request_specific() API.
+ *
+ * Returns the global lock id number on success, -EPROBE_DEFER if the hwspinlock
+ * device is not yet registered, -EINVAL on invalid args specifier value or an
+ * appropriate error as returned from the OF parsing of the DT client node.
+ */
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
+{
+	int index;
+
+	if (!name)
+		return -EINVAL;
+
+	index = of_property_match_string(np, "hwlock-names", name);
+	if (index < 0)
+		return index;
+
+	return of_hwspin_lock_get_id(np, index);
+}
+EXPORT_SYMBOL_GPL(of_hwspin_lock_get_id_byname);
+
 static int hwspin_lock_register_single(struct hwspinlock *hwlock, int id)
 {
 	struct hwspinlock *tmp;
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index fe450ee..f165cc8 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -74,6 +74,7 @@ int __hwspin_lock_timeout(struct hwspinlock *, unsigned int, int,
 							unsigned long *);
 int __hwspin_trylock(struct hwspinlock *, int, unsigned long *);
 void __hwspin_unlock(struct hwspinlock *, int, unsigned long *);
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name);
 
 #else /* !CONFIG_HWSPINLOCK */
 
@@ -133,6 +134,12 @@ static inline int hwspin_lock_get_id(struct hwspinlock *hwlock)
 	return 0;
 }
 
+static inline
+int of_hwspin_lock_get_id_byname(struct device_node *np, const char *name)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_HWSPINLOCK */
 
 /**
-- 
1.7.9.5
