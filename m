Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011E2DF3DA;
	Wed, 10 Jun 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072657; cv=fail; b=j/ji7PDnI9q4RprshBAs2XOFaQkWtKN38NadXx/qJzYlzOqNvvEDkz5uwsQRMkqcrESySxBd8InF+Lhz3EUquYgG1WuiSqMGhhFMTjKgBPUe8po4EjplkTAXb+uFciVnSAf4DuE49xGT7VakHBd8ebYiKWePhIEzcgeF8X4VN3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072657; c=relaxed/simple;
	bh=naH3vsvFazyiRgaYQq5GDHmSEweqdb8W+fY69HS+I3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHiH1tnQ5aq5JN5rSV62XzFSOT2HgFSHoeBjjpxpDTMk3vTP1cO+09f2lWQrTxzvvGWCE/YOJhZyi5v4DyoMR+iyG6wK/5mOyHtUrCxAneXPQH1PGHndTns0lPNy1oPYPdKGuhp7aelFhQQz5fRFlCRWhNwe4kJMF1CsiaDCu24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcOZiUWb; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcOZiUWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idHqmUA7GYp/XL4hIOW/oSyZXObo12b/69OKrcRxl+oYDmoatajjjxuzOeKUZxT+B27k21Dy6nEgKRlTLcZq7UuERLTzVMTReDYVmMytZ5GyUIXKHXoDaH8R0kJFMUxnqJM1hwGVUkd3nDdrnB8wYq1+YAPimiT5+XjrRhyMWbN1+QhffydrEX6mvqOc4D6utyhn9qnw+Zq5fVKXkBDuz5JUIPdBMqUIXt/IR7CsSfyJDa/ncPr2zBE8eMeZHo+ZWsSQxCDOcGvJKM8n9x6VF+TbfU2T2FYLz4z8DsVtc0Pv7IV52tqHJL9xOJacHn+EeO9vfTpJjqe0JiC9ns+FCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkEedGCk2DFwFfMyHRPGbUp27xV9fNQ3B4M4LTNbSfI=;
 b=NCtCSJq7O3EdhOuzwGsTPWl8ux62P0+R0rCy8UUXl+W2PHqxQW6qmKJPUUzpfYp/fR7JCwD+lVavhAh77/4Q4mI9CnwYVYZ8+B5Ufi+3j27v7YEPzyPA/tU2taErFYBGE4OvUozlHooOq82jFszMlNAup4uVl674T7STNn6Pl55DJYqNQRmu34pT/ShfAKnfZ6kOTsUXSFknbYIJHIgNb66ZoYolWsYQc6DdIqqFhDFgLqVCxVldy0/CdTTbgbQZGGCD0vQU+iHrgOpBwQGuSLBuTikgTlvQNbs2sFCJT6PjXPJ5FJcoKuKSTbZo7kxU8F4dT+7ZmcuRm9/IVa4m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkEedGCk2DFwFfMyHRPGbUp27xV9fNQ3B4M4LTNbSfI=;
 b=jcOZiUWbbxQR5DbqYjUw5NRNe59+uBlnHEZerHbJT8KUrJjhASg6lmUEBAI8zUyLS8foCyWnTwl9l9yuJqJZoczYptFLEh/4Yr/Y7nXqMzr3ICMV0emm2QFkPEuTMRcPfQnFnhEY04RFgwuJdNpWqsn0d/TakcAfm15FeXKnYOMzFLs/9Z3GynVLrOwQ72DroZEY9i2nRm4NgbV2hdz9OVOJqYzmrVnl52cx2sC1/m9ywt8iYdvuw0tN6Wr9xRLoZstvJ6Lm9qNG8kjDHThWLNspemKMYA1Guhn/R7DNP6vUOEaFU7wuKeTLgLlmJQHgsE68v38oXJyq+OyXAIXV5A==
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 06:24:10 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::5e) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 06:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:24:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 23:24:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Jun 2026 23:24:03 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 9 Jun 2026 23:24:03 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Wed, 10 Jun 2026 06:24:02 +0000
Message-ID: <8b89310f9c3e6884910d533890e95d1039edc39a.1781037385.git.va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: c53686e9-79c8-4d17-e312-08dec6b8e248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KFiSjwdnE+xiVk0/8t2wQ24zyo/jVO+2sql9Ds+mDp8iGg0w4LTyH4pG0aNa0zNFNbSh/xX2SHuhVa8Qdoy6elc4/mJ10C4L7w36EXA60+tmNI17FTSI/z0/+pXO0nTsGtfLpsJD4PKlTVg83seWyZ6hEkafisiUkiI9/5UsP2D6NMigHR0etF2b7//ofabdfzYh1C8CaWaadcXbLd/DtjkH6ENsttyvgTX7uNKJ90FWAa9f4zMinftlXn0rdASr579tsOlBrjPt4XovFFzehrUGhbhPlTLws9IE3ZtNT94KnDGfsqF5gX1gc0rDnczgLNiDEw3pNfsEnRKpxtXhNtBlImSb9KxC6/+yzuXQS+EYWR0g2oQjZkSTX7t8ETt0zPgBQLbd3ZwehHRxuyWfIzYH0mWN6lvF9QH5iHQLIn+nVgoWPudvkmexy3hAF6F+X3Syb5ImqmRrRmsWw7w8hVPU1RLXvpa3wYD2r706JWjAJkWmFHFs67xOhXmrYJlfda+Cr417n5OPhLf7TWZ7LCFITc7lAvD5Kg3rQ1Zu7MwVNSHMnfQp1sysBmFw1GqxlIae+U0f2NFSlFePtOTH5XEw5xmo4l9g7VnOesFTpGxnwDPwubV1T05lJn21waw4xlHqO123nyjkUWg81IwskaDG9P3P8pJiCoRETJ5o1pimK+PXKY3j1N/n7+REi3igH5HoDrAEgJr5vKovZ+aJc950bylqFwkpPF6+HPWseJ4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mV9Tf5bD6aFevbdYj/IYY2iBD6bsLIc7ix7dl5AeeJp5VYmLQljydWg4FIbTT8nCvtoCSysBgCVQPXzXuIy1H09oxzL1jjmGWLfKvXie3WtWgyrqm5hA66w1HeovKvcBf0dm59RR6bZTMtR8acVPLfeGL30+HVOOxveM9kRA3b/n8ZmA93WIKpLKDlT/Hx3+WL1TxDxXbO47TcyBfGNgpKP765+9rNul3CaE0GdaNUWcPU7buC6EUW8EGbn8neEYGy2yyvit0N4EGfQxbR3D0GyqSchMjhXgahHFgY8IydXNzaGR71gwBDEq21ZL/MbJZpgO/8aqloP1i3Isd3VsxD6W8aKkLDTBB99HG9ui3cdw7kdavic6LMG0fAEuQ38MKqt0LEfjv/pZvLlup8UDy54I7A5ont773eN7FpKbnOhfNlQZWOwrgrWBM1Bu6vvF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:24:10.4436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53686e9-79c8-4d17-e312-08dec6b8e248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

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
index f0b15d13e433..e7611275734a 100644
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
@@ -716,7 +728,13 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 
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
@@ -737,9 +755,23 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
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
 	tegra_qspi_unmask_irq(qspi);
 
-	qspi->is_curr_dma_xfer = false;
+	WRITE_ONCE(qspi->is_curr_dma_xfer, false);
 	val = qspi->command1_reg;
 	val |= QSPI_PIO;
 	tegra_qspi_writel(qspi, val, QSPI_COMMAND1);
@@ -1656,7 +1688,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 	 * DMA handler also needs to sleep in wait_for_completion_*(), which
 	 * cannot be done while holding spinlock.
 	 */
-	if (!tqspi->is_curr_dma_xfer)
+	if (!READ_ONCE(tqspi->is_curr_dma_xfer))
 		handle_cpu_based_xfer(tqspi);
 	else
 		handle_dma_based_xfer(tqspi);
@@ -1684,6 +1716,7 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 	u32 status_reg, trans_status;
+	u32 tx_status = 0, rx_status = 0;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1695,13 +1728,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
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
@@ -1715,6 +1750,30 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
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

