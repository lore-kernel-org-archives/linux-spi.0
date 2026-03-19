Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC93E8C72;
	Thu, 19 Mar 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935553; cv=fail; b=aMyvfxzp1l474lb8wH/VblEQ/bHBNXe0bZaA1PPgF0Cwn8pUALKaR0vYKvVPr+oPO+svvuc6cqoySCdWoFZbhWBMZt2GdDS+OdLNiA2dlGlLvsST94sv/qd9Nbz6TFUvetqNEBTEILEaEwlmGr1FwDVlMw12Hm+VTNxLyK+hvcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935553; c=relaxed/simple;
	bh=S+1zuVNYox0Ad3N9f4jT83kRBTlZr7JLBdkkKE9I298=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9nJMKV48MOmUto/mVd2yDVQShaFwp+FvpGOSx4IfHA/qMyec9XH6X0IW6J3K3BtT3hHEG1ZCDaDaeT9v6B4gqEmDCCLUM9nYO7lgrxJM15oPFfW2k1m8xAeEkEkFQ0F+5kW4gANMQb9FA8GnPP+XfGDklXA7xT5rb9yBCi47iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jSyvClCr; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jSyvClCr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB45WVRPD/YHpVDRB1Dwd/5KMpc6wZjbp21dITHPVl4GVAFPeoYTtCG+ua+QiU9vONGerdMQMDESe6kQ+z8xDRkNgI8KQUS5XfZDUY6RzhNhlSn1E875dl8W6b6+dLhpGpDu2RWIFGMtCTE25aysRQNf6zJTuIIhxaRQ/ncWIYCA99rS80G33ZHFuqGrI+pZr2bxib5e1TDWtfiWvfSWX8UI0h3M3B3gFVPj7FsI5xPLG4d3mW1yd+8Gw3FM3HbugX0zDv7qmL86X8u+MY1yiVmxyOmcMRJG9QsPQQMPTv6bsImQYEtz5CW0IVGHvZ9ubAxLsQJGZ6qBm5oZZm1Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmgyijRcd4OmJG/9PnORXit59oxOF3CJelVTrd5+kIQ=;
 b=RbDDlMRmUrAgX3L0qbeftOWPiG3CALw6/Wtyd9zwJM+7Em0wBCAOP1H4+8G4zFMEQCnX+WwZaQbXaQkFrKDMNKsm6HzUFGlRZREHDGQRmPnbu0toHA2Un9Xt++rr4P/YS6xEpjGKiml7MxXOIag9GdYw2SK9KrmhORtiFZa14OVaIJ4BC0CX/3yTa4So/3m1kIOJ4Nm2G1/B6BEHMYQdCrk5A9AqPeK20fEPRnpywr+aqyily17PBR7emMLIxos1TVn6XrrALaMksy4Myy6WT/5udIgKovgvCgQGQrUZzSGKKP77QotdW8fZKL1LFN8mrq93fT14xa2jMetpQr1A5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmgyijRcd4OmJG/9PnORXit59oxOF3CJelVTrd5+kIQ=;
 b=jSyvClCrbBv2TQ4t2t90g/vNNcn42Xj8bhi5UEPDpNPAmF6JnQjYiMgsyxZKHKmIEKZVQYI9Frp3DKPh19nFNMHgGbMawlUreS76kYr2aU1snytDDGlf9LB5VBH8JTkhk54HpGwgWNnVri6kFCyNnWpncuSIejKBu1NDApA3FmBvD3sREn/77pc83HP5twjh974pHyUEvRxbnwEGae8m+nv7LYhiruT9V0/Rm8x+Q2x7zukcKDy2+hQlLzPB1AfR/b1ae5ifVtkHGXO9PwcDVQZTz+bTfBiT8yF6A5MrXxxosW5QaLTeScTYEZauIYnTj5BCcRJEcBDb0jgkuWXCEw==
