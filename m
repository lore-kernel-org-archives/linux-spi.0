Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2FD41D22E;
	Mon,  3 Aug 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760882; cv=fail; b=YSqbm5MTYGRmtPXyNwYT3C6+GwtISLhEot0JVoY+bTqbnxuZDlmJ0A6ITEt3suz7zOT9gPfDEP6vK1+y1BI2zaMqlboZffrmHt9Nk2TU1OpaWyfx9ptcOK4YFUBzoPe5lKabvSml0rI/hL5tRpxk1P2q3oGlsP5XAixjObEuiug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760882; c=relaxed/simple;
	bh=WdsRkGy6kHMD9Fdl8A7kjEYmRGkXBZJT+beN72iGTvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6d8EMpX9gWHerGB/pcPSItHfAsOZkRkECQKsDNo0HFKWFxzYgD80TAh3ukJRTdSI56rMujx9HOLpI+nRu6QSzRRc69nMYlk94OVU4U2FZvdnaf5vK2ExvF0F4fxt+Klv8Bns3gqEikR6bsupBtrH7R4uH8oQUPxlOBiU31lAmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYpIbpKXkaj6G9TyPmUOJ7dtkXWme4gARdlaY1QVDUfj/CC2zCB/GWiuuzgogAYFdZ/CSC567aij9RZRuRyCkw3JJq760PEFqu3LPfjb35PaQjxozq0tAvr1u4cLsOOzUQJlcZ4fjMErhZ8hae7wfuzJqitzkfvb5qjrM7hKN/tJCvNFVzB9Ydb08GyA1XjHcV5rWvGodNriy0YXKoz/ZihKutdjUu/U79sm6vFDoYq68ryEGedb/Mky/HPXev6gV/X1irSsrbCYKSCD0T0tvKh3QObj2kOa3MLT9RB8x7hx/78fMhvLcAiLRQUxs7SnjYlcJciCaxIa2MQnKRv4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P59ZjuGF2u3Ab9BrY8fPy5eSXmiZ4XgD6sERcDyMCaI=;
 b=dSTOwdBEK+rVOopVzBOdpKQ3Y9NKL6+C703yxq2xTOxqU63ah/rlLrzDE5QaaJCD93YLT0BQwSQTHu1ZAIMvJfUbEoDcL2ddjqGQcnJdUaR9y53h7OgBX1iY6nSWBM6Z1cojEEfVNv+ExtnnVgFEBXH29AtfO9g7HjQ61Wzwb4Zo6f3JsqWmBHpzPkFXiyNko/hyLSSnNHuAFSeVCPX8dVdImo5OMHsQkHr8G3PlBo958fr1USRAv143LsDptWpwgpXByMUf6/g9mp90YDWUsGjqbS451o1C/cttSspN0SWvEec+Jnj5PxDmVXU/kN1altfDpaTqfzS2knRHvLxfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:12 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:41:12 +0000
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
Subject: [PATCH v2 09/11] spi: dw: detect enhanced spi mode
Date: Mon,  3 Aug 2026 05:40:42 -0700
Message-Id: <20260803124044.156998-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c7cc725-46f7-4d00-37fb-08def15c78b6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G0Yo6fu8X34ZegqmPRuw+XPYbkXsLgd0LUg2CfENW01rQ+17aWnSjIgYXZK4bn5C3WFs0qv6TLkKkH/b1+kTPoi+lk+3GiuQnrL5W+qg4BEp0UwKwk6jUR7Bc4ehZ/+ZQWAqdy9XtEBenjjdzNGRm9h7ajpKx8bsj4T/V6hSmPVLn1DOcmue5RCi4EYZPLiyl5a/i/iyuorG8PLX3qf1Yibc0VKbQpqzazDkKxtJKehNGgBV/k7mSvZzBN9PQk/a+teCg81O9Jfif5xukztAd4s3aoCLfR3BK2s8oPF+PXCwJey6riMVemwyXHXy9oAG1+WrzTbOqIH0FLN0FKSf9iBQX8UNzxYyHIy1qdHvDJBS3NUlxx3EX7QBkvTFcM3WvdVTIfNJeJzDRq1oAZ4Lwa5M4Is3+R0NV8CohOdlrFtIwnapGABTwGONpvhB5xmRyiBJDS6cg1q/YZOQmCe2fg2s9D54rZYXQohoqUBkaqw2lPx9wYvvbZlprOlfBWFnoLpVX78RGRJ5Tnr8c6qN1lZn/KKM37kXE12gptL1XZ6DwEZBE1Ppy2up5dnPT6tj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUDTHm7FxC7vEPujGSC9FQGueHhbjTLLdwqH7oKK1l0+8kiYkCr0n+7AB4DB?=
 =?us-ascii?Q?j52I+NIfJCIy8tJ4SAniBpgMqpKvEdJoMUwM1nhv9nOp+RdjAm6kL8nqG8Rq?=
 =?us-ascii?Q?7z4fYgRYEgj0sWpc0zyEQOz0qbFrrbBRwrNtSqHj7upuEw+1dy6FOBCMYByq?=
 =?us-ascii?Q?0Y14MEw0M8ZZYRxRJVyV098PR5HOWXOyty+mRRJCuH0XW2rMEABbV5l1wKKl?=
 =?us-ascii?Q?WC1XbQ+gbHxPt3Op7rBCqEKRBD/y5pyc7vYR7YDgm7NluBLpPF39x3No63Ip?=
 =?us-ascii?Q?/YaWMcTcUML1L3ZEx+EnYP5GDZZZloGbMYiRtaEIa1aQnq1vVzkxa/d8tU90?=
 =?us-ascii?Q?M8prq23H4KBg1XFUAB+eByk+Pz8dhil9PiwCswWNzLq4Yz4MK5W9GcCiF42P?=
 =?us-ascii?Q?kPQKgKDrEIoXKMleDnNTutW0bp/qENbzxQQByquL3jI6ppm6L5lTm/hJEANR?=
 =?us-ascii?Q?QvyqHhfpdi4WpaIxvEbIizg9oddqxjM89DJzNNfL5xoMZW1GFqsL9TrQTO49?=
 =?us-ascii?Q?NQSEvjcgzq4cXhTt/iXBS3B38hnQ7ZEw0PORjSYmo+0fWhd9ICKMX+RHBi4r?=
 =?us-ascii?Q?bqFPfaE39OUIDzEltRy0alLT1eyWyUzy3n1IyErmuvEOE2D+Ra7BDKJ6FzSf?=
 =?us-ascii?Q?rdb3uMz8u0QE/FtWlrcpXIl5h3ik1AG+yWD0D/rPsDRBjR0yE7cNF+N0VuWP?=
 =?us-ascii?Q?oIzBzq4muBSZLbR4TfPa/SYVOZR5Bu48H/RCpqnqs+nJdM/UX/vrNuwCdpse?=
 =?us-ascii?Q?thbXVnFB/KcegpL2H7yDPr5zWR/y2Nn0S0Ts/yUWgJ0q14inF9DSwT5hY5cE?=
 =?us-ascii?Q?zCN/eTMx+dUa2w0FEk7Y7cd57Uw/qIWT8m8bu1Pmv52eCRBcGe08lPp17ZPW?=
 =?us-ascii?Q?pXiQzxzdtJIc7LWO/IZnI5xOOPBgnu0+gLE+fLkBGoHHZ389sbbXcVSkgRMe?=
 =?us-ascii?Q?O/Ac06BUOFBxX46HTi/5iE33whO24bm6xVbwth66aV8X3QSB2G3SOaQwAuk9?=
 =?us-ascii?Q?ekPzjLuMP64TsA0j0wYhARANoePcYMaGunhPf5/t+jJgGCia5moLKy5lkoKX?=
 =?us-ascii?Q?IrrvVCeeBioVQZxYMcKbKkyNd9d67e09vy4Em/GiK30PxHDhp6bSv0X3rFUQ?=
 =?us-ascii?Q?2yWX1FoSrD52VDZwMFSzVlqA0eBlwPAO02uhJ9xvPIyjirE2mT6p0EL0ND92?=
 =?us-ascii?Q?KKNnzyr1oB0KKAP94XJjBd2qfal+NKnyRphvrpFFjfxUHdNmrlIKWwRdDZBj?=
 =?us-ascii?Q?wqZlf/9fv2+XfxsWfrz21z0gf4WcrxdKDwYRbmDP+qvDNo6ijsh50xwySmUg?=
 =?us-ascii?Q?QncV5CAclW77Qkjo1Q3wF0616LgjsjteCN2DmIJLIYqQAiVr2IeFbFvjRcJ2?=
 =?us-ascii?Q?PyEiiAvM/ksaQexEtwhB2HG3HgUG2fcdc9BtOE0VzGbk/3mhU3IveGWxEeUG?=
 =?us-ascii?Q?vlxLiD6LcOzMe+oruqnQfYFXtkqw/FMbAj9RjATCZM5DyW1SDq09DEozyc1k?=
 =?us-ascii?Q?ttr1mZugMqgwQDBpeU/0x+kin4WqC4Z/TqAWVx29qoqe0g7b0phhn9APIEmT?=
 =?us-ascii?Q?Khrxad0aVd1ltUzv2IdqrBGRttHv7CG4p/40nf6Dya8m8kR+1x1eJGJZAeDf?=
 =?us-ascii?Q?34HmDwy04H2UA8WR6mA1OreqalRoZ9sW2SrFwqwGRxH6/R7Xwp45qNU8F6Yy?=
 =?us-ascii?Q?cZBb/db5q/8lBPzUHfQZF7v+TSQOWGSEcBiv98z19MzfyGPnBPJ7xrIkj7TC?=
 =?us-ascii?Q?lngEQdS9IZwHZvV6jRhgP6fbGxQ/utBvy6KjWXvZU41jjhclWH93?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7cc725-46f7-4d00-37fb-08def15c78b6
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:59.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCPqFYhu4V5+PXKdFJb4dSTvdiMCkkTeK2Tqc3LoX2Z6+MgOAamh6rkQSzcUaiPlyX65Sr0omGEx3ia0vjkAvtvfxSlA21GGCZWqfn7nCcWlE2M5S0FO5+4GNiiu9XE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

