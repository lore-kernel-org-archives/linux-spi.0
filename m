Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2B3F6C4E;
	Mon, 18 May 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120516; cv=fail; b=PAf/zdmxvhvvpSl52JXj5SwWI9Ku6IDAXTbWaq+2Ea+NYKx83Ph8x/Z5j4XXwUEWzoGuzRf29A21ezlFrgSeJFIxkKEQiIumYrDisvsOoPpfFC4dD/ZjmtpGyS7Hm9QRVUjJ5PE+zgZTrP2Y6wugoCCtY4Q59zL+hozWvbcGb3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120516; c=relaxed/simple;
	bh=X7zMk1Xrnn1vkRKNPQLHtVA7DT6G55m6ikcZzGfXVuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXNV9zG3BjlGbgT7dVtasICPfGt3xI0saVdVW2ewAkx65ZDTXWaH1wsSHG6LKBEimOOTLZE8knoZMtM+aBdMwuIyWj/uAI24kKDRXX00VIhj8e0vS6ydyVoYS0WU6lzGookM2MOgl5Jsl5kMrMKONrQrrlYdlqUvynxthjnwI5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ei6TGLRc; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ei6TGLRc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM43iDt/O1eNG8ejPZA76IQwlMmobO+fP4213RAnR3Q+BDUZjB7Ys7VmBLAR08VNBQVoeuAMWljiFSY4ADkEOgtuoPwP5O72bCG1MVeMIdVjYZInS4tTAfpXeKGD2CdA5zoyVagATdd7y72kYpYpmRm+Wn45W4VzGZfa9ZVyr7EO6I1yonYf9t277EtohwpTHlVidGcnreUqX6EscIgDQDdN5HbO/ZtSzuwGGeD942MRdsh84GoVcob0AV7XiMPUXIfxKPj51h1Y8x0SpwBhBOy11jGK+fYXqK3LtgZVrNXekOV0SpHoMXB4OMpvuukaRF7b/1fEjM462ou8Cf01uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXEXHq8itm8bpzS+n52QBJm7k/iLBd6lTzVbVvAIT28=;
 b=mbilo6gie+EDeDtAhKPOkMiQO2MUwDKnH8fBy0RgL3TO2yx7qzPgwtOc549Hy3yKi27qbThzoWskVyP5nLFENrQDjrnFmeCz554kYhRn2P7n4j2gtlZ2Ovemp/FINwWN7CXYaFw94PSLVG1bhAnZrAY07QDRl0eoZnJ5hl+grMEzJrd8nsM/snJwb/jSzGnbOvoPwmoHPk8IjsPaQ3fmB0ehKy11bY+KQTxtleeQdAqk0fJWyQfE8LHyIfe8lcGT3gmiQg1bQdaAChk+hs6q0qm1n5WStDwuenk0vOh+91FC9OPNxiaa3JREy1Ru0GKoclqPPROsepauM4yNPS86nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXEXHq8itm8bpzS+n52QBJm7k/iLBd6lTzVbVvAIT28=;
 b=Ei6TGLRc8jZf4mhYGC9qg/p31yv2Kk29YRxYsjtblBL4NWIjaD0OO5mStHOmygT+hq9JTL8vfGp4DubBqwUjQuPU05GGhAih0Gt7pbZSfvHAzwCy1n97PD7toHDE4fc6grvQOsCVudmq0XRhlW+Aahs78UJY9lY4kCMl0usTFyo2XHon6fgRQN+3fGlih1UzxBB42x87Us/hJjs30mK/dSIGQibtmMFqUpSME+70O3J0yjF1Oh8gumlJDz32MMBXaO03XCT16Ujrk4nwKttRlrGrGUP42q7sDm0rKYQ54D9tlZdbOntVrXFWuXelrP5ECoxg2w/ELmzw2v+N8LGQ5g==
