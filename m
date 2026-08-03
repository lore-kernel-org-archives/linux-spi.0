Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA341D105;
	Mon,  3 Aug 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760882; cv=fail; b=Tp5nRJiCjQLf/AKI9uhO+Jsht1zaDMjMe4n+cMI1KFwNiRAeEFKY7wE4wxxTbdwMiq3Rtl55HgWIaTzLIpP0DjH0lTmAktv3A8gqyDzQPqI4B24iRTtl4GAI+6lsdJfNjdYs5mQKJAh26yHf/hXKKyTwxpoSXby4cG8maG/TMqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760882; c=relaxed/simple;
	bh=fMjBGJuftQ4itxplbELNhbcn8uLiesLzejnMepQBHWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtlwgoUBvaT3lGWEDNpaVCYVEupW84fPoH1PS/VAifsiAb05qxHNp3g2YbuBmzPKzfVyl1DPc6/4ccK8Xldm9avmeJ0oXufnU1QQ+1h/R7abVpF4rgv7vPi11YGlybt0mxP1rxl+DqcINNtAoo0mJlJv6C8kPfub8WbBiUM6XmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krh/6n+iNYNapBuVVGT5K7YO17ioi0cz0MkkEZt5V6EzP4i+vrzZeH3AsYPegSwxIQIzNB+3F34n7ld/3dA57gBFoTvtxC7+ywQMw/Q8r9Mr5mwLosHpxgEqMS70NmWXYz7aLSazkZkyAT40qacDCSr0q/5iUswO8uqQOVksXEWBbU7k515YuNsUqTHWNojABPud6ChQ8yyUzJS8fV5AoVqH/mQWzIObYHi3Nn2Z154qPciCEX8VbdSxmGHBlj572JCK941pYYnV2X86VrsGfZllM6rg34wMR+WCyiMFTKvptsY2ftIBDIvvIBdsCGoa9KxznnZtVg3sihHD3EROtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB7j7AzcCL3USNsS9n9R5b9FeR/aeolAQyvjSntYNvM=;
 b=UWSjqG1W5feBr+3cn/y32vCwiNDjdsUEQpIUwRI3w7IWqdnKlHo/zlcxrmEigpK1oj5wqQcrKcTo3KYiQVrsURtYV5novmyXx/3gU2QNuRbzbiWkR4G3e7Hn6THQBo1dcgtd8eJsyuTUzkhU8Ga/b0VYVbWIqytmON+LWyrC489w0RQffYit2Hj4QPJH3RMaFczXDs2nwIvDIqC9TnC+GwNzRF+kL9RLqd5ktqH5NbQFIvZod6mnqGHKdsegNbNKiZ9mvmLg0sQRlcdSPFafYW9+laGE/P5hhnKSYIUijAS/rigYsAZpTaeE7DFxpnHvg3kOBxHO7JuUVTFClLzGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:05 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:41:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 08/11] spi: dw: use irq handler for enhanced spi
