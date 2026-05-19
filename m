Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747F3EF0D2;
	Tue, 19 May 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182891; cv=fail; b=AyjYZAOepdW9z+cbZvrZr+xyPAR8VjScy0EBbfalq7Oay37CvVGXu2Jc3HzQKbOIV8FEMvIdOQD/TM4gppXYvoHX38nrf80ho1CMlyJFUuRkjnTmaxVzbCuxICbjNUaR+YzcvGowaumdQYm3yyYoTTGjw3G0BCcGzJZRWkQqfQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182891; c=relaxed/simple;
	bh=fj2EhRW6Fmyh7dqO2Dy6Khq9kjKdE/yjiwKIqBnEOks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H6ZnltCeT+wbZWmUIcu1Ohg7FnAq98HIvDESo4bjF45okrak8AditkB90P4ekPl5eHqAxKH9p2e2GRzitTkatnpA5LCydHuKxs97VozKsB7N07FIEkfM87ZYvv0UEOyGnACkD1CvfmIm6EQSHYkoh8nGpRflrQ1k4BxFjP8jT/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YY0LgWq6; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YY0LgWq6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ldr1ncWUIchUVhYLpCEJ9RrokMdJbhPj21E+3OTPyIMRYidithDt+pt9o1XN2Dt0v4/AqA0L4OW0Qi7Z7IJWFYOCuYBsh9tQiiszPtU9uO34k0oWjkCulaHDCU5hMAEO+u0kU6YyCkalPuhX16YKONMUDkAtBQHhG1EbE10gQGUp9cd3tHui0T5K4kKSuwOhbS4DRVglDZzPbJSLqzKIqw1vna4+Fncz43On0Uprn4+7inlOpVxVhKL02MreSGZz+jngrzCfpUV8DIYo9N/tGJQlNZzuleoEjYaIA7vonQuyBq73eLNY/4zHlaN5aojgGYRJp0GTSUp+kg8cikDOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK0fft+kkin104BKDsMadqps9O5vWMWcMA4nKgQ2ZKE=;
 b=XHL57na48/Ci0mnFS9ne9q1MG6FROFcJtX+GOypPE7dxTIAi63pWRAPDZ5ZpA4jhdqwVAAKAe1fZHHH/ww8qc0hIpyjDOsbUTzFj+bouEdl2TqbdYM37zAYwCT8bOYWcZpQbZQkW3df5lnAwSCWMitCPHQOum9W9KHeHcAt0Evj1duc0l4i/JzmbFTFdNFQc7QhfEbPLyaMDR8xwN1A/MdxKCcJ1qS5DN+glHSkIWRPAznJvE8ZlaQqYs15tALNJzKmQykEv+ZnDzOy7r7HdGPJFcCPoj15XPuC2UFaNH8k75UCHk2xdiYA3Ez14xGNYo5AHQfFkmAo6h8XXtKnqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK0fft+kkin104BKDsMadqps9O5vWMWcMA4nKgQ2ZKE=;
 b=YY0LgWq6Rbbn946n5fiEBdAPFaX2XG/il/Z+HqleOxdR6pahY5J9bB3rV5LD2KL8rG5tHnSiQ+8LzUtuPIQSOQSTp19P6gfLWijTkdnndHn3i7zD5LtkjUmo9VVgszHhwyBaMN/VSPoo/al3V7hnMJFL7g6lYYSDCzNFGmSbhbp6DeUwGKNBQhPaxFSPAGCwaRnYUR11Vbr+9kFXMLsB+/CllTlgm9+VBBoPXsX63Ou2qmLeRh7DTWsaNPsKeDVOkKgUuXoQLabeoSvphrOBbAGq/i8cY65BduHFS4h5KT5CgF5jYrIIoF0tzhkcGZwBrYXqnqSG5ogREoecWe9DiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 09:28:01 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 09:28:01 +0000
Message-ID: <afa3819e-cf0d-478e-8813-ee1aa1b2156e@nvidia.com>
Date: Tue, 19 May 2026 10:27:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for
 timeout handler
