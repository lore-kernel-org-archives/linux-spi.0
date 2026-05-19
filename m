Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADB30FC1C;
	Tue, 19 May 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205903; cv=fail; b=cWkIMfHd3jzORcTfQ10KoCJSSBroeexJT7MT4uPVmDu8X8szMavwwsbXqPzq6S0Zy1cEUPPSZGZ8aRs9nPoVkMfTrSiYO+fQbg4l6QfvUr/0aLBJVjF7Nme/8nIQCO6N1pn7Mx6qhfETzBWFUqXAWSXMztjfiKV/HHx7VJCBjIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205903; c=relaxed/simple;
	bh=oDY7P8QJyi3FlMVxvcRHKftDef3i+tXG9hg/os4iCpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHV+ebG1D1Bn8yFN6fOwdU40qP5GFCbxXQ+LE5eQ8BNyPN9MptIpUubgWeiWaLlooKkxzuSnyuhwOKo2LOQz4KzqNXEou/16hIZtCFP9gfZ5sdzB4gQZgVP7KoxL4tgG+GRVNZUG0XHNFLADzRMSc0VKsI2ENyzrE4XIBa6C7tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDIQblWg; arc=fail smtp.client-ip=52.101.46.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDIQblWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLmiTu9fX+Vs8hEeA30YiOM5FtJ22iIsoFaqxjsL4yiGs17NqobNgWGH1Co1gRC5Il4KFdCzyr5nImZLjuX9WYS4dHQQVEp4ww5e905/+Ck1W6ZTV7xIMLR5zqzji4UKqJMG8fTLjvLhdMQx2a5aQHMYu0cgds/UGoQ4qg7RTCN2i30uWbeoytPnqyVWiFtsDp4wr6k+I1oWff67fCkjIffEpm7440Tcq1OI2ZhFLp6V+0FgrvWdJb/AYz93POkexMUohstw0eNTLOzg4WDHiKpFLa/TlJLtT9EqJAtVREsV1eruUYkNJ/wmr9eeA22MALBkxeqpci1HdUEsfqkn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofb6YfHbJYFua4j55zxqhu++xsa99KVYl5O2vDsBAuU=;
 b=KCTuM2v4RlyYAdgC37ckG3FbFhVeuoR01E2YbmoEFmWcmmvaHmSox1rzTQYWrGTKDOOLsU1kJ2zvvtm+8Rt5ePAEHFBldLyoviLaMbaurUmZxezbjHemtOw0TE28gVZK3InfnFmIKgC6k7TdO+vBmSwcHXFubuaHl7kZ4aS/TaKn7jB/e0If/bN2HbxHG6OgWTkXSQa+LV+fVnnD2B4SvBbrKzTZUsx0JgbSA85YH+8hdFU8Alh9mMJUweJGYXqsnZdhn7IEvEqB4OwLqkV/hHR33M32fNFjUE9vMUUhOiMn+/M7uyu4r1uOJTjS3K2w8tXzka9Ph47nAhyI4+nm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofb6YfHbJYFua4j55zxqhu++xsa99KVYl5O2vDsBAuU=;
 b=RDIQblWg6546BrCwyO8O+rsMRyAxBeEiI+X8/te2oivtHq19ND7ohiRSrNDQzrK+sGjRR739Tv8givDMD3v9CZRYTuBAqxgKRKoKsa9jKaF5n7giYH8cwK2rdHdKJAu075J42cNA6aVpPqerwX8T74OrZ71Kajn1rbvHYUAeea5rPX0C4VB/OIUyRhEICfEQScvbp094CZ+7RWZTVwEyVkA8Ix6ZZCJvyL1OshvOM+P6jbc4S14DI9+abGO7v58hLIvA8gp+7Sj0/uQkkNyUcsHe2zsphk7DxInkMV+SFsjoZ3oYZXjaHXBhOG3bdU/btCVQDax2CDeWDue80BcI7w==
