Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C044DB73;
	Wed, 27 May 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904608; cv=fail; b=fENjIV5YT5zxX2hvEdU0ad2uYBhU7pPW8q/D+GF6OpfsYblm551S1G2HGN6A4ufuimzPa99BOL6HNnKYaBj7oeDZqhV+N6qGy2TDSH+chCL3YEuDMnxKJ63yTG67ofW1/NCa6ZH6LbiMeX6mKAhllR9bgT4sltzV26UPZabISBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904608; c=relaxed/simple;
	bh=x5026VJYgpv32C/t5gUEsKQrghWdVeWp7249LN35+S4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkCuhMjnkq6FaQ3di6tME4xbST1YxTAzzXxaX+m8BcKdmdcsl2N4QEU5xrxkVimo34oODYj+orHRzIpcpxt84PbewI4ZpqjZAcPLn+WBFd2Q5zZzUbtSurP/4EQE5fVhPg52Av9pN5BAxx2iNzRQ49B6KD+7ujGPqg1tWfparQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YHMSzrvj; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YHMSzrvj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVbB4bejmItFDLWWy07WyBzRu3E+LdO0AqnhNBgF0rQ0XoDrZEX2oFd1Ctwn/GM10bjomaj2SiOJChyRV05UKHxvRBWhc4JhRBZd1KDtzJojbfPLwnlfy5dWKzH/6n/n9uWe9QjqvEnHpSdhEofzFLsqGrCSGqtBnHIrB3xGNAZctSMaT985774Dd0GgTVFzFEKcV+odhg6sa1Fn0qS3bEOJ9RqvLBUnQy5mGDAC9KL9Atw0Gt69fNOJdHgmxwANL3QVV0pAFZzG3CIGwvyjelu55SMMSIsNu3p85vjcbvTiNFZufRlznUdrRLfTuJ8R2BchzL/UOiXQ603Z5V6bPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrgkYh+OQSJzz9OR8rqEleiqnFNmI2RXfBwBj88HpJw=;
 b=HDjJyfxc5pN2bnFsgpLaZaHDzawWa9cVDI1UnOEtHTwwNtyqmI+1WEPoQtQSWKeNLqWnWYqJ1G8ca86KIaa3McR9IFHYD+f1Jh5ziG24ZefQk29pdnfkPWJHBM6mgNUMyiutuW1eY6azBw7BMGeYbHHgwziEkGmSRA4h5i0R1QVZ4vyfBWCErWJy0lBtHxGVckb27/LCUmFY8aUT3xfMH86qTBtTA8y2F7oVooQ0rG+kwTrQ4Z0uvNHwGx/VN57rRgYkTF0J2TVlrq65jCBz2qHOfRxRieAHxdnE70fBHwKH7fevmPJRMd0HB9l8YJqknpXC5hUCReMSI+zk4F6VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrgkYh+OQSJzz9OR8rqEleiqnFNmI2RXfBwBj88HpJw=;
 b=YHMSzrvjvLbHcwNa3puv61i/4CVJPTm/zQl19LYiG6RNjSp1TrCUqZLDU2Wq272Mjp9E/pwsnEZwZyaNpbAazsP60q9tYx0+v6H3XC6a7gcMQDjuN7jyDbJUnnmYQCnpOpdXm6Og7stk4D8+tmfYw6iF5vmpa4LIYPSWWEBWl5I=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:56:42 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::7f) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:56:40 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:30 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:56:30 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpm4052476;
	Wed, 27 May 2026 12:56:25 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 10/13] spi: cadence-quadspi: enable PHY for direct reads and indirect writes
