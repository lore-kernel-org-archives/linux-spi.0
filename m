Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906294;
	b=g7DsCgwfl7tDX0NFMDunzlH/IiiWa0xWjqOViQ/ABU7p4kYgL+XeW8IWpH4W9kOWZNvw
	 sqRGrNX/wN609xjEMGI79e0c3vnfJvAXj+clUggWUQ7Ic0aNWHv1Nphmxi1gleZIQH7W2
	 kyIXanrRKCr2m9O9KZYAXAnsKpmZehR/R0ODz48Cr6mNoUez6fFA1iz2brQa1xC66AhgL
	 k3kbM1rh3GQfYqTJ6yzqULRRbQW5QGfQpZNak5sjTO0X6XP1FxVo8+7MsWBoSzswClHzS
	 ExDtHCKXR70EgXTdWOTP9ZchKJ2XuAuqbHYOfTVSgqCCsm3uMKPOIAOt1VMv55C5GJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906294;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Disclaimer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GgK63glnyj/ZxugxcrAE4B7EHWl/JpNRY1nUgx3hoXs=;
	b=nbCToO13Upe53ThvvkJmS56P9MORqQFUdCSNRjLVaavDyYd0L8Jb/xsIN6K5h8T6sO3h
	 Usn6sHiD0M6tQVhuRzlkebhJzEF3QsA9RKYaU/ltWQggRlLcQaq6i7bmX+pSuNbcfOaqr
	 v3zJ9KC8lXLK2i04GQHlKPlIpYSrT+UQkP/qrWrqBhnAWEtQxUEn8WE7CCMlV4QeSVTJf
	 8OrQB80mprJ0N9E1seFC2e4gcgxVgchoMjsVSj9GOb9+H7PBojZgvaMc1L6wMnGrGJDJp
	 yexCdIor80EqunGLsXw53UitwJ6sA/ykUaxMbrAVN4sWWb5TTWN+vu44K0Q9s61hCRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Y009F4M0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.20
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011020.outbound.protection.outlook.com [40.107.130.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D9606A336;
	Tue, 17 Nov 2026 09:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 924D9606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Y009F4M0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSX/KnOI+sE71ccphPtuwlnMcGFzdgDer7ID1WqqJZyE8oqYJQQhOtoaxPzO/XaRnd4ACPkAR9Lf7C0TZBZ9REe33X7WO8AaJW4CsjuC1fOgcGJEiWEHlhn+D1SVHmTEphwZlcF4J69VxGSVkY5iWnHC9GkpccuUF3BvWzhMBEfwotfDqOLLHD/2lRo3JYF+sbc7nbUr944iUA7XeBG/q0Lbf7Ad8Tov1h6c2AxB19SJL6cE5oBquFgVoZDzqdBqDhKzCozRkNC9q6ygnXb8a+PXw2f9ANpDXoT14khPXQK3MRABCV7sS+VEgf2jxVaOKBPp+d2VQbm7oWgs+5CwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgK63glnyj/ZxugxcrAE4B7EHWl/JpNRY1nUgx3hoXs=;
 b=xrrRojlsCH/Swc27ZXi05MjGBJXpTMq1dqQOkrBt5QwTSzlbXZzu91cTv90jppIuQK741COVHsK6UEL4hD8XeBfurlIWJJB/CwOht8UyXkWWIAIVjJW2QEnr490Ntz5Cotgtvixt2DRWiYphzgzzXdWphmVC430/MURb89WQWRgY9q3q/y7am5dbNYQ6kwj3KnVQsyx1VDHuHTUCnywUxEvOzY2gtstERfPN4DfM7ngmtt5T5P5vvjM5T1+gYEVIlbhKVla3W1wfDviAir9M/h/A/XhvVDovNq0Twy+zaGxB26DaVH/e6h1kexF2hTmhY8UiK6hG0fe7VlCsUUvyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgK63glnyj/ZxugxcrAE4B7EHWl/JpNRY1nUgx3hoXs=;
 b=Y009F4M0fQHxhwiBl7MDNVjZph1F0scqDFaxbbYVt51ME/8jMwztkS59xBZ88ItL1+S7IYGI+IoIyewvKNVHeIXGEPs/8bZsxYy8o8fKq6jnzvVO9mnEJIe0xEfzhz/5Sfoge+gTL1IfSN/YmvKHx5/CLr/Nwpib8djDhlNPtWx7cVvPDX2EF4G/g4lXCU4utHxzGLQfg6Q79djACx5n/FDTBGMBDvCJ6QxPH7WbgJM0JvZ75ILR05lBKZVAtErdJZ1leglNZQX2l/19fRZ0Dy97PXEVimgailFICvSUgSXaL7YJJvHxkjjoF5kLyYWgqGJ/Xt1L0+YUKAn0rvspuA==
Received: from AS9P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::19)
 by PA2PR10MB8720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 09:04:46 +0000
