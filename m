Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A60358376;
	Sat, 25 Apr 2026 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777138483; cv=fail; b=ajiDKKvR/weVqtjT0hhE4zSHPovZCOWoYSAPKNNjWvUO22uBUUkr/IGEAXzvVziEJyzvyxgnP64mBmdoHjKtWfuwYx+24gZBRcyglihyXG/GpfGIY10AZVzbtQJwI6Z/rTkIATRBUfNj4cv98GafdGuc440JW94L8ICFIePeLEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777138483; c=relaxed/simple;
	bh=bHdKvQ7QT/0EzKApcARpXuqYdeQ+BXwiwDV21FSzooI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFXDvebPg0ktBJMCjQ97+QSnAB6usL5nIfb9nzrRmG+cFtxThHXqJVdMqeJRIGtowXiLBAIxmHqxPZhGe4q5GbTdTl9pc9MOGa90KoxCA019hZFF2gLovZ5d2NO/lRNPEFOMFfspb90pWRj3FFiR5rBmOfT78JNZBscwFDRra20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpLsW2s8; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpLsW2s8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6AE5mhN2sB2MNO2x2ExIeMllDaYoT/+xvCLe5Dms5enockgWQRpJhqIQ/lAKJeu1VGHdyfcXNblsKS5u1edI/RwD5FExw+E14HbDNmO4+Jcz8MUwZtS7+OReavEeK9BEs+Xt9krglH5JRulxWfX30YMHwjzSBfhchv0m/VUGDhNbz4rZdnCAG2LfQAf5lofZrthOO0mEu4e3V7pXgS9FDJeHOMFliUKV1QBoTy4zK0v/bTpLuktKahTBBmsXemtTIRylmOQHM+HJS5UCid5YfY93lCMpxHYqXvRfv3Cky9e4D9KTSR8/e51XfQzuwL4Gxxl+17O5ffZiBcZixRzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug5Ifl/Kg3Z5+1BWzTWy8sl2d1vsk+VHo7d+f0vBlls=;
 b=kMrv0oao6Em/7GAy1EWMcnFv/9+EmP5xMABJiiZpu5nFwQBV27sf9i6SBq0XFhBAPySm8fChVPPjZkBTDHwMkueKPz86KAoBinHCeEX9kx0nLrBjle6aGwByd8Maaxxma4bAaAsCCkvslmItysm6lFfurV2LCSVhA5Nl/n6K3fbUbjgONvun0G1wVaDIxLnu54PuECaHYfAfKkVrTORxYwRybi6g/S+CGjfsXw+EDl2oEUgJI5dkDQATt273tHXVQL4W+0juEfePBJ+UskvLIIYaBbSHtSUEV44nD4CJ0eQ+H/hlWUYdvgSqmJdVNOMCbpPVCOL5PS1sHZHo5f0Bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug5Ifl/Kg3Z5+1BWzTWy8sl2d1vsk+VHo7d+f0vBlls=;
 b=rpLsW2s8DjyQNIDVYhtQrR5PPWY1pceYSGUWq8046BvkZZfyvknMCL9OvmCASCwfhX9Xvz1id4dNeLxG1dqQ2AUiv+UtL/11zVJ95JEXiAy+c5GnCe1AdzYuxB+ISc2bNIfvPmKcxxtuuuDHOKb0lDarPnPrW7857ppib2pNMRTo0D4YjLmjtCI4u2heCbg7aDFLv7b6yy2qu0E4Hj51NyxY7Ii8TqbLbC+9ukKSmUuRb159o7IS741BR/fpexIWgaC/yg2EBYybtSIHQIBffwYqH0ye7gsTLbCUMqcP5UJEV3P1nnROUcmmCYn/jzu3UFsBj5OtqPlk58/KTGEV5g==
