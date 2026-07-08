Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F83AE1A6;
	Wed,  8 Jul 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473209; cv=fail; b=SOzwwvogwgyJ9c++SFL2hC0yF07XEV3TjI2c12qBs6vsfGQUvX9n/4WxGEmm3ABZrDjGY+qYbVGB/moyqObKi5xPEzwhPGvnRmhGYJitLxEMmxrLXjsNji7H/60+vMis7wZzuUZEOq3dO5I16gWNDIhH4t1MAxz5wli7w7N5pdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473209; c=relaxed/simple;
	bh=E2vyQsZ5wElK1EVA5j8stXOO0UP3UmhhvQ+LvSytcBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQ1KXW/qQKd5uHwTmy1yMDqshxZWRfm6hW+zkUQSLclF8Nm3B0+Qp6lfhKubPqILHTgpzlifwfSrmv5QpQvKa0rA11x68jYco3b/0Axbhtw7u1ye5S+1oNLcLX0hBcJ1ZYI2R4fyr3Tu99tk1oguNnv3JuSMN4KpDC4Kw3P2rbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HtgP7Oxi; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HtgP7Oxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytnbqhMgYNO6F8Aw7gv942Yip46Wrnwx5MuWRK4ARdGompdEKA1OUQlajJqic5dhUtnEDXSYeCTmy+qHj3TYPwfT4Y6L9CuaRw7a/zhcpXiwFzbRVl/LIy9/a7bQt7N7K8TAX9KRI79IHKtJTRPnYiyLQZAA59oS6cB28hwK0n/BS2f8RVXrilol5SwT0ECeLLG/7gruUGRtUQ9rwi7WCxXfipxPSU2PPf6iEE5xtQKX7WglP4MOIyyw31DpvxziyxH+bsYKZE58Zf9mRGvBa18e0HU227/3OLE0ThOk6dFNboY4aW6t4BvnrFzXoPhOci6LS3PqBWljZMzLpSMnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+diikuVqDZGbtBCVFwbShUC4tRQcz5vYmkc8A8zpJ28=;
 b=SFtAajP2eRfira1x9rx46T/9LOXl4Kt6HkovJFaNXQco8kpSOeiICgo5bdMCY1fB5l9VY2HLzxwOseXAkuNfqes+oq1E6VxWm5rMEpZ7FgdXmACiUT+Nx2syfogIYsYXC+dZj6J99yOer/Oi980/QE0Ir9+M9dtRwYHWfTWFfWs1ifIM63GwJte8rCN8iiYr/9UuezuaM1BksmBCUPviyvpZ7k5oH6nS5B24FBjMUwxU7VgYdokAH86tH+hyUgEK3uGcKqHMKZ5vEk51OMseCB7+HWYx+YkzqJTOXn0/4+LYjD1uM4YEMRoAamTBOaHUN6TrcZPpkVoeG7RRND8h8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+diikuVqDZGbtBCVFwbShUC4tRQcz5vYmkc8A8zpJ28=;
 b=HtgP7OxiyqBO5hLONXLBKTLljI1jppqy1QVqQmLLIJ8O37XGT0fo8x04UEAIPi1O13KTExdthQ5mWa5B9m4g0YYi1dkoobkawydLkh1bEQp/Z1GBXz7VSxB8agEUDlJG/CmpT/9cfU/YTb4zBAIDCPYDyU2tVzK7l5n1o2DOBeLwBmeu5qpV5Em3+T2mIIdgHMNHtO4brczFvXFpDLL3dcpASHWZPjxXatNSzRYUirZBb9+0xCVS6qlYCu5QEgJw0GdXeLMRvhcOORHTJxnNg5Q/ylJUAXgvAotZwpX6AE6WO2NEoFRxSzmSDsS4fS/y+lsx3Dr0RQzvKFsDKHgUjA==
