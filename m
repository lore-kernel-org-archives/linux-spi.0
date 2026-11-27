Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795770219;
	b=mY7c76hmAGwIWiMAgJT8pUFQQwOLQPJ1A/5JxshVmvqNg0UIrabbH2SSYrafHGJicdew
	 9GdFtPFmcxPKngQZHHMrjpFBd51hDWdac44OF6ZjdWSml4NrKB5P0aNZhZKp8ReUzLR5h
	 qjZuDOxm0c3pAoHGByUPnd9e+quYYFhpaEV9Q0jKtoFxpxMgs3MQL8nu6bL3Ck3kUsciH
	 7Y5XcMyz/3ANbvUo/BbusoY7jswmm4VKwKDPcWxEKxfAKy0mEg0cYn6e6Id3zuvJgWxO4
	 Yq/rt80qHgxA9K5anULuPGKRpulgF6xQpPYTOeyxbUEXFXKGZa1nCfMJmFPKQV7rfmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770219;
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
	bh=5TlQv6I1AXnZ8YsUFPt0kOq+A5eAwEgJYIg6NoF1pos=;
	b=HVQl1Akkv1Y8uZrXFVyiMd1jtrBThqJgMum18n00C378wuZ8mtUoBx/BRzYUuvO/Qq0G
	 j/b0fx9SWCLyaR0rwP0I9dIH6J8BeF/Uq/3rtKWztVvse6NBpsEWaEqIXhrSI4ZIH1pc3
	 7qh5vpgDTr6GuHArEcY5CLS3cmkuv6EpDn7ARN171g79LlOyTYEjm2yr0vUezTGtJoPfM
	 myOUwZItAfBwzjLyI2BbVDfZ5olYxnFIEWivqwX+yhBZRhx8Xe1K+pNgqzTKN2AL5yRmD
	 R2l3Rkk3WN+XfqpUMVZhFGvlYQG3KdvEBXLrux7RUbybA/wFdE4gUPUTyQfx/R66tyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wqA5a5+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.50
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BF606A32F;
	Fri, 27 Nov 2026 09:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 776BF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wqA5a5+6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQY2tfHscyEizJokF5WAL5LtQmdg8gi+PkUwr/NOPF7CQD1AeTebdKAFXVn4OmyqdPw4RCPgf7olhig6J4A8HtqgC/SUNmay3A1m1q7U+2QR+rI+kt0oFlp4RAdE9TlRzfz3k96yKWobKMbzyYJQI23l2+LbvYhS8vPcTod4XajAQZukJTn0DyFeHVj6NOxxUvzAl9R2yBvYZ4RSvdBLmf7D4ZsUicbrQu7lOhy6X90MLu+ilM4lYeFbxhiLrrLg825eNnupiycQzxfsfLWPJW2Qv1UZ4+MROracKH/MGooJRfM1F/mcYLXS8ULyGNfl4Z8dc5w5bsMBfhss+EAKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TlQv6I1AXnZ8YsUFPt0kOq+A5eAwEgJYIg6NoF1pos=;
 b=VComjTDyMPVa35JIdSyTPbWVoxAMLsGb7zTCj8ipYeRVWDvujpYw2fQzan88pjE/H2YUc0EQAYfHMLLb9qdEcQHPGoQuwqsfzPzNYGJiWftwF1Qt2mFaVeeHICAwRLXI/bSYJPFAGBF1MYOcdh75XvdidwtCxddgPzHV5oKkuYpwrPIZ3RvZIA9cBoJk7ApEwXrW/QDKvruu5YUbrgGCLQFwsF3isI3J9edlAXwKiwPucOfVlx0QTsy7jBSDmO+BQ0HHO5CakoH6VVx8VmACXz8lBD2yFqvUbonLhpm44GuLnPtj0vhd8aUy+yXvojO+ZK/9tenTeXjaKuHZ/TPEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TlQv6I1AXnZ8YsUFPt0kOq+A5eAwEgJYIg6NoF1pos=;
 b=wqA5a5+6PRwpqleJE38nD3WcuRaF7lshBviypdVraSJVJXWaxg8LjaCKwTCvzH6Gucop1bR0qoWGlw1Z1mCz5aMWbz+5fiIYTONbRo1WQlyVvUbzaKdun4TvGSU0O+NkkLlHyk5/mWvP2nLm7uf/KJr8nWWqAufsYNblM+yHI4GoVJuvpxaiylKAfmEpd7pONdsvXbSeIloHv0mXFIUHakRWUqubr1XxdqPG/eB4qw0xPLTLD9Eu/zoeLjjb16PrsoehWcZ4rTs3r5qW9+s4+TtNgJ7PNWL9fUfIb0/3bcmekBNBFh4841Pz/AobKW7bLHNzQWaelmpQPMKpgWDkIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by VI0PR04MB10094.eurprd04.prod.outlook.com
 (2603:10a6:800:247::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 09:03:34 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 09:03:34 +0000
Date: Fri, 27 Nov 2026 17:08:40 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>, Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 11/16] spi: nxp-xspi: Fix a comment
Message-ID: <20261127090840.3wj6lnyn5m7bzbdg@shlinux89>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
 <20261125-macronix-upstreaming-spi-mem-cycles-v1-11-fd036402fd37@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-11-fd036402fd37@bootlin.com>
