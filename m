Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793711183;
	b=ftQF6gEUMShjDgO3zF+m/YIjr4L9qhW/ye6UcKWKIyx3BJfDJzT0PElMaPMaG/waRcsw
	 G3lohEdDVk9QD/MiFpkFKL9bEuhnbehc8pOuUdvANWtWefWwoBT4qIj7dKaj3XaJj0Usb
	 xbjsDzPycxVdd3oZJPvZc4NAfPJj+EJJzuY3XNXm9zef5tW+2A4kfYjrnGpF2STMUuhs3
	 Ca1jx3RdTmqkXTgU6ByObxY3yrRwJ2rxt+yfCrBUEofnczcx8UYeUHXpDJuhYN/1RgxXi
	 vYaLWeytXQ3p1xr4/3C6ew5Fgn+xOOdR4WQgZ1X9t8CgdYkQdvphBSXtZP5cjUC5b8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711183;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Disclaimer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IDhXslPpLUjpmgJ9lF7wLDQiPC8B9j6Mf5c17GbQios=;
	b=Z44q+lo+8mD7WTPOFrB1GA5sMSTZUWJqm1CMLsQgLq8AgavOOx443r/GYmH6jnyFixrO
	 V+9JIfirVLf0NatzGX2p211er8poc2+yY32fpqXdPROXyTeXEOyRURy3RIUbl5yHyLWUh
	 n8yESFhP+VXJwSPv8nuYhMM+Sf7zixZ7J/+c9mF4woC8fvtHiC7DRSMT1P7fggagGQnNm
	 HIKTRkUNksS9zMZD/5O/amEyK1ueqjNp8UWWY1QDMzeijJ2vzVdugbRtcifwtxbUc8M39
	 dhsoRTcCyVuCGlKsilWIcXTURiMS1c2C8YtlQrn+Q/vfeJ7MUogolk3PLxTq9hTy0VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Tlk9CB2V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.47
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FD606EE96;
	Tue,  3 Nov 2026 13:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404FD606EE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Tlk9CB2V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuX63EqfmQxhi0BPjm4/sVUeJbR/xreWewgObOj4VQ8y8lVEqLv8BVovsUGhg2b7fWK2L+IzxDa6MbWVKbC5An0D+fPtdbcOMnqQS6o47WDzMBD39BCH21+hWmmmZojSQ1AJpR18gkyEwA5LCBiNkg4pXOmnOHiJATug7rQ1JB9SH36XBOAKU6qWLExOZWgdByMb2RUuXbhyp1sWOGhtpsA4YHRV7PDLQqrZIgeTUKkZcn18Ngk4KBVEmBsZks84YzqvsMkOHvrXTZajXu932uUgPeqpTcR/gBN6+qXcLTlLUx691P+YiTXWDuxflpDAOCe85wQg6ZVDbhtl8ppGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDhXslPpLUjpmgJ9lF7wLDQiPC8B9j6Mf5c17GbQios=;
 b=ShvrnUpxpi+lX3A/lmDV+P6d1Jj3ydGxGrmXTGVWF+W+3VUASub6sOFsoOekiOimAQooxPVWE/90i0JekJ8QOwAKssKYch0ZxShMz2w4huEdIGrMYZwDbDP+1ly+4re1j/jD249FJIICbgue/jT0LF93dRY0L1DroAp2elgbeIcWpbxMhTEgYtcaU3okfBzol66vnYCoMjbLd7ODakqKsQfnsheQE1+yGNRYGE03K+KWnbwu6S8m3HST08boUO9gefvzJ4xG8Eu5p0gWPwF+dcqO378cwyMEdwMntVI6lJKJiui1uxbr5krd8NmI4u0Duywt56cdxTMDa/yxOm7FSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDhXslPpLUjpmgJ9lF7wLDQiPC8B9j6Mf5c17GbQios=;
 b=Tlk9CB2VhhLRqkwigzKpCwkIOVBT6xmRqkSNOjm1g2kpUf1+KfEwT0U5iBvxOpB5vwm8Jcfyf9f1fKplZzToN3Xuz/7tpuN9EZBgd9w1gCsLNrgru7bSxcZYnc0FFC4sETSoUPEgddD5nFZzGqvdwpIndX79APSQhu97FdjnwtoLEOAjvkM4HwDugSM0k1xXuC6i/YFilrtvQbXQ0lLZjLdR4QwXNmcAUFgln2HDUnryxls+Xo/6QsR6SfdNb9vwJ/dos4OiWdc+kWls9OJh11XoHB/iGg5m+fZcpC/X4+RPnmfQ8s2icHiy4wPT2xCMOW5iHYASiEob2RVB/sclQw==
Received: from AS9P309CA0008.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:45d::15)
 by GVSPR10MB953803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:71d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 13:06:15 +0000
