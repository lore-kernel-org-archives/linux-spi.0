Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61F443C34;
	Wed, 23 Sep 2026 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158367; cv=fail; b=FPS0bciu446tOLs0895DJKT7tGm70D3P20oQ35h4u3omwVLyAape61FnpX5z8AeXT56Pp8ng2+eSsC16BlqhUa+0shpFMBg1URgFChoFnscqlHShi1YqKGpRZND1vpiZ/PoK8WmRPtXy2D3j2fFuBwtNmdGiymJw3t9II/lNQXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158367; c=relaxed/simple;
	bh=zsqSaIFG3gDe24P5fDdNydiT2HPptfB38VZvQDd4j8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lINyMXeRFKyit/vXM0Vly1MwV8cMhkf7UQVji5I3UwTptR3S1a/e3QwH+JdH2dCbmFkhdUtq3ZMq4mcQmGzcMP4mo4qiyd8rxxvlNnQCekDOpsTstXIT0aY/WXp6wlEsNg4ziatPlolf00VMz6CAfqOPw18igqKjWtg8EkrvhG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exV+Nmqr+ZtZZ92mWzzvH+mc6+B2aPe2qzSs4ULq0lWBcYLK0cGVShKz14fKrEeZRqsQ+/f9jDfB9bj0Y0EB+fiTU+hFbnBUta7HLMjxlO5ay5MTtm0+Jo883w0XX1tFvWcyq3fNs/ZcGB8lFnBku2RLBLUdUVZCOFrII0iOb4VJvjKsB3Dyivz1082THELx7gO8AJzDv6j7xjeSJ+iBtlVFGIi6FGsrXPXQFADmxvADUOMHV57c1+UdabvvgiI/BoL97YK8BcElgAYPhBlwjmSqMn0SIjbbPzXkE8faJNOrUgNV916BE6S1CZW1QTCMtpjYlSuS4YIOYthUfkU8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwzCq+bPtCTncUDc0gGtoxPBBsdTEtHz1X76GSKSX0A=;
 b=ctf1UyuTE0FwkkcFrDTMNe+BRhDl04jHZUptL/sOuQGSgECXQDK6eT79kTIw9HzU/XfcSI8g45VxWJICnQq3bnQGYbwRYj+Tnt2l9kmxaPmW/fJRahJQ2cBzLH832VMhi8yYDoOxOMqP3dNrT08yglLLN0Gx9bnFdyHm7hI9sQJmE26oP+zGA/gUeFgpbgUE6UuAs/N74MPLL3Tn476JGWGjJLZap2g5Oio+e/Jq8GbpqzR1Wlv0g3339rT1gfM3C9lFHlmMaTisxxbq7fHpdOjc2zBhQ5UDArVjyJOQIoeb7OfrP8S6z2y5PrfUV17rhEOU1AzpSKInOIlpccqHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1219.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 09:57:14 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Wed, 23 Sep 2026 09:57:14 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 2/2] spi: dw: Add DMA support for enhanced memory operations
