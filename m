Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281E303A35;
	Mon,  4 May 2026 07:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880457; cv=fail; b=Ums1lmDmqogUknqYTKkHfJ6e/+9Y3J/Vg4iPvB3BnohYL3Slkx5cd0YwFZTIS893idlq/zrU1nV/CPAh/cPOsCLmN6aGjC1rkeqj7owvRlulo0WUOuqoe7i/SGo+eOSKuywsKz7sUrM8vdFi8DtE57VSmYy23Ush/MX04S5g0qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880457; c=relaxed/simple;
	bh=DpA4502YzU6sHyulmjjNHF0N0JyijajhOKuAbcpF+Cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hp000XY+dmXX/orjao2cTRyMK96xOat7IQMfIHG3ezct7mhZZzYBU8SiKyIaWK+1RMGOOaWjFZOf8Z92qo4XvsS9mAqnEq3ibkh5YSXBN5FBf6gSpyEPNKYq6vwON6TVE16Q/mDck+kbdRTs2HwAj18yk32HF7hejloTsTmQsa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gj3MrgOs; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gj3MrgOs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKK8uyB8FMSGkc9RQANVTft11D606LZzGDTbeOWgSBx5z0yOPJ0QeoRwi99TsrTe77xxhtam8mwLH5/PTGH0g/XXe6++YiOJmkJHoMfZzTBkfz5PYC88Zy7SX41CBgjcBXd3eUJrqnQLRBOHZnkMs/UR4XDHioggQENm80tpVNcb3UCJ7mAWJwavggdbJwUfYEKJ/A7wJyAKlY7MfW2Vj54cef9J6x+vZuNVdI5/dgneN41huTEOZSYreeCLtxFcPtvf6d0rd8tSBsLmm+XGyLox0vLVVzeVMZDl+TXHgPJ34o5olKkRIpOSj3DeCnv0++Pkf7jifA7UhpWQ/9meiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TduM00EPChqZQWkBNAHY69AbjxvUS3ealUPnimASHI8=;
 b=pUsS5uGRVNC5m8WHjmDBh2Mr+H2MCbsbSu2dRCnKVY/ZnF/ZSae7Ee4G5jqauVGrmG2wOnP6oA2ZhAgn9u3ZIMbImfByR3vj2fjIwsCo9D5d2aXCVHsTUgQI2vNAkJb8mAMy5b2bS04vN8f3kj4piNP00JTArUVryE2gm6WxWEVLC08YOCau4Qn3aDyues73Hhe2IQsLDVMTskdQMof8UYWfjDs0+xkrWkH95EX8i1Z/L9mbk7Y4+cSrB9DNs5f+UH2OxEzJr7I7JHtpgeOve/TU3A70oG+mQeu3Aw+Y2YHrmld/6z3xgGT0K5FPVPTRm2r65nIXtiz+jR+R5YCaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TduM00EPChqZQWkBNAHY69AbjxvUS3ealUPnimASHI8=;
 b=gj3MrgOsPJztRT6Y2BZZ+r/Plmxua6yuVv3G9Qy2bATkPN+IXOwAV+hC+eP4LAjvipzvF+WkcGSZElI8tPChd0nn39tnp26Cf5MWG9L39C339XD1ax2KGeE7zuZlgXSLOk1iw+KWU+5py1Un/yBMatpMt/ojOT/qJ6wfprni2USFhh6vpXOMRn7ROJnH/RnQHt9UjRmqkFyG6b49Fy0XW1LNkUbEbOKSU0APw208AXGv5QKoRkhLgfGohHo8GlTdA0XUuU/H1enX1i3xOAmpoxtCDs2+3MmfU3dfbRViHI/iwpKAevaRmG1gu3Ie3bp+lXcCX9/k03icWK6Cz7w/Qg==
