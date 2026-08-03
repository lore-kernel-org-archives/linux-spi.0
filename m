Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2F5385D67;
	Mon,  3 Aug 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754004; cv=fail; b=hbaci1VldOaqCdFj9LdEPqXXnAkomtRC7kLJZoGow2KbY8DEQcGRD/FXHQhxgn9Y+AEWdHMwoOv3YjHpBqap2vA7yU99PtGrj2HzHWXYV0Oks0Qnr+KBmPXkSvuvB9ntax+i8YVpsQ/4iJIeEUv3y3h0U0xAtAMvz73PcjLBkgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754004; c=relaxed/simple;
	bh=PzU0xJf4qR24GpzbRWoeRsioWuf5kazjkZ4KUk2T9gM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVCyWcO2i0E5iPpPn9bms+nfXmeULvLJgVFzgVogKhshNkWw7WB5d4H3RvyiDnmTFPd5v93BTEQ5svOw9rMOoS/L8JfqFY61iZOpYn7pjdlbYeipSk9eIcpMujsG8hNXpFbUsqln0wATlGc3j1aH+g5AtkKCJ++zhmE+PSIsJEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ag4Miwum; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ag4Miwum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxaHmZ1286tDcYQbBVieGkfZlakC0kmSFe6MluaneT5B5zk785/Y52T+iY1X9CSt6Ecuwb01mhRYRMzCgRB5qzvU3mb4Aiv3kKQsC4Dvxk+q6/yVPtLFAJvAtIEQYJ4yAYyyYYBrSNtS8K1qMMH62Yy1RjGHb4uryVds+sjnNaffKZUv1Y/tLA8HdSjTU7KDEu7kSpdDX92buvZxZhXXOArPhDQYHsJXI/HX+U4Qo4bojHyuZkXJr2xf9IU3zDDrcerm9xfBQJFGHIJG0rbh8rehBGDIHWq/brVKxaA/mJsmV+H/jtVepxZcF73kUKbqMs+y/7nMth6mGoiPJ1DvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRjRXw772dtvhZfXi+9E3g3Lit9zYIT8fhWnwQQCnh0=;
 b=cEY05e0Hk+aVoGxnP+OCjQCHQGKSoElid8tkdpYXmb0qEnybNQjbBKDUqQ3cO5ypVcgFn0GGHsRVXM3FYR6dRjl8NAP3B89wwE4T6jvXyGhKGg366vhFKnR349V63eUeu3M0eGRycC/ZGYunThfWlM3Ao+8DKOZLGtca1GlU1hSXO5RogJiR4DigDLV/nMfS09ASXRYcIKrIqFHEOi5OdmedfEFEHc9JuGV41+VpCJzDzM9IJ66OwC3hzKJhhO9RloVfL0PAHWE1AlLEmRTszfU2LrtaWSLiWTj3LTl1XsBbJTrQU2QMMwYZyFMpicylojfL2pu8x8yEQCD1lGsSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRjRXw772dtvhZfXi+9E3g3Lit9zYIT8fhWnwQQCnh0=;
 b=Ag4MiwumJfSimXs2z/xEq4MGROvSwlI+gqd3rTJ/cjrSCyYL1luzZw/ntMxl1JcJoNPJ2FRBrXd4zWtsK2eA1te7gJGg7gp+U6GVaVdkLBClhGhEvRgz285ZkrnFo7Wuy/e1MKZv7VCswrLHMhxTBTRUfvIpoSaYHBNtK3LMbCnehGJjtcpQmsnk6+zF2UwinMPF9Q3zAL5x/hkw7x49gI9/cmfV2sKHYVkv0JDCePGLJUsOjXNAlw8GDwEsaQe3MYXkaNRZQv6Jpllyqq9l+kZ4uKe7XDpXbro2Q1y8kDmbOIcrvyVqyM2ocon60QHV/O6Ohk2gOgSdLsO+k07LeQ==
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 10:46:37 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::7d) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 10:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 10:46:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 03:46:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 03:46:22 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 3 Aug 2026 03:46:21 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH v9 2/2] docs: spi: add documentation for userspace device instantiation
Date: Mon, 3 Aug 2026 10:46:14 +0000
Message-ID: <20260803104614.2548375-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d45117e-f54d-4389-fc16-08def14c7e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|30052699003|36860700016|23010399003|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5bFDJXiKWDffN3459u9SF1mblyclIArACIXtM9SfDBd2i3BzqlCscBk6aSn8j/J1wvu+Yu9QbzNNQjyfgH3jSnmJu5rKHfmy5kYO8TYVNOmI6neADySsabFAWEoWWhOwfmB1W2a+DHE5ds6AwOLzwwM22WlPFcJ1AZSbWL4qZVGEzciqJ/lUy4cN9UAdgq4BfWave+GrZHa7ZBKSQ9YO0FRFZVMWgUQJ4yWFMfc/6c49tRBPH87s0CzuiiAzHLF9XVU8US0iTsOxFivjvHN5k+cR1GSIkTcfCiESBe75c3K1hlPpe1eEcwD9+EPSQV/Ly5iAPF9kMJ85fnMGBIiYw0gQ2rW2qhnKsemUWfCEepGZa2e+qCtSktc4mH6ez/v+ia/C0RcBcJ93rQmt5vh1NZXQXfwfIArtKIN7wSrbT6Qv9IFXJ6+50IlPicpuj2yIA2F166WyopQC7v1zr6lO4o9uScFzo0r99nBjsGc0H7O4apBlo9z4Lae51EEu68jASnQJoLB2/10mcQeyCXaG+wpEThk8IGS3TUvlJ2suAQrV0aw4kWtel9Pye+Jxaot/QIhtSlEmPHQCCeQd2vbniNHvD7h/L4XgmX5Flj39Ufd3/GMgvER+yENIzm5DENkb9HhdhLIB6C1NeiJ40huRBOPZPhGjFamZzL01Yhd6v5ifHqvbZc0RqHZYr2eyi67GSXWuR3VfDOghdeiwV741uA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(30052699003)(36860700016)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gg8WjmCCZYCE3KRDKL8c0z97UFgC0xge3/bJbOkgUJ3nU5VqBryP6k8+L5wiQRlBDOgzzgCSj5/6B6xz4qnLspTMAS/RwMCp+90OUZQ+LjpfzDy1usrjfI8tSB/f4g8ib5EIQsX+CP4vKXdpQ1sADmgortlbQpTJUOUZQ1T2mGS1aSW0v1CfWE4LWWODEJFMnOI8bOb2wmZ/K186WPY2O1yJpb+hy1Y4AhFXMhhZXvSEG4swfOw4/3vaS2sz+3/Taf++fLhbPPbQgq8fqEgfHB8laMi9XdZZzT8C0Xh93EqfjabusR5c4l+0f8q656jG35usE+/ufQkqs3kmid5O+P8aL3DPScAzwDrNoGsLray7Moes4OQpieJc6QxTddbz/qOR8TxTI6WiKoyRCUXLKTvqgCQzKEr3djUarPMThkOPgut1ijKDyMQLRJsKmvrx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 10:46:36.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d45117e-f54d-4389-fc16-08def14c7e27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

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
index 000000000000..0a524fcd96d2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-master
@@ -0,0 +1,34 @@
+What:		/sys/class/spi_master/spiB/new_device
+Date:		July 2026
+KernelVersion:	7.3
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
+Date:		July 2026
+KernelVersion:	7.3
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
index 000000000000..ec07353b425d
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
+For these cases, a sysfs interface is provided on each SPI host controller
+(similar to the I2C ``new_device``/``delete_device`` interface described
+in Documentation/i2c/instantiating-devices.rst). Two write-only
+attribute files are created in every SPI host controller directory:
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
+The attributes are added after the host controller and its firmware-described
+devices have been registered. Their addition emits a ``change`` uevent,
+allowing a udev rule to write to ``new_device`` when the interface is ready.
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

