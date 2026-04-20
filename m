Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AF37F740;
	Mon, 20 Apr 2026 03:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776654879; cv=fail; b=dV0khbnYZRNrJ93kmuTx+HzZDrpumkvOu7H7mlKE7FDDa7hgHkp7XGgBqF1tCMz3lHZpbJdzUSUq+9fmt9aMrC8RcCMPBDUeOxQ/ccNO+9UxXqProiD/sv8ikh4RSsAmmDRLdPvHFlXC+G+P62U+dkeAriIBy2F8uLDFPBTK30U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776654879; c=relaxed/simple;
	bh=atioRZmip21ooRhxEPBbxKeM4VQ+uXtZnIuZ0D6Vj50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJSMuZP4WH4digjvcSIwV9SOx03bkf4sAHXUrkCO4qCeGLnN89c30oBnhel6jH4X0KNLs1gedvuoYZ2kN7kl0lYusXMZMEasHNJWDDL2RbEv/2a6aej1gnCoCPNS2UHE3A2fSAhopgY8//pB05oQlH+4ugjTkxXWpQ2JfsC6Xno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=exakH3cv; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="exakH3cv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqB7n91i+4L3x5ELLTDVmr643ABaTwdD5AJBYKl4aecykBXWB6BgZ0VT33+evi0eV1+d9kKUXiARhvI+xELvMKEiS04/b2disWD/ewFDPu1UyKq9Jll707JzhSxiRX8ptNqX063Sl8McTZO5C7f4X2hFagiYP/sxw7yDMA/gxU04v5+AlPf44+2Vtnk1ftkwz0S/3s93KxQ3u5wY5cHNIbDi3rQc2PLdml+JEIKirVSgDHI22yC5VMpPGOKRu4hHbbxBj0K0sbek2ya2Ic176NqxFucQZG1n3rdTQxgZb/dQ+N7biVXOnI10uBEl5uhix6wmKT9Gczr6ML5GeNGyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJLTr5ECTxCfqxbXS0vy8299lh5H1c9FSfjFcBqo4oM=;
 b=ULO39RzNYxmVqWMUf3grSHnpInHO2RJ6P2tVfXZdzzd8MWLMdNcYiGZXAbySw3hljAzQG9Tb9SmuP9AVK/R9N81/b5Kvh13ENmNrkqJJVwNaRN3HfWAGmbktKBmGUeC+QDlcEkP/melZk9+NycscjFT4Egp1TRYXhJDh/da7nHQdgsXgzXz5ZRoG6OyAjCuBCo+DweN+jj2hb4RovkphjoS0Fwou4ZzR3xUrU25dPwXco8uQVZ0QH1fJlXhewTS2vBFE9gWg43TONg6JvlG22uaaMKzzcifS3Ruhcuboj1Op7VhAJEWXkaCQ6i6BKap16Ls98aBTmwBV9UEMMcbL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJLTr5ECTxCfqxbXS0vy8299lh5H1c9FSfjFcBqo4oM=;
 b=exakH3cv7jxsCnb6Ni54RfZ6oUXEBCylvDn3ihoCYQyZIQUDc7sZDuHS67orwlmJvQgr2GOIVRFdbUKDbi0tj2hxxatMVAcYVD+ULCu++jCNvwkZ31yDJXDpBLjFodDbEu3NoUGkiUp6FsG2yoymnK2p1xWuDkATKGJdClFPv17jN/oNV5x0ut/MEbD6tfakwzPE5xXjIyMOXc0iHPHcBEvIL5FPtWftt7d3nJh89jkwSpqrYAOdE2Sog4fXHfeXQycH50IuMhlX6Ell2wzRFt9dmlSmKugY8aP1NkiJnPLG3LwQmubTuxfz/2b9aUW0Kf7FIbyll55CHvqcHP9gEw==
