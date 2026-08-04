Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265F383310;
	Tue,  4 Aug 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844478; cv=fail; b=lh+ESxcmEkNIjm+7bZqBC6sRdOlgcf01bvJfrdaZF32UWITHJPpADHEyzLlKbMXZsrR3zWjTFjXizAWCLM4bcdjpR9xe/Svf4tQ0OiZhlTv3hE2Q95uSnnEwzG/2AcoIPd9zIpvC4UBTgDNA82H8XxIcrGpTsWRUMWWCVO5rUAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844478; c=relaxed/simple;
	bh=wmTyO84ht0Q+39TliuYjkNouDdzqbmI9kjsflt3EX8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFLG+mpsm8hy2bR8yqRMqK9HX5K5WgZot82qh+hfQOQse1BN11xtDopDQgoWURFboDSuLejFI668J7rgiIXkfQp2INzuJiSheNKhGRKsJBa2enHTCLU4DpVWcCV4S6hn6nA8CFJDZkLWTwATvQDZwwrE/U6JTP8fs/zgg9C5ob0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QnVEW7R/; arc=fail smtp.client-ip=52.101.193.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QnVEW7R/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prEgw3+Yiq8Z4RtxQOugk1yHD3iXMSvsv7WUvEkggyNMWorRh6kHfO7jD0fPzvTxp2Zs6M9LN9BPkOAeMjuYRogrDl05F1eP+N+JZr1dcpfxNnsGHnaFitVBE+9dKpCJDvfkg1+DRDwlvjkThWChoJcfl+JfvqG7/V23hY1Cimll5yV2kUztCo8xFLS1RLqTHqXWtAOwhKEOF2Hdd8QFJkhhme2fj6wbxzAe8HtEOX9pc6Ms4n0wxwGU/S2+Fn4Vt6yochg9MHZ9lQfxnXUml5yWkUOsSrmEWEm6BGjsoxGFfoDZpdsTlb+/LH5v5Qtzfqdbj44b/nSip1/3sa+WMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSgBMog4Z3WKer5LhvpdcpMFJ1cTXhIW3nz5stH/uZY=;
 b=W8v0DlYFS35MzIMnxldZlH7YVJDxQnIxnzImdchA21yjgAQAX6xjiqivgKHRZq/YS/S8cwTaIbvj3zbnIm+WNYe+OL98nQOTdBaPlh/FvTrBcu96Xg/Oz3ir/eRazluOCErKKztpeWJNfLlUij7ReDenIbBntvM1aDb9MptzCfoMmEiaUrzPdMvSIuAGGBTd1QK4MX/hXFNQjPC292U9wf0P74ffM5o/zzYtriyUUU+aGT/yZhnayoZbcvVv18J7kAt9e7fqN6Ut9VGdExGRFodM1eTZWyHEpBJOqLEibiGBXvuU3zSLLzWU2YKL9HNyxUPwyQuH+WCNlar7BE6k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSgBMog4Z3WKer5LhvpdcpMFJ1cTXhIW3nz5stH/uZY=;
 b=QnVEW7R/bq1v30bJzWmRo0fsdGnI89kr92MWMDChL2WakaHGpnYVpx5dILJQMvpCnIYyacNIW7zaYuyQQPC0DofpOjE6DVA1Vcm+XgBPtCo1XIeYjxuPZr/FinzaTa8XjF5cARSe9IAf0VBdKqPxnsWWe8QkVlMHpjqyehyC/sw=
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:54:31 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a4) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 11:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:54:31 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:54:27 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <akshata.mukundshetty@amd.com>,
	<bleung@chromium.org>, <groeck@chromium.org>,
	<chrome-platform@lists.linux.dev>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [RFC PATCH 2/4] espi: add slave device model and event notification
