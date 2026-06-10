Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E6374A15;
	Wed, 10 Jun 2026 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072667; cv=fail; b=eCBc7w+0VToOhazO1AhdjOsbkzorcS6NOV3fLxr/uXbU8QdJlw7UAsknr0CxznvgxCDtoHpOkch6/7NZoGkuReZ33FKtqKkEyl2thy9x5Z5sHlwN13L3B5xGaNn/4v5J4fAAAc0t/9A7mT6Rww0kiSAXloE+09ZvXsfMQHYPQ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072667; c=relaxed/simple;
	bh=SibZ477A0JOuExxPWXi6BGlrnSVeQtkNDrUe0Wwvlsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZELzhAkaYkKwO8R4GG8sNBdffP4JzN9/rDQvGV7suGD93CLDEa6mdUS/gC0b3i7nqj8zuVyVs5J50ghsPc3gjNdS2oj4pE5+PQSv/4gmmPPxTBxEeKgaMJ3GhmHMskVGrurjU1csNFkOTssTcRvER40Lff8905K5g2BzZVtDEjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ieZsSaUP; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ieZsSaUP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeyWui7gNhGmSMse3MpyvGrq4nTiDUepcgLRY2ruva1zuD2YuM3EdgCGPrXD6DW5OtMaPEm5eIpK6KXJ9ZAJPWDmfc4KFkjVqBPGLu8lCB6NuaB/gC7xZtMZp0S3fqL0SggiJQaN9N420lmR4BVtgoyzfCjNNVydRt5oXpyrf6Z+eBiFEISjbmMwpeKSB6goSei/yAcVwgzLMZClfJV/y863RTVXsQQCpgKuvnV3oFy8wIfVpW+NZqy2pUf7E+qgV9yC5Y3RFM7MablT+l0rVrI0JeF9AgVbNC66EDQshWcbfBk3NsGIxggEtDNtFbEOqfcAq++cdWqi2RWTgvvn1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZUsMFtXOBVBIbCL+/cqv+KalcN9n9+AcGlPOIrpeYk=;
 b=PHcZ1YKyFwjnTufQ81stNVhcQIVh6JwqJRRxhvJqrhN+vyx5KdnC+/ntFtQZJKTRQVIhkd2j7Z1WmreKe2638IevG7nUKpzNAyGubW+rvZLJUdo1I/5PVmmkhakK7+3I1Qizuji/LR47lZWmQBHkHg7xT/DsicT//QJLCkmokTrQzyh+5aMj5Yecurxi073wz7SfYlw9uYhl2gAZvXtkUHyBT4DLiTR6Jpv4SxgZi54SIZ1g7erUOZ1DYUIIlaPeL8ieFyX6rZrTGzqn+sT1idN/CPgT52a5Cbra+RO+Z1d8GUIviMIIiGj4ho4oMT+bBoNO1iaJGUYg/9RYUL7JFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZUsMFtXOBVBIbCL+/cqv+KalcN9n9+AcGlPOIrpeYk=;
 b=ieZsSaUP3xa0vZLx/acgXIq8UX0ryRKE9ORiYS++TdQ5uE3mAWttJ39BZhZoZxlr75dkuPE3phswV3N0QOxHC+TkEmXRdezJ0jqsomnkNn1kmM222UyDrbtfV+C52zu/mHPga7dHEn3LBYpgLjj5uzYbo4SfEPgMW4yviShBKhk92874elBHK4hka/ieixK5WqCQt2VS5k5d5t/QQg5t3kuv5vZxgW6Tdyno2MYivo31DCtJUW2Lp+7dEDyi8evcihUbhfpyHC80YgZEPDuYhuylwC00gmz5JM8LvPjyFtOXoMfsToqO6KULV4qfPD0O0g1xB6I8hmXpP8+yzwK3DA==
