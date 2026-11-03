Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793743114;
	b=ZcAgr0Hr0wIo+B/CpjFPmCBayO1/x48I7npNhJpKfRG7o2uRmsJHxUDMceixdrX6aS5k
	 XiLvdvrY/oOrY/LydsU3dpTt0a51+A77vP9ZUthRSc7ivct3/QdcSpbQcCIgVdbVHGqsC
	 8an5/v2ei7chaRxnC9d90gN1bVQNo8zzkxDsPbWQ0LGC9Whs7EaP9fgjiHoXPC+A8cYE2
	 zD0SQ9UmxDrpR+jBHkLu73Gc9+zwQljP3TZPlcwnI0FHMguH86Jf27B+5dwtM+FR0GEfG
	 3LlcoXIy6qayTYVn8mKMb09lWCu9jjZfyp4WrC8zxVlWA42Fbd1qRmZSSjpVNljxAOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743114;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tGxCiSyiAgNrfVgKP5hwgqVdUhaT6Lutc5q8Fi0A0KU=;
	b=GfYSg6+oR05ozSSgI5GuSgnS2+VUzsK517hAs5+fb2lJ4RdecD/nxOIHM+5SQIE0XmXK
	 cD/89YRRkK2ClurIo7YRjba9rKCFn0n0zk9R+5A6X095/wJy84xb14Y4by6ImvOuQQTzn
	 lNtr+nRlOFW/x1EVkGrzpr+jQG7oiTXIyrPp8g0DkJgQ8QFjrhBw8sDKQxyAu/SQTIr1O
	 7rm3VhvPEP+VCFM6/8g9Z0wK3NK/wpiEHoRIZZm7UoYDd4qZZNFLGYw1qrykRTRVnvows
	 71TUD6+Uuha816BwfQSdTT/gVC0iw2LkciEB2tjAn5lYPvOVgSrQZlIVYdxwHJR9k1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDEHebm3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.4
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7850A606A31B;
	Tue,  3 Nov 2026 21:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7850A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=yDEHebm3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeHHvfPII8ICfEsGnmPYXeUg5Dan2z8oYOJocG/hb4UTrg6ycAY3gwCLKL9lZJhe84yf/rWUOW1f78VmE2pPTDV6u7uQexWk+yGBj80ThBglUwLERtKHAtubBIJY3dUcushoOFxHpippJHEX6/RnjiTZmIOxYqnprZXtiGS9WCmymtIswP21ZvtkVQJVR5F8S7gTCs1ixCkZamZusM6Ip3xbZIsX598jk+q0Bk+b/PhItesl194ZyMO/YTlEKLkKGCnxsR9U9GCpiX2sRD8GB8w09tdJmyRY4x6Zck0K4jOi6g6SAkad7pffLXUJHMfT9aFUM0dF0zWXxBfgVY13gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGxCiSyiAgNrfVgKP5hwgqVdUhaT6Lutc5q8Fi0A0KU=;
 b=JxJp64F0FiDPlQFTTKkG53PTFqDBGuYEvzh5DN8ntAXvZL128Lwa1ky//sjA/b+2l97ZH+evQcDiRwrhOMyKT6693Emr4SDtxgxwWJiw146MvtIsGV66gFY9OxHk4ON3kqCO8Ix+1wz6KKWQxOnCqLr+FzJPvO6nv9e4V31qb71jBDlYYT2JzSjoYI26F6g83QVIYfdFGNiUvQLIE1jOYRr2snd0kVkxIZ/Sec+N7G5OAKkLTV+ymHn0hG7+Qm4gNOSkDOpq7CR3DCz9LxesXgyCl+CXbf4DIElqZf7rQUXH3/MZ8B4P+B41PwUrLVMnZ5araFhaMqLwukB59On7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGxCiSyiAgNrfVgKP5hwgqVdUhaT6Lutc5q8Fi0A0KU=;
 b=yDEHebm3WCX4cl98m6huPHexhPLDpomwSTFR2Up4OQ2pivLJ8tzDciI7xfuHv2JZ51aBEnGte6VV3P6yopNuttUODrFFjW1nXYJe0WGugttyMpGf0zhFpokPZR+YZCBD5ATUap/D+SdXacrpVso2ebwxi1AYJHCkCGzlYVxslu9psVGcXUNMh2Ki4ggFqikf+nX7DC6rg5k59HUsgaBgnYQAPLCQDuNgHG3nSjBAXk+HtPC7OmmBEmmMYMMzKF3+xShGH4TS36CfB5/lr48FIv1+jro2Ro6XyPFxE/t/4YOjkcnGjWElMdlCXMv5LyWKtyBS5HVOI09mWiRDtFIYfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:58:30 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:58:30 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:PXA2xx/PXA3xx SUPPORT)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] spi: replace chan->device->dev with dmaengine_get_provider_device()
