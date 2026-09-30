Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A0466B58;
	Wed, 30 Sep 2026 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752572; cv=fail; b=j+bmRj9m/BtQA2azSF4woDSMhY/2TM6NnmPmNulg8HgsLvc9xl6guMd3Kqw1oApvuuh3jX6KJDh7hi1/76mHMIsN0qg6py4ve20DsEZz+8tg+8K6Tvl7H4V0T3HizW0uC8gIsWT7y26XIDdp+hyQnBX6hxYE4yKfXuenKXw500c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752572; c=relaxed/simple;
	bh=oSwyAzQ2jAo6cblZqLEdkZPOfSBn1cTLMrmbM+1gX0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+Zrf4u9hLrDDgVITNqiYdjK0sm0cn0ClBl3ClmCtC3DAC1fTSacHLK5ZhGrh8TBvG9qMOaPdCXrwQUJdQDVRK1Zdgsnrk+h/ylBEnHzlugE+xAwe/1LxzyMinjqTcnE2s9VGuAkBESVBmr9bdphYFjXVZ3ZSfCmJLJyJ+rWdY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrj+RAq3zYSeiQxQ9ehfj2+MHBKusKgQoYBM52Q25ExT8YOnNl7TosaVZ9RQTF4Re0lscKihLAP1OOes3HBnmzMumirYlyicvH0B4mqwyvlvUkb97pomDd67CidWBbWVeP5ooZ0akczZWdcfzNfBsDObmC8wIEVFXrwNPSM7P9zSbtVT9vnogkzeR6i8xXKP52UNVK8nlWbINYNlQidLtSMFVZOwvu8OM+unvpHXrkUigd0t1QgEHhnu89iNVykdtXjPE11EMu/lLy/ENUhnZ8pyndpTjXVGbAzShbIHB4z5EgoQTmsrjVl3wE2vU9T9QdbRBGF4/NRK+y8wX13xOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDe76KR6FlFVfWA0i8dpExkuCPxebWaZxofRcS6qWQk=;
 b=Fl0iLnGoDj/hEMFiNZuyYKmgyfkDKkzeX3XIpXti1jWWpudHIufWAlOGhHADHOKL4XsW9Wp4ekjwrYxzciFjhZhO14Rdgh46QRl4ZJuebRrhJZLT5NYOLoMh3VvPh31DHu5y9hxVmLyXsScqC9Dl7OBKO50eOlkAAx8x8gyg14P/+U3ySo24xRsm2/bBk/FTOeT/GnqMrMCbR2SzreuQ1RxlbgpGmCb8j06R6mhBeh4gxXXZhRSeMYEyMU1r26bIVKHv8OeLiKTuu9FEjftyWoT5z/tdo8TefU4llJW1RmbJnVGzi/OE9ONlOAapC2jPCXxHepA+u0fs385tJ7GbAw==
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
Subject: [PATCH v2 3/3] spi: dw: Add DMA support for enhanced memory operations
Date: Wed, 30 Sep 2026 00:15:35 -0700
Message-Id: <20260930071535.7947-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3663ca2-bd88-4e4e-3ef2-08df1ec2a68a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+OUT0NZDkKHtZeF05ld8yKM3oyaw1P9umYa6iORIAQs+YMzBdouEXmHRFNaR570FHdqYnD8bIdaYg2cQEXciDj/gIIM/ATxymDhBqcThM6Res5nrJ6wxCytMnWiQSnOco2Hdmwy4tDY2JpeyN8mRKuI2To0nrJmxeesLtkmn+2OfxZ0QEvCFas0T2goV8XZ6Ruy5huJa47tjdw/lnzpiqjMFh0FYtQhn+1TfBv98N9DF7wWHsSH2XtSmXPTJONH6hjgsWXCHVNq9VsjDkoip4BfykjcRRZQVZqhcXX83tbgu8pI4Ac7srMic7xoD4uvGBhnBjx2worE23y2a1y9Jng2XVKXz+8IjHlhD3sxWix/ELkeVjnhbZnKRy7pS7aH0aYU/7KzhFBlWVINx2+9mw+FdXMLY4RNztbmyLz7QujAU0w8cbTPW5af8oNI0UJsnoYCind95P8Fe5Kx7Xb/+UtuUGWXJ1D9KXrFTW7Ozqrsps+vSHhRnDpqpXwsvZ/nXVtVmoE1XHtLKWl1zHw7P4ttBkqTlqYl5ebPeVHLtnLJtpygK3g2qYOSmEfJzmJJs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvzZeGBV3K1WD+FjdIJutm1vvm5YEgJCXg+ykqEc2g9I4V79hhZccA0QmvIL?=
 =?us-ascii?Q?bOToGafXfl4ZY4uVcyobV3701/fBTSgOddvTthkFgiVocTmmY9TVl6gb2Gvh?=
 =?us-ascii?Q?S8nJtt436pqRbXBHods89kgNyN4pY3RGMWL2AA7gnadP86V4PS8hQau+JAz3?=
 =?us-ascii?Q?ZJRVRfRoGku6y6kFjQhsJPT+bHQMLAcHVhCFwF8XA5HY2pOFFKSl1BUKF2Ra?=
 =?us-ascii?Q?apooYUIW9VsIwv3htdZaZBik96FQKwH5USsVEhRF5rUq0UPh7SogvE00+TLz?=
 =?us-ascii?Q?KqeCkL+hhlG6cdZqbwMIqAMjiEyzwhEue3xIMU+kybxLteKwy/ttkMajDuV6?=
 =?us-ascii?Q?VsQQqJhuAOQf1kEqWuFoMqpjEnvOF1D3lmhP12qVI5aPmWvXq92b4Yp8sOt4?=
 =?us-ascii?Q?Ts7Jsf65HyHnpHrdPBdKSxBZdES1Zio7DgDVvxYG1z3SiP6Dbh5bLL5L5yQ6?=
 =?us-ascii?Q?v1j94GAgiPtNgSzJp7BEPgVIKvfVg5Rp4gTyMU53Vf8q8peMxQuuXTrMKRg5?=
 =?us-ascii?Q?GLF2dhSTan2MmiF7bQn6cYEreZrzIFnVVAiCn5jYNDiLNiQIZu0vbWPUh0zp?=
 =?us-ascii?Q?4rTjPq3JN2vI9p2p7joS5PUDxzvN4hyUnaEY2iIWDBT7Z6ekxj9PaueaAx+g?=
 =?us-ascii?Q?TLUvJjV4pj91XncDVmlOxlSnVvMsqUIid3dwlGU3p/6l59vfYcZz72TVmAls?=
 =?us-ascii?Q?sZZfhRByhmoNBFBqDz9jxz7XnPIQLuxfVTl3uCz0fLPSp0+4m4MaJCZNIZqS?=
 =?us-ascii?Q?gDFXnzmmuFYq6BswK7LJJnO4ajq4XzupggbsXTVBl7rJOXBzC7yf4wfuZDpS?=
 =?us-ascii?Q?+R8G0Qcjk3Ztu6rJNoEr/CN+TYPqjDsUFzWGnZq0J/NiJwAhoSQOq/mETq+l?=
 =?us-ascii?Q?9DkIXLh/uRGOxalR73VbT9w5wdGnNn0dHyKH2E2QqDWjJSUayXUobo0PYIFi?=
 =?us-ascii?Q?TA890EH3NnqFBini5+JulyHalgo/I7cMQkSyUVYXYsALGpdMQFkzDacV2zex?=
 =?us-ascii?Q?3A0dQ4KuM8IbY803vH851tZ13M1CxMeB8yzG8F5X9WUvEY+COhwg4RHZ4PUQ?=
 =?us-ascii?Q?5fyMo3vqHLpg08rLHazH2TaS3bRb0uuhQeI1V93n/uCHESF2N8NzXGOABesw?=
 =?us-ascii?Q?5FhbnpWRK4yV8Rha8C68/zSbn1+IqJ2SJevIONB+gfx6/uEMy4LxiXAgbI9X?=
 =?us-ascii?Q?54yUgLEJYgpv4F9KR5PNN0oC2BQPBLeK/M8OxEwrcL8zc/o1YWV9CrocyZcJ?=
 =?us-ascii?Q?dunEkv5EQ6slBBc5cUTRUE2C+R+sIgXPbkXaIVNNgzrnQ+nBtKFeDe6K2WBQ?=
 =?us-ascii?Q?hnwr2Ty1RKyCGMKWRyqDA5R/TVB6riJ/wZ3K9jiOQW2+ULaVrN5Kna3wp/Hl?=
 =?us-ascii?Q?Tsmvx9BDVJDrmM8j12aqqbX9Cwu1CK02IXszBlDq95bsGjzzjIRFnIYCK24n?=
 =?us-ascii?Q?jcnHLSpHaPDQY6a1jMqWHYM+46bB6CuWTkQ2q9Tl4oMfTAtsv/ZeBAOY0ll3?=
 =?us-ascii?Q?Fcd0wM65dMg8scY5P/glKTqfgJr+pewcbK3RdnQvW4T4ineSiNSvLrJeEnQI?=
 =?us-ascii?Q?BWGRAGS85s6vJtWGAAzbWkDZ+Hov3IKuqip8Ix2PMHvK0VQ4v1R3JoPuZTsi?=
 =?us-ascii?Q?hvvqqDRzM5v7SdBzqGqRh0K1tGqSNoe/KkUnBPc2ww9Yz2bNbCRmeJquZ7RJ?=
 =?us-ascii?Q?gW3qU89794RnnLHP3Y7H9IymuIDiJjGD4TNEMbpde5iAarYRCMagxxJ4gQvU?=
 =?us-ascii?Q?83RYsZw8IWaI7j0U17JiRF3QMEDfdfE/yFnf4Dl+nt44DDGbP9nN?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3663ca2-bd88-4e4e-3ef2-08df1ec2a68a
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:15:47.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MULtDyEKO7iae8xER03hDvc2vgorwJxmibpgV1/LJBa/El6qwbq7AQIzdfmxC8AVSx5TPVFOkNyPc7jFuq5/3FVmmESkQYykJcQb8xWTP0r0GOxkmFppbSWrPqYL6f4N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Implement DMA support for enhanced SPI memory operations. These
operations are half-duplex, so they work with either one or two DMA
channels.

