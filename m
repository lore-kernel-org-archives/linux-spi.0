Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792247;
	b=mrSar5e9eJJ1RhGnfPsqd9+rmqvUAJUUqWZoclrDnd+kblv30hP9mFlAGQSR+ABdb9BV
	 IclGBWSTuTgI5vydkFLpwXNL7Xjr+LpmF4faf9hm3Rdbyo+5zH0KPZoVzeLtlcPE6uhi7
	 NVG8fvlnPaUcGoE4UNai4nlv1d4smp9PobT4CMK5gGcB7diD0nyLZfkGV0DCkUSeKlqcZ
	 T1l6yrdXeQXqW96oCnkvFEHGIxy/0Dd5POvWK+QjZPUzW6ruEMxIx4azwpqJQAVjvUuAL
	 Uwd9DTYbdw4OeAXUsS4uL9f3EvzqZo9Ax7ymftJngrVlIF3gFhJYk9BbVKUOXGyosew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792247;
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
	bh=6lTGC+93F6eOlBTmee633XWr3Y01R8KhS/8vtHE4+3g=;
	b=m+GKLQ4yh1+sbrRnJS+ennfYtcrRfUshuzdyxhujBIlrhWchoereHr0QBt07Ai7E/jeB
	 DQcOtsZGNLvymaLNcCZ6qXYKT9Lrmvl+wIjzSh+ynB/m4sAmCzRvYAdUr0/3LbdFv1I2j
	 eguRQFjeZvLM8EBZ5SRLg1nN0szhP3k6dTP8YDMirsySrfLyPzc8+P59fFhh202Mb8E5m
	 hEFDK+LBgvrlxSrYSQl5ZEWJmIUL/jdofe0yt7fReEdPDNeDalDNfgnBeztHaC7v3ddtf
	 KSuQ1L+bsjSiHbyKTK9kFlYENPpBdv39DtF6yVUJakfsr/tcY45bh2OTPk9ic3mllww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=whiEeWW7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.43
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17C606A336;
	Wed,  4 Nov 2026 11:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E17C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=whiEeWW7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwyAAjXlmPUmMiRlUoP0nAgGQq/z+L0Bo8elXRXaE0cCImvZyDNAR4pWq+5JqLWDvb325R4rNXhQNOkuEXRto9MHH/7svWaLatqipSoqvU06lt+uj4z4XvFpUX8B/YzAYwDmjpkmTzst7hUZ0+DjI70wwUpALTb2rFHlG9oERj0eojdunuU4jePlWqtVYYFFF6FU5FjXYhX7QxHIB9DGqlnMBstQZObtxjTlXNB6m0eIWguYXK8pJUHD0bjBzwkJm/GklaGZioaPydixw61r8ejq7Nu9QYQnQS91/Fnanvw/fk9rWQl3Lzesf5kjl/cU66ZfDzbxos7kDIb78kH+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lTGC+93F6eOlBTmee633XWr3Y01R8KhS/8vtHE4+3g=;
 b=n2/PazAZCRZXu1bgKq3wX2uPR5V2yC8RsJweKlmaQ+oWZoJBf8TVUGUE1FyUHyskc15zs5e6ASBPsvWDMhysGHeRNoDGY2rF64NrYU4N88WM+JHkiAy5moI68NeWZCvAA+CSzUXbV+7J5qU6N2Qc96UMYfb0Eq/CeLCcUH87W3cgmdclrJSaOBGVTcNvGc1w4L23SdImHaQyaZvORyBT8LQp6DMe3/svR6dt/W7zbsACqIIB+BWR/dkChJ2J3NgvRlgKq8j0Q9Holhhljl85LieVG/QBsMpyPCwSECh1gCM0n0qTSUFLhP0KWk0Gxv5pM4KG+rFfnMnZk+lOfLLWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lTGC+93F6eOlBTmee633XWr3Y01R8KhS/8vtHE4+3g=;
 b=whiEeWW7Z+rocL4a5FZCZka3pR6nSA9ZDtflJK2yeREgkYtcx5PApr4S5+SXJbDLVsU9Nd2ax6b9OBFwk9qaZPOCEQpPPE4Mx0GQkMs9d6XG0Ah8S7LbCk6bjE3tsK2lSW4UPqhSdgeQEX5C7QAdRVvQ8nMSyN8ONMbeRLh6Gj4qfUpLZvuUoPqghopKI0WLXHY9vCmciXyMCJwnjaygW4Xiwi1bC7U+Jzh0LFPZ82WdLsho29/bKwGM2ePD5KMVZkLF3v7WcJUYxU8UBidbPwqTqVtt3si2gbjtrKXJrhC3ClFVuGUEybTP3fhXFAVnL6t/BijUJQAf3bz4GT7CFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:37:24 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:37:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: Convert to subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:34:05 +0800