Date: Wed, 27 May 2026 23:25:24 +0530
Message-ID: <20260527175527.2247679-11-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527175527.2247679-1-s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CH3PR10MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: bf001038-49b8-48ec-b137-08debc194e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|22082099003|18002099003|921020|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	y0QpqGk/r/aA51GcrZptqEx60XI2jHEGV+nuKZt9OhGcgUYXjoc34pyzmo0Gqb5UGRwDyIESCnHpT747AhLxFAF0UqQFri+VANBp+Oue8yGz1VOZEbkqL8WwaCzGX6cGWc+Uroq27HvtKlSfdK9eTF7HH4wHI29eEvhuFRhUE2f3gKYcU34cVOyCAcE9pul22HlLxZq9YXPjddkUCDFoAdn8OQqBpbn4rkShVf4BVw2BAFE1mdVsqSIczs/+14HL3YI6WJWKvqu4BOSz8DB9ltqt9dHl0kPypKP7f242+nAZ4cO++VfOhNUA5AejiyDf/qIC9G4w9WWOC9lj9WhE+rJjP6NRYYmQcrlZ/jzyn7Mio+WV3Z4pn1wbVXC39hVGQjymB26bMy3M/OY/1JryvMrkocD5z1M8nj1FYp8jCP00iMc2oX8Gt8jdEXT/inFub+/o+qcJlTpFAX9Tz6XOO4v71Tr49oyM4KmV0kFjcDcIK6Rkm75Vs0kZ3T0YFux213ultbv1CV/C2NOwBzkWp7J4c9xSheyaIWbnNUmQcD4BSbHROKnToeThAb3hGtk4H2t+xVsjzf5zgMjsDdIvdRJhlfd6m/PMorqoDd8rFjhuZgqqQsDTxgoK/HT9V5sYSQgyq1vJkrdAxksgqz3pDK6BhY/Nc7sYFFQCurq9rRaFV9pxyqKce21auXZT3MpnzJMY8h0wBD5XghRI43UHKp83rKHBdVr1JBuiL7TOKAZlRM+JA6osDfMArLBlMSSV0X/7T8MLj9FCUobAZqhftA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(921020)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	he/kCc78j0DvR9lVpYWNZTXH1JYDLgl+n1Zgbq2oIlEYVNriDWiIfMJ823SMSx6U4yo67XIP1b5LNoI0PdnOsN6eYLclY3kQxqvw0uADTqfhFW6N5CzefsOAFjuK7Y034JfbgKdmZohkBLBAXllsTVH3zb5TlYuggNg7dI4pN/g/xHzxRQy053/1ZEJe24Yf3/twD7o6WhrYdZ/b2jaxCRu8EZnYpbv3wG0mFMpo9XVdvz5DFmI1lc80VLlbHtnroPI41rySS1D7P3e8/fuNvrD1FZcyPwF1xcTPaYWsZOvtGKWfohrcnV0Oy7SXeu4MA2M1WumxuUdqA2htD6XbuD8GZ3eImOFAzM0ayp+TBO6SnynsukRVyscbutZg2UETARDrEdBZfvFvImfbxpbI/bKX9UDOVgzMgJbP9iFOX96FIG5A83g8E4T1A4xf9Ug4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:56:40.6478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf001038-49b8-48ec-b137-08debc194e58
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460

After PHY tuning completes, data transfers still use the default
read-capture path. The PHY pipeline must be activated around each
eligible transfer to benefit from the calibrated delay settings.

Add cqspi_phy_enable() to toggle PHY mode. Enabling sets the calibrated
read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
dummy cycle count by one since the PHY pipeline absorbs that latency.
Disabling reverses all three. Returns cqspi_wait_idle() so callers can
abort if the controller stalls on enable; disable is best-effort.

Split cqspi_direct_read_execute() so PHY-eligible reads run DMA over the
16-byte-aligned middle section with PHY active, while unaligned head and
tail bytes are transferred without PHY. PHY is used when use_phy is set,
the transfer exceeds 16 bytes, and the frequency matches the tuned rate.
cqspi_memcpy_fromio() handles small and non-DMA-able transfers, with
special handling for 8D-8D-8D to ensure 2-byte-aligned I/O accesses.

For indirect writes, PHY is enabled for transfers of at least 1 KB
where the setup overhead is amortized.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 181 ++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72208d376305..80e7c572ab80 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -564,6 +564,61 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
+static int cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+
+	if (enable) {
+		cqspi_readdata_capture(cqspi, true, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1191,6 +1246,7 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
+	bool use_phy_write;
 	int ret;
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1226,6 +1282,15 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
 
+	/* Use PHY only for large writes where setup overhead is amortized */
+	use_phy_write = n_tx >= SZ_1K && f_pdata->use_phy;
+
+	if (use_phy_write) {
+		ret = cqspi_phy_enable(f_pdata, true);
+		if (ret)
+			goto failwr;
+	}
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1266,6 +1331,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 		goto failwr;
 	}
 
+	if (use_phy_write)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1277,6 +1345,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	return 0;
 
 failwr:
+	if (use_phy_write)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1448,8 +1519,15 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
+			  const struct spi_mem_op *op)
+{
+	return f_pdata->use_phy && op->data.nbytes > 16 &&
+	       op->max_freq == f_pdata->max_clk_rate;
+}
+
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1461,19 +1539,14 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
 		dev_err(dev, "dma mapping failed\n");
 		return -ENOMEM;
 	}
-	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
-				       len, flags);
+	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, len,
+				       flags);
 	if (!tx) {
 		dev_err(dev, "device_prep_dma_memcpy error\n");
 		ret = -EIO;
@@ -1507,6 +1580,94 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/* Use 4-byte reads for aligned bulk (no readq for 32-bit) */
+		if (count >= 4) {
+			size_t len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			*(u16 *)to = __raw_readw(from);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
+	size_t len = op->data.nbytes;
+	size_t len_aligned;
+	u_char *buf = op->data.buf.in;
+	int ret;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) || len <= 16) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	if (!cqspi_use_phy(f_pdata, op))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/* Split into unaligned head, aligned middle, unaligned tail */
+	from_aligned = ALIGN(from, 16);
+	to_aligned = ALIGN_DOWN(from + len, 16);
+	len_aligned = to_aligned - from_aligned;
+
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		ret = cqspi_phy_enable(f_pdata, true);
+		if (ret)
+			return ret;
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_phy_enable(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
@@ -1524,7 +1685,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
-- 
2.34.1

