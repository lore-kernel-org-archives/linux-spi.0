Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CF48C8C9;
	Mon, 18 May 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120516; cv=fail; b=MQBaiDKhZcEMoP2Zb0lNQqTvA9bdtYBv2kNM6plb5QN01rxW8BLNEUKxwNEni9rzIykCuXbYIqToQ7tRSmRwMix/LdkKpdrov3IXeb3Rh3J+SFSIkSzPnw+EXewz02gSiH/fQimweUIFnWKXDikpFtPenRZwlGSVxzo3jofg42Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120516; c=relaxed/simple;
	bh=uuzrd8Y1N07TzvC/LG25bZdT3USbIVCLmKIDYQntzEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dg9AeZqSq85nI57JAsorUpYAudhWJ3vi7r/eLjT/6/FDHeMm9ZQLydgz29Lyg+a73dCNWn4YazxNFwrt1t6rKgebYL/a2NBrSeMp+Y/OpvSS4N1LLZ2Z//MFvurPOTVafAxaKl0KVkqsnKNsTernJRzGd3I3XYrfjwgfs0E0tu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQV+dUVl; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQV+dUVl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amwQ9OLEDMoZwnZ3Y6c80x3RLE6pRUwfG2GEnlv7L0Wak35LyCDD7l85wCGZOW+Uw2u2SSKA19c6BBQux69T0cdJYD6UQ0xlMJa5ILC/VbEeTorahbvuUwghLqt96iFRcB+TQSvYEwrc0m/zOXx9ESRtQC1YjRHBbfRoTGbKl+qpi2DE5P2cirtu9hIPew9KnjEWIEpe1Pupicku63KBglE0LeMJ5Yn7jFOx4AhE5UIJ/zsW5PhNwPdE6qgqW5TUTHB3yqvrh3X4QUV+GKg70MVX0IqmZApLuEV9/Vbugij58I3GRE0oAPX7zFVo2IiwACkEvRsKIh55RqHjudKUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1GOplAAyjU1xX3l2e2qiVYWF+b8F6T6UI2UpzEv+ZY=;
 b=nby5UNQsnzt+PkKr7jACEEd0FcZhoFseLTy0mCMVNnqux2yJDhevXWeWmIIIo+HEEgbQZSJ5ZvHL1FSRtUwbVhkI/HR6bMu2DFxFui8wKxS/f8LHjc8rfZgkJwDc1zGHh36KzT0ep4LV9fQvZlIiL6OO5pZQd8VhAM/+2sLUwaGmucOPKT2OAWeeRCLZFHsVrngNOEgwZshRXqDKGz1+agkf1d28v88PTLKqNi2/5RSiJ4Ztm1R6O31CnNtCfe6Srz0Tnk/BsXZ833SJqWwuHtmLK1mZw1GYWOKeYT3dygQ+ye29riCFlly/TPVxxgNeBTMiLl6hI9O4UKkaUsP4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1GOplAAyjU1xX3l2e2qiVYWF+b8F6T6UI2UpzEv+ZY=;
 b=mQV+dUVl1dd3qaawKHxeb/2w2GpzhekJlCCM9IqGyW3QQ4A7PGbuw0O+CtrvVKHtz6lQoHjCG8Sxfirj2uxAU+83djyt0D15LT1i5hoTXi/At5VOOCub/nqsK7gJdZm2orAKvALNiniMlMIwmXqNZp2yhtNCQAOjvHvsuwHs0QZAtKRyAhcPTwJ39PhGM9jegsnZoGKyjqCn+68r8A6CJs+DoMKelTMAFTCvd1zTELxMVn1GC8JmLdPUCJ+7vXuaWSN2CXqhDDLs0wrwCHpiWLSIWCuIRmGhWJdYAmY69kNyvk8dDnRClepql4SpUVI0FtCoB0c1Xv4hOyntm0yrwA==
