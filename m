Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D993D9DBC;
	Wed, 18 Mar 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841520; cv=fail; b=UqXl5Qdro+gmVnoMJVKG1rfmIwQ59zRAqwS/iBG8CJ5jsW6gLYsalXkEpnJS4WmCfvQ9bAqW296BlyBdWRGeq+5COg2Tj13vo8LY8iw7C7rs94+9wB+SIbFxj7iWlkMudpGmTO3+EzuQJFlfc2ynjpNj6bLpMxyVWC3lkZGUIFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841520; c=relaxed/simple;
	bh=0x8SxdzGZNbeMJVLQI5HDQu96ufDdaC5SlGnO1Drvh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BMlemFDsHAmcllq0LTecAxq205+LLcJU4tY2F0PmkgdCtI+G5/Yc8iLp2KXAKi9qeRguYq1vwaB35h9PcUDdCT7GZcMtjqYIdOv2DzR9eFsorTRMYQIKfTabDHw8eFfs6BpfWi+CewjFgN1Y6KtLlkeeAaZHg8HKIVHE/f5SYH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ur/FhEyw; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ur/FhEyw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC+jJsJQiBpIkwHjRtAvQenMwlrhXNZCSFqFOikGT99gl45OIKNZZ9b5fNpoM3bYt43g+nAvRVgDqX8z0wwRWxrjXLIk1+bjjLhAappA/ucikursuI4TKmPf7Jf4du2sFu4qx2ruZG9HIlUvX7V/F4sMWPUpdKVoPIE2Doh2Ozkp0sIlRAXWKNqp1gZVkAy0rhn+23hMlMjSAYp3jbtJ2NzosWPYp+MjL0BoRTbf1UIENee++OdVPS/9TKc0V97OW9RIxSakC8TveDg+2GW+IKEcfDOrUucdlbSDP45pWRJvI1griiQuQ+kTy0udmfq7JBiRH6hLNtuwMKuOASdnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T748oTPOn6Vf4zDtFIFiJdqmDQM9Pwav2OXKOn/KdOM=;
 b=yzWB9ePDGwJJhgiQR+Q7zYIXFQV8mIyR6ez6OTLuobQnsKsNdamQUTNav8/uSB2tJ1yo07bsdI4M1rf72Z6gRv6PB0NZ06nOZrYDCbSXC7wAcju3BgcYWDz+S5f88lMgZPfV+njQvhgfb2H9lBpLX8ViT5lLyen36BI1Yk/4L2pv3Am70spDBoIGrvvbkbVagNWh+HBiQGYD9ofteTTMXVq9iD85vk5lPSJg3jLSgk+xTOWqgr5oDIRdvdRTYrtT9wSN8iF75gvuh3+hbGbE8sDyUEChw/QKVm8j4+gZURqPDhprDXOvk1nUo6nv+kB0f6UzSIdZkugelACBMW8ikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T748oTPOn6Vf4zDtFIFiJdqmDQM9Pwav2OXKOn/KdOM=;
 b=Ur/FhEywlSqabddArLhiyasjKN75x2WnWr6045hHcx0b9ifgeTWUXcHjuEjXVTsr5Mqsqy3YUtLt8MuHutWVidG+9E8m/gmWggK1YfW35VrrqXo8KV7CmL3CBg7iQ8nCx1FdLhrZmjKEBw03s0qxw62RnXdhUmGEDGf9mkywUukbEWlCNCBWeHvH2VL2s7r3+aoNAhn6SNGZU5JsDY5nsca7gmlp7Ymoupf2U3nceifRBA/iyYDimShgnK1/FwpdaJGKCfuGOo+n1xrtuiV/NOdPwJq54/Jwr6XRhQWu/Mc1Br5cKAVUEQX0KOJJucM5FFRi3EGtVvJyQZaWWo6/5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB11915.eurprd04.prod.outlook.com (2603:10a6:20b:701::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:45:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.021; Wed, 18 Mar 2026
 13:45:15 +0000
Date: Wed, 18 Mar 2026 09:45:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 05/17] spi: imx: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <abqsYybojsX8ni1o@lizhi-Precision-Tower-5810>
References: <cover.1773801401.git.xiaopei01@kylinos.cn>
 <554b3a088ac453f50df9b040e3506c807efb5dd6.1773801401.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554b3a088ac453f50df9b040e3506c807efb5dd6.1773801401.git.xiaopei01@kylinos.cn>
