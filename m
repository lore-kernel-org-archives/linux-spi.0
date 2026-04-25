Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526E2AE78;
	Sat, 25 Apr 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777138478; cv=fail; b=Nw1qTHm/D8rOj/uAtsHh8BDfAcCPceorxLcCvj47gTXyhOfOFXpSWbcpD4hSqnAf0DJLKCURNE+IrSru2QZuSslZMcOXvYGguCuyJABHSbvWhE5kwgg7xm3eTUqC64/K9vtqgVHLGOwhtcCdH2t384qosGkQl16BkUBC0ZllTV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777138478; c=relaxed/simple;
	bh=Ou83dAw2WBD3/Hzx1mZsd7+BkNqm3pBdFfvn15o/wqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCD4xgw01omklFK0Y/+KWwXXVihEGWlTIGDEcNnG3EYv5DaAHG6MhC0L37Owtb6vRF0TiECTxyuDrTEECGMO1oydb1yiTGWdILVf2b4JIzxrdSNBk3BHIRRA9nhA8cgKjYUG7WusPNbVAeNincbE0djbbJ8/dYQkn5bANVgXIh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W8/tmXd6; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W8/tmXd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTm7n3b6xWWCFtGZ70/5DhwvM3xvVbg7iq0ORyBJjhAr0ibwNKE3uudTAYxRVnMzNWOsQEXPfTmCwjDMTCJ3wWudKgwv/OtWRT2v/Fg3SnZOqX9uYhM/dL4Zc2Lz0olNrn3FnMY/kv24CXJGz3Mj8Mi4utOi3nst+IdN32mx8GvEO45sf+MZXrS5SJI7eT56EAUYAEPdX4EksX0r2gHcxUFw9VR3GOwxJQ0HxgKY3nSH9gGl5pUqXoqiSvxdotaEO82UYYfCIPtD5GCgksDDtZZ+qiXHIyYhFDaRPK/MALXv6fIRs2qXWzLJpj8/30Dq5+o7J0HTQxeFB9ktmDWGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=FU0qeMy6dVP9nAvz2BBBDVQzhTmqBjhTBTxf1MWKXTy/E/uWbfxbXnJtUJSZr5yX9qPG5FwkBn1e6BNjkaXMDIfQwtwMGDiNktMob5AsIMW2PzlLmm3ABYS9GSb0AoqUOM5/bFnpbrEz1d05BAOCsgpxgINFnZz35GBxRn99eGPKudEpkboPoD98uT3qNNyTw+g9Tmd58YXh8XT4NPX/jx2GPdaAjQYgcKHDbBkCWKiTigUVYBeHE7MegIZv/n+scXFUNO3D36OGWqTo3zJka/z6hLHd0Sa2912evKP7JcRNVzEMg5XWWtgkDQnhcrOcD01uFSVfcI3/mszRTYHBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzC2Nb1OFnYoQpsB5d+r63ZC5H9ijhPswIpPK5NHoI=;
 b=W8/tmXd64GzGSUuW0PsvRq8vGJuQF5xKCdKK2l+yq7Op5bdVX5CzYF75A5Z+u1Mcvnr/mAYhCKony1NZ1yyOR2Pg549Y47DePPAuQeaImjmml0jAGbFfVuXElMINqz0JRSSt5tUZNsDOEoWbR3g4HcF3LrQR5VEHsrSSVM9wFu1FOVIncQ8RUSfegNcrGguHQ+kOlKmatQ/x7YE7cvXzzqbaXsK9JyJDiJ2WezPkZdej4+c6vlf1a7Y2ATictM5BBOp2z6lSrs76mGoQ8ZyxLgjjcLnBVaoVIa44m46UxgCSPyq7Rz0k9DmyTTPIcjeZLbPVFJ3yixx+dYwKAzUkbw==
Received: from DSSP221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::6) by
 SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Sat, 25 Apr
 2026 17:34:32 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:3d5:cafe::9d) by DSSP221CA0010.outlook.office365.com
 (2603:10b6:8:3d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 17:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 17:34:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:28 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sat, 25 Apr 2026 10:34:27 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, <smangipudi@nvidia.com>,
	<va@nvidia.com>
Subject: [PATCH v2 2/2] docs: spi: add documentation for userspace device instantiation
Date: Sat, 25 Apr 2026 17:34:25 +0000
Message-ID: <20260425173425.622042-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260425173425.622042-1-va@nvidia.com>
References: <20260420031417.291442-1-va@nvidia.com>
 <20260425173425.622042-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: fc48be23-5d98-4738-c00f-08dea2f0e93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|30052699003|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KHmPdtaRMRb+JmhF0iUC9h+SWz1o+qm+s0HW/zZJ0+DKvMRjgEEEZ/1hC+ZX0vN0sos2dzOLF+1+WXjVoVjQENT29ojcW2awkAp6sy8KUnemLi4yOj1EgHPF5WSOQI3jPiwdgzcJTP4ECTGCSQSzGWIwJd/4KiwKGoZh/GNMe3QCAH88kSfHgwzCJEIjx2EXgE0B2GGqh2Lcw+lrrcu7gxT9rOc06yOunMOqLp5i6k1tIY9pTxWzvcInxkqhwrtBan2NYv96QwAWlebUsIJXujAR4CRZbhNN0LC5wi2lAJR2asfylVU0R8uYyDyoGQaMe6PwbBAh2Y9JW7UiAbXddIhmKZIiPj1g+BvZjBHIRYd+qgzbppNiQPt+11b4YoaRJGWFhVJ2mvJliJ9v49X8sfrUtrPrYyv4HLT3VE8UcVStX3Cwl2csmrx98wPuWNI+6zQFd9VVNWD3Z7MsRkLQyndwW6VXe1te2S2qHNYTgl8emyUvE68RoMFv5MYF1y/8jKMrdVHNie/s0bA0R5+tVf54AGeV3FTClhFCemW4v85o3LjOLq0l3I9mHMJWDb1sKn4ZbTU5yVStkT3sE1jZPtBiAfge3r7LxWR0AbvLeRHKXW9T2sXOSHGjsaAx1fhteEn4Uk4AjZKd2NwVxfbzRdJoQPOOkiFgMDiCG0m/gzoTPCJdIpm7uDrWXi5yfJ1UjTjxZBDrMbnBpDXXH3hy9ao6ZWUq7naJ6MWubiWvwb6CLyRBtd7eaEHxE4m+dlbHMSWvCdI2VCkkx93V3WWugw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(30052699003)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bg4kwrbUfCKjfZOGb9Y8uCEhkhJHFwVJCgC39KfS5muVv7hcp/A4StBoz+d4kFIDmsh46v37aXS2dpbvFkmoxtBrkYNsfMbQly9jzDG3njhLT0RVgzmo/vWzzT9iLIxS9AqBZaUC5u6VSfc9dfdu0e3B+5qlsvG8TmCpAzy5Qs8oyjJDuVtf7jppC2WxCbl58LD880b4mA10R2KyFlzOPQQxt/V33Yw0e9xlZybh3ti7//WRjf/3LuEcNyRob1Q1Cgbjh/FdFRLihEP+0Uak8VZ05Pkcv0Io1uCdLABT+Y+JRTGUs0JaV7CIqOiBKNGvztFP1w8izdjx8JGnpzcXKLAB3EqCaJThWDGbvvBekQc70c4EDD+WIbVKOVt//rgzeFIEXcTYQnyb1gKb6UnSqe40HwabufcQtbAj6tMGvit1RrSffcQ8K21n24ClPg+o
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 17:34:32.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc48be23-5d98-4738-c00f-08dea2f0e93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

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

