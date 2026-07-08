Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBC3AD505;
	Wed,  8 Jul 2026 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473206; cv=fail; b=L2Ur5KzBMe8XCGcV9sRypTeT+ratgYCZ/8373ZPuTpZdvz9Ubbqji1NtpHzHntZF+SvHQkbvNpvzyIUCCrrAY3pcl8f2v2ti3rxDrnH4iTDPhMid9a/XKmeQxY5jLe81FIfBo3nxSYJPd54geuuSt9Fg3KyVOnagr5/bNWNvLaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473206; c=relaxed/simple;
	bh=28rcB0fdJKbT6JoQhVL0RITr9ymJ9+4lZ0HxMhOLIGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EV6SRWyi5jFn5FV5IWeijp+AhH1+1fBppaMFDUhL+ficRSalRwxTwOft5lY/rN6bUilDTQ88CuWNH2jP1EQ5e+YD6m14VmQcoAOZumrD+MSObwPx8a8sdnROZ7Mq6ns9DH5pCIlYhCG4Slo8pvo+PsySpYYExDD2ymLxGp/qhYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bOPwFrRx; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOPwFrRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMj7bHfRmajOyksTPOPqXLT96kg0w4jPmmqFZTmdGyXxq/zxqFeCp/MRnOuqC6ayE5SMrqZ4x54CeANwmRg8XLeThXp6CwK9CX+aXaEpt0a2c5DY5E9CH9GS8yCVd+fqff/e46GYR6+YFFSBI7ob2eImlVQW+yLpe4kW7JbQA0sdK8WkgEmML7Lo/au2/p4vgTHPC5m9DJTmmr92BoZ+LnvxKLjvwyAgTA7PfwblJ8iEZ6O5kKSt4a0ze1wC1ZMft0eyye6Kup6BonqJP1UdZweWZc738JBy7j0888+Y1nI3IS00+x2ovfNX1VyqLzAYpNfVsYliEo+5SnKmCJu26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjme0JlI9eYUr53i6Y/XgdYgE1++iNq6ZzKbz2bM1gM=;
 b=tVskQBiGt9iw5wFGR2rYre2QdqNzt/tsiVkRjRMg9hChz8POzR712bBxj9fUKQfbiJEq8Ye5hVqPpzRPfDalWoBL401pzyEVCgFaOMrkRDwmqRnaBDJzkBqEzEwxWeaCPIEFarF6UxmlpboEg9hkH1YG1y0spYbil20DYb9wS3aOEth/jckmZai2PiSWknTdox/anhi7UkjYpamlAlzlPSj7UwplKg3ZHYljVn9rI6klzCDei7qdhcWodzIM2jOJYITENf6hn/zhY8AMckFOlDmzxK+7JWd349LxOUz8bA2MWvgaBIUQbvOuwym3uw92PkSrF4Zdk84aseqsfTCC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjme0JlI9eYUr53i6Y/XgdYgE1++iNq6ZzKbz2bM1gM=;
 b=bOPwFrRxBtIWhIPm1LX0RmMEZUIPeig7iyNav4h3mX4HYHgPdID31IIO+SLA912VdCTk10WPc1o0+REbOMWY4OT4V1dMHL2uB+NKR5KTWQ/xnW4aw6aYa/Llzk945URacigD5nj8CUomEmebiVEjd6AT4VY2ZN0524JTvr1Xuuu7+9JerFeEkPV+sHLYi9dx/wIOFEBVaoZfSxT4VSbmR2RwTmZUmpCK32YHX1qfLpQcwwRLOmWg4/VhqxDebhjAcI5mRy4I5jiV2p4503iPymr4xZtjVdQMyLUYVqGyTpp3khDEEED+EcF2sXH3xTEljzPG6QmIQsKwcjtOPCfNBA==