Message-ID: <20261104113405.1634275-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 108908b9-7724-4828-971c-08df3a67fea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|10067099003|18002099003|56012099006|11063799006|261009223027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	V5RWqDKLsszxMl7QyBd0rfSxlwsLLjI1LL13KY18I66Vpo+/62CZRYYrJ9vJT8X/AKk2DKZydqpUDj4mEUfL84u75/aFBWV83vSy7aU70HT+AXRxJrEeKLWRViIK1RCVVUqXEjQvYEP0e7bx6YmLq5Ml1NjJcUuYHFR43rETUTiYiuQVBeSn1+2RJNd323Npx5nJTMxqdT1uCHAqlhOLd7F4gwcr5lU3eaXxLYxUUBm6NhgWm2mQVlJfRM3qOq7Kt0+ppxGtjKsL4y7sbek5ejKaxFG5SxlzpZHF1ZE0lpqSVtWkoddhAsF/EsMdCN6aBm+JeS71TB6rSVTM9RFiAKbxUy7pmV+sfLZMx9l1rHNTjr/mhglwKugBTq6TIuVHPFTOoj4ZV8JHOPC8JHCelXz3A/i2NK9daK0oh8f5BUTtPtG8280bkdNAp2lLPs6+haBA5SvgC2PSyN0DoxV+10zDsOuJpLybV1jqU8ahHfI4mbfFLB/jbsnWhntmRk/Scc687ORH1zgXUHoFHsmcnHFVMppf4Vn8fPB0cE/S7eZu0COePLzOayWJd+7gU6Yw9P4TYvSkS3wljNGdlVQ0028KsrczOnUsm5M6CueSpJruWj6DswNRyc5uSUuKGs8l1K7v9ntJZg68vrzY+EHlqNcI1rXWsTZiE1WqLyoZoZqidKO6ejWThNz9oesi6OpmH7s5NJuQz6fkz1HmOpaz5wIM4o1vxBLuQaoBrMfy/ns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VOdmuhdubNqNTEw8J0ZcO6ck1rhHEjnsne/F4fi4KOcUNCJEZT0GCzbdGqDk?=
 =?us-ascii?Q?3d1sBCnU1Tr37EmpgCJdo+PZQ+rNdQgI1ekwEQgRpVjbMlrYALjOIQW+spWG?=
 =?us-ascii?Q?mAasKGLhLnz/dhQQ2P2x5BKl77AVHFhETrUmvM2fTIEFpEKGTEbGuFoyAJ1b?=
 =?us-ascii?Q?V34ROM+KMRZfNPy0yG4ZBQNGGLLQMs/mAiYfJzRECFxsibf+Hrxb6kBosEPG?=
 =?us-ascii?Q?h+hI/bhxdZm5HaeqZLQhWCyTH/Ndk0dmshojc3DFCxd6f/xZxXkop1wTXjND?=
 =?us-ascii?Q?fGPv0mfNhXTmiKh8CmHLfauuopUAbT2y04gBSWiTIjBbeQ81rcdUlQaaBj7s?=
 =?us-ascii?Q?lu1/1m800w+CwVP7evROix9TPDDrq7XVYchnIcSMjJrZyaWMsW9voMC+gkb4?=
 =?us-ascii?Q?J9lZm4uce95YG3tpM30ZNw96z6sBoVhgymU0ZGLxKyYQV5Yfs49V1UAyAFu1?=
 =?us-ascii?Q?51W6F1ntJXtz9ocbccvfq4eVYKFhwLdS7+/hjHnQRnWbnvUornHHjDnHL9bv?=
 =?us-ascii?Q?3fl0OgHBapuLOTfbhYDks9HhTJjPXlGrS311OYWfjk8dt9rcNTgwTEIcA7iD?=
 =?us-ascii?Q?qFisi4Hqq+3pDQrxuD7FYRglfM+J/eOaTmcsbZkn/SHFNiX6q4MEBefbTWcy?=
 =?us-ascii?Q?d1fjmeEgU1EZxjIh9toIOj+0beMlCGrSK3eNqYgDziXth8ARkXbKwTtRbGse?=
 =?us-ascii?Q?G669NMnEo/sRpOeS6J5H9cMLBxpsA58Jwr0XFKDCijL5PwgyAImwFi00bmMj?=
 =?us-ascii?Q?yYuNIwwUqa8nhdvPKdZh66/D4Q0WjZoz6MdaoAY+xC5sr41flYOgyy5olfHU?=
 =?us-ascii?Q?DuAg52/4DPAaeaoJ7a7EbEW3Kgq51ma8GBgP9O+/mptatWvYQ57dD7fBxGyD?=
 =?us-ascii?Q?nvJ/sthhKYXoUG5ZQ0v9mg0osGobO491piERkejZIBg/OapSffN48Q88mgQV?=
 =?us-ascii?Q?FFp1BQbmmPKzmW/s2p9XDVu6NJ+tfmvoS3xoBNG/yzZ0pGHBNSCJYf3Y0v9l?=
 =?us-ascii?Q?Tm4sac7Axy5t450d7D4MeM+JaJGeiivFtl/bGkuypeQSB4GzoW0C4YOa9QC1?=
 =?us-ascii?Q?cqEkqYADLLxxVAfywnDdlcsOIDNR1rHIN84T6WzkHdsaLYDu7hj3XK48PgPh?=
 =?us-ascii?Q?h72ePD86CZcWKvSXmD7Ytl0eSSvf8D8fKRNkTIE10hIZeOAmzvyKi6iNhgpB?=
 =?us-ascii?Q?FMau24QtPz877GfO5ZIoy/ZHCEsIAaFMeMa0mpmqoN03q8mrqGlwAode3Yh/?=
 =?us-ascii?Q?zgrTIWP9SJ6wkiEKW9mLn+Tigoda8j/FGgFcQcK1T7cKAI8NA62iqhHKBIq5?=
 =?us-ascii?Q?jhlm+o44qPRTZCR0PImqY5/w/v56gomAtFG7U6fSB9eEx/Z3O8EhmIhd2uCS?=
 =?us-ascii?Q?yV3hdG1du6r4JL0rt4nRgTm5TZF7NLanFS+Je103MsMe0tYAJW24y2IIQf6y?=
 =?us-ascii?Q?aAeMOaO6rmunhtCCiHPuw93QhL9vQ5qzo+MmeGhyzGQhy55w8deTpL8HdeQx?=
 =?us-ascii?Q?LZivOsbe9jLw2s1tRRZJrYDMoFkUWp+NZEycN6tnJgb/d24ZvqWiOYf0Jg9w?=
 =?us-ascii?Q?8PV0vCQQgax8C1aOzhZXdDORcKBO2s+pkYLvUBdkL9TH4Me2KywgPc/dQfBW?=
 =?us-ascii?Q?Wuk+v0GZ6E6/FA6zkDv6l3vl8aR7x/XLcNPchjaiJ5ENEu6DCciYPSlcVeMQ?=
 =?us-ascii?Q?RvxgFuRp71ZE3WtSHN3fu9rZ0s+jaxha5zgxaiJuisgg83igiHtvB3fG02nS?=
 =?us-ascii?Q?LB85ZMYF0SpvEfueR/zlWt8ZmhNIMWFeBKlodBXYQTqCDGCi18nA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108908b9-7724-4828-971c-08df3a67fea1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:37:24.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zwuz6B9SCsIOmjtlZINFnYoliXyYANrbR+xVvzDtqJRVQMAxEPH2JCA8FvhuHvhpk6Hl3+QEZkm1AinXbWIkpZ40KLE5AR0YVOur2RDou+kwUqvjhuToCNLu3jFb8NHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

