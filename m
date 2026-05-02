Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0CF7081E;
	Sat,  2 May 2026 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697384; cv=fail; b=VAY/sRMcubYw+E6krcyigjopsbDeWlXfCKJDXVaNc4OMcbgXXy0C5yufdQ04/GLxcX8SHl/xTOjM1ki2gLQRGAvUZ/Ejufq9o9TeCtJYickTIlJaz8IvncUkwMQKB99Aua4ciJjZZVCNKzEKfL5MoVjCTAEtN7Dzxf8Ob9uS4Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697384; c=relaxed/simple;
	bh=kOy18Ym5IvstMdYWE6nqq0G9qlRSff0KZtAB7N8Hy+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1D+Y5Hal5QabGWoATazTFzSDgmLNnPnlZMjcci7crub4lJK4e0hoa4jsZFnrce0vqwTvnif9D5MZFTtswE/0vMqcKJcOndSnQS2019vRFmxVAmaHsr6ZC+oFCtSZO/+0GtuFZVM9RagD3LSk45Vx/haiRZchAvX4t7hVwE+l8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LmQLh4hI; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LmQLh4hI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMn9V2HZbWmPcXl0F2f40nFgFqdY/Wtjnb+a5UJJZLPbG3A7WygQn0uKuq+44WlDeKklxpTZabb9a4VloJ36mR3KNhoJQg2h7wg8R7d1xu2LnqFZqfAgNvj5xDRbjfzDweKM2fqS6eilgBVhYCHD8W7uZjwbBb0mLIBxj7WT73FKVLOmQTe3dbEETUHgr5mF9q7y/5yg7r026korgvEEcI9lbUmmfy7+sRRk5/mg0KG7O72LtWjebG8TByr5tbufLfYFk5hu5BHqa+E3No+djvPdutG+XOWLWmGNr2Ki0ivdQzd471D9KVSHlsuuDLVbOm5WXTxc9dW3FgwZwvjxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMAIzj7rktz/IHQZX6nyvDREknza+I+YhsUCY7568fg=;
 b=gNP8XkZhwoZQ3wXVngvQoU74HlhqFKt7gazvkA07W+7mr4RyINK24rHX1VZ/O1VnIbmh62xfubXn5paZajb/mqggCFXYDRh/h6F3HjASa+yyXCOZnIDOgbqkIyd1z271+QMNal/cPYgyYOaV6PDkW1y59FHJb0x18wuyQNQOIuD8VO3VVETHHgP2HCUWRFKpEZfoEvDHl+OggLnKxfRW8XwGfS2V3vei++y8DozDkd9plnxwXbZcfhFxRCHrDTNZ6LLZ9dt7fDhC3/tNIx/jYfH9DdmhzQgZKARFtrM8yr/ASroMrULXCMTCqxX3ld6TgRXhl1O1wYvrCi3AdRE5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMAIzj7rktz/IHQZX6nyvDREknza+I+YhsUCY7568fg=;
 b=LmQLh4hIuJt4WzwcmxWyGKrQX02VKtGRBUTppF6Xa8lUPWK9PkuTRk6BcEfPGCebDeAjr2V54pflF8Kx6iMRd632xuI+U0htz3tVGleFpfm0N8a8YQvjl8pLxkMSigzJL9Mp8nRHQOX2qP3U0cZwogqTtXznb0a2x6dtwjCwW3hRuMsck/4sx94GOQRsNCkqV6fohXDCuQPtX+8nnmi7aoqPFza5GfVI9NWP1TkSKe1rVPwqOs8HdF9IlgsHURDuBWRP2VmrhFrxiYgS4YeyJNJpTYBTnp3OgmjzefAli6lVj2RBn9DTRZ4/wl8eyg6j/cnH8u5xiPkio7Ph062Hxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 04:49:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 04:49:40 +0000
Date: Sat, 2 May 2026 00:49:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: John Madieu <john.madieu@gmail.com>
Cc: broonie@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, carlos.song@nxp.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: imx: Fix UAF on package-1 prepare failure in
 spi_imx_dma_data_prepare()
Message-ID: <afWCXTn_x6HtjNZa@lizhi-Precision-Tower-5810>
References: <20260501135951.2416527-1-john.madieu@gmail.com>
 <20260501135951.2416527-3-john.madieu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501135951.2416527-3-john.madieu@gmail.com>
