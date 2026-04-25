Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A63537D9;
	Sat, 25 Apr 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777138488; cv=fail; b=P/qteW6hGR6ZX2qlSGR0fgQ6HYWiK9YVxYb6ONFaCcqNbt4tnbmVoUNsKk2IJvJSO72ICgzz5+O0tQfAkapEKhJKEoYyUA+UFzko5gp5Buvy2yjOOdj8l7s/75uBAF6yqgdfPwrWBv4+ONjeCQM2+WRexWAhrM08QS9F6sStDr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777138488; c=relaxed/simple;
	bh=6xfaYM4bBX0+E4G59rdRhyA+Ff9dp5ZTS/Dn+QklwGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ+Brbz1C9U2y3xC7RIKXKYmsBch+24j5FCPOjstd/pfOW4cpp2RdM/bEpSigo36IvxpkllNWq0iA9s/IODzvCQ2amd4wyCAENqWXLxqiTZs4VAiCX8ZYJ54ndjEu4vPLfmuyUsYuz2Mk1k961LtmAjx3xwBgVLFQei1RWJGMto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aq9lRPVd; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aq9lRPVd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecv3dlWwsKhkcA/gKFZvUzGSLi1EtfOi8kZAqYThmLBrsT4zPRbWeXwYPrJgdzo6LYK3B49UImaWuQN+C+JD1ayzIRktsJ80GBEBD2tKiWDxveZnxF0dkpPwJQaffaVQALB5HgwtZrLMDMUww/Wk7DoUlmezmJTYPr8jK7NhYg7SmCJXuCa8Fn8oU+aM/hXpxYJ1XxUoypvs8twHBV7HVVwvXnAGAqxWDdDYrEjTVGtA6C6asDW1MX9IBMQC2SyfNCWbHhcLkpOsw5JqY9HmsWIjUOmzG6dJQwTIGyHF9yQKlckoxaCiA3nZdLT5RB9fzMxc8Ah/5dGeHM00pyzF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUQWmc5MmWho0SmsC5h8r3ULWClDoJqhBY9aU1KMpYQ=;
 b=Yc+7rLH5aevLRZBXRSRL1cX/fVY+YuUDCyntw9QqwfAiRijwDGSxTLdkex029FV29zFI/PYzCQpNKxBGaff1TgGbBKoE8L1QnxGkgtMJzn9JRfznRSQ90nF32XpyQ3A5ajGCFjDpV8ez5iHqZz4Bp6lfd2rGYNJXVLVveB7hOQwBRfszAdrnTIEuoASjBZWopnz3JCxPTAL77H57rYVu1vhijE42P3q/tJZ9hL+nXYQIHEMPRD9CsJarndfd+e/N/pzUJ+RFFpZEQAdjYxAfAryXy0KfRcYTKWTHV+To7yqWZBNFAymmLWbClOQRya9vvJxa+fwd/4WQMNHOq5Et8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUQWmc5MmWho0SmsC5h8r3ULWClDoJqhBY9aU1KMpYQ=;
 b=aq9lRPVdaMqMS5/Rj7lZNulD/xsV878IOrNDnd9Rk3s4DtkzZOnBI0mCs8hBVBNBbv85LBMRFS+EXju/WcRUbBgo5K11ZzHHxDM1OawVVLptFFr8uf9YXJThfdDtx0vtaeGX2tPiPhzeq0orL5rcybEEoZAsZaYERwB46uS60K0XyEbmhFbj1DAT4cc/PyOtRseYUqz+/jQQeAwV//edRnWZIjYykRPYqVy9Q539VHJT5H330Fj6vcm77svhwW63izWQt6Ces//9OWbm+OpZXW5ea2zMF/aDxE2RctfKwcx0S11XPCsqm4wkBPBWnRjKCd6q3LIoB3dH/5a/zfm3xw==
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 17:34:38 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::dc) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 17:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 17:34:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:27 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sat, 25 Apr 2026 10:34:26 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, <smangipudi@nvidia.com>,
	<va@nvidia.com>
Subject: [PATCH v2 1/2] spi: add new_device/delete_device sysfs interface
Date: Sat, 25 Apr 2026 17:34:24 +0000
Message-ID: <20260425173425.622042-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260425173425.622042-1-va@nvidia.com>
References: <20260420031417.291442-1-va@nvidia.com>
 <20260425173425.622042-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ec3cb3-a4d1-4829-6eb2-08dea2f0ecfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|1800799024|82310400026|36860700016|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kV0Ze7270ISoq9QkfmkXunaHKFfzrkmWNd0rjnPlqEY1dGDXyfnBPSAeqAJrXogSNFknUQq0OZkiESJHNMyyQhzQhFPFwg/ZizK4oar4cTdBQNUvzLO5SaHzPBJKzKZ+r3mCos4He+MDUqS/zCqQhiwDXrGE2rJM9NFdpFd6M27bO+lZInAJB13SmEOoiZQNoh5iE9XxIT+ilCcyBgwPa0y4eOlkAX1Wc4EBHtXgJ+22LJ3hMfb4dNkwCyboInUQzbGm9/nzwxtXy7Dy2Ux6YaxrFaOmTvBQH5j67RqQif5G6hAMq+9WBDlhRG8uiUAF4c781ZFNJk8SkkXe5nDnuP+ZpdQsTN1Zd6OfGUPAOptt73RaMxQul+7EQtbk9cPNQtqLYVn65I1ZJ2/2haJtZ9GePghAN2nyXsvUJkFfBYS9XJGtWdzsypbOakJzHMZO7NcG3vEfYASKz8o7SI9Cf6wTUOa/qZY04UP6f7VkkkAEfGt1pwzOiLh8y39y9EM8d2E9ZqZx4rtd0WItPSyqE4O53ScVXjacWVcrejRYBUQm69fZejoE8UIhf9cG/LLPkm+uJKjRotV0PjOzFGnk1SQrQaOqrlWA6arUzojvCJVCMU5SzDWfxOZoTeUi2Df5V50X6FU477dO6EyQYYdr7S5w41dKfxhVwGzuENoZSPtc5pN8lGPyZrq0JvRjFnsX2kC0aSgd6gjRB8AC/jGJBHGmRL2mzfDEAOJrIBhMbf/CPAcmWkEW3/BkWqSMpVpzpwTGoBTjCiTdsK1njpruyA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(30052699003)(1800799024)(82310400026)(36860700016)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qb2zMQje/trKVHhsYWw0k9S7jgmpKTS1DAZ1wBW8LTvnpe3kwnWe21r5Unj0MijnHTgmvYRXyW5qsZQidXbL2A3nLzEEQ6TMRZ1k/HjgmItPtzIDGlvHIRsfhNMbkox8dNosSrptmXhsEVVidY2VppT2eA1ua844Q6LaapMnApgDQue0pBeg69xac6NWn1I9tl4mkMv1Quo6uc79DBsrbT1Toc7Xrn/Sv+TK4jMlZa+SqSRuCjGOBRR/STVaL0WfQx+HnEHE+PAJlbgjx0v3lxtgrsexU+Y8TevXrONjkncf4I+r4MR8EyeStGbRT0QtP65q50lSR2f5sj6rrtEY/diuD1vMJsJXcbtGQexP1ZIy5b/gmoSQpqjy/TUmIxwVJxfxlDtJJT5gOX8zH9obEy1joFrzSde7iEmpkZCUl9k72Ty7+TSVOvLl9wF0sIOi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 17:34:38.4203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ec3cb3-a4d1-4829-6eb2-08dea2f0ecfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709

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
 drivers/spi/spi.c       | 190 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  10 +++
 2 files changed, 200 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7001f5dce8bd..916741690462 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -296,8 +296,178 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
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
 
@@ -3256,6 +3426,8 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+	mutex_init(&ctlr->userspace_clients_lock);
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3633,6 +3805,24 @@ void spi_unregister_controller(struct spi_controller *ctlr)
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

