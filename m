Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFB3793AC;
	Mon,  3 Aug 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754000; cv=fail; b=bbQzwDpUWD/I+KkzbpdL9GWuIQfzC4htODcAL8m/esajVo37Emjati6j0mmDCd2jhHrYXMU5P32BktGw/+wzCkzcC1pN7QW1V0Lsehq6LOpIy/n6e6U/QiNOEzfR7tipVsNNjSdukJ33ekWkTX2Rp2QdRXwNl/qoUpA3QWD0V1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754000; c=relaxed/simple;
	bh=HGG7ZamFacSjP4iRznRHpppyLckPprx0VffxNOrmY0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWvrNtGxJ4ubWEY8B2G+0mvj/VsUfeanWG/Qk7xSkpgYClZCJwYlwwtpqqGmohtBnL6mZcRZcL16V+rQ7ZkmSoRgLKNg2oDYOjr/hTJDdbBZvQI8QBlksqERBbqONIk34CUoCV/zYVEgB0/7M91KCICye+bhveBezaUa8q6Ogws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BBcJbwTB; arc=fail smtp.client-ip=52.101.61.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BBcJbwTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIsFdwNIIdYmJDAnrQIg9rCYF2YJUe8IlPjR3DJfRsGQtj4uP5+OFgqFZb1aTk1gLv3+pYLPloJUj7sqU7bgidmutFePF/+LjB1NURiTed5gO3uP1upjzHc++/RoyMusPVmXH5SXsY9N7bx7h7j1ODpW5fJzqeZfl6LmAc8087K25L9yFj/kv8sbR8rWYywpx5WZ0d1L83rGAMHBBrGe2U9obdkDvHGsHkQB7KnGsmVUxZWlLYEDjiMAW+7xiONgHKEtpnaImBOZ+Ktfh4NEGze2AdVyoOO/xDdKZMHH9jeI+qkSLVTWT+/6RDWqmhbUY9fr1q36IqZaWv8qzMMRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNc/o4pdZX7tZkE6bhblhBGr34ytBAAzBuIpdRGz2j4=;
 b=fDmScBV4/WVRGi9lAvCm/ZXMQdtBOWiAmWcNW7JC+nTNjvwdpy21FkUYFd13tyacAPzIQTDgTL73aKR9g7r//2L6dwQJm1SoVyijyWwa0d7+XTnXYTHmoxBApt5mpyRjEy1tYUQYLlnyTzdSjhp/y9CW478ySB0rkwGhRAZrXYW3g0YMFGCzB8FyXspO7tx9vTDohSFUzW2/PMfb1np7/8Abc70vWiAtgLCD3YEo7hUKMLnGymJ2cenIkOfpcFRU3/c2qVbb3ERdH1k0UuR4VpPTJjYT1iHGjTekcLtzkBiT8mP2YDnMmc+SsKMb/6pQY+6ToHx5Yg77Kr9RlG/VYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNc/o4pdZX7tZkE6bhblhBGr34ytBAAzBuIpdRGz2j4=;
 b=BBcJbwTBDBCQqpPUArI2STt/DHSStQb9yn2rEimxHvcbq+1YbIE9SSp8w0GnJkhTRQHidTO/WWPTdAYl9Knt247JbIeYa6/pIRvCmGZWuUH87slUs55LbmWosbG/bUXGIBt6E/hboBD5MGZYRVFf4gWwC81vOMRPBWK/us5ksKLhJyZbwCNtcsj6CRvOcMEJs2Dj1fempHSJ0afXOOtL55KeE8iurpmSLrq1hwMwPCJEIz0iLPvKBfoifRjshPvEko+bqgCfP7HSbHj+SVsYJUcSr4JdWuXG1rENLgk/sPBoL4PshckmfuZhB0kEsZHCLp46dMygK6igGlBPC22ERw==
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 10:46:33 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::9c) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 10:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 10:46:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 03:46:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 03:46:17 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 3 Aug 2026 03:46:16 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<smangipudi@nvidia.com>, <va@nvidia.com>
Subject: [PATCH v9 0/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 3 Aug 2026 10:46:12 +0000
Message-ID: <20260803104614.2548375-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d6f083-6f74-4b09-3158-08def14c7ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|30052699003|376014|23010399003|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ll3Kviq8a4Ff6nP9RewCMZtkP9Ycy01gdm8OfKx6g329wi6zLW/A+6EICEWDigv/Fyed1I9+ymx05aMbBnLZQ0ZQrSl0Npp7VBowlbC1G93kCA8pwLohy3Avi7tdJgwk+nRnufUFZc/XgyuynffI2BXxN8ShNXYu+ZQMyzEA8heGF+qevvSTzMergFxzy+T193xFWfuZSpZ2voaNO9g9LoLkuYQmTchV+0RjAaU3ANlgj4SL1768HuosIYqks9oMQQbncycKw3BvlXEdNjlCRSzPWgOPCEUjzpaWBI7zr4/N8s3n4e6RjEAEqfVf7NnKXWVuw/pFz+8hWmVOXhXVD+8cKqNJKmjx46U13m7r0/rnsbvBQN/yphbr+cDJp3ZSUa8nUk/1Q4N24cdMM1X6pUOIMA+khsXpu0+q6J0oJHz2ahKCVHVtNM3Jcs1cFp7BissQCgzkgvPa7PS3UTd30AbmkHJNjsA0VPfPu/Z5mBrjbFOZJg3WWeIdN8Civ8VutpmcT8KJEOhJ1YCPQkeMDSdP7Ud6PPTSomA0fcb2QoTs8geSS9sI6F4PxhbLD6ieypNs0y/1YoiuHjRCV+tWOpT3Hsn+cJBZANF2TOrCb3rTLbC/2oIaMovlihGUQnF9Kjl+LGxdctb0pf/L7IZ9x4dkp7v7nCUE0TenlAIX8L8+4J0D/zsXLAhDp8mXGYlmR+lss7HndEFUOGe7mPoH8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(30052699003)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n29YakzutjffAKyVCD9dBixbavNJPEZbBqwGd/WQnYhwSHy2NuUesNeqLQc1+DdZVZGkoc8dhGd58AnaPikO1CH0JBx9QNLOy5abGNatbuYu5CIpBiMF9KLJIZ00AqiZyashISuvLD1J27MfR64OlE4U4aLlDOyIcxyCyD+8H0bY1aIpD9B5U3hCkswW6RkXiUkhpUmUguJ3FT7LAd6YiK8RxzcKZIiJX5WLb2zjHw1CtmeOHuabP2UIAT9r5lIf3AC87dI5HuLJXt3/icFBA7OaKyVY4CwH6JwE92S0bvrUZjFZEsWuHpEjQPq2gg7MVKiSuYvf3HwNXBBLhyhdLbwYhKlFa4CnkfvT4jae80InqnBR8j3AvWjKxlx/jFZy1xlytSEF96zLExJrmY7Oj1My0T61AzNgh9kJmchGjbh6bnDy5EIG/VUUceQRJcT/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 10:46:32.5725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d6f083-6f74-4b09-3158-08def14c7ba8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

Patch 1 adds the new_device/delete_device attributes and the supporting
infrastructure (userspace_clients list, manual sysfs group registration).
Patch 2 adds the ABI and user-facing documentation.

Changes since v8:
  - Restrict the interface to SPI host controllers.  (Mark Brown)
  - Emit a change uevent after the late-created sysfs attributes become
    available, so userspace can detect when the interface is ready.
    (Mark Brown)
  - Update the ABI date and target kernel version, and clarify the
    host-only interface and change notification in the documentation.
    (Mark Brown)
  - Rebase on next-20260731 (v7.2-rc5).

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
    insertion with the current design: the sysfs group is removed
    before add_lock is taken, so kernfs_drain() serialises stores
    with controller unregister.

Changes since v2:
  - Gated sysfs attributes and locking on CONFIG_SPI_DYNAMIC.

Changes since v1:
  - Added locking to prevent races between new_device_store() and
    concurrent spi_unregister_controller().

Link: https://lore.kernel.org/linux-spi/20260728191056.2337791-1-va@nvidia.com/  # v8
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
 drivers/spi/spi.c                             | 246 ++++++++++++++++++
 include/linux/spi/spi.h                       |  18 ++
 5 files changed, 387 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst


base-commit: 415606a7be939835db9b0d6b711887586646346d
-- 
2.17.1

