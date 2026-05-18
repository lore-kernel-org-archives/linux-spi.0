Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389C3F7AA9;
	Mon, 18 May 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120507; cv=fail; b=mXXNi7aiTJGppkl7lyNxzPkLj67ndqwx0MTFKPjk0/qHcFo6Hv3M987YPZrI+UONtsNuFLtGlYYc2wDYe2jI2N+p3sPWKNs7OdeflJjGJzXbWY/fBV0gF1FobnTlyV1dLc3SwkErU3IMyZBlf6/tmTWDV7Z+Bek4mgt52OA5KRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120507; c=relaxed/simple;
	bh=dA2SfsrSiqpncFnAID0Dhb46BRo1W52PF0AbqjDArm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DI+z3OK9Ezfavlvv54Qa0n0z5xIQCAvfYTo/bESZ1xgxSL5ilFm1JD3coP4SC3b1bXgC0kDQe8sM1O1nVyHGexEd68i6lHlEhor8ZWCxOMWmQY4goUzn2GRdisEn38kxcYce/edB/UXx9RLQtYIoqhAab5cbgYE6pvxIlfYgyrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7NTpisH; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7NTpisH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nj3CTv7BWd9SpIA5++mcCr96IL88y8heWsfOcxCEtwZ+d29il3++HlAmLLsTuZGhzNViZf6nR3h2vMKQO/y/KpfsloyTR5511oiJ+GoOCxMjZnEuSEHp8Fsnsltr1of9Br0OE0CF8aAttDeC7n6hRfgEqDAwo94yhtP5E/A1syPKRJ1SUSj36d/XDLi20JaOjrBOT4SCLjJMda/RMlf8R1j+Q6R8ctDpBJOEutAKrd7F07ejnJa8OFw9RT0HjZeI01DgZDgS7CsRmg/4jw98c63BVjwTy9QGo5oxYt6il/H1RGSifCnRji56U+cLn/ZP//kvAs5uM0BWI2HjWrXtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ac4ACPfX83KjbOIqyxYwc1oGdL3FdIBPm39DRrQeBg=;
 b=iwd3iURKebi+PIZP344y9Ux0jZ0f9H3af7h2k61PPieArUX3L/XnwDx1qUBLSH3j5tswZHyCXzX3djlciIOyuJp88cg3Zc3AgJiLn8MrVJ3JqPrL/36b0BXU1+DCuJtoQKR49lLHF8n7FBMKk27tzJBavRVXAkL/6B8vJqw9zZrd2Wrp+jjPQPwRj+Bj6bQiCmAWa4TcNNATSGqf2zI+huoSx7b25ASXjQSF2owtcVyFgYhK5iQviatsIaAEkGUOu0tytq2qPdFDY1wl+cQBKwfSJMqwq5ni9h8zmGvf1k9vRh/ncxeBslGO82CNHRFZRLhQZERCJi57unU8ezRbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ac4ACPfX83KjbOIqyxYwc1oGdL3FdIBPm39DRrQeBg=;
 b=T7NTpisHTN8S5rt/tCn+OJ+1xMb+ButKGSlqhOIrEGz2MpQSTmmQ/fLd2vPTKFacCBrHKOIGAz0t9ZVYc9JeUnaifcxLvQjVoBBRexWtbYsSS4EKKjK2XesnOzrxGtwXJbQ9phyQ20CMeMzTSH+Z9UnurxWzcGDJsqpncqUx+iDHQr4QXh6mGqDyJPBf9ieKChWRzDFmW9CDCOswLPZPRFm53jTVZcsJp+DeUKe989fha2avkBeyM/oIEsDtVq/il+snPsj1pBMYWPUF86XSzJlKJufIgY0EfUKvoV1SZ//LGUy9+fFpqWlzeW4XZT76FA/1YewHJCUd3ilp7tvClw==
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:08:11 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::65) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 16:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:08:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:40 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 18 May 2026 09:07:39 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Mon, 18 May 2026 16:07:36 +0000
Message-ID: <20260518160739.3286438-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8ed894-f3d4-49a6-c164-08deb4f7a83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	dnKqvdrAeen5VVQVFrW3bKHYNQsYr1CDnouP/dzMEn5pGcbawWKDS36TG+3ZQadqilg5+blz/n4vCiNahplkMK5KOMc+km/c8U7oNeLA+E3Hxj1Quhwy61uP/Xz6qxCIEfimVWdZs9jLgULGwmgw5L8NedX/0Q5ORIcPQyeGAVKX/VYbfbPDwPuue91b6vYaGmZKB3apxV2Lu1TF+ZF7TG+HlDPlPw3mbIuY8uITwF2FN0SjaM/aWjg3+E42DCNpzsSGNOpT3VyvEF5f0MKxua4f+Vhj2oox5Zke2YL4i9Nzov5RKl+LYx74jPkITDU4JDY5o4Rfd2EvEPJjGvGdpeKYyQUM5BOhde8Af+56LB7Zqg76juK+cHTztzAhgbU1fx500nvk162RxVZesC/ffX00KS5mLMSIzHwu0hLwyEhw6ZCQ/huYCfhfIMdz4WoQkzpCZQ8H02XqOw6y6ppJOLyGp90kkdb7hv0gMmC8EqQSYOapE9lYclg+9sIsWu1U7zkdxYIH4rbpRNftQG7QIrMAZTX2I7Y3Q8KbSALmd0525bfUCUwO5AMH7Uf7xv/6ZuCBp7QRq4vNJgrLK0+CYpDQf7PizyVEL9gs1mydHJcAdV6gvO1/i3RNaN5guQtMdcm6ghuYF0gezn9otIXtJLBo6ixDIYsYBarLqq+cQBiAERs/AwoXRBh+nKyKHY2AMo1byw8qu9261+Ut0q3A120qy0psg91LfKQmtkj5vzQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1XiUAYEQkLr+RiDIoz3bpngKdKd6YrEemViOZgYUIK8uv6UA65orJ7AhsiPt3SrK+QCT8I4h/DaSRptlseMmk30kxK29U/FwAmNs9QJ9VMS3/N1mTt6rhBqCIRCCmM9nPGE4pki1Y1xm3mf62lc2ORnNcrD1AFYt9ucP2v2o71PNuk+uI2fjwNzhPuPT0CedNO+K3Cxen0l9eeqjB4pRQH9iWaw6DtLCeFPSFiekb/gUfkBhe8F3ArifN3hIltwkWEynt9GZlC3HmzMdSgP3dWbHNliDYo4RrORzTdF9uclvdS+UjCCcvjUbcp1e6PwRfPJxX9SBZ2DxvrgJDPk7FEGhEBWYMBNaSnyzrUTMxtlgCogADQndstDyW9C8RONo2UESzI5MAKH3kowtYkyxtTARDXqtdFITC7E31WCN5c4dkYkMuXZogleQmU7Y0Ng2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:08:10.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8ed894-f3d4-49a6-c164-08deb4f7a83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

