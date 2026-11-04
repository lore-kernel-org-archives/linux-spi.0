Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.84.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793803289;
	b=unguyc3+Marwk5n/NCE9jZIP8t+p+jUZT73wJXoRYVIXUpQMVO1UenJOic8CFZUVl2t9
	 V/dErMUzIlpb2YVNfX24G72mIJ4hLKJrGUb/wltiKqZPWVZTebiwWuhrmMPYOflcqZ5OT
	 FBBD4kmH5BHOKOnjWUmO+cQfxxCBgXE4TyolYEGpgzcCu63ph+0EO8nzCUTnn0cWh1Q65
	 +MK7JbJFIHNM9uYEeJvn8aOKfFL+4Yn5BjFc60N0Jf1a5cU2gmnRNCUXNnpYJkC7KdAmM
	 eptGhZ3fbg31TsRjCt6ImB+PxANJxb3MVgNIFd2JJNLkdjQND4MTE1wPHS74ZM3qRgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803289;
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
	bh=GVH5FsNcdOC718CDmUelDBpyYnRMeEOSc+uEv8J+lJo=;
	b=gLpod77+3x+jXZtgNSovKRCsTGpzm9fBZTzc24glUrtXJqZVr7pAyMKsCcxYgwK3sHIt
	 oY2GfssQFhhAWbcY7Mg4ZLoEyNdT+JHHwdetWV7OLCGshgdQ50mOCgc2wrL71mvIijafK
	 tLtP9zO6Qww5vmWomgwzTvEDNXuVP8TwlXECO0eHmsEjLd7DH3ykiJQXC1d77Xl70QR8X
	 jHX1mgHyxZ6VaH8KGHe7TojYd9v0Pr5cU5Q1xwQzVL7yHGXiYoY68w8DQNjZfJ+9h3pgN
	 DNecQvcCTRCiJb2mqWMpjYWQP9lIExTwatgUBsVswItv+TgDhHJLHZGhmIMzeO7mXFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wFKHE6FG;
	arc=fail smtp.remote-ip=52.101.84.1
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE827606A328;
	Wed,  4 Nov 2026 14:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE827606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wFKHE6FG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOJc6XL57zEPYKQqPX8Eg4puJc5cYxLnyAUULk6qQJ+JFpmGKqQtVwX2J3bygHYcXGURO5JgNsS0zclWr+EWFmWsdPd+DUhRoSit7AF0N/ujtBPelv/bPLcCCoAgWscyWGRKEKxfbexU/J3rnYFWRG8sQHR4k8Un6H9qn+rz6nGhrhu8wvjPEjOhNGwt+Ud/4J9lxFg/TfS74fyUOO0HqMXBOoKplmm83TvWQeAZgd60TB8AKVFYfNoROLR2uWeirOzRkHWvy3uCObsRjgOVA6gyDnckDnUUI+Gf0dfx5jeEKIgSpgm4VwEzVlNknLamWUE940wecPGpcDUmgxvhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVH5FsNcdOC718CDmUelDBpyYnRMeEOSc+uEv8J+lJo=;
 b=C+EPo1b7kZ4n7efdE9IPwv1aXLRR19a0TDw1c5n9w8DwAwyhIxFQHL91WeC167USTAOEV3CokJnk28oO5B46NZ36cL11tDS2yNHLwL+yQ0pCyV8UktvSmA3i4T7e+S8h9HSwK5bIRg3A4MoOXFMHcwACg1KusksXWJaSzjNNzKPY8UQCXBoej+F1JGBPGEvNKKQcgLgkBm9Gx2vHaM/R2W1dAvA7CLpqmfhGuFgSze+C9ZYNq6EsQ3CZf2E5SVQeRrOUoaNuA0YQA/zs+4AimLHcAr2yoNoodmKj+TxAIWoXOprlqpMIF6aXii/rKhZg48U8m+xWvbCpghhWhY1y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVH5FsNcdOC718CDmUelDBpyYnRMeEOSc+uEv8J+lJo=;
 b=wFKHE6FGBMRz66j457YLcE9l40R5XA6nu8h27m8CvwvSV13W9tKNKHNkBtmKFMCknR5/hIdJYRYcrQ9sJodBmzji6zlTN7JcVeCTQiTSDsfo4Pic6WR3u0kJ+Icg8/F1nh7T7fCA7/3+dXVZn4uYIY6Rk5mIx4P9iBjE7hV8M9d2KvWkbwVU0qO+v6+G6921fKo0/EkfOrnHmmVf5nsC0sO0/yvkkK2D9Kqllc6ewXX6vKQwpNTobtbnLTSkSiGyiV4j3sf6MG0i9hFJLEPKaB3ZG33tp3DwUgKB8q8fBnjhwlu+0DJjA12vzvoZiEa+/ZMmU4x9UwydMH65snNAUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS1PR04MB9430.eurprd04.prod.outlook.com (2603:10a6:20b:4da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:41:24 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:41:22 +0000
Date: Wed, 4 Nov 2026 08:41:14 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:PXA2xx/PXA3xx SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <autEColBK8NUhTTy@SMW015318>
References: <20261103215824.1823272-1-Frank.Li@oss.nxp.com>
 <aurwylnNpkKi_Bx-@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aurwylnNpkKi_Bx-@ashevche-desk.local>
X-ClientProxiedBy: DS7PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS1PR04MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4528c53e-c2f9-4aff-304e-08df3a81b1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|19092799006|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261102130727099003|261026140227099003|10067099003|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	JD9psevqPnIrvjwpaNTrH0DhLHxC+JbOEndclq1qSD1QpyDXE8Il3CnSfyjEwg05SqzjxTA1SUtEwkCXFI38ZwCU/d4q/elihk7aZ+QG3m9VOSuHYXfAiGoXUPenWUHzc3ktpbH0xulSmncFwSUBD528dS5h8dy3VhCc/ijpCPQyddbO8Y4oKfEZqXkEgQIeHPYaLHy42D8OwV50TqQlICuXlYg1ZAxnC1S0SWUrw78KHQEGP1awR8AeSw14bdW2+oIwfrQ7t35QipogkL+ItvQHkNljfLiMoixlMa1YDQPGfUuNHBLDGOoL/0v/fDXgzB8g1pvW6ba6+yvw7SDaQtS1Q7D8bBYNhBfwtkQrvD2S61Y9UWtsWGYlZxE9+TrwlTx5YSn/w5VmaapqtOlGZQQquEM+BUETCJtdX/3ZrwTYjr8Q6h6Jp6mABAxyUxwjvZMeP+aPJGEO0X7zxRcGmIck0P8fV3ibkGwDHPbyxGCdlrTHpApHiXEYG9jKcn0vWRTeSsVpCXuGr2XWZ30d6q6U+G3r+QdEGNotN16ztLDfajkgTEGBiIPlnFdk3L8UkZd6SxN74DCWt1GupdB/HjjmXocBhvf2W2gSmtHJq9V5VcJtzFUsc5zyHOLuVCAb/RMRi1PEZqSn1k+l6GkmVtD8ut/5/Q1/PyFDlPB3N1UDznoOAEAbBdF4RYpuqa/6tei0bhQtVV71deRf/oFUIicQUyuAtFijeI4OOWtHs/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(19092799006)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261102130727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sj8J93U6Q7qhxhVojOrxV2madeOPwqp8OgBDicW+dlx2t73dXzx2Tw0a0VXC?=
 =?us-ascii?Q?lde/1obby0g5rYH8iNQA8q+I7NhNuNuKStTIocgUn8VS7dAmdjkPWg0HThS8?=
 =?us-ascii?Q?iMZGledDYlWqMy7BUVhntVAtHrfG+zQBmH5+LsWxeLnKPhnWEDC42jhVKRLr?=
 =?us-ascii?Q?IgRFkYxh3AzZuml4gpnscocBTkug/B/T/sVWJRvJ9V19wsVYrkodU7OueLIG?=
 =?us-ascii?Q?X5zxPB7VLj1ARFNYOg97ngvmtmfQqtY8+JFY5/9PrsY2PvuF/esms28ba5Yd?=
 =?us-ascii?Q?NbUlHujsKF81TyV01+/CUf3P5+YqcHpAPhV+EiT5mkUQl18CH6JY2OYiFuwY?=
 =?us-ascii?Q?KgkXGHJbxIy/xxauMsaPH50I4EBB9oJs3fqH0oIg/KNE/9GFsj6TtF4wJyfg?=
 =?us-ascii?Q?rbybf25NXNU8BCvEcIxwvK1NzxE9WZHJt2aPAOe9NBB03yBRLQE3ZU11Q9rF?=
 =?us-ascii?Q?2WJcVfeW9/DTUGltVwpm7JUgSxm/2dnHkDGs/H3FnFp6iuZdqN+NNeShZ5Oe?=
 =?us-ascii?Q?qb1IdG0N3f6Om+MN2mJnQMk0zlH6CPm+5LQTycdwwWN7p2PuWC0gszNHCAjK?=
 =?us-ascii?Q?Z/JV9N12Q7Wtjt4f5fX0+Yf2+H1w6LQclpAmYsSdAEWYKeO1mBbL+rClZXzm?=
 =?us-ascii?Q?VgACfdMojkNGh6T+FvKUjzSIWodN7JKhLoTN5MiPPagS5NoPK9337X/w5EZI?=
 =?us-ascii?Q?pRSp/nwTF3iGTFVVuRdKp8+oPpnIShXifS5ucQvg48GFgXWg5d8d4JX+0vBu?=
 =?us-ascii?Q?oFwo6oSXEwtucEnOwGzqMgnPe7y2Hxd/fMTpnAW/ki0Bjp8ds8irHXpqADoW?=
 =?us-ascii?Q?94sy5TAyQxwTPwCTlftVnEnn7wzuBuDt3FaTyNyZz2rQpnGPMrb+wGQ1NvOG?=
 =?us-ascii?Q?a3CigN+hna4Q8ChVuQYc+ycDIb00AJCEIJvYMvQ8nfBPTBVawMcFWzYGjBPd?=
 =?us-ascii?Q?URTTaAr0gUjscYkCWMK4OAVxGf92B+wXUm6UgM97PEcC+920BhINpuqIzT5U?=
 =?us-ascii?Q?i0Y10EHuPhr1nN5/QXwFeGk381X54nOXQcEQmmgpFj2LJqUuC+gI1HIXsbwM?=
 =?us-ascii?Q?YaR5rEttTlR9PdDoBj52bGCB2hmqITOCWFPmjaBKLsRQlE95h4rhqGfG/z9N?=
 =?us-ascii?Q?j32Zzw4ysrxCV5Rv76sMwwGblffz3hHbiMNZVCAdoNBO3LWiiuCfdx+hCKIA?=
 =?us-ascii?Q?zmybb3ztCCDdYwJdnaFcRxxxwYevjKCfukyCAPKlUvLfbE1extj2iIPw3V5P?=
 =?us-ascii?Q?8HDPZ4QkLvh4CqNU5hRIwYsX/pJvjavY3rYekA4a0M+Z8yqL/bGyf4dv1PsL?=
 =?us-ascii?Q?OKsQSkf6HZl3sOybLG8yEQ++jumA5I5fRtP8bPbh2njvg8/OySVgNwLvnkM6?=
 =?us-ascii?Q?vIE2nW0QUixvq++oC3yUrYPCLqg+JyCrM8Fe85xArEK53sna7K6GjBASNlTS?=
 =?us-ascii?Q?V4ZgBUxg+ji3rEMkQDisH4Uw9dHHPe5uXZGFXOBidPEMDAXGH+ITo8Y+Piz1?=
 =?us-ascii?Q?CgjenSlibVzJkv/Aws+NoVzawryJj4mgsnAqUtJ939wJOPpIxuK15/1v9XtZ?=
 =?us-ascii?Q?aE3QbCmQjK9GaHJMokyNzrKf3g2rLLjQn+dWXAIb+s/bs+9iNou7qRKtZi9N?=
 =?us-ascii?Q?UrTk+D5I0aSyBXcE45C0U72n/9dj0ul5aqVLyHIa/FUHndBmnhygV6FDsHP5?=
 =?us-ascii?Q?gfBDgLJmLnjZPyaGlBOYFyVJWDBRBWN+McGIRDToEZPrkWARcTNCEA4FjScZ?=
 =?us-ascii?Q?c92ekl44hpwR3uyICyx9mgEE/+Q53AmYAr1PhUC+61GGA3adbty6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4528c53e-c2f9-4aff-304e-08df3a81b1ea
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:41:22.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INnWKj6xLbMffsETikVfuQnBsKrzXPAjKkgvzbXL632toFd5ptk7GeSFklgklqyvCJjfiu2tVZUMTwvkz15O1OJKWx7eNm/IhFqnH15A0UdKeJQlUsYOPh0nQuzSQk1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9430

On Wed, Nov 04, 2026 at 10:46:02AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 03, 2026 at 04:58:23PM -0500, Frank.Li@oss.nxp.com wrote:
>
> > Use the dmaengine_get_provider_device() API instead of directly
> > accessing chan->device->dev to get the DMA provider device.
> >
> > No functional change. Prepare make to struct dma_device private to the DMA
> > engine.
>
> ...
>
> >  	struct dw_dma_slave *s = param;
> >
> > -	if (s->dma_dev != chan->device->dev)
> > +	if (s->dma_dev != dmaengine_get_provider_device(chan))
> >  		return false;
>
> It's obvious that we need another helper to match.
>
> // void * and EXPORT to be able to use as filter function
> bool dmaengine_match_provider_device(struct dma_chan *chan, void *dma_dev)
> {
> 	return dmaengine_get_provider_device(chan) == dma_dev;
> }
> EXPORT_SYMBOL_GPL(dmaengine_match_provider_device);
>

Yes, I can submit Add API patch first. It cross multi subsystems, it'd
better put this optimizate at next version and leave it as it now. Others
depend on dma engine patch to make merge complex. and there are not much
files.

Frank

> ...
>
> >  static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
> >  {
> > -	return param == chan->device->dev;
> > +	return param == dmaengine_get_provider_device(chan);
> >  }
>
> With that being done this function is gone.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
