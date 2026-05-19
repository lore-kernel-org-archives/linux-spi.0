Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99D408009;
	Tue, 19 May 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205903; cv=fail; b=RsiuP8zBaAYlj7cYX+DLFvAlJuKNwE55f/md33CfXBlSOBbnJCTUJJw6LT5v9SIapqyBYoj1+7QxC8Ktk2F1RVu+pwdOEMwQCk3JIUfDndhgzHmR0QsUlzu9RRLgXaEazFX0DXcrYH5yXkfINmqaGGi6W2ndxJErMNxITLk94Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205903; c=relaxed/simple;
	bh=da0vNYfz79XmpLf4+v5qPTO4q7ljvw8+/XFpbjz2sSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUzha4AqqhHttapRNgP24c2PptYqdjF8lhdzjvx74kS5uCVxsUQlLKel9aSyqIvT4j+EFUhI2tTMqgJ/FbIkq6RS7/JlIpYMAzaB5Ag/rEfKv2/htQsKvu/JYkaOmbqRFHE4zywswNkOlz+dOF9jmCyMypaXgTM67MI+4HPHCEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e4Ajheg1; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e4Ajheg1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEwuqt27hRmnPKLEJonML8Qp/f4XF8J0C4iSXYuN2tckZL5wKUgLLxFoyXdp1HHAkEjaKncRDDK0FRQNynu9Hn6StgJnnG/xFDtnbFHdIagO2YFQ12xCMaCymwzSYqjB1AZ/N2Ov+wXNpDLwhQ9Dzu8txUh/PeJF5uRSgARICiQvyWvteVAOG4de+Uh2mAsTrxXXI85Yw0vBPye0Cu6iltCpCuh0xKb/wiN+KHHgbimlXVkySUCKw83B1vTnOiTfJrOpvCdSnzHxYXgj2llUawjR96Y17VKm2Mbh1lRL7+EXnO8huZxFSaEAeW+/qdlwybNDfopQu5+ARSx3hndLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rNsr6EVEjGsIpV74U3qRiMgmUE12ur/uOsJExB40Pw=;
 b=M4yMDES3LkblcDHP5k7KG0nGnKQesBnTYDtKV4XDQTYq5cD17KGoj++t5a14sJA7KDwXd7nau9NWMlEJzdje31C9WzhF2TDPGCxduqsLfka0gXZIKHB7meOqatQRqeecv/4tIHRszLGK2APCrfT3X1qjSIASh8FV1Urk0G/DB4QfENev3FUQ3YrBCPKb1gsAPwNxrTmuWYf10oypJLGGFeeltWooSFmWb8n0tGK3bn1ESX8YqgFZsFf4Oj4BZF4GS0O+kUs41B55cK1cUCo/zz+mioSx4VZUC61NHMnYaFm8j3evfUV0yeb9vjDUy0GNP+/0MgeaG7oF4SRdcOSbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rNsr6EVEjGsIpV74U3qRiMgmUE12ur/uOsJExB40Pw=;
 b=e4Ajheg1Jm1yqsRLdbMqzcLth5RPIdtowPBaU6OCJecUvZmngSPA8q2JCbTQtQhGyCqXbsreyfp6ZhAp43oBnhoeSFk8uP7t4SIvac9XgzUQ+z5mSlJKdoY3i+SgVHgTQOhImrmlvrDbuWiAkmI8rE0C+CE2BwdQfzXd24RPbscqwSfVbqB7PP+GHaeNxePL9PbRgMrLYtFJ/bfY15NRz0omsAt8sS2sDKPngSHATOKC4tSAn4RN41FIdwce1O/IC30faj7toQJUK3aUNOeO9GPJKyCtser9ZBilN4exAftLzAQniGmn3j33QTqS/HXok7+4MabISAZqqvyBFMz7OQ==
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 15:51:34 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::24) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 15:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:51:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:10 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 19 May 2026 08:51:09 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Tue, 19 May 2026 15:51:06 +0000
Message-ID: <20260519155108.4092518-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519155108.4092518-1-va@nvidia.com>
References: <20260519155108.4092518-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c1c436-334e-4d96-4c74-08deb5be80dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|11063799006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IloVBXo1XUtcvCzdiOh9nXKqZWghz6CMru4hrUgMf0CmzKmK9S/1IzEYyNYJJ6mfj4nSch7QW4/AWxDByLo80/ocNNTZm8im32z2SQDQR86BeTyYLts2dHTOZH15PvYEo4T3LUoil1izIsxkhQqNmSMOMfeaWeA1UMGXhAsQ9egSbZ2AQdTW6bwNT3l8AkeIQZNHhV31gZBQLAkWz6bvWfi1W5OldzcgSjhwTLt9QiYPqRfmtabH/idKdme+PZq2I/58qXeYx6YrhGraFmtIfweznollyUc+YuEIfnpudNYYobM+eq9ebIC8/uoaAc/wxRk0QPVuN3YBjcg3EQ6lZ6JQzJJF4SizuTzOANG3CZccJju1R2RkiFGqRaoJauq1uSYDmD8+Sc1d3WzfhrrUlT6SQlekj/c/R04aEXsjdt427fWgcFIjaXxFxkCoskw+YwbZ28IUNzuTxofBslza6GxEhRxUGWjsMhbeZMFK1ULJ3utDO5+tidQY1kWy7E0Cz+zs+zA1BJ2WJLGQhkNiibonUyk/5KsZx0SAlelpJGBdXB75GZKAGou2Xyyhzb6Q/L/DRcWusAX7pI0CV+MBnUV18V/VEXRT3buKNfblpXZJMY496SPnWesdeTQKFNSqi6rtLM+UInBgONCCIhkNeZUiYRYzOKNnOuKkTw5WQAj08Wb4+REKwJ0FTjBHQSpgOg46jJFYYzQuB9mr4UxboEEalvSda/5YBt4fl/M19Vk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F+aKnZj1wB8fKSMK500Iru0emKT8HhXFwHxTgpy+eKHhz8W642yL6/3T8Lz6kYCnB/bER32ZJ5QX3mUsc+h/+jozKsGndse/VlB5KGvRMjnqRWXEFaBwWVufbSaXDB4efv4z9OlXoIx9ta6Ez9hPJCtDlUM1pcvXx2S/XWRsHOc3jgfHibqdpXE5KvESz2IdwwbCqhOWjA32iDqG8Ec4QZai5Iv+E1LiwbOhUWYgZ5w37WRvOCvv/z+l6np17l6r58fksRZY8irRhxQeYpJfLh55ZvAbE65BTgDvI2BbfVcyHqfo18vjYjg6ZnfaeSdMp7ZbuUW5bvZ0TDoBpNRaBEu/vU7JJtYJedCzMbjHv3XSs4tKwDlBiOM91FmpfNUnYICkU+fQ6LpV3GAyrxFDwawboGwf+jFE4GnWpHRl3GSxtA9yssmcStLAV+yH+5xY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:51:34.2237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c1c436-334e-4d96-4c74-08deb5be80dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