Received: from BLAPR03CA0140.namprd03.prod.outlook.com (2603:10b6:208:32e::25)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 18 May
 2026 16:08:08 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::2c) by BLAPR03CA0140.outlook.office365.com
 (2603:10b6:208:32e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:08:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:41 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 18 May 2026 09:07:41 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Mon, 18 May 2026 16:07:39 +0000
Message-ID: <20260518160739.3286438-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260518160739.3286438-1-va@nvidia.com>
References: <20260518160739.3286438-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c335de-f178-4519-70ce-08deb4f7a6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kZ4U3N97ZrF6/FGslHQk2UzPrC8jLPfXtoEwM2g3VTsUpckoLzU23wX3oYk6h6AOMvlvp+XBuYb3Lxok8B5DT+hlyUBbgeObNYZjTOschvDdtG+5PK3vlBPwOBIU73pSd+6dZ6qARqc8lMWzezD1KvZMAWpWuQ/Id9rgGQ0xF+nsq7MIROh2pW9X50490YsxLB+Ah3DQtMqEWqCxJGFfTKlcutHEgTNroujKpgNA5d0+moHiU7Ly6HeTST4CJ0KvwROrYF4CbvzMkybT93mvQPmmezrMd3F+uy2ewUMChp38wTLOomXTZqh0Jy6p4lIFDsSr0Ve421+RylPmIxD43VmgghTajdsfwKGq/5Du4e35VjtGD6TrlIY5FFn3UaCEMaI93MdU9JYifX+1I+5HGSmD5G4PaiO6aiONOjW20NY0/tM8L7f3UrKJV2MovOT7+YXzvrE0+T5X6EWEgKZOr7TT49jbMLIwL+GPrQDsC3OC8pGZPbFtouW5yQt/DIqM09glCixv2ypRN+Orsg3Zmv129O8DWVQOQ1wT+1si0uNUSdXqSYQO1Vf4Uo9Xts9nRbNH4+0y9HsrUyQtMNwWsAuC8HGQWbwLcrJVyYMT2rnWYpfGV25q0UkpJm9DQIqlNi6nX/3bmHTSqen4Oo68G7deVf/ca4TRRLLxM+iQ/n9c3saT1KOohoWvFpNF4KBWncLHDAiGhgh+l+iRXW90Z7xQI8JJqOh1DykRPJlDNPI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YvokVPqweF+7+cr23Bina2vThS32auPD0uufZUqp9xReHIPkiWYSuIwG8JB2cgxBBGxxnu7QIMBvPl2rPUWgwctfpsPMwGKFh7Od4Ih6hMe/nzNMnoAxTrcqpznKKyDC0j4SiRaklipUpqucyNH7o7h8v4c3umgKVRew/zAEkbLoEpAGHeK4mQ7Kbjhj8N4ILvhaY8HN13fHFpx9lgMTexIraI0++mL4+gA4YI0xoLxjCqeail5V6JhIdMnHLJd3Ol45jtOXznYgc9OuntjqG7vDLFjiSV+lTMmCmvgTM0vdgPni5nyK6SHO9iZOh8ZPNgxgY80K55HmPsAp1LqHa0rQMrKXfuMAJuPlCmpA7d4vbDUs93F3m2IVkK92XdZ6n2+ywIiA9Cl3NJzBDXUBpIcQstmSikuV4q0JOEx4FvWtMo4SrGxFwIVzCNGtxI+C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:08:08.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c335de-f178-4519-70ce-08deb4f7a6f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB

On heavily loaded systems, workqueue scheduling delays can exceed
transfer timeouts even for high-priority queues, causing false timeouts
for latency-sensitive devices like TPM despite hardware completing in
microseconds.

Process small PIO transfers (≤256 bytes) directly in hard IRQ context
instead of deferring to workqueue. This reduces completion latency
from 1000ms+ to microseconds and matches the pattern used by other
SPI drivers.

The 256-byte threshold (FIFO depth) ensures small transfers for devices
like TPMs use the fast path, while larger transfers continue using
workqueue.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 6148267a51cd..435e14d80bfa 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1666,6 +1666,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
 	spin_unlock(&tqspi->lock);
 
+	/*
+	 * For small PIO transfers (e.g., TPM), process directly in hard IRQ
+	 * context unless there was a FIFO error. Error recovery calls
+	 * device_reset() which can sleep, so must be deferred to workqueue.
+	 */
+	if (!tqspi->is_curr_dma_xfer && tqspi->curr_dma_words <= QSPI_FIFO_DEPTH &&
+	    !tqspi->tx_status && !tqspi->rx_status)
+		return handle_cpu_based_xfer(tqspi);
+
 	queue_work(tqspi->wq, &tqspi->irq_work);
 
 	return IRQ_HANDLED;
-- 
2.17.1

