Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD12FE07D;
	Wed, 18 Mar 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854425; cv=fail; b=VctljCVCRSx17ON7hirQXYHnmjYBA0pqeXRjC1KIwQqpefIaPms8WwBGkHIPqn5b693x9Oyy+9/SMNzuGcQ/8WI2uGG3PJL1hsJLxjaG+cFCdd2jEUePgzB/4jUOwgmti5/l63AmnRW4E2KzEID7Fnmqk8jwmbER6YHiHAnE7o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854425; c=relaxed/simple;
	bh=hAFp8gNabT4m9cTIAqYQTksy3QtL9zHlfIVt2ogvhP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fahi6BSLLDGUbxvOl5rOTBDWSsfXa75xqR4EpxOOdtpRdh70WZwf9Ph6W87D8Xp9axClhM3a5Dr3dVPj0JpX5Y9DNDcwv39buVIl445LMvE4HopdGnZSt52oBAtgRKpJ0c1Xc4J6KhMSxEop/Q1YMExdX3QuryIbqb6VIDzolMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nmCsFbdF; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nmCsFbdF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoZh7XEt3HtrkaR9koCBJT9TA4dnn/OlS10UqYZO6BYd7Xb2ucV8v10DTKjrmmvTqJyqQDlt/tAWq9lhzm7uvJEFyiaR7lvQWMDgt5HaRWTnT21eEtZ1kmJgmeNs5GgBuHO2c91+LO4oMdRVqy57573rBpQqkebzVXkM7aMx+F2sNF0w0qHwqfEK5TOdShBNgDMfUx6X8cXuS/J6La0AcVrB70oswG5KS3gSAgCrUMk0BYCEkQThRKSyAudmjuxeD8LxoLNhkmzYsBajCsNO+mM5iqoAhE2F3GB66qPu2MQJ18cQAdypP2tz5KObXq/DHXqUDGmu57MDwPy9weCbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72i0Af2CILVbwbBueaZ8KOXIlo24SRO8oa6WAfXbGWE=;
 b=pEK30hfpWOMp8S64SNvEmmxcCI6P0jgDZHkLZN242H2flFcmfixMAxVBLaHerSnvHAdhffl9wgNpnP2NhMJAkX/hUUET3WZbhNHS8pXYi8WTB89+Ae1VxhaWUhb9ES80vnTnMbqEcbQSlz9Dx5IVQ/CKkDmyntXcjwVFFodEVF8ZUNPJCakFyZP+alCjEg6Z1R2Ep7RoGV0nNimbDx3yMRenbdwlblF5OgDc7aCGLh7r3kCmJKRtb5a7gbEnlVOGxnnWOs9JZmHK4jnUphT9tsJc/1+CvcGhhIa2SDEH7uz6jdGwZ+uTwlBe0rou14quXl72WFc7uCNLwGiPsQf7BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72i0Af2CILVbwbBueaZ8KOXIlo24SRO8oa6WAfXbGWE=;
 b=nmCsFbdFWc4ahJG/KSQW0jdGnHs5wB14Xk9YjQ6uISXDwnFRGGFfW1UNh4t7BEbXTXPI1Y95caAa+0y2CRb/VKQCq5dXi/sM427dRf20kxl5LBGfn80dcyNgubxPZNVHeIG+xmI5H/hBic/bZE+Ddz7Chey5GTm7Bd1ICJ6kdbJRMX2Tlua26Tn/SRbBd5T2DPUcBaC1nhJkvIySkFpifmW9nxeZxqvjWi9+mqiy+fm49OW82HBz4TjBNjPEJ6FyiVgb+vjNw9RRElNWVj9kSoF/0PYld/5oictPAnO9v4EB+qqcHZDMUbEcRizICbCzby9z33Ohb9TphGedDgu4eQ==