The pxa2xx platform driver is renamed from "driver" to
"pxa2xx_spi_driver" because subsys_platform_driver() generates
"<name>_init", which would otherwise conflict with the core
driver_init() declaration.

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-omap-uwire.c      | 13 +------------
 drivers/spi/spi-pxa2xx-platform.c | 15 ++-------------
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 83e263eb6069..6838a0603c90 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -528,18 +528,7 @@ static struct platform_driver uwire_driver = {
 	// resume ... use ck
 };
 
-static int __init omap_uwire_init(void)
-{
-	return platform_driver_register(&uwire_driver);
-}
-
-static void __exit omap_uwire_exit(void)
-{
-	platform_driver_unregister(&uwire_driver);
-}
-
-subsys_initcall(omap_uwire_init);
-module_exit(omap_uwire_exit);
+subsys_platform_driver(uwire_driver);
 
 MODULE_DESCRIPTION("MicroWire interface driver for OMAP");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-pxa2xx-platform.c b/drivers/spi/spi-pxa2xx-platform.c
index 849a14cd0343..eee70e1f8690 100644
--- a/drivers/spi/spi-pxa2xx-platform.c
+++ b/drivers/spi/spi-pxa2xx-platform.c
@@ -198,7 +198,7 @@ static const struct of_device_id pxa2xx_spi_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
-static struct platform_driver driver = {
+static struct platform_driver pxa2xx_spi_driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
 		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
@@ -208,18 +208,7 @@ static struct platform_driver driver = {
 	.probe = pxa2xx_spi_platform_probe,
 	.remove = pxa2xx_spi_platform_remove,
 };
-
-static int __init pxa2xx_spi_init(void)
-{
-	return platform_driver_register(&driver);
-}
-subsys_initcall(pxa2xx_spi_init);
-
-static void __exit pxa2xx_spi_exit(void)
-{
-	platform_driver_unregister(&driver);
-}
-module_exit(pxa2xx_spi_exit);
+subsys_platform_driver(pxa2xx_spi_driver);
 
 MODULE_AUTHOR("Stephen Street");
 MODULE_DESCRIPTION("PXA2xx SSP SPI Controller platform driver");
-- 
2.51.0