Date: Tue, 4 Aug 2026 17:22:57 +0530
Message-ID: <20260804115259.4065638-3-krishnamoorthi.m@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b9cc1c-03c5-4fb9-8a09-08def21f2534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|36860700016|23010399003|376014|7416014|30052699003|1800799024|82310400026|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	ubIzRy1TUIOXNwBsBP2ORrDhQ/mL0zs9a8GnNI6fqQNm2oodIzsrdfd9aDLmg4IPrMCjZcofdwlwL0TMspDE6BphZdGhYIdpXIZDAIvBfEChVSsXW9m/KQ6tAZidW6YKkILiNBFmfl8BN+YZ5Dkpw/oasGuO29KFY8wIDRtCe9/Ew2mNNxQ5HYwqKI2bK2KiRwTepYp1KU9j63xwikhHf0oSbHd2chxfW2PoiiJlw58ccoh/gnWDWiVDVOowCTMWqcK+AoEsoFZChr7tWY8RrNO7nR0BMlnIcAfG+0UQPPcw+uSDK53eokVhYpU6QrlIB/Zi8tLHkTei8U0N9xbYDWqIx3aNzVUO03tWLwonZSF67/7iqoMkh0C4b6H7NIWPuRUr54uSW9aP3MT0hLVjbP+5IyIrVBWK66ox5MoNUiP9kBiq/BU14SbeRd2nK0pg/vINZ1ayzAeu6W9ddgQHN4WvvXwE6ab0DI7vBfvlD4wS4nOh4H1NTmWLJslrrePZ1UXVAFQslt7oTYqaeqdHQRWVbRL32FaT6Ae9ZivfmVu4aOo2D+vrrB1WhZO3CvSXvB1rD5gKKoHhoj2aAENwwjohwikEJaOSttAIzadTpmcnECId1ENeFS7PhU9xpvs2UDpMSvimrloL35q+eBPDPXQrL8LGzPLjhCOIhB0pZpEt+OOaQplOFkWgDG6ZswKH9OZpsIe5Tv/hIJRNswQJAw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(4022899009)(36860700016)(23010399003)(376014)(7416014)(30052699003)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tm0lEz5Rh4lC+RMWji+WeJAeeQ0RcSFFiTnmcb5oRTl7u909u+F3CxjggmJO/EKO3GCUW9RRAaOAP5k1BAiB80q4ditKGYxeAdHOSm9srEvzeFCW21Xk5a+EF7lik9ibnH7pyItjSxL1silh3iyCVtLwDv6Y6uTw8yBzKSE6n3LL0Vqjj+09P3nU424CiQ+Ypc04NgOOvtgbOdv+MS0ARVezHONBVhTueL4arcXmlEZCrvSNe/4NnPZN4kQdEHiMcqxSm3qTvae0j9AD3hKFhshZtOgijdkY/r0D+Svx2AHcFZ2FG7o/P7uhd7y4UzXNkpeHxKNlgOTIlM4hs9doeOOqNgYrHCburCUU/45j0zYfnnGCGBQlMJykQh3xIqD1zpL1TBRJNtivs7lLOqDQF5eQSIxATEXXCkzr7v90iNMJn8EH2lHN8wwkltsQGrAB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:54:31.4756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b9cc1c-03c5-4fb9-8a09-08def21f2534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

Add espi_new_device()/espi_remove_device() and a process-context
blocking-notifier event chain. Devices are named espi<bus>.<cs>
(unique across controllers) and matched via a modalias string, also
emitted in the MODALIAS uevent.

cs is range-checked against ctrl->max_targets when the controller
advertises a non-zero limit. Devices are added to ctrl->device_list
before device_register() so that any controller-side iteration sees
the device as soon as the uevent fires.

A per-controller blocking notifier chain delivers hardware events to
slave drivers from process context. Slave drivers subscribe with a
notifier_block; the val argument is the espi_event_type and the data
pointer is the full struct espi_event. A blocking notifier is used
rather than a raw notifier because slave driver callbacks may sleep,
for example to issue follow-up configuration commands over the bus.

Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 drivers/espi/Kconfig      |   3 +
 drivers/espi/Makefile     |   2 +-
 drivers/espi/espi-slave.c | 177 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/espi/espi-slave.c

diff --git a/drivers/espi/Kconfig b/drivers/espi/Kconfig
index 4411d8336e82..7e609004967e 100644
--- a/drivers/espi/Kconfig
+++ b/drivers/espi/Kconfig
@@ -16,4 +16,7 @@ menuconfig ESPI
 	  over a shared physical link: Peripheral (I/O and memory), Virtual
 	  Wire, OOB (Out-of-Band) messaging, and Flash Access.
 
+	  Includes slave device registration and a blocking-notifier event
+	  chain for delivering hardware events to slave drivers.
+
 	  If unsure, say N.
