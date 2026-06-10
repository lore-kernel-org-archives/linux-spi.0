Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A95328B7F;
	Wed, 10 Jun 2026 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072660; cv=fail; b=GsGN+rrN7XZskp8AvkbxefadXy8vuK+LSdRGiJp/twHA/yp2Hro2hMYwyyync1cNPYPZGe7eQGxMgwSKpWkx8inG01k8f4T8Vh/I/6dgHWAvgdmZQjxnnyZmYGpK6pC2aeK/tdYBW77lzk5YbDCOjX45oyUORjPITLogQkSwtpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072660; c=relaxed/simple;
	bh=SOPNXjthCX7HN5U/EgWF99k/ORmL0MrFi/ePcfCJq2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kx7qSlv65zqahOS8nvYmblN52X6MCCEmcWxsTxFVE8LY3cSldcheybZr/TU/k4WFqFF4C9oxWdbCQuynOJnyxEEFbZh6fk+cmQG9zn/7wg6T+bha5wZDX/zyNAjN/V91BuhWTu26vrHXqBwp8wULYKwqZhwOYmK1oDVbB5lPm9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROnexxV1; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROnexxV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkw3hU06zGtoWF2+179ao7EcrhaG1qqx/YMVJnUtlGOUzTc0eHsCis+yGYDKSg9xsijDkncRHMgem95M3irSPFlmjC0jpgv+oXAahLMIGmaV6xifB143/spsQAUFM+CHuXSgeEGRwGyU4NqATt20TyGGdroj8duYc8h1LkRa1u7k5ALaKVvNHPkf1rnwjF9rBTWBNfWFSCAMYeeCuQZPJE/HJ9GC4QdyC99u89bIhvpM0EJQ0z4sLpupge1GbwQgwaaFo70PbI3E4X/WLpVhdNzxRHI8L01SPFYi1gDdO9vtdwu2tup5WFu0Ck6MeVn46vEu6swJAorI9kc4/Bzb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQOatmHvDnwR5FrKWcsiW5hxWu9SR2dqatwspB6pwJE=;
 b=X62fPvWo/Qp/qH/wjNkPiBUjLqhTzV1tg8ZCECurVh1YhClyntGtQ4BxxV0jwvvtd6o1xTerXsJgxzW+OcwpvtRqRYPUJq0HJMeAtCA13k441pS5gk8A+Y+ZkJTg3fVUq49hoQmy7KO6RFSxJYkVEYDjgNrEACrQ2Ax+Jv7Egohls+cKiGYhZXN65n8d1pPTu9sbitVn8tXpIWa/w1P55Dl5XpohAFSVJJ11PXJyT4OasAVNRexFVTyRX2P8dBAXhG/lqddk5EgFXUUJ2eLQ+cLASW4fZZcHdrBDvi2GrIgB6eaWMdHkhLuEm7Oz52twJY+oJQR3/ZZncSVuK6hZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQOatmHvDnwR5FrKWcsiW5hxWu9SR2dqatwspB6pwJE=;
 b=ROnexxV1hGLutMua7KpzqfmhmedbvFyMRtWtVoepai462dT90O4XU+AQzWTps98zMZKjt4LYvB0CDAeyk2L9MWz5RpQslJVENVcNI/Jocp2exxYrrskl8HlzbXqw8d84yRiVN7pPc87oQnI8a/vOgh7qwYvPUPxmw7GzO63j581fYu+MTHktpLSGSLh50C9x1AKDZFT26D7CALowy4SPsFVCjmjRnkqMzWN3z4NOI2JxqpoOq9EUyU8xcmvfAVLGT9f/XoO4RzUiA7oVcmJJG4/T/Jy3JqDEYlar6bplE72+b+81plKFVq/31uznb5HabnA0oSW9EVcu8jgSs9UBzw==
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 10 Jun
 2026 06:24:14 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::19) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:24:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v4 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Wed, 10 Jun 2026 06:24:01 +0000
