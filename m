Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80622579E;
	Sat, 20 Jun 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781964600; cv=fail; b=a+ZVqCt+/2QD6Hxv3Fr3sVe5h6Ot9np2rlPU5wa37QcbZcbxB7SWvIU79rdrTwfid6VyPVicnNYgBoNDA/uC4XMNiHmtAs1XsB0jmYYVjprQoNr/aL1NXsw11HNU6wUoX40OpW0sWGv7carWeB5GE0xSAE8Y7rThgkuQmvAFmOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781964600; c=relaxed/simple;
	bh=pkoJEm7FfwbB1sw0mcyjY85NHEJnXO4CV0JZKkTWiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVDsmoQv4ebgiubSzDGSYhRYxlnRlyXmBSiZ5S+ptDzhHK/8NceSA+I00RhgpejaOOstAGkrXq15pZw0IO3bYgGJwde34DYyW2mrYwLL3zT0rvW89PmCLxcCdtbpaCmtgrPaW/NVZM1Xjw2VrnHw0b1ihtP5ITYpc7M3X0aM1tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=j/FX9Zy6; arc=fail smtp.client-ip=52.101.70.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j/FX9Zy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqSokA5lflAHGR54iIWPgFiht/SoQJbz/AOPW3Hs4gr0snZy7UAICXLDI92vSPt8YfGNqJRcb9OZlBZWS+5qQ+nxYUl3+c7wYuq1vsxnPVL1H+b70Gx32lqIrH1epldHhZscy8eNNtjO5LQeZ3XXNEP5kaGMSW1aGXLWjIxXHYxyeK8lb5F2MoCUQ0ldt/5o4drlTMKXMoM4iWQ7aQRIuU5k9CNTfdAyzWTPVH0/MYlqvQWE554aEC6cHgeoIIuiEWH3gE/35OW8MIkWKaavuHHBUg/IyUw8W8jcYD5gdP1kzcSw+EY1WDwzZdH3fvLCsKIfIVaYYUqY+H+txIMpKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLHhte5QUVyT08IVmnmDcOMU38Iu165K7b6l/LoQiX4=;
 b=ll/S27fpRtTj6q7l3fGMckEbP7ufr0dQ6wyhJvmXYjhtEfAWyuSSHkKhOs/ddR97nLAB1eEgrD13u6dQ7MsA6wKYUzUTJIC3W2d+bl6/uH0YqgOiQ6Lu/74qO0NtCIT8o0MZSPrbVc/vEY36c0nTjMorek2ehr7cKPI/2gckK2BWWvMI8ehTcUR8BMos2YdpU6+kBV+unrCkT4eJSi9O1HRAlvhyH/D7CgPz6DuTgMnhF4TAu6gNu8yWtXf+2CLZsB+wGEh7z5wDmxcEN6WPDKHTijJn4Gf2Bs7gWIQVhSNgU5CdSKq5CbmvEMHaJMaJfyMAUUQ0x8aGkf68caaC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLHhte5QUVyT08IVmnmDcOMU38Iu165K7b6l/LoQiX4=;
 b=j/FX9Zy6THoKBPDMC0VC/oY60rTnz9leEM82OjIeKIXngxFWQzG3NU1fvvRMM3fPvF98BQTBdEC89zIntnlQzZCd7+X4Wpcu5P/aOKVAhYY6ENQ2erTndfNBuJabIc6Zlia956nLyGW3qKUpaYfPSx41ocBsOSYv94BMkuDAgdvwbH4wsJpzHYnaYgSQXbh4+zRnDzkDsliNwxbwKuoahDyi06IpdNW1emCP+gfcz2bYeqtzm+WqA4dts/txuuZYpHH87GoRjorn/b1Rog0acpACCi1AAfjMj1OUqIX67jFORWttgZxyaw2JiXkYf7BSw/9lS9iYtl1MuQ8PtgtNtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 14:09:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 14:09:54 +0000
Date: Sat, 20 Jun 2026 09:09:40 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jiawen Liu <1298662399@qq.com>
Cc: broonie@kernel.org, cl634@andestech.com, william.zhang@broadcom.com,
	kursad.oney@broadcom.com, jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com,
	f.fainelli@gmail.com, rafal@milecki.pl, olteanv@gmail.com,
	han.xu@nxp.com, haibo.chen@nxp.com, yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] spi: nxp-fspi: disable runtime PM on probe failures
Message-ID: <ajafJIPNBOiaISgk@SMW015318>
References: <20260620083931.1120616-1-1298662399@qq.com>
 <tencent_8FC0B8DFAF4AE67AEBA20548045D53A77707@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8FC0B8DFAF4AE67AEBA20548045D53A77707@qq.com>
