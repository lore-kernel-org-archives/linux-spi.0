Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44401305E1F;
	Mon,  4 May 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880458; cv=fail; b=F/X7HsdfC1yTXSjpDltkFRriGi2M9BjJaOBIKm+w4l7uiWp3t9ZAe682DqMCWJpsiGjtCYGl9CoqNOzaG37Bus+YpDEVjLQeHNJaZYnWN8PG4e79VMs1Y/TT1E9nHe4qKZVmDD9pWCKwp+sVQeyNQh9JfEDy86DI0VhhA2xaHiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880458; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu/XK4NPLXe4Y95LSBh7eeKSDnKTYffV+wqMfEzfnWRfcArztpJvzMja5rxsh1QUqZCqR1zYStUDtKM49TL89RZy68u2eVCllWoMLz0Ej7Np76WgZEY03omFyJXRyLKpw4dAvsJFRc+9Ozc2WAJzBHC/9ryGb0zXXhK2M7fHjQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8DA4HUn; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8DA4HUn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aT/p0EtqR6C7hNJa4ofR+3DcpqsQpJf+ilipzVM4HqiN1lDM+rbbfARPPPbvWj2YIiwvWClYAZyzNG3ALhVP+elhwCfhxOnt2EfY1HQIWdXU5Xzf2UCUSVVvAIsWLkil7Q8hwuEkUYYyJzkAwMW01/aEcjRnlVdpfqIwDsuqJRXeb9eBmY0nEJhT57dMDf5gRtUW/ystJN1jWQalj0D3TIsQhaKswP/gLIQEXz/AHDCEwErD1f4dUqqExTqLYoE+rmm1hsNLBH3zkvY9mvi9K48G3NmOxZUH4Eie7AscQEuEMj+NYdxE/DONCTRayUtED5XOiM/pIlaGayLXsfzYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=xtWar+lxynRaNVZp42LsxWFltQc2Srrt6lGRBqTA+YDrp9fFUNthSYWH4b2LC3k7IQJccu0rnVd/pFWNGnlyfjnEsmQumvlH2kYOFpwfhcLsIH0TvGsFUAD2CoIeVhKU1hpw4C97UTgDnaicV4I+BXj/6E3KRt8lMNas4q+vTqMFRtHyHJ9hqY9FhH+/8406L55zv6phWI8nFrxUy0JqKV9qnCE08Ea+zq+lrzF3bl3Y3EOtfHLD+rB9GA0aETRfCm3YlrvCbhSwtFd2XfnIxW7RmsyMcyNE8o++swKvzIIPNRUNR7D1TtQmpo1hWsXYiYONQ/iOFTlws2KsUq0bvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=Y8DA4HUnD4ZW2BjaDLl3XlLMh7HRRYgWQZOmQOhG+l7vxC4BEdT8vB2KROXDFhac2qPEQC+GKhjKNZq5X+PONxSE5KVSLKHypqMBZ0HsbOT+x8ajx56mUEXE92Lsh619Q02vItpnTDedOf0vxJ56emZKjiD2eCTwAH7hZCQNedftfmr/wuJR0gCV8YLpzj40Tja8rX5fUxcA85Cs7hFGG6+aHQOMQvbkuoXMWF3CmIHW2fg3rEH8bYYfY8E9/fhNpoNjkKFPVaYiTTKmUWrASikqYI2nGVPr2zlK6fKxFJAultvCKG4TJYbaXwOrOembuI5gZxzGhF5hjh9IBjSqHg==
Received: from PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::8)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:40:51 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::3b) by PH5P222CA0012.outlook.office365.com
 (2603:10b6:510:34b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 07:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 07:40:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 00:40:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 00:40:39 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 4 May 2026 00:40:38 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v3 2/2] docs: spi: add documentation for userspace device instantiation
Date: Mon, 4 May 2026 07:40:37 +0000
Message-ID: <20260504074037.704833-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260504074037.704833-1-va@nvidia.com>
References: <20260504074037.704833-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: e48382d1-7ce3-4ada-7720-08dea9b0771f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|30052699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M7Anp0RA5ELUbBtkAEe1R/okPE4L0L6GxXI8hW/yX172G3MtBp+HGUzPDVsxFzk1c7Vem4htAJhIyXR2GK9ICrmfZi/39C6dCWALmB/ioa2m0LX3J4C+8VvXIF43mpatH7u7TuEj+i1BbYC9ghJpKoUk14gx40Pyg2mTBYKmZFuDdTTvkhJvbVN0zijYTW5njEZ6oLknz9+N5UF//2ZxiUmbpdAXaBhDisoyNUHgjYnx1yS69eOEyj7N+e4qMvudvyXRGDht1K4sky2Vcyn5VxVr94q0gX/RlzhHkJtC/jW5EFKnzlq8jh0m9c/cdjQxDragA8GhJTL7HPk7uVDtMEvzmUlpUxq27KUetNWo1xEMejDT1zxASIuLgmvyP/agtkoOQUFCQ6UneVY7JKXR0WciXxi6cQA3g3Upp/T5AbGwsrH7K2PpwNL5p2lZIU8KZiTFqIj6QH75meHyC4zZbt2C4pdVPRGCawOjSGGGyK8XZjjLc/FSxcrm3CCw1xEYzEniCqW15Xsnc893jeXFBLKpOuc3mjgYqSHuGJ3evUElcXK3diUVQoxHbHm9CViTcdoJ+mTfCub0omrpNxJb7ec9FojXb2gYHwiHVUBrqj73bLNoHSjUSwFIJ/uvw7fnFGOt0Xa5z0xmY5h5wu1sOKphPyvytn3N3DmXIc4linvBIPIHiDQJoYU8Jp0elHN103LoY4AeZeeMdJYgfmGqPmfeuz+MDfyLm/tUvtayFjw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(30052699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	31o4hz7ZVh6cLWGK7gtEvvo/ak3tTeKsQG6z8Z4P4XY5R3ZAQ0JXJW0iJfFlustrbs28n5XcjKk1SfwvKk7zO1NCVS86zFGvTWLkKLJJm0YXJgj4VLAF6rxC6SzqN1jJX0n5iMFSG4UwVj1SmEAhM0auK37EdajzqeAQHh+IdtMPuUW+kV7cQBSi/+MesDQDx/gXY3eaV28EcdBj0tAU3V6qYjB6FIZ4LohwEehqywrmSgdgF90cvs7YybaPdeFPhcOBak6GdDkdKFq9rBEq15wbnLWgioJBErCOwR0PQPHcZSxbRsbExj61KE2C97ECVgJH+awzmTA0BK+ypVN+BI/8kpH3OU1ux+iofgZXc06MSgAp7GNB8XD60971YSDX2nypieoEIc6Hl1exH+QpQkX6f9OYRu0RQ665A37cLKQNoE7BHDBFc3TjNd3LDlKq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:40:50.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48382d1-7ce3-4ada-7720-08dea9b0771f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

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

