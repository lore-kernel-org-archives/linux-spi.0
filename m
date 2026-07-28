Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0644C50C;
	Tue, 28 Jul 2026 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265891; cv=fail; b=R5MTs6Kx33ewOqPj2tvt0rzAa9i65JAypxvTZG8Xas0gUe/qbxTkesvPfacPo3vBjjz4J5vv5bCXA5EZvF+6zMeGX+d2YN5vbvhWXR1YqwrDlxbALNlDmaydjhrgUAy2fkyVsQPI3ryGL8VUDQZDZOJsmWtsloRD+9l3wpxP38U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265891; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBKmvU8M8nl77w+g7B+pC8TdQnhS5Z5RZgxe3FPdhNVfPS2f6v+aG4rN8R+EcqNwDKjLOW1CbMKpz9+jR/r0piBigMmkWGrArzrRYR/k7YCL4RrAtA0N9zD6fajTAfjRu9vQAD9Lc96VUW3d9bhQEr75JLCb16Ew3KiNR73UfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=moqH2YVU; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="moqH2YVU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dStHrVaWxTjAdBK9khlSUEQjZsI1oRotLXp4ri648kCvDa12u54UbMdtXiAJOE/Ix6p0nd3TEk3yxIDMeIvQlB20gR9NrdLjLFfVYKmbMo5BqJMJscGlWDhoJGKOxZxRC4B/g5p7OaA4WulkjhNjru8WO0LUww5LGRDQRTbFflIWXewYJ9psUgyt2juaLEVSEudJtkfPfRuSfISEO9Ye/iteBiR60lCHBSNL9hN7hPNy+qxdC725PIqV1+NuOSJX4+fxMopaAbFuncTDYPBPsZm9e/Sm0VpUJHB4pCjMYf7i8Exwt3nvgrYsjpVlrtnlDV4omLGvN3e5Niv1lm53Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=kVlC+kOLp3aWsRHyWN2u7EWjUW2RmYkLDa4InS7MQzYf/aIXnxOkUaU011rrFJZ2glAix3dSXTMrn2U2FR+QIKUtjxtMuSoZYJRANCKwphqPJZkpt/evqv2Bus/0uB0kPi2xRsnQECbZ4q+37+OXoptc0mG6SiZn4lD9l7K96NKBvLJG0GFqPox+t6Pys8Lh2QH1/lz4KaLb4NFX9BUQte6UEVaAuG67dG2e21TM0Oztzdp8+mYKqbiHEf7mzpe/LgKovFWmjCMzKEM5WXWwSDXrQs4LK4uMSRkWggtcnrvSjdXb56h4LWrWHcpY4ua5vCMtCZOzoBnE5oqXoHgKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=moqH2YVU+3HceWuo31ftZAfG7srJYG3RyI5tdpTo3+9ZQbLYkpWHM2MPH8OmIx46Hh/Nrex4u8k8/0xvQ/liWk3xpe7VCSaLyuiOw+eXqVhddjrLKWgYjDpooRovVc3NpxlsZ/TetyQFiOmRlSzjaXydG7e5v3Dwlt+xvGf54VpddvJR4XTqedH98veMslM0boNHwFdnWMnw8o+Y5Vt1vJAgfauMcp3+lhIMf3gxy2qWJWWwHpfUoCFMcF6qMb1ZDQsXn9Aqq90Y1eWXcUFiyqWEAAYc/gIZXo7ajmSiXWJW7lvNs2Xljwgc/fWKLMLTljoUKuEdKLVKIsgXNnnidA==
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:11:23 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:610:5b:cafe::7a) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 19:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 19:11:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 12:10:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 12:10:58 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Jul 2026 12:10:58 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH v8 2/2] docs: spi: add documentation for userspace device instantiation
Date: Tue, 28 Jul 2026 19:10:56 +0000
Message-ID: <20260728191056.2337791-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260728191056.2337791-1-va@nvidia.com>
References: <20260728191056.2337791-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c93282-1568-497f-ee7b-08deecdc0386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|30052699003|23010399003|36860700016|1800799024|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	74h/2HLPbWotmvncHbw+zouDrNWgvmh6ZmUtVKQzPYTdibqMdZJqsnblFs8y+oeXMiWDXFMA54wRWuulPkId0XVSeXOB7JsdfsEfzPydHM6TZlcLNVsWwG5S4GekBxqQyl+8KY5+m5vojfL6iZscV82PX34t7a7ifyFv9oiRk9XvkWMF8Kn38R1JWdWXkQ7yIoRcbGCYayl7HKV5FaXF16qsZ24A36nOfyJJisJza2Ibw+jZ+LuLX76Ku+wuYJjc34a4CGwQX0kgkWCzabLCv8UcXZ5Xpit89zWd99uamFAywh1v3YPxHY3xbtGpeZA+9xWREtQ4DS9fy68ItEpr0oY4L4b/5TIxYIGb4GieBU612Rj5Onzx/SAUe0tvboPcGup33mdSywqW05iJV7MiAK3Zb5I2k3BNqucze8H0HN1zNsIDzyXfYbmY2XXWFpWz1u/T6UbWolGFwiU5CVhuhmFB2tBPbHtA0H9NyaFYmEIkTuct+WAcPTbg6jCtLIbDdhZHeQyj2Jh+YcbHa4zWrIRaIUEsKod9kP558Uh8BmyPExqtjDbfWONK0WG0Tmxz9Sa6ukoDcCxNXTtgbFbHKk12MjW7Tu0NhwE610Mj9QLHWHQczZTltyUuInv262Yej2DoRdjR8gixSGLqHmjLG6PKrN9xyuu1ArN8h9G8tuveM8O04Nqb92Ytj6zJEIrr8/IJ0hWIDjKGMiyUo/fsYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(30052699003)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l/qBR7U8ET67QsA0pSkuOpWjap4dYgKPCsHgZgUqr1Jjgnu3HigAHuDyZr5KDCJI5MyJFyMlzPU/lbt3gDQ6jISKV6KHhpZvGsRJ4ThxCR4GKXWX1KX8t2C1E7eAb01R5mUeGbbzd51X8KoNhhozPHsn04j/kTcRL2+vR7QyrC82VIkYf3TJ2CQycRzioRIfO+hIST8Lw4YfrkjrZhSZ2YzZHMrL9rriywBBCUgwtqHV1xyBEm42KtLCjm9sqFDVdEiIa1Iy4enJ9oHmHUd5el+ESJGa76IwpvQn3fYZUP6c4P/DVsMGDTe5763zV7d3tUkzjJkDQABfQQSoAExc1vyu9FDx/T9nsu75HnP4GFN3t+gpEJUo06KHSmbZ0MEH03Z5zEJehy++aZWy+9PzJaYWcJm7GwwXpa8toWzW7ReG2Jfd69YlVJUxb3gwcC3M
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:11:22.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c93282-1568-497f-ee7b-08deecdc0386
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