Threaded IRQ handlers suffer from scheduler latency on heavily loaded
systems, causing false transfer timeouts. Convert to hard IRQ handler
that schedules work on a high-priority unbound workqueue.

The hard IRQ handler verifies the interrupt, caches FIFO status,
clears and masks interrupts, then schedules bottom-half processing.
The workqueue handler runs in process context (can sleep for DMA)
and can execute on any CPU, avoiding CPU0 bottlenecks.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 128 +++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index db28dd556484..17d0b511af1d 100644
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
@@ -1225,9 +1227,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
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
@@ -1344,8 +1346,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
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
+
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
 
-	return handle_dma_based_xfer(tqspi);
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
@@ -1793,9 +1826,19 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-	ret = request_threaded_irq(tqspi->irq, NULL,
-				   tegra_qspi_isr_thread, IRQF_ONESHOT,
-				   dev_name(&pdev->dev), tqspi);
+	tqspi->wq = devm_alloc_workqueue(&pdev->dev, "%s",
+					 WQ_HIGHPRI | WQ_UNBOUND, 0,
+					 dev_name(&pdev->dev));
+	if (!tqspi->wq) {
+		dev_err(&pdev->dev, "failed to allocate workqueue\n");
+		ret = -ENOMEM;
+		goto exit_pm_disable;
+	}
+
+	INIT_WORK(&tqspi->irq_work, tegra_qspi_work_handler);
+
+	ret = devm_request_irq(&pdev->dev, tqspi->irq, tegra_qspi_isr,
+			       IRQF_SHARED, dev_name(&pdev->dev), tqspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
 		goto exit_pm_disable;
@@ -1804,13 +1847,11 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register host: %d\n", ret);
-		goto exit_free_irq;
+		goto exit_pm_disable;
 	}
 
 	return 0;
 
-exit_free_irq:
-	free_irq(qspi_irq, tqspi);
 exit_pm_disable:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
@@ -1824,7 +1865,6 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 
 	spi_unregister_controller(host);
-	free_irq(tqspi->irq, tqspi);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
-- 
2.17.1

