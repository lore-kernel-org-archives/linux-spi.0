Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556223CFF6F;
	Mon, 11 May 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496029; cv=fail; b=CIxM2hXxfMxg7BEym0xt5IGISnDvdLf29j0+H+FwPfPGut0gHB4+y8O+Xp638MMkSUox582NB9u3JTkM59ftCWGSIR680ABkR7jXjZyy+N0I93rPELQK+q+YOIWYe9W0dty/PHXmJzuzDUJDiDT4IAocvskPmtNFQGfcHYyKmxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496029; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZF0vl2vod+v/Gje3UDUBlX4/aM4K1V6PAW1Aa4RH1k3Nm4A4xMsOX6HbCty8a2pujR+ctmZvt5CD3aDoTNIrUyZjLcv3mqH+VUfJP2VktWftlKct5KN38Yo61glNJh7WmlP13qgRLrSF+TKWFfKr0K9EJc/R2lCSUux33awfnew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+F0dkex; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+F0dkex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BplHXkEJGmqBANNTDKU8JCTIBh9Ptt+cxp7JFY+V3ciyVqd2coYO4YRVEPjEp/T5DHCwLJ28zzF1aN/jMO9+LpjLm6vB6+A0ib/74kP4uKY94Ll+WGRVW3XlvK8k4dkY7PdZMWEBv8oWX5iryyTiz4hgqeRZxGceY7gZw/ACYTB5u0vlqrcx5CnAyUMkUMZ5qBwu6YC3JtprDP9BhVd2O4dSJyGiMH+53VhxAUoLX17MYdA0M4WuronPsPFjPmcqggX5H0ycHMDG4Lww9N61UFF1UUGMIGjaIUXo75F69LJFKc+OYGcme9GH5CaoxgfDUL0PMqcaiuGSjNKt+vXzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=fm/1aICVQ3a+BCQ3eR59oqS1lUOPeHIa9+q0t7vqmAyrDTrN0ySRiNeBnVRnHr2WhxWIwAtqt697VnOmBFSejFOLdi22UgSMJavUKH7HnWge2JEknTaQwxI6thixv/Qw2QQ33pavE/Hq1Lhg1u5szRbRXDamSTZc0qA97r7Lg9dnrGJqkPWeg8iQBUzC5WAUSwE/H9CvEu4dJQg7J07OXm7CsRB35iEfWeQ8NCxbOHN1sCBiSjH6gQ3mE41PJMfs7GwYacGDIMDY6WOwMIKbio3SjxpHtZe/ERw2iuhOuIgm+ZccIQxaNFvz0KjOTm9F/MZ/yY8c5FC/p6FeXB00KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=T+F0dkexitWlbNVsXt5EI2lgq9kD1BUm0B26I7/grG90XET0L6Fwrqq/GF/tRyFCTqRK1cvhlcdbnnZlhfDnm/msKsyIG4NRa1DgtSzQ2QbkvEFDm9qo80HBeGwvi2Px9bWDXjYoi5GoN7K82NgMfNQ4e9vnj+dJwHszAAAI+qkGUc1Y7xKM641qEmj3S95kvHRAbKgnJjT8V5MTkFu6KoK2/UBTcYCKZzcRqCPLBnP7pl/9ZcFgoj4xqHNRdmRMi8rWpbeDweML5dgocCrXBoeJMw9aj8T19zO3995DBCkF4mODXyABHFmLH5DF0VRJyyvV+rWWgSBY/YrdfdHuUg==
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:40:18 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::f1) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:40:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:04 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 11 May 2026 03:40:04 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v4 2/2] docs: spi: add documentation for userspace device instantiation
Date: Mon, 11 May 2026 10:40:02 +0000
Message-ID: <20260511104002.976269-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 20acef09-4e41-4812-e58e-08deaf49b1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|30052699003|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	DKZ1iO2iMC/90eLNvDRBWnnxLXK8ltvMJOu1+kbWnZSYfz6LG8G81T4Eyz+YntmZsHufhvq1VWEksWnrYOEaGclBmHNlvOMnpJzyfEup7nZAO+W5mP/XYKsy6pRnqC5DFCBYjM2YUS/Fl/atXNo+T3+5ivmjH3FmoguyTcQ9xc2fCoik1wLAJozHnkb70ivO3JAlSPLh1TDUSlI0GBIzVJmnDqoHVRqjqhDtRIhKW2XSJ9FrY2IM7jVWQG1E/5HlHUWl1kSCyuIFkVaPQERcP3P+qmixRzZPRLtC/GD1PPVxp77rlJLuxSmlVjs03C91nu7cpuHLnLmqaFgBkfQmTI0xF7+GMK0LnXLlQcGYpMuXw3HalRAeFZWtCta2NoEDccpEyn+zdc0Bn/0AkMyzH2/3aAMlLjNw1sNJw8sDfEejJBQBbbazYBGgv+fJoQ+lhJ6Cs/GcWqEHpcETkh1iIniaF+bTd7+gwQtjnJLOXP6XpOhm0dxE+bA68aoMPmWxsS/Pcy+6WJ6moECsfNeHmXaDaMMHVjFJ/m/w6wo7gPSokoj0nv+1AeSYWM7p8rDM+cAvTwm1nexApmeodRnJ1o9ryeMzk1kEGF4CluDNiM8NdaYW0ILNd22lhoGXuPj8OXosjs5jvSwLJaZ5bz4WmjUvqD0JI+zuVQpfBkSwtGEU6c3sFCcUnqd9AxzfV2+gKj4VkLLDYbrW95ECigQS+8N58V04a7dQluIbRt9zQ8g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(30052699003)(376014)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gGwvXS/pyAY9f+o6uhkdcFO51r6m1MaJnb6eZ0MrGXaANj67YPxQ7BKU4o24WjXNl+D5m0EVpIB/0oLaAci9mfIuUlNM+J5Kdy2AtgO53YWE7dtHycqk0ohf1nHVbo1ZPICBJYMSxZUmoBmOxJIOXEo+u2d9F6f4nYZiAvCIB67jJ7M0BQFwfB3tufp8kwsRCnPSlyyi6fj4mb2HiYU44RTeqjYaEdMTh20HZalk/CGmXVwhMLpQhJPhMa0YHnfVGEqqMbeYSVrmws++eyusO0G4FFx0qltX4iX6bywN10hILEMgh6qBvCrXT7Uf0ljtA/cZubySQ+HPey5/narvqfcOvj2B6SQXucK1jeM/xEc1jsOmw0v8DUdcOmXka0q27KGdcWfWnHFl3rmchouwpYRLQkXuv+vkha0SvlWVUNEK58vnWLtLd9bndQqIMLE6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:40:18.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20acef09-4e41-4812-e58e-08deaf49b1c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

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

