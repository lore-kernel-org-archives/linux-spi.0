Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0271C84A0;
	Mon, 30 Mar 2026 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850391; cv=fail; b=F9F5ql4KI6RWbnqyMmO4CaCVw7WCgrQJpLkZn7E/zi7kwb9vwg34F4w0VpvEzpoJw+qjcP70vr5EbW7POGBPq6KX9RjEuqTvc4NhWvgKxWptYT/QXFxn2lKCFqWJ6qIT/CJPqmGICDmBfWDEKm7NblJ5nUxSm0NtSb390RoLVbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850391; c=relaxed/simple;
	bh=8gCYbi34JacX1jvrr6jH7kSy5D1t+Rk/3Xo419pCgqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDSxPUCAovd4m9JpSbHQPzigDLCRFb3tDMTromttaLUQY0dmq7p4rgLK750LCfK1G/5KkW969xUH6hBaGQaT68k8r4ZUWA6RWf1TLMH2HZ//Zap1cxUEZucoJJzIuwnI2xklVQPZpp1bg54Xq54T5DVxqzGWsnjH+u4INPs2FdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VI/6UcWP; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VI/6UcWP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWJKK/QOK29xDoh5MS102ZLgzalXV4OzarfpjbStbCBHT13e2OAa/fSM2b6R9huhhjkifOQAdkeF1FdOdPjqqblcRl6ozpDN2U4cQoF57ehWVqFn5WIMZ+vS5ehH7eekPJ9BZOijHttEDTmq6OpKe34M8Fc2ocaGjl7AA2RoCqfmM1/8fwXa6VLlnTQNHtGw1odmSKrk5WzTmtn7UTlAxzWqq0EGGw5jZ6j2nrVByCM0f2HlHo/Nz6vKLYzfM3WxtqL/DwTkj6aSkbKVllW0mRzQdGsU9/6/iH2zdjVAtylW3iBYdxUxVwloyKTwHdKPAjeQ+YFCufxEvjr5eqk7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHKg9Q+JlijQx5DLBnlJ/zAbiL0GUVaVF5hXeyCPbC8=;
 b=DA3ORlzHHgdHZzAU9HBDWkN8a0UO4PEW9AHk7IXcC7U39BfiXFPCGDt1fg/rhB4TYih1/2JhzkEGOQclP7Fb/GE9dM3AmnStHESc4LT9OrlTIdS9blY/BeRXGKMoiugcw1X7AAU1H24VAcuXLt7Z6g2kLReW+yMehD+R9yHUjVMmBzzKum4V44RDYEzA9pSt2G31VVe6+RPy1OyNaIYKuC1Uu6kQbbE7WHzmsAOhGqk3ZxXxvZqJLUoiJP4b8QIrqviD6uzLh165SEa7qiKBONRsH3BcFH8AC4oIift8tpr/1Ar0GaHyY01gPGPqbt4DI4czoBibDARLK7q5EKtMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHKg9Q+JlijQx5DLBnlJ/zAbiL0GUVaVF5hXeyCPbC8=;
 b=VI/6UcWPFl/gnw7TpPcKbdoTiqMJgNLm7cE02B3ncXSJDrGkNuFuT+4flOitzmFSYcXl2rciGEGnLmM2/wwrrD8FoEL8gORnsiZgVVqnPGsZ/0gG3Mowo7H4/u2FydR3arZcZzppasgTEyiM0Q4RVOnL+DEBk+ErO4qv0+2UFVvyYZJ35GR1qHHsLb2Ef0PEvI7SOe2iMKL0P9sd0o/auIEAE+UsjV5vcK6SMf75O6tO2BzbAzsRToVv84SI7MVquMLrp7lE2o5thou/WSA6zirGAQh8nn9mgyIcDEwOJPUFWPYYm9DR8RBw+l/pvAN242W3LwomMgEHYGKKEhoLfA==
