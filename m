Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588976;
	b=wJw3VzDR1O2nTLxXv+d8AMKsbu8RCYwVfxuUtdcfKx86vskTOj18AHKJj6s9r2YlWeGJ
	 AJ5yCuseaESdzRKkurFl+3mfzIKFbnmq+NjyjcgPtMnSGKXVhK/qc+XBk+mMKThAzF9Mz
	 r6LUc7OdCa0Zv1xfK023/D8CztMtuL8FQw5xQ8vsOSb5VZvu7lLvFMlAJfff1NtQ/P5Cr
	 XDgMpDFsrT2z0FIc5Fw7ZymJFriGhMCexnQYfybPeO8sRFbxPmjqEa+/lTzTPsWDed2hf
	 V3XMXrpBvLi9dAMvAMgH92VBFEOlsOhHaZOaJvXNxHsZpJOd/1Vy1vWjsIK0/vi98RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588976;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:Subject:From:Message-ID:In-Reply-To:References:
	 To:CC:MIME-Version:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LRK5iJiA5XXN8lyOrq8YqLPIDaQ7pK4kKoe5w1iG+ZQ=;
	b=e3Hceo5wAGn/M4xuY8cycTXjDiI2SLE3ayzqfaHEU1i1yEXlvRG+9d2uG5HVHEk1GJ0O
	 p409NSSCFc5bEAod0RbXg0GcpSlcR+e6qN5Y3AQBqj+ok39D1hrWiHMrwcZU333xDppSo
	 xkZMsLAZ4cp2dB+GfsmWKUYeVgTal8It7gFuDeGL2nAJR0cG698q/MTTUIQW4USYj0VNM
	 xEatKKIkJEClxzCcWpHUQIYY2CFeJ22LevHgRj2dDOFUAYH2MfQxUWdX8isLGltYqi1ff
	 u5n/h8mprHvQJPKublK4CkZkJaTuuXrZYxXan0SIYh1Fv+9chq/6cWEnl0i+NrJfu8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D77yUrbF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.49
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A621606A319;
	Wed, 21 Oct 2026 13:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A621606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D77yUrbF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtOm2OHGzSbjTqWoQoKaf1FBkYtNm2j/3c+vhMiAbns1PkwjVGNyGcYAWbiXyHV/ROKURag91zvd8fgn2PXv4P8GCaV11JRym40I17SZ0CWrkE9utvEwcobMXfogmrAWkru7UT2GpNa0/tDLykmjL0Vt6CYes/XYluACQiE1LNlUIKzc+6pfJrIV2D9O9Tg8zIPwBW0yMqdB7Fl0DpWxJB5ytyRSh2VnqH/H5X2hqV3Sw+qYJ44c/jXGVZ9IpFXpfxiVWwUzsxbqphaHG+N7DQMErp0ZmCNxelIQbGmasq6uLtlxHY7gvONnsysUunIh7qPOZePgn04zRiBEZQ7pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRK5iJiA5XXN8lyOrq8YqLPIDaQ7pK4kKoe5w1iG+ZQ=;
 b=sRQ1mt+vsJPuDP4oUKcFywHAkocqIb5UsYak7a1xML1vadwRUjDR7S+RB9UThdsDx6DAsw3ohUfIMTlc6mBUlfDChYOq+B3Fb6c1t5zhfX3iFl/BPEMPqKxuAemO8Jjif9JSkgjaTyIvN0t4F9P/z3cWqgBWtD6vjYt09mnqDVgD29tqdLULKayb7AzKPaaGdUz+bHX8nvMi4w3T5HbVnTHUl6SrmEvkL84WE5GdAvMMWBCvWoDyi7SDsnnV7Q3a77y8sQKTUnjUs8HyjARFu5d3hM+qrqXL0nk7NnxS65w1ggrWTD6kurtFHPe4isiNdX7DORbfbLQjt53sqq38sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRK5iJiA5XXN8lyOrq8YqLPIDaQ7pK4kKoe5w1iG+ZQ=;
 b=D77yUrbFnA8Zvy1YSyz5Whz9rPkpMqR2Nz+6oLq0Gn5gqsZoy7M6dJEvp5pNF23aYk9LdcwxTP8r9WcDig/vL+vne8HUTy09SQ9JdyGp5A4YJaFbfs5C87jW9ouNsfs8IznurJoCMCYVhfe5SpnMDMrXsFyYU5PkEezjjzrqRARONXRJhVfGhNFoTpnbg/NYHKmq0ffCub+M0JJ+jK4BKKFeJCkndS7RyNGsb4xHMBUaA1L7q5HMaRZzL5drpNC3p6soQU1m4naaAaidiQiZz6emU9ICqMQgIAcx7su9069pMu6L54CZ9MSH1V9q1ixVaglaW4tzxoH1crSQpGusDQ==
