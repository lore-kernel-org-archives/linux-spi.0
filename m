Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090437F01C;
	Mon, 20 Apr 2026 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776654872; cv=fail; b=IPzumDv1DFq11qgr8Z4Xeq8v2s9Q+/3yQUrvwkyrMJzvHp+jVyINowPU5A2boyho/E+zKeQc827U7UB96xAHU7hNxf1tWOZFJs40T8w8ur2oRmrHQYKubX8PfGag4OrWHcdz3YQAwMkfhp0YcmS5Lp+kad2DQhiaD0Ui4YLO8RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776654872; c=relaxed/simple;
	bh=M15Iu+BLfuH3i5NOCpvtzNtfYAUh8OOSjaY3iNm7hGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YSu9X6Hb38KbqBRJ5VDc1qF3oU4AH3Q9/PYv9VqUCOkbrIpFrgDNQGB0aiQMQzgpW+R57eyKItFczhEWVpSVcVwsN99+2id+Bafg7AkEixFe8NsZUiuXlPCwzdD4QTmncza2qgTtSR20w/tcjEqU2gJ+hd5Hgn0/MQZgCPVG8kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GiupbSyE; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GiupbSyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgxnw9b7ptJtkp0Pbd8nV4ZKN8ptRJ2r/26uvw5MfOaOxtD55P1fsCXxjSZhP0946APCTkAtUspPrRth6ERKul8b25S1rFByvxQOQGjb78iMDJk6/sXx44YEqwjEIs/hpHpVQWopoYSSTHuAmFrdx6GmLbRqeHMuDMkmJs2JMv6VTLaSu5yWtVi5Sh0+phFlafQURkvzAEu1cajI4unhURXLPvs/JIjn0MfXzjeN+J/vaVc8dx6lT8eTS/faNpnnDTu/ypwdOjKvRi7ckQSxI33SKRVqgp/YXbYFwLBdhfkbd/GJJqcmygaHl46Tx+QypazXerD8lCCKxZuwzv63og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcrPNSjNAUTVmkZSc2wGGuND+BStwz2gNQfG/qdgup8=;
 b=s2Ya0M0HR7PSa/CEZpv61SKSJZ0HGcgdrBxNwAxO4cAWkKqkFy62GavqHAm+yngiyQHsRvvXWZW1+szE7vTtoGZzTv+q9sGGgXY0VP6Xj8EZdu2625mzOrzNNgHskWOLyKpBK4YIMnxB5u54qADuVlgUFNQw1sFkPtb6AKuP//oob3YbcrzYFUPy4aM5BAHaph+r5wEtFxk3eQGciU9gepx+zalRy6+FRIXJP/93ep2K9jtHOnMRSPbMjB5iDWBpix+WB5xjsP0VqFbg5Y7f/RaUbyk+lswPQgf4N/iABUUjuWddRRbVLdggXJbLZteO5J01yTrGDRUNaCYg4jtXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcrPNSjNAUTVmkZSc2wGGuND+BStwz2gNQfG/qdgup8=;
 b=GiupbSyE91ZjNErbBdRjbAxRAIsovT54G2OqjU7V3ECCqa5odwPF2EDx1onRdqBuOeIkemddGb57qj7jdCt0s/VOEQLl/H4XRLx0CoyLFAU7ceV6SUPyOGAubdhUGApAKTZxq/9lgt3Wef/Btkx1n9j5qkjNVylmI8yDLMsD+IvCFbziSUFHvblC48p9gmgcdiRQZlL9U1gGWps0alevMiMYUurynHrkt/An2GkvYf7owXXgfTnbF5vneUCmL87cHDuFjrVnBFb2qeXQ2yzEzTNuUDazboyG3N7+OOlfIFXMw8tJ1mHqDQ+egD1FkRVNqcEOu+0dEHr3KBa6BerbuA==
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 03:14:27 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::fb) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 03:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 03:14:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 20:14:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Apr 2026 20:14:18 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 19 Apr 2026 20:14:17 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH 0/2] spi: add sysfs interface for userspace device instantiation
Date: Mon, 20 Apr 2026 03:14:15 +0000
Message-ID: <20260420031417.291442-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b108d02-ba75-4869-c45d-08de9e8aee28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	81t5sOsyDvJOst4iC3WGtxfMu5bKXNSc6BwxJfMuyUyulcCaMBMKIJ6SQWNA4TM61H+WfTm3nQYqEvLaoCUofGcnD+Y+f+bw1s+P52QtlWoj7YuuMAh1kvfNhgP8xAuOb3OAw/YEhCn8/tWiPeBClUYp8Ipi4K61naAyFx5tb9oG4iZBQxm+y7JKv0PdbGaODk44juww6dlRT/cbmW4n3BvvDQ8xEdsIa03RYPN2mI0Fd5vP4PsLv4VnuI8FXSgWywszIalDk2mfGQvDIyboTGuJrNG5ZLKS6g9yYXhfVK3PP4JNmeBsgdpNI/Qlo2b3ZLzZvZHfK9BJXtHTr70stA86nIyCa6ngdXAuRTFx83McYLBoZxqWGXqzUpuszTvDLycSCF8QpXA1h3snkUineAKxmVIBhGQ4eNhRChFjxG4y2AktiyHC7E0LALHjgmjEeqcnYBPXw4qBXJiYO1jgv92/zHzvsobRMcZD8ouM1a0gN8FJCqu17u5faGqmK3wbZCgc9J4oLy6wI+08St/IRUYDqDLLnEWWglTEaELM/PbusAn6wweSLRYiCMmFy9mDFSpRtUelChLkFh34B47tco98iI0KdUHYESpEbSOarONR0O1qywHVkihkzjTkrcaIyfuJ4bSqo/2lV3Nk5owk5Dlafev73v1ReRKWSW5PWwOMCRUuBh0GlVnY+tROXoWsLEoQlqBMqD0tGR2ruG3oPvMphOKT/kid5zdfKJR6tQyLH9q38dl6zwERZC1w0nkSDhseppKI08d/VMi1OsUgDw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YlSyarMN5CyR2WwP7sX/bGTyI8jNHGlDr6HhbYtZC6q6wvPOjWL5hsGexvHpLawv0Gq9e0mZT1UHban3y2JiutEijhmHKHc77CkrljbdGcHk1P16U46RRqIw1gkOvYd4K2OGOv5Ba4s2Y9kJeEWriDA+JZHgBjD/qCnk1beCcDdc2XTMTYK06aRgBlhOI9Eb2N2Vy7API2GE9XElz7QKYpLmUC7cilmtywR6PNrSScDGofr5kCYC9nwYnPMgJPI3GluG7qv3NCbTG+JZCZh1ztA4ALfvAaKGQhjVEk8gy4hckOyflZ/aKVscBvdafcyE5D2kqyDqGUxKzl9fCrTofEQQ56l8hw8BoXVB7RIvutmGXFOBoq9BUx3WN3hPDoaW0lpxXjZ/MEHjbYo8zuGQFvKn0gSP5ioJGyzGJDOxS7UUs38KDE2zpK1hAkZNC3cj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 03:14:27.0115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b108d02-ba75-4869-c45d-08de9e8aee28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

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

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 ++++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 +++++++++
 drivers/spi/spi.c                             | 172 ++++++++++++++++++
 include/linux/spi/spi.h                       |  10 +
 5 files changed, 305 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

-- 
2.17.1

