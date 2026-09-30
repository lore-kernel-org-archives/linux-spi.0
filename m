Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECED4582E8;
	Wed, 30 Sep 2026 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752569; cv=fail; b=idZ9oJOWmwNvuR/JRq2z5c99wSKkBEHm2m4BmPUTXHzYxRPo+alTp0+cg3ESWk5/ZTr8T9z6py16VWfZa9vCFOQ44CzV3MYmM8Jo6ilPe7R/MN5Qu0GB+Ixndh6kyOSN9NZ8J9pmlhyFlkJoJ/Hpm/Zs80gbr0fd+Wu7rHYYMnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752569; c=relaxed/simple;
	bh=BLj+3mdxPQDdwpqYJmE0e0ZxDaMrnGYjfyoxg9zx8YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y10mJvPj8d8bVC2aPekT9qgpnwBdOpgHQGcRR3yTL/YT3MMtBBM/kmH002GSWi1jsazr461NCcpIpCN8qJyCKMA2h3rjY9kE4+Ce9LDFIcRgKARsjcxLJp59BDzqg42FkQNV/EIJBo62KQMD2WZux1sZqaZ1WHrv0LMxk1SDY3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFH5DC/uJXnxosSEw2VRUu15CBbwiQ+ttVACWoQpnb1z9C7mGKQLmXM/AmYIM6icdY28556Xmlh8Wrnut/qWL55zNL25VjjX8LUgPKa0OAv91ac0v3aaElk6V1igEZO7K54HwIPak/Al1GMv9TaaSdw+pb4B3FiRTch6wsU/pzhIT4YYuL1FZo8tzT1E7C4LwC/qgt+N1uhWqiKTTw07mH+DXC+fQaJm9dxuOit7rr/ARnQtztBuQvi0zQVWrK9cWFCPCXx7Dich3AnaTU76pIm4aYNFxz4taFioC2PuO5zFwPSOu/zEvlpgAFb/NGj8hp6Qvxh+DwdIf6JZM1QJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqA9wOO6hs7zaaMiagh5n6yq45PZfzRyQeabnZ5CFqA=;
 b=n39XbE16fytDML1eeMo0/MHU6Cd6+kQw55YxbbVI4k3nrfrzwSWQPm67bpisdH8ez+4I9U/82nfpH7lU5rSRJ2+QCro9SMQTG6jLL641dLCVfol1+U/QeEjNRcCOO2kvkqihdq6WWyb4RMB0GrxUar4m9g9MfanoBS4dlrapP9LM22DYkpNizBQKtYVHZlOayXsQumkZ5Dim1DgIHYDFFZovgsEz21RKD+q7H7g5i8RSYuhNJCwehAhpUd9IE1BXGJygZIpVMjGbCs9Q6pyc3faet7aTvUBUql9FF6+az1u29ebk+/1Aj4W8itJtBtkTLGhElzUfv0Plzn55BBUttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:15:47 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 07:15:47 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 2/3] spi: dw: Support DMA with a single channel
