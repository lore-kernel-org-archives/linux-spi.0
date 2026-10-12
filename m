Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB63D34B3;
	Mon, 12 Oct 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833501; cv=fail; b=WPyss+SdXdjWoRSjVtRtwuDrehsViW3rav66J4WmVcSvsOv5khYman+DRusHbSqDWF4y54ga7pZmme10RZb+gVvQRBALrSlu6lsb4bCmiDFB6FtLKybRsIOA59l51olQ6YC4bB2xmr2kDt9GS/EcUKmS2Q8T5N5rur1kSQ5PdHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833501; c=relaxed/simple;
	bh=c/S+7TrjYNa9kuK4ps9hxIPQq1KXEfurcnpbqlPH0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PxXMRImwb9HgAsYz2iTYwPe1iQLvGY7r259pX5AfFM+RE4lOsbssoXosJyrMj3rIvI2k6mvUz3ReyMEUyDqZtqozFvfd0vSn16F8ClFXwVaWK6iz2wjVAeM5asIomhKzMgm2T1d+AvfLFZiFl3n5ffqftDyeVtt9gfTT4MCkS7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Bp3eGOPM; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bp3eGOPM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUr9ARrQyZRAT2iKzOhIRB7PODRxpGWuTtvSvLA/xl0qPr9qopZ10EdXf3Y1T0I3/wv0c+sOyIq7QnC3/OBTpxpkOROZbJ6mLDZbd4xDu9AdXD3D1oom+H46fO/piwhf7bMbjsfGXr5OQCpxQMHYcXIn2XKsOfijyD6Nnpdb5jbDteqfBYvRe4xNQvWZjFfmtslh43KvW019nppU0Z675vzxwp7xRN1IFyAqEurKHGBmXOlL4FQqqeNrMDmCrrBBNGNUKVSlq9Y7uDY2nDxj++SrTUOMmpO3uFtvl9uzmAtvXEi1kcg3K2tiAmDhEtGb5pShYrBp0LP968DuRSnfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovwFXanajD5EMXLXvnKfWBFmhe3k4aP8PCEEH0zPLKw=;
 b=TKrtywF0iMbnCD/nq1f+B3emgLIaA3dTb/DeBPzvRo4bAMu5TvJQ2cLWXUh6vmv/qrQ9IAKi9hjo31CzcCxomxTAZNfrhCPsNAtZFAFSJxOYVZqEftEeOudoGd5oBjI8USvMu2vzHCU2MDhZtb83Kc2baDqBje+3AdFUHUjkxGjTB5qaFeBLhUWlju/bMXqvbR7YVf0cuQDkcKD83TU/yr6DuUeauf0kDhn83dkPZS1NYPGQjT+zlJfByBKQ3RGyXqIPThdLIGLcZavItEZJfeBzwYSXAcoNKW7RcqHTvG+n1vOUeLVjiUoQD66lgBs5Mx79jJ9ByamCb+czvUGcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovwFXanajD5EMXLXvnKfWBFmhe3k4aP8PCEEH0zPLKw=;
 b=Bp3eGOPMu79Oj1Q74mFtjC+ldxQRR+zx840kAISd0KE8jTd4RtyJfPE/Azb7xkUf6uJy2MhP1DKPoPRhgDre70ELJbgRfzTUbYBgcx9DJGxAP9sQY54092PMvfy+PcgzTu+PldD0vwq4VXfdX+dRJEwEI25FIzhktD/cpP67HgqeMu4qh0LwNzB4gaz8Z9Blyvp8UI4jEs2QvVJ1UXoD4rrK4b3I2VAFoSYqwx8ZwmiVq6N49NbJRBpqNQv04lzFP4iNHOxImc3Gpp/OmHtFZiA2IJ/8W+rzYNCCbpO1M6sEtkbZ+CZWt03t2vY1TOfJQVtFycB9F4cE0GdZL/cW6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI3PR04MB213044.eurprd04.prod.outlook.com (2603:10a6:800:375::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 19:31:38 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 19:31:38 +0000
Date: Mon, 12 Oct 2026 14:31:30 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH spi-next 3/3] spi: spi-fsl-lpspi: cache content of
 Interrupt Enable Register (IER)
Message-ID: <as01km6qZJ-pxOa4@SMW015318>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
 <20261009-spi-fsl-lpspi-more-cleanups-v1-3-2d4549d5205e@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-3-2d4549d5205e@pengutronix.de>