Received: from AS4P250CA0002.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::20)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 05:59:44 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::cf) by AS4P250CA0002.outlook.office365.com
 (2603:10a6:20b:5df::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 05:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 05:59:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 08:02:23 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 07:59:43 +0200
Message-ID: <f9c1d1e8-408b-4456-b048-1eed4526e214@foss.st.com>
Date: Mon, 30 Mar 2026 07:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: stm32-ospi: Fix reset control leak on probe
 error
To: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
 <20260329-stm32-ospi-v1-1-142122466412@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260329-stm32-ospi-v1-1-142122466412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 58711f11-8bf6-4c1d-ee6b-08de8e218a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k4I/aVFRdcQjDyqE03HcN37hy+OaeeUkFw3riu7Mf5VeFJ5tklBcX89Pt7ahYZhtEVeq8hKxfV2ZpctJus4qrdKjAtxIb3whgo1aOiRo7iPKEz3PyqzpWL5pmX1wD4zRIF1xLm/s7hjM6m/M8CtEKqL82kVNsEgIeUOhj07rOhaKD9+oBqLIjF8Om1vgQqWBF8zcwUr0OJp+l9pg7yWoQy1U+eyhNSPGCj8TrBlHD3FHVaZZdhQ3E8/kPRJz8+VVj0huSwIgSOvrLsXTAThT0vYzzpM8wpefWqDDPWiWocKbFLdeHr6n4xZr5vRsHIVU4BKq7dPx5Nd+Q2A0nMZVg3eW/oSfds5vMiFybXr8fD1bHHXyDwXQLEUVtQVf/Rf9NmJKDt6EkK5Al05UnM/5x34z51w7zb4TIUcKx+Ob2ztObPx6J1SZqM5xWjv0h/YTsRF0T8MDuQf2d1YqTrDLnCgC1LD38u18E9vBNBB20/Iy3152SAYwAyzQHFl1F/FWJdilGDX06iKVry0Mby40QJX6nDY36Vdh6GCW2E+bh70G/2yKnF/mZlrHsbowt4ay3xBq/sMdneQk7iU2gj+G5GsJg/db9/USIUFgYFnI/V5ExdebehCgozEImIfacIOgwrVOUHBB6n43ozFS36eYgOza1GOSl71Tk2zlQrKaJBDOMAyYQ9+F0RaygR9BMrlN8FlP8S+hFTE5ITcXgrewDXV0cuu0VysfVAVKJGEgAmQBQVwkPzSLg0LXkUyeycCxbJLHabyKcH0BMxgv1Wdi9A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sajkBAqiMzyQ8q6OJNpckjkh4UgPWTD71OcLfRMjyCb0vbJLmN6K9Wa0pLiNDSiTfPdY97eou3O4EVxSubmRm8BsTL3HqgJ86ioV9AuSCYsYM9AeNneGkpdZzb5CDHbCKdxRmUyIXF5+eVsCj4RzX1p9PQObh3A7WwcUBYQkzut86cF1WmqUu100Xw57Uo/idIih/BQG3HHi+PKJYh7Ymc1qADv4GYPOEiOUieg/8zpsILd5aqfuVdviWL8wbIjXcS0dGzrELI5BYWDIAKkswa5gkw+PwWgG+B05JC74StYeQ88AHvwe3jSgVtTaFzGeJ54tK7egEO9K//OQippmKrSB9ST00lFuMR6K0xZYxkXuV4/AiJqv5U/J98pqLdm/ADPeMdUscpAHUsHn9eHbmi7EB1B3Kt0PgbycteH/Q85IB/dSp0Kp7qBzzwLfbwV1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 05:59:44.1046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58711f11-8bf6-4c1d-ee6b-08de8e218a80
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063



On 3/28/26 17:07, Felix Gu wrote:
> When spi_register_controller() fails after reset_control_acquire()
> succeeds, the reset control is never released. This causes a resource
> leak in the error path.
> 
> Add the missing reset_control_release() call in the error path.
> 
> Fixes: cf2c3eceb757 ("spi: stm32-ospi: Make usage of reset_control_acquire/release() API")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index acf2d182e8b1..52997c3f7174 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -960,13 +960,15 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  	if (ret) {
>  		/* Disable ospi */
>  		writel_relaxed(0, ospi->regs_base + OSPI_CR);
> -		goto err_pm_resume;
> +		goto err_reset_control;
>  	}
>  
>  	pm_runtime_put_autosuspend(ospi->dev);
>  
>  	return 0;
>  
> +err_reset_control:
> +	reset_control_release(ospi->rstc);
>  err_pm_resume:
>  	pm_runtime_put_sync_suspend(ospi->dev);
>  
> 


Hi Felix

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
