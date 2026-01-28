Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168392D6605;
	Wed, 28 Jan 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614606; cv=fail; b=Oj9JA64/bFUKH9qfyq9uIjp8AX7GeNTEEcXkcnuKH9CS0zRZQkebeBAMXQvN7Gz1IVOPS+kwX7Qvuc45zJQt7F4gPkZssRTZ4UlHbgDWAN8boHGzj8q29tD4bGSTBpJmjpsW1SFspRoWwcJ00wegve7t/XSXkmS5g3HskJ1WOgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614606; c=relaxed/simple;
	bh=hGuSxpDBhTztye7HKBm2BaLLjtuxwHNKD1k9Pes238I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbEOJx34QhurHa2ioUHLqIW/SjdrNPdRayoruC/yzNqOcrO5l5A3oXsgyQbioTss4wVOdlK9C7jp8GDkQL94nxzFAvUSmVPRssb4USmjp9dpVfAKIOPnh5BF4OIkqp5S91M5z0mFe9mFsj5ZfFhy3y+Q+mB1qN5jB3cCdLei4YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E8eq92zP; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E8eq92zP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRQPesnSUhYFOATsQKmBM17IlD6XF8xi/alTbRbiEQjqPxDJ85uu2jaeLNAnl1IRzatkhiiLsRYE/o2gW0nxF470WHWK2cxIOY6U1p8B5bewf8c/sMMAigzJ46ZXsUCE8lwSxq5OJ6uCM5N+CGvGkzpiIGkGgxc+wCANpt9d2+0qf0GhuTBDQytn48zmtMhB0DalJMe3K2eV+NEgf2I4cha+QThzHZRBIHPYxHLAR/pIAWaQCStE2YwdnrrlNmK8ZxnImyDjHnBZPbIOXYknfwzZZ1gvSSfoh5AKKOjyLL6e5nogeRaRDXR5VOGzMNZopMcyyYzMFB4nGns5y5YMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFV/Ci1fvOf1whrpDoKwFTeWgakPtfkSTKMFQ46dNHI=;
 b=vf3ijyNt18cme422oh6vr3nZ4MUxKDiLyOwDVuWYSaZDKO9X2nHrfdCOvqGSzFJvc9HhbIGp+klVG9iUDoomppCosaMekXHxovWvG2TiTVh+hmg16vLUbZT034xSy3lfcvfRjT7HASgb6Sfg+M8q/IZ+V7tYV3SjFe4Sczg6v80Iz8gEBy9/Y5ea7TwpWBLPzFzlJqbKCtX58oq//1qFpJr/5yd2BtO5ILaeAd/K4i9HQqdmYZH6MgUmU+v7XE0N/GhgiGG5gNjuYv+njJ55LxdaUagNem2hvdfkZa69xc4bBsh+AYPoVL4G9UJJANacZtMt59nujPUukruhJ/vGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFV/Ci1fvOf1whrpDoKwFTeWgakPtfkSTKMFQ46dNHI=;
 b=E8eq92zPz8mI2SzS0iJYVK/BN70Ewgl9zLggYOxhg5Lu96Cnn6HuJc2oNPLuBz5OW9w++YyONmVt5N7NE29yb0K1SZ/8J/a/5DHg35pvYy91BioEw2LTLkTGymUq8mU9wLEaDDraBil4Wo1kEfEcb70RMGy7hRWUiOeXoRGaKqnlxJn2J3ydHi2b9EhoHFe1Ajog1jDCQHHeRrVFP5+t+HxvTwt/VSnsuu3Zl2fkfnsoLjR6o1huQIHYAu5NAssHJwbOc+46hC7Hju1ZXlP6lIqPaR5RZ8UbX0r0x14xY/+UzpfT6cxJIQRjlJutQJVaK7Mcv4sa4rCDhLGEdu+okw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV4PR04MB11290.eurprd04.prod.outlook.com (2603:10a6:150:28f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 15:36:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 15:36:40 +0000
Date: Wed, 28 Jan 2026 10:36:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-spi@vger.kernel.org, Fedor Ross <fedor.ross@ifm.com>,
	Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Handle clock polarity and phase
Message-ID: <aXotATlo14Ea1VPI@lizhi-Precision-Tower-5810>
References: <20260127222353.1452003-1-marex@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127222353.1452003-1-marex@nabladev.com>
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV4PR04MB11290:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbfee0f-b605-4792-87a0-08de5e830817
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?eCSDmIEkoQTdwi+WZqFzqT1xUK6AHHTsEzN04Qfuja+o+qUbsAuKkW3ZO8i3?=
 =?us-ascii?Q?oPqjN+yGmmHFWpfaFFWoBIGGF8RM56SP8l1BJ2o5Ejji969l7MCbE5pwBIud?=
 =?us-ascii?Q?bOewUc5eG5Kdmlt1Uh5pDtu0aD7cKTRgRHHh2s7PrvlSSItp9/Dy0hRub72c?=
 =?us-ascii?Q?bh11eP6jPIqrfFGAQxYZyHEYv53ZJ2i9saYNMI3ozgyh9IwTsvRIAJlkUIIJ?=
 =?us-ascii?Q?9Isoi5boTUAuWBen0eUtO+Fa32xEgOGoLlBkCKO2HK5dz/nUOUMSeM1qlcLa?=
 =?us-ascii?Q?XXTnX8PtKJ92AmbBBt3iyixmWAUFQyvIUOrV+rtyl1b4tu3Imh/PU+icPVgT?=
 =?us-ascii?Q?1gstbyBaHpcCjILfvVDsFF/9kxqtkGqh/CSFiHCAB+VY48ETawMpSNEVZ7G9?=
 =?us-ascii?Q?4gSeN1Gxsnpd/lezw4MxdEiRXHCX743FjdkRooD9Di//FYwyYQw1yXriiBdy?=
 =?us-ascii?Q?Fi+/8avRAiEr6Ghd3w0fnL38f3nyac01vy96Satq8cJFpa5CLu76fxFx7jC4?=
 =?us-ascii?Q?0zN9FG1bQ5t14IAw33bBCKYpZL7smzYINPxeOxADolnPMQT2KpHMNeIIoGvG?=
 =?us-ascii?Q?4fOU/vhD/yCRRS+rSucyDn18FWu0LbBab7D72TUAzmbD1tG4QRrWHUXuYjH0?=
 =?us-ascii?Q?Hgjh7yMokX+t6MvWqmNDvuSYfLYdGMgqielAhbzXlvCHcD+AWIwn4GPW2/0L?=
 =?us-ascii?Q?UlHaCbmXIGKXS2adiOzPXoGSA9knhFfwYO1l2Z9jNcame+iqZ+iUOEmSiOMj?=
 =?us-ascii?Q?3q0XMwlYnHWvk20EVvLlMARN2bRBPYW5OzksYJx6o/pmCEbYiUz66w71xh9k?=
 =?us-ascii?Q?lJZKoFYc/4sj8FNDparDTvYZJEVV5hoDpFz6t1HqgmpUk83Yw7Jk6ArOeN6r?=
 =?us-ascii?Q?hGHuD0FSRhqJC/7Dhy0MY9PAsR/ptZ2waG4ZteOv6dZUzv0xC5Upat3J2e8j?=
 =?us-ascii?Q?8GyvPHr05tbxvlj7qaI/7dDBAmDZS3OZ2bxnxIkCgohX8x/tdnDB8UJ6goCP?=
 =?us-ascii?Q?Cgeu/hSFuV9+SuO8gasyf8US9ElaGn9+eua1bzLCRDikqSvJ8I7UfDH4F9jD?=
 =?us-ascii?Q?qfCefoYjQa6MSyG/XD8ArYCKXAk7XX+GhbuBI2BpOF8uVFFqcQZz8OJ3Q39/?=
 =?us-ascii?Q?nw1NCpf/w5bqcx1WWWjqeY2EmgCVyV7DG/HHERNibXOz/QcRaWIFWIPWPwzs?=
 =?us-ascii?Q?5zOlnNd4S3spBF2kINtmIxG8d1hVC8PNJjfgO0eFj8bv3vdfyw8eXSaNUvV0?=
 =?us-ascii?Q?fHTVcXOvilSfEooE+naAZqQ2uYDMPOlaQVpSO8/GXQ4Tz63O+tJXcsOCWsdX?=
 =?us-ascii?Q?XtaJV7XyjBXIIIva1AIkMzzaGQwOfTocw2nrqj732KSKscUqQTvhasON9/cA?=
 =?us-ascii?Q?ITgegQDoaJiJJkZEwMtJDdMRmheLPBpnzM5pzWLDsmYx90yTf3URSC2LHpD8?=
 =?us-ascii?Q?5kOyymAAy7HwlvK1VxzhysoctaW8Yz0zmzfrofZe5VaXZcqTPj1BcBCukiD7?=
 =?us-ascii?Q?yEo1ziERP3pK+pK7gMIC6r5UsXsaf0eBCQtOdOng+F/8X+bYWarMqdpOthH1?=
 =?us-ascii?Q?ImHPFYMwGnlcJYzbSW9ipBXuiLvOdNzSk2ylQuP3PAgPLBI31OphWUu2Csyp?=
 =?us-ascii?Q?CnZhteTC0to25sKhu4mwZp0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?R6/W/lYC77FNM+6txv7/Z7N8m0DhCrUfTeVxvYp6TESNKBi+6ePqSJMQI9mA?=
 =?us-ascii?Q?eTm4ZAHpQ3ah+wN4kdM4betvLiOOqirKOCNDQuIJ5juR+1VqT4IfBQVoUbrx?=
 =?us-ascii?Q?gzQRs3Mif9lIo9D3DfT+JHF/TNRCyx8t+kuME3EowddPHKV1uuEnWyyhFmTb?=
 =?us-ascii?Q?vAVxQaGYhGx5EB1RS/b5JZcZ0ZTyXYY/9mGqJexseT0fnfj+66hJUr6WcfrW?=
 =?us-ascii?Q?8iP8DwBPnQSInchK6NmVGYCpbwFaZyQChKuhkbX39C1sOsVZA17lACJU63dV?=
 =?us-ascii?Q?DoFNtO6ulTNVWqixr2u3VEH+4HvF3mrPUiNz23ZANtqlJV7qr0LWU/Ih1P6+?=
 =?us-ascii?Q?uPQLDwJIBEoZt46wr13aqyCmlJN64I8O1qqb4EzlOm8YaLTDP49E6Hn1F+GR?=
 =?us-ascii?Q?6nDAgnWWQ1dMzSQtIofdtZWrvX92zvvpeXlfuR/DedyvghQEd2DopCsHxI7S?=
 =?us-ascii?Q?fOwVJH9Wc6ZL+pbVV/h7uy+QevdT2Y+3IbYCajlM+Rglw0tQOYxSRic12KTz?=
 =?us-ascii?Q?JlO0+0tPmybO3zxPD+RgBB79s0CAjweIUQQtwWzltf/7Gk7o1IhssTZvT13R?=
 =?us-ascii?Q?Xsii0tf9lwWfsEOTz/8SJQrAEOqO1X45iBKdZZClSp1xuCFpE4I1bM6DEHPs?=
 =?us-ascii?Q?dZHIjgaDIrvAejKG+8RQTBQ08a/qIRDInSCZJqLWYm0KyciXA1TKXwZFUij9?=
 =?us-ascii?Q?8wgQHg1Vz3JvQ2iBKE68Y3XB0rHiqaXSw+TVIyCd02t5TqCDIWc+EN+muipX?=
 =?us-ascii?Q?wJ3RILvsdM7X5Xhy9RbfdZ0Bpfw+BTagoGs4FCBFwoKRlMRZGRPYOL0GlFIb?=
 =?us-ascii?Q?gc57MiAevXbejYbExUXPcnW9/88CcfZ7P4aTAVCA9GPTQFaXhCNHMnPy4VFf?=
 =?us-ascii?Q?QnSHED64Rn6t7plfVWMXYQS2Vf6EhoaBT6fY3+qCWSvZMNgCCPqYUuuwpvUE?=
 =?us-ascii?Q?VdwSpz6/OCXDKcJSktMjqjr6ibzobTb0xvGlwnzO8YZ9vO+XhcLIoy789SQk?=
 =?us-ascii?Q?E7cKydcarhUdQxAuHL+1pZfHh2Yss3wbZRinlApOM0lGhpuM6+XjhBzRLwwq?=
 =?us-ascii?Q?5SbQoyxhCUKcdqlzQv/jRO+s9pm9Im8CMljEvMcKonqRhXDXPLxzpU8NUeDN?=
 =?us-ascii?Q?NL1jiQyouKjCKRzaWzYADe267Q5Jio+7SMgI4rAxZV5UHgnOz6tJHdNDOasb?=
 =?us-ascii?Q?wEXkPSmZp51nCPgUtotQA8Zrb7tMJhX8mPK2hU61LfC5UByEsbZNv/Is9rN/?=
 =?us-ascii?Q?H5pkC9ZFteNeDEqzL1/lAmvS1+ivUvAO83k+lnuJuABFVcyavSlgmkPXlsx+?=
 =?us-ascii?Q?O2Hup+kKmRvy3ZXNpVBzFwdupAFo3FeHXg/0LbkGeF0OcDbeOhvLuu8vFNsT?=
 =?us-ascii?Q?OOTU6Suh7O0GdLop4DnH/Px/w23gZOzSIdPQ9dhO5SF7oDu9ccBSeSTEI2w4?=
 =?us-ascii?Q?mt8mLZ2QhWqNV/bgqxiK+xMNZeAU6dhiJmo0vsehvkP0OswsxsPB2D8xNZbw?=
 =?us-ascii?Q?pFCf0BeLYGlHS/DWHsww/aOoA+tFBS/ESwQeGd7qg4TU+w3TtbUnvDqS+mCZ?=
 =?us-ascii?Q?E+Ynih1H4JmGlDxRWrQGRY2aMSNaevC8osAFVxPkP0w3jb5jZOurEGCru94V?=
 =?us-ascii?Q?sXFE42KesdwLU3BNnj2dZnxEhi7zeD8zg94AbOBtZkJGiE/tLW8HWfPUCruI?=
 =?us-ascii?Q?kBoWh4uxqnzvKPJOeSkYpFPU+dXNTAzBwGjNWRcWgpaHBWxjI1M/nuzvz5+B?=
 =?us-ascii?Q?EFCKoTXuTw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbfee0f-b605-4792-87a0-08de5e830817
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:36:40.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdrudYc5QMzz1FkdeX8UmapS3GL2V9yVDIcT5+d4vW+3tW9lWlP0Ne+4c7qOuBcOpasfzTVAz/AmNHbNCsNtpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11290

On Tue, Jan 27, 2026 at 11:23:22PM +0100, Marek Vasut wrote:
> The LPSPI driver currently does not support setting SPI bus clock
> polarity and phase, add support for it.
>
> It is important to configure correct initial clock polarity and phase
> before the GPIO chipselect toggles, otherwise a chip attached to the
> bus might recognize the first change of clock signal as the first
> clock cycle and get confused.
>
> In order to set up the correct polarity and phase on the clock signal
> before the GPIO chipselects get configured by the SPI core, the
> controller has to be briefly brought up in fsl_lpspi_prepare_message().
> The fsl_lpspi_prepare_message() behaves like a zero-length transfer
> which always uses PIO and never DMA, and which leaves the clock signal
> in the correct state at the end of such transfer, which happens before
> the GPIO chipselect toggles.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Cc: Fedor Ross <fedor.ross@ifm.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: imx@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> ---
>  drivers/spi/spi-fsl-lpspi.c | 54 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index 6c692568bdf58..b361c1bb3e431 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -281,7 +281,8 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
>  		fsl_lpspi->rx(fsl_lpspi);
>  }
>
> -static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
> +static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
> +			      struct spi_device *spi)
>  {
>  	u32 temp = 0;
>
> @@ -303,6 +304,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
>  				temp |= TCR_CONTC;
>  		}
>  	}
> +
> +	if (spi->mode & SPI_CPOL)
> +		temp |= TCR_CPOL;
> +
> +	if (spi->mode & SPI_CPHA)
> +		temp |= TCR_CPHA;
> +
>  	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
>
>  	dev_dbg(fsl_lpspi->dev, "TCR=0x%x\n", temp);
> @@ -488,12 +496,45 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
>
>  	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
>
> +	return fsl_lpspi_config(fsl_lpspi);
> +}
> +
> +static int fsl_lpspi_prepare_message(struct spi_controller *controller,
> +				     struct spi_message *msg)
> +{
> +	struct fsl_lpspi_data *fsl_lpspi =
> +				spi_controller_get_devdata(controller);
> +	struct spi_device *spi = msg->spi;
> +	struct spi_transfer *t;
> +	int ret;
> +
> +	t = list_first_entry_or_null(&msg->transfers, struct spi_transfer,
> +				     transfer_list);
> +	if (!t)
> +		return 0;
> +
> +	fsl_lpspi->is_first_byte = true;
> +	fsl_lpspi->usedma = false;
> +	ret = fsl_lpspi_setup_transfer(controller, spi, t);
> +
>  	if (fsl_lpspi_can_dma(controller, spi, t))
>  		fsl_lpspi->usedma = true;
>  	else
>  		fsl_lpspi->usedma = false;
>
> -	return fsl_lpspi_config(fsl_lpspi);
> +	if (ret < 0)
> +		return ret;
> +
> +	fsl_lpspi_set_cmd(fsl_lpspi, spi);
> +
> +	/* No IRQs */
> +	writel(0, fsl_lpspi->base + IMX7ULP_IER);
> +
> +	/* Controller disable, clear FIFOs, clear status */
> +	writel(CR_RRF | CR_RTF, fsl_lpspi->base + IMX7ULP_CR);
> +	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
> +
> +	return 0;
>  }
>
>  static int fsl_lpspi_target_abort(struct spi_controller *controller)
> @@ -753,14 +794,18 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>  					spi_controller_get_devdata(controller);
>  	int ret;
>
> -	fsl_lpspi->is_first_byte = true;
> +	if (fsl_lpspi_can_dma(controller, spi, t))
> +		fsl_lpspi->usedma = true;
> +	else
> +		fsl_lpspi->usedma = false;
> +
>  	ret = fsl_lpspi_setup_transfer(controller, spi, t);
>  	if (ret < 0)
>  		return ret;
>
>  	t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
>
> -	fsl_lpspi_set_cmd(fsl_lpspi);
> +	fsl_lpspi_set_cmd(fsl_lpspi, spi);
>  	fsl_lpspi->is_first_byte = false;
>
>  	if (fsl_lpspi->usedma)
> @@ -944,6 +989,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>  	}
>
>  	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
> +	controller->prepare_message = fsl_lpspi_prepare_message;
>  	controller->transfer_one = fsl_lpspi_transfer_one;
>  	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
>  	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
> --
> 2.51.0
>