Received: from PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::6)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 03:14:30 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::14) by PH7P220CA0119.outlook.office365.com
 (2603:10b6:510:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 03:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 03:14:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 20:14:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Apr 2026 20:14:19 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 19 Apr 2026 20:14:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH 1/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 20 Apr 2026 03:14:16 +0000
Message-ID: <20260420031417.291442-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260420031417.291442-1-va@nvidia.com>
References: <20260420031417.291442-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: bb43fc9c-72cc-427c-fdcd-08de9e8aef84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|30052699003|56012099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GQBXUzXGRGaTVkHnSy49zCivdEix6E7F1cNDB9VAxu0VbZ3H16VLetRsa2QpXoApu6TuxjE6daMc/lz7q341+2DYCOfkeIh2X6f/MFibLzl+yNtyV1uJyXHFfBxKi2FTE0MescRk2lFxF4mV2dzeJanphxT3CcMGBnHc3YbIEfni8B/vFZd1ELK6KxZZAp0MRYBG7ERFuVMujai3rJKvuTHtGBgkxogybRJM8vyL6IYxb73I6p0Z3/8fgRCej68gpa2HdGcpWhhK6j704eYkmHw/MLwv/eny5b8oMPACFadQCWgLlVZUZrw/wvu67pBmY8iVgNd38esmrCWko1ColGM/fsa/0r7Jvddmh98V7b/7Y06BxWi6NAhv9XhJuLRWAhAmL4LTyQyLNt7HoxDiznuUwjt/inO3TjB3SGXOcP4HfINvEE4LpCuRraafryJcRpL7DjAYbH1vXOivbvvKBJCphHr88eOp4pXog3EdXmfnZ2qwSAx4KsmSIYBpcZX8m6v+ih+Sv8Te4dHnOmPIkpCPgzhJvncXgW+/9Uy94cehuhz6CVaTdS0Ks3alcUVaIfVl5tPRIQHRg9vnI/wxiXr411Nep5EK22hJOoyfKlBa8G+Be/KQyqRYajpcwaC8Oh/T7nOYwSgBZ/KH3dCIa3sc3kIxW6Uc37VebkvAGN98mpqb0pw7zX4CTVWGmj4/drMf8BzHblJX4+wEwtwUue/KTB0/yuzqr2p2lhtR8ysiNku0gGR2E4AAvpFiVVjj6BuEG9Y4iR6mCL+Mc7Jkbg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(30052699003)(56012099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8N/EZe1DuIr6MqkoD83S2wCdNpvHJckUGc9KoAYv578aHiG/iv9XW7WvNxNsA7LPlnTXTGwrhtiXgG+dvIArzcnDxblbLqfbrK/xpkSst3sJSCRAMo37/TDlbrRylopaU6pBxWwJtU+9MPp+KCsDAK0trOWwyEnTkh+I3q978BDzDUZgznSqPxQpxbRNDKaq3zJlpQzKNtmyCJ9UP1lqrdd+KOnrsB9YYkRT7lcQc0bcT5iTr9SsuHRtZ7C9Imuu0bV/RINSQ1Yh0uMYN3+moKIz+gYrO6v245PwU4CRGRkVIcOnrMX0KXxn1Bj86ZX+FyIQnujeMiDfxqoAYWMcsp79njQADi52Jjd0hDy4MMZ9V4kSZAVzkdwbfmHC4Ls9VkqtiOGXQ7PdmDgjlxeZexpFPwpyaY4ohnvR/jCTIU18DgPBDXKyTTM8aBRK/j3S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 03:14:29.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb43fc9c-72cc-427c-fdcd-08de9e8aef84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664

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

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi.c       | 172 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  10 +++
 2 files changed, 182 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7001f5dce8bd..b0c66f7b3ea0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -296,8 +296,160 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
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
+	status = spi_add_device(spi);
+	if (status) {
+		spi_dev_put(spi);
+		return status;
+	}
+
+	mutex_lock(&ctlr->userspace_clients_lock);
+	list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
+	mutex_unlock(&ctlr->userspace_clients_lock);
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
 
@@ -3256,6 +3408,8 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+	mutex_init(&ctlr->userspace_clients_lock);
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3633,6 +3787,24 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_lock(&ctlr->add_lock);
 
+	/*
+	 * Remove devices created via the sysfs new_device interface.
+	 * These must be explicitly removed before device_for_each_child()
+	 * below because spi_unregister_device() does not remove devices
+	 * from the userspace_clients list; freeing them without list_del()
+	 * first would leave dangling pointers in that list.
+	 */
+	mutex_lock(&ctlr->userspace_clients_lock);
+	while (!list_empty(&ctlr->userspace_clients)) {
+		struct spi_device *spi;
+
+		spi = list_first_entry(&ctlr->userspace_clients,
+				       struct spi_device, userspace_node);
+		list_del(&spi->userspace_node);
+		spi_unregister_device(spi);
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7587b1c5d7ec..63c267ca9730 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -250,6 +250,9 @@ struct spi_device {
 	u8			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
 	u8			num_rx_lanes;
 
+	/* Entry on controller's userspace_clients list */
+	struct list_head	userspace_node;
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -554,6 +557,9 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * @defer_optimize_message: set to true if controller cannot pre-optimize messages
  *	and needs to defer the optimization step until the message is actually
  *	being transferred
+ * @userspace_clients: list of SPI devices instantiated from userspace via
+ *	the sysfs new_device interface
+ * @userspace_clients_lock: mutex protecting @userspace_clients
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -809,6 +815,10 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+	/* List of SPI devices created via sysfs new_device interface */
+	struct list_head	userspace_clients;
+	struct mutex		userspace_clients_lock;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

