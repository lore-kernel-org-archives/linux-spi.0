Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E902343D75;
	Wed, 20 May 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305075; cv=fail; b=pePm+rbs/nD2qmT+jbXvUltUmMmsSbpRFJjB3am/OWdG2p8so4PbkmDNmAO1qmScB+/aLbAfRBdbnexB2bNTl2grd/uRlFRdNkSmzJ81zAZrKo8VWIWPPXwdTdMnNlyeX9eU0qoAiEY4wqe/DQIQKP3/slCHBnwzOf0I59gr6/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305075; c=relaxed/simple;
	bh=BlccWsQi+SfhalB/Hgk/Jy4tDzV+loY3eK9+OT4zY54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeLIShlw6RlWaavtYWBo+l78tcnA1I1WvKlHGc0DO2U08NzDc8I4b4WmL4uFIiQyhofj1/jkAPO6AbsM4B2gyO8R7VVIU1ePIP9y/8bHmWwrqAryyFS8oelGR6yrPxvy8yzK8mNXgh8Fj48Ot1v/aMa6m/woD3F3XIet5UQLJCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPdB03TP; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPdB03TP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+TxK09dIU7OSaoO3C9t06loA1FueQvmrpy171m4o1bBCApXpPFdugoxiDYT/0oCqDwE+BNH42hnTxVkM7ocqgg8Y4pV6VLs9gaHfdDTRsBBc2aLJ0irT1RYA+1fG65k4B1DPDlHdAhtTb5zyYUTg8bz7h2bbZ2QComb1iDZImE/M5cM3aDgMJKfVBXweEcMBfaOUPBXKHGsMGLcTfPWYJ4X2hE64NhdOXifQJC0uTSNcBBJRnDjcaL3Ag1Zu4sXmdcRF5wDcHCmiyunsDdOKd7QHcOXFC+q1wXqJ2j14xCoBoK7+mhAbTE/lZ4HHajQILF24k/n4efcyu4F98qpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfUqALSeLYZELN/KrwEG5p3RucKfFUeFTCHDAZVmf9g=;
 b=GUDpc9xHwKzd5s4S+1lVoOTVwq5G4doVDhMT9/dpZW23miOSZyWEL35od6jZGqihw4Iwcnz094OPujBNN1kkl+YR9zL1tQekAq98XsMD3aVJxKMSprVJgQtjLX/WtE3QXX8CjwFSIp6wot8S6sf0JMEQVSD7hYKYT1pojT3ZgJvBzsrckeP0F8FPbKzuA0PWPj24hme6wi8R9Gqb/+RNWHxs65r+2VZmQkwZzd8NadxOEV6IJuzoKtUBAdIT8aKXkq6jxxwDsmY0iENZ7DFj+zwckcJUn04Kes8ijG1WN4Qv5ubQ8g7EnnB8p/od8eGGbsjN2HXxLdRyF80dQNjBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfUqALSeLYZELN/KrwEG5p3RucKfFUeFTCHDAZVmf9g=;
 b=KPdB03TPdZah8JtFyaUbhpbXq6d4K+4OFn/2i3S6ss6sJ8m9Q1yP7rQhvg6xMC/u4xuRnGp9TBpQh49DZlP/ZzNukCyWEj49uMX2Mz3VVvV3m1irT+D2TWi7xsTLc9uxfE/s9mbQOSl1oTWjenK3mfO0G4exuFuhHdqAZ4hnx9SKqhMw0rSAyoqVLrblGq1suFMNnwimxdYr5A5bh4nY4587GA2G5CaOuk/2rheEeLzIQMN8CbnV7ZJsGHfKgQxHt6FxxJz2YbqILqc6TlWegaXF19tVUhc39cbpXgeqP4ws8txOmLu/d4ZinxR1uXVBZqcaM1BdmmKHjuiuklLevg==
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:24:29 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::3b) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Wed, 20 May 2026 19:24:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:06 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 20 May 2026 12:24:06 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Breno Leitao <leitao@debian.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Wed, 20 May 2026 19:24:03 +0000
Message-ID: <20260520192405.70469-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520192405.70469-1-va@nvidia.com>
References: <20260520192405.70469-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bcd1c6-29d6-4eb5-98c8-08deb6a56963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|11063799006|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XixvOnad4TD29JwR1l2rUWoYufmzzHFcHLaS+efRI6WJfD+auvxycH4fnWMa1LdMwbDUAfY0kbfYLmh05o3EmFJcoofpjzK644znHiucf0hvMF5DfG9/Vr8JOFecxR72yWjss998XkH6WQru16lfaemR3P7832TlIE6L8eOgaLIoECRTPv4ocA+ZjoLz5QesLtEWd/hXYJXMk/qrm5IoMENyq5E2n76EsRAFQR4hXjULyE1IeJt9Leato1/0wbpLUjXcK5Bv+uAeJ9m9/6/vhgxybSZFRomiJvjy2NR3WpSG95hGhfscxnjOVY5wtDcNAUGu8ZbsMnSgkyxByE5VUsK7i6E1hjf3+/1IBIFDZ6wNcjtE7pfvkkV3giTF0mQ94nTh7f48xJAhZsnlJWnWOoZNfeXqsMlKJ0tJrkAgRKc0Hsc/gaa6lys6+ym/h/q1UI7RUB7+5As5GY10Oqb+YomxTNtvDbRRJApevmKHrmraHed9JbJ08nfFJDR3prLDENRiT62w1ZpqEzD/Zhn44lnlR7Qo0x5ko3UenXPaQaZcTiZ9qXNayHBQdOcYVJNMZvq7MurQndppr65fKuM+qEyyeJjARkl86lkerbSAxNL/fteBVZgwmcO+YWbo6acrBbd5pqgEkgnw5LRVOdlV9VfF0EHX88vdgttYr2NGC/88EM+QFsPxsyozL6ziq5dDPYwlcZbtZMId4rmRXGMx7eVvDujl54GlGop7AwDCe8k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(11063799006)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mteZnbHschCzDpa5UxBAZSYP/ohFuRF3y5+LGEnslrSqYSg/Sh5GkqAbCXl2/JxFbznUuWx1Ang5X+Qv2eq7M+4sAoTBFV3WKC7Zd4lxTKdikTxjN26fWFNA/IT8YAYxedFGvJenk82vaNuZh0rNklz1dn/Y9Hnq7EoMj21L4bbAYpZPmVK/CmhCfVZl09bdjP9Bx7BfEQxf1AhVB73Wvlm8u/VWvxQRqwjuwRyxz7mTgTiMpROXkH4ImC3izMvH5gVN7d/0iZAV1tKbhYDrkSlJvHjGcRCVdlYFRcSA3l6d3cwkbgX1jf+NKRUV0c5OJrtQis9gPXXxoj5IAn4/uvGXt+FBgkm8+8vge1xngt47egLLxWF/IA62n2bVH7+crdwYrGYA6QKHV8A09N8zKBSUJaABZfLDY/9yygo8AjCUMQ872RHuRX24sdSf7Ae5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:24:28.5392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcd1c6-29d6-4eb5-98c8-08deb6a56963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