Received: from DB8PR06CA0064.eurprd06.prod.outlook.com (2603:10a6:10:120::38)
 by VE1PR10MB3805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Wed, 18 Mar
 2026 17:20:16 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::88) by DB8PR06CA0064.outlook.office365.com
 (2603:10a6:10:120::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 17:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 17:20:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 18:22:32 +0100
Received: from [10.252.10.174] (10.252.10.174) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 18:20:12 +0100
Message-ID: <ae1b9767-574d-418a-84d9-8bc128a9e500@foss.st.com>
Date: Wed, 18 Mar 2026 18:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v4 13/17] spi: stm32: Simplify clock
 handling with devm_clk_get_enabled()
To: Pei Xiao <xiaopei01@kylinos.cn>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, <openbmc@lists.ozlabs.org>,
	<linux-rockchip@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <cover.1773801401.git.xiaopei01@kylinos.cn>
 <cb88610059a9b20a9f2ffcd03cd77fecbecf7eaf.1773801401.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <cb88610059a9b20a9f2ffcd03cd77fecbecf7eaf.1773801401.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B91:EE_|VE1PR10MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: c54840f0-9b6f-46e8-e1d9-08de85129f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|921020|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	pC7QXVJDAFr+AzhfA92QyLXK1Orr0940Uu6M8ZFUxqZqLXhMv2c2zn7KAn7OB0+7xwycTbZ8CYrX2RsdfSXGixDpa+H/pacCZFQd9LNMcqI4HwkzCvpWRuZ+B3ml0rIGu/ar1hZ0tD2zB577JvOuTP2Qfqv+UlmkbtcJVqMOMgAgbVNX8XVo9vt6vE+fCqfGkS9UxAIDKwLcJQAsoJNKw4qm1wBK45v4xwSYqFbLswG2qh/c9Vsf7LMQWrg3guSqb3c8sioBIcr8VCF/TYOOYK7x7gPs4Ht9dxCZ0EbuEpfgosBodftJA+/zI4glNJmLQWXLvxEOu6rc91La0d+yj0Df9QaQSOj6/CTbYj0dg94C7heHBYg2AD7D2P0lqv8X3/3RIjgSJN2QTAMqgaPJrgRP374MOmqbmPqO2+qLHeyUs0z1cOfVOLaGBfqMwmzw4rEgJKVwBIX+oM4mygZiIuZSK/mm5rd6dzHqY+/7fPSwIg/flHNjBM7wg1v11LT1FTDoFfyUbbaP1P4CzC8jo31msZEEdSU2rMQN4z3HOrV5p3SJAEswtN0bIcj2f+a76CJFGcv9D7snnSztkGA9UeyxID0xhBaecfKvbij6My28A3aOzTcoGD628lCZqm+fA5eAfVuTj9Hkf45psaCu9mXgP8qIE8nggJMvgjWq1eqxn3ZcU6EPyqhGYxATp4T41euZisFHwA4Mj04Ni/un6c1YsigO8gSBkoSgzS5zCoIhirzpu/JA28VI7QIj+PR5xQ+ELq66MuB0+4KYcS0FXMTrlAcbE+Znqh5nvoXauIiNcK4tZlcOKRhWYv9eL8PQ
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	30Oq685Ewt/zJ+karDW1HSaKyZNcrSP2RHDAL4nB31zxx7ksaxKM6uhm+YpAn1qwLzbxoygaed8px4DCnGwy3VEsSHNRca05Ep7v6VJpY4rrSILBTXrVv2CDWXHQ+PfSILC/6kiubUOtiUhWnoq+Rn+hGwwvCidoyYtt3AMrv1aflADT69UXd5u5rbliCOoN8MsM65m+zoDlF9mAFc3L+75/cPpi+iYrFWGfCb/+bj53UmC5quQsCpsIiqlxC7pXznPL6PulUl3vYOvjzv317UEDiKNCoUbz6lYr2yhwnOZF4OlNuiqt5qYwfgMBM1IzlDR4n4J8/2xGJj6Z/zuKFQ24KFwDoIv5WYwM+J5tUI8TWJNHH92yp+5ENBb1KlPtpunaiI0dphJfDX5xlyf5EFvrSCVNSUwIffKbD+FgXhAKQ/Fq27YvWxBL3105c/X/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:20:15.9015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54840f0-9b6f-46e8-e1d9-08de85129f35
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3805

Hi,

