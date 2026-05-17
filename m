Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA3248896;
	Sun, 17 May 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048974; cv=fail; b=EKRl/2NnRbRoR4fzRmqYoFRABWu7JPPDlABqI/YKVkEW2lRnoQyscC0xL+Z4ZkqfeAN1MWUR+KwfNJmDjW9Bdtg0KWPI6MsedghiFqhZ9fHWqhJFea9ZAyEdhPQtAhIAGbfQSHdAnaxtjDojYlTt+DmxHkjoSzTmOq8en6FKSQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048974; c=relaxed/simple;
	bh=oQ3cWbhcS3dcWvfqEtEEopip8gPlADSXK0bzW52BN+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VxPKssRHh7PEJdBhnH6z3fa1PZE8guoGfaQPgYnQb4/IIjyfdxThfIC7VxdsXpQ5ltmDdjtmZTqIOTPojxizArJhZxdnU2jemYyV+g/zuytAU0T2ixbnIvmcrhv7ZhwN4W3vNHU5DH9niy/XjWf4LdgRXWxF08zerrVR0hrtyNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HyEP2MA7; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HyEP2MA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcLAo4fZmssevHSOjaLoapcDMZPNMSMwOxDlNep3mMPTGk2XJdr+1a6YBweL9fJBai6IBujXPUa6AwsXEa0YMSWeA/cauofGc0ZPbiewH7gDL4a6t00MuZs5p3A8on7i0ddkYl4YpJgyBVw0xWst1SMvGw6YvWzgZVzYTP/fK+BX1sCAs+YhMPSlQ8JcHOKh5azm6zI9A/+Ir+YyjAJWtZVLVF8q1Nl1VwdYwtTn6sCh/2FhaVJ3myxZklZEut5x4kZxSfqPN0kRqvJ9YIvXigJJ9CT/DBIKXXdrLzoDvrh4OGncnCjpoxuiostStCiVFUuI3pt9Ramf6eUYQW2GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+F1ty32Ng04N0XBojEbtGgS/Jt931xMq+tkjplUw0U=;
 b=anpkGlM+zAXuUiYNUtKgWxc7Zq76jzzh2H35MXw2pBvKljOVc4XVnJm86WitF0hXiCgZ8LL7aSdhX6rjXjD1Jzc14/KJxZ6sQPxgH4rmXEdDG9WEiqelUqQD4BbZesOw3/CoEEhKsDynDcf83R5eHePNcMZBKEEvgkJlnNmNsEZiNqqjFuw2STsHW6TERvJi5ERqbwqPgJYmYZeOEiZosp9stkDa3INzNG9MF3MkKVEpBFaCiY2aMLyL4QftQMF4Yn3DZ2oqXVXJABwtRE/brEaw/W51oS8K9VVpGvhybbPy4bdn0MWmGbIqlcrgwu7wx3YlVqP8V3PIdNRfHsxEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+F1ty32Ng04N0XBojEbtGgS/Jt931xMq+tkjplUw0U=;
 b=HyEP2MA7ZU4qU9H9BWDxHSJibVWcoCwwqsJN8OCKavvbCp+sMYtIv4wxyUEzDuXkABk8uass7WjgatXCVTq+NdEYxXsUX/d2quRCopO+ecwMnJdspqREQLpSsfvc3LwSmCYTKiY1JLMFpsXoFnrHjm+1vi2QlXqiXSnIeccfc72eHLZQdOPsCIAbuRfo/0fJ7NEcdxah65z55Xq5Coc5KGqoe2eVkZz7F5iT3ENxubwydAplOTg5W7bmE85nc9qk1FmYiytb6Buev6HRr9cla4fXdISyPPZUt/Ap5F7nl157FZKDlj5QW2ajLIJbFgtbKmjnwrWp/Ex9CgfT78vdyg==
Received: from SA0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:130::14)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 20:16:08 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::9d) by SA0PR13CA0009.outlook.office365.com
 (2603:10b6:806:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Sun, 17
 May 2026 20:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 20:16:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 13:16:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 13:16:02 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 17 May 2026 13:16:02 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v5 0/2] spi: add new_device/delete_device sysfs interface
