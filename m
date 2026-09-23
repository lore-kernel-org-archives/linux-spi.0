Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653C426D2E;
	Wed, 23 Sep 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158384; cv=fail; b=KtO+DaDasZhN3dekVDga9yhei0vViqtHKvfS6BjA4bLVkQqDMtuM3TznJvewKhjMWhw+8x95gZ+63ZENezvuj5d5C2+9zl8eDYfQScGI/xAsjNRN7PaAxAxZe320ejmnbfXlbxjFNkK8RJT47hUExr02NN3QOcbW1JrH92f465k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158384; c=relaxed/simple;
	bh=po00FS1QIH06G04R3u2SqCzArUbkIXfKrIoCYNUPi4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CW7gUWwjtr1izNEo9je1aiFot7Tzss8Mw5Nuzue+GqJNv5s8g1ybq4Pa2TYI0c/L1eYXWQTOdj/+P3+bE+5yBpC7uqthEv+jcBSL7+KvKiZpPHohlmVmkr4tW/B9kqDk4UG7ctdLUChNwpGX/ARa6cJ9ZkhxxJu+ySXRol7Ty+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+15bJfbON2fV9BGal/ND/dBzuS6iP0vbBcLACf/h5A1OsjpZ1KVaWC2QwSpYT0R0r9anFEytkixGd/LTizYaRyNyEDIp7Uzx7OWS82SJmX+ob3hflMkAP5Y+1XGG8JKu2iZVAq9yilBdjl8l/E5olcIaXrHa6AhJWEYAB7r1nrNNKZBf5wHd9HBuO1GoRQFDXO/1KbEaVP6j++UEHGa5X4RTSFBxu8FYy2ZTCdUUNG0kp9sVe4oAoYB69TnjzDx7KiKd64Q+zgluPdS6qDBm73WMpCXJV02HB0b4Ad7ZMyiDiD6UYxU9N9j49vtxIGp/ADAwBPdb+79elMJ3KbogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6qquyhWraK7r/WB1mjcU4LKyjIIS55+zLF08+Q9FtQ=;
 b=bopep4nCeOX6FjfHSZFy8Xu9yG5XPyEFfNZk+3NpX1IfQJZnmbzDseKlvPHxLgW1DP9qMdpbofkBPX7xt7X7KghcofKFeAWAQ+t1V+AvPCT98cHA0X4uODEmP16ExNC0MSOZ0wg0G6yl96U/G0ZIv5N1Wv/bHL4ahopvfWBdfiriCRN3RMRUbMZZAyM795NU6jv8STw9SLfBDQmhmsLRoAG/gyS/OSRDpL5d/8nqhGa/YNAODBeKmN2zIFuc8fIOxhAggDSqqcx3J7qW01olUnr6mGAl03mEXsqA00OKncw+1S2XW8CZuD5RXdIbkazQNegv9CHTA/v2toQkbq42lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1219.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 09:57:13 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Wed, 23 Sep 2026 09:57:13 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 1/2] spi: dw: Request DMA channels at runtime instead of probe
