Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2733BBCF;
	Tue, 19 May 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205911; cv=fail; b=sPNu4u2PYEYXtWPjYM+jwIJmSWs3Uo0kv683HOP4idcHImttLU1Y+btpa4gzcnEr5KSXNl3Dz8LGboiTw+zEXjkfU5hrgtVZprpZHJUcD5oLc8E8jBhm+GTrSkWQwAr/g+ZOoIDoPre846DL4t1IdzKm7uOX1EjmQM2LhysdVjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205911; c=relaxed/simple;
	bh=h6YZe6qg6ETo6BsqKQUZ7QJoClbkbaQK3St4tLAPb8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfoDm6xC4t4eR+fJnBa6R7XAg/rhdDPLvh5CZrF5PJHGiwPMgNzLlX0Q5QGJvy0zAu1KFrdl0NgTaQzNDUa4US069YPCvXCRE1cvDsXPr2QTQL28Vyd8ri6nASKqPaDPopD2IuUC7SH8W9c8XUxaSIqKlNvvR6UAbwuZzWVCiAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6TkZBUF; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6TkZBUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhNtN3iwNoZON9quU6NJFybSApMfGzaJWWQdD42LA55vcir3IKPDVDzPfplZtZmSKl4D92MBi9Arz+qpTzCFSIpL8hvN2wxz7LwGIjoegDBetTv5hJWo/sKB9BI/Zw7RRdDzkJdLfbm588NL8nkfd4loNKvGuryN9PtZvIL4a6+IiFXmLJTbxOCgnDhdVs8Xp39fN+mD9S2OX49Kpx4QIvO6JHFqHvU1CHmHjT5NznvVmFP18nj0b3QAMRU9KAGtKRe8Vx9Swoi1Vo57OGJp9zhNGlMO+HtyrhujLOQaQ3R7/SEFPnMzPCKXtaUYpsNZmk9H1sPsYNZ/C5Dumr956g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrGPxMUiHNe+8aqwJfopB9TSHyHq1s05rGf6lHB/ifU=;
 b=M9Exqmo7UePAf6O6m9lgHV/SpnwSar08JO/AypA7pExfBqr4avhMvKck+LygG9VtxYeX3fNxoU/4o2cpEeJI5VvlDzZ4i5pK4Na/UgXrXlZGHt5i8gl7KRhe5aRLpoTBTq5LSwnwBOUW0FwX6xjJ8Yi9BYmcoUaIzDMnhI2t0+DFflJ4E91Ae5fLiFsHvK2N6c3LkbdOh9L6xnQMpY9FtAePSnunLcwcqrZ/+pXr1zsaL2xFBaNymETIJD3JXGqcA4jUkh/EPNH6aH7BcQBiYHBgdi1hOlGCnqjx/RuU8e7KBx9qkByfc+RHWhjTkvk97lay8NK+QeLsJB+NtZx06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrGPxMUiHNe+8aqwJfopB9TSHyHq1s05rGf6lHB/ifU=;
 b=l6TkZBUFgZ+RbnMaEDRe3P5H2G+523D5xclmUmLXNFGgk4zdU1fswC1KS6UobLKmyYjtUVsSR5y1Q3qPwMhjS2eru3/xitxHpAHHN9y0VeDqRrZ1w8NOWjjFOE/QWJXc4yIBldP9gt8YRipvLB3cqbQk74A3AAHFGs5sL5lNUthF7T8eSAiDYjbZwB1f4Y5H9A+Sl4zhOaCL2pnIqId6shor0uENFp3+r2jCcChr4Ft2VN9G2dk+Uqml3x6+QzACSPmuXHBQA+9ZxD8kZeMB/QU+L2nh0kRfQJtDr/hvj46L/2WUUCFFAzLN/KsspykGXbCuf0nYOBqHKFcY+1UUdA==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 15:51:35 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4e) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 15:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:51:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:10 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 19 May 2026 08:51:10 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Tue, 19 May 2026 15:51:07 +0000
