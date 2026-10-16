Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797C4C7557;
	Fri, 16 Oct 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157157; cv=fail; b=HL/IMfVS+wJKpzFmnxc7EVN6X5H32t6qECNFrNdHYp036rKd5hQw5G2Bet51HGtQ9udL6es6wh3dE/cyiOYxnn/8SM3Y9SPe0nDYJc2+6jfjedC/sKjKrEfJKAn1XOB8LHHBtvkpddeio45eJaYC20zBIeb7wsp6TfPO0GWO/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157157; c=relaxed/simple;
	bh=qanR5mZRN3Q27SSUzbma3785xbuMBG9zOfN7gnAYdqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGp95D6Fr4CUpI5WFzabaeKFryh7eHYzBMN9q49UcAEGoSFYEsZOH+eKBeN/nEUFNpMJP5wrCSzAtqDT+UVH3+3UCrWAobsudYdIPQZH+Ln9yzBzAeUJUrS7yVvdlB743GnxV8/tcZWOfU/K0b2Ufi3S9mQiUDsjru8IHaOG6lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCqJT8sL; arc=fail smtp.client-ip=52.101.46.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCqJT8sL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRkSRwwnBT6I4hhdqLhowAwzlyalIMysapp0O0Cq6JD9PEIPuaxr5mLy3M5FoHjO/BkmDqbN9YQpaUOpsnba/o9l3BcRWIcucn8zM2WQWLT2HRAmTaIvfW5hR7VUtCl+7iR5X6EWV2P8WnyMcACoMSSTQMJnJaYCavq+mfAfgZjYRYHHUPPeVxLM9oLjOVtsG5diNsjD92WSEEPfrqd8AINIzvOyRdyisbFl8Gq5f/cJN20LQ8JhyP/StPO8ve5Ds22cMY+jyMe1ZLOvHya2dbPvCJ+99SMLmkkXxdbxWaf6IAVJ+3Ocs1E1iK7xE9n4Q87u+7aMNpQnS+xBuwJAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSt+zL9tXQWSlDw8jNaFP1lPbZFuvVTzP2A90v3qdn0=;
 b=tny1RbNSLjM8IdpEttFEypU2fN1VA1uv+lelXiBLF0NS8PiEwKmO0catAHt+4Sn/XBETmiViKMQxqZvKRkYTfD6a8DQqwFf/wWBLs4tNTVnFpQrFNxYCTZRdBOI+aos4QKjSPTHEf3jdFs6k9TWg304pahJTYEJPOf/UXCjxGheKF3ecym/WXRUgE2SjWaVEwdL0gSShv2X+TIW7yGl6JOwhb8hK0N3S4jwaHiHZ+nH7TJoZPG3HsBPpsTS72ZuiI4JSQKFlf+H9PKDgA3hObUedfnAoyn2q4NzRuVMqjFRYvkBoKaOqSHmslJxutmjM/a3jUzdIJX0guAjNBYNTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSt+zL9tXQWSlDw8jNaFP1lPbZFuvVTzP2A90v3qdn0=;
 b=uCqJT8sLOiuoayQYYM8wA7PgWQtfgWr9xvuiVBfDxSmGb4xKMyb+WRxMGcepZ/EGuSG7PxqZ3a2nGAeAEIbMewKQTvk5Mg449hA4sWShyugYyKL4tOmQ6MytSUvyVRUIBhXRahokIFY6ICJTwUlOh3g06G2cT7QNmzuXKhgcFtyQuEHmxu8o2jLahfnhfv+SZnpZpBXpqmbw6mFtg67mfzNipWG+6VynRfWbC2weqmj3OTPBlllujjrRTBwT/R6OWJnBmPnyF96S7D67KKf+4226SYJlva4a60yRbYpPukAve1DKDN/nlwtvSgWciZBdnaXRAxXS9ILtYnwWmlxFWw==
Received: from SJ0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:2c0::30)
 by CHBPR12MB319464.namprd12.prod.outlook.com (2603:10b6:610:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 13:25:49 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2b) by SJ0PR13CA0025.outlook.office365.com
 (2603:10b6:a03:2c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 13:25:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 13:25:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 06:25:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 06:25:20 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 16 Oct 2026 06:25:20 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] spi: tegra210-quad: Fix timeout path status handling and DMA leak
