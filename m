Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793805786;
	b=2QYM/HbdlrOx2rHqWpbUDavuRlFk+RVGSIt9vWFcbwPKHwF9RRXaMDMn7yBHPS/ZTJmh
	 WydjiDeMegx6YfWmDYPMnMjUzBTHNG50xtilUDfKPaA6fHjwb9VQ31Lk876OjL0KXlSJs
	 5LwkEdIPTN7sZXg9gMXxNN0c+1VZNC8HwimuZyGJ76PVqgDo0KcUOvvU3K690UBHVZ23r
	 pqzNGS+yA1cq5E5wW2FcSQrv93bqZwdXaDJ72oEd/xl8dfpqlM16twI1uUzNqBx1Jl1oT
	 lKUfB03h2ESlyLr/n96kKEhHgMZqyB24fBnVFsWhQh4YHKhkqkHYm6U5Oh9BBR8Wdvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805786;
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
	bh=4+HgKOHYxpgYyNPWAf8RtEC85RW7IbzPnxAGpyARVyU=;
	b=xYJeSptkzreCPTwDntzrl09ojsvwm9oHNQh6PZHwb9vLvITGPAbX6Zsp5+s5n5UFCRKv
	 NV2JFB+eoYHbUthrTV/vmKRRcbSX7EmBfYTT7x52gzt+KAesLjopQ6cz4aaCxss7Xb6wN
	 +5E+Wev+j0zybDcXtbpKqbA5SGZqPkQXMzwBZhDqS5eOBTZ4RYQ/Ny1xGS5bwiZl63H+u
	 cj3Icn4ROmxTRHJ0C2gn4KzAgWMqdAlXDdCFfQ2UiTvisE4g9HhTrO+len9zupPtE8Das
	 bIOnAV+yNxd8z8f3EriFDUcR7gd61r3p6IDUB+4WgOveFk5l0PJxAtl2KJxfPEQhrug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V3RMM7Vz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE894606A326;
	Wed,  4 Nov 2026 15:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE894606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=V3RMM7Vz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+217clKtAJS9fUcB1WFBSzt5j8tiNzvh+ekvQoug8jrYYy+KysfVyh9A6J6nTt7oqN8bJqo7MyKiWisXVDaDeEKhFsQWKFeWmpRG5NjaZJ8EdNqIbhEwXs0Am+0Gs+nCMs3jZ4OOFHqZjdM5pKdD6jsMJilHISlEs0v49UUZXg3QbCjTMydiBab4NzpawD43bZc67p0jISH6HByZpGSR3VZy88uh4H2EB+VzZSbULEqnQS24ryiGJdzmyWyv1ncqqSVGm0g4hvCGjdgEKf44U7X+lBUqqUmrkj9CMpJ4K8hf2Qf1w9dwHUMZqW0F7UlpP2V+K+478JnBFaD4dWvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+HgKOHYxpgYyNPWAf8RtEC85RW7IbzPnxAGpyARVyU=;
 b=vDtwyD3LNFTE9PGHdnYU9ApC3wIzZ5z07NpKVwPGSgs6Kft5cuH8KYTT3Mryid2aRynf19nPdewiiZBw6AB5mmv5gOCL9sQZp6Bx1Zbv94TeYqPgHLdiYhQeunoteHZddxtrvQUs+i8UUyLi6kMsSglJxY8zY7ifmGwg92sFp2G6KV29/E728GoR0XwrLjE2fMBffGNC/C0KST98oRWXp7k/Lo6oxBKUogGrRU2mSqpT1FVc6oHaMsvN+QVi1eZCvSdg88Q4w/7WP0y6T/AcmL67NVcWN4FlFXKhzJ2I8Lf0uAmPrLDW8fLFCYnjYnk/NV7IrG5PMCSuODI65Wjr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+HgKOHYxpgYyNPWAf8RtEC85RW7IbzPnxAGpyARVyU=;
 b=V3RMM7VzPdOZJu8O/+OfxsldHmtEYVSO4Fmwrr3hGy8aHg2aLXO8Klvb9r2UNUdHFoPpyz7ey/Qdbf1NjyIq4dNWQmm3BZfqQ7+XvwWqgatQYyjE/iGaCogkdnI57OIryRfKywvGWqVaD77U3Hcl9d+WUP8g2QkiG0ZnL6cKeStflkr6Ju9QSZCeD1615PRwfffCF92KCkG2JsQZ6txRtuvd0o/C9VqcVONiZHOp0+WFrJKCpJXDpL7MA/lvqxcDN+lwkQ2VRImtvTK0ubC6rhKLEDv8nEjL2GEWrBR2U2hEMQoJg9GY65VMeH30YR7j+wJo7GZkN/OehwynAtPXCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU6PR04MB11135.eurprd04.prod.outlook.com (2603:10a6:10:5c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:23:00 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:23:00 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	CL Wang <cl634@andestech.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
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
	Alim Akhtar <alim.akhtar@samsung.com>,
	Yixun Lan <dlan@kernel.org>,
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
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	imx@lists.linux.dev (open list:FREESCALE DSPI DRIVER),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS RZ/V2H(P) RSPI DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SPI DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Cc: imx@lists.linux.dev,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Date: Wed,  4 Nov 2026 10:22:45 -0500
Message-ID: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU6PR04MB11135:EE_
X-MS-Office365-Filtering-Correlation-Id: 950e1d8a-dd25-4e19-6aac-08df3a8782fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|921020|261009223327099003|261021135927099003|11063799006|261022105027099003|56012099006|261009221727099003|261009221227099003|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261026121527099003|261022075727099003|261009220027099003|261026140227099003|261028144727099003|10067099003|18002099003|6133799003|41080700001;
X-Microsoft-Antispam-Message-Info:
	YBFV/gthlVTD3kZUmdUnPd4Wzl368b/2fmGPGbVh6fEcUYsDH/1o0S6eldyTEoJORGhtYnTZorshsyOZrHtKQWfsqq1WsHty+SNpG5tpPMLIc73v/o5N0I3PglKpXFXwt2XHKwyqlQM7TeC3eUuAePUYJnXGYFD3OzDrrGLx+eMzteeYVSZmxSClP2xC4ADX9TY+NZCX1H9K6xKQ9AKgt233EI9i3iJpHEYhYmGRUXLDd2kbYrWansNPaTZ7qrqCgKEhu1aEveIORdvTzR3AXyUPTT5Gdje+tX7CyfS005YNah3C2E9wjb4gVwrdmJ6yQPIG8ojD3PaGO9Fs8hcX6fjqnFwwNqAJrR3PPCfvnkxqTpx2bpAFTEDZ3EZUpnR+oqp/y/WdaqdWpP7k37ux17Qzrm5gljBiDpretVCwrqx0MHkvGXzNzxHDbwa1nsLZXu8onTnwubqQxFJYrNI4YecmyYF+wYtanHUMG00u6kA55YG0MlMt87sZCuUOM3biXHYQE5KPaY6amtxlSnomjGmos6vXJ0lR50ziyC+axH+SGxSbRLQDmyTC65+V8Hm3wVLTI02r2AaQ3pWdnqHEsk+KnBnCE3omEPmvW0OE3gv16n9gmeS8aOGlP3oHfkiyXAWBQ0T1eqt7HYNm5CCt3Zwz9AcIku2xsrZxs+NOW8gDfLs7b3GfUAahePeoGzMFaUyyzlCnsubGSHC6NnA1hOE7YxwWeyUTsqX6yhx91V5GWigcY1sdptiEGXP28bzy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(921020)(261009223327099003)(261021135927099003)(11063799006)(261022105027099003)(56012099006)(261009221727099003)(261009221227099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022075727099003)(261009220027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(6133799003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3E9Mrl4buHObD4Aqscix7RIXTDLh4OSNI2GtBwksyGMCUlnvq88jqfSfwz+R?=
 =?us-ascii?Q?Pzv/I5J3kwrEfIGZ38wug9mjJl+Y4Kq2MyVzJuCQQEUe/Ky5Q4FcKA8lzCpB?=
 =?us-ascii?Q?hvRSuxXiX0jTaXCn68RFFCn7WWEKxDtK2hfK02L2SsVZiNPuUrZh7QPfhn3/?=
 =?us-ascii?Q?b8vEZ6LMVZ5iTcoEnmhWz6QgbNB2DpDf32Aajrf4N4CumA+3sYIlkHlXXSni?=
 =?us-ascii?Q?XKVnB/wL3T5mBE+xxH6qp1Rz1I0UIDxntfCQ88sml83K6mVCRW+LVnlgR2EV?=
 =?us-ascii?Q?9yZ6yXNgePpqAGiKtU7455cyXyeBTNJWcreuWiDpb6+X556zqkrLZN649ti0?=
 =?us-ascii?Q?wVxzEFqfyxPgUXej96i+88V/B8SkscSrcmG3M9r1VaSNYTveZUNR3MDYhBCP?=
 =?us-ascii?Q?p0YT4RK2EK1LwPui1DscRbL0s+lJSedNPgrubQKAmUQGSUamb68omGkLMdC5?=
 =?us-ascii?Q?x4ViQZjJGN2CRzkN2K8GUlM6zg/4uBpAH7cpi6ytJPutlbtuHl23PgUsuVVv?=
 =?us-ascii?Q?PWb579YzN3yLs7Okl1QSi+VDZ4cUunq5Rsnz5SjKoPPj2Og7GN6r0QceFSoR?=
 =?us-ascii?Q?KPtR5FqfsCOs1gTgcGXtyufXsGLLg0zlGK9ZUqebhe186L+pMuCJsWXirWC+?=
 =?us-ascii?Q?qNg3ehwKtIaa0Np/OVaV76QZPMrKQwkZmwJ6ERgfLpy2i7b1D61iRqI8Txgf?=
 =?us-ascii?Q?cfuKapV+FbIlqkI5Jg8SwtfR4kEHECaFOtRCzJT+BCXhBV+MOAQkeitWf6MT?=
 =?us-ascii?Q?WDx6252OVwrt7MTIRrzjQ2QrZ4MBbC4FhW15HYOxsz8vkQmSwO9gzZiYw2kC?=
 =?us-ascii?Q?RTbOAo0yfjtzvk6huM4lB7XorBMmRukXaeAKRf4l0Q5umKWQOR15Z/0Zjg7c?=
 =?us-ascii?Q?/p4faeGGt4R8k4LMTbTiFvxFPZx4MOkIzfJofOC1MRN5ewkWv3BEFyZPdY7p?=
 =?us-ascii?Q?fD3lR+keVUPFIkQF2qTBgJvvHPojr3hoV9eC7XX1Te+6eXJoMJda50QivJhE?=
 =?us-ascii?Q?Ud/dbQXDjGGProxT/Vwi7pVoedZ+bH73L6kpGuGs4c7yW3al+FEtMaBLZG+x?=
 =?us-ascii?Q?puy6HaJVQJARoLgXzAK0iWOUSYyiAd4YMh7tMXcbiPI8/GoGFD8bDkdHhX23?=
 =?us-ascii?Q?e9yyWqX55mj7maXA3Uf/s+UeG/0N3L4d8xqLLqNI/pUE0XN+dr5rKxgr9LMs?=
 =?us-ascii?Q?R/D+l1NtgO6A9OKHAHqyiYG2MdbPrhjB1rkcU504haNPSSKqG36EC6uB/T5w?=
 =?us-ascii?Q?xIvOwyvhPLx/y3K7ZMzZqteKI80WdeeLiGWBWRJEFr2LfPinFPaXYqnrynuF?=
 =?us-ascii?Q?LJGxFkms79bHFIvqQnlP1DBuq0hOIYU6xXwCXtTqjsp+LrsnD28yF1QizGe4?=
 =?us-ascii?Q?kl6iFWO/lMlRXJ1yaBLpBuw8zYTLS++7hNC079HEzQGwLV8JLC7dSQ7CJ2wx?=
 =?us-ascii?Q?kmtcGmNNSL3QiSChauOS2q3ADNN3tTJAZlHMbfRcyqsAtaZdtsl5btKn5Ijl?=
 =?us-ascii?Q?qt2O4H5CsoThZeWVqH/ekJrMaPeziohmzPWPWrEA/suGgYxY30z2WFFDNMWU?=
 =?us-ascii?Q?zJ3Vct2FeEc84qs9lxXLAxc9KFyj9WlGCQQ2anTouetXenVO8YfUyFZtF19M?=
 =?us-ascii?Q?NVTswEt8ZDtcApqwuPPmTWRTe66LI6dUsfXJ3d6D72dgEkvcatnY0/W1bqYp?=
 =?us-ascii?Q?vRrd+UhM2ZhLmQnfXfgPYRIpNeq3Nw7YmQ/pRpCDx+IpCvMxDuD+opkVpG1v?=
 =?us-ascii?Q?44kogol8moRxFx22sbSJM9G1xjkSA4vDOK8IPi9OQInYsTBPr2Wv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950e1d8a-dd25-4e19-6aac-08df3a8782fa
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:23:00.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlKeDxwBIA8XW4rbSYG7B4h/W0B+xutCoeJbVV4paeFM7USkbkyhO5OaMkVrsPIANC+aNOgzT7n64ML+t2S075IH0JTrh85vRSY5ElrRdyk8MboVUcW2jXdAYXAPiDmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11135

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across SPI bus drivers.

No functional change intended. Prepare make to struct
dma_async_tx_descriptor private to the DMA engine.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add missed set_callback in rspi_dma_transfer() (sashiko
- collect review by tags
- drop void *
---
 drivers/spi/atmel-quadspi.c       | 3 +--
 drivers/spi/spi-at91-usart.c      | 3 +--
 drivers/spi/spi-atcspi200.c       | 3 +--
 drivers/spi/spi-atmel.c           | 3 +--
 drivers/spi/spi-bcm2835.c         | 6 ++----
 drivers/spi/spi-cadence-quadspi.c | 3 +--
 drivers/spi/spi-davinci.c         | 6 ++----
 drivers/spi/spi-dw-dma.c          | 6 ++----
 drivers/spi/spi-ep93xx.c          | 3 +--
 drivers/spi/spi-fsl-dspi.c        | 6 ++----
 drivers/spi/spi-fsl-lpspi.c       | 6 ++----
 drivers/spi/spi-geni-qcom.c       | 3 +--
 drivers/spi/spi-img-spfi.c        | 6 ++----
 drivers/spi/spi-imx.c             | 6 ++----
 drivers/spi/spi-ingenic.c         | 3 +--
 drivers/spi/spi-mxs.c             | 3 +--
 drivers/spi/spi-nxp-xspi.c        | 3 +--
 drivers/spi/spi-omap2-mcspi.c     | 6 ++----
 drivers/spi/spi-pic32.c           | 3 +--
 drivers/spi/spi-pl022.c           | 3 +--
 drivers/spi/spi-pxa2xx-dma.c      | 3 +--
 drivers/spi/spi-qup.c             | 3 +--
 drivers/spi/spi-rockchip.c        | 6 ++----
 drivers/spi/spi-rspi.c            | 8 +++-----
 drivers/spi/spi-rzv2h-rspi.c      | 3 +--
 drivers/spi/spi-s3c64xx.c         | 3 +--
 drivers/spi/spi-sh-msiof.c        | 6 ++----
 drivers/spi/spi-spacemit-k1.c     | 3 +--
 drivers/spi/spi-stm32-ospi.c      | 3 +--
 drivers/spi/spi-stm32-qspi.c      | 3 +--
 drivers/spi/spi-stm32.c           | 9 +++------
 drivers/spi/spi-sun6i.c           | 3 +--
 drivers/spi/spi-tegra114.c        | 6 ++----
 drivers/spi/spi-tegra20-slink.c   | 6 ++----
 drivers/spi/spi-tegra210-quad.c   | 6 ++----
 drivers/spi/spi-ti-qspi.c         | 3 +--
 drivers/spi/spi-topcliff-pch.c    | 6 ++----
 drivers/spi/spi-uniphier.c        | 6 ++----
 38 files changed, 57 insertions(+), 113 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 762a3fb0fca81..de205e04a8600 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -790,8 +790,7 @@ static int atmel_qspi_dma_xfer(struct atmel_qspi *aq, struct dma_chan *chan,
 	}
 
 	reinit_completion(&aq->dma_completion);
-	tx->callback = atmel_qspi_dma_callback;
-	tx->callback_param = aq;
+	dmaengine_desc_set_callback(tx, atmel_qspi_dma_callback, NULL, aq);
 	cookie = dmaengine_submit(tx);
 	ret = dma_submit_error(cookie);
 	if (ret) {
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index aadcdf734fb03..8b56ac1dcad8e 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -228,8 +228,7 @@ static int at91_usart_spi_dma_transfer(struct spi_controller *ctlr,
 	if (!txdesc)
 		goto at91_usart_spi_err_dma;
 
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = ctlr;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, ctlr);
 
 	cookie = dmaengine_submit(rxdesc);
 	if (dma_submit_error(cookie))
diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index b532c58c0ab91..c807e730ca94c 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -340,8 +340,7 @@ static int atcspi_dma_trans(struct atcspi_dev *spi,
 	}
 
 	reinit_completion(&spi->dma_completion);
-	desc->callback = atcspi_dma_callback;
-	desc->callback_param = &spi->dma_completion;
+	dmaengine_desc_set_callback(desc, atcspi_dma_callback, NULL, &spi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
 	if (ret)
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc896e4621ac..ffc1292b08c10 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -867,8 +867,7 @@ static int atmel_spi_next_xfer_dma_submit(struct spi_controller *host,
 	spi_writel(as, IER, SPI_BIT(OVRES));
 
 	/* Put the callback on the RX transfer only, that should finish last */
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = host;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, host);
 
 	/* Submit and fire RX and TX with TX last so we're ready to read! */
 	cookie = dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cc57489732816..a71048a88c58a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -706,11 +706,9 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	 * RX-only transfers; else by the TX channel for TX-only transfers.
 	 */
 	if (!is_tx) {
-		desc->callback = bcm2835_spi_dma_rx_done;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_rx_done, NULL, ctlr);
 	} else if (!tfr->rx_buf) {
-		desc->callback = bcm2835_spi_dma_tx_done;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, bcm2835_spi_dma_tx_done, NULL, ctlr);
 		bs->target = target;
 	}
 
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73ea51c41f955..6e7c8b54e0377 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1395,8 +1395,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		goto err_unmap;
 	}
 
-	tx->callback = cqspi_rx_dma_callback;
-	tx->callback_param = cqspi;
+	dmaengine_desc_set_callback(tx, cqspi_rx_dma_callback, NULL, cqspi);
 	cookie = dmaengine_submit(tx);
 	reinit_completion(&cqspi->rx_dma_complete);
 
diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 087735ed9c80c..baa642c1429a4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -703,10 +703,8 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		if (!txdesc)
 			goto err_desc;
 
-		rxdesc->callback = davinci_spi_dma_rx_callback;
-		rxdesc->callback_param = (void *)dspi;
-		txdesc->callback = davinci_spi_dma_tx_callback;
-		txdesc->callback_param = (void *)dspi;
+		dmaengine_desc_set_callback(rxdesc, davinci_spi_dma_rx_callback, NULL, dspi);
+		dmaengine_desc_set_callback(txdesc, davinci_spi_dma_tx_callback, NULL, dspi);
 
 		if (pdata->cshold_bug)
 			iowrite16(spidat1 >> 16, dspi->base + SPIDAT1 + 2);
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b706770334a61..94810f9dd5c5d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -397,8 +397,7 @@ static int dw_spi_dma_submit_tx(struct dw_spi *dws, struct scatterlist *sgl,
 	if (!txdesc)
 		return -ENOMEM;
 
-	txdesc->callback = dw_spi_dma_tx_done;
-	txdesc->callback_param = dws;
+	dmaengine_desc_set_callback(txdesc, dw_spi_dma_tx_done, NULL, dws);
 
 	cookie = dmaengine_submit(txdesc);
 	ret = dma_submit_error(cookie);
@@ -498,8 +497,7 @@ static int dw_spi_dma_submit_rx(struct dw_spi *dws, struct scatterlist *sgl,
 	if (!rxdesc)
 		return -ENOMEM;
 
-	rxdesc->callback = dw_spi_dma_rx_done;
-	rxdesc->callback_param = dws;
+	dmaengine_desc_set_callback(rxdesc, dw_spi_dma_rx_done, NULL, dws);
 
 	cookie = dmaengine_submit(rxdesc);
 	ret = dma_submit_error(cookie);
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d8f4aa38685f5..6832869bc73bf 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -418,8 +418,7 @@ static int ep93xx_spi_dma_transfer(struct spi_controller *host)
 	}
 
 	/* We are ready when RX is done */
-	rxd->callback = ep93xx_spi_dma_callback;
-	rxd->callback_param = host;
+	dmaengine_desc_set_callback(rxd, ep93xx_spi_dma_callback, NULL, host);
 
 	/* Now submit both descriptors and start DMA */
 	dmaengine_submit(rxd);
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f03488870d024..aee0393f9a832 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -581,8 +581,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EIO;
 	}
 
-	dma->tx_desc->callback = dspi_tx_dma_callback;
-	dma->tx_desc->callback_param = dspi;
+	dmaengine_desc_set_callback(dma->tx_desc, dspi_tx_dma_callback, NULL, dspi);
 	if (dma_submit_error(dmaengine_submit(dma->tx_desc))) {
 		dev_err(dev, "DMA submit failed\n");
 		return -EINVAL;
@@ -600,8 +599,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EIO;
 	}
 
-	dma->rx_desc->callback = dspi_rx_dma_callback;
-	dma->rx_desc->callback_param = dspi;
+	dmaengine_desc_set_callback(dma->rx_desc, dspi_rx_dma_callback, NULL, dspi);
 	if (dma_submit_error(dmaengine_submit(dma->rx_desc))) {
 		dev_err(dev, "DMA submit failed\n");
 		return -EINVAL;
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b25f94b2ef738..c7aba0d777470 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -634,8 +634,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 	if (!desc_rx)
 		return -EINVAL;
 
-	desc_rx->callback = fsl_lpspi_dma_rx_callback;
-	desc_rx->callback_param = (void *)fsl_lpspi;
+	dmaengine_desc_set_callback(desc_rx, fsl_lpspi_dma_rx_callback, NULL, fsl_lpspi);
 	dmaengine_submit(desc_rx);
 	reinit_completion(&fsl_lpspi->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
@@ -648,8 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
 		return -EINVAL;
 	}
 
-	desc_tx->callback = fsl_lpspi_dma_tx_callback;
-	desc_tx->callback_param = (void *)fsl_lpspi;
+	dmaengine_desc_set_callback(desc_tx, fsl_lpspi_dma_tx_callback, NULL, fsl_lpspi);
 	dmaengine_submit(desc_tx);
 	reinit_completion(&fsl_lpspi->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 91e75e213f929..e239c4333055b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -506,8 +506,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		return -EIO;
 	}
 
-	tx_desc->callback_result = spi_gsi_callback_result;
-	tx_desc->callback_param = spi;
+	dmaengine_desc_set_callback(tx_desc, NULL, spi_gsi_callback_result, spi);
 
 	if (peripheral.cmd & SPI_RX)
 		dmaengine_submit(rx_desc);
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 76dcb283d1225..53370cff7e2cd 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -334,8 +334,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
 		if (!rxdesc)
 			goto stop_dma;
 
-		rxdesc->callback = img_spfi_dma_rx_cb;
-		rxdesc->callback_param = spfi;
+		dmaengine_desc_set_callback(rxdesc, img_spfi_dma_rx_cb, NULL, spfi);
 	}
 
 	if (xfer->tx_buf) {
@@ -358,8 +357,7 @@ static int img_spfi_start_dma(struct spi_controller *host,
 		if (!txdesc)
 			goto stop_dma;
 
-		txdesc->callback = img_spfi_dma_tx_cb;
-		txdesc->callback_param = spfi;
+		dmaengine_desc_set_callback(txdesc, img_spfi_dma_tx_cb, NULL, spfi);
 	}
 
 	if (xfer->rx_buf) {
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index cadf0b93f4403..dc58d898cfba4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1738,8 +1738,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 		return -EINVAL;
 	}
 
-	desc_rx->callback = spi_imx_dma_rx_callback;
-	desc_rx->callback_param = (void *)spi_imx;
+	dmaengine_desc_set_callback(desc_rx, spi_imx_dma_rx_callback, NULL, spi_imx);
 	cookie = dmaengine_submit(desc_rx);
 	if (dma_submit_error(cookie)) {
 		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
@@ -1756,8 +1755,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	if (!desc_tx)
 		goto dmaengine_terminate_rx;
 
-	desc_tx->callback = spi_imx_dma_tx_callback;
-	desc_tx->callback_param = (void *)spi_imx;
+	dmaengine_desc_set_callback(desc_tx, spi_imx_dma_tx_callback, NULL, spi_imx);
 	cookie = dmaengine_submit(desc_tx);
 	if (dma_submit_error(cookie)) {
 		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index a0a047510611e..9567ddde06ef0 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -157,8 +157,7 @@ spi_ingenic_prepare_dma(struct spi_controller *ctlr, struct dma_chan *chan,
 		return ERR_PTR(-ENOMEM);
 
 	if (dir == DMA_DEV_TO_MEM) {
-		desc->callback = spi_ingenic_finalize_transfer;
-		desc->callback_param = ctlr;
+		dmaengine_desc_set_callback(desc, spi_ingenic_finalize_transfer, NULL, ctlr);
 	}
 
 	cookie = dmaengine_submit(desc);
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index fda1d260b2966..eabea73a19fc7 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -267,8 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 	 * The last descriptor must have this callback,
 	 * to finish the DMA transaction.
 	 */
-	desc->callback = mxs_ssp_dma_irq_callback;
-	desc->callback_param = spi;
+	dmaengine_desc_set_callback(desc, mxs_ssp_dma_irq_callback, NULL, spi);
 
 	/* Start the transfer. */
 	dmaengine_submit(desc);
diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 38c8d6269aadd..e532b2da54835 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -872,8 +872,7 @@ static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
 		goto err_unmap_src;
 	}
 
-	desc->callback = nxp_xspi_dma_rx_callback;
-	desc->callback_param = xspi;
+	dmaengine_desc_set_callback(desc, nxp_xspi_dma_rx_callback, NULL, xspi);
 	reinit_completion(&xspi->dma_rx_c);
 	dmaengine_submit(desc);
 	dma_async_issue_pending(chan);
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index e46b1d9c8cd08..56fc8211a752f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -436,8 +436,7 @@ static int omap2_mcspi_tx_dma(struct spi_device *spi,
 	if (!tx)
 		return -EIO;
 
-	tx->callback = omap2_mcspi_tx_callback;
-	tx->callback_param = spi;
+	dmaengine_desc_set_callback(tx, omap2_mcspi_tx_callback, NULL, spi);
 
 	return dma_submit_error(dmaengine_submit(tx));
 }
@@ -525,8 +524,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		goto out_free_sg;
 	}
 
-	tx->callback = omap2_mcspi_rx_callback;
-	tx->callback_param = spi;
+	dmaengine_desc_set_callback(tx, omap2_mcspi_rx_callback, NULL, spi);
 	ret = dma_submit_error(dmaengine_submit(tx));
 	if (ret)
 		goto out_free_sg;
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 8363bc873b03a..b6a6929cbb0c2 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -330,8 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	}
 
 	/* Put callback on the RX transfer, that should finish last */
-	desc_rx->callback = pic32_spi_dma_rx_notify;
-	desc_rx->callback_param = pic32s;
+	dmaengine_desc_set_callback(desc_rx, pic32_spi_dma_rx_notify, NULL, pic32s);
 
 	cookie = dmaengine_submit(desc_rx);
 	ret = dma_submit_error(cookie);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 3ff30486b2892..9f98f95bb534c 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -956,8 +956,7 @@ static int configure_dma(struct pl022 *pl022)
 		goto err_txdesc;
 
 	/* Put the callback on the RX transfer only, that should finish last */
-	rxdesc->callback = dma_callback;
-	rxdesc->callback_param = pl022;
+	dmaengine_desc_set_callback(rxdesc, dma_callback, NULL, pl022);
 
 	/* Submit and fire RX and TX with TX last so we're ready to read! */
 	dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index c94d1d192e743..0e7ad7fb48eb2 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -154,8 +154,7 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
 	}
 
 	/* We are ready when RX completes */
-	rx_desc->callback = pxa2xx_spi_dma_callback;
-	rx_desc->callback_param = drv_data;
+	dmaengine_desc_set_callback(rx_desc, pxa2xx_spi_dma_callback, NULL, drv_data);
 
 	dmaengine_submit(rx_desc);
 	dmaengine_submit(tx_desc);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e8b076b1622d3..6be0b942d7c4e 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -429,8 +429,7 @@ static int spi_qup_prep_sg(struct spi_controller *host, struct scatterlist *sgl,
 	if (IS_ERR_OR_NULL(desc))
 		return desc ? PTR_ERR(desc) : -EINVAL;
 
-	desc->callback = callback;
-	desc->callback_param = qup;
+	dmaengine_desc_set_callback(desc, callback, NULL, qup);
 
 	cookie = dmaengine_submit(desc);
 
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a81fd94b4396..f8d6cea2f3dad 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		if (!rxdesc)
 			return -EINVAL;
 
-		rxdesc->callback = rockchip_spi_dma_rxcb;
-		rxdesc->callback_param = ctlr;
+		dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb, NULL, ctlr);
 	}
 
 	txdesc = NULL;
@@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			return -EINVAL;
 		}
 
-		txdesc->callback = rockchip_spi_dma_txcb;
-		txdesc->callback_param = ctlr;
+		dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb, NULL, ctlr);
 	}
 
 	/* rx must be started before tx due to spi instinct */
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c61edd1c1353b..a1e5fae8563fd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -553,8 +553,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 			goto no_dma_rx;
 		}
 