All the SSI controllers supporting enhanced spi modes might not support
all the three dual or quad or octal modes. Detect the modes that are
supported and finally enable the DW_SPI_CAP_EMODE capability which will
start using all the enhanced spi functions that has been added.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 75 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a1c6fa1a780b..0d900afa015d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1029,6 +1029,12 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	return ret;
 }
 
+static bool dw_spi_can_use_mem_ops(struct dw_spi *dws)
+{
+	return !dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
+	       !dws->set_cs;
+}
+
 /*
  * Initialize the default memory operations if a glue layer hasn't specified
  * custom ones. Direct mapping operations will be preserved anyway since DW SPI
@@ -1040,8 +1046,7 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
  */
 static void dw_spi_init_mem_ops(struct dw_spi *dws)
 {
-	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
-	    !dws->set_cs) {
+	if (dw_spi_can_use_mem_ops(dws)) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		if (dws->caps & DW_SPI_CAP_EMODE) {
 			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
@@ -1103,6 +1108,66 @@ static void dw_spi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
+static u16 detect_enh_mode(struct dw_spi *dws)
+{
+	u32 tmp_spi_ctrlr0, tmp_ctrlr0;
+	u32 tmp_val, frf_shift;
+	u16 mode = 0;
+
+	if (dw_spi_ver_is_ge(dws, HSSI, 103A))
+		frf_shift = __bf_shf(DW_HSSI_CTRLR0_SPI_FRF_MASK);
+	else if (dw_spi_ver_is_ge(dws, PSSI, 400A))
+		frf_shift = __bf_shf(DW_PSSI_CTRLR0_SPI_FRF_MASK);
+	else
+		return 0;
+
+	tmp_ctrlr0 = dw_readl(dws, DW_SPI_CTRLR0);
+	tmp_spi_ctrlr0 = dw_readl(dws, DW_SPI_SPI_CTRLR0);
+	dw_spi_enable_chip(dws, 0);
+
+	/* test dual mode */
+	tmp_val = DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI << frf_shift;
+	dw_writel(dws, DW_SPI_CTRLR0, tmp_val);
+	if ((tmp_val & dw_readl(dws, DW_SPI_CTRLR0)) == tmp_val)
+		mode |= SPI_TX_DUAL | SPI_RX_DUAL;
+
+	/* test quad mode */
+	tmp_val = DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI << frf_shift;
+	dw_writel(dws, DW_SPI_CTRLR0, tmp_val);
+	if ((tmp_val & dw_readl(dws, DW_SPI_CTRLR0)) == tmp_val)
+		mode |= SPI_TX_QUAD | SPI_RX_QUAD;
+
+	/* test octal mode */
+	tmp_val = DW_SPI_CTRLR0_SPI_FRF_OCT_SPI << frf_shift;
+	dw_writel(dws, DW_SPI_CTRLR0, tmp_val);
+	if ((tmp_val & dw_readl(dws, DW_SPI_CTRLR0)) == tmp_val)
+		mode |= SPI_TX_OCTAL | SPI_RX_OCTAL;
+
+	if (!mode)
+		goto disable_enh;
+
+	/* test clock stretching */
+	dw_writel(dws, DW_SPI_SPI_CTRLR0, DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN);
+	if ((DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN & dw_readl(dws, DW_SPI_SPI_CTRLR0)) !=
+	    DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN) {
+		/*
+		 * If clock stretching is not enabled then do not use
+		 * enhanced mode.
+		 */
+		mode = 0;
+		goto disable_enh;
+	}
+
+	dws->caps |= DW_SPI_CAP_EMODE;
+
+disable_enh:
+	dw_writel(dws, DW_SPI_CTRLR0, tmp_ctrlr0);
+	dw_writel(dws, DW_SPI_SPI_CTRLR0, tmp_spi_ctrlr0);
+	dw_spi_enable_chip(dws, 1);
+
+	return mode;
+}
+
 /* Restart the controller, disable all interrupts, clean rx fifo */
 static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
@@ -1182,6 +1247,11 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->caps |= DW_SPI_CAP_DFS32;
 	}
 
+	dws->ctlr->mode_bits |= SPI_CPOL | SPI_CPHA;
+
+	if (!spi_controller_is_target(dws->ctlr) && dw_spi_can_use_mem_ops(dws))
+		dws->ctlr->mode_bits |= detect_enh_mode(dws);
+
 	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
 	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
@@ -1226,7 +1296,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_init_mem_ops(dws);
 
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	if (dws->caps & DW_SPI_CAP_DFS32)
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
-- 
2.25.1

