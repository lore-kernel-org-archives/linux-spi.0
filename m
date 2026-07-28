Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BC2F7F12;
	Tue, 28 Jul 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207971; cv=fail; b=F5kvOC1OBKLLSXnP1mNvzgvE3pVbJeqD4asc5GlbWNnUecbEDnGYIQGNxNBZet3UP+b+AGWNqg4FnhCyQqfYQPv7q7Aov6Q7rdB2hALqoos4AH0obHC9wPHE5cRGyatgUJAAgA2oQkZyJjGV1Hj8o1ev6sO+P6t5IFWZWU2zoVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207971; c=relaxed/simple;
	bh=0eyw9fP9VKC9yFMZ9lBb5vLNMu44f8wR2DWkhmoZIhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcuMzavXVh8idPEBHHIxFJvXszMMAnBO9mEZiPZnmI+P+8ppiU7sVhLZy4XVMO9+IPK1oypkr0pvRGlTcbBVYj8iRZGdOETRG2PqhuAWTRgxnVw64tWs+fyHSr8IKOwBVeCLme1L8IZITmPs76EajfNsw74cg0FR3XnYURdwob8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k0rK2Xdo; arc=fail smtp.client-ip=52.101.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k0rK2Xdo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhwmMWVYl8UsTdKlH3MBbOFvr2mqxXdjMzpI4ggbbQ0jQwIj4eAOkOKq4ZDOvZ5b0B6q0iEboGsKbnNP1MWBwoY86OnTJF1xRmle7dbjJL/f3k1nsARs6aMGyaFoTlY5gLJbFKUKkHNSzUNSkcqatHexKFpb7UxZT/lvLtjLAKm9hUBFwHrYqzo1ao7/B0RZudmuYdZyGsp17fHqxzOnV0nk6Hq9mfohIr7MJV6uCq48lwk34IObEOSnGv4iOrji0zrHm4oPDyFo7as5vgLBLClxItAiCxNboELn/46ilNy94KN+71t8DJrW/VpOqIvYRoFl/y/n7is+gAg+UT5NwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb/NqzHdJ9WhZmnpb/5vwHBrJX/mUPS0nbYWSQ2ZoJM=;
 b=g1dkCbfcCPbf3ynsA122RFL1PVKIDlJo6EPAUy58vOsNYdymyl9UJa7lDKqvzPeOxwYo2hKKaSVd4QNJW5x4aNtMOjhQcB4ud7mEj3n9tMIwfTjFoXSE9MFAen2vEJ2Q+OeTC/s1y2BoaY8ENR3HrudA11MflNbGALzDqeF7VaY/Gc9gOME9Wk7bqwblUxW6mHDfZvE3YNKcNJnr1KN+AUs3uzHN2klXMZch7l4RceyMhpKsuOAuLfp2mzdjcpUItwAIsE5MQY04Dqmne0/VGiGo28jmMDNnMw6GBXoTu3ZROXm/PxEMVDs78Hg2zUpkp0EUiymIIVlMcI2MserU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb/NqzHdJ9WhZmnpb/5vwHBrJX/mUPS0nbYWSQ2ZoJM=;
 b=k0rK2Xdof9PSv8fb0LOugzI2h2jgPWJ5bHa3qvN8Hr5+F88nepMmDCXcZY6U92g04XK8C8LuInziRNsZpI7DX1Kl33nlEIvVx1yR7rAwAHZBC7QDlWAOL/iYpX2ahYH8sR/jAciNpGcGmT7BCvM1+7woaUwedDIB3H4w9az9N7W0/XLAivZNZxw8Pstvh6Hqc9rUc8sqU4qmCzfi+adj34esRZ60KVod4Fz+kLIdmaH8BVpeEmtE/dTPa5Zr7raUX/YcIlrSe+DWpr4PsZQknkKW7Qbqbw5zr5X9nPFFHW8lI5TR/++TlJyWuGHSwv6GoU5iPeNBPb3RFE5IWtNMsQ==
