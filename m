Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5450AC31;
	Wed, 30 Sep 2026 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777013; cv=fail; b=IY6+CN3YszN9Hk9mHxhVjmd8VJBd1WO2KI43Xz7X2JhLhQJyqfMqV5NbzXs/EcmEFYsym+K3CeUFmAkkW29f/wPm0s/vt5Ak0zw248ynhWTzIjPYdh5oaxDa+geyzcWfz9YG0+UvUQxdBJ4GjGVZ5qb7LiRUU1csI4swui+B82Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777013; c=relaxed/simple;
	bh=K4bYe0TNgPwlUTy3l9oqK+1vTIZp6Ym/l51X59AFKL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2t8o+yY7ybDwq/YaeygQXdmwtN0W+BfNlzIGt06kDPScICA1lUBHA8UqEtnaoKSz0UsCnzvr22/qkpEqY+OK15oDhhK3kSk4CrQjB8S8hV6tK3PFqKKzsvdrUiPJIEVTzsvR3E2ndg7pzkTayDeFXwvZ3L+1BhcGWv+tO8XGNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QTcjBEPH; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QTcjBEPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTJmeekX0fa+1QSho4NQlrQWIRFwhQ1TPWrNCMgDk43sezeJlTxQzEriYYCrUVqvbRVH48CQJmkpxbacgL2PmYgCrlRedJJITQNBq/Urx/b2EHfVluAXPkwGjqirD25gVukcHlJyMyTCAkqM50hYVn8YXuFoaxpBi3OAx4BvOhwSjt9jch8+Gt89bN9xyAp3efd4vWT8llx2nEOYoyJ/n9Vfzp8BudLuyrh4tkRN5p2cIbC9qU7YsDoNKqQr8PWAt1wd7U4lSznnC98ZQUcD/ut0YyOlri6N70ZoJ2G0azV1XuRPPHiNAz2EbnyEDt+LNSymDwjAb6yyTLTSPRXwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PFMk4MD3busBzpBTbKKT073xZwWJWJZ/I4B9p03M5Y=;
 b=xjFs7cGEFDoKoqGyrk45a5mUKBu7QMTbJ+OskgU5EtKTb9tXXLT4vzJNuiylZO2muog4UOpPJ7CCyAWI1O663Ohvx4OItFj7VaKDJqUA9h+5r0LxD0aEEi2VeY/szIb4EbTQyAIEqe7VJSt1nelNJApxlUjiGGhjZ3fGbEDKOeGPbwrw3VPZHEKH92KIRZOS//hpHxUx4rE6sBVwWETtNtk2Ru3Ou0x8FJB5uUd3jOVA5IeIsXHn9CC2AbWbykRHxAaRk9zC23LR6Hv0SiMSZHaO7gXIyEosZwR5uyI3HqvjszqUKP1DCRXBhsrbzmh0EMciM6zAmiqNChDLhftaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PFMk4MD3busBzpBTbKKT073xZwWJWJZ/I4B9p03M5Y=;
 b=QTcjBEPHAF/rAQpb47cup8AXCu6zYu8yGyzP5LbYzkBrrVOguXp4F8NqTCYfuXdGEEFO4JdNH+Vif9pyMewSJkBoWnjUWVQCeaxxyH3iBmZRCYHponxLPwxcueS7pPEoeKE8FD8PetdR6HhedzH09Q2at3YsBeHTJBjI20CGUdFHRgPTGCAig4gJBov2/rpfGrPNylLxc5GTYMNrJrZgRkU9d3V/iCAFHHOub4Ag1GvffSF+J3S+hqvg2tg0lXLkRGFEXINj8B5nJMZvuVvZjvrcHMwaqva4zZOLFGwncnooNHsLIPViI7YDYr+EXXLhOagw2MN6y5V7AG4hY83NKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MMZPR04MB319484.eurprd04.prod.outlook.com (2603:10a6:190:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:03:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:03:12 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v2 2/2] spi: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Wed, 30 Sep 2026 10:02:55 -0400