Received: from CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::23)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 01:13:15 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::98) by CH0P220CA0009.outlook.office365.com
 (2603:10b6:610:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend
 Transport; Wed, 8 Jul 2026 01:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:13:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:13:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:59 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 7 Jul 2026 18:12:59 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Wed, 8 Jul 2026 01:12:57 +0000
Message-ID: <20260708011257.1712961-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc4a9f4-b3ec-44d0-91d4-08dedc8e165b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HD58XxqAdQDL/k/X5GKvdxIEVqUg8Oau4q9BhDlEV/2cdr5oqc7coZwAqYMdc61Is5anUhgMA/n55BCsDCJUBsfyd9RynZRgrmUrJPCl6m2vlH5/NpJp/WJd5xxAAUhkAVYUnVNLXPkNu4d0EHvJZGAgeOadbhWUl4BmnmoFgKAzd00b4SzVqDHmN++6VJnQ4xUK8JrV/4h6oJZIVwKK/+EwGHgD8gG4zmHSPKo42ycs8+CJd8PFvMXik3GP0P3BZLbS2sFSCX24Sr4UW/J4IDkB/OEydxngz6bK6WP+t23OVh+CzPvcNxEsbtQPLHuqWIBsi2WHSueE5zztVu0TnwRuudFZ5uMBn469HHhFcDyqpXzyigC7bUmH0ZUjEcBi/vb74BCKUHhrYwPZ81YyL1hRxcn3tFCuJN0F5c+7upbE1VN4zwIHuzvr9ozXI0WG1Jqgl/WiDprFw9Y57ap9viTDP0RVHO1j/LDUcWHSpT8jJm99G97o6ck2JkF8SfTjSPOJjvVtBl+N+M9XMKvO95PO7+2H4hneedCjvrsJoec3aikDHVVMRqSLLnwFT9jc0oyDd/yZDskYtEqydXOkV0l2NhsqL454nE/7tAiosvPirVi//KZ1mQX2yZhVqfdB/FZTM3Bg9wgx0RQuTqqhMdjUqE9yYSlNTx0uAXbkLYuHiSJOa+xBBdtRiprELTpe0t+Ye6xR0eWYehPhzPsIfA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wK3voa40BQzv7QNEtA4YzWtu6CXSSgC0f2IAwbhdWYw3oV6NmWH5lp4vkeoXiZ1JbY6j3wDsNDfTGBQ0IIR6f3NuK33O/IqGMDPQqc9vqB/sFRj3O4r/7ngPoPaODkoOL8UFmIQdm8vUeKhAC9H+v9TUEJl7Yy+vcrTZAu+yWXavK9tn7HUwSWxy1E2ycxdBBu1mudocPlKI14Q18dKdGydGKTLj/TUl0t4b7jcoNLWZYZvHlcj0/SMEet/GvKSMLJfPLIt33+c3SBqiWYrf56yNorkY3b3aTLrPDIEEaI/lmLk9PD10oaeBYClEtc2ZWql54DoxHbD1w9CtN8Mk3WNY5gv11b58UlWui1C3vmUB6OnpkGxc1qhtAL0UBsjwPpnUID4fI2Wh1+Bivu3ObymvTXe3f/htkRiE4xjXmL5NQ0OCRadMh4QIsPQGx66F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:15.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4a9f4-b3ec-44d0-91d4-08dedc8e165b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

On heavily loaded systems, workqueue scheduling delays can exceed
transfer timeouts even for high-priority queues, causing false
timeouts for latency-sensitive devices like TPM despite hardware
completing in microseconds.

Process small PIO transfers (those that complete the whole spi_transfer
in a single chunk) directly in hard IRQ context instead of deferring to
the workqueue. This reduces completion latency from 1000ms+ to
microseconds and matches the pattern used by other SPI drivers.

To avoid touching the spi_transfer object from hard IRQ context (which
would race with the synchronous teardown path that clears curr_xfer on
timeout), tegra_qspi_start_cpu_based_transfer() caches the "this PIO
chunk completes the whole transfer" decision into a scalar
tqspi->is_last_pio_chunk *before* unmasking the IRQ. The hard-IRQ
fastpath consumes that scalar with READ_ONCE() and never dereferences
curr_xfer or any spi_transfer fields. Multi-chunk PIO transfers are
intentionally kept on the workqueue (only the final chunk sets the
flag) so the fastpath can never recurse into
tegra_qspi_start_cpu_based_transfer() from hard IRQ context, and DMA
transfers always go through the workqueue because their completion
path sleeps on the DMA engine.

The fastpath also gates on the per-IRQ tx_status / rx_status locals
being zero, because handle_cpu_based_xfer()'s error path calls
tegra_qspi_reset() -> device_reset(), which can sleep and must not run
from hard IRQ context.

is_curr_dma_xfer and is_last_pio_chunk are written from process
context (the transfer-start functions) and read lock-free from the
hard IRQ handler and the workqueue handler, so the writes use
WRITE_ONCE() and the reads use READ_ONCE() to prevent compiler tearing
and silence KCSAN data-race warnings.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 77 +++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 06625c0a62d2..bd13818d5431 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -207,6 +207,18 @@ struct tegra_qspi {
 	unsigned int				dma_buf_size;
 	unsigned int				max_buf_size;
 	bool					is_curr_dma_xfer;
+	/*
+	 * Cached "this PIO chunk completes the whole transfer" decision,
+	 * computed by tegra_qspi_start_cpu_based_transfer() before it
+	 * unmasks the IRQ. Used by the hard IRQ small-PIO fastpath in
+	 * place of dereferencing curr_xfer->len, so the ISR cannot touch
+	 * the spi_transfer object even on a late IRQ that races with the
+	 * synchronous teardown path. Multi-chunk PIO transfers always go
+	 * through the workqueue (this flag is only set on the final
+	 * chunk), so the fastpath cannot recurse into
+	 * tegra_qspi_start_cpu_based_transfer() from hard IRQ context.
+	 */
+	bool					is_last_pio_chunk;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -727,7 +739,13 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 
 	tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
 
-	tqspi->is_curr_dma_xfer = true;
+	/*
+	 * WRITE_ONCE() pairs with READ_ONCE() in tegra_qspi_isr() and
+	 * tegra_qspi_work_handler(); the flag is read lock-free across
+	 * the hard-IRQ / process-context boundary so the annotation
+	 * prevents compiler tearing and silences KCSAN.
+	 */
+	WRITE_ONCE(tqspi->is_curr_dma_xfer, true);
 	tqspi->dma_control_reg = val;
 	val |= QSPI_DMA_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
@@ -748,6 +766,20 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 	val = QSPI_DMA_BLK_SET(cur_words - 1);
 	tegra_qspi_writel(qspi, val, QSPI_DMA_BLK);
 
+	/*
+	 * Snapshot whether this PIO chunk completes the whole transfer
+	 * before unmasking the IRQ, so the hard IRQ small-PIO fastpath
+	 * can decide whether to drain inline without dereferencing the
+	 * spi_transfer object. cur_pos / curr_dma_words / bytes_per_word
+	 * are stable here: they are written by
+	 * tegra_qspi_calculate_curr_xfer_param() earlier in this code
+	 * path. The IRQ cannot fire until the QSPI_COMMAND1 write below
+	 * kicks the transfer off, so this store happens-before any ISR
+	 * that observes the unmask.
+	 */
+	WRITE_ONCE(qspi->is_last_pio_chunk,
+		   qspi->cur_pos + qspi->curr_dma_words * qspi->bytes_per_word >= t->len);
+
 	/*
 	 * Reset the cached transfer status before unmasking the IRQ for
 	 * this chunk so the cache represents only the IRQ for THIS chunk;
@@ -760,7 +792,7 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 	smp_store_release(&qspi->trans_status, 0);
 	tegra_qspi_unmask_irq(qspi);
 
-	qspi->is_curr_dma_xfer = false;
+	WRITE_ONCE(qspi->is_curr_dma_xfer, false);
 	val = qspi->command1_reg;
 	val |= QSPI_PIO;
 	tegra_qspi_writel(qspi, val, QSPI_COMMAND1);
@@ -1700,7 +1732,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 	 * DMA handler also needs to sleep in wait_for_completion_*(), which
 	 * cannot be done while holding spinlock.
 	 */
-	if (!tqspi->is_curr_dma_xfer)
+	if (!READ_ONCE(tqspi->is_curr_dma_xfer))
 		handle_cpu_based_xfer(tqspi);
 	else
 		handle_dma_based_xfer(tqspi);
@@ -1728,6 +1760,7 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 	u32 status_reg, trans_status;
+	u32 tx_status = 0, rx_status = 0;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1739,13 +1772,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	trans_status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 	tegra_qspi_mask_clear_irq(tqspi);
 
-	if (tqspi->cur_direction & DATA_DIR_TX)
-		WRITE_ONCE(tqspi->tx_status,
-			   status_reg & (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF));
+	if (tqspi->cur_direction & DATA_DIR_TX) {
+		tx_status = status_reg & (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+		WRITE_ONCE(tqspi->tx_status, tx_status);
+	}
 
-	if (tqspi->cur_direction & DATA_DIR_RX)
-		WRITE_ONCE(tqspi->rx_status,
-			   status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF));
+	if (tqspi->cur_direction & DATA_DIR_RX) {
+		rx_status = status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+		WRITE_ONCE(tqspi->rx_status, rx_status);
+	}
 
 	WRITE_ONCE(tqspi->status_reg, status_reg);
 	/*
@@ -1759,6 +1794,30 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
 	spin_unlock(&tqspi->lock);
 
+	/*
+	 * Small-PIO fastpath: drain the FIFO inline only when this chunk
+	 * completes the entire outstanding transfer and no error bit was
+	 * latched, to avoid workqueue scheduling latency for TPM-style
+	 * short reads.
+	 *
+	 * The "last chunk" decision is computed and cached as a scalar by
+	 * tegra_qspi_start_cpu_based_transfer() before it unmasks the IRQ,
+	 * so the hard-IRQ fastpath never dereferences the spi_transfer
+	 * pointer here. That keeps the ISR safe against any teardown race
+	 * where the synchronous path could clear curr_xfer concurrently.
+	 *
+	 * Multi-chunk PIO continuation stays on the workqueue so that
+	 * tegra_qspi_start_cpu_based_transfer() can re-arm the IRQ from
+	 * process context. DMA transfers also stay on the workqueue
+	 * because their completion path sleeps on the DMA engine.
+	 * tegra_qspi_handle_error() -> device_reset() can sleep, so the
+	 * fastpath only runs when both status words are clean.
+	 */
+	if (!READ_ONCE(tqspi->is_curr_dma_xfer) &&
+	    READ_ONCE(tqspi->is_last_pio_chunk) &&
+	    !tx_status && !rx_status)
+		return handle_cpu_based_xfer(tqspi);
+
 	queue_work(tqspi->wq, &tqspi->irq_work);
 
 	return IRQ_HANDLED;
-- 
2.17.1