Date: Wed, 30 Sep 2026 00:15:34 -0700
Message-Id: <20260930071535.7947-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
References: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: 09576af1-d49a-43cd-a609-08df1ec2a62c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7c1fEpks6aW6xj2wUCalxWsuA9qAlMwQMBiSeuxFQE+4mTX3QckVzCu+PbCU7ChAPpH79Dlbj+gatkl/sgLq5lS2pIN/o5aWF9EFbLQytflvyCMg+iq5lLn2+bRe2hiMLE3SE+SP6yU241VDCyKZHFtrvOw9sbB2+zuHF0gsJmJthXbMB/9FTP64tp877zMVw7t8B31Mg/eaBKbSuwU/XKBugieoQohEZhud8/4pzkvJIRa3Tzd/4ctsUxy0xnqzr9tbGI6pHoK7KxthSKlsATntQlYZnue+IK0dXcP8lCC0h1azi+kJrPYa/EpymYxhObtIssaRgp/KxBrd/DIYo+ko4+y4suApN/5cr8N9vP8tHRsuSKP7zeLI28Gr+3tPde0XI+3A5I50mNbceJc0Oi9nV87VmD9dSuWKT73dBHf+cpSr4yn/ED3pXn4j2myGF1L2HKHEZREaIVPWpiZrRmxO5AumQ0NpSUAan0Z9qBC/uBqjdlFixtLZD4kZGs69cJHXBa6t3Nv+E/S16Bmw76q5cRwcatp6zXiJCSQZzIazARuRZaUwiQzhbHBD7pCi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3awbEfFcR/z/ApQIikXZS0MFbzLF2TChipHb5P1IFgjRcL23Yb9Z1guXG7/9?=
 =?us-ascii?Q?fNixzEUZxKlVqRT8DSsF/X5qftXHwokCCdtKMbkhPxXZAIQOxKlMkawMIKWE?=
 =?us-ascii?Q?ztfeZ1m9ZiggInpgJ4S3XS5XRwX1/cuXgQhWwQJQ0hx6ctNrKSmHI/r2ZgOV?=
 =?us-ascii?Q?WVRIAw51g2R14w9GsqrW5XKEYQSjCGbfo8hUDf0RWZsw6woK5t1VxTU4D+pK?=
 =?us-ascii?Q?gdX0y1+cKtnY//h3+R/e45+DztkUHfq2O3qh4s/Cw+7Ak4NoiSnpI5EPOhWR?=
 =?us-ascii?Q?kXxLfNUVyAjrsAHJx21RU74CvpzGgSjH7HSjkQb8thtr5WuGzP1M2QbUO12S?=
 =?us-ascii?Q?hV/ziesMB16XQWSOv5daHlfTJHLMQuyeDJPU/ocYK200djk5kjlXF3rAvfEh?=
 =?us-ascii?Q?1vMDFZ3Xvaxs4ULt+WHZj4EkrTsG5tcd698hlGSBgQR7po329xkpGRHuTDKL?=
 =?us-ascii?Q?FL0cJd8GM+JdaTwQLL9I10lud63moEpYMSDfpdlviFrWRlD4TsTONtbbmEJy?=
 =?us-ascii?Q?fTKaBcvM04PmdaWhRxMoKK+1byBYhx0wwJ4CWnoMe4Xvcf6oMh+Q8oLjLJRl?=
 =?us-ascii?Q?XPGraTzEK0naSRE3lf/RF3D8aMTJWq2VaZpGTBBUrnWGaAWFGodRZLe3jSQV?=
 =?us-ascii?Q?yEnu39aR6kgzoZXfZATjESrLQL4szBWp6EyeB9newStheDBlQQ3qXsxDZTsD?=
 =?us-ascii?Q?cswPENDeO2M6XlSQo8BnwQGzUgOj2Yf3nnFVQsbU5Kjsecm1ueWmR0WT/Fek?=
 =?us-ascii?Q?oMe4lKBXp6TLk+yHSVxXDERm7VRQRm6AX4Yc6O4rdHsCIx3cpltAQSMOusVE?=
 =?us-ascii?Q?uNu83EJ/4E7Is7v4HTtjwnVXQlBn7MhJcbvD2t7BmjIIxw7Ohh78lKqtAqYr?=
 =?us-ascii?Q?v/pxXR+xcOtVRObIxqKL3yGDIkXdDx7DlyGqLkkF0KyuqVQHUKirixHdljeI?=
 =?us-ascii?Q?OMdmyo2GsEJhXxS7qenx5622Xuqr8gULd8S0bb7qvHDVwzKJBisC1iJ9ryLS?=
 =?us-ascii?Q?VXrRWAlbuQDrQMzGGk+GDMgn1r2/7DgSEGFfcK4R2uaB6sUbIcZpteJ5feu3?=
 =?us-ascii?Q?9IDJoPCE2ayug9IlFwEtkHjip1ssU+K6SBQVgLI++2GHOHUmXvTDIHBRgp/0?=
 =?us-ascii?Q?olaNHbbDabCPEdQKehOKOcvOxJcYXNAutxBVOmKqWLcOCVpBZ2N8V3/qJnTO?=
 =?us-ascii?Q?QiNSnQrUz0K4oJHIdxabI22UQrZyKXQru+G9xh0lZqyDo+eEK6S8FMtJaVS0?=
 =?us-ascii?Q?5H/lIRufLLKZ0CnXqP0vrHzAEERUJHOMMS7gJR+g07eIZwCufCAIRsEiI7jt?=
 =?us-ascii?Q?kvNu/+NBLHetjvQxcmF2+YAZnwHwQiLyToeKeY/JHpsYq/6MD8sp7NJUZn+B?=
 =?us-ascii?Q?hLnee9eQParQ4T9VANeWxTlPY07ybg5jA0YxKQ+ERA4hgjtrLFINMaePLAYv?=
 =?us-ascii?Q?ybiSsUH6FclGQ5zNfuC+/tBMhff20KBZ4vApQAjDYa+cfR+7VOwbEdvuh18d?=
 =?us-ascii?Q?1mt7PUROO3eUQfqncgRZyDdwriwejLwvanP0psVCl+/Bs/olgL2FFhqEcoX3?=
 =?us-ascii?Q?0meg04NsCWvKVRDiBaHNRcXw2kBpbaTJ7RLLDeVls8ZWRyQJtpdq/rElr5Ss?=
 =?us-ascii?Q?mxiE236hOBWTX1JiT8A0qDlaOhS+u6oQr6iHSW5+ijFEycltBISIWCFafQ9w?=
 =?us-ascii?Q?0ESj3bYu/MKbmddq47Hc33U9XEMRHKz+tzSMXhhhHw/er6krUMmj48uI8PaR?=
 =?us-ascii?Q?3bPgkzXG8l1eU7XR06KKIN84WWU+wWj+1cdTr+0Tpq7xD5MkMfOh?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09576af1-d49a-43cd-a609-08df1ec2a62c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:15:47.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qeqBZmBFoYyaamjquQhrMPoe+gK5ihvBk3JdUPMRWdfejB0hjZpRbj5mjLqWwphBRp3FCofKkyY6skzx243+c6SWDODlBoDamqtn1BUbVT8iwfkM6aP5Ij6h7m7NZ0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Some platforms, such as StarFive JHB100, provide only one DMA channel