X-ClientProxiedBy: CY5P221CA0143.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:6a::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI3PR04MB213044:EE_
X-MS-Office365-Filtering-Correlation-Id: e80e9f0e-9892-485e-7603-08df28976f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7c03Y/jQn5w7KeWQ5Q5yh47+yHdub+LJIIlmfgNAEpafVzORLyow+7U42SoCs7Sn+Ln6kak/NxsWuZ/GDf8RdgqDfcyP52ibF9KbIJsouWO1MviWSOHpjz6irBJfGi8G+kasW3YPKhz3JOrtKKg2to+0HCkFYbCAOKBzW/SmHHyXHOIZ1nC37165C30kCNeAO+KHvg8bJlSOa5syUDjYJ6q1Rzb06Q+QFN4tKcI8yjJhkT2NtEqpXaPvdBwYI7kNkx+GZV6iNTkYTb9gjplHJ15Z+EAIdgrAPNzr0FUOWbSdqQP5hyXZIwIM7xg+iaXLh0h+NjuRlgX/BlwJUZ7bh3M4Auqjlrs4KZjKjMCSSwqYy0AJ+/qLP7LB05Os+c0xejnyo+VLY+orPRVrsh6jWvGAc/RxongIR5ad/N7a6RP6tz7uOAPunXNlWnVTkMg/MwN1qLbwyzauxfBS3JMNI4g9SJH3e6SZQuDGQoFiYMaEdoqLDFXf8/7PQslzSPlkdyj/7juWD1PFKCUPsZwSKfQwHFWHQUeMQk++oBhvzDJACe7muvKYbqnJ2L3f5Vztpy9dcsCIb2gI+b2Ll2KD515M9COOntBAS0ZrVXB6MyXXRCAhotYVEKZFo7h9m1DcC6+qAywGATTzdTxxFsTEfSaFN84284BVwt7upj0e2nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SSJTbzu+sdjsuNeiUkTP41iXYQPm3Le5qrwzgAwdhhtiYv2phbyy8AWGLxRP?=
 =?us-ascii?Q?iZdM+YrzemjxCLDoDx9o9YjshbWg+IungmrekHmi1pD8yeXYl1iwpsPe+OKO?=
 =?us-ascii?Q?mx4f4EYObsU11gFKwY27pvmxlZTwdsr/wN64OATnksaP90EvK1jgj/T+B/nI?=
 =?us-ascii?Q?Ftsf03tzQoRHVMJphz+p7XsoPogeKDzvyZqrQB4YBGf0rZjsUEe/+X4T/EIN?=
 =?us-ascii?Q?I/ODXghHNuuYuFJRagkNQmzqubklsTWedEiHO9tLlOt4SrddxCd+7+ZNqLF6?=
 =?us-ascii?Q?DByXK9IAudNcFI6rdwQVKa2KjbBQRefypVGrllEK0rDYqiw65xepLwmM7rM5?=
 =?us-ascii?Q?jkPlEFgizu9B49CQtRglSzJPY1ejVK+f1FB5xDSzP46nqAgH1fOUZMnP9qb9?=
 =?us-ascii?Q?7tXgnbGvQkIng63gTD8HGV5fYkYYkNA5VHK63beyh/Ms8RXwIbZ/LKn1LWNH?=
 =?us-ascii?Q?umztihiMTdRK3uIG53g+mas20GgS93xhj4uEVZzULv0U12Bh7LwryabEktMm?=
 =?us-ascii?Q?4vKELrBw2ipyM2zYOQSUNYCJYF0+Vqvj21afp+egi8Pzc1rWEkmUtA2rHvLJ?=
 =?us-ascii?Q?K1EpkaBzbfrMD487ibcDTqnddGQmYFQTpIZ5ptgt7Sw270HUijLGnFjA+AS9?=
 =?us-ascii?Q?y5fwjy1qsBl15Tkhm9TbGhM89vlEwZc00gcIHC8XLlPCDGr9+wkxasG0NdCI?=
 =?us-ascii?Q?IeKezy4wjiS04BUi3JYo0+07H79Y54djgJCHnUJQZWACN3SIVrwEYerEZXaz?=
 =?us-ascii?Q?ZTFy668fCO1ObnoXEfmX4jB8KgTVYSQoMyHcuFlkhRqpDjWVmazovRwgXOQe?=
 =?us-ascii?Q?Itd/xk4mB3ZHNZlmFfX7jidxzZ2MlO8xoarUMpA3rTUUUAQ/e5p60r0QEQMC?=
 =?us-ascii?Q?nbOeTUQPomS/8sVw0iuxtPzBpIMpIpLMLn1a14PUZ8soPst2n1HXUNCOr4g1?=
 =?us-ascii?Q?f/diWTnKMezXv7I4byLn3CTdTXZY2deHquB0MWuAGuvFxqeWf1Wsxl/kmumf?=
 =?us-ascii?Q?bdVmDfFR6ejA7LtD+jiALTBjCTDjSMudOWGuC4KUXhApckVADtJ4q+xFvpgV?=
 =?us-ascii?Q?XnE9v/qpNoz/XEQIbMjsSaMcMgb5qct/6h/q15BOnof2vkEigyhSI7o3If41?=
 =?us-ascii?Q?f96pQQOSWK8q3rtDkkm4NEyekheYn4zZN5KlJv4r71yVLHoU2QSC8UNQyr+K?=
 =?us-ascii?Q?JifZ3ZCfz1wx+X869iDDozdV3vmGKK08VP5NNZlqcsjw8kwCfdYUeXMp68Qj?=
 =?us-ascii?Q?d9JrnZQW1ekaPRHyzx1PgmIzKfNiby1WoZeTGllsnWE167gssKYlfkPgla4j?=
 =?us-ascii?Q?7ntKY8pp08YKD9WaDvtijnBsZvwA41U/29KROmOhs8QBlJvJCNfperM9qZE3?=
 =?us-ascii?Q?52aADte9s7uVu/fnKI7oiV98IWw0BGyryyREhOdosC4klkqidovrv29kXOaD?=
 =?us-ascii?Q?tgiLf3TrInG8jyiHShQWaOvjw+XqjHnyluDdw56oPLTn+z2ihzXgF3m4gPti?=
 =?us-ascii?Q?IylwqGsLA/wR40xmy3B31JI4BxUJ/rbl7RQOpstEU/HWCKsv9ydjDQXdWhev?=
 =?us-ascii?Q?XGK18VZrcbFoXU/0wUQ5Wyl1wx209cde0o893bXJ4nUiv016kuxp9miFUtrz?=
 =?us-ascii?Q?aHcQ3sYwgR/WwutYzvAW1uTHQEH2GVvZBa/KlUVXB+GWlRilqIinSu8Z/4Se?=
 =?us-ascii?Q?oip7zLJRcsfHBZzsjg67H76NW7tVNziouwWtfRU7ekTMnX3WPDrfb1TtNwOh?=
 =?us-ascii?Q?XXc2HEbuYr1v9ukjsyrUk5Yyc8WtUhrCebkYOt9bQ/YwSRmcQDJ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e9f0e-9892-485e-7603-08df28976f14
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:31:38.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7ta4tcq4THyuivtQ1GmiiYDfoRt0/Jx3AUHT1QDSj77/PV7yVfbKu/s++zmo9MU5BEWmZQLHhSPyPpHLlQIO5CjqwTxWtIKvVBOd/BaLuqa4d/tQ8rSRYeKbBByCWf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB213044