Date: Wed, 23 Sep 2026 02:57:05 -0700
Message-Id: <20260923095705.233297-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4266a327-56f8-4970-c375-08df19590b2f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1RU4bRKzK2o0bE6OI9zc8VRBGz7/Tj3d/cgisYF6tVyjuCXNdfdeh9XUAwPaLMpUqVqUCwVsJWBZUQZyN4YgXLKlFGvBQSK/mCyOyVCH1Lere8wqL12azVS67iFkKbo2n9Hi2cQ1ClBFqks6Or3QtXWNF2/29TX14qU+1pzTDYhDoGuDNGnL76oLUqWL8hqjevEIxNWjmDyFSKqe/moil5Hyrjnu+R6xgrTKIBaHyhGJfGIWsn+Q2thbXsGtWjqHYsd579gZhFucUD+dqbY1zcQacpANstXPz7zlhfrPj3EaoHPVjNjsI7LdpgTPuZI+yOXlL+hm7Qufb9VGGusBVuQ3QZKBZFczS/yDA74UEiaBW+JBb+8IQq83B47vvpnDBr95xfizumvASnw1eqNUwxJtWvP5T0tMYV2weLcS58z0latEJWwS0LD6NM7O49zCYyfNC+vrGA1snAZ2QC8tPa5DsSyWuq5foGOYXSXL8r19F6pKbNV8fbKq8fcUFnda+AqBVDTS3RfM71sBKBf4SDnr6APbU7xJUDzqdv40J5miZT9e7sF6vntWyQ+usw3E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4DJ1KN3n3qyCMMaRQ1qQQrPJKcSeAG4yA0pY1Iu2h/Unflc5DcLEKb7SocY6?=
 =?us-ascii?Q?i1l3M1el+OomEabeWloy7uXzdXi/7yzDPvaDxvFZ+nmI4t78w3lGabMBQY5n?=
 =?us-ascii?Q?symhmnHfo2ecZhk86UWKWPlHd26jQ8r3I240iI58bDFP8BgsMu4FsyM2xL1X?=
 =?us-ascii?Q?DNZysQ1UGv7H0MpXabSCxuSbDOUlMocdCHZm2nbRkee1pTBbmEZr5l5rwm2k?=
 =?us-ascii?Q?taUj7u50O6UQq+DmQkJz8QF9Q5Jmkm7m4uZ9vE4VZaueud2PkwRy/HbTSX1W?=
 =?us-ascii?Q?gyBbT812VF2vacL5zPbdUlThNRLejvKSE644h287Bb3skdRNiRIDdR/mKK4M?=
 =?us-ascii?Q?lb3d1ApDc1qqczYOmFfE+oVpebNi/59sSmIDl58wbtBbRWY4ei/qOds4Uc+5?=
 =?us-ascii?Q?wXEZGeKnC2L1F1hRqRb8rAZyZJtylymevTQFhS7gzO8vI06wN1F9c/1cI7Bu?=
 =?us-ascii?Q?Y9AcFrxxABkjCOL2/OpE2rOl4mW8CJmViBK3YU1onnO25YjA3mr5gAx0hz0E?=
 =?us-ascii?Q?IlWIs9/lIpb9PxDNvfZrkLp/lck4Ee6TRWy+XvQb46SfLzVEqpkaRf+aXs9p?=
 =?us-ascii?Q?CkfE/Hm6jAS5CvStxjZvxVu8U82spMg2mZSdEjLIq1qFMHjSgnQMo/vJCXEm?=
 =?us-ascii?Q?v4qcnR0KM9/AsQwW/y+y0zF8bJNL7SDhe0ZeKYyyKSqT1heJ2r2ZNUp5O6bz?=
 =?us-ascii?Q?fv4S/y6MLCdozYBfxMrR4Be2dYTly0h/yB8bB/eMAVDo4GSw7hSBifynEJrL?=
 =?us-ascii?Q?e1X46z3T1njqQrzK2w1o4Z1EgVweAC8+OLSxaKgajhQhZvWcSEq0cXDD4SYp?=
 =?us-ascii?Q?KM72dJOgHfSCHsBTq7U9kfaVHFrs+64m6oZtOyKxU7FsslzLZUCAfSjRqO5g?=
 =?us-ascii?Q?WKt7Iz+5MbEMCNeupwCVv6zKsFBMjw6ZvKBNyL51ivmOUoOj8iGG13lx3rf/?=
 =?us-ascii?Q?K1DWSQ8Hl27buWkWS15HlwGD2SZhHvHhrAj23uMjnxOzUa7HypxRczPHk8Ta?=
 =?us-ascii?Q?CKYiKBH47KWD1UXK1PD9FTI9yxXbmA1byBNJQGPeLnzr6f/Xl1Pr7WDR6RH6?=
 =?us-ascii?Q?SW6AkcL8Kc6sk3vL0ZHq7FhxVxdAhsJYvwPTE1K4vYj8QPa5bshOA6QSKiMA?=
 =?us-ascii?Q?HEAM9EtVLgZS+PExq6PtM+jlAuZ1rvIf7uK9hyvypaP1pjiSYIi79dAnre+U?=
 =?us-ascii?Q?q+sR7pPao+58PBKZyqx8NJxpiqiSdWbjkmWor624g2irVyiX+hyCVfLNoBT7?=
 =?us-ascii?Q?oSRro7ZyUA6iJjLhQsVpDSQopnqKNmlAU3eO7yQNvC3N1FXqBDFS5j05YhM6?=
 =?us-ascii?Q?VHyuIRlL3U8FjjhTmkWyGpLMe1IsuxKZJMkY6Q8lRWrsKofew9mhPtVwJlad?=
 =?us-ascii?Q?h4pA1Xpl/Yp4Gg9FbAfnXAGqCJ6R/64qm5oadDSfBbgPXbUcduVAXyQ6mAIw?=
 =?us-ascii?Q?lcflmtFlgV78jkKupG2UscKAdDAeXnxN4hLYUQaafVZOlXLeWkENwDpXPCsw?=
 =?us-ascii?Q?TouwEK115OdI/hhKBBfdYTIeIR8J3y/WKIenFllguiUiXemV8ojiwkWrhvV+?=
 =?us-ascii?Q?Xj0vUzKzQC6dSUf3jJJrREWmHS4+s0feIi/wlxQYuFoi50tDXGn2I0LUP7Iy?=
 =?us-ascii?Q?JNIiCIp8OWiA4zlEls2/U7QdzsrQc8Z5LTxQk4NcdxwCIBpxGAv/g4CMCDjx?=
 =?us-ascii?Q?cyQ0D3SLad3Qq51wDsqW53PLvjwMVgHHSCxeKvNDi18fZaDP472K3ShquLmI?=
 =?us-ascii?Q?PkR7p/XDuSHo6yZOrJ33uBCP5pOxpRFj7hfqRsaOO1ZcePe5S0aN?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4266a327-56f8-4970-c375-08df19590b2f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:57:14.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7UYWLLM4z0b/NT/oIvTvDh+RsvO72Juq8JGziE3sREsq+hOdUi3n36uMjrtATEGZ2KuPkLJo4QZ/h6vxeAOQ7NXBslYLBIDjTdHU4JY6P1QS3Jxh/OMfP8cjAwXA/b4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1219

