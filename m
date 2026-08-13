Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323E368D7E;
	Thu, 13 Aug 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651259; cv=fail; b=Eg4ezBr3iRRNanTE1s52PJxUAaAD0c1aBJOn0X6tiJ3DHuCbsU3niJW9vZB8RyfiKs2KUldSF6A8+4JvRW0h9RqvGTFUkeFW5GiCLHE3jxJzYTDbGKWh4ruyzgQ2TnprrV8hTTYeEfFD/kpUaMiwKtdpRao1NtuAjbpRhYW/1Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651259; c=relaxed/simple;
	bh=j0ap5E7Bl3+06LNFv332ljRe1ZicGU0EJ3JuXdfvhBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHAoNfMFxM7rN/gsUdXbSpJvfjfzgWj/sje+tsxfMnhmy7EjDdYfLZXIdpOFfCSgNFR+c/NNaQYT5uB8110oByIyHW6fJASxbl1LdxbijodyE+Y+q+Wcz7b59icRL4RvSKip32TJMVQ2R9jShL6O5Vg5rVBv6bH/ToB44Wsxef8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gICUZ5+D; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gICUZ5+D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQLW0obrDKQm1YQ9int1uwG7v/habB5oMdnsumgC14VXVt8nko2gUF5de9eHefb6UEHBuNy56D7SVVP2ArDpOjExUwsj4Kdoj/nvg21nMcABM6mX918OZ53jU11eWjvluuxD7RL4V+ks5qkuDGcWGTsmNlQ5bwO3lQ0slJo6GnGveB2rBGcSNw6gbwDDxtQ1N6A8pMFeBte2+UCKhz7jol6CPkNQILr9sjMD4KMBE+HbEKamwXqA4mkUNKLNiYeIMkETZCwq1eD2w5cAzJa0axXM0QBxo+8SBRZ4KTxUhNKZLSpxcRe9/c37co9rOQbxj06LyDQs3TKC3IqafiWUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFvYZ+WR91YCW563OlU3YNVrR/vYYVLIeuI8r8dakA0=;
 b=P1ZMDbZP4+xqSlxYuGakGvVnon5WHfEajQIpOeQ5x5MAEF7SZIyMFbAUpxVqT+Fq+81lheUdzJYCQ7nBuT5SMynUW3bOZHCVNz66bDAO7rxNVt+q5i6K8B/WPvA0uADPPWPnkQDAjQfrV5qz+Lmo7b2K/3Gn1gsKS9iyfTDPXSIt7fYKhztTU3HbGhOxJhSbAY6UcD3oKSbXGioMnSGD2jtNKZ9UyArJGjOeO9yQQIVo6pkU1IGtnvqxo6piuqssXaRc9i7XJmrZoBWc1TNuGy45Pu1AIBIaDHosW6BRIHcvZ7T/Fe2fM7wjrat5t0E0YNPvDiiKK4pqJAugxAmFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFvYZ+WR91YCW563OlU3YNVrR/vYYVLIeuI8r8dakA0=;
 b=gICUZ5+D23a6IZFA5MiLHYUkpLwqZn4Qzvm8Rhb/wO3EgJX0eZBJLFoIEmxmKzs+pA2gw3dn2lXel9FlRE877gx2aMJV0CXUMWhyHMp6Sx9X9zQXD2/WcvDX589SYtBnXwvEAq/73HYm+Db1GIICPfOBp1Gt9layMHo3BvavUZ2FsQw9sWz+cNIikLw+VR5LqfmPvl2N+LpvEX2fYY1y5c2VOKkR6QSceZZXi6ltfn1rqst84BC4ghn3eyDR0UFxvBqSnTeTUB7YuAKbi9EYpBHW4RfgYJUU7KdJIPfIUwgCbP+1Fj+8Lp6tprP3ewTZJQT90iqNGzPnb1/Vw6hVfw==
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 20:00:50 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::4f) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Thu,
 13 Aug 2026 20:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 20:00:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 13:00:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 13:00:28 -0700
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
Subject: [PATCH v6 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Thu, 13 Aug 2026 20:00:27 +0000
Message-ID: <20260813200027.2711863-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a475cd-08f6-40ab-e9b6-08def97591c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	blC3xzYJ9w4RIk5BexsoZQLBwJ/axwOvRCQuo08rPIps750KAlRj/hhrmVJAXrMjNGJPLA3ZAr9Yqf3I34cQkBIg7f1tHC6crb1mblSdTETCjY+Rd4f19Lm2Cc1q7kceZOTxA6xp87XzZXygtTp/4qJGQv6Qd7RfGPWsZ99Ga05PvPus0+GCSBhWM/ao0ha5Y43VxX89/+IO1r0Eimn2G/eFevTM1X/hLID3y6AVqyzbcI87T6JuTpxiHFdXTFc2pcVR2f3R0ZnqasNvRzQ9+pR3Cmk05UOnohLP54an1lzcJv8d/QpeQ/QFSxyt3rZ+GPQFqEXVIdb61YVxi+nfAFIX5rbiiqZMKd9Q6U15AYVw+xnl5GchMWCiYOqARo7soZVQ0xBmDnB9+4BMe++HONZrcgGETiP+8gaL1hM+LHrfa74aagieaPwRwU3x4YrC9c5YhHA17tK/pHYNzhRJw9T2sU0w+8c81YYVjwE6Vd0DdihrGApjV3zoufk9d6PBdqlDRheRNYVdnR9jpAN8CmuGxfhxDSMPWNEi7oxGbwhdI6YFxSWjF7kzWjrH32rwxyuzR5/49/b2B2AsBkWIUk0o5UCUhhd1Mss96PeBGdTXhSiBVJPXmaCbmO2HgWnyfZoi7RShQlA0Ign0n7vRTAEpDuMMvOLp0zTXdnCo+JGSkIfKxVPFAXxLp3KzR3w2bbTXtiy/3oqwayyEZtQjXA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jFSwGXh7bbXxhaCrTANi6Zlj6/yxpAnCVir7xcJb4YjKL1DazZpJQxJ772km3W/KPeJZfgVlknjuXFPYOkxG3r6Q7RgT73+heHoeSKNiDyKeLNTY//Ju2LB0eHh0Uo4hBV4yCtcGdadHZbkk58HsaqMhqVeyhW0mQ9bBa+SDxhaqcFbq3OjM0135W/jHPcPLwXPZRqShkDXRsV52j0iLBkUi6qfsBv2FJH8ZiqS0nrti+h1QFLt4PKVyagMIkHdUER04WJzp6HAqZ9PYV1MrgxIrW/kyvCCqZIR23ay2eNl3lHrjhsnYEzMWgevaro1h+Kx1EyMVPk2GFVk19G8mzWSvy2MrbRvG54lwYH0rSsPgDcRZop82159lWdzVU0aPSYVJOTorALTEY+jVxC1pMhiesQ6UuYsEgWvigo8bD4GpfcWlNrUIV19oXhp2Ogmh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:00:48.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a475cd-08f6-40ab-e9b6-08def97591c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

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
 drivers/spi/spi-tegra210-quad.c | 88 +++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index c242f56a09fd..d8cca3aa276b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,18 @@ struct tegra_qspi {
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
@@ -734,7 +746,13 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 
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
@@ -755,6 +773,20 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
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
@@ -767,7 +799,7 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 	smp_store_release(&qspi->trans_status, 0);
 	tegra_qspi_unmask_irq(qspi);
 
-	qspi->is_curr_dma_xfer = false;
+	WRITE_ONCE(qspi->is_curr_dma_xfer, false);
 	val = qspi->command1_reg;
 	val |= QSPI_PIO;
 	tegra_qspi_writel(qspi, val, QSPI_COMMAND1);
@@ -1835,7 +1867,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 	 * DMA handler also needs to sleep in wait_for_completion_*(), which
 	 * cannot be done while holding spinlock.
 	 */
-	if (!tqspi->is_curr_dma_xfer)
+	if (!READ_ONCE(tqspi->is_curr_dma_xfer))
 		handle_cpu_based_xfer(tqspi);
 	else
 		handle_dma_based_xfer(tqspi);
@@ -1863,6 +1895,7 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 	u32 status_reg, trans_status;
+	u32 tx_status = 0, rx_status = 0;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1873,13 +1906,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 	trans_status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 
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
@@ -1913,6 +1948,41 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 		return IRQ_HANDLED;
 	}
 
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
+	 * The fastpath dispatch decision is made while still holding
+	 * tqspi->lock, so the recovery_in_progress guard above covers it
+	 * atomically with queue_work() below: an ISR that reaches the
+	 * fastpath cannot race a tegra_qspi_handle_timeout() that
+	 * subsequently observes recovery_in_progress == true, because
+	 * that path calls synchronize_irq() before proceeding. We drop
+	 * the lock before calling handle_cpu_based_xfer() so it can take
+	 * tqspi->lock internally without deadlocking.
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
+	    !tx_status && !rx_status) {
+		spin_unlock(&tqspi->lock);
+		return handle_cpu_based_xfer(tqspi);
+	}
+
 	queue_work(tqspi->wq, &tqspi->irq_work);
 
 	spin_unlock(&tqspi->lock);
-- 
2.17.1

