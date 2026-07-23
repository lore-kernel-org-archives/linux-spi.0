Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE604242D67;
	Thu, 23 Jul 2026 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766797; cv=fail; b=MBObzS2BWLChvX+TgYcTfRG/m70xmfLKKb0kksTWYEEBN+CL2qqXFMjqyT7yTLox2f0cSP6OqJpaIvMTPymzyGlRj3qQt3VKjZcDZd3oYLt8ZlNUDqvFYWJudqvuY0/yVKIUtWRNqganHMBaZ1Q2eATDkS9OrndP+6qgWh7GnxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766797; c=relaxed/simple;
	bh=KnDXPPMa1/3S3iAxTpzCtQeQa+se+7xvSCoD9dVWUms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YbHHsJDJhFnhF9vR4Jr3NbjONqitpIujuBOzGysXuL7f5nv80ctLXVQ1ysDU/T4NAhXWkx/CpGb64a6hYjt+5MQyAhGhR0Q+gm8Van7PDCraxZh8yfbxzRQjPkTcmMUVutRYAh53Fm56YWEFVjePGAorKHOlGlfzyd9G8zeVazw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GodQmjT0; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GodQmjT0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNXRkU3DCKNgZ092BrpHcYwgTZ382mv1pNVfoRO2KEh7UevL1wuGvWhmEo1ux2PUyp8mlJKtMRf1HhlK2cLXFlFTklHmjszRVFfbYpO/5z1Mdtv/lrhWBiNY4w6H6jCM0dfkld9Mo4AurUwh3bmiaU+IXoQm6/OOylmx5rbAIkxCZRutaZZRzYkzTSrrLZf4miwbjdpkZsRVLOwmc2v1L5WXPb5HKXFzuV+3qE/NN2YTQ4caFgv7AfQyI6u/sp4iPsz41KsCBVSVH2DAWK1DYRPJoXI3AzegjBDcqo3njfWuYJ2bcb4QE4ey0KHxqhrIgRZ7REavPWg8eR3Oj+3FXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx3sj4OEXzWvByuX0+hJLjXZ1jc9I/pCn0J0KekMIfE=;
 b=BK6LG7WZCRymxmEIbyzOcmrVdcWdLNvHUY2oDkl9nqK4v899qaLrAleQjjD6VEnUiojnEMzu93yi287H4qb5TaXZNW4+mzWZcMe7Mr/p2clAq552fGOx+wSRFhwMbFzG/edUYyeIrgUrRrI88XalgZ3GnRvpkce8rnWlr/vU8xhOdgjoRx/3FKPgz1fQ2UAIdKEBXPJX0Ou/dqikGKJCVCHdMkN7f0Zwpmrfxs0SMoX6xkJloJcPdQOmp6tWPuReS3eHsVuEja1O1LStHbOKOije+srnwTr+iOAUXi8gh8GoI0xZ6ii1gJYZRCqkdIIZ+fy6Djdpgeo6GbIVDLBe9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx3sj4OEXzWvByuX0+hJLjXZ1jc9I/pCn0J0KekMIfE=;
 b=GodQmjT0e5y5pR7oL6YkMO5FiaoLKAW32xgHXDfykSnE+lNnSMaK2kpCl2wFbdJ+HOK1c3L3WyTjSlGgs7MX3ZdHOim2a49NSyJRZWCOv+dKnwGsOA1pG88K6+sIjQV+aO/ShBHIp6SVxFsdpDDfpWYTrreaU83W3ID/fAzZP5NqW7jUZIrime70uMIcFz0I0lpK/R7oIDFk4LtJGPErTFprIUWl1DgVr6gb2Ghss3k5yu0GUjiRYry5TzqIK3AXO3Ri8eCJfLQQCyzJEXWEsiHh4fhBfZ2q9t8hBl1/QE1lNkIhJyjdpuN2B693mIrawCYC/yAh3QQORiPGncvE5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 00:33:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 00:33:11 +0000