Date: Mon,  3 Aug 2026 05:40:41 -0700
Message-Id: <20260803124044.156998-9-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
References: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::32) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 4356ef38-cc50-4a4f-2532-08def15c782b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RuNizyjraiqABwbJryRCeujQMbWijPOI5qq9KponisdjgvJG/C3uTw2XhdJTL6Ad4qJYwikKrcIsf6QR/oEIvZnFLQdCSgHXCslALrV0Aj9NFETwfIoIZOFNvvIREy5MOeHvdRv2DTxw8fexPJm2fNE0Vs/1JP0xG3TNCDKhuz8br97zyl557HMztGzy2gVZ302bS0/8mUuvMyIKL2e8yKWE43KqngiOYFv6IkP2G4PGdPDRfSj0xgUHr4K8gbqyE+dOeOP6jL0TXPo69ow38Uw9RfQMSm1Mpd+Hi89i26DIaMSjFlbyfQWWnH3CsOWsvzkpiG8S41ZNfO6OjOKBg0NmlQUI/JXipHiJiECwDnYWM7JZzrmFZzqp/UFMyXEhHq11kNpj31M42qy6WvEf+4PDwsn+0DLxNKEsNx6btad5MUh1BC46id04kSDb4zkb1JKFiD/S2U8JG/DJ0LM8bTFXeKLUos6IYMQc2uI4o7H+YXTwwAk06PKQO2rKISQzuBJCyANfn+DpiavrE0MB+nb0nCMXtgStbx8MlC6j8su1rfxGbop+BC1MIyZqDCVH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hjZGVk3OvDbkgp0oTNzrslRymBwIDptoXJzzSky0w4GuioLVWyStIfDGvbJ?=
 =?us-ascii?Q?i8bIvEjIbaDVc8xcuZS8GWz4FybXZkVr+xKKY3n6m2Wd5xar3xS72Eocy5Kl?=
 =?us-ascii?Q?0iUqcQRPG3XGBS4wXWh5n7Hc/ma70ETUctIHxsX1cy5+xr2gk3pl1+x4pJPV?=
 =?us-ascii?Q?b7UtG7YzKNQy4mo6XB+8zTOBj3NyG2ZpIAmEi4rmr0PbKQZEBNjq5emdQmwU?=
 =?us-ascii?Q?6WDmFPQCPwFsZLOXEPN3STWdjWTpiI2ohAsllZIjAmDCwuN78AZla90mps9U?=
 =?us-ascii?Q?eCwM84Y4Cv08VxjCaxicorqJ0pqLIxVeJSTHFaDy9xkoybId6TAO0pyEWXzR?=
 =?us-ascii?Q?WtBDw53kqUbggOk5N3ETj8Stldf/voYLq2SnKqQVwpvNnpKKFXTtb8JXjUU0?=
 =?us-ascii?Q?zgeVa6DCbLnhu516LCe8/iBJKDAn3MMeaFlDYl9KFvKR3ZyOCvXBxhVzLIov?=
 =?us-ascii?Q?tqX1rv3G/9gKgDI17J6lvFlOmjVQUINGiqeGLyMzSRg61hZ/CvP1GVnLuAWx?=
 =?us-ascii?Q?lJrIxnVEfyaWIQo3ebSXjDBVt52rIencyHbpqhkiBZSQCTvfrEuqdNxs9FZy?=
 =?us-ascii?Q?+et8nEj+i70ah3p+wJ5HSltJJkdFn37/Wex37XEflJzFwWF2OYZfryx1lNB6?=
 =?us-ascii?Q?I1RJFD5fOipTdLRMG4ZxzDde5i+kdQU7Fm+QwTWZ+jBm39zxbdKOfp6BSHT7?=
 =?us-ascii?Q?n6aPtxSEXN5nsDNHrhyEiH+4Zzt/vLy8NCXMrglzuXTsxQecF97+KFXI9D+2?=
 =?us-ascii?Q?enFFJYuTO3hWSJiIx0bN6DFssw19g/6CBVbHR5YMKHhxTPKOgy6Av0d2MCSc?=
 =?us-ascii?Q?MIZTHtnk8JLs0KQEni6wTvH0q0bjxAh4iOfuG++hj3T3tQLzumrG0CNFe1A6?=
 =?us-ascii?Q?dJOy6lKcVFV0WCsuMlCmFJK1lmHH6YPgHBUf0RO3VqGuAABWJa1UauhixoFb?=
 =?us-ascii?Q?afkaoxeHyT8Yri/SZFLesp/7ALADlXc7G5brsDmeu+uF2quojc5AE5jeCA4d?=
 =?us-ascii?Q?7+iD94N+nsxEr/syKBdA6KTSSq5Gj5iF+WGjz6NE6WSjiQonQIlvqKZW618v?=
 =?us-ascii?Q?nn1+beuzOKtjsz/h/gveHochtNNIhIcW7l18F3e/6gYSPhp9Z36YLP2dc1VY?=
 =?us-ascii?Q?Dic6ShFdTiiGht47t+7yNQ5+O28JNS7gttisnxNcbvmYBWYiTQaQDWV1NeRU?=
 =?us-ascii?Q?9LkP1Lgv8FS9Km3JqY0SfTzosnLL8ri40sqqJSx8GT1afZH9mdNsRw+HM8Cj?=
 =?us-ascii?Q?zIy7O8AjCmE2+D74sEeND+ziZ1z4shzcyosS1yG+MaIQdvxNxgHdLWJ1nwRb?=
 =?us-ascii?Q?dpwR9r9zBKnxHtj18TllnhVSdRC7pGKXTk47x70rbGwgO7IEeMMD9UDV7lSt?=
 =?us-ascii?Q?mWipNZQFvVyHsvJRjjTP0Tc1EP0Yc21Yo6fEorYmM7g6FU3iRX6qbcq5lwxS?=
 =?us-ascii?Q?mzoR/vjASvMqB/2YtOjC67PKtxibr2IyKupj2klpn5yXq82V1gKjheQOJpgn?=
 =?us-ascii?Q?Q0xpqH3iMulZ1Dhxa8cx7T9uBeB2M8LMQlkC5LIlHzmIxuamjvAzqEJ//48W?=
 =?us-ascii?Q?8qS1MLPrNZC2O4b9h40g1tmtxu08/djyM9xz/7kdy+fILRgtFAk9HRg6FCY2?=
 =?us-ascii?Q?WYx3GUzbNpeNJaIQ+m6jEFXjtjqOEVgPISi063S5FwM1SGfBZODwkO2j5ga1?=
 =?us-ascii?Q?jflOEF/twGP1b14ptJfLp6FUk5GfYjt4GBSngN+c9ExPOodlOGVrCR4duQGJ?=
 =?us-ascii?Q?2XcrRdTvKGYxaXoYTtV32t5fLVXjWRStl7a/cQzmWeCfdj/h5ODP?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4356ef38-cc50-4a4f-2532-08def15c782b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:58.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teofeLuudVYrkyaEe5G1qYdQQZlBgnNL0Wo7Y5Z7xhPK+0QcTgsVmHG9aAoJh8LLKPhgsUJTi0SgXID23PpTirBXcfWGDqe/y33tE81vBto4UCVOZmQd1OA6U2xCppb3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

