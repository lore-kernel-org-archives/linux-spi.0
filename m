Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D41E98EF;
	Wed,  8 Jul 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473203; cv=fail; b=mJWD7Dccbql1uLQvk0ETfycK+a1Ql0nMlneKvGGeDjrNeD4jMY57O+Ocbi6h0gUyGK/XLEc1+7l3JDQhr8pG6ZyKpaOQFCqsaoo0Cd+f+opYU3CwQJKJSHddwBHc/kRBhVy7EGWszNNtyp4SoiNevjgJMQXvLD9NQPsvJlTLc1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473203; c=relaxed/simple;
	bh=9XtOuLSE3VAPNyL/x7quMOKqa3In35SXb5GaXXm3Xxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANGLWLWNFR2sF+w2DpVRlHPadh3XeS34CpvP0a6ocMG71WRSbQ02JR83LwpPWGl2r+CfBTDtqxnwK3VMyL0p8vTyhwB3hBFXV502B6bn1yDkOYDXMVRje0pdPCvsFk8n6TkZbFVmMfSkl2z9MxypuZDz4k+PnYxBEeu6LSUPquM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kM7xO5HM; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kM7xO5HM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oyg3H+W0DhKgTM+Y5iHXuNQEBTr+EYwVbwW8ojqrZ6qPULltBi01RGj1aZ6oRlztBELOiYrs4oMUM7XDbGtXRtQCLR+mCs2qAtjcpiT4GsQS8iMbDaOE6QonxjdaZSQsM1jVnCFZUGITqOLd9a7dKnKwKVsUmZBIV59WOkzapxtsSqtnVSaz/wn/xdF2+AuNJ2LPYU+n1eqjxJK0YC4+zwoVl7fZ2bCSVeaw7W6Hw/8rE2v3fKooUjlfIWPQv6dtcueFJwkQZ/1r8kx36d7vfvkkGsXmufqHwIlOlssAVQZyHXvaY08HayqcSdKXvM5qC7WVVYrJq0uX2SuUskB9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYqcLQQN1gXx3lOkPXB2CGPEMs5VP8vPv6i8MDrsgoc=;
 b=ugSINo1aIq9zO93lxvPuIMeSIna7b4dkwGbJ68q5QVOd/U7weIizInKXH/xCsme6rs3vCzbCKKU/oDaBsOJC8XSBGAaYGqSKKH6mEhqwQFMVC2UrOvX7pTR7JO240lme+mqIoiRCv1XAKyuOsnniw4JfY+3telv0jd/HymZgTP7v9bWodleiOnu7nt7ErQz+1ytNrYrNWgj1AYrTP/0tXH3pOuMEwvj81Yw88C+SKeo1a+z119CTd2IOWhL85KHOsrukYeoPIPAtzSfpXu/kGujWt+ptA2cERvTI65iz/C3Z02s8hIF3+O//ZV+6MMpd+/vLtnXZ+npWaOTDKL/R9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYqcLQQN1gXx3lOkPXB2CGPEMs5VP8vPv6i8MDrsgoc=;
 b=kM7xO5HMXkKkdTryuBNR3BP8oRe5zdkpY9/31bo1Edv7b3ZG6ddHPuwGa3rtK8NrjYBaKYl26oQlX4ePb+ik0kiARlQJFMxPwkQaRDmlPIORFXXghOsvARr+V+Okdx7CzUebbCUlOY8OPBKOppu3S2A9PK7EiJ19dAA/KowzMm9512dukl/XeADT9EssRQKbnoHdjPqOnfQbSQ7qdb4U4VEo+VN59pxQaSbXCR3F4vNXggIzpmqe5DvJqchcv5p8DDlqsiNZHHBZEYSfWLGN7X4yRWx68brYf2mAGb14KLuoyaRkhk/1JKsl4hy7T3DWRihFqMNuiS7MEr00CEe+zg==
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:13 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::5) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend
 Transport; Wed, 8 Jul 2026 01:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:13:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:58 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 7 Jul 2026 18:12:58 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Wed, 8 Jul 2026 01:12:55 +0000