X-ClientProxiedBy: PH7PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:510:23d::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5e020b-b5b7-414b-7d36-08dea8063858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JoaFi2NrgcT0wRoYszVT3D3pYPrHUd2rzT8rHQIYK0guyzox3ZnWIXlRe82s98XrpymsR3A5vf+PpcMIEkK9p/Te0DjVo5d6Carx6C8KdzjPn+Vq5apecoD6eamtS9Hvbf49a0dj98dzFq1Fj5yHArEe8Ei7c2LguWkhp1nvJktIsXe0EEgyrFhuQcMN5eNhKr2K5McKeO1LICumBvio+UQI5Mu9YiEqUq8UkGgspFRGjZEV782Mxi2RlOMjBPu6raGdyAhY530DmHuBl2kJ3mjUWpxKGLKS1acVheNsPpi+DjCbGfbmbzEwGH7iKA8dgmMmw0DFG+SANoqJY7p54e8rX0jMv1IE6pJ0kHf+NV20d9RK1qVWJKPWKiBhNT7MyHaFJjVSAA1eIxMcP+s57mzp3AZxdrq0xXI1CDMyVg/qB3WyaCU3J/E5BAKV0ujsM8wzOj46AEDLM9m2Qy8zuNRnbmvDRpCYC+prFcIfgyEfAHMOmT4eHJiLBhaL6VcbI/mlUpcp9TzgBlWuYUv6NYYJK3MhCPdS9sBkli4bdRnupTfAeiV1RRTSMPvwsd12PAG2g/mJwfsOA7x4oOsrCkDqh1npBmOnVqzt1d6WNyQJiNlne/p1x7H0DDlq3oRf2uAhgkWupm+BGD0naCS6tbyPS6/R+clXhOV810Ep035XIhRwg9+FFncD6KikM3mj66qnVj5m+pXnEWSJMxdpX60T2LCdmLb/IMe2OfJMLymy6UVbGaWl6UsifuSmeG85
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmxlsTMcFycZR5p78nfHYgOxdGMUPi/bXQ+gnW0Gm0axMM86b2PBMv3P+aeU?=
 =?us-ascii?Q?U5ie4SexD4fHyZ5ia7/mhNH0LmMNm8d0tBueZHoUfZEBoTIMAlgpc9ipQx7S?=
 =?us-ascii?Q?zK5kxnWOoBIRoVeIm31mkDA0WavM8E/MU2/SdMF27CHLcbxFHIin5bMq8Z6O?=
 =?us-ascii?Q?HRDUuj65HdinFKwjGRJ5pX6FvoGwj8GpvLm3uAcYfA5FIWkcQSct0zgP8BXB?=
 =?us-ascii?Q?5RVS7YMC/5YQ4Y8Xh71/hoZbRmJZr51fASJP8xTZ8DxhhnKi1Lh8Q+QoDnXb?=
 =?us-ascii?Q?DHVd+p5ASuCiq7pwDuB8W+tWaSuOcycjIeU92CPRihp7ue1GGp5sR4+T5l9J?=
 =?us-ascii?Q?qm1L9kt9QQrgoiTvISiaoCwjX3qjooOoTv3darjIE5xZWPX9KekqZNgBj4m1?=
 =?us-ascii?Q?Xq0aMlV7zREKTMHBYnCUr29KmukpgHDgBhGjne7nrfTsmHXu7KEX8AjvMzEH?=
 =?us-ascii?Q?Knu5q0C9PyKJTUoOhwIXydt8A4uYW1It+lhLEbMrxnC+WGx4k2eYzD9yYLu9?=
 =?us-ascii?Q?aMUf3Fpv8Q+O7uOJ59n/yHXDzkdaKzShU9Ym+z79taKNZ/PNGMgR9brQb9tz?=
 =?us-ascii?Q?HP+4hpnc4SZ85oHVHsjUexjw27J6SV5BtVfQwMnFnByB5gJTKX5s9hFJy4OV?=
 =?us-ascii?Q?V5LyWN4e5pgBLAYxwTTn0ZjmLziAp3DXmefmCV3w6/LrPzMHWjjJvNQTt7j3?=
 =?us-ascii?Q?Adm50jGYA2SkF4QGbmkebZzRkeoP719ewxmg+g/Bm2VdW3xOx2poFzysjbIN?=
 =?us-ascii?Q?0qH85ylt2GCweaqcacpFEWeUyAMHplW/vU72nFuTY0496oXXkIIPevOcYGrf?=
 =?us-ascii?Q?3i667DLTEwoSXam45Vlqk+287Mi9cN8nYYjs0uYfc1JLysw3ALmlkFODh/dh?=
 =?us-ascii?Q?BUpXF8xBY/+KwffqveKygM3zE2lWRh2UVFUbPHYo2rn/4JYLES7WyKiv5KW7?=
 =?us-ascii?Q?HlRuWznJC1Gn8OXVwtGaQYM112FBwvEXWyJKozpnJ56JFTUP0qi5hj6D24hv?=
 =?us-ascii?Q?VNmExQ6BvODJJhDOrLIA0+t780DWse7VUhFNQRlOCtnC7rhCQh4kNxyTQ7Do?=
 =?us-ascii?Q?/zJ3dQyxb8Xi793GRsNLmwaUhRylKw1Qs6QJ9MyR3f9PPyyyODVdPEGIxGUt?=
 =?us-ascii?Q?rQcCU5awkyagsl0JNIdVYDtye4nP8Q1sVNB+Q9BkC3zBOBqmWIq/HfN2qh7Z?=
 =?us-ascii?Q?yF0/AT1AuLBtB9r3tisbolf0kMpr2U2Oi0L20UtqcMutHzqM6Xyzd5u9IwdC?=
 =?us-ascii?Q?UnmwWSWns7CNSD6o47pAqMqy1hLcc2gMJa62NdCPyEk05WAtGm5DN5Pcrhg+?=
 =?us-ascii?Q?r+1IJYMgNtTDX46AVRtJ0QikqPp++SUjLalFeYBawp4V24MFXzHSdU7x3tVx?=
 =?us-ascii?Q?Zs61D9tMNwLb7k2GHB/V25a4ecnrkOFvuPkK4etZLyGTj6NT/i6eUmL+M42e?=
 =?us-ascii?Q?j7bo0yD2eO0WGIPC4pwGAtCJhjpOuk7dFUijvvArIiAzr3R7vETcof6HEfsG?=
 =?us-ascii?Q?Fb+5LE9VS9QuWXaZj41fadHVOTaNrai+bRhDSwzEk6jRwGJcuAYZLjDXpOd1?=
 =?us-ascii?Q?A05VSuzFOvFICsbT/q4CAixGot0YukOs7TgkAQiiHz4tk5GHmw0zHLMJUPtM?=
 =?us-ascii?Q?WCc/vU/v0dhOtdv3TAJqhfgCFPvNCPt9jixdUpHsLGOlFR5hWPPTXLO674zD?=
 =?us-ascii?Q?xz87gBKGmBp0JI4jSXULVN3XHAb80m1nODOpIOziXVOI19eg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5e020b-b5b7-414b-7d36-08dea8063858
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 04:49:40.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG8u+K3UimPsKTs36oWfT+R8QlBP+Nh3zMpsja53NkKpNDU608yGvDrZoVwbv+l75s0QdamO9g26l25buxaqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792

