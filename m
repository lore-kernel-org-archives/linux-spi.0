Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795670482;
	b=NbyqVnw6xXEgPfkZamDK5AJ2OoafPjCjUP4+x2tSBAn9hVMrVvzPekwrzD8mr60u50FK
	 ZWr3tUXzomg9PXejDX2tRwv3yoR8DSceJIGZJqH+Y+q6eWywopMug65HlSs3eWlZqTdtB
	 WbsyPgbyTp0+97I5wFh1+YpfZ0sh5CMGRlZa7l5LyJu64/nyOL4KEsxU75f4Fu5k0hja9
	 x9qzPHOZrTtAhBYKBV+tTye0XkX9fkCfblTPZ02RESf/A1W5R6X9r0zXCUEOf70Uyl2g+
	 2iSWTUWiqUnZ8WlecUChtEGzlYE2dkYw89zlZOdhtLNFp4xFlu3MfVCKqUQtHnudmPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670482;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=O3awedQSpkzGGUAKphlMI3AmFGc20ERawC7tMGMPZUc=;
	b=ouNmddC6ZEbPhDk19CnaaASO1lg8WeaBH3RTTMMe/LPbWHD3R2Dx23fQNXwvQuiC62w9
	 GDXPmEllRTdp6p6D0o0bocZO5SSaI36l2O/uSNi8OIJP3RnINCeGH4pX5dCslxSLYQp6O
	 PyxdhBHCM4RbfgaOM1oaHLJbOubPs+64heutDYupzklqvgauvTPu3UdXKPv+ul2c1pdzw
	 nbkPjOS+2oPzbTrB0L+S5xxfj1vpnx6+T8+WcrV1SfFXnWzdQET1nZMu6QzQyCScq6Pjk
	 ke5o18SR2DiHXQC07BdvsDYE618WhJnFQDCn+4AEQqCFYVN/eXj3s4NwWxcC9tYuN4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ayIC6fsG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.30
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18338606A31E
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 05:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18338606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ayIC6fsG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biCdkLKxAY/hZcOe3xJn17tk8xthqPVmnCfmCLiwtaGmQ/WHZoBEhNGMhrxzYGQ0i/Y7A4QFaDANoNcbA2gYwg5XCwExg8+jv46/Q5xcnwycBDNkpppsdni6szBSPGNxWfDJqWfzlgv7kjtp+x6UviIeEOFh03MOslp8AoLuKE8EA/CtGu98JRoJR8Kq1RQ90RJbS7W3bAKziBiV58JE3OVUDW5Ble60lr+kENGR5FVhqcaMtB+lyziRhLD8FZNwDDU4ryTxFxAuLd9TrijB6NUvBCsvJIAS9xyIHvcGXE+6vJ+z5lzuTIFkW9CvjuukM6CZckP7tp0uBKlZN5BGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3awedQSpkzGGUAKphlMI3AmFGc20ERawC7tMGMPZUc=;
 b=VUGrwOIC+D4VaGqlJLWvmZ6Kv70dKmTwPOS2XkUiL5VWzLSrm47LFAOxTcDfqG3unSVx6PxPjr5BM3X5ik+tQxpDNs0T8mvr8+X4ALe+cWEBSWN6xVxzHQAIZ1G5nnZEq630rpnDG+wzEWj2eSYL9ftOByuMkpkD49pshPk42hADEpn/XxoG1+TVCqKJnxc52c7d33pehh+BODz4K1zTIyhYW3KhZokN8YuegMzPzyaavrmjO47m5Tu20vRkInUoNa07pj41S7eN0RT+sGzNqC75Jqb+5ccoMNrmhNZphBWqktP8CeDpgBu3Xm7PT4tJifhCzbph0Png7OOwO2N60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3awedQSpkzGGUAKphlMI3AmFGc20ERawC7tMGMPZUc=;
 b=ayIC6fsG0dtyZtsT97wGVRhXB6Ort8VxvM+vMbnu+cbNpURdbnRuW9AFS7ZWGyHaI6aNvF48y8e3fUoJd37PXG7mWWNlZb8UU/NmwtRSoGtQAIqcCcpx5RAboORDMB8oKAWr+1W9GMJb3RLpjbJ1OEPK9+xsIbpVgxiYxTUAetg=
