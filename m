Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91763F86F5;
	Thu, 18 Jun 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787980; cv=fail; b=db2YhaCdF2rziSZfV18WICRRmh/SF31xsgdWWwgsuNvppDcRu1F4uxhk2QjH+1RaYjXXF0bWObG1N9Z+RlJDGASDsE/P5k9g107jFTU+LA0kNbs0dqn59VtMtkUL7le6I/iBKu+YiUcBAEMgiPPXossuYVTHlRGC2Rj9LqsKWmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787980; c=relaxed/simple;
	bh=LG3LyAJrDNqb+8X8QlDKnyyI4KEOQHK2KoJo5len4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ysn6YmP5YF54wrj3Y5GBhHcUZmuLFSiM76J8oHYZp23BVBtV/nTsbSApynla/EK0Uoo2kotGt8yTxc31LUddjYO0BuXR2AdKYm8jwrCimZS7psFK/7br1dW9EBAshfohZjyLGo+SutE/9xPU2ROADWj3WEf83WR9u1aKm8c5bBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wnxlYboI; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wnxlYboI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9U1yaZRtPRyZcIIM5TTBsTDkCzLDoIYpwSRt3KMN/FQdFWu/fjQyQkrfguDs7AsxRm4EPEMB0lxttL8zrLD/49JLbcOMCgqSC/zrGt+fSc0ITYxX7DSGG5s81ZDsCMG6PAGkDP0CPCFxlytQOfAt4Niz2BWepdw70GkgBUjvHsA0Qs/Azzjf19wud2FBGEh/AlMI9pLlSn4V50xOOsIhEYVipY42HAHz4Yk8htE8FwgbEbqffpwVgDIvRtQUtO+Xe+8dL3fWY341Yzbd3E+7BTYrkn+4pKStbjGz7nukSyqSbMLGPSwHSNrz2ubD+UgGAQ7ngoDBn7RCWno0tTwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqkg75G097CH6HFQYXE7QbI9sRRpTucHzkHMOzLIMx4=;
 b=OIN2gh0qtAPY3wbZ178Agmt7vT/FJ53cUVGcRV2w3F2LhtajbIVdHzXv/gk6CLfRJxGi0aI847db4kSLmYDN4vegcGAbJp+uibac/DHXoCB8IWgnKkh9fPkEvCYDcRtSHO6x9h89CUzFtiBPEYJaWbHkgFwqZEBKVPr/vwyKLExWB8bT6kc7Ph2+lxmzRLQNMps4MwFbCiOmCyBNQFYQ/zFq28exEX8DR/Wk5zQYJkFWnXo32cnGFe1gxxxifCpePQT/j1V2Lx63IWlhaHUbWpnR1KM9Wt4u+QKmCS0vmOBA88b5yXh0TRYMqKPnnIpIZbDS2FMtR4D2HHWhQQwBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqkg75G097CH6HFQYXE7QbI9sRRpTucHzkHMOzLIMx4=;
 b=wnxlYboIOXJMTMrH4MiUVj6+NkYVRvAyIvO756zDAnDMbR7gvQNScm2ov9XR+TACNO6UgWqis1kbqypFpRbbrJJt0uu9qKTnDoAL4dICQSG2JKzyANuOycLJ+kwaiEBNsrozNP0OxN468DOgq78ysV/M9tTcIhSgRJZ333itx6gCUNzKQ1yNh2mUi4u+H+TSQog3EK1eXDtXsIjlh4pt7ANBiQuJKtF5KrHCs+gHFQShnrbdzyaDSCTOoaFWcd9FVcj1ai1iJd5sLR+r7kcIYgWqZQWnb3UeaSVCG/9eiAQgUU1KWZ6DyfSoJUw7g+MsPkObEf0YBLRKe5gRn3qxWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 13:06:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 13:06:14 +0000
