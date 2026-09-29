Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C242CAFC;
	Tue, 29 Sep 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697314; cv=fail; b=hv5UvqZqKF4RlOwpX0rW3+7u63fbLdr/Z4PH94sVW7sVYckNJH3iVrqu1R9up1zXIYi0UrgInRYmSgVm2Yo0/10ZVg2KMUFTvwRvzkAZr9CAQ9a5KyqcxbruveY9nQMgHfwuS2ACDbkMio/JRefv5k5OpYVLCr/4dMf3yJfet00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697314; c=relaxed/simple;
	bh=aoaL8XXYvjfiqAxWA4u2V+btJZPaMB2IYytYepHOntA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0bR3DSFCD2vZO86mOHMGRo6uV1kvH1fvDHynuzdJc+a0FAVLSMBDyq6hZqV3Ftf1BKMQXe9OC6gYY/vY3htNZH/rIX5bUQTlgdwkqxE2+r4iCnZ/Q8H5sJSCewt0vZB2ttxLcBT/6KPhwLjY2Q1DiQE43ZPwPtGctvP3Sy2fm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r6qepQ+g; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r6qepQ+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exUX15PcSJ0CW2qat8hE8gEb7qBkwHHmpnaqaR86lfZ/22RS6vvn/Z0bokXQmlBm7JoDaFOox0CJUWOu/bouUqb4QMfKEumDV6W7+wHl8Eh6pJzvdBRZIE4y1YthLCkaen7h+Y1HrTgLKOEBsKRUv2WR9nQ59vZufnylMHDCR1jbj0gX0lNMwru7np0f22KrTkCu2nFYLc00JX3R0o/7azwHLAWd0KaEHGpxqkRUqUWACxB4ns0G726ik0csyb81vHSCMQVjb8Q9GfVE3mc+UjeJiUHY9LMJ9O/S36mfdyg7Z0yqoemTX713pfT3yVHoDoYQSBPBWfAjbrBNZlFXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZkbkMbiEON4hfscsQBvtB99PJa9iWumF68KMnUUDho=;
 b=qRADaslItfDv93OIH/v2CODkQTEy4iLDmKkWBRUYOyO9tAmYpJ2VNw1vn0BcoIYGlACtU/7pT0YF86vFaY8IV7KFaIQqd/b7uiDM9whOW6JZFD2W2bAWWnWp7mgCwD5winCD/6ZhcNxb/mEkuQMq4GX/iM9/yqCkyc2MvGR3L5W8knm6G527wdic+PyQ5s98KyO+MmL1G0qbcfaM1j1VVGthrJjDdBG+pWsco4Y4xlNyjnO+Nn5FZRr1p8xvbLrgqiL4L+LuGM1LFZjTq+jYqEbnMvI04ht4uUtyH/JX+qjqUBU4Fak1/060mdShmGa0/Ixbwc2ytGbXkW9N7zmAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZkbkMbiEON4hfscsQBvtB99PJa9iWumF68KMnUUDho=;
 b=r6qepQ+gIeSp3AiuxyJPlMAKb6jy7oOsXFtNpLi9dSTtY5+XN1XYTNhi7aVRPxmBsrxaJhYXihOF8aKy6Irnc5R0zOGBxzv8Z+5eY+DPIfrn1wpCkg3dWeXyR93EAZL8zQZBqh79/YAq5X9B+5FN9TWCqJk1porYRWsTrJhSAkQc2qvzANNQfxV/Ew1CtX5lk4EFfcV3PfM5ELZdGl3vJQph9ajmca5x55we0pXfUkVWriBc7/wXQPJpV9AfhYlnFvW/zYCrcoRPTs1jJNRS8Eibobm6iAUtwl8Km8yfCUIPgIAYIaqJR/YQBZvSBHtjZVSHtTEqTVMfU9bQmfmWhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 15:55:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 15:55:09 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:FREESCALE DSPI DRIVER)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 2/2] spi: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Tue, 29 Sep 2026 11:54:43 -0400
