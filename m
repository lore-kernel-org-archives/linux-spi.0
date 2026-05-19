Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE473F075E;
	Tue, 19 May 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182134; cv=fail; b=nwtlA1XSnaLneZWumbwdZlKjBPvEbwoeK6yznfhwpKe9E4i4jh6yhaTQ9C+Dnbc57Op2BlULWDJyfXwQnuxVzK1BUYCWQK3Yc6sXgYm4381EGuVzB3O0e/uNrImC8PFFuNEZXzktDOLBWnfmfjSV9q08CFJdWHNNTPPyeBOg6uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182134; c=relaxed/simple;
	bh=R6/zyMJNn8TdynI28M6iLpLT0SuRXmILadO2N88KEPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OX66syGmhRw8H0erILGmSS567ZD7k3zGrhC1ngszEVVVmP/WEfkfSOh4Ty34aDmxyrayA3baiFGa9FXajQM+GKbVb2ZdWmFTrKgGQkqojrHsKUFZOFxlZFwFJiZuKbsnvQPktNMYbMVQqRvwYLR/nRQh9a1dioUicdZj9n635dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxFRbHLv; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxFRbHLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlGMcmwGxgBr86JK5sFf+1odm4CVbZdI24+C6MYY5nyUaRQGNIZkUVnxJHUY1oEgegDZ+6Nqug24bDJYjrapMdO0LPY/kX64uoJWK+jGWQQvtGn7Co/FXjxBg+0s6ppFYePa5JT5EzIBbYQDDCFrxPoKKPbtsE9LSyA8AQpAwUqb3bJUTe3H52QyJV71e2w7eZ8h5AO4gU8jQQCQ4Z1Eq5r5Iw7sJMNXOZkcacGSh/sjBDj/4UE6hLM2qbhXLvD+Wq62jUo/D479eFm9D8aYo+FKFu/X65QzQf9GMj9r2AeVN0Q4IHQ9F/l5TqNwL8bHI+Em2h/+p45Ul5VNUVMpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ/ZjIkIjbNBT50jtmTaSca+ENNsYaQwmhj9CqHoOos=;
 b=MeVNgZTTQC7fleA1CDPPEoE805ZaSJSW4lM5J3hi3cC5Py5p1XRV8cHKwBcx2CtrTHpyR5s+iKas24WXJxJurPNspdddhEkAs0fWGmELvWAMdSnzDZS1NS9kTFSweU/RkAhar6lfJ0JgU9uGxbVcEHRotPNNWo729gLcfNJ/VxNvDcN7Pjo2XH1+MfMYrrAPpc3UTRpijsTHN6s74PrkUXBRp+JkTeeQr+WXm4WtxdQQzhK6PEmMUMzpZ2fFUQZjorWPI5zjycoeIAKJ3TQ5Ad3ZMtLYtpcu0oXXlq93yIaRWgveFB95TLYbpbzy06n8KKS4apiKdM5N0hEfYb6ilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ/ZjIkIjbNBT50jtmTaSca+ENNsYaQwmhj9CqHoOos=;
 b=ZxFRbHLvlsNdNuXof2mdBzIGkve0CIC/rem0N+sT2CYsbib342WEqBaZVqw5SvBHj3ieAXsS/hVDpTsvt+vr18VFZc3bIyKwWr/TEi4VeRtcqj2n+G/XdfFYlRa5Nhbcqql9Cao3vUyxpHlz28OSyhp7Dz75z42jfAwNI931ZuAFe+sComZHYN62enBNncMT8gwO8271ISFsNgYdzLE7Vg+5V8Pxjc1B3X8NDyKYw9YleAHk940uXywOCd6fXkDcwHlmwUbuJ0tY5cv1vWUAnsMqGJcZA5u5MfSs6WW8KIKF5a+wejjEz2giIIW6ALW8sw6kZ9Qal91MzC770SfrPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 09:15:29 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 09:15:29 +0000
