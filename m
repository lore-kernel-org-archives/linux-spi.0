Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794428874;
	b=JYjKgtGXpW7FIsIEiKNEdaK2y9RrYzcsUoOs1ifX1dMPQivu53Dbl/paClUki8LgFI04
	 zf0a/HybZjLoHsxwHz37jKOCNEu5AncowQC9whtmrXg5i4mtRd9TISXn7HRd/uPStsOYk
	 b6udVo3yu1educOrjYLa4h4/bY1agKi1yxETSgT72sEhnm1tpgDBDAcRYjNrt0/mbP6np
	 khrrBgdcqBj+gt5w4zqU+rhuUFZ6URj/g7HtI3DvGqTn0ewD5VlcsZwKneXXqrKFtFYZe
	 SXT2tnq5cCDK81xrBz04YlfXDmcsJuS7t/LjLLP27wzUaMrwf+1w/fRBXzzi5qymRIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428874;
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
	bh=hHDUEXT8Smi77nRmQjdP8iGKQR/YAzPk8MpBCg5LccQ=;
	b=wfIxoBDAboLrK09XAixW8Va78RD00m4IP2elZr+Be1lYhDbWIkDTKdplqY73tDq9srBf
	 AqZgqrIV34xhpns+0PXdp1BELbvi/zhkfiEhIzNwUP7j61BgFTO/BOI/9CFlDxtG/0nS7
	 J9DG6mncEV6I6UMl6MXvFHJ+eEMxnnd5qTQJzdl0uWSbsFtk7q1H+Q+7/PR3gHiymJR8M
	 1/etmwuINM90R22WCfdgzHQ+JYv+DIdnh42nh9ufFzoDq+8nLfsc5G292pDE0syt5BgSW
	 hAX7x9A2FsHW1W0X2N27NaVf4w9NR7H3KtSMzJ9TygKVLNRalMhH6/GCRJXmAXFOjvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="Xy/IpXhK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.11
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1516606A31C;
	Wed, 11 Nov 2026 20:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1516606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xy/IpXhK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAdVDoQOVqrtfScZ2agLqDIz22W+lFoXa2YoiFxo81wMJkca6KL1CUnyJkLMaXWL9PWx4V963dNs6cBVVb5Hxnnhug8oJFHI/V6fjSVBHYD7mnPGSBlLR1vFJJCmcdymtMS8HnmSuxoc8iaLv5Fkh+Io6NrSxB3JUDeRVR70dfstGjP/Yc5DOM6P8p8mV2DrJ6U+m3ZRN4HGGspmp+vO13k9pV2Y2K8pW2yotkZV/m1Rfk4UnrsfaOqK6EKaPlmyYqfgzlc5ll1B4PpdjeTMRI9ox8lcXCBX0Liz5foRnepMgcWyNA12KGwn9e83RnwveBF874LVpWmBFlu/fynCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHDUEXT8Smi77nRmQjdP8iGKQR/YAzPk8MpBCg5LccQ=;
 b=A9YPYSJBHMU8xZmOiQ3Dyj9VPF8slS8WT/0477SqJ1iN6ZhiwgJBW8GgcytB55zDLmHq5G/w5ncLvKmVOiHF8ThqaHpvMcvLQO9GkVTe8k6zVEbKefCu57hQhPJGbQJchBPCpduuNdgdydU39QhcD3lncN3n2dOv0Kcidr1LFv4n03usbsaCnb5dSAE3ertQwH1Xask4KMfKgntwEnBy/mIBN8WJS3aveGRaxK/liyS+zHa4CiX8D8bbHtYy1Tl7wSAXiHmK8bpJ8/pwQfJS6V6gmOtohVREUIK5mJcE5/SuenPXxzISSSVj5lYDs0hnePUrJ+I+8s43qsKKyy7AYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHDUEXT8Smi77nRmQjdP8iGKQR/YAzPk8MpBCg5LccQ=;
 b=Xy/IpXhKigimUTWrHIeVVgnYQ2soPZ3g9WBsbTtGjHhva+2JNr1185sorxMWhcUI1gJ482dqKfs55AgvWi3TI7Vaf0jbu36CZ5W3t3GXpoC11srr9bwh5a2p2h+dPgQN/9437GIpFrvTiwtpXLiC8N7DCfJ+px5GlCztkBdworxFWozClguZP4R7wN30X3Iy0b2k3a1NgrVTtWPmohAN/55wkrUrxW8dgZyORKFRjqO9OC0qE8CMpckapkN3g3eogpkojEhAMHEeNRXMT75M/jLcb3x9wuaBizWnLnKEKBE55lPHf3tn5ZQ+LbZUMOUEJJQ7cAwzZ2HIi7dWgFV/rg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GVXPR04MB11018.eurprd04.prod.outlook.com (2603:10a6:150:224::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 20:27:48 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:27:48 +0000
From: Frank.Li@oss.nxp.com
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:NXP XSPI DRIVER),
	imx@lists.linux.dev (open list:NXP XSPI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
Date: Wed, 11 Nov 2026 15:27:40 -0500
Message-ID: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:8:450::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GVXPR04MB11018:EE_
X-MS-Office365-Filtering-Correlation-Id: a0226c45-7aa9-494d-3070-08df403240b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|261026140227099003|56012099006|11063799006|261022105027099003|261021121427099003|261021123027099003|261028144727099003|10067099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jSMJi09TSlzM73IhB0vEPBSer5466PicI3IgJILAvlXeftOrkDITkK6oNTSzzI0oA0OfB+TVwLA/4EJ0QIMt7bTX4yy8lRGYyNi6ggTf/ocx0KMzGPImPOBGSlKdu68yYqP0ywnAPPlaj00qUtznpOLA8gnVgEKLfLr7ztDZRK8nxcZ5j4IJyVM2V++2X33ywJNV6I2j6JILXitwuPrxlTfd13JbWhEHVWOLzTQjm91NVNGvR2FmiPoM4NvHvaJaVCKZRvMit6RTxbUT3TCaTq451oV65lNeb9viI+2QH2B7491jHYYw69moovO5PdP9+PAtiSMFbl+o8ONSknEj3XzP8KKX5x12sHjp+xQirIZh/lT/eUOGD7EzzSwA3WtvUfVhUA+hO+JfLuLHQlUWpnVO1kvkBMOicjorsJ2ETADIb7QcTLii/mn/1VxXDdEaw0MryvaQGgf+0R6sSU74zo3mik5ria6wVhVRbxpiv32jWyqJp9Ba6mp7GTeNqwT6VuUKCvU6kgKX7yieRzJBojj8QrkY0L/Ly6gK4eQpt2qSLCeMScHJtcYZb5iw2syNJbgISwF0K+1rf02DjBsMb+K5vSUoHhluVNWsJRg1FOtEw8SV741/GQ09KgT/a0VTO+LPI3xc7fA0wJLJz8wY4xqd60pP8RYYopCEbL9nWc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(10067099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8vyxupp2m2Jlc8RIvqQC8kxibzZBguuIWGS5ttOdRy2vkBwPoCRvXJ65zU3?=
 =?us-ascii?Q?KDTdBBDPIBM9MOpL92ciyDErdiakWG3v1Qgf2+5vueV4cNzPrqnrhhatheKg?=
 =?us-ascii?Q?bR6S/Pewts00E4n8rlddqVaxeuShXtJKEV18dsb9Uhd5ZeFGb41e8kqGLF9s?=
 =?us-ascii?Q?4r8hbQXdJIcUX0IkKZbpvqnnaLKzWd7WP0ApfpnXb2tPAyV6yhcLJLFy2qZP?=
 =?us-ascii?Q?EzVZVmZ0auyFudlLq6T3uFv0vRxVLGO8dl+mrMjQIT7pS46Jg4HFXkCbtHfy?=
 =?us-ascii?Q?QJwgJoJXqYPLspLekPyCIYM1HCW9pd5PkJMIX6PN46aHrCo2705bDWJsBjqj?=
 =?us-ascii?Q?sf7kGa+okMu01SOi4+91XSpB9WvDYmxCWcpre4cFLsQ1nEFuW+zIq0iNz+Ka?=
 =?us-ascii?Q?pRXCQBDILPHt4ySsoaSSDjk04vBKsnMxXA1vcdV9vMAjzWA+DdBmX+++SOQ+?=
 =?us-ascii?Q?aqCKRVIlEv+PRtBUlVDXOCMs9IUfSt65BlNnQjz77H8tdwnO614fTCe5AmDW?=
 =?us-ascii?Q?xwN5/2E/Ft+ab7D6x8Cg5dRsALLb/0qUPEDEJlMIz/drgX1dTN6m7u7O59lX?=
 =?us-ascii?Q?ne/EbqR13tCcsYLoRCdNjTLaENIgfufZyFIYY4xoh+/7I/ei6SLhHZLgTlsB?=
 =?us-ascii?Q?87jVpBR3Oumak0pdoIDmcVf+tMJ5ap/TOu3HZb//pmWNtzmfA8S1fJcssVI7?=
 =?us-ascii?Q?dv0DOH7mlT9CoHkBnKvEsPha99l09zn6YlrmFUmSPhYX6aMntRYJgxvz9BC4?=
 =?us-ascii?Q?8mr+oFsueZ1ztDk00XoWynOytTsK1D75wHSdDUbPk5IPT/siEronaKcl32BY?=
 =?us-ascii?Q?nqxHg00vehXQZdi5f/MVlUe7Jy0B6akgvAItBk4tuLRHknDvVWewK1IZ6d3f?=
 =?us-ascii?Q?stU6kR1OCfHkW3oHhmzX5b6747wAjNjN90IWg8qguu/U0zt6zDbgI50m7VZo?=
 =?us-ascii?Q?CZPU++k7F0rUx4ImokZG+XTXfrySgD9CPxC4IUHjG6nusN4eXpon7nqK4j0F?=
 =?us-ascii?Q?B41SN7UEuiQ8g0eP4zgLEq2kSaSlbl0ixoE9TeNpvnWsvErZAEpeWnM1Q5bb?=
 =?us-ascii?Q?v9P/v0KlKSAujjhrxEn0SRaDR6+HnsENhLvQSAkOgBpUqJow69HfweTSdh25?=
 =?us-ascii?Q?YUipwlukzdfBUsQsmmc9SMe1h02UhfP42n2vnb656hY5cG9Z0d5X+mYogzcq?=
 =?us-ascii?Q?TiHKtcB2wdfuAg7h8O58o9wnYxivt50uOig8f8wp6uxUSX4kHMb2v8IuTNCo?=
 =?us-ascii?Q?iYg+/CkgUCauqBH/KcQszFWPEXdo+6owRatp1i6z0wbljPvGXxh4RF6lxqX9?=
 =?us-ascii?Q?1UaGsT3vaNKY7B1SGWwxvgKctp+WyCJmIliBFNdDcSkQPxJp8CwfZEWkLnoP?=
 =?us-ascii?Q?fii2ImTDQQEWGe1pXooXb9WHCWgkCDVLAJDrwedgS3kU5IAFqold7HYfny6Z?=
 =?us-ascii?Q?/3PAeUONCbD622rI32vyp1+DHEpo7fmSuli4nlwOq3Fo2sdCd9yJeRhEQwVj?=
 =?us-ascii?Q?cUCoxexCL+i50WnyK7B64F1GsU63eUqQXglRaWgj00QQPWqPlC6j4p2LoFcq?=
 =?us-ascii?Q?SXnGQLe0+4+Di8sM1zIYN4gcxdCBeqQ6foRxq5QsTpVoJKAGe62Ni8bO0ecm?=
 =?us-ascii?Q?yAAsogVL3Yj28bAQt39eIc8eTeA8zVCZFoMyvfe3nc/ED1glq9qVCNAQYqaf?=
 =?us-ascii?Q?z6Om0n14JVuCLrxqdbisChHkTRmIcWJ+cc+xK58isrBENsoGK4a7BX8aRZx9?=
 =?us-ascii?Q?GxDVrcveChv3Nykq1/YhHeDhBo15FYUFDn2ow2ZS47ZQDmrCwXTr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0226c45-7aa9-494d-3070-08df403240b5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:27:48.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVFgrd4W8BsJejTP9c1Wf4JSl/51Am83dJKCo7FYiFJ8OexSEiNIeqi+tUI9apx4MgDv4QR/5nbHaxCaQtv7iwRZhKtz+4iZ057zS9j1WiiaHO1PrF49iQ3xMRH2rLQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11018

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_copy_align() API function instead of directly
accessing rx->device->copy_align.

No functional change and prepare to move struct dma_device to private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-nxp-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index e532b2da54835..e8383fed461e5 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -824,7 +824,7 @@ static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
 
 	xspi->dma_rx = rx;
 	init_completion(&xspi->dma_rx_c);
-	xspi->dma_copy_align = 1 << rx->device->copy_align;
+	xspi->dma_copy_align = 1 << dmaengine_get_copy_align(rx);
 
 	return 0;
 }
-- 
2.43.0