Add enhanced memory DMA callbacks (get_chan, setup, can_dma, transfer)
to struct dw_spi_dma_ops and hook them into the generic DMA operations.
They reuse the existing channel configuration, submission and wait
helpers.

With two channels, both are requested at probe time and kept for the
lifetime of the controller. With a single channel, as on JHB100, the
channel is bound to one direction by its "tx"/"rx" DMA specifier. The
channel currently held (dws->txchan or dws->rxchan) records which
direction it serves. It is reused as long as the direction stays the
same, and only released and requested for the other direction when
the transfer direction changes.

In dw_spi_exec_enh_mem_op(), record the direction in dws->tx_dir and
use the DMA path when a channel is available for that direction,
can_dma_enh_mem() accepts the transfer, and the transfer exceeds the
FIFO length; otherwise fall back to the interrupt path.

Also move the udelay(5) workaround into dw_spi_enh_write_cmd_addr() so
it applies to both paths, and enable the generic DMA setup in
dw_spi_jhb100_init().

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 100 +++++++++++++--------
 drivers/spi/spi-dw-dma.c  | 182 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw-mmio.c |   2 +
 drivers/spi/spi-dw.h      |   7 ++
 4 files changed, 255 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 6889f4446ecb..892b3a8787eb 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -937,6 +937,15 @@ static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_o
 
 		dw_spi_set_cs(mem->spi, false);
 	}
