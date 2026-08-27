Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD243CE45;
	Thu, 27 Aug 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843916; cv=fail; b=RFQy4FDSoEpbLaeXmvuhH1e/IEkCUs18M1wyIQR2FnxInwt8mEPo57fabTtJgtI3L/M944KtGWu70fiBQzKWQ7FY8kLQwwBD76VmwlPsgGMJjHD4RZP2l80ID3yYGrlyFNofV/TZCf8unjh/Gnc2kTqZX123r85iNc7XV9vSS64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843916; c=relaxed/simple;
	bh=MB5AGhz33PSMMThg8SCdHJUR5HgggTubOI36tlpLIOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJJswSY7lOa2Tz/Tyr/oYtfNluP3M2QgmsaoV2sVpyxnAwF5gHGOClMjNAdipLMry3pVD2pyVW1G7aE2wv3fMOYgVHN6PZjgVtoOTqHOjjiSSAOzgWfPLU1ssTMjsmKe4C9R8tPRWdYoJ9y9bMWTu+vyPSfQNPEkwvAnKROSdM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZQoLZED; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MZQoLZED"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7EHu6sE6WEqAQ/R6upw6ZZHrTW3HQjfYk96vjmXOObWQURZaoA7BVkrcOKSB9JOoqyvR50hp2gME1ZC5iMYRVPYqTYxggbtbhYc65M3fUcjuwulxx8i29pi/Uk7zk6acYwCIE+1hSLKrQVJnopy3etnqEEW95G54qKLLe5pZUTNwTEGIlYmRpXJeY/fGgWjPUw772A3z39dOuvlIdRnsFPswELEo/EMaZWwmU89qF3npeOAzhyzmojEiLM2cutrwJo45WnewtwUsAdr+Y6JQSwZpjfWt1vmNgtZJM64o5sAnygDlknhqQw3wljf8Dqpk6mu+2r4HlvEX/2KhHBW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AyXjWoeRRdFbzEumKfiTu3t4MpWSknUU8tFVCA2PjY=;
 b=bmIw1pVneFNPQ8BRpjDOZk0Q3Ftp21ucsyGKUldnH5qhUqi/L1QEIS65UTW+pWFYqleSBuw8hCf02zzppPQcJnT8+57sxTJbOS6hDoZt56N4lhA4OYc6AsWhhbak1VYQKTXr0aa4ptSEoXDCAuYcrlNmlZBPEClL/tOfeuC9tdiIhbQfSEmiuVRIBjIUNaCCcyhIxHhQEKxNJWTuV2yZ1Ij6JTosuJhhljzqVfE4D5WMuKBeHolKoGnGmb5GyC2/sOwJI9SAns1VKam07pbm3jGAgCfF8aeky5vNXx1CDtWslRfUywvZrg9jUVX6goE6D2uGVNjNgDWNl8CUVe8sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AyXjWoeRRdFbzEumKfiTu3t4MpWSknUU8tFVCA2PjY=;
 b=MZQoLZEDFV8MWz0mHYnO/fHV31kFRIWB0W4YnQRqNPklTMBQB7bYtbWWeHwNRT3tSQxhn5bqzq8ggk8j9SYSdDU/tr7PmyGEKWIrqFaQyNxV8wLU1mwi3NzQx8XwaIZmGqnw4HiN4m0xfQpe2sANi/pcD1NRdDuVRQoiNeOaCo2OfGrcbK6CCbeEDIcSom18Unw2XOSSu3Wmv8EiJRm1VxNaxWXSX9Cqw5XZJNOpMsQlhXRWiPrK4zm9kACghZ2vh0lOJ1POA+7oiFOKPuIWi40jAguWE2dP3NvLA6cD1XxDa5D+ztu56geDsHOmgUfhALnkAu5DyFzmZw6ze0Yujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:18:27 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 15:18:27 +0000
