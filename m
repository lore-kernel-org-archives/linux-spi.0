Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFF14A60F;
	Mon,  1 Jun 2026 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303230; cv=fail; b=vElFpS21lpe7tVw3ARWYZimQVIcJKFLJ03D6qYVHjQY0Sitvfj8cGsq8RBwEj2yAKG6XscWtd3KKl3HU/0Q0L3CBROxby53iCpyID/rmWtFl7x/xHmioxd4f9VdRienDnoJCkx5Ej4RBF5fF8U3ydweMEFyxSopOPj3WnWWPws8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303230; c=relaxed/simple;
	bh=CubGhGq3URSd5o5ydXbVTUjc39buMZ7bnwnx84WG4T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y78Eg/eWho/yvKlgnlZwuYsZqHtF6eerQrICzISdHL9t/htt50mH1dgeplkoDzdFjljZ5WUiyYrRuqcnmhW2T/S8VOMH7o8Kq8IV6Jrd5O/9rlxPVIkY1UeAVES0C7Aun+a2bF4uZY0rZQ0ca9lV1XNA9YJvwZFE4HSKHzwjMQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=spH29k8V; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="spH29k8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orctQkXAHNJr1B6SeqGdaHt27mfFNrTZX2Bhv1bHozYiXpjAiiDCQWa8Rzrgpme1zvlFHZ4BkTaXK6ZGgO+9XJP+KNUndCeZE4/9Z9E329UHPcW0yY/WRbKwX6v6XmB00TuaSBae4EH7E1kGrzWgBaeYghaEBRmyxTPZe79dIemeuLmB57jqvOFieVU8Sei7WzbBc2jZFiWFrUTSH0AJyL2VPnH5iUckVhQ/SxQkUHeRoScXQFdpT1j9xocHetQegMoImaAYtoG609A3sTiwxUSpQbTFiz4CCGSXbxh6yLTHEIdUGxn3JEe35knmpuUV+ODjVZWengCZ1GPYmTWC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy+I3eAZ11agTmKD5M+F6/8uiqNEUh0bJnDLXMET9uQ=;
 b=iwZ3GBTsZT1Eu2t6ZY66T9x4voSNi4RIRsrUiS5nDJ8DXAawFY+g/EHCbgi9uVzmCm6eP3x3R4i3wCgNHJokQTch89yrXCXLBYBEH1tb/w1W4Xiq0UYWfIvfe2KOeqsip/Faf3rH1rN1U2orPT6Uwy4KeXklp7RK6mIY4UE6zWnPjp5CWkgkwHomyLhYaGm1Orv5kUcJ2qlruN6ZNScNYabX2fjqZTLAGtRXZOVzQpFFHThfshQCBm/fj5Rtnpi4Pol7g2NVCkPhccKJM21TbNXqC1vmUzmOJ+882VV+ndUc0DI/G9c084ukBXoXv0FenSIC3wyu2YDlC8MyaVFsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy+I3eAZ11agTmKD5M+F6/8uiqNEUh0bJnDLXMET9uQ=;
 b=spH29k8Vd0ehv+ZeAPTASCTw26JG0xJ5PndirR/D9t+DQBs8OO0ZCSh14NgVWX6Z7ZOcqdLVFtyQ9aTZy4Kxm3oRe3fzuu3GS0aWEu7dYqYPl05XPDbl5dll2DWWjLUrY1wpFB+fckd1awpxCZIXFhr5cAB5VkJbDPRgxHNubFc=
