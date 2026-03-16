Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073135CB8C
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701089; cv=none; b=rNa+Dwz3sEs/cmeC8s+G3J716cslWR+N8uZQDZYMZkAeX99dMhmDhAWn2ApBj9PnnYxdDzhmjSMfMJcQQPYgrrjscP8pNkzpncQZOTxfxNjlGRUh1DnXbxMHF9Z6HxCQq1B6FPs6Hlh/N6OpqePd0UIqwXbPBRcUHCi/iXBzfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701089; c=relaxed/simple;
	bh=TbQNVQEsTIqifTBhmial/tJVeDIfLAcFVJyfGWKgSvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGOFzjBEHsF3XluCVOP8KQN9JxuussgwQBZa8ZayOUr/ZIp7By/TgtVsyqqaWYX5XiDB5KLnJ7GoUqdilsmYhgnOmeXFoYqfEhSInbNfPhaXxiswEHB1jOMDygrfqStWgT+8BBr0gPF3E1rHg8ccDU3FsbFO0Ixqc9XtwMQc6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KceJ7vbz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KceJ7vbz"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271257ae53so6929424c88.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773701086; x=1774305886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO9eSvDa3+h2qEsV4y9v8xIrZRQkG5vgqMO5VOKMlms=;
        b=KceJ7vbzRzs96WiZ7B5Ypns1TvqpxNtfpHVv17BZQAhc85G7CL5xX+asNowFS6vJCK
         hRDBFaVRYtzpG5MqgwzdV43wqGRpAeUeaUkvoY/syg7Ngr0V5Yx+KuzR5QOgqb/VxwWN
         3ti3haJn4y1ZHYzNSEInxD0XtzPIuY+PqUMt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701086; x=1774305886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO9eSvDa3+h2qEsV4y9v8xIrZRQkG5vgqMO5VOKMlms=;
        b=EgIZ9oTy8azgYzaqMLwesAu5DiN5aP7s9G38KQT1NAbM8ZQqZCQRJ1aQTlAdylrS7L
         Qmmllxq4B8ugpDT/wM9LxHelzkATMm5tMoSXSff7M4H/vchIP05etuC1RfLRIEeBKwR9
         JiBfm8+Ad1oIIgITo8U+kFbhFCDhry4XKVt005YcBPUNH6oCSXwu0/bt13kxX97vMnpn
         tdpOcX1bcfGpUqlpLlPVv9KIXtMTvQcqdt3VuR3JlzGNtHdyAKh/LcZoKxd4OtDAvh7d
         +6sw82zHpxDalyqS2WeD3EdO1B3+DQJkQvY/O4yQIiL8qY0WElUtPnMrIh8/pq5DjpFA
         b6qA==
X-Forwarded-Encrypted: i=1; AJvYcCWABix/E3T/nMv3VoIt0KB7iQuezn+FI1hGspBNonv9crYYFmHg3hShZtU3xSghaOksk2scrvMrk9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG0lU1yJMBjbmp2SxdLXM5CmKS5V4VDBoiTH7WCD48DE/Fxq/z
	m4ODrA2b3BQGK0V8SMX7GCQKjcSV+vc927HC+aFpcNOuxk4d/zYg3ne50Pv0mLIFkA==
X-Gm-Gg: ATEYQzyoKaZfHDFWN+Ra0NxPDdkue9uTy1CfCvQZmcP/R6hWHgaSKNzhbrq/WVMHl6P
	IjVne3D5sRT7KAdR8Sn7CDLMIls780qFzEzlQy0Cw+Y4qJk4zTQmRck+ak3X7CYodjIKtTjrBgq
	qxogON+TKPQQ1c2f6sA0ZOFH8h7CcrvaimQIaToR0YPqhlH8NyoB3g5hQDf4DswtOU6JP+6zjiR
	Tvz/FQ3/yhh93YNh/tjamuPGw5p22fmAspDDeIfKX1wqziVklsMMwg8pVU3FWjBKkIzg0toRD0+
	LmUnPNyucyWQ+bKqqaG53O3uIhUQYPotX891SigSE8YgkPSdqZ8L6Yr0G+QyWETh1IDQ4Mtl2qS
	ju3rYIsB2yyyXXFIWSYLr6EKbgwWB4qBJ0CPkGt36iVOVZB3oGwMMxECdjwQfv/YmnK8TQZHRCa
	oE1jvYzow5U6o4c2235aOk7b5KccAiJx4RUvn01ZWt/ygtoaj/RLRtExlZbGC5lV5+PFOjGbVSI
	qyiwvWCgqA=
