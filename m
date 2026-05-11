Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A053D8915;
	Mon, 11 May 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496030; cv=fail; b=RT2oAhYwhJTo9Bnb2W5jFHwndmYHLb1xH7VIVZbBWZICvhp24ModXNrv+lrpNvwjX+MgiBhyaILPQP5A6AtDkNmwXgDXi5CH5p/0QS3YWNwZDzRkIfwRjojj7IzeXSheV8OsNJCBCCiwkIdeLvRXAkvZYkcSh2cFtyvkKMJ//tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496030; c=relaxed/simple;
	bh=BzZorCHjcPI8VPH0yxqJ8V9DEBkTOuHPWBrATACgArY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnfHuIWZmgwJxxm6XPDnYiPw0UKT1PmNiDVGpCB530H//dZy6vahwZNm7Mxc3G0qLU24ey2CobB3EO4vgAU1HPAsYCLF4dfJiAdDvafr4rL2oQ56HWsV1diZpJyRBbpWQhlApu1IPE6WTPj7s8rtem9/lVjH8UHyf6XwaJK/Lkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJqqL1A9; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJqqL1A9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVjB6C4T7YWRy6kDF6PWwY2NXenVRorgGURKzosTYMy1u0orkw/vApEYY9N+MZ6CbVjgWVq9h4qV+gDS2Kom33nfU9lJnNpI+I2QjwlIpQTlpnHVAFTKGMxT5ku6vvgCvX5RquDnbZQXhIFdSat+qEPkxzj7dM9Kr0E8WPUcolhUFZvxfvSOvZeQmbMr0tEmZzGO2MF6FIerujxG0pPBbGvKDr4qd28eFoU7NikF+kRb9l7TcDd2PvRLg6pE424XZozmHrZJVmN5dURA5zqg4G/ZwxX/FuFVVxlBxGdyrHNS3Dt9AEY9JNXz30I1F9jESktYUTay1yl7cmg/xQ2DAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u4NklnjgaJN3ZYbzspBD5toOu8HzCNGXkwxPvR1+K4=;
 b=MYbyMmXpC9PRu6NnjnaER3rVRWj/4kxi0pnB1TmQD2XDX3aa3Jwkze53bsAGhL0ZIsY2qN1zvRqjdIXpGFd1mJwkdpcQdCypTvjH1IW/ELNwg6o9HblqmoKgANsQF36sIjWvx+PeBx2310DPKevfjxSIVKoauqxJZOZ3eLSGfAlGmklCbVnrDA0XCunB2J5tDQioeuzPEJJkG7n0JJCJ1l8/LQ8aMa9UrX71z60secY7r7K0q5Li61c3Ob6NvK0mnP0MS1wE7g5thuRSq8rMLv0vnj356ST3VkPNEoafFI8NF3tXYTEtMqcV8RIBN0pNKfPGABd1muGfumLTwwsqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u4NklnjgaJN3ZYbzspBD5toOu8HzCNGXkwxPvR1+K4=;
 b=kJqqL1A9J5ArWdJPkcAISfx9ijD0P1F9rHBcrRteg3y8Q/euUVINIURTP4JR8u4IYm8Js4HwUigm2oiwBlL7MahlPHbShLw5l3RISl+D3UCSJINeqzZFGX0uWtZBc5A/bzY7YRVMHFqpd/sImKJ9kr9UlodXpB3DzTpEQ4ohLjWgXxg8HThdcZKQ3P65fIp8H9sMQI9uEPcTdbYJd26fJD9wCU+xaQoUH2olb0dEPdx1im44bFRcTsxvji5BMFnmVOP3G/ZwFi+q0NqQfp4VHLO372ZwcooMpVbfLjNTIR9pILWvPpseE4fgyx8w/DVpcen6fm3dU74pNOIMLyf5Pg==
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:40:20 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::61) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.15 via Frontend Transport; Mon, 11
 May 2026 10:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:40:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:04 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 11 May 2026 03:40:03 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v4 1/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 11 May 2026 10:40:01 +0000
