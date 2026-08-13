Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161036194E;
	Thu, 13 Aug 2026 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651268; cv=fail; b=OAnjOPcVCtVIN0fUrWb/ajh4k6Rzhxl0RZwpvIx7bESI6c3P83Lqj1renSqvw2b/o+ji6z+VGmi4E7ucBwyP6NECod/koMbcHYb9Xh0Voy5OVCjLF0H6lMMnxSLgGWsSaT01lB4UN2p4ZC2WR/YUOsk1LJFVlZZkx/jDInH5Q4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651268; c=relaxed/simple;
	bh=hoLIXNFLUerl9vJWmBP6BstEzuQEW/TbSJcevw6LLhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlBwKbgNFg33vX0EeSRZW3GWnencox6ZtLaI+K9Jn7cEYApdLFK3iU6EH5kWjEUd2IeXWfb5/+U/oneyuCR0TgX1jeBnhSLCqmY0q6SL3/s9vdZHX4MK1NH1TxdBZHac/D7yBsfKAUctQCRQ5DlTAbyskCrtz0N32GtGF4oKCHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hdy3YcSl; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hdy3YcSl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuCH20kC8F8vj12FKbriArP9ySs+PPT9TD8VsR1BGYIcpwqiiagG2hPZ9qUGNeq1ssTZQD616bsYz6OxXnVkfEaETYXbrnAcrdXmgoYZLOqdYNIERTV2PvOKn4426GsE9CPf2TWaogSXn6wrQvDj3euTYU2K1ed7XY8jAqUi7NLpLFrqUnKSc1FmJ2V0bKJzynH2oj/bRZbzSbAYTF3vkEe9XG7Hj0Xcq/Ys7Sx2BxZEBrp+drVil22SXfp01twkQuObg8oCpD5fPYHM5nU9G1RvDFMgD5otOU6/0Euyp28tnM2hZkuFrpDuBdbBes5dB50qnmqXv9W/SNLdgPPE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZmC8kPgFSJEh33dvmSqb6LggP93pDjYUHNOUN/6Wus=;
 b=CpgL9RbxqsgzuW3UFn6coj3HWr1ZptH467Ty72VQytuwNxRsglKe296bXe8I9MLKu5di2builVKepvrfDMDCwJg4EBbfjgBGisVkvKI9WSaVK9E+6p/KMzw5J6JkXIoidTuusbZkBNiI82DLHF+E13YqMOMV/MhZ4h/5mR6mmYOMCXqgANOhJ+4qJCvQzGw3xfpCDFZO7rQf9CoMnkPsEwplzj+xY1AXwCbyh9GECJqD94gB1qXHfqclzeHoYCT3zdqa4y6aVXM2Ij7vNI7k6jEC7b/eaF/4Y+xW/Iao04YiG+q4Kgs2u2wp1tT4tcJPIXUo1AVpcvm4L4vLy14iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZmC8kPgFSJEh33dvmSqb6LggP93pDjYUHNOUN/6Wus=;
 b=hdy3YcSlHqeaCEal7HXH0f+De0izQj+XvuYPkTPnn3jqZy0owo0H2amILFY2V6py76rERxoax1VsFO84RCekoA8j8ty2iIwk7U0LQu/dWHkRVm+YvV8nDHmK01MND5cpcKIzzu7AGES9iBe26hGKmQXRLGm9JihIFPKb68AW0M2ntXlL5ZtMH6q7HBOrkrcd41Ck1r84BplnKtrTAbJ4/gxerL0mlPeFclhrFlBhJCEEZHm5HJ3DJRs0eVruIWWUE/enPon2We+XU6jgRyGt0M9657EIMvybbSIfE0B26ihzYT6paT7tY9cRm8YEghFiS31/yhTndk3Hi3BxeybPcQ==
