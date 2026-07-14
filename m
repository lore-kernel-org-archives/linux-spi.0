Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA181350285;
	Tue, 14 Jul 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023845; cv=fail; b=M3XbeL/0GpLYRtPhPc0X33UIzZW3B/aQYn4CJwME/IPRcaPnAkBStIBr2pHuzcVWzekt96trN7boWkPxVMV8KwJTbzq+G5tc4maC30RSFO7edQjmVy54/Za9f5l8xw1IKK2RJwAWWNNWh135TKhwlNOoqFcii7x6KFBB6fx1unk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023845; c=relaxed/simple;
	bh=dHO4Xr+fEDGk6tQa8sQJVa6WICwMrWwozHWshiPvdWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzlligIPTCr3zx4xoTWC/fd0A2BQK1oqGAiksvPMOBdLcm5ZvufCGF9ozwKfja5ZYQmNFVkPWjR3G4a7N8NSSe35yibWV3Slm669CKu4b+Rwjv+4yCnB+eb3rCBoq0WQvwfqmqdx55/i0kbPpqTxmpX5YGXqn9VvVpy43OabiIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tUXO5eMe; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tUXO5eMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLqiJ4vlj2NtArGPkfSnzEmkTJPethiApCmnt6tpY0ZcLSnU6i1U6zxXZ1R5QdQFYPT0+6r9V+icFXlJ6RwgaC1ZWruWBwqdAgZs82HwZXFAW+ZsvuA2xzS8IGFJYIGmX32Otjygxkm2P9GUYplnBCK+hN08aqsCkuqsYDiROi8mz+R9gJ1abFTu3QJfX2Zp4G48Oyb54sTat8DLV3z7mK/F+jeMNYS8JeJU8WzvucSzGBcRAjePKXKJa4RYy64/wJQQs9mOb6SCTqz+sc1z4xUok2keCItnD0G5LlE/uLT4o90h6uhTtyX5jypjoL5CqbobLUnthiIr66qka1UYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdsyAF6JU+bBWbX5bCRChr22PVpqj6h8HPO4zKbLtWA=;
 b=w8+lz9860uKcpZBanyKdabSyXS25T5upCuJDlAhuuYSqffrtYtH0xmASjun/+eVxugEY4ylsHrPc66LBB8gvsUKEfMGO/m9F45W6C8MSY9TfBG49kQ69N+W5sbG3bl7lEcI0T7hzWLVULTE/6HVjdKv+57IwFcfc60rWbVHeFSSm6P8I99Yafqdm8isFDo/rqC62wJn+SX7LUqTo5SU6DAeNn8gV3lDeBZUnbvk9YTRubrJ2C1UChdJTFzP9qvJI3CyPGtSyPC1b3mfyB4sUFoFQGTi9qIt1F7xjOKaoVtNELzzSCgPEQiast49LDZf75BSijgAREyS5lBR0xPbLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdsyAF6JU+bBWbX5bCRChr22PVpqj6h8HPO4zKbLtWA=;
 b=tUXO5eMezQ8M3DNqSLK98HyKeU3zJz7aPF640WUHslCXL2wiSTj/uGh6Fk98dpM9FodyTWEp04HwN1slGFXZQ2gwK2YMRGaypjg7ijKTA7mc8MbJ044hfPvmlO19S9j6F2vfBZCuolL++pB/4R4TBWm8XnmbfO3uMfO1DpWMgkiE6kaNPsG+Mo5Pq69VVt+P6hVXBHyRyBx+2DAUjMDvkHPL5zvekNjUooyjZymWbcuUKK7k7hPPjz1FlkUc+X6aWwqjhY4+h+ePH0ZRaRFdBu2M0Tdp3fu2AiiX3osa149frRG3qcpu19IVVWPD/4stwTX4xfoGp/623qEh9xGEYg==
