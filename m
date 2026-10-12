Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987EA4D796E;
	Mon, 12 Oct 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833369; cv=fail; b=FiP7VRa13SEiXBA0JoDSRTPq3fazI0CD+YOHnM8qbq1OAXy7vQSLBMRJyJpPYDOz2W9a6YT90awgpBPApOa74p6pJrkWsSrRjGBixwBD+GzMs+61/bkiRQ6OzNuNJlWO895Ygr3NgiS4TCdJkMTF5Dij4+MBLo23WBAVcXAds3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833369; c=relaxed/simple;
	bh=iJYfmmDFzPMOhDTnp7Rn07cY2OI9VrEBCNxtwrwyYKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFItbfZo5vIXGNF4ql3k16WKPGCngQ7YdtYyYVFKmKAg4yov9r8tMx+StRwhtQZDBZU2ffWLiN6mQxCkyrlToq5STJrNayNzw3eTZtUycNnBiAIVyirG0ijUo0vqa3KH9IJIuIhLNxP/qpU90EbNgnUpWWjaLNIZwCLheM+PVM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AuXJ9wpr; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AuXJ9wpr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/xwX7b+Nu7gPEF9pYQcV81KHOqR2AXFUmYoSfZIGx//d8lnISRZ6iMLUw6wcQh7fItrFXsdgCqr0KVVj0A5+lFWEnnvvP/rOxpccAHZSof67qAZ8JclwVo9UJXN9tB+HhQy5uhkwgAivIsb4SjePEXXftiha9ze0gG19LUQkBXzNfgixuvDm+UNmRSIZuHO4ObU47IlkGISj/Md7kkuf9gU8pDA0CpJOIdMxizsyuHTs8XTx4w9PKWS7UZQKPOUqG93lKT7pvankdvAAbEPcV52Eb06RWPGUmpTsRVfRDtJy5Mp6VSNSQdfRt86RVmqoF2Bdf/LSBN+5z4VnnvE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7obATJ7gMa4Jk1Ncm5OyKnaG32M5nst2tGfJoQriiM=;
 b=A2iLljA0n6LE74FT7mnNYhbCa7RZdpccl0zUhK49cG8pOuToGOhfuu01Q1VCgzl1TmEwIOSRsZiTx0jCV5yECvh55HudBuDtUfnMONt6OOsRkeMbRdTWNOCypXbwppJhbqnbU7yjQ0rm5nQcF3zMGTjF+aYSyIsOXHpHNOOjbSlae87rRBkDD32NBaH3Qntnxeub3QT4tpYehF6VWAz2sFR9qpM5e4nVRvmZCT/yuX0GDB0vRo5IQVIBAjF1rDaqOKAc3jjVYmtRHdpANJgT3bXTVenTOOSd4S8uVltvhaJszXieQ1/chpoYBdiAqq+VmY7u0p+mQKpbAwG6gk9TmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7obATJ7gMa4Jk1Ncm5OyKnaG32M5nst2tGfJoQriiM=;
 b=AuXJ9wprN6mMBskUIwTDVyLnli7KIafRnj1LgaY6cRjdNtdEINFBNotxFf7nShERy3Srgzw7drFKSsHBRrDjLfdhk/S2G0W5nTZmCiVCyeiX8UU4VtnOoSpXFYOtHmx9k6MlF8ig7hw9QeCvNGQV9Ub5UJ0y4eYtw5cfN2aeS3UQf1OsfYa/jV+r1fmnVJIdTZVtN8pt3BZqhpoFFPpACIctae++r64QhhW1Xi0sRgZ4KLueUECPBOUtsvZD0gF7EkdmzVpfDu2emDO7rnVuqURud8gxG+OHSqk7qZ3G1ZzNTDxSC8nSt9ENGk+yenAIIfu3o2IXeqVkNW7d1NFSqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI3PR04MB213044.eurprd04.prod.outlook.com (2603:10a6:800:375::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 19:29:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 19:29:24 +0000
Date: Mon, 12 Oct 2026 14:29:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH spi-next 1/3] spi: spi-fsl-lpspi: pass struct
 fsl_lpspi_data instead of struct spi_controller if possible
Message-ID: <as01DLlbGMOO0jxq@SMW015318>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
 <20261009-spi-fsl-lpspi-more-cleanups-v1-1-2d4549d5205e@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-1-2d4549d5205e@pengutronix.de>
