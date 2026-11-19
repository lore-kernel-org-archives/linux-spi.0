Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795083158;
	b=gmD1zJEpbjb7H5/9c/qF6TfeU+jnJd0qkiC0xonoGojl1EY/0QFafEUlB0TvEjxEaU2N
	 dfXPdr2cKdOtoP0ot5MnSVfNF5CTdhEplCF38pOcreK4nW7ObgA0jWfXDta2jGzy90iNW
	 tPx1nyW/BAXi/WfIxuBzv5p0HNvN3EVSlaJ89KwiC7s6o6axGHtg7x0Lv1EjNEVStLBtM
	 H1RRygy7aq6oP7rG7jrTpVhgSn20R4x/3SGQx7xpTmXgXcDlIHat5bcabD6hH8odp2x3c
	 TBDu+UCV8WZ7GcXxSp/aDInir6ExFK4Bm7GQzVA9C7LKOPDzO3mqDZHfNm02WI8ONcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083158;
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
	bh=N+sVjl1B7WBAFONYrsSGC0ci/jc7zkr5l+1gzz5AYDQ=;
	b=StJdIIMHuApeQxDdCEw7B+elcdTkAsMymwY7YlhyhPmKH+dyLDqthxzQO1fTB8sD/AEL
	 wqdrND5jHlKOj30PQFeUIkYfIErMrYOnW71Iu9wForO8qFsmuzMnQDn8GiEpAFJccfMT1
	 P5GcHjRn0OicFMs77O1g+JjIkySK6eOb4KGs1WGN+77ztG+Mni81bwXm23yxTBk/MhUjX
	 c/pcgGvryHUeNpcSDAYLcUIexoZKotbWyP54oEH9Dyw/y4bP9fIcxZ6mQAo4bbbGDF/kc
	 C3xUQyybZS2rb4HrSJV9U1Ew4k/hT35Bpc4PQIVHA18zpFIWV8CW0HhbjkO6qGtKvOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eI88T9C0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.58
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D4606A32C
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 10:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164D4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eI88T9C0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzM0qDLiYMOoaZR7PZfDYPlq70I6tTfwPIGkFKkYtRmy0P8965oqPjg7AI3Gc1EtWLHs4AeQrbCy9rdvq18Rt4D8i28OEsno1LhCHOzSoRcUGN0JwxqK+6j8STVMMcgQwDprmxxvBmwzJu5a5TD6Wklq3JX7sdPBloDdlR3b1hc4tu0oIHvHomctbHiqVBZI1OVXF2wTwbRfOYY9tmh+dRqm782zL0tuqnB1roAZW5iZl5frF/6wJ/7jl7/XqFBBSKYiGA1lZaM83z5iENoCThSbC8Sr/2JX77Ugj0d3zD4OIOW8I2HqkwPfFikp89BuC6dF+18tjoxRAMiXJYyVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+sVjl1B7WBAFONYrsSGC0ci/jc7zkr5l+1gzz5AYDQ=;
 b=Y7xBXuP7njYLXJcvXm+py10+bMKh0cN4YSZE1gjCoymAJKDw5wb+yy83mdTOvA6iR5JwlFnpd6H+SlwmrWiW0xeJ+OLs51qzX205TLdgttU5rG37twvOhQJkDj85hgBtTSyTl80CHi77IsS8hRv8x5hH1um+TLa98n4sEkORHXjgpwQRxiDAShoqKwNTAz5FVvTm5Xair/6FpGtW7oWAISZHGF3UMLIfw1qIL8X5UJeVSKJOS1vTLYPb5eU9klYgwHQgHAoNPs+bxI5WzoZGlBnQdtMFZXrN037t1ZJM2Feoss/bv9Yvh+ObUpQ0oK4x+Og8T8WPKMVVtK91XDdsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+sVjl1B7WBAFONYrsSGC0ci/jc7zkr5l+1gzz5AYDQ=;
 b=eI88T9C0zazBGQjW7QPhCQAKyerfoU7R+T1MvTzIm5eMWW/kkbRtUV21ISFNiiKh5YCkNeFcv+GXKIO5cEW+fY3KgnWEPfaEaMo9TWntLIEp1Fcfpy9jfzGFp0GB2eLXp7zx/YHMLwmelmimMpf0XgGLk2l3z/SIobT+E6ImqBDu3Y4+w9IpOqKT5KbtNviSnt7RzM8eAIZwdLkRNtfOPrSCaPYg4OZQb7lCQdOLInP8jncbr/bTo1b07TXnVTHvhHDu4kYxP/9d2fknt5BKXz8NQBk3aiZPxuehnfmtdfxZDA1NRw+wZzaLTArH1FJYJGqsv3kjaw3bWpc0+ipwtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12)
 by AM7PR04MB6888.eurprd04.prod.outlook.com (2603:10a6:20b:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 10:12:33 +0000
Received: from AM0PR04MB5876.eurprd04.prod.outlook.com
 ([fe80::6e6a:39dd:1985:8e31]) by AM0PR04MB5876.eurprd04.prod.outlook.com
 ([fe80::6e6a:39dd:1985:8e31%6]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 10:12:33 +0000
From: carlos.song@oss.nxp.com
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	mkl@pengutronix.de
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH] spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits
Date: Thu, 19 Nov 2026 18:15:39 +0800
Message-ID: <20261119101539.2536367-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_|AM7PR04MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 0642dfc3-09a9-418e-818e-08df4625a061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|23010399003|1800799024|18002099003|6133799003|261009223027099003|261009221227099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/Wd0I99StvYngaKz/uUXuj89v10pMQmIg8a9Q+WSXx+B9KlGwt+p/1mbNfxT8sUk0DVVKacZITTn0vX08KVVxZMRLFpqzIWA9eftR6eycxMdjPoQtIqCU6ksWjSnu+OpUnqTpR7Lws2JKtulfOeUB8gdGSGZgE6aIAayMqEHTBpZOcf4bc0RjZFiLWlCvZhn1vNiSwkPtm7FH8ZaGD8OgfDNZy8x8T4RoyTzJCjhebw7QiWxT7fvbHEJ9IvIrzVVFp5CdbOqMciI5g311WyGgQPs0eLR2QDyvVyjbpxlxjcIc3mXhHHZHzUf0EvU9Sfb/R2ESFLtR8R7VynHRf+GuLAuXeY1S/tmvjg9qz4Gxdq4DYSPE5MybBa2K9KEPBzOJay2RT1Tm3ZsWZGt5Qnyk4dsVsdBH9HhymCExvSxjoFcFdZJfsrUH7dItLcT/Dqwb0Mh7fDc5w1siwmpD5IK6ckE/3Pj9JCWM6TS1Ol1G/Nf1cygxNaDLxZpbpR7ViW2tNGkjMpBj1BhbP226VQbKRps/IPKB6+LqBf2A2kj5iQ4/yIlf82NipNqVcOXso5f/IAeK3plKIJywMcTu0uDX3VtT3xJjRiAp7o9pnXsRso2K2825vN0KfTi4GyNITuyWNk8Jtrar03MXAWZSzDqsw3kc5MGFMByFuuyZ4i+pbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5876.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(23010399003)(1800799024)(18002099003)(6133799003)(261009223027099003)(261009221227099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnRCkrDL33ymUkYy9IYBZUvatvTSCSKO9H7uKw1L3VHp8hoi8q74lCKVdmFu?=
 =?us-ascii?Q?xTuDtqjh5ygUUXAWQy/0QPdVHeE162p64RtxALd5+6U/93QcVlBo5RFbSlgB?=
 =?us-ascii?Q?/ioJqZRRJuDeq++Je4X2nnZLUTHvK5vO3k1hVD3t+qGgfUH2bSwsX50GERJ/?=
 =?us-ascii?Q?+duQbr1r/3AnRMStBUi2KZWvb5pMDlWmW4MHqNJrcmcnikycNCpTEEsLP6Aq?=
 =?us-ascii?Q?Uv9clq5YHslmWcsKpQ/iJSSWQzb2Ad7M1EeKSjrWCB0/hs+BnY/Qxj+JhQ0+?=
 =?us-ascii?Q?FA3U2GUEPTrol/0lJz2leJitVzA3CsOuwg76/Y8Gs1201/tflaDWX0cqEFXu?=
 =?us-ascii?Q?KYXbknCfgV8jqiAka70A+QwXPjaya4tFcGXxLcPqGXDw2ppIojb2wmPj2uUF?=
 =?us-ascii?Q?5QUSlLWUtr+w3zDAgEsDE/iQxQSxl1uTvkUUx/jZ11Djd9kcCK++rBjymx8k?=
 =?us-ascii?Q?riSdLgCKBawYayJC7cSbg/tYctcqQjApN3Y43revSbbqs5oHYXZTEYiJeBuF?=
 =?us-ascii?Q?dB5LmAfG9KtDTjET/OLY4d452Iw1qlM/jHCX8cQyUXwObs08hBnu/I+yWFGm?=
 =?us-ascii?Q?Za5CPmB/JxqT4oJbOQrCmJgZlaXnhI6jky0Z+HvV7UhbDcyYE7UCzjq1QcfH?=
 =?us-ascii?Q?XYT6maoZW80ZoVQ4Ubh3/ssvLHjtzjHEaHODwQ/6WHf1tGUxTSYMQupFWG4q?=
 =?us-ascii?Q?+3YbGJ4QHt8RTD66oRzmSE2mXR11C95IlcCNDxGRg3E1I0FIfUJ2+DhTJLSJ?=
 =?us-ascii?Q?VA2hPBDqUyGzCWcYyFSxh+I/uY1AaCHsLxKpnQTZ16YuYtvAosUsaugvWCP7?=
 =?us-ascii?Q?s6dyfFr31mSslpElphqgBBz/nN979zppfcC+/LXvfb6ggzRF28N6p+HhnhxC?=
 =?us-ascii?Q?td/rWw2SfP+cO4BnevZEAyKYI46cOINGjYRTQiBU7bKBkWP97NN8A8ujqjzY?=
 =?us-ascii?Q?fz9hkIwF4/BDxymTKlyd0RQouctK3cCCKQ7oHdqpL+4iFwfdqFN57ZKyxvhx?=
 =?us-ascii?Q?RtezwuUtzCE+alTYwUUahBnPuHGSPd/aq7Fk3xcHMiyE2UULHYGNAjQalNRO?=
 =?us-ascii?Q?CP6Pukk12uEDL67HO++QZ7R/0hNQIO4PeM4pXOl4BzhOKXPsx323hlp4q/fv?=
 =?us-ascii?Q?LgCA1JAwBgM5HBNrIkr2IN27kVgdS9CMdm5ouNtcuHE81BKqMZlt3+UH5dC2?=
 =?us-ascii?Q?a9pe6rGrzYegIHyjdztQvETpRW9Ks49lZ5xzSt6DSNkwNOSZdZoyZFSwBCa+?=
 =?us-ascii?Q?YBkQRwKwaf1UTC6H+G7fxacPx+pHXFHQzdDvQmCnIcyXqb/8CkFLlgJjeuGX?=
 =?us-ascii?Q?H3+U/JFIij5TgOT4WwWPdOY1ObO7i8LrEXm3yXc4z1gCZgLJPC3nzkCGfqQR?=
 =?us-ascii?Q?TPpEtUp95fF1s8d2wmdnmVWtNnGEUpu1cZ5A73YtHfC9PZBVrkmUz9O3MXgX?=
 =?us-ascii?Q?W3zTNH4NPtREl9As3Vx4JIGzCBLlrywT8rdin9SMX7zaNoT2cSRpkwYPHkjG?=
 =?us-ascii?Q?VKDIVoE/P7RuVo3epq3k6RUrvHL5F0EOtMCeKj3D4eLTOXd6LLsNLBX5aMxK?=
 =?us-ascii?Q?Q/bJ7PPQbcwtRFhksBBc62ljegZ9DlTq1T9ZZUOeU1IsNJzceVIQJ3aXVLUl?=
 =?us-ascii?Q?rSsAju+ZpdbKBHhwArKii9B2Qp6Qi59N19g4628zqppPV27eGcW5HZVpKEIx?=
 =?us-ascii?Q?cibuSuWnPLMm2xvWS10mrotVY634H39NHGw053v8fDOxKRYIUlz/uItzo1St?=
 =?us-ascii?Q?yqYsfGPvjW2hNZqydVlYuplh9x9SE/MunfMybWIW2A4OK9aV2tVp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0642dfc3-09a9-418e-818e-08df4625a061
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5876.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:12:33.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKCrv4mbbRGvallM43NkCf9zuetwUgw8MMXATujVxUD2aqvcS7ajW/KKP4bgnVp/SVCSr7LHImPu7e97tw3ztgwHrpZE0vInMlCq0VPIvQVJKyaAI5bdaCxP/LCmy6X7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6888

From: Carlos Song <carlos.song@nxp.com>

The original FCR[TWATER|RXWATER] fields were defined as 3-bit values,
limiting the FIFO watermark to values 0-7. This is sufficient for LPSPI
instances with 8-word FIFOs (like i.MX93) where watermark = FIFO_SIZE/2.

However, platforms like i.MX95 feature 16-word FIFOs requiring watermark
values up to 8, which exceeds the 3-bit field capacity. Expands both
TXWATER and RXWATER fields from 3 bits to 4 bits to support larger FIFO
configurations across various IMX platforms while maintaining backward
compatibility with existing 8-word FIFO implementations.

Fixes: 732b903ea3e2 ("spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control register")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b25f94b2ef738..cea72d0340357 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -75,8 +75,8 @@
 #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
-#define FCR_RXWATER	GENMASK(18, 16)
-#define FCR_TXWATER	GENMASK(2, 0)
+#define FCR_RXWATER	GENMASK(19, 16)
+#define FCR_TXWATER	GENMASK(3, 0)
 #define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
-- 
2.43.0