Received: from CH3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::13)
 by BLAPR10MB4964.namprd10.prod.outlook.com (2603:10b6:208:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:40:23 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::52) by CH3P220CA0002.outlook.office365.com
 (2603:10b6:610:1e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 08:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 08:40:21 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:40:03 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:40:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 03:40:03 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6518dwid641399;
	Mon, 1 Jun 2026 03:39:59 -0500
Message-ID: <e2a354fe-ef25-401a-b8a9-4d51ad12f429@ti.com>
Date: Mon, 1 Jun 2026 14:09:58 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] spi: cadence-quadspi: enable PHY for direct
 reads and indirect writes
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-11-s-k6@ti.com> <87se7bgasn.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87se7bgasn.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BLAPR10MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dfa93f-9d5d-41e0-aacb-08debfb96b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	SgfIoDfG/Ex17JXUoLIdd8gwcLqIHHAwxqyDQR0AgWVydTxZMJ2seIpMGqSPbnBXv39Decmi6RCWUZec2/tn7k90o40RwoVndDi8sFzFwgksOE+GUMi2L/JjpXsv4MS3uxQQ41THm/UgRAeelkbhDorD9mt9Ak2NOIghbP78Jcpa32txXn6ztJj5AH8xH1V6QTEQogIKsJW/Ar/hsQlPm1iafmYaSTPwvHEqcQRlLB5Ky+Au5HYYBdH/g+DjIWldklOPTtU9vmLJXsWEyWV4UoAN3UNUcaliMWokMEddow/vk8r4T5JNM5ZS/2l5ZISevBhjhDVR1FHzSt/hWlMqnnLWxSLPXi15urDlmROTaryPWZJl1NWoJecQusCcRl2AKRCXdteEv/X24zJnlQxFFhMmG9gEVT7LVN1U6KW+3uF2gW8wR95dCOUU0NGFBDGSX68jD4yjz+BJE+KGPQJQT29LNALo5XCfayudDMYluLW8VUbugs8f43XhO/UPigCiELB9QcVlGHvlmg/o7MBrKXMPiAqPM7/wLJ9tv16WCuK6/kXztV6sc7IXi1lzwLYZHXuxaUkz8P5Av3uaLb4pn4lV6uNsXgsgL/uMoSJabKOWk1sMl7Dm17mHmlPc2U9rQro7+ZxBoIjK4PeRiWH7KQz6abaS7M3KlcFcIVe4q0+UHUu6mbtupHLhu/pVK4BhPRTdCvg0spcFJrxr1GJdEb4tJxJxwLFP5macVc2As+I=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	45NxWKjXXQ3oSuRPsgfC6EdPZqertFECJvnL4s4ky6VUXLQaFI9XOFZ+us34/qfcB95mRbrHd+wuyT/1CjI46E4K4rJzDlnN5a7wrUeDY+60HKhX0OGpVe0SxN4A0kgSwV65isXNAEIqalcaDmP/bbDG6HjUC9rBM5ZfAamK8/16tXg7tuCYe1+QHbP+VU5YlqaakPTywTOKSFSxOZNPwuSYSc+TF1Kc21tb7TAk87/yDRC8zfK/93zd39oHgGll7TsiARcFUuewzRbx8iP3BoHQlOjSj6lj4iC3Gvv7QCXZaQO3bW40TtYZO8ZjDj7yEsWy7YkP7QCIA3OCCKQRz8+xwLcSK+O5FSHx/+CchaPFeiK/vqPXWl9EHE/4qcXLOy//1uMzVkCb8cbktT0j+gCtgUN9kw9Qn7D9BhRvZktSPFaX91UwnOlvbxkeOV4J
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:40:21.7687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dfa93f-9d5d-41e0-aacb-08debfb96b02
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964