Received: from BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::24)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 01:13:18 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::57) by BL1P222CA0019.outlook.office365.com
 (2603:10b6:208:2c7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 01:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:13:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:59 -0700
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
Subject: [PATCH v5 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Wed, 8 Jul 2026 01:12:56 +0000
Message-ID: <20260708011257.1712961-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: a778cde8-fc22-4b3b-1970-08dedc8e1762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TMBviZMhnWh8HpEtK0pFPF7uFZbqj4nYmVkN9lIdksrC+vOZpEcFKDMuySHWs3/Iw1VRJVe/z8OZx7mBUek1YgMwAkC/zCNCexE0JEuCpRCPZYJgw5yZKyd0PrkcoFJGdSUEhGGAiC6GYdodGLnHdr/j45LL5IEVEnwEMjFg290waMyxVU+/U/93YzptHeUTkRiAef72SpW9ZxZBUhcVwOGP2hWOWyn1rlVeyJKwpg+5oaVoEgxmmJkcGpC/DWlH9gH/jO2yGvNTrP4pp9NJOWqdYKXLsOIQrA39ZF8+CsbfdzDQ2BtRl+yAP24rFwoufE/YL9E13owHcqMcZCVigQSZBLonUaJY2NkStG0b/nsPp3/2SzTjskGm7Ph7IX+Rt0oN5Ir2sQhCzo1V5/DovNF/h42+d3RWVpuMNCIgQOlCevWrzFKLCH0ju85wEo8aaZYJ7xq/6dIgHfa5q8Fjy91nRx5u0RzxCaLGTy6YxHdqyrxw8zpQ9RldgwlnBZmxVI0sTzAxx4iK/EzqFCZMN+1JPSn7MAOjO4ePr7F8k6clw9yT6aNVGiih1+nYDYhhMZjGGlKvE64kPiMNRLhHBfa30QQ80MYhVmnCenDHSOxI2od6+TNpEMFBHN5gkiEjL/zukw3kC6EihX3glHCLmOf21BwP+JvWv/OVvsux2TwSanioAL14IhVPTsrOs8Ucys3BCzkEkZmIGh0Si8c82A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lMSCB+lY6Q7p0RJm5kAVdQskbHz+Vv4OfLq201Cs3b4vpLSxg6MxMwvG/6IyfsZ2Nf1TS02R+FsI7QH14XyNYNBwyOQYtSfxcitzttR6gV28SnpVv/Bn0rUkNaVDZ3bW2/Y7xn+PtyNatAOwMqcx0OjgmHbd+6VRkvTAHOO9U2lqBjSI0+e1Dq/bank0Jqr5hgXjhsgs6pZ1OwZVkEQ2zFL99gaSVcve/B4aVs6oST4rqxBFnCII80EF+smA8lCh9ONCjBUlUAFmy6pqdoZVCT6L/BfV9xJB73/WK9qaVTTsiOWpOHNunOzU/i9P5Rprw7wrEz++IQ7Uk8B252+8CMGqUEDqSMVZLBqL+Gj16u+L1Hh/zwwSJ3F7OAa2NUCC9g3PYWhHziC2uSgDKkfIYeQABgKmmII6CQ1deXU7146cvRTF5oDXC5b3wkHC4gHa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:16.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a778cde8-fc22-4b3b-1970-08dedc8e1762
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276

On heavily loaded systems the workqueue bottom half can be delayed
long enough for wait_for_completion_timeout() to expire before the
ISR's queued work actually runs. Reading QSPI_TRANS_STATUS directly
from the controller in the timeout handler races with both the
workqueue handler and the controller itself, and can mis-classify a
transfer that genuinely timed out as having "completed".

Cache the controller status captured by the hard IRQ before it is
acked, and let the timeout handler consume that cache:

  - tegra_qspi_isr() reads QSPI_FIFO_STATUS and QSPI_TRANS_STATUS,
    derives tx_status / rx_status, then publishes them via WRITE_ONCE()
    and the trans_status cache via smp_store_release() before masking
    and acking the controller IRQ.

  - tegra_qspi_handle_timeout() consumes trans_status with a paired
    smp_load_acquire(). The release/acquire pair guarantees that a
    timeout handler which observes a non-zero trans_status also
    observes the matching status_reg / tx_status / rx_status updates.

  - tegra_qspi_setup_transfer_one() clears the cache with
    smp_store_release() under the spinlock before unmasking the IRQ
    for the new transfer, so a stale RDY bit from the previous
    transfer cannot fool the timeout handler.

  - If the cache is zero at timeout time the ISR genuinely never ran
    (lost IRQ), so the handler falls back to a direct controller read
    so we do not unconditionally surface a timeout when the hardware
    has actually finished.

curr_xfer is re-checked under the spinlock so that a workqueue handler
which races with the timeout path cannot double-complete the transfer.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 108 +++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 61f72c778b7e..06625c0a62d2 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -624,6 +625,17 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 	val = QSPI_DMA_BLK_SET(tqspi->curr_dma_words - 1);
 	tegra_qspi_writel(tqspi, val, QSPI_DMA_BLK);
 
+	/*
+	 * Reset the cached transfer status before unmasking the IRQ for
+	 * this chunk. The cache must represent only the IRQ for THIS
+	 * chunk; a stale RDY from the previous chunk of a multi-chunk
+	 * transfer would otherwise mislead tegra_qspi_handle_timeout()
+	 * into a false-positive recovery while the new chunk is still in
+	 * flight. Pairs with smp_load_acquire() in
+	 * tegra_qspi_handle_timeout(). The new chunk's IRQ cannot fire
+	 * until QSPI_DMA_CTL is written below.
+	 */
+	smp_store_release(&tqspi->trans_status, 0);
 	tegra_qspi_unmask_irq(tqspi);
 
 	if (tqspi->is_packed)
@@ -736,6 +748,16 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 	val = QSPI_DMA_BLK_SET(cur_words - 1);
 	tegra_qspi_writel(qspi, val, QSPI_DMA_BLK);
 
+	/*
+	 * Reset the cached transfer status before unmasking the IRQ for
+	 * this chunk so the cache represents only the IRQ for THIS chunk;
+	 * a stale RDY from the previous chunk would otherwise mislead
+	 * tegra_qspi_handle_timeout() into a false-positive recovery
+	 * while the new chunk is still in flight. Pairs with
+	 * smp_load_acquire() in tegra_qspi_handle_timeout(). The new
+	 * chunk's IRQ cannot fire until QSPI_COMMAND1 is written below.
+	 */
+	smp_store_release(&qspi->trans_status, 0);
 	tegra_qspi_unmask_irq(qspi);
 
 	qspi->is_curr_dma_xfer = false;
@@ -861,6 +883,13 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	tqspi->cur_rx_pos = 0;
 	tqspi->cur_tx_pos = 0;
 	tqspi->curr_xfer = t;
+	/*
+	 * Pairs with smp_load_acquire() in tegra_qspi_handle_timeout().
+	 * Clearing the cached trans_status before unmasking the IRQ for
+	 * the new transfer prevents a stale RDY bit from the previous
+	 * transfer fooling the timeout handler into a false recovery.
+	 */
+	smp_store_release(&tqspi->trans_status, 0);
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	if (is_first_of_msg) {
@@ -1075,26 +1104,65 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
  */
 static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 {
+	unsigned long flags;
 	irqreturn_t ret;
 	u32 status;
 
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	/*
+	 * Pairs with smp_store_release() in tegra_qspi_isr(). If the ISR
+	 * managed to run before wait_for_completion_timeout() expired, the
+	 * cached value lets us classify the timeout without racing with a
+	 * concurrent HW write to QSPI_TRANS_STATUS.
+	 *
+	 * The cache is reset to zero in tegra_qspi_start_{cpu,dma}_based_
+	 * transfer() before unmasking the IRQ for every chunk, so a stale
+	 * RDY from the previous chunk of a multi-chunk transfer cannot
+	 * survive into this check.
+	 *
+	 * A zero cache means the ISR never ran for this transfer (the IRQ
+	 * was lost entirely). In that case fall back to reading the
+	 * controller directly so we do not unconditionally surface a
+	 * timeout when the hardware has actually finished.
+	 */
+	status = smp_load_acquire(&tqspi->trans_status);
+	if (!status)
+		status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+
 	if (!(status & QSPI_RDY))
 		return -ETIMEDOUT;
 
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * Take over completion processing from the bottom half. Mask the
+	 * controller IRQ first so no late ISR can queue fresh work behind
+	 * our back, then drain any in-flight or pending work. After
+	 * cancel_work_sync() returns, the work handler is neither running
+	 * nor pending and handle_{cpu,dma}_based_xfer() below runs
+	 * single-threaded with respect to the bottom half.
+	 *
+	 * tegra_qspi_mask_clear_irq() is idempotent: its read-modify-write
+	 * of QSPI_INTR_MASK and W1C of QSPI_TRANS_STATUS both tolerate a
+	 * double-write, so it is safe whether or not the ISR has already
+	 * run for this transfer.
 	 */
+	tegra_qspi_mask_clear_irq(tqspi);
+	cancel_work_sync(&tqspi->irq_work);
+
+	spin_lock_irqsave(&tqspi->lock, flags);
+	/*
+	 * Re-check curr_xfer after the drain: the work handler may have
+	 * completed the transfer and cleared curr_xfer while we were
+	 * waiting inside cancel_work_sync().
+	 */
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
@@ -1659,6 +1727,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status_reg, trans_status;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1666,16 +1735,27 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	}
 
 	spin_lock(&tqspi->lock);
-	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	trans_status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 	tegra_qspi_mask_clear_irq(tqspi);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
-		tqspi->tx_status = tqspi->status_reg &
-				    (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+		WRITE_ONCE(tqspi->tx_status,
+			   status_reg & (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF));
 
 	if (tqspi->cur_direction & DATA_DIR_RX)
-		tqspi->rx_status = tqspi->status_reg &
-				    (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+		WRITE_ONCE(tqspi->rx_status,
+			   status_reg & (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF));
+
+	WRITE_ONCE(tqspi->status_reg, status_reg);
+	/*
+	 * smp_store_release() pairs with smp_load_acquire() in
+	 * tegra_qspi_handle_timeout(). Publishing trans_status last with
+	 * release semantics guarantees that a timeout handler which sees
+	 * a non-zero trans_status also observes the WRITE_ONCE() updates
+	 * to status_reg / tx_status / rx_status above.
+	 */
+	smp_store_release(&tqspi->trans_status, trans_status);
 
 	spin_unlock(&tqspi->lock);
 
-- 
2.17.1

