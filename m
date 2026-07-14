Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501E364038;
	Tue, 14 Jul 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023848; cv=fail; b=hFHbRf0DFVmqi/UZm+dFOoqZfA84Wr2o7I0Cq72OVDYeubRJRlmVlQ9sL9yQ4apAeeRLxUCksgOTeyUucM/ZTdrYufXLXWuQpdfobRhicq/z6hqciH4z1Mbb/XS3AuyWVv5Bv3duVP/FqEtsYTPwi+LHGNJReZ6/PxnYr0TmrkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023848; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5MhiKkStMytANrLj51+kqasGQJfzjvU1zcgeP52B7AIDtose2BPNviup2P4M/tWC065fO+kW10QlUD2lDZlcS0DRswP5B10QDWVvA+ZUcC1FNE7wsn/eJoLpsqulQPVjL5z9TdydW+H4znuSe6UxHl7/Xyk1yfjwKxU2AsZmcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCCvcyVd; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCCvcyVd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neGm9KfbvxwoR0mj5lymr4OnyTG3Rb/XgZsWpeCvcaUJxVHYZ2ZL8KJYaTDUAL/ZJbkCPQkGCgBWeg92kUqM/jFVrZCmCC+eJU3pkrvtNH/N/eGL02O2n9LlCeLkhPtKEkvo98JtyybrGN8pKKZ6YMEtWNlz1oQLmGqOSk7eUK0AyT89K3PXOIegvZN9P8hjSlvZIUc0cWtdT6wk5yvjrwk5N+SurifrrtJf97G0ELOYT7NVU2ACb/UXeEtDVGZTlLpsAU47y+KtmMTbBWr+O6OOep9KGUZHwijIHniU6glK7Nn8uSYDqEWGTPb/E1KNaPXbiqN2CI0WFMd1ZuqVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=h3UgWdZ2gWznr3s5OrRi/MC7rVK1StuY8KVSp9jJ0SlNoX2JaXYpNczvqAFJ8UNiAO2GtO9xyvBxAyntaQwECscttGzw7KYEnPXvWiGdsW4BYS/PA5e6Bb+V+aowhAas2zWY5ZDbxRL4nu+h0njUWbAXcMShYAuUhPfOTJyIvXQYjsKwcaTzAJ94VWivPULpNg/Emz1oKmhwOGS+itkUZICczYIo3t1LMjIw2J2xoaCP9G1QHDKbiawB9ODOeSfBIQEwu3S1ffgewVuuHdGgmobXeVMnfTFM5RZsdQ29WCOZ1XyJHvYJh/Mz3gYcTQY4IrqZejZDqm8CKfZ1Jp5lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=BCCvcyVdWXXjdeIGsyro/VBA/gl0KFbWgSBYAwD0iLz2r5YpLSAbDAheswxQzQZzzAoAMmjshWNsEuj9quIEEkX8QEMyk+SsGu9VcXIQrMDQ9tUQrq60YjF8peQ7sVMmD+LjFiCs+BgAwQ77Qgcyf29uwr/UaTSWXLVYECmBOF0SPnyu/lFo2Zt28GRAOpyPB9gPaFspZ9fPGn52MTenw0qrxuq5wvs6mQXx8PztMHNh4IfJfZawzxzpPYPMJrb6met1/uzyb2GK9/42TkxGuFXXl7CHuZ2sNclnXnCUEOy83M0y93LSrujqfl621cgJF4gM9c2zAdXr7/fBxQjnfg==
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 10:10:39 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::ac) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 10:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:10:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:09:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:09:50 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 14 Jul 2026 03:09:50 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<linux-tegra@vger.kernel.org>, Vishwaroop A <va@nvidia.com>
Subject: [PATCH v6 2/2] docs: spi: add documentation for userspace device instantiation
Date: Tue, 14 Jul 2026 10:09:44 +0000
Message-ID: <20260714100947.1871359-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1784000000.git.va@nvidia.com>
References: <cover.1784000000.git.va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b19b53-8bff-41a6-80ac-08dee1902837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|30052699003|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xkhaNFewszZwhY99BqRtk04xpR3+3A0JLTNXdBwZntIDXaQNM7yGFlIKldPuwsI2DqZwTBLTZjoB/+LqFmxpwEHdzPsQIWlgtCMlJiG4i7iuQpOusw4sryBGOK6NxMNWROKr3CqZETSiY9jk2nKEWLKi0a4BD6YVrttBXZN3+Kl8o3LLV0GcARYJoH4TTljFWo56tbEEuJy0uWbzpEOtJclIC6/qGpNFaSetBtLR+6jrfXjikWwZpri43gjQXknr9pCdUV6pqwjeVDbmGKCAf+Q5ODrzuv+63A4CAJNYw0NtqGc38Upl+Tkv13BpXXgzuQbXxAvJyju2aeioPLAl7qX0uWj/P2P8VZGQLxnHMOg+txIqdzb9GYystVy31vksMDX3vxJq6dL/YUz8Bk8HX5gr8zrDUcZCXKsmHq2hFEPgl9Stl56pZjI44N3v0LyJ7AO54/vyHxoVLsVCYAHhPNmzoGWHiu+ursEANQ54QmI0pccqniK3RlR0K5mSCulVEgD5t7909NMZm213GsUzzbbUf4N8MEMX67mjXuLlnHmZzqT7EJP0q5NNSAMcvVYwuRz9msOWGPf3CLNvrYu7i9g4oyv3fVjoBwEfYLs60gDmB+0z6kQBUbfb7Mn+v4HTttTmt8zLoCcHyq0YauXOSHx4jjNQDYMHEQ5EB9Hxv1ZA3CYoOYixqcHkaz2xsUHO2+Jp38hI/don/tN/SSJ/Cg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(30052699003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RzQNPJ9tFGnleanu3HkX/YAIynzMPvAU0cStrWnpGZjxBhWrT8F/tXEWuJlRGgxTpdmHwBBsvRItmEgPUAQeE/j9ctBPAU6aLtaOM1X90ruFRhr6f65EacnxTDcKwWo5phpMwyalMXs+tjvusVCeMMeM5XNCj8K9CVX1+NhTF0m7j+ePQP+eNHslVuNRie1WyoqvMZhAL1Pet+gn97DLMfL5nomqRe4c5R87K8iLJjfW+Etw9fOpQ2u6lWnwIIDH0YvOZlCdXirR0Z9jwzMPmOiyiol3AfTzQqPsHA75MHq5kQN/nJYofG59In4qbb6y5hErCFkdQUBfGV29MPvgfalfem3xSbjoXiNUZ3z3mfiraFsvrZoTzK808j141T0QlaQYhSs3XAb1Ah9UAWTKTvl7euByoDC8CiWQylQ1rO6DKwnTaJr0s6zpCNffJJNL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:10:39.7473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b19b53-8bff-41a6-80ac-08dee1902837
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

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