On Fri, Oct 09, 2026 at 12:16:37PM +0200, Marc Kleine-Budde wrote:
> To improve performance avoid reading the Interrupt Enable Register (IER)
> from the hardware, cache in struct fsl_lpspi_data::reg_ier.

Do you have bench mark data? I am not sure how much gain by only avoid
a register read.

Frank

>
> Introduce struct fsl_lpspi_data::reg_ier, to cache the current value.
> Extend fsl_lpspi_intctrl() to update the cache and replace the open coded
> writing of the IRQ register in fsl_lpspi_prepare_message() with
> fsl_lpspi_intctrl().
>
> In fsl_lpspi_isr() don't read the IER from the hardware, but use the cached
> value from struct fsl_lpspi_data::reg_ier.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index b25f94b2ef73..5b158b0cb5af 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -122,6 +122,7 @@ struct fsl_lpspi_data {
>  	void (*rx)(struct fsl_lpspi_data *fsl_lpspi);
>
>  	u32 remain;
> +	u32 reg_ier;
>  	u8 watermark;
>  	u8 txfifosize;
>  	u8 rxfifosize;
> @@ -199,6 +200,7 @@ LPSPI_BUF_TX(u32)
>  static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
>  			      unsigned int enable)
>  {
> +	fsl_lpspi->reg_ier = enable;
>  	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
>  }
>
> @@ -525,7 +527,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
>  	fsl_lpspi_set_cmd(fsl_lpspi);
>
>  	/* No IRQs */
> -	writel(0, fsl_lpspi->base + IMX7ULP_IER);
> +	fsl_lpspi_intctrl(fsl_lpspi, 0);
>
>  	/* Controller disable, clear FIFOs, clear status */
>  	writel(CR_RRF | CR_RTF, fsl_lpspi->base + IMX7ULP_CR);
> @@ -808,7 +810,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
>  	u32 temp_SR, temp_IER;
>  	struct fsl_lpspi_data *fsl_lpspi = dev_id;
>
> -	temp_IER = readl(fsl_lpspi->base + IMX7ULP_IER);
> +	temp_IER = fsl_lpspi->reg_ier;
>  	fsl_lpspi_intctrl(fsl_lpspi, 0);
>  	temp_SR = readl(fsl_lpspi->base + IMX7ULP_SR);
>
>
> --
> 2.53.0
>
>
