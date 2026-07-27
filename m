Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0574366057;
	Mon, 27 Jul 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154061; cv=fail; b=jRyaE0G474Ya9jeB7cVzz/43MirGrxGX0N0V6WoKemdrzR7rXnk4DQB4PlBMCY1wJjzwEFa5BOlqTeHBeM6hpsYYOsuU9Qxn+HPBYYWwLBU6Uycny5aaYgFEjZDxA28BQ5aE1AAwSRykAFDRvnHeKsTzDeDAMjY6brEkdrhZFQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154061; c=relaxed/simple;
	bh=Ipj53UZ0hfh5YLPR4cozZUw+tHuDnRRWd/nQ9Uk78bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Za7MiXA1PEVYoI6LmPnq4RUMOuILkoBrM5Oh1HVm8lEcPYV4R9KskesSkiGO+qixa4upvLCfUhcEk684r99V5N+wKs60kV7ApqoERGxSit+o06VzybATV6NhBvWmKcZpkSimVVHEsD5KqxLQ8rtvBbgUl+lucaGIV7tpya+duIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFJeQB6n; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFJeQB6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncxBuy+ewWNB3TVsrhX5wBi85uTMBsnfTBSNYI/WbUSaZSI9jd0Po+hlMEKUlljcH3S+UEhBW6cXqDMD2XTS5bCUZVFljwyOaYBMZmN+6ZyIHXIP+rOVXmqYD74eMB/PdkkZglVu/GPS/dfh+qFLkNQNtBZ6YlsAFQEmjVuJFO0vqVOFVlaOEW8p88whGhPjwdN9lejSsPRfn1PFMERH4brq+KQ6ahsr5TfHzbZDF3PN7zaAprXzG9yXlgRW3uSJxRKXEnXnGeTFGC0T/5/1NFGB1I7d5GkYaK7YLKS28eQ/s5b/HaAsP1VSr9tOd/bYl1liyAlqpLGO5xzjfLrsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys7wMhlx9mf+3MDwX1cG52nAddx88gmzblZ1bGbiBec=;
 b=W1CmjQg/OL1w03ycGnk/Qb8p5Cdmaz/4G4F8EwW8/z76odB+zWTnNqSedqJSf5ZsPvf1OelqephP0NX8j5lcnbiTWs6MRS5DQoG66YmKutRKF8GqI4WL5X/fMeWuzGUo3IYSoq9EBUf9QZNABBdB24R6BJo5XNXPbZTV971jbyj7t0pvqgM/xTd0YImeVrYZ8aVo5AfQiElF48kfAcfrzjrhqnn7J72sd4VcMvom3mUQ9fDBukv+2AEq3Q2pZcWYvCI3299zZXwHI0rAX7lk9dxHVdQMLQR2s6TwwUzBfYLtM1Hkxke3Hpy/mPuoIcvcmPtyys/o5cDsiQqZVAiteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys7wMhlx9mf+3MDwX1cG52nAddx88gmzblZ1bGbiBec=;
 b=FFJeQB6nmREEQss4RcgMtDdpXdXwXDV1gi0LCb0nZLiybldrphthtpqSgQM9qWNsCaFcGICB1Q0KID2wuU306P55GeTKSqairL9wuxmAxxt4wqJk11ivX30MIKdyoKCLZs3Krg9mirWyF6Ex9hRktywRapMEDOAlMW96c64SF9y5KPJre7Y4vYhxhZGRQMZPqY775M6N+HHRNvDKuKV8JQpS/EMhK0h539/MwF+qh3YtLx0dyA/AbzWS/Ft62Mlf+KCbDFms813Xo2/iv3sEYkmbT4QIUN0pL6qsik9QaVa1srFD0L0x/M1WEYdnW/HjOIVtW8Iqf2Jtdsf90YHazg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:07:36 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:07:36 +0000