X-ClientProxiedBy: SIAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:28a::16) To PA6PR04MB11909.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|VI0PR04MB10094:EE_
X-MS-Office365-Filtering-Correlation-Id: d0841c01-9507-4692-02a0-08df4c6550b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pnTiosWm7cOld0pA+ZNngSRqgn2/JekkeWTOilERgt8l50/nHWYKIUB55HKUhQACbtgGH8+dji467MnQCNOudKCxCE9VsbkHztyYIRgsK6EYZlHrAIH6QQYrlIXD7ZBGm7v+I89gIxaiY5NyuBh0mUtbOY+ivB6hdSPV7I0Kua46uxfPI72LhpeicUQBfEq3NmjIm/4B/0egEWGKHC1SoJRAGr7QHBjDSHwqbb/sRmGmwkqPfnRz0kM2oB8UY273Mu2aFpCH7LH2oFeoMxIGMzw1zhFKtz71MDwCFP/6c37o+MeGAy/93U6zAVG8MVm+d70zL0cENwEmCYvUpgU9xFYsz6jS+Hj7HiM6xM9+aftT8JHqmumeze7yz6jPq3aK6Da6xxDRvV/pZrMe55iuOC4zPeBma0FwntaTIlm4KuPmTVx5oW5n4kBJLaXNGm9SWL/qwhNdlWFMzR0meC7s1ZFYmBll6ySig3anwqxNYaQYOYuSfzetBS5pgAkO8WgJ+uY/iplaSFaYGhh1MZ7XWpSHhiZXQ5d0LZuxUrW1AKUF1iZrjAoFdaCY4OBz7ZBXzx1kJOKaEoSZNkb1pzxiHyWbiFZ4g0tn0K2qb546EffULNQhVZPl2vgTkzIAc9B3qhzxYkLbsIwQ4ZsklWSC5orG/Rg5MsgCblT2hxNINUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QaO+OLaN+m/lbeO1i5klGgVLpSaHw37WQJ521lqOz1l+8f5qTNTT+dUy3t4?=
 =?us-ascii?Q?v06+KQCA0UeMKl3SCC8wM4Aip7dGb3WejMKfnEqMJtqm5YuI5l5V2CauMqfK?=
 =?us-ascii?Q?j6kWD+Vq4Dp/A+OBb9UuZBJT7G8DK0iGpdNtW0aNfUCESYzV5iEeFbsid6rH?=
 =?us-ascii?Q?P3dC2trI/5h99UZ475u949LTxbO9sLV4CgZoI3bgH4JPSwDidt3BcC7jEVkY?=
 =?us-ascii?Q?em7yOO6ciXlH0oM0ewKjkP6EfLXlK/OOTVi1K3x4EcpfXPHNsj6r/SXVwql2?=
 =?us-ascii?Q?smaJF9bMWQNd3rPScH5aRGWLHHQVLrethJFU/mW0jfnNC3efmAIR0XKhXN8p?=
 =?us-ascii?Q?NzSW0vHD5++85tW+asz4jrT2LuKdRFnlX0I+uD8autsKvGmABsWOFXh3udNc?=
 =?us-ascii?Q?Vbe5PsZTKPVB1hnjSikR7Hl1Wp7ho+QuQpI75dCd0YPHOF3CZ4hvX/9A2+mG?=
 =?us-ascii?Q?yZsx3j7BaLR1qlJDuqJraEAh23BbILuAzan+r7bufPw50Jp6P3YkcdRFHl3i?=
 =?us-ascii?Q?XF7RhGyaWbOubE77v9W1wBA5kWZJ30zP08aTEVM3OScRGxTfa+yBSNgdHdSq?=
 =?us-ascii?Q?8y3X/NnCv7qeXcx0M8BBwzymrSU/jGkUyIz+TtIPA16+sFZ+W7oUXz0ZXJLN?=
 =?us-ascii?Q?mdDDosdE9Osy3OoFmRnXeU6CUsrbmSlC5k0MR+tMEb54KAqz4ClynA42RwTz?=
 =?us-ascii?Q?c1jZJmJUiOPjmXqDXI4SFZeHSXGsmdMCHUCAopUMcAckdhu1QIaE/4X3jb2+?=
 =?us-ascii?Q?XSmZ+HDrR5I7W02SCv4cJqwU/EWb+Z0erzvocG0wUtP9T4CgpIKvbB2cKx8D?=
 =?us-ascii?Q?uksMDHDZ/D2ruml0uiTyuvWPDVZXnMXCMVPKVjSctfsCvKLkKTdHzIBHBxnE?=
 =?us-ascii?Q?EzMNn0b8/iF9bOJ97ki1tlOwtje6yZLvz0OsZVsKEi0IOgbw2Rj2XwpaFqDG?=
 =?us-ascii?Q?68n1SYK184fFWU/afgU7LBj6qapRJJRZg7pj+SAFjMDjdKq2oDOn9Y/lp1dk?=
 =?us-ascii?Q?uTizQPnPzXWfduI2RH07nwUP+5I8zp+RnVDgDkxf9WXlSxTLmz7FgGCVTVVk?=
 =?us-ascii?Q?/0BmOphR/dDWyVi6lexwFClrpOf4LR1ZjYKJrO9MX3JoGiPqNE6tI9LsBhLp?=
 =?us-ascii?Q?fI09sSabDE74CVSmBSys7TWEfMkB0BDg8O7ag44SJy9yPqc+fTJth9CON2BG?=
 =?us-ascii?Q?jbRqHWCLFwwZpGIUaoSQHnlAchi29Fv5xkz0dRq9v8Z8fKPy4IUszLgvc6Nb?=
 =?us-ascii?Q?J8IZ7XBpFHk/tL2nGEU2TjLKlYw5oOPVgVuuYKFiK0ZFKrZPVDg5hUqG24TT?=
 =?us-ascii?Q?ne/5h76s99xn7k990ijd0/krRk4hljUKBCr4GVvM5MaOiY/Q9TodA76P/rws?=
 =?us-ascii?Q?DGjOnMn5oDjpyDlhpjiyPBJgujJhsztLSE/rI2Pog3wCCN9O58ppkMKwMu7Y?=
 =?us-ascii?Q?3Yd/q5YlIyLM29Qg1b+3Fcolz5CG/ELNYrBqf6rViszZ8UJ6gY9ypFNJ56AU?=
 =?us-ascii?Q?rePkD6lud7YU2QSc683t3THaFO5d46vmejLimQLS/9kMq/7u4/pyD+Pa7Bwd?=
 =?us-ascii?Q?O7pqaEuqzDTG0DNBO770TroCWv5hrpAWvfsxm42hqohNOECQ54axBYSLMljb?=
 =?us-ascii?Q?bNOo/rsoKpHVtDvQ/dlTIDUL6ARh2wGg+93OquAznYHS+dhPDYifTP0AGaNo?=
 =?us-ascii?Q?CJtT4B2iIWxjUiJAfqL9fhqYi1aMSg3QVq6it5VN5lTkeEE87AS0wKRLgzoz?=
 =?us-ascii?Q?kqJmXesSka35/93Y+Hihy20M7dE4ER8RKsjutnqrqpwDc3d2b1Qy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0841c01-9507-4692-02a0-08df4c6550b3
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:03:34.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TZbJqpRGS1yvEdzIQMFhpyjOhXx6VAsWrNlcTFG5/aKHa4VSfMw5aX1cEcANYnHsJjZFuMtUR52+eT4ia+yJjrnPSCUc4KpDIxevU25YjEj5uZ617D6fP9/quZes0+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094

On Wed, Nov 25, 2026 at 06:51:25PM +0100, Miquel Raynal wrote:
> Looking at the i.MX952 TRM which is I believe one of the SoCs with this
> controller inside, the maximum number of supported dummy clock cycles is
> 64 and not 32, so the code seems more accurate than the comment, which
> needs fixing.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Regards
Haibo Chen
> ---
>  drivers/spi/spi-nxp-xspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 8b836662a5da..ccd00c744d18 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -407,7 +407,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
>  	if (op->addr.nbytes > 4)
>  		return false;
>  
> -	/* Max 32 dummy clock cycles supported */
> +	/* Max 64 dummy clock cycles supported */
>  	if (op->dummy.ncycles > 64)
>  		return false;
>  
> 
> -- 
> 2.56.0
> 