Received: from SJ0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:a03:3a0::30)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 15:51:35 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c2) by SJ0PR03CA0265.outlook.office365.com
 (2603:10b6:a03:3a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 15:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:51:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:09 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 19 May 2026 08:51:08 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Tue, 19 May 2026 15:51:05 +0000
Message-ID: <20260519155108.4092518-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c4b939-658e-4dc1-27d4-08deb5be807c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	c/JnvC7karnqDO+X1H1OwB5fWdRu5IHykML0ZYz7VMvLEWgiWw9aeFVe4fpAFx2Nf0oVmJetx2Ft8wDhFum06H6cjFYEI5W9QLa1qv6alh/+EJV8Pt17gUvROcP2R8NkvuU9YKfhiRxWNcb6yffZnJlWS9G76m/SwpUcNypUBOe0XPVVQ540NlL06y+bmppdzew5SBgjW7sV/xkpCRKpUfcnDSR1ertQrI6Fsp7Tfm5ISDBH1REJsNMXQejAgRbXO7k1ZoPsrZEtvuiaf/cEtoDzICkhnZt1do89ZrNYwxVBzwVWmkFwDWQ3uTUU0cGIDD2zOyhbVcG+pc9qIj3ry46ZGTkwbR3nKiUc0oQKKKrOLdLcVgpf+YzXQ8NKcPsYfe7x101tMvaXcYdtJmRh1PIrL0/HNVV0HO/65DGZzoyqb3/EPLRV8vOFNGsd0J3C1IT6II9xYUDYAn6tMqsnNbIy3cGYc5gXqQREmjd5Y7nj2d85BVIPs+VJG8k0T2tZK9mK1yTRpd7tdOgYRM5gdEADXKYiF0QxD9PRVzqvgqJDo80GAoIARAnHXbZYcKFntcqXrhqcewDLQAZaUQ0t9mUCef8ns88rE976sE3gjJwWA3u5tgIQusDPu2C+5/hC3erqtUCEYljW6DguPTuInW3/A9YSXe2PtfJI/+LNlpnrBpgYhzJ0NoB8fLIRJfY2vwJi++U0uwF1hf03bT8uuIE1LYuMzcZz8TuAedL1dV0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hM/HI+yZQYl3y7AwfxlL65s25/rex4eAN+K5WRShui+2hqTwrrh2S3SAAUfmi8VW5so36h5kZZXBDXb+Nimb/YgfBuau9SB5+D4BZ9TVgjbIt4Yj4jSrlu+xCGy9F6Ey50B5IkXbRudY4uMyNx3lyJQg0APbIV/ir2Rd03xV14gcSjHQdPsLXQWTy7ePzg2V2QOftZ1JGKbU4aIA0DdPytxVyEiPUsQfhxf0VqfL31Z7poLZm9rgNWKIPiutrJQg3vIeSImUNY6uKw9htcHDP8KZ8u/VgtbEsc9VMDUiN6wiargJAUalXeNmUPa2s0HuhrSmegQg4b+/951i7cbUFlWKN6WhMrxziHaGiwDNRhAEhG3G3673BimLGg7l2SLJz5dW6b0sNiLnjNDr/f5mq4Dj4Ppk+6R0cJp3vm2vmSv1eInr4i12LxWVFaA1Ik86
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:51:33.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c4b939-658e-4dc1-27d4-08deb5be807c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

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

Changes since v1:
- Switched to devm_alloc_workqueue() and devm_request_irq() for resource
  management, simplifying error paths and remove (Jon Hunter)
- Improved patch 2 commit message to explain the timeout race scenario
  and clarify that the issue pre-exists the workqueue conversion (Jon)
- Removed unnecessary local variable in tegra_qspi_handle_timeout (Jon)
- Moved "workqueue was delayed" comment updates from patch 2 to patch 1,
  since patch 1 introduces the workqueue (Jon)

Tested on TH500 with TPM and QSPI flash devices under sustained load.

Vishwaroop A (3):
  spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
  spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
  spi: tegra210-quad: Process small PIO transfers in hard IRQ context

 drivers/spi/spi-tegra210-quad.c | 165 +++++++++++++++++++++-----------
 1 file changed, 111 insertions(+), 54 deletions(-)

-- 
2.17.1

