Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2448BD4E;
	Mon, 18 May 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120520; cv=fail; b=P3dD+aDBegaFBAsMz8RiXjinBCnWMGbJPDHNVofMk6CHZDADWYK1EjW85LJKsoK8prUrpGS+YOUF84u2bf4gBHrYlQhZx6wtZb9Hb2tFbZFq4EmNVEn9TsT+tN04AW+vO4oTdHRThTRdJ+55quObbwI3iJ1y7YwMf7rYx2UM8xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120520; c=relaxed/simple;
	bh=ofJguFgrAg90YzPzsUhaRx22Rm6aPJE6JmXXOipA8Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe2kmogoivWCqjvOFWAZekG5i7M3z9+T/lo8P2RuLJZOzZvl/HMW02Vk2BAgX35RT8KTcRIlbNUkNq4EpD7Zj/4AyAlmDPq1GjCrKMYhEH7AJzXf7R8NiLVXJ/M76vc6pA4Kg+h6Ywp0FJ7LMrtLUs4hU4a6kZpkg6bgH7BDqK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=STu95g/W; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="STu95g/W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mogI4BofeK5VWURoDIfw2j04Y06hPveco3X7vQbW91POTAl7vmwO3Sb4s/EwUyii5QHSTJrhWz/cfM6EAA+vSeH1UyY6+3CYWuSp/tDTBdVZ+CYVOKU+Q1B1im+AYn8xXGaRBzKTkUjTyi+9gKYyk64MnPE37nH1qoBhdC6znEklSMkP0klwTi1tja7g8qOHHhUCFKzmvsxzbxgMAqObZLxQbalXs+D/cmIFW/k58hCs3GBRRghDFV9gO53a21ujSLxPfWzOvo8aMjv+k86T2NYEuioOr62qkRIk17GFcsspQirMu8MrcZ7o01MOg/tcJJr5m+FwCFg3O7sThonLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iABmhJOTwZsUs2yUNYTs4GPN2Jz6FD6w13zuDqlxEEk=;
 b=dP2y2tis1AGqiL2XtKAEyx+l2VNiBK07uwb4sbw2HG7kYkMK5G/YKe5uB9CeOayGFouw2SfVhEcGNKgHtrkGYQxy0rpkA5tqtOnBVs3+9HGwC2FCzbNsunbUEwesmRJaHYIHMoeDtQQAyk0WwaZi9EugsfMpgHodwdrzV+1hHbHeLMlZM9HR6bXWWEdoOOjvadx6KgaxI4Gfcyo9l4Vl8vz56ruYguyOIU/0+Af0BDE28dF7FeWdknlqzG5/zeir7v+l8/JtH/eY/KGUCSzBddYwXstVychl0tLXa06Nsv/J0OfS9fi+SaPgz4aooeNKW5/+rRw2cuRvlOl0bdORJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iABmhJOTwZsUs2yUNYTs4GPN2Jz6FD6w13zuDqlxEEk=;
 b=STu95g/WPYwGSHyeqCmabyKt9euu2xJUttQiZuca0JvdjZYFkfajIYRjipL+PSLxvyBvopSiLxbUpE/Sd6URqbe/yPGatgArq2id4pqloKArEx5Z+jeZdxtOzran2Swd5v8XxsTYYQfb8Cr3ZD4zjf0qzizhx2UnUX2NaWf85yCwCWL/Ach61Ap1SPxmx5iE5sYbTzcFinofl/xMyA9xLSvB36VrAOd7LN1hyMLXrnAdJ9fCxXGsCPJ7atvPXZpDGk4bOgKT9ObKxEs6AfkU662JyCAPDu5CV7QyXlMjT7Tx1/7wI+t6hN57+gR5SmDDTw6NYzkE4ev64ROnB6ElLQ==
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 16:08:11 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a6) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 16:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 16:08:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 09:07:41 -0700
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
Subject: [PATCH 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Mon, 18 May 2026 16:07:38 +0000
Message-ID: <20260518160739.3286438-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 662bdc37-3042-4ea7-a920-08deb4f7a8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FnqB/j5vWpF4VeOAa82AqnHzdWOsf5ZqStg0zveV3ncVHVveBSGLH+aI/x8ZerYF6LGZv3GzFDR/PVtV6+oEq28pDq3nixHQzxSdLtgyXJbUjAXlrG+yB1sdZBnuq+ojM0wvEBZdigAsJw+XfHIqsQVuDyPwP1EgpCyiZNkehImuez5xqtquAEJw/2RsCqOXd4CfNWeHw4wc3R6DSY6cfT6BGWSGiFvGwBGgF5fMBN0DD4yCWLYl9gHkb5gH91Z9n3p8D6lqZ3HxOeC8IN1wvmX40h76kt8ZakPR2ssglvFAaIFMnPH/2xaP+G9yKfZ2L1i44+Z8TQSTSbi1LAqldrHRyGGKWOB3iSM7ci19F1AcbO/vU9E5QrfX+zKgKn39RTEVjofzBMf7MHbfXxN+Nfzzn5t0bdobsqB29SOuSc/QVJvEVBmBq8/WCXxm/7+IsjYXsLDupj2KQpDgk3fitQOUG16VRBejy+fw3mYKdeW2LWbBybaWW+v+fg9h8oZhInmMtCraJu4RCPXebuTn0KPEcClGN3akjsokmq7fs6+pz9zTMl107AQFcf2MZi+prnarSTKoIb5UZ5CczUYffB7Unj6wN87YwEiYsIxZEYBKhQFPekMuV9b/Uft/O643iZ2evPsXXPuH+z1uXahYZIbJNSzAW5nsQ40yq0dHvslf/1iJsq3DW765PSoGrjEUvcyEet+dx1fmMDvrsmKm0jLPkx4R21T9J2sZxWu1tec=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zf04ilzK+2L/PEb+ucaO/ijxEkBaU4yfeOxcOnMoEeO5E2gfnQUNNAxCPrQpW5R5eI14lI1xmFCh4blnO+T9xG+dG8R1xQZKnZwldXVucjBlVD1OHWzULVTQF8++DdJijT0MNSi5oc8N2O5L6aYaYmn59FU9YTMxejL77O61J9YkDIex34MkhP/6ADUSpmaUZCoZcx+I7cCMQEsX8tuBEbpEPbrygz5zyQN43Fm5s6yMIbqgHgkuBXlEUoe8EZkicYGR7yYk5CW0L3lDAastFnPQcjYn1BIHTHkWqP3uWOoCtLMjZcy1KS/xMNdjfgxeHiCdBg4T7ebpjlh28hJkeCfyR3vTU0EDZPeEQVZRDFwdfwm3KsdEbB9yjQr/e16a7yfvciuSvaTAy2QuCVgTKYaYD5F4fe977KFzlNm6SXorL6wMdXLCnSpjoGi4NV5a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:08:11.4918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662bdc37-3042-4ea7-a920-08deb4f7a8df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

On heavily loaded systems, workqueue scheduling delays can exceed the
transfer timeout even though hardware completes the transfer in
microseconds. The timeout handler cannot distinguish between a real
hardware timeout and a delayed workqueue, causing false timeout errors.

Cache QSPI_TRANS_STATUS in the ISR before clearing it, allowing the
timeout handler to check if hardware completed (QSPI_RDY set) versus
a real timeout (QSPI_RDY not set). This prevents false timeout errors
when the hardware completes but the workqueue is delayed.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 42 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a551c7a7f6c4..6148267a51cd 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -854,6 +855,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	tqspi->cur_rx_pos = 0;
 	tqspi->cur_tx_pos = 0;
 	tqspi->curr_xfer = t;
+	tqspi->trans_status = 0;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	if (is_first_of_msg) {
@@ -1068,26 +1070,32 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
  */
 static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 {
+	unsigned long flags;
 	irqreturn_t ret;
-	u32 status;
+	u32 trans_status;
 
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	if (!(status & QSPI_RDY))
+	spin_lock_irqsave(&tqspi->lock, flags);
+
+	trans_status = tqspi->trans_status;
+	if (!(trans_status & QSPI_RDY)) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 		return -ETIMEDOUT;
+	}
 
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * ISR or workqueue may have already completed the transfer
+	 * and NULLed curr_xfer between the completion timeout and now.
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
@@ -1227,9 +1235,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
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
@@ -1346,8 +1354,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1642,6 +1650,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	if (!(status & QSPI_RDY))
 		return IRQ_NONE;
 
+	tqspi->trans_status = status;
+
 	spin_lock(&tqspi->lock);
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 	tegra_qspi_mask_clear_irq(tqspi);
-- 
2.17.1

