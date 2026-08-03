Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848736EAA4;
	Mon,  3 Aug 2026 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754008; cv=fail; b=LwYDgFjXHbDaXky3X4WuzXip4TqvEzK5THEpB8gd23IvQ+aIkfdyPTS83WhIWNIpYCt2kY7lzjJKmk1LaNT5cc0AHlyB0qReln939O7AMJMyFtupFOu1J7gYkMmuD4npCsUOcfpjuknIVODg+ZPKAuESIDOLnl0QcbY6iyUOw+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754008; c=relaxed/simple;
	bh=UndT3q1PZHRMP8bEFqVJeisa7QIyTV08aSwFihseI7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0dkPmxelkoPLZGNNzINEpF5nBGq/mPNAvZQE/rBMvwWhdzY7JphV9zmDJjitUhV/BBBXq7Oj6oDnJaRsMuz7M/CxTr0NiTz0MH16zQHYKQtl8lmMR2mEcx75pgHy8JSkF92j+QHUrR2L+5KSCIEHi2aBT/U8LXutvCuZTPiTmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ikL1Ojb9; arc=fail smtp.client-ip=40.107.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ikL1Ojb9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iecmYvWJCudO+j2jeOfTlvjmsEP/Ix2GlxRQ5x/snySxSO2qsHxbcM19E3Gi2QTDbEzncHH0s79f5nYxu/96Z41VjJp9bejEoaBDH7TlyYghliBzgHEGJVAazlLLqxJIGZzPs0MKHGIxKIFr8he8hEx+V9cL4y7r88YCcdLex4PHyVOMjKGvESoTFmguhO5Uo+BVa0HArjRBdZ4k1/xt2CSZ70YzDulqaaZjCnm1edSYAEopqQqqBeH2Gsn/Q5Qg989EtYPr6aF744k4RHM5p2uIYExt5Z6Gg/D4JDiq5+htkmecKQwKKkDdKjkF1mwjRNVrfZ0CFXT/KRF3vc84jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id21i1cZBxHKbunNi3OBH80jMV/G31evM/AJfezEgRE=;
 b=gPjnKiNgNGl9/UfnN72rHXxsp2necWWcnbLbpqTa3y1x3+COaazjfBQ49forFH1Vwjrp1GiBcS6CZByCcwjguP3rtlTEuuRef6DcgHqkZ6xI9Wp8Bit5Wk4OlioBBxP7AfraqZ8pNprFoJi9QcDvLt/69MruWm27HpnyUrTWl88PshOAtUbyWPBprA6oZqdOBs+kL20pnYZV7++s/L4bJ+9s7rs4KT1w7wjkNA0KGiY2ka8I9R+gq7FLonEA7osdac5g9UVkTq/dlbvldj417iJLpqB+jzKE9gT/GCzw0/cQoQ1TUZosh+5D0Yqcf9ZAlug7yYQHo4rwstvQdc1qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id21i1cZBxHKbunNi3OBH80jMV/G31evM/AJfezEgRE=;
 b=ikL1Ojb9sO7VvWYw9GnrtwYo0QjeIcHVg/K+uH9cuO79K32Ucxx2HvvV/qwTckSDPBAH5pZTkdL+Ra+/RDvznuxvUPD/vygxNHvH37x2YolTKyRbYv5NK5udTubjU6+1nd18GctRQSlWNVFnQ4hq4A2yvxnfSeSif7AiMXOSLOxaIaE7XQuWRYBhbrRkciKxNdoJQreWIOStBbGUZgU4nC2PkWxAQXAObcuygYrc5kLoXtq05KxJSag1qsp9jLPGDY0my4upfKwpYx/sU0GlquM3aRis+8VnFqMRqzVe5EqbVXWIojkHEDUZOJ9rXhw9ldduCQE1kzZeSavrtRHutQ==
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 10:46:37 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::75) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Mon, 3
 Aug 2026 10:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 10:46:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 03:46:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 03:46:19 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 3 Aug 2026 03:46:18 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH v9 1/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 3 Aug 2026 10:46:13 +0000