-		desc_rx->callback = rspi_dma_complete;
-		desc_rx->callback_param = rspi;
+		dmaengine_desc_set_callback(desc_rx, rspi_dma_complete, NULL, rspi);
 		cookie = dmaengine_submit(desc_rx);
 		if (dma_submit_error(cookie)) {
 			ret = cookie;
@@ -575,10 +574,9 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 		if (rx) {
 			/* No callback */
-			desc_tx->callback = NULL;
+			dmaengine_desc_set_callback(desc_tx, NULL, NULL, NULL);
 		} else {
-			desc_tx->callback = rspi_dma_complete;
-			desc_tx->callback_param = rspi;
+			dmaengine_desc_set_callback(desc_tx, rspi_dma_complete, NULL, rspi);
 		}
 		cookie = dmaengine_submit(desc_tx);
 		if (dma_submit_error(cookie)) {
diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index daa4239b0fe04..f17b6d3da5de7 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -295,8 +295,7 @@ rzv2h_rspi_setup_dma_channel(struct rzv2h_rspi_priv *rspi,
 		return ERR_PTR(-EAGAIN);
 
 	if (direction == DMA_DEV_TO_MEM) {
-		desc->callback = rzv2h_rspi_dma_complete;
-		desc->callback_param = rspi;
+		dmaengine_desc_set_callback(desc, rzv2h_rspi_dma_complete, NULL, rspi);
 	}
 
 	return desc;
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 58e306cc730fc..d24b95212ecd8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -338,8 +338,7 @@ static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
 		return -ENOMEM;
 	}
 
-	desc->callback = s3c64xx_spi_dmacb;
-	desc->callback_param = dma;
+	dmaengine_desc_set_callback(desc, s3c64xx_spi_dmacb, NULL, dma);
 
 	dma->cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(dma->cookie);
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 89fbdde46cfe9..557c645fcebc6 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -665,8 +665,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		if (!desc_rx)
 			return -EAGAIN;
 
-		desc_rx->callback = sh_msiof_dma_complete;
-		desc_rx->callback_param = &p->done;
+		dmaengine_desc_set_callback(desc_rx, sh_msiof_dma_complete, NULL, &p->done);
 		cookie = dmaengine_submit(desc_rx);
 		if (dma_submit_error(cookie))
 			return cookie;
@@ -684,8 +683,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 			goto no_dma_tx;
 		}
 
-		desc_tx->callback = sh_msiof_dma_complete;
-		desc_tx->callback_param = &p->done_txdma;
+		dmaengine_desc_set_callback(desc_tx, sh_msiof_dma_complete, NULL, &p->done_txdma);
 		cookie = dmaengine_submit(desc_tx);
 		if (dma_submit_error(cookie)) {
 			ret = cookie;
diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index d03a93d149ecc..c9bf925ee3521 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -294,8 +294,7 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
 	}
 
 	/* When RX is complete we also know TX has completed */
-	rxdesc->callback = k1_spi_dma_callback;
-	rxdesc->callback_param = drv_data;
+	dmaengine_desc_set_callback(rxdesc, k1_spi_dma_callback, NULL, drv_data);
 
 	dmaengine_submit(txdesc);
 	dmaengine_submit(rxdesc);
diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 1340e62ebe1b6..afb30af9421f6 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -374,8 +374,7 @@ static int stm32_ospi_tx_dma(struct stm32_ospi *ospi,
 	cr = readl_relaxed(regs_base + OSPI_CR);
 
 	reinit_completion(&ospi->dma_completion);
-	desc->callback = stm32_ospi_dma_callback;
-	desc->callback_param = &ospi->dma_completion;
+	dmaengine_desc_set_callback(desc, stm32_ospi_dma_callback, NULL, &ospi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	err = dma_submit_error(cookie);
 	if (err)
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index b77daba6db83a..f9865720c6dd3 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -265,8 +265,7 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 
 	reinit_completion(&qspi->dma_completion);
-	desc->callback = stm32_qspi_dma_callback;
-	desc->callback_param = &qspi->dma_completion;
+	dmaengine_desc_set_callback(desc, stm32_qspi_dma_callback, NULL, &qspi->dma_completion);
 	cookie = dmaengine_submit(desc);
 	err = dma_submit_error(cookie);
 	if (err)
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c3ae546afc05..66932400cf570 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1690,11 +1690,9 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 	if (rx_dma_desc) {
 		if (rx_mdma_desc) {
-			rx_mdma_desc->callback = spi->cfg->dma_rx_cb;
-			rx_mdma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(rx_mdma_desc, spi->cfg->dma_rx_cb, NULL, spi);
 		} else {
-			rx_dma_desc->callback = spi->cfg->dma_rx_cb;
-			rx_dma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(rx_dma_desc, spi->cfg->dma_rx_cb, NULL, spi);
 		}
 
 		/* Enable Rx DMA request */
@@ -1719,8 +1717,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	if (tx_dma_desc) {
 		if (spi->cur_comm == SPI_SIMPLEX_TX ||
 		    spi->cur_comm == SPI_3WIRE_TX) {
-			tx_dma_desc->callback = spi->cfg->dma_tx_cb;
-			tx_dma_desc->callback_param = spi;
+			dmaengine_desc_set_callback(tx_dma_desc, spi->cfg->dma_tx_cb, NULL, spi);
 		}
 
 		if (dma_submit_error(dmaengine_submit(tx_dma_desc))) {
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6b7a05dd0de8a..e9fce8618299a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -232,8 +232,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 						 DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
-		rxdesc->callback_param = sspi;
-		rxdesc->callback = sun6i_spi_dma_rx_cb;
+		dmaengine_desc_set_callback(rxdesc, sun6i_spi_dma_rx_cb, NULL, sspi);
 	}
 
 	txdesc = NULL;
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f43f2df478b45..ffe547d1e3af3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -480,8 +480,7 @@ static int tegra_spi_start_tx_dma(struct tegra_spi_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->tx_dma_desc->callback = tegra_spi_dma_complete;
-	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->tx_dma_complete);
 
 	dmaengine_submit(tspi->tx_dma_desc);
 	dma_async_issue_pending(tspi->tx_dma_chan);
@@ -499,8 +498,7 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->rx_dma_desc->callback = tegra_spi_dma_complete;
-	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_spi_dma_complete, NULL, &tspi->rx_dma_complete);
 
 	dmaengine_submit(tspi->rx_dma_desc);
 	dma_async_issue_pending(tspi->rx_dma_chan);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1fcf57dd30d..5aca26549e730 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -440,8 +440,7 @@ static int tegra_slink_start_tx_dma(struct tegra_slink_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->tx_dma_desc->callback = tegra_slink_dma_complete;
-	tspi->tx_dma_desc->callback_param = &tspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tspi->tx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->tx_dma_complete);
 
 	dmaengine_submit(tspi->tx_dma_desc);
 	dma_async_issue_pending(tspi->tx_dma_chan);
@@ -459,8 +458,7 @@ static int tegra_slink_start_rx_dma(struct tegra_slink_data *tspi, int len)
 		return -EIO;
 	}
 
-	tspi->rx_dma_desc->callback = tegra_slink_dma_complete;
-	tspi->rx_dma_desc->callback_param = &tspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tspi->rx_dma_desc, tegra_slink_dma_complete, NULL, &tspi->rx_dma_complete);
 
 	dmaengine_submit(tspi->rx_dma_desc);
 	dma_async_issue_pending(tspi->rx_dma_chan);
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d8cca3aa276b2..95132d8be9dd6 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -522,8 +522,7 @@ static int tegra_qspi_start_tx_dma(struct tegra_qspi *tqspi, struct spi_transfer
 		return -EIO;
 	}
 
-	tqspi->tx_dma_desc->callback = tegra_qspi_dma_complete;
-	tqspi->tx_dma_desc->callback_param = &tqspi->tx_dma_complete;
+	dmaengine_desc_set_callback(tqspi->tx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->tx_dma_complete);
 	dmaengine_submit(tqspi->tx_dma_desc);
 	dma_async_issue_pending(tqspi->tx_dma_chan);
 
@@ -550,8 +549,7 @@ static int tegra_qspi_start_rx_dma(struct tegra_qspi *tqspi, struct spi_transfer
 		return -EIO;
 	}
 
-	tqspi->rx_dma_desc->callback = tegra_qspi_dma_complete;
-	tqspi->rx_dma_desc->callback_param = &tqspi->rx_dma_complete;
+	dmaengine_desc_set_callback(tqspi->rx_dma_desc, tegra_qspi_dma_complete, NULL, &tqspi->rx_dma_complete);
 	dmaengine_submit(tqspi->rx_dma_desc);
 	dma_async_issue_pending(tqspi->rx_dma_chan);
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6908dc3621fd9..8e872eb57c57d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -456,8 +456,7 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 		return -EIO;
 	}
 
-	tx->callback = ti_qspi_dma_callback;
-	tx->callback_param = qspi;
+	dmaengine_desc_set_callback(tx, ti_qspi_dma_callback, NULL, qspi);
 	cookie = dmaengine_submit(tx);
 	reinit_completion(&qspi->transfer_complete);
 
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 1f53d62f37267..c78d3fa0a5a7f 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1022,8 +1022,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		return;
 	}
 	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
