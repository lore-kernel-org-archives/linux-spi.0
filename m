Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F73A1A4E;
	Tue, 24 Feb 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945543; cv=fail; b=rOl/rR4NBtE55SAHH7LMkmO9IdtuSpyNy/94sDQ02VPkKlLUhu0eYkg6dHgZHEM1jO5OTmTa4Nbot9VGxQXNs9546F07xTKWOFmmUIlfaJghOHzf/Ol9xgCYBljQmBO/IH5BxevmKvz+1TrglMhgcGT95DB+Dz/WKWp9QS8YR38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945543; c=relaxed/simple;
	bh=qStETXPcJQpMsYxssdMGi4gAb4+yf1x8HE05fUaBkbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=koSbo/L9qNyMZ5Mu5KYDNTgxz1PfO3Yd94bdzaTIyFKpV6Z5E3N+2fcHX+mkmH7KoY9P+cWcvqqoZe8pzk9CqRiC/MjbOVQmUexb+KKQYKtXwq8MZQYDp929C71UXPDzk+G7p2SdUJXa2xpg8Agc+CXWnx4Z7uE9XJ3FoxASqcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWw//hE8; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWw//hE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imv+GC2pAdxxQMM2oi2fnEsIkY0RtFG3Te0ZfkiqAS+FY+ApEoi60SsigEbVctMhu2oCjEq6Ml7IaghdmL09zhM3uC4TrrF27UVp93Jn6z2AZFK3hAw4yo+ExC854NitH4UV/IRM5eQK9g4OkzI4bD+fBuY6wyGO5iy0jfmEsPbPXGQdeKiaXJr4VwlLeoYeJuTB+FmDq5ZX3AqaCUXIi5N9T7aZoqTFIlV32DbWH7bUPGrWfinHSXKb3MT2GcdtaYFGKpdrXs8ua4T5U0NYxPB6BwIwX9fYBE9kIJuAWqr8CqaDX7pkvwLKgDz8DIonFHz3oYvsNCdoAiKZ1eE88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utSQyxhLTQfEf+UFAW0jR5pCLRGdhcZ/vbQyYqWQSRU=;
 b=dRcj77XjCZIxuvsQqSZCVuK82/Q2/3GolLytofPDzlbQyhqytzJ6+7L7qOXQW1F6Z/Xhx9nzc+8x/o6h4hKa0Pzq3Dd7ES1lgKRbZjPb690JLnr6vdWtE8sJcSnTxvrVFtSuzll+htUORbJDwhRL9qrI9zSECC6hXVtEs/DKRa/c0b2mhFniqXEHez8vyWEtk3KmUEqftoFwHntLqbxTF4Iwmwck++4pl5DTbRjltStVYEhUZLJONVj9ps6b+wSFenRRvFX4pi4FhbksmJQwdREJ/g02jSt8o/kMaDS8O0kOuHL4ik+POqJFtMkMz6fGgy/MghZm6x8OHVE1cj/Xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utSQyxhLTQfEf+UFAW0jR5pCLRGdhcZ/vbQyYqWQSRU=;
 b=gWw//hE8/PDgnpiU/+zQKVtiXKFRBdwOXgCa7W8uRC2iVSBANVdxwUTbrH61AXDOekGS+a+JCDwfrXQoF0oI7kcjviti3GkQjR2Ttx796bNgjRF3Yd7Su/doPVWrHxELCblEE9G3NsKfwcvAh/kErf3Veuzp8DmXJolkEsP7cGb82JTBARBo2Y8YsQyDHhbVAIYzgDqs9+RHo+rRqOb7cVVmGCkiQQz2I/RjxJXJhl+FA/IpIG7yzlXEMlSyj0T5TNTRvY8l8vTnGAeeFZZ6P2g2k8sHnq+aIWxg7yC3MHrk+cz+tjuaOxQKBNiPKxrYQ6g0lV7QXrJ2WRjs8o3L1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB8025.eurprd04.prod.outlook.com (2603:10a6:10:1e4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:05:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:05:37 +0000
