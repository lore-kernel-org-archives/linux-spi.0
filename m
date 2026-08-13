Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5C40F8DF;
	Thu, 13 Aug 2026 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651254; cv=fail; b=RX15MauCt5keWrFzNP13BuJXW8XEATfUAlc3HIvTo5vpcnTXr4tydyOCC7vBJJKcausthhJWN79SHg0R49RlhY1dEpds4dxmbBEO3nPRZdz4oHIi6AIfkzV3jI+CRb5CJ1eRGKbTrE8RNXfs8wID6jDjNotzqDEh85rsSgC/spc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651254; c=relaxed/simple;
	bh=sKEbDa2RfT6atehAihTIkYz9qbaqRSG4Kg8HgK1T2sU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm/vBHTb0Ewfus9gVxSi9DEJwM2nuz5fxNrCe/b5rnhRZjh3Q9ExRs9j6OxsvtWVMBWmdB/atT1UppHwMBkQrcpb/oXHWLAGbW/JuK4Zz9LSVwsSRJSZfL0uK0etzARIQhyU32YKCLUc7HCwFnZ0EomC1SThubrPVJ7zIRDnsAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXxWAE4e; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXxWAE4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVUb8k7wTdnYwQRja3SdQ82MFAijjhZj+tcC+ULdQgoWDZXK9+B3yOzrvUf2F7Eocx4kVec4dTcowcwO290S9z0dPm3QdNIngaXMlIPoDdad7QWLu0R0iSav1aIJFqxvxGovvyPxnHMLyAr9ESxBgQzh0kIaip2uJ/xsSa1Wh8EwyVrZM6ji0bCLq46gYZLwHo0llAbV//riGX6yRKnMHlhWqJK8wLs5Viy21esex7MSL6MK1hd7ycLC+gpIJtztarcM2OD1CqAhxsY3z58uMaaR/UkozGSBksaeuipJQLMAzU+47CqI9a8a2QEE/bZsutfaS96GtDm5DeCUCfM0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHNUhAPPPHggwk8rNBgzRj3NyqiuQfLCNyF7kUU2DdQ=;
 b=E7w/Z0p33JU8v+VgsO/97QsVN1x29NSXt8ylntT/8NoXyPcLH3wcUm2TdWNaOcUrVeyvF74a/TDi0mVTp9wdUg7mPECIMXN+6akIgkIKrOUysPOV0dJ6aB9LOZTi5T4mldBqETcvQ0iGAYWmzCeRwrgB0g7U3OnS7keg00qRehKZ1tNvRPEeVg2GgwsgXHgBNOk9BexCXkM+Icz4UUKkKnBJey9lH8h8qpXQ7M18EjVlzp855DSRsZNAcPG/H2P/K6ghKhyTsfv9j4BGRdt4b/wXUdn3kPLRbB4NDvIYJGffvOBr+N7ROKRwqLVAHTkAdoLcDDxRNyX43IfmjhnXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHNUhAPPPHggwk8rNBgzRj3NyqiuQfLCNyF7kUU2DdQ=;
 b=JXxWAE4ecmAiRi6NVVue62bqW11XP0P4OMfVa4p3OycZR74BFj4cohSvK2mx43tSWVZD38jcid4hIUFQP8X4Uqf9gwi1kQxuHF1Ncce5WeO6T9vZZri3XezHDvaOEbeDylJ+tOXUn57C9WaIfnll8KJsAJz0TaH+s5d94RShgFqprWlWglJGnXJrpfp0pgMg0v+TFibEW0hJJeKxWsegXEEWXPrHjnKIcUEQIjU2J+xToG/ptBys/rYpP+E6PdZ2ahonYkdoV5sNddaIimjrN96D6HkgWVIwQ9ZjYwazAU7oi0GQvNAKZFdr0vpT3ilsFHbW632yAUs4PgJa821/FQ==