Received: from BYAPR08CA0066.namprd08.prod.outlook.com (2603:10b6:a03:117::43)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:08:10 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::3b) by BYAPR08CA0066.outlook.office365.com
 (2603:10b6:a03:117::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 16:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:08:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:40 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 18 May 2026 09:07:40 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Mon, 18 May 2026 16:07:37 +0000
Message-ID: <20260518160739.3286438-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260518160739.3286438-1-va@nvidia.com>
References: <20260518160739.3286438-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d2a202-85de-4b5d-8f06-08deb4f7a86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VrcYTe/qRriXggPZ97E159a8xkzgR/7Bmfk+lmeHO9zwM5SkRqdwNzRJYQDoGkFiJ90rAz7MGxHjMHiVbKWm5kyiDarkMjVtiZI6wu6TCJQMWLODFHpchHIBRVlXkiJF8ht6/yW6iMLk5zjrGa0h9L9hyzlr0Fu1Kuwa8H7SXiDrKX7u+I8xNSFGV3QK34D9SSn8FBtA5ORqsWPIXEbgtVDDzcFSaIm0vgGToRhEQu4nLmrytiwsr0ztZmFf6LfEC5LaFoJzt+fK9pslNa5WfefgTicb0xOq9EUN57SxGzR8V42YfWV5EPSYnfgl0G5HEz+2OXqn928EjHLaWEg8dhtdl7jjSACrRZAj2tmoZoSZwOeik2aphDxLgNrfDDalOT1Vg2Zht1cz4jhzaPWW+DBvvRFKpvRILualAMBgRfD+Brfw7JX0XBpDFu4qp13NvX1d78nRGab4J86Lxhn+coIHB6nxjVHL+tm+TSswsqVUKHodczDAtIZVbHN+4l5dGAdIyo2YCygMaco9Tbmlkt0hGbPAP/sPCc0jCHi1uLlp+s9C8BXLdH5U5f7XUAYctk5ikG/hRu92S32epPW+Dwtv2r8lrcYCG2nqkGeK6kgUWzzCRWclrujHSIhmrlJmjAAWK2MP0/xTqU9erWNyeEHGwQKp0e8+o/D27WghRVF5/Qk9qOZjdWHkEMcj/P+y+L4EC+IkQ4PqHcsVW9tgis138yCckv8raCRZ6S4LG2s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eh2apMHRC/61/YYCTwUSGJyRLy2jEIaHNumzru7eg72fkwHLNoSeUIfYdw0GnZt+BA6qGd72NsLZMxhkDU5PMxNMlrrvJ0t8FfaGjldqaM41xwaTj5yfb3ZUgR6lQhh1xrA5pS14/EskYMe0hN/ogT6oU4ZBZxWbujZZqN+X4MSiAvuzwgf0D3lkTqPSkYYHQHSDH0x71hMmdiBxRPpdL+OYSvcagVWqul7kNTNuYYCm+ZwAQAgvDJkqnLarf6xM68QPWQiOQVPukLWuQKMfJyM17Of2g5KKPw2ZEisUwVDmr7OmY3f1eChAUXDHYSnwfrjlN2GiKF3pyhqUKwqpMYp3UNndy8zEnqpwQzHTVfKLE5VE/348vylrh0urqqhKfZlqox+mI+84ZrNfqkFm6gmNvI9Z40edJ9A5TbEn1Ga6AynNvhCjbJbtGZlFso/q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:08:10.7568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d2a202-85de-4b5d-8f06-08deb4f7a86f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156

Threaded IRQ handlers suffer from scheduler latency on heavily loaded
systems, causing false transfer timeouts. Convert to hard IRQ handler
that schedules work on a high-priority unbound workqueue.

The hard IRQ handler verifies the interrupt, caches FIFO status,
clears and masks interrupts, then schedules bottom-half processing.
The workqueue handler runs in process context (can sleep for DMA)
and can execute on any CPU, avoiding CPU0 bottlenecks.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 120 ++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index db28dd556484..a551c7a7f6c4 100644
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
 
-	return handle_dma_based_xfer(tqspi);
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
+
+	queue_work(tqspi->wq, &tqspi->irq_work);
+
+	return IRQ_HANDLED;
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
@@ -1793,12 +1826,21 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
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
+	ret = request_irq(tqspi->irq, tegra_qspi_isr, IRQF_SHARED,
+			  dev_name(&pdev->dev), tqspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
-		goto exit_pm_disable;
+		goto exit_destroy_wq;
 	}
 
 	ret = spi_register_controller(host);
@@ -1810,7 +1852,9 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq:
-	free_irq(qspi_irq, tqspi);
+	free_irq(tqspi->irq, tqspi);
+exit_destroy_wq:
+	destroy_workqueue(tqspi->wq);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1825,6 +1869,8 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(host);
 	free_irq(tqspi->irq, tqspi);
+	flush_workqueue(tqspi->wq);
+	destroy_workqueue(tqspi->wq);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
-- 
2.17.1

