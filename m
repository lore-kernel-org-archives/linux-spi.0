Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BF4195B5;
	Mon,  3 Aug 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760868; cv=fail; b=FgIhp5n4A4dv8Xev8vq85euZ3tsfwWusuDOczcVgeb2f6LYzs1dQ6y28y27wK/uDg1CNrI7YN0D9PDdhQh1xoZnaQHs8ylvC24tFP7q57GU/sVyMwpPO0JMa8R67TYI082Dg77OyjIrGtQYY1/XIkgQEYiyz7J0XAcJsvy64tSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760868; c=relaxed/simple;
	bh=/dwlo+HKG11bv57IM2NFTbD5nvIPlJ0FeqS9dwTrX0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUiR3zgW6twSpJTqV38zouCm2st3xJmh+A9itfXMwgMl41+KJ4jLRCOvx8d0o5pGd9U7slXxjJd7kA3Kl566HuLTkT6MmEOhZoC/Q8YuXYjGEQVzXKlMxr7y9Ua7qq/NtvmtWfbYAxrtNBAsxz3Jpu3tFd36coi+VRGE9gLnrMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz91O+sln6h3nm06IsHCn+COkBdVUkWVU8uZSBjfJ0MW5Bb3d9ifSsAAynE9hjttH4r4yzhZ67C5n2iaJ82SnJM89rq6eBlFLgwku1sy8HXL9LMDTMpcGLu5o8e4yG1jpjwHpsHN3X3uJtHE3aEdy6SQkdXvgtv8guNO5Y6hOQlOxgut/a/GQsvDIuViQ2aPzc+4VGdFCUkXbf9DjCrQlCM5CxWorDF90V/gDDhoRAcxMzbvVt5rVM2nwpU2RWcJe1fXAd2+JjOrr3Fn4hoPJeGuXZGeDbs6bSiYZO5mZu81J2xnW8EtEjf6VdEyfqwCpEAY1/zXCwj917wGNPYnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2OplIiNX6SWaCfDxn8hAcGzUnPJcCcOIQsmZHsvHZs=;
 b=lNj5zbMsp45yNNQzcYV17JYxT+9JGm3L4CH3+Ru/l8Zu0XVaHxuGJ5xvX37QLuptEfa3T2tBONgYqOfxn/XRkaAt1WVleRAFOrZrFNmEuLFvLkMrs1XD+uJLsGffGUkIAZoRrla0y52RRDYI0gbEsexO4teSR46CED5ZJ6aQfdSBV8OuA8l5wJ9VORJRrICJ93mOoyUI/i5FDs+HSfTefH1hbGQAWyYKcJznUYvlQPrKfoxeXynGifQliatSeViLVD11IrpdQABtNbJdjgjQHQ3c5TV4MNqWibSgeB0IhkRZNG38NS5GenF4UAP3blTOUVN0HN8VsbFIoISUeJLuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:40:52 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:40:52 +0000
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
Subject: [PATCH v2 01/11] spi: dw: Introduce spi_frf and STD_SPI
Date: Mon,  3 Aug 2026 05:40:34 -0700
Message-Id: <20260803124044.156998-2-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46f7c7d6-11d3-4842-12b6-08def15c7479
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	04gNYfLKU8Yr7ke1IRruhZ4DkerV2VXDc9VM4D5URtT5zwBxoozbhaVT6V3wrunwHGH5lSpT8APo9AIU7xs4bEGDMipCBRlYmgrEfMvYD/gxwWRBI8JhwlX6r7rAyR8eo4v6dHGBnHpeWoSIFM4kYW1qVId0j4mAMip7m4PqLzKrW7824Z03nfH0D7pwvqoG9wTjK+Sf/kcuPn7ntVUZM6pqDLm36XMdw5EwMW6BnZyUz4h+uEhu7yjQCTnlF7TtsCNE7L6bttqkjxotOVPUCPqhA+vJBqxnFjSde3fHRQ18ZO28hbQUCIWjw1HLTdMmdqgYqGyAxHpo/MVymvtQJxs7XiKklv6JaqLAh4Sn3RGc1o9w88t2HmpromNYUnzdnQ1eoqfUI+OGWc9/mnE9Mo1FHq07ls/lGqcw5/kDT7X7WH7VuxfGJGwAH2toOCePav/VY5arH7mGQYqHSvlRf+LDYNfjGEM/92nOjvErlD66u3EsOu7hvSSW3ohStp/W59A5FO+wWB+x6BT0mW4Oy7JuY5JgrMhUv476lbdtHXSiTnCXF7L30xmkZ87h9Ayf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxOfoK1G0wy7+STbmFj1iehfFpyxFEeFjps/3URmdWci64zPCz1kz52/3sbS?=
 =?us-ascii?Q?LVJnQqb2dLbRCI5T6lSOZjvvuoUOM3wOnK983vjRmQLQnvCL/G8LFg5H0jVm?=
 =?us-ascii?Q?0A3mKWmYyEPIrdJoTPeHT3Yj7Dx1Cxywg0mBn/FB1OSuXNPPh+8ZdlI1ET6G?=
 =?us-ascii?Q?e1ZhxTneLDDSnkQUe2f6VDZhyy4fWcJ5WQA33a9WAzIFU8LenQS3TM3/aQE6?=
 =?us-ascii?Q?iVuTlN7auGdgJFkZGk024DC4o/NBNJqJXMVlJIAKsNeHrK8ZpQsVvg1vq0+k?=
 =?us-ascii?Q?ldSJYx4wvuUL4rzONbgiS4jHYc+rpUN6zGo3qSStBdIPCc76HgrYWzvzROo9?=
 =?us-ascii?Q?HeFQGJdqNsNS+/1QZKrn/jWEdN7IgW6AT8/RE2Vp1GxplRGLUsbPNMooyzMW?=
 =?us-ascii?Q?9nAt+TuLQ9g7kUu6p/i5GiLjmu3/AtZuML1PUv7B29dwCBiJ13bE+YrBm9ZD?=
 =?us-ascii?Q?37xw7yHCkENScZTzHElkt2rVZR4ftVsp3ibBIqwf+7j0eSH5+VksaUxREFkY?=
 =?us-ascii?Q?hIXpALi4w3iykxJ7adVw1feVRBkJcVMKjLmLo1hJS+QxB3n9QchcaOUYY+TY?=
 =?us-ascii?Q?OV9d4rNCJU+narc2SEt9xM5WVb6CrlRtwNlafnIm+vz3FmrscJ18DHHTc/3I?=
 =?us-ascii?Q?hNsbJD6UEr8Xy8yZ+axwl4+Z8kqFGgHetov6L0HGcOqAZ8fKfubCyJ+/GDJv?=
 =?us-ascii?Q?1suChM/R3fTeq61J/U8fCkCBhFSf4ClTTZy1T5H6dtMO2jpdfDxnsXKS1pns?=
 =?us-ascii?Q?qevpi1I267camI5eQ+T+mAkani3UHxv5jX3bcJ8kPJznwOxkIZkARyT7RKDR?=
 =?us-ascii?Q?hfFhRN8JTPb708fXjFTTXL69pih2IFhPtelF1voZ3anSEv5flhUndg6Md8O1?=
 =?us-ascii?Q?5Z1yJfkzusyZEoXSZZxTVE6q5J1OUmCKZL73qFETdZSoJ79GpzSjEECnlEOn?=
 =?us-ascii?Q?1xmNUNxJNbX1lrWTCg4Y2k1ezxk0PU07+6wubCnEdlWx/Sgpma2vNCxPSD3t?=
 =?us-ascii?Q?sOomtwrDdCo1aVarB70zRPcX1Tu38W1NZFw2jlNx7xgze8oCTunur0vajVlU?=
 =?us-ascii?Q?RSiDI/3rBUL9Aa+k+/hSub6Us1J3fgvM7vJi/YxP/Y+HDo59uhRcD0wotB/P?=
 =?us-ascii?Q?Zec+t2mLm05jGIomEjFbAbfCgoQkNYb9XRG4S+eTGma2DdAmJcCfQ/QalZjd?=
 =?us-ascii?Q?V+nVRHnW9r18QDr9gpOLy3X/9UD7+Opzu8vrHYIKFCCv7j7HMaJqA7AFW00/?=
 =?us-ascii?Q?qw8qcHut9pW4IFGPBGg7I/aRjnT0NILnrwxVvA0l5h5GID8Plcrqp37T7S45?=
 =?us-ascii?Q?mAbxD28u8diosgUSi5ZfML5FrntOhVLJGjqOWnPlEmKKgS3sVCR4Fo2X77kg?=
 =?us-ascii?Q?Q66IidEwztwPi93RBjybTB76KPfxL6IZnPAfqZ9jHCiGPVM5V/UXSle6rJd4?=
 =?us-ascii?Q?7vOt9PtpQnL8h9qfPGJOkD+9M8imzV8usHzH5stHcjBc2xssy/To7RypOfyX?=
 =?us-ascii?Q?1goc9YMyicJahuOGyTS1aWXTSIeX6cJmqeJ/thPVwhWsXXr2abSHHcTe6aCb?=
 =?us-ascii?Q?1YzTF2lVBb2PQ083q4WDUNNLG+8LZgZcmFdIuuC74eTVjUd8Cmdfo1yhCu2t?=
 =?us-ascii?Q?MD2JdefGnIpSFvvivqzisXFQF9ma4m/Gp1KmxWlCDb+MC7iYkBKwjHk7Ilmn?=
 =?us-ascii?Q?38IXMWVb5ilBR5tlLW7mOQLiOM9/DdNglrDR5Necsq0DZ4Jd3K/75W5wgNkZ?=
 =?us-ascii?Q?RrHoj65hxGwVRoKvCLKIdy8vQGlrVwo9MibuB4oF8XNKdmvB1ghv?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f7c7d6-11d3-4842-12b6-08def15c7479
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:52.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++P7haTzO1cKcunL4GQ69oInHcLOl2SGeRgsHVsWnw7GjY/vNugtjNXFW/JkNra67V+JSfgTxF5BnrOLwjAjYZ7k7S3GfP42d3kJWB8xb/xTty0eJrxkwzQO+ZJwDR10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