for the DW SPI controller. dw_spi_dma_init_generic() requires both the
Tx and Rx channels, so DMA is disabled entirely on such platforms.

Request both channels at probe time and decide what is usable from the
return values. If the first (Rx) channel request fails, fall back to
non-DMA transfers as before. If only the second (Tx) channel request
fails, keep the Rx channel. Each successfully requested channel is
counted in dws->dma_nr_chans. -EPROBE_DEFER on the second channel is
still propagated.

Full-duplex standard SPI transfers need both channels, so only set
ctlr->can_dma and SPI_CONTROLLER_MUST_TX when two channels are
available. A single channel can still serve half-duplex transfers,
which will be used by the enhanced SPI memory operations in a
follow-up patch.

Make dw_spi_dma_caps_init() and dw_spi_dma_maxburst_init() cope with a
missing channel, and set ctlr->dma_tx/dma_rx only after the capability
check has passed so that they never point to a released channel.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c |  3 ++
 drivers/spi/spi-dw-dma.c  | 88 ++++++++++++++++++++++++++++-----------
 drivers/spi/spi-dw.h      |  1 +
 3 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 206d3f9dd83d..6889f4446ecb 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1360,6 +1360,9 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 			goto err_free_irq;
 		} else if (ret) {
 			dev_warn(dev, "DMA init failed\n");
+		} else if (dws->dma_nr_chans == 1) {
+			/* Full-duplex DMA transfers need both channels */
+			dev_info(dev, "Single DMA channel, full-duplex DMA disabled\n");
 		} else {
 			ctlr->can_dma = dws->dma_ops->can_dma;
 			ctlr->flags |= SPI_CONTROLLER_MUST_TX;
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index d0b1a03682e6..76d7814f0dcf 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -42,14 +42,19 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 
 	def_burst = dws->fifo_len / 2;
 
-	ret = dma_get_slave_caps(dws->rxchan, &caps);
-	if (!ret && caps.max_burst)
-		max_burst = caps.max_burst;
-	else
-		max_burst = DW_SPI_RX_BURST_LEVEL;
+	if (dws->rxchan) {
+		ret = dma_get_slave_caps(dws->rxchan, &caps);
+		if (!ret && caps.max_burst)
+			max_burst = caps.max_burst;
+		else
+			max_burst = DW_SPI_RX_BURST_LEVEL;
+
+		dws->rxburst = min(max_burst, def_burst);
+		dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
+	}
 
-	dws->rxburst = min(max_burst, def_burst);
-	dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
+	if (!dws->txchan)
+		return;
 
 	ret = dma_get_slave_caps(dws->txchan, &caps);
 	if (!ret && caps.max_burst)
@@ -74,20 +79,39 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 
 static int dw_spi_dma_caps_init(struct dw_spi *dws)
 {
-	struct dma_slave_caps tx, rx;
+	struct dma_slave_caps tx = {}, rx = {};
 	int ret;
 
-	ret = dma_get_slave_caps(dws->txchan, &tx);
-	if (ret)
-		return ret;
+	if (dws->txchan) {
+		ret = dma_get_slave_caps(dws->txchan, &tx);
+		if (ret)
+			return ret;
 
-	ret = dma_get_slave_caps(dws->rxchan, &rx);
-	if (ret)
-		return ret;
+		if (!(tx.directions & BIT(DMA_MEM_TO_DEV)))
+			return -ENXIO;
+	}
+
+	if (dws->rxchan) {
+		ret = dma_get_slave_caps(dws->rxchan, &rx);
+		if (ret)
+			return ret;
+
+		if (!(rx.directions & BIT(DMA_DEV_TO_MEM)))
+			return -ENXIO;
+	}
 
-	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
-	      rx.directions & BIT(DMA_DEV_TO_MEM)))
-		return -ENXIO;
+	/* With a single channel only one direction is available at a time */
+	if (!dws->rxchan) {
+		dws->dma_sg_burst = tx.max_sg_burst;
+		dws->dma_addr_widths = tx.dst_addr_widths;
+		return 0;
+	}
+
+	if (!dws->txchan) {
+		dws->dma_sg_burst = rx.max_sg_burst;
+		dws->dma_addr_widths = rx.src_addr_widths;
+		return 0;
+	}
 
 	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
 		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