X-ClientProxiedBy: PH7PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:510:23d::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB11915:EE_
X-MS-Office365-Filtering-Correlation-Id: d16056fa-addd-454d-568d-08de84f495ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|19092799006|1800799024|38350700014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	hEjPRWQiSFbpcUGW/EdpKneGRRj5ToObxhaGx9APeGltzVFnjybHEWpnEfCFFFvLEGWOpNUfO5e4gzaWrSLw8TAMXjB+DEpO+R0d++83OuOwVFj774/aev7d6NFj8m5ummXaOWpKZ2JpRvdu/hTeTxP0wqzzXzIWceQvuGdPJKqjXx0xjOFuT3AnhQPaHjaBAhns6+lOGd5+kpuFFMrsEaoLv5oQl17GECA4n8jHbCRI5Y0Pk4s621TcTgegto9DWrDImtyZmd2FFJMeDRMCaxM0fvnLl/pojm9uZh6FJKJJKuWjLOHi9xawaqPQX/4Vs5w/xN8772ev/EoyKih9YisGkzQlvKxSCn029hSv0jAt/qYSDOE4HqPT37eFaz6gGE6BXbaZaRkzPJd+xl44Y/yd0G9H+Q+g9iUkfZf9mhs1VqHUNRG56S6UOqj5Opb8bL3kcbDQgSfxeKlsxjNk9JuDkl8Vg00stL59XRho9F1yA+aa9SI6I2NGrlnb0f23pT9w2jnQtQwX+vvZhtkAYKOr9gk3dm3DIs5iaF/uDzVsd+G626O8P5v67LANoY9APfOHGoYfzyytdpMCRr+0gwjPQBgsM1Ch/5P9rSeDe2NdvBvawiMok7AVaM4gaUwnXABHrlut2U1HceoTDZeePKjAMnHCeMHOy6yUSQVviUOFgu79MJslDSO6FEmd4h2+PtU7YAUEyEk6Uyb5t3693sqe5cWaYeWnr1Ll1rWTcS3OujRWMq2hpSwWyqvDAV/pHcnfzFqz9KmWwFMXPKCh2CqoAccwYBUTJdJnFGEYCJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBSFuRH6RfSO6L3+JW3R4PrnKSsmemRW0mT8pdz8KkOnTdKDOPSJ8aHJtDa+?=
 =?us-ascii?Q?LHM0375qFLjszCfXMFOqUwK/FGB3zlmdXSowzelog4qUyOMWrXPa7A2yc7bd?=
 =?us-ascii?Q?cW+mE03MF20qQh82WG0u16UcTUXo2qK8iA3ggu9pp8Fktno8IpkjfR7amt4o?=
 =?us-ascii?Q?gyGXWHGqN3k00h6NDvWHc7+/4NFK2QvRKJSfaY7NEp+nr1QkK+TlC0Fh8OPA?=
 =?us-ascii?Q?w8qEP+YEiFQpCgSqIPDJc4iDkEDoKUaTPTqvA+WZTAJ+d2PFPDQ6zT0UAzC9?=
 =?us-ascii?Q?F/AMffjS7+UA4+pdyd0TCYr4KDquyCGatayTo6UclEaVP9lC+VVAPRjQ72xc?=
 =?us-ascii?Q?U8IeiipgGm4SJlVX9CYghkFexVZgC4q0YMg++BYzcxFv4ttxd/viJq/fQ8X2?=
 =?us-ascii?Q?cToA/zPU3tEMoBaI0cmKFP19PHL3iStKcu4ZbI8C3OvBTaQAXJmxLWpgj9Ev?=
 =?us-ascii?Q?RRaixGaPz28X1+cxUDUdzOPVh+TA5KCHSNovHH5y2nqM7MwkEkR+NQbmoAVu?=
 =?us-ascii?Q?dR3335NM9nNNmp0Rn7WgJSeVcD98IpN4ug/V8cyxzUmhFAnEAn+SPXnpXg+1?=
 =?us-ascii?Q?btn9MXEC+aucLlZwX89nft3h+80fOGfFjIb9Q8l2vrzbLfFjkLDD4oxtSvpW?=
 =?us-ascii?Q?9nUvFlB5dH9JlroojBxPKCJxdKPer4GWB83bDOm2zZDznnXGux3HuI5A07J8?=
 =?us-ascii?Q?yFAvyNFFvTITymr7u0WeTYXadGCgGaUiq2lKV+JkivzZlJ4Vce41sVPz6i69?=
 =?us-ascii?Q?eyyN+i2pBmaMbN9oyhkJ1pNW7KI/19lDOZrfax+YhLAdzNE6Esb3a14qmy8i?=
 =?us-ascii?Q?l5Xp+K0ZLvnQu//4tmMA3qfLxomN5aDY3EJRea8kXWkk8li1lJUO2nJX1x8h?=
 =?us-ascii?Q?R/2cM9Zv6GZiRAQHyquvSq5Z96huMTreLvp6kkHMMjyfo2Q+Hd8ao11AKHzM?=
 =?us-ascii?Q?dfzy2vU26lny+qoUQpBOJHBXc2bSYD06NDkIzz1TgN5CFLfIf/lFDPRf5wyj?=
 =?us-ascii?Q?VbHKM0tI97TkEnnsYVstqqKE9Y5t5hb+DOwwaFb7Ut5DuUNRW2XJW1Zf1frJ?=
 =?us-ascii?Q?QsZBTWE5ExO1sG+zGmqwpGpXSaAkRLx5g+hcptQORyKEs6+EWfsYFiXZJuou?=
 =?us-ascii?Q?6wJ9KBOUOWgrenvr8St7fkQnQVfYHVmvP/T9ByJfvy8TgRIiYMgpLvI3uWyB?=
 =?us-ascii?Q?4/e7OLXKRFNjEY28QlgeCumvjGPH9/fdEROMiyCzIcRZ2KY7d62g1MPXO8TQ?=
 =?us-ascii?Q?sMMJ14tFk5x2v7MBM4WEsL/7nczjopLoPM9ufvbojJXylk0DniBUhnfZHVzA?=
 =?us-ascii?Q?I01RkZUSd6+BoI77H8yMvTFC/1cq89mbZQFezS+dsUbAreyYGJ0R5HiSghh8?=
 =?us-ascii?Q?AWXkrsSDPUnddWVAajEjE90I6W+9FUt4r7QcObqmh2c0KGVFWjOOgqKyFj26?=
 =?us-ascii?Q?sy38w1cqoG+IuvWnLy8L/na/5PimNQUYxh/z5jDDp+n2BxYlRe3LcCP2C1F1?=
 =?us-ascii?Q?BO0bGddBdk0qsmfdqrN5PU4zVmeEJ9bI+/og/CxULed1rYFN59GnUMHp1CvR?=
 =?us-ascii?Q?XM6WFVbJ+QDpIdMJoX/KeEdaB5vNoop3/q3hWSfCee40sjtLktHFGzGnQXwF?=
 =?us-ascii?Q?lKsPb78KlYQSDork+jrztiru830ZStTsgGWPKPYjhRY6+tzBwKepAzxEU3VE?=
 =?us-ascii?Q?dd5XC3FBaujYf+wzW3Uh7LljwWJkf591AcZse4sBKVXAywwe47GIRcl0nRcc?=
 =?us-ascii?Q?dPqx2oPcww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16056fa-addd-454d-568d-08de84f495ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:45:15.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ9ClbHtxkZpnRTcX/gYYnLi5/VGPH4N0DrI+nCQ+qqxczD1dKcPrT4bdonp/pPrdBZHxp5mgvge8pdTkPX2eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11915

