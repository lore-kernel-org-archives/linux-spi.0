Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F6401A01;
	Thu,  9 Jul 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589229; cv=fail; b=DjWVrVaZl2r8I7wcBb/f7o6UJyzwUuxmKe9+lyyeHa2MLJipFIttXnpm8fJtxdg9CVAAFFKc6UvmDttbw3XSbBw/3fy/57ueUoekvMm4Aj7za1qL+pWZ4LQlOAsivsQYe1FEn6X6VkFMzWdPIZb6bT69J01BKOJsWvAWc+NXp3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589229; c=relaxed/simple;
	bh=1lax9kgeGkj7QcncEAbI0frK3vG5Q007EKu3C4e7Pc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilbwHWcSc7ggWzm6z2nVmvHss4B0hKOxt3E464eNWpRGoHWtAsWtXy0Hd7K6yi1vY8kCYy7N6nM8XrysDGZCyUhee1iJHE3PLldQj+Mrx0j2VD93HGtxpEF9vPCXkF2t3LOOROAoH7s5kI+evQUCcg0EI9YyxDza1+psF8Zgk70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PedYkiY6bdI7xzRtIkNFdNLAwttxeDjUqp59DVF+fzrhZYZeZa2FeGhK5x/3XG8+imO484ReCYP93rCfuvgAVZTRTjQPZeWxVoEPeCjIunvUl+pYB5lITYfnor5tw1Y0ib6qvciypQ8UsXIVqXBr6g9NxwXNh4KsZHr9WkufQ5W2xFMY/+Co+kyWS/LEZNRCb2+yP8tVdoojt/6Vvg7xyds8RmW5qR3oUJsSxs4+scABXsquIt7sCie5vXGAK0V076ckvG3Sonet/mQahKEJsuaAOJrDllM8bg7bfxGhFpD081ZoOKO/NRpMeeyGdXPY1QLVD7UuUecJAXYwFhV7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya++mFVZj//FD7rg03gVF+EbPubMKly+PgEvkL7FbDo=;
 b=eiIJYx2AncCIH7Ux6hs7qOLzhQM8/J42DG7eN0lObLbsiePSlcVM/tIkJeRuIGRrJTjhuM1sAE2l3M+HvmDrpU82r6og/WRBU7cYgHwXL7TeWVKtqf+ne06qV+WRoEsr8A9ZuFlcg/vTSwX8FzT+TSVaMbmm4CTMEy/5wsSyJnL/CF7vLzVpQJQEyhhv03Oc/F6VrpEjfcd55JslvoX9XEyplEFtfJ+yCcSwu/3WA0SyGGlsb6PRRkDeoj5buG04rBTYIRJX+mfrNVeJ/O9T2cg5l/88Kh+7jSPK5sW0603QxpXWHy10wkLiVzQJCZO4RrgXdZiIqKYORslwJtvb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:21 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:21 +0000
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
Subject: [PATCH v1 05/11] spi: dw: Introduce enhanced single/dual/quad/octal spi
Date: Wed,  8 Jul 2026 22:51:58 -0700
Message-Id: <20260709055204.138168-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef8d3585-9c6f-44d0-9c5b-08dedd7e3e47
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C/W4fMft87oJ63o6kXAqT0UGaO1rOlYN7Ecgl4VoWCYd9AeiBraQ4kfvAZfDlseyWn6dWZMmTGh/YSMr7i47YcHb827LTsZhZo0NtcekJaLsF7TBRxWAjvd2XtFFyS+rS6SQAkTVL9ttVKuDmCYo3GY3/ApNGPSd96GOmm42iYL/IWtaBWC383QF1RyvjvwBkFCVm8ICvx5Oac2luGcGTXABB481DIzbGU3rwxCgj1HaQE/PJJJylZLIaKHjqWlIy8rDA1AXBgpP/oDYptvCX2YtHHDsmpyjhMUPDAJFbMiBOaaQBT+LCpevL7NdZRFAvpMmnYBwJNiQGXVjeY7ffMmq+D56s8gsn2oI/WQR9aMNCKfr+KB423esdaY1BMEIDMfWS7J8XbSjrVHESbcxip039wqNEILY0gVuQ426PZ0qlEgB2RuBiMqcAAuqBU9/3u7LuAdWEsaku86OzzZ2Pn5tCkONsDPmTT3QTU088iY3n4XinZLtKQDKGdQiuxtrEWOrwoV+MC/1UKuFvBmrbiQMVfgeJUnayAMP3ll9LdV8SrEvmMVlIWvMYEaM5kiu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dm8EfFEJ7w5HAwlorAUM9lYr8AI84d20vVIFPvdKHdTtb+rNK3GAlgPlb6y?=
 =?us-ascii?Q?+jhiWIKENQIlvd3eVNjFJACr29M+/zXTt6befSutjnW63xSPPca/6iIFINS2?=
 =?us-ascii?Q?+eE3b/m2mBgjZoVBj28NCvVOReBo/1Xd2QeUdNrAvxJjouFDLDtf2xajuSPo?=
 =?us-ascii?Q?VJzzRcMSi62QfII7cSQYt5fFGgWOodfa4Bi46u/0088FCGsWV7GddS8UwrqQ?=
 =?us-ascii?Q?4RyK5Cr/6tFdD1+qX2NvLX8fGwFiFhOh4qIoi531y+pf3P+kDFGI/15gHeXK?=
 =?us-ascii?Q?GFN9+zS4c9kByjwC2+ZOrXOuzXydv5Rvfy59PPILAtmelOm30HKys5b+++Dp?=
 =?us-ascii?Q?MGGl6UirJPOrnuLej/Ic2uyIfPpSh6Sfa0mUoKH6uSjWtxRRoitueIPymT9z?=
 =?us-ascii?Q?EUSAz2BA83ClWL/rqScRC+erhISvLe11f21dkvno2s4Jbe9UWz1MTuNFkQgV?=
 =?us-ascii?Q?ujHsPqe1TjHHalEgq220EQhhEyrJesMiOuuigDTfj4dt5ydeG63/hT3d5IpO?=
 =?us-ascii?Q?ulaCkNuC/OyU+9V8TKb1VA7yvFtTO5uEVNLtuGyYRX/TBk7c6SeZavjOmCMW?=
 =?us-ascii?Q?a53oPgbpwlCOmwrQrOcnWSdHvEjBu9Dnyc+8WrAaj44ulhzmc4rm3NCYRlM+?=
 =?us-ascii?Q?fsOvpl2txPFZU1o4kHEhbovpEEBflKe5Xj57NClhGZSDEIZqUqY4hNOFuIJZ?=
 =?us-ascii?Q?YGgkvROL5vDHe4njrLmSgY8Emb8ZSqCTHwQ6mx4ZvuJhq3AWCx77zI88/I47?=
 =?us-ascii?Q?ljPnuzB9P9m2aOVegF4oqF96pjeukW5mZwW6kJoLSNJcdueAVflLste4ownc?=
 =?us-ascii?Q?KeJmQNTVR8tq3l4t2gKbmcKjWgGDst5kv633BkIyKJFTZUypk7et5qHhhw9q?=
 =?us-ascii?Q?oPHvbEbxQgi242bKmbbwAel07Tc5yaz0+IxbATUuq1umAC6aWhAveP+uLKYh?=
 =?us-ascii?Q?gvZ9o4TMiiwlKQ94RP/mQc8iJdswhPuDBCW77FpL8y84CuZ0eAHwgK4/LRDc?=
 =?us-ascii?Q?TLPENP7KA/r0rtnXz72F+dvGeZ4mx04BiikzEZnlbdzZqCwLdSXNo6EsRJXP?=
 =?us-ascii?Q?tMQuMf3XiwWyEcvTLS0Oxwddkja8heZ1qLGnC/GmYzX3Uz4UxO4ra/nHNsK/?=
 =?us-ascii?Q?wzaPq8IwpCxW7JjQqMq5D6KZEC6UF3LmR7RYs8Yt0jmEmEIz4Cb8E+igqbBW?=
 =?us-ascii?Q?BnoETn9DrQkjmn78in7r0+uGid+ZTLMjeniY1yd8kpTQ1Ril6G5G2YKv/Hts?=
 =?us-ascii?Q?kZlWOzfJp4/BaYqr5L+ANWzWLPkwwrLzZz0m7zp41NZVPuyRreO5iAqYojBY?=
 =?us-ascii?Q?wp8zqukP01/s/vMuMYF3R++pseTJKjaX5Agf+Cfp2qGqZo71uH5f8gGs9NA4?=
 =?us-ascii?Q?Qs6V3hriyBLHeRnxmkzZ2C4153jKV4w0vnwd8LTIEygo1h2Tye0YKSinuZqc?=
 =?us-ascii?Q?koRnhUko8MUV2ttImz2CBHDfdEsVfI4bmhCcMqsGBTqLzFi+EJY+6bBgaXAv?=
 =?us-ascii?Q?myomnMPxH2AV1RPLUdTIuL8AvwPWa91NCllUIW2wCbvo1mCpzkL45PJTkNej?=
 =?us-ascii?Q?PXQ6wSJRipVCqHKJ3t35uV4NFjUGJoH80qhi7jxwF6a0D84zNfX2EZ32ulMn?=
 =?us-ascii?Q?wmj2lop+auzDJmp7TRyafzWK0Donx3vEuNIE5cbf4BKw8ZPVXhBGGQ31nqbf?=
 =?us-ascii?Q?rPaAGhBVdcI1QslDGce6nxYte5VlGpEyNKuEVqABhcslwTzKgegwzy+eQnC4?=
 =?us-ascii?Q?EpwW6Oq9BDkiKELZTlHTgG0ikiFNlnlhekpP7WweEeIJH+on05zX?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8d3585-9c6f-44d0-9c5b-08dedd7e3e47
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:21.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcoC3BwnOvpkF0jPJRHJ8ILY9uAQBxAZEqfW8qSk6ZEyCIVLoPNrNqp6RLuMGETbzFX4CFCg45sEInWNyJEIngOKo4F80tBJvZM2ZqU3fEnt5tJ72GoICmx9LhlPXvnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