Message-ID: <20260929155445.3311133-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929155445.3311133-1-Frank.Li@oss.nxp.com>
References: <20260929155445.3311133-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 341457ed-fa48-4448-bda7-08df1e42099a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|921020|11063799006|10067099003|6133799003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	17AK7tBIiXfmgj1vz/0gjjdCyc5YtnwrNS21YiAt0wZYROovva7uQVe3b/Aw1NSyCrCd45Fwg52p0E8j+NUtL7wu/sNsc1rCcckyoLPVaFnCgbk8YtrSX1AE7bqams4eZ93EO/eSzO//5oMo7tSudK1RZlnoQJcuL2hQb1HWa9GF3lAaqDY3Ie0E5rbH/rjfXNJhN0wK81L0LQ+j2I0MW82HyKr1HGMYWRxciM7ZnIp99hmCXTVJtimPKVALenr1vm+Jdql0y8DtIBUb+YWJfkUmOraoQssUyExBKNK5bUP0NEJV6G1kODZR3CjnTGX04IG1lTlR7inn1axpJe9oiIDWTkSDcWN9GJPQ3KR3VHZmH93/hh55ktQqnnxY7fAIINkIZ2OyNbpmEZ0EzQCb1ta8dLa/ZZhvwQWr5cKIxLxjlQX5BP73r1169gGAjXYCG0PJH8njqpUm7ty8bRRkKPksoJNaOnv755Lag0Cnub8sW48fqeV20kL6Rsxvky2Omem+vWXnGeezvIuArijkpk0mJLA/JCk6CcOQxjIqyuPIcOZvPxWGlMuVs+YqNocXFxWJQrixEo5imsOyjQa8xXjyVLA4UC8VoxRo/mrYZBHxLrUSlk/78XpBkTJBGT/ExNjJeLLJ0vu9qdHron+7HiunvErhIrYQxrrqhdntzsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(921020)(11063799006)(10067099003)(6133799003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bYI6hw2ZNrfJZ9RIgaf4NEX6B1i/n7FommwG5C8GTbAFvPkxkrTAjIeCIjR?=
 =?us-ascii?Q?Q2ihKfG6cGNQKDjAbPK34ltRHxnfOf/uhYajcqLGmY+Tq6giCQ0Z1Ip2Cv6p?=
 =?us-ascii?Q?F01iNDx7CksmQMMjoG/LSQwS43JCXcp4FVwBVqRzJ1EUleDfz5uead6l43sJ?=
 =?us-ascii?Q?ke2kf6ZqyaJVu+Zs5FSReyppnXnTJINzRIFmHVp762r9zbkK673CGElDvfPk?=
 =?us-ascii?Q?CcdHGq/Dvsju1XxR8QqWmY6luEB5vvd6nDRjd5YjU5kFn8320+f4LshB0PYN?=
 =?us-ascii?Q?4wD068cxRCMWUp9CMBT/nUMcFJSNYKrHULTEarylKnkKc7DBqS9gztr68Sqw?=
 =?us-ascii?Q?K4aAORMeLr9lg/zi8c5AiF9oGUCvJebHGpvLWpeXALQFE1o2ehzYOwVxCNgS?=
 =?us-ascii?Q?/la+vfTnNv2FM686D1GeukS/66OBbSNhalNcwPrvw8oGQ7WhtraDN/z0LNcn?=
 =?us-ascii?Q?MeUkJD/tb8jFxcdb02sJE+66gjqy9w7NuaM74dcsznwfuggXR7b0mT5XQdBM?=
 =?us-ascii?Q?EzbvTVz+RPe2Wd5lNQu3cmy/BU0LUJpQf/VQ5vKOZTW209d78+e2Bw8I/GDc?=
 =?us-ascii?Q?PLdosk4WgwPLcNvluGYXnG1ylP6jgIYD7T3hCjGi5L478C2G0NkFEONPJKCT?=
 =?us-ascii?Q?7PpzX8Ehc4MoVAn31dGl2l4QyNy/bmdIJnhw+/fjWeIjPEQ1nIzXIkefKig0?=
 =?us-ascii?Q?fmK/JpFU1JahkJpdL87eZY47M8TuvEAYtyXwg4Ni6so8BzS/v9KvdNZhLCA0?=
 =?us-ascii?Q?WOzgQCMOGhF0m0Xan1f9K+pOdhp49g57ket+qkmPj4mQgiJESkrc03hnDQl3?=
 =?us-ascii?Q?MYO5cAPEVpT4EqWtz3owUnCE3bWK2/yvvrXFT4V3Y6TFNFPxlOXEGkTsac90?=
 =?us-ascii?Q?pGbM0wEHRbyiW7d6gk7V9JOk/hS2QTZHBQ40KZSdEGCdMqGTP6SdLzpmAOsT?=
 =?us-ascii?Q?Espe3Po9aFgaxHrvhDPu4eLOwGG4qAVkolLRUsAWFcu8iWVkl6h+GUsUKsud?=
 =?us-ascii?Q?kqFThMjC5Y9zrNHeY9D0DkAaDoWmLFSBVFwbNGQEhHBTy9XS/PLc9fJ7/HRR?=
 =?us-ascii?Q?V/YvfUgs/vD4j2rlHeyUQjthZ8zu1fWrMWeV9Rg+JoLBH1e2KHpiEAb3G/jA?=
 =?us-ascii?Q?eXW+t7ieA6KQPM4g0DYcyo6yMEXW2lKIxwaedjkY9g1f2v6ctR9jkJL5TUom?=
 =?us-ascii?Q?YrnGjnDdktIaGeJhtOyrR3ISijsmAqbK+fuw5NquSBYvFbJjIP+TLEsXTq6M?=
 =?us-ascii?Q?uxhtGp+xMJ7Dt8rcpp3/zr7X9zcK7K0Jmuz2JE6MgzGT68PxKbespzten6V0?=
 =?us-ascii?Q?WgT2NxSCqvPo3hLkV43o60y/OFQXHq3toQAqMGOUxih7WFgeFivaXc8z2wk5?=
 =?us-ascii?Q?9qNFr5drp4QN/EcPV+rLxYt9pRRskSKO2EX+eM0qrakrUCoYN5L4xRLg1sM8?=
 =?us-ascii?Q?KlFNVHWlHg6aIG00FTE07SGbJtEIbl1m2iXfF/MnGjB1fpwpoPU/7q/wg77+?=
 =?us-ascii?Q?bOHOeisnz74qunRggmbenz9VvL+lsInmXqZqDFwiaLp+i9LkCxRayBqilBe+?=
 =?us-ascii?Q?UBd+j/IvEGDtgo20+raaPv+Z9dXHRL6/eluomJfN2x18XckcFYfyI09A0UXr?=
 =?us-ascii?Q?xvFNTJkE7FzAr5mJ0lSH1ruA6Dl4+w+K0UhC8zTR/blW9M5CduX6JHzpb/Kc?=
 =?us-ascii?Q?ZavjTtl9Rw+euxiWhLZ1u4yUzU745/b6rMv3M2x9Pmt+i036yzdjD3xn+mpf?=
 =?us-ascii?Q?bg5LtBbR4o25vVf0xZOJYY4E+Afv3G1cJ3yVPmSmjV1p4MRF4J5A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341457ed-fa48-4448-bda7-08df1e42099a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:55:08.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDm7q+h6A+Q9gA6ESi2xBP09DgWQSFw9HWiO8W2H+sACyalMZY2TwM1DZ5+MNV87zgcvzOg1n1TZmQ01QWmpHxdASQaVNDV5beEqXVEhEjohNCdwEEU6/pUyQHlcE6VL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() for consumer API