Message-ID: <20260930140257.490019-2-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930140257.490019-1-Frank.Li@oss.nxp.com>
References: <20260930140257.490019-1-Frank.Li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:5::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MMZPR04MB319484:EE_
X-MS-Office365-Filtering-Correlation-Id: b8204cd7-bbc2-449a-3935-08df1efb90ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|921020|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	yvP8q4bS3j99ZlrMwQE5qdivCP9lCyiWTTeupOEtsGTYmKOfEFSS4XTLymEhvC2PEteZDveei0YZTvVBDFIkrjKyqolfLg3WbV3C1qs46nBhfHDAdHP47c/XUiCtQyUoMi5KcrFJ7gRhb3V3UC1P6XXvWUQuFB66CbsW5lTpFjODSr5P7x7to8TkaZbbQG9dbaRR+ZlzpVXo2zcJjceXIimTJHWsovhX7kikxFjs5UpdTka1CMkGQHu7RqN/yirr0w13419x5mpmL3B1kROu++GezjVWuio67rQajCdmeA1p9j0Pd0WbVgl2CLQ06QKafKU8tjQ5FT2BiK65UlElC5E35JQ4hgVGqJtnKbarfKvdOPcBDShBh2MbAqisSYPztuMqt+zgFrDaoPRRVtv6gddkyqC0CJIec5IR2ZiHlY1oX/qbaV8rCvwu6kiZS3PmaX4pLPsMrl9TSg4Qv6Qjvxb0/4JrWdG+wpS4SE+pPNUBbUpmX0HGitSymqsKGNOuZz2zQH63uAdb8Up+Mn0ODT7x+pWPrLXkjX96nOrwLibIN5ESo/ht2uIWqG6eWKVeIdC8Lcz+KF1DGpkCMk6FhMVGxZxj0P1ZguC0fCaGTfeQPfrhk1vTN9VGgrk38wPQQzOGST6OrpS/xOmB68lME5bo+57Iut2OYnyk1LPcc2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VgO8yH0MmhqReffznDGFyMU3hmxDgv3QHfp0DBPw40DUmza+2LIOW8N30hYZ?=
 =?us-ascii?Q?lk8CR9A9CRGP3g6+/UFxfFYVNbmmCkkkG1My7uAEDbm+a2LI8Pcvq8A2CGlT?=
 =?us-ascii?Q?Wz4Ms/DyZywELcE28YVcHrb04uHCxAaH+lU87I8xgd4oVCz9aPdcpPua44ks?=
 =?us-ascii?Q?vrvXN+b4fGF6qqsjRfbNcDxfoREguzgwuWMG22YfElbuFjbhCzvXX38606u7?=
 =?us-ascii?Q?nhL7V2fI5vSU5TKHYKOMUkp93LKt1QOoJPIGiD9Hn/WQHYGlbl7ZnZGt6mb+?=
 =?us-ascii?Q?xuX9/lKSpEFbmfBUoOif06FEPXsyNPe7UXdWXDxTAjzYuWi1nPIhdRRyPh9O?=
 =?us-ascii?Q?GCpeMEovVLOclJ0kquwtmSpFRygnQydBF2k3NrRByv3TXaXPaw6IKm68Ti+H?=
 =?us-ascii?Q?tJm8nIDrE62bLRJ5xjA9Ab4XHYWo8qn4vuDbld3sOHUt5ww+kVahpoOchRoW?=
 =?us-ascii?Q?Y0p0Urp3QIGwG9uYpBaVW5zL6fqMxiV/DjuRmxNeGShteI7c0xknrdPv4sSn?=
 =?us-ascii?Q?twpyil0JNPwXQfGx2OXoYBwtMUiYmZ2PuVkiktR07l+ZomxeHvVFO+41wGMK?=
 =?us-ascii?Q?7PfS6BV8+1HpRWE6ekrtFk9f7xBiF7ryKYeUTf43l++y64pNJeSOlwf6mWs+?=
 =?us-ascii?Q?pXpoDnS7hmwIWTHl5jDatxW+Bhekcoqh7dZPTRwD3oNwvoz6/HDeM5fYHO88?=
 =?us-ascii?Q?Wjn8icgsx4qw0c+ANdEmcQ7aQgAULf2+gQ/97wqjMKoFgyg8szyHNna1+dQL?=
 =?us-ascii?Q?N0yHcdyrjFAYHcCSa8tlwV3EBKEsqhqJXp41WZ9gPKfXy/KcSY578hJkN5UE?=
 =?us-ascii?Q?qJItDX79o4H5YJFG4tNgau0TvcGKd4tiTEOwyAZSV3B6DPQtQnX6w0sQ2fTf?=
 =?us-ascii?Q?BXgU/HllISYx8FHGoasChexsvPqd006VklFTUI1YiLK90QZ/TOXHbhXGhH5T?=
 =?us-ascii?Q?B2rFqf3J8sRpm23Tr4ATknExeK8DcTTZITsxC8Yesk0txv2vq0vKiv4Chre2?=
 =?us-ascii?Q?BGskfzzo9NHwgEXTlhmu/vovinG7pAGz8w7TIS2Ozlluh5TVSLUmNiAqf7aP?=
 =?us-ascii?Q?A14pnmqP6CK9VKH5MKT+jZI7F4GcY1hYtcNOnTBYFi4j2KkeeFm4sAsQ/Lgc?=
 =?us-ascii?Q?qnZe6f7PqHxbGkb39zyHTpLhBhNIbNLNPtIc3H3eQrIZvxsBLJRFs2FVZt9t?=
 =?us-ascii?Q?xgC8T9mCLIzwzK5NoYT4+7ar1JTNDlbISlXwOegbpF60JeSbTLjP2UdR0mhl?=
 =?us-ascii?Q?5XsWNCQN4oifTsWo5+ExNrd0pUkPkcCvg2Tn0VZFra0qUyLQwpv9gCOYVBlN?=
 =?us-ascii?Q?pBfKIKyHIkdWnPtj9D2yElI/0wm+hsUJ68Es11sNbSHe5OSatQafID5kmeSG?=
 =?us-ascii?Q?CQ+JXKrNNYJm0yhuUy6ohupQZslT9xfTHyatLQYX/R9BFT3P4SJ0jad9e8pf?=
 =?us-ascii?Q?2qqSXM6u/838/FVJIQsNtur1GPGXkUPM/yBoNIweESwpcpnNpxlnXMan15Eq?=
 =?us-ascii?Q?FO0D7B/RVFeCMD+DkYiBCwuG0Vp+0cMAd8+R9VGplgaNk4pL3qsa3PmIzXl1?=
 =?us-ascii?Q?TN7xBa0LSqZRk9ZcDkfSft9s4+JMzlgv9/n11woVGtATTgYPZ5QA6i6alUll?=
 =?us-ascii?Q?KxGGD+ZP4fpQlHhbQLLWuJ4Hg7+Z0xoLK3HV7Hmy9ZTi5YAGlJlmWRz2xIBD?=
 =?us-ascii?Q?5iD0O6bLwcsLC7DZUdsy0cDnfprpMjhTRNNMZjSqVY1vgwC5gij2gkTjlmtW?=
 =?us-ascii?Q?2oZC0u/SfQzm9Hg9Lp+Ji0DII14pProyF3Zs14jwJz98zjMFaRcc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8204cd7-bbc2-449a-3935-08df1efb90ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:03:12.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdwcU0956iX9DwQVP+h40i5shXmx8LBPaqUEd7xU7hmm6iuKMWXQoEXRSJfxDkxNGvIM8p7gEGh5plhBpThQunU0m2XL1MOApaKdcvlXR6HsVTHy7AZKm2wCXzJo18cX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB319484

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
Change in v2
- move dmaengine_get_dma_device() after check dma_chan available. (Mark brown)

