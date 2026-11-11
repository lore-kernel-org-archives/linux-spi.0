Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794434788;
	b=Z9RrXc2NeurDTiPUjaK1xIYc9xZm+6SOzsWDIlUrk8/h4Rm9BNQ9J8tcoHo1yEB3sqsg
	 YI+vT8K7DBW92bsPjXnQvafmoeIn2ooPDGh0hndqPworoF0UGA5MNUdi53vucbMgiaawP
	 tSQMSYLPIp4m6/BLS6yW1d2mIvptxb6Tg6BU4zWUhw0gDdwg+AynfF3NOZbR4jOSV9vZY
	 i6VmQmia/Y9C1g1KB5UkvZMsGmVqMJJ9PIHmNSfhJKbxGGLAsVuQ3hDDEjD8wQYRGp4h8
	 PJ15OBJVGsyI3WGy9v4V+Q3Ds0LiZNHjjfX4vqa2rS6hXMTfo1c/wGJzHtVbg5B0gkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434788;
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
	bh=ZDY8gV5dA0p1N+QlE9aZvUGoN0r2KL+eGJvhRysyMtw=;
	b=OraGTGc0TBEREjze1JRAFfFX3O6skUVJaoREzRY0VBuB+DzeLeGrpym6BryIh+QbJ6Mk
	 O3Y1d79y55ooj4KH/OGC9aG3sSFkqW3MibleopPFAxd6/iJJxSFxkSyYzGvDbQ0/Or9j9
	 nM0+J59ypcaQaJNjwedaA7rBU/3Gal/JKT0BC1f6uWSuvSWtJDV33CIl6kYYAImj0OIhO
	 gyM2iRRBuJawXVBqG7k6VI/qnoeIKPirGfAssv9pb19/ZPxK6Ko9WXuhpgO1ZUWqmX3Fq
	 SUzTA0b1jwCuCVEoWX5qrra8p1062EjJRiSTyyL1vYuebaa72mOBWZI7Z+3ITfgnPdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NhDLKRnL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.31
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BE606A31C;
	Wed, 11 Nov 2026 22:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=NhDLKRnL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkbGc8oX4iQ759Ia+gh+eB1S9DP88k3umrcmED40P2sNHH2bAELIng0jiZQzhZLmGCrN1Vaezcb4lE4nopp90ZyMnd9T2xtFlKdfSKIDH2EgJ+JTfA5SM3NL3hnVJzcyrmhQtH5YSZ4UygnN58FugILn81LhptQtaybzxL3mMQD3NId0ZGzeWMQF9zSZSuEYj8C0wz6Em8b/mOK24tjPMr5JaCLBMS0LteWx6sRPYc1n2BzfTs550e4ssoAdRDPJ0zFym9H8EOve301v4Xz8EQLTs8I5P5eokMvHzF3zcPz9tnoCVfoT2pKM6f3jN9r985QB/LSoxUv/Y00E9LaEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDY8gV5dA0p1N+QlE9aZvUGoN0r2KL+eGJvhRysyMtw=;
 b=CqA8VQaKNfWx9JwBE7lEABXmPi/9jIDiKupcV63kw3cnHtApeWnl72RCA8ud7EqHzYqIsWyuFVhtdCF3DNAoPvFpbSN32cI11uESbo3tK+yfWG/Ao+VGEVWkCedXTTwTt5G6wNKGAxg/nGjS3tcpqHUkN/VU0kGHUy/HVHK27Cd/ayDjvMEd1XwfuPPJVbSVRXweRQ6l0ig6cEodBR5TkmR4vcae4D1JKqfGbQHGVjLkG08wUsEbai8IDUo/gYY5oi03o9KGfv1XLdBSi72fCPrkUOL/XqIKBeHQN+He4zJ80QyfUZ04kQ6wLWb9W3CN/TQAapnG+/ngjZqlkou6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDY8gV5dA0p1N+QlE9aZvUGoN0r2KL+eGJvhRysyMtw=;
 b=NhDLKRnLOo+Qbb3igR5evah5l+52Immnj/jNgBZx+3Z2lDEh93yhwxkyqMiWAaknc8M3ORSbn50JLI6QHdJSSwW2GAJ2fTZxeBEkQEQxGnudC7VwBpuf1lm5BapD3WwYTGZCxnpnbOVUaRe3/q3kMeXpU2S0QIB0weoKuXFYkTiuyDIBrrnzhLvK5Jjh67ZNCxjF51ecPu1RMVYnWbJ05RAHtjmp0g6TIrCkOkIGEpkIm7ZikVHjsROnj5s8nxT9PWIadQre9ZA4WX1T9rImE9tkJjviYuOAACgnFbJy4uyLbUsBBmKFOnq30PEAS8NTw3xH1kQjQwY5PYlZU4B/eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0SPRMB0082.eurprd04.prod.outlook.com (2603:10a6:800:2f9::18)
 by DU0PR04MB9228.eurprd04.prod.outlook.com (2603:10a6:10:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:06:24 +0000
Received: from VI0SPRMB0082.eurprd04.prod.outlook.com
 ([fe80::4120:bdcb:6b3e:ac66]) by VI0SPRMB0082.eurprd04.prod.outlook.com
 ([fe80::4120:bdcb:6b3e:ac66%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 22:06:23 +0000
Date: Wed, 11 Nov 2026 16:06:15 -0600
From: "han.xu" <han.xu@oss.nxp.com>
To: Frank.Li@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Mark Brown <broonie@kernel.org>, "open list:NXP XSPI DRIVER" <linux-spi@vger.kernel.org>, 
	"open list:NXP XSPI DRIVER" <imx@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
Message-ID: <avTmsgHPAi_SDonX@cozumel>
References: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111202741.3866239-1-Frank.Li@oss.nxp.com>
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To VI0SPRMB0082.eurprd04.prod.outlook.com
 (2603:10a6:800:2f9::18)
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
X-MS-TrafficTypeDiagnostic: VI0SPRMB0082:EE_|DU0PR04MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ce621e-938d-4ce2-62c5-08df404005a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|10067099003|11063799006|56012099006|261021123027099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cYepqVVwr341yDmfL2R2zBxGID++9zs9u7Eb25mUTG9PXapH6kJudqRwmDLVSibCycT30dOFqzd4zZ+JRYKzV9VkemI60hy70mXNHn2jkvpoe39ZAJvkpUS3B7dbo4E2+yZL7SZ6IoeDRyI3IHOZhI60UElq5sqndnaewPW3LgbgRtOr+Fq999koZrms3mxhNujaqJyjfIDINOisyZa/PnhRjWd/VrTaHk0nzAr66ig9xquIgmbJgVVhqkji3Y/d6pv3lyXbLI43O2A5DoRQurm1JKmOGZ+1YNFJZdajoFXaEiBqfaxL7SX3WgTD2KvX9BBT7P5dAiA8P5IHmbabJDgrMIQadMR1DWH8DPLQKAvds168zUBYeHzJudOfEKhdMvYA4Aqq2K2Ug92gfIkZrpTyO2NXS+AJk8CuufIqzlvTa7nIO2GxFHZOa4nce/j4vNGnuMjvcCklK2CYD60+LeFxCvt03QLJiUcTtpS/kGF0zmuKAd4N7tzySN8PxJEQQ5+NHwqrWvdSBYVmZFmlCVjrlLWMEs4Q8i0UXKG/tevaNCSqdbln+EtMTeJplWjrlt+6Ua57ZlAPMjHfwaaUepciWIUEo+K+uVYp/Z4f7MiqXoghs8jwYozyn1M2LxXTvINyXcvuS3qjcBGApueV/QTPUPoAcXIvPh9D1nxfcWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0SPRMB0082.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFs2S8v6Jh6kAO97irWB2cqDiswuiVfZi65xM37Q7/VIm5isJqH73eQ5AP5L?=
 =?us-ascii?Q?yIdLFgv8mjnuvwkm+igqa/MPFfqzWl2yxETWjY3HvxlPqsZRzy1UGBsqXpew?=
 =?us-ascii?Q?QpWI59RlBhtWOOu++0VamJ8uWYyLFkwpyhgnskgEncb4h56zpQGOoL67PwPQ?=
 =?us-ascii?Q?pzbSprK1qy5qFRc32j7s2X3uFLXrQk3MchesonyjSqPpzXGv4EJ4bKnIGG11?=
 =?us-ascii?Q?YC88fnt6ZVDmGZaNKmweel07J3ZXFN4UjHYhRPo+Qy1W4DrDUfZWU4YGSX16?=
 =?us-ascii?Q?Kqzl3W6SYDAg4F5WML+vpb7O8f3aUnEaEYfrIpl+ML4B2H2LbglnF/xSY7je?=
 =?us-ascii?Q?UUtYhvQyOBBTDKto9C57MS1kjHtWey0KH70JUMU65BpbU7ZH8frVTI2eI9r1?=
 =?us-ascii?Q?OGqv6B9bNHs6RnjdiGWMkneJiXCdqbFXDmaMpLBEPa24KzGgrb49eLRPpNII?=
 =?us-ascii?Q?kbPPPyX5clphZ565yaqBBrwt+t/ZvCPOlgp9geA1cYlzxIeUpLeS8N12dHyE?=
 =?us-ascii?Q?WYrwmwQ9FEGLB6LNwJ39Z+T9aqSnqjRj8ClHpRo/xXNufPsmI09xtZ90QNPN?=
 =?us-ascii?Q?LfnIP/FD35sN0HfAH5QZVwmRSvfrW3JaQCFiPW77sGjSeWYmWBxN1IFdFD5d?=
 =?us-ascii?Q?VXF6ug3pv8HGXQcNIbZC3oMczK9Kg6yaGQgiMve0emt2L4QrMYsi6dWVvfqf?=
 =?us-ascii?Q?ztj7CWQWjPcVAqzl0rmwZxFEuOrB7niTm+HxPu3BQc5xE21IMxr+fSsBVTDR?=
 =?us-ascii?Q?w1WKN/QGIBVD46WrioQZwfYMfsdtgHw/MoF9jcQ8lx8IYJQgkxwJM7v/JLgM?=
 =?us-ascii?Q?ypWj+tQXw2zFpyIN9a273Cmy/hr43WiRBr7oE3dsu0r3woZlPuNFOqwvAJmi?=
 =?us-ascii?Q?aporqvfMvsRF6Kg1qEG7irTC3nq+M9vPsV/mVwfOjuNtQRetJUP/uGwsRKe3?=
 =?us-ascii?Q?+Ov2Oc6IbA+Ke286yAygU4TV9dQtrjnmeOGmSJcNslYyEeBkOM8ZpHpzs+Ww?=
 =?us-ascii?Q?f43/zLBmisWHsH7wHngUcWXkcqVY4yb+z5Z/1/MTXcCo6o1v84S4HTI+HKlR?=
 =?us-ascii?Q?ui7MxndOmD4gdKWCBmWuJMDtSRSLT/CNCpMfyjH+F4bMVPa49pDx9HXDuJ9B?=
 =?us-ascii?Q?sXioN83AWNTYl83CWBlPjVnrv+BC88HBC/KWv7Wqt6wXa4IQfJ2CfoiGrJOr?=
 =?us-ascii?Q?mtskPmVjgBUUO+LoQvyPzFvbLGGKDufnegHv9c/almZCErQseO17JdeJExXk?=
 =?us-ascii?Q?rtXKkPTQZOwphkW3oH3+uTQmEw0lr4AFAQnD/SDUEcvFSS1wKpgZQs9BIZaz?=
 =?us-ascii?Q?mVpcDU/ZWwrZpOhSXNj9XU7QnQgtDYG7RTWzfslMWF8hfDfzBj6sKffMPcut?=
 =?us-ascii?Q?/+PcKmTEN6HsrkbO0Ws9BiD5UH918rtdpa3RjypyfXRP+fHaM3yd5PimMish?=
 =?us-ascii?Q?UMM3gCHQMGHRrUe37ZG48sxa6/901OeUJO4mOGBULHF1FUkm0rs0N0vpQSzZ?=
 =?us-ascii?Q?L8ng4ILtLStaumbQwygFoCV1paWsR2nQ27nsnNuE7A90EQbpe0a4VEjV4Aai?=
 =?us-ascii?Q?AZHhENyCZ9Y7IKbOTRvw0P2F75pO8G9DKaacOII+PXeam2MpUUOWHzdS06Yp?=
 =?us-ascii?Q?aQe+hFpGQlEQazi/EGdsOQp5/8bWlnmBAspIGTywMTC5CN2BB3EmCFWaj64d?=
 =?us-ascii?Q?5ie4BrX4n7xuwoao1xigNV5FcrM06/h9PI0YPTp39HLgAEVr6CrFN9On+oRa?=
 =?us-ascii?Q?cshrQM+k61u3pE0rjtR6idpiLX/ahGAWQfdASdcS7uLGup/Ptcmx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ce621e-938d-4ce2-62c5-08df404005a1
X-MS-Exchange-CrossTenant-AuthSource: VI0SPRMB0082.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:06:23.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdmOLUXGzk0JeRJq4SV5UbzmJO3vGuJJTA4YDPOsj/uag51nSbUsR9C6Z++ZV24AijZBEulnlSFqjJ2EAyyJglJ/0sMmdhs3JKppQY/t4Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9228

On 26/11/11 03:27PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use the dmaengine_get_copy_align() API function instead of directly
> accessing rx->device->copy_align.
> 
> No functional change and prepare to move struct dma_device to private.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-nxp-xspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index e532b2da54835..e8383fed461e5 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -824,7 +824,7 @@ static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
>  
>  	xspi->dma_rx = rx;
>  	init_completion(&xspi->dma_rx_c);
> -	xspi->dma_copy_align = 1 << rx->device->copy_align;
> +	xspi->dma_copy_align = 1 << dmaengine_get_copy_align(rx);

Acked-by: Han Xu <han.xu@nxp.com>

>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