Message-ID: <d058322b-1239-4429-97eb-ab49002881d7@nvidia.com>
Date: Tue, 19 May 2026 10:15:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
To: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mark Brown <broonie@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260518160739.3286438-1-va@nvidia.com>
 <20260518160739.3286438-2-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260518160739.3286438-2-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ed022c-0638-43fc-95f3-08deb5872b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	9iptZR/0yHPab/T0+9A/awQSy+JxR7oSGeii5n1K/9i7boLmXMjSMF86DiP2D2fc0XNc7y2LhiSAFfWURHo4LShofB1VUhftWDx0Ck48lD5XuyaWCyHD+fEtGmhnSb0R0FYB79Cz5EdlfbR+yYijYrwOOimfRXQi3DtCMNiA3VkBWSQeHFII8y190xBRnWXwHVKSiMQG8RlX2yB4Hq1/ED7bcoFTH9w89cQPGCBLBbY5rrIB/CeI5QjQuEts8+On2MYzKaOqEm+BYzDu2xbjVjG6fgrmceZDuWDAAjrQ27SwC0rtfKZVl6+j1UKX2WXJBmPtCYxvH/PrPKqikHUYHV4U+rK9n24Jlj9rCvhdJ590oAPAsl7eqTjMGVdfKgwQnFiTbRPM+FNpsg8Q6NJh8jOPxF9IHjf5+avnK2xlLdzO8RUXpq4fTh16DTdlfVO1/2+3wFWHgCFiKMd4/rmiqo702dLmAT8rmPbgY4hOKk6ECJlDccVU/z5jUqHoGFm77bhGp+VVo+IBi/vp0Fykrcy+pNryoab2a6gVYnVFks7WlNXosXbWgEZTMR2Z4S8Rq91vSHAnIVIbx8KhYuEMi9FsneHO0zKvjwoiV4w4gfQsdw5w0Ne+7qGODr/2XmFpPJDabIAzWVlesL03EPMPp34xnPqftp9YCsRL4By5d+XTb5aWkgJ1LIk7hQPLUAKX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzV2cHRtb2daMWQ4ZWY3cEhIOWg3NHNLaHhBR3hSZW05TmNua1dsNGtGQ2d6?=
 =?utf-8?B?dlpnRC9TdzRoQWFIRHd2OTlPalRDSlZ2RHYvRDg2V0VXU3BydG5reVo1QXd0?=
 =?utf-8?B?TmZrN0VhU3JTcmY0cm11U0xrdk9MQ0ZCMUtDUHQxT3oyMjVMdGhSRG5kZnRi?=
 =?utf-8?B?bUluOEpwWElLbW5MZkxWU2N1cG9uZ0FFVzExckNVRUs5OU1EUXM1NHFRYVhG?=
 =?utf-8?B?NUpzbW9TY0lPa0kwcWM1aXVldTZ2UEk4NlNTc2s5T1Z5VDg4STNGRUtVZ0xX?=
 =?utf-8?B?aWMrNU90d2FsSTc3YWFKN2pyYmI4WXBPREN4VkQ3WmdUNktaM2gzVy9jSW8y?=
 =?utf-8?B?SWl2anR2ZzhzQmdQNDBqd2tmMC9kMXRRWnJhSlE5Y290c2RRNEx3MEVxV01F?=
 =?utf-8?B?ZzBaYnVYK3NXT1dLTk9qZUVtMWViQlU3bHlLblpTOVhkTzZzdTU5NXI2OFFr?=
 =?utf-8?B?SDc3aytSaUhGMnY5b3NjVWw5d3VyT1BEemVZVklGLzQ2Ym8zMHFoNlM5cEZz?=
 =?utf-8?B?T0JuTzVhUWlsUWhub1h6YVk2Z1ltb3NXUlRZUWlORTJHeVdIczdzcUVzMDcw?=
 =?utf-8?B?dVVKeTN6ZFlvRFdKMXpwMHY5eitzdW9JS09wN1NZR3Jic0hJdGZ0THNqK2o2?=
 =?utf-8?B?ellseXlDZkl2U2tvSW1oemJLRVB3WFduZndGcEZSNkplWXpKT1Y4WlorV0JJ?=
 =?utf-8?B?a3E2SHlPa2Vyd3BsSVRMa2pKUVllZ3QzYTVBQ0JONy9kazlVejBkd21Jekdp?=
 =?utf-8?B?V2JQOWNkR05YdHFXTWFtQ3VNRW9pS0QxbHl0eGdzK2p3eDhRQmZHTkN1YUU3?=
 =?utf-8?B?akovcmIxT0lvZ0pCTE96eEd2aU9aVFhZSEVSVE1wZGdnbmh1VDMzQ0dNaWY2?=
 =?utf-8?B?STc0ZUhxd1ZObU40U3oyV2xwYmlaQmIrNlBHNnY0d1hjSklRSWpYdXJQZWZT?=
 =?utf-8?B?ZGVIWkx2QmlWV2JkQUZuOVdoMjBWbytsNjZaRnVpVkU1emI4RGkxOWFEblZP?=
 =?utf-8?B?REdqMUEwa1NVbXhrK2JjZTVqS2gyN1VpWVR6ajlWNVFySFRZR0hYUGJTWGQ2?=
 =?utf-8?B?b1B1QnRLM1ZmWDhiQndXaEIxdFpFM2JqZ1BXZHhLaXJiQURQM01JdWhvQldJ?=
 =?utf-8?B?TDV0bEdCMlhPcHZMeGpFQTlHcitCSmdVbVQrMXd4emVjN05tZHJiT0plZUo2?=
 =?utf-8?B?eWI2UVI4WFUrcC80YjBkSGx4cEUvSmZxNGJtN0doNS85M0tuSEorUWVlTDNn?=
 =?utf-8?B?L09sT1hpS01SZEtNVFdPQ2FpNk5oN1FKdDgrTmYzN2hHMFVQUWpqUFk5b3U3?=
 =?utf-8?B?UnNkUEE3UEF6QTZkSDJJQTJTTDF3RFRLZmdqQmpjYXE5Z3ZDSFRmQlZ6VG9k?=
 =?utf-8?B?Wk9iZ0ZCTUdCUHhLaE54dlVNWHU0TUlSeUh0UCtSQlR1NG52SkFiLzdCVVlk?=
 =?utf-8?B?eUIwb0NvaG1Hekt3eHB1UUtGbk5Pd085Yjd4Vng4UVkzMHB5QjJRVXphSmtF?=
 =?utf-8?B?enNGcGpPbU05SEJXb1g0M1F3RjZ2ZUNLQWNEalpENWJHcjg5cU9kdTkrWnhG?=
 =?utf-8?B?REhoaGVWRFpOSS9YWXV0MExHQi9WbENjYzJPWmU0cDA4dU1icGU0MmxyZ3gr?=
 =?utf-8?B?QWt4N1R1a0ExcytoVkorT01qc2VkODhVVEpaYkFjUVk0TkxMaXNXRVQ4Vjk5?=
 =?utf-8?B?QXAwb0RmK0NpbExYUkJ4VDhQU3NEYUY5bkcreU5oczNJOG54a1NCdkJxY0hy?=
 =?utf-8?B?RC9CeFpZdkNBdThINnFXTEYyY0R5SXhVVzFXekUxUjBuY2lSdTBDdnFNM2pM?=
 =?utf-8?B?bE91d3phRDNBSjU3VHNPd0JzNU5CMVF5L0tGVHVOalBDMlFSelNqcC9iU1Fi?=
 =?utf-8?B?VVNaSlZ1cG5ibnNBcmVhbVZtejIxQ2xyelNRY2xqTS9iU3VERm9UMUZXNldl?=
 =?utf-8?B?ektuK0pMQmdEN2ZaOERMRG9CckszTmY4ZXpkeldsOTIxZ2RaSjlpdVNadFhi?=
 =?utf-8?B?Z0svK1F2SHZ5dFF6WE96TU92VSsrUmFCUmRnanllR2tWSUdKaDFaV1EvcVlr?=
 =?utf-8?B?Nk9NZURBTk5ncUdnNlh0UlhEOFRESVJEenJyK1djeGliQ3V1dkdOT1RyZFJD?=
 =?utf-8?B?Q2swbDNVMEhGN211b1l1VmFGKy82UllrdlF0N1NZK2dTbjZpbTk1dkJiQWdQ?=
 =?utf-8?B?bWJhaFRTT1B0ZDc4RVpzeEhVK1ZHbmxGbjVOc0o4TkpXMUx2NHFaV1Y0NkdR?=
 =?utf-8?B?R04rbHJXdGllZkZoSGt5N3R3aUM4WVpNTjhsdU9LZldoeGdYYnIxQkhVTGxq?=
 =?utf-8?B?TXBBY3ZtM3BZM0JYME9hZ0VrOEkyZzZyS09ndWRKeUNzejJORlJoUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ed022c-0638-43fc-95f3-08deb5872b93
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:15:29.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkqNi/ETNIeREDbfkA4B/JXd/aucOdx0z/0+zj9njRMYaCetMHG/fnAzrULhUTXW/guAjvH67UPX8DE+qjCxTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452



