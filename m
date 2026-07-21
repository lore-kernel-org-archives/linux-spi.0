Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE944AB91;
	Tue, 21 Jul 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669766; cv=fail; b=NmZkG92n9YYxFgAv1xUhP7o+HmVhNfV0nugLmUf5QU0ymkzBYV3BPa+c21BbiIKjFsAbuiXlyqPWWADQ7v1uiR69t8xdLs7YDIDIEadgMe6Sv7bV+o074Z/oMqNUwYW66uhZhZXghWuRK/UL4d9uXVw9KMCTpO/5qKnHe528dlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669766; c=relaxed/simple;
	bh=pWJEF00u+cmGmioqtPfLYAoJOJsfu43bO2Uv1SJ7L7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOXH+jtIjPTCdyyWqegiimFVvXF3bnHkgZmFx9aY05sDlKxttp4o5jIT5kICGcorF7SZusYV2zk3GLO0WrVocSAOLBkY4sTE+KsRxcvcw1cDRkeSOXS3i2JgvhrSQh3R2TemQsuP9CCXL4YXth4cjFGuZnP/qKCp34AWP4PJEzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O5ncosRK; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O5ncosRK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1hBtxO8lIUtsldjGTXREQYG7L9Fo0oWfGlpQCBunhnX0N0woTkEyNeyGlBJXv354+cK1I6bCdmD4t+et5jDyTDSNc/uFyFGTX0q735weKJQzJr3/h56Tjc8ZJ1qj940UOZFCuc+Etuq436FnODT3H7JkIwm/5Glmzgjt5iw9cGM/HuFEPXB/t1PjVjeaaEwk/UH4xSmoPqKQb9VqptE5Rx4B+WKWigxPa1Eg1t+AD5PxoUZpNbBBAYuVIe4EgP3+Xkua9Oc+NHfor8IKQDDN1IT8nI/p2LwnqeZ3Yl5ZDn1BejfOD7pQFUeiFWZUlzGZ0Dhq80zTNAmfKtsHogCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEv/1vUa1ycDI9DEGEAWt6TnWK/WcxYVxV0CCOTNQ8k=;
 b=aJ1Rsi2BjodD80ZpC8IXeiBhZMl29IEeJWGRbMaa5VZb5AAuEtEXD7RqTuWc//Nap17ZqpjH7fEukgohTCV4dJi2wqWuVALQ/TA3ZQBP5lrfQc9tiTf0iuIshcGdugWOk7EUzpnfsmlyaDySwjaZdJCaJVzhxWMc6gSYEjep65u7YjMCWWDzne4QHY//2ShjmwrzLi59GwSTD+8kh/UVWNPe1u9f5ztI6+DH0+Yg30mn+2C/ewXwTh/KO6QzcrW06a+YjMbr7XgrlPRp0j+E1BLmN5had31TEmtYQsk1SzNpFjMNv3Nuvemk85PpdxQwpZSP64QY4NxeTIWpb/XWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEv/1vUa1ycDI9DEGEAWt6TnWK/WcxYVxV0CCOTNQ8k=;
 b=O5ncosRK6UnUZ6+n3tyxx1+FOT/lU81mLZ7xpaNLSRwiwKQnGR4PbbjCQhk0DKhXc2OdbY5a0Zq/6DPAuZkif9fSg4AiedpOrprxXyHGDAzjNNiDoVo6yg0kY/YDJNWjuws9QKEHiUO26kwrWFxi2XA0WRZILQz4ZrlIgA7klZhU+3QfSBb5P/lDv2r3huWaPn/1ek7RLM5hJ9t6vHjdPj6JoSSw09FgW+BO4e/RhD7kgsDa+stY7+fo4ASyoN7Q4ETPhthVxCoFPR8q56CQLV8wT3Kt1O1/FOU0lt7EjXVq30Rg/tMz4XpndHPM+EmjRObM3AJQswPwwglyeEGcCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:36:02 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:36:01 +0000
Date: Tue, 21 Jul 2026 16:35:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: han.xu@oss.nxp.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA
 properties