Message-ID: <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
Date: Mon, 27 Jul 2026 13:07:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
To: Abraham Zukor <abe@maticrobots.com>, Mark Brown <broonie@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725042944.1204409-1-abe@maticrobots.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260725042944.1204409-1-abe@maticrobots.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: fc656ba5-2919-41b6-8474-08deebd7a582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zk9bq8tMn+1ULX9xZbgzwwcoQSVobxK4r3krNUp6izrVXl0css2hWbrIpSVNnaa/TXK0Dj8CmBym/7WDIzxsZl6ZuAlxmeBOuvRntKzryorjPNoUxT7CHVg7ykRLNSEc7ILkBLRt40BSACXCTDgedtwoEsYs+g7cFP2s/Xl24Ty00J3KiSttvXHdBBZQf4hEtbNM5g65TPpRyx/kcvtc6jrc6beR+YUoUJiBVjlYdEoDymQadpjaiY65UvCwBN4XamoHZ+RtfW54LTfUmQ9XmwLjK+Fy1NdQaDYHIaGH1HT5DRD7tUP6/5DyIRgQEA4pZGqF+wKjuSNF66dzmmKKJW5SS/HS/wouMyKFDmV2KeNJAg1w0+X+ojs1c+3GNw0+2Js39b21o7mAqdCTrS7jvEC8byneONNV/Y3J2lmQefGUHwio69rHqve559xU9/vYVhIelvog5RQI/LXf710FntCnM0VUug9IHXbMk82s+5ph2KcWgHqbNyzAcJCTtcmAtvp6bQmal1en6KIqX4ekauAZSZ4e/SGsGPB509ftAQW/ZvhppzfWFIwZu/DJJfhVfmWdumIvSB4OvLk0NtH+Txvs4AeUIX0PoDA4mUcNs3UXiliCCdUWuS4dNep0zxXJEh7Gjp7nYKNmiLLI5qAaGu6GEogrDGfXijaDSegbEvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtjUUtxRkpUZ0sveGRQR3ZwN1FOZFN1VWhodXREM05QWkEvRDk4RXFzTGxD?=
 =?utf-8?B?VVlQR0MxU3hiYVB1L2ppVXA5enlHbWhmV2o3L1gzT09IRUZ3UmtraTdBbVlF?=
 =?utf-8?B?MURLbCs0NVRRZHB5K2haOVY1Y1VzNkZMenhxQ3dwTkRwTnRzNm93eGJ3MlYx?=
 =?utf-8?B?bmpZSlFlYzlYcFkrNGZUcm85Z2d1V0lKVy84RUZSZWV1WGJTK0FDZUtyOG95?=
 =?utf-8?B?NCtKMmlzZ1EwU3ZDd2MzK0U1YkJKbDNZSFkzRWs0c2ZEYVRCTGZmOW8xclRz?=
 =?utf-8?B?RVl0WlpUVkxMdEhOZGVZK0JGTytlVCtuWTJzMXNucVRUbFo3M3hyZFc3T2pJ?=
 =?utf-8?B?Y0FtL3RLQnRBRk9OL3ZjYWlXbWxGMWlnR3VaV0k3ZWNSQzJDTHMwUzl1dVdL?=
 =?utf-8?B?MnZiUDZiQ05yQU5BU2FGOGdlQnlUNU1TODQyc09Dam40VEVSWnFqZ2xNM0Vl?=
 =?utf-8?B?YzR5T2krL0VhNW5CQms4NTlGSzRpQ3VOTmordjcrTElaVU50dHlobk1BYys1?=
 =?utf-8?B?QWljM251cGRZM0orU2drMmxlTmdPakZOc3FOT3VxQ3gxNzZzT3Vqb1JPRGFv?=
 =?utf-8?B?SDRFWTQ0UTJYUXNrSUpxc3RNbFdTTGNFMVZ1RFNPRXl4RWRvRjl5c0QxS2dP?=
 =?utf-8?B?N1doOEkzV2I5T1UvTkpHYkxHWEFMTS9BbXJtQ0M4R2JDZE1ZRit1S1YzSlhn?=
 =?utf-8?B?Zml3MUV3RzhqSm0vQnc5VDBqUTU5T0xtZnc1aTA5Z3V3cUpxcUdPVTBkZlND?=
 =?utf-8?B?Qy9zT2h4TmJOaHZWK2tST0t1UXk4NUkvcm4vTnpZbVJqMkZZMWRWak1yRDBE?=
 =?utf-8?B?T0xPUytrcEt4U0pDRXFwZDhjN1Z3WGM4SjNhYSs1NU81cjZRR3had241SDJP?=
 =?utf-8?B?NFd5QVpRVUF1QzAwL0U1RTNDRGNERGF6TGxxU0NmaWIvNFNWNEExazJtUWli?=
 =?utf-8?B?UG81VThHaERFUlYwR2JvWU9MNlBURFp6a3RzWXB2VnlDNnAzNUZlMlBhaTI3?=
 =?utf-8?B?OUp1Skc2MkZhc2cyK0kvL2k1RWFBV3NTay9XcXlyQmVEYjR1UVk3cy9aRFpC?=
 =?utf-8?B?ZVBsc2pCYXkvTHBTMXRmeXVkeEhtWTFmakpWQmJ5bWNvZitpekJxNzZ0dUlT?=
 =?utf-8?B?YmMrNktXeCtzcXN1RTdVTTBFUFgyL1YwTlh3SGJXWG9MTzJmRmpucXNQS1pv?=
 =?utf-8?B?UUt4U0xtZDRFTEZhOE5UdGRjallFTFVlS2xEN3ZQT1dyb1FrWGxUd1cyWWp3?=
 =?utf-8?B?QWhWdHBXNGV4R0doTG15bjB4enNXL0lFMHpZeTluNDIrSHFXUXhsMzdySnpk?=
 =?utf-8?B?eEM3aWkzMnZIenFMRDNzWEtVeUFRTy9FeXpDL3lJelVyTks5dXg5SElSWU1r?=
 =?utf-8?B?bGZuRzlmTFMvWlNrZnVyVzFXVVJ1WDJtQlpCVGdlY2JPSW9BZmxSbGpNelVV?=
 =?utf-8?B?UnEwZGZ2K01MbEdHRHVjMUVlQTViMmE3UWp6eXgwclhWaUppTGZkRlhmR0Nv?=
 =?utf-8?B?L09MeUUxTU9PaCtRUmxzcUF1Tm0weXYzdC9WNW9oZ2d2SUpoalZkajVuRWlC?=
 =?utf-8?B?S29HMnRWVFNiclpaanpPZEMrU3haUXZJY2xuc0JXTFhTNVJnWHNLK0VyNWdQ?=
 =?utf-8?B?QUFENEw0d2dzWXVHM3RJYkd5RXRkZm91V2tKQzBjaXI4Mm1rblZBZG5hVS9H?=
 =?utf-8?B?UHJiZUNzcDJwYUhBMXIzcnBxVmZST25UQmdPNU1GL1RpQmNxOGlDakhHTnNo?=
 =?utf-8?B?c1FSRmoxazZUVjF1U1NDbm1VNkdTNngwZ1R1YmxLbTVaOXo4MzM1alVQaFFT?=
 =?utf-8?B?YWNCTTlkbGRvb3NRaTFuaUJBU3pqUFdEY0xYQ0F4REc0bFJ3UFFQM1dYTUc0?=
 =?utf-8?B?dG9jczF0OTlWWmhJSDNrdkYrOXRYTGpqYk9vSU84Z0s0QUxTWHl2K3pudDVz?=
 =?utf-8?B?Z0E4emovMjJsY2IyWVJxVGIrY0pZbUVST0lhcEVlaVF3R0o0N2xyL1p5bVFa?=
 =?utf-8?B?QzVvR0wwM01QWHRaTVF2TnJSTEVyK0hnMHRJRll0ZkpEOGlTMWh0MUNhZ2dV?=
 =?utf-8?B?WGFiajlTaUhHblJRTWo5Z0JBU3Q5L0dKM0pBTWlLYVFQSnhTMzZIRDc4Z1ha?=
 =?utf-8?B?SFZ6WHRGRVdYRDI0aHBqM2pKZVF6UzVyM3N6TXdHOW44cXRzdndJNlBrb2pq?=
 =?utf-8?B?TGU5bXRNM1FWazlpWXFrYnErTDZFbndDSG1oYW9KUlZtQU5TRHdUVkc3Mm1L?=
 =?utf-8?B?VmFaMDdGRTJZT2Y4YS9UNlJVdUNTbHAwKzNUY3ZES2V4akZZYzNPK0pzeDBl?=
 =?utf-8?B?SUFMa3RBRDBwQXpiaU5DeHpOM0xtV2xOVFJRNTd5T1RDcDdQRm1Oc1M0YUlk?=
 =?utf-8?Q?oyHZN+fKCf510/4PKoP4Zet5e6WZdz3hz9neySWoQRmp6?=