Received: from AM1PEPF000C1ADA.eurprd02.prod.outlook.com
 (2603:10a6:20b:532:cafe::25) by AS9P250CA0021.outlook.office365.com
 (2603:10a6:20b:532::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 09:04:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1ADA.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 09:04:46 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 10:05:30 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 10:04:42 +0100
Date: Tue, 17 Nov 2026 10:04:40 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Joshua Crofts <crofts@kernel.org>
CC: Vladimir Moravcevic <vmoravcevic@axiado.com>, Tzu-Hao Wei
	<twei@axiado.com>, Swark Yang <syang@axiado.com>, Prasad Bolisetty
	<pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, Karthikeyan Mitran
	<kmitran@axiado.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Michal Simek <michal.simek@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Heiko Stuebner <heiko@sntech.de>,
	Jyan Chou <jyanchou@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	"Sowjanya Komatineni" <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-mediatek@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 04/11] spi: stm32: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <avwYqLu0nEGsfAv6@gnbcxd0016.gnb.st.com>
References: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
 <20261108-spi-dont-use-autosuspend-v1-4-3587b0183cbe@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261108-spi-dont-use-autosuspend-v1-4-3587b0183cbe@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1ADA:EE_|PA2PR10MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d04b6e-1468-4308-4230-08df4489d3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261022105027099003|261028144727099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	MmBcNlKoJNUyPWEa3xjn91urwAHoIMYAFvQVaRwUomNDVn6cmpce7ciYMQpqxJEKUfqyc/kca9NvFQp+vsnowSkCJz5+ske6YkXk9DkhOzP1ffOxUl48JBcKjW4jdZ6aJYJrLO/CYSK6b8TN2qW8D6H15jSIbQFHiDMwWUKTIOq5vmAY+aApg5jlSzV8EEMXY394cqVyF74RNqrMmAE/gxkKBT9Ckm7zWDBDZqAi4LWTG4BORFpKiCyBourSVShz89jCj35p4QAPBU8/xB0C/YSG7p3WkY4G+91w6g/wN9n6d/hEzkFckQpBFvaat0xhy5ldAlexSvCYWAlgYrFeN/cH2hiCUtqKi6AvkhorqkA7nPkwTNNc5YZj+dUWx/O+TGYECjjKOWUbZcvlg1fIyjigXyA/dbPGvQwOn8Har2bscr5LZltldVRK33dW4EbKyXgOnbDVmLhY+B8o1Z8tAtZcy5O4WQ+v7Cj2gDcAAybAm3I4LbRgjKDlHF8ZcjjPi6KHm87fsrS3Y5lGDeQqXptAw2iP+Aw9F9/O6d0b6YW+C1ea7NuBJNBjGMFRNM/708Joj45EPWJgM/UmAQW7P7G0NtWdzPrSj89E5cRli5byaCCitdl17r5qwEl7lyXlkhSl2qnmfAsRXP4ztxhn5mFRQ8VVHPxnldPgftcwPQbH01sZIJ/YztRj279Fc1ZeF6Ff9csZcJLR4qVw+EUwgA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261022105027099003)(261028144727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uYk6wlbJ7S6TJiySOlPK6qEHBdl2PMQ07A97ROAgANvoCmqsEOxMDP+PM88DUSZny8aDQUT+hi6+A9Teci2/79870GPPmZauL2ONj7eoj3AvgZGd//pCzXhCiF4ukMv0HpplrSCshRURev+3V+VPlPXnp24slwWZrR+mu7/3I3sQn6igj89xs7MGxSGNhr1tWsn6vHJ+lvSZkl/aVcsihpIFv40SmB1V+GzgAXYQM5FL30cEfL1BUY1nxOm+TH51SUrLWn6EG2GMH4GckfnNd1OmKQgUetB8wUFTRnL2c98Rd5uPp/JuXkOhKtRBFB4xuBcd1HDn8VqAQlgaZWylqzv3VktVwlikEdrNkllXpv9gXQCCIESmuus4NNfYxuOpnbNjPklQtvTz6vRHqKOaCQ8drvoLfz45Fgjlt64c8uts4uOQSnOrtplyLdxyS5uG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:04:46.1762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d04b6e-1468-4308-4230-08df4489d3af
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1ADA.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8720

Hi,

On Sun, Nov 08, 2026 at 01:16:51PM +0100, Joshua Crofts wrote:
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
> 
> Remove the redundant function calls.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  drivers/spi/spi-stm32.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 4c3ae546afc0..95994278cdaa 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -2544,7 +2544,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  
>  	if (spi->mdma_rx)
>  		dma_release_channel(spi->mdma_rx);
> @@ -2574,7 +2573,6 @@ static void stm32_spi_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  
>  	if (ctrl->dma_tx)
>  		dma_release_channel(ctrl->dma_tx);
> 

Reviewed-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

> -- 
> 2.56.0
> 