+
+	/*
+	 * FIXME: The exact reason for this delay is not fully understood,
+	 * but empirical testing shows it significantly improves the stability
+	 * of read/write operations. Without this delay, occasional transfer
+	 * errors or timeouts may occur under certain conditions.
+	 * Keeping it as a safeguard based on practical validation.
+	 */
+	udelay(5);
 }
 
 static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
@@ -948,6 +957,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	unsigned long long ms;
 	int ret;
 
+	dws->dma_mapped = false;
+
 	switch (op->data.buswidth) {
 	case 0:
 	case 1:
@@ -971,10 +982,13 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	cfg.dfs = 8;
 	cfg.freq = clamp(op->max_freq, 0U, dws->max_mem_freq);
 	cfg.ndf = op->data.nbytes;
-	if (op->data.dir == SPI_MEM_DATA_IN)
+	if (op->data.dir == SPI_MEM_DATA_IN) {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
-	else
+		dws->tx_dir = false;
+	} else {
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
+		dws->tx_dir = true;
+	}
 
 	if (op->data.buswidth == op->addr.buswidth &&
 	    op->data.buswidth == op->cmd.buswidth)
@@ -1010,47 +1024,61 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 		}
 	}
 
-	dw_spi_enh_write_cmd_addr(dws, op, mem);
+	if (dws->dma_nr_chans && dws->dma_ops->dma_enh_mem_get_chan &&
+	    op->data.nbytes > dws->fifo_len) {
+		ret = dws->dma_ops->dma_enh_mem_get_chan(ctlr->dev.parent, dws);
+		if (ret) {
+			/* fall back to the PIO/IRQ path */
+			dev_dbg(&ctlr->dev, "DMA enh mem channel unavailable (%d)\n", ret);
+		} else if (dws->dma_ops->can_dma_enh_mem(ctlr)) {
+			ret = dws->dma_ops->dma_enh_mem_setup(dws);
+			if (ret)
+				dev_err(&ctlr->dev, "DMA enh mem setup failed (%d)\n", ret);
+			else
+				dws->dma_mapped = true;
+		}
+	}
 