Date: Sun, 17 May 2026 20:16:00 +0000
Message-ID: <20260517201602.498135-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 89097fed-721e-4e68-6f1b-08deb451218a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|30052699003|11063799003|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vKJ1JKfTWzGTg5nTYCPcBCjsvtrZN+PqjO+eu/meYfMeEem1lCqDmpLe+FHeR9+zSLDXrFFwXmVfWacBhf7bAr8NLo47wcZd7f2bVDRVTEQUif56S3cFK7ElxMaNXcBG/3VQNOT7qML6GpX7qUonll1GWbFYzKFuCJSVp3i0VwpPGwPINjAl3PRKcaQvbRvQaa//36Ctp9CrKY0nZ7BqDsFKD+RcUDSfWQ6Yflqc0om4iiGrGKCJjB8iFku85AZiOTC+MkqVg0Z9d/cSeNdlyXW4xdLsa4vRiKg5ND192RuXocPyL9ysGYua/FOR0UQdNNS33c100AD0rpU1NU2e0eTA7oM7zAyQcEdBrwlmRa8KdYx51NoWJeM0HQgZNaK1DiFc88Hf9SUPKTIi2CT53mhmuAFDnVhtSE0lHbnnpLsGEdDIngXHrPSA/SEv2x85vf+xVTqWHYYdH6qKproMhDpZfV6tGP2E4zANhlhSQ3ZM2OHTpDmD7OQis2goaXuc1tS08ew3M0Z0gNVcvNcO1XrKJpQZLoawJy04IOyR8/tXkEN+o4J1xRwG3rjTGZO5EeOhvLruEpAIQKLd58C/fGWWGkBxhST9F0yGpaZi75qy1u24arZSrxp6zrvSBZfxeuWdevqKIwe8xUpvzvxWlN756b9qX2BYsTU6piW5f3VpykfStojI0lzvr58a73HYNCcl/NqdLvzmqlYIenzjDclbykQ3+ZnnmaUltOJAmvY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(30052699003)(11063799003)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aM4Az64cHmcctf6FBp+PVP9PydMkcjM3AemcXxnePwI7B8GhPpsb+6jQdKUvscsdIOvwofg7xGPbt0bjKKPfvR5vUzSLZok+EuEUV/6GXqZ11Nh/5QLaNwlHCbAa45whOeLj4Yr1mfiuKi/RLZ99wLZa7uEZRS/FosHXiuO8o8x3WkQ7YGeH2hnbvzOl2dYsqDVVHOS/3rCjcDuvskT2jyFwskRIkuFOcTs8v31wlPJ4OFKq48t2co3ouII9I2OYYUhMcXafEvoIbSzD95F+WMBrcN+Ju25fyRgqXL1bOiPdSTCe4lpbY33tM7jWfM1YVo00rrGhbovbDREFrCkwIMZFyAOtZZg/hHVmIs/VTjqH8WmeBNKilUOKHPXuNdasZzeZp0pXsTajiCa3gO3xGYvOun9y+9i/acNo8Gebhhs3vMNfhntIxr42N5bRodVH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 20:16:08.0512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89097fed-721e-4e68-6f1b-08deb451218a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

Changes since v4:
  - Removed spi_unregister_device() call from new_device_store()'s
    ctlr->dead teardown path.  That call raced with
    device_for_each_child(__unregister) in spi_unregister_controller(),
    causing a double-free.  The extra get_device() ref keeps the struct
    alive; __unregister handles the actual cleanup.

Changes since v3:
  - Replaced holding add_lock across __spi_add_device() + list
    insertion (which caused an ABBA deadlock between add_lock and the
    kernfs active reference during concurrent unbind) with:
    * A 'dead' flag on spi_controller, set in
      spi_unregister_controller() under both add_lock and
      userspace_clients_lock.
    * __spi_add_device() checks ctlr->dead under add_lock to reject
      new devices after teardown begins.
    * new_device_store() checks ctlr->dead under userspace_clients_lock
      before list insertion, falling back to cleanup + ENODEV.
    * add_lock is released before device_del() so in-flight sysfs
      stores can drain without deadlocking.
    * get_device() taken before spi_add_device() prevents
      use-after-free if __unregister runs concurrently.
  - Used #if IS_ENABLED() preprocessor guard (not runtime IS_ENABLED())
    for the ctlr->dead check in __spi_add_device(), since the dead
    field is conditionally compiled.

Changes since v2:
  - Gated sysfs attributes and locking on CONFIG_SPI_DYNAMIC.

Changes since v1:
  - Added locking to prevent races between new_device_store() and
    concurrent spi_unregister_controller().

Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 +++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 +++++++
 drivers/spi/spi.c                             | 217 +++++++++++++++++-
 include/linux/spi/spi.h                       |  13 ++
 5 files changed, 347 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

-- 
2.17.1