Implement DMA support for enhanced SPI memory operations. On some
platforms, such as JHB100, only one DMA channel is available for the
enhanced SPI controller, so the channel is allocated dynamically based
on the transfer direction.

Add enhanced memory DMA callbacks (init/exit, setup, can_dma, transfer)
to struct dw_spi_dma_ops and hook them into the generic DMA operations.
The channel is requested per operation and released afterwards.

In dw_spi_exec_enh_mem_op(), record the direction in dws->tx_dir and use
the DMA path when a channel is available, can_dma_enh_mem() accepts the
transfer, and the transfer exceeds the FIFO length; otherwise fall back
to the interrupt path.

Rework dw_spi_dma_wait_tx_done() to take an explicit speed_hz, add one
to TXFLR for the word possibly left in the shift register, and compute
the delay in ns or us, dropping the dependency on the xfer pointer.

Also move the udelay(5) workaround into dw_spi_enh_write_cmd_addr() so
it applies to both paths, and enable the generic DMA setup in
dw_spi_jhb100_init().

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 107 ++++++++++-----
 drivers/spi/spi-dw-dma.c  | 281 +++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw-mmio.c |   2 +
 drivers/spi/spi-dw.h      |  10 ++
 4 files changed, 357 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 04a5b48373e1..6da3812f72f6 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -970,6 +970,15 @@ static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_o
 
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
@@ -981,6 +990,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	unsigned long long ms;
 	int ret;
 
+	dws->dma_mapped = false;
+
 	switch (op->data.buswidth) {
 	case 0:
 	case 1:
@@ -1004,10 +1015,13 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
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
@@ -1043,47 +1057,68 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 		}
 	}
 