On Wed, Mar 18, 2026 at 10:39:55AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "ipg" and "per" clocks. This reduces
> boilerplate code and error handling, as the managed API automatically
> disables the clocks when the device is removed or if probe fails.
>
> Remove the now-unnecessary clk_disable_unprepare() calls from the
> probe error paths.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/spi/spi-imx.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 64c6c09e1e7b..a01c466818de 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2323,26 +2323,18 @@ static int spi_imx_probe(struct platform_device *pdev)
>  		goto out_controller_put;
>  	}
>
> -	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	spi_imx->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
>  	if (IS_ERR(spi_imx->clk_ipg)) {
>  		ret = PTR_ERR(spi_imx->clk_ipg);
>  		goto out_controller_put;
>  	}
>
> -	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
> +	spi_imx->clk_per = devm_clk_get_enabled(&pdev->dev, "per");
>  	if (IS_ERR(spi_imx->clk_per)) {
>  		ret = PTR_ERR(spi_imx->clk_per);
>  		goto out_controller_put;
>  	}
>
> -	ret = clk_prepare_enable(spi_imx->clk_per);
> -	if (ret)
> -		goto out_controller_put;
> -
> -	ret = clk_prepare_enable(spi_imx->clk_ipg);
> -	if (ret)
> -		goto out_put_per;
> -
>  	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
>  	pm_runtime_use_autosuspend(spi_imx->dev);
>  	pm_runtime_get_noresume(spi_imx->dev);
> @@ -2386,9 +2378,6 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	pm_runtime_disable(spi_imx->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>
> -	clk_disable_unprepare(spi_imx->clk_ipg);
> -out_put_per:
> -	clk_disable_unprepare(spi_imx->clk_per);
>  out_controller_put:
>  	spi_controller_put(controller);
>
> --
> 2.25.1
>