The DW APB SSI controllers of v4.x and newer and DW AHB SSI controllers
supports enhanced SPI modes which can be defined from SPI_FRF of
DW_SPI_CTRLR0 register. Without enhanced mode, these controllers will
work in the standard spi mode.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 13 ++++++++++++-
 drivers/spi/spi-dw.h      |  7 +++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index eff08461c2f5..86e3e7487bc7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -330,6 +330,16 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		/* CTRLR0[11:10] Transfer Mode */
 		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_TMOD_MASK, cfg->tmode);
 
+	if (dw_spi_ver_is_ge(dws, HSSI, 103A)) {
+		cr0 &= ~DW_HSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_HSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	} else if (dw_spi_ver_is_ge(dws, PSSI, 400A)) {
+		cr0 &= ~DW_PSSI_CTRLR0_SPI_FRF_MASK;
+		cr0 |= FIELD_PREP(DW_PSSI_CTRLR0_SPI_FRF_MASK,
+				  cfg->spi_frf);
+	}
+
 	dw_writel(dws, DW_SPI_CTRLR0, cr0);
 
 	if (spi_controller_is_target(dws->ctlr))
@@ -422,6 +432,7 @@ static int dw_spi_transfer_one(struct spi_controller *ctlr,
 		.tmode = DW_SPI_CTRLR0_TMOD_TR,
 		.dfs = transfer->bits_per_word,
 		.freq = transfer->speed_hz,
+		.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI,
 	};
 	int ret;
 