-	dw_spi_enh_write_cmd_addr(dws, op, mem);
-
-	/*
-	 * FIXME: The exact reason for this delay is not fully understood,
-	 * but empirical testing shows it significantly improves the stability
-	 * of read/write operations. Without this delay, occasional transfer
-	 * errors or timeouts may occur under certain conditions.
-	 * Keeping it as a safeguard based on practical validation.
-	 */
-	udelay(5);
+	if (dws->dma_ops && dws->dma_ops->dma_enh_mem_init &&
+	    dws->dma_ops->can_dma_enh_mem && op->data.nbytes > dws->fifo_len) {
+		ret = dws->dma_ops->dma_enh_mem_init(ctlr->dev.parent, dws);
+		if (ret) {
+			dev_dbg(&ctlr->dev, "DMA enh mem init failed (%d)\n", ret);
+		} else if (!dws->dma_ops->can_dma_enh_mem(ctlr)) {
+			/* Not worth a DMA transfer: give the channel back. */
+			dws->dma_ops->dma_enh_mem_exit(dws);
+		} else {
+			ret = dws->dma_ops->dma_enh_mem_setup(dws);
+			if (ret) {
+				/* fall back to the PIO/IRQ path */
+				dws->dma_ops->dma_enh_mem_exit(dws);
+				dev_err(&ctlr->dev, "DMA enh mem setup failed (%d)\n", ret);
+			} else {
+				dws->dma_mapped = true;
+			}
+		}
+	}
 
-	dw_spi_enh_irq_setup(dws);
+	if (dws->dma_mapped) {
+		dw_spi_enh_write_cmd_addr(dws, op, mem);
 
-	/* Use timeout calculation from spi_transfer_wait() */
-	ms = 8LL * MSEC_PER_SEC * (dws->rx_len ? dws->rx_len : dws->tx_len);
-	do_div(ms, dws->current_freq);
+		ret = dws->dma_ops->dma_enh_mem_transfer(mem, op);
 
-	/*
-	 * Increase it twice and add 200 ms tolerance, use
-	 * predefined maximum in case of overflow.
-	 */
-	ms += ms + 200;
-	if (ms > UINT_MAX)
-		ms = UINT_MAX;
+		dws->dma_ops->dma_enh_mem_exit(dws);
 
-	ms = wait_for_completion_timeout(&ctlr->xfer_completion,
-					 msecs_to_jiffies(ms));
-	if (ms == 0) {
-		dw_spi_mask_intr(dws, 0xff);
-		synchronize_irq(dws->irq);
-		dws->rx = NULL;
-		dws->tx = NULL;
-		dws->rx_len = 0;
-		dws->tx_len = 0;
 		dw_spi_stop_mem_op(dws, mem->spi);
-		return -EIO;
-	}
+	} else {
+		dw_spi_enh_write_cmd_addr(dws, op, mem);
 
-	ret = dw_spi_wait_mem_op_done(dws);
+		dw_spi_enh_irq_setup(dws);
 
-	dw_spi_stop_mem_op(dws, mem->spi);
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
+
+		ret = dw_spi_wait_mem_op_done(dws);
+
+		dw_spi_stop_mem_op(dws, mem->spi);
+	}
 
 	return ret;
 }
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 022eb4fae33d..446c8b1c2dd1 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -294,19 +294,28 @@ static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
 		(DW_SPI_SR_BUSY | DW_SPI_SR_TF_EMPT)) != DW_SPI_SR_TF_EMPT;
 }
 
-static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
-				   struct spi_transfer *xfer)
+static int dw_spi_dma_wait_tx_done(struct dw_spi *dws, u32 speed_hz)
 {
 	int retry = DW_SPI_WAIT_RETRIES;
 	struct spi_delay delay;
+	unsigned long ns, us;
 	u32 nents;
 
-	nents = dw_readl(dws, DW_SPI_TXFLR);
-	delay.unit = SPI_DELAY_UNIT_SCK;
-	delay.value = nents * dws->n_bytes * BITS_PER_BYTE;
+	/* Account for the word that may still be in the shift register */
+	nents = dw_readl(dws, DW_SPI_TXFLR) + 1;
+	ns = DIV_ROUND_UP(NSEC_PER_SEC, speed_hz) * nents *
+	     dws->n_bytes * BITS_PER_BYTE;
+	if (ns <= NSEC_PER_USEC) {
+		delay.unit = SPI_DELAY_UNIT_NSECS;
+		delay.value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay.unit = SPI_DELAY_UNIT_USECS;
+		delay.value = clamp_val(us, 0, USHRT_MAX);
+	}
 
 	while (dw_spi_dma_tx_busy(dws) && retry--)
-		spi_delay_exec(&delay, xfer);
+		spi_delay_exec(&delay, NULL);
 
 	if (retry < 0) {
 		dev_err(&dws->ctlr->dev, "Tx hanged up\n");
@@ -667,7 +676,7 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		return ret;
 
 	if (dws->ctlr->cur_msg->status == -EINPROGRESS) {
-		ret = dw_spi_dma_wait_tx_done(dws, xfer);
+		ret = dw_spi_dma_wait_tx_done(dws, xfer->effective_speed_hz);
 		if (ret)
 			return ret;
 	}
@@ -690,6 +699,258 @@ static void dw_spi_dma_stop(struct dw_spi *dws)
 	}
 }
 
