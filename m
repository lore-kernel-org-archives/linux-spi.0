Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578022F5474;
	Tue, 28 Jul 2026 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207963; cv=fail; b=gzdSlg9R/90wtfx0UKkf2oNqOWTMudrG3LCac2uzJbqp9pEvH416Kmltgurk6UwRjWO94Ho71ETsGiZXY+JwZ8J+8uVO4Ycvk4k4w4EKCISNpzZWSFhVejR2IhbABMYk0xQ/2aAVO1kz/3Bf2uOhaWluwnX1HmsiB1MSW1YHyE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207963; c=relaxed/simple;
	bh=kyiDxvTTeykxaBtMNMQeDc2EKH8OTupOs+7SmRP3SIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c3Buhxnjw4PpRc1xPquog7rDveXcy/PwZBfidsWfXvCUY9PX1MqLNjxOu1ouuAghbYE4EOAol+fYJnmv4JdZkJMFFio6UA7fmqAlKou/g7abCwoDnfAPe5X5vko/vj16JZbYwzd2R8bXjgaknVnMEF+cyFq9cMT/QWwzMrxJu5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qq0HNCuk; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qq0HNCuk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biimKLr1HMHecZQ0Aey+lXaJnCc8nW9+OaZKJMepHAjtPQ+81vlhgcUCdoJdtgmqR8A9++02G0+LoCPA+F17qdrxMC94r6R688jeoYD2rdojBm0y/O4GXY8+cCFkeNYemfzV6mN7qMhrDRU1AT+LKHoMNyuULrejCJkCHStx+FObRUqRBRviAdBBwX0B6+e51FwOHrDiSIzS9ER5X1gNT5cHpNI3WHz/fQgsNyq9gVBPTXKrUHHHjGf0Rex7BdVDFlPMCZA0xv+zaKtjhM7p0gpP6bU3DNiY3hXT69KXcw2Ma6jBH+1Yn1wHyuSKPgehtvGhpEIl6vE8a76YzJ92sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr5Fyh8aRPLP83Xpn2XrAKYp0ZxiiPpkFNPMmRzbYK4=;
 b=xZBNK5z/acaInBTQxI20HJUcR/sj+gvSntuTQwTF/X6VVNCxnScInFIPGffDGHzajYHrjkadY4/pAYp1dZruCGCbsLMNowN6yOJ4iTe88qOlwobjKvVq75O/+Z+Ko2KAAT2mWejj7XMPF8HarG6IUDhLNFEMZifypGmGCFA10wrWTrHzoLbBc9MOdbMLvvZ1+rltubVvG8EhDqZD4f/EHtXNNPoCiAjaxLwFbYhrjBZ31vuB9M2sfq+VQLBS3V6c+Gi5yu5uDyxpS4+irs30iS5xy/+cr/57VN0KgsiwT5XU+b3M0zN0O0enHNPjAuNMl+pPRl6h7iu84+HQ0p2kVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr5Fyh8aRPLP83Xpn2XrAKYp0ZxiiPpkFNPMmRzbYK4=;
 b=qq0HNCukTQgTVvPA+bLhnqMlEcDcpBjcg5CwPbtRcO2RLyIMBbndziWCv4jzT4fKZggWFWASFlaOdT6OjJqW6sGgtJbTpZ2PuzrqyS1KU4FJtPoBVN/HNZ4wqsPo1CNjDyFUfXR5TJQmZzBHn3i/CzLZeCb8ioHjKM11T/DLXfXKg2FisQ3Mp7egHEGlnM/eIffqBS0b6KfMuYJnuQzFDEZNAHpYDXQfm/av7nLBxG7Oi6d19boCNJcCrGPA6coKIk9Gn2X+L4AOPXgUlTT5XTE5xL/j95Ns7boIJYpaDWNCLHmTyRw4FZwT6mw5btRMW7g5HU/7926OS+YH22SYzg==