Received: from AM1PEPF000C1AD7.eurprd02.prod.outlook.com
 (2603:10a6:20b:45d:cafe::2b) by AS9P309CA0008.outlook.office365.com
 (2603:10a6:20b:45d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.3 via Frontend Transport; Tue, 3
 Nov 2026 13:06:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1AD7.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:06:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 3 Nov
 2026 14:06:22 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 3 Nov
 2026 14:05:51 +0100
Date: Tue, 3 Nov 2026 14:05:49 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: <Frank.Li@oss.nxp.com>
CC: Mark Brown <broonie@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>, "Ryan
 Wanner" <ryan.wanner@microchip.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Han Xu <han.xu@nxp.com>, Haibo Chen
	<haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Daniel Mack <daniel@zonque.org>,
	"Haojian Zhuang" <haojian.zhuang@gmail.com>, Robert Jarzmik
	<robert.jarzmik@free.fr>, Heiko Stuebner <heiko@sntech.de>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Andi Shyti <andi.shyti@kernel.org>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>, Troy Mitchell
	<troy.mitchell@linux.spacemit.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM
 ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "open list:FREESCALE
 DSPI DRIVER" <imx@lists.linux.dev>, "open list:ARM/QUALCOMM MAILING LIST"
	<linux-arm-msm@vger.kernel.org>, "open list:ARM/Rockchip SoC support"
	<linux-rockchip@lists.infradead.org>, "open list:RENESAS RZ/V2H(P) RSPI
 DRIVER" <linux-renesas-soc@vger.kernel.org>, "open list:SAMSUNG SPI DRIVERS"
	<linux-samsung-soc@vger.kernel.org>, "open list:RISC-V SPACEMIT SoC Support"
	<linux-riscv@lists.infradead.org>, "open list:RISC-V SPACEMIT SoC Support"
	<spacemit@lists.linux.dev>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>, "open list:ARM/Allwinner sunXi
 SoC support" <linux-sunxi@lists.linux.dev>, "open list:TEGRA ARCHITECTURE
 SUPPORT" <linux-tegra@vger.kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <auncLWeLzd8OL9SQ@gnbcxd0016.gnb.st.com>
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD7:EE_|GVSPR10MB953803:EE_
X-MS-Office365-Filtering-Correlation-Id: b77f3807-152a-4efe-e3aa-08df39ab3e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|11063799006|261022105027099003|261026140227099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|261009223327099003|261028144727099003|261021135927099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	ZjzWigixUF1WXu4m54pXncf6zJcdHsviUVaBb9yW9UQs5zdJBPcfld3tL7opRqei5bXcaJ2vhbcrKdQCNi6uRzC2bad26Sqa/ZrX2BCmX3aHTPsXkoSuefNVeBHhb6KOrQW+VJRqVOAjxFQvM1ItsaBiWM8U/MnLzk0jwBPum73P2pTBnHjO925JbXXYYOuWlLcDHUbU50mWp7RLJkja6sE0wWEfAqPecGUhRYzo/OJRqDEUsGth6VqGN5sFYq1orHR+TwNBrJZmvo0fgSEknnwAK7CvRow54sZhyTS4tsnmrWyLv3E5Nagpmkj8TvSWUMuRITnMbceQHEioD9XNMbNGCG1PHcYRRZRD9d4u1u10Oey6s1WP5reHhm4bv2MzNMxvuvbpZ9lPOLtZju5j6ITSmMt+snBfodCoATwNEiehyeida6xSaNnF3JzOwb2YWqbD+p+kHwTe7PApXWQIUUMBZOnSiDc91ef5okhuRxS2YPsZqP5oDZs7BGOgTAe2vJp4qCIC4oieNnIW2UwLtpQ875EemCCGezdDSnAwkP5tiFnnBx8Ay/63MB4IAChV93Vys1axSReM4k+Gk7nT74GDYJQ3+5wL7GtCJcAT3P/SPfVXGCdP/GniY9qGP6WFHrSFH6CluFPtLKQ+K83Hhn/k+rFElkaTum4pvJ3YLVTAC7aRsjTHPE4TcIaSac+xtzDylyOXRlMLqUDcDosSldNruuWobdHt78IA36Nbj+7GZXwA7n/EdUu8Q2P30F3rbWftLqPx8iGpwk+288j/7Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261028144727099003)(261021135927099003)(261021121427099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XQ7uq+C8+wjt39eT63XGGSwIvkGlwUfA/5kYIh0DgP3VJ0tkzh7pGUomg5JB0E+vIYr901g5oQsY9gQnHSJXXqyManmUCqremKfjlJLsPIiUnpUSnH1JiWoU6OEN7nMG3dJ2gE0kk+sW2qMxt/1GN5G+lLXs8Rq3Q+OuZUtLTGQ2baZrHZp0ShXJ0bysnclJG5NFu9j66wkDtgPQZYKZ8JRxKFIyJGylvQzP028+eL2VvuOX6kK+Q3fq39jnXyR0h2UI2053kofmsjg9bHLUvT7HW8pp9ptYXmJjX63cmHBhAi+b0LRYcOF/hN4AlQgLLlATTgebrmCYO4WMrWuTlhBGXxpTgomumpKS752oP8JekjW1MWa07O1H8XR9F/l66G+TlXkxruTXLZfrPu0h8CqbXF9epUPveVGD0z9RVTRRxN7RPxwRoG3QOOl4dUis
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:06:15.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f3807-152a-4efe-e3aa-08df39ab3e4c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR10MB953803

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

For the spi-stm32.c
Acked-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain
