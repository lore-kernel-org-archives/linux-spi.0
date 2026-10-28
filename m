Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189499;
	b=brOvf7lMM01mx0KiJ0K0TNa/4gM3aV4MAZp6tUUDBB5F9JoXw0sBpHNyfXk2d3QykF0s
	 bHXQlEGulz7rwyf+U3IA8LoFS8VkuSUtHSBp4ErLQP6LrnyhiRoNyCkOqYOhY0wVY2GRk
	 SI8//8yg6XUxEschIaRry49Eg6N7VzRTfMrjc/IM25jX04psou5eNX0TqV5tKJgRzlXOV
	 JSDLKMh8OXfSnk0DiQWRjMGCXr6vhjn0JSTKSjQyrT3maJdcCO3t9In4JZXFFqJqRg62C
	 6eKVfpEMTeeJdxMHPRpF1hSBkxr0KQbP2eOO85uArLPQp4+L99q26jYSD7jHsILW+pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189499;
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
	bh=xgAi6b/sSbd6IWiZX06ZNRocJa8EPu44Mxl3y27lex0=;
	b=eLbB/5a5HdzTJeFEOLhkLAXNVu5xqSCyBhUzARTgUrtjam6VhrjMKXsF3ZQvIrLVNHWR
	 G9AJpzXx0JCEJxg81wvnwncWg3btBQS4WPD+z8RzKdyFEBfidgfzDRO1OpXUFf6d2QLXz
	 tJoMLVM01Jcftw17YdJa3xWEU+AUEb1/ixQ0JaNUTw8Tu3EGd0hDq0W1+uY4hrXNYMndF
	 nqIjOVb+lbI1jkSU0Eftmjp93ubJHCC+CZEmpxGh8mIKViH7+EQv23X67h6AFPh+n+j6d
	 O7YQLZkN/6vPEEbs8FErZVoBIeibJ32YXUHagYLQhV7c6DusMFJdyGyaDHHphtr4XbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD3606A31D;
	Wed, 28 Oct 2026 12:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73BD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMwni1cJCLmXQfP6ohfRYrDWLJdrWcPltc21ucyOsJx/RrZrwdmoHzunGNTFDy1roYtjFlvvxwt0RrMzlDNDdmBp8YMjbXVfEGaEllPUYQC0ugmaNhmayGhQiv53LLbWtIililL62N1uLuWsvEX7GWwo155XHNZwpSO+sHB+rw6E1y9RP1L2UhjhknuGKk1Lfya1osid2wZhy1dwKVWdFv4UTqUmCwhUQxurkoFOHKubid0c/R+ZeQAvl0WXwHoldz69qYtF9yF/HLJyD0llz4lBKdbHR6wRdC2u9o+CbGmEp4JE59UmjFQ8JaoD+Efm9rCjkNLS/0pb+0b4pKnS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgAi6b/sSbd6IWiZX06ZNRocJa8EPu44Mxl3y27lex0=;
 b=VtEELj8nHxtLHPWZvgvYyWP7Ac5CldKYOWoo9bd+WXPTkr5VrzzcTiNhIT+NNvXoIigawPP5HjwzKL8HfNZS8d7df8EZXoS3uX8J3AY+Qr6+aCmRqbG0vtk0TzFWvk/+MGfT4h/3Kz+tsKsY0bTWVBLyLXdVM+GU9tCKCx9ZFTXOJvauJrZoebxn62yB1Q8jvlCEDOEl0EpwFTsu2HGUYb/6hN7xa4YD80wQxx1m3eSiyW/BHOGnC2fld65DY7ZKdVtyByzkH0/rPyd03QJQYP9GWUGFFPR6veiRp9Mtv3cmNJM8HVSEb8+aBy8avuqBJDiqwvSgY1AheGK+7T5MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:11:24 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0546.021; Wed, 28 Oct 2026 12:11:24 +0000
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
Subject: [PATCH v2 2/5] spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode
Date: Wed, 28 Oct 2026 05:10:57 -0700
Message-Id: <20261028121100.79667-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
References: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::14) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
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
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: 29866598-5af4-4d3c-f8a9-08df34ec95af
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|7416014|366016|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|56012099006|261026140227099003|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	/hbPTetGJvtuThsiNlPw3nQfiyC+nV4G/Rfd+OXE1RPHiWh/LY9ImKdfZOtVhzS0v5yPkbyZdQDJkpQySjRWztbgzqH/JQGk2S7HnEeKoQXpl61aDEpgj1JAjkm5jSWniGJrGYaGhGmdJkPpdeLZdAqF+lRR5Rs7WCybVxUMPOtJ0Ui2Tmax8SaIW0zf5fChtVEPIqhNBysfGXTcIrXWog19fCNpfnK8x45uhD41NOH9ihWirmwzuw1h0/JmqGkjvtVVhx+wdkpb9OpU1p5blYv9fVmSWA1XfIZg131RH9YOR6hBmS43cqP3gKYc57O1LnyblC8VhgRY0kZNkHpzSTdxJ0CxKW3WFw4v3hU+DpYBz5s2Ksdy71Un3qcyo/amkM4DIuyYSZH2gBLrGnrpMNyXeFmuvS0M/Mmj4MRy/3X4hWf6+kOrxfDzoQl7vUV24H6n4+WtNyLlCqlw7U3f4SvIWdG3E8unGDX4t0XB+39N/6J4Ed9RBHx5+B+v9oqO+wQboQbtESlt9ukiPERNUk1PBPKIsBnPPZjr+hY0JWJYHx1Dni0LJJVOO6AWrH7+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(7416014)(366016)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(261026140227099003)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZEPVTXSN/NUpUqR4C8ctesKC9kFKTpxQQizR0SAdxX0w2VioODa5tAehhP0?=
 =?us-ascii?Q?Ke7+bjVPM08GjMApJosyC/ckWegr0eZAUZUJmcsYHPIeC/B+uOU2a8NSw4ga?=
 =?us-ascii?Q?KYEOqK6BTrIPz7CS7eoZcSEgmLgwnfs5GPmcSrSDphV8LB4Nv8N0RuVI0XPj?=
 =?us-ascii?Q?b7/b0NzfFrC966f3EdJJWnUcSY1NhGFgRV8vnpN0kUuAcerpusNLfe5eOb4m?=
 =?us-ascii?Q?MsewCN9K9AbHtrHbJrHLS9uRebQXzGc6DDix/091C0SWRhJDDsr4ZUtDfyaU?=
 =?us-ascii?Q?QODPRwujiX29hGTOdgKb0CSf+SHQLI4Ry/es3aqswGp7p+wwTorJsV97PcPi?=
 =?us-ascii?Q?VOs4IqIXco2s49j+1QFhr1LqjG/Qsb6sLmgFoFilKqTIX3xInPJ2vvX+YefA?=
 =?us-ascii?Q?gK9FtIxvPd4nEwnTCbiJdhLl2RJynhmJZBvSpgkbzQM5CZ2/vBkLSYbDCViu?=
 =?us-ascii?Q?bWUH/AXhR8h21fo/VYhC6m+2kQuXDk8ilMbwdO2W0xTeuquc47UvcJZsCUbU?=
 =?us-ascii?Q?/t0qHgM6/TzIc4BSJkPbzmKmArULFI13I8xDKLq9rAWe/YWyFx/CK6cbQSdN?=
 =?us-ascii?Q?ivdQwpaOl/3KP9aRPSFitzx34fhwVFOO2QJ/8SjTMo1SgVLWRx0msv3m7eps?=
 =?us-ascii?Q?ZacC7vYF7jGcbhd2KR24TO4USMtpKTgjBbq/DJe/D7TFaoaV8RhZv6149H2x?=
 =?us-ascii?Q?4yQpsOFHm6la9dvq9B+IUxhZjTAZEq6hhi2vkn/+pKlVvHMre6zM/aq6F2hG?=
 =?us-ascii?Q?qbOXZv+WzAaXIt+8Lq0udPjVOy9m2XTi1x1drD5r6pQSSe9cmT6UypTMGBbJ?=
 =?us-ascii?Q?HCzSa+4LpoWTE4mSSWTQk70Y0egl2JcNdicOFEXaExzChPih6J2zrSSk/D31?=
 =?us-ascii?Q?t0BNS8lkU4SBzgup1Uyc/EJQt6w4AebSOzKgdbeQvQwqQxse9Y0xEKrrgvtO?=
 =?us-ascii?Q?IWdUnhilxNn6+cD5Bm0sORaMdLMZb8VSTGSqhDzB3p0XlK1mE/Wgueeazdu8?=
 =?us-ascii?Q?Bb3jCb+6rEg8z4ZLu8jlK9QCJmjyDGlVNwVZ55LELzEdkn/0AOrmOLSzyvhh?=
 =?us-ascii?Q?VN1PPY80H8SdhdJyAC+wqmSGoqhwNZcc+TUEiN0kbC5N/W72FK1ZfES0+AZq?=
 =?us-ascii?Q?KQXfUP72LoRb3nKNOPDkxo3jzifqVjl+D7+7xVwe34ZJWmuKjO8CqrEagurP?=
 =?us-ascii?Q?V3ijbqHREYvoeLFLipK0J7a4DyQOwfYoOf1DKOLwOdoEfK3ULV0YZmUXOPoN?=
 =?us-ascii?Q?/tIyfGGZLTzSowdF5Jiv4omeDVp0QCt/mCtQJP+i68UrTyJJi0NZwwtmO1vB?=
 =?us-ascii?Q?HzvcFpExRQuL3wh5xARvuIITQiJZy4H0pCgYt44IKaOP9SDCLeXlUjTzQQa+?=
 =?us-ascii?Q?7G7VxmTeVmKP+tDbMboi+z+q66Z+t/e25vMdW5Ngj/fJU2v774BfuNZQ0S2A?=
 =?us-ascii?Q?GPEZe7IcNquAfg4kULRPPsObwU/AXM5g+Uj53v1useQVXn1iH94YPSnhtTdb?=
 =?us-ascii?Q?bEWbeXGP0EZqxavqIrqRb2Q+vdEMdclzE3+HBDpKxBNSki7Zb6TOSSijHtiG?=
 =?us-ascii?Q?bIf24pv6zThwCxhRSTmmAXHfO78WTDY2A1U1NTLO6hJ87IWbtGme/gsw37lg?=
 =?us-ascii?Q?zoJoIb0VCoRzwJQTGsQaPADBMlUi+CZ9QN2c2/XdEpVNzO37rbaCMqSSszGW?=
 =?us-ascii?Q?gvWVGuIjIdgjtutG2bOr+lY4Ao9hUcGUmzcRwLGIOm63jOq3Asrmhirwj3V1?=
 =?us-ascii?Q?WII791JUSzVl4X5NWq3T47WocpxLv/qaguN6FOxJdBP/eIXNplLZ?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29866598-5af4-4d3c-f8a9-08df34ec95af
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:11:23.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rO6LVG004Sah2C/Haud4/hD6QIbPeZWJymdX6vFHql+8f4gov2tga/FPY5pTrNY0SAGWX5rG2VCX4pMPQVXoR0K8wKM0qWw9h9RmXyCpHQyoiDuyvYQmDSfbffrtKVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