chan->device->dev is not always the device used for DMA mapping. Some DMA
engines support per-channel IOMMU mappings, so different channels may use
different DMA devices. dmaengine_get_dma_device() returns the correct
device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Check all unders driver/spi/ by rename device to _device in dma_chan struct
with all yes config.

Still few left, one for copy_align access, which need new API. some filter
DMA channel, need new API to get provider devices.

In https://lore.kernel.org/imx/67966b47-22cb-4b07-80c7-2044f557dbcb@app.fastmail.com/
There are better idea to move map singe/sg into dma prep functions.

But it takes more times, not straightforward works. Let replace this firstly,

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-bcm2835.c         | 24 +++++++++++-----------
 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi-ep93xx.c          |  8 +++++---
 drivers/spi/spi-fsl-dspi.c        | 33 +++++++++++++++++--------------
 drivers/spi/spi-imx.c             | 10 +++++-----
 drivers/spi/spi-nxp-xspi.c        | 16 +++++++--------
 drivers/spi/spi-pl022.c           | 19 ++++++++++--------
 drivers/spi/spi-sh-msiof.c        | 12 +++++------
 8 files changed, 66 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8f8715809c7ce..5c270573bac16 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -527,7 +527,7 @@ static void bcm2835_spi_transfer_prologue(struct spi_controller *ctlr,
 						  | BCM2835_SPI_CS_CLEAR_TX
 						  | BCM2835_SPI_CS_DONE);
 