Date: Fri, 16 Oct 2026 13:25:18 +0000
Message-ID: <20261016132520.3723412-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|CHBPR12MB319464:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbdec53-f5c2-43a7-9405-08df2b88fe3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1irn5Kfj1Jzd7Xl+xyw3vkjYC1hPQC9yzbxxI321AgxaLIPMi7M6OSimo9RKtV4QMD6yLjGQNhSF0MlJK+fSn2DPu6wektZMIQnWTlIEL4Z3V1XohfsqBwqfoUe7uLVsLB5BN6SZO7a1H/XYU3GYkY/y8fg9NQBtO8vp0S1XyvOMOOR/rLZ0auEZVusK6mrZ/mRGNvaaj+BfmDI+yCMnFdN/9t/F2ohzIzffBBnyBPcEdlCwddgN39JkdaX8FloC1o3/DGXzC5uQKZL0Tu4VyAEd58rOeQ/vbR+ndPA15gJGwGM/s+cbrA/xQm4S1mqm6zIsGMWenXJjXunFDc1OZwMULu34s7ArFdEZVirWqMQkKpkQwYHuDRcKz8ioJS7iVMnULCg3oPU6JzPKVaphiZzwso5M8Gw5kAJwIO3hCVFUyzNr95gOsXp+venUTsjZ8eVd/DdB+K/Crel0Gd7LaPTfmVgyKBkl4jwGhaCKhkWgLXc1N8sh1IhSRsuMA7Jgc3OL/uPfBHwG9tGUQJTahaszFuNAUKo44bev2arE67UUEYJ6VEPVNJ1SSAmfTYoDdsCPYPxcc/rfg3ZRNk935qLibYI66EkgjOt7C3rXFnMAtaln0JqxEtAyBh6waq6bvKQAcIxY7wVQzWDBUvNrOQZhZiKfo505Q7bnG2TohnTbc1HZWIRX/K5TElee9mwnHmj8eECA0txfG4GqrYHz6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xiSx/jKy7/Jde6wzeskOtAQYz6OkmcaEjlJR4/gOxWzyAvmKyjlKMde4CENpXIfBOC+F4Ly/3HzQI9wc9GOm3FbmGlfadozpoSHqdSItY+xo0eV2xSxgZYws7zRZAHAlzIgE/vy7H1lb9uQ5QrpkmxhEyBFiMppYktiSPoa9YhQmxrHBHgOjqT+Rb0Rpe/UChmRIsmu+TldbdtUJONvf2qH2YWYFNo6UC5551SRCkYAOLS1tZZSyeYFd/1scpQwHN6Sn9QbRW5BuN6OWcOw2crFYpPa+OPintArPwDR8BJz6Db6f4PvlJN1jUnNpXWxyCYjM4DS25CN5cd1YccmJgvhIcvOavwhvmJoUTuacdxyO4Q95jtf+dboi47qQeqmzvc5/75kSCL9ORbGxjkfwr8RK2OW2NTFte6SupqMCT3oxnJ2Qjd7BHjso5AQiGdzE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:25:49.0588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbdec53-f5c2-43a7-9405-08df2b88fe3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB319464

Two independent fixes in the Tegra QSPI transfer timeout path.

Patch 1 fixes a regression from commit 1ff82c13ea94 ("spi: tegra210-quad:
Cache TRANS_STATUS in ISR for timeout handler"), currently in linux-next
only. When tegra_qspi_handle_timeout() observes a real ISR completion
after draining the workqueue, it still publishes the pre-drain lost-IRQ
FIFO snapshot. That snapshot can hold zeroed error bits if the ISR
W1C-ed the hardware between the two reads, which makes the manual
completion handler downstream accept a transfer that actually reported a
FIFO underflow or overflow. No stable backport is needed because the
offending commit has not been released.

Patch 2 fixes a DMA mapping leak present since the driver was added.
tegra_qspi_dma_map_xfer() maps the client TX/RX buffers, but the only
unmap lives in handle_dma_based_xfer(), which runs from the interrupt
bottom half. On a genuine timeout the bottom half never runs and both
transfer paths abort with tegra_qspi_dma_stop() plus a controller reset
without unmapping, so every real timeout leaks the streaming mappings
for that chunk. On systems with an IOMMU in front of QSPI this
gradually exhausts the IOVA space. This one is tagged for stable.

Both issues surfaced while reviewing a downstream backport of the
hard-IRQ series now in linux-next; patch 1 carries the corresponding
Reported-by and Link tags.

Vishwaroop A (2):
  spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ
    snapshot
  spi: tegra210-quad: Unmap DMA buffers on transfer timeout

 drivers/spi/spi-tegra210-quad.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.17.1

