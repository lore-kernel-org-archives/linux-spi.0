Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723F320A00;
	Fri, 24 Jul 2026 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921736; cv=fail; b=nyq6J4ra7C2wNxtmwmJoeyZyMevLZ7tpssUzM3ohalT4xisswRN5bSK+a/ive5Ny3g0hauad1G5hs6FzcI6tknTNagGseBdVOaEUs4X6BxxWwEjuxq1CpB/eAnCyIY1nHNQLZgyRSPxwo0dujsub39k6nH4nZUvn8ifrwThZK1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921736; c=relaxed/simple;
	bh=iOAt5/6IIzt7anPcyL6CaZ8lEa/ZGtgYZwFij9RPWfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKMZEEOF41ErcH7n0qEZlq25FTswEtRxextjC2VplSdN5p+0NmkPVALDsF+4vGDNVazEyaT1YLbgKLryNIoc+t/ajq9mOVpjPNY9JvIdcFeN9eov7daKszjOEhERd2YIZUwouF0EWbB6WUfqAUnSQK5zA40OxK8Is+yz5xELZeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=brJtkGRo; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="brJtkGRo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJdf8/flXOUkP3j1pNukHV2smZZwfpbfA7JAuVoc++jBf0OvBQBPVuLQc7VHSUkaCBECda4KiBB8w7Gv1Xng/Whq0hArst+xLESORTOIoeLbqQJ8ybE+GpTe4r92iu6UcKDa8yYoLrN0jm51aQlV01y0HSHdgzv4T+urHFwfpU+QUR1OKPZewDcLHkSghT6pWXQVEBxMKTEI4zYL8tU3nYqJe+4uzYPJmPlaz0wIADmicleHbzCGxPnwLf5eCmUwY5zRlBhMBkrcs3WO059IvBERm0LATbHL/iL3RKXC0ng/8hKvCuIbbrzkFx4UATiPnXSANFUqPq4lbOd9IBJaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q852HDl/X3D1aZNvrQ8tGTIffyFNb2ogAzE91eD8s9o=;
 b=Mfl5r2DsVWyibHuIeGqq13xztAbMaQb1Kw1qJmNY7Xy7Hr9sxXBm9/6QMFH4i6GiHH7mUX8vazWYBli8jBOp5gtpkXIF8epnNtvfUZtjsotxbstIwdHgtuhgDT6pOUah1sz6zOyGHyjc/UAPFUZCL/pespO1cv8/zlwj5AgADlIEMZCerLwQ9xfaG6KPxoJpvh0SFE9ZP9PWmL+l2ATte4cZt8A0qcXEyDhI5osL4lb3SCBpmucsrZgWLua9HvmlcbzJqVFt+yi536Fhl7f4kcw6U8thfyyTTmVEbk3/GsJ0BN8k6g1f30/8RTb9roR3B4PjjyyoZTH1yHAQoE7+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q852HDl/X3D1aZNvrQ8tGTIffyFNb2ogAzE91eD8s9o=;
 b=brJtkGRougOGxc1HtvZktVDLAjYBUskolP1pUUD/GShXfA2JJwRo89A0+0Jk0uIqoAXiBd2rKUNnfQq2wRsgSstGU3ezkm/svomP6+hemMU8gcm1b39BTX8/i/ku8+WS/OIj0VtlVtm/fmQ8ZKrSYHNxVLGqf0dVWRlCffD/2YUKvHN4Wg/bCknNYGXir5KlIULi5dJ2euwMBaHxr5j6fqdr5jFMuw9uG9+j/lQWmbGqQfNnNgUmtxpgmJ7NEwUduiu1GebJVl7ejqgJ1s2vK9v1jOeBrc+h/Agv6xlMiBCLGDnqxH3Azt1ozm0pJuxJAwDH9F/VwFp3sdhvwKj+Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11547.eurprd04.prod.outlook.com (2603:10a6:800:2ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 19:35:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 19:35:31 +0000
Date: Fri, 24 Jul 2026 15:35:23 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: broonie@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: imx: replace dmaengine_terminate_all with
 dmaengine_terminate_sync
Message-ID: <amO-e2ThPaB-nqC9@lizhi-Precision-Tower-5810>
References: <20260519104659.2794476-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519104659.2794476-1-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SA0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:130::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11547:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b91c7b-3496-4fda-6487-08dee9bab918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|19092799006|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6qreBFJiSuJ4vUwWv6xJ1VQ0fi+OMzXMB9KPeo+mMI+x0g8JnSCsbuRvCHX6JMgkWlhNk0EJigheb68rinBgqajs1Nh+uIBtCKssQRP1SwbxmFLRCLeHtmQMbXh6vS9F6anjmXRIRtIT3RYwfKe0pyW7uiZ7N+Ve2k8BdiVj8sJzrkwkUUgChp6SwYNTeXonWTtnmbuBNxGCvPGReI7AkUBXgtDezRnic1zT+9HW2MWa+VtOCBVkee9SObFsYMlFAWlC2zpVwboG+t9bhBLC4emWPfAN5pqDHt9SXV0yNLUHaYDp2aUtT7ohHScsKSUOuisLmOhHi1VDoaWNy68AapplILsJaMTvrBXP6voaUjpuL8Kd5DsvCD9sSIQEvBCPTLK+tJSQ3wQ5HTWGHgt3fe1kozQqTWptCodYzWiu8Rwe+0qiEOk5IgSuw5cS1aMY6AzQ9bXfZ024oTL/xz5RSDqSBpEQcWN2S+wfZ9Jgw85d+VeMEbRO0P/zH11aS2aluNe4PKY6lVZzVzz+wGJRgyY6NQAHv71481+59Z12+qt8VstzPhpMYOqa98iPyx8OotJ6H83Z9vLDHZk/GfXnxikGKdxHlYquxXT9cwUkjuAaq+IQF2VnTijoy2t+iegsxnzHab7ufGmW2rA5nHOrU4zRKLDx1ECpbho49r/eo7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(19092799006)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNn5+QUa8vJeTGXuZBN4x0kx7lux4uaWyOhtbqEhKtVVkWa2OBhPmFxalycH?=
 =?us-ascii?Q?/m2F6kmNL60XOw9eRSCe9XILU41pzMunN3arZn428528JMhrOk3B7feWf0bq?=
 =?us-ascii?Q?S09Av0yUTlcECHjtA9PIZxtp6uonEy9J18TrEPtoZH+W7nV1udRJjJF70a1K?=
 =?us-ascii?Q?qvA41s0E3+q7XNmAv1cp4M6dT3KbCmMdosGSDeQeDSgWZV0yepPmLjBMRzUm?=
 =?us-ascii?Q?nxr3adIEfzFXJClNDr4WXRHGWGvE1b4mbtlouWKWw7EyDWgZVsm/0mxejKrC?=
 =?us-ascii?Q?1qBWyAXcTk1tCXAANZsVorGC8lRG49hnZwpn7nBXlswcqHoW57TSLrthmxH6?=
 =?us-ascii?Q?D7ysQubp5a6g1cpd/7P/SS8eYEyLFS+NA7ZpzyEcv/slxVlEnF1BligSYvy+?=
 =?us-ascii?Q?BU2+0sB9SKZExF38xr/h1m4wf7fovxR9od2O/HUW0OZUjN5r620zxK++N/Ma?=
 =?us-ascii?Q?zApGX8a5Ll3efrhAzpnruvyM1/T/qu2yoqt5C6wRBV3DjwmeytgxzTKY+X3x?=
 =?us-ascii?Q?enGXcqd+M9qcBB9g3fpYilCpLwZeb3j6LPOZd5jgcHhZJm1DKtNANqKJ1jyg?=
 =?us-ascii?Q?mSeyWdJJy/ebfZ+SRcFdD0SWt/EI0v24rmq3zt07i4mIXr2+UC2fMuWVeKUY?=
 =?us-ascii?Q?MyN8LEy8EStL3HUY3/HV8TZc8F6l64szh9Vq3XJ4M8XsCze09S/C/PjfF3aj?=
 =?us-ascii?Q?b/edPRLXSfur8UTORrHn6a+vrBd0mEN/udi+EenjjOBOntmiVzYTXHu8NtsB?=
 =?us-ascii?Q?6EsH2Q/gSKpodCZPgoJgtQrTg9oEWquCpECTgzcrwJ4m3dShCCZCptoS82Cl?=
 =?us-ascii?Q?NUtE/u1eJDAvDCLutaGMBNWUDS7+Zjc61W7qtQhrv15pictzHComiqBMNq6I?=
 =?us-ascii?Q?RBY3lzr1MobUuOCjJ8cTk+kNyknbw64GbCFSXX1LhFm3hZDfPqKMoz6cWdah?=
 =?us-ascii?Q?llXRGrsnwJJwky+2mW0+mpnmXeJa2Emmc78QSS6WVDekodTItX+Jgdde0N0W?=
 =?us-ascii?Q?G1J/TJwXvABBVkuZCtDc0yK+kAErh4wN/irw+6xIRwCnKl729ULz0auPw+WN?=
 =?us-ascii?Q?Wgzu2R2w9tCHelzWh7xn9oV3nLpCtnNy7Pre1zlAX66jJCRnmb8bZjutZko2?=
 =?us-ascii?Q?VbHw6zhN47bH+Kjedlo+fSQKtogK2Ol/znXQgZEaMDpNtPL7053NSFLSf5JZ?=
 =?us-ascii?Q?1ZQqXU9qiqksEuXNgEylKULZV0NWXSTPabK3XjvJG1fs+hdgok/mhtcrf30W?=
 =?us-ascii?Q?RbutVh+YlVSCHkpW/JM6cu+h9bhcZaomugIbBtsgmxpm4kSkClfmQsHJz86D?=
 =?us-ascii?Q?TELDoT87ucVnTwb832ZeLF7JnndNYhhvBV6cTpnQDipSh/ZnYx0w6GBR27sc?=
 =?us-ascii?Q?cZk3e2qZYmk9u/Ss2tsbwsu33Qd6UpcHv/RFQiMGtCLofrmmxbZXfGXtQGfu?=
 =?us-ascii?Q?LEwOVBw7SvGcAizC4YfIpfQr6MhdE5780lEarJPhiqHILVb/V6jTR8feBPkw?=
 =?us-ascii?Q?jsnqUcaP/uiIzN//S+f4N5JdXy2XrZIS/fgx14bAQOdIbgPLfg/rlUi0XWgy?=
 =?us-ascii?Q?Q/tQxl2/Y/7lFzvimgnNwI/H/4wo4CpmK0qJK6eyaAde+FJVyLLh39zQbsuK?=
 =?us-ascii?Q?bp+2TAVuCVR1koX1HtJ+F+fGQNKCyCtQW+Xal9HcELut2RObkGantTjUn+Nn?=
 =?us-ascii?Q?Q+gFvDQ+CAyIpOLo0t3GZpxgAHX34dlZrv7ddh/1t7AUz0ICAlS3jhMfLZSH?=
 =?us-ascii?Q?t0FH8fKEcf1iSNcr3slc5hF5A/2Rr1oPRklbCPRfnm5ST4pvH9j7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b91c7b-3496-4fda-6487-08dee9bab918
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:35:31.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4bCVoQm77Ajlp6UaqTSbcx3v4i8saQ8xMJTj/lNbkYndw/IHkh0BGS6yV32/G12JlZVG4mIhBhCDBfBDtBBxxVLSdvGcy4GYzS0gp5VQbPp3uUTvegEojfGBUb1LqjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11547

On Tue, May 19, 2026 at 06:46:59PM +0800, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
>
> The terminate API dmaengine_terminate_all() has been deprecated, improve
> driver with dmaengine_terminate_sync().
>
> Fixes: ba9b28652c75 ("spi: imx: enable DMA mode for target operation")
> Fixes: a450c8b77f92 ("spi: imx: handle DMA submission errors with dma_submit_error()")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/spi/spi-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 480d1e8b281f..ae9912905c67 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1774,8 +1774,8 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  							transfer_timeout);
>  		if (!time_left) {
>  			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			return -ETIMEDOUT;
>  		}
>
> @@ -1784,7 +1784,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  		if (!time_left) {
>  			dev_err(&controller->dev, "I/O Error in DMA RX\n");
>  			spi_imx->devtype_data->reset(spi_imx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			return -ETIMEDOUT;
>  		}
>  	} else {
> @@ -1793,15 +1793,15 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
>  		    READ_ONCE(spi_imx->target_aborted)) {
>  			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			return -EINTR;
>  		}
>
>  		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
>  		    READ_ONCE(spi_imx->target_aborted)) {
>  			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			return -EINTR;
>  		}
>
> @@ -1818,9 +1818,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
>  	return 0;
>
>  dmaengine_terminate_tx:
> -	dmaengine_terminate_all(controller->dma_tx);
> +	dmaengine_terminate_sync(controller->dma_tx);
>  dmaengine_terminate_rx:
> -	dmaengine_terminate_all(controller->dma_rx);
> +	dmaengine_terminate_sync(controller->dma_rx);
>
>  	return -EINVAL;
>  }
> --
> 2.43.0
>