Date: Wed, 22 Jul 2026 19:32:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: han.xu@oss.nxp.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v3 2/3] spi: nxp-xspi: Improve AHB read performance with
 DMA
Message-ID: <amFhOs8aXWZxIrIn@SMW015318>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
 <20260722-xspi_dma_upstream-v3-2-6b7ff50cae8e@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-xspi_dma_upstream-v3-2-6b7ff50cae8e@nxp.com>
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 523ce8b3-c729-4613-3367-08dee851f95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|4143699003|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qrSGpM4KjKHhjkbwgLzsQfCPSiWmgQ3oVnDVTzz5lWmkJnvxXYTjgkXaVx1nOhUVVTzYdFTbUGt537K07vEFLowX7olG1B6V0OmxhXbek17x4JB92axnFIFNFXSi36niwPXkuOB255KTaiIREcr9wGKahPHHJkwmzs+U68jkJi5StMpasc7NgwhK5cyocYHKX1B5OSGi9g1UMGcqDx22HJRRo2Gshq8uHtARgkSNHtADjVcHAKRSOyIcHxJbuMKTvXMYWECnGwHSFPCTggtTTJaPjYUmaK77yJ7SCvs0FQBM8LvTLmLZE3/SzvDxxm8EdYfCMetCZfsxJvpHYE1px+L06t+vMKZE3kg4qVGle0Rln3n7oegt3ZOK2Vi47j7W/M1UUeeuG5g7oKVP2Oc9k6LpI9aZQ6Y6lt8NUTSx5HAZAUx7ikH/SXW/wCyY+N5INaqVv0nnX+hQwD+jXHBsqbVSEggy34c02aPfc5yfo+UjNBrNjOtkHZCvALBrmWZEH0zhxVYZp3LxAyEelvrhTpLoDFUyUPnB9P2w2/wv21foIXFufmnObJyPhWk1NXpB/jVnxF+UHzTKkpSzHxxSnlma7591AD0SDwNGw1u3uVssnqbS9elWetx+ao2sU4SrjZHZP6HQ5TwvNnJkcd8msQfMIbfODb15+X++zh8Y2Os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(4143699003)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kOhyoI/5Uz5SKMEZYnraXUIaLVvFFUvHizKwL5igz3ANKaC4XUdHVGISJs5f?=
 =?us-ascii?Q?BL0ULL51qz5OZT99V7vrpmE1V3ooybEesQHj7dNE7q/pveTrEgSAbWvQJio6?=
 =?us-ascii?Q?gCH30BupIPfxTmu8Ct26KECT2dvaKRkBiRKSf0lFWls7d2Q+SOee4tUi04zK?=
 =?us-ascii?Q?jYscl8UGhUbPl2uwJ9ektHOsw0eaD0ZNoqEeEDC7Oke7G9Q+CXxWTDW0JUTS?=
 =?us-ascii?Q?6E7g7HFUCoIokvRoe6I7dWPLkkS/BNJQd2ScMC2l2dTiSTLYKFS6s6Y6Uefp?=
 =?us-ascii?Q?oauaGZySCLL830x2vyrpQdmNbQNNEOLmoq5wRgtMYn0uc7ECXRHAp4woAY3I?=
 =?us-ascii?Q?E94knIpBPiDWeWpbmn8GnIn4GUKRLeY6Tg0TEvYsxspO+Zg02AmS47QyJjJg?=
 =?us-ascii?Q?syiJXpMqHEiBIYq7NBj0A9Epiz/hAGFHogyAvETnTbUpsOrcjWTmx58MmjPJ?=
 =?us-ascii?Q?XCqPHtDquoSFkHfPNnztaBgywuTJy3NNp/LUwCp5PeooVtdyTnlf8ShEDje8?=
 =?us-ascii?Q?P/8ECRRxvYv5C39wK5ocVCpMEVyeSf8RNK8wY8V4+IOulidySz1QN1SCVZNI?=
 =?us-ascii?Q?Dp5cSglQcCkWbRLml2QGjQ10W0HUjsCnMKRp6Ja1WtdvuZPqXO4U8ONKncEd?=
 =?us-ascii?Q?727i8OoinUgL7T5/lvGUIBb/lNtHIz0aeZDS8evMNNe+u3H2HjoA5q22h94d?=
 =?us-ascii?Q?DMb+QYpFkcSOc854rL24/5fB1EUWwnbDQQBwnR8HtZJ80neO2A93hGZonuNu?=
 =?us-ascii?Q?Fei0QvOQCn8ngRnOGS5p475jknha53AOS0LKtjRAEoEv9pq192gvJ7ZLQCSP?=
 =?us-ascii?Q?j0M6wJHAZeBLJoQd2epl+smp9hshKL0K4IUJFmwTLP6V6W5OBEKqb+UUuqA2?=
 =?us-ascii?Q?pDehF2ebBlrN0i06pQ8jijVtfcUHBoaTSA5W4SA8q2rqXbfjWWZpunAiGExq?=
 =?us-ascii?Q?fIteO4X+x8xDtRn1UY3eERPiJfWg1Ex3qhNeGo04nXlz/eW8wItvJWRQZqre?=
 =?us-ascii?Q?XrLvLujLWTJjJlRa42rzb2E4qigTq5KZg0kboQ9AjdSvBf6KkEPigKsPpoc7?=
 =?us-ascii?Q?1G6rlb8yJHvpVOaL/0mPH86FGMd7fBJCQsRuCHYFm+QYIKQKrHX76HowYk/g?=
 =?us-ascii?Q?iaCyI8Hneq3dQy/zCrJ6MfssEdDUnmkzXeeG3JuxgtYoX7ApT7/sKCDEgqU3?=
 =?us-ascii?Q?C7aGS4dFJhHi6a3o2onH9vzAPqrsqpkEf9rihWkXtpxcjo7u+XxR6MHi+VUg?=
 =?us-ascii?Q?tp5rnrBaXO7MxN89epLrD1fmllitEexn82uuI48a5F7PAnl35jhjU05k/n4O?=
 =?us-ascii?Q?RwpjanTBmh0mI+D3QJv2fFitOa7cnOUPB7QfuRQKxoF2p1GQWCppyRgDENMR?=
 =?us-ascii?Q?oRQVg2BB0r78s4lbEPtu/wrUlzn5r2NkqdDNsR6MVF/lZXfm+ULqOXQ5/Owj?=
 =?us-ascii?Q?4uCqv6s/wiiaJIeGqYNlZ96Ki0s+NA+letbr40wNwysOR1ZVx1kdgDjgPu7a?=
 =?us-ascii?Q?0YlBTDCQnVG0jRwe4Rioq0mXu7BeT99K3qLiXYxS09Yx1TQoACpVGmQ67znp?=
 =?us-ascii?Q?SNtz6kdtNrtttvQRmSPwatgl2XL1JZlghTY1UJ+xKsEN2OZ6DnuVMDY2O4fu?=
 =?us-ascii?Q?tVsMZBrTg1XrVTL98a+YvtFdBOiGlsPSuznRQrnEIo5Irf3osevsULBIx56z?=
 =?us-ascii?Q?reT50n3/qj/AzFWhnB1jU+QPcxvvrQzCQ6qq2B6e8Ee9n5KMy6ItwhQR0VBG?=
 =?us-ascii?Q?BGRi+NgHZdgeduUnOpN9S5QIGuCtZ2bygAOwVczhDmQlKDfgoHDQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523ce8b3-c729-4613-3367-08dee851f95a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 00:33:10.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cuoked8hwtinPmLEsvEKE2yEECzGIhspP2tXYTd87JD0T/41g5+shNZR8Y8njAAM5G8t06RVziGB4J10Ht4bOgm5PWKvCV3tbpqc9OPkMGD06w1KSk5H4UASYOSqZUhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