On Fri, May 01, 2026 at 01:59:50PM +0000, John Madieu wrote:
> When transfer->len exceeds MX51_ECSPI_CTRL_MAX_BURST and is not a
> multiple of it, spi_imx_dma_data_prepare() splits the transfer into
> two DMA packages. If preparing the second package fails:
>
> 	ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
> 					 transfer->tx_buf + spi_imx->dma_data[0].data_len,
> 					 false);
> 	if (ret) {
> 		kfree(spi_imx->dma_data[0].dma_tx_buf);
> 		kfree(spi_imx->dma_data[0].dma_rx_buf);
> 		kfree(spi_imx->dma_data);
> 	}
> 	}

Nit: duplicated }

>
> 	return 0;
>
> the function frees the package-0 buffers and the dma_data array,
> then falls through to `return 0`, telling the caller the prepare
> succeeded. The caller then dereferences the freed dma_data array,
> producing a use-after-free.
>
> Return the error from the failure path so the caller takes its
> existing failure branch.
>
> Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
> Signed-off-by: John Madieu <john.madieu@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 7ae8078c10ef..4e3dbd01d619 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1709,6 +1709,7 @@ static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
>  			kfree(spi_imx->dma_data[0].dma_tx_buf);
>  			kfree(spi_imx->dma_data[0].dma_rx_buf);
>  			kfree(spi_imx->dma_data);
> +			return ret;
>  		}
>  	}
>
> --
> 2.25.1
>
