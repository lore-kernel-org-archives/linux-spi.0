Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663C44AB6F;
	Tue, 28 Jul 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265884; cv=fail; b=FKvNbF0wle+7ugrsMW4+n9x0SkOZk2nz62omLuLX8asGTyvxzVufBztddNBVs+mZOlQMfWEIAQqiEdBUL3ZlOs2XCR1dvVbpwG8Dzse0WvT6GXZVNawqtjB6lAF/XZtLnXkmHFvA4YBLsybqpDHVid9HLNuWz+bcoBKbecZ3Esw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265884; c=relaxed/simple;
	bh=47+rWuUVAnMTu7phD5LbV3IRmcItFpRf8HLUZZPBlqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lrjagf9QgVYG7bl7yBGvKX4u1Al/N00wXTes7CdVptiZVpm1UVccecF4nCjaHrwkmkh/8tXTvdtJx7tYALgBPLqsoBt/DqEQdaZ+sG2IeRcWEgO6e9lrGrJtXRrIWvfczSpr61gENncS9FsGJ8DJQJF3gKMr0GIFNDdF6LFxIuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZYfSHYD; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZYfSHYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW18TG57ZBabl6btG0v1ilu0usRQA+DKlU2GrJOJ+R7jBH4WzHjSpQ86nNEYjNFAAxZ70oamCjK3QWNE30GzhnnnOjGJTm2J+QMkHid8mXHAkoJ4eV1aBNG3uee9tZx2st4+sGNqONYjwYrGcVtKMo1NjCnNG5Fd0suBX9n+st7qNV4muVbg9Ih8deMafnfKR1ucyD0V9hERZAoaUARnKRlcIRpog/uIkpt3VTBwosmnGfv19o0aay+zkcLchAeyzoHPzjnPAzSZtgJxjARqg0/7bUJBbdPYV3sZ+gb44Y46+3/SG0t+wtgJb6iU5S8WUJjVoGJd2yl7rSA9cZkAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCsggAagejOv86ML0SFX7ZWFLMhWWMRh2D1CCbGQOgc=;
 b=i5MJRuDSKU69qPpnA8Z+dKW19/LXWfIVWUXUTcOj4y4fBoaJ0HFHf+LYBtcnMo3bVLD1rQbG4MEOu8RbN8CuO7Y7YAKyBGe/32e3BANFyhnCVrCeon5MYPjwfmQYP5su9JusYSApGNYvxvdgS4D44/msjGpvtQJKwPRshbY4MzYE1CCFwUwuooTCawyYZSCmQryFVZwmRlITElFYyJ7/CeGFof4uhln0im6kmpNFIC0NL8xPUNHXIOIa3H0feE4j38ReCrXKi6bkp5Nmm9395BkgOwnpDkPWrIbzRnjurHhc8ZE4Fxpp6U2z3mqKOTraHm4e1GzI/6fR2JfLGTRJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCsggAagejOv86ML0SFX7ZWFLMhWWMRh2D1CCbGQOgc=;
 b=uZYfSHYDwb+QbgPYUUXCIACm4R/dVmciUCPa9wHXU8vjpVZ3QvNlYeLLXPza5bcqkIHj7gn0GadAb7C2XvifHU0/yi4qQDWKCeKk1ejZiE4aE86medPF/N7zcTg8w8JUl2I3Q6KDuJOweyzD/M4iCQwUaBCT0+Lht6BkQ/Jbzw5soan+Nh2ZVo8eUx77Tk0Vz9Og8OqOwoDFwiElFmyD5++d5Xzn8z9cYpCbqpZS+g9w527TunmZDE2PBQb+urF60CShTfOKTsopLjlvumrF7zsPFxDL8fAk6AHx4aO6e8E9FzKyt9NKJAvbSHSsFN23MXsWmxBtM2D8p7ypgWisNg==
Received: from CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:11:17 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::3) by CH2PR07CA0059.outlook.office365.com
 (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 19:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 19:11:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 12:10:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 12:10:57 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Jul 2026 12:10:56 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH v8 0/2] spi: add new_device/delete_device sysfs interface