Message-ID: <20260519155108.4092518-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519155108.4092518-1-va@nvidia.com>
References: <20260519155108.4092518-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: d03eac72-ac64-47d8-c500-08deb5be8133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hH4jjbTie8vXLS1U3BW4919DpNI497Krid0mj4O/PHOcw8xtPoLxmAxJVwGObQmhK7b18hByWywZw51/puYKt8znGZXP0JZqJxpMDJhJKqdvu7JPHUAbXNZU69fSwS21EopSHu8hmILK38D/Js78NkpaG0KSJIe8k9OkULrTvaDe0Zp21+AZ0IA98YWWR0y4fjJ5XyNAH8g09nycZv1by5XotvsJNgankjjCZUiyNB9upIdwBZ6yk3E10e1zsS6aopE73gtfW85l7A2B8kmx0/vNHZAjSbyFBGzI0i/QN4V+tbLGxhS1BDEwG2czZH5XGfpHI24WVeADvlIiUPtrRBCEV+QNPSMdE68m0DTPmVmIR/KxyV5R7vHscSoEZVR4AiNzuhlt3NnkBUtub6UHgVEx7VzCz6PpBC4HGFzFNUsZeRD73kd8cYI04XV3AtYhwpyG9HJUfsMcp2D2ToUd9s1ZbJ6QzbVg8IIt2PBy1X34JotDn4c7/UMtHhNpVkunoQ4nl0Wjp1pWN/49WJnHGN0Jvpk/iFhfhEuv9eOpjYKfrvnR+0G+Lk2xXjKjkAz272xc2boiiZY2QfPqOgHTiy4PtzGrKPQDE/f/G9I0bamPtQ8hK/BoJqfnpMqlUSGdlNgW32cRM7Dyk1AHIQtkkbi19wz6KUuvwWbWtR5fXccqygVhwB4OVR03pGhF013WkckeRp8mMZsQ3TTtfuH34jv4lHI8gC6T5oGbZg1ZWK4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WGrqEvjTKo4W7e1q9Re50R9nb2RI8jB1ZTG6sjg26XLqUBBhJxlD59IRY6wd7OYzpN7XPhcqKOmoVzHbRBd4LdgDf7ukEqt9YusEUDbbe/80iqvpNFcNeDyKPW5H6jEDykbsZOyPg/akczWTwkd/WNNRKqJnUkvocD1PRIM/iHaPvee9CCbeQmx/E4hiSs9e7o9wH5FDf7sdSgDkoPq50HxjT93EuFWVRDbRK609fjeACz4xC0GmdK/pDZ6Arx2Cn7I8fNcT6bsqTSnEGXcG8VP2GHozeCCl8nfwg7Nw6/wXmy1wtoDO0sejySWisvsF+co5bNm0qRCHhafhpUzIeClZCNG08ZZzAuOts1v6/+yTKqshsTO+bO8L2Nl7FwkProGJXMsNOnd9lyHJTsDrCKDgsBIYnVx3IBPVBj3UEEXLqkhEXCXFyUjwav2HZQr6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:51:34.7856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d03eac72-ac64-47d8-c500-08deb5be8133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777

The threaded IRQ handler reads QSPI_TRANS_STATUS to check for transfer
completion, but on heavily loaded systems, the thread can be delayed
long enough for wait_for_completion_timeout() to expire first. When
the timeout handler then reads TRANS_STATUS directly from hardware,
it may see a completed transfer but race with the (now-running) IRQ
thread, leading to double completion or use-after-free on curr_xfer.

With the conversion to hard IRQ + workqueue in the previous patch,
this race still exists: the workqueue bottom-half can be delayed
past the timeout, and the timeout handler reading hardware directly
has no synchronization with the ISR's cached state.

Cache QSPI_TRANS_STATUS in the ISR before clearing it, allowing the
timeout handler to check the cached value under spinlock. Also guard
against curr_xfer being NULLed by a concurrent workqueue completion.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 17d0b511af1d..72f66f2c6dab 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -854,6 +855,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	tqspi->cur_rx_pos = 0;
 	tqspi->cur_tx_pos = 0;
 	tqspi->curr_xfer = t;
+	tqspi->trans_status = 0;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	if (is_first_of_msg) {
@@ -1068,26 +1070,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
  */
 static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 {
+	unsigned long flags;
 	irqreturn_t ret;
-	u32 status;
 
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	if (!(status & QSPI_RDY))
+	spin_lock_irqsave(&tqspi->lock, flags);
+
+	if (!(tqspi->trans_status & QSPI_RDY)) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 		return -ETIMEDOUT;
+	}
 
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * ISR or workqueue may have already completed the transfer
+	 * and NULLed curr_xfer between the completion timeout and now.
 	 */
+	if (!tqspi->curr_xfer) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+
 	dev_warn_ratelimited(tqspi->dev,
 			     "QSPI interrupt timeout, but transfer complete\n");
 
-	/* Clear the transfer status */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
-
-	/* Manually trigger completion handler */
 	if (!tqspi->is_curr_dma_xfer)
 		ret = handle_cpu_based_xfer(tqspi);
 	else
@@ -1642,6 +1648,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	if (!(status & QSPI_RDY))
 		return IRQ_NONE;
 
+	tqspi->trans_status = status;
+
 	spin_lock(&tqspi->lock);
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 	tegra_qspi_mask_clear_irq(tqspi);
-- 
2.17.1