Message-ID: <20260511104002.976269-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260511104002.976269-1-va@nvidia.com>
References: <20260511104002.976269-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe2ea3d-2800-40b6-ebdc-08deaf49b2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|30052699003|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pxlOjVTY5f87Al5XpRscp6Zuz0wygeOxpwt8dqVPnwsgQ4BikL5Q5IkpROFTi++FGnnOoK9g/nDN5eCle0MUC3J7+60y6Q0oL0z39H3E7xua3rG6e8fTwm0QAT0OrxBXlv/ESREq9eC9SuXXR4f3Y0J7BhdraFakvCALTWur4h3vZ/+SY0oiuZyH8I9OT74XYix2MoSH3EUMcgzvvhPSmL31q/nBEUDmMeRR4eR3CE6pfYxO3vAyj8O0uyE/cOeMrvsDRIuYw1gHAWQX7aJvzZtWa9wSjxonQ45dOZpAiFq5RN1PnW6j8wtBO/+ECldtW+eFym5WDZs/wqKCd+9VZXHcjxdcnb1TNsmL03U+dF1HpyNdVb0gonEFPulYRA6heFpFszFdJhRjfJdKQqChLUpQ3JF5ZKzu+IWeT8ab0XBlQhvvMVF8q3/K9l7ZBAzZhlpCXWg/jfR91Kw0+I/j7YP5qBzJMD8UEu0A3ZUce5MCYwAmt2vCihB76skw0099axCgKSRSTmmQRDq4gYoO2+/HzmPm1i55vG9YswZXYWIixqTCoZG24pC+nwyF+2a0I5QIwkSIsa3ZAzzl58s26pq3ZQVm9jLb49h+ysCka8pfb8wfZ0G9TBBT37FMYD7UsXvKAdTb49gtbT9vn3k3p+PV4fHDK1W5sNbwo+bjfWWub5w7sDdhj222ctUXqCHFpI/wrV7geZjcAOsDYiwZcx2wEr2pbUurGeBeyvFwSeQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(30052699003)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XT5X3r1dNYzHyUAaTqlrzX/mVxrrKuRomI7JpiAmoYxWS37ohZ99loSZFYXW5iiHTP3ktYQny6oO7CbOvh0imCTZDUqcb0glkK9rclJwpckwpElOBU8ip4XVowDIWX7mm3fqEOYYZ+vnjHJmDrteYDbi9iouQf6e5saRGj77KMeZF7dZdjQJDrlXzpX4V+5hOF3N9xopclIWiBcL6SfLpJHbZkC7SrcdQW49gpS09C4SvLoAh9sCkgRjRNSRBX5MIxmVaWwlZxfmTIyMvczzZ6ghcQCPOK1BJqvM45CcK/w8RUK36sgmHCCULNsd+yn+pKAi3x5YtO9L9VxeLPYzk0C4j/0QCKaor3Rx6PM0jrDvB88RxjI/sn7to7vs4/+VPLZW4K7kpoYEnN8wXeirY+ROt4eVtzdI4wPNjNyucA8L1xOtPS3TbYWk0scnAs9+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:40:19.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe2ea3d-2800-40b6-ebdc-08deaf49b2cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

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
 drivers/spi/spi.c       | 216 ++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi.h |  13 +++
 2 files changed, 223 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7001f5dce8bd..2b49c5fec1d7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -296,11 +296,187 @@ static const struct attribute_group spi_controller_statistics_group = {
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
+	/* Extra ref so concurrent __unregister cannot free the device */
+	get_device(&spi->dev);
+
+	status = spi_add_device(spi);
+	if (status) {
+		put_device(&spi->dev);
+		spi_dev_put(spi);
+		return status;
+	}
+
+	mutex_lock(&ctlr->userspace_clients_lock);
+	if (!ctlr->dead) {
+		list_add_tail(&spi->userspace_node, &ctlr->userspace_clients);
+		mutex_unlock(&ctlr->userspace_clients_lock);
+		put_device(&spi->dev);
+		dev_info(dev, "%s: Instantiated device %s at CS%u\n",
+			 "new_device", modalias, chip_select);
+		return count;
+	}
+	mutex_unlock(&ctlr->userspace_clients_lock);
+
+	/* Controller is dying; clean up if __unregister hasn't already */
+	if (device_is_registered(&spi->dev))
+		spi_unregister_device(spi);
+	put_device(&spi->dev);
+	return -ENODEV;
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
@@ -724,10 +900,10 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
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
 		u8 cs;
@@ -3256,6 +3432,10 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
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
@@ -3633,8 +3813,35 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
 		mutex_lock(&ctlr->add_lock);
 
+	/*
+	 * Mark dead and drain userspace_clients before __unregister,
+	 * since spi_unregister_device() doesn't do list_del() itself.
+	 */
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	mutex_lock(&ctlr->userspace_clients_lock);
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
+	mutex_unlock(&ctlr->userspace_clients_lock);
+#endif
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
+	/*
+	 * Release add_lock before device_del(): holding it would
+	 * deadlock against kernfs_drain waiting for in-flight sysfs
+	 * stores.  ctlr->dead prevents new device registration.
+	 */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_unlock(&ctlr->add_lock);
+
 	/* First make sure that this controller was ever added */
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_controller_idr, id);
@@ -3655,9 +3862,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 		idr_remove(&spi_controller_idr, id);
 	mutex_unlock(&board_lock);
 
-	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
-		mutex_unlock(&ctlr->add_lock);
-
 	/*
 	 * Release the last reference on the controller if its driver
 	 * has not yet been converted to devm_spi_alloc_host/target().
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7587b1c5d7ec..7a86749d2701 100644
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
@@ -809,6 +816,12 @@ struct spi_controller {
 	bool			queue_empty;
 	bool			must_async;
 	bool			defer_optimize_message;
+
+#if IS_ENABLED(CONFIG_SPI_DYNAMIC)
+	struct list_head	userspace_clients;
+	struct mutex		userspace_clients_lock;
+	bool			dead;
+#endif
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
-- 
2.17.1

