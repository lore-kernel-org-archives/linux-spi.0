Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF3EC810;
	Tue, 29 Sep 2026 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708795; cv=fail; b=h7Cqp/w6H/zC4bPje5T+sf79cTUit+vhJ5oHww+OSbmBbjRs+Ptc2rM7IqkUEraExrHtHDKMxwhRaomXEAptrWMgohx1fxePXL/YY3X6XiHloUCDO57niMpIkeG20RJ/c3qPkjORokR6nKvGA1jDsOmld1eWVE7HWQNk+1kbIZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708795; c=relaxed/simple;
	bh=vGWpjITqs2C8W/ZzwZ7Cb8s4vFOT7Nlzj9xKnet5m5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jN4qU2A+BpFRoOtv+zHk0eqLQ+d5W0S9j9U4t/SFFdQubobokXtO7dUxZ4ZiAip78IpgK9Mp6NOBQNrtoSPRp/n3OTwxJI9Lw4EwNcBuPv36ecUFRm/b1H2wPEdDXNkYSN+MNkrAXqVu3dsNHEFdwyhym9u8d8vYiEa9bG1wQ3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iicsQZvp; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iicsQZvp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/mjatK7nqp0Uh7TmyR7e/Mv0hRd4cGoOi+RmV8u4N2RJEtA2W0YUey5QLpKV53LXfgLocPr7J7nsyC1vNk0+y2UzTCWtsR3m+yEE0yf8/Wv3XpmOYJdcLhtSD6PGi3+QJPNyLzbslS7y7fuzuDZClI/YwzN147dvCqXWHpBgYiE5EthNkV8DFJnrZCjpvFkcYbwUKxDpuHwbnMpDbePgk4LInN19Ww76bj+wRxRdXH+kUfBEm9Uy7nbnWlr6D4XFOl2jfIxzdx46XwKLLQ4IXZxCiUVEx4tI3S4T0aXlJpYUQ04LzxsSDK7lfWKQwB05M8qh6xGCpz3y3HgIyVVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm/DPr5DI4y/jSLn57lnko90SrK3FzpDqB0pYM2SGPQ=;
 b=Mb2OZGN6XcYo6D3nJiAHjI+icx4CSdwAr8o8BOZcPDPkkVJoRigdbENjGzuODBuJEf8z0eiPLObTxKhYuvFCZA8yI5yH7kRCEyHJqSVIdZ49MEFSexOt1xXXoeSCQ09rumC2krKyW4yQUVLvlaYPRIc7vGvOqGvuoqVym5COkk/3NwCHQoazK0bpD7j5dYXFztfvEa/M4deKBQUaVGzR6TzqE3b23Pmips+jgPm+6Q3Vhje5jAVssGUp3LUaE9+//16JMPogKA9YJHsjZPHbHGqec1HiIkENzfFDN3TibAwn4zfKNyXXAqPiEXLMYMn7naqmnUXc9riFsPpXCv+mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm/DPr5DI4y/jSLn57lnko90SrK3FzpDqB0pYM2SGPQ=;
 b=iicsQZvpPO/b6Yl+Oz+bOVxa0b8YclHnhef8fWJUNnNluiGJrTMiGmntQXzR9QYV4AeiLtbG2VXRBLWnmHMO2ychuZTCbm4BsVKqJSJ/vVBI0a+9SXHPWMb8UGqPggWG0qTKswERIXCGl6XfVcQK2+3hb5a4du72k7Q5M7DkEYV0PbsKdBbiVtXakyvRDfxWcj2DthPNnFDOmel72okMcqBc/YbQZALluR/eLmsYIU+csEqiqojX0zAM7IvC6kGqjvvfr/FsjnXklbgqOG2CusY+ACPrvg2o4LyjDjtvmLBESY5Nc0OVlBQN3SpyFX09npjT4GQ8r/Irnt0uVv9aEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 19:06:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:06:27 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] spi: ingenic: remove dmaengine_desc_free()