-	desc_rx->callback = pch_dma_rx_complete;
-	desc_rx->callback_param = data;
+	dmaengine_desc_set_callback(desc_rx, pch_dma_rx_complete, NULL, data);
 	dma->nent = num;
 	dma->desc_rx = desc_rx;
 
@@ -1084,8 +1083,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		return;
 	}
 	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
-	desc_tx->callback = NULL;
-	desc_tx->callback_param = data;
+	dmaengine_desc_set_callback(desc_tx, NULL, NULL, data);
 	dma->nent = num;
 	dma->desc_tx = desc_tx;
 
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 86fce9a571dab..e8344a66e4361 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -418,8 +418,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
 		if (!rxdesc)
 			goto out_err_prep;
 
-		rxdesc->callback = uniphier_spi_dma_rxcb;
-		rxdesc->callback_param = host;
+		dmaengine_desc_set_callback(rxdesc, uniphier_spi_dma_rxcb, NULL, host);
 
 		uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
 		atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
@@ -445,8 +444,7 @@ static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
 		if (!txdesc)
 			goto out_err_prep;
 
-		txdesc->callback = uniphier_spi_dma_txcb;
-		txdesc->callback_param = host;
+		dmaengine_desc_set_callback(txdesc, uniphier_spi_dma_txcb, NULL, host);
 
 		uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
 		atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
-- 
2.43.0