On Wed, Jul 22, 2026 at 05:00:43PM -0500, han.xu@oss.nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>
> Use eDMA for XSPI AHB read to improve the performance.
>
> Read with CPU
> root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
> 1+0 records in
> 1+0 records out
> 33554432 bytes (34 MB, 32 MiB) copied, 0.479719 s, 69.9 MB/s
>
> Read with DMA
> root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
> 1+0 records in
> 1+0 records out
> 33554432 bytes (34 MB, 32 MiB) copied, 0.115788 s, 290 MB/s
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-nxp-xspi.c | 143 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 140 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 037eac24e6fd2..70cbc3ef658b6 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -35,6 +35,8 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -303,6 +305,12 @@
>  	(opr)) << (((idx) % 2) * OPRND_SHIFT))
>
>  #define NXP_XSPI_MIN_IOMAP	SZ_4M
> +/*
> + * It takes 0.5s to access the entire area with DMA,
> + * leaving a 10x safety margin
> + */
> +#define NXP_XSPI_DMA_TOUT_MS	5000
> +#define NXP_XSPI_DMA_TOUT	msecs_to_jiffies(NXP_XSPI_DMA_TOUT_MS)
>  #define NXP_XSPI_MAX_CHIPSELECT		2
>  #define POLL_TOUT_US		5000
>
> @@ -336,6 +344,9 @@ struct nxp_xspi {
>  	/* mutex lock for each operation */
>  	struct mutex lock;
>  	int selected;
> +	int dma_copy_align;
> +	struct dma_chan *dma_rx;
> +	struct completion dma_rx_c;
>  #define XSPI_DTR_PROTO		BIT(0)
>  	int flags;
>  	/* Save the previous operation clock rate */
> @@ -796,6 +807,95 @@ static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
>  	return 0;
>  }
>
> +static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
> +{
> +	struct dma_chan *rx;
> +
> +	rx = dma_request_chan(dev, "rx");
> +	if (IS_ERR(rx)) {
> +		int ret = PTR_ERR(rx);
> +
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		dev_dbg(dev, "NO DMA RX channel, falling back to CPU read\n");
> +		xspi->dma_copy_align = 1;
> +		return 0;
> +	}
> +
> +	xspi->dma_rx = rx;
> +	init_completion(&xspi->dma_rx_c);
> +	xspi->dma_copy_align = 1 << rx->device->copy_align;
> +
> +	return 0;
> +}
> +
> +static void nxp_xspi_dma_rx_callback(void *data)
> +{
> +	struct nxp_xspi *xspi = data;
> +
> +	complete(&xspi->dma_rx_c);
> +}
> +
> +static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
> +				 const struct spi_mem_op *op)
> +{
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_chan *chan = xspi->dma_rx;
> +	unsigned long timeout;
> +	dma_addr_t src_addr, dst_addr;
> +	int ret = 0;
> +
> +	dst_addr = dma_map_single(chan->device->dev,
> +				  op->data.buf.in, op->data.nbytes,
> +				  DMA_FROM_DEVICE);
> +	if (dma_mapping_error(chan->device->dev, dst_addr)) {
> +		dev_err(xspi->dev, "failed to map DMA dst buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	src_addr = dma_map_resource(chan->device->dev,
> +				    (phys_addr_t)xspi->memmap_phy + op->addr.val,
> +				    op->data.nbytes,
> +				    DMA_TO_DEVICE, 0);
> +	if (dma_mapping_error(chan->device->dev, src_addr)) {
> +		dev_err(xspi->dev, "failed to map DMA src resource\n");
> +		ret = -ENOMEM;
> +		goto err_unmap_dst;
> +	}
> +
> +	desc = dmaengine_prep_dma_memcpy(chan, dst_addr, src_addr,
> +					 op->data.nbytes,
> +					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(xspi->dev, "failed to prepare AHB RX DMA descriptor\n");
> +		ret = -EIO;
> +		goto err_unmap_src;
> +	}
> +
> +	desc->callback = nxp_xspi_dma_rx_callback;
> +	desc->callback_param = xspi;
> +	reinit_completion(&xspi->dma_rx_c);
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(chan);
> +
> +	timeout = wait_for_completion_timeout(&xspi->dma_rx_c, NXP_XSPI_DMA_TOUT);
> +	if (!timeout) {
> +		dev_err(xspi->dev, "AHB RX DMA timeout\n");
> +		dmaengine_terminate_sync(chan);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +err_unmap_src:
> +	dma_unmap_resource(chan->device->dev, src_addr,
> +		op->data.nbytes, DMA_TO_DEVICE, 0);
> +
> +err_unmap_dst:
> +	dma_unmap_single(chan->device->dev, dst_addr,
> +			 op->data.nbytes, DMA_FROM_DEVICE);
> +
> +	return ret;
> +}
> +
>  static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
>  				 const struct spi_mem_op *op)
>  {
> @@ -1016,10 +1116,21 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	 *     all use IP write.
>  	 */
>  	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
> -		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
> -		err = nxp_xspi_ahb_read(xspi, op);
> -	else
> +		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size)) {
> +		/* use DMA for transfers no less than ahb_buf_size, when DMA is available */
> +		if (xspi->dma_rx && op->data.nbytes >= xspi->devtype_data->ahb_buf_size) {
> +			err = nxp_xspi_ahb_dma_read(xspi, op);
> +			if (err) {
> +				dev_warn_ratelimited(xspi->dev,
> +					"DMA read failed (%d), falling back to CPU read\n", err);
> +				err = nxp_xspi_ahb_read(xspi, op);
> +			}
> +		} else {
> +			err = nxp_xspi_ahb_read(xspi, op);
> +		}
> +	} else {
>  		err = nxp_xspi_do_op(xspi, op);
> +	}
>
>  	nxp_xspi_sw_reset(xspi);
>
> @@ -1029,6 +1140,7 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  {
>  	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
> +	int alignment = xspi->dma_copy_align;
>
>  	if (op->data.dir == SPI_MEM_DATA_OUT) {
>  		if (op->data.nbytes > xspi->devtype_data->txfifo)
> @@ -1042,6 +1154,22 @@ static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  		if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
>  			&& ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
>  			op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
> +
> +		/*
> +		 * For AHB DMA read, align the transfer to the DMA alignment
> +		 * boundaries. If the start address is unaligned, shorten this
> +		 * transfer so the next one starts on an aligned boundary.
> +		 * Otherwise, if the length is unaligned, round it down.
> +		 */
> +		if (xspi->dma_rx && !needs_ip_only(xspi) &&
> +		    (op->data.nbytes >= xspi->devtype_data->ahb_buf_size)) {
> +			if (op->addr.val & (alignment - 1))
> +				op->data.nbytes =
> +					ALIGN(op->addr.val, alignment) - op->addr.val;
> +			else if (op->data.nbytes & (alignment - 1))
> +				op->data.nbytes =
> +					ALIGN_DOWN(op->data.nbytes, alignment);
> +		}
>  	}
>
>  	return 0;
> @@ -1203,6 +1331,10 @@ static void nxp_xspi_cleanup(void *data)
>
>  	if (xspi->ahb_addr)
>  		iounmap(xspi->ahb_addr);
> +	if (xspi->dma_rx) {
> +		dmaengine_terminate_sync(xspi->dma_rx);
> +		dma_release_channel(xspi->dma_rx);
> +	}
>  }
>
>  static int nxp_xspi_probe(struct platform_device *pdev)
> @@ -1283,6 +1415,11 @@ static int nxp_xspi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	/* DMA is optional, failure(other than -EPROBE_DEFER) falls back to CPU */
> +	ret = nxp_xspi_dma_init(dev, xspi);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +
>  	ctlr->bus_num = -1;
>  	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
>  	ctlr->mem_ops = &nxp_xspi_mem_ops;
>
> --
> 2.34.1
>
>
