Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFC340401;
	Mon, 12 Oct 2026 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833444; cv=fail; b=sE2hBYkWT+FiuLrkM8pc0I7RZjm7OGuv0bj9otkd7jNym4nN062VcC8Ohfl/RqR0cHAN4XD6PlICQedeIylpj+kJ9+n0JqWf5h8MdROMnK1OrHMTSuYb+AZ0njuiCO+PN7aEjmUX73QdK4AfiVWU9rGjWSLqhw8ZK0MbL+636Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833444; c=relaxed/simple;
	bh=ANeAQz5FAd+RNIxkdCYs7WEa5DFHkNz+5eYGcKQhuvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a0ea9fRiGeOWzwSBIDhQhp1la9hJZ03fPkhyjnU9lZ3EnYxmET9Eu0x4lrFhHNde8CcL9hx9zVqWqUO4ipl0UdJsex+ZLeYV4CvyMZdiifZqBG33kwg3HZo71+rE6A3c/7DcfQfoCelGouJ1jzQrD33slwNYf/2+b95j54rLlF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dkaHz8On; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dkaHz8On"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALx8pr3zDETnA/SjQixYH6yJeE6ghfWrL2peYBFdeGtuijARZC0t1dSDcQmxbtNJE0T6QfbTS4w1xftr+VYlVESHY1Rv60jYas/SDU/sNOoZSox3h/z31/P6x+QyMMyFx1t0+6CzhisfFBF00+M9FYJ7z2k2DtYgonXtD8Nw+jXYAMp0XZUdrYZJqUeMumVdNxjrQgqzH/kK3GHR0gvTpLJmCWuUk5guv5HasVSKE2f9hfThZFmBHdlo+S+8n/VCXgJcJz+tWOLYoffwwCl9cNx7CqWLY7BGDdVsTRJkwJgRatiU30SdQ8bN8RZhCPg5KZrNM9H2uaj4ZC7+bR+98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4ToIpvznRYEp/w2L2RGp8rP6r3Yf/QGAeEQgCoa6/Q=;
 b=B/GbYNd//DLkZAYunfDWkT2887/vxQghQZIDvXPPH51ZIUDfQWVb3mOLHmoRRgAr2DL30q7YLJDYxleOOmrwtKB6IqNNNUd3GDKAVIXxPbGGsOqQMViszeV5s4Dt9kVsACfH69aTcEsT9RlwAeXAxPRBNAsqGRWwrsTt3LDqGY/W0BSDnnsgIGscMpz9mA59lLUZU5wR3o8N3/dId4YHy/ExdeX3qBL1f2extdNKdi8lpVjLCHCvnZo3NeZrhlaDq7NaOu0wEcWsx5hncM/g3SwndBwL5XIBS0GY0I0NBdCJVdNrHXIg/V8kIe4ZwgKyzJ7FfUjvzfihVjYbH9bBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4ToIpvznRYEp/w2L2RGp8rP6r3Yf/QGAeEQgCoa6/Q=;
 b=dkaHz8OnARzi58ybBqCiH+CxmCw45PxJ75pTu5p5VE8+VRP6XCT4OktmIoUuUyCUrM0wTg3+VsLocLL3J/MO4J7g9/dnQBPtaLVBDhqMWh1wE6tKOylCcr6LNAXBsIy6fY0Cp5eutomxRYuyI7No9JOfahkqj5DNvw2bK2cXj11a4z/x6D/7Gw7NJR8Pgqlg0CRlbfox3ThoI2b2XpfeavCZT05lRBNiBhGvlX2YaoLxEG5LEZIO0hAzYdOdgiE4ytmNe3SeUg4PLexptVnBm4oCPwbcF/xUXEGBtreTXNlTeZJMiWHaZ+x2doz+k6m8alqyxVfP0shhNWWg2EP2yQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI3PR04MB213044.eurprd04.prod.outlook.com (2603:10a6:800:375::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 19:30:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 19:30:41 +0000
Date: Mon, 12 Oct 2026 14:30:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	kernel@pengutronix.de, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH spi-next 2/3] spi: spi-fsl-lpspi:
 fsl_lpspi_transfer_one(): directly return ret
Message-ID: <as01WEXPZlwM6tn6@SMW015318>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
 <20261009-spi-fsl-lpspi-more-cleanups-v1-2-2d4549d5205e@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-2-2d4549d5205e@pengutronix.de>
