Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C89315D29;
	Thu,  9 Jul 2026 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598397; cv=fail; b=hHR046QXIw5rAnfNaXYK6QJiYwASDz39H0kfmWsKZ7nXDv1M/CMxq244g3ndi6tntmib9dH2q5ZNag2KvYnqDSYFNU48FTW8FUnCL4rtas+zyIpJTNL8x8O2wRMz3+CHIwr5ZEJzm3KGVCO+B9zDsIgYdv8dTdD7z/Uy0+muIP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598397; c=relaxed/simple;
	bh=x3Jfct7UXO4u4fl51+VhRzrgw2+T+7TyRUbrLPSRz44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbwO1ESyBHHym3h46oVntHVdXKgJISRk6aViK+XdTeTIAlTP2sl5yRTY2eLxajFuj4huSR8aF7B3W2iqxSUiC/Rl2YG73H++n5J35qF8X+nCVCX5yXxDV8FhBqxb7nWrSlVDrH+PX9ZAqWHh7kJtljuCsctDZ93qENd7FycrKto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+Eh+syTTjcso89RMp6mZzSL7ziV0cdJqZMUxLMKgBeqPc66nAQcyedSawExqZU4/1KxgFRukk+RrX9yAaIPCSCU8+K5R6qXuztATZ8MyRMGxzlhWhP3MQ91FX4SgglPUp4HWu0CUEPSPrulUBn/xO0Z7Zek/0RP+RBNzdNNA1vd0STHp3XhHbLeethg7aLBbXS8z6Le0U+WaHbPyGD+AfYK1fp0vPyx7w8BC/0toq4qIquCIHYRYIc61uLwi55qaPw1h7GZbAWSONVGwSdy3AZPep2TaGk0JMA3G4yTDs9l3hY9Bq/IYQ8fWMqxgCOLfi3o4rv49m0/91QSY4LEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+ms3MxuK+n3WlSe/JpK/aNZi8skppQ+e6rvu8Xj7tU=;
 b=deqeBlKCP/5yn1o/bxMvqwM+4gOXzOcK42FZr5Zvc7bzbA8UoMXD8A20/gh751GtQHEVZYnNEsRIAvFqbXnuhSNIR2D6GcTOHNgC0VB+KfKJUS4vkV41tS6SlnZyfkgeqGvs7bEVBW0RcY3BQptgU7Obw3RcOdCk9zHp3dpeGbCUEkTIXwwmGfXE3f26NCWqV89YlSeH0PDKm0PIh42ZpX6tiSLPpPkBXg6KpaXvooaUzrktiXfNOd+VXdL7VUGvIgu2/qtSvaxwtcDZ6W7Nhj/dX+LM0wxGHzIYIzY7/8mMlb38KefZbLlHMtnlfk/z7U+lM+c2N/+v7Hu3Xd3hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:23 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:23 +0000
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
Subject: [PATCH v1 07/11] spi: dw: use irq handler for enhanced spi
Date: Wed,  8 Jul 2026 22:52:00 -0700
Message-Id: <20260709055204.138168-8-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: d73cc285-388f-41d8-0671-08dedd7e3f69
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LfTgCqEwIbH4pRcBsyZ1p12cgrwg/57dVHaDY58XAK9+thyLqqXN4J+leGQsUeEvYqjqKm7AGaa7pgXIzOsRXdaspWxPgTuoH7EVYx5xLZKylzl/VRXpyWAmW+Ww/wC1qViH5AV6c67Xfcn0CSDSVqzL4eBT2XUgLjcE184Hdpi3sYSgykcBdsrza5nVhA0hacoM/BlYZH2BGvd8WDZ6QdaL4hI8EDTgw1x2W/NqjydPn+8lQrYfRqSSTJT8IDbBfO/FfHskS7XSD9ousE+vAIkSXh/TfPwD7nrHRqG53HrwhB48ZVAi4mxAriXs1uNxV542BPgIQoy3I4688njpiRfD7IVVpuPyNLrNj9MRzYYfFJjQ/lEdM9e5ze9IMRGljzO2hcw02xCzsrcV3jbevylWiIicCUvqruDfegoX570zvvQnsbBNmNkqXruoeL21LPv28nCkKw0Biq6PQ/kFTeSV6fqyB35TuEo7R5+kICXObR9zJ027e8TIMOxeXkxi5sOewcJ+xao8rSSQk212k3WyIfKnvCxX0yoRTXpJHbOVjJb+ZCSJbapett/5Gi3g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7m4aAclgm+aFgZoEqfNuNLMxYxTxjee1rXIWZR6izecMWgYtX+CX8v+CdIB?=
 =?us-ascii?Q?QDxvD7gZsg/U6HgtCjLt60g7XXtXZ+xvh4sOT9fYQSRbAFWZ//JMIDwED19H?=
 =?us-ascii?Q?M59cbfxfSMlUmRhfhH9A5AnP2WLqaJ9LhV0reUsu1W7PJ8BKMLrYDAoEqJNE?=
 =?us-ascii?Q?cAfC4VZ8DU6hkU/QIOjhC6/FMItY9nEvEyls4i5U49+i4itMJHIg74dqcK/B?=
 =?us-ascii?Q?2Qyi5lQy8dWxUKETA8Bpc2MhKAGVu/VnXTlKi18K6ijSZAqrhTd908YZvDw8?=
 =?us-ascii?Q?DXZVRkq3BuCBFZ803lvfKcdwAfUexQC97I148DkgCNhslWkWa/fjrP+43VVv?=
 =?us-ascii?Q?Adi6Mvfpy75CT5aJnP1oBiaEronkr8M3swiUKxzCvELSU8Y2FWkBixaIQTok?=
 =?us-ascii?Q?YeR8e5VUXB2ia22iJ2900cwJC+PC/7yrnemukt1KrVwLh5Sg83lRkhmyH0p5?=
 =?us-ascii?Q?CxSwtxhAobJOCXlNFpqVXlhA2oE2tJI7V9u+AIFO2xfuCo8sflzWoaz6J8c8?=
 =?us-ascii?Q?axvTx6qqbGBAQmSGavmiEEJp58EWzUnNr8q0V0Y0v7gUIkb6HDgejx/brcWw?=
 =?us-ascii?Q?UHKcErCBlnLNVhN5KgJ+vXD1CiXkjE8mToFuKtMMEjNfjjSLeMiUWey0ObyL?=
 =?us-ascii?Q?t1uNIoQ9vPkZpgJyeMqx88AHhC/CY/yRXQoZIEPJA/R/D1UUoE4s3K8R43NK?=
 =?us-ascii?Q?W77tJzjieI3Wb8E+FFBsDr/YqFa7ZCyZShvTkGQDotZOo2E4hAQUVun3EH+2?=
 =?us-ascii?Q?1z8WpTRg2+NG16+zr7oAJDGIpthV8hJjJZN/5ACvGKJGKfuLvI6zrMxc38wa?=
 =?us-ascii?Q?BFjX3oYGsQBArtE11ig2Hj3ONx2UugrMVlGxu8XEd5ZjVqf2zrvWGtnI2ZM0?=
 =?us-ascii?Q?9X6+uVGRN5GZwLI5uozUZpZ1vlJyGNiIpeVmcRWhJlC1/YNj3vaGSgcETl1o?=
 =?us-ascii?Q?1hBILUAAI4VXcuva7teG0s6ZaQyoBvwnEaK13dqacje/DKB184o3eV5Qzj1+?=
 =?us-ascii?Q?KeWEENW+KbJHm4PHgWT1s7u8fZbRJCjF1FYpkXcFhTp6wtD3TNJBZ6jgu+Lo?=
 =?us-ascii?Q?yqfOKET54I3RA0ZkmtYtC4+pMqETbRqGN/sZcQq850WhRUbmwjlmn64CymiB?=
 =?us-ascii?Q?FdtFsgBl9aSD+oW8eSmwkaQy9xqHvQZ/I3biQ60mFjGI0Gs6Cd8Y4mfy8fFC?=
 =?us-ascii?Q?IDWYzh6RTP07twJdwGxCKZCcBFHB/Bn0ZrqJj1a/utQ5C5khxcno0q0VxAdT?=
 =?us-ascii?Q?2UnYYdttx+vllgUWfqcevMIbmTLV6p3k4g+Gd8Ii6M85VY7yTZPhHZhu0gMG?=
 =?us-ascii?Q?PQHS0VsADrO9yN6U66+T+OJ/R+GcHB6ItZUCzNPpbMJifHSk4aYy7pwlvzJ/?=
 =?us-ascii?Q?lH1GYzhzQVII7sPmeJ8wSnLdWkh8lZr7fVXBXwrQbw9PUplabXzwWcFofkh/?=
 =?us-ascii?Q?t4PvnqkynQ5lRVVID8uLgULo/5sknpWzbtgnCQv8pxkOYiWHSw/Ud9IThh8S?=
 =?us-ascii?Q?8GYXmyZLZahscjvbP4keQDd+a7B2JSYjusCt7PLjqxRd79jXo3WQTt7aoqGf?=
 =?us-ascii?Q?cx7RlP/grSMVjmTciGrDCixqgCuEO0oF9VXykGA/iS0vuZosRVYNfE+h3aZE?=
 =?us-ascii?Q?AsPGZl0rkkaJ0XEgACM1I2Cspnse7vGj9P64884Tucm00vjr950G8clkI84/?=
 =?us-ascii?Q?LDd+h0NuHjDlUAZCKMmbkjIDH6hHQAdG13CHVGZ1K3csi+qcj/VvVLq5EgkJ?=
 =?us-ascii?Q?TcwES7c8bZYeVIL7yPm84P7QPlEwyXpE3HsCUKZIzgIr/gl3xUA3?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73cc285-388f-41d8-0671-08dedd7e3f69
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:23.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O7kIeDsFLxeKcclgo48vCl7zw+ItbL75vQo9AGjzCafde8U9aj8+Kq3+ygN4FfOu5sIZtmVbYNgxPGYPpQy9YD6sJprAFx3+EBjHFM9anPoPhauS1gW4Z+tBQHLtun0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

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
 drivers/spi/spi-dw-core.c | 93 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 9f0f7e0b93a1..532441da235e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -248,6 +248,34 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