Received: from BN9PR03CA0647.namprd03.prod.outlook.com (2603:10b6:408:13b::22)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Tue, 14 Jul
 2026 10:10:39 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::82) by BN9PR03CA0647.outlook.office365.com
 (2603:10b6:408:13b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
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
 2026 03:09:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:09:47 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 14 Jul 2026 03:09:47 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<linux-tegra@vger.kernel.org>, Vishwaroop A <va@nvidia.com>
Subject: [PATCH v6 0/2] spi: add new_device/delete_device sysfs interface
Date: Tue, 14 Jul 2026 10:09:42 +0000
Message-ID: <cover.1784000000.git.va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 244f4234-1076-4c5f-8f0d-08dee19027cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|30052699003|82310400026|22082099003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9t6P6D9sNBD/5aHrFbnCDj2jIkv8y23KbCuxjqwpuXJK3lk11BWvchmE6F5FoTz0IJDdN5vywWRtnmbprLxB9ADvv/tl2vLginsY/GlOBRawCzEUeFlEnJLM3zrBhH3zHPd8zoaCplxkQk8FktJKScBsfbpo8onob1WcLFS1vStDWUQ2CPD3XCLUKOeJiyyygh9MpBvLPUuQy44kI/Xr3JQ88hBnALAZhDZdQQns8xb2RXefsV5gGE+nonuz2XSI+ra6nC6i8k4H6SHNpFqM+GyIKMuNFDuw3KrHpuByjF7IMi9vbQtwvwIbEhajWIOjUNkWANEyLFd6ZObhP7WAMzSOiiuV8aQ/rMnBDOBKF6EQA9LyrL2xpMZP9pVd/ketgZWb45BOm6COV956t2Cr0S3yNLKBcwCZWOTQVscxUbwu93+oLt5r1DRTkrV/M39e/8iPhmqzFXuYb094hh7A9oDX6QDpeRwWWBgR54o0wU8BowKYPT8Kh6v2Tl1LyOdQL0QxOf8sGyFIPKblLnLh01INkKtT84tRGwu7kv3vgQLCqkDpJhJGMasV9m4D5o2DvUC47n/2TbRMCn97nF1haCT0D356JtbALEpHp4qqI7XG8/lX7Nb0+DlTF6SDMAUA2GPqjXCTJJIy29UTEWTDUv1gb6KdX2d6ZK+aRcqaOKTQ0vXoOgReu9VpxdooBaHqu5HlH1zyrh7JIRfSBFwJaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(30052699003)(82310400026)(22082099003)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T4XgH3YdZYwbyTxqDdzhUvFxqmBvFzsNwAvVOoDCEzN1NLwQ7lumR5F0zVnV9csXPv8YoEbO3yZEzY+tQlIUL66iKlJlYscNuVLzKP06Ghgee9I46g9cosQ8k0px9ITWbv+MD+HFiddUip5jz9u70XYEATBQx422aP5KcccujxHduUtm4p0Qrg8JH2uaxIMxP68SiZUUmGtRl17zkKNXKFcikTW3PN9tptrwBUQZmCaeFkeXbj4t3Z8abVEIaIUZJbRq+V1wg52gi02llE78+g2/ZZcQJf+BGARWD3aohO0EA/ZTE93vkAvyS3QisDNQrF3YlfoFxtrDBOlkAF93FmiRLgVhN6V38DdGistxpeirLQmd/2q9YmZx26dXfqWUsXjKm2PpmfzyAeGSHM3FtybFnevgMufZuAYzuRT7IztQLTxlUb1nnuVd88i8212k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:10:39.0552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244f4234-1076-4c5f-8f0d-08dee19027cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

Patch 1 adds the new_device/delete_device attributes and the supporting
infrastructure (userspace_clients list, locking, dead flag).
Patch 2 adds the ABI and user-facing documentation.

Changes since v5:
  - Rebased on next-20260707 (v7.2-rc2); applies cleanly.
  - Added missing kernel-doc entries for the new struct fields
    (@userspace_node, @userspace_clients, @userspace_clients_lock,
    @dead).
  - new_device_store(): reject chip_select > U8_MAX to avoid silent
    truncation in spi_set_chipselect(); parse with %u instead of %hu.
  - new_device_store(): reject mode bits outside SPI_MODE_USER_MASK
    (mirrors spidev's SPI_IOC_WR_MODE32 filter).
  - new_device_store(): drop the unused 'n' / '%n' from sscanf().
  - Minor comment cleanup.

Changes since v4:
  - Removed spi_unregister_device() call from new_device_store()'s
    ctlr->dead teardown path; it raced with
    device_for_each_child(__unregister) in spi_unregister_controller().

Changes since v3:
  - Replaced holding add_lock across __spi_add_device() + list
    insertion (which caused an ABBA deadlock with kernfs) by a
    ctlr->dead flag checked under add_lock / userspace_clients_lock.
  - Used a compile-time #if IS_ENABLED() guard for the ctlr->dead
    check in __spi_add_device(), since the dead field is conditional.

Changes since v2:
  - Gated sysfs attributes and locking on CONFIG_SPI_DYNAMIC.

Changes since v1:
  - Added locking to prevent races between new_device_store() and
    concurrent spi_unregister_controller().

Link: https://lore.kernel.org/linux-spi/20260517201602.498135-1-va@nvidia.com/  # v5
Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 +++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 +++++++
 drivers/spi/spi.c                             | 238 +++++++++++++++++-
 include/linux/spi/spi.h                       |  21 ++
 5 files changed, 376 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst


base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
-- 
2.17.1

