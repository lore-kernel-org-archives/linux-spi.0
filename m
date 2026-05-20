Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6C34572B;
	Wed, 20 May 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305076; cv=fail; b=PKkk3X3Q50/t4WBgrbWM3fcZvu7sTIJA7eOEMvmMl3yTgOFFYFR3VeS/8LaFLHRUErmTLS6ob56cZdawLqXThUFCNxddNiTR8z3/llUnO5u15NXNbG1hSb8TQ9urd3/lvEyiauK4mkqehMsKKiGYUOok2i7+BrLL427Y45hc7zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305076; c=relaxed/simple;
	bh=OqLSmUQ285AIKYC4jAswqXn4Lhi2st2bohk+aCpmKL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7k2QSSERiPweJzli5arsh4uuCcLol4NvcYubtYA61+ljVaAuG5NSsB2l62zhrrvTIIkiPZwaPcdeQCNcTCdg5zHDDh8o1vVg3f3/bUUAcutdy4GGO+m15W/kR4GGGRF0jXfXEb+b6KHzB3dDTUaQT1fVep2UX3B1dtQGlFHwoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dEIUNoDH; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dEIUNoDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNt7g1bfkYpbEC2BFmz1/IypcRdbHWX4AvPgKnvPGe1PEzZAnt1ppydYAmwAscFOiTxE8qEhV2J8qD4IUhj3g6quLpisXDVQPbxe/ad741RTLcjY2jALCXsZXSiR2YlN3WjO7e+qiXv7NO/YmMeVQZfGG3JxJmBtnuCCFv/kKDO2coUZWfW0yniFDZ90z2ZxxBzfHqGlA4vA1TCyTJqh3nTDbXNCmPK2XK3naeAMTiZ6JiAvyQx/hBY+OgLrdJyIAGPhzIg/LZjeedx0xMlYAQNaFYOyaWweAyxakFIqCYkbyl8WzoDHwF60MJ5oPULpPhXybJmkCh9XzFVlcTlOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy09i1km5Nd1+aj5iXu5PdwJwTGs0JlupXLUvYVWkbQ=;
 b=HuIzlUH+cBSV1fKmR4gmtr+WD//+x7mDBf10RxJz/e/bEPaScjDqRkTnPetpisjT5Io1pZw7+RUhym4lFw7FzWs9fRGfUMOrnSw3Zwn5kjMgZD9wXL/XIrYw2XTb+lfyZBqi3vbSJYdoOnvFxRmL25by+w/drcvNcTupY+m9hF7ILr0G1zG2SFjSh/BuINH9naWv3Y15N3y2lQswUuy11f8CvDhM/0bCqxxCx0Bar5lRTOalnoJuZjg9y3nY5f8sRcW2GhOTc1Jg5Z5zp/GY7U4npX/952om9V3T6TC4OquxK6p19XKs56qM0tkXl73Wk9RWX21lTTZCikz2Nj0nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy09i1km5Nd1+aj5iXu5PdwJwTGs0JlupXLUvYVWkbQ=;
 b=dEIUNoDHhyiDKNX7kGNe/9elsSGL/ZtJkQhwlLFjN97/H/Ye2tlgylaC9D57caDyri7H3S04xEr9b/ZGq+Hz7phizdw5pOHi3kac7nEMBENTdpmjLPLIq78h17LB0h7YhL2sd9nm/1BQJA/UjVLPljiQdci1jKxgs78MGl10hsiYdgfTStmuCf9Otwxppc27OaFoDBv4t8NwU7JqLmJ59CA4Lma5wgOOeY334t1wealdYqJY9qOclXc4pjXkWy8u77ek6lvB9OMhr9Y4u7Rf84+tyRrbAAhoCfpdDGuMrzqkNPsv0KZj6FAOh4RmonWpDpBzv4NpiyWTaNMjPs1HJw==
Received: from CH2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:610:5b::23)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 19:24:27 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::93) by CH2PR07CA0049.outlook.office365.com
 (2603:10b6:610:5b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 19:24:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:07 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 20 May 2026 12:24:07 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Breno Leitao <leitao@debian.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Wed, 20 May 2026 19:24:05 +0000
Message-ID: <20260520192405.70469-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520192405.70469-1-va@nvidia.com>
References: <20260520192405.70469-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 635036b9-abd9-4f02-b6b4-08deb6a568af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+wmnbaWtMVOAuLTwsn3IH49kI3LXyLxZB/1v9/w1CUWmbWfvZuk1dZRseiBvV8zP3xN08BkdIZxR4cIoYKEp0Az/L2pQduEBHWFf34OSQ9BFcg34G0G7Zqwi7JYdIugaVUzFugiXVT1lmqDlJ/C+2sqkyG/wCTP8Mvxk861CLIdw1QhlhS5KpSK1yfdv+fymvXZydXNiL+4YGT2DZ+J8widBTcqapJZTgnqDOpFiSVZN+txkAYCTloNBnGaOQwUF6iOtROPFbJNNGUpb2/7HgM1iAlnwmLrMJZAuuPRuBxrreqnz/wCj2+pE/plyjaj3/RietilfMCOrLcZik9eLeAsFM77XeRpsJh5+Dbj3ZuV9+Q2S1d90jzaxhnn0YPKvbbajGk5yTxehK4CpaIHwB82WjMOidYvA2Qk9ChLN+h/7/8YR8wGvLf9uCRCrbn0PVksLnSlDujkmqZsarHeAoIjafnj3ndwfyOr1Nc5AGT0cdt/iQYv9PBGnVeXh1Dc0KhyJtriIu5BB8s2mNTLpltOiQQHpwDHcf3lSKy167BLlzXJyKI1tbSa5MOl8l3eXDwrDgmm2aRzsmi9X7GlR/EKpj6doOf8xNVZGrJ0LFhbKtWKO0G48ziwubAD8LTvwOvgrmDzaZrq2xQ1UD/T4Fa3WDNaRIsEMynuvQDNlPRttVhhdoNGyWD5RJ1La45igzmivny/oZP6sWIdlCm68TywVCnNpbpU5zkFx+4FUhSQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W5wLqT+iMmqHXK6CaNT6PUXauOuok32uUxARUo1SMPeQCsfnw1nYljgTLz/AppGJiDxR1k5XxOykrqg7+4sLG+RsT8RAXxC8tE8LvZyIWHl7+KSekz5V+6Pu65ZaRy0MGmN1+1qdiVc5tvlFUd2H9w+lE1H+gL2RqdnlbxZDVpX9R36DvOWamWcRCNw1FJ3E6aZkN4+mMK2Mtkq2f4BcupxkEAyoI5tNJxYWv6HRjL0rnAmBofSLD/FL+CXvr2kWrOYNGNcqd9AR0RUIAheDxLKdjNuU95J7M5t4TR7dfZ7IcQTPli+1pU/Q+lkjR50YyBtQFpKRjW3+lAgTYeGSTPAwIkSnPujwnVB4udeTKknxd/9eLEgughECtiFf1ly2YwAmPr1hwR/Q0kaKVZd+/6EShx6glRXpocH50KLWoz7Z62OzHwoQ5r7WGjVrmHsD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:24:27.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635036b9-abd9-4f02-b6b4-08deb6a568af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

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
index 64ad17d38b84..e3681f06b0ec 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1664,6 +1664,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
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