Received: from BN0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:408:e4::11)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Thu, 13 Aug 2026 20:00:53 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::6a) by BN0PR02CA0006.outlook.office365.com
 (2603:10b6:408:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 20:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 20:00:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 13:00:28 -0700
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
Subject: [PATCH v6 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Thu, 13 Aug 2026 20:00:26 +0000
Message-ID: <20260813200027.2711863-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2cc418-21bf-4f6b-4a23-08def97594c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	x4cQjHexgamwIexU/ry9mOhZsR8BPTSrVG2fMGZ80clN+ZRbdwdZxu4SMyGaVIyUnpGoqyq1dr7Ww886hZyQPgDBxMAxO6miTdu9HFZAfvek5bxkmLZ9JqbAi45tXe68Wea4sbLIiZUNhCXT7UfVwSa/UKGH1UoitqqQIJsRmmkeMNHrgH8G3T3QSHnXMqzXz4TB44IQ9NL1SenHUtKa9a9EJ+8TLSJuhcPAzMb1fVA9/YRRNJen9XWWJno2VHFbz1ZMcyd43Iswp7C3LrFcwukOWFKPcXBVm4bjzZpHM7MXLlbqQ54t5k17MGDW3dOaPONLpQzwR20JOLyeudQrlS2A+GTWUgoS6EWRoaSOXjetHowWhPCA6SXTPFBxfw3KCHOCoxmE8ARKwLXaGmDcfUWXz/NDcJ2ROL803iysqq13dXd8ilFIZwynzcZ4R4phowcYNPtToAMX9AB8nWZNLxn7367biZg2N/LFiht5IbocQymUDzODueYPj6lvbVBVKhjHCBNZ9UTz/shkKkFSxbiTRZjXCHa9jAtkzLzbm8GPbvWALc8vYj1j4YVsPjtemR3bA1RcFanHbP6n7hBqGe2JdVCuhBQ0ZZfx7hQ4/dTLMQx1Oaw7Bl0lJKYHOHkL0H8imklb7C2h51/hEs7dwCOHNCeXhegY2umDx4hzaf8yOe8wMt3qwHj9j03QRWiC7Y9Nf9dsQuXC1kKVPWY/ig==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Rku0ArFrhlTPSODB2EcS4v2dm2iSqnNRJj3lyliLDOD0M1wwehkaLG8u3X43vFSedFmGZ6C4FytgcKq3RJC8EkMBhwe/Af86x0oaOeLz4am62bLFe1QKldRsyN6T1WqSahlsgEX3V8jsUfNfINHQRGcAjbe4mdwPf/zZL0a592Jl8XX6ABfYe7iNC6abVgRYOaovfGziexgELksY++LeZoemXP310cS5s1/QZlC75IQGmDN2tkpnardmZe5ImhQuQ5jXQmif7LUakQAcXIHTN/vezviS/8PGyarIs0KPbRLD10Z9ScSjruNNOtr+VjY9+WGx5oMK3i6FJMk3YOFjZp+IR2KG2IHtzU/P0lftKcbg4ik6YEmzBzw4FZBfO/gfkPDIyXYp4c2cbzSuGGomuQan4z5h5gdc1t74XHdgEJYn6I27dutniDSpDoqLZB4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:00:53.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2cc418-21bf-4f6b-4a23-08def97594c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

On heavily loaded systems the workqueue bottom half can be delayed
long enough for wait_for_completion_timeout() to expire before the
ISR's queued work actually runs. Reading QSPI_TRANS_STATUS directly
from the controller in the timeout handler races with both the
workqueue handler and the controller itself, and can mis-classify a
transfer that genuinely timed out as having "completed".

Cache the controller status captured by the hard IRQ before it is
acked, and let the timeout handler consume that cache:

  - tegra_qspi_isr() reads QSPI_FIFO_STATUS and QSPI_TRANS_STATUS,
    derives tx_status / rx_status, publishes them via WRITE_ONCE(),
    and then publishes the trans_status cache via
    smp_store_release() *before* masking and acking the controller
    IRQ. Publish-before-clear is required so that a timeout handler
    that fell back to a live QSPI_TRANS_STATUS read (because it saw
    the cache still zero on another CPU) also sees the hardware
    RDY bit that has not been cleared yet.

  - tegra_qspi_handle_timeout() consumes trans_status with a paired
    smp_load_acquire() and a cache-live-cache retry pattern. If the
    initial cache load returns zero, the handler reads the live
    QSPI_TRANS_STATUS register; if that also returns zero it retries
    the cache once more. That closes the interleaving where an ISR
    publishes trans_status with release semantics and then W1Cs the
    hardware between the timeout handler's cache load and its live
    load, otherwise leaving the timeout handler with cache = 0 and
    HW = 0 (a false timeout on a transfer that has in fact just
    completed).

  - tegra_qspi_setup_transfer_one() and both
    tegra_qspi_start_{cpu,dma}_based_transfer() paths clear the cache
    with smp_store_release() under the spinlock before unmasking the
    IRQ for the new chunk, so a stale RDY bit from a previous chunk
    of a multi-chunk transfer cannot fool the handler.

Serialise handle_timeout with the workqueue and the ISR
unconditionally. Every expired wait_for_completion_timeout() enters
the recovery state: publish recovery_in_progress under tqspi->lock,
mask the controller IRQ, synchronize_irq() to drain any in-flight
hard IRQ (including the small-PIO fastpath), and cancel_work_sync()
to drain the workqueue. This holds regardless of whether the
hardware finished, because a genuine hardware timeout still races the
caller's dma_stop() + device_reset() + curr_xfer clear against a
delayed ISR or worker that arrives immediately after the status
sample. Classifying the timeout as -ETIMEDOUT only *after*
serialisation gives the caller a stable state to clean up.

Snapshot the live FIFO error status *before* entering recovery when
the ISR cache is empty and the live QSPI_TRANS_STATUS shows RDY (the
lost-IRQ path). tegra_qspi_mask_clear_irq() W1Cs QSPI_TRANS_STATUS
and the QSPI_FIFO_STATUS error bits, so a lost-IRQ recovery that
called it first would erase the very error state the manual handler
downstream needs to see. Capturing the snapshot before the mask and
publishing it into tqspi->{status_reg,tx_status,rx_status} after the
drain keeps the manual final-chunk handler operating on fresh error
data rather than stale fields from an earlier ISR run.

cancel_work_sync() cancels a pending worker without executing it and
waits for a currently running one to finish. The recovery_in_progress
guard is checked inside tegra_qspi_isr() under the same tqspi->lock
as its queue_work() and small-PIO fastpath dispatch decisions, so no
new bottom-half work is enqueued once we publish the flag.
synchronize_irq() closes the window where an ISR observed
recovery_in_progress == false, released the lock, and is about to
call queue_work(): we wait for that ISR to finish before draining
the workqueue, so its queued work is caught by cancel_work_sync().

After the drain, re-check the cache once more (the drained worker
may have published a completion status the entry snapshot did not
observe). If try_wait_for_completion() reports the whole transfer
completed, return success.

Restrict the manual fallback that invokes handle_{cpu,dma}_based_xfer()
from process context to the last chunk of a transfer. On an
intermediate chunk of a multi-chunk DMA transfer the work handler
may have processed the current chunk and armed the next chunk
(unmasked the IRQ and kicked HW) before cancel_work_sync() returned;
running another handler here would let the caller's seq_xfer clear
curr_xfer and finalise the message while the DMA engine is still
moving the next chunk into the client buffer. Return -ETIMEDOUT in
that case and let the caller's existing dma_stop() + reset() path
clean up.

Before returning, re-mask the controller IRQ and synchronize_irq()
one more time. The drained bottom half may have unmasked the IRQ
when arming a subsequent chunk; without the re-mask a lingering
RDY IRQ that arrives after this function returns could invoke the
ISR and queue a worker after recovery_in_progress has been cleared,
racing the caller's cleanup of curr_xfer.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 294 +++++++++++++++++++++++++++++---
 1 file changed, 266 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 7c09a1fe0d41..c242f56a09fd 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -193,6 +193,13 @@ struct tegra_qspi {
 	unsigned int				irq;
 	struct work_struct			irq_work;
 	struct workqueue_struct			*wq;
+	/*
+	 * Set by tegra_qspi_handle_timeout() while it drains the bottom
+	 * half so tegra_qspi_isr() suppresses new queue_work() calls
+	 * that would otherwise race the recovery path or the caller's
+	 * cleanup of curr_xfer.
+	 */
+	bool					recovery_in_progress;
 
 	u32					cur_speed;
 	unsigned int				cur_pos;
@@ -214,6 +221,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -624,6 +632,17 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
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
@@ -736,6 +755,16 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
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
@@ -861,6 +890,13 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
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
@@ -1067,40 +1103,206 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
  * tegra_qspi_handle_timeout - Handle transfer timeout with hardware check
  * @tqspi: QSPI controller instance
  *
- * When a timeout occurs but hardware has completed the transfer (interrupt
- * was lost or delayed), manually trigger transfer completion processing.
- * This avoids failing transfers that actually succeeded.
+ * When wait_for_completion_timeout() expires the hardware may still have
+ * finished the current chunk. Drain the pending bottom half and, if the
+ * whole transfer really did complete during the drain, consume the
+ * completion and report success.
+ *
+ * When the bottom half advanced the transfer by only one chunk of a
+ * multi-chunk DMA/PIO transfer without signalling xfer_completion, a
+ * fallback that ran handle_{cpu,dma}_based_xfer() here would race with
+ * the DMA engine already moving the next chunk into the client buffer
+ * (spi_finalize_current_message() would then release the buffer while
+ * the controller is still writing memory). Fake completion is therefore
+ * only attempted when the current chunk is the last chunk of the
+ * transfer; multi-chunk continuation timeouts return -ETIMEDOUT and
+ * let the caller reset the controller.
  *
- * Returns: 0 if transfer was completed, -ETIMEDOUT if real timeout
+ * Returns: 0 if the transfer completed, -ETIMEDOUT otherwise.
  */
 static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 {
+	struct spi_transfer *t;
+	unsigned long flags;
+	bool is_last_chunk;
+	bool lost_irq_snapshot = false;
 	irqreturn_t ret;
-	u32 status;
+	int retval;
+	u32 status, refreshed;
+	u32 lost_fifo_status = 0;
+	u32 lost_tx_status = 0;
+	u32 lost_rx_status = 0;
 
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	if (!(status & QSPI_RDY))
-		return -ETIMEDOUT;
+	/*
+	 * Snapshot both the ISR cache and (if the cache is empty) the
+	 * live status registers BEFORE entering recovery. The recovery
+	 * path calls tegra_qspi_mask_clear_irq() below, which performs
+	 * W1Cs on QSPI_TRANS_STATUS and on the QSPI_FIFO_STATUS error
+	 * bits: a lost-IRQ recovery must capture the current FIFO error
+	 * state before the mask erases it.
+	 *
+	 * Cache-live-cache retry: if the initial cache load returns zero
+	 * we fall back to a live QSPI_TRANS_STATUS read, and if that also
+	 * returns zero we retry the cache once more. That closes the
+	 * interleaving where an ISR on another CPU publishes trans_status
+	 * with release semantics and then W1Cs the hardware between our
+	 * cache load and our live load: the second cache load observes
+	 * the now-visible release and we correctly classify the transfer
+	 * as complete rather than reporting a false timeout.
+	 *
+	 * The trans_status cache is reset to zero in
+	 * tegra_qspi_start_{cpu,dma}_based_transfer() before unmasking
+	 * the IRQ for every chunk, so a stale RDY from the previous
+	 * chunk of a multi-chunk transfer cannot survive into this
+	 * check.
+	 */
+	status = smp_load_acquire(&tqspi->trans_status);
+	if (!status) {
+		status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+		if (!status) {
+			/* Retry cache; pairs with release in ISR post-store. */
+			status = smp_load_acquire(&tqspi->trans_status);
+		} else {
+			/*
+			 * Live register shows RDY but the ISR cache is
+			 * empty: either the ISR ran and cleared HW between
+			 * our two loads (the cache retry above would have
+			 * observed it, so we would not be here), or the IRQ
+			 * was genuinely lost. Snapshot the live FIFO error
+			 * status now so tegra_qspi_mask_clear_irq() below
+			 * does not W1C it away before the manual handler
+			 * downstream can see it.
+			 */
+			lost_fifo_status = tegra_qspi_readl(tqspi,
+							    QSPI_FIFO_STATUS);
+			lost_tx_status = lost_fifo_status &
+					 (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+			lost_rx_status = lost_fifo_status &
+					 (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+			lost_irq_snapshot = true;
+		}
+	}
 
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * Enter recovery unconditionally. Every expired
+	 * wait_for_completion_timeout() must serialise against a delayed
+	 * ISR or worker before the caller runs dma_stop() +
+	 * device_reset() + curr_xfer clear: publishing
+	 * recovery_in_progress under tqspi->lock, masking the controller
+	 * IRQ, calling synchronize_irq() to drain any in-flight ISR
+	 * (including the small-PIO hard-IRQ fastpath), and finally
+	 * cancel_work_sync() to drain the workqueue gives us that
+	 * serialisation regardless of whether the hardware finished. A
+	 * genuine hardware timeout still ends up as -ETIMEDOUT further
+	 * down, but only after ISR and workqueue activity are quiesced.
+	 *
+	 * cancel_work_sync() cancels a pending worker without executing
+	 * it and waits for a currently running one to finish; the
+	 * recovery_in_progress guard checked inside tegra_qspi_isr()
+	 * under tqspi->lock is atomic with its queue_work() and small-PIO
+	 * fastpath dispatch decisions, so no new bottom-half work is
+	 * enqueued once we publish the flag.
+	 *
+	 * tegra_qspi_mask_clear_irq() is idempotent: its read-modify-write
+	 * of QSPI_INTR_MASK and W1C of QSPI_TRANS_STATUS / FIFO error
+	 * status all tolerate a double-write, so it is safe whether or
+	 * not the ISR has already run for this transfer.
 	 */
+	spin_lock_irqsave(&tqspi->lock, flags);
+	WRITE_ONCE(tqspi->recovery_in_progress, true);
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+
+	tegra_qspi_mask_clear_irq(tqspi);
+	synchronize_irq(tqspi->irq);
+	cancel_work_sync(&tqspi->irq_work);
+
+	if (try_wait_for_completion(&tqspi->xfer_completion)) {
+		retval = 0;
+		goto out;
+	}
+
+	/*
+	 * Re-check the cache after the drain: the worker we just drained
+	 * may have published a completion status the entry snapshot did
+	 * not observe (for example the ISR fired on another CPU after we
+	 * loaded the cache but before we masked).
+	 */
+	refreshed = smp_load_acquire(&tqspi->trans_status);
+	if (refreshed)
+		status = refreshed;
+
+	if (!(status & QSPI_RDY)) {
+		retval = -ETIMEDOUT;
+		goto out;
+	}
+
+	/*
+	 * If the ISR never ran (lost IRQ path) publish the FIFO error
+	 * snapshot we captured before mask_clear_irq() so the manual
+	 * handler downstream has fresh error state rather than stale
+	 * fields from a previous chunk's ISR.
+	 */
+	if (lost_irq_snapshot) {
+		WRITE_ONCE(tqspi->status_reg, lost_fifo_status);
+		WRITE_ONCE(tqspi->tx_status, lost_tx_status);
+		WRITE_ONCE(tqspi->rx_status, lost_rx_status);
+	}
+
+	/*
+	 * The bottom half did not signal full completion. Either the work
+	 * ran and advanced the transfer by one chunk (possibly arming the
+	 * next chunk of a multi-chunk transfer), or it was cancelled
+	 * before it could run, or the current chunk really did not
+	 * complete. Only fake completion when the current chunk is the
+	 * last chunk of the transfer; otherwise the DMA engine may still
+	 * be moving the next chunk into memory, and returning 0 here would
+	 * let seq_xfer clear curr_xfer and finalise the message while the
+	 * hardware is still writing.
+	 *
+	 * The last-chunk arithmetic mirrors tegra_qspi_start_cpu_based_
+	 * transfer(), which uses cur_pos + curr_dma_words * bytes_per_word
+	 * >= t->len to set is_last_pio_chunk before arming the IRQ.
+	 */
+	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
+	if (!t) {
+		/* CPU-path handler already cleared curr_xfer */
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		retval = 0;
+		goto out;
+	}
+	is_last_chunk = (tqspi->cur_pos +
+			 tqspi->curr_dma_words * tqspi->bytes_per_word) >= t->len;
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+
+	if (!is_last_chunk) {
+		retval = -ETIMEDOUT;
+		goto out;
+	}
+
 	dev_warn_ratelimited(tqspi->dev,
 			     "QSPI interrupt timeout, but transfer complete\n");
 
-	/* Clear the transfer status */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
-
-	/* Manually trigger completion handler */
-	if (!tqspi->is_curr_dma_xfer)
+	if (!READ_ONCE(tqspi->is_curr_dma_xfer))
 		ret = handle_cpu_based_xfer(tqspi);
 	else
 		ret = handle_dma_based_xfer(tqspi);
 
-	return (ret == IRQ_HANDLED) ? 0 : -EIO;
+	retval = (ret == IRQ_HANDLED) ? 0 : -EIO;
+
+out:
+	/*
+	 * The drained bottom half may have unmasked the controller IRQ
+	 * to arm the next chunk of a multi-chunk transfer. Re-mask and
+	 * synchronize before clearing recovery_in_progress so that no
+	 * lingering ISR can queue fresh work behind the caller's back
+	 * (the caller's dma_stop() + device_reset() + curr_xfer clear
+	 * runs immediately after we return on the error path).
+	 */
+	tegra_qspi_mask_clear_irq(tqspi);
+	synchronize_irq(tqspi->irq);
+	WRITE_ONCE(tqspi->recovery_in_progress, false);
+	return retval;
 }
 
 static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
@@ -1613,9 +1815,12 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 	spin_lock_irqsave(&tqspi->lock, flags);
 
 	/*
-	 * The timeout path can clear curr_xfer between the ISR queuing
-	 * this work and the worker actually running, so re-check under
-	 * the lock and bail if there is nothing to do.
+	 * tegra_qspi_handle_timeout() sets recovery_in_progress under
+	 * tqspi->lock and then calls cancel_work_sync(), so any running
+	 * worker is drained and tegra_qspi_isr() cannot enqueue a new
+	 * one while recovery runs. The curr_xfer NULL check catches the
+	 * case where the timeout path already tore the transfer down
+	 * before this work got a chance to run.
 	 */
 	if (!tqspi->curr_xfer) {
 		spin_unlock_irqrestore(&tqspi->lock, flags);
@@ -1657,6 +1862,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status_reg, trans_status;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1664,21 +1870,53 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	}
 
 	spin_lock(&tqspi->lock);
-	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
-	tegra_qspi_mask_clear_irq(tqspi);
+	status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	trans_status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 
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
 
-	spin_unlock(&tqspi->lock);
+	WRITE_ONCE(tqspi->status_reg, status_reg);
+	/*
+	 * Publish trans_status with release semantics before we clear
+	 * the hardware status in tegra_qspi_mask_clear_irq() below. That
+	 * ordering matters for the lock-free cache read in
+	 * tegra_qspi_handle_timeout(): if the timeout path sees the
+	 * released trans_status it also observes the matching status_reg
+	 * / tx_status / rx_status; if it does not yet see the released
+	 * value it falls back to a live QSPI_TRANS_STATUS read, and that
+	 * live read still returns QSPI_RDY because we have not cleared
+	 * the register yet. Reversing this order would open a window
+	 * where the cache is still zero but the hardware bit has already
+	 * been cleared, making the fallback report a false timeout.
+	 */
+	smp_store_release(&tqspi->trans_status, trans_status);
+
+	tegra_qspi_mask_clear_irq(tqspi);
+
+	/*
+	 * If tegra_qspi_handle_timeout() is draining the bottom half,
+	 * skip queueing new work. The flag is set under tqspi->lock and
+	 * queue_work() below happens while we still hold the lock, so
+	 * the guard is atomic with the queue decision. Any ISR that had
+	 * already passed this check is drained by the synchronize_irq()
+	 * call that tegra_qspi_handle_timeout() issues after publishing
+	 * the flag.
+	 */
+	if (READ_ONCE(tqspi->recovery_in_progress)) {
+		spin_unlock(&tqspi->lock);
+		return IRQ_HANDLED;
+	}
 
 	queue_work(tqspi->wq, &tqspi->irq_work);
 
+	spin_unlock(&tqspi->lock);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