Received: from CH2PR07CA0039.namprd07.prod.outlook.com (2603:10b6:610:5b::13)
 by LV2PR12MB683086.namprd12.prod.outlook.com (2603:10b6:408:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:22:53 +0000
Received: from CH01EPF000BE946.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::24) by CH2PR07CA0039.outlook.office365.com
 (2603:10b6:610:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 13:22:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH01EPF000BE946.mail.protection.outlook.com (10.167.244.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:22:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:35 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:34 -0700
Date: Tue, 18 Aug 2026 14:34:43 +0000
Subject: [PATCH 1/5] spi: tegra114: Allow PIO fallback when DMA is unavailable
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.7785404408966779179@nvidia.com>
In-Reply-To: <179258895296.403962.3492255118456900623@nvidia.com>
References: <179258895296.403962.3492255118456900623@nvidia.com>
To: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	"Sowjanya Komatineni" <skomatineni@nvidia.com>, Rhyland Klein
	<rklein@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, Krishna
 Yarlagadda <kyarlagadda@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE946:EE_|LV2PR12MB683086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1243e13e-aea9-4fb2-1d7a-08df2f7669b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|260925022911599003|260925021911599003|261009220027099003|260925021311599003|261009221227099003|11063799006|261009221727099003|261009223327099003|261009223027099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tpPp4Kp78CeRv6VVTizR/W46J3T2h4PZzL7YftJYWj2gV8bFq6aVVzGLG+A+Agc9gG4rObl4hc1vBGQ+TbTE7lMjcjp5vwnTTwfOW4PNF9S5ug7o4Gex3FYc6Tglu9f2dfrGewM1Afcr+jXVpKvMhjzQazihzAb179Y0jQGF5pxF8Vf2EqgIK76pMfBFmRK9powFHxaLeWVUHzdxP8c/5N/E4f5a/iFbxCTnMcJKqBeSTYHFW7JIu5vq53PGQKAH7KlOlQ65YYLxct47z7OO5ERiVDpSwocoW/HVUVvVpRA3jlRln0N0sGwLhC5zMSD3aI3MPNoLnqBGg8pM7WpN4mJ/Oa8DnT7zmY9cf5q7L9hOR6heAcQzxPCXbLYWAWMTlcsdPvDy8oTgWO4+BXrOLN3TO4FEItFqwvgv7qihYyGYQK0muoFE9Rc1HkAaRg9Hx8TUSXoixUXgO+Ros1YaeW+rP/Pc75l1I9XFrhbi0nVmX2iSupnRpbMCOSyJN8C0mqYFi9IUMq1CnUbdi/nxbf+KqyX6FtGQnUprrj4XyUDQHMa82XJinsRMGgzOBISx9wKCt9yYxoJ6xtO2MY4pegrZmrvi6wEq4teZQecs6RDCLuLKk8ZoAz60snDbBH9rvLTBBEgI/mO+7aEy7Iuuyt9CUFwGUIFFQqQg9Qn6X2s5WLEwX42EXSzNQGgF+cBe9zskz50q160il+NqjhXv4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(260925022911599003)(260925021911599003)(261009220027099003)(260925021311599003)(261009221227099003)(11063799006)(261009221727099003)(261009223327099003)(261009223027099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iSsyBVseE8pg/KuhiqS/C83QMoYxFbCcDO443tPI+xNPgnJhHN8YZaAjxxNz2tAM2j7wPSdsvAK4S68D1H1Z8I66/2Y5+HQmNzb2mBnX2AVgRifH7QlckZsSI+EoMWZwkPu0Ts9wdKDgh/wpsFCxXdSNXVNS5JMpBZbqLhmBjyOVtxZWnKXCgLcldITZtC6F73GUKcgvi/sBjPIDc0q6LxEhkpophYqzUfeQj2UaKuyZXwsXZNRAjx0Mg0paPR6zL1GlL+goNSErgThvQWL+fpVJ+uGWploFnJpGE93QassE8NLsIUurMlJo6ZJAszXY6eZ7/TJTBubCaDhwQh6+FeJV2XYgbYYHW5g2q1FhbzCEdz6uLlDPO6pA4iKjXg1vzXh8KHuUmEJWALmj/GnwOJXh/uAUMumUNmSMzak/uDk2TLwzi9XcTwI70oNgk/Sh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:22:53.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1243e13e-aea9-4fb2-1d7a-08df2f7669b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE946.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB683086

From: Krishna Yarlagadda <kyarlagadda@nvidia.com>

The driver can still use PIO if DMA is not declared in DT. The DT
binding lists 'dmas' as required, but tolerate its absence by
falling back to PIO instead of failing probe. This lets platforms
that legitimately do not wire up a DMA controller use the SPI
controller in PIO-only mode.

The runtime transfer path only takes DMA when both channels are
set, so PIO-only probes automatically stay on the PIO path.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 333fb549214e..f9bd783cb4dc 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -901,7 +901,8 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	ret = tegra_spi_flush_fifos(tspi);
 	if (ret < 0)
 		return ret;
-	if (total_fifo_words > SPI_FIFO_DEPTH)
+	if (total_fifo_words > SPI_FIFO_DEPTH &&
+	    tspi->tx_dma_chan && tspi->rx_dma_chan)
 		ret = tegra_spi_start_dma_based_transfer(tspi, t);
 	else
 		ret = tegra_spi_start_cpu_based_transfer(tspi, t);
@@ -1366,15 +1367,21 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-	ret = tegra_spi_init_dma_param(tspi, true);
-	if (ret < 0)
-		return ret;
-	ret = tegra_spi_init_dma_param(tspi, false);
-	if (ret < 0)
-		goto exit_rx_dma_free;
-	tspi->max_buf_size = tspi->dma_buf_size;
-	init_completion(&tspi->tx_dma_complete);
-	init_completion(&tspi->rx_dma_complete);
+	if (of_property_present(pdev->dev.of_node, "dmas")) {
+		ret = tegra_spi_init_dma_param(tspi, true);
+		if (ret < 0)
+			return ret;
+		ret = tegra_spi_init_dma_param(tspi, false);
+		if (ret < 0)
+			goto exit_rx_dma_free;
+
+		tspi->max_buf_size = tspi->dma_buf_size;
+		init_completion(&tspi->tx_dma_complete);
+		init_completion(&tspi->rx_dma_complete);
+	} else {
+		dev_warn(&pdev->dev,
+			 "'dmas' is required by the binding, falling back to PIO\n");
+	}
 
 	init_completion(&tspi->xfer_completion);
 

base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
-- 
2.17.1