Add support for 1S-xD-xD DDR transfers in the enhanced SPI mode of the
DW SPI controller, on controllers that have DW_SPI_CAP_DDR.

SPI_CTRLR0.SPI_DDR_EN switches the address, dummy and data phases to
DDR all together, and it only applies to the Dual/Quad/Octal frame
formats. So in supports_op() only accept DTR operations where the
command is sent in STR on one line, the data phase uses two lines or
more, and the address and dummy phases are DTR on the data lines.
DDR instruction phase (8D-8D-8D) is not supported for now.

For DDR transfers the dummy phase takes two bits per clock on each
line, so the wait cycles must be halved. Factor the wait cycle
calculation into dw_spi_enh_wait_cycles(), so that supports_op() and
exec_op() use the same value, and refuse dummy phases that are not a
whole number of clock cycles.

When DDR is enabled, program the DDR_DRIVE_EDGE register. The
recommended TDE value is SCKDV / 4, clamped to SCKDV / 2 - 1 and to
the field width. The register is only written when the controller
supports DDR.

Finally, advertise DTR to the spi-mem layer through a dedicated
dw_spi_ddr_mem_caps when the controller has DW_SPI_CAP_DDR.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 84 +++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-dw.h      |  4 ++
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index e8f70808352a..6b06b84c661b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -46,6 +46,8 @@ struct dw_spi_enh_cfg {
 	u8 inst_l;
 	u8 addr_l;
 	u8 trans_t;
+	/* Address, dummy and data phases in DDR (SPI_CTRLR0.SPI_DDR_EN) */
+	bool addr_data_ddr;
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
+		if (enh_cfg->addr_data_ddr)
+			cr0 |= DW_SPI_ENH_CTRLR0_SPI_DDR_EN;
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK, enh_cfg->wait_c);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_INST_L_MASK, enh_cfg->inst_l);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_ADDR_L_MASK, enh_cfg->addr_l);
 		cr0 |= FIELD_PREP(DW_SPI_ENH_CTRLR0_TRANS_TYPE_MASK, enh_cfg->trans_t);
 		dw_writel(dws, DW_SPI_SPI_CTRLR0, cr0);