Message-ID: <420de339-53d2-40d9-b04a-a54428450830@nvidia.com>
Date: Thu, 27 Aug 2026 16:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] spi: tegra114: initialize native chip selects inactive
To: Abraham Zukor <abe@maticrobots.com>, Mark Brown <broonie@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260826000517.631736-1-abe@maticrobots.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260826000517.631736-1-abe@maticrobots.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b100f2-58ab-4fb1-10e9-08df044e7189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CFfUMD/KOkQn87DUWfVrVQSH8mgO2bdkjDWGTVYSrm+mpHq4yyfUcbPrfoOozZBPOCeUtc6fxRsmiSmCPLOYLZKsm1ETbhoPA2iMV2UBjng+oXmx3uAgoPFAYRthHRxTA1aoVkq7Bc/nOTpjgHMQN2g8wnHQMUgtOrWyEQICkGIRebSQyu4P13rty7+xqakGWVXv1FNtLMpl2EQ23SbJldjK9Ycdm3GpwJK2tlhXKU5TvmdJyWS08SN9jufN1CmysY16knb631pe+tu92QKpNtsdBogxs0FMxLMrN7PShIWoebwLyEYte9VvzjFvVyWnRXZLww8B7HtOhi0hqsVdLWJQny1RkA4u8GTRWJKqphEqUTuwoVOb2YhM6iShZbj9JattsB6UZiz0Zf00e+E+tCNRqGVQsclsltkeYe4xEi3IttBj9CbWArDl417h5gOdEaaojcSD9UY90n4LWXrkalf3PfmmC6y976OGxDGx89tl2bt3IU5/BcEyjIVuZbL1i9e7dGCillzsuAtXR+eic8+H+HE0Uisro2vIEmuCfXfEcIRQDQATCJkjpLB06Bp7ymsJO0Sm9V5SGAq3C6317+mFxADr0ojaIhvH2Gzv0AaIsIYO0O1odRcN7RqkY9VYZOMkVktKKleOyz9CboxUYWGYIs+b5Nk3SsNRx61J+h8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNteGc3UVBxcHNUWG0ydGRpMWxHcmkwT1NIcUo1S2huWkpuaEhPM2dzMUJq?=
 =?utf-8?B?SUFMRVA4S3NhOVpydnp3ZXk1V3RJRmUzMGRqTHFlaHREQVNEWFBkeWlYVWxj?=
 =?utf-8?B?QjdpV08xZDVvS3BOc3ZQeGhKVzhWWVIrN1pvcUtsamRMcVl6QTQxNkZTSG9h?=
 =?utf-8?B?WkVXc3Z0T3Q1MzFncm1EVVdmWWo4NGFFUjNiakx5blh5eVlpWG1vbjkxaSt2?=
 =?utf-8?B?aEVPUlM1cWZ3NklBeVNsdHpPazhENWZkMlhFM3BScU0wSmVZV0toYVVHT2pI?=
 =?utf-8?B?NG1tUllvVGJlZnZLcjB1YkNqd09FM0ZMZzkrYnlDTjhpMHJUM2VvbGdzL05w?=
 =?utf-8?B?Q0NFdnFXdGh0SjdHUjJ1dndVd3htcVZCdkJFdTcwZURReUppam1DMDBhN0lv?=
 =?utf-8?B?bm85N0xkeGRkWHJOMk5sL3FyZ1B1L1FKMlV2TnJHdXlyVExLdldCNmZUVHgy?=
 =?utf-8?B?b2wvZmsrbjIxdnREWlR4RTdWTVM2ZStRQjRKMXExeDhRc1hTWEdXR0FOdzNH?=
 =?utf-8?B?SDQ3emRzMXZicTYvK1pUV2llSkd1b3luUWcyRkRKOWcwb0RNS09rdUdLQk13?=
 =?utf-8?B?TlJMSVhIWE0vSC96U1hYdkJ6Mi90djJYMHVjRElzVnRzZnpiWVNPL1ZDeXFm?=
 =?utf-8?B?OWs1dWdnMVBTS1pYcnE2SWM2OUp4YWlVTmdITExuUEpsQXVBZnpTQnRhNDly?=
 =?utf-8?B?UU85MmplcXlHbXFtN2lIdnJuZVgvbXdUaUVEdFJ0M2JxYW5HeHk0TkVsaitM?=
 =?utf-8?B?ZERwaGxBSmhDbjJuQjcxakpJaS90RWIreGFZTklwK1B2Q0pkSloxMFJpNkxW?=
 =?utf-8?B?L2IrWTZNVTh2M25wQURuY09USXNuTmVQekkvUXVudkxRREk4eUFxZ3REaVlx?=
 =?utf-8?B?dEpOdlJnSFcyNmJGbHpCak5ROERLQUZaKzhZR3hadXVrWFd6bFo2REpJU3Fi?=
 =?utf-8?B?WDRpbUFFRER3WGw2dGFOUVIrSFRFb09oMGpCMm1OVVhrajl6WXJuekRCRld5?=
 =?utf-8?B?UU9aLzlnTTdkZ0NiMndmUFgxVk1XY3FqdllKLzRBQ0daMG9CckZDWFh3WDI2?=
 =?utf-8?B?cU5mejdyOC9Ya2xpQlNjeThLaUNEN05ONVFmV3BUc2xMaVJ2R0xVYXM1YVV2?=
 =?utf-8?B?eTdZV2hEMjc1YWxCdGtSaXlmUHV1N08wZEFWSm85QktYOFJhT3FpUVdSV1dp?=
 =?utf-8?B?VEFaSzcvYnI4SGFmN3VWdTJDK1pNM0lBTW1wbVVjQTZJNXVnTG05ZFNoWE4r?=
 =?utf-8?B?aEE5a0hId2tPenNHOUhmNzRlcjZsTU4wWm5WVEM3cDdhUk5MSWdiNDE1ZzhB?=
 =?utf-8?B?QkFJS0tKNkFnLzhMVnFSWENIaSsxT1lxcGRiSnZKYXB6WWdJaXBaVHc1WDhx?=
 =?utf-8?B?c0xhQmkxa1M4Tm5HN2lKZW50WmtUL1dxbW5XN2FQVzJXNktzZm85ZHJMVGox?=
 =?utf-8?B?MTE3bXdWcHVnOFZ4bDR6OEFWVkFiUzdMcGlHRWVDVmk4aHNwbmp5TEJnVFlh?=
 =?utf-8?B?V1cvbFlkZTZManozZEU3MUI0b09qc3hhZVlyYkNKNEpORkoxcUljcit6RmFZ?=
 =?utf-8?B?OTlTdCtjb0hxeXc0NTNJL213aCs3RFFpR29kb054dFNXdjc1dmJ2Y2xXR0Zm?=
 =?utf-8?B?cmxTaWVtbkNESUpQd2l5dXdScFBKR1pERlRJZXlnNzZITTFrQ2pBTnI1N0dn?=
 =?utf-8?B?T1RibHNidlFMNks5RmdkQ0tjbk5lOGhxZW0wY1hkOVJVeExiRG1PczZyOEow?=
 =?utf-8?B?a2piY3ZXb0NOM09ZYmd0RkFockNEQyt3U2poWjB1NEsyRW9HMFI4emJSZ3o3?=
 =?utf-8?B?aXdCTTZURXBzZ1BQcDI0ZmplUERxQ0xkSnFQZ1EwQm0vMXdvZkZrT01zYk9s?=
 =?utf-8?B?b2lxQ0ZPeTJIUVRQZm1uVmFQUm5MMVZQUWRUdUpGbSs5ZjNXNkpVRVBSSmE4?=
 =?utf-8?B?M0tRYkdQa2paNzA5TmNlMTVYV25CWFJ2dVRRS0pKVlV6MWRpbSs3TmRvOGZP?=
 =?utf-8?B?NjFZVVVSeHF5a2FKTG5PbjdHb2RYenVqWkJlVm54U1hQRlBRWHMzaXNuMnFp?=
 =?utf-8?B?bFJCYkNQMTNFaFpqSlNPRkFTemdFbWN4R1N2YVQwZ1VEcTN5NlhiWGJCc3Mz?=
 =?utf-8?B?VllHRUw1M0Y3MTJEcy9PUGVPMU5lazh3TkhBMGxrbDdWT1VOWE52SFI0aWtn?=
 =?utf-8?B?VEhxUUFidWl5YWJqWWw1Z3hEUXl3RmZIbHJLM1d1OExXWThNajBWNnV6djRF?=
 =?utf-8?B?MWJEUndyVVZoc0tmcFlpNk1Na0ltRGxtRGRxVkc0YW1iczYvZEdqaVVJZ1BE?=
 =?utf-8?B?U0pRRnlLNTlCaTQ1ODVLU01MdEYxaThRTC9QMjN1UEZTOWVoR1NEUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b100f2-58ab-4fb1-10e9-08df044e7189
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:18:27.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUakezH2iIGRU1k1ccrSm4CYeZLeir7s4ULinO4tZo+Q2ImyfTwV3aJlvgJJaWEFnzLmbWawQvBeg8BHYHtITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782