Date: Tue,  3 Nov 2026 16:58:23 -0500
Message-ID: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::13) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c6e94f-9336-44af-be16-08df39f598ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261021123027099003|261026140227099003|261028144727099003|10067099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	nuEf2LHrgDECOeqKKnDQ9oiAHNuRgg2Y6OK0YrJWMSjcq+1Gz4LHqvMclfi37h47bChp+f1Arvee1aX8kqxk9+U3YIaQGuO+qgnhagKfnY+sHheZLeQN42dHWwxTmqHTAuPbkQPz/eTYA6kZpN/lWV9WBJIWFQNepoZO8h9W16GlYm4lykYglAhOosELccm1fF/jwHuwj8l1HPPw1EWOdw+0/0KDvjM28EdKr6ILhOnciwzu683TSChi+CakL+jxrBpSEfvhVesleJ+y5ZGqboiDRWVHFcomMgdLDmzPizHR5LB4HPNhjSEKqYxFyhjED7yeQkstLPmry4O44A4FI3E+TLn7x8H9jeFzJK3DvWcNHM4ki/W3d1Ju6RQU0Uu0YJ+44S6/+V/f8Qoej37PIqHLinskhPCPBjwHR7vzWsxmKKmQYdNqCDfRCu5AcXv/zmMowNBP9kjukaY8ZiUpB+eWS4kZbit1W5wKenqgKFsB2NgtoShb9J6ye98X0/CDzY0k/7/66LWWyk/Alxkimv1vzUCTtQiok0r67AP/Zc/PwNGelkA60l7c62eCKqP/dEuqwXXJoy3tVQQusmZXF1tT9AxEwnOYUsWN8hV3SyRsZxhCK+J+RFSx0xef7AjnOgEJMSF5CybMs7wkaglpWPMDHqkawHG5NspD8li0BI6/JHs2rVHzC0hCofo6gwU2sOASlf3smQck8rrKuNjpUOfyBOLJ/HE1YLlMUjo+pQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBgLpStYQ6F3JJe0piepT6YOYhcXV2owqp5xO+n+3cIp8Wrro/lVVwihn0J6?=
 =?us-ascii?Q?xzMDKadyE3dGKPdcUL1qyZWwuaP/qb+RQ9o16gywdyFmX0Ihiqq6eSgJ1tS8?=
 =?us-ascii?Q?kVFI69t/q193gT7Jdrl8mnLG48Bxk+sA9U5X2aDsSmawuXSx/Mrx4cyZZw3E?=
 =?us-ascii?Q?A+WUBJRSQpctlTMBL1xUihzYpaKKXJs2ltT+emeq/PdAaR+B8d9lW6Tu6002?=
 =?us-ascii?Q?W3gYhQYWv10zLRB0dv0qHPUmNlh0E0zUxWvtJMW6al3eoPEe13auDP6If9/L?=
 =?us-ascii?Q?+859jMoEOisexajfQax5FpUbmn4dvHPgQfcmiDYWUyVeog0+mWqXol+MwVNL?=
 =?us-ascii?Q?hDDM4hGm2nOfW1BZg5aVsn3toUGp6CXX/hIaJqpaSS/axCBV7Hlevca4doip?=
 =?us-ascii?Q?Hc2V8J7khvqT0c53qxo2owBEsZGykI1p+2IgVeMiSBnI2tC7Fnr6dAQ+zETk?=
 =?us-ascii?Q?HofUxAFjnelShR3XdCAZAPttYK3qX0SttiKiDJjiRkmlu7bJhN/hFinGG/+i?=
 =?us-ascii?Q?aOOBtwLHnvgNuRR4x/0FtkaG0TBOdUQavL0NMsloBnv818LhQqyQsnwCl9db?=
 =?us-ascii?Q?vR13O1086BaApPpB5K4sxScEFVuP3aSQu+YEXlhLZNaLzD5v0mC0efgh7l4R?=
 =?us-ascii?Q?VmAI+4NH8Slr2ou9H4u+gOgZLk4DVWreZcU+c32M20YePz7N2/FF/il8H0sM?=
 =?us-ascii?Q?rUvSg61MVUzKImmvvHPBLeisNdB1+gkaxp4NroedCboCIKP51cHFXGkZdkyi?=
 =?us-ascii?Q?DwE4o7BHkLjxN0ONdmmlCBLRsqxa6PqL7YR39IbOeiTvAuC18Bd901SPDAti?=
 =?us-ascii?Q?DBhD2RluupbMGQLDBsH/G2adsnIKXi2W47ahgrcUYM0JbqN8q8hJMEQedjSg?=
 =?us-ascii?Q?WpSo6jiPci93F6xdi42d+Jai0XqtXGhTkhfXwA6KBQqi+vo8BspV7BRrc62o?=
 =?us-ascii?Q?Nx0pmB9sQ67FjK1QegZ4oMTxCz7joBKCO0eItAspPXmb/UbAWQ+xrJs4sRND?=
 =?us-ascii?Q?gIgioSSzVHOJ6RYQKAR/ZPQUpP9Zx5lwvwHW2gWJSE52TpbEuAJ610Jx4Ndz?=
 =?us-ascii?Q?76TwA+f+7wr195rj9wVFVADDfZlYb6MSS5BIUswHUqvSJBusnKjQtlOo4sgk?=
 =?us-ascii?Q?t3FJnEAerxdu0Ih7lImTxx54eIdr7W+WVebZnvh74K72+JIK8UR4mNpc+DYJ?=
 =?us-ascii?Q?5dZ0YAv2rk7LIT/XUSp7LZPCfkqZFlEBFw0SClbnzMwOKn3NSTaPYfYZAbsW?=
 =?us-ascii?Q?zM0RSTcN2DTeasFBixlBGuThj2m1dEKHUYhNuPxE/0u4UbdjO1n+zDlxjDXj?=
 =?us-ascii?Q?z0D8ZqmBaxECKM47CjbaHkZd3HxMBK3KBicLmoyDbDJ0qJiC8RuigO0r0DpE?=
 =?us-ascii?Q?0D0eMwDnszpHvNDRqz6EvXaTbhZjnkRTyPm1IX1M8eBRWXo0V1DehTvH0li0?=
 =?us-ascii?Q?oNgT5Y33SLVNUeM9kP3ki6H0spgrAycYL/Rcm/b4RqAqcHxd5H6CJqtXuyr6?=
 =?us-ascii?Q?EaFiq4VdenU32zbLWDrlKiFtEjIVpb33IMlmOMfpV0juPpzpgtpy8hEBsD0i?=
 =?us-ascii?Q?3H3M0xDeHO9jBqN6Hke1LSZa/6D0zLV79o8Ikfgw2ROIRepfhs/I1hY5J3if?=
 =?us-ascii?Q?IDFSj9dEuld7ugUG4sOwQMMh+ghiDxo7XBTjVOK2NaeKPhLhl0Afl5ui2ibu?=
 =?us-ascii?Q?kkZt4sgEx1As54Fhd7P88GAkrmcnHBk8aqRlEwuKu5KuGVNx4dZutNP1R7GD?=
 =?us-ascii?Q?uBJ6FQb2EmkARLygkoQruog6Q+I7sNm0xkkIvFZL7U0hDymDL81T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c6e94f-9336-44af-be16-08df39f598ef
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:58:30.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyIEY0xp1jI7Sy8wC95MDHMisI9x5hdKODoDNgg0p72XJzloauRkU854mumKr+oVINokz7/2xbi9NXnLdz+6+YTd/HCRcWJUFyigy88Pe9E6+2Ga9RYgwKKO/Xr0aOeG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-dw-dma.c          | 2 +-
 drivers/spi/spi-pxa2xx-pci.c      | 2 +-
 drivers/spi/spi-pxa2xx-platform.c | 2 +-
 drivers/spi/spi-topcliff-pch.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b706770334a61..a655026071729 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -27,7 +27,7 @@ static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
 
-	if (s->dma_dev != chan->device->dev)
+	if (s->dma_dev != dmaengine_get_provider_device(chan))
 		return false;
 
 	chan->private = s;
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac185206..de790e94f493f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -81,7 +81,7 @@ static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
 
-	if (dws->dma_dev != chan->device->dev)
+	if (dws->dma_dev != dmaengine_get_provider_device(chan))
 		return false;
 
 	chan->private = dws;
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index 849a14cd0343c..8e90bbf74350d 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -14,7 +14,7 @@
 
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
-	return param == chan->device->dev;
+	return param == dmaengine_get_provider_device(chan);
 }
 
 static int
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 1f53d62f37267..b5aa52596ecb4 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -808,7 +808,7 @@ static bool pch_spi_filter(struct dma_chan *chan, void *slave)
 	struct pch_dma_slave *param = slave;
 
 	if ((chan->chan_id == param->chan_id) &&
-	    (param->dma_dev == chan->device->dev)) {
+	    (param->dma_dev == dmaengine_get_provider_device(chan))) {
 		chan->private = param;
 		return true;
 	} else {
-- 
2.43.0

