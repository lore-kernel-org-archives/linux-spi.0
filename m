Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D83BE644;
	Wed, 17 Jun 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733342; cv=fail; b=WbjDAFuGtsf2+mKvZ64/CLXvtsX9s1cKxOr5/gEOsn/K/L3H3VkMus5COFZAcjBOAy/gf7w7eXYLrS8OKi3X6PxuvF5LC7ahe1TPkBhA76xfCPD72D3RbE9Uh8WgMw6XfIY95uen6DWvAwiWsQhiT9qNPbPtmc1TIHYoSklLgaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733342; c=relaxed/simple;
	bh=eylPSIVpOGsvstSsLHgrqhJXdkiJplpHcNHhnr25Z/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SuHudNnCnZWRW1+lZoOrKeCTDHIRnpO/DhHd0dABAvfRoFqWfI621pVkSe0KNWHj0W9JXlLjvfVPCVQXKSIXdm9MZzOHvqYzXy/0jr7O7TeEvF3SaD5xNdGKF0P5whA6gdZNF0jDTHoGJ32k+2q7j/k2g8/j9uuNDYEzzMn/PzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y1E8+R75; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y1E8+R75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qubxT8Ijn73xLAj032EN9QNO+FNxEGk3XhextSSK5BnWKZ+H3/pU/mFFlLAAmdGCyyochlRG8pLCZJ4//0ttbdMS4mJ0V9OCmH4dhnZVN6TAO7yKfr03QJ2y1nlVeTgpi3BIlJ5JPiJ7JoxGrF9geG/eujcvWTTzlF6jvjjWI2IzO2m8EvMhJvWoAkiueuaGxwejduyyefyoJdIEkBzUzOOUaI2pCmVhJHaAzM97I+rX9qsPE+okSbBSFI4QlaTSs63OXZ6tUtTkeBauS8sliUlTjURBnta7tAzeYte+LNSKC9VI9nJyQyFvXYhkIFxOP7g1D96DviT1V9LlVQlzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6tfTZr3ViLlARvosYEYcdRFaomgzHJo/GATtdV8G+o=;
 b=wkwPXay1RZyxkraNDDlW67qUa4QRBq8rdAozB3g99+IqAUcS2AAT+u2jshOeZYi1Mfx1FjnKM8I/D4TCnvxVifMh1LrRiTVtIKwl0VRuHvE38AkCi6KGKStLCY72RUUh7Y9WdWHAccv5j7spwOdYW0xIaah6+Vnoig25cm5QycpaO1VcHR0yBTKREnaMiTJcmk3j31KXusYhk0OjDwUR8bjHJqFKYQmAGP/87sfLmaL4qtZY72Vdn45NPI+vnlf0hCW9PDfuRmjz2og1D1WPTEK3ggt7ucx4gmVLjpmTW9WdDqAe/iM01sY9rxCq8G7aRrOOiPWczjlvP15SpGy9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6tfTZr3ViLlARvosYEYcdRFaomgzHJo/GATtdV8G+o=;
 b=Y1E8+R75+NWmHI7GiwhDKLPgJqCtttuPTFfotnqHQp0qz1hc5OTPe0zEyJ2IKD6vR8bxeSqdZJRW9otEgziDDBa44OiUlNJNfPGlJi4OutXyLAfw56m9G50CFCPviT8p2nW1a+KzHP+n8/f5k3xwJ58/0WPMUvTRy1n/P/zu01a+AUSL1Hq3X519IWqShGAVTsW7TXCrb0M72PrNAI8pp5Cqs1KxKh+n6mvPNoWkpelGEXB5Bs2u1DgFrxaNVLpfTijQubOSH0MOsIDunyKgSBGJFtrx/TvAd4MSJzn8UGXiMzEpKizKPIfIa2Qbx07eADXyDyLNA+sDsug+nry+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB7549.eurprd04.prod.outlook.com (2603:10a6:102:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 21:55:38 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 21:55:38 +0000
From: han.xu@oss.nxp.com
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: spi: nxp,imx94-xspi: add DMA properties
Date: Wed, 17 Jun 2026 16:55:19 -0500
Message-Id: <20260617215520.3327836-3-han.xu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617215520.3327836-1-han.xu@oss.nxp.com>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::21) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ae8bbe-05f7-418b-1b19-08deccbb2ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|7416014|376014|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	2pdHqKh0EfYNIU/1rLZlPhN0e73aULyvyfmPmY2ptHaAKsi9y8sHMIppEwqcLJyHWUxApuGzBYl7rPeTUQCnJg/OUkQTwjGDsdj7E9nF/59TGa6B5tMHHhsnoz0gs003PfX8qU1Fh515/Ya/8KySq0SQQ4yR/8ufXoHpbvSbWmVjQcuFjA1+1iNGW731A1X19PQsdTzelZajDfTr3BZY3T+xyxe2zmi1x8pftm3iN6EjUGo/Avzd+Wk6P1x839Grodbv8Iq0FHI5gYvcB1OvJUyZSv9wMC3h8sMAKY5rIa8ip+tP5w2O1aKb8JSKRHSoLNLW3LleeuxqTnk/yv7pQWBYx635aCf+dxpXO8w1wp0cvTWjdNDkf5433GFETXMvuY7/6dExVWD0ISRhDXLou6OJrW3NwyAu8Jv8sxe6P3PEnQRjK5JkiuIjqcTP3H5JbwFg0rQh78Xc9czMrbohBpxmk+g95Q+7hsva6kibu64kQrcFh4S28i0WQWTD+DLsPvsQ2JiNPYX3a9yPn9C54UyBwTi3VrSqqPFxW2j461z/Bfa0/1MoGsrxjwcQcYsD+dynNrczrISHa1ud/4QcIwqeJH+DKhNDXUkHIkBBR5wpk2F2PqKEIrOseeh4TJ9iQxrAERsuilnC3eHOqLpQRe6Ktg3E1wRZd3/21RrvZmlehB3tBJJ456JJImFxoAmQTQKLjmziWyvVjafNxFHl/wMmmg5x0MjMKW8jbINOiUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpSpunol43IJKYl5nyhRMTmPaLo2a6pofsJJjZcwD8RFFYy6XZ8mgcynsFAm?=
 =?us-ascii?Q?JGyi67prjhzXqQkDysPuIPAGc3icz99AwpO1YIsoaFh1fjnvdpFzPZHak8CQ?=
 =?us-ascii?Q?MGMul4edsQKT99EMMxB6HCLvib/oNJUba8KIYF+E/DOJTimLv/b2zzrrDpdQ?=
 =?us-ascii?Q?5zs3+KXpWtS6GqlL5KBeOiJ1eZDthTs1+cp6lC67txhnW3EGBJwI4eUw+6qo?=
 =?us-ascii?Q?zRx6kliurmjhEmezGUyqhBs8BZnnu6EbooN5wLpZKJusIoqdI2KjRKLNgpWm?=
 =?us-ascii?Q?b6QdP52iRUJQoB05Ugk1IKj7no/LeUywUCmj79HZkicvDXM1dYWl4iSj3bJl?=
 =?us-ascii?Q?2yfVvSBAyg3L3eENdtqcYy7bz2Y3I8Pd2QQURuiPfrpz3KZLb8uQTYlwKhgM?=
 =?us-ascii?Q?IWAulapjmfAP5fHFEPa6yaLFJnFgRmEmDjx4wlBn6RGHXltrjuiovbFfM7dq?=
 =?us-ascii?Q?yx4SiccothjHxfFPp9FCj1YvxHBe942kPyoisN5KXNq6BYYD1DYpwFruW270?=
 =?us-ascii?Q?H3n3ExvAI8qChSEZS2r4TtjQP4c14nulvXeF1aV1FePHaxLP4AWZFMSuoRhu?=
 =?us-ascii?Q?Idec27+MzCvtkxwrx8T2F9/u1XbovavXAGAdydy9mZdiDE8APBeIwPEJHvam?=
 =?us-ascii?Q?/W/l1uVZO+CCgzeu9SPOcrr+35bdS90V4VMBlG6Tg98unxUQmSAjlRa8eCFt?=
 =?us-ascii?Q?+ZbplyW+VkUsbUohM+zibmXrejx810oQQJDZoe/S4HNzd4rAO4dq5LZOg3/0?=
 =?us-ascii?Q?wNfPIY7LtjeOOJcI+AEFeP6qup6tlrDsy+ZSVy3+vZeEPOhFg7QIs92eh9lS?=
 =?us-ascii?Q?1TvJHyruyAYmWurqmYar+7V14pUCoylG/2JikERGogWfezvr2i/9i8Rva7P9?=
 =?us-ascii?Q?lJBK2yqRfSh+M6JODvlOJsnpLMUSrDMFY8Puol0J7VOp5XDeqapa036rLvhA?=
 =?us-ascii?Q?KlP9SDfy2h2/SNaClvuWwZurrl+w4xoIMDx+KFXcXdxSJkDzAihDIrBqpdkv?=
 =?us-ascii?Q?o0UjeGz7kP2doLGFubJyFl7oun8I9ImWKE8yXRwJzLy3Ea9cRGejtMgHYdWb?=
 =?us-ascii?Q?b+L3VjQzoJpMQc5K5g7uuuWgGWFdMwUoJWie8YDI90SpRNASwmGDy46e1pT7?=
 =?us-ascii?Q?h8ARNGmHBTRr0kLDckq4a9ajV7QyMANH8SFdYiROz/RJdXQQ5xpx8zOE6m8W?=
 =?us-ascii?Q?uagpZCGtAYIiyIYhH77T8ceKycK0GwA+MV2/gErJjHE7FdMuSXMA8QGNRMqV?=
 =?us-ascii?Q?aRG4OqCa+59DBV6t/50WszkXWjVCvfGrmuTimX2U5ruYEy7Wfe6IQ3IT/FxH?=
 =?us-ascii?Q?XTF9ly9VWAxa9rjWqfHe+qxSiO9tGxYTruFaGnAOZcugy+AayxKQiy7SjCCP?=
 =?us-ascii?Q?MuQK831RtmpYdJH2EoVnQKz1ZHOX/b55BE/7iDb64k9VtRQtUiGJXolbnuea?=
 =?us-ascii?Q?BZO5RxVQLI71gwDZ/5U9Z2/xrCoWiQemgW7dRy6IPeviWkk+QOmuXAqJMDhw?=
 =?us-ascii?Q?7A0hveEXUsu3r5v+gHCUuLZv9+SFQrK3kI+bhSILurFHF9dSK34c/5DLfC4Y?=
 =?us-ascii?Q?rWq4DPKo74z08GM2S1ZX9zdlpnslKkqy2zACtvA3vdWVoCaaFrUQSIgd6gEv?=
 =?us-ascii?Q?ZLdUhrOHozBavoIJxLBtRp5wN73KzCfHTY7gjn4xUlXT1F60oFQOXDAOqfM5?=
 =?us-ascii?Q?Kxz9WorgH7pR8+JnMsQCmv9mVC1yCX9de8Ony7dw1TcIQyls+rsQHqYEMwAp?=
 =?us-ascii?Q?PMylCrQ+8nhuRHr3o6j52cNO1W5N+xE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ae8bbe-05f7-418b-1b19-08deccbb2ad0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:55:38.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg4ggQ2Q5cXhPOyRHam+G7rRMYVHe67LkPTNPPhrcj0HsjR+L9jZbGMw3tADEfNNNTk7HBOE5v7/2PAJuSkyUvbzrt5hNFKCfsdj+IOz6bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7549

From: Han Xu <han.xu@nxp.com>

Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
XSPI controller.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml        | 10 ++++++++++
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

