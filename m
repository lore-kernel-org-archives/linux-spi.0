Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DB391E41;
	Mon, 30 Mar 2026 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850580; cv=fail; b=UTiaeLiZh1mfX6LszK96xZD7Recc0kgHrbFMS70bFIdTaNmT3jJbs3bUVPBfsTF864W1CkjfmtJRHY0sSZKyQ1BB5gPkp89qm0UWzMvU0t0MpQzWjC7QFPlSkf9xeuuzzcstxGX/DQJimfZbqL8h8GONJzcK42/FkbcHQNLkUZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850580; c=relaxed/simple;
	bh=Jfg1dBgWNvI9e0rognzMBZCBxoKnlsXNFjhBpb+xYGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tTn82kX0mI3b1n3CTUof0sSpiZ1AwYcwUVLXq3FCTVbE0JDZ4KUK0YND1Mfx4u12CbssLhIPpd05hFTemUv8WS6J4c8ZHJ/oYDNnOpjPDLqu/gSmKDcJvKWh1Pn1rn4nnJq7F70yDcyQvDdY5GPwCuomRcYnTdiyGB9kYycAZ0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=P5YoVCm8; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="P5YoVCm8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro6EwkL9KPeDFnOD9G+XD25l8wAIkpUsiIFtoisQTt26aNxbFXaY3wNNEdW4sIFlX0QXBJQBoU0LIlW3L4Mz/xBBB1NU/S5ND6sU6QNA+IqMbvcSkOnozZLAYx3UvGYAjiwOGpka4t+UrSMQ8hZuAbuvtgOdjZYQl5pSleE/p7TP+MzQ8QKFNhlMiCdTDm96S+GIU0h/6EzMM7iAim0TL0Ij9VSHYlO9nZEvhGb7kYxyLUZeLu9kPC0aQAJcaC/JPUm322xiq/bRdMzSbnpAgYqYHREBz+kFrvjelo+LvVWSD2IIk3b9HlYE0jzj8bBcyDT6XRtjv13+3q7Vwf0G3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NV5KHMa91ytPkFWV8Phit+K6SI36of/L0YBVKeZbhg=;
 b=RIwNqzydR9wjO/v6HTcqfR9xNzyES3wuMTZJa0Ig3Nhgfo17MuyJToKMVQzSNxhVuOM0Mov61FuRln8t0byJRa565Bn/L1prTGi1TPLDGLffMotQhNuPIW9X5qpP2euv1cNa3wLuffk7DgzTZUj6sGup59OpB3MMrz2fb/cJBx4nYLmmvUlVyLiUuVrBOI3MsDsOKpaGWOwc7FzhRkmRlQu8v3uS9g6mjs4oeG1VmlAEo6k78k2SEyEoBEOrcLlB1sRJQ8VZsOqlJnLO9psHOL31hkCxdF2jh2FBbdUKLwv+hqIsYaVdcVU2lyiPTkmaOdR3yMltMmHUnOaj7bf7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NV5KHMa91ytPkFWV8Phit+K6SI36of/L0YBVKeZbhg=;
 b=P5YoVCm8M8L1StmPeN2wp8Kcq8Kaz2I9LCyj5s6qf8Ht7eYHUWMwsmG02Aj1+7ARNMAYnrSBlCvSe9uGmVR3qs6lhkT+f361mRWEeAFRQ5kV+16+jsn24iAlKwwwnAd2HP6ecEuXU+oTzTCmqdI47AwEtMcSxCiJaQ1CxFfUuNF+lOnJ2sSjvzpkMVnDfnAHpUAP5fYu94x0ZZhCucONcOl8WiRWhNnjod5cvkiGFzNAo5nUH2sVzdwYZ1+oevzyvPLKzs0HgW03cLGMK1cg+Tpkvd1PRS9ou6u4mtdoCcqlToPG0K1GnkqUm4vL7y84xre7IXMVuYuAMiUVtOUt4A==
