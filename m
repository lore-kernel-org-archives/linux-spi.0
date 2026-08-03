Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300E41B37D;
	Mon,  3 Aug 2026 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760875; cv=fail; b=JGVrTtnbHiy8DlK1UK6iEcS+PxZX/UKMy5itJpme0xbggk3ag8DxS7Z7wbi3JDc0LbBlccsotW7JiFG/V75Ac4Pyh7hLHRtQmr4F3I0/TBeQDSZ0EbCx7CTNu9N5dOj7xlgzZ0WTHpmQsN2Rwgrko77F74ckDPYQIEoWApyp4Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760875; c=relaxed/simple;
	bh=l4dGY80sjTLVBNonlDAd3UaAPzTUIpoj9gYg3d2PriQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avQH2jVpw+JbiWscGdD/2saqPQVdvX5fZAuditJCUqWBP0pNmhWfj0CykZMg7pm4ylrJEbzAM23VCiStu+IRxI0fez/XZkVH/Kq4rINeuJX0hYuCzgu0QM36WDprI6DBDWO+8B9+phr62zUyx61vXnOXcqFbghz8MM5wBjvdk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP//bz87vXltIpp26jnDqa8X/A8yFgnhh6lZYhLqPLRK/qfDVcQWMXWwzDtj9NgRiK1fbSruzLLhAYj+L+STkXbAs0VfNiMFn54uka9NsU7czye/VoBjxwneSoAyo+Hu6PRVOs36UcQ4Lw7jcojZpTiwcohvJcv8pKhylpXY0D6ac1gMEjBVqBFQUKa5jgxO0xsokj1K5lJ3atkM6qapBIVTskaBsmQdCy+M3mNcnq4BziDVysuS/2HOqbNghcfBOsiGXIWyMUnOZUdS0I0/kZ3bHCW79HMg9Jcxl+VF1ndh1K8Xj4+bM84MJ3GsnqaJLJz9Z63yK4byPy1XQHkWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEgbw9XHtLWNZnVMvi7JOPiw6IUxW5VMPo2ns4U2mLU=;
 b=NimRp6yl2yCW6mueK+iM/cfaLX2qLIyIVw0hgKcUsqfeSQTUMS7QHkFJokxunCfu8ZJDhRvkWEBrOql6NufHNkCyRVw5MgNWmLhfF4dJtHELuKz17yVry1+Cf7E5asWwfM2N/+pydFTJvEFhhuBDjCwF0awtkuMcFK766wEevlGA8zSdyAkkBm/5IMyLzTzVit0XLlV92Gtqll23zbVQW5jkOORHFPMkOJWDHjpS8TKV44/4QMfz8IVVLpdOtNfplcLD+8xDktfls1plowfyIyJ5ulyT8AxDEuIHjJnp5LcQ1Rqkg8i2F5uyN0xnx51o5qhEYfv7cCMACcUg59CcNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:04 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:41:04 +0000
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
Subject: [PATCH v2 05/11] spi: dw: update NDF while using enhanced spi mode
Date: Mon,  3 Aug 2026 05:40:38 -0700
Message-Id: <20260803124044.156998-6-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 466c8aaa-0628-40cb-d2df-08def15c76a3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1GsvCa0rfUVahj5gi9DM5F1XED+IoI6Rc1aidqARNPv15AsCfgYPui/5AAEKZRKciMDF0/2Bupwr4eng+c7cLDWLqNJmDQxkm2xrDcAeQUEDrUOzIgwo5tELmfq3ZtVy0nvJ1jVOOJa4Ezwokv9o06VGz5wZbro0+KRFazmLVjoDyXEO86lX77kq+2qtA2X0UANJxx+s5JPaBkkTatPiXo1wf6SBsXCPA1TIRUvYpXtyPsYY7CSdekfVsWZKq4zDPaNt8bcGAsi3xEjg+KumSLnLut1crkYG0lddkl7oRr/rFg33KOErxnWz9GaNt8MVao6oEHx7gPI96uxQkW2X6qjWw95/iMSS4He3abmsuQZ5y3KPI8yV7v5B1GXIW4wOICHcwxEu9SCZn2st8SXXwaK/S85axSdVkOylXG3VTpWPthT8CKZe1iy5cmCfvByjKApowIOt7KL3q6/pnM+yht5RHz3/li/igaqt9is991J8Eq2PKTqKfMeLbjMgTghfE/eSTgbq9+xErgvjGSptaCM73ckqlGUTJllY8BzQzLC+5YB81NGi4z8MAwe38yAU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qo+xf+y2Kzm2aVQx+GiVRgOdG+1SUBckQzehnqhhOgVek8g3FMPW3uBYEq2n?=
 =?us-ascii?Q?BsqIODLmJ1dYCZDYO14aK1vybwB54l4xcH+BRdWKyFLF5X3lu63EF2VlTbr8?=
 =?us-ascii?Q?yS3JRos8mYhD/BcftjokrFjaAUM0azgnLtzsFEIhnkHzPS6qWw7MSMavAHge?=
 =?us-ascii?Q?qCw6sNzqfjsix32627QoIpqFamiz2p2zof9uWF9BoVfU//LLHE6KZ0LIpyY4?=
 =?us-ascii?Q?S6pDKA1nNdK6jWJso5YXt8cG6f74dVfp2FSiMWdgrU9OTlSJo38PHi37ZW81?=
 =?us-ascii?Q?B4HgzqL2CXf1yfSmBQqSGQpMu0vdRUZt+kH+m/tP4sDUW7hMOU6eGOZ+7zUr?=
 =?us-ascii?Q?klttpOHym4B02ULCI58ZagGG6V9U+pRew0fkJFGGe+Qcgc3wkI+Z6CmqlRZv?=
 =?us-ascii?Q?ILTp0jwBLQkSIrvhrfU9NG26/Q0IXL8wJmQPFa8vdlP5XIPkN9rYZphVKYqQ?=
 =?us-ascii?Q?U6oc43vYAbT+WlDl5jJ13nQ71mJ/+iOCvzPy4DYneVzTSIAabSAIV8yAZ5EM?=
 =?us-ascii?Q?lgK9Y2uVyujS2Xbm1PAXko5Q5ilaZqpryFZ4MpIQizeUXeYbC0f0RHKebcV2?=
 =?us-ascii?Q?uWv045eXrrTd92kgBybr3rfUgoPJUPhFkqi4QglC0FeHRKJEoMdjhYFhyoor?=
 =?us-ascii?Q?nFYs6VsAX5JOim2iejKe19k+ybenMqHFtWoZzJ5UHwkbsKksAyjxDoE6tocJ?=
 =?us-ascii?Q?TKQ2cOlWZc0GpbRKY/pTmJSxsSA/Tzoj6OQmItv2FlcrY0y03bW8ZpOoCIPM?=
 =?us-ascii?Q?27oo8h9tp1BNiupDd7uQOEr8iFDIEEBr1WqGdYSLiTZZTNR8/afquuws1PUO?=
 =?us-ascii?Q?Hu/W/BD5Klb5qgxX7HkpLbvnmGAh15BkncOt8wgqsDDdh5bEkvPH1PGa1A++?=
 =?us-ascii?Q?JFjD/vv93jALnymi/O+phVWcvtYWSJdzpkgGd0zGV1yP0tTCrdBG+bnU+2Kp?=
 =?us-ascii?Q?3+obWkU0ca1zWXZ1+RqIqlZrkt2oEg2N9Vbk3IY3vztaGJPYJxpdRH4nyhYr?=
 =?us-ascii?Q?a0v9hIdvWoRczXRldKx0FckjoBMcsqxwXtFpDGq7E2m1GKwrK6zyfUI78XMZ?=
 =?us-ascii?Q?svoP3RB4PAg0rLSmI/Tg/M07HMKd9Y3eaDvZgjythXEZTUdaQVc184vDu4xd?=
 =?us-ascii?Q?kQPBT5eJQj5j4dTiwbqFU+2mWISS0DRCNeZKfAlAxGaC4mNN6DedinByvry5?=
 =?us-ascii?Q?mA94ooqT7/51Ky5RklwVikwe4aus+N/FNHAUOTd+0++OV7PrMxXHpeyOVDSg?=
 =?us-ascii?Q?e+SuxobAV4wQyXymbowjoHerwJywW+NLkDlPJVZoRTPkFlQBmpdoripDd62g?=
 =?us-ascii?Q?1IR/+c9XwsrJ+PhU0K82HPXxHRAWxX13ZnXxGCixA6K7YEnk+SWVVoq7Eq8F?=
 =?us-ascii?Q?53WQhIKUu3yqEnVpdX8cFo3hR7UFthDMuIa33i8EnqrtRFemI9YH82C/Txz4?=
 =?us-ascii?Q?yRxFzdFQhr/A2Tfps+f9oWQZUU9w9DLSI2m7XY1colrtwsh3Fs2B+yJ90IQJ?=
 =?us-ascii?Q?Nz+tRiI6e2Dwxzjhztz821yBj6aF/UUJXA0FY6O0+eNNnnKhKVPVhZADSODv?=
 =?us-ascii?Q?iRwFYvxIgrJkxpdAS3d2+3XzzzRN04DA9oFNNmGJqvAsRDGLgaryXGJqb6XK?=
 =?us-ascii?Q?ZXnzUN1jDNqjSbM3tUKARa9Qf6lDJOp6u8BSMs5cVs2Wgyi1zEzn7jsdsfxZ?=
 =?us-ascii?Q?cgssMq6CKhK10p4KzRXkUJNFwjABpmbC+Cp65Pd5IcfA+z8C2DjESFnhyac/?=
 =?us-ascii?Q?6YdYvVNwhG9req/E0o4u9Zgu4twk+ZGeDiGvrLEAAUDro9WTi0u8?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466c8aaa-0628-40cb-d2df-08def15c76a3
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:56.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2pdX08/2BGx4f4cHTsDsbwT0uoWDSdygqWt+4MzSoDA5lHEh5uuH/qFNaYcgAyQxBQBt6ET2lHm+L3Z5/65HQIKcnicCOMDMdTUm5OWblS3/GIRkEJj7Q+cz0vA8QWG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

If the transfer of Transmit only mode is using enhanced SPI then
NDF needs to be updated with the number of data frames.
If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
clock and wait for rest of the data until the programmed amount of
frames are transferred successfully.
In receive mode, the number of data frames received is equal to this
register value plus 1.
In transmit mode, the number of data frames is equal this register
value.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c7cd24337188..5f215e76a7ad 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -348,6 +348,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
 	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
+	else if (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
+		 dws->caps & DW_SPI_CAP_EMODE)
+		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
 	clk_div = (DIV_ROUND_UP(dws->max_freq, cfg->freq) + 1) & 0xfffe;
-- 
2.25.1

