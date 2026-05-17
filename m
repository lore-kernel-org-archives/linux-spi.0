Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6E2FFDD6;
	Sun, 17 May 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048983; cv=fail; b=QtF655m49Ir8gaLIgG3H9PCNP8gZWDV1zvoyiUb0GdP/EGbZRbGhUth0C6ZdQidCiXSmSAwqO8LsdlwUTCi2UHLqtIPucl3jq7EUUrnAy/dztCoT/KU7Zb8+3RJA9f97+m9TZr8x0+Yf7NiU3eYUR/jkbeiBFNMJbRBGUTFqLmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048983; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+139UXt0jywgOUiS6YacVz2y0f1mIXMVNbteZGbF0Sw/VenyLJYZeF8k+OEHz0yTIdfC0eF8T/noY27J3i+16q2qoPzFIhUWc/vWaJ4+9v+EAWq/iKUaa0WM3wPwwEVuZiBy0bYum6NUr41ZahQyGpQMszF5fKKxYQHbIXRPsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lPmrbBzq; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lPmrbBzq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwD5NJ7gYFcmV2jfwBFt4iOoPdiqswf9sUqiCGoqWO6o4isGsTf+YUGj/uh4srpt6kAtYvPlOIOfyJMnTr5a9k6/6Qubb8hSwhmeD9E0IhK/1sDI7yQAyOpWHiN5/b5sTuIKF2IzuWJx2xuAlPVRTsbXWx20zki5MawrLqM4BxYBmIYbYcWatmHsL+1NOF2CVwEuKVfcuoUDUEhIe1dLMa2DODBtU4ZMWsDBfPDM1ysfhaOCxF9GdDPnw0XZeQ4I8krB7Q6djdiBtzkxVqV7ejvrmKKN4qRUQ0xS+WbYpZ5uyuOOlkWldZTTTZHozoGEBqxtzJ0P9sPiNdc5xwnRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=XpviESjvKt+57Mc5aHwaqzw8RxwWLUVB1YLFdV2MtwyB80YoRjuIcSbP6MI47R2RM/gAOgJhuI15z5aqyCTqJ7VeyqM0g7iNIxVWAty0ePgNkrix3wGjak4rLGbGcoOBNU1SWQALdE1gQ0+G5e8wPxFSDZUmlHFqRZ5doZGmR4w0SJ71OpOjFKi9Q9VN579jrJvpt6+EQ2fjbtpb7LD167Hid+DB1R2xMPse42UqNpF/rLvX1tlroMYu26ccRmiNbXHfbqLMIOZwnRQnlu8xj6Zusf03Wx2IyMXBYkfI8qVUtt29Vs/NkfCn+D5C3VW2xmQwc/2kHF6fuE0E/zHSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=lPmrbBzqHChGJfzlIR6lPVABzPbZUFZUbzT3lJqny9TIXQGhI0k9keLpkf0voHrQ5bU0VuTwkvoHPKsinUJHRKFHux++Y8SatRbaNunBtyscEYzaCUd/rRHyfiaC+uZtIoWWbZANof7N/iA6dfDW03Xg6rMBoEbrmvWXMJaGzagrJdHm4MMfkHDvGwN5LRNpQjsG4l/ZtSWybNU/cJsApfLtfZZXZNv5WzDpcu90+KxuQ+FEos+Y6UwwNQkylV0mvmkyljagADhws7kFz0VK6UXEbUa82wM86cu7SgkhiWQLenoegjI2KR+y3bGnqThaZ3BCOR2luGBzdCtRzjhauw==
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Sun, 17 May
 2026 20:16:17 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::61) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Sun, 17
 May 2026 20:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 20:16:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 13:16:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 13:16:04 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 17 May 2026 13:16:04 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v5 2/2] docs: spi: add documentation for userspace device instantiation
Date: Sun, 17 May 2026 20:16:02 +0000
Message-ID: <20260517201602.498135-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260517201602.498135-1-va@nvidia.com>
References: <20260517201602.498135-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba0c53-057a-4fa4-1155-08deb45126d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|30052699003|36860700016|82310400026|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	nwMN0ZNYHjIGfAN6L3q167mzrwQ8DuvyDytd5m1MhN+e9P+yb0ZIQb1Hls9xsrkzNk1lTmt2CfpAIaJfLklfYupI8LBfSnO2NYOf5dFoQeeRSq44SwaWrH+NOnwaHm4xQwLkLoOg6r584fiE4Z5lBvDG6yCnq5OIUibrLp7MEDfvaCRS7Y2hoVSY4ZoGGwrtB2mma0LXVGvoSN8sqwwDEiJyJI7Uol9/gspNssPPAGt3V23qMf6Gwg8BTi0F6pNZlH6BRwcmQYw+yUL5zkmROyh8TD2YK6f/2rYIIxGC/MnC4wjs+DTJNA7im0dng73JIPCNRAWXIc79svBQTlE5wnVprtD7TMe7g3SRVLR7sQ9sCibdGwkhj6gRpCn8zvQZS6Nvnx6zPIaak0vUQYfHJQ+C9GjBxQ2X3GhQJG0lU6OBV7WG0UtIyRGGQtRAbz+beccdml0pjfVpNfhING3mM8JyDtt9WwIHTu0uzZdFuZcrs7doqfVb0Z6YtfbwV62zwp1ydFdIX5sgVB6eq4lmSARp5JEBgDPFM5SXM14W8j20RaVuQIvpAv/Nm5zUfh5c1dP+epXf2BwE8R58IU5xIe3RYxs6KsMKwlhY/mWfBhR26Ni0ReQkXzVkYq6RqtpJBeJzWSK9UnFZFpfhJ27DHFv3rM+sZOp9aflHqW3AVaIZPGj9oZ5uyOfRjUlDU1Zj7IVnul1Xs/NU0lrwOt+5AhaJctTmQDjTd+fbnnr1QmM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(30052699003)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5xnh9S9XxeZaeKj41vkmw7p+4xknH+qwfdljaJC0ZaUHSVBmoC6C6lXYvOjT5fn4YPsrdGcjM8xoKhO12v4xJf30gphpZg0p1g+6QtDqqvbDvkD1iCSPjChYBSPX1hyv0W2SG+cbU/W3PJmIXPypzwj+yR/6S5pjTU5bqAyobCee6qJ/imlTCvwB2HMhD5IcuXLH2PXTcw1Pw4tdYmRPCGfze99RwKkiiuIeY4IUGekzeNdHDBr5AIr28CKTUCHuTi0XRzhN+DuQlrBoA+BxuT757XJdFzywwChzs09Q1orA145pfGSdbN4cEiMY4FKFERBcVfF/ER1dA70wXIamCesHI6I6W4z8FlZ1SkXyl8O5jAS4d7Ts8fQZuJqHCYTJRSVf+eLvmRT7XdsAdG9qgL/jHI7DmO16v8T6Xxgw4Kwt91lvCEJe6Zm9WxZS4q0z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 20:16:16.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba0c53-057a-4fa4-1155-08deb45126d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

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

