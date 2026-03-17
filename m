Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E82DA769
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763490; cv=none; b=YaeS7ufNUxiqTNGvOCzEL0+FPfH/IKYtlhAeZP+XMjfVTgEM3wxw/cbUrtN9GCXHJRqm+DNdiygUIwcwI6l2l4B1Dt9ghCxzZ7siSOMpgN3VGr0h7T6cg8su4/5Zzzhu9IBFHNYBnnhyWg9cmq24/aK+r/G7eAu4xTs8bxkp+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763490; c=relaxed/simple;
	bh=/woO57/3kwyiiPsa2lSyKvtK+eath9N6mg7mZSaqCqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXN6dMc9mC0mpZjw+76Q1YWkB9cvrtp1BbyRYqWOfulypGM8xdJsFGcZKX32g1x+Lmge23phYGzx5G0TtMLLmV86XG2+BRlh5u5G1EzL1VOrrwzQWOfAyhvLLZFRXpua/fgha/Fa3UOeDRRT0r/je6ATOa+mmhBvBlz74+giEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mx/mMVJ0; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mx/mMVJ0"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8423654eec.0
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773763486; x=1774368286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFkyhNI2/Yf15avynpQ6DoytW+lLrvipNnvTKl0TtFE=;
        b=mx/mMVJ0T3xOAsXIA5SL2XOpXMYtFuVLpooyWCdKUwIy9tpSnPvd3xswtOmOBDAB1V
         zkv1YMQAFDB67jEyK0K6ocwiUvBIqEJHgtpW27Pa9v/27WCCfg6kQyDXq/1u3uqH1vrD
         PVgAtClmfpBJ2h4txuMlcMfbReMo0l2UfKBmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773763486; x=1774368286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFkyhNI2/Yf15avynpQ6DoytW+lLrvipNnvTKl0TtFE=;
        b=oIB0bqWtA5mXnXgFAOzXNY9kGW5uMt78znJQmK0gcNTw/2g1h/GdDLRhzREWcq7oNV
         2+0DXWH0SXkoxmaOOC5Dyn4mZ6UwkGyy7jiAVR45yA9bBCIj8J+CjFf3s63ZQ/RjKRzA
         1W1AKMSmFgYBovvHmy3FROjkWBN1yISssEJEmk++xbRJC2JtsBqD4Vut5FZQGzRGOuKC
         l5QBSRPnluJsl7wm7LdH+Zxv2GEoFGOb02GOKL4FJdvGoCLOr1JIDm2rDCcHeA9KjD6T
         /KgI9dqsg//GxFed6UOL730sbbXE0T6uJ+aqdh53EXEcsZOIo5nI3dXLkHGebwXrcDmA
         PK4g==
X-Forwarded-Encrypted: i=1; AJvYcCXixDizMHvtccxg91q1BrogiKEW3coYlYriKjU52d7j+N9+mZV3XRWF+c1zgEmhxPS6bxhHWsbrfZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNy2m3ZPnxiASeAkUpCe7H75RJaXwGjnmpUiP/9ALfW2s1q43
	cTqo6FcPzZi3gnpwJYpEKDeuCgCAZqaZGtt8Ek+Es7MSUstSUefYW1p90yElFIHdHw==
X-Gm-Gg: ATEYQzyRDwJ2Hj3a6O6KUyIbvle/gl9etr4JUvuk+7EpBi6al0H2gAPFCmFm0eK/Vei
	Lap7zdP5gdOeNFlnqs8zkgIY0p+JMUbO+PLBaLng3Vynf8AOJWOTqsCNMtOsQyFxdq9MHpGm9hJ
	JpBlmmmJPtDj5uv4UeaAVb+A+bMOr98HzK2Da27Z6p2UcCMu3wUWTDtOKyf4YURZzir/zIots2I
	rZYtY5af+CX5a8unEd5TGjP/ypyaCNi8cW4LptyOuplM8RlmwO9zBYXOtFWhr8ZRW+LJHP9eGDm
	fKyh+kKevAvfI4imb6Z4HvwDxZaODUtPFVXaJZZhWUSE3RNf8U0IqaxTHmjzExtCYQEASyjyY51
	kkyTS7+YFc4rHyorX/1q+J2S/prrCaVau5ZgadhDkKzXetXqNJ/hDnQCqZp9mYpgFzW7MVxSlvx
	8P0oOFs0MoB8FPPtN0hcNpdGjHEY3tBUAUporb+RpcJkutbYt74YxT1f65u4SfjW1nMsUraG9fx
	Uoa+1lOFgk=
X-Received: by 2002:a05:7300:6ca0:b0:2ba:a465:3a20 with SMTP id 5a478bee46e88-2bea5569b7cmr6387069eec.24.1773763486251;
        Tue, 17 Mar 2026 09:04:46 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:3965:b4d0:9159:598b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm23406119eec.28.2026.03.17.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:04:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] device property: Make modifications of fwnode "flags" thread safe
Date: Tue, 17 Mar 2026 09:01:20 -0700
Message-ID: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While this patch is not known for sure to fix any specific issues, it
seems possible that it could fix some rare problems. I'm currently
trying to track down a hard-to-reproduce heisenbug and one (currently
unproven) theory I had was that the fwnode flags could be getting
messed up like this. Even if turns out not to fix my heisenbug,
though, this seems like a worthwhile change to take.

Changes in v2:
- Add/use fwnode_assign_flag() (Andy).

 drivers/base/core.c                 | 24 +++++++--------
 drivers/bus/imx-weim.c              |  2 +-
 drivers/i2c/i2c-core-of.c           |  2 +-
 drivers/net/phy/mdio_bus_provider.c |  4 +--
 drivers/of/base.c                   |  2 +-
 drivers/of/dynamic.c                |  2 +-
 drivers/of/platform.c               |  2 +-
 drivers/spi/spi.c                   |  2 +-
 include/linux/fwnode.h              | 45 +++++++++++++++++++++--------
 9 files changed, 53 insertions(+), 32 deletions(-)

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
index 097be89487bf..c1ebcc6fd896 100644
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
@@ -212,16 +213,36 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
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
+static inline void fwnode_assign_flag(struct fwnode_handle *fwnode,
+				      unsigned int bit, bool value)
+{
+	assign_bit(bit, &fwnode->flags, value);
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
 	if (IS_ERR_OR_NULL(fwnode))
 		return;
-
-	if (initialized)
-		fwnode->flags |= FWNODE_FLAG_INITIALIZED;
-	else
-		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
+	fwnode_assign_flag(fwnode, FWNODE_FLAG_INITIALIZED, initialized);
 }
 
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
-- 
2.53.0.851.ga537e3e6e9-goog

