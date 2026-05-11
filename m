Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC753D47DC;
	Mon, 11 May 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496021; cv=fail; b=Y+QX5mhL7KLHqdmaGEIjNrMLq5eclLUqZfyOORfNOvY29P7ufRSrp7B9KzxT40YgpCu99KR//87cwmpptT3ApL0HzhcPmaIeJl9y2TGQfslI3K60JqFPNQM8jIPDFYrZDiYMacUOVwiiwhI17Q2FVpGRGdjsu3KB1VIzfpJqjS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496021; c=relaxed/simple;
	bh=ifmlf5KXy7HAs9a8+r7gIN58tGCndQQggvUkturq6Tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXn2bJmmPlxpc4d0sBmVQvs2buAdT/LCaKGGFZEEo8vzVARGpqi+HGRt3nQhADLUJ1PJrQbXu+V+Nk5NN2CfsTBkafeLjrKilTgX/ySSSfutklZUQP8M8YQqLUJHLALnnPwKUGA3RD1tXyJZ1pDu6VTAIRbn0kWlQwuLWZhjAEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkLhiGmD; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkLhiGmD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNg1XIsItlOR5igJ6nesNRRx5Y4XXmgK9hQ6IxBjejLslR3Um0ctq4HB+TgkMCTZXmuCeqD8uZdGtoGoIlXPEE9cVNQf+HhBSGifQBVKzXaRHJsSadlsI0jhBWjPCXLY9v0QVJKIgICfh9nfIs5boNoQeDT4UQINV7h0e23iHdxdFv35Hgim5mcFRw+FOer7Rn09c+5Pfw1uzagVDXyN/8iNnl8G0SCo/ucRKgE+TaAd8Yx5H6T5QU3uHCYPMLlI51fGe3Nb07tniXtFfU71t5SUBAI8r8DsyGfEZ98opXsgFzOvM1SspWv55QeqMdlJNiBoiHFkLa7020SsTHzs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG9/rauUu5gKOBAvQJNB9KdLvKVr9eXlMKlaAHgbJzY=;
 b=ZTvSyiYZuAmjjTA4p9kqL4BSCfSSUpkMTZ7TD6jWHGRGonEUNif6X2/sEN2I48vGKP7nox4B/nfKmkPFTp9epClExM9s6rBTJZx+yhxsNxSHc8hfzhAedXNj86rcf+qjqCBJCHABmEJHS4Ru3/dldNduMK226Y6QPmNUoZ5ALRtDDdHXeFGQILfzKVQIEETXgz5u3AuZeVC3Ui99u+YhaKrRSbz1K27eK/z6A36K8xsQ6x5LdIwViPmNcYubuYNeUlYevSNomdzJDAUbY4m3G07qVnsdxeUtR1+jw+YZ7RPSny173Zi4ROaFtRX7FGDKrJ7zd2+GEz9PRUdcFTcNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG9/rauUu5gKOBAvQJNB9KdLvKVr9eXlMKlaAHgbJzY=;
 b=kkLhiGmDnwey2seM8gsuo5UMR9aK+ON1U7pNcfXMRezyYwLG9L4pr/Wnp88ypivLS24KSv1By49K80jHqntY/iSsDzvPk3QBi0DEOt+JYoHzW3npFypxeN635SdMH0oUVhfSxgd8DWwAPxkpckZ3GvvbrCnc5xOMQDUhrnWQykR2ToVXE+jQUKvBP2cjp6KjPLn9dmcfVk6kwNRwHPU4tAIWHhgn/TjtChWq0L5NclzpLYgArJAWtklupqFzg6DRAJkxDFmo9I+908eFu9OZeHx8e3V4+khPiw2DFwpFJlyEzzwdLmFL+YNY9t/FgSCV9pmvtMWm1llQ2CpmnGbw8w==
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:40:16 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a4) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Mon,
 11 May 2026 10:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:40:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 03:40:03 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 11 May 2026 03:40:03 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v4 0/2] spi: add new_device/delete_device sysfs interface
Date: Mon, 11 May 2026 10:40:00 +0000
Message-ID: <20260511104002.976269-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH2PR12MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 23177a80-1db9-4b2a-8775-08deaf49afcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|36860700016|376014|82310400026|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	MtMabcQuedrnfQrol9uwrcSW/P5c2sQl3GGSOPLOMYVURsI5dlaw9CNudvuPWPGfFxbH0573MKBUuWMQnNmGSZL8WGwbwy4a7pfQWFxnSazdDLej9EA+cQof/7V3btXGnWAB2NoGHZRhICo8itrbUdvUgPmgRyLyxZERhsIpz3kOdhdbxPePmy81bFHyXjefWl5yA+V1Dj2z+asWAZusUpmY4UvrQ33UKXjFaeRA8i5eOf8F4fKHPPs0tOtTChhaIIw03SUuVw388bAOS4dDp9KF9eMK77Z0KhReDXVnONpXVStgp2ks7ubstEEykdjfeo8Vfr1MpwxEvtgJlTXdjj7JFxUkJ5ES4eiuOq13gmh92PrfBhFPHcrYyeZCS2IMyuS7GvthApLyxls8NCsQbyDvh3bbqvsrmXrIzEyR2lZnen1YbbCRY8hS9oVcI9GkO2UwKge2ZlbVRuNtE5FQNG5gRhp0nkJueWFmD2xLOfHBSlfPD+ZjHWnSK67U7lQRV3BbmhG3PVJ+vQQNIbRN2+UxMxi+pLj6URgGwOYqxN64r7VRQabMj9AOFlUtKtOh7lgrdl+6LVj7oM3SPlMf7861vJhZ+2jFShLrq5izAJopxh0TWHwLCmq1ixLAUGEx9ikR5gRtia16H6UjPPfZ1Bhk2UsREWF2icYh5GQDwBb1XrkWi/PdPuMAD0qA38XXl9+cAMCQ90Ag0xC1Kw3ffv7yvwgwvrOlSDFAOhPENYs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XmyJiLrEufQB8+gIltfllSVj1W5KgaR6evSpRPK6H7852nrXUHM0CP5J6ex2I4/K+MSPsiWrR01nL4MaTVsoTrxMPENsTx5Q3SkaqoYQKWx5SeEWLMnvoIqL4Jtn4QemjYxL47IFGZ7Z0aE1LkuUP7bl/eV7qkEc95N+lDfYRK+FNWMSm/pGv238BjEJjVQMEFN2CM1DXy863mlRUdVq9p89pf41Yya4w7if4a9ZNH94kGxtM+9hCKZy8Ldpdm8rABpcgdarlgbp9jhI5zs1z8y00KRJkq8KmurfwtKV7F1s2IIEjb98uGabqagk7XFtH2Thhr1Z3pcHPPqTgaXHOctNV5Qg35WOdp2bqbiG7Gq+IgtEWKK/EbDeRMxaoYZ/tXmTnhf0T2AXu1SRcYgQuWnl/bJ2JVzeeRW+U0toXsmfgVWok8/yC03t2rlmU97v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:40:14.9822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23177a80-1db9-4b2a-8775-08deaf49afcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

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
 drivers/spi/spi.c                             | 216 +++++++++++++++++-
 include/linux/spi/spi.h                       |  13 +
 5 files changed, 346 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

-- 
2.17.1

