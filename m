Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FE4014AA;
	Thu,  9 Jul 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589293; cv=fail; b=Swne13ao+zP74euZuGLXS1XxpSm2k4ojDC+p5wbF9+0YBjJss5Z1BBJySnEUqxbjHYKhhl+5sZRU0JHTTfFq4a37ICRKIQi8z5/xBxJ9rydHvR9tmWdEV7iTAyclm56yNTbcGx/neqXfU/1/J4UZh0GXZUWEi6pzmFnnD26Pggo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589293; c=relaxed/simple;
	bh=QZTzgB7FNnKVayuuzufYI1xUfv9yUmb+F7GHUHEWLls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzMoz9EqS/g21PRaWCmRQCZeDWK19Xh0v1YnzP/w/Vjy5QFQs2WSzQIF3PWHdRjMDxDhX6O7NTz/fdesMqi3wHvT9w8E16lv7qtWGA4jRpqHLV4yjPXwKFIRCfGPcunmGqHalNsX1K2FsPXtbY8ESOFg+eD25HxSOWFFlPoMhF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrDbg1CbJNhwwiPACxu7u4Uclh0RkeHJH3WFXjax85fYd0ht5xjcZBe2dg/zRQ/UrCnEJhGy6uH6NZmbGuJUAIalYjvSnWtKNuppDwkPJNhPljJ//2K/2k9VJuPQHorUrmjZ3ttXVHfRezLG1ll2Kv3vVTRmlehEKEA9XYI7RgW2JmiPEhyULzOcKD12+c6gccY9rn/FAh1VlqdVFP4wjfR64bTHqiKThCnFFRDPRQaDxW0UmgnWv3wG1xTymc9Jw4RCAaIZhNvOxtHS375jHaB8GgkYZ6FLHiet9SVTXi09tRAU4zD9erF+vBc3dF9ame75d6mQPP+2H1IUkxfeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP8tMIHHeK70idgfJcXHDnj6QWKRa8fLvzExMJyPOz4=;
 b=cyHVWfHvhyUEgMxxkXKdnne6M/C6yokVA9xXMyCC4ZXcdoZNe77cN5jJjGZ2jKh+LnhnFhgRcSytvAZ2tsTun4TZUdcgchKnFPWyOFA4fhJSaECB4QH6Rl68vb0rWhetrd0OInnD8Eni9gchJW+jBvg6QCehkd9nLMHunnYNJgILex7ZiTw4Norlf+bc72EGiYB+hL4RF1uYx/wCIzXr0NpzZJbtQigKyFaCoOFX4MVCdAfgFPjHy1Y6TdmsN8cQ7H8k4Qj7tWb9YWosFB5gpTOlOWYZtnYsr36VOrHP/TlLzZDe08b+jUO8p37poQ6MzLki9nlTLHWxpXu35f1P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:25 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:25 +0000
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
Subject: [PATCH v1 09/11] spi: dw: detect enhanced spi mode
Date: Wed,  8 Jul 2026 22:52:02 -0700
Message-Id: <20260709055204.138168-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f448a82e-517c-4657-453d-08dedd7e4098
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oFPsUms9UZ25IS/Ua89l6yvp2IxLvu3qgcvdx7xuTz0Zp/WWh18Q4iO8JeclRyVBrLZTcAU/f9VlItGiyRxRiNH/uyAYJX1ABJLFsvcdOa5WGx1V/3SX6hdLPcxfq+T8iH/SQhmeBO/eDiriJ6dKfqq+1rwz9DmuoQq3agKOnrc2vX08pKSoLnB3xamXrBR1zrD5J6OQaG/7oFLmZmLyPPTeK5aobnXd8ES9RfQwClMS/7OudbgwxxWZyCD5m0YTZLAAznnZOEbrbako/EvdEmJn/c/DdbCCOWXCOr7O6kDkn/kXt82gpE1Z1hf7n2UqD2bMN8NrodGzqDa4ypV8VF+jZ/LtT+xHizqsBPZgkuoVhIIXjAWZgfc4G2EdFkoVvx6qcQsXfPNEOEmkfA3L1K1djLqcjRcj59afJeyl6VP0F94TuWuJDhIIZzkUqkV8Z5LEZDZ7sT5FOvuCqWOC7giR1r1PR8BFb9eAOlBtYhDg+1xZhoL2LtI3TEtDK9GYQdqyOTT0xwwg5C3EZx+9U6pv8geyNvdVRa9m7Cl8+N+tFbu9voGgzZNuJfvpn4Ib
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lIHTfRFXFpu232dAsqosJMke4e+vyLexUxggbG8Fp28hcvB6rc4USQPp32a?=
 =?us-ascii?Q?LLv92/vb+7I9kfvIMwMOFd78T42JMNrbLPnrlb4i1VA//WH0Kk+GCOqOiHZg?=
 =?us-ascii?Q?3MC6x0HpVE0keJCCPXzTzwzgkLnOliBcfrHPS/DMRJq9lmtf5cC/RqT4El+a?=
 =?us-ascii?Q?tG2ARLEAjKxF49U0WqN0tx1CGFtdIr0hFsxPzsOOqeyEZ7bfinKZEMt9RcAW?=
 =?us-ascii?Q?nKcQQ4Dy9vciOYfEUVJF3tERhGCUKtmKuRVgIIjnivaKjR/IG47Ar52FNtFg?=
 =?us-ascii?Q?yLMnSOS7DlI3iQ4ypngaN0nm5o+MZpkjnOym8E5FFcxbKQovrP8pj74iYNqw?=
 =?us-ascii?Q?eYR+vBwRkfSVrDBpK/dECHuU+rM/Hqdhs2IMHb8Acw14dDa1mWrcLfytr/6e?=
 =?us-ascii?Q?/GGi/qHfg43K9H6MGILwbBFbTeT5ltG7boDoptS+GT6x/p/QGrm83ZrmMQzL?=
 =?us-ascii?Q?jEI8MigeHGHG8DtKxUV4MiUbG7xec9/x/cxJote1sZjcXBD13lWdSHFXsQvW?=
 =?us-ascii?Q?Q4tYK/lWSl31p8kSuAPlZO1Rqa5DBdKu/sN6DVY70Nst3hGWQER+HlEdqBql?=
 =?us-ascii?Q?eYBPEx1csGoB0ZQgnaRpbARxD12LOiYXQMLgL//VNuBOHixVFpwkMhHPq4fl?=
 =?us-ascii?Q?NeKZZIhmuQpJEh/QoSMKc6qYyV06Ut6GhmqcmPxqeWDqRg2RholxI0Sug24+?=
 =?us-ascii?Q?/8+tUzWaIlfNXw+1Gr/5hTjbTKZdKJRlpS8FPJDMCXyBkYMZyBWkYWw4xhq4?=
 =?us-ascii?Q?ijUYoOJjcTLjW2+bMGwzLqcBghTx1h8e2m26WvXgpCTcL3baFoaMkWvMWzBN?=
 =?us-ascii?Q?u4Op2XGuuYCo5aypxQmP/PhnLBcPRWK+ehJkBL8OglXdqNFwRk/l98qBLiX3?=
 =?us-ascii?Q?g0btiMVFfLpNGgI8YhZjWG6T/WYp5jeVcw4WZIVwyNoa9ON/xW16B5RoIpkQ?=
 =?us-ascii?Q?c/VKy83WFefbDmp14toHOQg/XjCu81cUYt2nyHCIvXxUgFviRHmUnGkjPjnP?=
 =?us-ascii?Q?Bpw4suvQoaj9TlsbWNUtEE2f+MTn19GiRl0lCNXEFVxiTd5be+df5LqrSWOU?=
 =?us-ascii?Q?U4FtmFW1hAZCUjBTvQU55Jlz0asUR3BvBKYme6422/GsclqdPnG7O5zpKjVc?=
 =?us-ascii?Q?rs3uFVXdBPR5AErfRmWV0OiWeSdL292+CZlcVxVvSel7plwC3bawzV46z16Q?=
 =?us-ascii?Q?rEEzePSmTT2K1DEtu6ERrx+VGxk1JfT9tzXvhza3SLXYC5isBzhJRBdbIMSI?=
 =?us-ascii?Q?mrCZRhGQQ/hDQZwomT9GzWlI/fBdwfitmcdqv+0yXu8D582xT9tUF+ECYFnX?=
 =?us-ascii?Q?8OqFGraEmdVumwcbzwqziBmd6CYarySkrRXFuPczHd48B58rmL8XaKyFVj9u?=
 =?us-ascii?Q?4tJzimlN8lfxofHgFPdv51QLj5LCIXrDY5tHLblIKvaL0Aa7DyWFClrm0n4Z?=
 =?us-ascii?Q?t+LBlLmvwbOghckYI6DhGAaB3wu63TdpDaCDqCjvVYiDNhzU0dZeI/m9ohZa?=
 =?us-ascii?Q?SFPiSeL/ukvLcAaFSicikyTxgSvM4wsrojbtdsna9JhFl66XN1AM4OKdtG4R?=
 =?us-ascii?Q?xeAYB4V94LuhsBwVtxj8VHEmeaARP1HEgq/zSLOoWsvrsH9MFw/sLMqJzA7P?=
 =?us-ascii?Q?hrIzWJ/rvABbebbRTVfMrKgWr+bGaXNK1JwAJPB3p2f67OuyPsHNSCVb1hnr?=
 =?us-ascii?Q?D34IbCYuANnPqNvMCIXdIyHWajyeUQhuquHoSX6hZef2XN0TteZRrKwVMmM7?=
 =?us-ascii?Q?XgqBl1tjB4RR97ZRgUJxhOBePi44uPnd4qFkB5Q9encUV+UgL+B6?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f448a82e-517c-4657-453d-08dedd7e4098
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:25.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JRbqwdw6k/nHr2DOuR4RqlEQMkxuiB/lIPNapxzj5Aa6CARJC1Hm1eawlXOyFlAgxfiLj+YQEbGLhLMNYfULMPWvvsSIG48J2w5Ea4S0NiTQacVsjbkVsu+B5izqb/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

All the SSI controllers supporting enhanced spi modes might not support
all the three dual or quad or octal modes. Detect the modes that are
supported and finally enable the DW_SPI_CAP_EMODE capability which will
start using all the enhanced spi functions that has been added.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 62 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0dbf250a101b..0abdee82eaab 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1083,6 +1083,64 @@ static void dw_spi_cleanup(struct spi_device *spi)
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
+	    DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN)
+		/*
+		 * If clock stretching is not enabled then do not use
+		 * enhanced mode.
+		 */
+		goto disable_enh;
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
@@ -1162,6 +1220,9 @@ static void dw_spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->caps |= DW_SPI_CAP_DFS32;
 	}
 
+	dws->ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
+	dws->ctlr->mode_bits |= detect_enh_mode(dws);
+
 	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
 	if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
 		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
@@ -1206,7 +1267,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_init_mem_ops(dws);
 
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	if (dws->caps & DW_SPI_CAP_DFS32)
 		ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	else
-- 
2.25.1