Received: from SJ0PR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:332::21)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 20:00:47 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::a6) by SJ0PR05CA0076.outlook.office365.com
 (2603:10b6:a03:332::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 20:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 20:00:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 13:00:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 13:00:27 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 13 Aug 2026 13:00:27 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: Thierry Reding <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Breno Leitao <leitao@debian.org>,
	"Suresh Mangipudi" <smangipudi@nvidia.com>, Krishna Yarlagadda
	<kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishwaroop A
	<va@nvidia.com>
Subject: [PATCH v6 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Thu, 13 Aug 2026 20:00:25 +0000
Message-ID: <20260813200027.2711863-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260813200027.2711863-1-va@nvidia.com>
References: <20260813200027.2711863-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: ed901d19-6c87-4b0e-b749-08def9759124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|11063799006|5023799004|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XjpjpCc4lvb9VZYJfnHMlK1+RLJVAuNIpnKKdEd9m+fCzvItyPGRm7sGx4gCAV7zWPLC6aL29Rk0Zi7bBocfX/QeS5twwxnKDfllPcH1hjUkQejBu4/laP+8I1cq8EQxb3u6/TBvXQbHiTnV1+UYrtAn28vNvmW0bCRthsbDLFk7e2iL7lRPcLY1VU+F8oclY5WKP6hvw2lERiZZUhWNznn5NN6oSUTFd02xGfrj2X9p4H+G0EgbV6x3BFnBIYAUcJXeqh89tEQQlM6fo4h/6kpaN29z+ctuTCoyusw23kGPOTCqjSQ8LriRcB+NBW7WfgZlidISHH+nz2jgZIAtqaBMS+kqQDMn7ePrQlhbwCeTX2cPR/7kTJ5QXv1BPM40WJf7YOb7Vs0uQre56f7J4KW4d4uD7FdU0Q5zmld+xdJGWkJlcuHWYABOXLVWPf4gE1bGl3EBYUQMDCpNMNWaeX0108q/Jjado5y2Ex/ETwfDPN9g6JKACk2e8p3dQSofw93PHFIIeSi7MCcYShmZ+xYcF1p0xx2SptwR4vPjGpi5uJxZu6Y2kZcXVs+CCw7FsBpgm+hjrDUcaZN7OWQ8Gh49C3HG24TCkvDg0Ctzp/CagOvgRopHDz/8MAJ2EbO5/AeTWfWJoLwxQx9F8J86iN+HDGPeMYpzevZBGkSws+Hvk7L+trhtVEw3fc2zVIC6hS15T9dSnq+rQNkU/eItcA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fQzuRPKKP57ACfWOGOLPXqVp2AXWsBdO9Ly2wZ6SOs0EphJ0HCXzOQ7tomr62uvABVt/SK7Q65grwdrjvWu2Dapgp5SROfPwTqRqIse8+9jExXt1JWd19HDvePrPjvrtlQJ0PYUx3ZDvC6nYB+W+2CzzUrEsv+mmYpGdann0sMd765qtMEvBqYrXxGQWt6do5oF43TSnbjv+6IBum7XiN9Cmqqzl4TDf4XpLHPLyTwmGq7LWusvkdQV2Ds5VDDaUKqrCqpB5WjL4Rfub0pcDjf8YATzrn5FQw4dtIuXPFtRDWIWWwWJwRnx4CAU27n4ScO93QEpAAfIiOibrkJEcjOm0+9wk0YPNTmvgQfQ03nW0V2lPMvvt8v+iWT0XsXlhh3kAYLsUiGVmt4BdmbQRcsqaabcdFZWiQTr70W64d0KX9q7eix2g+3M//bhk3B4X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:00:47.3703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed901d19-6c87-4b0e-b749-08def9759124
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

Threaded IRQ handlers can be delayed by the scheduler on heavily loaded
systems, causing wait_for_completion_timeout() to expire before the
handler runs and producing false transfer timeouts. On GB200 with TPM
hwrng traffic running alongside a NCCL multicast workload this shows up
as a WARN in tegra_qspi_transfer_one_message() even though the hardware
has already signalled QSPI_RDY.

irq_thread() runs SCHED_FIFO but set_cpus_allowed_ptr()s to the IRQ
affinity mask (typically a single CPU). When that CPU is saturated by
non-preemptible kernel work on the same interrupt line (softirqs,
spinlock contention, network RX processing), the FIFO priority alone
does not help - there is nothing at lower priority to preempt. The
bottom half sits on the runqueue for milliseconds and occasionally
seconds.

Convert to a hard IRQ handler that schedules work on a WQ_HIGHPRI |
WQ_UNBOUND workqueue:

  - The hard IRQ handler runs outside process-scheduler control - it
    can still be delayed by higher-priority IRQ handling or local
    IRQ-disabled / non-preemptible sections, but not by CFS or
    RT-userspace backpressure. tegra_qspi_isr() captures FIFO / trans
    status and masks the controller IRQ synchronously with the
    hardware event, so the subsequent timeout classification (added
    in the following patch) always sees the true state.

  - The workqueue worker runs SCHED_NORMAL with HIGHPRI_NICE_LEVEL
    (nice -20). A real-time SCHED_FIFO userspace task will preempt it
    where it would not have preempted the old irq_thread; that is a
    real trade-off. In exchange, WQ_UNBOUND lets the worker migrate
    off the interrupt-taking CPU that the threaded IRQ could not
    leave, which is the actual failure mode observed in the field.
    The following patch (small-PIO fastpath) further removes the
    worker from the latency-sensitive TPM path entirely.

The work handler only touches QSPI MMIO when curr_xfer is non-NULL.
curr_xfer is cleared only after the transfer thread has processed the
completion, and while it is set the transfer thread is blocked in
wait_for_completion_timeout() with the SPI core's runtime PM reference
held, so the clocks are guaranteed on.

The ISR returns IRQ_HANDLED unconditionally. Tegra QSPI has a
dedicated, non-shared GIC SPI line on every SoC that uses this driver,
so any spurious / late IRQ (for example after the timeout path has
cleared curr_xfer) must still be acked and re-masked here; otherwise
the level-triggered line could stay asserted and trip the kernel
spurious-IRQ detector into disabling the line ("nobody cared, try to
disable"). The lock-free curr_xfer NULL check lets the ISR bail
without touching FIFO / status when there is no transfer to drive
forward.

handle_dma_based_xfer() snapshots curr_xfer under the spinlock at
function entry and bails immediately when the timeout path has already
cleared it. This avoids waiting up to QSPI_DMA_TIMEOUT on a DMA
completion that belongs to a transfer the synchronous path has already
torn down, and keeps the subsequent dma_unmap / FIFO-drain operations
consistent with the transfer that actually started.

Resources are allocated and torn down manually so that remove() can
stop the controller, free the IRQ (preventing new work from being
queued), then destroy the workqueue (which drains any already-queued
work while the clocks are still on) before runtime PM is disabled.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 161 ++++++++++++++++++++++----------
 1 file changed, 113 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 8ede864c3d3c..7c09a1fe0d41 100644
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
@@ -1232,9 +1234,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
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
@@ -1351,8 +1353,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1506,6 +1508,19 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	long wait_status;
 	int num_errors = 0;
 
+	/*
+	 * Snapshot curr_xfer under the lock before the (potentially long)
+	 * DMA waits below. The timeout path can clear tqspi->curr_xfer
+	 * concurrently; using the local copy keeps the subsequent dma_unmap
+	 * and FIFO-drain steps consistent with the transfer that actually
+	 * started, and lets us bail safely if cleanup already happened.
+	 */
+	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+	if (!t)
+		return IRQ_HANDLED;
+
 	if (tqspi->cur_direction & DATA_DIR_TX) {
 		if (tqspi->tx_status) {
 			if (tqspi->tx_dma_chan)
@@ -1539,12 +1554,6 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	}
 
 	spin_lock_irqsave(&tqspi->lock, flags);
-	t = tqspi->curr_xfer;
-
-	if (!t) {
-		spin_unlock_irqrestore(&tqspi->lock, flags);
-		return IRQ_HANDLED;
-	}
 
 	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
@@ -1581,46 +1590,38 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
+/**
+ * tegra_qspi_work_handler - Workqueue handler for interrupt bottom-half
+ * @work: work_struct embedded in tegra_qspi
+ *
+ * Runs in process context and can sleep (needed for DMA completion waits).
+ * Runs on any CPU in the WQ_UNBOUND pool, so the bottom half can migrate off
+ * the interrupt-taking CPU that the previous threaded IRQ pinned to
+ * (irq_thread() calls set_cpus_allowed_ptr() with the IRQ affinity mask).
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
+	 * The timeout path can clear curr_xfer between the ISR queuing
+	 * this work and the worker actually running, so re-check under
+	 * the lock and bail if there is nothing to do.
 	 */
-	spin_lock_irqsave(&tqspi->lock, flags);
 	if (!tqspi->curr_xfer) {
 		spin_unlock_irqrestore(&tqspi->lock, flags);
-		/* Spurious interrupt - transfer not ready */
-		if (!(status & QSPI_RDY))
-			return IRQ_NONE;
-		/* Real interrupt, already handled by timeout path */
-		return IRQ_HANDLED;
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
@@ -1630,9 +1631,55 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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
+ * Tegra QSPI uses a dedicated, non-shared GIC SPI line on every SoC that
+ * uses this driver. The handler always returns IRQ_HANDLED and always
+ * acknowledges/re-masks the controller IRQ, so the level-triggered line
+ * cannot stay asserted and trip the kernel spurious-IRQ detector into
+ * disabling the line. On a stray IRQ where curr_xfer is NULL (e.g. the
+ * timeout path has already torn the transfer down) the FIFO/status
+ * processing and bottom-half scheduling are skipped because there is no
+ * transfer to drive forward.
+ *
+ * Return: IRQ_HANDLED.
+ */
+static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
+{
+	struct tegra_qspi *tqspi = context_data;
+
+	if (!READ_ONCE(tqspi->curr_xfer)) {
+		tegra_qspi_mask_clear_irq(tqspi);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock(&tqspi->lock);
+	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	tegra_qspi_mask_clear_irq(tqspi);
+
+	if (tqspi->cur_direction & DATA_DIR_TX)
+		tqspi->tx_status = tqspi->status_reg &
+				    (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+
+	if (tqspi->cur_direction & DATA_DIR_RX)
+		tqspi->rx_status = tqspi->status_reg &
+				    (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+
+	spin_unlock(&tqspi->lock);
 
-	return handle_dma_based_xfer(tqspi);
+	queue_work(tqspi->wq, &tqspi->irq_work);
+
+	return IRQ_HANDLED;
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
@@ -1800,12 +1847,21 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	ret = request_threaded_irq(tqspi->irq, NULL,
-				   tegra_qspi_isr_thread, IRQF_ONESHOT,
-				   dev_name(&pdev->dev), tqspi);
+	tqspi->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_UNBOUND, 0,
+				    dev_name(&pdev->dev));
+	if (!tqspi->wq) {
+		dev_err(&pdev->dev, "failed to allocate workqueue\n");
+		ret = -ENOMEM;
+		goto exit_pm_disable;
+	}
+
+	INIT_WORK(&tqspi->irq_work, tegra_qspi_work_handler);
+
+	ret = request_irq(tqspi->irq, tegra_qspi_isr, 0,
+			  dev_name(&pdev->dev), tqspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
-		goto exit_pm_disable;
+		goto exit_destroy_wq;
 	}
 
 	ret = spi_register_controller(host);
@@ -1817,7 +1873,9 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq:
-	free_irq(qspi_irq, tqspi);
+	free_irq(tqspi->irq, tqspi);
+exit_destroy_wq:
+	destroy_workqueue(tqspi->wq);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1830,8 +1888,15 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 
+	/*
+	 * Tear down in reverse order of probe() so that the controller stops
+	 * accepting transfers before the IRQ is released, no new work can be
+	 * queued after the IRQ is freed, and any work already queued is
+	 * drained while the clocks are still running.
+	 */
 	spi_unregister_controller(host);
 	free_irq(tqspi->irq, tqspi);
+	destroy_workqueue(tqspi->wq);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
-- 
2.17.1