Date: Wed, 23 Sep 2026 02:57:04 -0700
Message-Id: <20260923095705.233297-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
References: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 346735f5-75d1-46d5-73ea-08df19590ad8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PRlyT83aj7TmDbPmnKdS6tsgyaQFg7VM+dyeOxjybLUh7bUqw1gL276cXAYzXvNhxADQbQg0D9/qQPaQx6Lv8VwixAO/J9FkiT/QZZ6lphVg9I9wYcQRwIoYfF4NPjl1gTOSfM1RvUJMiqk6KoD4zx7vGyrFl0Nz1KH/79bSPWGfSARcrAXXRpdOEDuk15qba+xpMh9zhAfp/jn27DXWOc6zZ6D8OlVvhVPzo7L9enBgbBdIz29dd84OVsgWlXQkfyh+cc+zp4zj4r0ySsVqv/aPFLW1oQyLS8N9g6usVFCOWrdAWNlStNVec7Ze3zJHCAbHQM942ag6l9OSii4RxXToaH98LcH9E20GmCK17+nVU6FlR8k3X2lIMh5RbXNDUS7JqeySdTe39C2PbfYW4LWd9Cko6PGDl9Zju+ydnqJEVljRBHs2v/FbDunpK+UpS5iARtlM1po0IUOtRxgs1wwuxLx0L5Ra7zLzUONQ8rPtof8haft/kDpBc1CGimtIor0tprkpZzrNnHHNWs3spimBD2pi3gGF4fXX/zBBgnMqsyWu42jLNxlKfiPoMM2q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jP1psnMD9tvl+T7PgPAqhUKLSXV0KG+cIZ6CH6kHAOApJ/BBIjZCiUGIWL5M?=
 =?us-ascii?Q?gadtxP6UXr+owA4Rn5YFaP4cdg/ivSBbG5eu47W4BdybKKHmEAS1Nu5LctzG?=
 =?us-ascii?Q?pvBWKe7sLnmB6cgSW0GBhkFfncj7ZsYk+xn50Ey2qcxCvhM6YJVHKddAtJdi?=
 =?us-ascii?Q?WpixuU0BvrXubxiFL81s34A2+4n6AbGYiqjE1RqxCpldT3up8JdEUW8UiLPa?=
 =?us-ascii?Q?FG6aOCzN2PUzC7diRMWDkhnMs74nNhGA1C2UZmJcaZxcpT7CxsbuJ15SE9cl?=
 =?us-ascii?Q?N9A47kkVi44vyWmbR0D6KqyP5JpH1blrWE/WEI6k3ZScTX81aZeXEDUfG4eM?=
 =?us-ascii?Q?Zn7EstfvUX9U5ZTNDNQwGnjyr4Him8FGhgnsZPEbZmbaN/GmjH20zYzmHGPh?=
 =?us-ascii?Q?kWriIW3utanqHBOI3Wyigo/u/ITRenhr94uIgH9FGmDFVBts892bIW7k4wLb?=
 =?us-ascii?Q?R+9ZwcpuH3AQ2nc/XM491KuCItEO6AgnApHuq4xjE3ho1lfnCJmQHgQPjF7B?=
 =?us-ascii?Q?ghhTKk7wMSYWazhzRloJNjrzJ25ApnFwS83sd+vdutK5SYUNsNKSyfBqPRZh?=
 =?us-ascii?Q?4AkosrZ68XtDnsBiuD4TFkxz4g5NM2plPPM75nHSpHziyTv9DVENgDKXqRvi?=
 =?us-ascii?Q?JqIy9rpLTE/SBeS65fJKIINuvgmq4xuBj24dBrUBQFI8ondwhRgLxIl4UohA?=
 =?us-ascii?Q?TRtGdWgkYw3WzXN3dAxsgg30k5dQGRbpRCpVPP7ALOqIbGQ7tD2dFWEG5dmS?=
 =?us-ascii?Q?WBKwtz7CKgUZMMvhiGgBn6YBSdhWrEkJdHB5fEUxdkr5fX8//38CX0XmBe63?=
 =?us-ascii?Q?H5JzGNVrXrWf6jyBx6/jXFNycAbmMlu5wP0OX2YUSn6vSi2z3t8L0mu7Topy?=
 =?us-ascii?Q?0DRCDC2c9dzKSsmrhui4oh9BZf6+u4rfp9yWK9tbogTRjQVc3etuWMxI63z/?=
 =?us-ascii?Q?NJFrtDeTCCSJEzX4swXdIwyuujt3p9LWJRkbjbV9r1r6rKWe77Eqmi21dIgG?=
 =?us-ascii?Q?8EMVUbibfcSgrQPPSbiF9rUzDUWu5oQQGiMPo2J3HpkV8ELoAXZYItyiDoIa?=
 =?us-ascii?Q?nrQLfZ2yHRDqWXKT+S2BQoa78Rsr11IGfDZVH/znAvLNn/h5c0NoAIjWLNwK?=
 =?us-ascii?Q?/r26R7lHO8QfDbVJvfk9SyxAkKwQLL5iL7+Ml+iC+ibh5sUG5FiZnQwGAPmU?=
 =?us-ascii?Q?hH4UxapiNq/wO1lOkeWIXWoX4N5mNPBKOdqrb9F9GjFIB/11bqWrV1maYnmt?=
 =?us-ascii?Q?syv5txFnNMogXwrlvxnvG75RjfFBa42IHm2oHRZ24pu78BkYA9v1Vs1LvvDg?=
 =?us-ascii?Q?xSCZvIr9U0kR/sROOHyp5YxiIpFpyqRz3CCbFu2uaLW10tbxXTUXRiXArvq6?=
 =?us-ascii?Q?pMlI6CgyqvvRVS55BkpAHV472TkkiB7v1+FTu/g7Le5+VzakOophDzeN0av+?=
 =?us-ascii?Q?1OY+mb3wIOqz9ALZSTUK9km3VSrwhAUbRiJvm7piHeTfM206rlw1iYxg/81i?=
 =?us-ascii?Q?+MywuviniiyiCIYua50h3lyhP9xy4FaG6MJVjEWUuP23c7q5FQaDBx3j/JeH?=
 =?us-ascii?Q?J9nujaFKqIGA19VFVSoHN6EEdh4UDXjBaJkhXY9JNzkCcaci0Sle8uVqRg6k?=
 =?us-ascii?Q?FfKPK5P8MbKBDh2SOuhJMUTcz1md7xJAOWPu8BgraHOMa49spKNLmc4OOdyL?=
 =?us-ascii?Q?6XHb6jUYKzRdzBw1PQwhD8s4EYG0BrT30A8t5tgomR9nMJ7O7AqnAxgA1Pto?=
 =?us-ascii?Q?vMRUt4dezQ9fP+rlqeugOF816S6x/0veO1fwMySkUWt1q/tm7m5P?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346735f5-75d1-46d5-73ea-08df19590ad8
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:57:13.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ4Uf9v23TcW5NOK3mOLBcZLIcYnPDmA3lm4xohUV4ro7nnXA5eQHBnfJNMT+GcStQoln+i7QV2SPmD8fHlVYJUD+UzdTiaB57LVBwLSsa3AjVRQbgzXILxz8eKGnDLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1219