Received: from MW4PR04CA0279.namprd04.prod.outlook.com (2603:10b6:303:89::14)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 17:34:37 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::54) by MW4PR04CA0279.outlook.office365.com
 (2603:10b6:303:89::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 17:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 17:34:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 10:34:26 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sat, 25 Apr 2026 10:34:25 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, <smangipudi@nvidia.com>,
	<va@nvidia.com>
Subject: [PATCH v2 0/2] spi: add sysfs interface for userspace device instantiation
Date: Sat, 25 Apr 2026 17:34:23 +0000
Message-ID: <20260425173425.622042-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: e86a8734-e511-4285-164e-08dea2f0ebfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|30052699003|1800799024|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FSD8ZpStdhLEYc96vJWl4XjzAAGsGsLypplWnPxGSSso1o9b5mnB7YS0kpnQyPBBicfeEH0SigdO3f6n1ZEUzeqJvdhtS96xZk1Jc7n3aH4zcXxt6Dir5XyUOfGeStPtXg4gQTHmAQ3x07aIYHdT9geuDqtGJ9OgBnzh3CUD0LqSMvG3uxp6q0TvvvtDlgoPTmQPThIuRzqSVpfqiDDEkKczH38OESO1IB3OrfsdlXMMerd0OchEg+bJFVfvlFDb4OD8KTwcoS2O/Bk/JfdQRn1Q63gdGOJRqK0cW5lmQft+6U4Ef7yUT7n19yRfn34DpAVaJgAxBbwdWM+4MFnEBrcS3PC5ZiIpm3NgsJyMbLpLnRmCWnkITdPjm8Tdz9uW7uwyr7QfSFSWMdXiNrxbv6sGaMIGGCHflRFZUUcl/h6+Gg9jXpXFD/rBY/yBP5QD6IZlQWWsxRlId02uoI7R4FgrgD2nRpknAtMAsKUxNyWJRy8TKkZyMv2pHjeAerFSyJBgBPvSSTpK1oaWToj0qUC03QUhV2MFSgZj3YrLrRScTl6IY2WOIjTtopx+Umfr84pT+d+/C5I8yw1PCwDSkFEbqojx9OmaFkGoQkKYvoZixjf/4wLtNwyP8zp+FAa6mCxEseFI3DD2YicH+ejyWMKEn0WhqFQlfLLqdE8at/JmGdGmEfQMmhZlx587CnAjqsr1vCS8X2bZzVHWw4YM4EB/lWjnCpzfz0M+Y4yKXGSrqOmKtLazdNtfb2H0dibdxXRxQy47bJm3VEV4JC2c9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(30052699003)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8XOCmGu3RWMvPxKKSVDAgiI2hGmqu9Q1zCXDSILukKYAfQd7wk/2auUfowNlosT5VOcWd1V3OehvTbqvbbI4aQRFzwaMBA48/emiffqmr4q8AastmhSpxoNdfTB8OJrXgfUqx8cHssV1X/DfQ9nmsbXDgDPZNt+G3T9agl6zh3wmpg7SwE/NQCqHTDfevCyYG13UKuScu3oFfgOoTuJbCdw1ZO+ZeJqEm4LTmJv734WP1DnMKAGnHsSgVD4Yxrmkts9jeb5zQpfmK7epN5Fi2Fj02fDR7KqQyOFeiaPbUAihLb/YTMylgPbXGLdy3nxPSTHDq9fQId5PtYoW8vNzoa2PusJ1lSp6ENMWj1MmbUStq1NeDS9O3fUa5GCL2tsqsqJnh0SKBiPL0nkHbzIRypFzsWiDY3GWQ+BFOBxPyZM/ujCxkQHvGhMhR+pSi9gV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 17:34:36.6705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86a8734-e511-4285-164e-08dea2f0ebfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639

Development boards such as the Jetson AGX Orin expose SPI buses on
expansion headers so that users can connect and interact with SPI
peripherals from userspace via /dev/spidevB.C character devices.

Today there is no viable upstream mechanism to create these device nodes:

  - The spidev driver rejects the bare "spidev" compatible string in DT,
    since spidev is a Linux software interface, not a hardware description.
  - Vendor-specific compatible strings (e.g. "nvidia,tegra-spidev") have
    been rejected by DT maintainers for the same reason.

The I2C subsystem solved an analogous problem years ago by exposing
new_device/delete_device sysfs attributes on each i2c adapter. This
series adds the same interface to SPI host controllers.

Patch 1 adds the core implementation: new_device and delete_device sysfs
attributes under /sys/class/spi_master/spiB/, allowing userspace to
dynamically instantiate and remove SPI devices at runtime.

Patch 2 adds documentation: an RST guide describing usage, parameters,
examples, and limitations, plus a formal ABI entry.

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Changes in v2:
  - Fixed race between new_device_store() and spi_unregister_controller():
    replaced spi_add_device() with direct __spi_add_device() call under
    add_lock so that device registration and userspace_clients list
    insertion are atomic with respect to controller teardown.
    (Mark Brown)

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 ++++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 ++++++++
 drivers/spi/spi.c                             | 190 ++++++++++++++++++
 include/linux/spi/spi.h                       |  10 +
 5 files changed, 323 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

-- 
2.17.1