+
+		/*
+		 * The recommended TDE is SCKDV / 4, and it must not exceed
+		 * SCKDV / 2 - 1. DDR_DRIVE_EDGE only exists if DDR is supported.
+		 */
+		if (dws->caps & DW_SPI_CAP_DDR) {
+			if (enh_cfg->addr_data_ddr)
+				tde = min3(clk_div / 4U, clk_div / 2U - 1,
+					   FIELD_MAX(DW_SPI_DDR_DRIVE_EDGE_TDE_MASK));
+
+			dw_writel(dws, DW_SPI_DDR_DRIVE_EDGE,
+				  FIELD_PREP(DW_SPI_DDR_DRIVE_EDGE_TDE_MASK, tde));
+		}
 	}
 }
 
@@ -656,6 +674,49 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
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
+/*
+ * SPI_DDR_EN switches the address, dummy and data phases to DDR all
+ * together, and only in the Dual/Quad/Octal frame formats with the
+ * address sent on the data lines. DDR instruction phase is not
+ * supported, so only accept 1S-xD-xD operations.
+ */
+static bool dw_spi_supports_enh_ddr_op(const struct spi_mem_op *op)
+{
+	if (op->cmd.dtr || op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+		return false;
+
+	if (op->data.dir == SPI_MEM_NO_DATA || !op->data.dtr ||
+	    op->data.buswidth < 2)
+		return false;
+
+	if (op->addr.nbytes &&
+	    (!op->addr.dtr || op->addr.buswidth != op->data.buswidth))
+		return false;
+
+	/* WAIT_CYCLES counts full clock cycles. */
+	if (op->dummy.nbytes &&
+	    (!op->dummy.dtr || !op->dummy.buswidth ||
+	     (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth) % 2))
+		return false;
+
+	return true;
+}
+
 static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 				       const struct spi_mem_op *op)
 {
@@ -675,13 +736,14 @@ static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 	if (op->dummy.nbytes && !op->dummy.buswidth)
 		return false;
 
+	if ((op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr) &&
+	    !dw_spi_supports_enh_ddr_op(op))
+		return false;
+
 	if (op->dummy.nbytes != 0 && op->data.dir == SPI_MEM_DATA_OUT)
 		return false;
 
-	/* WAIT_CYCLES is a 5-bit field in SPI_CTRLR0 */
-	if (op->dummy.nbytes != 0 &&
-	    op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth >
-	    FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
+	if (dw_spi_enh_wait_cycles(op) > FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
 		return false;
 
 	if ((dws->quirk_flags & DW_SPI_QUIRK_JHB100) && op->addr.nbytes &&
@@ -1074,8 +1136,10 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 	else
 		enh_cfg.inst_l = DW_SPI_ENH_CTRLR0_INST_L_INST_L0;
 
-	if (op->dummy.buswidth)
-		enh_cfg.wait_c = op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth;
+	enh_cfg.wait_c = dw_spi_enh_wait_cycles(op);
+
+	/* All phases but the instruction share the DDR setting, see supports_op */
+	enh_cfg.addr_data_ddr = op->data.dtr;
 
 	dw_spi_enable_chip(dws, 0);
 
@@ -1389,6 +1453,11 @@ static const struct spi_controller_mem_caps dw_spi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static const struct spi_controller_mem_caps dw_spi_ddr_mem_caps = {
+	.per_op_freq = true,
+	.dtr = true,
+};
+
 int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_controller *ctlr;
@@ -1445,7 +1514,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 			ctlr->set_cs = dw_spi_set_cs;
 		if (dws->mem_ops.exec_op) {
 			ctlr->mem_ops = &dws->mem_ops;
-			ctlr->mem_caps = &dw_spi_mem_caps;
+			ctlr->mem_caps = (dws->caps & DW_SPI_CAP_DDR) ?
+					 &dw_spi_ddr_mem_caps : &dw_spi_mem_caps;
 		}
 		ctlr->max_speed_hz = dws->max_freq;
 		ctlr->flags = SPI_CONTROLLER_GPIO_SS;
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index f922e000e7a0..4c548fde89dd 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -67,6 +67,7 @@
 #define DW_SPI_RX_SAMPLE_DLY		0xf0
 #define DW_SPI_SPI_CTRLR0		0xf4
 #define DW_SPI_CS_OVERRIDE		0xf4
+#define DW_SPI_DDR_DRIVE_EDGE		0xf8
 
 /* Register offsets (StarFive JHB100 DWC SSI IP-cores) */
 #define DW_SPI_JHB100_INST		0x1000
@@ -152,6 +153,9 @@
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