Date: Thu, 18 Jun 2026 08:06:04 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: han.xu@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: spi: nxp,imx94-xspi: add DMA properties
Message-ID: <ajPtPOiTQSJ4FhTP@SMW015318>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
 <20260617215520.3327836-3-han.xu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617215520.3327836-3-han.xu@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d6eba0-7433-456b-07d7-08decd3a601b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	e12qD1t3KSPeRny3Mf1wrQJQvsF6klRYY2msE+BCci6Jdr10ej9QWMi3cDmRZloIysAkurBzPJ8Av64MuCOJOpFHKjudlbCliQ9K4o7P40pRcSUXsSsLltJD9sFM83S/Wc4eq1ayJaOHOXAfOyDS6XsXUyGssSqoKdyaf/ZPX79uMCdVxViqotMds0yZMVAdsUr1tUrT7MK+ON3A2Un5gjLWA5bJJ+Y/DMG4g3CqIAq1ff0G6bfyCWtqk9UgTNL9gJqWkOFk/Sxia3TrHUZkcrJbowD6RsOoL5bc+PgWC4DOerjdfiBWRz9hFX/4ije12W/vHeMeYwA6IlsqE/0Rk2n4gLp98kDjw7N3JFislvZVMU+l0ku8NGBOaarl2eTPegPWT5c/88C63oVoIpSFzEeNDshjCuKJj72rHAjShyOo4XfjAU0QniwSKO8Q/sRUhG6uhyHdHCgI4/ZUbFl3YDO3mdRylbKAV13zzKUHNHwpiEPFSgk8ptZ8+YZDUs4fsoeJ+hzg4jDPuLwj4VOidv4cEA7jJkrwmt5OtUM0RBDuZ4wt/uaMLUfOzCKSRd3V5Fkdnf7byfpi40jWeA5mkTYNLqgEolMmRMoMxZ+xjlJvvVXWPn4YpP/W/XJlu2137m5i2ETTYj1x9xVMvxdGft9JWlPYA3ozDJlpan5P/OO2dXobC1wvf/3XJhIzWRLN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpUY4hYn8YDnI7jVch/dQ/N8hsNKUjZ8Zz1olrHqpnb9U577iajG5buhvcZf?=
 =?us-ascii?Q?PXmRsvZASDmhTjrEEFgeZjkc9FT0sEWDYGSekppMlaTd3Ij7Okmefp8kgNcu?=
 =?us-ascii?Q?2UnQfQMdlUrLwkkx1k2JVP19n91HB0NKnbgj91YQeyyUS+eQi70blbkqK8iG?=
 =?us-ascii?Q?eXdIocxE8QEGaOHJlibJ59xoQCLshuk6YcMYZe9HiHAaTNhgIQ1LT2YCYLAI?=
 =?us-ascii?Q?CG+B2YqdUlHvrbTTw3HM5/kAmYpsawweWbwmeI+aHTNy5H/ApDRPZkZUAEPs?=
 =?us-ascii?Q?NafkMKXIj5TbAyCMv3Ay4e81drAkKD7I0tR/BIJ2K75WmOxvQ5nBNIoiNC3A?=
 =?us-ascii?Q?DkJj+BNUx/ly2s5mRis3CeEHjYJ5VAl/cjahT4cj67rtVXYmXdBTTytTY11y?=
 =?us-ascii?Q?Lwa93WnZqdFiJOE+cEGZgAgDIzwuIH9sofhQJAOZwppBTEMVy6nkrA+2FuUN?=
 =?us-ascii?Q?m93X0VzHIB+VqANd5c5PAnfppOVSJl3eYPEm5/XPo162Q1BXkpALZusuuxBo?=
 =?us-ascii?Q?4oyZDEnnrRMNPSg/db+M4OckFJ3tbTN4rfm78C/fSa+0nX6sy4JUyXA+ajVG?=
 =?us-ascii?Q?W/AGBS4gSqGqXjkV4hxev9PD/Sw9x/JaAz812tnapSsJNGTq4KYtvJP1vuYw?=
 =?us-ascii?Q?jfG77IW9LmSPh4T3IX1sEIz9YHfFKgCq5LDq+iHLNovIpbuaY/ybuJYnNsGl?=
 =?us-ascii?Q?pyTjOEoG94lXswjoLSvBluLfJcPGeCnoaAT7NkJaTU9jwPEcLw/82mVF+SS6?=
 =?us-ascii?Q?c26MKlNK1dpQ4pdGN38ojyEroSc/JO01pS2iHGzwsM5HRYFjdfLPXNsNKLLN?=
 =?us-ascii?Q?Fz0P+/UbMibV2KEgcoavbqA/jTatWRiL1EPQwIVlzSX34mxTRS9C0HZfEp01?=
 =?us-ascii?Q?e/Dpk6Dw+ZRwr/xe04JBYhf+tAas7pjGwTMT6IZVrmZ7L1XW1F0PqjnGKwLJ?=
 =?us-ascii?Q?64ZqwiYAXPG+aVKlhV6OxrgbGr+RebgXvqyTDQo10GLQA/U4Ig+4B3jzqkIm?=
 =?us-ascii?Q?WX3mV/aTH4SmMLNluH5ZKgFTyDAfTMd55L92sf2FFQV/7lgjA9VR3knj5AFA?=
 =?us-ascii?Q?zDFDIb5q17bCoHCuQpgLZKE8FYVHulNpxtyTHkkH6iAoLm7C2T2qji1SvgDg?=
 =?us-ascii?Q?Z+2zNG6p1Ra0yH0gNrUL6wC9UKgbrrjpnIiFQllspafHgrVIBAy2opfrGg91?=
 =?us-ascii?Q?wko2x7BbC8iwNLdgiOtEYsTIhMaV1vQh7coRv1ymCpE7ITNoQ2LlCYWlqbP2?=
 =?us-ascii?Q?ZmaUHz3Mey5hq/Ulks70bbgILGpgOwTbGpcMtXs3d5h4I6rTh+H8nlQetLp/?=
 =?us-ascii?Q?5Dp/kDos8NSQlqZqMqU1qgWK3orGk4PQPe/jR9DYhATP5Tf3IZP/tXv6mgZt?=
 =?us-ascii?Q?Trx2MdZXhabgq0KcH4QqINpyvj97lCqwNm8jweclhrl2aFAL38fM5j7i1Ge6?=
 =?us-ascii?Q?/DriQHDbpc3Bp9ru4b9C8LgwQEyGWaGRPbJ3tk1o77J/HInjFz8CrbPbBa+c?=
 =?us-ascii?Q?J48SWdjNdMQqLvX/r7y0DlmziFQlXCYNxk5vzK5SWEdJuSpkh2ZYiLnO5eym?=
 =?us-ascii?Q?JmZvc1mRwsixL90+FkaWXwN0jznP7u0UWbztMDHo8sTs6uz7OyEJxuCyvXKl?=
 =?us-ascii?Q?IraHuTFMUzSjJ12rjRsVvkSNO+qg6mtIGNsigsj3lVLGxontMRTWxMKOaV5q?=
 =?us-ascii?Q?MIPblzQWV6OH6itW186ZZ0fLVr5Zk2ZyyrtSQGvb36Nj68p7CE+H4LC++Ym4?=
 =?us-ascii?Q?aVzeY/0aH1A4y1G56gqfrSbfmWM6rzxaT7Y9IjtOiFB7GSf8q7kt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d6eba0-7433-456b-07d7-08decd3a601b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:06:14.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLrbBbnD0vv7vJq0PGDsuhKdOT7V/sgm/Kqd73pmloaN5wQEOdlGi9tjhFQu74tZqfIb++igLi0YH1DfMVJduN9uZCuFQuEw72FdUjuQPI+yMMrDjbBtatAgA1x2N6Q5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196

On Wed, Jun 17, 2026 at 04:55:19PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>
> Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
> XSPI controller.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---

This patch should be fix one.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/spi/nxp,imx94-xspi.yaml        | 10 ++++++++++
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
> --
> 2.34.1
>
>