Received: from MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) by
 SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:40:51 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::50) by MN2PR01CA0060.outlook.office365.com
 (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 07:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 07:40:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 00:40:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 00:40:37 -0700
Received: from build-va-bionic-20251031.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 4 May 2026 00:40:37 -0700
From: Vishwaroop A <va@nvidia.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <smangipudi@nvidia.com>, <jonathanh@nvidia.com>,
	<thierry.reding@gmail.com>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<va@nvidia.com>
Subject: [PATCH v3 0/2] spi: add sysfs interface for userspace device instantiation
Date: Mon, 4 May 2026 07:40:35 +0000
Message-ID: <20260504074037.704833-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6def6c58-1ada-4d65-e764-08dea9b07700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|30052699003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1fvoO5DzreoFjdyaFK04N2h8Z7bSdaD4NScxX7nPI2W2dQaGUabdTb6zjSJkFLWz+M5e8ZyyeZ10q1D7u2XuDxU4rFIxjPb7HXFXoAYu+9wlB/kjXWao8ljTfJ7Q0uL+sf4ECCaxzIvdyRDU/XJ/jBjTZWb3IatjWPNZgjOjg++E98+K/pDgZ73/lDd8jhJERHNcozA8yvCe0w6WyuWjoX6yxb9mJDCuCjh6SULL1CrZTCkY5T8eEaPCKk/fvwcenb5L8KM3KkYyYNoCuL429j/fNEif4E3wW+m6RTIPhRNJrtW4ZBi1LIwwd5LpSaJaxOxdU03bMX0rqK12HC6ULJyGx0yKYNxW0dXHvXqjYl7jOzx1oEvqkS9/k/4vX4mlISUsIwEu4as+wwWCyMQqpys3MO8wOLco0Y+hp4kFeB2tUoZWgiXdkGJVdOvTfupFxeECEPuBER2TeoctXofQLhexZabcXgIedDi2fTBNuTFiX4KxPkdS4hJDTf8Oubc78bHmJf7YTs6CmJZ/sTneHconsAwL74nXEMfWqXBWh092ooqLAbP/eDbdDl5qUUYryWUZh/x/yjb+qTaZtfqElqscR0mP5vwWq6MlmtEIf7jLLKViuxdwLtTB7MlC5Fo1nXmB09qhfHfIu5ET3EQOjZECKE6j58kavb2lSg6JWdgvAq13KGbtQdG95A6YVNoP1gnTWXKb7ByfpIT6SfEFT6EFWfQ1J5sp/ODerX20alA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(30052699003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xb2hxlL35FRkYvExubHjBFSpPHVffmLMS58bSHLRBlNE7W2vWNh+2wSY6VyIIgj5Fcvp9TR7PSp87cyMZE5/R8iKE6CVTClxwC1blFyjOZQVtvcO6/WsemBO4R3ti6ITw5AZNC1zLlPIUqpS/jhQNll5aAVN4UMUGf40njVtJygTWnpPWzsMc/Q6iZo5Oxk4JbntXD4THW1DJ+tL3sopC1G+0CaTGN3lOw3RqpzMkY4TSSNTLU756+c1t4suvDoZdYfmUzshygzCAIQFSmN2rq65PLaejyarizOIAcezC30NFcUQqIL8nODxwvy0lot2nAbcR8eM+fySG6McLa+5OO3lTaqAKB6eUNyKxEK5dEmyx+1Fuc07/qTe1znwkSI2jkTU4yfxgyuY4ut6OvANyVZ6ut0jb3xGbTL3HZDYlQg7oobaskmkV2K+rRAhZKMs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:40:50.7110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6def6c58-1ada-4d65-e764-08dea9b07700
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040

Development boards such as the Jetson AGX Orin expose SPI buses on
expansion headers so that users can connect and interact with SPI
peripherals from userspace via /dev/spidevB.C character devices.

Today, instantiating spidev devices on upstream kernels is impractical:
the spidev driver rejects bare "spidev" compatible strings in DT, and
vendor-specific strings have been rejected by DT maintainers.

This series adds an I2C-style new_device/delete_device sysfs interface
to SPI host controllers, enabling runtime device instantiation from
userspace without any device-tree changes.

Patch 1 adds the core sysfs interface (new_device/delete_device).
Patch 2 adds user-facing documentation and ABI entries.

Changes in v3:
  - Made the entire feature conditional on CONFIG_SPI_DYNAMIC using
    #if IS_ENABLED(CONFIG_SPI_DYNAMIC) preprocessor guards, since this
    adds a new way of dynamically instantiating and removing SPI
    devices and the add_lock locking in spi_unregister_controller() is
    already conditional on CONFIG_SPI_DYNAMIC (Mark Brown)
  - Wrapped userspace_clients list, lock, and userspace_node struct
    members in #if IS_ENABLED(CONFIG_SPI_DYNAMIC) in spi.h
  - Started a new thread instead of replying to v2 (Mark Brown)

Changes in v2:
  - Fixed a race between new_device_store() and
    spi_unregister_controller(): hold ctlr->add_lock across both
    __spi_add_device() and the list insertion so the two operations
    are atomic with respect to controller teardown (Mark Brown)

Vishwaroop A (2):
  spi: add new_device/delete_device sysfs interface
  docs: spi: add documentation for userspace device instantiation

 .../ABI/testing/sysfs-class-spi-master        |  34 +++
 Documentation/spi/index.rst                   |   1 +
 Documentation/spi/instantiating-devices.rst   |  88 ++++++++
 drivers/spi/spi.c                             | 206 ++++++++++++++++++
 include/linux/spi/spi.h                       |  12 +
 5 files changed, 341 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/spi/instantiating-devices.rst

-- 
2.17.1

