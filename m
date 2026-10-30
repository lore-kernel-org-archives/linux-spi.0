Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371681;
	b=eHk90DH4WXKR8jgtrBdjKSTGYq/bo/b9tTBzgkhbjqhGGDKOCBqvGvYkIRxM6cDo5RpR
	 YDKx1JmwyStH7GzHldguq8up4FM6TqCaA/1faeVFrgHpxCLZYEyBqoDiEbkNVXy4X3pBx
	 4hqXJ/i9YbenIyDW7E7nJiNzrvqdcN0BWziGDLQnxCHiWOptAYwmExYPMayl/BPN3zSAz
	 /VOd2PqgPWEzTU+/UJHTxAdiR/pwS6UQAYUofmDf5PZ6ul8rr99tBPzFqqGOxx3FfUMEB
	 NxS0KhLh4rm8aCMIU9pRLx6pbZsvGhxkuOmJEniHQvWoY+eOY64ANOFeoEdMl7vN4fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371681;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wiBt2adyNssPDVuBgui78eZ+UT/JYY2EutDA38J/UWA=;
	b=5BITqRRJc+Ti7oDQ9EVD01rGF8d/dqRYkUySZdDLEgIvgPskCbrKwttRIRyRM1OgFqRB
	 ykHfItwikvykEaseUVKea08aZC8pERV6w02n2SplpFYFV+qCLpHjeo1xwVHiIvD+YVsVF
	 MrlpB5FVP/dF+OA//BTaTudPcToDUXDxTiMZmsolobBLnkL0G99WjL3fPSte7hYt2CzyJ
	 Pcr3WkS6i0OBc7DNhCBmKMC2VtbNjVq3ThRxC2btQr0vpSKU7ef/GUXpQPjwouu6w4nx9
	 FlpK8gUINhU2YKV7+KRDKYHU5krq3kTmcEcBuRUAXb6m1MocT/Ryew8alRWprmYPxuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=JsUSJJ13;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.0
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F1606A31A;
	Fri, 30 Oct 2026 14:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D42F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=JsUSJJ13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI6NHEOUYEHrPe8739huOGjovJM10S1Z6YFpQcIWzHW6Cz+7U5+h1/5bZrRUnavdrwHExPhbApOpKDimEhzF5X4taeR9S2m0VboLzZIGd3ycZHkavEZF+zClb7maKNae4Gq/C2vyabvhl991AKww+CgsK6ZDo9K5XBvcuxedAKs1kPeEZDg9sgrRbuwre1yKpugmv5H4XNCGGUeJ1unlpuFtwC+GMbVMxqX+CpT7saxsphOP+P/eBhk0NBQu/bBIGwsP12rUdEExBckVRVVL9ODuK7P0r+W1m7eg7QD4YIqn0VQ2RepsLvFnrAYxfoeHgJJGM/MlQ3I3gTXVO0DUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiBt2adyNssPDVuBgui78eZ+UT/JYY2EutDA38J/UWA=;
 b=pTwhlmuGSSwSjnOKt72QqcmWXW/hS/t11t0EpdrgeK+s3gHNvZv1yILxUFFWlbVG3vuCg+E//Lfm9ctxX9W9uurEMqHMuzj+bblHCuty+YT9UkABwIe2C6RQQ/B00jESi7YSF6jyqFj2qCW+MM1q1GVKy/rfrkI8WapLZJBbJux8tVeeqT9C8mi+KwU4YhQgZant4MxygxdBIJT7TfahmB6i23WDhfCTDDdwrPZUMMTbwOmm3Njm+wP2KBpDIPASMtovnb4L+umTJ7h4WTi9vRV82QGkE5gVKRUjUHHiEKsjZdbM7k4rg2hUqu6XVf1W1rRAI9mX7r1z+SMVzBETmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=163.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiBt2adyNssPDVuBgui78eZ+UT/JYY2EutDA38J/UWA=;
 b=JsUSJJ130k7WuZs5OgvJ/wbACRHmzs6711As4PkPqyYKpJu8GC1aTQtZM07qIAaivyQbHGKwdp82SEzG0Q1Tl6XxZ5kOiY+6AeOYHoL5MXrsYCPKAR/nG79cQX5L7+JgeFlAnq2A6XqFbi7Up4JpWOtKVdpUuoA+aB3/lQruM+0VBfjtKD6fVCF2RxDztOdOKxBODOOBrar0B/1gNV0ZS3vNOXU3c2/n6Yam7l6cUTN2OHaVjaG1fMLoLB5EbyJZGwcQw2dwtRrirde8mVePwDDpMPxvprTwamFLwLnWpGCTS4pH4j+qnhwuHWr8jkXYbmoujO8F2yfBYNuEWpiQxw==