Message-ID: <al_mN46VZcFqykpW@SMW015318>
References: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
 <20260721-xspi_dma_upstream-v2-1-9e19d80e7762@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-xspi_dma_upstream-v2-1-9e19d80e7762@nxp.com>
X-ClientProxiedBy: SA9PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:20::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 03266f49-9dde-4d58-9e0a-08dee7700f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+U8MpErPqUi4n4y9V43ybQEd5l5Q6GPfxN1s/h05ahIcQkBuWLVQEVfyI/Q4HN5nL/L5YMEJek6j6UJX4q7oNsxfLEivBy2zatBGZHUAHaEvOgwvWRsfN9fmzuZ7Dh68KYDqM2VrFFAsJ7HmWUY4OhpJ1nHJ21CUldu8GWSX0MTD/IBqCdNs4BptV+MdlC7SNmctkas1egYZzl4RfUdzw/Y/ShPUn41r7MtwycY6d/juEjdZdjHrpz6djzPEbLRT8PM1Iqp8w8ZXfBavwLyUtw7oDm2vxSADuxyCrLJOyoTIOIgQcOVBS3TUAOs31FkypLG+rRXyI7+xSipgaakEucUh6e6A9Nl5QKIDBbqdzpGyeJk4Ex6bqI/j8luNxfuUyOrezfI5mFuqSMopzhJuBgIuOTXqqpIxcA9TENXBBR5R23EY8f5FhRpCzAy0ssu3KK75bnp5+h/0Qj0S5MFBh6XTueC9+zbUUCsL2vGFggGgQvTcTbpE84RjUBhrQM1W0FdNqiaOeLJrkeUrD1c/0ILEnCARux05jf8BZ7bKbzUBehovOeAiiEq5cZ/zXec4KIN3D6E3MLAPP/2mCEMR/q7TLpkgLDMTLGuuPbe6xSYT3lrpy7QCQncO0MZwMR1lu4g0w5Rf+i5G5qcMsaDB6SZyBHGJ5bfJw+Z2+BYgNrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZ99CxIrREySNYPQfzkxxGQPU7F78CaW7mAQ8Zl4Kx82P/Ek65KzMdTp8M4G?=
 =?us-ascii?Q?Sv8ePxSmoFjnRrr95rJMXN4l4AZDrdKMycvW9KdYND9Sg8jFF8/g5oNLF9nt?=
 =?us-ascii?Q?g7C33Rxvt52vG810LAVa2RuZsyVLilw4w89o5umz2bAATNtASC4+mqdLA8r8?=
 =?us-ascii?Q?0xwX7MhAu3i5PKeW7lvEhfEV4x+DOHivuYVMe2XxOrQZji4VkkXFNj2X6cqR?=
 =?us-ascii?Q?OY0CnsEaZKrK9NhJpo67SVhZnXIAvs5+8AfdfeZtsGW1Moxr/J3r9HZlBTQk?=
 =?us-ascii?Q?4cqQ60yWsuI+G42KDHBgqabI10nSQnFUpIrUDbDJbVc7FAmMZVzj0YGMklXC?=
 =?us-ascii?Q?3PaKSq3WyILOSc2Y0XvOrkpDKiz1iHZA5VPxbUOV04yGg5pev2WdcU9Uh8cn?=
 =?us-ascii?Q?Xc4Oc2x/Bt40P2zPSZ8jmK1XPGhycefujCqx93JRypBbECz9YCvXbF9n9Op7?=
 =?us-ascii?Q?9oNIuX+LZKs2F6C+fjfs61OPVxPAu8s/JNELECqt9uVf8QtxRx5caNeltyCg?=
 =?us-ascii?Q?D9HjHGy8eB815xRlVFMDcaJ2YZ2gvsqvSzeEdIGNywU7ae4R9oAkOXU/zZ6z?=
 =?us-ascii?Q?9uoHeN3dNfEczeDrex29aeRqSFIz+46Hv2aydF0U1xBU9K7JIxm4sDUA9SAP?=
 =?us-ascii?Q?TLvuJZ9T1zSoNYWE6CD3Cdicodgcnbqdrb+0wGM6ZjrW05AMPA9MukA7a8lR?=
 =?us-ascii?Q?yUC4HLA2lphzqhxh7uY6Tjb08+ekflEBoEoPFQ3/LvJl3JSr1QzhpPv3NZXz?=
 =?us-ascii?Q?S2t5eOiHDBJDqODftW4YCPT+gdiB3+I4nsscx+6Do78S6ug6iOREJTgcczmK?=
 =?us-ascii?Q?1poXms87OUkjf4vvuLbsxZKdjeFTdlRu13ieLGyME6s3QyAvWbVgEZJnKsK3?=
 =?us-ascii?Q?s58OcY15GXpeHZtMEZ9Sp21GwpUQo9mwiXEJ3UoeuN5JI88/0+LcubogKHFl?=
 =?us-ascii?Q?vhU2uxZragqbpWOtPAREG0hVcfvtf/6cPG109KzxflbAQkqOb1E1DDsn5hPW?=
 =?us-ascii?Q?z7fbuk3YEMynCkvEM0RkPsR4RuSxzIf3MwZfSpRE0OshasrdGU2iwlxlsWAl?=
 =?us-ascii?Q?nAXz9opyi9LcTwexorShX8z9hbERXlFHX1IxtmslpDcNKTvn9A52sZ4SAHyO?=
 =?us-ascii?Q?qu3QqUCsCN8SnPM4kFW/9At+Qx/ABmcYTJGCHQVbDfr816N9qCi5MDShH/LM?=
 =?us-ascii?Q?y2FSwcfLA90DomgtI7b6tmv4j8kxcW0PzS9X+oy2Lw8N+Q4/csdghtnRKm3b?=
 =?us-ascii?Q?qZyKWInKEjfB1MC2S9u1kwmLk6qsiwFfmQ1mMenGGec/Ak6/y1jWuFIhhtlw?=
 =?us-ascii?Q?QvUPoEE7zNASruqFPya1Isjb6D2x2cFDtB/s8zIzxAgLiJjeTeaHVT7WbDzB?=
 =?us-ascii?Q?dJVj++rSPSOYlcwsmQ8xdNLI+zZyNom3KKYNiLjWS/r19bYUx/ZW07cUUQP4?=
 =?us-ascii?Q?6Gz/t7DP6PGoX5bnEX/33P5iJOOKFgh65WXS6Gdr/HLqUkOUj3iUETjpjsWR?=
 =?us-ascii?Q?RnepzZix6tUvdCjv1hPIAIEGpXL2+Ky56hDammJQyWc1j3k7h1dvRBMbXy8R?=
 =?us-ascii?Q?8k8xGkCsdNT5LIZGgQWSy1VDoO0Tr7CY0cZRK91pYcrl49lUkKCyqYGaf+JF?=
 =?us-ascii?Q?CGomUhKrvx9cZv+P17idP7qIXNXfJ/M5timUQzOauZx4epCznbvxw/O4Ri0L?=
 =?us-ascii?Q?uvJRSdYbJo2SU/+e1iPb/nG20UY6yrihTBGnRiIEpoFb9skW572KeQv7ngew?=
 =?us-ascii?Q?6v7BnTXsu9X+1f2ftYBpXTNBkZKmneMNwdnc33zWe8V/zheOvfj9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03266f49-9dde-4d58-9e0a-08dee7700f64
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:36:01.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXKxFNADCg8rGsgoibxKsZNyQzcdYv/oL9PlZCut5NN8Yg/iS0yuvrVSKbuNGfjWkyB2USneVqhgq5BN8l7puYEY6ViirBdDvJyVDP1SWyjkM767PO4JXmYyg20g49wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835

On Tue, Jul 21, 2026 at 04:01:42PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>
> Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
> XSPI controller.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> index 16a0598c6d033..ccf841f194c06 100644
> --- a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> @@ -30,6 +30,16 @@ properties:
>        - const: base
>        - const: mmap
>
> +  dmas:
> +    items:
> +      - description: Transmit DMA
> +      - description: Receive DMA
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
>    interrupts:
>      items:
>        - description: interrupt for EENV0
>
> --
> 2.34.1
>
>