The DW SPI controller requests its DMA channels in
dw_spi_add_controller(), which ties them up for the entire lifetime of
the controller. Even a controller that is only ever used for standard
SPI transfers and never for enhanced SPI transfers holds the channels
exclusively from probe onwards, preventing them from being shared with
other users.

At probe time, first check whether the controller has DMA channels,
and release them immediately after the check. Remove the DMA channel
release from the remove path. Implement prepare_transfer_hardware()
and unprepare_transfer_hardware() to acquire and release the channels
later at runtime. This ensures that the DMA channels can be
time-multiplexed between enhanced SPI and standard SPI.

Since DMA is no longer set up at probe and torn down at remove.
dw_spi_dma_exit() now also clears txchan/rxchan, the controller's
dma_tx/dma_rx pointers, so that the state is consistent across
repeated prepare/unprepare cycles. Also check whether the channels
are valid in dw_spi_can_dma().

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 47 ++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw-dma.c  |  8 +++++++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 206d3f9dd83d..04a5b48373e1 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -545,6 +545,39 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 	return 1;
 }
 
+static int dw_spi_prepare_hardware(struct spi_controller *ctlr)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	if (!ctlr->can_dma)
+		return 0;
+
+	ret = dws->dma_ops->dma_init(ctlr->dev.parent, dws);
+	if (ret) {
+		/*
+		 * DMA is optional: fall back to the PIO/IRQ path instead of
+		 * failing the message. Use dev_dbg() since this may happen
+		 * on every prepare.
+		 */
+		dev_dbg(&ctlr->dev, "DMA init failed (%d), using PIO\n", ret);
+
+		return 0;
+	}
+
+	return 0;
+}
+
+static int dw_spi_unprepare_hardware(struct spi_controller *ctlr)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+
+	if (dws->dma_ops && dws->dma_ops->dma_exit)
+		dws->dma_ops->dma_exit(dws);
+
+	return 0;
+}
+
 static inline void dw_spi_abort(struct spi_controller *ctlr)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