Date: Tue, 29 Sep 2026 15:06:20 -0400
Message-ID: <20260929190621.3516424-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0027.namprd22.prod.outlook.com
 (2603:10b6:930:16::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1270e555-8378-4395-dd96-08df1e5cc364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info:
	+juSzncbM9lmNr0oX6O9ZTdxa1cNBDVoBZA1vUCwqkmVpZyPK7QZMUIH9v3zCOsxBdY9CYiF/19KA5EN4SGpRlR7MRzCZ5JR/hB1QO6fTdvj01sclwCDC8C4Ew3YQRB2ns456COhI8Chefx/F3dRpgQTmiehRURHQbzrQvBCIKN/WTpQxi2V6x5H1ltd9JKQUbnQxknCYjESxk6KDCe5q3wuUflMvP1weIWcOxNI/AzgyXXWuBDfgfZ203lcsIWBUIdPQZ6kM18+lgkDGCSRip64gVoJaD2u+jUykL+5m/tEPDc/gd8jZus6x9KCIWRkQPmgog1dxXXW3o8cvv7M6s73mxhsMuTiU127ID6yx6mbz97s02O0mCslmc2EW2dvptVSsYYQSGsqp4bbm0ALOIAiFST3/0W0NRVWcZgfnZBe8LQM7w/BccMTUsO26Y1mwPgXyKRcHgOqu3ftpHaVKmq1u9og/Srg59XUwVkRdRW2cbwy/uEIbVlGxhSWoTs0k8IdZmaH7keM9E7nO4kkmBUQO97boioMSvCst8bRk/RfWciJYbrQhMEq9CJgNoPRfJ/h7Ver7FqCdsQazRQvTF1inxlUDeIbvs+G7WNv+gBFJke6HSXq6+kr3YEx7CzTm2GjODwnY/QD7mX1xGXQyzrcmcaL0vrtvLyQEcc4e3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(5023799004)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tvMJIzWf4+H5v+oKlPk20tBvfUI5T7Tm5ZT/GlsSv7xYZLKg4Q1A3vilFXZp?=
 =?us-ascii?Q?AeTAbDmSjgCm+sLuePzBQewTAozXW9RTbEMMC5TURuV16ca0oXB4fWZiJFS4?=
 =?us-ascii?Q?QSYAgL1v1D4PwIzb9SXsHCGTxu4NMD89CGM5IcIDZlCjgp8mHUGoH4mqHUEH?=
 =?us-ascii?Q?cfs1o66DF2+Wto1AkidnbOghxcsW50TEDUQ4bD8fXx4JTVGlZ4r+NjBiqvLb?=
 =?us-ascii?Q?ECc8Ic4CAuEVF4l1YdtQlX9bN+ge8H/wZUxJ1LCVbzoIft1VUU60aBzuMV23?=
 =?us-ascii?Q?pJs5FbA4vlgkVXhipUG86QHvJfPnBSJL9Tugfw3ZMlCIEF+AuMYtvpIFqE2l?=
 =?us-ascii?Q?AKJ066og63Zyi2ss10SKwDdL+MnRNATGgPZUHq/9v6wuV0yV0vPOskXAFbl8?=
 =?us-ascii?Q?iDJfZNaFZmWEpCu2D2NcKzoph9Rx1H9V9f3i1rNYkpz04Ngjrn2ppYb2vL+B?=
 =?us-ascii?Q?xhn1i/URWYR70Sjt17u0Ty0G84/V4IRDjdM/gWmGMEkTZiFIa1eSb/C3G/S+?=
 =?us-ascii?Q?93JyHL0d7qQtZ+2Rtg/PzBUEEloglgEucs0zglG7vAwpDsh9/oB7+MjI9PTF?=
 =?us-ascii?Q?SZtm8a5vrOWLgXQgY/S4TtMGA5UHc9Ot8sa1ry6bnaScmJDH07oVD7rzCwUU?=
 =?us-ascii?Q?RZ9WzEW3SWSpXP3mCCQluketwOiyZUNegbXGdWu0IEGP+TiCJ1xOLCbRL6AT?=
 =?us-ascii?Q?GHda94VoueJSCqV0B0e9ndwsQc00e0YGcwQ9rtJ0yiDvqajsnVp+iOzfwE6g?=
 =?us-ascii?Q?Sv92+3OH2clnDdIJ7N1NlJ8KK0zjfyAdMBKzh/OJvYYEuNzJ8wCTOu2hXhH+?=
 =?us-ascii?Q?TnCA2tQ8/MNcOQXQVHrJpyHkLVD/eP/03ppcgnKLMcMvAru1aTlPQ1PFQaG/?=
 =?us-ascii?Q?Knr3l8sUowDZiT5bWAr2Pjp6kYQZTCdQ+zHFjOd5W/X0QsdF17AWEmfoAqjP?=
 =?us-ascii?Q?8gkC+1qeWvrpwbU0Op+RmZMQusvq5JSxuuZnGYcwweIK9wq98MwduNndeWQh?=
 =?us-ascii?Q?5u68Oa85fTumIvWwfRv0gdWP4EasLwchkYoAyAe1LlqilgP2HGfFi3Tvw2p4?=
 =?us-ascii?Q?XLTsoZJ18dvfA4jopkn80KdkTejMVAns/cH/iTyrph2Vg34r46TSwlIIyULt?=
 =?us-ascii?Q?7bSvJnk2RmKWJS81sHVoDvyLWIi7S1oJZMIfvJQMTd+wQlWLqeLoUdl6FwDE?=
 =?us-ascii?Q?/8NZODqXCKjzkKaGzXt2V32Xd61Um7RnaFjxb6x/sGeP77KwW8DF7bu3XYP4?=
 =?us-ascii?Q?W9taGBpVxz96atp3ddiPwjPf5K49Mc5f0TPh0LXWz1vYK3o6mpq+ZcnlOqbE?=
 =?us-ascii?Q?Vi+3kCKlTpqk1Vf22AaKwB3GMSUX3wyo4R86wr9IGEP4c+Of6nrqWxISTC4J?=
 =?us-ascii?Q?QE1HfAh5A8PdVX3aTKotaGV0nwX9l0rS7avo39+4GT3i+QDLEMwlzv0cGmBs?=
 =?us-ascii?Q?e3ViC8ugfyBCO5c/oDvoLLqvxQGCLEfKAiLe3Im8tcLMBuadvjG1XxALMl7L?=
 =?us-ascii?Q?HNGWsel90cT56m7/MC64kt9z95fMRBAbOeun2osi7oGV2k6bGlGLRt+0ERPs?=
 =?us-ascii?Q?YeYxPAJDoUlVlbx2R4XXtB6i6ygxb+4OgJU1hI1T6LDCnd0Lu1HmRRoPrSUs?=
 =?us-ascii?Q?q4q85HFnYlHZdPwGhn9CzA89oTvJzoPz2ggmiREeijzzQ+Qlgcgw8OTdkmQi?=
 =?us-ascii?Q?8JBWzyaDQzU+P5FZz7KNeHzEgY40ykL+tYzeGiXElH+bsNW+//XwolUgOl4F?=
 =?us-ascii?Q?R/2gBM1tGLSbEUpaPsp8T6G6ww5lXMOWF+du5qAYiVrozEgCxj7A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1270e555-8378-4395-dd96-08df1e5cc364
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:06:27.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gbonAI70PUTS074fE2xiQwfssLsBHtnh744jeMyxrOsZDO6fByRSfeaISXlFJ+e6vDO3Rw71ZTNRwUr4bO5DMQ5zDw8kbHRQ5htbwbZUTZFvSEirP9X6EY3qa+F59h5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363

From: Frank Li <Frank.Li@nxp.com>

dmaengine_desc_free() is designed for DMA_CTRL_REUSE. If DMA_CTRL_REUSE
is not set, dmaengine_desc_free() will return -EPERM.

	if (!dmaengine_desc_test_reuse(desc))
		return -EPERM;

So calling dmaengine_desc_free() does nothing.
dmaengine_terminate_(a)sync() will free all already allocated descriptors.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-ingenic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 7ce4fe965cac1..a0a047510611e 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -164,10 +164,8 @@ spi_ingenic_prepare_dma(struct spi_controller *ctlr, struct dma_chan *chan,
 	cookie = dmaengine_submit(desc);
 
 	ret = dma_submit_error(cookie);
-	if (ret) {
-		dmaengine_desc_free(desc);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return desc;
 }
@@ -186,7 +184,6 @@ static int spi_ingenic_dma_tx(struct spi_controller *ctlr,
 					  &xfer->tx_sg, DMA_MEM_TO_DEV, bits);
 	if (IS_ERR(tx_desc)) {
 		dmaengine_terminate_async(ctlr->dma_rx);
-		dmaengine_desc_free(rx_desc);
 		return PTR_ERR(tx_desc);
 	}
 
-- 
2.43.0