Received: from DS7P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::15) by
 CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 03:05:56 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:25b:cafe::18) by DS7P221CA0009.outlook.office365.com
 (2603:10b6:8:25b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 03:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 03:05:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 27 Jul
 2026 20:05:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Jul
 2026 20:05:44 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 27 Jul 2026 20:05:44 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, "Suresh
 Mangipudi" <smangipudi@nvidia.com>, <linux-tegra@vger.kernel.org>,
	"Vishwaroop A" <va@nvidia.com>
Subject: [PATCH v7 0/2] spi: add new_device/delete_device sysfs interface
Date: Tue, 28 Jul 2026 03:05:39 +0000
Message-ID: <20260728030541.2279518-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bd5951-1745-489f-7172-08deec55249b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|30052699003|82310400026|1800799024|36860700016|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+2CSP6oNAa89HSHJ1hu+MMOPLF7Zis2cgTst6ABHc3NUOSt2QyaHJaCXg+T2vphoJAsNQsZmKZRgwCFJvFb2tAZ243hyDjCuRSdcTLX1/DistMT457kQf4C1arp3/VtOpEas0RpgBmBQUNU1W56v6Z9WrjB5P3yKAv2AbLRV0gI1NHEvFwGNBRjMzXtr9grYJGSzLToLBFKh4yaxaYEZHBDAhTWY9RMi3Iae5hLqb2gmPB4cwtDmhBLplgGFkasc43EWusLCiEEy63vLZOArmv9AVUcze8Jgt+iinIQttqhDusx+0vQLKc3C0s5TMlTGEeNEnaVHul26Piw9AuetpAwtj9CGZscRPsCRfF25WHM+ZTz/bvPbLblUilwPOcHmpHtRVWxZd3otZ5Z06nlligvbEPHFENMaVsyjT1lVegybMBn/gWgKGFRzNg/Rc1A7FSt4QuXted2hJsa4AZdSqWgE7uzRyPSTFgFWwpGbXwwva/EIhzviylv3RWajVUqK/dWv/dhvvKPOSi7TjMQ/LwJ9CjyEek07XpUr6ZvRRV3NIk4z4+ZvM98tan7Z4IJFc5bDDWfTCeJ0oJjiiWRjOQuaUyUZbQwln2zK9hEvruM6YQovkL0R+t8mo5ZWnqtyv0XD+FpOKiYG1mMgScmWAgZJ/p54zKJB0u3yiwdWw3SaE5KIgBepNNQYap/lbPpdqe5JWkT8SnAyHuA0CfNehg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(30052699003)(82310400026)(1800799024)(36860700016)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HgVUzLnffx1hsQ4ZAqEmbmQAj/QGq/r3+UJSbX+MUuEQdPTXKXDzDGlRI5LTHdW5bjIrEYdM69kPa82SrEcwwZgUjFLbY6PSro1bYeljorvJBIU5hnOsyj8p8GjZ4kxgyNOf1aAPZhODhH+AJpclCPCROxMCJUYPOTEojOpBci/51I3Zf+jx97dXWeAepxbGc8yMNkH88X7iTrUvraUBf7GkiNDamfwxO8haCXCQ3TirXDkLD5BUZ8duwko+GL8e9JUt9rQt3+XFZF5Ke0eCOJXL9nT5RHo7/eSewqECTHTuI4pyoHPhNkVNDFsaQLFsMCx26ESvOca89DIqTEpgzoBaqAT5dtZvQnd3QTZLBMGLfjkt14lcj0IQh2X5c5IPZIyyppltVYXmfc9H2/4a/Xi8sEQJpuivETjde98QS+GG3ERzwkWda7Xw2kNNyzrY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 03:05:56.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bd5951-1745-489f-7172-08deec55249b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

Add I2C-style new_device/delete_device sysfs attributes to SPI host
controllers, allowing userspace to instantiate and remove SPI devices
at runtime without device-tree changes.

Patch 1 adds the new_device/delete_device attributes and the supporting
infrastructure (userspace_clients list, dead flag).
Patch 2 adds the ABI and user-facing documentation.

Sent as a fresh top-level thread per Mark's feedback on v6.

Changes since v6:
  - new_device_store(): reject empty device names (leading-space input
    like " 0").  Previously produced an empty modalias that could
    never bind a driver.  (Mark)
  - Move sysfs userspace group registration out of the automatic
    ctlr->dev.groups path and into an explicit sysfs_create_group()
    call at the end of spi_register_controller(), after the queue,
    boardinfo matching and DT/ACPI enumeration have all completed.
    Torn down with sysfs_remove_group() at the start of
    spi_unregister_controller() so kernfs_drain naturally serialises
    with in-flight sysfs stores.  (Mark)
  - Drop userspace_clients_lock; reuse the existing add_lock for the
    userspace_clients list and the dead flag.  new_device_store() now
    calls __spi_add_device() directly under add_lock (add_lock is
    already the lock the controller uses to serialise device adds),
    which lets the dead check, __spi_add_device() and list insertion
    happen atomically.  delete_device_store() also takes add_lock.
    new_device is annotated DEVICE_ATTR_IGNORE_LOCKDEP alongside
    delete_device to silence the false-positive class-level splat
    (kernfs_drain has per-node scope, so no real ABBA).  (Jon)
  - kernel-doc / inline comment updates for the new struct fields
    (@userspace_clients now protected by @add_lock, new
    @userspace_registered, updated @dead).

Changes since v5:
  - Rebased on next-20260727 (v7.2-rc5); applies cleanly.
  - kernel-doc entries for the new struct spi_controller /
    struct spi_device fields.
  - new_device_store(): reject chip_select > U8_MAX to avoid silent
    truncation in spi_set_chipselect(); parse with %u instead of %hu.
  - new_device_store(): reject mode bits outside SPI_MODE_USER_MASK
    (mirrors spidev's SPI_IOC_WR_MODE32 filter).
  - new_device_store(): drop the unused 'n' / '%n' from sscanf().

Changes since v4:
  - Removed spi_unregister_device() call from new_device_store()'s
    ctlr->dead teardown path; it raced with
    device_for_each_child(__unregister) in spi_unregister_controller().

Changes since v3:
  - Replaced holding add_lock across __spi_add_device() + list
    insertion by a ctlr->dead flag checked under add_lock, so
    add_lock is only held while doing list bookkeeping and can
    be released before device_del().

Changes since v2:
  - Gated sysfs attributes and locking on CONFIG_SPI_DYNAMIC.

Changes since v1:
  - Added locking to prevent races between new_device_store() and
    concurrent spi_unregister_controller().

Link: https://lore.kernel.org/linux-spi/cover.1784000000.git.va@nvidia.com/  # v6
Link: https://lore.kernel.org/linux-spi/20260517201602.498135-1-va@nvidia.com/  # v5
Link: https://lore.kernel.org/linux-tegra/909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com/

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 +++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 +++++++
 drivers/spi/spi.c                             | 270 +++++++++++++++++-
 include/linux/spi/spi.h                       |  23 ++
 5 files changed, 410 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst


base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
-- 
2.17.1