Threaded IRQ handlers suffer from scheduler latency on heavily loaded
systems, causing false transfer timeouts. Convert to hard IRQ handler
that schedules work on a high-priority unbound workqueue.

The hard IRQ handler verifies the interrupt, caches FIFO status,
clears and masks interrupts, then schedules bottom-half processing.
The workqueue handler runs in process context (can sleep for DMA)
and can execute on any CPU, avoiding CPU0 bottlenecks.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 129 +++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index db28dd556484..b37c1b9816f7 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -191,6 +191,8 @@ struct tegra_qspi {
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned int				irq;
+	struct work_struct			irq_work;
+	struct workqueue_struct			*wq;
 
 	u32					cur_speed;
 	unsigned int				cur_pos;
@@ -1225,9 +1227,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 			if (ret == 0) {
 				/*
-				 * Check if hardware completed the transfer
-				 * even though interrupt was lost or delayed.
-				 * If so, process the completion and continue.
+				 * Check if hardware completed the transfer even though
+				 * workqueue was delayed. If so, process completion and
+				 * continue.
 				 */
 				ret = tegra_qspi_handle_timeout(tqspi);
 				if (ret < 0) {
@@ -1344,8 +1346,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		if (ret == 0) {
 			/*
 			 * Check if hardware completed the transfer even though
-			 * interrupt was lost or delayed. If so, process the
-			 * completion and continue.
+			 * workqueue was delayed. If so, process completion and
+			 * continue.
 			 */
 			ret = tegra_qspi_handle_timeout(tqspi);
 			if (ret < 0) {
@@ -1574,46 +1576,40 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
+/**
+ * tegra_qspi_work_handler - Workqueue handler for interrupt bottom-half
+ * @work: work_struct embedded in tegra_qspi
+ *
+ * Runs in process context and can sleep (needed for DMA completion waits).
+ * Can run on any available CPU, avoiding CPU0 bottleneck that occurs with
+ * threaded IRQ handlers which are pinned to the IRQ's CPU.
+ *
+ * The hard IRQ handler has already:
+ * - Verified this is our interrupt (QSPI_RDY was set)
+ * - Cached FIFO status in tqspi->status_reg
+ * - Parsed tx_status / rx_status from FIFO status
+ * - Masked further interrupts
+ */
+static void tegra_qspi_work_handler(struct work_struct *work)
 {
-	struct tegra_qspi *tqspi = context_data;
+	struct tegra_qspi *tqspi = container_of(work, struct tegra_qspi, irq_work);
 	unsigned long flags;
-	u32 status;
 
-	/*
-	 * Read transfer status to check if interrupt was triggered by transfer
-	 * completion
-	 */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	spin_lock_irqsave(&tqspi->lock, flags);
 
 	/*
-	 * Occasionally the IRQ thread takes a long time to wake up (usually
-	 * when the CPU that it's running on is excessively busy) and we have
-	 * already reached the timeout before and cleaned up the timed out
-	 * transfer. Avoid any processing in that case and bail out early.
-	 *
-	 * If no transfer is in progress, check if this was a real interrupt
-	 * that the timeout handler already processed, or a spurious one.
+	 * Check if timeout handler already processed this transfer.
+	 * Can happen if work was delayed and timeout fired first. If
+	 * so, we must unmask interrupts before returning, otherwise
+	 * they remain masked from the hard IRQ handler and the next
+	 * transfer will timeout.
 	 */
-	spin_lock_irqsave(&tqspi->lock, flags);
 	if (!tqspi->curr_xfer) {
 		spin_unlock_irqrestore(&tqspi->lock, flags);
-		/* Spurious interrupt - transfer not ready */
-		if (!(status & QSPI_RDY))
-			return IRQ_NONE;
-		/* Real interrupt, already handled by timeout path */
-		return IRQ_HANDLED;
+		tegra_qspi_unmask_irq(tqspi);
+		return;
 	}
 
-	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
-
-	if (tqspi->cur_direction & DATA_DIR_TX)
-		tqspi->tx_status = tqspi->status_reg & (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
-
-	if (tqspi->cur_direction & DATA_DIR_RX)
-		tqspi->rx_status = tqspi->status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
-
-	tegra_qspi_mask_clear_irq(tqspi);
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	/*
@@ -1623,9 +1619,46 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 	 * cannot be done while holding spinlock.
 	 */
 	if (!tqspi->is_curr_dma_xfer)
-		return handle_cpu_based_xfer(tqspi);
+		handle_cpu_based_xfer(tqspi);
+	else
+		handle_dma_based_xfer(tqspi);
+}
+
+/**
+ * tegra_qspi_isr - Hard IRQ handler
+ * @irq: IRQ number
+ * @context_data: QSPI controller instance
+ *
+ * Runs in hard IRQ context with minimal latency. Cannot sleep.
+ *
+ * Return: IRQ_NONE if not our interrupt, IRQ_HANDLED if handled
+ */
+static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
+{
+	struct tegra_qspi *tqspi = context_data;
+	u32 status;
+
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	if (!(status & QSPI_RDY))
+		return IRQ_NONE;
+
+	spin_lock(&tqspi->lock);
+	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	tegra_qspi_mask_clear_irq(tqspi);
 
-	return handle_dma_based_xfer(tqspi);
+	if (tqspi->cur_direction & DATA_DIR_TX)
+		tqspi->tx_status = tqspi->status_reg &
+				    (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+
+	if (tqspi->cur_direction & DATA_DIR_RX)
+		tqspi->rx_status = tqspi->status_reg &
+				    (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+
+	spin_unlock(&tqspi->lock);
+
+	queue_work(tqspi->wq, &tqspi->irq_work);
+
+	return IRQ_HANDLED;
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
@@ -1793,9 +1826,19 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	ret = request_threaded_irq(tqspi->irq, NULL,
-				   tegra_qspi_isr_thread, IRQF_ONESHOT,
-				   dev_name(&pdev->dev), tqspi);
+	tqspi->wq = devm_alloc_workqueue(&pdev->dev, "%s",
+					 WQ_HIGHPRI | WQ_UNBOUND, 0,
+					 dev_name(&pdev->dev));
+	if (!tqspi->wq) {
+		dev_err(&pdev->dev, "failed to allocate workqueue\n");
+		ret = -ENOMEM;
+		goto exit_pm_disable;
+	}
+
+	INIT_WORK(&tqspi->irq_work, tegra_qspi_work_handler);
+
+	ret = devm_request_irq(&pdev->dev, tqspi->irq, tegra_qspi_isr,
+			       IRQF_SHARED, dev_name(&pdev->dev), tqspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
 		goto exit_pm_disable;
@@ -1804,13 +1847,11 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register host: %d\n", ret);
-		goto exit_free_irq;
+		goto exit_pm_disable;
 	}
 
 	return 0;
 
-exit_free_irq:
-	free_irq(qspi_irq, tqspi);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1824,7 +1865,7 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 
 	spi_unregister_controller(host);
-	free_irq(tqspi->irq, tqspi);
+	cancel_work_sync(&tqspi->irq_work);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
-- 
2.17.1