Received: from DB3PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:8::27) by
 DU0PR10MB7264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Thu, 19 Mar 2026 15:52:26 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::ee) by DB3PR08CA0014.outlook.office365.com
 (2603:10a6:8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 15:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 15:52:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Mar
 2026 16:55:00 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Mar
 2026 16:52:24 +0100
Date: Thu, 19 Mar 2026 16:52:17 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
	<openbmc@lists.ozlabs.org>, <linux-rockchip@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <broonie@kernel.org>,
	<Frank.Li@nxp.com>, <amelie.delaunay@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH v5 13/17] spi: stm32: Simplify clock
 handling with devm_clk_get_enabled()
Message-ID: <abwbsdBCbNZniGPO@gnbcxd0016.gnb.st.com>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <c8259f582596fd08541b94dce5dbb4cae513e295.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c8259f582596fd08541b94dce5dbb4cae513e295.1773885292.git.xiaopei01@kylinos.cn>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|DU0PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f4bb44-52c2-4323-b3ae-08de85cf83f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	i790NmnyAze8L8ruj4DraySR3x2noY4HVobfFZ71eduo69J/CBZ19gmz5kiqg7mQ/+Fm6bHpxiRH29PU8N4MU/pAyxOXuvlBKhZ9Zqkkv4cqDeHhnsBKTGY0BI9ZlndodkR6AeGPS5eTRmtxqIolxDjk21FG1x+L9181Q26sJaqFLIS/Yus4pOJWUttYbX8YEs/jAZigMy9IlMwVl7IBMb9r5OdoQi5g/SDEGjXVRHg3V4r5YauwoVTUTb3IBoEbVWao2Zp6Ns1XdjFMlVT7YwPNvjaNMOk79u/e/wh+hrTWr44LOmp4UGDQ0y2aFZDnSJ/aV07Ln45je5VPDQOT5J4enIwt2+C90e/If/3Y3LdGBi/hVNnH5Skd+a0wVLO4Aoa23HT1fR+p/CyCY3aRNUdYvoGx2v7DBy4fbYCbKRGmHn7Fvk72fP1ISAajuoA05rCsYsd9+OoLw6OS204/o48Wcdpo5zx76xqAFHm6QUtx1MBBC++Y9lguY5s+lTD5+S2WcMcxlg+fSyn+n1HnQXOn1z6nUmucC6/GhMjSTyQmxh17XdPQorwQbR3P6cRAXbObZcUeHMAKULsGHIUEW5iGIapwW1pgAdebK7nTEIB6qNN1eHpfE2LA2pDErsWdZ/lvLHrkmXKFuBFTgRvoKs/zIU/3/062IQOT/xq2RB7Q4OYgv5+nU2z+IyDvcn+IZSNAIY8I6hoylkOC73j1V7rKpMU7F2vWZaREoih91f8=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TVXouk8Fa30YFfPqg/PB/cNdwlNnrIc58BlsYVyv1hQtynP8rMeuZOfnW5TDyQAHeR7zXxyCKrUW0qt44lpV6w78fID2zpFCzeL0KFt2qYYLHILZB3rdzDtnPtptXRGjbLO4LomkViIdEOBCtSy7S40eLEt5OIs2vOsJDLczQuB4+RcNjoDQP2WUDrpd6BGl8Mm1F8/3ZnVI33QIi0XplZYKfTVp3U4702JwNQdyeGtN5/rgJ6fsB4Niw1J/CZjlo0siAVpO6mKucCdVyr7ql1oxUhQfX2teXeifx18y9+kDs9PtVVuVoZCfxoW4kAvfKyPWQ7wW1MJg9eR5b83Su6e4G2Qg1lKqwhU0sv/Om+rnkVrqn3+0r/4o+NbWBxDKXCJHKxrDb5ZH8eWMygU+ls8JZ3mo3B2LxxdXuZwNYExzV6dVgIkrRPtTjy7d1DAy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:52:25.0594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f4bb44-52c2-4323-b3ae-08de85cf83f3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7264

Hello,

thanks for your patch.

On Thu, Mar 19, 2026 at 10:04:09AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the clock. This removes the need for
> explicit clock enable and disable calls, as the managed API automatically
> handles clock disabling on device removal or probe failure.
> 
> Remove the now-unnecessary clk_disable_unprepare() calls from the probe
> error paths and the remove callback. Also simplify error handling by
> using dev_err_probe().
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Acked-by: Alain Volmat <alain.volmat@foss.st.com>

