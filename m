Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074F37F01C;
	Mon, 20 Apr 2026 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776654879; cv=fail; b=l2rddynNlBerDCnIBEe1LqkE29MX/QwF5sMo5SH64JZOMH5mLRGcOULZkS5Twz9eWMuH1KzBjRh+DKkdoe9TAuQ7RHWDFW7a+f/zoHNsRzEbX791RLOZABUOph+J+hv1Bt/ehPhi6Dra6ZFR/4a/jaERkd744vnTmAgHaeIOG48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776654879; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQpVv1F8MNGuiIVj+bQj1Vyjcvr07YYutzExHpMi7lxpwsab6vJ+hCuDJHqVtMG8Q9HE9apFTO88rAxTd3aIeYnkxSCvot9ltX6312QhkjJeGt9iSqsWSYfGKtRX8dwqZ+mE6amUoA4p8MicQgjD7cLK9bct5kV2TcF+4BBl9FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LkylvyE5; arc=fail smtp.client-ip=40.107.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LkylvyE5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj4WbcKXwtmrV3/lt+4l9Zk1dpj798f3OfRGhx0pJGSQy+N2UtI9/hN1GYDqGWRWWlKKxf+qZGQfU/5HXdM4blz/rRhWWHCN/vhV8u/VJr26bgMz2pQLckyJC8xrk0sbQevPFF4g1EJMVcJuDuIvsCqpV2ok63/FZZxNsvo6eLecr/eaJToXWn1uDalUEx4OL+70ONsYij162WOa4xYwj71B++jPOCg/H2BqKWO3dFOUsk3mCJW4AII1ORaB3gguBm6XnqCefBhl0443kr7DuJymNBCDI8QbZDwneviUISyU0EgJaX5MbEnNj8oVYfYt3NH0Aq5zsrgdC2zHmGUEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=eZ/KgDaAzubHedTKwYx0yIvYqWApg+Fze00WDMBpmlghYpk+/LTw59QjXHcTPpoGI7PLiTpVEGaTuiCjFBtDQnw6HdLb9pDiLZ0DBL3mu2GwonI+KVfziyvNAZfoDIQD8oI6nn+Ru2aUzy6kVo2//wRGkCK88XlaR7zlKCgXvXlUwN8AwQiWTmp6liBXN7A3/JI1/COIkG2UipDb2wuDHqiJYQUMvP6qThvFCHGztU1B1TVeyKtxlYDz5MFQGKZtcHObDgG2cUcTs+1rrOio6rWpE9wL2prftv5dNp6ZHa3Tr6ciM3QtnEQot9PB7NLSlTlSOCLgkboyVgTfE+/2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=LkylvyE5pMI6KLw86rRsgv9sp2HA6iobjeOnC1ojiEmSoWKG4pr2ovozVC7nBtK1uAHHegAOMvJz1n7x94FgAKqjYHxgveqOKZqiuB1rv40aq50jA1JjClApbygYKD6A/VDWOW/P1eVX7+DUoL86E0dO89fm1REMwXR4m0UWmDovsobFxWTYHKhhw3f2QwdrL2UMLJ1gXPNoOmuIoX4r7kFjdPSducOFPJUIr288uN9CwlQnCSDgLv36AXj2l1HW3HZMgN2JnQ3UH/WihZJtaFL4ugHH33A9PUVcz8kuqry5QvIkpMf4jgqcoj1Ydqjs7VQvSaFD6U0eQob5dEp8KA==
Received: from SA9PR10CA0001.namprd10.prod.outlook.com (2603:10b6:806:a7::6)
 by DSWPR12MB999154.namprd12.prod.outlook.com (2603:10b6:8:36e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 03:14:32 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::9) by SA9PR10CA0001.outlook.office365.com
 (2603:10b6:806:a7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 03:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 03:14:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 20:14:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Apr 2026 20:14:19 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 19 Apr 2026 20:14:19 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH 2/2] docs: spi: add documentation for userspace device instantiation
Date: Mon, 20 Apr 2026 03:14:17 +0000
Message-ID: <20260420031417.291442-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DSWPR12MB999154:EE_
X-MS-Office365-Filtering-Correlation-Id: 841aec9c-d3fd-4acb-40c3-08de9e8af0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SD9MMt6OXBPCawTvrpGCR8CrR07QqKWssnjHvzkCIdGkECuxDnYe2HOyHAmSce8fY205DXjoEsmXhW2WznfohrPnlpnLXpXAJPYlOC3tCx5btViDzqiOlPT7GkCalVVosXXtrmtpuNDDlQcAVDFHn6RMrgdPdlj+RvWLCjMPGGeb5hiVAnNB8o+u85JeXi/TEDcDi1C4UV+kInVXiof0oNZAlzGQRkfr6wL3Igc4dIlVNbW3eybIvNpRG32Aehui6BVA+Ph6bSertFOKRk/bgMdnyWxGFcp+ArYX7+lR6T0BpDX5VIWFpl/N2WIONN29GAh+SDSmi7/E9wWaQ3bh1W0Oohk93rl4Bfvdtfr6yzbU2WfsXp14Ft1uz+E0kbCtP+uTg3vBtI7J4y924W5TS0tKSikDnqfbC3f2lc/6Z4Oaaigh46ojeuNrycXEN8AVkeJusET+1MRD4y0SvlQWRxIVtZ/ly1/fGjXmZuXdQT0Oi1HB1IRv0Ej9Rh4s9mr/t2Q80rKhx7rR08rLLo6LayYzbeQ/tkjTKKryKANQ1e5Mp/nBdc7PWzNJGHNYT7vX82R2iTgbXQNzz1WEiHMm/sBmflafF+ew/4c9X8JJVlnb2hnDbINJjKEkvcCAxkJpHmovzd/Z+P48/gkxPSyXxx/7QWSsE6bQ3w4HvYa8QTw3JUJ3e96pjns1AnC9yUiZxq8rTMobTgHb1rM96UJFaqEPSA6bv+ttfQ8+kWlsauc9Y/GrmsPaWiVg2rpfeJl4Jt0ySAWmu7tKwRT2EUat8w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zSqPpFZzufNtL5pLKfdukEEGzaF61hjkHcv22z+6N2OtMD0+4RbiyKwNSUTN7+dtP4gmOjNi/m5VTLjGXi784ljVN+MC1cAwexsxhbaXvRxvkvjZ/pYTY+2IC6AuEssxXq2IbL5tRf0mVY5NByoc1NfDQMzh082Ub6qHSw3qnQMLBkQlrg6Duq3VB1xmZClH2NfaaDho8yD5qYj2uBF7okTJcHGcAbRBAvyVnvZh0dPzOFMSSq1aC2Kgqf6FJGGhJkmOOsymGZCr7UpLuiOzLapnEgRkJn/gO/lpso+zXe4yvsvu247Ec9fczXLcZJCrFT0U3zUjXR0nqiIpZ/EUkEbAXt1qYq0gcXXGn+ZtMiNuSq2MQwEBZ8elq3Q0yHyN9M9ZuptY7ZHiPGXgeFsB44GWq6l+/b3gvYGCqVrY+nxCtqjkTAE6BeatcwqBJ6c8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 03:14:31.7297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841aec9c-d3fd-4acb-40c3-08de9e8af0f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999154

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