Introduce the interrupt handler for enhanced spi to read or write based
on the generated irq. Also, use the xfer_completion from spi_controller
to wait for a timeout or completion from irq handler.

In enhanced mode we need to calculate RXFTLR based on the length of data
we are expecting to receive or the fifo length.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 106 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2b3149ac64b3..a1c6fa1a780b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -248,6 +248,29 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
+{
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+
+	if (irq_status & DW_SPI_INT_RXFI) {
+		dw_reader(dws);
+		if (dws->rx_len && dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR))
+			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
+	}
+
+	if (irq_status & DW_SPI_INT_TXEI)
+		dw_writer(dws);
+
+	if (!dws->tx_len && dws->rx_len) {
+		dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
+	} else if (!dws->rx_len && !dws->tx_len) {
+		dw_spi_mask_intr(dws, 0xff);
+		spi_finalize_current_transfer(dws->ctlr);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *ctlr = dev_id;
@@ -257,10 +280,17 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!ctlr->cur_msg) {
+	if (!dws->transfer_handler ||
+	    (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler)) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
+	if (dws->transfer_handler == dw_spi_enh_handler &&
+	    !dws->rx_len && !dws->tx_len) {
+		dw_spi_mask_intr(dws, 0xff);
+		spi_finalize_current_transfer(ctlr);
+		return IRQ_HANDLED;
+	}
 
 	return dws->transfer_handler(dws);
 }
@@ -399,6 +429,33 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 	dw_spi_umask_intr(dws, imask);
 }
 
+static void dw_spi_enh_irq_setup(struct dw_spi *dws)
+{
+	u16 level;
+	u8 imask;
+
+	/*
+	 * Originally Tx and Rx data lengths match. Rx FIFO Threshold level
+	 * will be adjusted at the final stage of the IRQ-based SPI transfer
+	 * execution so not to lose the leftover of the incoming data.
+	 */
+	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);
+	dw_writel(dws, DW_SPI_TXFTLR, level);
+
+	/*
+	 * In enhanced mode if we are reading then tx_len is 0 as we
+	 * have nothing to transmit. Calculate DW_SPI_RXFTLR with
+	 * rx_len.
+	 */
+	level = min_t(unsigned int, dws->fifo_len / 2, dws->rx_len);
+	dw_writel(dws, DW_SPI_RXFTLR, level ? level - 1 : 0);
+
+	dws->transfer_handler = dw_spi_enh_handler;
+
+	imask = DW_SPI_INT_TXEI | DW_SPI_INT_RXFI;
+	dw_spi_umask_intr(dws, imask);
+}
+
 /*
  * The iterative procedure of the poll-based transfer is simple: write as much
  * as possible to the Tx FIFO, wait until the pending to receive data is ready
@@ -868,6 +925,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	struct dw_spi_enh_cfg enh_cfg = {0};
 	struct dw_spi_cfg cfg = {0};
+	unsigned long long ms;
+	int ret;
 
 	switch (op->data.buswidth) {
 	case 0:
@@ -920,11 +979,54 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_update_config(dws, mem->spi, &cfg, &enh_cfg);
 
+	dw_spi_mask_intr(dws, 0xff);
+	reinit_completion(&ctlr->xfer_completion);
 	dw_spi_enable_chip(dws, 1);
 
 	dw_spi_enh_write_cmd_addr(dws, op);
+	dw_spi_set_cs(mem->spi, false);
 
-	return 0;
+	/*
+	 * FIXME: The exact reason for this delay is not fully understood,
+	 * but empirical testing shows it significantly improves the stability
+	 * of read/write operations. Without this delay, occasional transfer
+	 * errors or timeouts may occur under certain conditions.
+	 * Keeping it as a safeguard based on practical validation.
+	 */
+	udelay(5);
+
+	dw_spi_enh_irq_setup(dws);
+
+	/* Use timeout calculation from spi_transfer_wait() */
+	ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
+	do_div(ms, dws->current_freq);
+
+	/*
+	 * Increase it twice and add 200 ms tolerance, use
+	 * predefined maximum in case of overflow.
+	 */
+	ms += ms + 200;
+	if (ms > UINT_MAX)
+		ms = UINT_MAX;
+
+	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+					 msecs_to_jiffies(ms));
+	if (ms == 0) {
+		dw_spi_mask_intr(dws, 0xff);
+		synchronize_irq(dws->irq);
+		dws->rx = NULL;
+		dws->tx = NULL;
+		dws->rx_len = 0;
+		dws->tx_len = 0;
+		dw_spi_stop_mem_op(dws, mem->spi);
+		return -EIO;
+	}
+
+	ret = dw_spi_wait_mem_op_done(dws);
+
+	dw_spi_stop_mem_op(dws, mem->spi);
+
+	return ret;
 }
 
 /*
-- 
2.25.1