Document the new_device and delete_device sysfs attributes on SPI
controllers:

  - Documentation/spi/instantiating-devices.rst: describes when and
    why this interface is needed, accepted parameters, usage examples,
    and limitations.
  - Documentation/ABI/testing/sysfs-class-spi-master: formal ABI
    entry for both attributes.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 .../ABI/testing/sysfs-class-spi-master        | 34 +++++++
 Documentation/spi/index.rst                   |  1 +
 Documentation/spi/instantiating-devices.rst   | 88 +++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

diff --git a/Documentation/ABI/testing/sysfs-class-spi-master b/Documentation/ABI/testing/sysfs-class-spi-master
new file mode 100644
index 000000000000..b498be128bad
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-master
@@ -0,0 +1,34 @@
+What:		/sys/class/spi_master/spiB/new_device
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	linux-spi@vger.kernel.org
+Description:	(WO) Instantiate a new SPI device on bus B, where B
+		is the bus number (0, 1, 2, ...). Takes parameters
+		in the format:
+
+		<modalias> <chip_select> [<max_speed_hz> [<mode>]]
+
+		where modalias is the driver name, chip_select is the
+		CS line number, and max_speed_hz and mode are optional.
+
+		The device can later be removed with delete_device.
+
+		Only devices created via this interface can be removed
+		with delete_device; platform and DT devices are not
+		affected.
+
+		Example:
+		# echo spidev 0 > /sys/class/spi_master/spi0/new_device
+		# echo spidev 0 10000000 > /sys/class/spi_master/spi0/new_device
+		# echo spidev 0 10000000 3 > /sys/class/spi_master/spi0/new_device
+
+What:		/sys/class/spi_master/spiB/delete_device
+Date:		April 2026
+KernelVersion:	7.2
+Contact:	linux-spi@vger.kernel.org
+Description:	(WO) Remove a SPI device previously created via
+		new_device. Takes a single parameter: the chip select
+		number of the device to remove.
+
+		Example:
+		# echo 0 > /sys/class/spi_master/spi0/delete_device
diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
index ac0c2233ce48..3f723e2c07da 100644
--- a/Documentation/spi/index.rst
+++ b/Documentation/spi/index.rst
@@ -8,6 +8,7 @@ Serial Peripheral Interface (SPI)
    :maxdepth: 1
 
    spi-summary