X-ClientProxiedBy: PH7P220CA0147.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6be700-1fce-47c6-12e6-08deced599c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|366016|7416014|1800799024|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	pGjGpLDLki03V+dxaRbswTNv34+vgLICVcSF7YWf67xJm+TVfMipRkHSgwTlvAQfz776rvB4/z3TsJkgytZZWra4BR/r0updKwEVtqHV9wFHml3+HTYWPIjc7eqytX+glh4tKE5sokwXA/aK4AsvvZGna0KBwYHnnt4PjVs70ER5OP9JXJsRbCwi158cPh7mMEDpqzJOXjBAUYj0JCw9PU1OmEAvEKCRQTaPxUCda8sJeaaXa+CgoXEEvBZOz2DRFs53F9VBLtX17PSYzqX8SmXKOLdZRjjZnPwu8E3Pw9PPgJ0Herz9yZ8pSmjqY5WhvyUs+dJGTFQlAPU5FUsst0BFw2qOgKicaM4oAFZ73hPb3xhoOHmKiW6hh+DbRPftYU7iIgHsl2v98gEB6FQzQRyVsikOZ0X2mXsKEd6mRTq+l/Bc5s0xhoBnE45b3ebt6PtQhVXJHOIvEXtohHXftU/zMtuk8702wJvLkRu4izzXKxon2KTZLUVHwcixRNr5bVhoArMnlkTwD4xxFvJLEWHaFR2kuD45kCHUiCxRT0DFWzoqfPQfWUI+D1tUy4107hWcmcbD/stjSydm5yie9IUfF/1K6VwHHSw+e67Hhxmyq97mr6SYZjH+2w0U4z05CTsr5uayQ8/sVwota4rnFZ7J7mR1nUMGVLob+sSFTpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(366016)(7416014)(1800799024)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ifq97yKp7/BdDZHkNeHB5Xma4drU01ZpZ4GaWLnLyL3kVBd36Wuh7eoPJ8tL?=
 =?us-ascii?Q?sHyou2XY8PRol8qxu0KX9u6p56n8nVH88PiMg8/868Uf9SAVNMy5rFk4L8IE?=
 =?us-ascii?Q?DNrixzNEMYJV9y/3cHi1HQz6J4Qh8mh+F+ix395zvEF1cu2nU3WsOF5K4+cZ?=
 =?us-ascii?Q?CucdxI3AfLLrAJ2QVdZ0wHokN4/MYEsP+0Bgw6eimFZFFyCKhtxzuxtWNvKR?=
 =?us-ascii?Q?GCoT4cG181svo8QRTsEU6QABeyoee/T5nXx3Zrn7+nz7j+qJBju1VpSBhypB?=
 =?us-ascii?Q?xq9+ehXm0ovso3fAGYXZtWNPq8H8W4MhkD0xwBFfDK9SrJLx9WCAE0ISjNzL?=
 =?us-ascii?Q?3K3pxqkwNzBnk8D7GNMW9lEITzuNXLo9KiNzlZnKPaeDrFQr0n1b4Pdb0WXi?=
 =?us-ascii?Q?38Itc0mQmuY9g+gOSNn0q5oXdUkl6GYnlhDEaBT2iQnlP4QySm9osz2tjaVM?=
 =?us-ascii?Q?C+HT389hN8AlYDmkxNZCaJYRGjPhWT21Ruq2J2ax+MPjIA2zXmHgXRjjuhY9?=
 =?us-ascii?Q?J/2ZuJHCnhgbnWzTcQ1I8gpamSJ/3BTfqUs5DGai/XOkCXX8op13X4amM2E2?=
 =?us-ascii?Q?ZzaDj+4evVj+fHSYfv2vTF0L6Cakzzp4x3GGtWK0TZSpKh9pxg0/2M2KREk7?=
 =?us-ascii?Q?go2hAh/AYrkLkc6QAdAtl22J84EPOU1dB1XuOXXD5PZMEra//rgkia5Vs8N3?=
 =?us-ascii?Q?RVKqH1t/1aX7hPHRJaDX44MA0dt8+A//5l+bsYMf0huH5Ua+k3EfhaCL43sc?=
 =?us-ascii?Q?Ve5DwGXRoGpvkINkeYOV/idnbFQAjX6Odbbaba8X8u7WiY/llWYeULM6tCaT?=
 =?us-ascii?Q?8fyTjDq++IcuyJi081JiFuvIlnlOsuWy4/X6NQWx4RmlkqdfrwfvvKtQXyeD?=
 =?us-ascii?Q?JUnptaMHHSymbfdng2bVgHszbUlPATz3Gl6jZ8k0O7K3TK3oGtcKHWr2gQrw?=
 =?us-ascii?Q?XxL+eTUzpXN8uaKq/fy88uskG9WaQD4m+p5nbBsMhTFgTAZIaje7M+tgaqfY?=
 =?us-ascii?Q?bcXoPEKoEq//PL7vzdgZtYiSk+qJFyDnwaqr2rnaDKnMI9yA1/L/2rpdYhtO?=
 =?us-ascii?Q?eW0VmKFAYEz5lrjyWfzCRamJPQlhpQeJ10b465+ed7skIMW3AByJzTDVKHvM?=
 =?us-ascii?Q?cIGsejS/aZjrI4ckRYU7zyLagOvkdJ2j+X6KuMMBnDFXBAH+VQAvPfy3Dh1y?=
 =?us-ascii?Q?AiHJKIMLYOkwq3soCV5hTNSxuTP2yKUzTVh33lve/pKAbLhYFc5k74CbmZji?=
 =?us-ascii?Q?D+3zL+BRVO+oGSRW5IJ+fuFdRRs3C1zbx3RcD116xVF8M7eSqA5fmHFQDMpw?=
 =?us-ascii?Q?5Fta7ztpD8Cp1OK6NuqfkKKiPbZv5ffO0xkNvJ5uQVp90A6tIE5wv57IZ9jK?=
 =?us-ascii?Q?VPEV+IFGsap5gPe75lA/X2T3Vb+EwlvEOE/fw4z2ym/JwvM9zeXa9jYqkGmi?=
 =?us-ascii?Q?QYy5fLw2h/KTDzb6XSLHSmWCuAN1NnXBZ/h6FZ2yUY0A7pYjqI75YlPYrFoC?=
 =?us-ascii?Q?sF9Fow/62d8BkO8cHq7p3o6gIwQ24xAjlMu4ox8GbxdKBaMrXqXz/cVrxgjD?=
 =?us-ascii?Q?Pg2qKCAyqJ1sqXzOzmzjFde0wTT7rUBKI6boI53M2aasBjbTMM2fvkQaLlFf?=
 =?us-ascii?Q?9+elqVHiET/GEhySVoT96boLoPF7OmrPcVSs0Y/1FG/0LJqiHw0eNoAjo+bP?=
 =?us-ascii?Q?G+Ay/m35RB1+jQkcqUok445YQA1lk2W2mo8bzIcrkL+6dQc8NAAJpMvSggYU?=
 =?us-ascii?Q?U8gq4SK714vuAeGrIgU7K5is9lAOqDQB+gEdfO2yyYGo2jFtAzxN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6be700-1fce-47c6-12e6-08deced599c8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 14:09:54.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSLAbrWy16vV0c/faOz1IUlp/OlqlQpUDEF+D0g6wMHwdpcKcBAklk/DHCH36zplvzWRaKVO5cmBKQ+V0in/0ySaIkCar55pjrrjUsOQkycL4aVHP46U8ZAU2ZGxSxIj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524