X-MS-Exchange-AntiSpam-MessageData-1: MqBIxW1pTQQvbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc656ba5-2919-41b6-8474-08deebd7a582
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:07:36.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBzs0a4L1ZUgAESMRtoDq0wC74snorC3U+TrvX2yxwz20rW+LF7+SZY/RtbdqJA6PKAyJP1Nt77Qoag26rrurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876



On 25/07/2026 05:29, Abraham Zukor wrote:
> tegra_spi_probe() initializes SPI_COMMAND1 with only SPI_M_S, leaving
> CS_POL_INACTIVE clear for every chip select. This drives every native
> active-low chip select low until tegra_spi_setup() runs for that device.
> 
> SPI children are registered and probed one at a time. A synchronous
> probe of an earlier child can therefore transfer while a later child's
> chip select is still asserted. On a Tegra234 system with active-low devices
> on CS0 and CS1, this caused both devices to be selected when the CS1
> device probed first. Its initialization then intermittently failed. A
> logic analyzer showed CS0 remained low throughout the CS1 transfer and
> went high only after the CS1 probe failed.

What about the case where the SPI devices CS is active high or a mixture 
of the two?

> The Tegra234 TRM also documents all CS_POL_INACTIVE bits as one after
> reset, so the existing probe code replaces the hardware's safe reset
> polarity with zeros on that SoC.
> 
> Set CS_POL_INACTIVE for all native chip selects during controller probe.
> This matches SPI's default active-low polarity and the documented
> Tegra234 reset polarity. tegra_spi_setup() continues to configure the
> inactive polarity of SPI_CS_HIGH devices before their drivers probe.
> 
> Fixes: f333a331adfa ("spi/tegra114: add spi driver")
> Assisted-by: Codex:GPT-5
> Signed-off-by: Abraham Zukor <abe@maticrobots.com>
> ---
>   drivers/spi/spi-tegra114.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index aa44ffd09e61..c28aae093d57 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -1394,7 +1394,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
>   	reset_control_assert(tspi->rst);
>   	udelay(2);
>   	reset_control_deassert(tspi->rst);
> -	tspi->def_command1_reg  = SPI_M_S;
> +	tspi->def_command1_reg  = SPI_M_S | SPI_CS_POL_INACTIVE_MASK;
>   	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
>   	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
>   	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);

-- 
nvpublic

