Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0A35E1BF;
	Wed, 22 Jul 2026 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757670; cv=fail; b=Rcl/Rtvvl3wdiraH859RO+ePrB9XfeK1hf7Y70oODCBcFxNiKENkaEO37ld7a6Alop9clbU4JV1Wn5Y1Y7OZRd9q7/vbF7F+grjepfxkmm8ONHSxyXqh+sqwtJChf5+lMxoje/zt38YRN7KKSRo35dZ1ztSLh66i4p9V1ZaWkGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757670; c=relaxed/simple;
	bh=elROp9V0DiULEEdOsdSyB2XnxZY5p812IliXFhFeI9I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ji8EXQn2VgJjq0D6m4/bDnF7mhS6+GHek5IQxmVR8UzNbeqhnuqONpemPzXQNOZG5h7pcoh7D6WS43u4at32Xc6Y22XBFCZ24sQcIIQkKqfZkJN8hq3wwlpHxpsRBqRLgbVLPHtpF2850+IV1w9FrxSq1E8JbAKVzm60ddN9jCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gWK5XNGX; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gWK5XNGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpUwx4/dSSR08m0SFo3Kkq3GfglgZY9ehX2KAEQGdQWkUfGe/f5MMxm2ABO2j6phB1QsVZaTfrYfATJbAAMdiocUU3O7Y78Azj9rj7Ec9TXIo/4QaQTOf4NGRhmsT/hdAsV56J1KgB5nYFaxUPZH6KdjraaW1mnfKxs+8v/UOCV5mdRd9VcGc8hXM3Vk6c9rDJE41fzLJQUJQ2P232zh6qyjM4J5oBs+1UWJ+BBWM1WVl7PzeOgCZroTxpoj+lsAjzyiljKT4mC8GoZUN3b7Oovov8kKpI4BCDMhdHg8562O1NABxdfAoXHmm76680A/NNCo2q9f5zqa+GtbofASpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VliVplz83szFe8xfrwhusYXlxPRF2FZ3ziJslIKnVU=;
 b=vzLif2d50HFeXyHpzp24syvYGnV7Ha1R0xP/TacglFUb34S+IbNrp9/jlt1t0JFemopzr38Dkz2fF6yx0AoHTp7r7yJTl/rNazpq9iWPrZnbhIbyxloJ/Jz+viG+1oJlFblEfeT3XlqP9HMo+gdibStGLI1f8PQTpXAthsomzqtGQiUtdkC/9+ks46wOb3yk/FA8buF4ry1J6YdjKzymT85tB8aZs0vobRzRnUdUmwxqRb9pgMgUIpztzakxpvnULMVKJiyu8t/A7ZQQb3io5Dy8iTpcECXqprahlX37CF6vbDexX+xHMJOxT+nuljN5lY7MKpto8E0hHtsOpbBmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VliVplz83szFe8xfrwhusYXlxPRF2FZ3ziJslIKnVU=;
 b=gWK5XNGXxMwBtuh7syEznykbx27stRbNBLRcfX+FM4UQKyVKihE3jUtTa7q+9IsIOjumwZjn79cZOo4cDUf5RTdwHb/1ZFKwj3oPQ0XKRf0RUyQ/VMdM1zGUzittYruwazpqF/L9wxj64iWYelRnUo4p7CHEdSGLDoslANORLFtPMAi/jw18YFn+a5FTtFE/9OgMGDMj04f65xq2vCIZYi69tyD/BqLndvzTqiAkEjliWjQA4slTbzSTzT+hEvlO8oqv83Ale2V5dc3Xq5a7ZU176YSlPVtpO85y/1k3/FyEmtJOcMMesuQrFd/H+9MhmIUMzaRRLy7c5tP02Tc4FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by AMBPR04MB11809.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 22:01:02 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 22:01:02 +0000