On Sat, Jun 20, 2026 at 12:39:31PM +0400, Jiawen Liu wrote:
> [You don't often get email from 1298662399@qq.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> nxp_fspi_probe() enables runtime PM and autosuspend before
> several operations that can fail.
>
> Some failure paths returned directly before the devm cleanup
> action was installed, leaving runtime PM enabled.
>
> Route those failures through a common runtime PM cleanup path.
> Use pm_runtime_resume_and_get() for the initial clock enable.
>
> Signed-off-by: Jiawen Liu <1298662399@qq.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 1e36ae084dd8..d94a2a7b98d4 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -1350,9 +1350,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(dev);
>
>         /* enable clock */
> -       ret = pm_runtime_get_sync(f->dev);
> -       if (ret < 0)
> -               return dev_err_probe(dev, ret, "Failed to enable clock");
> +       ret = pm_runtime_resume_and_get(f->dev);
> +       if (ret < 0) {
> +               ret = dev_err_probe(dev, ret, "Failed to enable clock");
> +               goto err_disable_pm;
> +       }

Use PM_RUNTIME_ACQUIRE help macro to avoid all goto

Frank

>
>         /* Clear potential interrupts */
>         reg = fspi_readl(f, f->iobase + FSPI_INTR);
> @@ -1362,18 +1364,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>         nxp_fspi_default_setup(f);
>
>         ret = pm_runtime_put_sync(dev);
> -       if (ret < 0)
> -               return dev_err_probe(dev, ret, "Failed to disable clock");
> +       if (ret < 0) {
> +               ret = dev_err_probe(dev, ret, "Failed to disable clock");
> +               goto err_disable_pm;
> +       }
>
>         init_completion(&f->c);
>         ret = devm_request_irq(dev, irq,
>                         nxp_fspi_irq_handler, 0, pdev->name, f);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "Failed to request irq\n");
> +       if (ret) {
> +               ret = dev_err_probe(dev, ret, "Failed to request irq\n");
> +               goto err_disable_pm;
> +       }
>
>         ret = devm_mutex_init(dev, &f->lock);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "Failed to initialize lock\n");
> +       if (ret) {
> +               ret = dev_err_probe(dev, ret, "Failed to initialize lock\n");
> +               goto err_disable_pm;
> +       }
>
>         ctlr->bus_num = -1;
>         ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
> @@ -1389,6 +1397,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>                 return ret;
>
>         return devm_spi_register_controller(&pdev->dev, ctlr);
> +
> +err_disable_pm:
> +       pm_runtime_dont_use_autosuspend(dev);
> +       pm_runtime_disable(dev);
> +       return ret;
>  }
>
>  static int nxp_fspi_runtime_suspend(struct device *dev)
> --
> 2.34.1
>
>