On 18/05/2026 17:07, Vishwaroop A wrote:
> Threaded IRQ handlers suffer from scheduler latency on heavily loaded
> systems, causing false transfer timeouts. Convert to hard IRQ handler
> that schedules work on a high-priority unbound workqueue.
> 
> The hard IRQ handler verifies the interrupt, caches FIFO status,
> clears and masks interrupts, then schedules bottom-half processing.
> The workqueue handler runs in process context (can sleep for DMA)
> and can execute on any CPU, avoiding CPU0 bottlenecks.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 120 ++++++++++++++++++++++----------
>   1 file changed, 83 insertions(+), 37 deletions(-)

...

>   static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
> @@ -1793,12 +1826,21 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   
>   	pm_runtime_put_autosuspend(&pdev->dev);
>   
> -	ret = request_threaded_irq(tqspi->irq, NULL,
> -				   tegra_qspi_isr_thread, IRQF_ONESHOT,
> -				   dev_name(&pdev->dev), tqspi);
> +	tqspi->wq = alloc_workqueue("%s", WQ_HIGHPRI | WQ_UNBOUND, 0,
> +				    dev_name(&pdev->dev));

Why not used devm_alloc_workqueue() here?

> +	if (!tqspi->wq) {
> +		dev_err(&pdev->dev, "failed to allocate workqueue\n");
> +		ret = -ENOMEM;
> +		goto exit_pm_disable;
> +	}
> +
> +	INIT_WORK(&tqspi->irq_work, tegra_qspi_work_handler);
> +
> +	ret = request_irq(tqspi->irq, tegra_qspi_isr, IRQF_SHARED,
> +			  dev_name(&pdev->dev), tqspi);