X-ClientProxiedBy: PH7PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:510:323::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI3PR04MB213044:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f568e9-eee9-4f45-ca71-08df28971f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QNcmhBn845/g2v8VZYNI9QOR6rcmd9B5E0QPSkiyCO8i/8ReAwfMPlKiMWsxxhCSa8cQTYHjfjcF+WgpsZnZQmVf7vq1ybO23p0VuTaxEgig2nnj80K+M4+eeFsRI6Pp+2hLpM5Fh91aKquWZHyDcWvrb0+nI/wTi3Bw0NT6THvYo5w6/93kTTagYL+P9uouCrAmnLjPB5G8Wd9W6Ilo+Nf9hCptvR1S5RjuFftvMIUnklgPNNYREDbQvu0NJPgd8gR++U+FuXhBL+O7fqoydtrfJaeeraUVp/OOSRIl8jOB9Xgk8RU1mGUUZUepMyPlEJ++L4n4acHAC82bsyw0ZaoKBpTmGolf9EGOKYksY5nffMFBMbFF1LLwiUC/BCp8R/+e0Nfr8WMB9yRBfmcQMhCbXBjheCKhdOao9K27vU3p8WTagVk7TDP+IrRlSqCQ1zJJ/Ouz0UMjVfOcqBi9Fv5fALKpCcExXOO5s0b9T1JK1qxeBJAE2qf3+eQyn4P13J5UHwf/N/Gorvu7pjERfc2sYNvARsNsdBnHxwm5LHoMKeyHg1d0tyndPD8Eh+r7amjR9nT5G9u05ka18RS2t4lRspfk3rf5a/x7LsG/oIyUDcWIjoPlqeT6Mp2xgTq7qwt5CLKxqfLVvwHWZKwT3Du4GV4HnGE/iObx5t35otE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1Z8bN45jjVvvllPb7HhEav/Na53cUYt5t79uV3UKtsMHcacqUoTcz6g/Uph?=
 =?us-ascii?Q?VfRdWjIUhJwFwXu1rMdrbuAstvP1eADKTe/+/qMYHgnnWippG8NiX6DPV7qX?=
 =?us-ascii?Q?CwYCz8stry1tOaAU7s9QjfwSBD+G2w6RZgKxPMujPuSPCM2XPXOdt64vprCU?=
 =?us-ascii?Q?9w6iJDJWaPQNXJp6bL389XrbNq6wYZYUSgALuLAoTP7qSKescqa+9q3BDpvd?=
 =?us-ascii?Q?+QUvzFG2tFWRzJqJbl+ShZJO+PXZpWLFZf9DxGHu69LW916p2eXhxmYgXv73?=
 =?us-ascii?Q?O45BAi3KPJ2ARmIFYOUgWfsVMHu78SOvdtnGLcOup9MMLjSGeZekzwjr67fy?=
 =?us-ascii?Q?f4fLxPqAlmAQw+CFhhfBvUd2LMcVCror5TP/q4Ksz535WiydgFFMFBAC7QG7?=
 =?us-ascii?Q?B8sut5BdriPihhZNwiM8m7HaYIw1D0j5duXheKF8kVugFEo8zB3RM+oPV17M?=
 =?us-ascii?Q?Z1L6Bn38+wDcGH+Gbpx0aCQDs4SOtiMNyzl75Wgtq+GN0j3t/KhO5O/8Vhu/?=
 =?us-ascii?Q?PLo1woerJNNR96NDU8f0VNH/+zayqvpeUGQxJdLt6TpjSsw+Do79RysBOq1W?=
 =?us-ascii?Q?PLkW1QGaZ2SkcCVGDa4cNkGvWdtP75xWIB3m4J4T6YusVLkcf/w7+qgLt62Q?=
 =?us-ascii?Q?CHXhhU0Ngvb2MKCHULePNmS2IloZHGRdQcur4bNs/x9MVX7JjqEPdq7noHCM?=
 =?us-ascii?Q?gpcTVBCcksXgZuLUh2U/fMPkfrMFKH2l3oTvdDNX5Y4MsXAkjGOkMocq5Uno?=
 =?us-ascii?Q?pXHqYk3fTgSoYn7Vf2m2OTKv9v2INhGsu1NO8qz2y2sIuf/HqPlfFmAG8nHo?=
 =?us-ascii?Q?j0sde0mdp5pWRbkPQi1uWqc0ZWUcskbFIacYIcX8nSdJ5m1IXUV3nWbsv2vY?=
 =?us-ascii?Q?l1+Wkbtmru/4Tqzk7nVa6gEQaN6Rs3pazaadiu1MjI4dUZ716cSz4ly/0FBw?=
 =?us-ascii?Q?1p5TpEyj24c7tGb1tHU6P3rky7GO8j9+suKQbWSr2r+9MoMKTlmvWvW8ufXf?=
 =?us-ascii?Q?vR3Sf/N4mR8l7gWCuNf0Pe+4RSz5ZCcoaEao/NjxHUtqBdxMXsRWZnEUYakA?=
 =?us-ascii?Q?oLxyL5Arkbf9Gn4kuqIpUquzqP3Deczi7YZa/QDQGZ790vhSZvkfgC1opAUs?=
 =?us-ascii?Q?dGBoFNVS65Qz8Xgct2sRNOFUXOnUUB2YxKJ5ycz4DLqZSFjKx8w3ahONBLoN?=
 =?us-ascii?Q?fN+n33r48DlHr6UP4ZmpntQR8iUGDu9DncZY0VdEK1e1UI7nxq1mdt1t6odz?=
 =?us-ascii?Q?Chp0CjbrXoNBJG12TE/Wi5L3u53eZl5B+BksFiRJZ4rLVuQDq+aKg6OH9Lo2?=
 =?us-ascii?Q?akPamuevYBptQx6G496qTxORRVnulcWP52WzQXdu+ft+6wbnppFTXIon60mp?=
 =?us-ascii?Q?bAXxT/mfC2KhWRriog4qKAbzGD7uh0yOny6HreZYiPtGCNjH1HxTD95Zml34?=
 =?us-ascii?Q?JJp6a9RtYnrCBvvmiWN1e+Z8nLBsozFL34KThUDdQMlNSRgBzeg8gR7ewyMQ?=
 =?us-ascii?Q?ZZUjnIpMoMbCkvH2j+22A+4+Cz6SRLZRrXm9SZ6G6y4XE4Zf94MtC42fPHLf?=
 =?us-ascii?Q?1UTkHqMFadiRXSc2xuCmYl+3UDFcnmj9Qtmq9WZIJs/4mNt7qEhrUSpFKkIZ?=
 =?us-ascii?Q?waLD8mGXCiHgd+tIdRq4WDAe5p7TSnWaWlUojlQvnsA36ocd7EFvM8y44U5V?=
 =?us-ascii?Q?+1bUQJohul3nxerEkmI6EB2N1H77owPbpFS0PTIGNyRQ8u6JP6etBq/rX52S?=
 =?us-ascii?Q?aLuc/a+QPrLLV0Qcm+5Sdk5O1OQQGN1KNNjdPjQB09sLYSQeKIut?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f568e9-eee9-4f45-ca71-08df28971f44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:29:24.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1uoZhGDiCu2Yd+xakIeL+jLdWpBk8mRuZ8K0Sk6pIPxQxI3jKBEX5H0Nb9nT8/6KEE5wcL2nQ4Ia6aJn1MlUQJITj/PpcZyIPDhz8aC4hGZE70of91tWsgzv7S9eCRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB213044

