Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC8348896;
	Wed, 20 May 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305079; cv=fail; b=tp0othpesFzGYc8YpsDsu36O6cJemu/UyfiT/VNVqlKI5eFrYTYk5Q7CXW8/B/MjWR0yJILkbSTXs+Rtl3/N5I7kDgLSFnWkVNHCQgTJRW4H/41eUD/liDdlCW6JC/WTDmnkBqWlJjn6AL/ZywqRhSGSQaseWcufSWwu4HWOrrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305079; c=relaxed/simple;
	bh=S9Q2cPUUWZVs98hQnynrYhOYCL/VgJYinWwBL1dlckQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhoCaF9UVnDrApKK4fUhemAH06/31kJAodTd98dp9ePXpxPTVo0IuceEviAdlm6vz7H/LHOwPJ4cgvow+h+jgR0AjVVW9jn15GFJ2oRABLRP3nvir3EQ1r30V2KWQAsVY5hAuOtXT4rMbW6pmnlraRlCeBDuuYdTsMygqS+FXbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0Lp6WT4; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0Lp6WT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VATktm3ybz7WV5VFAvOIyo8n5xhNZMTv4OFJGDzwOLfr87QbcVVBNiIkSd4qi8JPnxeCxXcpW28rDaBMECOhGIa0TNKWAsjTytL8dtUkmNQ5eP1mT1od4s9WIeQOEGFFX2R25WQKM+eciGO3vUtHudPIoAdwrXYjAIsM8MaGQzUbp2vkfxOzsVs0oZh2qNaW4n83nJhmRO3NcTRCaXjHkxCGE8fwC2n0k4ze4aTeCHzCpL2MPQX6ciNfIJRq8YXiuLTtXGxxxghIf0ninQ39SIgAxrdMx3QhQxhO+oE3Gqduherhd5bfzrUskZ4RQAttQCsGzx03uJi2kXGjV7Rd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxKrogH8tKvzp0Docdc63zZSlzPuL0El6Kv1iuh1/nY=;
 b=MMupnnZsgkcS1UVBiENzkpBCAhIsCax0/py0HyrV5SxrRZZNywBCGKKrV3z3Rf7rXWVBLXqoDXJFGNTajVG6jOPICBh3ql3wPnGi4DH2P2RHCWa85V+RjEYJn9gYmmit+fC/kAnzA7KXnXo6LNbDuvseUDDK7ZlozdsZlzxBvExbOmowEoGaRhbHZyK/Ow4+dgNqyUhIFjy87OYLnSiF6ici+zyWpLxA/9Hghya70KkR0DURlwyXZ1nrVa22mUw6mPmaOSV6HlFp9pBFtPDGnDLeLtDahLYLm28VaeoPPO8T31TyM1eq3u6X+EyfwLpxzjHUXVqa7+eDtBZiSeWEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxKrogH8tKvzp0Docdc63zZSlzPuL0El6Kv1iuh1/nY=;
 b=U0Lp6WT4PnzZRXR6fHyaihmaudiSe2LzzjZIR2jtuGHxlqW3LPHSAD4UD2DmLzpFaBaT2x6eBTpUjNcuw7mDpwrnImB1foefACAPddFG7SMm1dYcu5GjKN8fq0r5DaSk/HEJY+1gaz06RB4/Vm3fKyXGQfyTA9UDNjFnbiC9fJi6fhd3Li8CIbvfIzo54raM+AALf7PNNFXS7B+iyiMkpySHN6eRZ4jSsrOvCaMAJYmov2AeNS50tFgK5QF2xmGUp0OQrJqflQiPwS/4Sl3Jasz7vW2PsM8wVCFoc2O7H+0u9GgdDGiKH9HqKjkaGidG09kheseVynXXPGFI7Y3s+A==
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:24:28 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::75) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Wed, 20 May 2026 19:24:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:05 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 20 May 2026 12:24:05 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Breno Leitao <leitao@debian.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Wed, 20 May 2026 19:24:02 +0000
Message-ID: <20260520192405.70469-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f3d3d1-e654-4338-3a29-08deb6a568e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tLr8OlG57j1k+rUMh5oT0a0Zr8f/7VMIn5HU1QE8ylqU/V2CrJ1s7E7dHPgHnqkHTGKk/wLh1Zj/EcKLm/RV2650vdCX4FttaN0z6YIlh/dfDZ4UISctcfYJm1q/rrgMgF4UAfs7QuUVfcelH2+gA36B48z4TgBg4cYhXY3djn3nuVMMK+eDpZrK/cqngrUvcPpEGmlzSwg6XUslH/2Md5THkykoBRxINE9U+zjAyZxXf4dfN+/U0q7QBPfgZgAvjWuBAbNqFd8/uyguyzDXtPinpVWwREVW0+ukXjrrMdQPjkOt2V8Nl2YLLHRtyEs2KPrIFf7H0AmOqUZKQGNdYAohpVjIqrIEXVXiL+zD6IWKQs/KwJz7cxkx/RXzWyKc52kG83WlLNZQoXVMgigy/40/wbl8K2H/ELBxO3cYa/uc+MPv4Gg5YcDZ+3ih/gbaKRQKiKNEYYdinER418RXOoSvGDjX47Mf06zisrk6x33ZP2q7/kqTqbvf8sFsq+MtFQ4DcdVe4VTvTBy9SDqYtERvZ+pexUBSFhNQm6Swu799lpo5WEe3blnEJQfcwbK+zW61FViIIDQOpqpbBQK1+JqaJIoHxeM22grX+5XsQsQkaAXMQ8Qx08RiAdP/wMZ23dAE/4IEWEo+wGmFLrYUnlbOS8rDHDrQ3X5BdCMZbox8Bcnu6yEo+9sfu6RdyEy2VzeAZ5zvD4X9aIKGU0N6zoGZeWg0wXcZXC9fN4RvUWo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+x0bYKuHhdUM6Z1QFKxntLThSzH4Tne4Faz5I14LfH494bKThdpbh24ZQwAeBJBS1lTUmrAKoJf3gGxaf3Gg9Sdd2szifSraXoYX0d+Y4JumosC6dVrgkDR6OXJIzdCnYpQH94ua1GPlju0HbdUHKQUStj3PhqMFBZ9vhBgauMzHivA37uU6h8929l9rXafnCiG9ncI86PRcoFEm7Bm/YlC8fL7CwPrQOO+KJ9oM0VmfxT5UzF85jNmTTWQJWqPFxrgJUZEBKFCD390rpKBA452mqvJsf1GwyKGxnePE0KuStKwYMCT0tSNaSn0VyQ4V2e6wSOH1TdCZFQH89A7F+DHiHhTaL6d6agV7CyJBfPUcVcDFXaMZTECB7359n0P51Tgb7uPAJrM6Lm4+ChyUNydKt78lTP0DiMyBS3kVPKNWHFDLTZtKqWiUA8Y85hmL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:24:27.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3d3d1-e654-4338-3a29-08deb6a568e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613

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

Changes since v2:
- Added cancel_work_sync() in remove to flush pending work before devm
  tears down the workqueue (Jon Hunter)
- Rewrote patch 2 commit message to describe the race in terms of the
  workqueue model rather than referencing the old threaded IRQ (Jon)
- s/NULLed/cleared/ in code comment (Jon)

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

 drivers/spi/spi-tegra210-quad.c | 166 +++++++++++++++++++++-----------
 1 file changed, 112 insertions(+), 54 deletions(-)

-- 
2.17.1

