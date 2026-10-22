Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664797;
	b=FTbKr5CG4/ZM8oja8NZFr0XG7/JdWXtWRPzaWkd93XqwKea415fAaK0qdak3yZP0sAY9
	 gBFXdehcpJyovKveGIf4cqvMA6LtvPK4EeK6MJMhpX5DjrXnkEANNNejXxkpyaLUQsZaX
	 1fbA7JIBT04Ux5YR78UuI4kP4jmfNxYn6/JnHk9rwkD8FKKNmPO7ujiOHRo2H8ZHCr0MG
	 o+xyiEB1C+2+URJoV0VE9czue4aVfQUfooYRu4bsED570/thFd1lqDKeiWxl/jUzJ6Gwo
	 mFY6ETVLMCfQNTNJx/0ZvQjvm4lXJUjXcVQHFqcrhm01j3C8U4dfWg5s5QRGMOUSsaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664797;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nBTiET3Et7AEazEA7AvaNZq9/jKOprtqxBU4xnIfKNU=;
	b=Z3M7ExVWHr3I8+uMrg+btiAvLZe4QiAYfpd7cxPVHiP0UorTBtGRwLO7v9u5kJ0mRT3o
	 1D3c92rvYwN0F5m5bn8Prc2nMo30pSGhkNeSPqXxUQHrGlmvyzcXJRRKLOUFVpOYFCX/M
	 cDnpdWdk1eu4lpLm43ZTKCBvCNeqobH1dA/MEnRFybRcI8ShBrT9cakdJ1ev/CjbESPtO
	 +HTKB0OAgy6RrdS1nxTAZnqruA7lvhLjP/p/DWhL915VBZwV6JXjiOp6LkXSqnxrnorEp
	 55A4b8ugPONMfPRxQlC/5V+BICvNhLuO6OsP6ZsN/cHt1nbUm+q7H7NcYcrV13NRSrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.122
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8092606A322;
	Thu, 22 Oct 2026 10:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8092606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMWdb88kCQONDciPa/GGRFerZvKdqNQk7vEI3/Xv2mVfranQeGaHFcNGtWXdUr7/xAvQ28CXUey2qpYwgqARV8d+EtCcDJEL7UEVjGFWB5yZmwnTIhOiRNKJr4zpEX2FFR7Vv3dbEZ7GAqbNBoLeG+CWCyAllUEDar8kRgnXzA8ZignfFa7LKc0Xx1ObFvo4jxMIf1SfW5SaE1uHEQ4jQdd/A8YXoc/Sx6e9r0ccmL6E3TfAD7lb+MM5qFLpd4WfJ3BzVBnaM7up/Q2eEWT1LLMopU/OuF/sCffAyIqc7mBpubfNT4up7uqt2g7GBvgF72Gu/twuhrcxLz6X5EvInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBTiET3Et7AEazEA7AvaNZq9/jKOprtqxBU4xnIfKNU=;
 b=kuoU3XcPJcVfeDG+zc3pXjoQW0KGMxOPq5MKpX6uvii3mTf8oZQMHSF8H/8Gxsd0AQvwvzQ0eENXR88Xvy4V4BGNUuCqU3NgNUrikwcFEKd5vAZ6msGnK3EtkoTM3mLOUz0tBiSmTB5FRWkmTpANgjJBrjyA+8uaC1lt2of0PbvwHwmVtp1l2vFzR2+rv9b8au1y9VbQMGHVKF525O5bxQSIYy/7+58GeEyjf4pO10B8JfbQkLSF1hU+ceHeq39OuSA08BtLZjaLKlol+MWFNGpaNaxX4tpDRtxnONVXl9zlGFHtxRAgaQd/FwTet8TqXUJn1+IBQV3YT/+VahCerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn (10.2.3.102) by
 ZQ4PR01MB1298.CHNPR01.prod.partner.outlook.cn (10.2.3.110) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Thu, 22 Oct 2026 10:26:22 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.016; Thu, 22 Oct 2026 10:26:22 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode
Date: Thu, 22 Oct 2026 03:26:11 -0700
Message-Id: <20261022102614.75696-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::23) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1298:EE_
X-MS-Office365-Filtering-Correlation-Id: c372d93e-3898-4ab3-800e-08df3026eb79
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|52116014|1800799024|22082099003|18002099003|3023799007|38350700014|261009223027099003|10067099003|261021123027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Cry/F72O2PTjiN5gJ0GK/Jfj4zm3j1ZfMgPozMN0tGb42cL8Ew8hT74rVebLiu8E6gHa4VGCSk0GDHaATmNSnY1BJu5I8wp209Ru4TEZ09twZ/yN2vE6gqjHpUlFLyvRjw+Vi8AG3bMNAiqrjhiOzCx2zyXGvj9ShTegd23OrcVWboAjWcxnXRHQFETXzwXNwD4HNMpW1FQghVk3oSLstinvJYNemIVO5Mc3seaTmQajiRv03x8FdvlbGU+3pgCFFSCjNMl6tb8p4nffHZlcSY5mtBWAReG8HwEu58R5qb8Ikclv7zC8oeQ0jzg9QDuPg5WNtLdpEDTg68L2NVRIkBFwPvfbdOqJVINUn2ULjFmynMq+fu7dTm/HoOOGNE8uH0NO1xftXdVO9CF4CoD5TwLaRe25TMn1AfFOyBM2MrHWXlwSu/yYlhFEDo1B+dRxZ/Wm6XyUFlCpPxTFJXEcyAb3KVIc53av+C39mUG1N7Ca4w8bEYrU6pWdZ6i1GHyOjzBF7CYkHczJ+b2T4PVFp8NrwcY5pvXYlDGyktWiox1LOWqiHnMETv2Lovn4aX+D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(52116014)(1800799024)(22082099003)(18002099003)(3023799007)(38350700014)(261009223027099003)(10067099003)(261021123027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/MEIF+eVBRCvzv6a53mlBjb4DBWiKJVmtx56kFvn1oNirxOuGFgPfiRjTjg?=
 =?us-ascii?Q?hRFgEqu3tpn2k92VG7i3MvzOwxXVlNLJ6n2wPsjSwDtvnJrPLXG1D49B6GJy?=
 =?us-ascii?Q?gDESRFEDyItwrVlTmIlZKp68cJyOjlU1TIJhJ7kaXfZI8V38maPbpByQGoij?=
 =?us-ascii?Q?StAnGSC9ehGRDltrXM7BbNacBLzFnvj1v7UidlxF/1UCay0t0JavJAGjl46G?=
 =?us-ascii?Q?rLlBT3O64BItaR9BbpPk7Y9LmyeNIbAIQOxRYxw7YYo8IiflniuZ/lFim4rR?=
 =?us-ascii?Q?lxet7ER128q19FaaX+3ySj1AKzPmZKwvObOyJcIXnXPdCMMX4mPkjCa/4mlu?=
 =?us-ascii?Q?n70slMuqvCFtKr/S0BjkuYwT/qKLpUfgZgJGHZa6JjydRwRLddKU0vifWdP0?=
 =?us-ascii?Q?bfCPWZcO05eTu4cnfTUsmWOTtvah6pAonQv2Dc1CuKb2BGbA6p2VU7ggBR7Z?=
 =?us-ascii?Q?+peG38MjWLfo4DOHmINMqfX+l+KVYnbOWYxkYxN/6YZdz8HqfxG5/CyXdx08?=
 =?us-ascii?Q?pAOgM1AuqtKIfRCWUEZF+2gxqw8HCc2GLdwXqqUNeLxhyLWEUT/VdmuFszQY?=
 =?us-ascii?Q?DVVcPns/S6wLHAEc2h0IAFcEuA+3ZdZbm9+J+YMECzeCWfziFUsSSy5qR/VR?=
 =?us-ascii?Q?nr+76kbwMNEUF45n65fvSIGdYRTtxyEZpU47qo9a74CAhmb7NYAEu1qC6HPT?=
 =?us-ascii?Q?5+9OCVuDdJ9ttB+vaq/mYinNxStT6TgCKfdyhFKTf09ttiyK06j4B4eEVLDs?=
 =?us-ascii?Q?ipMGBrPKgUo4ggvAf3U4gXCAcwIMj7H+/tkGEXaVw/ZZLcJNrIc4iZQspTpP?=
 =?us-ascii?Q?b/e7ahwywnLiLJHDEeWJmr+YpOWIO5BFL8KTzvd98FzwX7lU4OzGnoJQYURO?=
 =?us-ascii?Q?c3XFzupLf0nFQtxC9bs+EOgNsGth6DRmK+ZzRuwOXhWh07Z2NfC68Rvdmybm?=
 =?us-ascii?Q?Rr5Y2K2eMxO4WgTjK22LEFCgH//W8T7H94DYYiln1PaIo/z41xZVwv2Uifj3?=
 =?us-ascii?Q?j0Mqb6IIT5zXD2xv+MzwNt3dI4iGVlNuKowHjYrnige7lMcswO1FQZP0aB7L?=
 =?us-ascii?Q?kCo7OgG4cgq2OyO/LukWo7HULE9CfEsdne7G5hO+n0yZjkSt94+BWVotE+CL?=
 =?us-ascii?Q?A+/mI6pbreofJ7AxhEMAPHnMXXUo22/jpsYoBxFlRez2asaXFMcSy8gc7gkj?=
 =?us-ascii?Q?MksGYGMwtq0OmRpGuD+U78/G/iP2Hf84p4jiC3XoNGtjMM/PwxusgQpEISu0?=
 =?us-ascii?Q?OR07ym/vdGB+ZgASTaRqn0/naay3X2BYBF335VFuC8QoxYnx7iQmgbTsnCt0?=
 =?us-ascii?Q?KrgWJchIq/X9M5TXt9hq8BBxhPcToB9jtxFCvp23cT9pUCNp/zq65K9iZ2Uy?=
 =?us-ascii?Q?B07FU8mbWA78UAECwqamwH7SYTK/KB45mD1iWn4/uEOOL1jIbd1e2Y+z3xwI?=
 =?us-ascii?Q?Uq0S+VrOxCRy4hl8Smkf+L1fquq5Ayl3kvHA9qF8mGjYlJslB7G/w4DOo4H8?=
 =?us-ascii?Q?tgUNqq1NFb0T6BkMDGfbsuvZugk8WRNBBa2vyA5i7B+ZbylN7ETP6eU9Htlj?=
 =?us-ascii?Q?8LHZ12xiVkhLFetmkjtRi5Z8Zw1ic6gThRCVujKIxvwXhL4OnT5/CBgcvdR4?=
 =?us-ascii?Q?xZMG6lAvJWZ4Gv7gqaH2Wft2/NMEBwxY1KYgrY2eLQSSwdyFM2N5facTa/01?=
 =?us-ascii?Q?2xXL1kyyC+YqaiQFPxkPNVVH0Z6SBwB0iqbxDDDA1vkN2wUGEl8nuYfBx1Qx?=
 =?us-ascii?Q?GTT0X9mZCYm1WbrSMznG5LawMTiqFa1lQHnbLjsV1iPny6bNbllo?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c372d93e-3898-4ab3-800e-08df3026eb79
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:26:22.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjpEB9LHnVp4jewB2CiauDeMM0z/DqLULwUqQhMV0RBKD2ylNHzCvJtDCXkWpfB3gxEEO9vktxmBxy7paqI2+BuuEOIuzG4OF+UFbwVQ1K971dEaZd2oZVIPSDIkGzhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1298

Add support for DDR (Dual Data-Rate) transfers in the enhanced SPI
mode of the DW SPI controller.

The enhanced SPI control register (SPI_CTRLR0) has dedicated fields to
enable DDR mode for the instruction phase (INST_DDR_EN) and for the
address/dummy/data phases (SPI_DDR_EN). Populate these from the
corresponding dtr flags of the spi_mem_op.

For DDR transfers, the dummy phase consumes two bits per clock per
line, so the computed wait cycles must be halved. Factor the wait cycle
calculation into a helper, dw_spi_enh_wait_cycles(), so that both the
supports check and the exec path use the same value.

When SPI DDR is enabled, program the DDR_DRIVE_EDGE register. The
recommended TDE value is clk_div / 4, clamped to clk_div / 2 - 1 and to
the field width.

Finally, advertise DTR support to the SPI memory layer through a
dedicated dw_spi_enh_mem_caps, selected when the controller has
DW_SPI_CAP_EMODE, so that spi-mem may issue DDR operations.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 52 +++++++++++++++++++++++++++++++++------
 drivers/spi/spi-dw.h      |  6 +++++
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 47434fa78e4b..6ff142c8a6bd 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -46,6 +46,8 @@ struct dw_spi_enh_cfg {
 	u8 inst_l;
 	u8 addr_l;
 	u8 trans_t;
+	bool inst_ddr;
+	bool spi_ddr;
 };

 #ifdef CONFIG_DEBUG_FS
@@ -418,6 +420,7 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	u32 cr0 = chip->cr0;
 	u32 speed_hz;
 	u16 clk_div;
+	u32 tde = 0;

 	/* CTRLR0[ 4/3: 0] or CTRLR0[ 20: 16] Data Frame Size */
 	cr0 |= (cfg->dfs - 1) << dws->dfs_offset;
@@ -468,11 +471,26 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,

 	if (enh_cfg) {
 		cr0 = DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN;
+		if (enh_cfg->inst_ddr)
+			cr0 |= DW_SPI_ENH_CTRLR0_INST_DDR_EN;
+		if (enh_cfg->spi_ddr)
+			cr0 |= DW_SPI_ENH_CTRLR0_SPI_DDR_EN;
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK, enh_cfg->wait_c);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_INST_L_MASK, enh_cfg->inst_l);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_ADDR_L_MASK, enh_cfg->addr_l);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK, enh_cfg->trans_t);
 		dw_writel(dws, DW_SPI_SPI_CTRLR0, cr0);
