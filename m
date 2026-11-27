Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795770141;
	b=3r9GvyLlHibSCVhDYFaPI9HLpo6X1nltDS/fb2OwMW0vpEEu0CTJqH0VkrAAO++fp/Yu
	 I0SllhcgYfnTa3dZx3Badyfn2dyZsNnDtgmiOVJkrMSLQeNgaFBVyBle+BieGQ5jj3clt
	 65q/+a5DTzXUovQ2RffZevZL6jjM54UmbILgVaCRXRgSwOXFl5JbnRWJeJkffKJ4pmMrj
	 6+UCmTHjOP8YEvsV+O1SV1xtydCrhFXXEs8wGfo2Y2KGCiwWWRf7PbSm8XZi0rKH9Jx54
	 Igj2oGuCaagczBz80brOyIHo3C44d4p6sx8jqkWsHBujKHD2w1tyT7bLaZmsh4tebnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770141;
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
	bh=cvOfGrEfMw7IxAwZJQLg+xmeDvWrmtApjE8tTwE5UV8=;
	b=mfrwIXOLc0d4N4D54hhMwBH5clvdUzmVNiFakLMK8QwQBrArXuTaHDChjHkiB65MO/Av
	 kfaM2Fejsh1PJ48+hhtgWJnZ76EW44sbufUJpsQ0nG05B6VynkgCuNIVjeq4L+vXaroJ1
	 sN2aM5MU/Mx74kfSvo5QuQ/AtWriThHG5SrrRFvKx/DEfZI9bF0302uI2i5LuIuE7XRJ3
	 Y0/UUSJAFMzFBGX9ej3Mm/kY3JK3bL5PvVTQU7zE45/XU/5y21lykmgQiiVhEB0I1zKY2
	 vz4/eEIdrpLU940YF05WjRvTIBZwjmNKBd6S60qDejfJoUP2VLU35iQJZC3/Y8xRD7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VjPtXvAP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E3606A31E;
	Fri, 27 Nov 2026 09:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 659E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VjPtXvAP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHPivb+mfAWrZO5iUz0n5J4hado+KmmPpN4EaUey5GHJ4CKJFdZpln9UawmeeMCk6/Tii4dEN/f8e+BYsJbOYxTGoeXUJRIpn5eJhn6tKBcpjEDjxS+k6BgOWCy5QpxDzEqhjHqK97WG1hYee7Z0G6Ufrk6XOezrPfLaYqoN+6ZzhWZ/+/VytQ9aVmiv67ZqN4USIxcuaIbXT/5BMaVMhyNYbbZ/wOdZAvrsuPtYpe7koiq4SosXmyWqsxQP8PdWyR4iAGlVDoUTrDdfAyookxuUwRBbGRBxiQlzpoEWovYzVt0Wf8+eM6DFeuZgNZBUWERrteGZ5VEdJ3Y3+XJqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvOfGrEfMw7IxAwZJQLg+xmeDvWrmtApjE8tTwE5UV8=;
 b=d0pGsJVmXywOLchVHY1hbGSwqiOqr/fbHLnPfzCGVDnyZRSzjOdr9n892R7UsXDDmAVM6Afa8+1fTS8sdCpx/GsPLkoWV7qYhZkzq/StdqJXfF+Lac4VPpLDgsV0nZ1zrC6nKG+lVMMYiMI1ugFgM5kzhpOW+LCOxCn06V1l44EltmMe07vhpTzZJCm0lTmaSm3SObEU0QZbeCHapw9qpkLVg5J7c1bPgXc/6nZat2yHT8L0fOGkqpN3kfv/iPbqda7wCXwaBSj3cFMzHriGvKYHqj68NBzYXO6tlcBq0ILVfMy/GEG6yQXGgxckVgZuD5wdIN7kdwbl9qZ3ayYznQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvOfGrEfMw7IxAwZJQLg+xmeDvWrmtApjE8tTwE5UV8=;
 b=VjPtXvAPh/MScgD3/KNGEFRVcaxGWc6/0+eXsIw+6+7HBXO8QMUtg3oX0HTpIMdc71MPmo3JnPjCHJXNFu/7NvLjM7kvvYHLMztkn6/epWTWkf2QW208XnDuEKQ7sgwSjqRZHAIqtx6Klgzl7mrdwZmTq74wVIZFfylaBW60WkODqJNg2/fksKW891e+CnhimlOJ8oi9m2WXH3Bh2vLfnhphvzlQb0+ReN8kAsoaILXkerbYVCQxVUTsBAcxzA0fghlRHatuIn8QnNIUQs0uhn6DtiD3XfiqMaWXtRU6jk1n9Ori4GF6TvQsikgW48ZMc382hBZo1cvfjj//dtB9bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by VI0PR04MB10094.eurprd04.prod.outlook.com
 (2603:10a6:800:247::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 09:02:14 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 09:02:14 +0000
Date: Fri, 27 Nov 2026 17:07:20 +0800
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
Subject: Re: [PATCH RFC 10/16] spi: nxp-xspi: Consume dummy cycles directly
Message-ID: <20261127090720.2zu37yavojz7fze6@shlinux89>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
 <20261125-macronix-upstreaming-spi-mem-cycles-v1-10-fd036402fd37@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-10-fd036402fd37@bootlin.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PA6PR04MB11909.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 4c324c2c-54bc-450c-1297-08df4c65214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|5023799004|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	2h9826xHROdXUeZNIRMvO+Ln2QR5zwrhE3CuyzCjL+bc3OCndWP/9WYCXuJ51tWuUJs0/6eRdgzi8EbGcwPdfuOEB/FrlzbeM3gF+tSkB6uWHIVa42s/ZfVSsNXS2Z9HllvqJSm0xhzM+uhAyiHrhZydOOhf75KbPl0sSIS+H1aqWPXt8xpvB3IyNPsI9YvXIGFuAe/aFJUpbrLX7eZcwy1+GZzvkPkOscLNO4LsLIwhhohdJTkyhs5QTvBuYEViqqR2Et9lroTNzjX1XD5vjpS1tZ+hMRP5lK28uehu6KYpEJgzT8v+BCRdkcRFENmVugNOWXNjnc8I1PnwnACsxI6aGE3Bw0uLB0IBSN8T863XWa1TmBnWqw8DTAqidkMj92QjYtGBgLF6FbekhEtij8FtyDUee/FbDAWn6QwfoqZ/TyTLsIm448zwtdpzE5v4+r4DoYnl0d0oEeVWyV8SdsKSiVDKrs46uBmpKJa9kPVoxGZSKU0j5Afb/sOWdqsk4+sRJt5fKbg1kaGMgMYNFbi7g4U7kmBH3reh57PJOgOyuLGt10F4v9lUmvaI8WPFerI2uan2EMhW7u2twxgG2Team2GnXoWqeyazixYcn/BfUow/eHbTuXFRAnRZdn5UHfEfb6ZhCKHWPjimWc7rYQy1tH/xn1w3xVNR24d8Ub8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(5023799004)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CWsHvoEoH60f7evdQTiob3vwcqeOA35xIFZU0rjGVxb1ovFkd2eVOZQjqnYM?=
 =?us-ascii?Q?omXDvBHhMjxdZW3HejswqcQEQvZUw03rVew9XxE76KtZ2kC1G8KqYpktszi/?=
 =?us-ascii?Q?G6j3KfA6CcK1sHLezzcFAJDEfMmVLljEGi3/EbRbK+D+twcZYryeZLLrzByK?=
 =?us-ascii?Q?1D5rHWSB9wXZoJ/CGgrLx4gKvTQcolKDoaL4oVtNgDrOUA/APiUShcdTeLoG?=
 =?us-ascii?Q?CyCymGR1kzaNCbkn4axzUegqdfbq3Ycz4SGJqdsVUsRJOpftyEn2efGqPvy2?=
 =?us-ascii?Q?EGo+damRpN238f3tcRUoM7gfNkd+Yj8HWCWpAidzUeaYy3/YkxSZuvMXZNGb?=
 =?us-ascii?Q?xKGqzw4HOKqfZGo04vT+EQDZfXDmlCVWDXekD6PdgzmRtClfG9RsTz6uixrX?=
 =?us-ascii?Q?UuT4ZbQjhXCVTV5NlVcQjaziFgZgin++9HYue2HghbCk8F6ZoJPTPXqzmgYm?=
 =?us-ascii?Q?yO3hTNn7UhmTzUoNz4gJDaIEJEGB8tcqzweqc3sbIHj3G3y0UdE6v5JDYr2H?=
 =?us-ascii?Q?Dp085qLkksBncXL/LbYnndVcI1fkZtJHBti6DOXEIXgD8OZktpV3BMqeODgl?=
 =?us-ascii?Q?Cthh2VOWE7MsE2e7qEsS7WhW26JNIMHZ2JHHl0OJETvMnXtT9tJCbeMxwb1l?=
 =?us-ascii?Q?plwGWJAeFI2vHk7BrJ/aNszID6mAkwfABvFsdod9a+gTxMkbV3UyDX6H+opm?=
 =?us-ascii?Q?707/GQuP5Ne2WpThPHPHVpNzE2Q5yzseTIrlROaCGUqnuv17vlhuepQEP34+?=
 =?us-ascii?Q?mDLOG1NqjJGERT7ts3O+tHlwCCqsXKjqBk5zLVPcpUk7QTrs+w4m/p09NHKj?=
 =?us-ascii?Q?we8m4vgVK2IwABuWMoAELpS9Dc7vUQwKoRp1UbFk+7TGIj7ioFMuBk6RduiT?=
 =?us-ascii?Q?RLPI9ciRdneU4E6gw6obnwrxUlY7nXpkHWdJvIKwGCN1UJ4o7qTyaQhtwOSa?=
 =?us-ascii?Q?nwD5NKFsNvMe0NCIfSXKKSq0p3yFwsCHtfy+zyf3dTroXEeu5omO3QFOPH0r?=
 =?us-ascii?Q?kQWk5H4M1SjYglCUH3dDQh0oXoxTQAh9Oc3VvOVaMq289cG0hecjSAAljrLN?=
 =?us-ascii?Q?oenKq39cE0zy+xAAAc6F2kJTSMf9Nvnj8KHLuqyw6SN/1d2FZRs1MF9Lqr13?=
 =?us-ascii?Q?d/dSXMPisyRoLonbDP5e40VTg1iYb1V2j8B+aGdPmUemH/8v/uBM2SRRbCXN?=
 =?us-ascii?Q?6i4WUB+MA6MPaVxeHq2V/hMVpFGiHZ8NedJEcVol1nfB1ohQ5KG+dNCK0o9g?=
 =?us-ascii?Q?+7KQ6wX2+ahxr9kRzHRpsWZnu0eaOTRYlohrKVOrbaq/YzQIxtbvNL4xbO4O?=
 =?us-ascii?Q?MaZCeazRUB9X7iEboME7plwCgeYrKQOksJk3L/J15+O6WOEL1oC82QiORWKd?=
 =?us-ascii?Q?qpj29IuoOIXVeXZbU99aQS+EtaeEmfrd+ySohmMgOHgzqTtO1lZBmLqoF6Ug?=
 =?us-ascii?Q?RpiKbK4BivQ+EDxPtAvkIfO7vMPSbQMVI/K1ws6TadHEfcAdUkdhqipMpkoL?=
 =?us-ascii?Q?x252kGxEfRz4mqBEk21Ye0CrrmMHR83T1vGZ7oStUEH8d/nxTcPIhqTvWNJd?=
 =?us-ascii?Q?M799gpGEKu6Ejj7gsSFQD5taOlZJx9RDPgihe3TvetfnTfFWYH3qQ1wXdPNs?=
 =?us-ascii?Q?7JmbLE8hWDHg/AoKeN9L1cZQ5zezzcoGAGalNgzK2f8yjzcZNOSf02OE97t0?=
 =?us-ascii?Q?T9UQqEndNAsyv+q90tfTa9Gy0P439mn//TEJgMoMNltIxgEaJ7lgOo94Rioi?=
 =?us-ascii?Q?ThbGp9CHZJ/h3ONBtRG2nDSb1HVbxpPK4poPchwJkN/uujuEXOtt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c324c2c-54bc-450c-1297-08df4c65214b
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:02:14.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH3JQwy5drD3EftveASI7orDS3D0fH70VPbukibZIKDewTT3fipTzzB0TtsOSlnKboD2EvOkT1rTxh0ke6yKldSW7CoC4L+WFBTj4OBJru7MwsoVsHAn7gU0Cf87QkR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10094

On Wed, Nov 25, 2026 at 06:51:24PM +0100, Miquel Raynal wrote:
> The spi-mem layer is now capable of providing the dummy phase in cycle
> units rather than bytes, provided that drivers advertize the dummy_cycle
> capability. Since this controller is consuming cycles and currently
> converts bytes into cycles, flag it capable to consume cycles directly
> and drop the extra conversions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-nxp-xspi.c | 12 +++++-------

Hi Miquel,

Can you help also add the changes for spi-nxp-fspi.c?
flexspi and xspi of NXP have the similar driver structure.

Regards
Haibo Chen
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 38c8d6269aad..8b836662a5da 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -392,7 +392,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
>  	if (op->addr.nbytes)
>  		ret |= nxp_xspi_check_buswidth(xspi, op->addr.buswidth);
>  
> -	if (op->dummy.nbytes)
> +	if (op->dummy.ncycles)
>  		ret |= nxp_xspi_check_buswidth(xspi, op->dummy.buswidth);
>  
>  	if (op->data.nbytes)
> @@ -408,8 +408,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
>  		return false;
>  
>  	/* Max 32 dummy clock cycles supported */
> -	if (op->dummy.buswidth &&
> -	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> +	if (op->dummy.ncycles > 64)
>  		return false;
>  
>  	if (needs_ip_only(xspi) && op->data.dir == SPI_MEM_DATA_IN &&
> @@ -453,12 +452,10 @@ static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
>  	}
>  
>  	/* Dummy bytes, if needed */
> -	if (op->dummy.nbytes) {
> +	if (op->dummy.ncycles) {
>  		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
>  					      LUT_PAD(op->data.buswidth),
> -					      op->dummy.nbytes * 8 /
> -						/* need distinguish ddr mode */
> -					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
> +					      op->dummy.ncycles);
>  		lutidx++;
>  	}
>  
> @@ -1307,6 +1304,7 @@ static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
>  	.dtr = true,
>  	.per_op_freq = true,
>  	.swap16 = true,
> +	.dummy_cycles = true,
>  };
>  
>  static void nxp_xspi_cleanup(void *data)
> 
> -- 
> 2.56.0
> 