Received: from DUZPR01CA0181.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::22) by PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 14:47:56 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::a9) by DUZPR01CA0181.outlook.office365.com
 (2603:10a6:10:4b3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Fri, 30
 Oct 2026 14:47:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 14:47:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 30 Oct
 2026 15:48:38 +0100
Received: from [10.252.9.90] (10.252.9.90) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 30 Oct
 2026 15:47:48 +0100
Message-ID: <aebeb751-59f7-4281-983b-a7580196556f@foss.st.com>
Date: Fri, 30 Oct 2026 15:47:44 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: stm32-ospi: handle runtime resume failure in
 remove
To: Jiale Yao <yaojiale02@163.com>, Mark Brown <broonie@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Felix Gu <ustc.gu@gmail.com>,
	<linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261019084443.1824122-1-yaojiale02@163.com>
 <20261019084443.1824122-2-yaojiale02@163.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261019084443.1824122-2-yaojiale02@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PR3PR10MB3897:EE_
X-MS-Office365-Filtering-Correlation-Id: fa250b92-fa00-47f3-8b98-08df3694c904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gmSuaV3k2gtzg5MQLbg1GvPKonLlpDqXBYQYL9Dns8nbzG8mVUl9LtjegOdEerdJJZfChE6ELtagI3cv94kecEP8Sne1teFMxerY0/Rz4wSzQNulXDgb6Xc3G24pKUIn+9dQvy1/VyZybwSESFeAhKQaML8mp5BlXqu+DNmlBX1pF6NxY2uIqNB1ttDgJ6lc9O7Tpv8eP0pcGjL30rtRi3YVV93U4JsHOYGJ0rlsfou6mHc4YDWiDgcjzT+V132WlIqYVh8pf7Fon1WRFfEfWn3OBvmpYOiYR9Kot7sbaCTWx6BwZjXpG5rEWEZC8gW7u/8/z/36HTZJ0gJ1+tjC+tQNYhNyvi+qUi+7neqEa1T6lNPNMU6NSahSf8ruL0d9GgE06u9/aKeR08A7q745oof3w/X3WBVucyfJgp3zDl58+2KLnISxRkjCKRfFaU5UGIq4EqvH3e1w32vsC4lCCPTOBQfiavNYtK2rOVwECAlM9tJKVBjLqooWlYVk8Zu5D70jIHuFFrSRXintHYNAKQVEc51HCX44KSs4d+SWqrJ0IsT1ZbpowyL7251bwgvDudTyefjAQFYIuMtdgFquNyUiYo+JkFJMQBdUhD5M6eFCHSXVY8/rn1UH2ZDPIYazfAyKieGVqc/RBbxWHUpiiG60j+9aDoVK5GiROv2bTpZbfIqPaZEeRkevceWvdWjs8aBguPRiuTrzUmQIwSMLnw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6X26TIGlbsl2gzic9AIiXaGji5z+vJMYCrXaeoUCymCzYj7Ny+UHxo+3H19zT8NuR4QYzZ89HduUO/UrGXUaKL3f6CDSJkef0UMTw38XNdfmV9An7P2211myhBPBApsP/IET0AuNG49jHrjGxT7U3DtcqJxt0qak54Z2gGFReORmp+zFlqjz1h1R1PLKKa3n2iMwMJqftraQXXsPZl+P2h/LUzNZnDSt+rj7+RDU2wAJjeloa8K7pDVsVJrBdyRF4z9ht7BcdRY+zq2p5jDDdHUilpBzKSmdrw69+9ufEWmMMWgu4WN4bISTT2FOjukvyDz3oW1CvN7CEg6XFOwZtvmeL+b65vaI5RH5zF/4brRAb6Puhds0ltTn2/M5bI+PNuUmQnV2fflGQkfPZG0gUSoGnKtzX9jzhgOZ6y1qxXZr6Xs3ZatQn4LDuHzZ3krq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:47:56.4264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa250b92-fa00-47f3-8b98-08df3694c904
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3897



On 10/19/26 10:44, Jiale Yao wrote:
> stm32_ospi_remove() continues with the controller teardown when runtime
> resume fails. The register write can then access an unavailable device,
> and the final runtime PM put does not match an acquired reference.
> 
> Keep the resource cleanup, but skip the register access and matching
> runtime PM put when the resume operation fails.
> 
> Fixes: 73cd1f97946a ("spi: stm32-ospi: Fix resource leak in remove() callback")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index fa0e8e83cb1b..1340e62ebe1b 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -986,12 +986,15 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  static void stm32_ospi_remove(struct platform_device *pdev)
>  {
>  	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
> +	int ret;
>  
> -	pm_runtime_resume_and_get(ospi->dev);
> +	ret = pm_runtime_resume_and_get(ospi->dev);
>  
>  	spi_unregister_controller(ospi->ctrl);
> -	/* Disable ospi */
> -	writel_relaxed(0, ospi->regs_base + OSPI_CR);
> +	if (ret >= 0) {
> +		/* Disable ospi */
> +		writel_relaxed(0, ospi->regs_base + OSPI_CR);
> +	}
>  	mutex_destroy(&ospi->lock);
>  
>  	if (ospi->dma_chtx)
> @@ -1001,7 +1004,8 @@ static void stm32_ospi_remove(struct platform_device *pdev)
>  
>  	reset_control_release(ospi->rstc);
>  
> -	pm_runtime_put_sync_suspend(ospi->dev);
> +	if (ret >= 0)
> +		pm_runtime_put_sync_suspend(ospi->dev);
>  	pm_runtime_force_suspend(ospi->dev);
>  }
>  
Hi Jiale

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

