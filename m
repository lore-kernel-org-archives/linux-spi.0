Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.107
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189503;
	b=hC5Y7G64zOoU96P0HIvOSV3SkUlIk2FNec6e0wAHT5xNKq58tvYgfiJ0tFSErr4nn9aK
	 EPLF8HP0JoVNxl32shSfx6teLi2uzMeuPMIy264N/0OMTWYStaQi3u/NlYfzVAwbgq/e1
	 FZ2KjJLg2NJD9WskEczDoblESLSZh3I48EZ1oaNWc97ATDCVoDvh8xqrJiCTB1usbbz5L
	 cQgr+7/KDZQZ9zTpwivQ92x/Zg40LhbuDaHLLIkhwxWiv2gNauH1bDau0DcbyBylb5yOH
	 nLDSPQ9lkoEwYQ9OjdiKYjNByOrd7ck3lDPyEKk3L9fah4c6UbWj6AQ5TApVdKXZORw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189503;
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
	bh=6uu2+LHx8xPLOidEQ2d4R6OrWR1Kq/5BObxRMnRM0Uc=;
	b=oqhFTA/xRdr7F0DPRK7sCYGoVy9OlamBi5vdA8tJEh6TaCwZ/bpVmtL2hv5ztTkocyi5
	 c50lMqnowoffbyY5HVHjfsnq+XhNTBhhuBuYfknPISVb0GHFns3RP3aFDYIiWfClOi3fp
	 0hPF8S9lhiyjl4q4L1rurhGmzjgvPQpOnSn8O82zNNBi8l7xK0USJ7aVFwgJ+WySLpDjB
	 RB5aujEqsm4ge/ZrVqhkUPz+yM8C54Yphmhkgk+wnjK4fAJCOHs8ETUbmp52IgJRw8O5q
	 +RaEATAwprSVX5LiSZzQOBicVbZjQNkmwNIJrbqi/yls+rMhKFBSVstFovK4QlxqDfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.107
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2107.outbound.protection.partner.outlook.cn [139.219.17.107])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8D60A2617;
	Wed, 28 Oct 2026 12:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA8D60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAupMfjYDDolFju2/SgNJvktxsfD6EM01b9i1I4FYa3XTxdYWY1H0KPCGi9BGMRMTLTisKngYH6xdjMz07xA5x/tnsieJfexV/Y07R/rTGDeeVOTHVpi7AZu0HTTeYTyd1Yc/p9zt5nrjWQlbGKFqufvwWF+FIPlwETnqzYXZesJV5zyEPbu0y3jl5HKcL6C0VqYkuKRKRwI13yqv1+I+/CUkD6r0Dak0mrJfQPYthLGFj3UdhLwUqc6oPJkTKcTCnHTmc2YVgEbPlhA4v0XU9GR7LVoPh7xtcZwpMswOwoh7HC6aaLSu8daK9y/EP3r0DTYHVeKQqsyPA8Gw5PGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uu2+LHx8xPLOidEQ2d4R6OrWR1Kq/5BObxRMnRM0Uc=;
 b=PQKvdODnLy3hh0S75/cVzODChJ2HQ5kzI/RJAQ6GZ3vbwecj4ms8iQQcvZQzSD2vJpd8NxBL2DoUVwlfX/9PLu9IpZqu/hOOKBE6QOVPkN1xVieIO10iJTKY128ZJov97tkRiG+3qwxmt0bD9IgD90wfpeZE8p8CMUeoLZUIgwCbvq/u3StZ5O+p40DyJ4o745Lcg7edM48Cn1VLwGaTDu08+6zu/TzvWZ85VnCiAISVNEeV4KcQHIJrcQsOqvtxWp1VcIAVMQH+KkHSwhSRzEPVs0YEvSZimcGxtgPCAm5dGStUtHUAFAQHV/N8yp4+NZcgLm0mKQw3jhk8sb9HGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:11:23 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0546.021; Wed, 28 Oct 2026 12:11:23 +0000
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
Subject: [PATCH v2 1/5] spi: dw: Detect DDR support in enhanced SPI mode
Date: Wed, 28 Oct 2026 05:10:56 -0700
Message-Id: <20261028121100.79667-2-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c4b82b9-8785-4363-c3d3-08df34ec952a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|7416014|366016|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|56012099006|261026140227099003|3023799007|18002099003|22082099003|261026121527099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	HiZMBFLb2BlzWxeX+/MAwScy6S/619J818oQZzvIYREoQmutxZrnmIjMqev74UjEQvTfXvWDOKXPfq0CwV8XAxakKgHNskt+J6QTPZggkMD0YRPfgHKkW1s1JgjR9rEfiTSTD06w24Vs2QkSuQThdrsHzB0aP/jCQG6u4nqQclpf/o16ps6+rsF2jMA4rfsILuhMLFvsgwp7zhnbJuf0qDQZMr6PVoQGuEoMShOoQVu6ePJlVVTFKF+JF0CFxmeBG0NkbCPKOhgJnINsCB05uyzhRXQfd6vmZsTgZHkNYbxT0PC0JSw5xZioequ1F2jTP16SGBFMuojhjkbosn/DeK9nfLNlZQEhhO1WeYo2EprP9BtYKTNfK2cNKnM1bjUjJeK31tf7zbgZGjHAOodNBRAuStjaEZFW7WASTNzhwmyDBbwPyaeUgMEWDUX3RbQd/wFFDjwz+gOmM1xlOdyaMQ6Dz8rBDCjeablfZHvPQHrR7VeQGmYImmbf9U28DzsrXCsVkvW4im4abN36KwV/Ll7QRPla7sAjrVNQJvEvCcZuUMG8NglpzG/qqIitwO7y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(7416014)(366016)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(261026140227099003)(3023799007)(18002099003)(22082099003)(261026121527099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/B+NfO6CyjDLehZXV86YMP4cDfL3jFUz5B2J2WJHMyqo56p+dhB3abkqPRe?=
 =?us-ascii?Q?e/3kRjaVXKrqP+IF6LE2hZGcMDbv8ndfM6kp5d2FJRMKWMt4n/chT12VzitJ?=
 =?us-ascii?Q?MCQeJRKi+w6T2QXlNW68D54Rr4swiuD/lcATgsP/godDhsQj/ZKyVJ0yqu5h?=
 =?us-ascii?Q?yrPlQilYdq7N1FlT/1iOne5kX02QlvHvC7zcifwZr6VBco+0KFVRnwriAeps?=
 =?us-ascii?Q?BquEpABlqSlklgJ6KPpdJ85Y81runUV3l0bjY9Q8n/0UiyAii7BF3QXMKHiR?=
 =?us-ascii?Q?fK6OWSlK8SIYWzfErWbmQUoNfPaQbKAvXCddxZZpl6Smr9INAEWspJouvNfm?=
 =?us-ascii?Q?Fhf6Cbmp5L/nO9DaikwTMGbE6K8HJq6crV/wx/3fFVXlssExcOpLuk6hp68K?=
 =?us-ascii?Q?/g6d27PTgG6S9nSGPe4X3n+QL+9kVdt1MZ46PTE4y1GBbij/FFbZDVVqb/aV?=
 =?us-ascii?Q?rzIvhh0mfMl7pJlkeYl8XCvEUjBModvFg1esAgL98M529aRjLByJriLj3flV?=
 =?us-ascii?Q?Dw+I1jxDuBKMx77gGIAlxyi6/Fo+t6MTBTJzYVa9ulsbQf/AmFNR6ol+UfNF?=
 =?us-ascii?Q?FbRJnrQxpiMNpkMlr+sVttRGQOCUMEHAxvZpHQq8z5p6WmVIXEaj1WtLMqOb?=
 =?us-ascii?Q?RfxT56Ob4VItIic+vuchwCFsTKvOpffqQADOJUiq5AeyhoelL0drsCA4VaGC?=
 =?us-ascii?Q?XszHot7gllSXm+dFSqIXETToaGTZzS/rYQ35vO8Ri62Zakyg77/t9Svp/aCP?=
 =?us-ascii?Q?FpRnewKeG4lMU+Hse4HK15KDgCIuufUzM4cdC8Z1NFKjo9LtBOo0MnNGUCHS?=
 =?us-ascii?Q?rk/shhSaRMyBLMETLbF65NYEz4RMbnr4dsDnf52EyQCLnGizOykGGRmzH0yz?=
 =?us-ascii?Q?KCpfLSnRXtjfR9ZhjHzZKlM0KO/WeINtF2kCSGm2tOMsnGSNnZWl31hDhOxD?=
 =?us-ascii?Q?x2QYGjZ/Mbr22EiIWq5iOxUw7Ld/43PHl8VzOv/AB41PuT6vbmhe9O4RAXUf?=
 =?us-ascii?Q?yYooQ371zIG6G7AwxksNSpdDCRUwcIxb99BhUUtQwMHtD06ioqYL7PUCnKZ9?=
 =?us-ascii?Q?8I4cctaGnljZwDuxVOtjXY5unLhSpUPrnHjdTtakqnKYTAsiwEao8K5tRuMw?=
 =?us-ascii?Q?THMGliaDlrx+y31IO6S0pxPEqVEIXwQS9n0f7sSVurrjL/1xs/iRW1yqPtnj?=
 =?us-ascii?Q?idkdDWMIHvOt2l04CzGGHGCGS3fwOTZ89t285rsDgY1Pse1R/q0Q4+AlG9n+?=
 =?us-ascii?Q?J/uQtrsIa+IhiWAiC2KdiT7B+GUSj8x2vbDqvHrWwjydgda7TmM8mJ9fFsDL?=
 =?us-ascii?Q?kUE06/zIdUg3jdYy5kTqbAUYHrUhxye7EbkMOcVJ6MTjTxV9oznU2Ac8jVDs?=
 =?us-ascii?Q?mLlbdHxsbz7Nh8Q6F+IESknle7BDeJkKbwD4y3wqSPmfbKz06vVdZhtWox9P?=
 =?us-ascii?Q?oAa7RhblUhc0hzVPPzfRd8Elh6+Mf3Fsp1nisUup3PFKePJga6uDi2WcxCpD?=
 =?us-ascii?Q?wtgiL1VdFlw99l2lK0qF9pEySrMGsPl9J1kNLZrH511zvowIqGFukibntxAO?=
 =?us-ascii?Q?AArloWTc4Fl5e9nRDo5vGtjuYLEx0vr4MZq8FN5iGGpoCBq48UNwt8Z4ca+8?=
 =?us-ascii?Q?yCHF0Zh5km25PWCBBWek6et/VaBT6QmQn35GSasRkn/d3GqLboptAVBoL7SY?=
 =?us-ascii?Q?WqWIEAW73SVIQdsnGICg7gsvlY3QMs4pk19xJoS0O++0DCk15o65CvlZMls7?=
 =?us-ascii?Q?5wu5F8FWJgKQ+azAxb51k9avbAqFE+25XitUerwy8YsOaoh7RT7Y?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b82b9-8785-4363-c3d3-08df34ec952a
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:11:23.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXzMcZjzZu/EO15FHJkV4ZwkbTU6HIM6mimHuA0lmSgRWxRqGVXCOoDP0Krjre8365fGiZF6FxtBhpzjfRR6g7iNlsiL46iHXu+sodyZd8vni7x7VrD2hwRQZsjkErxa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

DDR (Dual Data-Rate) is a synthesis option of the DW SSI IP, separate
from the enhanced SPI mode. When it is not implemented, the
SPI_CTRLR0.SPI_DDR_EN bit reads back as zero.

Check whether SPI_DDR_EN is writable in detect_enh_mode(), the same
way clock stretching is checked, and record the result in a new
DW_SPI_CAP_DDR capability. A follow-up patch uses it to decide
whether DTR operations can be advertised to the spi-mem layer.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 12 +++++++++---
 drivers/spi/spi-dw.h      |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 47434fa78e4b..e8f70808352a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1269,9 +1269,11 @@ static u16 detect_enh_mode(struct dw_spi *dws)
 		goto disable_enh;
 
 	/* test clock stretching */
-	dw_writel(dws, DW_SPI_SPI_CTRLR0, DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN);
-	if ((DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN & dw_readl(dws, DW_SPI_SPI_CTRLR0)) !=
-	    DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN) {
+	dw_writel(dws, DW_SPI_SPI_CTRLR0,
+		  DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN | DW_SPI_ENH_CTRLR0_SPI_DDR_EN);
+
+	tmp_val = dw_readl(dws, DW_SPI_SPI_CTRLR0);
+	if (!(tmp_val & DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN)) {
 		/*
 		 * If clock stretching is not enabled then do not use
 		 * enhanced mode.
@@ -1282,6 +1284,10 @@ static u16 detect_enh_mode(struct dw_spi *dws)
 
 	dws->caps |= DW_SPI_CAP_EMODE;
 
+	/* test DDR support, SPI_DDR_EN is read-only zero if not implemented */
+	if (tmp_val & DW_SPI_ENH_CTRLR0_SPI_DDR_EN)
+		dws->caps |= DW_SPI_CAP_DDR;
+
 disable_enh:
 	dw_writel(dws, DW_SPI_CTRLR0, tmp_ctrlr0);
 	dw_writel(dws, DW_SPI_SPI_CTRLR0, tmp_spi_ctrlr0);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c16225c5c887..f922e000e7a0 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -36,6 +36,7 @@
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_DFS32		BIT(1)
 #define DW_SPI_CAP_EMODE		BIT(2)
+#define DW_SPI_CAP_DDR			BIT(3)
 
 /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
 #define DW_SPI_CTRLR0			0x00
@@ -139,6 +140,7 @@
 
 /* Bit fields in SPI_CTRLR0 */
 #define DW_SPI_ENH_CTRLR0_CLK_STRETCH_EN	BIT(30)
+#define DW_SPI_ENH_CTRLR0_SPI_DDR_EN		BIT(16)
 #define DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK	GENMASK(15, 11)
 #define DW_SPI_ENH_CTRLR0_INST_L_MASK		GENMASK(9, 8)
 #define DW_SPI_ENH_CTRLR0_INST_L_INST_L0	0x0
-- 
2.25.1