X-Received: by 2002:a05:7022:b97:b0:128:ca90:32e2 with SMTP id a92af1059eb24-128f3d01194mr6948603c88.7.1773701086368;
        Mon, 16 Mar 2026 15:44:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:3965:b4d0:9159:598b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3eec8fsm16536873eec.13.2026.03.16.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:44:45 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] device property: Make modifications of fwnode "flags" thread safe
Date: Mon, 16 Mar 2026 15:42:06 -0700
Message-ID: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In various places in the kernel, we modify the fwnode "flags" member
by doing either:
  fwnode->flags |= SOME_FLAG;
  fwnode->flags &= ~SOME_FLAG;

This type of modification is not thread-safe. If two threads are both
mucking with the flags at the same time then one can clobber the
other.

While flags are often modified while under the "fwnode_link_lock",
this is not universally true.

Create some accessor functions for setting, clearing, and testing the
FWNODE flags and move all users to these accessor functions. New
accessor functions use set_bit() and clear_bit(), which are
thread-safe.

Cc: stable@vger.kernel.org
Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While this patch is not known for sure to fix any specific issues, it
seems possible that it could fix some rare problems. I'm currently
trying to track down a hard-to-reproduce heisenbug and one (currently
unproven) theory I had was that the fwnode flags could be getting
messed up like this. Even if turns out not to fix my heisenbug,
though, this seems like a worthwhile change to take.

 drivers/base/core.c                 | 24 +++++++++----------
 drivers/bus/imx-weim.c              |  2 +-
 drivers/i2c/i2c-core-of.c           |  2 +-
 drivers/net/phy/mdio_bus_provider.c |  4 ++--
 drivers/of/base.c                   |  2 +-
 drivers/of/dynamic.c                |  2 +-
 drivers/of/platform.c               |  2 +-
 drivers/spi/spi.c                   |  2 +-
 include/linux/fwnode.h              | 37 ++++++++++++++++++++++-------
 9 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791f9e444df8..f65492a4afc8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -182,7 +182,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	if (fwnode->dev)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	fwnode_links_purge_consumers(fwnode);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -228,7 +228,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 	if (fwnode->dev && fwnode->dev->bus)
 		return;
 
-	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
 	__fwnode_links_move_consumers(fwnode, new_sup);
 
 	fwnode_for_each_available_child_node(fwnode, child)
@@ -1012,7 +1012,7 @@ static void device_links_missing_supplier(struct device *dev)
 static bool dev_is_best_effort(struct device *dev)
 {
 	return (fw_devlink_best_effort && dev->can_match) ||
-		(dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EFFORT));
+		(dev->fwnode && (fwnode_test_flag(dev->fwnode, FWNODE_FLAG_BEST_EFFORT)));
 }
 
 static struct fwnode_handle *fwnode_links_check_suppliers(
@@ -1723,11 +1723,11 @@ bool fw_devlink_is_strict(void)
 
 static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
 {
-	if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
+	if (fwnode_test_flag(fwnode, FWNODE_FLAG_LINKS_ADDED))
 		return;
 
 	fwnode_call_int_op(fwnode, add_links);
-	fwnode->flags |= FWNODE_FLAG_LINKS_ADDED;
+	fwnode_set_flag(fwnode, FWNODE_FLAG_LINKS_ADDED);
 }
 
 static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
@@ -1885,7 +1885,7 @@ static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 	struct device *dev;
 	bool ret;
 
-	if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
+	if (!(fwnode_test_flag(fwnode, FWNODE_FLAG_INITIALIZED)))
 		return false;
 
 	dev = get_dev_from_fwnode(fwnode);
@@ -2001,10 +2001,10 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	 * We aren't trying to find all cycles. Just a cycle between con and
 	 * sup_handle.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_VISITED)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_VISITED))
 		return false;
 
-	sup_handle->flags |= FWNODE_FLAG_VISITED;
+	fwnode_set_flag(sup_handle, FWNODE_FLAG_VISITED);
 
 	/* Termination condition. */
 	if (sup_handle == con_handle) {
@@ -2074,7 +2074,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 	}
 
 out:
-	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
+	fwnode_clear_flag(sup_handle, FWNODE_FLAG_VISITED);
 	put_device(sup_dev);
 	put_device(con_dev);
 	put_device(par_dev);
@@ -2127,7 +2127,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	 * When such a flag is set, we can't create device links where P is the
 	 * supplier of C as that would delay the probe of C.
 	 */
-	if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD) &&
 	    fwnode_is_ancestor_of(sup_handle, con->fwnode))
 		return -EINVAL;
 