diff --git a/drivers/espi/Makefile b/drivers/espi/Makefile
index 72712fcb0ada..48c2a591132f 100644
--- a/drivers/espi/Makefile
+++ b/drivers/espi/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-obj-$(CONFIG_ESPI)		+= espi-core.o
+obj-$(CONFIG_ESPI)		+= espi-core.o espi-slave.o
diff --git a/drivers/espi/espi-slave.c b/drivers/espi/espi-slave.c
new file mode 100644
index 000000000000..5d7f8c3c0d1f
--- /dev/null
+++ b/drivers/espi/espi-slave.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * eSPI slave-side device management and event notification
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/espi/espi.h>
+
+static void espi_device_release(struct device *dev)
+{
+	struct espi_device *edev = to_espi_device(dev);
+
+	fwnode_handle_put(dev_fwnode(dev));
+	kfree(edev);
+}
+
+static const struct device_type espi_device_type = {
+	.release = espi_device_release,
+};
+
+/**
+ * espi_new_device - instantiate a new eSPI slave device
+ * @ctrl: controller to which the device is attached
+ * @info: board-level description of the device
+ *
+ * Creates and registers a new &struct espi_device on @ctrl.  The device
+ * is named ``espi<bus>.<cs>`` and its modalias is set from
+ * @info->type.
+ *
+ * Return: pointer to the new device, or an ERR_PTR() on failure.
+ */
+struct espi_device *espi_new_device(struct espi_controller *ctrl,
+				    const struct espi_board_info *info)
+{
+	struct espi_device *edev;
+	int ret;
+
+	if (!ctrl || !info)
+		return ERR_PTR(-EINVAL);
+	if (ctrl->max_targets && info->cs >= ctrl->max_targets)
+		return ERR_PTR(-EINVAL);
+
+	edev = kzalloc_obj(*edev, GFP_KERNEL);
+	if (!edev)
+		return ERR_PTR(-ENOMEM);
+
+	edev->ctrl = ctrl;
+	edev->cs = info->cs;
+	edev->platform_data = info->platform_data;
+	strscpy(edev->modalias, info->type, sizeof(edev->modalias));
+	INIT_LIST_HEAD(&edev->list);
+
+	edev->dev.parent = &ctrl->dev;
+	edev->dev.bus = &espi_bus_type;
+	edev->dev.type = &espi_device_type;
+	device_set_node(&edev->dev, fwnode_handle_get(info->fwnode));
+
+	dev_set_name(&edev->dev, "espi%d.%u", ctrl->bus_num, info->cs);
+
+	/*
+	 * Add to the list before device_register() so the device is visible
+	 * to any controller-side iteration as soon as the uevent fires.
+	 */
+	mutex_lock(&ctrl->device_list_lock);
+	list_add_tail(&edev->list, &ctrl->device_list);
+	mutex_unlock(&ctrl->device_list_lock);
+
+	ret = device_register(&edev->dev);
+	if (ret) {
+		dev_err(&ctrl->dev, "failed to register device '%s': %d\n",
+			dev_name(&edev->dev), ret);
+		mutex_lock(&ctrl->device_list_lock);
+		list_del_init(&edev->list);
+		mutex_unlock(&ctrl->device_list_lock);
+		put_device(&edev->dev);
+		return ERR_PTR(ret);
+	}
+
+	return edev;
+}
+EXPORT_SYMBOL_GPL(espi_new_device);
+
+/**
+ * espi_remove_device - unregister and free an eSPI slave device
+ * @edev: device to remove
+ *
+ * Removes @edev from the controller's device list and unregisters it
+ * from the bus.  Must be called at most once per device.
+ */
+void espi_remove_device(struct espi_device *edev)
+{
+	struct espi_controller *ctrl;
+
+	if (!edev)
+		return;
+	ctrl = edev->ctrl;
+
+	mutex_lock(&ctrl->device_list_lock);
+	if (WARN_ON(list_empty(&edev->list))) {
+		mutex_unlock(&ctrl->device_list_lock);
+		return;
+	}
+	list_del_init(&edev->list);
+	mutex_unlock(&ctrl->device_list_lock);
+
+	device_unregister(&edev->dev);
+}
+EXPORT_SYMBOL_GPL(espi_remove_device);
+
+/**
+ * espi_register_notifier - subscribe to eSPI hardware events
+ * @ctrl: controller whose event chain to subscribe to
+ * @nb:   notifier block to register
+ *
+ * Notifier callbacks are invoked from process context (threaded IRQ or
+ * workqueue).  The @val argument passed to the callback is the
+ * &enum espi_event_type value; @data points to the &struct espi_event.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int espi_register_notifier(struct espi_controller *ctrl,
+			   struct notifier_block *nb)
+{
+	if (!ctrl || !nb)
+		return -EINVAL;
+	return blocking_notifier_chain_register(&ctrl->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(espi_register_notifier);
+
+/**
+ * espi_unregister_notifier - unsubscribe from eSPI hardware events
+ * @ctrl: controller whose event chain to unsubscribe from
+ * @nb:   notifier block to unregister
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int espi_unregister_notifier(struct espi_controller *ctrl,
+			     struct notifier_block *nb)
+{
+	if (!ctrl || !nb)
+		return -EINVAL;
+	return blocking_notifier_chain_unregister(&ctrl->notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(espi_unregister_notifier);
+
+/**
+ * espi_notify_event - deliver a hardware event to all registered listeners
+ * @ctrl:  controller on which the event occurred
+ * @event: event descriptor; @event->ctrl is set by this function
+ *
+ * Must be called from process context (threaded IRQ or workqueue), never
+ * from hard-IRQ context and never with @ctrl->lock held.
+ *
+ * Return: a NOTIFY_* value, not an errno.  Callers that need to map this
+ * to an errno should use notifier_to_errno().
+ */
+int espi_notify_event(struct espi_controller *ctrl, struct espi_event *event)
+{
+	if (!ctrl || !event)
+		return notifier_from_errno(-EINVAL);
+	event->ctrl = ctrl;
+	return blocking_notifier_call_chain(&ctrl->notifier_list,
+					    (unsigned long)event->type, event);
+}
+EXPORT_SYMBOL_GPL(espi_notify_event);
+
+MODULE_AUTHOR("Krishnamoorthi M <krishnamoorthi.m@amd.com>");
+MODULE_DESCRIPTION("eSPI slave-side device management");
+MODULE_LICENSE("GPL");
-- 
2.34.1