Message-ID: <2ed90a7d175f7967e621943b772115da655c477d.1781037385.git.va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 489df881-de8b-4c18-1b6d-08dec6b8e476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GNxaCUXLutTiPY7J+6dcMXTlDEWdK+DgsWuN/VMox5MtJ+VQP5ogSupAPfe0KolMYYAfMx19Tc+xEO7EjdwxMGojRUHyhIOS7pcq19G7+58CiyiypZaqp7WwVDRK51TkaSximquZMktrHmlQlHsKH6CljJZ8Utpy6zC/TC84YFTp2mLNIm1LxZmyvm9GCd9sylgDVjDvZs4o/7NeLJji5LsDAYDDBS7RvXEOLsTw5ka6rrOs6yaEZI8il3nNB2phIfdnVmtH3N53QvobI2+FUlTQTKPT/Au/GQtp+265XhScAKU8tdzRaU7VAqJCAXRqh7WTuXL8DNN6cZAfpb4tfttIHCcqPcM3Egxacjoe6IB61vgkM4tpdDwETUJmRkKxoG9jXOXC5bsK2q+ZZ+mVfPRWu9l8GtJR+6ynBUp5IMuUsiGJWkYCs5hKS5f+FVZx2I4HrW3TbhaFso456WaQp3BwX3mVZWHL3/0jjXCB7+oorhqHKFOsarrGLyNpSBmH0yrnlygZso7GquyFgHjflUI+Xl7aecO02SW9mOf0rceeZYML4cn0kaPsngSe7T5VNN/KMpqLeYEpszNOCzNp7iH4ehy4kChwg1VHxrozDvmi4DlW7ruDM5BEglp9HBySP9K4dXgBgB4XqhGj/TEPp6vGC7vbwtGjwGpGK7Gujyr+N4ZodnHi+c0LIDcJ45kg50UhD5kxu4ucJgBRPqAE7aS7areihU2vsHVCTmefIKk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WzkbJAU4C/2OKNK3tgUAtsjeLdL1VBSy4Uv4Stui/D/uoZUYuEqcq+SmFxzp1xFraZfiVyjGyzCwDQRZetZMzkmqEWepvYtT9kqbGob1lle+QBrP5c3G8MUDgOzy0AeX/jUi38cq0A1sjP68KVTkRihxlii0m2uFj0Y6AnoHlcwPFWalZ4BFwmbynfuRq4IG4HTWHNZk7aoK4w8ZP7eaJyPSIOyHoO8rPyMtU8wrPBR94+0Wt2cdb/0qtrBVBj5dBoiCtfnFVg0o/CM5etDxwRmb5IkDY7W6PlUsz0vKppux4UjPAKQY3bGpmcZnNtAfY4UVuv90KWnZuKXBxzao6LUldNNVB0a2kyQAu1hR9wSgtxrH2y1PrTdLZwdvphSMYO+2aToXQjF0uxS7S0HxaEAdGshctYFaYQ7HZo4teFjgJvSaoajrlz/h1OEvP2Fy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:24:14.0531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 489df881-de8b-4c18-1b6d-08dec6b8e476
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

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
 drivers/spi/spi-tegra210-quad.c | 65 ++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index dd5d40e0dcbc..f0b15d13e433 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -861,6 +862,13 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
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
@@ -1075,26 +1083,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
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
 
+	spin_lock_irqsave(&tqspi->lock, flags);
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * ISR or workqueue may have already completed the transfer
+	 * and cleared curr_xfer between the completion timeout and now.
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
@@ -1658,6 +1683,7 @@ static void tegra_qspi_work_handler(struct work_struct *work)
 static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status_reg, trans_status;
 
 	if (!READ_ONCE(tqspi->curr_xfer)) {
 		tegra_qspi_mask_clear_irq(tqspi);
@@ -1665,16 +1691,27 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
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