Message-ID: <20260708011257.1712961-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260708011257.1712961-1-va@nvidia.com>
References: <20260708011257.1712961-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 76aa528c-f545-4e3f-f247-08dedc8e155a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|5023799004|18002099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mwp4S5FsrpuBNvxZ4po+BnNzZLUHuTXEuQ448a5lbQQe1dpFdV9mkFzpPjQGg+zMI17e6zcuR2x3Uo32iyAid4y/LhYGMA4irpKfCf9l+8QnG2Ih9FnS2PoNpOE2eF4nAbSTFFmwTZ/z7hKopvfzlnWsaQ2+gzg+k6e6hUu4PtcFKoZcpCaJD0WIsm8cl4vbIpU9wxEijWtmmsEsZIfqyrOB8gKyf0J/3jmuiuIvdrAQcHEWRA0pqhTJwdcxZwYEPqHInwhaqoehtn8zqFOLYpGxAr96U+HZqw3mwUGr12jfZpewQVofk2qoRjUuBMHrcYJmZ1PIgrm5BekL0UdMC9+BchwFgCuFifiI8QJ3/QaHJxo/fZgAxcF7w+4dH1xI+pEe07WfNfRosBp3utzDnuaPEOPFCGF4IJlZ602BCcCg/4CvXmoZch4d+kmCny3TmwRu+c8p8W/C9xQAH0UD7p5yzemclLaSPtwVBn3Xts9gsp7wL+cYjajP1cBTZGrIFHTQipryJW+CEX7z1kzuPCs1XMww6S2dknI/sfAqEw7Rd5yAd6jjYmzJ/vQrVFNF662k0j2n9aTmXTBev/bGqLOtKh8dlFRTCzVZF9hyZuYDjxH2WCUTZ7efI4J0fQN26Dl0wTXml5124iSUe4QTA0uPL2JExnZFRaW2xxlndwveARzRiDguv0SW34RzD6fscF5fkMPuQcB6RMsg/worwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(5023799004)(18002099003)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fr5Sdw0D9DTbd5i/7WUaIaWpAdJoJMOnGA1k3JG3w8W7rNj+Zb0EGSpmCq9QN9O2efK8P4ALftEjqLVU3VKB8Ume3ndRzwj3eJHS+cm4StXUhSZhyppA9XGiR4hxe+c4t2DVYtc349RPDmlvQgJrF1Mgaz3pgRFfwBuxNhjeYb9OmscJhCG81OSuegSn8lLKEVeqIgTjV7qGEx6aMuMPnifuOteUpV+0cSSHS+BpzeKnhLGrR05LNqTr7/edP8bGmw37gNVgWchhltv6h35oWwpf6Qm0vxn4CGn62+XfzNLMvvquYgjmJpM5AjuHxCnUOtJP83udG404JuZ+C/0ZSfbJygZnnLg2kf8Brszb7fZjdORfVYRgqugC6Oa2R1Y9v0ZE2PBLxv1XZ+ob2MecNoyLE9g8EtFUGc5VT7GxN7XyjBQXud/iX1xgpeRHep+y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:13.3220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76aa528c-f545-4e3f-f247-08dedc8e155a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

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
 drivers/spi/spi-tegra210-quad.c | 163 ++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 588a929a9785..61f72c778b7e 100644
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
@@ -1581,46 +1590,40 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
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
+	 * tegra_qspi_handle_timeout() calls cancel_work_sync() before it
+	 * invokes handle_{cpu,dma}_based_xfer() itself, so this work is
+	 * never concurrent with the timeout path. The curr_xfer NULL
+	 * check below simply catches the case where the timeout path
+	 * has already completed and torn the transfer down before this
+	 * work got a chance to run; there is no work left to do then.
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
@@ -1630,9 +1633,55 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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
@@ -1800,12 +1849,21 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
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
@@ -1817,7 +1875,9 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq:
-	free_irq(qspi_irq, tqspi);
+	free_irq(tqspi->irq, tqspi);
+exit_destroy_wq:
+	destroy_workqueue(tqspi->wq);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1830,8 +1890,15 @@ static void tegra_qspi_remove(struct platform_device *pdev)
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