Received: from BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::13)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:05:58 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::36) by BN9P222CA0008.outlook.office365.com
 (2603:10b6:408:10c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 03:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 03:05:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Jul
 2026 20:05:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Jul
 2026 20:05:47 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 27 Jul 2026 20:05:47 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, "Suresh
 Mangipudi" <smangipudi@nvidia.com>, <linux-tegra@vger.kernel.org>,
	"Vishwaroop A" <va@nvidia.com>
Subject: [PATCH v7 1/2] spi: add new_device/delete_device sysfs interface
Date: Tue, 28 Jul 2026 03:05:40 +0000
Message-ID: <20260728030541.2279518-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260728030541.2279518-1-va@nvidia.com>
References: <20260728030541.2279518-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2e0b20-4c0d-4bbd-e3fd-08deec55260d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|23010399003|376014|1800799024|36860700016|18002099003|22082099003|11063799006|10067099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	NKF+QW1iaxOvecVjZ1mRKP966XMOJvDRF8WK8pJUto+9CcPKSOz/G5tBamW/Y4b0HVbLIFmiKCD1xBUJ5BPNbxWPSACa0J20z7ZMV9HcDU9/rTkt+xWIv0DheQmh1hhqNi8gPh7SgtDMUKy4a6RT1CF/Z3m7Y0vfIG1xr495TkoOqjvW+6YmK8COvazRYhBsqT6Jn/TbAFYhhGEKnp37qCOpuYTWwJ5AYFFZ5Nes2xKteb0p+JaPsvGJYjJEDldqzc3vWeFfBpKDFZmmwGvLyB+FggCP/ebyo5J+eWsbEEPp+0rDrrz/AZAfCJ+jojr51/B6i17lVyN7wLz2PjUAzLVjFvEPW4aChYK0TUH23u/NtEccQ1KB0NgzYB8xOLiJdIdjWZyqwczPymeIhXSvm0cDd/SBS0ThcpAjonpv6085G7CgvvRrxr5mwySc1Mp/Nsuig+K4V8MF1D/cD+qyuNhRRU9lp0WZGBh/77wWa7p+zw9mm9CW6gp2/XZ3eALIDL4CLix4lAXjfpl8oo5axtvKgQ9u1XdP2nFqlwI77f31prZDFKhjXmw4WMpWQVPikffVnLN8OrQQAGFd3xYaD0BIOY3/ulIhSnF8wX0lbtunAZtXqXsfmACTvKQ1xsI8ztQ2wN3t9EuI15va3sXB10GbFr4apORgUVVSbZ6oBhbBkm57PESFf6/N71AxAKyEVBjiE+aWBj7axgooHPC6fw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xCqU94mhjEObk293x0fWIj9XbiDpIrwX7ZsnDL27IjNX3w9ixxyAESwVZz5GfCqBODyf9POjyyhPj61W4UG/KAsg8sQE8WuJR7Ht0t44vyXr1lsZ+9Zyo1lLFBIezZS1t28a3Vcn4OsWTKLOygeKdNN/CCsh2Z8GbjtkqcJB8ZjRo3sosPUskK0tIDqfMMYB36Q1LfR2qZhxEhZkg2aej8P0iEce+Ydn5TYgTOR8+Ow0KthQVXZi/qPsbDVJJH49/4kRRoW5MZFd43xyAQ8+339LlwnyU1Pb8xMFfvSu9skNmjxHodbKXAU3m87MCKY+ViwgqG7fEYkminT4IjD3xzH+3lupUgbA0ew+rikAYNrJCAq4upRmKkbCYYjlG6bQH/NbkrxATmCTk0cUbTiyQ1CUzjd6TCsJlt/5nfyxeuQnMXUHnVqsFBq8QlxpJa/g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 03:05:58.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2e0b20-4c0d-4bbd-e3fd-08deec55260d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

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

A 'dead' flag on spi_controller prevents new device registration
and list insertion after spi_unregister_controller() begins
tearing down the controller. This avoids:

  1. An ABBA deadlock between add_lock and the kernfs active
     reference held by sysfs store callbacks. add_lock is
     released before device_del() so that in-flight sysfs
     operations can drain.

  2. Orphaned devices that could slip through after the
     userspace_clients cleanup but before device_del().

  3. Use-after-free if __unregister frees a device that
     new_device_store() still references. An extra get_device()
     before spi_add_device() holds the device alive.

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi.c       | 270 +++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  23 ++++
 2 files changed, 287 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..6a6c822cc04e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -43,6 +43,7 @@ EXPORT_TRACEPOINT_SYMBOL(spi_transfer_stop);
 #include "internals.h"
 
 static int __spi_setup(struct spi_device *spi, bool initial_setup);
+static int __spi_add_device(struct spi_device *spi, struct spi_device *parent);
 
 static DEFINE_IDR(spi_controller_idr);
 
@@ -297,11 +298,214 @@ static const struct attribute_group spi_controller_statistics_group = {
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
+	int res, status;
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Missing parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (blank == buf || blank - buf > SPI_NAME_SIZE - 1) {
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
+	res = sscanf(++blank, "%u %u %u",
+		     &chip_select, &max_speed_hz, &mode);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse chip select\n", "new_device");
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
+		dev_err(dev, "%s: Chip select %u out of range (num_chipselect=%u)\n",
+			"new_device", chip_select, ctlr->num_chipselect);
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
+		dev_err(dev, "%s: Invalid mode bits 0x%x\n", "new_device",
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
+	 * Serialise against spi_unregister_controller() via add_lock so
+	 * that the dead check, __spi_add_device() and list insertion are
+	 * atomic with respect to controller teardown.
+	 */
+	mutex_lock(&ctlr->add_lock);
+
+	if (ctlr->dead) {
+		mutex_unlock(&ctlr->add_lock);
+		spi_dev_put(spi);
+		return -ENODEV;
+	}
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
+	dev_info(dev, "%s: Instantiated device %s at CS%u\n",
+		 "new_device", modalias, chip_select);
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
+		dev_err(dev, "%s: Can't parse chip select\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1 && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	res = -ENOENT;
+	mutex_lock(&ctlr->add_lock);
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
+	mutex_unlock(&ctlr->add_lock);
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
+/*
+ * spi_controller_userspace_group is deliberately NOT listed here.  Attaching
+ * it via ctlr->dev.groups would expose new_device/delete_device the moment
+ * device_add() runs, i.e. before spi_register_controller() has finished
+ * bringing up the queue, matching boardinfo and registering DT/ACPI
+ * children.  It is instead created manually as the last step of
+ * spi_register_controller() and torn down as the first step of
+ * spi_unregister_controller().
+ */
+static const struct attribute_group *spi_controller_groups[] = {
+	&spi_controller_statistics_group,
+	NULL,
+};
+
+#else /* !CONFIG_SPI_DYNAMIC */
+
 static const struct attribute_group *spi_controller_groups[] = {
 	&spi_controller_statistics_group,
 	NULL,
 };
 
+#endif /* CONFIG_SPI_DYNAMIC */
+
 static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pcpu_stats,
 					      struct spi_transfer *xfer,
 					      struct spi_message *msg)
@@ -729,10 +933,10 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 		return status;
 
 	/* Controller may unregister concurrently */
-	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
-	    !device_is_registered(&ctlr->dev)) {
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	if (ctlr->dead)
 		return -ENODEV;
-	}
+#endif
 
 	if (ctlr->cs_gpiods) {
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
@@ -3259,6 +3463,9 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->bus_lock_mutex);
 	mutex_init(&ctlr->io_mutex);
 	mutex_init(&ctlr->add_lock);
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	INIT_LIST_HEAD(&ctlr->userspace_clients);
+#endif
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
 	ctlr->num_data_lanes = 1;
@@ -3552,6 +3759,24 @@ int spi_register_controller(struct spi_controller *ctlr)
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
 
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/*
+	 * Register the new_device/delete_device sysfs interface as the
+	 * final step of controller bringup, only after the queue,
+	 * boardinfo matching and DT/ACPI enumeration have all completed.
+	 * If this fails, the controller is otherwise usable, so log and
+	 * carry on rather than tearing everything down.
+	 */
+	status = sysfs_create_group(&ctlr->dev.kobj,
+				    &spi_controller_userspace_group);
+	if (status)
+		dev_warn(&ctlr->dev,
+			 "Failed to create userspace client interface: %d\n",
+			 status);
+	else
+		ctlr->userspace_registered = true;
+#endif
+
 	return 0;
 
 del_ctrl:
@@ -3616,12 +3841,48 @@ void spi_unregister_controller(struct spi_controller *ctlr)
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
+	 * Mark dead and drain userspace_clients before __unregister,
+	 * since spi_unregister_device() doesn't do list_del() itself.
+	 * With the userspace sysfs group already removed above, no new
+	 * entries can appear in this list.
+	 */
+	ctlr->dead = true;
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
 
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_unlock(&ctlr->add_lock);
+
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_controller_idr, id);
@@ -3641,9 +3902,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (found == ctlr)
 		idr_remove(&spi_controller_idr, id);
 	mutex_unlock(&board_lock);
-
-	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&ctlr->add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..628b3466cdf5 100644
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
@@ -555,6 +561,14 @@ extern struct spi_device *devm_spi_new_ancillary_device(struct spi_device *spi,
  * @defer_optimize_message: set to true if controller cannot pre-optimize messages
  *	and needs to defer the optimization step until the message is actually
  *	being transferred
+ * @userspace_clients: list of SPI devices instantiated from userspace via
+ *	the sysfs new_device interface; protected by @add_lock
+ * @userspace_registered: true once the new_device/delete_device sysfs
+ *	group has been added by spi_register_controller(); used by
+ *	spi_unregister_controller() to know whether to remove it
+ * @dead: set to true under @add_lock when spi_unregister_controller()
+ *	begins teardown; prevents __spi_add_device() from racing new
+ *	device registrations against controller shutdown
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -807,6 +821,15 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	/* List of userspace-instantiated devices; protected by @add_lock */
+	struct list_head	userspace_clients;
+	/* True after new_device/delete_device sysfs group is created */
+	bool			userspace_registered;
+	/* Set true under @add_lock once spi_unregister_controller() has begun teardown */
+	bool			dead;
+#endif
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