On 26/08/2026 01:05, Abraham Zukor wrote:
> tegra_spi_probe() initializes SPI_COMMAND1 with only SPI_M_S, leaving
> CS_POL_INACTIVE clear for every chip select. This drives every native
> active-low chip select low until tegra_spi_setup() runs for that device.
> 
> SPI children are registered and probed one at a time. A synchronous
> probe of an earlier child can therefore transfer while a later child's
> chip select is still asserted. On a Tegra234 system with active-low
> devices on CS0 and CS1, this caused both devices to be selected when the
> CS1 device probed first. Its initialization then intermittently failed.
> A logic analyzer showed CS0 remained low throughout the CS1 transfer and
> went high only after the CS1 probe failed.
> 
> Walk the controller's device tree children before SPI_COMMAND1 is
> written and set CS_POL_INACTIVE for each valid chip select without
> spi-cs-high. That way the line is already deasserted when the first
> child transfers and does not change level when setup runs.
> 
> Disabled children are walked too. The core only registers available
> children, so tegra_spi_setup() never runs for a disabled one and probe
> is the only chance to park its chip select at the level its hardware
> needs.
> 
> Fixes: f333a331adfa ("spi/tegra114: add spi driver")
> Assisted-by: Claude:Opus-5
> Signed-off-by: Abraham Zukor <abe@maticrobots.com>
> ---
> v3:
> - Drop the cs-gpios check; programming an unused native chip select does
>    not affect a device using a GPIO chip select.
> - Split the compound condition into separate checks for readability.
> - Retest on a Jetson Orin Nano with CS1 disabled. The old module left CS1
>    asserted, while the patched module parked both chip selects inactive.
> 
> v2:
> - Derive the inactive level per chip select from the device tree instead
>    of setting the whole CS_POL_INACTIVE field, which is incorrect for an
>    active-high or mixed-polarity bus.
> 
> drivers/spi/spi-tegra114.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index aa44ffd09e61..463bb7e61b6e 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -1395,6 +1395,32 @@ static int tegra_spi_probe(struct platform_device *pdev)
>   	udelay(2);
>   	reset_control_deassert(tspi->rst);
>   	tspi->def_command1_reg  = SPI_M_S;
> +
> +	/*
> +	 * SPI_COMMAND1 is written before any child is registered, so a chip
> +	 * select with CS_POL_INACTIVE clear stays asserted until
> +	 * tegra_spi_setup() runs for that device. Program the level the
> +	 * device tree asks for up front instead.
> +	 *
> +	 * Disabled children are included deliberately. The core never
> +	 * registers them, so this is the only chance to park their chip
> +	 * select at the level their hardware needs.
> +	 */
> +	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
> +		u32 cs;
> +
> +		if (of_property_read_bool(np, "spi-cs-high"))
> +			continue;
> +
> +		if (of_property_read_u32(np, "reg", &cs))
> +			continue;
> +
> +		if (cs >= MAX_CHIP_SELECT)
> +			continue;
> +
> +		tspi->def_command1_reg |= SPI_CS_POL_INACTIVE(cs);
> +	}
> +

Thanks for updating this. This looks fine to me, the only comment
I have is whether we should check and warn for any badly configured
device-trees where the same CS is used on multiple devices even if
one is disabled? It shouldn't be, but could be good to flag this.

Jon

-- 
nvpublic