-	/*
-	 * FIXME: The exact reason for this delay is not fully understood,
-	 * but empirical testing shows it significantly improves the stability
-	 * of read/write operations. Without this delay, occasional transfer
-	 * errors or timeouts may occur under certain conditions.
-	 * Keeping it as a safeguard based on practical validation.
-	 */
-	udelay(5);
+	if (dws->dma_mapped) {
+		dw_spi_enh_write_cmd_addr(dws, op, mem);
 
-	dw_spi_enh_irq_setup(dws);
+		ret = dws->dma_ops->dma_enh_mem_transfer(mem, op);
 
-	/* Use timeout calculation from spi_transfer_wait() */
-	ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
-	do_div(ms, dws->current_freq);
+		dw_spi_stop_mem_op(dws, mem->spi);
+	} else {
+		dw_spi_enh_write_cmd_addr(dws, op, mem);
 
-	/*
-	 * Increase it twice and add 200 ms tolerance, use
-	 * predefined maximum in case of overflow.
-	 */
-	ms += ms + 200;
-	if (ms > UINT_MAX)
-		ms = UINT_MAX;
+		dw_spi_enh_irq_setup(dws);
 
-	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
-					 msecs_to_jiffies(ms));
-	if (ms == 0) {
-		dw_spi_mask_intr(dws, 0xff);
-		synchronize_irq(dws->irq);
-		dws->rx = NULL;
-		dws->tx = NULL;
-		dws->rx_len = 0;
-		dws->tx_len = 0;
-		dw_spi_stop_mem_op(dws, mem->spi);
-		return -EIO;
-	}
+		/* Use timeout calculation from spi_transfer_wait() */
+		ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
+		do_div(ms, dws->current_freq);
+
+		/*
+		 * Increase it twice and add 200 ms tolerance, use
+		 * predefined maximum in case of overflow.
+		 */
+		ms += ms + 200;
+		if (ms > UINT_MAX)
+			ms = UINT_MAX;
+
+		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
+						 msecs_to_jiffies(ms));
+		if (ms == 0) {
+			dw_spi_mask_intr(dws, 0xff);
+			synchronize_irq(dws->irq);
+			dws->rx = NULL;
+			dws->tx = NULL;
+			dws->rx_len = 0;
+			dws->tx_len = 0;
+			dw_spi_stop_mem_op(dws, mem->spi);
+			return -EIO;
+		}
 