To: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260518160739.3286438-1-va@nvidia.com>
 <20260518160739.3286438-3-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260518160739.3286438-3-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0263.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::16) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7bf005-45a9-423f-a643-08deb588ebb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	O4XMuGLdxDI6sy09sOY+zEg6Zw4ac08ZUDjHS8FvVO8jkqStzB5P8COvmrlOEzxDvR14oLailOYR61lz/qPBoC8wkGzERzSb8LXEFOW3axh9sIaI4nMNYwgIigNFUcJSNb86UrQkNXWvLnJ/QHc3VfYowUCNrtz7OZBcYG9TEyR3VmFVrCJ5YWLHgLw9xKEn0LCAcCajWQA6d5vWVE2x5D7za6ik03hmlfIzFOHL23l+sPyPPWHpktSazZmuG7X3FyqvqQ+ZyxRmvZNW+61ODcv8jveYMXF5WamwvWb/M480DH06mv+C3V8BROMZs/OqJw/F5FOWN3wGjsyzLJKHohhnDu9qba5ciotKfNtv38bNys9dH8AvgZBGWA7UZVt38556npS/WHI3my5FS335xY6Fhww44sXyOX8ngGDw28IDXGS56O30mIkImjKF4ew4L6ysuwk3FaTvsldo0JlY4wNSA5r1B875ikSHfuX8YOgvYqNKsJ45sp/qTDJoJ2MRWmuoleeB1u6WqOpFU07hE6CW7sQpxsN+O3F0Pbiwevh3MKToBbFm5XtNQQPJGd78yg0iIaxjE5enC9yOtjSO4GFG2DTN3T6RkU5VudLJqI0duOR4GROj/5qx9JoUz9Ksqr+cK7C4r5oHSbU7KrSfZgUN6CgfuFMVkWkWFuD+jTQY3T2RWypg3rtzGcJutf/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVNM25SRkJxNURxRkZlemNqY1A3cjd1amNyRnRmNU1rRUU3dnZTczFDUXlp?=
 =?utf-8?B?a2pLU2JXVzV4M3ZzUGljWkxtZU41QXZLQkJ4TGQ3WnY2d1g2KzViWi8xZUZ5?=
 =?utf-8?B?d1ZUdXl4K2RPMjl6L2o0dWtjb1NKN1c4YTdwb0dGUjNUV2hPNTFJOERadHRE?=
 =?utf-8?B?Y2xvbWdOVUhyaStWajVWWU9GNGJRRDBHZlBraHJoakZyYXJoUmxYWDB4VEl1?=
 =?utf-8?B?RXUvbUgzcWxlWm13R1FYb1E4V0dWK2w5OEtlK0kxMUxSTVREd0thNDFRWEpo?=
 =?utf-8?B?NEtKRmo5a2pncDMrODQ1QkwySTNjZWgrSE5YbjBRTS94cVhIS3BXeGJ4bkZU?=
 =?utf-8?B?MW5kYmVvQy9MNC8xb05SSVBpSnZGS25FaEcwbFI1aE1uZk9UZ1NaeHZ5YSsy?=
 =?utf-8?B?blpiQmJzM3VTRHBMT0dLMmlyS09hZll4M0QxQUh6ZjJnNlVIcHgyZjRFT0VE?=
 =?utf-8?B?bkFxWkNWWWl3dFVua3I5czB0UDhONnQveWw4WFpmemdUSDJubTNDK2x1SW90?=
 =?utf-8?B?elNSVjdVeUFlM0NYb2xTVm9qbUhSelZMMkRmWFN6ZzN1N3hHN2hSQ2twS1Bt?=
 =?utf-8?B?ZklZRXBDTnFDTmh0ZkdySXFIRVl2YnNVNFZjSUozYjZSZEpSb1FkN2YrWmJ5?=
 =?utf-8?B?cUVVbXBOL1lpb1BldkhncjEwdGZUNFZKNHgxQ2FkR21icnpIZDdrWWJFOE1v?=
 =?utf-8?B?bUVmL202aWJrc1VCeWVLZUloeXpERmR4MUxsdHpURDN4UHBJL2hzV0VZMkpW?=
 =?utf-8?B?aUF6c2pBc3Y2ZXNDLzFxeCtmRk42M0UyMmx1TGlMeHZickNHdTFQNDRCbCtu?=
 =?utf-8?B?dm4wdCtPWXRib2JGOWREcVJYcHU3Uk5yWTBxMWZGc25QRHUvQ0lYcTd3c01y?=
 =?utf-8?B?WktGNVJxQ3NuNk9PYmtZUDYwYUFUYlgvNisrVjEycUw4blBrYm15bVloQXBi?=
 =?utf-8?B?NnhDdDJCbnJZZHVuUzlzbzgxN3lqOG1FYi9LS21qbC8vYzRFL1VSLzZKSElR?=
 =?utf-8?B?VUdhcUtsb204RVBlNUJORDFNNmx3d1YrMTZLSVM5em93VEx3a2JTVVJ4YXhU?=
 =?utf-8?B?bnRyVWxKUjBCT1lueUkrdWZwMTNlRHgrKzBCMk9QaUxzRVlSUXNsaDcwZklh?=
 =?utf-8?B?VGw4WW5EUUVKUzZCRUdXZndIYjJpajJiOCtZd1hCcmtTS2l4SFB5Q3RHK09u?=
 =?utf-8?B?WWM3bWc1YTVFcDYvU2kyU1MxdnNxRkNxWnlDWlpiUVR1SVNDQ3gyZjVUQjlW?=
 =?utf-8?B?b2RQSnY0a1FFVlNlejlVd0k4cFE1SkxBOHRSZDVucHRVQjJNVDJ6alNvK1ZZ?=
 =?utf-8?B?c1NFZkhSVWVoN29uYmpNd2JwTkNYR1d5TXJsSE9kNisrYzlrWk1jZk9KazVG?=
 =?utf-8?B?a2I3TW9ieWRuRFpaaVVxZ3hnczhRS0VEVUVwN3BKc1U1MHBKOWE2bXNQcjVF?=
 =?utf-8?B?Yk5sY2p5NjBGcGw0cFdwUXhLUXZ1ZC9sdGF1aFhCWG5XZVFtVUJnODUxZUNM?=
 =?utf-8?B?Q1Z3aXd6VUlHWStLZ3ZpOEFkRXFYNEJCNUIwVzlIcXFTclFwTnhpVVR4eDFJ?=
 =?utf-8?B?UFFBN2g5cDgzQ2JORW9RZERzenRrTlV3L2hNay9Ja3psdzRMbkhTMmNodlFv?=
 =?utf-8?B?QnNKMkR1QkpvalM0TjMweFhXeGVYUmtEOTg0R2VzSEF2d2UwV2dKdlE5Yktj?=
 =?utf-8?B?RXVPN0ZRVWFEdHl4M3VvZ1U1UGVXSC9EUFZkODZtNFBUcTc4QmRVeXFqdDNO?=
 =?utf-8?B?VXhxbm1iV2hEREJuTVRnbWdoZU1xOFdrb00zRFZhQ1lEc0lNSkM5UzFsc1NQ?=
 =?utf-8?B?NzdRTFl4bFBjMUttUmdqQUlRdEh6Q09haGZ5VUM1T2hDbjA0WmFXWFpUZW9x?=
 =?utf-8?B?cWk4S0Z1VlBFME94bVJQOG1yazBhRG5KaW9Ga0lGNDZITE50eWdVcVV1bDVk?=
 =?utf-8?B?RHBBVjN3OG50ZlVMelBUVVNTU0dvUUZVREcwQ2dlRkRMd0xXblE4dVBMQWto?=
 =?utf-8?B?WEYybWJNN3VOK0xxSE9SNGZ0aUlCZFRRSFpTVVV2eVhzdTVUekd3U0ZJMU1P?=
 =?utf-8?B?cFZPTmt4TXF6R2xhS21tQ3dYTldDclh1MmVwVEEzdlVVczl0ck9IYnVxQlI0?=
 =?utf-8?B?dEJZbzhZcHlmVTE0eGFWQTNETnlYcUwyTVlXU1RLdFdGYi9zSFNXbzdUaTdj?=
 =?utf-8?B?RmNqMk03dmN3VHdnTzFPb1pFc3NHenRhUDZkQnF3SDNMSTJ4MFVLQ0dKMGQy?=
 =?utf-8?B?QjZQWHVFZHFsODRkeEpLRGZqV0VSZDNzcmdZS3hacE0ya0pldmIrMW81NEND?=
 =?utf-8?B?Rjh6WDhpVmNtbVQvNEduck1BdEQwV3c2dVJFZkI5eVc5blpUWnhYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7bf005-45a9-423f-a643-08deb588ebb9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:28:00.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3B0F6uSieep8gK/cC00MWqpPoH/MdykebPjRndpWBLyJi6LZ3PdNP/Gxl2Ou+Z5a82/afGQrAXE9V070inHOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219