Received: from DB8PR06CA0058.eurprd06.prod.outlook.com (2603:10a6:10:120::32)
 by AS8PR10MB6892.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 06:02:52 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::ea) by DB8PR06CA0058.outlook.office365.com
 (2603:10a6:10:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 06:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 06:02:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 08:05:46 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 30 Mar
 2026 08:02:50 +0200
Message-ID: <48310ec7-490b-42d9-b3dd-46084a3a7efb@foss.st.com>
Date: Mon, 30 Mar 2026 08:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: stm32-ospi: Fix DMA channel leak on
 stm32_ospi_dma_setup() failure
To: Felix Gu <ustc.gu@gmail.com>, Mark Brown <broonie@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260329-stm32-ospi-v1-0-142122466412@gmail.com>
 <20260329-stm32-ospi-v1-2-142122466412@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260329-stm32-ospi-v1-2-142122466412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AS8PR10MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fa7b63-f492-441a-fb78-08de8e21fa4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HniyeHbHKUgJXGQpCM78AjVt6WGu4OBmXIFdv3fxLP+Hczam6/stXejVbevMkJp4UFiJMT3cSR3QSypjOXtieheHQ5+ueampsH0xQQbw+rzbQ26bBbH9uJYzMuUtWVAotOa+21ahJwA5GEoNcIjZ3NsNMs+kEazLzjI4NFtQ4l99o8DnTeCxNno7F1ooNzqYvvUZT7//6zlKkgWiA9X2rLO233uHlMoDil5pfzZ0rbm1FMFFbvthdi968+qYLbj8/HApxSVa2rVJnFYz0pY5xedmBlKNq6OEydxBR5FZB7Y9gr4VObE1dhpxRJ0R8xvx9X7ftwZVwTFVA+bvxjKSzafvPgxt4MbX/0rq8qkgxrQ2zvuz7sEAVfmikw+edt9tQgt2dubzmzQgA10mc7IokLj3n9IXa4NIFQNjsDW1c7YUExCtEc+wb+O6pbEiedGhxNXcFfl+zWt/zdHxzyRIGFmJglCeQwwpir9/jPt61Ts+aUPre/NttlwNA+X88Fn56QSeDFNhUdXjy7DNRodi4AbYCGGJB3/TJyBboqi4/PJ8sLevRYzos3wcnvEzJ/h6LxbKO8ll/ivGPAguDGWppcVAmhYJDcTjDbC1+ndKDnD6A94ju8lWR1Us6sEyAY23+cs2JrxZTatyKAXq/e3gA1GH1ZsQIOIREmB7SxbGeeqvDcDAtSFJ/Rjq1fWhyF3tfegwL8ZYgH+65bsGv+mrBz/h2jEZ5YacFZwOf1Ejz2G7PeJPY38dkOUs4C8lkRNBM/+7iDQJbqpEJQ2REinCnA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cSCiCcOJ7cmwVF0FpkYPd/1jcWHd+9YW6OaVACi8XxRf6arJENQa/qmhDjnf8XMnQ+EvA+aYzSWN0Y5YIgo++ADMyUnBj7zpTj6/i4SxTYk+XSgOq3gPsqo2klFTR+krX/+KXkledzzSH5geBkRWRKk+QzaZyqyiFexjgGXMMvxA2hhiEbzpUz9Sy3f3eYeZHR/C+HAiPblsqIQbblMl+M1/xcq8evq8wmyngM2XXbEkRbrbjKHwJdCsWEO6EVU+9QXtlfmOdQMNIpWIghN9ODQfq7jMeGt0B4h2b9uQLgDHJsSCNM9Ybcq7iu7CR0dOhHmo+uLdcJZdtuXxoKC7iA+nv3+QkMkcvCJlV823b9i4pLnGlaiFGZx5PIBcHt7AoXefI9xwPiEErEpawGKCLwzA2Foltv6Pw/GK/cm3t0G+wzuP/pEHjJ793zbGd3P4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 06:02:51.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa7b63-f492-441a-fb78-08de8e21fa4e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6892



On 3/28/26 17:07, Felix Gu wrote:
> When stm32_ospi_dma_setup() fails, the DMA channels allocated by
> stm32_ospi_get_resources() were never released. Add proper cleanup
> in the error path.
> 
> Fixes: e35a7607e05d ("spi: stm32-ospi: Set DMA maxburst dynamically")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/spi/spi-stm32-ospi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
> index 52997c3f7174..34498939bcdf 100644
> --- a/drivers/spi/spi-stm32-ospi.c
> +++ b/drivers/spi/spi-stm32-ospi.c
> @@ -923,7 +923,7 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  	dma_cfg.dst_addr = ospi->regs_phys_base + OSPI_DR;
>  	ret = stm32_ospi_dma_setup(ospi, &dma_cfg);
>  	if (ret)
> -		return ret;
> +		goto err_dma_free;
>  
>  	mutex_init(&ospi->lock);
>  
> @@ -975,6 +975,7 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>  err_pm_enable:
>  	pm_runtime_force_suspend(ospi->dev);
>  	mutex_destroy(&ospi->lock);
> +err_dma_free:
>  	if (ospi->dma_chtx)
>  		dma_release_channel(ospi->dma_chtx);
>  	if (ospi->dma_chrx)
> 

Hi Felix

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
