Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00496441636;
	Wed, 22 Jul 2026 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757678; cv=fail; b=mA6zpPcU0+FoolpFFmuTdI9uAp7do6Xvn5ZM4pmw8epT5nx7WzDZtZr7veN97TTZ/0WO1IVyb5lo8U83LhK+KAjYinDAMp5mQ+dZ13N2Z8zYGG1IofChHsN+OhHgmMZ1ilQkMyNJq9HBX343TRyiNJE+J3vaihf3/aD6bKDyXQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757678; c=relaxed/simple;
	bh=qC2MuxbiwI1dazDchoGku4cXFfmM9o6MbUMycaGk5mQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HwWPfNb/HCUEkqi+tJSvAU8G4jcqDj7pq2U6/KSUUnS4SYNg9ugpPJq6h0ZwBG+6seDGsno5gngy0WC74q8VS6KzyHSp2gagWX6qB83wPTd8qSBLe8AVF+GIuW6n1pzVWQrq6h3Ky6bT8H48DNzR9QQYs8HDydZiOKPck2GRrD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F1Iw/MT1; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F1Iw/MT1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5PetWt7oc3mG+pZTiEvsWS9nBoEC6x0OmnAtpSqyDkoEZ1Q5LLWv54uxLQPgKY0tlmvB7W+e4cJGdzAxqc1vwHRp+YpsgryjMzeZS2IzvIBZkkgU/QegK/0/bcUOHzjCJ7rQKWIWBch9JzDpcopc7m3pXkdfTHIGpQruorGn8kC8oaxWF2doTVpk4v2v5xLLSHlITOUDEpjTqixgK6HDXla1UcOtz4km5FREnH3qSLRxy/kk2n45Z+Fcqh6PiRXRu5GCPRoohofmr5Ko4PFXooJkXpPoE1XKi8EX+HiO1anmq2ipqclGiRAV8QLkPH86KDSrFrvwvKUVJ45IJtiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpvPCPfsVrrM81pvHxdFj3wlD026RLV+ioUWciRQEDU=;
 b=lRtcfTta5d5wKQhRh58yMeRRQOnyoPFy2Fp+7YmoaGnvYL7sXEahZ3kQwihQdPZs1TPPGWyXNW6qSnbgqYOTvGlfTaqYWUGlsD3tAet8OEjhIKDL0Z+2o+2R2VRhSKg+S0hA4gsv4WEr/tdW918p8pp0W9VZt95JAqLdM3nBMg2zExs8qnHV3pzpiQpNJUYpk4q2H4lrEjQ7prbu0jlKtp5L8uBRGqGfTeQptO+dt0D9kTgTCga+1iQkuGTQY68ShHyHfykIZbD7tGfiggXZAa+zzzETOTqy14Ts79iApMNop0lIjpX6aA25gaWZDtr6rqOrMlsqNjVLoBfamy867g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpvPCPfsVrrM81pvHxdFj3wlD026RLV+ioUWciRQEDU=;
 b=F1Iw/MT1/qCGncAmo2O6hmiPLsaAcwTXTuSu3/ZB2m+I0T+GO8Vi4qG0d7LA8eNQPjPZl1nsD+he0jLhHelENm82TWsngybL1M5yv8Ixi48N3Kle/FGUuno2zndCyRy+ceRzQBWMvTGpH9VkY34+mWVPjlKccZ+cmloZLVPaJmFwkZuh+1Zm5Bn/A6GqlWItDYVll8ToHcLZNrHUrt6LtFyUSJyR8cn+vK2mnT4SM3vnJ+m3Cu5gbxTR29DLl832ppKCVsvGnPM0+HGNV2uug19Y6BdZVpVtDeEvew9kaDf1gov+eSWgaKONF5/3/jBLJyDmYfX6Q6fVhdlE7H+RzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by AMBPR04MB11809.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:01:10 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:01:10 +0000