-		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
+		dma_sync_single_for_device(dmaengine_get_dma_device(ctlr->dma_rx),
 					   sg_dma_address(&tfr->rx_sg.sgl[0]),
 					   bs->rx_prologue, DMA_FROM_DEVICE);
 
@@ -871,7 +871,7 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 			dmaengine_desc_free(bs->fill_tx_desc);
 
 		if (bs->fill_tx_addr)
-			dma_unmap_page_attrs(ctlr->dma_tx->device->dev,
+			dma_unmap_page_attrs(dmaengine_get_dma_device(ctlr->dma_tx),
 					     bs->fill_tx_addr, sizeof(u32),
 					     DMA_TO_DEVICE,
 					     DMA_ATTR_SKIP_CPU_SYNC);
@@ -891,6 +891,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 			    struct bcm2835_spi *bs)
 {
 	struct dma_slave_config slave_config;
+	struct device *tx_dma_dev;
 	const __be32 *addr;
 	dma_addr_t dma_reg_base;
 	int ret;
@@ -932,11 +933,13 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	if (ret)
 		goto err_config;
 
-	bs->fill_tx_addr = dma_map_page_attrs(ctlr->dma_tx->device->dev,
+	tx_dma_dev = dmaengine_get_dma_device(ctlr->dma_tx);
+
+	bs->fill_tx_addr = dma_map_page_attrs(tx_dma_dev,
 					      ZERO_PAGE(0), 0, sizeof(u32),
 					      DMA_TO_DEVICE,
 					      DMA_ATTR_SKIP_CPU_SYNC);
-	if (dma_mapping_error(ctlr->dma_tx->device->dev, bs->fill_tx_addr)) {
+	if (dma_mapping_error(tx_dma_dev, bs->fill_tx_addr)) {
 		dev_err(dev, "cannot map zero page - not using DMA mode\n");
 		bs->fill_tx_addr = 0;
 		ret = -ENOMEM;
@@ -1157,7 +1160,7 @@ static void bcm2835_spi_cleanup(struct spi_device *spi)
 		dmaengine_desc_free(target->clear_rx_desc);
 
 	if (target->clear_rx_addr)
-		dma_unmap_single(ctlr->dma_rx->device->dev,
+		dma_unmap_single(dmaengine_get_dma_device(ctlr->dma_rx),
 				 target->clear_rx_addr,
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
@@ -1174,16 +1177,15 @@ static int bcm2835_spi_setup_dma(struct spi_controller *ctlr,
 				 struct bcm2835_spi *bs,
 				 struct bcm2835_spidev *target)
 {
+	struct device *rx_dev = dmaengine_get_dma_device(ctlr->dma_rx);
 	int ret;
 
 	if (!ctlr->dma_rx)
 		return 0;
 
-	target->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
-					       &target->clear_rx_cs,
-					       sizeof(u32),
-					       DMA_TO_DEVICE);
-	if (dma_mapping_error(ctlr->dma_rx->device->dev, target->clear_rx_addr)) {
+	target->clear_rx_addr = dma_map_single(rx_dev, &target->clear_rx_cs,
+					       sizeof(u32), DMA_TO_DEVICE);
+	if (dma_mapping_error(rx_dev, target->clear_rx_addr)) {
 		dev_err(&spi->dev, "cannot map clear_rx_cs\n");
 		target->clear_rx_addr = 0;
 		return -ENOMEM;
@@ -1268,7 +1270,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		target->clear_rx_cs = cs | BCM2835_SPI_CS_TA |
 					BCM2835_SPI_CS_DMAEN |
 					BCM2835_SPI_CS_CLEAR_RX;
-		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
+		dma_sync_single_for_device(dmaengine_get_dma_device(ctlr->dma_rx),
 					   target->clear_rx_addr,
 					   sizeof(u32),
 					   DMA_TO_DEVICE);
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be3946965..fe5b094f0b6b3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1382,7 +1382,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	ddev = cqspi->rx_chan->device->dev;
+	ddev = dmaengine_get_dma_device(cqspi->rx_chan);
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
 		dev_err(dev, "dma mapping failed\n");
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index bf389d7590d35..d8f4aa38685f5 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -273,6 +273,7 @@ ep93xx_spi_dma_prepare(struct spi_controller *host,
 	struct dma_async_tx_descriptor *txd;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config conf;
+	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct sg_table *sgt;
 	struct dma_chan *chan;
@@ -348,14 +349,15 @@ ep93xx_spi_dma_prepare(struct spi_controller *host,
 		return ERR_PTR(-EINVAL);
 	}
 
-	nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
+	dma_dev = dmaengine_get_dma_device(chan);
+	nents = dma_map_sg(dma_dev, sgt->sgl, sgt->nents, dir);
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
 	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, conf.direction,
 				      DMA_CTRL_ACK);
 	if (!txd) {
-		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sg(dma_dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
 	}
 	return txd;
@@ -384,7 +386,7 @@ static void ep93xx_spi_dma_finish(struct spi_controller *host,
 		sgt = &espi->tx_sgt;
 	}
 
-	dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
+	dma_unmap_sg(dmaengine_get_dma_device(chan), sgt->sgl, sgt->nents, dir);
 }
 
 static void ep93xx_spi_dma_callback(void *callback_param)
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 23e6bc5f202e2..25af5e6777230 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -670,6 +670,7 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
 	struct device *dev = &dspi->pdev->dev;
+	struct device *tx_dev, *rx_dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
 	int ret;
@@ -688,20 +689,23 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
+	tx_dev = dmaengine_get_dma_device(dma->chan_tx);
+	rx_dev = dmaengine_get_dma_device(dma->chan_rx);
+
 	if (spi_controller_is_target(dspi->ctlr)) {
 		/*
 		 * In target mode we have to be ready to receive the maximum
 		 * that can possibly be transferred at once by EDMA without any
 		 * FIFO underflows.
 		 */
-		dma->bufsize = min(dma_get_max_seg_size(dma->chan_rx->device->dev),
-				   dma_get_max_seg_size(dma->chan_tx->device->dev)) *
+		dma->bufsize = min(dma_get_max_seg_size(rx_dev),
+				   dma_get_max_seg_size(tx_dev)) *
 			       DMA_SLAVE_BUSWIDTH_4_BYTES;
 	} else {
 		dma->bufsize = PAGE_SIZE;
 	}
 
-	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
+	dma->tx_dma_buf = dma_alloc_noncoherent(tx_dev,
 						dma->bufsize, &dma->tx_dma_phys,
 						DMA_TO_DEVICE, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
@@ -709,7 +713,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
+	dma->rx_dma_buf = dma_alloc_noncoherent(rx_dev,
 						dma->bufsize, &dma->rx_dma_phys,
 						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
@@ -746,12 +750,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
-			     dma->rx_dma_buf, dma->rx_dma_phys,
-			     DMA_FROM_DEVICE);
+	dma_free_noncoherent(rx_dev, dma->bufsize, dma->rx_dma_buf,
+			     dma->rx_dma_phys, DMA_FROM_DEVICE);
 err_rx_dma_buf:
-	dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
-			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
+	dma_free_noncoherent(tx_dev, dma->bufsize, dma->tx_dma_buf,
+			     dma->tx_dma_phys, DMA_TO_DEVICE);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -766,21 +769,21 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
 	struct fsl_dspi_dma *dma = dspi->dma;
+	struct device *tx_dev = dmaengine_get_dma_device(dma->chan_tx);
+	struct device *rx_dev = dmaengine_get_dma_device(dma->chan_rx);
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
-				     dma->tx_dma_buf, dma->tx_dma_phys,
-				     DMA_TO_DEVICE);
+		dma_free_noncoherent(tx_dev, dma->bufsize, dma->tx_dma_buf,
+				     dma->tx_dma_phys, DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
-				     dma->rx_dma_buf, dma->rx_dma_phys,
-				     DMA_FROM_DEVICE);
+		dma_free_noncoherent(rx_dev, dma->bufsize, dma->rx_dma_buf,
+				     dma->rx_dma_phys, DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6f9686df0486e..868f963e61371 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1467,8 +1467,8 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 static void spi_imx_dma_unmap(struct spi_imx_data *spi_imx,
 			      struct dma_data_package *dma_data)
 {
-	struct device *tx_dev = spi_imx->controller->dma_tx->device->dev;
-	struct device *rx_dev = spi_imx->controller->dma_rx->device->dev;
+	struct device *tx_dev = dmaengine_get_dma_device(spi_imx->controller->dma_tx);
+	struct device *rx_dev = dmaengine_get_dma_device(spi_imx->controller->dma_rx);
 
 	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
 			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
@@ -1526,8 +1526,8 @@ static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
 			   struct dma_data_package *dma_data)
 {
 	struct spi_controller *controller = spi_imx->controller;
-	struct device *tx_dev = controller->dma_tx->device->dev;
-	struct device *rx_dev = controller->dma_rx->device->dev;
+	struct device *tx_dev = dmaengine_get_dma_device(controller->dma_tx);
+	struct device *rx_dev = dmaengine_get_dma_device(controller->dma_rx);
 	int ret;
 
 	dma_data->dma_tx_addr = dma_map_single(tx_dev, dma_data->dma_tx_buf,
@@ -1919,7 +1919,7 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
 		return ret;
 
 	/* Trim the DMA RX buffer and copy the actual data to rx_buf */
-	dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_rx_addr,
+	dma_sync_single_for_cpu(dmaengine_get_dma_device(controller->dma_rx), dma_data->dma_rx_addr,
 				dma_data->dma_len, DMA_FROM_DEVICE);
 	spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_imx->rx_offset,
 				   word_delay);
diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 70cbc3ef658b6..38c8d6269aadd 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -841,23 +841,23 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
 {
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan *chan = xspi->dma_rx;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
 	unsigned long timeout;
 	dma_addr_t src_addr, dst_addr;
 	int ret = 0;
 
-	dst_addr = dma_map_single(chan->device->dev,
-				  op->data.buf.in, op->data.nbytes,
+	dst_addr = dma_map_single(dma_dev, op->data.buf.in, op->data.nbytes,
 				  DMA_FROM_DEVICE);
-	if (dma_mapping_error(chan->device->dev, dst_addr)) {
+	if (dma_mapping_error(dma_dev, dst_addr)) {
 		dev_err(xspi->dev, "failed to map DMA dst buffer\n");
 		return -ENOMEM;
 	}
 
-	src_addr = dma_map_resource(chan->device->dev,
+	src_addr = dma_map_resource(dma_dev,
 				    (phys_addr_t)xspi->memmap_phy + op->addr.val,
 				    op->data.nbytes,
 				    DMA_TO_DEVICE, 0);
-	if (dma_mapping_error(chan->device->dev, src_addr)) {
+	if (dma_mapping_error(dma_dev, src_addr)) {
 		dev_err(xspi->dev, "failed to map DMA src resource\n");
 		ret = -ENOMEM;
 		goto err_unmap_dst;
@@ -886,12 +886,10 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
 	}
 
 err_unmap_src:
-	dma_unmap_resource(chan->device->dev, src_addr,
-		op->data.nbytes, DMA_TO_DEVICE, 0);
+	dma_unmap_resource(dma_dev, src_addr, op->data.nbytes, DMA_TO_DEVICE, 0);
 
 err_unmap_dst:
-	dma_unmap_single(chan->device->dev, dst_addr,
-			 op->data.nbytes, DMA_FROM_DEVICE);
+	dma_unmap_single(dma_dev, dst_addr, op->data.nbytes, DMA_FROM_DEVICE);
 
 	return ret;
 }
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 4877ab909c51b..4f817de9f2d3f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -684,9 +684,9 @@ static void readwriter(struct pl022 *pl022)
 static void unmap_free_dma_scatter(struct pl022 *pl022)
 {
 	/* Unmap and free the SG tables */
-	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
+	dma_unmap_sg(dmaengine_get_dma_device(pl022->dma_tx_channel), pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
-	dma_unmap_sg(pl022->dma_rx_channel->device->dev, pl022->sgt_rx.sgl,
+	dma_unmap_sg(dmaengine_get_dma_device(pl022->dma_rx_channel), pl022->sgt_rx.sgl,
 		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 	sg_free_table(&pl022->sgt_rx);
 	sg_free_table(&pl022->sgt_tx);
@@ -811,6 +811,7 @@ static int configure_dma(struct pl022 *pl022)
 	struct dma_chan *txchan = pl022->dma_tx_channel;
 	struct dma_async_tx_descriptor *rxdesc;
 	struct dma_async_tx_descriptor *txdesc;
+	struct device *rx_dev, *tx_dev;
 
 	/* Check that the channels are available */
 	if (!rxchan || !txchan)
@@ -924,14 +925,16 @@ static int configure_dma(struct pl022 *pl022)
 	setup_dma_scatter(pl022, pl022->tx,
 			  pl022->cur_transfer->len, &pl022->sgt_tx);
 
+	rx_dev = dmaengine_get_dma_device(rxchan);
+	tx_dev = dmaengine_get_dma_device(txchan);
 	/* Map DMA buffers */
-	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	rx_sglen = dma_map_sg(rx_dev, pl022->sgt_rx.sgl,
+			      pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 	if (!rx_sglen)
 		goto err_rx_sgmap;
 
-	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
-			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
+	tx_sglen = dma_map_sg(tx_dev, pl022->sgt_tx.sgl,
+			      pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	if (!tx_sglen)
 		goto err_tx_sgmap;
 
@@ -969,10 +972,10 @@ static int configure_dma(struct pl022 *pl022)
 	dmaengine_terminate_all(txchan);
 err_rxdesc:
 	dmaengine_terminate_all(rxchan);
-	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
+	dma_unmap_sg(tx_dev, pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 err_tx_sgmap:
-	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+	dma_unmap_sg(rx_dev, pl022->sgt_rx.sgl,
 		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 err_rx_sgmap:
 	sg_free_table(&pl022->sgt_tx);
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 90a671e9de70e..89fbdde46cfe9 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -674,7 +674,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 
 	if (tx) {
 		ier_bits |= SIIER_TDREQE | SIIER_TDMAE;
-		dma_sync_single_for_device(p->ctlr->dma_tx->device->dev,
+		dma_sync_single_for_device(dmaengine_get_dma_device(p->ctlr->dma_tx),
 					   p->tx_dma_addr, len, DMA_TO_DEVICE);
 		desc_tx = dmaengine_prep_slave_single(p->ctlr->dma_tx,
 					p->tx_dma_addr, len, DMA_MEM_TO_DEV,
@@ -754,7 +754,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	if (rx)
-		dma_sync_single_for_cpu(p->ctlr->dma_rx->device->dev,
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(p->ctlr->dma_rx),
 					p->rx_dma_addr, len, DMA_FROM_DEVICE);
 
 	return 0;
@@ -1142,13 +1142,13 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 	if (!p->rx_dma_page)
 		goto free_tx_page;
 
-	tx_dev = ctlr->dma_tx->device->dev;
+	tx_dev = dmaengine_get_dma_device(ctlr->dma_tx);
 	p->tx_dma_addr = dma_map_single(tx_dev, p->tx_dma_page, PAGE_SIZE,
 					DMA_TO_DEVICE);
 	if (dma_mapping_error(tx_dev, p->tx_dma_addr))
 		goto free_rx_page;
 
-	rx_dev = ctlr->dma_rx->device->dev;
+	rx_dev = dmaengine_get_dma_device(ctlr->dma_rx);
 	p->rx_dma_addr = dma_map_single(rx_dev, p->rx_dma_page, PAGE_SIZE,
 					DMA_FROM_DEVICE);
 	if (dma_mapping_error(rx_dev, p->rx_dma_addr))
@@ -1178,9 +1178,9 @@ static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
 	if (!ctlr->dma_tx)
 		return;
 
-	dma_unmap_single(ctlr->dma_rx->device->dev, p->rx_dma_addr, PAGE_SIZE,
+	dma_unmap_single(dmaengine_get_dma_device(ctlr->dma_rx), p->rx_dma_addr, PAGE_SIZE,
 			 DMA_FROM_DEVICE);
-	dma_unmap_single(ctlr->dma_tx->device->dev, p->tx_dma_addr, PAGE_SIZE,
+	dma_unmap_single(dmaengine_get_dma_device(ctlr->dma_tx), p->tx_dma_addr, PAGE_SIZE,
 			 DMA_TO_DEVICE);
 	free_page((unsigned long)p->rx_dma_page);
 	free_page((unsigned long)p->tx_dma_page);
-- 
2.43.0