On Fri, Oct 09, 2026 at 12:16:35PM +0200, Marc Kleine-Budde wrote:
> Instead of passing a spi_controller pointer to functions and using
> spi_controller_get_devdata() to get the struct fsl_lpspi_data pointer,
> directly pass a struct fsl_lpspi_data pointer.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-fsl-lpspi.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 5aa0a75b4e57..a3c5bab1acc7 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -550,11 +550,8 @@ static int fsl_lpspi_target_abort(struct spi_controller *controller)
>  	return 0;
>  }
>
> -static int fsl_lpspi_wait_for_completion(struct spi_controller *controller)
> +static int fsl_lpspi_wait_for_completion(struct fsl_lpspi_data *fsl_lpspi)
>  {
> -	struct fsl_lpspi_data *fsl_lpspi =
> -				spi_controller_get_devdata(controller);
> -
>  	if (fsl_lpspi->is_target) {
>  		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
>  			fsl_lpspi->target_aborted) {
> @@ -758,11 +755,9 @@ static int fsl_lpspi_dma_init(struct device *dev,
>  	return ret;
>  }
>
> -static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
> +static int fsl_lpspi_pio_transfer(struct fsl_lpspi_data *fsl_lpspi,
>  				  struct spi_transfer *t)
>  {
> -	struct fsl_lpspi_data *fsl_lpspi =
> -				spi_controller_get_devdata(controller);
>  	int ret;
>
>  	fsl_lpspi->tx_buf = t->tx_buf;
> @@ -774,7 +769,7 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
>
>  	fsl_lpspi_write_tx_fifo(fsl_lpspi);
>
> -	ret = fsl_lpspi_wait_for_completion(controller);
> +	ret = fsl_lpspi_wait_for_completion(fsl_lpspi);
>
>  	fsl_lpspi_reset(fsl_lpspi);
>
> @@ -803,7 +798,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>  	if (fsl_lpspi->usedma)
>  		ret = fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
>  	else
> -		ret = fsl_lpspi_pio_transfer(controller, t);
> +		ret = fsl_lpspi_pio_transfer(fsl_lpspi, t);
>  	if (ret < 0)
>  		return ret;
>
>
> --
> 2.53.0
>
>