> ---
>  drivers/spi/spi-stm32.c | 62 +++++++++++------------------------------
>  1 file changed, 17 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 8a7f5a10d4af..be88e62075af 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -2360,25 +2360,20 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	cfg = of_device_get_match_data(&pdev->dev);
> -	if (!cfg) {
> -		dev_err(&pdev->dev, "Failed to get match data for platform\n");
> -		return -ENODEV;
> -	}
> +	if (!cfg)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Failed to get match data for platform\n");
>  
>  	device_mode = of_property_read_bool(np, "spi-slave");
> -	if (!cfg->has_device_mode && device_mode) {
> -		dev_err(&pdev->dev, "spi-slave not supported\n");
> -		return -EPERM;
> -	}
> +	if (!cfg->has_device_mode && device_mode)
> +		return dev_err_probe(&pdev->dev, -EPERM, "spi-slave not supported\n");
>  
>  	if (device_mode)
>  		ctrl = devm_spi_alloc_target(&pdev->dev, sizeof(struct stm32_spi));
>  	else
>  		ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(struct stm32_spi));
> -	if (!ctrl) {
> -		dev_err(&pdev->dev, "spi controller allocation failed\n");
> -		return -ENOMEM;
> -	}
> +	if (!ctrl)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "spi controller allocation failed\n");
>  	platform_set_drvdata(pdev, ctrl);
>  
>  	spi = spi_controller_get_devdata(ctrl);
> @@ -2409,32 +2404,18 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	spi->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(spi->clk)) {
> -		ret = PTR_ERR(spi->clk);
> -		dev_err(&pdev->dev, "clk get failed: %d\n", ret);
> -		return ret;
> -	}
> +	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(spi->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk), "clk enabled failed\n");
>  
> -	ret = clk_prepare_enable(spi->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "clk enable failed: %d\n", ret);
> -		return ret;
> -	}
>  	spi->clk_rate = clk_get_rate(spi->clk);
> -	if (!spi->clk_rate) {
> -		dev_err(&pdev->dev, "clk rate = 0\n");
> -		ret = -EINVAL;
> -		goto err_clk_disable;
> -	}
> +	if (!spi->clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "clk rate = 0\n");
>  
>  	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>  	if (rst) {
> -		if (IS_ERR(rst)) {
> -			ret = dev_err_probe(&pdev->dev, PTR_ERR(rst),
> -					    "failed to get reset\n");
> -			goto err_clk_disable;
> -		}
> +		if (IS_ERR(rst))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get reset\n");
>  
>  		reset_control_assert(rst);
>  		udelay(2);
> @@ -2461,11 +2442,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	dev_dbg(spi->dev, "one message max size %d\n", spi->t_size_max);
>  
>  	ret = spi->cfg->config(spi);
> -	if (ret) {
> -		dev_err(&pdev->dev, "controller configuration failed: %d\n",
> -			ret);
> -		goto err_clk_disable;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "controller configuration failed: %d\n", ret);
>  
>  	ctrl->auto_runtime_pm = true;
>  	ctrl->bus_num = pdev->id;
> @@ -2490,8 +2468,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  			dev_info(&pdev->dev, "tx dma disabled\n");
>  			spi->dma_tx = NULL;
>  		} else {
> -			dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
> -			goto err_clk_disable;
> +			return dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
>  		}
>  	} else {
>  		ctrl->dma_tx = spi->dma_tx;
> @@ -2579,8 +2556,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  err_dma_tx_release:
>  	if (spi->dma_tx)
>  		dma_release_channel(spi->dma_tx);
> -err_clk_disable:
> -	clk_disable_unprepare(spi->clk);
>  
>  	return ret;
>  }
> @@ -2610,9 +2585,6 @@ static void stm32_spi_remove(struct platform_device *pdev)
>  		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
>  			      spi->sram_rx_buf_size);
>  
> -	clk_disable_unprepare(spi->clk);
> -
> -
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>  }
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

Regards,
Alain
