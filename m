Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2A382F15;
	Tue,  4 Aug 2026 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844468; cv=fail; b=TlD0w1NSZuNidfVAf3o8QvzxS0mib92I7k1M+iNoig8qagZiUpPSScHLNqTQtq8PtDePSBqpuOsQb2duGEmQsqB/nkhOAbbzcZ/7rF4N6h3noMPBfoxKH004oEy7DqoIwBu2wgyN+Nppxnl+hFWgRz9CQ3wNODxIAPbS73cpr/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844468; c=relaxed/simple;
	bh=ncP2ZehdcOqVszJoioamoLWElFiVTUEF4SBL12pUyrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p75+GsQFAHPaMle2p5BqkpcMz5HzPGQ092v2rWY6dR9MVQQuIOAWGbathdId6GC1sFgfSZDZlFbs9Cwa+IZ5XRRkbmhJAe/hFydhCXFJ33qz3rAuORH3vLiPa7r4SUR6Ed3UZUs0RglXYwhiuqfuPTiDxz272rd0obZJEECnKPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svVvmWAt; arc=fail smtp.client-ip=40.107.209.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svVvmWAt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ5muNxWL7xOJa4MyRfim72TIWjDZH0Biyfc2eFcD7LDmS6Gj8EEOHlF0aU8+PwAknHBEeGBINTknr1xBfvAbTg8pcYCZ6XDtw8Q8gMW39w12Pc4HFT57E4faM3aPte8C3G1OGVzY6Z/r5Ouy+1JpLqdGR6ws3spuEa2wzTtM1nMOgab9qr/UehteBdsaXJFI7bsEoA+5475SDLEQEHfLQzuO7Pna31Bt7Jql1nq4hMnNODoPP5F4mR20R99JdrdNVZS/MW8CdqWdmH+IRRFS6dtyELaofWkKnSYSWM041khMrlgKJZYNOiNUS3+wTIY62tMobFHy1UKZ6dHXUvlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmoOwZromLXayU0K0V8rtpB/mCueeotKaoJj8v+d72U=;
 b=WE+pE0QwOfcjYrGWY/9YAMGlDZC6BkxhPO2kvoAtIP9NQuSusj9BxIDWykNWV1HCvQG2FyfMojx6SUDrX8vlZnn8HATCHd8jTuIEz81sLzRFmgCJGcIl+VTZA9Zw//W8DPVEwUfFJ3IgXzXDy7HOmdIzzSGh1RdOIJQ5qrDHmMT5TmjyRPs9+zt4Hkz2pPlSUchPSic+9CKz1ZHipbLF8/0isjOshWybkohL1AlYPf9ZdDFjf35SpKU9v93I4iEl/NXNBMhr4/BJ06TDc0TZGnlwvvqj6Vx28Ql42OCSQ6Mg1FAjD6HJK6wLSRKwlOT0Pt9Ryxtu7cqosDix98W/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmoOwZromLXayU0K0V8rtpB/mCueeotKaoJj8v+d72U=;
 b=svVvmWAtyevz417Im51/3HRyVHQLON7k7KQGYpPfEhoQ3gPMo00Xx4xqIZkCKhpAJVyPLloManAP+TKpHhJzDWMrbM8YZ9qjqWcD1tZbF//5V6+PutqsPECZDekWj9w40QOIgAhxeIhmNeVWwqyrBRG5oElqpoaaUOnaRDn+Cuk=