Received: from PH8PR05CA0013.namprd05.prod.outlook.com (2603:10b6:510:2cc::13)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 05:21:18 +0000
Received: from PH5PEPF0000002B.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::4c) by PH8PR05CA0013.outlook.office365.com
 (2603:10b6:510:2cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Thu, 26
 Nov 2026 05:21:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002B.mail.protection.outlook.com (10.167.243.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 05:21:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 23:21:01 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 23:21:00 -0600
Received: from xhdlc220225.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 23:20:58 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Thu, 26 Nov 2026 10:50:36 +0530
Subject: [PATCH] spi: cadence-quadspi: Stop controller on shutdown
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261126-ospi_shutdown_v1-v1-1-5aa6e65d76d7@amd.com>
X-B4-Tracking: v=1; b=H4sIAKPBB2sC/yXMTQ5AMBBA4avIrDUxlTTiKiJCDcailY6/RNxds
 fwW710gFJgEyuSCQDsLexeBaQJ2at1Iivto0Jk2iNooLws3Mm1r7w/X7KhyYzS2RZcTWojZEmj
 g81tW9W/Zupns+n7gvh8t6o00dAAAAA==
X-Change-ID: 20261126-ospi_shutdown_v1-36621a8b3e1c
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <michal.simek@amd.com>, <git@amd.com>,
	Mohammad Zeeshan <zeeshan.mohammad2@amd.com>, Srikanth Boyapally
	<srikanth.boyapally@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795670458; l=3821;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=SOX2p7s5tsUuuhIi/AaegoqNw+a7wVtc0nKWGUT/sjc=;
 b=pIQppxwCkWN7PQWd4qgWDDK3VqGboYli0EfWteJghn/EdjUXrVMd3dnmPTPXlQO4bzu9rb1uG
 H9NXMSw2ybICkDll1OsSh46HDJ/cByaoU05PuKqmwsUREyJF93NwQ1H
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002B:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3492f6-8231-441f-9b33-08df4b7d19a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261009221227099003|261028144727099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	785rOFRGstbefNrDqZBFqPU6hHihLSDWdkixuupO80U4U8Ei0hWLssPlEzBnzOXMGqxMlucDt3JgxuSom7PdKAY/o4WFHNbPxwYhy+1SbSdthpF5cznMGSqnP5aHO2ODTJq2NbxLo0LiIpsj3sPurj8UrZa1FGo+HWrVmhaEuZFeZH9bgiNeOhWpBwZBFmcHlIqO92vUiapNQdXtuMpqf6ElwlhiKsqbzRSLH1Q4bupPL3uzWfBuiQZ4xlORL29ONDT8FEuxAXudxLRMTHdk5gB3Zp5jjS9zDAdEq2EHf5aqbayMaumf73H5wgDE4yD8F5h1vntOQx10A4cz56kz619U87n9oK4hzXd7dDzlF1YbsiM83lnaDFAsThzzjHdBEZErXb9qU5CCJyv10u2FoDwlrwwfg9139M1mOvycNldxE7E8zcRb4tW4wnQiEolnlLRVRnWpco/KtXVkbFmTW8XYaH/YhL9mVkDalFRembvkzQWBDnseyBPZJDm7If4SrAExkV/vpWrBpfRh/+MTVIPLnV4tQ4zyJl9I6HdaxzPXcYqWJx9z5Ejah4G1C5xp68G8fSFvl9/GZsWb9BcfXp0WnLRGgcMfwrOaaSheCELoNtA67SjnsbiEwIX8w8//XzROqeQ8Gsw7B6Qn60MiLF2JyshXpNzjoLkZkj4tbCw5ol8reHvbMf6bmBLA7LSc39fRPiouGZp/OT4HDFNM2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009221227099003)(261028144727099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NSqg97rFIlAhjfYmqrJ/EPsD8EiQVq/NwFNKVCTndEQE1BEpdBjliwnySi072ii/dF0E2pbKdje32UzJEh+zqclcaGqtUs8HHrMm9uKBn4XqKvgckH08mH5/YG0lFWkauLrYhnU+nls/S/CArH7ee37xWPx8Twd4KCmCioTFr4Q7D0joGrT0+IVBfPp4yNjmWJ/ftk2zgWWsY3UkicjTHlclxv+om+BEWbhwDlsdz2AOKktCfRktGsU8BDUWCVkSQWZYVG+bHFsTQAF9QCoy/9H2O3sUeUUZJOTFEOx5nV4eVkq9z3s9CmfT8lDCLMSzPoSottOVxf4JjexdDrkFqKqjaN2ZbC8oL0p7qXbeL4OEtHgMAhGTx0xFraHqeJsxNfRvL0CWJm3QFKR29EgCGnWHLhcCinWq2yUNGJs3Ke+7p0LWchzNobabsi3KhPWz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:21:18.2512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3492f6-8231-441f-9b33-08df4b7d19a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

From: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>

Stop the Cadence QSPI controller during an orderly reboot or kexec so
the next boot stage can take over the hardware.

Reject new SPI memory operations and suspend the SPI controller to
drain operations already holding the bus lock. If runtime PM has
already stopped the hardware, skip the register accesses.

Wait for the controller to go idle, mask interrupts, and disable the
IRQ line before clearing pending status and turning off the clocks.
Disabling the IRQ line waits for any running handler, which accesses
controller registers.

Signed-off-by: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
Stop the Cadence QSPI controller cleanly during reboot or kexec to
allow safe hardware handoff.
---
 drivers/spi/spi-cadence-quadspi.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 912470bdd10c..677b36294c52 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -91,6 +91,7 @@ struct cqspi_st {
 	void __iomem		*ahb_base;
 	resource_size_t		ahb_size;
 	struct completion	transfer_complete;
+	int			irq;
 
 	struct dma_chan		*rx_chan;
 	struct completion	rx_dma_complete;
@@ -1796,7 +1797,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	struct spi_controller *host;
 	struct resource *res_ahb;
 	struct cqspi_st *cqspi;
-	int ret, irq;
+	int ret;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
 	if (!host)
@@ -1864,8 +1865,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	init_completion(&cqspi->transfer_complete);
 
 	/* Obtain IRQ line. */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	cqspi->irq = platform_get_irq(pdev, 0);
+	if (cqspi->irq < 0)
 		return -ENXIO;
 
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
@@ -1950,7 +1951,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	refcount_set(&cqspi->refcount, 1);
 	refcount_set(&cqspi->inflight_ops, 1);
 
-	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
+	ret = devm_request_irq(dev, cqspi->irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
 		dev_err(dev, "Cannot request IRQ.\n");
@@ -2048,6 +2049,33 @@ static int cqspi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static void cqspi_shutdown(struct platform_device *pdev)
+{
+	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/* Block new SPI memory operations and drain any active operation. */
+	refcount_set(&cqspi->refcount, 0);
+	ret = spi_controller_suspend(cqspi->host);
+	if (ret)
+		dev_warn(dev, "failed to suspend SPI controller: %d\n", ret);
+
+	if (pm_runtime_suspended(dev))
+		return;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		dev_warn(dev, "controller did not go idle: %d\n", ret);
+
+	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
+	/* The interrupt handler accesses controller registers. */
+	disable_irq(cqspi->irq);
+	writel(CQSPI_IRQ_STATUS_MASK, cqspi->iobase + CQSPI_REG_IRQSTATUS);
+
+	cqspi_runtime_suspend(dev);
+}
+
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
@@ -2211,6 +2239,7 @@ MODULE_DEVICE_TABLE(of, cqspi_dt_ids);
 static struct platform_driver cqspi_platform_driver = {
 	.probe = cqspi_probe,
 	.remove = cqspi_remove,
+	.shutdown = cqspi_shutdown,
 	.driver = {
 		.name = CQSPI_NAME,
 		.pm = pm_ptr(&cqspi_dev_pm_ops),

---
base-commit: d8c1f1ad171d0e5844b6579054fa19ebf6cf7d17
change-id: 20261126-ospi_shutdown_v1-36621a8b3e1c

Best regards,
--  
Srikanth Boyapally <srikanth.boyapally@amd.com>