And use devm_request_irq() here?

>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", tqspi->irq, ret);
> -		goto exit_pm_disable;
> +		goto exit_destroy_wq;
>   	}
>   
>   	ret = spi_register_controller(host);
> @@ -1810,7 +1852,9 @@ static int tegra_qspi_probe(struct platform_device *pdev)
>   	return 0;
>   
>   exit_free_irq:
> -	free_irq(qspi_irq, tqspi);
> +	free_irq(tqspi->irq, tqspi);
> +exit_destroy_wq:
> +	destroy_workqueue(tqspi->wq);
>   exit_pm_disable:
>   	pm_runtime_dont_use_autosuspend(&pdev->dev);
>   	pm_runtime_force_suspend(&pdev->dev);
> @@ -1825,6 +1869,8 @@ static void tegra_qspi_remove(struct platform_device *pdev)
>   
>   	spi_unregister_controller(host);
>   	free_irq(tqspi->irq, tqspi);
> +	flush_workqueue(tqspi->wq);
> +	destroy_workqueue(tqspi->wq);
>   	pm_runtime_dont_use_autosuspend(&pdev->dev);
>   	pm_runtime_force_suspend(&pdev->dev);
>   	tegra_qspi_deinit_dma(tqspi);

Jon

-- 
nvpublic