If the spi transfer is using enhanced single/dual/quad/octal spi mode,
then we need to update the SPI_CTRLR0 register. The SPI_CTRLR0 register
will be updated in dw_spi_update_config() via the values in
dw_spi_enh_cfg.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 91 +++++++++++++++++++++++++++++++++++++--
 drivers/spi/spi-dw.h      |  9 ++++
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0d7c88d2c74d..9f3ee1d78c05 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -815,6 +815,89 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	dws->n_bytes = 1;
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		dws->rx = op->data.buf.in;
+		dws->rx_len = op->data.nbytes;
+		dws->tx = NULL;
+		dws->tx_len = 0;
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		dws->tx_len = op->data.nbytes;
+		dws->tx = (void *)op->data.buf.out;
+		dws->rx = NULL;
+		dws->rx_len = 0;
+	} else {
+		dws->rx = NULL;
+		dws->rx_len = 0;
+		dws->tx = NULL;
+		dws->tx_len = 0;
+	}
+}
+
+static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	struct dw_spi_enh_cfg enh_cfg;
+	struct dw_spi_cfg cfg;
+
+	switch (op->data.buswidth) {
+	case 0:
+	case 1:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI;
+		break;
+	case 2:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI;
+		break;
+	case 4:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI;
+		break;
+	case 8:
+		cfg.spi_frf = DW_SPI_CTRLR0_SPI_FRF_OCT_SPI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dw_spi_init_enh_mem_buf(dws, op);
+
+	cfg.dfs = 8;
+	cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
+	cfg.ndf = op->data.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
+	else
+		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
+
+	if (op->data.buswidth == op->addr.buswidth &&
+	    op->data.buswidth == op->cmd.buswidth)
+		enh_cfg.trans_t = DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT2;
+	else if (op->data.buswidth == op->addr.buswidth)
+		enh_cfg.trans_t = DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT1;
+	else
+		enh_cfg.trans_t = DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT0;
+
+	enh_cfg.addr_l = op->addr.nbytes << 1;
+	if (op->cmd.nbytes == 2)
+		enh_cfg.inst_l = DW_SPI_ENH_CTRLR0_INST_L_INST_L16;
+	else if (op->cmd.nbytes == 1)
+		enh_cfg.inst_l = DW_SPI_ENH_CTRLR0_INST_L_INST_L8;
+	else
+		enh_cfg.inst_l = DW_SPI_ENH_CTRLR0_INST_L_INST_L0;
+
+	enh_cfg.wait_c = (op->dummy.nbytes * (BITS_PER_BYTE / op->dummy.buswidth));
+
+	dw_spi_enable_chip(dws, 0);
+
+	dw_spi_update_config(dws, mem->spi, &cfg, &enh_cfg);
+
+	dw_spi_enable_chip(dws, 1);
+
+	return 0;
+}
+
 /*
  * Initialize the default memory operations if a glue layer hasn't specified
  * custom ones. Direct mapping operations will be preserved anyway since DW SPI
@@ -829,11 +912,13 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
 		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
-		if (dws->caps & DW_SPI_CAP_EMODE)
+		if (dws->caps & DW_SPI_CAP_EMODE) {
+			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
-		else
+		} else {
+			dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
-		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
+		}
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
 	}
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 81a433ab759b..2dae81c15423 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -102,6 +102,9 @@
 #define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
 #define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
 #define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
+#define DW_SPI_CTRLR0_SPI_FRF_DUAL_SPI		0x1
+#define DW_SPI_CTRLR0_SPI_FRF_QUAD_SPI		0x2
+#define DW_SPI_CTRLR0_SPI_FRF_OCT_SPI		0x3
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
@@ -133,7 +136,13 @@
 #define DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN	BIT(30)
 #define DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
 #define DW_SPI_ENH_CTRLR0_INST_L_MASK		GENMASK(9, 8)
+#define DW_SPI_ENH_CTRLR0_INST_L_INST_L0	0x0
+#define DW_SPI_ENH_CTRLR0_INST_L_INST_L8	0x2
+#define DW_SPI_ENH_CTRLR0_INST_L_INST_L16	0x3
 #define DW_SPI_ENH_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
+#define DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT0	0x0
+#define DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT1	0x1
+#define DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT2	0x2
 #define DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK	GENMASK(1, 0)
 
 /* Mem/DMA operations helpers */
-- 
2.25.1

