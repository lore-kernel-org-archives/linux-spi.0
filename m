Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740341D11D;
	Mon,  3 Aug 2026 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760879; cv=fail; b=m13ir3JXAE344Oap2a9M6NxhPHubBzJF+B9M2s7OiKEZzHs/v0XTuJPSQA8P0BIej5eMKTDUF4BGuc3mzjGXvienSIo/KRSJ4ANb/fkB3YonuZTRxWaEMmjaQEnZnwncp91mg8ueHcfrEYrDo+xqrGpxxyXupBzvR5t13YvI6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760879; c=relaxed/simple;
	bh=A3kMPYTLJBfobnlna/zLk9K3tBj4gCJXD5De7BrZTgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcS8QSNWWJyE4u4/+sXB6+3VVOVL+aVJeryETntig8WY1ruuANaH9Z6whBq29hbjwyHk/BIM1t/6wu9YqXKymoVyG0fWFvk5ObxDGw6MIeBHWljIYWh+2TXEn0fQNWJ94cGmdHy1O6meYRP2w0Vqe6LYx4QsOJ6icOeW9109ZrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0Zm5asYQID5vDOGsf9Er6Z68dMNOoPeKMG9mFV5lJwMQMW8HCOEYPOEYyaBF8m6Do2XiRpxbk7m9hKa7rqgZkvlHEsterCqowE+dxsQgUuyHNvKuQAbfh/oaI2eucVhGRcHdVfJehoibwNLLDYOIByUxGCt2qoDzO8DqxKFqAU53bPc6aEfpsCNsxHwrMTPgg1/tQHnY9VO2kMsYyy756lvcj8Gwn9kOI272FFTwYrRFCxbofQaqZkTJ0t7uHg5oaoJsOkuRYDXYM5jZ64D0t1GGOgJ3MsoL8qh3FmavWvc9UUPt6ccU0IFSbD3hVe/331k7QA1LXMJsISv0g07yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIbgA9u+WU9PgqNSuA5ZEi3VyACPvVpSatg8rjOpH7s=;
 b=BShWenziPvKRocwZe6xlC+z4nHh8nxnVfGc0tgXOaiQbNasNalWTaHJjW31+kaFs/do2x1ohHlk8GkDAauK4eXx9R5x2mv6SV+FNK38mQIxXhtZRmu4VZmGyq7YzCN5sfitY4r0rpXkKMaVuly2kN6U3niaoQxNq/MYD+0MCNoo2Br5cBqkG9/u9ClMxShTAGA+0Ir8cfvFOB7PgvRolO8hJWspNKPvxE8jb3Jf6Zd3VC3dOgdUl+r4RaNY3BRG5F2E3jgSy1vCVYqu4VqsuiRIemOtOP+KGNwMQCjjnHGCm0Tkv4uqbtuiERNhbsP33llGOwiyuiSpzRCa7RgEPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:40:53 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:40:53 +0000
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
Subject: [PATCH v2 02/11] spi: dw: update SPI_CTRLR0 register
Date: Mon,  3 Aug 2026 05:40:35 -0700
Message-Id: <20260803124044.156998-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f199778-c06c-465b-e2f7-08def15c7502
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IEA8g6SgPcwXWYsJUBNqA5FYaW0Fd+tVbbil7/TbrSVEovj3NVXsMmpUt1nHVWvI7DTrLuxexszw4R5sH+IhavPBOBAU+tpdAe5gNo9FdnSwpPt3Mco9eh82VjGXHcYh7zAfWMvDW192qQf0LX/QDgVHkNTtr1tJ41z0cBWGrTMYf2otJ2YR2noAY8zQ3sSh5V0MSOn5zgTqICWd2TXK1Sq0ohPNY+dErMgeODU0VvyPstfz7VhwCYm1XVmsXoe1ByJy8HiEtLC+M3IAHeWbeeaQvekt+/vamYGha1HTezbnkXrbMwCN4aABmpXTdcHQ7tWsFA3EfY+NANlpuUNI4O9mzjF0U5WqJ2gCZD4xEir5fupXVwAP+Fhz9xtgrIxCy4uPq/nvuyZaMmWW14vJYIQmvV2ODplSmIsYsUgmANQwZeV7ExqFThBgtfFEQ91lVkgIRq2ymScltx/W9247JydAP/r2NK1ciaN4hQwI0kXXJuY9gN+f3QVjN2hh5e8Exbz2Vj1/or4RbqIGqOYmMaXHdvsIRvGQWicsvPgkh7Cj0g2ONxZcGqEGPFvKfays
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6k7ClmUhmmwI1oVjii5FkEM56kC3jbb73cQUa9Wl3tzTPts5tqB6tbCFCHi?=
 =?us-ascii?Q?jItk/EWQ+jrbe2MGhHCu85aAqd5oxvxQ2T8jOJ0o1qY6phMwClSIfxY4V57L?=
 =?us-ascii?Q?DpEGzjE9shXt5+yO1oMh0sKuAHjL6xr3PCGWdKCvc4FPcnkRQNSiHk8LOto5?=
 =?us-ascii?Q?90n+zdw5/N8DRzOvHTdGRXfeu0GxkFXNIh0Zo/bRAlSl1NP/Dh70lYsssdXA?=
 =?us-ascii?Q?xj0k9sHoi56Ig6yby9ZQjktF1DnUkCJ2Tf9TQQEMDx+8TQplWdO9mmY7VXYK?=
 =?us-ascii?Q?HeWxpYe9TMfsXyG105wzshPOs4nOjComSmCQ8rGBdDXXDaGioSgbRH8Sw4xL?=
 =?us-ascii?Q?jpkEfv2l9xiJrxzGIFddVC7ZpRTMzB9YWu+aU72bPF1H4UWlM46FHyH297yr?=
 =?us-ascii?Q?s7kGsyeRQLxqaxfMtdzz2/zOevbwRKsqaOTfDzbu3DgMtjz75+xiFffCxkKD?=
 =?us-ascii?Q?BshAp1t0tt7tIUVXBoPZ/NeuddVTxxzNp6pihvefprgWxo+McnhTi/8uPC/W?=
 =?us-ascii?Q?7oncRAwegId7BpO1pGtIAXEdRnLML8gP+jd9SBTLpiD2tLdr7PKNZQtF73TD?=
 =?us-ascii?Q?HCFGFaXe61mGsl/Y+pUMdR/t4kEeLm8hZFw+Hok9QhRfjWhd5iGjmpfnIG8G?=
 =?us-ascii?Q?/+hVEf1YLFA59AK4YxYCp2gorINHhtzBdGEbLWDFI3xls5Ck5GuI5an6MQXF?=
 =?us-ascii?Q?10hOjFkk/F2s2Q5DgFumRViKABmt3rSlvhdIt1NNQ1X4ysHaRY/RLAidyum6?=
 =?us-ascii?Q?Vu8Npaf2K+toLr66ow9EOwBY5QJbEmsaFWsNnQbTQUXK0gGEP+gK8nd2cD/A?=
 =?us-ascii?Q?RE/Eq746zBNYkX7se6VmSxltxDD131HJ9yT5F8kGrMrqKZCPHG+15eIpBpsj?=
 =?us-ascii?Q?rBBkIgRNZ4GSOwwPPhUpsILDRgHv2Ee+aoDoUgzLaJraijmCDzFYg27N/x0W?=
 =?us-ascii?Q?CfyotjyyN6kZBeBQ7SkCKhAUVyP/6G21iq775Jwtmf9M8vOlpLGnjXvJPpcA?=
 =?us-ascii?Q?+tVhjqDgoKnwCaSesEaMiZvfQdAtqIF9fWCJrchEcUq9MrMKZOA9Djc6/Frf?=
 =?us-ascii?Q?9J+dDGX41EZX1yVI+iz48No1E/NbDQSl9ovM+6g/nrsdQDJ1yVahRlMFjmB2?=
 =?us-ascii?Q?dt90DeLeb+cG1aJXdw7H89vyVd0whQIQ25hPcvjxbG+DC+uo/XNpKTy71xkm?=
 =?us-ascii?Q?kEzifM34IFAqa+iPNWRB/n4XUcqLdLbsQd0+TOBpvrNF/AeHkyAJQzp3vF6I?=
 =?us-ascii?Q?qPDZsRgr3Z2HXPyOB5oYt/V+vB8qv4SqQKNlDwNWeT5RCka+pxGh8EZMBVEg?=
 =?us-ascii?Q?eIJ57BByrG43U7VsCye32eH/wF+9eIhWXQlNXL412ORamDmPo8p3v1DJ7SQK?=
 =?us-ascii?Q?uCocGQhYGuEk1sePmMyod89kgyxYErk1PWDltB7IFdClnBn8Qm6HW/Navpsv?=
 =?us-ascii?Q?f+yLv/eCG8Fx+4y4sj2aQouc+TavIEJ/a3hKcR62+YZ0wVxYYkpHVSaMLGa4?=
 =?us-ascii?Q?evClpYkws2TrmQJYREpVdBhcyp8aUNT4D7VBXEwxr3gyY2exuBxnBlzf+bKM?=
 =?us-ascii?Q?0GXNmXi6qySVFFxx+n6ESwDlV+hEjtYRRoy6BmzPoOXSlyRKTgq58zdRpRLB?=
 =?us-ascii?Q?6X5K3vWesgrAtV0g0qffWXLi00C0FJI8H9RnTZ3Y+8iJ7Zx8tl9OqpgvoCgK?=
 =?us-ascii?Q?p5zZ8QoMm2cb+ua3+13a2jW6jTy6QqulmerGi3jYPdgw65lsHFYdNBbi1JT0?=
 =?us-ascii?Q?mye/1dNG22T4r/xTdB448GsMxqR5+s6mOalieGqYALBLI8IZJTeq?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f199778-c06c-465b-e2f7-08def15c7502
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:53.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0eEOH1kGSzk735f3lQH1INWrxnd4tePWmEqQlGzZAZuHSAgsqyDO+S/YxScAPcVpoDRF1GJIRMiLsIb3UsNkhXtXdkKUu+9a47xrlnhFk1JGkfcVt9NAKXlj6RMd/aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