From: han.xu@oss.nxp.com
Date: Wed, 22 Jul 2026 17:00:44 -0500
Subject: [PATCH v3 3/3] arm64: dts: imx94-xspi: add the DMA channels
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-xspi_dma_upstream-v3-3-6b7ff50cae8e@nxp.com>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
In-Reply-To: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784757654; l=968;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=DIvYzVJJ+Z7BGus1NDjEgVrT7HPmIigSFr3cNQeP53o=;
 b=PY2WZPRTkcLXciZnAVduNEhhTia2TDOT2tBEAW13cyjeR+3BvCGDJholI7kNgWzrOo+341/at
 8r6068Fx7LaAdjg88erz/mtXu3UAtcMe1HYbpx69s6YmSJeZjA/wQ5C
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|AMBPR04MB11809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7869abe6-43d7-4f04-f474-08dee83cbd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|7416014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lcU02yv0zXTX7rz6b5tIJclOK/cjtt2C6h8c9p+k/62yXPXn+/NqihZjaN6+uyZyRnOxczE/4BhQfKN0Y7F1s4mGmB+Stmxl2JX9ltBlduiaIufv7c0FHZPzut9qKSeO1MOkmzoU5NfHBvNRm3gaYbZIMbLN5ftNAWnLjrhGjyKCVP+kB9nv1HIuSdvQLiQfzQIic3w+nS8QP6Ik6ujo070zmHxTq+OnyJWB7uHrRimTpKfIjezjjNaV2W9Lp3YdAIOeGZB6UJgD3yq60sW9nEwQ5DDZuXVX3nM759c54m6xwial3KO30MTvaJxRJF+KSpHuP1f9rZJ4BoGuaCGkoMNwZcGkdquVnElZ7ZR6zy5Q4eznIqKj9b+KZKmXh6yd8nQMh6D9AAFURgBMlCqtdNqqLEVardoSlrfFarpRCGLlIgRDonmKTqWnW3ixnaaaP4mYO/PYraLiEuuSVOp41r1zIPfiVZpRVGpybchyrRP5ozAM1kVAVfpsrPk4K+oP594AwU5k9RRm64JRqO2fXtKRIhLt3tpMzh30eDRiH8xPLqW+FcH2ZQ1ONrLuovbMRdpMrrLznpgstRfWuywPeN1kkh2XGwFeZll9wQU46lBe88z76AkYQtp/bR+ueS3ROI7b+mZfwxyTbWOqICM7eiDSysOceRCArVofYAdcJMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(7416014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhiREhTNjh3RmgxZFdwWmR5VEVYSXJYbGhNcWplYmhQU1V1OTBObGlhY1pk?=
 =?utf-8?B?SkpsclgzNkM2NGM0V2Q0WWNEMGYwRzZoSEtpVVZxUnV6ZUt1YTdyZjFDRTNC?=
 =?utf-8?B?Q1RxcG5DZDZDeTYvUGtNaGpMRGUwU0ttTFFmakJvODJNWEtqSjYrSExFbUVH?=
 =?utf-8?B?ZWJYT3NUdmFBd1dzOGs5S0E3TEZha1VPUlBHTk5jb3cvKzZHQTYrVEl2UUU3?=
 =?utf-8?B?SnM0Z3BtSFVxVGdEd3hQVDlwelh1TWkyek9UcmNMK01ldW15VHZKOTYwd1Vk?=
 =?utf-8?B?Zi9zcGgwSXVhUm9ieG9xYVF0VU1xMTNJV1docFVtNFVIRi9vMktSMHVlNFNX?=
 =?utf-8?B?c3NpdGxFZzlSZ252WkNhUGhtL2V0N0xVTlQwb0ttRXltTEt6bGszNFFqQnFr?=
 =?utf-8?B?L0ttSkJ5MmdYZ2RDZ1Nxb0o3Tkh5N2piUW1XbzRtaGN1V08wc0wwaXR6ZDNU?=
 =?utf-8?B?MlJ1RTJxaG9sTXJCamtnL2xrcmszeU9aMS83QU1oeEpLNHZDajEwNXl1djJm?=
 =?utf-8?B?VkZzbTFvZkFhSnhoUUlhaGdqRmJFRkk2VGVQampDQisrdUw0L2dHWFpFK1R1?=
 =?utf-8?B?bUpLNmlrSjVPbmdjVWMwZnpCTGdBWGZ3ZFRTeXZTOWRSMnJQK1pleEtoVGVH?=
 =?utf-8?B?a3ZjdG1oTElVbVBuQy8rV1N0eDhleHFSOExDcndvRXk2YTJsb1pVS3NvZTFN?=
 =?utf-8?B?QmlYVGRXYWlYREN2RnFhTkRCZDNYS2x4azVuRUd3aEZ6dXdQVkV6WFoxSlVn?=
 =?utf-8?B?NDFFejNGcUZ2UTB2eHUxNkowU3NzTzQ2NDFJTExDaTlIeUlFd1JZUWNhVnQ1?=
 =?utf-8?B?c0ZCZnAraEJZbUF4dWI2TVJ4R2hOT1pFNDlYYVVCRUYrNUp2KzN4Vy9GRVo1?=
 =?utf-8?B?VU9NYlVyVGM2MlUyZUJrYmV3enJaQUlaMVJiYWZDUXBBaUV6NXkxcXFtZzZ1?=
 =?utf-8?B?ck1PckZsWkdsa0VKdDRXdVRZYkl2UmxweU9jU2xxcUpZTm5vY3IrMEo2aGto?=
 =?utf-8?B?c0JTUTVQYmxLRWVVcWU1dmhFb05JclBrSXQxSVh2b3JuRGJsd04zNFVZcThx?=
 =?utf-8?B?elZDTEYvNXVKUW83K1dvb24wS1JzeDlJb3ZwdmdsZmxzSE1uYlZIZjhZTU9r?=
 =?utf-8?B?VWRFcis4R2FWanJJWXpyMk40M2VEalY3WVVMdStvQkM0QVlLbFgraFUwMDVh?=
 =?utf-8?B?dzYrYmQ0cGlYZ0RjSEpjUjZzTHozT3N6bWFkVnVNZkVKTGQzbWs2S3VPTGlG?=
 =?utf-8?B?QWNFb0FNMHVsT2Z5NEYxcWlaTGRFZGlaWkgvcjFJbDBXYTkzalc0UnhocUgz?=
 =?utf-8?B?VXdnUmlhMjhYOFRrVjFFbmtnRXpnZ3NlNWh3QU9JUTRHNjFqQ0VsUEFQQmRU?=
 =?utf-8?B?Y2NQZTJ4UTlram9LQ3BFQ1lVdHlqK2N2aDdocVlBdy9kanBtR3JFYWhaRkZu?=
 =?utf-8?B?WEV4RnkwYjJoR1NzcjNBQWhZOHFEMGJ0U3Vnb0FTMmlEWmc2MUduM2MzYzdF?=
 =?utf-8?B?d3I1NFM1SS9Ba1o2bzRyZDRZV09ud1phR0d4eW1wbGF2SHJUU2plajNjbkJq?=
 =?utf-8?B?RVdmYXdoNHo0ZDgxRERRbkV2dlhjTFNXTGVQTWduMVJVS1lsR0JvQTVwSExs?=
 =?utf-8?B?bnVqazl4UXhmNmlKbW85bHRFS00xVHBDL2txTExvOHUyTXBpaTNya3NiUVQr?=
 =?utf-8?B?SHlFelN5YkpFc1dScFZqcnErOWFNbTQxQ2lFczc0TEo0Mklnb2hoN3lnUnB2?=
 =?utf-8?B?dkU1MEJ3TDRFWjRERFNjQ2hvcWJiUUM3VW5nUGs3ME5XTk12UFRwZ1ZxVWxD?=
 =?utf-8?B?ZEEwd1FWUDRnNElQeXZlRUFNZjF6TTVVZDMyTkRDWlpLL2FUbFNrRjFiLzZv?=
 =?utf-8?B?Y2lra0Nmb203S1VlTmtsTXcvTzRSQkZneHRtbHNFL0ZXTnZvRWlmcGZIQTlm?=
 =?utf-8?B?SHYxdEh2YUhwV1h4QXdaeVNwMWNtUVMvKzh3T3RiTWFwNGxMdWVrblpLaUpP?=
 =?utf-8?B?YUUrd2hrWVJpOGx2NlRhd0NRRFNpMENhQ1BiM2ZYM2s4S0hHM05lVFMyZ05t?=
 =?utf-8?B?dVQ3dG1halNGaGZseUN1TjhraGpIcVE3QnpxMFFvNmM1SUpORGxobm01M1ds?=
 =?utf-8?B?VE9FY25MZFNEVXEvclh3dUVKdGM0ZzRkUEtaMWVRdnFRVW9lb1ZvNUU0T0la?=
 =?utf-8?B?UjgxL3lqQ1hYd2lzSmhjTEpwdDZLK1YrVHVrUnpYVlJaYW1RQmdLSFRaSkxO?=
 =?utf-8?B?UTg0VWxHR1Q1aUEwOER6U0kzS3FRTG5mVHNRZzBIMENoUG1ZZC8vMkxwZmpZ?=
 =?utf-8?B?RjM1NW1pd1Fmd1doL2ZhcHlCenh2ejV1U3B3VGtGc2d0TGFCNlVsR01wNm1Z?=
 =?utf-8?Q?P1d5sZ2E4+se+DYNomGcSGUqMz1Ru4elekqR5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7869abe6-43d7-4f04-f474-08dee83cbd67
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:01:10.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMMsrrjY5L9ZSQj1C4vy9t3VWZaENROzahRMeV6sMavmkXXJj7fp4IiB+zV4Qr9pEscsxPFzlhC2eXEr3th9a/wZ/UgdynyUT3vp2CH+gH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11809

From: Han Xu <han.xu@nxp.com>

Add the DMA channels for iMX94 XSPI controller.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index a6cb5a6e848b3..70c9dbf10fa5e 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -827,6 +827,8 @@ xspi1: spi@42b90000 {
 				#size-cells = <0>;
 				clocks = <&scmi_clk IMX94_CLK_XSPI1>;
 				clock-names = "per";
+				dmas = <&edma2 27 0 0>, <&edma2 28 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -843,6 +845,8 @@ xspi2: spi@42be0000 {
 				#size-cells = <0>;
 				clocks = <&scmi_clk IMX94_CLK_XSPI2>;
 				clock-names = "per";
+				dmas = <&edma4 42 0 0>, <&edma4 43 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};

-- 
2.34.1