X-ClientProxiedBy: CY5PR15CA0233.namprd15.prod.outlook.com
 (2603:10b6:930:88::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI3PR04MB213044:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f65609-b807-4bf4-1abe-08df28974cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|376014|10067099003|22082099003|18002099003|11063799006|4143699003|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TcDZAQb0yEuK71zvu9QgawDRHVS1UebjxhPKcEgWJ6lzbxMD0mZbXdVByAeLC83ZS+YSoV4v3/nCBLWlfREh+fNSN44fpiEOqZFLvDKal22DtMoA6XRnoNmD2qRGd7bxWg9CEiTAIxIwc7IaLPKipmqW5WhLUCm2XONI0U0B/jS25mitFnpGCWgBR68rIRuvYHlMqko18QkEM2Q0zKY/D2Y7zP63kQyRUTUKqoawB8EgjRmYL8+8XpcZijP6czgGPeXMDhmwRbo+P1hqGeRUT/DxlmXO84anfHsZLCAWgM+aGkVld6Byx0m1ndZGw83y4yp/5kpN3kqWwJGQp5VwgJVx7rGYgpIMA/nEf3V/AbqJfH/P6GnPkXYkQ9bdwuOdQTYAeeFi0c5FWvT4Q2dbOVS+bLyskQ5V8Cd1Zg+o/zHIOrZWL5jCS5K46PCv/UWPalnaeqVKYdWqn0ISgMSIeGJpXSaSl/Y2bec6uBwIhr0qSqpUQQjGOBLsxUrNQkUi2dUugCRpQuxozRTuFjsVVMzb3TA7WVCGH6/01DniULVIQlCpxan/7bouZO8XuYMEfo8Qh2ldDLfy5OPZ0olRaGVw7jDe8h1muwhA5FJLrKVvYYHrI5ppGKcOtM4TLy4HNZTWGeSExVI/8UUUyzOfHu4mrQEc8q69ZMfGlrz8Y3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dz4MQtZXGeQymJDqCaDEz/onZU2L1gcZAI+CCPNAM/XzCYxt8Pyt4Szl6Ht?=
 =?us-ascii?Q?+b47Igliwr38qRTLvmCJuiEvuwpXLbbrZTTLJoe6FNGoncZcFfhSU1OGgwUo?=
 =?us-ascii?Q?849WH/mDu0774th8pGp2WeBa3AiBE5tzwnMU9vn7vcbUd7QfQpGirdlvLqzd?=
 =?us-ascii?Q?IIgTtm2Tp24OvblhGvb+GsgnVffPTlCNft9xGGAaElV70fnrHXyBrI7OxIjl?=
 =?us-ascii?Q?HZOJlu5TANrenInG/iTUy4wJfHJAG/ZLb0NrZNUdRiasD8ZRtOVaK/xU6hdU?=
 =?us-ascii?Q?XyO3Gl5tlgINWb+2KAalWRfuCr2DtIYL5eqg+fuR63WFe5G0JLX+qwsc6dth?=
 =?us-ascii?Q?HD14vgoX2IqCIXMKHRh7iA4N/pAh3cYAPivAGa5KJyLjjwK5A5qtmAI4jWM6?=
 =?us-ascii?Q?gWaCad+8aeMLlJIdnVOJFY5qBVmZZGB3bbz1wuriHsZSVTRElgPPLLk2OXsV?=
 =?us-ascii?Q?bUVRpdBhCwVPjmaThQph6oqhEGKrRrorCz/RdGM4tOAn8owcP7Pr8AwBrbd+?=
 =?us-ascii?Q?fddVaTzKmgK+OVHnU9ja8OJCt3EIoRIQ7F2LcV0Wc0Mp6KZxJfi32VDzF5uQ?=
 =?us-ascii?Q?782Y+5KWX4uJkAIc6ksFITy4k6gVb8q86GGOKdTgs+uGxPcYQyq6Dv4U9bOI?=
 =?us-ascii?Q?NIXYbV5mSjp//t3Nzs/99iJk3B+Od6XANToDHFDd8+CdCq5Pcmp1Xukv41XV?=
 =?us-ascii?Q?JzkcHc/95DqzIjD/sKs/u+tDzPh2XPt/I2Cn4UgnA03dl82flqRoAdPowKXZ?=
 =?us-ascii?Q?EsfcAE8H+BemBWfvMagH5wHKsU59p0ftAxjKPNu18TIgNnUP4tbjTwX3klSW?=
 =?us-ascii?Q?EYShGJ/sX0/izWG9WEi44W98cwzlsFQTJRvXa/wOOMNhGk1jfwSOLquPi5bY?=
 =?us-ascii?Q?ZztsyYCyzwKb+UupAwvNeZYeMIBALF04rqqxRPP2Xy1p3h79srDxXGo+hglZ?=
 =?us-ascii?Q?mImCveJP9AiiWZ03YUZ95RlqVI9Qyy2GZdtOuvjxsxvJkDWdINwbqBuorKeV?=
 =?us-ascii?Q?pnMfNAHnSzhnLseyF37eQGZHjddeK4DD0FppQdbj7xCj+vdb2loROmJbQ8SI?=
 =?us-ascii?Q?B1aZGRbv+vV/9bV8P96KRpgNIlctAl1f51VoukgxUrhQSE+8DCShSyBlnL+v?=
 =?us-ascii?Q?a32Q0wNdKS/+J7cCCIAsXQKrhklkpooUCnq/2wFsqvGydH2q/zmahHCUjEFt?=
 =?us-ascii?Q?D4U+8WhWNStebIORTxw6amd5UmwRO7WpgYTQI3O9yeg2wO2fLENXw9SoKnf/?=
 =?us-ascii?Q?bRmUDVluZbOoAbJh6ZXpqO2nmWTJpq/8srmXKC6KQQ7g1rfeCq/06I1ZQTEL?=
 =?us-ascii?Q?W9rWKAhpiAiysrxxUrMhlzxCIhalyBo1puz9R+HEN2clasLtqBN2m7dm5wza?=
 =?us-ascii?Q?0YyuIXbdvnKnFiHPzGtdu3Pm1FfgMNOmqxAu46xx88wNTIQAs80j+vc9ERCI?=
 =?us-ascii?Q?L8eLb/HVS65NWmCRrIkvkBCMxOobXW0TUra5MtTqDq3XNQP3rpJT1pNQvUos?=
 =?us-ascii?Q?BtYQYyP8JYImD/33DezFjPxX63D0H+Pe+UiZVWq7dfMTM84IPfDvNyCMQSu3?=
 =?us-ascii?Q?sTko3Q6qXyjdgjZ+mw+M52dRz/Pj3yDXxk/lf3Gj8VxW4yWefKqlqdOzQOp/?=
 =?us-ascii?Q?roJRjqI74E8Tzauxj1rQDe92cxt11szKXNN2zc5UimKPu7vD35ED6niOwin2?=
 =?us-ascii?Q?CI/nzYTslfn7A+skRoaAM2xXF6uXkEoqinqEDbG9mBdGFPPa4CW4oil/I9nI?=
 =?us-ascii?Q?aKY4+dNF3gp43/2Iooh0Ao3ldzxDJXrtIjGO1ABTD9XsEbal8YRV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f65609-b807-4bf4-1abe-08df28974cfd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 19:30:40.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed3b7ThuLoeMymfD0dnOnvgrS0dGNhTvxpv7F9pCyZPuNc4dbe4TmfH8+gs147J9RvV6MyUt5KSMYuKxmka3kFJnen7VxLoSlJCu9lfubsijboeubv0T+8FoRZSAifVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR04MB213044

On Fri, Oct 09, 2026 at 12:16:36PM +0200, Marc Kleine-Budde wrote:

subject:

spi: spi-fsl-lpspi: directly return ret in fsl_lpspi_transfer_one().

Frank

> Both fsl_lpspi_dma_transfer() and fsl_lpspi_pio_transfer() only return
> negative error values in case of error or 0 in case of success.
>
> Directly return ret, there is no need to check for positive error values
> and return them as 0.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/spi/spi-fsl-lpspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index a3c5bab1acc7..b25f94b2ef73 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -799,10 +799,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
>  		ret = fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
>  	else
>  		ret = fsl_lpspi_pio_transfer(fsl_lpspi, t);
> -	if (ret < 0)
> -		return ret;
>
> -	return 0;
> +	return ret;
>  }
>
>  static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
>
> --
> 2.53.0
>
>