+static int dw_spi_enh_mem_dma_caps_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps caps;
+	int ret;
+
+	if (dws->tx_dir) {
+		ret = dma_get_slave_caps(dws->txchan, &caps);
+		if (ret)
+			return ret;
+
+		if (!(caps.directions & BIT(DMA_MEM_TO_DEV)))
+			return -ENXIO;
+
+		dws->dma_sg_burst = caps.max_sg_burst;
+		dws->dma_addr_widths = caps.dst_addr_widths;
+	} else {
+		ret = dma_get_slave_caps(dws->rxchan, &caps);
+		if (ret)
+			return ret;
+
+		if (!(caps.directions & BIT(DMA_DEV_TO_MEM)))
+			return -ENXIO;
+
+		dws->dma_sg_burst = caps.max_sg_burst;
+		dws->dma_addr_widths = caps.src_addr_widths;
+	}
+
+	return 0;
+}
+
+static void dw_spi_enh_mem_dma_maxburst_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps caps;
+	u32 max_burst, def_burst;
+	int ret;
+
+	def_burst = dws->fifo_len / 2;
+
+	if (dws->tx_dir) {
+		ret = dma_get_slave_caps(dws->txchan, &caps);
+		max_burst = (!ret && caps.max_burst) ? caps.max_burst
+						     : DW_SPI_TX_BURST_LEVEL;
+		dws->txburst = min(max_burst, def_burst);
+		dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
+	} else {
+		ret = dma_get_slave_caps(dws->rxchan, &caps);
+		max_burst = (!ret && caps.max_burst) ? caps.max_burst
+						     : DW_SPI_RX_BURST_LEVEL;
+		dws->rxburst = min(max_burst, def_burst);
+		dw_writel(dws, DW_SPI_DMARDLR, dws->rxburst - 1);
+	}
+}
+
+static int dw_spi_enh_mem_dma_init_generic(struct device *dev, struct dw_spi *dws)
+{
+	int ret;
+
+	if (dws->tx_dir) {
+		if (dws->txchan)
+			return -EBUSY;
+
+		dws->txchan = dma_request_chan(dev, "tx");
+		if (IS_ERR(dws->txchan)) {
+			ret = PTR_ERR(dws->txchan);
+			dws->txchan = NULL;
+			goto err_exit;
+		}
+	} else {
+		if (dws->rxchan)
+			return -EBUSY;
+
+		dws->rxchan = dma_request_chan(dev, "rx");
+		if (IS_ERR(dws->rxchan)) {
+			ret = PTR_ERR(dws->rxchan);
+			dws->rxchan = NULL;
+			goto err_exit;
+		}
+	}
+
+	init_completion(&dws->dma_completion);
+
+	ret = dw_spi_enh_mem_dma_caps_init(dws);
+	if (ret)
+		goto free_txrxchan;
+
+	dw_spi_enh_mem_dma_maxburst_init(dws);
+
+	if (dws->tx_dir)
+		dws->ctlr->dma_tx = dws->txchan;
+	else
+		dws->ctlr->dma_rx = dws->rxchan;
+
+	return 0;
+
+free_txrxchan:
+	if (dws->tx_dir) {
+		dma_release_channel(dws->txchan);
+		dws->txchan = NULL;
+	} else {
+		dma_release_channel(dws->rxchan);
+		dws->rxchan = NULL;
+	}
+err_exit:
+	return ret;
+}
+
+static void dw_spi_enh_mem_dma_exit(struct dw_spi *dws)
+{
+	if (dws->tx_dir) {
+		if (!dws->txchan)
+			return;
+
+		dmaengine_terminate_sync(dws->txchan);
+		dma_release_channel(dws->txchan);
+		dws->txchan = NULL;
+		dws->ctlr->dma_tx = NULL;
+	} else {
+		if (!dws->rxchan)
+			return;
+
+		dmaengine_terminate_sync(dws->rxchan);
+		dma_release_channel(dws->rxchan);
+		dws->rxchan = NULL;
+		dws->ctlr->dma_rx = NULL;
+	}
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
+	enum dma_slave_buswidth dma_bus_width;
+
+	if (dws->tx_dir) {
+		if (dws->tx_len <= dws->fifo_len)
+			return false;
+	} else {
+		if (dws->rx_len <= dws->fifo_len)
+			return false;
+	}
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
+	if (dws->tx_dir) {
+		ret = spi_controller_dma_map_mem_op_data(ctlr, op, &sgt);
+		if (ret)
+			goto err_clear_dmac;
+
+		ret = dw_spi_dma_submit_tx(dws, sgt.sgl, sgt.nents);
+		if (ret)
+			goto err_unmap;
+
+		dma_async_issue_pending(dws->txchan);
+
+		ret = dw_spi_dma_wait(dws, dws->tx_len, dws->current_freq);
+		if (ret)
+			goto err_terminate;
+
+		ret = dw_spi_dma_wait_tx_done(dws, dws->current_freq);
+		if (ret)
+			goto err_terminate;
+
+		goto err_unmap;
+	} else {
+		ret = spi_controller_dma_map_mem_op_data(ctlr, op, &sgt);
+		if (ret)
+			goto err_clear_dmac;
+
+		ret = dw_spi_dma_submit_rx(dws, sgt.sgl, sgt.nents);
+		if (ret)
+			goto err_unmap;
+
+		dma_async_issue_pending(dws->rxchan);
+
+		ret = dw_spi_dma_wait(dws, dws->rx_len, dws->current_freq);
+		if (ret)
+			goto err_terminate;
+
+		ret = dw_spi_dma_wait_rx_done(dws);
+		if (ret)
+			goto err_terminate;
+
+		goto err_unmap;
+	}
+
+err_terminate:
+	dw_spi_enh_mem_dma_stop(dws);
+err_unmap:
+	spi_controller_dma_unmap_mem_op_data(ctlr, op, &sgt);
+err_clear_dmac:
+	dw_writel(dws, DW_SPI_DMACR, 0);
+
+	return ret;
+}
+
 static const struct dw_spi_dma_ops dw_spi_dma_mfld_ops = {
 	.dma_init	= dw_spi_dma_init_mfld,
 	.dma_exit	= dw_spi_dma_exit,
@@ -712,6 +973,12 @@ static const struct dw_spi_dma_ops dw_spi_dma_generic_ops = {
 	.can_dma	= dw_spi_can_dma,
 	.dma_transfer	= dw_spi_dma_transfer,
 	.dma_stop	= dw_spi_dma_stop,
+
+	.dma_enh_mem_init	= dw_spi_enh_mem_dma_init_generic,
+	.dma_enh_mem_exit	= dw_spi_enh_mem_dma_exit,
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
index e62f919f1188..da603c36d5d4 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -183,6 +183,13 @@ struct dw_spi_dma_ops {
 			struct spi_transfer *xfer);
 	int (*dma_transfer)(struct dw_spi *dws, struct spi_transfer *xfer);
 	void (*dma_stop)(struct dw_spi *dws);
+
+	/* enh mem dma ops */
+	int (*dma_enh_mem_init)(struct device *dev, struct dw_spi *dws);
+	void (*dma_enh_mem_exit)(struct dw_spi *dws);
+	int (*dma_enh_mem_setup)(struct dw_spi *dws);
+	bool (*can_dma_enh_mem)(struct spi_controller *ctlr);
+	int (*dma_enh_mem_transfer)(struct spi_mem *mem, const struct spi_mem_op *op);
 };
 
 struct dw_spi {
@@ -227,6 +234,9 @@ struct dw_spi {
 	u32			txburst;
 	struct dma_chan		*rxchan;
 	u32			rxburst;
+
+	bool			tx_dir;
+
 	u32			dma_sg_burst;
 	u32			dma_addr_widths;
 	unsigned long		dma_chan_busy;
-- 
2.25.1