From: han.xu@oss.nxp.com
Date: Wed, 22 Jul 2026 17:00:42 -0500
Subject: [PATCH v3 1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA
 properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-xspi_dma_upstream-v3-1-6b7ff50cae8e@nxp.com>
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
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784757654; l=986;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=MCiFiAilyAzkGuxQ+rkCaGPOy72ZAtH49wa5fbKHe0w=;
 b=PS24wtQq79UbQDpVK9t5jQMTqtx9WioP/v0HaFqJi7SGBEKy2uWyFjcEc5YocMxzt06bwZQGq
 apf8JDpSDuBAgooAVKrhlRGiTUYK4eOUxxgGfV+R89cqeN/59/74h9d
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|AMBPR04MB11809:EE_
X-MS-Office365-Filtering-Correlation-Id: bb781c84-581e-46dd-824a-08dee83cb856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|19092799006|376014|7416014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7xySC8RawKb68eru3WkhFdIiGxzeJZEyoEbs6srg79kGoIMRmcqUnkHQiYOjp640PFPYYq5fqGHGmBLRBQ01fj2IrnPcEBS0NOWtq2wHIvTMN9iIBepZKoxu2cfjgooqf5Qxdi5Uo4iBglzh5yngYhxVTolGGu3IK9GHLvvm5nt93yMsGUCIaAhw5zNQ0FuQ+nmLLxSaFP1dfV40iIT9X4O4VnRO6W5lmHLV7uUkA4AVyLficHFbgobREpl6P9fYrhFOqkGGWOSHhb3OH8M4yEPSnqFAJhhfGTRHurvzpT6/Pz8K0lWqyQLjpqqVVMsgTqt8m7VCaAeQROu9CSdcd0jU8cpF6E+n5khEv6yd1c505etRaPKOo9BIGZjlWBb/l8QYQGsBogUn1fdMmgtHIbhR6YU84LGWasU8u/iTAqpFRRxexYY6girHPYfPTOGYRtA/mJ6xLrxLKTVKRZR4lYzEbgDe2catYwI5fbVhWR4KhV/MuKUXSvuaQUePOQqtwzt5gybEEQOnB+nRNqkw1MfEJgIkj0wqtYVpSgLu+sOFQc8T95eEWTieKEwQqYR0NL4osxHfHfK7C+EcCC7YCerpZAWR6WOxv6w2Q7C1u5knIr/4SlCWTwfNLYpV7/+Ll7DmC2DKn10ASZrfZmBHszyG2exRPjfBDkyB1SJBPg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(7416014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDBMRkV6aXdXOEdscENYeDVpN1ZrSnRkWk9oYUVaWURmMUJ1Z3JmcGcybDdH?=
 =?utf-8?B?MlBVWDBRZVNQak5SMUcwdy8zZUN4a3VRcFFHS0t1RG5QSjFMVU5JNVl4aG0z?=
 =?utf-8?B?emdXeDM0dCtLL2p1S1dZeVJ1bENmZmptQ2gxdVphNTl3a2QxQ3NndWhNeWt0?=
 =?utf-8?B?TEMwSGI3eWVoTitjci93d0lkS2JNN1hEd24zUk1yTDBsR2Rib1Fhc0d2MnJP?=
 =?utf-8?B?bmxTeEliN2d5NDgrVXNKejJZSm5OM0kzeGZFc1RPZDgvdkdqWm1oSDRkejVu?=
 =?utf-8?B?S09tam1WZnlzM25DYmNFZU9wVlFYZGwrQUNOdDNncUluT1hJc0JtN011Z01U?=
 =?utf-8?B?SWQzSEFOUHpGQ0pCWFpERitQeW9XMnh4M0FxeEdqYmlsck9vTy9nNU5Lcmoy?=
 =?utf-8?B?VHhwSUlUY2k0TWpacUNVcUkxQ2ZPYW5nZkRmZENPTDIyM0pzc000OXlUYStS?=
 =?utf-8?B?MU45RUNJL055aFMxR3lQZGIvcFNna1I5SUpsZnZ4ZjZhOGxsUTJFYlhYSXRY?=
 =?utf-8?B?dVZWN1NrVlowWk1LWDdRZFZYbUt5d0I3WUVFaWM3eHNxUjQvOXowbU5QY0Zq?=
 =?utf-8?B?T005dW01dGNsYzhQY3pWTmlLYTgxVGJvanBqWnRnSkxZdm5xV2IxRUVPTGRz?=
 =?utf-8?B?UU8zTG82Sy9vM3R3Z3lnU1J4Y1Q5dXZTRHFDbVZ1QWNxMGJjTEFmblQ2bzJZ?=
 =?utf-8?B?V051V0hKVTFQRXRWN2EzMTBMWVVHYVk4amIyNDZqNU1McG81bmtOR1hWZmJP?=
 =?utf-8?B?ZFN0M0Q1Q3JaMzkxQ1JmVXd5cUVoRURZZWw5eW5XV0NicVpGRmtyNWxXQnY4?=
 =?utf-8?B?UWlBS1ZMZG5LYklwRExNcWU1WkhQVDJxM0prLzR2b0drQ3JKWjN6YU93Y0tl?=
 =?utf-8?B?am9US3pVMnNNTnBReGlEenRWWmthZFBGdE5HQmI4NE9UekNJYTdrb3cwY2ZQ?=
 =?utf-8?B?VitBeGY0cUNERFJJY3ZtWVUrSm1PVVJlTGQ3K1NodlVaZk5YQTAvcVhwY0VZ?=
 =?utf-8?B?VlNyOTZCdE4wWWY2ZnZ6Zng2OUlMcDdYUEE3N2UzRTIzQjlzckVNUURLOHJC?=
 =?utf-8?B?VzQ2YWlCRzFrLzYrOEFXQTdYdlluMVdDci80YWtkRkJ6MDVwOUgydjA5SWhw?=
 =?utf-8?B?VW14Yll5Ukg2VGJNQzAzcUxydXc4VUkyUWMyM3B4K2g2bE5jN2d4MG9jTStt?=
 =?utf-8?B?RUVpd3paTk5KVHVpSndrVWhnVXQ4NlZzVHp3L0NkSmtzTnVoa2xTSUQvYmY2?=
 =?utf-8?B?ckZtWTE1TXNtU0xUT1dzYWxEa3MvTHlqZmxkNUlYTFdXYUVRZi9aejRtb05R?=
 =?utf-8?B?V1RKMGYrdFJUdGFhc0NIY05zYkR5UWhjQzFJWDJsL2hLdThPeU04bGlDY3pE?=
 =?utf-8?B?MmFTRDE3MzJYMk5pZjRvOTNHVGZNVE90UzdCU1RCV1ZIT0I1aklyRElTeG5J?=
 =?utf-8?B?Z3JiZDV3N0RVektRVTBPL0MxYzBDYVNFWEtKdXo0eEpZa0IycWNLSlUvSGlJ?=
 =?utf-8?B?QWtrTDNFS1QrTUdxSU5PTHNXd2NaN0VBSUd1eTBUM0c5cmZtVHE4TENGUGN6?=
 =?utf-8?B?NjcyOU9FM1FaVFhDTXAxc1VVcnZsbWxBbDFWRmgzQ0RVL1VGYXNGK0xGN2VJ?=
 =?utf-8?B?SWR5RFdZanFpTHA2bDFQcGRKR2tNdG8rM1BPd2pHRnNQQkpZVzFWcCtTYm9Q?=
 =?utf-8?B?clloZXhOQjg1bGxpOWE5VGRyK29sM1ZHVERTZW5iYmQrQUVqNkVZbkRNUTZn?=
 =?utf-8?B?S0UzbExhamRvbmlEdUh6LzgzSUtqOXJWaFRFSFFQNHRPMnhZbjdMM28wOEo3?=
 =?utf-8?B?U2kyZE1oSjVVc01rUTJOSFY0TitwMFZkQnYrd1Ryelk1ZG9NTDFDZU9YVTJp?=
 =?utf-8?B?TytNM0IwTjZFZ0pYQTNjRVdLWkpIazlZS2hDejBYMHg2WFZNek9oSHhsa2Jt?=
 =?utf-8?B?UC8xUjZicmVEV3ZoMWRncGVYRERZZjBGMVRVWU40NjJvb0hWbUlhcDZNc01T?=
 =?utf-8?B?aklGMlJCNFR6aFhwOG1kVEdVWUJnYVhocERoRHQ1b1pJRkF6aGZzcU8yelJF?=
 =?utf-8?B?SERJVXd1aFpwTU9Id3VkS0ZrekxQazVrZEZTdzJvVkVnMVpVUy9xTjNDTFdB?=
 =?utf-8?B?RDhGM2FKZkU4WnI2TU9CSWI2WFREajVvdTRnUDl0Mlpxc25veG1QYUtRVU9r?=
 =?utf-8?B?b0VBOGVveHVuYUZGN3VpMlNlWHpNTldYWGRjQnBwMmVDSnEvTmZPYjEraGxE?=
 =?utf-8?B?ZmlCSE9kSkRLbjNSWnhWWXJFb2p3L2YyWmdXWjZxcU5DNUFuMzNaN0tzbzA4?=
 =?utf-8?B?RVlSK2toS0ZPWXhueldYZTJ5SXZTRFZoTVdRK3VGS3FrTS9nK01ST2hKMzlt?=
 =?utf-8?Q?rvOexITXCgowuRyk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb781c84-581e-46dd-824a-08dee83cb856
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 22:01:02.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 595M+guS98zCFpwHbBE305QBRwHVgOvo64He0B6Ju97ARCHcosR2J+nBW5LH/h3/brC3vhpWk2FjTf/kCasUGq9usAvzULlc8CCGNbgl7Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11809

From: Han Xu <han.xu@nxp.com>

Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
XSPI controller.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

