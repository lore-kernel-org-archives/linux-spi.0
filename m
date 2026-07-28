Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32563093CB;
	Tue, 28 Jul 2026 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208013; cv=fail; b=FJGqbm5I5jQVtrcsXATK2d8/H1GgFcSNkA8vL4xr4t0ZVv5Ggg2q6HZHEUUkEmeg14/RJyT9JT+g7LUNjqsk1A3kSDt2a+QTGOCdZx9dG91+0iygSwHzjl6xh12ob23QgvYBoAFx6tMbqmfLRBAAc7FngJs8Exl9JvyDbE5pnXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208013; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq0HHsTLRWRutPwqRBuKpokP8pP3VgMbz10XzjHT7N1HkA4xqGTqqadsp1R8KbjkQgMBKjT0k6y4BiLPeYTWNqtD2qarzRpKkjVyhm7VL74E5PtGyPWdwDI1zpzOqMuyhDrV3GgZJBgcR8LO0+J+DY0NpEgSndBJzMQ+jSbXnlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1+H+uTM; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1+H+uTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpagklLeclXIbZPTlCz178EZ6IFJuAXAQvaLla6t751ISuT5vXP9yybFBh6St/3Do1tNZHeMgc7oUaW4VUyU+9EUtFMh7OT7lUh5/u2IvUysWHOyf8KLmFKFVHnJBiEZR2433+BMBEmcXP4kw8FH70XlOpOJ/umevsGywtu/XL1Seodox6EEC3dTJNl4LEN6972hiDiCVjlCZgqQKN2JNJdfn8LsFPt7Lc8EN6KKZpvYt0PVxarSdH0/at9qewKY8iCzc/jXpA37Xg+1CfPpTduV01grPrMhczkRLLxDvHlqoyLxs/fus9QSwCyg2otV2wJ7uREPGfm2ZtRwsOQ/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=xCfehaNAQqiaFcJzHgC9bIejPwyPHl+erAhmfc6qbTr7/ebPCE8c4CX1O54x9TmSAwUj0Iz+Ej6/+C97udmIPUS9NfGONy6Bfzo+4C1wkzuXCy5ZTaGhr+fFGAttawagbpbuy/t+MZ6wYcDtW/ESVexbthcImBS8rrMnmFXia0g5JNEOTYSxIy0yXGmkgULZd42eYv0gtug6//rYYSv/j5NkoBXTjO3SHhjegSt1WccAnluWpntmkxoxkqmN8/m7XVS9hxQuCUsAoKmtHB2QJH+y+6S8IdmWppsAhGyveBkRHVAJ3ALJkDGCDdHUOptvn1a/KADQCh8XzWICAL+Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=s1+H+uTMbnnY1nhwJcVBBJTural3CtFU2mwB+85T2jmo0/FL3Fzl/V3w+Xf7NM29OPEyy966QZ8yc5TWRXgHDwos6K10gBuuCZSUDW90c2U/Y0behNAVfHw1e1dwRKBw/jiWFf0sQPsVb2fzf6xL4jvF/84bUylDSAVOs3ihrk3M7lYTR1IQd6lGVY3Nk47PiamiNmajIZgJt8+bSB0RmSILnHjtZYPlPVsN6pxwB4/G8YGh3B8oLl4VzDJqCOLpSg4zFReMtkSFQVkDsqrbaxUFAsCaBq1Bx6KA1f/282tmV6GONPUtuGDIu8nXPJ36Tk7fazRYFVxb8ODnYzEQSA==
Received: from IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::7)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:06:44 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::77) by IA4P221CA0003.outlook.office365.com
 (2603:10b6:208:559::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 03:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 03:06:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Jul
 2026 20:06:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Jul
 2026 20:06:33 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 27 Jul 2026 20:06:33 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, "Suresh
 Mangipudi" <smangipudi@nvidia.com>, <linux-tegra@vger.kernel.org>,
	"Vishwaroop A" <va@nvidia.com>
Subject: [PATCH v7 2/2] docs: spi: add documentation for userspace device instantiation
Date: Tue, 28 Jul 2026 03:05:41 +0000
Message-ID: <20260728030541.2279518-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f75ad7d-bb32-42ad-7191-08deec5540b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|30052699003|36860700016|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	JI1pgHIpMGOKtSIybX153EZebNjFBiLc64Ou62r0ISVma3UDuIX4eDhjuQgMll1n24jGJBoKcgHHphDwAJS+R88F4hBvI4WnS8JtR1NYne9DrTI4BxfxdQmXuNemdfjcAd5u7LrVaX4uQapt7TnNdvsSA4H7m/2JeWQJXNuImqS0xtdmZ2KUlvCBxaX65nry0wJ5NBYGD3hkd5eNwoUfJKO85weqv6sRsK8Y6JxOYJnBI1icpVNvhEaKzxdHxjkVTAEN44fzXjMg8v/q3/iPmcIk20DUoThlE2Jdv6Rswq0WV6KAJ9zejhBuWYzpJ8n9NeNPfM4O1GzmIkearTbXH4yttKCXb316OjcBD9VFjz88ar6Kiu3kd/sKNrrnkz5e3LhnDTYQfMpDHNtPEWSrdl34fuCFQCqMLiL8NpnMUDYU7i4wKk5vvCQ+ckzkrBaGGSmnrXpT+emrS3yw6AczXX17qhSxjnBdEqkc0PrsHfzSVJL8itNjcsmG988hxMLtobE+syiKCAcda3WQ4+/hkUiJ5IAVfvVGJBHoIcP9ftRK8fj2oJTVyOQsRsEgc6S+iuhufRRCKhiNZyx4sT6PRyYL01cOS7XBL3a+Gidvb0zi6jc7dalGZaoVki2rxI+l7b2NpkVfDzeo8XhaK9MF0VRjx9nwb5SkYpfuEHIUUlSPuIF1wh8Z+QxS60TUupV8/TOyNwWk/zyIefbDTtAV6g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(30052699003)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5wXhmEnn7YVPi5LDWzgvqMCBLCSEaeHjMsZCuBFehai1u+M+4XeE+7zWxEWgG/jQbCY1J6NsimV1T+Va88aOzSWand4qKVgvlxzezDby/iqytLVwOKqOSV6b8YFt6YpeDBp+XqhJCSmxM/sNcWMDIiO9UDxXnQZKBgPLE2shWOh/F/GdfLFO+5hwVhz4E30W3hmYfiee/sd9oJvG3MIaVsLgRQMMP/sWtGTZs4sICp0tqPeJ/w1yuM+4WB3mIjZn1HuznwqX5RUakU+bt58FzT3a3lnQXZ1LhCdCaG5QnIudzGJl4IhBEGpr1eGxrLWHAcuECKDrko+Tq2zIIYEQFd7TinhhOVCa8Ui+KHAkX+7kbV/FOagOaU6KFI0A6Md2aTh2U6GVNSrXMB9x8ApZQ8UGKx97I5k+f00mbQMgPSrh2rAxGWm9qPws70GRr7t8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 03:06:43.3399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f75ad7d-bb32-42ad-7191-08deec5540b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748

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