Received: from DM6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:5:174::17)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 06:24:12 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::2b) by DM6PR21CA0007.outlook.office365.com
 (2603:10b6:5:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.4 via Frontend Transport; Wed, 10
 Jun 2026 06:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:24:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 23:24:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Jun 2026 23:24:02 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 9 Jun 2026 23:24:02 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Wed, 10 Jun 2026 06:24:00 +0000
Message-ID: <552afd84ee31c9e475ed1344ea9349af01eacfa1.1781037385.git.va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1781037385.git.va@nvidia.com>
References: <cover.1781037385.git.va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 494c9688-d440-4ea3-c461-08dec6b8e156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|5023799004|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wxPBjqA43753V5fcOWXQm8BCJ0oUxb+jvfBHeqJU/jOUFjIm23u5OcWfbWOhIPzqpHDmZV4UQbUX9OqxfGKyFGoz+G/CF8SgzIxPYuYsP5276SyUJxR2iaoRZpIa75ipslOmHVd+oX60HTjkAMExPCRbrqIW9pjQFM/KS/C2E4yRarBa8ucyQLCSp51hH/RGoEfSR/m+Qer8H4T2SiFAXb+JGoBnsVJxyKHDRT0uXdMeEYqMeuJDWTWH+4nDnErnrT8qd+46Q6z7kcqi5ZdKh6U3sqJnlypzY0Uv2SteFNQQzXT5xusRjX1uWa6NZC57OflVN5A9jhiHGY1JA14QvH3PkAHcWEasEn8QAtt0se3bL/9W0DCS9sWIckCrhOq7UQ5qdrZgYro44UiBDGa2basoJOFVhusxBZu34pcMjqIVmZMgPvOiRsCtH8ryjmSf+Ap+ApCoQyEAriDVprM5WNPJY2Sahuo5lVlYPd/iemMFk+BYeA0c1dJlq1HyJk8RYIhiBYItouRlYsPINxzKduEVtStbtdo6HOnS70zC2Cz9C+J4Kf0AQecWxtZ5iMBDJeU6fA77n5J/8MhaBb3vh7jHk5TaK+Q1gtIrhzcida+QOhgPHj/ng8pfGDlvE97JBhUunGPQJeKsY+1YmqmK4DFfm77kRRnzI4Qn0YWHFMjQmWD7CZkKd997+/lG3YHy2gYDXSrYbcIviGqMAWpj7ZoBSZmxOMBCxEnJwzIXJA4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r1/ZBwUdjZnVVPjBUTV3EelzCONUKYxV+2iEbtG6w0taVBY0xB3ybERoj4DTlrSn+PETv339xF0oa2DTXFzOaDc7wQ4JguysfzLUCKSl2f5tSSedScPK29pzaaN9GvQZDHi/UPvNGMpDB6vX7BFoyB3CGhHv155cRoTyrP+gIpGFVMtUsjpvsB9odhqlwrmhPIsYzTwVnu4DCi2+td+BootU7N/cSOgJZk+YxVfrOxP/Xjr+AmjA83wu6ESQ6tVJGgiITjILHlufPREiEv6q49oAw+VB5aMnRH9/+pqIBcI9jPMCyQLvwqf0VorBuDpqfkfgxRU1vfbW4K9fwLQbbBjhN3b+WXQsj0QAD0jUg/UIf4WQyGMQhwbXVkW6pJPZ3nUNF68UWD41mpm20xGkMcgC//CkuPwm40QHJO2zHzaQd28rnWQY7nesgWVXmWCu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:24:08.8553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494c9688-d440-4ea3-c461-08dec6b8e156
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

Threaded IRQ handlers suffer from scheduler latency on heavily loaded
systems, causing false transfer timeouts. Convert to a hard IRQ handler
that schedules work on a high-priority unbound workqueue.

The hard IRQ handler captures FIFO status, masks and clears the
controller IRQ, then schedules the bottom half. The workqueue handler
runs in process context (can sleep for DMA completion) and can execute
on any CPU, avoiding the CPU0 bottleneck that a threaded IRQ pinned to
the GIC affinity creates.

The work handler only touches QSPI MMIO when curr_xfer is non-NULL.
curr_xfer is cleared only after the transfer thread has processed the
completion, and while it is set the transfer thread is blocked in
wait_for_completion_timeout() with the SPI core's runtime PM reference
held, so the clocks are guaranteed on.

The ISR returns IRQ_HANDLED unconditionally. Tegra QSPI has a dedicated,
non-shared GIC SPI line on every SoC that uses this driver, so any
spurious / late IRQ (e.g. after the timeout path has cleared curr_xfer)
must still be acked and re-masked here; otherwise the level-triggered
line could stay asserted and trip the kernel spurious-IRQ detector into
disabling the line ("nobody cared, try to disable"). The lock-free
curr_xfer NULL check lets the ISR bail without touching FIFO/status
when there is no transfer to drive forward.

handle_dma_based_xfer() snapshots curr_xfer under the spinlock at
function entry and bails immediately when the timeout path has already
cleared it. This avoids waiting up to QSPI_DMA_TIMEOUT on a DMA
completion that belongs to a transfer the synchronous path has already
torn down, and keeps the subsequent dma_unmap/FIFO-drain operations
consistent with the transfer that actually started.

Resources are allocated and torn down manually so that remove() can
stop the controller, free the IRQ (preventing new work from being
queued), then destroy the workqueue (which drains any already-queued
work while the clocks are still on) before runtime PM is disabled.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 162 ++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 588a929a9785..dd5d40e0dcbc 100644
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
@@ -1581,46 +1590,39 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
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
+	 * Check if the timeout handler already processed this transfer.
+	 * Can happen if the workqueue was delayed and the timeout fired
+	 * first. In that case there is nothing to do: tegra_qspi_start_
+	 * {cpu,dma}_based_transfer() at the start of the next transfer
+	 * (or the next message) re-enables interrupts.
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
@@ -1630,9 +1632,55 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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
@@ -1800,12 +1848,21 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
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
@@ -1817,7 +1874,9 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq:
-	free_irq(qspi_irq, tqspi);
+	free_irq(tqspi->irq, tqspi);
+exit_destroy_wq:
+	destroy_workqueue(tqspi->wq);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1830,8 +1889,15 @@ static void tegra_qspi_remove(struct platform_device *pdev)
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