+
+		/*
+		 * The recommended value of TDE is clk_div / 4, and it must not exceed
+		 * SCKDV / 2 - 1
+		 */
+		if (enh_cfg->spi_ddr)
+			tde = min3(clk_div / 4U, clk_div / 2U - 1,
+				   FIELD_MAX(DW_SPI_DDR_DRIVE_EDGE_TDE_MASK));
+
+		dw_writel(dws, DW_SPI_DDR_DRIVE_EDGE,
+			  FIELD_PREP(DW_SPI_DDR_DRIVE_EDGE_TDE_MASK, tde));
 	}
 }

@@ -656,6 +674,21 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	return 0;
 }

+static u32 dw_spi_enh_wait_cycles(const struct spi_mem_op *op)
+{
+	u32 wait_c;
+
+	if (!op->dummy.nbytes || !op->dummy.buswidth)
+		return 0;
+
+	wait_c = op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth;
+	/* DTR transfers two bits per clock on each line. */
+	if (op->dummy.dtr)
+		wait_c >>= 1;
+
+	return wait_c;
+}
+
 static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 				       const struct spi_mem_op *op)
 {
@@ -678,10 +711,7 @@ static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 	if (op->dummy.nbytes != 0 && op->data.dir == SPI_MEM_DATA_OUT)
 		return false;

-	/* WAIT_CYCLES is a 5-bit field in SPI_CTRLR0 */
-	if (op->dummy.nbytes != 0 &&
-	    op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
-	    FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
+	if (dw_spi_enh_wait_cycles(op) > FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
 		return false;

 	if ((dws->quirk_flags & DW_SPI_QUIRK_JHB100) && op->addr.nbytes &&
@@ -1074,8 +1104,10 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	else
 		enh_cfg.inst_l = DW_SPI_ENH_CTRLR0_INST_L_INST_L0;

-	if (op->dummy.buswidth)
-		enh_cfg.wait_c = op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth;
+	enh_cfg.wait_c = dw_spi_enh_wait_cycles(op);
+
+	enh_cfg.inst_ddr = op->cmd.dtr;
+	enh_cfg.spi_ddr = op->addr.dtr || op->dummy.dtr || op->data.dtr;

 	dw_spi_enable_chip(dws, 0);

@@ -1383,6 +1415,11 @@ static const struct spi_controller_mem_caps dw_spi_mem_caps = {
 	.per_op_freq = true,
 };

+static const struct spi_controller_mem_caps dw_spi_enh_mem_caps = {
+	.per_op_freq = true,
+	.dtr = true,
+};
+
 int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_controller *ctlr;
@@ -1439,7 +1476,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 			ctlr->set_cs = dw_spi_set_cs;
 		if (dws->mem_ops.exec_op) {
 			ctlr->mem_ops = &dws->mem_ops;
-			ctlr->mem_caps = &dw_spi_mem_caps;
+			ctlr->mem_caps = (dws->caps & DW_SPI_CAP_EMODE) ?
+					 &dw_spi_enh_mem_caps : &dw_spi_mem_caps;
 		}
 		ctlr->max_speed_hz = dws->max_freq;
 		ctlr->flags = SPI_CONTROLLER_GPIO_SS;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c16225c5c887..67b4e0098ac3 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -66,6 +66,7 @@
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_SPI_CTRLR0		0xf4
 #define DW_SPI_CS_OVERRIDE		0xf4
+#define DW_SPI_DDR_DRIVE_EDGE		0xf8

 /* Register offsets (StarFive JHB100 DWC SSI IP-cores) */
 #define DW_SPI_JHB100_INST		0x1000
@@ -139,6 +140,8 @@

 /* Bit fields in SPI_CTRLR0 */
 #define DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN	BIT(30)
+#define DW_SPI_ENH_CTRLR0_INST_DDR_EN		BIT(17)
+#define DW_SPI_ENH_CTRLR0_SPI_DDR_EN		BIT(16)
 #define DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
 #define DW_SPI_ENH_CTRLR0_INST_L_MASK		GENMASK(9, 8)
 #define DW_SPI_ENH_CTRLR0_INST_L_INST_L0	0x0
@@ -150,6 +153,9 @@
 #define DW_SPI_ENH_CTRLR0_TRANS_TYPE_TT2	0x2
 #define DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK	GENMASK(1, 0)

+/* Bit fields in DDR_DRIVE_EDGE */
+#define DW_SPI_DDR_DRIVE_EDGE_TDE_MASK		GENMASK(7, 0)
+
 /* Mem/DMA operations helpers */
 #define DW_SPI_WAIT_RETRIES			5
 #define DW_SPI_BUF_SIZE \
--
2.25.1
