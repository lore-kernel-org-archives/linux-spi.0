Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F72D8DB5;
	Mon,  4 May 2026 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880463; cv=fail; b=PomEpuOpr2CXD/pB3ah7/pLKG/5mNvcZDYONcxvagvqHfiUdbgssIprUp3HNKN2KVTBies3dwUClyCSjOpjWg5kc0tTZEIVg4EXBGoPF4Z/Ov3ZeuruSwVuSuS0jS4HICuFGF6D0pxgI4YGU5M497mrqvxyzWk6zlqC2vthVIg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880463; c=relaxed/simple;
	bh=sdiREhclqMF7AlcNYB1beDkI7LtYYVXReEF9OLy4Gzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udjL205TDiKp9zMFWWC2WV53K6buRzmBezwkgcss8jRKvkJSxq8/wdKRRefBC6EBsXr3hLxpEd+DD+98ay365Z8LVQaiK79VY9/AtVbABI9su8/JH2tiSUadCuYGIwt5j+vZDiJ4+Va3pdbRe5+q0Hecg+azmSJ3qXGfxZfGCLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDBeU5E7; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDBeU5E7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUXWQY1inDwNBhP/VjioWnamZp4rMFarhqd8vSA4uHuKnTsroQ5bL36CxoPZc3na96xZlf9qDGoUSxnprciuJojMRmn2wwKiaCaUDg/C5x5AHzlliuWojW0wi1y72aUkI8xEc6AGwkyo/uLWyc/ifLv04mBSeme9+P/UsRuuu1tvZ3sHak7Np4xuoMg8oK6rHUX9TXwTiNGfA8ydb+v7KrstKmIUfgkwWi+11S8S1wZVDInKmP8VD709R8bqhPAKsxKkGLLEE5kKdpUOIFW64xHocHBqB0KmBZt0AJjjhY3Hu7zMXSluktYhM1beoI6cQsSN1lcR4XETQmu7Y3pzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60CQT4INlHwHLi+g2FfThFCDvKoA7p61eaazdN8U+R0=;
 b=XHhBnuOZcg0T+eK6XtTyTrU6HLFEQ5jOnfC4tNXb0LMDAp3lYzn4FFwhaEMyz+3pWs4SbaMEz6GXreKeSF91eDW2yyQgiB8ru/q6yjEJBda45kFnRKfqImnSjqmfNBbZtbpXdzQT9Tiw+aH2wq5PWIkvOEMzgF+s4oivyXg4IUA01bdOPCF0W7DK1Jpk107hkBWk+NzH0z8woZt4C49Q5zt51gT+a3ou4Nv6FOmp+tJ12j1Mt+KVZ9I/aGyI24hov3jx8om1sRC35vuNMFP8euCx3UO4wdIw434eX5wVd+AuX5v9HnZ90D+d4THIMyX76KFbFwnSu50Cqfb5wYydrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60CQT4INlHwHLi+g2FfThFCDvKoA7p61eaazdN8U+R0=;
 b=TDBeU5E7zbQDAV4KCgT57Kpo1uFFewSwrXlcDjVTSf5nPhmMY4gXkUQrN+DK4neD9XV7n43TkP4SSFjJEzLGttxhBpsuDjPlRkSYALAT7ashun7Gbehkp5Ow3aq4VK0LuQA3CWD7xJTPJho3b+QpBUC27OQ9WteJLrqOWEHwsPfvWby5b/pi9aIKeS21Tqs8GJQlq6QE6RM+EoGOzIzf2yVS9rJbQflRdGGu3AF7TF0g5BDNpwzuow94uP7WTpt1CcumyTm5koXicxIgaX2EHV9uZ8ZQnKij/SxbWllWviLSj8PuQl+BHwYbN2biR91DwWQiJPlWwv4f3vQ6TDUghw==
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:40:54 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::98) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 07:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 07:40:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 00:40:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 00:40:38 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 4 May 2026 00:40:38 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v3 1/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 4 May 2026 07:40:36 +0000
Message-ID: <20260504074037.704833-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260504074037.704833-1-va@nvidia.com>
References: <20260504074037.704833-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: f55899c5-5f9f-403b-1080-08dea9b07967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|30052699003|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UeLrtkffDb9SJVB47mZxX6LkayVpxfCjdCOfEiqtFNK0sHFdd+44HbI0JYyaolNOwvHl1atOKlGA+7mYXOrHtEE2etEmi+vKyY6gnq95A6nwafGjUZ1O/+EAr0sBJa3sKs7RG8+jnTTWGsw14ci3fFTfDrvcA4/i689VxO3DVfllt7l7w8LntiIMphplnFC50UKZZ6upUn0cHOUhZtI6Drywc3nhQjl8tU4FKYO69CZ5LTkG+8UXwy9Glh5b/1Xw1f1tfiCBi8E31ECd39fHgDUImsQE/scwgHPcyPjcA3qSY+qUcSXcEf490PDOHfmOGHG6A/FWbFvVa0TLzGlePtqgdljya/z3PwgB52MnIm4Abdv0uGVSAHU9UHx9OmRydRBbLe+K3UgXlISm142ryPOhkb9eoj8AQwKeCx4FkAdQv50lHzt35mwRkRiYJ2XgRjNgJh9tW5b6v6at6+afbqUeDXrgqun/I2LkDxjvAe9VXiy2R88cKK6lkRzPWeVZ7+EhXgUA8EUPdN8KdGMV6Ecm29LeDyPN4Ec2Id7MFiYGCEAORSITj9tGAFmEe3Xr3Mnfbb2/HxVzpNsr0t6wqntUU3GVvCMSndZWcb7BrsWqwuZjvxXb2Z5V9mCE01qnJgt/whKmDmfkz/F9XTpEuf/npN5lJgdagSHTDpYPXjQU1CQ+wqCikKNFjHOHUioYLYHzgoUouVWDr+q2OZb38NC1u093N/K4Hz0ZZ6v4xGs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(30052699003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0cFHtH4CKLaUqzOmfkstEyh720U/zoA643W0r9GswJKaDOyAjYTTNnKMvS6Ww/4e+UJ836kz1YWHdQDEDLH30qIAdZPH3oCZRX0vMYvPPGr7SOqUho1sCL/PFf7tb2qdIzAMXQzH+D9DR09KAQeJQNvNMM+J1ZzKGWEKWIJClsZ4cfFCT3schCQ0sjxHulb1clCb+J/ckAXIpGHggaewb1bUnV67GDkjnCOX+ljWzsyxXsYAL2M1BOr+Mv60w7s6N0gK5fq3DwdRAuNppCvcjyHRg2FuxM8kvI5t9fJop9nX3DcGQYUtOSaveLclEQBVVXg9FeeU99QnD7cTFMWrPGGG42WqhmzDur3TZ6mmvkrRcw1Q6COxS7RTOsb/9IzZE5rsHBr7L3TatEms1tuyVixF/AbjShGBz2JQO25j3+kdxpHd6/mmbmgubWgZ4KHY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:40:54.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55899c5-5f9f-403b-1080-08dea9b07967
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

Development boards such as the Jetson AGX Orin expose SPI buses
on expansion headers (e.g. the 40-pin header) so that users can
connect and interact with SPI peripherals from userspace. The
standard way to get /dev/spidevB.C character device nodes for
this purpose is to register spi_device instances backed by the
spidev driver.

Today there is no viable way to do this on upstream kernels:

  - The spidev driver rejects the bare "spidev" compatible
    string in DT, since spidev is a Linux software interface
    and not a description of real hardware.
  - Vendor-specific compatible strings (e.g. "nvidia,tegra-spidev")
    have been rejected by DT maintainers for the same reason.

The I2C subsystem solved an analogous problem by exposing
new_device/delete_device sysfs attributes on each adapter. Add
the same interface to SPI host controllers, so that userspace
(e.g. a systemd unit at boot) can instantiate SPI devices at
runtime without needing anything in device-tree.

The new_device file accepts:

  <modalias> <chip_select> [<max_speed_hz> [<mode>]]

where chip_select is required, while max_speed_hz and mode are
optional and default to 0 if omitted. max_speed_hz == 0 is
clamped to the controller's maximum by spi_setup(); mode == 0
selects SPI mode 0 (CPOL=0, CPHA=0).

The modalias is used both as the device identifier and as a
driver_override, so that the device binds to the named driver
directly. This is necessary because some drivers like spidev
deliberately exclude generic names from their id_table.

Devices created this way are limited compared to those declared
via DT or board files:

  - No IRQ is assigned (the device gets IRQ 0 / no interrupt).
  - No platform_data or device properties are attached.
  - No OF node is associated with the device.

These limitations are acceptable for spidev, which only needs a
registered spi_device to expose a character device to userspace.

Only devices created via new_device can be removed through
delete_device; DT and platform devices are unaffected.

The sysfs attributes are gated behind CONFIG_SPI_DYNAMIC since
this feature adds a new way of dynamically instantiating and
removing SPI devices, and the add_lock locking in
spi_unregister_controller() is already conditional on
CONFIG_SPI_DYNAMIC.

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi.c       | 206 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  12 +++
 2 files changed, 218 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7001f5dce8bd..ce4fab6cd50c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -296,11 +296,192 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+
+static void spi_dev_set_name(struct spi_device *spi);
+static int __spi_add_device(struct spi_device *spi, struct spi_device *parent);
+
+/*
+ * new_device_store - instantiate a new SPI device from userspace
+ *
+ * Takes parameters: <modalias> <chip_select> [<max_speed_hz> [<mode>]]
+ *
+ * Examples:
+ *   echo spidev 0 > new_device
+ *   echo spidev 0 10000000 > new_device
+ *   echo spidev 0 10000000 3 > new_device
+ */
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi;
+	char modalias[SPI_NAME_SIZE];
+	u16 chip_select;
+	u32 max_speed_hz = 0;
+	u32 mode = 0;
+	char *blank;
+	int n, res, status;
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Missing parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (blank - buf > SPI_NAME_SIZE - 1) {
+		dev_err(dev, "%s: Invalid device name\n", "new_device");
+		return -EINVAL;
+	}
+
+	memset(modalias, 0, sizeof(modalias));
+	memcpy(modalias, buf, blank - buf);
+
+	/*
+	 * sscanf fills only the fields it matches; unmatched optional
+	 * fields (max_speed_hz, mode) stay zero from initialisation above.
+	 * max_speed_hz == 0 is clamped to the controller max by spi_setup().
+	 * mode == 0 selects SPI mode 0 (CPOL=0, CPHA=0).
+	 */
+	res = sscanf(++blank, "%hu %u %u%n",
+		     &chip_select, &max_speed_hz, &mode, &n);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse chip select\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (chip_select >= ctlr->num_chipselect) {
+		dev_err(dev, "%s: Chip select %u >= max %u\n", "new_device",
+			chip_select, ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
+	spi = spi_alloc_device(ctlr);
+	if (!spi)
+		return -ENOMEM;
+
+	spi_set_chipselect(spi, 0, chip_select);
+	spi->max_speed_hz = max_speed_hz;
+	spi->mode = mode;
+	spi->cs_index_mask = BIT(0);
+	strscpy(spi->modalias, modalias, sizeof(spi->modalias));
+
+	/*
+	 * Set driver_override so that the device binds to the driver
+	 * named by modalias regardless of whether that driver's
+	 * id_table contains a matching entry.  This is needed because
+	 * some drivers (e.g. spidev) deliberately omit generic names
+	 * from their id_table.
+	 */
+	status = device_set_driver_override(&spi->dev, modalias);
+	if (status) {
+		spi_dev_put(spi);
+		return status;
+	}
+
+	/*
+	 * Use __spi_add_device() directly rather than spi_add_device()
+	 * so we can hold add_lock across both the device registration
+	 * and the list insertion.  Without this, spi_unregister_controller()
+	 * could run between the two operations: the device would be known
+	 * to the core (so __unregister iterates over it) but not yet on
+	 * the userspace_clients list, leading to a double-free or a
+	 * dangling list entry.
+	 */
+	spi_dev_set_name(spi);
+
+	mutex_lock(&ctlr->add_lock);
+	status = __spi_add_device(spi, NULL);
+	if (status) {
+		mutex_unlock(&ctlr->add_lock);
+		spi_dev_put(spi);
+		return status;
+	}
+
+	mutex_lock(&ctlr->userspace_clients_lock);
+	list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
+	mutex_unlock(&ctlr->userspace_clients_lock);
+	mutex_unlock(&ctlr->add_lock);
+
+	dev_info(dev, "%s: Instantiated device %s at CS%u\n", "new_device",
+		 modalias, chip_select);
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi, *next;
+	unsigned short cs;
+	char end;
+	int res;
+
+	res = sscanf(buf, "%hu%c", &cs, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse chip select\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1 && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	res = -ENOENT;
+	mutex_lock(&ctlr->userspace_clients_lock);
+	list_for_each_entry_safe(spi, next, &ctlr->userspace_clients,
+				 userspace_node) {
+		if (spi_get_chipselect(spi, 0) == cs) {
+			dev_info(dev, "%s: Deleting device %s at CS%u\n",
+				 "delete_device", spi->modalias, cs);
+
+			list_del(&spi->userspace_node);
+			spi_unregister_device(spi);
+			res = count;
+			break;
+		}
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+
+	if (res < 0)
+		dev_err(dev, "%s: Can't find device in list\n",
+			"delete_device");
+	return res;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				   delete_device_store);
+
+static struct attribute *spi_controller_userspace_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_controller_userspace_group = {
+	.attrs = spi_controller_userspace_attrs,
+};
+
 static const struct attribute_group *spi_controller_groups[] = {
 	&spi_controller_statistics_group,
+	&spi_controller_userspace_group,
 	NULL,
 };
 
+#else /* !CONFIG_SPI_DYNAMIC */
+
+static const struct attribute_group *spi_controller_groups[] = {
+	&spi_controller_statistics_group,
+	NULL,
+};
+
+#endif /* CONFIG_SPI_DYNAMIC */
+
 static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pcpu_stats,
 					      struct spi_transfer *xfer,
 					      struct spi_message *msg)
@@ -3256,6 +3437,10 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	mutex_init(&ctlr->userspace_clients_lock);
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
+#endif
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3633,6 +3818,27 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_lock(&ctlr->add_lock);
 
+	/*
+	 * Remove devices created via the sysfs new_device interface.
+	 * These must be explicitly removed before device_for_each_child()
+	 * below because spi_unregister_device() does not remove devices
+	 * from the userspace_clients list; freeing them without list_del()
+	 * first would leave dangling pointers in that list.
+	 */
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	mutex_lock(&ctlr->userspace_clients_lock);
+	while (!list_empty(&ctlr->userspace_clients)) {
+		struct spi_device *spi;
+
+		spi = list_first_entry(&ctlr->userspace_clients,
+				       struct spi_device,
+				       userspace_node);
+		list_del(&spi->userspace_node);
+		spi_unregister_device(spi);
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+#endif
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7587b1c5d7ec..3dff1a4e630a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -250,6 +250,10 @@ struct spi_device {
 	u8			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
 	u8			num_rx_lanes;
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	struct list_head	userspace_node;
+#endif
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -554,6 +558,9 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * @defer_optimize_message: set to true if controller cannot pre-optimize messages
  *	and needs to defer the optimization step until the message is actually
  *	being transferred
+ * @userspace_clients: list of SPI devices instantiated from userspace via
+ *	the sysfs new_device interface
+ * @userspace_clients_lock: mutex protecting @userspace_clients
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -809,6 +816,11 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	struct list_head	userspace_clients;
+	struct mutex		userspace_clients_lock;
+#endif
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