Received: from CH0PR03CA0270.namprd03.prod.outlook.com (2603:10b6:610:e5::35)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:54:19 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::a6) by CH0PR03CA0270.outlook.office365.com
 (2603:10b6:610:e5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 11:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:54:19 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:54:15 -0500
From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <akshata.mukundshetty@amd.com>,
	<bleung@chromium.org>, <groeck@chromium.org>,
	<chrome-platform@lists.linux.dev>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [RFC PATCH 1/4] espi: add core bus framework
Date: Tue, 4 Aug 2026 17:22:56 +0530
Message-ID: <20260804115259.4065638-2-krishnamoorthi.m@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6c3e2d-a77e-4ab7-2474-08def21f1e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BHFmnyjcJ5N9lgMxhQ+MV9/b1hipC0Sb7hhe/NZK+kDBDNJDzrKAWJC6g6LIXh8gOiCGBMaOzt+kP5eSs2r7vyDRYz/xO5cqVLy5iOxOcbEYfFpU9XHDijKONgYtmucuZmvft6ioVgE5lyeWnledIs1DD/uto+48s8E7YPPlVpG/+KI4Zu9a+rOYGJDNKQ8jXPH/AwyEnC2SIb9wyyMlNC+Y2q33E+EOY3OAEPl++/3aDWz77qzpn4iRdR94/RIaRrNetAqrUKU3gLepa/wafkaur1g6VjNzCgO8sSdX3L19K55bIoLL9wIaLbezHuGlG0Jz6mYL3pPGiVK84HxN+dq1F7DPRlmrKZ6jt6f3uESI3mm1r6qa+Hh0HviiwsF0Iv7NQQJQJEcAsyGR0zA5QS1z5/9tQYO31ldZ6WQCDrpuGi4cHS+/QjgKn0w48sT5IrJqVbKP1/639Gy8nc6qAssfYUQsMl0CQI3t8oK0kIdY6DOSfDxSD57pzVc9bg7/USRnYCfoE8k1Fyes+rWy6OUSahVHQdjFlbMllTC6J71Prg2cdcAaIry/CNRtmJZJgcgTJlYbrcuJruIz8yX0HnZDC8jRyRd4TkJZAfhpOaS4psRdRwPJBdBsjy7Yvvg2nT6t4+JwJeElsy5kuHQ/cJWf/7xFmbSateprSpH4S1aXPnnZia5CMYONQogDjYdTey99qlKWLpyOvVl8qD9EHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Im3700ocZI8rBzYCDRzY3eH22PqcuCF6Q7X+lA83yd60eP/M2+V9GvDk1V8QOiXNRgNAZu0z6UonlSFZd2o5/vSN230lBTNlG3PdDjgfGLJ6rDj03qzbW1S9Owq6jJWi5EOHNAU3SWtUJfHzNLNuJCjBjmWwKQsPn4jMKx6yAsMjJqB+nJLVIGkr0nKT+y0GZdoPXmg1MkzfjGY9Fb2zfcmKp9Qy8a+9AI3hqXQMTyQhjxIdOZPmxDnMYtN4w6f2hDtppRbBJflsgn0Aj/45JHZVPsqCK0koT4f9O0Ka2Ejo0kOShJtZYXdfxMY5TuWnnoRw3/VWvcfPe3pMrKa/5hnwdqUmEg3T4N/VktYod1DyD1OvKbU6e/y76LpcgJWBuWklTDQkBFKfPqsS2cJ6zDm3HeCevbTSYLlc9EuE33FE+bi7qabgP2SXeQN26YJm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:54:19.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6c3e2d-a77e-4ab7-2474-08def21f1e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

Add the core of a new Enhanced Serial Peripheral Interface (eSPI) bus
subsystem under drivers/espi/.

eSPI is a capability-negotiated, message-oriented link: the controller
and slave negotiate I/O mode, clock and channel support at runtime and
exchange packetised transactions over four logically independent channels
over a shared physical link (peripheral, virtual wire, out-of-band and
flash). This does not fit the synchronous, transfer-oriented SPI model,
so eSPI is modelled as its own bus type rather than an extension of SPI.

The core provides:
  - espi_bus_type, binding devices to drivers by ID table or ACPI match
    and emitting a MODALIAS uevent;
  - controller lifecycle helpers, with each controller registered as a
    device and assigned a bus number from an allocating XArray;
  - read-only sysfs attributes for the controller capabilities;
  - a channel API that serialises access with ctrl->lock, dispatches to
    the controller ops, and returns -EOPNOTSUPP for unimplemented ops.

Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
---
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   1 +
 drivers/espi/Kconfig      |  19 ++
 drivers/espi/Makefile     |   2 +
 drivers/espi/espi-core.c  | 493 ++++++++++++++++++++++++++++++++++++++
 include/linux/espi/espi.h | 345 ++++++++++++++++++++++++++
 6 files changed, 862 insertions(+)
 create mode 100644 drivers/espi/Kconfig
 create mode 100644 drivers/espi/Makefile
 create mode 100644 drivers/espi/espi-core.c
 create mode 100644 include/linux/espi/espi.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index f2bed2ddeb66..d7661432ce7c 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -73,6 +73,8 @@ source "drivers/i3c/Kconfig"
 
 source "drivers/spi/Kconfig"
 
+source "drivers/espi/Kconfig"
+
 source "drivers/spmi/Kconfig"
 
 source "drivers/hsi/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0841ea851847..ff3d42dd14ba 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_ATA)		+= ata/
 obj-$(CONFIG_TARGET_CORE)	+= target/
 obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_SPI)		+= spi/
+obj-$(CONFIG_ESPI)		+= espi/
 obj-$(CONFIG_SPMI)		+= spmi/
 obj-$(CONFIG_HSI)		+= hsi/
 obj-$(CONFIG_SLIMBUS)		+= slimbus/
