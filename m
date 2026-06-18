Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1E3E7BA9;
	Thu, 18 Jun 2026 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788161; cv=fail; b=Rytxqq077RyFYfeE9mf1uWmP7QbOC3t2ShKJvLggqMwZGX41ruGyLXiCBhWMbsY+MVfk34fRo74lnpncjJsNEvx1dgCyVb/pOL4/Y1c3A6hDiriksXdfDE6AfR1h63+3lHCJj3agCnAuxV0gnTQ0AEM+DBEovZphI74xCOXjiuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788161; c=relaxed/simple;
	bh=VZwHrNSxvap8RnyIFkC/3169I+CbCplQw0TyzB2vGJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=adpJaXlAHJGcAoDTQ86xyhzHzkzGhrRnYmctsaZ+sXF8ME/29vYBsv22TOX1aWlmUxsddOn16wrDhhmTktyfs5NF7tnO7jjU/8gXd5T36u8ySF1nQWQFquWdszz4Eu396i8z64G7gnd3PFkf3STWEEgXgiWNQ1fqBOnCrZamk9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=htTys44l; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="htTys44l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfrQz+eaH/X9f6axvzPSFcgNV92GWWk46TzrGcUsBhe8DCtdNLp1rmKOYxl7hd8hauELt/K9sNuxYQ2/lbn4qA6Y3K2mhgdOu1/9MThgTDYEpMiKK9itBhByDAg/0muJT/LZTqWqvKXNmT9iwDnjJs8N66xNL/Kt8e6l9w0eLigeltY6N6NkwjQdXj3hFwYYt3pGu5Tz4ctmzx9UcGwCup3/evwlYN2DyitieB73iqy0OSNt1BQKmjyRnkeQw5SGR+lfOwckT9am62f8w+ylNELYxdMvmlKzSeD1NRYnAvJYnMKYmYq6Kh6VrrhEHpPPx9K6FIgzUGuCJH6mFdFz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1qxTut6Vb+cteh1Cfn3EXd4EG+dj8X/toBLKhDrVhg=;
 b=m1Li9EwW+E8TDeN67NqcvtKXZhoKBJKJ7LT0GU5HoNewkLT5HyI+bHnFd+1aXq3QctWpHX5egSUi7ohTDbnOMfkx+6mELjNbs7V4q8pV9imzxz9z2U3+me6XJYr2s52RxGEYfTYXcvDhp5RVTtScug19fqzmCfiCxi6UOO2PLA+CYZKgUiNwXpZcebt99B+/XeajMgw6nZxsmGNdsozwtQxofasYexKiS0el5CXIiT9ZJlwhuQGAFEGbMwoj01aKh5bFeWE2I2ggUMPnZjM0Ge1JvNj1Jwifov9Udul5Pl7xwYRtP0S2Tq5NxMkoydfXPpwCxFESs8jx3HiMsgTIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1qxTut6Vb+cteh1Cfn3EXd4EG+dj8X/toBLKhDrVhg=;
 b=htTys44lCfAUMk8wZeMtYVeK+tAdBy6EpPZVyGWBE5Sn/Hv9UUH9MFhbSPifqDahwdJ1LWqCoLU3lfH4l0j/wN6oReLHujteTQ+MNTEF4yBTOuqz1IMitK9V0ASlC7vOhYqlbxsh/RhNyDwcKv6scymWCcyk1Dd4YKwhdMit88yQdUbsq+rjkEuDkzEg/nnd+3r8PRaxb5i2SLIxTwPN4FnnRzIcsy2yh4hSfYg1dvbqFTreCIsdIcTvUb5bJ5L3fzmXjZcPJrD7b31hEofbJhsQ+E74jd260sqOfIL33Z4amiS8zBtBhCLsrbGQwWGi3jEBeE2DbDdhdTcYxKMXGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 13:09:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 13:09:17 +0000
Date: Thu, 18 Jun 2026 08:08:58 -0500
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
Message-ID: <ajPt6kSQFNhEJvCO@SMW015318>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
 <20260617215520.3327836-3-han.xu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617215520.3327836-3-han.xu@oss.nxp.com>
