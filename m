Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793932741;
	b=jTlR3/KQwaOw9pnPoBf4r2GlgM3opaTD9nh6WNy86Pu7tDCS2o1KIi4ASkfqjLpTkOS0
	 P+Ph/aYBcXtXz1FFD1KOZuenfoOlIGlTFmaJNRSS0CqQB+eH298AwIOxRRDTlDHFKm0y1
	 9CsE2ocgnPt0glS0wx6iZ8shRPszqrblzcNufYXloxFbDU2R3p9Tl1skpyAzegfQlsVOy
	 aq93vG/g15J8qZQRpFLmGaQtuYB6SaA6hWSuqVqtka6gczATkYxFleu8niUNijFkS4Y77
	 hm1QWat2f8xourQ++e/4fp/0a1nWigt1DO8nwNMWCvDZ4LagnawTyhsfnHVVpF2AKWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932741;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=xGxtsnAex5dkYsDxdLPWZAbdczVY1D9+cLI13z9f9vk=;
	b=DpV/VjYx+yp4mxLiPz3OVMFX7KcrOoSBAk352E1hpDYh0gGRAAyKxjIBB/zhzRgBWFDu
	 uUhy/ijySEVvxiFAt7J79srcYwbz1FPyAKUCIGpVyVlre6Ap1ycjs1kMsJHRbGQA3YpDn
	 G5yH30LwJdfBHiWwnz8ov+xg2/n4q7iDhsEqRKwaCLeWmu87S7p71UB7g/KyPvWhq/qSj
	 V8ehzOsAFd+FIP1R4exzLiGHIfulQ+3Cs8UbjOpx6pnoWrXm4okVQys9uJIC2bDLrKinC
	 vDVBbvSBE9j4yOw3DS+jvzo9eCDWVTKTfhl4ZdpBWZr+WgCBTN+uwjFoSiQTcjClHoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FC3hBfg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.46
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243E606A31B;
	Fri,  6 Nov 2026 02:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6243E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FC3hBfg3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cx404EpR+OOPEZOATPb+ng3xt4jzRuOMMKBG1BgE2+JS1CKfLfXkyhaFxK0YMe56EQqXEj+pR6jW3vXMsrro5ilH3nJVCJkT7hgfZpS1jOnpUZUanARv2BQgD1zSWL9BOZxFftCQGXuYHEGuCcqQo/n5IpLfo93Gyy6caIh+NsgckAurEMdCcj6eaUtfuMPZBlhXuzMK1BA6+uyfGK5+P5cz59LgMTmwUud4krOsida/IqM5BM5IjS8T6eCY/Gho83jNz25/vc6uaPYF2Wl7wjuc8/dOwHT6JbHZr16BLC9ad6yHtaY0vwmFJVDkbETqNdue9IzxCpftn0Vs5HMKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGxtsnAex5dkYsDxdLPWZAbdczVY1D9+cLI13z9f9vk=;
 b=muCjDQKtunrOCr1y+pxmrVywhrjHkMu2kByzl7XPXzHLFW449sUNomU8b2wbbo/WmWJ2j3Q3B3s8LsiPFhqHN+rDLNGl4h5ziPiX3BmOdbf32AEJPgba30U68Sy1hY4kNzrtMhy3qTat+4qvBvBRL9WKa40UBY3lVpLBxohLIROFY+ylLo45ppnk4slzo0S2WEAo30/a39xC+VHJ1n7gK2mjRARrpd4fS8FFW39O4m3oiYyaVNWLfAIMji9uIGiOqGogSWoE+qIUH9zmtUX2uQY7NhscV3iD0ipWHV1NyoozRw6/elyGcjJ2T2N/L6XAy6nmqBWUQxNSMiNXzVr9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGxtsnAex5dkYsDxdLPWZAbdczVY1D9+cLI13z9f9vk=;
 b=FC3hBfg3WbZwnGj6IUuSpswDJFMk44S2c0gj1zxoKD9+J/fbHVZ8tP0XIhO0fFwK3e2Pmzt+2NZhK27LH/NMN4YQAB4Wvh0AnUVX2j/2ADYUgxrQb1oii4Sdu1yZuTD1cruXIX1wawfvIFV339hijObuYder27XJ39BLLaYB9H1AF+dhwkkErUAylH1TJE6uetDT96D47UafzWzXrFfN6oBCFh+42hc3w7i05BoJgohL+BzN8poF+XAMEctXE973oG0xmzoKakxWjZqM+yIlo7qiwPWMzUGRdxX+lf7ggafEi6XwkHJfDiPeaYDtyU7d2maEzz9KOqhga/hU7z2Tsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by AM0PR04MB6819.eurprd04.prod.outlook.com
 (2603:10a6:208:17f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 02:38:56 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 02:38:56 +0000
Date: Fri, 6 Nov 2026 10:43:46 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	CL Wang <cl634@andestech.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	"open list:RENESAS RZ/V2H(P) RSPI DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	vkoul@kernel.org
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <20261106024346.za4rqvfjxs2rwsdj@shlinux89>
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
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
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b43c7ef-d25e-4163-9b1a-08df3baf1a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|261022075727099003|261022105027099003|11063799006|56012099006|261028144727099003|261021123027099003|261009220027099003|261009221227099003|261021121427099003|261009221727099003|261021135927099003|261102123227099003|261009223327099003|261009223027099003|261026121527099003|261026140227099003|22082099003|18002099003|6133799003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	/fYfq4SuB6tsE9f40cousCRMnQJk+BO6hlMCel1Gd30byw1qLwbT1VBmbpnfEa+TdZJdZizbxbZA5oduJUidVyHaxrGxOvKmbo+L5dHVib/3EL3Pdis4B2h5GapLm/ZZF5FubIgab5Q0bTB6AxIgb9cpZIyn+DXlJTF0EFWDXLdSJ2vJwj81km97oAK6XqpwIH050fjfPQDc08/zgndnGmHEhjqhQpPYD/5lxCkXbF/r1fFnC2+ngokLA03+dKj/Z+U6xLG52WOZlNFFQtR1rUi7kDX64lAjhhjRk+9AkUyPxmeHM4TjKzC1OPuwzoA4UBYx2lt2YNEsuO5DqRCLCrjQ7m6mcIp81hNKK8wMvcKGXhl52DrE/V/nnAF08D5hyCs2bkNlzrjWjiDdru/38LE2gkjnhhffQi60Wj37tcoZHjq6+3QASILa5q460TzTgOpqCG+NBcGisHnFmDUsyWL3EsNIDKhtW4yCB5jxLRc8MqZA6A/tIn6JWjfk9nsrx2VDkjyqItA/opx5KBU1uqX6NW+/ACTvUlEwDTFsYMXmMWYnTWPbLxJ2OtFO9pXRNQq7lgHJRBP0vDFr6mSWwKYFGqiBR1UyGVuCCuRSk/6WqsQNSzBMy0tAwCYH7OooJqGcf0cX7ZtVM0Y6rbjhHC8iJHzY157frWH6+YsD9z3Si/1o7qO0aIG7DEp73rE3TOEiIJb2ReJhA7q/jy1RAUudB5My3z1w9cqrfXhh4r8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(261022075727099003)(261022105027099003)(11063799006)(56012099006)(261028144727099003)(261021123027099003)(261009220027099003)(261009221227099003)(261021121427099003)(261009221727099003)(261021135927099003)(261102123227099003)(261009223327099003)(261009223027099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003)(6133799003)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SpAH0n0uzFdO2Y4xmHSx22+QJbm/1OoeDxLdj8x1zLdZJQ5EHFk1LJINrhv0?=
 =?us-ascii?Q?FPPZMgitoEtGwRfIICWHK4UXVTinB3qxB5OI9agKiNQy3+uo6DZ53O7z2V8f?=
 =?us-ascii?Q?RR00qe/3UhJJyrQY62NbbqZSC2N649ZjDumd6uOTF/JbBLe6pMZVUEV+W1bn?=
 =?us-ascii?Q?+gSFK1bYTT8/l5WU20TuY16YoW+u9iTNcKlWAtyJeKGG3abOkiFKDdk3G6+/?=
 =?us-ascii?Q?D7Jvn7zdeAeseu5XlysDZWYaP9EwPqW22PkMYOYgfJH70PFoIPRplK7mC9lL?=
 =?us-ascii?Q?rNm3Jd+t/XRqQeHSF+zopysLlSfWcs/I6KvtlEgMk7jrB/cZcSNV2XuSD6fc?=
 =?us-ascii?Q?FkDghneksxK1Af2NgvK6VuZxKPumRBK2V1nkpmiUXZG/BkivDrKlW3GrmCY1?=
 =?us-ascii?Q?3nIE7Tc6FvYt3yKAuz735FD9vCImRXpBTOu9+rDNUd9GG+b/q179N6VDp39M?=
 =?us-ascii?Q?hEj2kYbg165aT1QN3bLub2Objc9NN34hpWlBLQ2lcrOHts9iv4Cqk7Do+BOk?=
 =?us-ascii?Q?PVwRBMJnKR2R7IxHb8+pluVc5jPqYh9terEBGNbb3OxZ9r2GJztNgCRuqgEX?=
 =?us-ascii?Q?cCw35lkEYErjgbHhiTtKsDQXQfH32WlRYg5deIVrMva2hNC9UwqUxs74Xm1y?=
 =?us-ascii?Q?qkbwVY/7dcvaB5Y6FAAtjmsqYkkdjr5II4TBV+mVpzolrvFpWlpGVyU9gCmi?=
 =?us-ascii?Q?zAIJWMB0Enic6TQVtL27Eg2k4oE70CjXSij86KFqyMOUsrLBianmp/3aACHd?=
 =?us-ascii?Q?PQXxTtIJlULooMk8u1hNsfbH+7Tn05HsKMlD4mdfUi+0GrCnX82dydoUdvXj?=
 =?us-ascii?Q?Pe+Og4tDTfOFVlHMf1KPwjfxnCQZYduIu1TsqzlQ/07CEHFq39XWBS0VKLkb?=
 =?us-ascii?Q?sG8MnIE0yZQcT7PPaPcB0gCtuwXG+jadoyQWjsiVhHOeklUdnwuTQRzVONQA?=
 =?us-ascii?Q?cycW5lm4pEeKhLnzVwvnYu4bP0x6M98QPrR4wBj8i97NoLZ6GDpZU/iNsUZp?=
 =?us-ascii?Q?2Yp/CWVrlSHV9QxTlF8LKUK0NqoTaPwbQF90uELHXfOrFhzTdMBh8WtuV3tV?=
 =?us-ascii?Q?BMBKURimqsfXGszAgN0Awa4qMrgqL7KXLhT6CD1aaILxI/tQgcYW/16WzNHz?=
 =?us-ascii?Q?0Ai07o07b/7g+zPXKioHZlNeXT0+Qpn8XLfwvgTTORd4qHHr5fLc7wpOaA6h?=
 =?us-ascii?Q?PaxEjURXZuVAAQCNLjB3Q5+aLfjv65urUyzuP+aBBN13C7G1kBRQqsb8JUXX?=
 =?us-ascii?Q?pXJaXenS6dreZEX4fdkdHfOG1D7/H8ywoM+p9ZcDhV+YVo8YGp+jYksGg1Jf?=
 =?us-ascii?Q?c5V8/PkMHgxmfV3BcNZFsIRWQt/VULjA+EZh1FcFFL89lO6A4wEVEml7m5He?=
 =?us-ascii?Q?tAehX8SGt3iI3rLpRzENxz3yTxmJOJTJcp+kZczoPiusHP2Rz4WcdjLmbfAe?=
 =?us-ascii?Q?OjHYAaniMbVk15MD1CGjAXjRZ7NV9WO3RWdq6IG7Kg5pAwl9JVGJfTr5Mvjh?=
 =?us-ascii?Q?+Lph+I8w5qpWLJjGdE4CyFaEmhteIOzRX3GdORqCphM+PEY7BFEgZGS8owoH?=
 =?us-ascii?Q?tE293WSFKc37d59CFYn+M1DaCWVPsvvpSmLj4sHGOJmSIRglhoBRF3zcvAmU?=
 =?us-ascii?Q?YnzlTRiUzpIlzAWPrJU+v1hqxA+6MkbTx67Y5r9wMTIxj/B+9IUMmX0jHSjn?=
 =?us-ascii?Q?qp5WD/SbXsa+PRqN1syRqfRkflkqyVRz3roq8sb13V2vZrw83ch+r7jshJDt?=
 =?us-ascii?Q?8jFDuZwRqNziqrRpzHfI5yWNReMHA57P7tBSInNIBlej1Q7nDY3P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b43c7ef-d25e-4163-9b1a-08df3baf1a35
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 02:38:56.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Z24sb9DL0ba06Ep4NQGRPiHCu24z2CRN/cxXgySxtnuwc7lt7Mf70HI0Ev3gDxmSFqaQaeMoen8IyeFTuPBd8ZudYDnN00HNarB8TF2At6FanAyaC6L/tcnksMSzhWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819

On Mon, Nov 02, 2026 at 12:39:58PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 

For NXP related including:
  drivers/spi/spi-fsl-dspi.c
  drivers/spi/spi-fsl-lpspi.c
  drivers/spi/spi-imx.c
  drivers/spi/spi-nxp-xspi.c
  drivers/spi/spi-mxs.c

Reviewed-by: Haibo Chen <haibo.chen@nxp.com> # NXP

Regards
Haibo Chen

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/atmel-quadspi.c       | 3 +--
>  drivers/spi/spi-at91-usart.c      | 3 +--
>  drivers/spi/spi-atcspi200.c       | 3 +--
>  drivers/spi/spi-atmel.c           | 3 +--
>  drivers/spi/spi-bcm2835.c         | 6 ++----
>  drivers/spi/spi-cadence-quadspi.c | 3 +--
>  drivers/spi/spi-davinci.c         | 6 ++----
>  drivers/spi/spi-dw-dma.c          | 6 ++----
>  drivers/spi/spi-ep93xx.c          | 3 +--
>  drivers/spi/spi-fsl-dspi.c        | 6 ++----
>  drivers/spi/spi-fsl-lpspi.c       | 6 ++----
>  drivers/spi/spi-geni-qcom.c       | 3 +--
>  drivers/spi/spi-img-spfi.c        | 6 ++----
>  drivers/spi/spi-imx.c             | 6 ++----
>  drivers/spi/spi-ingenic.c         | 3 +--
>  drivers/spi/spi-mxs.c             | 3 +--
>  drivers/spi/spi-nxp-xspi.c        | 3 +--
>  drivers/spi/spi-omap2-mcspi.c     | 6 ++----
>  drivers/spi/spi-pic32.c           | 3 +--
>  drivers/spi/spi-pl022.c           | 3 +--
>  drivers/spi/spi-pxa2xx-dma.c      | 3 +--
>  drivers/spi/spi-qup.c             | 3 +--
>  drivers/spi/spi-rockchip.c        | 6 ++----
>  drivers/spi/spi-rspi.c            | 6 ++----
>  drivers/spi/spi-rzv2h-rspi.c      | 3 +--
>  drivers/spi/spi-s3c64xx.c         | 3 +--
>  drivers/spi/spi-sh-msiof.c        | 6 ++----
>  drivers/spi/spi-spacemit-k1.c     | 3 +--
>  drivers/spi/spi-stm32-ospi.c      | 3 +--
>  drivers/spi/spi-stm32-qspi.c      | 3 +--
>  drivers/spi/spi-stm32.c           | 9 +++------
>  drivers/spi/spi-sun6i.c           | 3 +--
>  drivers/spi/spi-tegra114.c        | 6 ++----
>  drivers/spi/spi-tegra20-slink.c   | 6 ++----
>  drivers/spi/spi-tegra210-quad.c   | 6 ++----
>  drivers/spi/spi-ti-qspi.c         | 3 +--
>  drivers/spi/spi-topcliff-pch.c    | 6 ++----
>  drivers/spi/spi-uniphier.c        | 6 ++----
>  38 files changed, 56 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 762a3fb0fca81..de205e04a8600 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -790,8 +790,7 @@ static int atmel_qspi_dma_xfer(struct atmel_qspi *aq, struct dma_chan *chan,
>  	}
>  
>  	reinit_completion(&aq->dma_completion);
> -	tx->callback = atmel_qspi_dma_callback;
> -	tx->callback_param = aq;
> +	dmaengine_desc_set_callback(tx, atmel_qspi_dma_callback, NULL, aq);
>  	cookie = dmaengine_submit(tx);
>  	ret = dma_submit_error(cookie);
>  	if (ret) {
> diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
> index aadcdf734fb03..8b56ac1dcad8e 100644
> --- a/drivers/spi/spi-at91-usart.c
> +++ b/drivers/spi/spi-at91-usart.c
> @@ -228,8 +228,7 @@ static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
>  	if (!txdesc)
>  		goto at91_usart_spi_err_dma;
>  
> -	rxdesc->callback = dma_callback;
> -	rxdesc->callback_param = ctlr;
> +	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, ctlr);
>  
>  	cookie = dmaengine_submit(rxdesc);
>  	if (dma_submit_error(cookie))
> diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
> index b532c58c0ab91..c807e730ca94c 100644
> --- a/drivers/spi/spi-atcspi200.c
> +++ b/drivers/spi/spi-atcspi200.c
> @@ -340,8 +340,7 @@ static int atcspi_dma_trans(struct atcspi_dev *spi,
>  	}
>  
>  	reinit_completion(&spi->dma_completion);
> -	desc->callback = atcspi_dma_callback;
> -	desc->callback_param = &spi->dma_completion;
> +	dmaengine_desc_set_callback(desc, atcspi_dma_callback, NULL, &spi->dma_completion);
>  	cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(cookie);
>  	if (ret)
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index ffc896e4621ac..ffc1292b08c10 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -867,8 +867,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_controller *host,
>  	spi_writel(as, IER, SPI_BIT(OVRES));
>  
>  	/* Put the callback on the RX transfer only, that should finish last */
> -	rxdesc->callback = dma_callback;
> -	rxdesc->callback_param = host;
> +	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, host);
>  
>  	/* Submit and fire RX and TX with TX last so we're ready to read! */
>  	cookie = dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index cc57489732816..a71048a88c58a 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -706,11 +706,9 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
>  	 * RX-only transfers; else by the TX channel for TX-only transfers.
>  	 */
>  	if (!is_tx) {
> -		desc->callback = bcm2835_spi_dma_rx_done;
> -		desc->callback_param = ctlr;
> +		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_rx_done, NULL, ctlr);
>  	} else if (!tfr->rx_buf) {
> -		desc->callback = bcm2835_spi_dma_tx_done;
> -		desc->callback_param = ctlr;
> +		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_tx_done, NULL, ctlr);
>  		bs->target = target;
>  	}
>  
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 73ea51c41f955..6e7c8b54e0377 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1395,8 +1395,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>  		goto err_unmap;
>  	}
>  
> -	tx->callback = cqspi_rx_dma_callback;
> -	tx->callback_param = cqspi;
> +	dmaengine_desc_set_callback(tx, cqspi_rx_dma_callback, NULL, cqspi);
>  	cookie = dmaengine_submit(tx);
>  	reinit_completion(&cqspi->rx_dma_complete);
>  
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 087735ed9c80c..b115daf2c76f3 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -703,10 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
>  		if (!txdesc)
>  			goto err_desc;
>  
> -		rxdesc->callback = davinci_spi_dma_rx_callback;
> -		rxdesc->callback_param = (void *)dspi;
> -		txdesc->callback = davinci_spi_dma_tx_callback;
> -		txdesc->callback_param = (void *)dspi;
> +		dmaengine_desc_set_callback(rxdesc, davinci_spi_dma_rx_callback, NULL, (void *)dspi);
> +		dmaengine_desc_set_callback(txdesc, davinci_spi_dma_tx_callback, NULL, (void *)dspi);
>  
>  		if (pdata->cshold_bug)
>  			iowrite16(spidat1 >> 16, dspi->base + SPIDAT1 + 2);
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index b706770334a61..94810f9dd5c5d 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -397,8 +397,7 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
>  	if (!txdesc)
>  		return -ENOMEM;
>  
> -	txdesc->callback = dw_spi_dma_tx_done;
> -	txdesc->callback_param = dws;
> +	dmaengine_desc_set_callback(txdesc, dw_spi_dma_tx_done, NULL, dws);
>  
>  	cookie = dmaengine_submit(txdesc);
>  	ret = dma_submit_error(cookie);
> @@ -498,8 +497,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
>  	if (!rxdesc)
>  		return -ENOMEM;
>  
> -	rxdesc->callback = dw_spi_dma_rx_done;
> -	rxdesc->callback_param = dws;
> +	dmaengine_desc_set_callback(rxdesc, dw_spi_dma_rx_done, NULL, dws);
>  
>  	cookie = dmaengine_submit(rxdesc);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index d8f4aa38685f5..6832869bc73bf 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -418,8 +418,7 @@ static int ep93xx_spi_dma_transfer(struct spi_controller *host)
>  	}
>  
>  	/* We are ready when RX is done */
> -	rxd->callback = ep93xx_spi_dma_callback;
> -	rxd->callback_param = host;
> +	dmaengine_desc_set_callback(rxd, ep93xx_spi_dma_callback, NULL, host);
>  
>  	/* Now submit both descriptors and start DMA */
>  	dmaengine_submit(rxd);
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index f03488870d024..aee0393f9a832 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -581,8 +581,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  		return -EIO;
>  	}
>  
> -	dma->tx_desc->callback = dspi_tx_dma_callback;
> -	dma->tx_desc->callback_param = dspi;
> +	dmaengine_desc_set_callback(dma->tx_desc, dspi_tx_dma_callback, NULL, dspi);
>  	if (dma_submit_error(dmaengine_submit(dma->tx_desc))) {
>  		dev_err(dev, "DMA submit failed\n");
>  		return -EINVAL;
> @@ -600,8 +599,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
>  		return -EIO;
>  	}
>  
> -	dma->rx_desc->callback = dspi_rx_dma_callback;
> -	dma->rx_desc->callback_param = dspi;
> +	dmaengine_desc_set_callback(dma->rx_desc, dspi_rx_dma_callback, NULL, dspi);
>  	if (dma_submit_error(dmaengine_submit(dma->rx_desc))) {
>  		dev_err(dev, "DMA submit failed\n");
>  		return -EINVAL;
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index b25f94b2ef738..7798197d5b350 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -634,8 +634,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  	if (!desc_rx)
>  		return -EINVAL;
>  
> -	desc_rx->callback = fsl_lpspi_dma_rx_callback;
> -	desc_rx->callback_param = (void *)fsl_lpspi;
> +	dmaengine_desc_set_callback(desc_rx, fsl_lpspi_dma_rx_callback, NULL, (void *)fsl_lpspi);
>  	dmaengine_submit(desc_rx);
>  	reinit_completion(&fsl_lpspi->dma_rx_completion);
>  	dma_async_issue_pending(controller->dma_rx);
> @@ -648,8 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  		return -EINVAL;
>  	}
>  
> -	desc_tx->callback = fsl_lpspi_dma_tx_callback;
> -	desc_tx->callback_param = (void *)fsl_lpspi;
> +	dmaengine_desc_set_callback(desc_tx, fsl_lpspi_dma_tx_callback, NULL, (void *)fsl_lpspi);
>  	dmaengine_submit(desc_tx);
>  	reinit_completion(&fsl_lpspi->dma_tx_completion);
>  	dma_async_issue_pending(controller->dma_tx);
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 91e75e213f929..e239c4333055b 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -506,8 +506,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>  		return -EIO;
>  	}
>  
> -	tx_desc->callback_result = spi_gsi_callback_result;
> -	tx_desc->callback_param = spi;
> +	dmaengine_desc_set_callback(tx_desc, NULL, spi_gsi_callback_result, spi);
>  
>  	if (peripheral.cmd & SPI_RX)
>  		dmaengine_submit(rx_desc);
> diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
> index 76dcb283d1225..53370cff7e2cd 100644
> --- a/drivers/spi/spi-img-spfi.c
> +++ b/drivers/spi/spi-img-spfi.c
> @@ -334,8 +334,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
>  		if (!rxdesc)
>  			goto stop_dma;
>  
> -		rxdesc->callback = img_spfi_dma_rx_cb;
> -		rxdesc->callback_param = spfi;
> +		dmaengine_desc_set_callback(rxdesc, img_spfi_dma_rx_cb, NULL, spfi);
>  	}
>  
>  	if (xfer->tx_buf) {
> @@ -358,8 +357,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
>  		if (!txdesc)
>  			goto stop_dma;
>  
> -		txdesc->callback = img_spfi_dma_tx_cb;
> -		txdesc->callback_param = spfi;
> +		dmaengine_desc_set_callback(txdesc, img_spfi_dma_tx_cb, NULL, spfi);
>  	}
>  
>  	if (xfer->rx_buf) {
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index cadf0b93f4403..f8a3ac11f49d0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1738,8 +1738,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  		return -EINVAL;
>  	}
>  
> -	desc_rx->callback = spi_imx_dma_rx_callback;
> -	desc_rx->callback_param = (void *)spi_imx;
> +	dmaengine_desc_set_callback(desc_rx, spi_imx_dma_rx_callback, NULL, (void *)spi_imx);
>  	cookie = dmaengine_submit(desc_rx);
>  	if (dma_submit_error(cookie)) {
>  		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
> @@ -1756,8 +1755,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	if (!desc_tx)
>  		goto dmaengine_terminate_rx;
>  
> -	desc_tx->callback = spi_imx_dma_tx_callback;
> -	desc_tx->callback_param = (void *)spi_imx;
> +	dmaengine_desc_set_callback(desc_tx, spi_imx_dma_tx_callback, NULL, (void *)spi_imx);
>  	cookie = dmaengine_submit(desc_tx);
>  	if (dma_submit_error(cookie)) {
>  		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
> index a0a047510611e..9567ddde06ef0 100644
> --- a/drivers/spi/spi-ingenic.c
> +++ b/drivers/spi/spi-ingenic.c
> @@ -157,8 +157,7 @@ spi_ingenic_prepare_dma(struct spi_controller *ctlr, struct dma_chan *chan,
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (dir == DMA_DEV_TO_MEM) {
> -		desc->callback = spi_ingenic_finalize_transfer;
> -		desc->callback_param = ctlr;
> +		dmaengine_desc_set_callback(desc, spi_ingenic_finalize_transfer, NULL, ctlr);
>  	}
>  
>  	cookie = dmaengine_submit(desc);
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index fda1d260b2966..eabea73a19fc7 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -267,8 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
>  	 * The last descriptor must have this callback,
>  	 * to finish the DMA transaction.
>  	 */
> -	desc->callback = mxs_ssp_dma_irq_callback;
> -	desc->callback_param = spi;
> +	dmaengine_desc_set_callback(desc, mxs_ssp_dma_irq_callback, NULL, spi);
>  
>  	/* Start the transfer. */
>  	dmaengine_submit(desc);
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 38c8d6269aadd..e532b2da54835 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -872,8 +872,7 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
>  		goto err_unmap_src;
>  	}
>  
> -	desc->callback = nxp_xspi_dma_rx_callback;
> -	desc->callback_param = xspi;
> +	dmaengine_desc_set_callback(desc, nxp_xspi_dma_rx_callback, NULL, xspi);
>  	reinit_completion(&xspi->dma_rx_c);
>  	dmaengine_submit(desc);
>  	dma_async_issue_pending(chan);
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index e46b1d9c8cd08..56fc8211a752f 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -436,8 +436,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
>  	if (!tx)
>  		return -EIO;
>  
> -	tx->callback = omap2_mcspi_tx_callback;
> -	tx->callback_param = spi;
> +	dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL, spi);
>  
>  	return dma_submit_error(dmaengine_submit(tx));
>  }
> @@ -525,8 +524,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
>  		goto out_free_sg;
>  	}
>  
> -	tx->callback = omap2_mcspi_rx_callback;
> -	tx->callback_param = spi;
> +	dmaengine_desc_set_callback(tx, omap2_mcspi_rx_callback, NULL, spi);
>  	ret = dma_submit_error(dmaengine_submit(tx));
>  	if (ret)
>  		goto out_free_sg;
> diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> index 8363bc873b03a..b6a6929cbb0c2 100644
> --- a/drivers/spi/spi-pic32.c
> +++ b/drivers/spi/spi-pic32.c
> @@ -330,8 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
>  	}
>  
>  	/* Put callback on the RX transfer, that should finish last */
> -	desc_rx->callback = pic32_spi_dma_rx_notify;
> -	desc_rx->callback_param = pic32s;
> +	dmaengine_desc_set_callback(desc_rx, pic32_spi_dma_rx_notify, NULL, pic32s);
>  
>  	cookie = dmaengine_submit(desc_rx);
>  	ret = dma_submit_error(cookie);
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 3ff30486b2892..9f98f95bb534c 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -956,8 +956,7 @@ static int configure_dma(struct pl022 *pl022)
>  		goto err_txdesc;
>  
>  	/* Put the callback on the RX transfer only, that should finish last */
> -	rxdesc->callback = dma_callback;
> -	rxdesc->callback_param = pl022;
> +	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, pl022);
>  
>  	/* Submit and fire RX and TX with TX last so we're ready to read! */
>  	dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
> index c94d1d192e743..0e7ad7fb48eb2 100644
> --- a/drivers/spi/spi-pxa2xx-dma.c
> +++ b/drivers/spi/spi-pxa2xx-dma.c
> @@ -154,8 +154,7 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
>  	}
>  
>  	/* We are ready when RX completes */
> -	rx_desc->callback = pxa2xx_spi_dma_callback;
> -	rx_desc->callback_param = drv_data;
> +	dmaengine_desc_set_callback(rx_desc, pxa2xx_spi_dma_callback, NULL, drv_data);
>  
>  	dmaengine_submit(rx_desc);
>  	dmaengine_submit(tx_desc);
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index e8b076b1622d3..6be0b942d7c4e 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -429,8 +429,7 @@ static int spi_qup_prep_sg(struct spi_controller *host, struct scatterlist *sgl,
>  	if (IS_ERR_OR_NULL(desc))
>  		return desc ? PTR_ERR(desc) : -EINVAL;
>  
> -	desc->callback = callback;
> -	desc->callback_param = qup;
> +	dmaengine_desc_set_callback(desc, callback, NULL, qup);
>  
>  	cookie = dmaengine_submit(desc);
>  
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 1a81fd94b4396..f8d6cea2f3dad 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
>  		if (!rxdesc)
>  			return -EINVAL;
>  
> -		rxdesc->callback = rockchip_spi_dma_rxcb;
> -		rxdesc->callback_param = ctlr;
> +		dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb, NULL, ctlr);
>  	}
>  
>  	txdesc = NULL;
> @@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
>  			return -EINVAL;
>  		}
>  
> -		txdesc->callback = rockchip_spi_dma_txcb;
> -		txdesc->callback_param = ctlr;
> +		dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb, NULL, ctlr);
>  	}
>  
>  	/* rx must be started before tx due to spi instinct */
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index c61edd1c1353b..5e03a186e9e79 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -553,8 +553,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
>  			goto no_dma_rx;
>  		}
>  
> -		desc_rx->callback = rspi_dma_complete;
> -		desc_rx->callback_param = rspi;
> +		dmaengine_desc_set_callback(desc_rx, rspi_dma_complete, NULL, rspi);
>  		cookie = dmaengine_submit(desc_rx);
>  		if (dma_submit_error(cookie)) {
>  			ret = cookie;
> @@ -577,8 +576,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
>  			/* No callback */
>  			desc_tx->callback = NULL;
>  		} else {
> -			desc_tx->callback = rspi_dma_complete;
> -			desc_tx->callback_param = rspi;
> +			dmaengine_desc_set_callback(desc_tx, rspi_dma_complete, NULL, rspi);
>  		}
>  		cookie = dmaengine_submit(desc_tx);
>  		if (dma_submit_error(cookie)) {
> diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
> index daa4239b0fe04..f17b6d3da5de7 100644
> --- a/drivers/spi/spi-rzv2h-rspi.c
> +++ b/drivers/spi/spi-rzv2h-rspi.c
> @@ -295,8 +295,7 @@ rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *rspi,
>  		return ERR_PTR(-EAGAIN);
>  
>  	if (direction == DMA_DEV_TO_MEM) {
> -		desc->callback = rzv2h_rspi_dma_complete;
> -		desc->callback_param = rspi;
> +		dmaengine_desc_set_callback(desc, rzv2h_rspi_dma_complete, NULL, rspi);
>  	}
>  
>  	return desc;
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 58e306cc730fc..d24b95212ecd8 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -338,8 +338,7 @@ static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  		return -ENOMEM;
>  	}
>  
> -	desc->callback = s3c64xx_spi_dmacb;
> -	desc->callback_param = dma;
> +	dmaengine_desc_set_callback(desc, s3c64xx_spi_dmacb, NULL, dma);
>  
>  	dma->cookie = dmaengine_submit(desc);
>  	ret = dma_submit_error(dma->cookie);
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 89fbdde46cfe9..557c645fcebc6 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -665,8 +665,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
>  		if (!desc_rx)
>  			return -EAGAIN;
>  
> -		desc_rx->callback = sh_msiof_dma_complete;
> -		desc_rx->callback_param = &p->done;
> +		dmaengine_desc_set_callback(desc_rx, sh_msiof_dma_complete, NULL, &p->done);
>  		cookie = dmaengine_submit(desc_rx);
>  		if (dma_submit_error(cookie))
>  			return cookie;
> @@ -684,8 +683,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
>  			goto no_dma_tx;
>  		}
>  
> -		desc_tx->callback = sh_msiof_dma_complete;
> -		desc_tx->callback_param = &p->done_txdma;
> +		dmaengine_desc_set_callback(desc_tx, sh_msiof_dma_complete, NULL, &p->done_txdma);
>  		cookie = dmaengine_submit(desc_tx);
>  		if (dma_submit_error(cookie)) {
>  			ret = cookie;
> diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
> index d03a93d149ecc..c9bf925ee3521 100644
> --- a/drivers/spi/spi-spacemit-k1.c
> +++ b/drivers/spi/spi-spacemit-k1.c
> @@ -294,8 +294,7 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
>  	}
>  
>  	/* When RX is complete we also know TX has completed */
> -	rxdesc->callback = k1_spi_dma_callback;
> -	rxdesc->callback_param = drv_data;
> +	dmaengine_desc_set_callback(rxdesc, k1_spi_dma_callback, NULL, drv_data);
>  
>  	dmaengine_submit(txdesc);
>  	dmaengine_submit(rxdesc);
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index fa0e8e83cb1be..4e202d74c9926 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -374,8 +374,7 @@ static int stm32_ospi_tx_dma(struct stm32_ospi *ospi,
>  	cr = readl_relaxed(regs_base + OSPI_CR);
>  
>  	reinit_completion(&ospi->dma_completion);
> -	desc->callback = stm32_ospi_dma_callback;
> -	desc->callback_param = &ospi->dma_completion;
> +	dmaengine_desc_set_callback(desc, stm32_ospi_dma_callback, NULL, &ospi->dma_completion);
>  	cookie = dmaengine_submit(desc);
>  	err = dma_submit_error(cookie);
>  	if (err)
> diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
> index b77daba6db83a..f9865720c6dd3 100644
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -265,8 +265,7 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
>  	cr = readl_relaxed(qspi->io_base + QSPI_CR);
>  
>  	reinit_completion(&qspi->dma_completion);
> -	desc->callback = stm32_qspi_dma_callback;
> -	desc->callback_param = &qspi->dma_completion;
> +	dmaengine_desc_set_callback(desc, stm32_qspi_dma_callback, NULL, &qspi->dma_completion);
>  	cookie = dmaengine_submit(desc);
>  	err = dma_submit_error(cookie);
>  	if (err)
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 4c3ae546afc05..66932400cf570 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1690,11 +1690,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
>  
>  	if (rx_dma_desc) {
>  		if (rx_mdma_desc) {
> -			rx_mdma_desc->callback = spi->cfg->dma_rx_cb;
> -			rx_mdma_desc->callback_param = spi;
> +			dmaengine_desc_set_callback(rx_mdma_desc, spi->cfg->dma_rx_cb, NULL, spi);
>  		} else {
> -			rx_dma_desc->callback = spi->cfg->dma_rx_cb;
> -			rx_dma_desc->callback_param = spi;
> +			dmaengine_desc_set_callback(rx_dma_desc, spi->cfg->dma_rx_cb, NULL, spi);
>  		}
>  
>  		/* Enable Rx DMA request */
> @@ -1719,8 +1717,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
>  	if (tx_dma_desc) {
>  		if (spi->cur_comm == SPI_SIMPLEX_TX ||
>  		    spi->cur_comm == SPI_3WIRE_TX) {
> -			tx_dma_desc->callback = spi->cfg->dma_tx_cb;
> -			tx_dma_desc->callback_param = spi;
> +			dmaengine_desc_set_callback(tx_dma_desc, spi->cfg->dma_tx_cb, NULL, spi);
>  		}
>  
>  		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 6b7a05dd0de8a..e9fce8618299a 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -232,8 +232,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
>  						 DMA_PREP_INTERRUPT);
>  		if (!rxdesc)
>  			return -EINVAL;
> -		rxdesc->callback_param = sspi;
> -		rxdesc->callback = sun6i_spi_dma_rx_cb;
> +		dmaengine_desc_set_callback(rxdesc, sun6i_spi_dma_rx_cb, NULL, sspi);
>  	}
>  
>  	txdesc = NULL;
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index f43f2df478b45..ffe547d1e3af3 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -480,8 +480,7 @@ static int tegra_spi_start_tx_dma(struct tegra_spi_data *tspi, int len)
>  		return -EIO;
>  	}
>  
> -	tspi->tx_dma_desc->callback = tegra_spi_dma_complete;
> -	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
> +	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->tx_dma_complete);
>  
>  	dmaengine_submit(tspi->tx_dma_desc);
>  	dma_async_issue_pending(tspi->tx_dma_chan);
> @@ -499,8 +498,7 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_data *tspi, int len)
>  		return -EIO;
>  	}
>  
> -	tspi->rx_dma_desc->callback = tegra_spi_dma_complete;
> -	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
> +	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->rx_dma_complete);
>  
>  	dmaengine_submit(tspi->rx_dma_desc);
>  	dma_async_issue_pending(tspi->rx_dma_chan);
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index ed1fcf57dd30d..5aca26549e730 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -440,8 +440,7 @@ static int tegra_slink_start_tx_dma(struct tegra_slink_data *tspi, int len)
>  		return -EIO;
>  	}
>  
> -	tspi->tx_dma_desc->callback = tegra_slink_dma_complete;
> -	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
> +	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->tx_dma_complete);
>  
>  	dmaengine_submit(tspi->tx_dma_desc);
>  	dma_async_issue_pending(tspi->tx_dma_chan);
> @@ -459,8 +458,7 @@ static int tegra_slink_start_rx_dma(struct tegra_slink_data *tspi, int len)
>  		return -EIO;
>  	}
>  
> -	tspi->rx_dma_desc->callback = tegra_slink_dma_complete;
> -	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
> +	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->rx_dma_complete);
>  
>  	dmaengine_submit(tspi->rx_dma_desc);
>  	dma_async_issue_pending(tspi->rx_dma_chan);
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index d8cca3aa276b2..95132d8be9dd6 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -522,8 +522,7 @@ static int tegra_qspi_start_tx_dma(struct tegra_qspi *tqspi, struct spi_transfer
>  		return -EIO;
>  	}
>  
> -	tqspi->tx_dma_desc->callback = tegra_qspi_dma_complete;
> -	tqspi->tx_dma_desc->callback_param = &tqspi->tx_dma_complete;
> +	dmaengine_desc_set_callback(tqspi->tx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->tx_dma_complete);
>  	dmaengine_submit(tqspi->tx_dma_desc);
>  	dma_async_issue_pending(tqspi->tx_dma_chan);
>  
> @@ -550,8 +549,7 @@ static int tegra_qspi_start_rx_dma(struct tegra_qspi *tqspi, struct spi_transfer
>  		return -EIO;
>  	}
>  
> -	tqspi->rx_dma_desc->callback = tegra_qspi_dma_complete;
> -	tqspi->rx_dma_desc->callback_param = &tqspi->rx_dma_complete;
> +	dmaengine_desc_set_callback(tqspi->rx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->rx_dma_complete);
>  	dmaengine_submit(tqspi->rx_dma_desc);
>  	dma_async_issue_pending(tqspi->rx_dma_chan);
>  
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 091a8b8842f58..0083160c15fea 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -452,8 +452,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
>  		return -EIO;
>  	}
>  
> -	tx->callback = ti_qspi_dma_callback;
> -	tx->callback_param = qspi;
> +	dmaengine_desc_set_callback(tx, ti_qspi_dma_callback, NULL, qspi);
>  	cookie = dmaengine_submit(tx);
>  	reinit_completion(&qspi->transfer_complete);
>  
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index eb3485149e75a..fdda26eb311fb 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1021,8 +1021,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
> -	desc_rx->callback = pch_dma_rx_complete;
> -	desc_rx->callback_param = data;
> +	dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, data);
>  	dma->nent = num;
>  	dma->desc_rx = desc_rx;
>  
> @@ -1083,8 +1082,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
>  		return;
>  	}
>  	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
> -	desc_tx->callback = NULL;
> -	desc_tx->callback_param = data;
> +	dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);
>  	dma->nent = num;
>  	dma->desc_tx = desc_tx;
>  
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index 86fce9a571dab..e8344a66e4361 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -418,8 +418,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
>  		if (!rxdesc)
>  			goto out_err_prep;
>  
> -		rxdesc->callback = uniphier_spi_dma_rxcb;
> -		rxdesc->callback_param = host;
> +		dmaengine_desc_set_callback(rxdesc, uniphier_spi_dma_rxcb, NULL, host);
>  
>  		uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
>  		atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
> @@ -445,8 +444,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
>  		if (!txdesc)
>  			goto out_err_prep;
>  
> -		txdesc->callback = uniphier_spi_dma_txcb;
> -		txdesc->callback_param = host;
> +		dmaengine_desc_set_callback(txdesc, uniphier_spi_dma_txcb, NULL, host);
>  
>  		uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
>  		atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
> -- 
> 2.43.0
> 