diff --git a/drivers/espi/Kconfig b/drivers/espi/Kconfig
new file mode 100644
index 000000000000..4411d8336e82
--- /dev/null
+++ b/drivers/espi/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# eSPI (Enhanced Serial Peripheral Interface) bus configuration
+#
+
+menuconfig ESPI
+	bool "eSPI (Enhanced Serial Peripheral Interface) bus support"
+	help
+	  Enhanced Serial Peripheral Interface (eSPI) bus framework.
+
+	  eSPI is a serial bus specification by Intel that replaces the
+	  legacy Low Pin Count (LPC) bus. It connects a host controller to
+	  one or more slave devices (for example an EC or BMC) over a
+	  low-pin-count link clocked up to 66 MHz with single, dual or quad
+	  I/O, and carries traffic on four logically independent channels
+	  over a shared physical link: Peripheral (I/O and memory), Virtual
+	  Wire, OOB (Out-of-Band) messaging, and Flash Access.
+
+	  If unsure, say N.
diff --git a/drivers/espi/Makefile b/drivers/espi/Makefile
new file mode 100644
index 000000000000..72712fcb0ada
--- /dev/null
+++ b/drivers/espi/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+obj-$(CONFIG_ESPI)		+= espi-core.o
diff --git a/drivers/espi/espi-core.c b/drivers/espi/espi-core.c
new file mode 100644
index 000000000000..35481f1c1858
--- /dev/null
+++ b/drivers/espi/espi-core.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * eSPI (Enhanced Serial Peripheral Interface) core framework
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)	"espi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/xarray.h>
+#include <linux/espi/espi.h>
+
+static DEFINE_XARRAY_ALLOC(espi_controllers);
+
+static int espi_bus_match(struct device *dev, const struct device_driver *drv)
+{
+	const struct espi_device *edev = to_espi_device(dev);
+	const struct espi_driver *edrv = to_espi_driver(drv);
+
+	if (edrv->id_table) {
+		const struct espi_device_id *id = edrv->id_table;
+
+		while (id->name[0]) {
+			if (!strcmp(edev->modalias, id->name))
+				return 1;
+			id++;
+		}
+	}
+	if (acpi_driver_match_device(dev, drv))
+		return 1;
+
+	return 0;
+}
+
+static int espi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct espi_device *edev = to_espi_device(dev);
+
+	return add_uevent_var(env, "MODALIAS=espi:%s", edev->modalias);
+}
+
+static int espi_bus_probe(struct device *dev)
+{
+	const struct espi_driver *edrv = to_espi_driver(dev->driver);
+	struct espi_device *edev = to_espi_device(dev);
+
+	if (edrv->probe)
+		return edrv->probe(edev);
+	return 0;
+}
+
+static void espi_bus_remove(struct device *dev)
+{
+	const struct espi_driver *edrv = to_espi_driver(dev->driver);
+	struct espi_device *edev = to_espi_device(dev);
+
+	if (edrv->remove)
+		edrv->remove(edev);
+}
+
+const struct bus_type espi_bus_type = {
+	.name	= "espi",
+	.match	= espi_bus_match,
+	.uevent	= espi_bus_uevent,
+	.probe	= espi_bus_probe,
+	.remove	= espi_bus_remove,
+};
+EXPORT_SYMBOL_GPL(espi_bus_type);
+
+static ssize_t supported_channels_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct espi_controller *ctrl = to_espi_controller(dev);
+
+	return sysfs_emit(buf, "0x%02x\n", ctrl->caps.supported_channels);
+}
+static DEVICE_ATTR_RO(supported_channels);
+
+static ssize_t max_freq_mhz_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct espi_controller *ctrl = to_espi_controller(dev);
+
+	return sysfs_emit(buf, "%u\n", ctrl->caps.max_freq_mhz);
+}
+static DEVICE_ATTR_RO(max_freq_mhz);
+
+static ssize_t io_mode_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct espi_controller *ctrl = to_espi_controller(dev);
+	static const char * const modes[] = { "single", "dual", "quad" };
+	u8 m = ctrl->caps.io_mode;
+
+	if (WARN_ON_ONCE(m > ESPI_IO_MODE_QUAD))
+		return sysfs_emit(buf, "unknown\n");
+	return sysfs_emit(buf, "%s\n", modes[m]);
+}
+static DEVICE_ATTR_RO(io_mode);
+
+static ssize_t channel_enabled_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct espi_controller *ctrl = to_espi_controller(dev);
+
+	return sysfs_emit(buf, "0x%02x\n", READ_ONCE(ctrl->channel_enabled));
+}
+static DEVICE_ATTR_RO(channel_enabled);
+
+static struct attribute *espi_controller_attrs[] = {
+	&dev_attr_supported_channels.attr,
+	&dev_attr_max_freq_mhz.attr,
+	&dev_attr_io_mode.attr,
+	&dev_attr_channel_enabled.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(espi_controller);
+
+static void espi_controller_release(struct device *dev)
+{
+	struct espi_controller *ctrl = to_espi_controller(dev);
+
+	mutex_destroy(&ctrl->lock);
+	mutex_destroy(&ctrl->device_list_lock);
+	kfree(ctrl);
+}
+
+static const struct device_type espi_controller_type = {
+	.groups	 = espi_controller_groups,
+	.release = espi_controller_release,
+};
+
+struct espi_controller *espi_controller_alloc(struct device *parent,
+					      unsigned int size)
+{
+	struct espi_controller *ctrl;
+
+	if (!parent)
+		return ERR_PTR(-EINVAL);
+
+	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	device_initialize(&ctrl->dev);
+	ctrl->dev.parent = parent;
+	ctrl->dev.type = &espi_controller_type;
+
+	mutex_init(&ctrl->lock);
+	INIT_LIST_HEAD(&ctrl->device_list);
+	mutex_init(&ctrl->device_list_lock);
+	BLOCKING_INIT_NOTIFIER_HEAD(&ctrl->notifier_list);
+
+	if (size)
+		espi_controller_set_devdata(ctrl, (void *)ctrl + sizeof(*ctrl));
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(espi_controller_alloc);
+
+int espi_controller_register(struct espi_controller *ctrl)
+{
+	int ret;
+	u32 id;
+
+	if (!ctrl || !ctrl->ops)
+		return -EINVAL;
+
+	ret = xa_alloc(&espi_controllers, &id, ctrl, xa_limit_31b,
+		       GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ctrl->bus_num = id;
+	ret = dev_set_name(&ctrl->dev, "espi%d", ctrl->bus_num);
+	if (ret)
+		goto err_erase;
+
+	if (ctrl->ops->setup) {
+		ret = ctrl->ops->setup(ctrl);
+		if (ret) {
+			dev_err(&ctrl->dev, "controller setup failed: %d\n", ret);
+			goto err_erase;
+		}
+	}
+
+	ret = device_add(&ctrl->dev);
+	if (ret) {
+		dev_err(&ctrl->dev, "device_add failed: %d\n", ret);
+		if (ctrl->ops->cleanup)
+			ctrl->ops->cleanup(ctrl);
+		goto err_erase;
+	}
+
+	dev_info(&ctrl->dev, "registered: channels=0x%02x freq=%uMHz\n",
+		 ctrl->caps.supported_channels, ctrl->caps.max_freq_mhz);
+	return 0;
+
+err_erase:
+	xa_erase(&espi_controllers, ctrl->bus_num);
+	ctrl->bus_num = -1;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(espi_controller_register);
+
+void espi_controller_unregister(struct espi_controller *ctrl)
+{
+	if (!ctrl)
+		return;
+	/*
+	 * Remove from the lookup table before dropping the device reference,
+	 * so a concurrent espi_controller_get_by_bus_num() can never take a
+	 * reference on a controller that is going away.
+	 */
+	xa_erase(&espi_controllers, ctrl->bus_num);
+	if (ctrl->ops && ctrl->ops->cleanup)
+		ctrl->ops->cleanup(ctrl);
+	device_unregister(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(espi_controller_unregister);
+
+void espi_controller_put(struct espi_controller *ctrl)
+{
+	if (ctrl)
+		put_device(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(espi_controller_put);
+
+struct espi_controller *espi_controller_get_by_bus_num(int bus_num)
+{
+	struct espi_controller *ctrl;
+
+	guard(spinlock)(&espi_controllers.xa_lock);
+	ctrl = xa_load(&espi_controllers, bus_num);
+	if (ctrl)
+		get_device(&ctrl->dev);
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(espi_controller_get_by_bus_num);
+
+int espi_get_capabilities(struct espi_controller *ctrl,
+			  struct espi_capabilities *caps)
+{
+	if (!ctrl || !caps)
+		return -EINVAL;
+	guard(mutex)(&ctrl->lock);
+	*caps = ctrl->caps;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(espi_get_capabilities);
+
+bool espi_channel_is_enabled(struct espi_controller *ctrl, u8 channel)
+{
+	if (!ctrl || channel >= ESPI_CHANNEL_COUNT)
+		return false;
+	guard(mutex)(&ctrl->lock);
+	return !!(ctrl->channel_enabled & BIT(channel));
+}
+EXPORT_SYMBOL_GPL(espi_channel_is_enabled);
+
+int espi_get_configuration(struct espi_controller *ctrl,
+			   u32 slave_reg_addr, u32 *config)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->get_configuration)
+		return -EOPNOTSUPP;
+	if (!config)
+		return -EINVAL;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->get_configuration(ctrl, slave_reg_addr, config);
+}
+EXPORT_SYMBOL_GPL(espi_get_configuration);
+
+int espi_set_configuration(struct espi_controller *ctrl,
+			   u32 slave_reg_addr, u32 config)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->set_configuration)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->set_configuration(ctrl, slave_reg_addr, config);
+}
+EXPORT_SYMBOL_GPL(espi_set_configuration);
+
+int espi_inband_reset(struct espi_controller *ctrl)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->inband_reset)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->inband_reset(ctrl);
+}
+EXPORT_SYMBOL_GPL(espi_inband_reset);
+
+int espi_get_status(struct espi_controller *ctrl,
+		    struct espi_slave_status *status)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->get_status)
+		return -EOPNOTSUPP;
+	if (!status)
+		return -EINVAL;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->get_status(ctrl, status);
+}
+EXPORT_SYMBOL_GPL(espi_get_status);
+
+int espi_enable_channel(struct espi_controller *ctrl, u8 channel)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->ops || !ctrl->ops->enable_channel)
+		return -EOPNOTSUPP;
+	if (channel >= ESPI_CHANNEL_COUNT)
+		return -EINVAL;
+	guard(mutex)(&ctrl->lock);
+	ret = ctrl->ops->enable_channel(ctrl, channel);
+	if (!ret)
+		ctrl->channel_enabled |= BIT(channel);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(espi_enable_channel);
+
+int espi_disable_channel(struct espi_controller *ctrl, u8 channel)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->ops || !ctrl->ops->disable_channel)
+		return -EOPNOTSUPP;
+	if (channel >= ESPI_CHANNEL_COUNT)
+		return -EINVAL;
+	guard(mutex)(&ctrl->lock);
+	ret = ctrl->ops->disable_channel(ctrl, channel);
+	if (!ret)
+		ctrl->channel_enabled &= ~BIT(channel);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(espi_disable_channel);
+
+int espi_periph_io_read(struct espi_controller *ctrl,
+			u16 port, u8 width, u32 *value)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_io_read)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->periph_io_read(ctrl, port, width, value);
+}
+EXPORT_SYMBOL_GPL(espi_periph_io_read);
+
+int espi_periph_io_write(struct espi_controller *ctrl,
+			 u16 port, u8 width, u32 value)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_io_write)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->periph_io_write(ctrl, port, width, value);
+}
+EXPORT_SYMBOL_GPL(espi_periph_io_write);
+
+int espi_periph_mem_read(struct espi_controller *ctrl,
+			 u32 addr, void *buf, size_t len)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_mem_read)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->periph_mem_read(ctrl, addr, buf, len);
+}
+EXPORT_SYMBOL_GPL(espi_periph_mem_read);
+
+int espi_periph_mem_write(struct espi_controller *ctrl,
+			  u32 addr, const void *buf, size_t len)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_mem_write)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->periph_mem_write(ctrl, addr, buf, len);
+}
+EXPORT_SYMBOL_GPL(espi_periph_mem_write);
+
+int espi_vwire_get(struct espi_controller *ctrl, u8 index, u8 *value, u8 *valid)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->vwire_get)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->vwire_get(ctrl, index, value, valid);
+}
+EXPORT_SYMBOL_GPL(espi_vwire_get);
+
+int espi_vwire_put(struct espi_controller *ctrl, u8 index, u8 value, u8 valid)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->vwire_put)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->vwire_put(ctrl, index, value, valid);
+}
+EXPORT_SYMBOL_GPL(espi_vwire_put);
+
+int espi_oob_send(struct espi_controller *ctrl, const void *buf, size_t len, u8 tag)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->oob_send)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->oob_send(ctrl, buf, len, tag);
+}
+EXPORT_SYMBOL_GPL(espi_oob_send);
+
+int espi_oob_recv(struct espi_controller *ctrl, void *buf, size_t *len, u8 *tag)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->oob_recv)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->oob_recv(ctrl, buf, len, tag);
+}
+EXPORT_SYMBOL_GPL(espi_oob_recv);
+
+int espi_flash_read(struct espi_controller *ctrl, u32 offset, void *buf, size_t len)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_read)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->flash_read(ctrl, offset, buf, len);
+}
+EXPORT_SYMBOL_GPL(espi_flash_read);
+
+int espi_flash_write(struct espi_controller *ctrl, u32 offset, const void *buf, size_t len)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_write)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->flash_write(ctrl, offset, buf, len);
+}
+EXPORT_SYMBOL_GPL(espi_flash_write);
+
+int espi_flash_erase(struct espi_controller *ctrl, u32 offset, size_t len)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_erase)
+		return -EOPNOTSUPP;
+	guard(mutex)(&ctrl->lock);
+	return ctrl->ops->flash_erase(ctrl, offset, len);
+}
+EXPORT_SYMBOL_GPL(espi_flash_erase);
+
+/*
+ * espi_handle_alert - dispatch a hardware alert to the controller
+ *
+ * Must be called from process context (threaded IRQ or workqueue).
+ *
+ * ctrl->lock is NOT held across ops->handle_alert so that the driver
+ * callback can call espi_notify_event() without deadlocking: notifier
+ * callbacks may in turn call channel APIs that also acquire ctrl->lock.
+ * The driver is responsible for taking ctrl->lock around any register
+ * accesses that need serialisation with the channel API.
+ */
+int espi_handle_alert(struct espi_controller *ctrl)
+{
+	if (!ctrl || !ctrl->ops || !ctrl->ops->handle_alert)
+		return -EOPNOTSUPP;
+	return ctrl->ops->handle_alert(ctrl);
+}
+EXPORT_SYMBOL_GPL(espi_handle_alert);
+
+int __espi_register_driver(struct module *owner, struct espi_driver *drv)
+{
+	drv->driver.owner = owner;
+	drv->driver.bus = &espi_bus_type;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__espi_register_driver);
+
+void espi_unregister_driver(struct espi_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(espi_unregister_driver);
+
+static int __init espi_init(void)
+{
+	int ret = bus_register(&espi_bus_type);
+
+	if (ret)
+		pr_err("failed to register eSPI bus: %d\n", ret);
+	return ret;
+}
+postcore_initcall(espi_init);
+
+MODULE_AUTHOR("Krishnamoorthi M <krishnamoorthi.m@amd.com>");
+MODULE_DESCRIPTION("eSPI core framework");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/espi/espi.h b/include/linux/espi/espi.h
new file mode 100644
index 000000000000..a191ddc10cdd
--- /dev/null
+++ b/include/linux/espi/espi.h
@@ -0,0 +1,345 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * eSPI (Enhanced Serial Peripheral Interface) framework
+ *
+ * Copyright (c) 2026, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ */
+#ifndef _LINUX_ESPI_ESPI_H
+#define _LINUX_ESPI_ESPI_H
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
+
+struct espi_controller;
+struct espi_device;
+struct espi_driver;
+struct espi_board_info;
+
+#define ESPI_NAME_SIZE			32
+
+#define ESPI_CHANNEL_PERIPH		0
+#define ESPI_CHANNEL_VWIRE		1
+#define ESPI_CHANNEL_OOB		2
+#define ESPI_CHANNEL_FLASH		3
+#define ESPI_CHANNEL_COUNT		4
+
+#define ESPI_CHANNEL_PERIPH_SUPP	BIT(ESPI_CHANNEL_PERIPH)
+#define ESPI_CHANNEL_VWIRE_SUPP		BIT(ESPI_CHANNEL_VWIRE)
+#define ESPI_CHANNEL_OOB_SUPP		BIT(ESPI_CHANNEL_OOB)
+#define ESPI_CHANNEL_FLASH_SUPP		BIT(ESPI_CHANNEL_FLASH)
+#define ESPI_CHANNEL_ALL		(ESPI_CHANNEL_PERIPH_SUPP | \
+					 ESPI_CHANNEL_VWIRE_SUPP | \
+					 ESPI_CHANNEL_OOB_SUPP | \
+					 ESPI_CHANNEL_FLASH_SUPP)
+
+#define ESPI_IO_MODE_SINGLE		0
+#define ESPI_IO_MODE_DUAL		1
+#define ESPI_IO_MODE_QUAD		2
+
+#define ESPI_FREQ_16MHZ			16
+#define ESPI_FREQ_33MHZ			33
+#define ESPI_FREQ_66MHZ			66
+
+enum espi_cmd_type {
+	ESPI_CMD_SET_CONFIGURATION	= 0,
+	ESPI_CMD_GET_CONFIGURATION	= 1,
+	ESPI_CMD_IN_BAND_RESET		= 2,
+	ESPI_CMD_GET_STATUS		= 3,
+	ESPI_CMD_PERIPHERAL		= 4,
+	ESPI_CMD_VWIRE			= 5,
+	ESPI_CMD_OOB			= 6,
+	ESPI_CMD_FLASH			= 7,
+};
+
+#define ESPI_SLAVE_REG_DEVICE_ID	0x0004
+#define ESPI_SLAVE_REG_GENERAL_CFG	0x0008
+
+/* General Configuration register (0x08) field definitions. */
+#define ESPI_GENCFG_OP_FREQ		GENMASK(22, 20)
+#define ESPI_GENCFG_IO_MODE		GENMASK(27, 26)
+#define ESPI_GENCFG_ALERT_MODE		BIT(28)
+#define ESPI_GENCFG_CRC_EN		BIT(31)
+/* ESPI_GENCFG_OP_FREQ values */
+#define ESPI_GENCFG_FREQ_20MHZ		0x0
+#define ESPI_GENCFG_FREQ_33MHZ		0x2
+#define ESPI_GENCFG_FREQ_66MHZ		0x4
+
+/* Channel-specific capability/configuration register addresses */
+#define ESPI_SLAVE_REG_PERIPH_CFG	0x0010
+#define ESPI_SLAVE_REG_VWIRE_CFG	0x0020
+#define ESPI_SLAVE_REG_OOB_CFG		0x0030
+#define ESPI_SLAVE_REG_FLASH_CFG	0x0040
+
+struct espi_slave_status {
+	bool pc_free;
+	bool np_free;
+	bool vwire_free;
+	bool oob_free;
+	bool flash_free;
+	u16 raw;
+};
+
+struct espi_device_id {
+	char name[ESPI_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
+enum espi_event_type {
+	ESPI_EVENT_CHANNEL_READY	= 0,
+	ESPI_EVENT_CHANNEL_RESET	= 1,
+	ESPI_EVENT_VWIRE_CHANGED	= 2,
+	ESPI_EVENT_OOB_RECEIVED		= 3,
+	ESPI_EVENT_PERIPH_POSTED	= 4,
+	ESPI_EVENT_ALERT		= 5,
+	ESPI_EVENT_RESET		= 6,
+};
+
+struct espi_event {
+	enum espi_event_type type;
+	int channel;
+	u32 details;
+	struct espi_controller *ctrl;
+};
+
+struct espi_board_info {
+	char type[ESPI_NAME_SIZE];
+	u8 cs;
+	void *platform_data;
+	struct fwnode_handle *fwnode;
+};
+
+struct espi_capabilities {
+	u32 supported_channels;
+	u32 max_freq_mhz;
+	u8 io_mode;
+	bool alert_mode;
+	bool crc_supported;
+	u16 periph_max_payload;
+	u8 vwire_max_count;
+	u16 oob_max_payload;
+	u16 flash_max_payload;
+};
+
+/**
+ * struct espi_controller_ops - hardware operation callbacks
+ *
+ * All callbacks are optional and return 0 or a negative errno. The core
+ * returns -EOPNOTSUPP for operations a controller does not provide.
+ */
+struct espi_controller_ops {
+	int (*setup)(struct espi_controller *ctrl);
+	void (*cleanup)(struct espi_controller *ctrl);
+
+	int (*get_configuration)(struct espi_controller *ctrl,
+				 u32 slave_reg_addr, u32 *config);
+	int (*set_configuration)(struct espi_controller *ctrl,
+				 u32 slave_reg_addr, u32 config);
+	int (*inband_reset)(struct espi_controller *ctrl);
+	int (*get_status)(struct espi_controller *ctrl,
+			  struct espi_slave_status *status);
+
+	int (*enable_channel)(struct espi_controller *ctrl, u8 channel);
+	int (*disable_channel)(struct espi_controller *ctrl, u8 channel);
+
+	int (*periph_io_read)(struct espi_controller *ctrl,
+			      u16 port, u8 width, u32 *value);
+	int (*periph_io_write)(struct espi_controller *ctrl,
+			       u16 port, u8 width, u32 value);
+	int (*periph_mem_read)(struct espi_controller *ctrl,
+			       u32 addr, void *buf, size_t len);
+	int (*periph_mem_write)(struct espi_controller *ctrl,
+				u32 addr, const void *buf, size_t len);
+
+	int (*vwire_get)(struct espi_controller *ctrl,
+			 u8 index, u8 *value, u8 *valid);
+	int (*vwire_put)(struct espi_controller *ctrl,
+			 u8 index, u8 value, u8 valid);
+
+	int (*oob_send)(struct espi_controller *ctrl,
+			const void *buf, size_t len, u8 tag);
+	int (*oob_recv)(struct espi_controller *ctrl,
+			void *buf, size_t *len, u8 *tag);
+
+	int (*flash_read)(struct espi_controller *ctrl,
+			  u32 offset, void *buf, size_t len);
+	int (*flash_write)(struct espi_controller *ctrl,
+			   u32 offset, const void *buf, size_t len);
+	int (*flash_erase)(struct espi_controller *ctrl,
+			   u32 offset, size_t len);
+
+	int (*handle_alert)(struct espi_controller *ctrl);
+};
+
+struct espi_controller {
+	struct device dev;
+	int bus_num;
+	u8 max_targets;		/* number of Chip Select# pins supported */
+
+	const struct espi_controller_ops *ops;
+	struct espi_capabilities caps;
+
+	struct mutex lock;	/* serialises controller ops and @channel_enabled */
+	u32 channel_enabled;
+
+	struct list_head device_list;
+	struct mutex device_list_lock;	/* protects @device_list */
+
+	struct blocking_notifier_head notifier_list;
+};
+
+#define to_espi_controller(d)	container_of(d, struct espi_controller, dev)
+
+struct espi_device {
+	struct device dev;
+	struct espi_controller *ctrl;
+	u8 cs;
+	char modalias[ESPI_NAME_SIZE];
+	void *platform_data;
+	struct list_head list;
+};
+
+#define to_espi_device(d)	container_of(d, struct espi_device, dev)
+
+struct espi_driver {
+	struct device_driver driver;
+	int (*probe)(struct espi_device *edev);
+	void (*remove)(struct espi_device *edev);
+	const struct espi_device_id *id_table;
+};
+
+#define to_espi_driver(d)	container_of_const(d, struct espi_driver, driver)
+
+extern const struct bus_type espi_bus_type;
+
+struct espi_controller *espi_controller_alloc(struct device *parent,
+					      unsigned int size);
+int espi_controller_register(struct espi_controller *ctrl);
+void espi_controller_unregister(struct espi_controller *ctrl);
+void espi_controller_put(struct espi_controller *ctrl);
+struct espi_controller *espi_controller_get_by_bus_num(int bus_num);
+
+static inline void *espi_controller_get_devdata(struct espi_controller *ctrl)
+{
+	return dev_get_drvdata(&ctrl->dev);
+}
+
+static inline void espi_controller_set_devdata(struct espi_controller *ctrl,
+					       void *data)
+{
+	dev_set_drvdata(&ctrl->dev, data);
+}
+
+int espi_get_capabilities(struct espi_controller *ctrl,
+			  struct espi_capabilities *caps);
+bool espi_channel_is_enabled(struct espi_controller *ctrl, u8 channel);
+
+int espi_get_configuration(struct espi_controller *ctrl,
+			   u32 slave_reg_addr, u32 *config);
+int espi_set_configuration(struct espi_controller *ctrl,
+			   u32 slave_reg_addr, u32 config);
+int espi_inband_reset(struct espi_controller *ctrl);
+int espi_get_status(struct espi_controller *ctrl,
+		    struct espi_slave_status *status);
+
+int espi_enable_channel(struct espi_controller *ctrl, u8 channel);
+int espi_disable_channel(struct espi_controller *ctrl, u8 channel);
+
+/**
+ * espi_periph_io_read - issue a Peripheral Channel I/O read cycle
+ * @ctrl:  controller
+ * @port:  16-bit I/O port address
+ * @width: access width in bytes (1, 2, or 4)
+ * @value: receives the read value
+ */
+int espi_periph_io_read(struct espi_controller *ctrl,
+			u16 port, u8 width, u32 *value);
+/**
+ * espi_periph_io_write - issue a Peripheral Channel I/O write cycle
+ * @ctrl:  controller
+ * @port:  16-bit I/O port address
+ * @width: access width in bytes (1, 2, or 4)
+ * @value: value to write
+ */
+int espi_periph_io_write(struct espi_controller *ctrl,
+			 u16 port, u8 width, u32 value);
+int espi_periph_mem_read(struct espi_controller *ctrl,
+			 u32 addr, void *buf, size_t len);
+int espi_periph_mem_write(struct espi_controller *ctrl,
+			  u32 addr, const void *buf, size_t len);
+
+int espi_vwire_get(struct espi_controller *ctrl,
+		   u8 index, u8 *value, u8 *valid);
+/**
+ * espi_vwire_put - send a PUT_VIRTUAL_WIRE command
+ * @ctrl:  controller
+ * @index: VWire group index
+ * @value: wire value byte
+ * @valid: valid mask byte
+ */
+int espi_vwire_put(struct espi_controller *ctrl,
+		   u8 index, u8 value, u8 valid);
+
+int espi_oob_send(struct espi_controller *ctrl,
+		  const void *buf, size_t len, u8 tag);
+int espi_oob_recv(struct espi_controller *ctrl,
+		  void *buf, size_t *len, u8 *tag);
+
+int espi_flash_read(struct espi_controller *ctrl,
+		    u32 offset, void *buf, size_t len);
+int espi_flash_write(struct espi_controller *ctrl,
+		     u32 offset, const void *buf, size_t len);
+int espi_flash_erase(struct espi_controller *ctrl,
+		     u32 offset, size_t len);
+
+int espi_handle_alert(struct espi_controller *ctrl);
+
+struct espi_device *espi_new_device(struct espi_controller *ctrl,
+				    const struct espi_board_info *info);
+void espi_remove_device(struct espi_device *edev);
+
+int espi_register_notifier(struct espi_controller *ctrl,
+			   struct notifier_block *nb);
+int espi_unregister_notifier(struct espi_controller *ctrl,
+			     struct notifier_block *nb);
+int espi_notify_event(struct espi_controller *ctrl,
+		      struct espi_event *event);
+
+static inline int espi_dev_get_configuration(struct espi_device *edev,
+					     u32 addr, u32 *config)
+{
+	return espi_get_configuration(edev->ctrl, addr, config);
+}
+
+static inline int espi_dev_set_configuration(struct espi_device *edev,
+					     u32 addr, u32 config)
+{
+	return espi_set_configuration(edev->ctrl, addr, config);
+}
+
+static inline int espi_dev_inband_reset(struct espi_device *edev)
+{
+	return espi_inband_reset(edev->ctrl);
+}
+
+static inline int espi_dev_get_status(struct espi_device *edev,
+				      struct espi_slave_status *status)
+{
+	return espi_get_status(edev->ctrl, status);
+}
+
+int __espi_register_driver(struct module *owner, struct espi_driver *drv);
+void espi_unregister_driver(struct espi_driver *drv);
+
+#define espi_register_driver(drv) \
+	__espi_register_driver(THIS_MODULE, drv)
+
+#define module_espi_driver(__espi_driver) \
+	module_driver(__espi_driver, espi_register_driver, espi_unregister_driver)
+
+#endif /* _LINUX_ESPI_ESPI_H */
-- 
2.34.1