X-ClientProxiedBy: PH8P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::34) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b61eb90-83ef-44c7-4b60-08decd3acd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	B1eDyVbTGiwwSadTsYyYBCQs0zkZ9ikgm0uE7WOxZtrz0BSBQ4Icqu1bP/wfLN+xkGg+4G9Z7Zakcg2VOLyTcbJeHqMBs5g4SlMMMl0PU8OQIscbXBRRPtiBrteLT8htdjk3OIelCwpxCyH6Js+fG0u9wcPWvVNL0RbU6BpjnTto+eixaydgidc5I+pmZW29ynP62P0UqP8xI/IsORtJgxRxRu+0Dnp6ECm838Mm12zTU9g/tMzJM3zldDMfcdZqWB9a9cH2eSGXBcPgfOrB+9w3oiIUvRUJ0Dc6d3ajKobpzbtCfNolbDcpvOu/wPuB/E4LwtJ3BTcApc/w9HIKVZSEw1RDmyzZk3FTX/VAoTOMyvNWi5fJKQ1xbt2qwr0sKPcjbauNKvsQ66kaVkXnwLPj4knfo5xYc8CRJpGb0W5D6s1eMkFIlYT2BY9r+z/hOvGN/iBFFrvzkBW+USc8BUMdGuCTfimvdjkPUGitrmImbmgRHDcvck0B/m//fUHW/6DqSA/wh4G3RNe9VPKxXY8cq73H9g4OfB8QWMalFbMC8vJ/8TVtHenBIYZPk6mAmxjXVGYr444Pit3ZNY1kD8ck2etEe2ZezEakz/EFjkaxBh00GkKtNn9ZhcCRl4gSYucag8tXBByefL2jScDI55bcXqbsQMHbW0pntWFiKxUurmrU1+n9yFormURAAqx6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jx+XV4dem1WTNxXVi/eJF51RRGUbEoNCe8MBLn7o4I96ymkfm/NZ5vmRv6Lx?=
 =?us-ascii?Q?HJKw8ZNMSJ+dU4DIIOaiJUeMoVt421SgsOXkIvz7OPZHdOwhfP+pdpRZKzeu?=
 =?us-ascii?Q?eBKETm39VsdwLyKIQ0sQnw/DL8hNTnbvW3d4+alR0izNLylFItRLtaK/aCAs?=
 =?us-ascii?Q?lSBodJKeVvR9audj5cmfaTNApdNQUfAnrz73POmPkC8x8Kto21hHZh+Fx05n?=
 =?us-ascii?Q?L1VCp4thnYuP6DV912d4KEugsmTfXTynQLSxpXzBRyDHn15VUgXuL5sU5t3Q?=
 =?us-ascii?Q?RpWFMZKqqiGhuZlX/D4krHB4EgI23Y6qN2n4hE01GQoCYrRBKhIiHjINHeeu?=
 =?us-ascii?Q?JrYshSuUx5IBp/0q8MWicE9TjLO7U0czlaIC5ME1usb05TubAX472cfnEluL?=
 =?us-ascii?Q?IFbZuJmPAvcvblHZOVLfRMbDpM+bDeo0YI6Gd9/eNCgdhTL0xR1JSjpRN90A?=
 =?us-ascii?Q?y99O4DLBorvl7pmCRjDA45qpodKbWRHz8eVqjpnJKr94fTYQDpUWXeXXE1eN?=
 =?us-ascii?Q?WkgrK4JtAMgbAZ29axCQhNbR5C7I/wMwy4sIDN/FhR6ea+Z/2f+QLR3Z+f7h?=
 =?us-ascii?Q?GHR3vNgWoHh51YJZ1Jm8OK8x55bZd8MZ7ec2RXYxSPYT2PaDToLzsTmY44hF?=
 =?us-ascii?Q?WGfwRY6lN0FgMlt7cn6m3ZWCRrp9HoRaZmMeZPBB6A+e3eePKSVy7WpAHc1Z?=
 =?us-ascii?Q?c71uSJimEu2NkybPsh1a7BTHMoaWYKzZKBMCbYciGOy6FFZfE5VHOC4KAu0I?=
 =?us-ascii?Q?eAtfeyOXGS6sXhaPnoVg031pGFxyDJ1peOtpWUazcjhXaQg97WKXHN3+uVa3?=
 =?us-ascii?Q?cTh1jIwajiAmOJgqADX+/W0eZa/j2yrH/Md1TfpjLzYxI7pW+paqG0tAt6ak?=
 =?us-ascii?Q?H2srj24jB5nvHhmjM9fkVcQkMzC3IPjzqUdZ3Odi8HXMkHoLxM+j9CrLYgIK?=
 =?us-ascii?Q?4bk4/gDuXobc3LzdjLh9Z+04OMsVQIEz2LBuX1+m6wPF7RcTNSkHHF9VS1GW?=
 =?us-ascii?Q?frkqjqgO0i8tqTcQUrIYaliliym6emXN4wP8Ghh78cIfoZZ7pzhaZeoQYvWV?=
 =?us-ascii?Q?BuDyj/EJR93s2oqYZ412J8ey5LQMU+xb3my4SJKfQWLcs84r+kDY3CbArHl+?=
 =?us-ascii?Q?KbFf7r55NKkkcGPtcwiOJtmihL1DnuQDCIG7NxBA0/xYR0YkvrSqZpR+OR9O?=
 =?us-ascii?Q?X78F/e+dm8cBSbF2yG/kSv/GT8cmsW4LPcJ7C2u5yd3pKPcLzK37hvzY9NCP?=
 =?us-ascii?Q?jC694CqXL3MLo4Hhi2JK603rbwmiVxwRlBiSYAgku6FTHiMEI9sE+DSknAcB?=
 =?us-ascii?Q?U8zABCTKACrdHEuKVj2B2CbHZqs5rw2hfOX6BLXKhflW3TpC3tXBy9qfadYw?=
 =?us-ascii?Q?owKbr1q2LZ4XdoLuxrLnz6agAROSFc/TVM2OrCPULFq1uP9eM3ikAEJVoPhA?=
 =?us-ascii?Q?YuEr/d5S56t1ItHpW6ZbZtcdgIJGghUuTLuydZ9CKUHkrZS6qhyyK18z/ww3?=
 =?us-ascii?Q?ZBT/O34pzeQIuAPohXB4Wwt2irR4MXUT6H3uN5/4Vxrnez3sDQkbCmCny9yo?=
 =?us-ascii?Q?07eKYFUGg0jpGHycOPqMbB1KDfNVssrtXicX6DiUUlp6FF3kMWnkMu1SmzuA?=
 =?us-ascii?Q?yDk5o8VdQTd6hNECh1TMLrmQQCuPDcdPcO3R3JuLZt828GybAMYUmzEqBMR/?=
 =?us-ascii?Q?tDtgvdG+HeSEg/ucN6Ow0staWQ103hvDCEOjXZWlsv3rtMItZmjz3NBpCGyr?=
 =?us-ascii?Q?SbHOejJfOG30aIU9wAfbUtvsxv6Sba/QGqA6urp+oP8Fsc+zqQyN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b61eb90-83ef-44c7-4b60-08decd3acd34
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:09:17.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAtM3XB02b3Eadfz1icJU+QXz0reaXGqMAHDS5ywTXk38vQaekPhPIn02mAkLtjlgf8vhj9htHkGg8cXDg0KaCBjnK7kxzgPMnW8MosQyw++9vUaY6+LQ/4x7xp/1JuU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196

On Wed, Jun 17, 2026 at 04:55:19PM -0500, han.xu@oss.nxp.com wrote:
>

tags is reversed in spi.

spi: dt-bindings: imx94-xspi ....

you can use git log --oneline Document/devicetree/bindings/spi

Frank

> Add dmas and dma-names to describe TX and RX DMA channels for the i.MX94
> XSPI controller.
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
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