Date: Tue, 24 Feb 2026 10:05:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: imx952-evk: add MT35XU01G spi nor flash
Message-ID: <aZ2-OV-QcIEOfI0a@lizhi-Precision-Tower-5810>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-3-acc60a5a2a9d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-xspi-imx952-v1-3-acc60a5a2a9d@nxp.com>
X-ClientProxiedBy: PH7P220CA0159.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fddba4-0d92-4d5d-36b7-08de73b62a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWPfM8tGmfZkYgTW1OPAI8g8MT5gTYYZvM6bW6moEUhSk1Vb9LPnqIM5KsTl?=
 =?us-ascii?Q?0nTxsS7XqOjCDgB/UsOWkuA2HvVI/b2UrpA5mVHWZmznbyZYyxpanV3Zrw6n?=
 =?us-ascii?Q?Cb3ruMXcCZhbW9g2mUYFGlUj5aDNjt1PmUMtMQ5vfJS57/ZYUmrqXjf9A1wp?=
 =?us-ascii?Q?gtS5k0yRukgoKVpeSrF4tA61AYgHRlXpG4gdTHyZ5kUKX28EChumnabafWf1?=
 =?us-ascii?Q?waLjcuWh+ViePGX0VcUp2xLQtR8CxCtmgnYZGCRFIBHA5B9Ks21jpF65PF29?=
 =?us-ascii?Q?ocjwRU6+wmW+1rdaUdgVeSZY+Q7Sd5ruRY59mUlIXufQkkCBJJZ+xfc9zrGT?=
 =?us-ascii?Q?va+VC8Z4yQvyb8IJHCPX343j3oEW4FLraeVzsFRbxzno3gpHzjPXRCgc9x/4?=
 =?us-ascii?Q?5hVs9g1CFcYFQo5xEcyRYAOJwqOrvle+xfMFpraMcBKDRfYg+ckz73dUlAKr?=
 =?us-ascii?Q?uhyxbV0Dx8R0apb1FGVJWvF48yGa+q4ZFcl6lji3QvJFum+u5P1JxG0RIUU0?=
 =?us-ascii?Q?xWH9B9/gBux1tzzWYyInxw3I6stFDluEw++LDLuiIuNDHhCcvt9f4B3M/uI6?=
 =?us-ascii?Q?pBsbYcJyoB3APImOTKanaPwB58kprtcl+W/orQh4CC68LM8udPyPTomXzGYP?=
 =?us-ascii?Q?PiD7zVo+P22lpsdzmnWhLqRzvhH4cRaAU6zHoK4NMuhTxYiCxuQUM7EN/s/d?=
 =?us-ascii?Q?i2tCNWKfXqSFTq8xxEtTWepgCdv3HbIifyJarTS3YoD5e4swIvdnK6DCkgYb?=
 =?us-ascii?Q?oQZlsGK1Ccmna9FqNcaXpVNyHsRqrupBiLzO3Fc6Ums85HLtWwxEWEdMXjZ+?=
 =?us-ascii?Q?agVIpz1h/W0S2wWThZKZx3yfxgNsFTdDL10q7kZxFVZcrz6EpeAsMojZHakY?=
 =?us-ascii?Q?dy+d0tfWAH4LyLmjFH5E0o+8gbo/EbZz6DbRi/Cl/N08fg7TfjF/5gdrLwDE?=
 =?us-ascii?Q?SPieOKQki9kIcDA+uMb/bi4dj0UFGW4qvkcFoSh/WOxljM1Xu/CqR2T+Ywdn?=
 =?us-ascii?Q?DlZv5NaLfamjblyLimRHaGR9LeCrWlcfOfdBrCijICbqhOmiokGUpvKxUNaR?=
 =?us-ascii?Q?sGcI+tk5xVB3IXjtdZx5B0e3uqHTqJ8nKAttIIDu9jqv0jIk9ExSs43RhRZM?=
 =?us-ascii?Q?hCwK1EnnJUVzQp9wbG3Z/FWAeZ58vI3o1r4NKSKpT2io4smW+koqLKfsc6+Z?=
 =?us-ascii?Q?hWgWjaEfy0Qk2otSzvnlUkZl74jhwtthIb2bZBvsxBrymAYNDOiPSIwvJiJo?=
 =?us-ascii?Q?VxwotHDca0Fgr+0m7anz/SblWI6ILIeP8RxMi/cPeqrNrdtV2U0V/d7pp6AL?=
 =?us-ascii?Q?Yl+33xNM6sYffH86xlPLXjfcp1SwaTHn+q8Vtny9NPuWJXBeFkL3qfr5XMKZ?=
 =?us-ascii?Q?UX0IbkGd8lCKAc9j4ClAUcTdfYtXEJCOu/EqoO9CSXetX6Z5QJ6GwkVqc0y3?=
 =?us-ascii?Q?LjqtbMmZqiLxhBlpl057D2hJnPgCZ4/Z4MzZH1yQUXADZQ0LkTV6dzDvOIPa?=
 =?us-ascii?Q?McUFsJtGZrxT3jdTPDJklDP1KMgGaGdtKwOG/Q5OfKQMSwnsKVMzeFv+Uquf?=
 =?us-ascii?Q?KB55wFO9JV/XJ9bzc6Q7N/R5oh3xummpE+7zsXoBee8knSITqoXM8uH9F+1v?=
 =?us-ascii?Q?aPIyDRCmC/TlF8tJFrwQFOI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3L2P1Rv++MXXKOPr7d5CoTNu1bEhaW35GsYZJ5gjhHp9/m52NmAzMHxWWOS?=
 =?us-ascii?Q?/0xZJOPBZWx8lemB+uv4uWTorX6TgvNlLRoUa8/ikgKeuRvCI06cqYmxAm41?=
 =?us-ascii?Q?geGIYiXnPcAw/xm8WiCPRwWRqcKyGeQmAwmWO49GkPzj9BSA1SY7BrHOg3Os?=
 =?us-ascii?Q?T+ATIj1MQtU0WcZpozDMF+1oJ1S8VVop7tRxmnqS2cU+aeWvUxeF/+w/AEMe?=
 =?us-ascii?Q?sZWlHlxWXjWfzsuIaSWFY4qE1Bg4yKECmr9Y6NINyP0FhRXBMmS9dOkDrZ78?=
 =?us-ascii?Q?oVR4gy9rOyyK9HrbGE5IbyH+QAN+o2WXAtNRvODwTXIdGds0bdIAgqaw/WbT?=
 =?us-ascii?Q?+S/2EVAC3GNdL0V6qW/Ia5W+J+pD/14dJTJBLs9XXYvB/nkSpVubQ5SqtT/R?=
 =?us-ascii?Q?aL5QD0M68gNfi9dnqHT+QJeAZIMf0oPO8gfS+xIG0SvDGHu0+6mT1LthPN3k?=
 =?us-ascii?Q?ICOcyw7Vx8DdSGvlKzYl/UgKrr5rBKAuwMFdzlsI/myfbM2y4OC3GWtBJWU4?=
 =?us-ascii?Q?p2jmRDPRpxXRw+wmD02EhfB6k62iz/tEOQeHwh8vItziQtYc3Lq9r7fMyk18?=
 =?us-ascii?Q?GtLTh8sM8P2GMY1VwzCULizdM6J2BTmDs6PPyXmpRZARPweBTv0E9WOfJGXn?=
 =?us-ascii?Q?DnmkZCVhcylPAOnyB9oIES/bSRUEx5LqwVSq7YX1lzy+mTGJLtN3qKlkZdQ6?=
 =?us-ascii?Q?9m2evxgTXcVb1iY5iZYYFymWTQXWLYuGRzH5o2mn4WRTuNOgeL1GmQ7UsLFG?=
 =?us-ascii?Q?6Kjip4/DDXCAPxYbRHRKibj+q2muRIrgtP86fAwBtVv7FukxcvFR2VOSdu2j?=
 =?us-ascii?Q?AGJkaCWgFUFQmpg+ShGsyK0t/8nvUqWqgPeNbWTd9zZKWeRNgoQLVykHmiWK?=
 =?us-ascii?Q?JjsXsDvbtkziIFEiOYsd5ltombZ6yKYJdfibtZFjwM3kJDme0OamTFhSePch?=
 =?us-ascii?Q?S51dVWJ8GWbafMKFlE3/Z2GZAL9hRnszAGTgFntkxCSXFAaZl6ng+oE8U9Mg?=
 =?us-ascii?Q?Ee0yqc5Z2dsNk74Z1BmfnHefJ//qY0k8n/WN0R0P61A6K6qW1cMF2fit07+e?=
 =?us-ascii?Q?h/EoDdH+qVwRk4WjkjWeYvXiPR6S2JrGW9zLUjOUTaeToTn79T+dd7LQcA2E?=
 =?us-ascii?Q?qzu8hzEy7KFvM+jr/7w2L93io8NCimoCozqtY485AUQRNWwRxtT+m7SWYB5R?=
 =?us-ascii?Q?WTkf+EDA56bRlEWsHYbz2e6jUmnSKwb4cYajTHW5BBzuCvKb/f46W1C6oF1j?=
 =?us-ascii?Q?dB6Cg4rtfQTyFY3j8d4ST00a67KSOIgBs53XV1o5oMVb8tst/sVwuSENiRY7?=
 =?us-ascii?Q?S5VF6/XPIDfp1n52ZkyCMzAejbGkk17uat0NRY2Y3sjJyZQMmXk7KWKj37kX?=
 =?us-ascii?Q?ySqg6MRU7x+F+7MaR6Af/KOmyAIKbcTgUmIgaUJ/XHX/nGJMdkgU8GzgiA58?=
 =?us-ascii?Q?YSfA4g6fS5zvryZSaDWFVVe6+GwSOV6pFt6x+RBgwcxVEUzvwari1EM44CjS?=
 =?us-ascii?Q?scDkyhhs0w6mw4orCBu+Yc59UnPUn4qKmlQHM187wzBFUqocihr+pye9woTO?=
 =?us-ascii?Q?TaVzOGBCONVA5Q6FKzdLMr6NBQWUXq4zRKAZfbrSFC44gq7xDhAk5NDQ4+4T?=
 =?us-ascii?Q?AV8PqdiGNIv4GZGTxZHEks8pwhvVDqzfJ9NMVd8hZdDiGFs1Rt5PEWBqdtlL?=
 =?us-ascii?Q?qtVN3nayQFl6XHIQpPLHvhjaTi4u1gptj8oGdd0Qa/Pfrqer?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fddba4-0d92-4d5d-36b7-08de73b62a96
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:05:37.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHU6mFiOvNDQ5bI3rYMlq0D/C6rbiJZw+GRDZGjXoPn3Z26a7qNoQewFFZi545Io20UMWpO+0CQs+Kzh8iPCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8025

