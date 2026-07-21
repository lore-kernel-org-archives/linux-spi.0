Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F494C9579;
	Tue, 21 Jul 2026 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667719; cv=fail; b=kwembIooGE64azCMbeTtkKdr4AJyoemEDvuqnRe25AYwmcgHZqBEWhBdD0ITP64rWzbOe8CU4ywtcd1Nqq3V2IExUnh/Zzh0DCIB/h6IMSz1P2i96RecWvqtvxu4ixXb0bntRHQe0lOjeHkXF9F8hWKRq7B5rA6+euJgfjoyZng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667719; c=relaxed/simple;
	bh=BKsDagey3ml7bGqM1SFlj+n1MK+q9HD1gZSXDe1fo68=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ooVJU9fmmS5RJAMiCGWg3CtBk3Ovo+4T/p9YNvVMdC4T9w5/utl1mIpddjyOmNnIpmo8Ana8Kw2eZ7CNY2iBS0Gh+Zk180HZN5ucr9XTA+sWCDuDqVktyZcHNWxQK0f+ISKMmhkamUruYSxq1xuXAOerMKupdhEObvuS3pPwg7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g7PVvdYE; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g7PVvdYE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf8HE7N6CZy6Iqgdoy2Bxs7OhUW0qZXlZNpoY6+Y742R/6TQuR+oVM9BaZZlWKeLZMi6/aFIu4J9+qYffkieRLaODmPXXrCkgUGIfChzpQDYwr/xNbUSREe8gak2l09M0FPFBlXXkMlZjywKAwB3wgwewa9reOSBCT7nCWRscPTzOP8K54fxy9ou/rfpmK0vjY+wMm+cV9uQhE6TzAb1c6rcbFxNr06gYXpxBg3BCDL1coTSm8/3OeyBlIcOWarGuBv8wrK7utRNWLPvFvBPIirgL0CmLNQjqbRlzJAhqxttfn/BGeFC7PSZmYb04JUUnuuu5slf6E1CG6qIJKw8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf5wuqw96XKwxp+Itx9rvHZL5O1QVLA7Cu8xNP6COhk=;
 b=HOsv5jD5mT/i1oBSpiRLhXvFmvFkfb+K1R1he0IFaYGdxjfNtSfI0/4ogDENKQgmruSL7oYoMGWMlxorLzML148xzUmrIgeeynC4VXqHY+NVnJ+7NbMxCKsPgJsy4WnfA0hZSJsmcpwaVAibotaZ9jvbtUaFF2ElVjjD3nejzToslzzxVcCKVIZDUa7S/3py9er3mnpNOr6YHm7zJq6XMQmxBvLlUKU07Iw3Ah30QO0SMiXRMkbTEESC1iDCsbz5Bjj+rCLtkw2+09EYAJ3mnf8X5wYWLcHGkxE9SB+PTJdYYiEuZlG6/oU/ptTc9msOhRmOrAQ2BI9ShGE3M+A7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf5wuqw96XKwxp+Itx9rvHZL5O1QVLA7Cu8xNP6COhk=;
 b=g7PVvdYEzlpyvNrmTHKkVmPmYm4BxQnHA6G7BFD0F0BijFUh7pL/6J9NEENh5t8CDYvVaqH3iJisJWOq/417US4Y7kDkmGFmf/n0FdaMmR5x8Ewumx8YN6LBtgV/JMtrliD8Bt+9rua5ukuAcpGX2YIaCNU6MYlENUpklz4t0aMtkuraqjqcFoNWMW4EA0f4uHW6Ye7KPa8UIAHTYYwQ1hnW2KJ6oTPLqCWXb3hJjr4wv7pn6EWTCr1yvHnfqF+6btdC2S0czu4ojyIhz2e0GdevoUiwIUlZUobXY4zFKd/bDK2sQbRpkhTW+eDCX88W7e7fYPqqCGfCiNWY2KV23g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 21:01:50 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:01:50 +0000