@@ -2150,7 +2150,7 @@ static int fw_devlink_create_devlink(struct device *con,
 	else
 		flags = FW_DEVLINK_FLAGS_PERMISSIVE;
 
-	if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
+	if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
 		sup_dev = fwnode_get_next_parent_dev(sup_handle);
 	else
 		sup_dev = get_dev_from_fwnode(sup_handle);
@@ -2162,7 +2162,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 * supplier device indefinitely.
 		 */
 		if (sup_dev->links.status == DL_DEV_NO_DRIVER &&
-		    sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
+		    fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)) {
 			dev_dbg(con,
 				"Not linking %pfwf - dev might never probe\n",
 				sup_handle);
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 83d623d97f5f..f735e0462c55 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -332,7 +332,7 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 			 * fw_devlink doesn't skip adding consumers to this
 			 * device.
 			 */
-			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+			fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
 				dev_err(&pdev->dev,
 					"Failed to create child device '%pOF'\n",
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index eb7fb202355f..354a88d0599e 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -180,7 +180,7 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		client = of_i2c_register_device(adap, rd->dn);
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 4b0637405740..fd691c5424ea 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -294,8 +294,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return -EINVAL;
 
 	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+		fwnode_set_flag(&bus->parent->of_node->fwnode,
+				FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
 
 	WARN(bus->state != MDIOBUS_ALLOCATED &&
 	     bus->state != MDIOBUS_UNREGISTERED,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 57420806c1a2..8d1972e18161 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1915,7 +1915,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
 		if (of_stdout)
-			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+			fwnode_set_flag(&of_stdout->fwnode, FWNODE_FLAG_BEST_EFFORT);
 	}
 
 	if (!of_aliases)
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 1a06175def37..ade288372101 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -225,7 +225,7 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
+	fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE);
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ba591fbceb56..7eeaf8e27b5b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -742,7 +742,7 @@ static int of_platform_notify(struct notifier_block *nb,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61f7bde8c7fb..ba8098f1a88c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4938,7 +4938,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		 * Clear the flag before adding the device so that fw_devlink
 		 * doesn't skip adding consumers to this device.
 		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
+		fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE);
 		spi = of_register_spi_device(ctlr, rd->dn);
 		put_device(&ctlr->dev);
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 097be89487bf..4f7f80155f69 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,6 +15,7 @@
 #define _LINUX_FWNODE_H_
 
 #include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -42,12 +43,12 @@ struct device;
  *		suppliers. Only enforce ordering with suppliers that have
  *		drivers.
  */
-#define FWNODE_FLAG_LINKS_ADDED			BIT(0)
-#define FWNODE_FLAG_NOT_DEVICE			BIT(1)
-#define FWNODE_FLAG_INITIALIZED			BIT(2)
-#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	BIT(3)
-#define FWNODE_FLAG_BEST_EFFORT			BIT(4)
-#define FWNODE_FLAG_VISITED			BIT(5)
+#define FWNODE_FLAG_LINKS_ADDED			0
+#define FWNODE_FLAG_NOT_DEVICE			1
+#define FWNODE_FLAG_INITIALIZED			2
+#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD	3
+#define FWNODE_FLAG_BEST_EFFORT			4
+#define FWNODE_FLAG_VISITED			5
 
 struct fwnode_handle {
 	struct fwnode_handle *secondary;
@@ -57,7 +58,7 @@ struct fwnode_handle {
 	struct device *dev;
 	struct list_head suppliers;
 	struct list_head consumers;
-	u8 flags;
+	unsigned long flags;
 };
 
 /*
@@ -212,6 +213,24 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 	INIT_LIST_HEAD(&fwnode->suppliers);
 }
 
+static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
+				   unsigned int bit)
+{
+	set_bit(bit, &fwnode->flags);
+}
+
+static inline void fwnode_clear_flag(struct fwnode_handle *fwnode,
+				   unsigned int bit)
+{
+	clear_bit(bit, &fwnode->flags);
+}
+
+static inline bool fwnode_test_flag(struct fwnode_handle *fwnode,
+				    unsigned int bit)
+{
+	return test_bit(bit, &fwnode->flags);
+}
+
 static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 					  bool initialized)
 {
@@ -219,9 +238,9 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 		return;
 
 	if (initialized)
-		fwnode->flags |= FWNODE_FLAG_INITIALIZED;
+		fwnode_set_flag(fwnode, FWNODE_FLAG_INITIALIZED);
 	else
-		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
+		fwnode_clear_flag(fwnode, FWNODE_FLAG_INITIALIZED);
 }
 
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
-- 
2.53.0.851.ga537e3e6e9-goog