@@ -169,40 +193,54 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 {
 	int ret;
 
+	dws->dma_nr_chans = 0;
+
 	dws->rxchan = dma_request_chan(dev, "rx");
 	if (IS_ERR(dws->rxchan)) {
 		ret = PTR_ERR(dws->rxchan);
 		dws->rxchan = NULL;
 		goto err_exit;
 	}
+	dws->dma_nr_chans++;
 
+	/*
+	 * Some platforms have only one DMA channel for the controller. Keep
+	 * the Rx channel in that case, it can still serve half-duplex
+	 * transfers.
+	 */
 	dws->txchan = dma_request_chan(dev, "tx");
 	if (IS_ERR(dws->txchan)) {
 		ret = PTR_ERR(dws->txchan);
 		dws->txchan = NULL;
-		goto free_rxchan;
+		if (ret == -EPROBE_DEFER)
+			goto free_rxchan;
+	} else {
+		dws->dma_nr_chans++;
 	}
 
-	dws->ctlr->dma_rx = dws->rxchan;
-	dws->ctlr->dma_tx = dws->txchan;
-
-	init_completion(&dws->dma_completion);
-
 	ret = dw_spi_dma_caps_init(dws);
 	if (ret)
 		goto free_txchan;
 
 	dw_spi_dma_maxburst_init(dws);
 
+	init_completion(&dws->dma_completion);
+
+	dws->ctlr->dma_rx = dws->rxchan;
+	dws->ctlr->dma_tx = dws->txchan;
+
 	return 0;
 
 free_txchan:
-	dma_release_channel(dws->txchan);
-	dws->txchan = NULL;
+	if (dws->txchan) {
+		dma_release_channel(dws->txchan);
+		dws->txchan = NULL;
+	}
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
 err_exit:
+	dws->dma_nr_chans = 0;
 	return ret;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index e62f919f1188..01eb24ae7fe0 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -227,6 +227,7 @@ struct dw_spi {
 	u32			txburst;
 	struct dma_chan		*rxchan;
 	u32			rxburst;
+	unsigned int		dma_nr_chans;
 	u32			dma_sg_burst;
 	u32			dma_addr_widths;
 	unsigned long		dma_chan_busy;
-- 
2.25.1