If the SPI transfer is being done in enhanced mode then SPI_CTRLR0
register needs to be updated to mention the instruction length, address
length, address and instruction transfer format, wait cycles. And, we
also need to enable clock stretching.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 15 ++++++++++++---
 drivers/spi/spi-dw.h      | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 86e3e7487bc7..7601a53d6f34 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -313,7 +313,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 }
 
 void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
-			  struct dw_spi_cfg *cfg)
+			  struct dw_spi_cfg *cfg, struct dw_spi_enh_cfg *enh_cfg)
 {
 	struct dw_spi_chip_data *chip = spi_get_ctldata(spi);
 	u32 cr0 = chip->cr0;
@@ -363,6 +363,15 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
 		dws->cur_rx_sample_dly = chip->rx_sample_dly;
 	}
+
+	if (enh_cfg) {
+		cr0 = DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN;
+		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK, enh_cfg->wait_c);
+		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_INST_L_MASK, enh_cfg->inst_l);
+		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_ADDR_L_MASK, enh_cfg->addr_l);
+		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK, enh_cfg->trans_t);
+		dw_writel(dws, DW_SPI_SPI_CTRLR0, cr0);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_update_config, "SPI_DW_CORE");
 
@@ -448,7 +457,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 
 	dw_spi_enable_chip(dws, 0);
 