+{
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+
+	if (dw_spi_check_status(dws, false)) {
+		spi_finalize_current_transfer(dws->ctlr);
+		return IRQ_HANDLED;
+	}
+
+	if (irq_status & DW_SPI_INT_RXFI) {
+		dw_reader(dws);
+		if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR))
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
@@ -257,8 +285,15 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!ctlr->cur_msg) {
+	if (!ctlr->cur_msg && dws->transfer_handler ==
+	    dw_spi_transfer_handler) {
+		dw_spi_mask_intr(dws, 0xff);
+		return IRQ_HANDLED;
+	}
+	if (dws->transfer_handler == dw_spi_enh_handler &&
+	    !dws->rx_len && !dws->tx_len) {
 		dw_spi_mask_intr(dws, 0xff);
+		spi_finalize_current_transfer(ctlr);
 		return IRQ_HANDLED;
 	}
 
@@ -399,6 +434,34 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
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
+	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
+
+	dws->transfer_handler = dw_spi_enh_handler;
+
+	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
+		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
+	dw_spi_umask_intr(dws, imask);
+}
+
 /*
  * The iterative procedure of the poll-based transfer is simple: write as much
  * as possible to the Tx FIFO, wait until the pending to receive data is ready
@@ -855,6 +918,7 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	struct dw_spi_enh_cfg enh_cfg;
 	struct dw_spi_cfg cfg;
+	unsigned long long ms;
 
 	switch (op->data.buswidth) {
 	case 0:
@@ -906,9 +970,36 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_update_config(dws, mem->spi, &cfg, &enh_cfg);
 
+	dw_spi_mask_intr(dws, 0xff);
+	reinit_completion(&ctlr->xfer_completion);
 	dw_spi_enable_chip(dws, 1);
 
 	dw_spi_enh_write_cmd_addr(dws, op);
+	dw_spi_set_cs(mem->spi, false);
+
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
+
+	dw_spi_stop_mem_op(dws, mem->spi);
+
+	if (ms == 0)
+		return -EIO;
 
 	return 0;
 }
-- 
2.25.1