Check all unders driver/spi/ by rename device to _device in dma_chan struct
with all yes config.

Still few left, one for copy_align access, which need new API. some filter
DMA channel, need new API to get provider devices.

In https://lore.kernel.org/imx/67966b47-22cb-4b07-80c7-2044f557dbcb@app.fastmail.com/
There are better idea to move map singe/sg into dma prep functions.

But it takes more times, not straightforward works. Let replace this firstly,
---
 drivers/spi/spi-bcm2835.c         | 25 ++++++++++++----------
 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi-ep93xx.c          |  8 ++++---
 drivers/spi/spi-fsl-dspi.c        | 35 ++++++++++++++++++-------------
 drivers/spi/spi-imx.c             | 10 ++++-----
 drivers/spi/spi-nxp-xspi.c        | 16 +++++++-------
 drivers/spi/spi-pl022.c           | 19 ++++++++++-------
 drivers/spi/spi-sh-msiof.c        | 12 +++++------
 8 files changed, 69 insertions(+), 58 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 8f8715809c7ce..884941f2e9b9a 100644
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
@@ -1174,16 +1177,16 @@ static int bcm2835_spi_setup_dma(struct spi_controller *ctlr,
 				 struct bcm2835_spi *bs,
 				 struct bcm2835_spidev *target)
 {
+	struct device *rx_dev;
 	int ret;
 
 	if (!ctlr->dma_rx)
 		return 0;
 
-	target->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
-					       &target->clear_rx_cs,
-					       sizeof(u32),
-					       DMA_TO_DEVICE);
-	if (dma_mapping_error(ctlr->dma_rx->device->dev, target->clear_rx_addr)) {
+	rx_dev = dmaengine_get_dma_device(ctlr->dma_rx);
+	target->clear_rx_addr = dma_map_single(rx_dev, &target->clear_rx_cs,
+					       sizeof(u32), DMA_TO_DEVICE);
+	if (dma_mapping_error(rx_dev, target->clear_rx_addr)) {
 		dev_err(&spi->dev, "cannot map clear_rx_cs\n");
 		target->clear_rx_addr = 0;
 		return -ENOMEM;
@@ -1268,7 +1271,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
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
index 23e6bc5f202e2..f03488870d024 100644
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
@@ -771,16 +774,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
-				     dma->tx_dma_buf, dma->tx_dma_phys,
-				     DMA_TO_DEVICE);
+		struct device *tx_dev = dmaengine_get_dma_device(dma->chan_tx);
+
+		dma_free_noncoherent(tx_dev, dma->bufsize, dma->tx_dma_buf,
+				     dma->tx_dma_phys, DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
-				     dma->rx_dma_buf, dma->rx_dma_phys,
-				     DMA_FROM_DEVICE);
+		struct device *rx_dev = dmaengine_get_dma_device(dma->chan_rx);
+
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
index 4877ab909c51b..3ff30486b2892 100644
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
 	/* Map DMA buffers */
-	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	rx_sglen = dma_map_sg(rx_dev, pl022->sgt_rx.sgl,
+			      pl022->sgt_rx.nents, DMA_FROM_DEVICE);
 	if (!rx_sglen)
 		goto err_rx_sgmap;
 
-	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
-			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
+	tx_dev = dmaengine_get_dma_device(txchan);
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