+   instantiating-devices
    spidev
    multiple-data-lanes
    butterfly
diff --git a/Documentation/spi/instantiating-devices.rst b/Documentation/spi/instantiating-devices.rst
new file mode 100644
index 000000000000..9ed08d94ae01
--- /dev/null
+++ b/Documentation/spi/instantiating-devices.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+How to instantiate SPI devices
+==============================
+
+SPI devices are normally declared statically via device-tree, ACPI, or
+board files. When the SPI controller is registered, these devices are
+instantiated automatically by the SPI core. This is the preferred method
+for any device with a proper kernel driver.
+
+Instantiate from user-space
+---------------------------
+
+In certain cases a SPI device cannot be declared statically:
+
+* The ``spidev`` driver, which provides raw userspace access to SPI
+  buses, explicitly rejects the bare ``"spidev"`` compatible string in
+  device-tree because spidev is a Linux implementation detail, not a
+  hardware description. Vendor-specific compatible strings for spidev
+  (e.g. ``"vendor,board-spidev"``) are also generally not accepted
+  upstream. Device-tree overlays do not help here either, since the
+  spidev driver performs the same compatible check regardless of how
+  the DT node was loaded.
+
+* You are developing or testing a SPI device on a development board
+  where the SPI bus is exposed on expansion headers, and the connected
+  device may change frequently.
+
+For these cases, a sysfs interface is provided on each SPI controller
+(similar to the I2C ``new_device``/``delete_device`` interface described
+in Documentation/i2c/instantiating-devices.rst). Two write-only
+attribute files are created in every SPI controller directory:
+``new_device`` and ``delete_device``.
+
+File ``new_device`` takes 2 to 4 parameters: the name of the SPI
+device (a string), the chip select number, and optionally
+``max_speed_hz`` and ``mode``::
+
+  <modalias> <chip_select> [<max_speed_hz> [<mode>]]
+
+The modalias is set both as the device's ``modalias`` field and as its
+``driver_override``. This ensures that the device binds to the named
+driver directly, bypassing the normal bus matching logic (OF, ACPI,
+and ``id_table``). This is necessary because drivers like ``spidev``
+deliberately exclude generic names from their ``id_table``.
+
+If ``max_speed_hz`` is omitted or 0, ``spi_setup()`` clamps it to
+the controller's maximum speed. If ``mode`` is omitted, SPI mode 0
+(CPOL=0, CPHA=0) is used.
+
+File ``delete_device`` takes a single parameter: the chip select
+number. As no two devices can share a chip select on a given SPI bus,
+the chip select is sufficient to uniquely identify the device.
+
+Examples::
+
+  # Create a spidev device on SPI bus 0, chip select 0
+  echo spidev 0 > /sys/class/spi_master/spi0/new_device
+
+  # Create with explicit clock rate and SPI mode
+  echo spidev 0 10000000 3 > /sys/class/spi_master/spi0/new_device
+
+  # Remove the device
+  echo 0 > /sys/class/spi_master/spi0/delete_device
+
+On systems that need spidev access at boot, a systemd service or
+udev rule can write to ``new_device`` after the SPI controller is
+available.
+
+Limitations
+^^^^^^^^^^^
+
+Devices created through this interface have the following limitations
+compared to devices declared via device-tree:
+
+* No interrupt (IRQ) support.
+* No additional properties such as ``spi-max-frequency`` DT bindings
+  or controller-specific configuration.
+* No platform data or software nodes.
+
+For ``spidev`` usage these limitations are not relevant, since spidev
+provides a raw byte-level interface that does not require any of these
+features.
+
+Only devices created via ``new_device`` can be removed through
+``delete_device``. Devices declared via device-tree, ACPI, or board
+files are not affected by this interface.
-- 
2.17.1