-	ret = dw_spi_wait_mem_op_done(dws);
+		ret = dw_spi_wait_mem_op_done(dws);
 
-	dw_spi_stop_mem_op(dws, mem->spi);
+		dw_spi_stop_mem_op(dws, mem->spi);
+	}
 
 	return ret;
 }
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 76d7814f0dcf..a86039057988 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -728,6 +728,183 @@ static void dw_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
+/*
+ * The enhanced SPI memory operations are half-duplex, so a single DMA channel
+ * is enough for them. On a platform with only one channel, the channel is
+ * bound to a direction by its "tx"/"rx" DMA specifier, and whichever channel
+ * is currently held tells which direction it serves. Keep it across
+ * operations and swap it only when the transfer direction changes.
+ */
+static int dw_spi_enh_mem_dma_get_chan(struct device *dev, struct dw_spi *dws)
+{
+	struct dma_chan **chan, **other;
+	const char *name;
+	int ret;
+
+	if (dws->dma_nr_chans == 2)
+		return 0;
+
+	if (dws->tx_dir) {
+		chan = &dws->txchan;
+		other = &dws->rxchan;
+		name = "tx";
+	} else {
+		chan = &dws->rxchan;
+		other = &dws->txchan;
+		name = "rx";
+	}
+
+	if (*chan)
+		return 0;
+
+	dws->ctlr->dma_tx = NULL;
+	dws->ctlr->dma_rx = NULL;
+
+	/*
+	 * With a single physical channel, the held channel must be released
+	 * before it can be requested again with the handshake of the other
+	 * direction. On failure both stay NULL, and the next operation
+	 * retries the request and falls back to PIO meanwhile.
+	 */
+
+	if (*other) {
+		dma_release_channel(*other);
+		*other = NULL;
+	}
+
+	*chan = dma_request_chan(dev, name);
+	if (IS_ERR(*chan)) {
+		ret = PTR_ERR(*chan);
+		*chan = NULL;
+		return ret;
+	}
+
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret) {
+		dma_release_channel(*chan);
+		*chan = NULL;
+		return ret;
+	}
+
+	dw_spi_dma_maxburst_init(dws);
+
+	dws->ctlr->dma_tx = dws->txchan;
+	dws->ctlr->dma_rx = dws->rxchan;
+
+	return 0;
+}
+
+static int dw_spi_enh_mem_dma_setup(struct dw_spi *dws)
+{
+	u16 dma_ctrl, level;
+	int ret;
+
+	/* Setup DMA channels */
+	if (dws->tx_dir) {
+		ret = dw_spi_dma_config_tx(dws);
+		if (ret)
+			return ret;
+
+		dma_ctrl = DW_SPI_DMACR_TDMAE;
+	} else {
+		ret = dw_spi_dma_config_rx(dws);
+		if (ret)
+			return ret;
+
+		dma_ctrl = DW_SPI_DMACR_RDMAE;
+	}
+
+	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
+
+	/* Clear stale error status, it is checked after the transfer */
+	dw_readl(dws, DW_SPI_ICR);
+
+	reinit_completion(&dws->dma_completion);
+
+	level = min_t(unsigned int, dws->fifo_len / 2, dws->tx_len);
+	dw_writel(dws, DW_SPI_TXFTLR, level);
+
+	level = min_t(unsigned int, dws->fifo_len / 2, dws->rx_len);
+	dw_writel(dws, DW_SPI_RXFTLR, level ? level - 1 : 0);
+
+	return 0;
+}
+
+static bool dw_spi_enh_mem_can_dma(struct spi_controller *ctlr)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	unsigned int len = dws->tx_dir ? dws->tx_len : dws->rx_len;
+	enum dma_slave_buswidth dma_bus_width;
+
+	if (len <= dws->fifo_len)
+		return false;
+
+	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
+
+	return dws->dma_addr_widths & BIT(dma_bus_width);
+}
+
+static void dw_spi_enh_mem_dma_stop(struct dw_spi *dws)
+{
+	if (dws->tx_dir) {
+		if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy)) {
+			dmaengine_terminate_sync(dws->txchan);
+			clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
+		}
+	} else {
+		if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy)) {
+			dmaengine_terminate_sync(dws->rxchan);
+			clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
+		}
+	}
+}
+
+static int dw_spi_enh_mem_dma_transfer(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	struct sg_table sgt;
+	int ret;
+
+	ret = spi_controller_dma_map_mem_op_data(ctlr, op, &sgt);
+	if (ret)
+		goto out_clear_dmac;
+
+	if (dws->tx_dir) {
+		ret = dw_spi_dma_submit_tx(dws, sgt.sgl, sgt.nents);
+		if (ret)
+			goto out_unmap;
+
+		dma_async_issue_pending(dws->txchan);
+
+		ret = dw_spi_dma_wait(dws, dws->tx_len, dws->current_freq);
+		if (!ret)
+			ret = dw_spi_dma_wait_tx_done(dws, dws->current_freq);
+	} else {
+		ret = dw_spi_dma_submit_rx(dws, sgt.sgl, sgt.nents);
+		if (ret)
+			goto out_unmap;
+
+		dma_async_issue_pending(dws->rxchan);
+
+		ret = dw_spi_dma_wait(dws, dws->rx_len, dws->current_freq);
+		if (!ret)
+			ret = dw_spi_dma_wait_rx_done(dws);
+	}
+
+	if (ret)
+		dw_spi_enh_mem_dma_stop(dws);
+	else
+		ret = dw_spi_check_status(dws, true);
+
+out_unmap:
+	spi_controller_dma_unmap_mem_op_data(ctlr, op, &sgt);
+out_clear_dmac:
+	dw_writel(dws, DW_SPI_DMACR, 0);
+
+	return ret;
+}
+
 static const struct dw_spi_dma_ops dw_spi_dma_mfld_ops = {
 	.dma_init	= dw_spi_dma_init_mfld,
 	.dma_exit	= dw_spi_dma_exit,
@@ -750,6 +927,11 @@ static const struct dw_spi_dma_ops dw_spi_dma_generic_ops = {
 	.can_dma	= dw_spi_can_dma,
 	.dma_transfer	= dw_spi_dma_transfer,
 	.dma_stop	= dw_spi_dma_stop,
+
+	.dma_enh_mem_get_chan	= dw_spi_enh_mem_dma_get_chan,
+	.dma_enh_mem_setup	= dw_spi_enh_mem_dma_setup,
+	.can_dma_enh_mem	= dw_spi_enh_mem_can_dma,
+	.dma_enh_mem_transfer	= dw_spi_enh_mem_dma_transfer,
 };
 
 void dw_spi_dma_setup_generic(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 8cdb0351605b..9c70947c969c 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -363,6 +363,8 @@ static int dw_spi_jhb100_init(struct platform_device *pdev,
 
 	dw_spi_jhb100_mask_intr(&dwsmmio->dws, 0xff);
 
+	dw_spi_dma_setup_generic(&dwsmmio->dws);
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 01eb24ae7fe0..bfdf371bcacb 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -183,6 +183,12 @@ struct dw_spi_dma_ops {
 			struct spi_transfer *xfer);
 	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
 	void (*dma_stop)(struct dw_spi *dws);
+
+	/* enh mem dma ops */
+	int (*dma_enh_mem_get_chan)(struct device *dev, struct dw_spi *dws);
+	int (*dma_enh_mem_setup)(struct dw_spi *dws);
+	bool (*can_dma_enh_mem)(struct spi_controller *ctlr);
+	int (*dma_enh_mem_transfer)(struct spi_mem *mem, const struct spi_mem_op *op);
 };
 
 struct dw_spi {
@@ -228,6 +234,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	unsigned int		dma_nr_chans;
+	bool			tx_dir;
 	u32			dma_sg_burst;
 	u32			dma_addr_widths;
 	unsigned long		dma_chan_busy;
-- 
2.25.1