-	dw_spi_update_config(dws, spi, &cfg);
+	dw_spi_update_config(dws, spi, &cfg, NULL);
 
 	transfer->effective_speed_hz = dws->current_freq;
 
@@ -715,7 +724,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dw_spi_enable_chip(dws, 0);
 
-	dw_spi_update_config(dws, mem->spi, &cfg);
+	dw_spi_update_config(dws, mem->spi, &cfg, NULL);
 
 	dw_spi_mask_intr(dws, 0xff);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 19cf1b1a5d4f..16a8c7ab7364 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -63,6 +63,7 @@
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
+#define DW_SPI_SPI_CTRLR0		0xf4
 #define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 (DWC APB SSI) */
@@ -127,6 +128,13 @@
 #define DW_SPI_DMACR_RDMAE			BIT(0)
 #define DW_SPI_DMACR_TDMAE			BIT(1)
 
+/* Bit fields in SPI_CTRLR0 */
+#define DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN	BIT(30)
+#define DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
+#define DW_SPI_ENH_CTRLR0_INST_L_MASK		GENMASK(9, 8)
+#define DW_SPI_ENH_CTRLR0_ADDR_L_MASK		GENMASK(5, 2)
+#define DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK	GENMASK(1, 0)
+
 /* Mem/DMA operations helpers */
 #define DW_SPI_WAIT_RETRIES			5
 #define DW_SPI_BUF_SIZE \
@@ -144,6 +152,13 @@ struct dw_spi_cfg {
 	u8 spi_frf;
 };
 
+struct dw_spi_enh_cfg {
+	u8 wait_c;
+	u8 inst_l;
+	u8 addr_l;
+	u8 trans_t;
+};
+
 struct dw_spi;
 struct dw_spi_dma_ops {
 	int (*dma_init)(struct device *dev, struct dw_spi *dws);
@@ -294,7 +309,7 @@ static inline void dw_spi_shutdown_chip(struct dw_spi *dws)
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
-				 struct dw_spi_cfg *cfg);
+				 struct dw_spi_cfg *cfg, struct dw_spi_enh_cfg *enh_cfg);
 extern int dw_spi_check_status(struct dw_spi *dws, bool raw);
 extern int dw_spi_add_controller(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_controller(struct dw_spi *dws);
-- 
2.25.1