On Wed, Jan 14, 2026 at 02:49:47PM +0800, Haibo Chen wrote:
> Add spi nor flash MT35XU01G support, it support OCT DTR mode
> at 200MHz.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx952-evk.dts | 41 ++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx952-evk.dts b/arch/arm64/boot/dts/freescale/imx952-evk.dts
> index 2c753fcbae3c5d545f5d835bd70492667061d626..534c93e527d0f3fb14ff3f21114993aae1d88a88 100644
> --- a/arch/arm64/boot/dts/freescale/imx952-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx952-evk.dts
> @@ -111,6 +111,25 @@ &usdhc2 {
>  	status = "okay";
>  };
>
> +&xspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_xspi1>;
> +	status = "okay";
> +
> +	mt35xu01gbba: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_xspi1_reset>;
> +		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <200000000>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +	};
> +};
> +

Can't apply, please rebase.

And move &xspi1 after &scmi_iomuxc to keep alphabet order

Frank

>  &scmi_iomuxc {
>  	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>  		fsl,pins = <
> @@ -214,4 +233,26 @@ pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  			IMX952_PAD_SD2_CD_B__WAKEUPMIX_TOP_GPIO3_IO_0		0x31e
>  		>;
>  	};
> +
> +	pinctrl_xspi1: xspi1grp {
> +		fsl,pins = <
> +			IMX952_PAD_XSPI1_DATA0__WAKEUPMIX_TOP_XSPI1_A_DATA_0		0x39e
> +			IMX952_PAD_XSPI1_DATA1__WAKEUPMIX_TOP_XSPI1_A_DATA_1		0x39e
> +			IMX952_PAD_XSPI1_DATA2__WAKEUPMIX_TOP_XSPI1_A_DATA_2		0x39e
> +			IMX952_PAD_XSPI1_DATA3__WAKEUPMIX_TOP_XSPI1_A_DATA_3		0x39e
> +			IMX952_PAD_XSPI1_DATA4__WAKEUPMIX_TOP_XSPI1_A_DATA_4		0x39e
> +			IMX952_PAD_XSPI1_DATA5__WAKEUPMIX_TOP_XSPI1_A_DATA_5		0x39e
> +			IMX952_PAD_XSPI1_DATA6__WAKEUPMIX_TOP_XSPI1_A_DATA_6		0x39e
> +			IMX952_PAD_XSPI1_DATA7__WAKEUPMIX_TOP_XSPI1_A_DATA_7		0x39e
> +			IMX952_PAD_XSPI1_DQS__WAKEUPMIX_TOP_XSPI1_A_DQS			0x39e
> +			IMX952_PAD_XSPI1_SCLK__WAKEUPMIX_TOP_XSPI1_A_SCLK		0x39e
> +			IMX952_PAD_XSPI1_SS0_B__WAKEUPMIX_TOP_XSPI1_A_SS0_B		0x39e
> +		>;
> +	};
> +
> +	pinctrl_xspi1_reset: xspi1-reset-grp {
> +		fsl,pins = <
> +			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x39e
> +		>;
> +	};
>  };
>
> --
> 2.34.1
>