Message-ID: <20260803104614.2548375-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260803104614.2548375-1-va@nvidia.com>
References: <20260803104614.2548375-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: eb721aa9-7774-4894-2902-08def14c7d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|376014|23010399003|1800799024|36860700016|13003099007|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	4xFSQtYYTntd5A+aLb6K0W2TGIpwX5SRvUvWhQAN4ME99pk7YNY0wJes2J7TdgimYPq3fTRs+7+YpllcBLPHPf//m2jsWsq5Y7y6bInBNgjhlNhBVZKgEX43MUYer6NcR/rgP9A5my9fOt16EjtreCQhBdbR5mVPIUq0pvPaiG2bO33AB9Hy8+R5okiPgsFRMVmWS/iv/AUUBq9A3ZZbXX1xJZXXV9+2njmonRsrTuLSWj43nlnOjA+4CBYlnW3vhi9wEc3iGBfb8uvjA+YhkwBC+qd7OjB7uGCsoMw7SVhRVhNXTUdyS952+0J18gzeBbWuFanlB4GLrDXzmwXXJ+3EQPlXgj8K8bzmOF9PR+I4E+ZU6DsfVcje9NUYypfsci6zP1T5m+Ap3C3hqZBg2xsc6Xm/jtO6Xstydvg1jNb7dC9BgRdaIOt8zpM3rpDhTSk4nw2eF19EEHLRix0qI6qsvA5HKGr0f5FQrMJ5yE+drDmIA41SaULyxxhRehXeJDW1OMqExvAg/iiUa8LfoPMPENqr4lb3J/LhZWLmHl3Wno4TXceljWFBTv3u9XUuO1emsvOBq1nqg0/UCqHeZlPkyfn77mRT8Ttjax1RSuZ/he1GNkN2GT/ryjgNJL5ieMgpREybaxRFyP0iC8czVPc/Ka9E3yZgXX7Aiv2siDDFodVwHQSBiRxb2D1lCW1jrkb+Z/6hIVaQ/ojJncS1uA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HlgioCWAKeZ3Wq0Nf73CSsLGD5w03pZiKU2haq/pLGWC8RJ4Xgd1K4i87Mkr4ly6iY21m4U5ftYehstOmMszhAmp/U3htRj7b/pFe0NAHJnC91N0CHv4JW/DzJkbcjlb0C/K5gtqY6rrgsNPSzF9ARQLNKXulsX7HpEQuUk32HWtUyNCYsK3f/hfFJYKfj0tWyoghmTRcY2EGN7xpVvV1SJrJmNNdqKFrE5lsO0n/siBHnrPswF5pWV2g1gw3TKU8WvlIaSmEVRMp1yq4z4RfAMr8ix5v/OTUWJz0MHD+gSLJyyQwr7iwN+pHMZ35qCtmYC1SnPgi5TLWqKH40talgHk7XmciWkLD+dXyYbW3pakD7bxj5fHxg8ex2Gh0kOrxh3uC3RZeD0eIhgHVFhb9QAY5BO4pgxNGo5FubgmbsLo6K/M/KBEriU5gu+GEmXz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 10:46:34.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb721aa9-7774-4894-2902-08def14c7d13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

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

The userspace sysfs group is created manually as the last step
of spi_register_controller() and removed as the first step of
spi_unregister_controller().  Removing the group before taking
add_lock means kernfs_drain() completes any in-flight
new_device_store()/delete_device_store() calls before
add_lock is acquired, so unregister never blocks on a store
that is itself waiting for add_lock and no store can be
touching an spi_device that is about to be torn down.

Non-sysfs callers of __spi_add_device() (DT/ACPI dynamic add,
ancillary registration) continue to be protected by the
pre-existing !device_is_registered(&ctlr->dev) check added in
commit ddf75be47ca7 ("spi: Prevent adding devices below an
unregistering controller"): device_del(&ctlr->dev) runs inside
add_lock in spi_unregister_controller() so state_in_sysfs flips
to 0 before add_lock is released.

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi.c       | 246 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  18 +++
 2 files changed, 264 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..07c572e1df5d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,6 +43,7 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 #include "internals.h"
 
 static int __spi_setup(struct spi_device *spi, bool initial_setup);
+static int __spi_add_device(struct spi_device *spi, struct spi_device *parent);
 
 static DEFINE_IDR(spi_controller_idr);
 
@@ -297,6 +298,192 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
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
+	unsigned int chip_select;
+	u32 max_speed_hz = 0;
+	u32 mode = 0;
+	char *blank;
+	int status;
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "new_device: Missing parameters\n");
+		return -EINVAL;
+	}
+
+	if (blank == buf || blank - buf > SPI_NAME_SIZE - 1) {
+		dev_err(dev, "new_device: Invalid device name\n");
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
+	if (sscanf(++blank, "%u %u %u", &chip_select, &max_speed_hz, &mode) < 1) {
+		dev_err(dev, "new_device: Can't parse chip select\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * spi_device.chip_select[] is u8, so cap at U8_MAX independently of
+	 * ctlr->num_chipselect (which is u16 and may exceed 255).  Without
+	 * this, values in (U8_MAX, num_chipselect) would silently truncate
+	 * inside spi_set_chipselect() and select the wrong CS.
+	 */
+	if (chip_select > U8_MAX || chip_select >= ctlr->num_chipselect) {
+		dev_err(dev, "new_device: Chip select %u out of range (num_chipselect=%u)\n",
+			chip_select, ctlr->num_chipselect);
+		return -EINVAL;
+	}
+
+	/*
+	 * Reject kernel-internal mode bits (SPI_NO_TX, SPI_NO_RX,
+	 * SPI_TPM_HW_FLOW, ...).  These are set only by in-kernel drivers
+	 * that know they are safe on their controller/device pair and must
+	 * not be settable through a userspace-writable sysfs.  Matches
+	 * spidev's SPI_IOC_WR_MODE32 handling (drivers/spi/spidev.c).
+	 */
+	if (mode & ~(u32)SPI_MODE_USER_MASK) {
+		dev_err(dev, "new_device: Invalid mode bits 0x%x\n",
+			mode & ~(u32)SPI_MODE_USER_MASK);
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
+	 * spi_unregister_controller() removes the new_device/delete_device
+	 * sysfs group before taking add_lock, so kernfs_drain() has already
+	 * completed by the time we get here and we cannot be racing with
+	 * teardown.  Take add_lock to serialise the __spi_add_device() and
+	 * list insertion with respect to non-sysfs callers of
+	 * __spi_add_device() (DT/ACPI, ancillary), which check
+	 * device_is_registered(&ctlr->dev) under the same lock.
+	 */
+	mutex_lock(&ctlr->add_lock);
+
+	status = __spi_add_device(spi, NULL);
+	if (status) {
+		mutex_unlock(&ctlr->add_lock);
+		spi_dev_put(spi);
+		return status;
+	}
+
+	list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
+	mutex_unlock(&ctlr->add_lock);
+
+	dev_info(dev, "new_device: Instantiated device %s at CS%u\n",
+		 modalias, chip_select);
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(new_device, 0200, NULL, new_device_store);
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
+		dev_err(dev, "delete_device: Can't parse chip select\n");
+		return -EINVAL;
+	}
+	if (res > 1 && end != '\n') {
+		dev_err(dev, "delete_device: Unexpected parameters\n");
+		return -EINVAL;
+	}
+
+	res = -ENOENT;
+	mutex_lock(&ctlr->add_lock);
+	list_for_each_entry_safe(spi, next, &ctlr->userspace_clients,
+				 userspace_node) {
+		if (spi_get_chipselect(spi, 0) == cs) {
+			dev_info(dev, "delete_device: Deleting device %s at CS%u\n",
+				 spi->modalias, cs);
+			list_del(&spi->userspace_node);
+			spi_unregister_device(spi);
+			res = count;
+			break;
+		}
+	}
+	mutex_unlock(&ctlr->add_lock);
+
+	if (res < 0)
+		dev_err(dev, "delete_device: Can't find device in list\n");
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
+#endif /* CONFIG_SPI_DYNAMIC */
+
+/*
+ * spi_controller_userspace_group is registered manually for host controllers
+ * at the end of spi_register_controller() so new_device/delete_device only
+ * appear after DT/ACPI children and the queue are set up.
+ */
 static const struct attribute_group *spi_controller_groups[] = {
 	&spi_controller_statistics_group,
 	NULL,
@@ -3259,6 +3446,9 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
+#endif
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3552,6 +3742,29 @@ int spi_register_controller(struct spi_controller *ctlr)
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/*
+	 * Register the new_device/delete_device sysfs interface as the
+	 * final step of host controller bringup, only after the queue,
+	 * boardinfo matching and DT/ACPI enumeration have all completed.
+	 * If this fails, the controller is otherwise usable, so log and
+	 * carry on rather than tearing everything down.
+	 */
+	if (!spi_controller_is_target(ctlr)) {
+		status = sysfs_create_group(&ctlr->dev.kobj,
+					    &spi_controller_userspace_group);
+		if (status) {
+			dev_warn(&ctlr->dev,
+				 "Failed to create userspace client interface: %d\n",
+				 status);
+		} else {
+			ctlr->userspace_registered = true;
+			/* Notify userspace that the new attributes are available. */
+			kobject_uevent(&ctlr->dev.kobj, KOBJ_CHANGE);
+		}
+	}
+#endif
+
 	return 0;
 
 del_ctrl:
@@ -3616,10 +3829,43 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/*
+	 * Drain in-flight new_device/delete_device sysfs stores and
+	 * prevent new ones from starting.  Must happen before we take
+	 * add_lock so kernfs_drain doesn't wait on a store that is
+	 * itself blocked on add_lock.
+	 */
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	if (ctlr->userspace_registered) {
+		sysfs_remove_group(&ctlr->dev.kobj,
+				   &spi_controller_userspace_group);
+		ctlr->userspace_registered = false;
+	}
+#endif
+
 	/* Prevent addition of new devices, unregister existing ones */
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_lock(&ctlr->add_lock);
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/*
+	 * Drain userspace_clients before __unregister since
+	 * spi_unregister_device() doesn't do list_del() itself.  The
+	 * userspace sysfs group has already been removed above and
+	 * kernfs_drain() has completed, so no new entries can appear
+	 * here.
+	 */
+	while (!list_empty(&ctlr->userspace_clients)) {
+		struct spi_device *spi;
+
+		spi = list_first_entry(&ctlr->userspace_clients,
+				       struct spi_device,
+				       userspace_node);
+		list_del(&spi->userspace_node);
+		spi_unregister_device(spi);
+	}
+#endif
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..88d17fce02dc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -179,6 +179,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @num_tx_lanes: Number of transmit lanes wired up.
  * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
  * @num_rx_lanes: Number of receive lanes wired up.
+ * @userspace_node: entry on the parent controller's userspace_clients list
+ *	when this device was instantiated via the sysfs new_device interface
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -252,6 +254,10 @@ struct spi_device {
 	u8			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
 	u8			num_rx_lanes;
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	struct list_head	userspace_node;
+#endif
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -555,6 +561,11 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * @defer_optimize_message: set to true if controller cannot pre-optimize messages
  *	and needs to defer the optimization step until the message is actually
  *	being transferred
+ * @userspace_clients: list of SPI devices instantiated from userspace via
+ *	the sysfs new_device interface; protected by @add_lock
+ * @userspace_registered: true once the new_device/delete_device sysfs
+ *	group has been added by spi_register_controller(); used by
+ *	spi_unregister_controller() to know whether to remove it
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -807,6 +818,13 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/* List of userspace-instantiated devices; protected by @add_lock */
+	struct list_head	userspace_clients;
+	/* True after new_device/delete_device sysfs group is created */
+	bool			userspace_registered;
+#endif
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