Date: Tue, 28 Jul 2026 19:10:54 +0000
Message-ID: <20260728191056.2337791-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: b83744c4-7df8-4c4b-4cf9-08deecdc0048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|376014|23010399003|36860700016|1800799024|13003099007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zW2ZHjDxxq0LZHlZIRN5Nb2YKuWKDfCqletcMQJwCKWdZ4y8VXePOcLbd47JCJMTjepp/hkfqGxQZzYuW0JSUBtYU93UNVyt02yK0Ramcl4cKpM7Y6DGPf0QIWBCqVh90BX5hSD+bpGlxiaUlIT1uLVbkw/14kcCWTed3s9QzmB80MOHoD64hrwJWstL9HbQ204f/dBWTdZhyl/GAzCJ5+4DKLYqtC6tBg68IyphYYvzvqOswV+0oOdRTmGI90eJLwni0nNfSNLic5jGi+sUxUAJWgslCbKgoMCakyELRqUU/eolBUwtC6k+/ADWqqfQbnkH2BvXPadpFpEg2FZZszxlmgIFZilS+JOpIjbSTOBOEeArav4TuC+C9xj/ngQaUD7WoNraNa0PR+FPpsTWcLHjFaDrrlmbwgDvBfA2reDMhl4AnllPCV+l3Qn9Zd04ZZcqP5YhoYWv28D5VVZdE4CxXLPdsG4Eoxm4aU1aA9Un6F7msmPGfxWxY/9161GQM1W5WRjuu8/IawbBl+tpM0vsak5FwLlZftJT4Z1DL8IpJtH3P70su3RJEGB0kxzzOzHZlyXZo/fjscP99yfXQFL7dHEAMILVFlzYcF5CJ0NzHBx8VJvo+xnGKhzdvspMq9X8r2lThItTku+4raSjdRhXfSvE8bTusmJtWzR0/pHJLLny+Z0+7POr2SDm1LC3pd5Egfd7SISh/xIraSQEYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GGnKyZxBPAh6HIIQRuSr5c1EjkGwiEJ2yjtVyj7o0ImSNxNbo4s3CeWgv1DX3mWt0r7YQ05iZWTgKe+Qmkwhtmx+UFn3XjuOUYM9oSu2ckVVebETu2KZ/k3DjtPJRvYLKCFsUgSigSnzB8fjsOCuzLy5f9NMTOYesLa3EYdgxOd/du4E27hFQgECmMCBr+06KqGdoiog2xOUlE5MycKfyBCORJK8SYQFZL6Ynq/c8kXMsb+QLsV8FvmiTz35VIL5/p7xs2DNY4nGi++/c3Y2Xa1VaUNWEFQpUnbMnBOsyCMIDO5fgArC3Fi0oq3yIVOwOqLOzXw4VOBMXt96ZWsGhATIB8zTWV/jEmuaPDqlqmwj18Fu47beOQyG8Ba2DH33A9RX908cKGwD536oHjg/cU3HgAZtJOkurUj2qLO12r0SvzP6vx0LKdj++1KH++nd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:11:17.3393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83744c4-7df8-4c4b-4cf9-08deecdc0048
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

Patch 1 adds the new_device/delete_device attributes and the supporting
infrastructure (userspace_clients list, manual sysfs group registration).
Patch 2 adds the ABI and user-facing documentation.

Changes since v7:
  - Remove the redundant CONFIG_SPI_DYNAMIC guard around
    spi_controller_groups[].  (Jon Hunter)
  - Restore the original add_lock release point; the userspace sysfs
    group is removed and drained before the lock is taken.  (Jon Hunter)
  - Remove the redundant dead flag and retain the base-tree
    device_is_registered() teardown check.  (Jon Hunter)
  - Simplify parsing, diagnostics and comments.  (Jon Hunter)

Changes since v6:
  - new_device_store(): reject empty device names.  (Mark Brown)
  - Move sysfs userspace group registration out of the automatic
    ctlr->dev.groups path; create it manually at the end of
    spi_register_controller() and remove it at the start of
    spi_unregister_controller().  (Mark Brown)
  - Drop userspace_clients_lock; reuse the existing add_lock.
    new_device_store() calls __spi_add_device() directly under
    add_lock; delete_device_store() also takes add_lock.
    new_device is DEVICE_ATTR_IGNORE_LOCKDEP alongside delete_device
    to silence the class-level splat.  (Jon Hunter)
  - kernel-doc / inline comment updates for the new struct fields.

Changes since v5:
  - Rebased on next-20260727 (v7.2-rc5); applies cleanly.
  - kernel-doc entries for the new struct spi_controller /
    struct spi_device fields.
  - new_device_store(): reject chip_select > U8_MAX; parse with %u.
  - new_device_store(): reject mode bits outside SPI_MODE_USER_MASK.
  - new_device_store(): drop the unused 'n' / '%n' from sscanf().

Changes since v4:
  - Removed spi_unregister_device() call from new_device_store()'s
    controller-teardown error path.

Changes since v3:
  - Replaced holding add_lock across __spi_add_device() + list
    insertion with the design that eventually landed as v8: sysfs
    group removed before add_lock is taken, so kernfs_drain()
    serialises us with unregister.

Changes since v2:
  - Gated sysfs attributes and locking on CONFIG_SPI_DYNAMIC.

Changes since v1:
  - Added locking to prevent races between new_device_store() and
    concurrent spi_unregister_controller().

Link: https://lore.kernel.org/linux-spi/20260728030541.2279518-1-va@nvidia.com/  # v7
Link: https://lore.kernel.org/linux-spi/cover.1784000000.git.va@nvidia.com/  # v6
Link: https://lore.kernel.org/linux-spi/20260517201602.498135-1-va@nvidia.com/  # v5
Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 +++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 +++++++
 drivers/spi/spi.c                             | 241 ++++++++++++++++++
 include/linux/spi/spi.h                       |  18 ++
 5 files changed, 382 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst


base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
-- 
2.17.1