On 18/05/2026 17:07, Vishwaroop A wrote:
> On heavily loaded systems, workqueue scheduling delays can exceed the
> transfer timeout even though hardware completes the transfer in
> microseconds. The timeout handler cannot distinguish between a real
> hardware timeout and a delayed workqueue, causing false timeout errors.

Can you explain this better? Ie. exactly how does this occur?


> Cache QSPI_TRANS_STATUS in the ISR before clearing it, allowing the
> timeout handler to check if hardware completed (QSPI_RDY set) versus
> a real timeout (QSPI_RDY not set). This prevents false timeout errors
> when the hardware completes but the workqueue is delayed.

The workqueue was introduced in patch 1/3. Did this problem already 
exist with the threaded IRQ?

> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 42 ++++++++++++++++++++-------------
>   1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index a551c7a7f6c4..6148267a51cd 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -214,6 +214,7 @@ struct tegra_qspi {
>   	u32					tx_status;
>   	u32					rx_status;
>   	u32					status_reg;
> +	u32					trans_status;
>   	bool					is_packed;
>   	bool					use_dma;
>   
> @@ -854,6 +855,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
>   	tqspi->cur_rx_pos = 0;
>   	tqspi->cur_tx_pos = 0;
>   	tqspi->curr_xfer = t;
> +	tqspi->trans_status = 0;
>   	spin_unlock_irqrestore(&tqspi->lock, flags);
>   
>   	if (is_first_of_msg) {
> @@ -1068,26 +1070,32 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
>    */
>   static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
>   {
> +	unsigned long flags;
>   	irqreturn_t ret;
> -	u32 status;
> +	u32 trans_status;

This variable is only used once and so seem unnecessary to have a local 
variable for this.

>   
> -	/* Check if hardware actually completed the transfer */
> -	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> -	if (!(status & QSPI_RDY))
> +	spin_lock_irqsave(&tqspi->lock, flags);
> +
> +	trans_status = tqspi->trans_status;
> +	if (!(trans_status & QSPI_RDY)) {
> +		spin_unlock_irqrestore(&tqspi->lock, flags);
>   		return -ETIMEDOUT;
> +	}
>   
>   	/*
> -	 * Hardware completed but interrupt was lost/delayed. Manually
> -	 * process the completion by calling the appropriate handler.
> +	 * ISR or workqueue may have already completed the transfer
> +	 * and NULLed curr_xfer between the completion timeout and now.
>   	 */
> +	if (!tqspi->curr_xfer) {
> +		spin_unlock_irqrestore(&tqspi->lock, flags);
> +		return 0;
> +	}
> +
> +	spin_unlock_irqrestore(&tqspi->lock, flags);
> +
>   	dev_warn_ratelimited(tqspi->dev,
>   			     "QSPI interrupt timeout, but transfer complete\n");
>   
> -	/* Clear the transfer status */
> -	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> -	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
> -
> -	/* Manually trigger completion handler */
>   	if (!tqspi->is_curr_dma_xfer)
>   		ret = handle_cpu_based_xfer(tqspi);
>   	else
> @@ -1227,9 +1235,9 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   
>   			if (ret == 0) {
>   				/*
> -				 * Check if hardware completed the transfer
> -				 * even though interrupt was lost or delayed.
> -				 * If so, process the completion and continue.
> +				 * Check if hardware completed the transfer even though
> +				 * workqueue was delayed. If so, process completion and
> +				 * continue.

Shouldn't this part be part of patch 1/3 because the introduced the 
workqueue?

>   				 */
>   				ret = tegra_qspi_handle_timeout(tqspi);
>   				if (ret < 0) {
> @@ -1346,8 +1354,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   		if (ret == 0) {
>   			/*
>   			 * Check if hardware completed the transfer even though
> -			 * interrupt was lost or delayed. If so, process the
> -			 * completion and continue.
> +			 * workqueue was delayed. If so, process completion and
> +			 * continue.

Same here.

>   			 */
>   			ret = tegra_qspi_handle_timeout(tqspi);
>   			if (ret < 0) {
> @@ -1642,6 +1650,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
>   	if (!(status & QSPI_RDY))
>   		return IRQ_NONE;
>   
> +	tqspi->trans_status = status;
> +
>   	spin_lock(&tqspi->lock);
>   	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
>   	tegra_qspi_mask_clear_irq(tqspi);

-- 
nvpublic