@@ -677,7 +688,7 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
-	struct dw_spi_cfg cfg;
+	struct dw_spi_cfg cfg = {0};
 	unsigned long flags;
 	int ret;
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..19cf1b1a5d4f 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -17,6 +17,9 @@
 
 /* Synopsys DW SSI component versions (FourCC sequence) */
 #define DW_HSSI_102A			0x3130322a
+#define DW_HSSI_103A			0x3130332a
+#define DW_HSSI_200A			0x3230302a
+#define DW_PSSI_400A			0x3430302a
 
 /* DW SSI IP-core ID and version check helpers */
 #define dw_spi_ip_is(_dws, _ip) \
@@ -94,6 +97,9 @@
 #define DW_HSSI_CTRLR0_TMOD_MASK		GENMASK(11, 10)
 #define DW_HSSI_CTRLR0_SRL			BIT(13)
 #define DW_HSSI_CTRLR0_MST			BIT(31)
+#define DW_HSSI_CTRLR0_SPI_FRF_MASK		GENMASK(23, 22)
+#define DW_PSSI_CTRLR0_SPI_FRF_MASK		GENMASK(22, 21)
+#define DW_SPI_CTRLR0_SPI_FRF_STD_SPI		0x0
 
 /* Bit fields in CTRLR1 */
 #define DW_SPI_NDF_MASK				GENMASK(15, 0)
@@ -135,6 +141,7 @@ struct dw_spi_cfg {
 	u8 dfs;
 	u32 ndf;
 	u32 freq;
+	u8 spi_frf;
 };
 
 struct dw_spi;
-- 
2.25.1