On 3/18/26 03:40, Pei Xiao wrote:
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
> ---
>   drivers/spi/spi-stm32.c | 61 ++++++++++++-----------------------------
>   1 file changed, 18 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 8a7f5a10d4af..ee5092bc5956 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -2360,25 +2360,21 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	cfg = of_device_get_match_data(&pdev->dev);
> -	if (!cfg) {
> -		dev_err(&pdev->dev, "Failed to get match data for platform\n");
> -		return -ENODEV;
> -	}
> +	if (!cfg)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Failed to get match data for platform\n");
>   
>   	device_mode = of_property_read_bool(np, "spi-slave");
> -	if (!cfg->has_device_mode && device_mode) {
> -		dev_err(&pdev->dev, "spi-slave not supported\n");
> -		return -EPERM;
> -	}
> +	if (!cfg->has_device_mode && device_mode)
> +		return dev_err_probe(&pdev->dev, -EPERM, "spi-slave not supported\n");
>   
>   	if (device_mode)
>   		ctrl = devm_spi_alloc_target(&pdev->dev, sizeof(struct stm32_spi));
>   	else
>   		ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(struct stm32_spi));
> -	if (!ctrl) {
> -		dev_err(&pdev->dev, "spi controller allocation failed\n");
> -		return -ENOMEM;
> -	}
> +	if (!ctrl)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "spi controller allocation failed\n");

it fits on single line
+		return dev_err_probe(&pdev->dev, -ENOMEM, "spi controller allocation 
failed\n");

>   	platform_set_drvdata(pdev, ctrl);
>   
>   	spi = spi_controller_get_devdata(ctrl);
> @@ -2409,32 +2405,19 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   		return ret;
>   	}
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
>   	spi->clk_rate = clk_get_rate(spi->clk);
> -	if (!spi->clk_rate) {
> -		dev_err(&pdev->dev, "clk rate = 0\n");
> -		ret = -EINVAL;
> -		goto err_clk_disable;
> -	}
> +	if (!spi->clk_rate)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "clk rate = 0\n");
>   
>   	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>   	if (rst) {
> -		if (IS_ERR(rst)) {
> +		if (IS_ERR(rst))
>   			ret = dev_err_probe(&pdev->dev, PTR_ERR(rst),
>   					    "failed to get reset\n");
> -			goto err_clk_disable;
> -		}

Here you change the behavior: it should return dev_err_probe(...) (on 
single line too)
+		if (IS_ERR(rst))
+   			return dev_err_probe(&pdev->dev, PTR_ERR(rst), "failed to get 
reset\n");

>   
>   		reset_control_assert(rst);
>   		udelay(2);
> @@ -2461,11 +2444,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   	dev_dbg(spi->dev, "one message max size %d\n", spi->t_size_max);
>   
>   	ret = spi->cfg->config(spi);
> -	if (ret) {
> -		dev_err(&pdev->dev, "controller configuration failed: %d\n",
> -			ret);
> -		goto err_clk_disable;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "controller configuration failed: %d\n", ret);

it fits on single line too here.

>   
>   	ctrl->auto_runtime_pm = true;
>   	ctrl->bus_num = pdev->id;
> @@ -2490,8 +2471,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   			dev_info(&pdev->dev, "tx dma disabled\n");
>   			spi->dma_tx = NULL;
>   		} else {
> -			dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
> -			goto err_clk_disable;
> +			return dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
>   		}
>   	} else {
>   		ctrl->dma_tx = spi->dma_tx;
> @@ -2579,8 +2559,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
>   err_dma_tx_release:
>   	if (spi->dma_tx)
>   		dma_release_channel(spi->dma_tx);
> -err_clk_disable:
> -	clk_disable_unprepare(spi->clk);
>   
>   	return ret;
>   }
> @@ -2610,9 +2588,6 @@ static void stm32_spi_remove(struct platform_device *pdev)
>   		gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
>   			      spi->sram_rx_buf_size);
>   
> -	clk_disable_unprepare(spi->clk);
> -
> -
>   	pinctrl_pm_select_sleep_state(&pdev->dev);
>   }
>   