@@ -1330,6 +1363,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	ctlr->setup = dw_spi_setup;
 	ctlr->cleanup = dw_spi_cleanup;
 	ctlr->transfer_one = dw_spi_transfer_one;
+	ctlr->prepare_transfer_hardware = dw_spi_prepare_hardware;
+	ctlr->unprepare_transfer_hardware = dw_spi_unprepare_hardware;
 	ctlr->handle_err = dw_spi_handle_err;
 	ctlr->auto_runtime_pm = true;
 
@@ -1354,13 +1389,14 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	device_property_read_u32(dev, "rx-sample-delay-ns",
 				 &dws->def_rx_sample_dly_ns);
 
-	if (dws->dma_ops && dws->dma_ops->dma_init) {
+	if (dws->dma_ops && dws->dma_ops->dma_init && dws->dma_ops->dma_exit) {
 		ret = dws->dma_ops->dma_init(dev, dws);
 		if (ret == -EPROBE_DEFER) {
 			goto err_free_irq;
 		} else if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 		} else {
+			dws->dma_ops->dma_exit(dws);
 			ctlr->can_dma = dws->dma_ops->can_dma;
 			ctlr->flags |= SPI_CONTROLLER_MUST_TX;
 		}
@@ -1369,15 +1405,13 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err_probe(dev, ret, "problem registering spi controller\n");
-		goto err_dma_exit;
+		goto err_disable_ctlr;
 	}
 
 	dw_spi_debugfs_init(dws);
 	return 0;
 
-err_dma_exit:
-	if (dws->dma_ops && dws->dma_ops->dma_exit)
-		dws->dma_ops->dma_exit(dws);
+err_disable_ctlr:
 	dw_spi_enable_chip(dws, 0);
 err_free_irq:
 	free_irq(dws->irq, ctlr);
@@ -1393,9 +1427,6 @@ void dw_spi_remove_controller(struct dw_spi *dws)
 
 	spi_unregister_controller(dws->ctlr);
 
-	if (dws->dma_ops && dws->dma_ops->dma_exit)
-		dws->dma_ops->dma_exit(dws);
-
 	dw_spi_shutdown_chip(dws);
 
 	free_irq(dws->irq, dws->ctlr);
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f7d848fec9ab..022eb4fae33d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -211,11 +211,15 @@ static void dw_spi_dma_exit(struct dw_spi *dws)
 	if (dws->txchan) {
 		dmaengine_terminate_sync(dws->txchan);
 		dma_release_channel(dws->txchan);
+		dws->txchan = NULL;
+		dws->ctlr->dma_tx = NULL;
 	}
 
 	if (dws->rxchan) {
 		dmaengine_terminate_sync(dws->rxchan);
 		dma_release_channel(dws->rxchan);
+		dws->rxchan = NULL;
+		dws->ctlr->dma_rx = NULL;
 	}
 }
 
@@ -249,6 +253,10 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 	enum dma_slave_buswidth dma_bus_width;
 	u8 n_bytes = roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word));
 
+	/* Channels are acquired at runtime and may be unavailable */
+	if (!dws->txchan || !dws->rxchan)
+		return false;
+
 	if (xfer->len <= dws->fifo_len)
 		return false;
 
-- 
2.25.1