On 28/05/26 14:39, Miquel Raynal wrote:
> On 27/05/2026 at 23:25:24 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> After PHY tuning completes, data transfers still use the default
>> read-capture path. The PHY pipeline must be activated around each
>> eligible transfer to benefit from the calibrated delay settings.
>>
>> Add cqspi_phy_enable() to toggle PHY mode. Enabling sets the calibrated
>> read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
>> dummy cycle count by one since the PHY pipeline absorbs that latency.
>> Disabling reverses all three. Returns cqspi_wait_idle() so callers can
>> abort if the controller stalls on enable; disable is best-effort.
>>
>> Split cqspi_direct_read_execute() so PHY-eligible reads run DMA over the
>> 16-byte-aligned middle section with PHY active, while unaligned head and
>> tail bytes are transferred without PHY. PHY is used when use_phy is set,
>> the transfer exceeds 16 bytes, and the frequency matches the tuned rate.
>> cqspi_memcpy_fromio() handles small and non-DMA-able transfers, with
>> special handling for 8D-8D-8D to ensure 2-byte-aligned I/O accesses.
>>
>> For indirect writes, PHY is enabled for transfers of at least 1 KB
> 
> kiB :-)
> 
>> where the setup overhead is amortized.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 181 ++++++++++++++++++++++++++++--
>>   1 file changed, 171 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 72208d376305..80e7c572ab80 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -564,6 +564,61 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
>>   	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
>>   }
>>   
>> +static int cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool
>> enable)
> 
> I'm fine with the logic, just the naming is very "TI" specific here. Can
> we name the helper "cqspi_tune_phy(f_pdata, enable)"?
> 
> [...]
> 
>>   static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
>>   {
>>   	void __iomem *reg_base = cqspi->iobase;
>> @@ -1191,6 +1246,7 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>>   	void __iomem *reg_base = cqspi->iobase;
>>   	unsigned int remaining = n_tx;
>>   	unsigned int write_bytes;
>> +	bool use_phy_write;
>>   	int ret;
>>   
>>   	if (!refcount_read(&cqspi->refcount))
>> @@ -1226,6 +1282,15 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>>   	if (cqspi->apb_ahb_hazard)
>>   		readl(reg_base + CQSPI_REG_INDIRECTWR);
>>   
>> +	/* Use PHY only for large writes where setup overhead is amortized */
>> +	use_phy_write = n_tx >= SZ_1K && f_pdata->use_phy;
> 
> Maybe also "f_pdata->use_tuned_phy?

Yeah, I'll rename them in v4.

> 
>> +	if (use_phy_write) {
>> +		ret = cqspi_phy_enable(f_pdata, true);
>> +		if (ret)
>> +			goto failwr;
>> +	}
>> +
>>   	while (remaining > 0) {
>>   		size_t write_words, mod_bytes;
>>   
>> @@ -1266,6 +1331,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>>   		goto failwr;
>>   	}
>>   
>> +	if (use_phy_write)
>> +		cqspi_phy_enable(f_pdata, false);
>> +
>>   	/* Disable interrupt. */
>>   	writel(0, reg_base + CQSPI_REG_IRQMASK);
>>   
>> @@ -1277,6 +1345,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
>>   	return 0;
>>   
>>   failwr:
>> +	if (use_phy_write)
>> +		cqspi_phy_enable(f_pdata, false);
>> +
>>   	/* Disable interrupt. */
>>   	writel(0, reg_base + CQSPI_REG_IRQMASK);
>>   
>> @@ -1448,8 +1519,15 @@ static void cqspi_rx_dma_callback(void *param)
>>   	complete(&cqspi->rx_dma_complete);
>>   }
>>   
>> -static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>> -				     u_char *buf, loff_t from, size_t len)
>> +static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
>> +			  const struct spi_mem_op *op)
>> +{
>> +	return f_pdata->use_phy && op->data.nbytes > 16 &&
> 
> Why is the check looking for 16 here, and 1kiB above?

Direct reads have very little per-op overhead, so enabling PHY is
beneficial even for relatively small transfers. (> 16)

Indirect writes, on the other hand, incur significantly higher setup
cost, resulting in much larger break point. (> 1kiB)

> 
>> +	       op->max_freq == f_pdata->max_clk_rate;
>> +}
>> +
>> +static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
>> +				 loff_t from, size_t len)
>>   {
>>   	struct cqspi_st *cqspi = f_pdata->cqspi;
>>   	struct device *dev = &cqspi->pdev->dev;
>> @@ -1461,19 +1539,14 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>   	dma_addr_t dma_dst;
>>   	struct device *ddev;
>>   
>> -	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>> -		memcpy_fromio(buf, cqspi->ahb_base + from, len);
>> -		return 0;
>> -	}
> 
> This (and changes below) don't seem to be directly related to the PHY
> addition, could we have those changes done in a separated patch, before
> introducing PHY tuning use?
> 
>> -
>>   	ddev = cqspi->rx_chan->device->dev;
>>   	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
>>   	if (dma_mapping_error(ddev, dma_dst)) {
>>   		dev_err(dev, "dma mapping failed\n");
>>   		return -ENOMEM;
>>   	}
>> -	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
>> -				       len, flags);
>> +	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, len,
>> +				       flags);
> 
> Not related to the change, isn't it?

Yeah, not related I'll leave this untouched. However, the changes above
and below are related and belong together in the same patch.

> 
>>   	if (!tx) {
>>   		dev_err(dev, "device_prep_dma_memcpy error\n");
>>   		ret = -EIO;
>> @@ -1507,6 +1580,94 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>>   	return ret;
>>   }
>>   
> 
> [...]
> 
>>   static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>>   			  const struct spi_mem_op *op)
>>   {
>> @@ -1524,7 +1685,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
>>   
>>   	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
>>   	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
>> -		return cqspi_direct_read_execute(f_pdata, buf, from, len);
>> +		return cqspi_direct_read_execute(f_pdata, op);
> 
> This change could also be done in a different commit.
> 

Thanks,
Santhosh.

>>   
>>   	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
>>   	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
> 
> Thanks,
> Miquèl

