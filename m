Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF3C3C9ED9;
	Thu,  9 Jul 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585646; cv=fail; b=hHkNgoIc9pjV6k/g93lJCNQu7TRYgaRuH/M4zzWbgw0J/uuOCEsda7TipBzPVEO+oVLDkPh1brCXd329Snyx/7aW/XUdToL1hKz2E7ySFFQyxEXquKG3vFe2wzsBVy+pQaFkA9qWHkY5kpeLcz9qu0BuH44MhIEDGFF1tH7Q8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585646; c=relaxed/simple;
	bh=esNg7GNyINm/ufnwLz65UzJu6jnE9TUlXYKPtmCswbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/KXpSOvke7xR1gOcKL+FIX3/phyqTwzBAO0Cnkv/WEmKI1SLd+a9SDzCVaGcZ3TVuDADrlkfcVfNfxnTt9S/Ozjx8A5jK9Cei3eeQ++Zhjm0oXDzTo9HJRflQm2VlYUGz1DK1ytaSc0HljYhwFVnzvhB34G78DSmHhSvnyvSiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw6sNeG5h0kvlrjUk4mfQsG7ZoaUC00ZiCBlgYGaq4LPBAUelAtitReCsuDreO+XQZorOKdqO20NO5TIziuiiLbOMX6j+OGdLWjxNOiQ0i0A+ZXBwJq5hmAKqNRm2sUXbUERbn4ZOe2TqolsqmKijb53GMv8XSZ4s8l3rnnW2oQwlWW2E+80sr+Kv/YuT3sZLb3ipondLWrQ6AfyG0eZpI905PqP1GNfSDOB0HaKz8TH/vd+UpeqkvA/CCAObXf1VwYB9zTMnjhjkF/IGdBSVpyUo9e2GA85OcOuWWpiXnfe4GIDdXAweh/uLeasaP/8RO8dnW4P9MJouI1iOJxkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urVPZf9wdL5Glv1hQOkcwqITCsoYELhlNx0YBkxi5nE=;
 b=CDKO9dBWeZmwWDTa4kkCK3gHnojKvF9qbBbJ7lWE3Zxgfj+av7nXh5NYGtxeCn59t8rFiNhluEa+fYKLtP6fk31t8oIySIBPpocCnHPUwYqnU+oaYA43xGH96lrDhhjr3uIIuf28vTwny4X3pVzdPSBPl9lvfIXXoz7xRfH02mLRWqV+U+1zxynAE4KVURn+i1Ov2xM6Kqu5Bor1EQ63AAa15Hgbxh/ixIlYzwrSCptrPo0EISZE7qFXGZCfsXaV5/DkaApwHDxAAMoFGuUTdQKnh6E2xODfeW1pgpUTz+3edQef0lwu97Inj9a+wjTIimYnoHpIu/gih5rA3rEavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:19 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:19 +0000
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
Subject: [PATCH v1 03/11] spi: dw: update SPI_CTRLR0 register
Date: Wed,  8 Jul 2026 22:51:56 -0700
Message-Id: <20260709055204.138168-4-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c70bd3a8-e688-4e81-bfe2-08dedd7e3d18
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IvzfiUNkjlikiiccK4wVdWHrl5AKTKwDXXG525eBc2VLlQSmEhmBTxtQMD4vy6tmiXJK3ry27DSh0MGvMFvJI7zLpwnozdn5BQ9Zv750hWYYVh/k65FR3z41wRD1g//c4u3qgCCd38EZNOAJcrxQsOQGmmrs8q/Jc3Z9wVm2Ebn0WeJuxUpnWUhiMeNWDsvf4YNZcw7HWVprMpu2HwKhly7M2AneTMIxSaZ8Oi7h7sSLvMvNoOU6uhNnYaLhIJeV4y63u0IwkIEqX7xY9Vttb9Re4FapAxw5Ob6yaBdnyaWP+i1yWlk6sGolcM4Itim/TQ+1qVBAAoto3YqWC6Cu3YRmA8UA8Q5h9u2tGhfz505bP7QMaNJ21d/zgnXVshdfzLzOB57VQyF/lXklr+kZK6hg5LUEwUHaCG44HLWIgoI+PbxPnxneKiOLu4Cpl+I6woWw7LWf/jPYmOjsSIculZ9Yf0pnsfn7Xg9OI3lWeW4/FryJ2qZg8C06zHCfAuE72PRg3tJ32owOXUdijPs7nNCCFL8DfywUuARQ8Vi43uDjq5309cZUKOTEtgt8c8Tq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kFtF5MjapGmupg12Nho4CiVrMCMBQnjIvijKt8iZX2Z+hxSx8UNBHjRVAVa?=
 =?us-ascii?Q?X+0MPDMDiq5HL2rtVLdxvbIXMD/Xn7+mUyPotB4NalEZ1G1H3597JetFjbKF?=
 =?us-ascii?Q?P+pgXh4+VjdVSDfFtYri7fFY0R4LUNlFAooVleR5lmG4wK0frH4rBGrFnfuu?=
 =?us-ascii?Q?U8wjF58xpLFDL8YGIo0a63e6fmtf4MSR4cBxuRbRIMdCy7BMPuBZp1wXz8Ll?=
 =?us-ascii?Q?6pmZC7LMAkADz0Ck0nInTnqMONBvz1rJ/gN3Wdi8I0YarWVYWbCLiBdwU33L?=
 =?us-ascii?Q?3pUYu8mrwJCtb6534VT5lyK048G/ubCLuYvdNcibJ51kn2FMpZdtlOG1c7td?=
 =?us-ascii?Q?Hs3iJnw43nfqca3vNJAwaKo9FNcalzuKx1noV8e3hmKXHLqHcHZABEsmd5i7?=
 =?us-ascii?Q?tWXomN/t3mWZaTapiz/frUqOKxogTm1eMYWbq3nMM1EnXkKvpiwaxIm/5JZJ?=
 =?us-ascii?Q?gOV8ILPvFL4LMlf9Gv1G630TrywSsa68RBe9NsPZgKg28+Us/kaeLi1R6SY1?=
 =?us-ascii?Q?gRCy9p4c7RBKW5+NXoSnmWLtGWLYiT/P0LA1E9GIFbwRXET6PXdlHJ9BnodK?=
 =?us-ascii?Q?2aYWuMKeTdBlAsGPp6TZUFpP5v5RDIfzB7Szxs3wbOXZUSrAyRoRlkbtFATC?=
 =?us-ascii?Q?RsrPji2Qn8DjfJhmoCoN1xkDBMEKCDmTAIYcLJ7pNHiC7DaRfEbINmMpXaSj?=
 =?us-ascii?Q?x0ZHpLuWTxYqQEyy9KceMutBj4SuKAPSXNrANlM1WPdvW5JmbHknbFSl6j0O?=
 =?us-ascii?Q?brvlF8NQy4VjzS0oTirnlRewTMJyPVVL3RQEpehEuWIoVGPhyyzFuOSqoc+A?=
 =?us-ascii?Q?b5+aXSilFmZaylwHj/7dXljUIjZxPHcZ5UbqW5H11Wg/s4XY948vTmppldJo?=
 =?us-ascii?Q?AYS8hBcQiLLrHNc3Sng3M191l2qKMBAjmuQz2HUJ1hm5vv8ukI2W2h47zLJR?=
 =?us-ascii?Q?8g67YW3vpvBndUhNnldxU+MuxW0IECOabOZ/otGbMa0p1HgBU55F2/zYhavz?=
 =?us-ascii?Q?03TEcIi1nNCOeJltyBL9ee/WSPVBYnT1Y7YFvIihSwL+i8BpWPL7qkf+V76+?=
 =?us-ascii?Q?uQtYxMHl/OQbs+3Uyn785qxYrnAx+7rW7ovwmxo5GJLKSQOZMnmda4/fCGWL?=
 =?us-ascii?Q?GTZoAUqrsIwfHRXf+vAje4PfD/IIPlm6EOmKS6JA9YZ2sa5UKKdNifjRs07N?=
 =?us-ascii?Q?UoYo7og2tK38jj1TI2JMdQk7Rzk+WSbMY8UervSjpkNi5n2SuCKSrNI35O8v?=
 =?us-ascii?Q?8xpmv0sfKHkDeqUbWtrHMfvYutbXC/08mys3SQzUpl8No22o2l0IIWkfA9sn?=
 =?us-ascii?Q?lknO5zT6+OTWNS4NnbKlGUETrdzX4vM+xQqmnO6OHL18ekyNkKlQNbSfWzFm?=
 =?us-ascii?Q?tdtXpT/QWEOb4YXRw+VP5qGAkEKhOAqgFPxy3AaTVNip2Y63gWc8H1w7NZCa?=
 =?us-ascii?Q?9Es3cNC++nkxlCTA/pMHScfDpijTG40bFoTApUEMNQ7SgVfuHyC806Sak0VG?=
 =?us-ascii?Q?NEsSEbTT69Lnzg2HV3mrootA+RoxvRL3Hq8ACriql6DAvyOyPiblArIsBxrC?=
 =?us-ascii?Q?z68AAJDEoVIXeJ5bJ54WSuU0WU9BofXGJMYyyk1cr2xaTUiW78Oetalo46iu?=
 =?us-ascii?Q?tA9ccTgPxvmOQ6JZPwJnkoOJtZBs5CZVpyIApqdHcv64ZaT7/ASQhQ24vB+B?=
 =?us-ascii?Q?ApYpj3/vf/e1VXtOEah63AYxRs6dHxVo/K4lK7JfomQXpVJ2Oeykx5i7ui+v?=
 =?us-ascii?Q?Mjnx50r1JN9Ubr0jcIDYWHMdS1Hy37/svL+Wn/PcRoH9TX2bzYGO?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70bd3a8-e688-4e81-bfe2-08dedd7e3d18
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:19.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFBfLmKcIRnYqU3i+996bYtoqR0d69h4MRNNOD+CQFmc/j7p6kCRWIJfRTz1hSTp4Y++CiHxqtb6RIGR7ZH+N+o+daZu8daQaECClyXjImppFjpVZ2F1evdlto3vffBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

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
index bd41e1b4dba7..fabfdf4ef604 100644
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
@@ -366,6 +366,15 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
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
 
@@ -451,7 +460,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 
 	dw_spi_enable_chip(dws, 0);
 
-	dw_spi_update_config(dws, spi, &cfg);
+	dw_spi_update_config(dws, spi, &cfg, NULL);
 
 	transfer->effective_speed_hz = dws->current_freq;
 
@@ -718,7 +727,7 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
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