From: han.xu@oss.nxp.com
Date: Tue, 21 Jul 2026 16:01:42 -0500
Subject: [PATCH v2 1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA
 properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-xspi_dma_upstream-v2-1-9e19d80e7762@nxp.com>
References: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
In-Reply-To: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667702; l=891;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=zMbeSSO90ZzJrEAaBhl3dXvmgeOfthJCxk5he/8iGDA=;
 b=UqR+FDgRiYVIqDeCGB8TDiJBo9qk2KvpWmiWa1M8HhA97+x5pVeA6DYwdKgvti+60L0QdwaqK
 Ei9ezOv2OxRDkUocjrL3vul/6Sco8wqKGb9YoV6glA3mEJrMIcP27Rb
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN7PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:806:121::18) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6055da35-8957-4f6a-2a5c-08dee76b4911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jZLVGKqGXbbltMYzijCMlWU0nmoHnVDFfhPAbHz21/X0UxfQ+NSnWxR7QeMqoh7GJP6KOJAebliywRwUVVy5LKsmDeEFK+EeO0Ma7CecAVh96mzqZMT2KiMCGDwTE5BxbKRf2mdvEh2OACn1JDK2C8GY62gmIxMCg5bmDp+vs0ze15dcETFekghcL5yxyb+MH5iHzZhaDcks9KLwUTldE2DzVmV4D9NQrT1LNsbAh6LLzQrriDHVfCgWqKiHwa0x3PRC0MH+kvnxZg9YHwHDGBestpDLIxkRY+/tmfC+PZlgDVt4Cdp6G39ryqyuWBysycQfKw/ZlzAx5XZN2V5okttRwSd2uApY4yMF3g5XxjoQ28UOV0ZQiRaqpd+3jNeGO+jWOs31LgMNZkXntlq+SSqVehXlqgdxbI0ePlT0HvYNhcvajumgQ3GJr7A6eX0diSxBr4LtFWhOF+TuWgdAhJE3qL9G/nCZaHma1PVrY/pAQ3sBedNNEPrKTY0oxMj4WtPOZ1N5sMIpb2zVrrg6HGKj+z2CSXzxb4x2FucnF6o7KhjSm49U6RQQ5skNqfHGvs9n2Ojk9A4Vk228R4ZhqPXN3QU5VrFhtW2n1STtqF/NYc5gHUd0PaMnLQV/o74DnZ7Erh2/nWjjfB14cPmvnfBPSzMVhgPCG+pdfKaqMZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhvTzJsKzBWcXBLa3N3WkI1Z3R3bFhVTDJIblFMN09qS0oxaDA2Rmd3YTAy?=
 =?utf-8?B?WmM3eHMvOFJuSVMydXhTWHlKeWVPcDNUbDNRNjE5emVWQVpudDB6cldPNFd0?=
 =?utf-8?B?dU81NmdFUE9Semd2NDZoc2RuR1hDanhVbXhXL3J6Q2cwSWZIQmRITkY5bWRD?=
 =?utf-8?B?elZiZ1BHOGlMN1cvZUJ4MTFoaGJzN041VDYrWGx2dTNUc3BwMHBwSWN2Y01T?=
 =?utf-8?B?RWRVZldWSkNUL2sxMEhLRkt2Q012Z09KYjlJRllrdkVha3doZ1JCQjNvSm14?=
 =?utf-8?B?b2E4Z1BRV29OcVdsRmJ6dG4rcnJGOUUzOTVqL2NSQk1HNUtpR1pKTGxiNi9X?=
 =?utf-8?B?V0VJL2ptczUzdGxLODcxeU5XM0NPZzNDei9hOUJIbGcvQTNUbHgvVXJKNTJ0?=
 =?utf-8?B?MEhXWjEveHozT1dmQUt2NjRaWGN2Z1dzVjFwLzV5UjFQT05RZGk4UC9aQmJN?=
 =?utf-8?B?UlYxNnh0UVVZbGl5Vk1wMUpqQ3phT3VIaWozcHRrcDNQNjY4Nks5SHBFOUFs?=
 =?utf-8?B?Tm01STRLTHdUWXpXaVh0SnRBZ1VyMjBNelBiTmtSRnpIaEhscHB5WnREMlp2?=
 =?utf-8?B?RHhzaWUrU3pJNzJlVURlclhVeHg5aS9YbkJHdkZHdldFK1pyT2I5RnZDOWx6?=
 =?utf-8?B?blBOdEl6ZWJFRkN5TDBLRS9MQUI3VzRISldkNjFFQkJJTnlBeXhVZkRHS0kw?=
 =?utf-8?B?ZGlrNGVtc1lPcVIxQTBQb0xKNXVsNHlxVXZNK2I3MmZhRk94azcwb1VvQWVt?=
 =?utf-8?B?RXhENFpwYWliS2JwQzdnaXJDdiswcVNYNGMvdFFZQnhjU3Nvank1K3lkZ0Js?=
 =?utf-8?B?SlppYkVYdTVtRnRqYjJjNndiRUVvMTlmVzRDS1FqWjZoNlRKS0pVUE92ZFha?=
 =?utf-8?B?TWxrcTNGdUYvbzM1Unk0M1lDWUl0ek8yQ3B6ZmJZVVd3ZTdrQXVud2FnWTNM?=
 =?utf-8?B?eHk3K28reEhIYU5xYVpYK3QxcCtXRjBEUng0UXRuc1FPSSt1MDdIdHBXTmhD?=
 =?utf-8?B?ZlU4dS8xeFRlek5DV1hvYktaNmZSNHBiTGxhbUo4TUppQU93Zmw4eHNSM3NB?=
 =?utf-8?B?bDdmMUZsUStlSGZtaHFZVkNWS1ZHdmNiTUdRU3poWXBrNGZSYllpa3VZd05u?=
 =?utf-8?B?aU54WldPR0dOc09keXAyRHlFVFBvUCtFdHFObi9ic3RjUXpSbkphK1NNMVBk?=
 =?utf-8?B?QjAzVmM2TThjM2xtUlBwbUY5VWZWUzcvUHhIN1hvZ2ZxTXNzMXZLeWhjOWpi?=
 =?utf-8?B?aERLV0k1TG9ML2JhY01FL1hUVHdzWENWdnpsNG9tTS9vamRJZjQrRmk4My9O?=
 =?utf-8?B?THU3bndYK1VIUWVCN1V5SXRoNTZsR1kyc1hzRWhmc1NIeEg3ZXFNd0hkQlp3?=
 =?utf-8?B?NFhOeU5GOGR4b2JyWVY0aWU3b1JDR1N1UE00aHZoRW5ybmIxV3RxRWpwOHZm?=
 =?utf-8?B?c3BmdDRQb2paanFhK245QUFRbi9RR2o4eENoZnFkTzJJMENCTTBqSWtZR3RK?=
 =?utf-8?B?eVVQZERvTEFQUlhYa0hpYzQvTWJheTFpWnJYZlJuQWNlS0hwc0QvZ2kxQzRG?=
 =?utf-8?B?TFNTZTU1UnhNMmhYR0ZjdkpDTHpEU2VmTFppZXdHOFRWZlJXUUJqV0NrVDFB?=
 =?utf-8?B?anBtaHh5NElOeDdCU2tVcFZ3WDFSbjd3VXdUcWoweS9ORUlZMlVsbk5FcnY1?=
 =?utf-8?B?emZjUXMxbkFvSGhpeVVFL0EyaTFDejZVaHM0NTJ4Z0owekFlbytGR3VZMFRE?=
 =?utf-8?B?dTNWa1VqdlBxTjVxRE5NN2ZBOHNnWDVlV2p3RHNBd0JiTWQ5VWZoWXdSWklm?=
 =?utf-8?B?TzZIWVA5YThTeGN6d1pGM2NRQU5jN1dRZWcvcUJRWjNrNjVZQWs1amJQTFJi?=
 =?utf-8?B?Zi8xM0pqaDZtM0FmSmhOYjI1RytFbXpTS2p3L0lkNmlDMW5vRGZEcHZ6ZEwx?=
 =?utf-8?B?WVlSZjJxNG42dDRFQ0lLYW12aGc2d2pzRERHcFNQVU5MWkFUZ1ZBM2k3bVZi?=
 =?utf-8?B?cUdXN3VxL0pjR0JkYkZWU3JnaDZOT1RRR2hKbW5na0NDamM1bnN3SFVRMDA1?=
 =?utf-8?B?S1gwb0JOVGVQVmtGMm1yZmpHaU04RFRVc2FPNVl1S1F1QzAxM3ovNFQ3M2I5?=
 =?utf-8?B?YzVRdzMvOE1raUNjamY2bTB2VDlNdFNaUlQ1aU1lWjgxckYraG1vWFJPcTZD?=
 =?utf-8?B?aS9OWld0UzdwVkJGZkYwMkFUUGMvaFRmRkQzRkUwQzlCZGtScTdvdDJJakZk?=
 =?utf-8?B?YWF4aHhhaURnQzZ3Y29zdTIxK0RYTW5HMDMvSU5iOGVhQUZ1Nm5wRFRpZFJv?=
 =?utf-8?B?T21rZFZwa3ZjUllEMDN3K3F1a3A1MUVWSlVUeWY1ZDNRZjJMdjFwandJMDRK?=
 =?utf-8?Q?3iHZ8g8MxT/v+V5s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6055da35-8957-4f6a-2a5c-08dee76b4911
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:01:50.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOPwrL+M38K5Zwt3kd55VxjGwesDbgNsHlVE21M0Dhzr5c0a9fYjf2CWMcFVJ93urK8hWpXp0/a2Jys0rJLJ9ucA2/VbVEcwdZFEljVzCj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368

From: Han Xu <han.xu@nxp.com>

Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
XSPI controller.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
index 16a0598c6d033..ccf841f194c06 100644
--- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -30,6 +30,16 @@ properties:
       - const: base
       - const: mmap
 
+  dmas:
+    items:
+      - description: Transmit DMA
+      - description: Receive DMA
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   interrupts:
     items:
       - description: interrupt for EENV0

-- 
2.34.1