The current threaded IRQ implementation in spi-tegra210-quad suffers from
scheduler-induced latency on heavily loaded systems. Because threaded IRQ
handlers are subject to CFS scheduling, they can be delayed long enough to
trigger transfer timeouts even though hardware completes in microseconds.
This results in false timeout errors and WARN_ON splats during normal
operation.

This series addresses the problem in three steps:

1. Convert the threaded IRQ handler to a hard IRQ + high-priority unbound
   workqueue model. The hard IRQ does the minimum: verify interrupt
   ownership, cache status registers, clear and mask interrupts. The
   workqueue bottom-half handles the rest in process context and can run
   on any available CPU, avoiding the CPU0 bottleneck inherent in threaded
   IRQs.

2. Cache QSPI_TRANS_STATUS in the ISR before clearing it. This allows the
   timeout handler to distinguish between a real hardware timeout (QSPI_RDY
   not set) and a delayed workqueue (QSPI_RDY set), preventing false
   timeout errors when hardware has already completed.

3. Process small PIO transfers (≤ FIFO depth, 256 bytes) directly in
   hard IRQ context. This eliminates workqueue scheduling overhead for
   latency-sensitive devices like TPMs, reducing completion latency from
   potentially seconds to microseconds.

Tested on TH500 with TPM and QSPI flash devices under sustained load.
The series applies cleanly on top of linux-next (20260508).

Vishwaroop A (3):
  spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
  spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
  spi: tegra210-quad: Process small PIO transfers in hard IRQ context

 drivers/spi/spi-tegra210-quad.c | 169 ++++++++++++++++++++++----------
 1 file changed, 117 insertions(+), 52 deletions(-)

-- 
2.17.1

