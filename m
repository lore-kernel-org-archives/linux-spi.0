Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC746345CAF;
	Tue, 19 May 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215772; cv=fail; b=lsaUrKBXO5rYFSBbNaf39qcyX68YskKELZ1tZ0w1ema2eiPQuADcaByKRRC2RT7WhQKRERRDTrdw0ZlU7M4zUxkPJOS3EkY+6YRUTEHUNJpgoHa1aJGV4G7EW3sQ2QvOAsT6swsEKeVE2h3zKvl/DHbO1Bxwc88HyXOgk9nsPno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215772; c=relaxed/simple;
	bh=nRfT/2tr19/5y21c6Zwj6OZFjMuNA8eBmNLZ35DpMG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5yv8HyXK4My6EW3C9qHP6oXJexO1Y3yslSgn/EHviPyRZ/07fJ8bSTy7nHQaQ1WoUCXtL8zAy/k/IXwe/sCY5dQ0TD10tPhjdxcNetftwTZ6E8TfGBrrNM10bT9VBeT1gXl3yxKUYR1giWFPn9WI+PFm7A/jZohgsqVv+pUvBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0UMBx5M; arc=fail smtp.client-ip=52.101.62.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0UMBx5M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnKUc1Zb+gccgkuq1WVeDB1+KboCwwYulTns9VO49PAYspLevLP8gFTSVxo8RPyZaEPk4N+xk3avv2MH2yurK5z7MID8LkFBxu+NDRRq9fG226XqlWxbxAp/QNRgr1LeUQTVz3N4v9yb90/McwFYCdWtpxTeuJ0zqOLb6qU0Wj70YCCDaXz3uf7Kiay9oABKryiiQqg5VIS7FIecwSH54EAABuqT1wCDG1TmgpvF5wdTIMd21QLJkhpA7WTQ4rP1xzjxC4k/vULh493XZrMPbSGr/c6z8Nt7J8DWLOZujQRy6WT9Cv4AXAmLrjtBnqOBQm4Ii92TonNPYSbrURtORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ECAwqlkHa3c5owqTddAJyShfgqC3NZfJKa2/NHo/cE=;
 b=FhVOneDNgJhdKdVsdgBmVRh39SWs/55AdrCVHq2dvxTg7irFI7mPhrd1oJLZTJadw2qZ2/UAPJpXMgIyNt6KjxVF2Db00OteDkqn9ok8y9WGc+H1YVBqNL85aRFjqo3Zi2ad2qjOqOcSmmnbxmLJbI3SAxoL5fPpmp5FowVQn2XqDvwmtmJe5KpYsMzvY2UkseEZiB2TB534E1LLouuJ1QzmdYW9ZWn+bcStqIUjpOxAE0k2I/f1X/Ya/gwYzDown4/OIHEtCVz2UmJuFmlyT+Gcw6UxhY9CUEcgIss6n6/0qNhWZXY44Hk1NQh8w9nJ0sBH7WDOwepUmqlQxm5D7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ECAwqlkHa3c5owqTddAJyShfgqC3NZfJKa2/NHo/cE=;
 b=W0UMBx5M2nX1gmAWSZy1bp700Y+N2gp6g04zRc/cew3RYiFbjvg2aPZiIMjF+tyeQyXgWDvIQfuEGzqVtI9GMQ0RAYhL+PMPVorMq0YPKLwCQya9A3SXVNFePS0RmwZVM0BR5Nq/8S9c1+ivMGdvdLBD51/pYctXkeVIuQWoaCQiQ1PATSgUHw/PRfrD/1DdvYilKp8T+SS2A+xGB39iaLgimrqDzBImPDqc6V3OnqcZNIpPon1Df7H0LD1LZtLYO4uj3G8TqQ+L+Pg9UBpu6HBkdXADbHuSObUR6hmSazLkcgjw2SRIWCHNDcHbwT4VjfxfakMIFemoM8YMHX4ADg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:36:07 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 18:36:07 +0000
Message-ID: <7ac5582f-9165-41a2-a130-2f465e6d77d9@nvidia.com>
Date: Tue, 19 May 2026 19:36:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com>
 <91fc534a-6529-4880-8c92-a8713118242d@nvidia.com>
 <CALHNRZ_Ke_pC4tept4_vGOB0ArwjcaMu=mc=wJrQ0x79MKid-A@mail.gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CALHNRZ_Ke_pC4tept4_vGOB0ArwjcaMu=mc=wJrQ0x79MKid-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::10) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 028d7871-3517-4a35-d21f-08deb5d57d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WyxQQsfAdvZfZFCsjJnbwXcSI92XeYumqr6Y7K5STuGH4Rxat5TAFhAHJa62iU+f/r3hYI5rWN6ND3qW+r925CQZlQQA/VVCZ5z9oyZTUDCRIORp/aio68jaojH5Hy8gBPlxfZzKAbK7Q+1qD5OAYxtnOE0GImWWNU+o663C7YJrnSA7tvtt+rnK73+Lm1oB1QPX1+bn2pOChG/wGk+W8FJzsPzmI7q4w15MyIvLz+U4+xQasZy1cXUicjEIzFTTsS6edJHBH2/BOa9RmGoNLWzqGP97Mb2t72Dc4s9pyGzWAgxlfiOzB2OYvhSCW2G/UrOk4QN7Sl0KY0D6qXOobXjtnL0VBjwy6kx68h5OXDAOTNkjz1H+MhY1prhgnVnqxHXXFrTB9jL7SL7wGS9YcpqwDkSeGw628tGduaLH46xm7alBKsYN7+Bz4DPo/t6paxUBzC/nzzJ6kKWlq47WxnXCIt9Y6t122LKaxlHzueodk12Jy9KwoOj4aLyQ9F7cYDeXWSVh6lj7AOJRUdoLFQRpwgXHoNivih+Ozd0HzcMspFlqE+yZOPQpAACwOj+6yXH9e1irOGlEPAzyMQKas9xd/+BlQzjJeuC7DSXg4cAD5WEj6AXOMi1t9sZra27ggNy0/8OjZv1GSKcdF0OvDuFUCFvgDAcfrSo8ZhQBJdAqR1lwF/Odci9jC5d3ieWC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2M0cm9jb21BSmFoN1A5ekdVYy92OHpxc1FBd0dyRDJsL21FUW96bFd0aFo4?=
 =?utf-8?B?cXdaZGg0VytxelVwWjNkdUl5azZvY1N3VVh0OWR1eCs2WEMzQzVSVkluTlE2?=
 =?utf-8?B?VjJ0dTlNejJ5L2N0emxBeWE2bVRnN1NEekdCLzQvUEdtU1ZmcktFdldpa00y?=
 =?utf-8?B?MU5xcnpRN0dSV2tvTzJoVlcyTUJFQnZGaG5pOXdlYkJZbFkxTjV1REpFWnd4?=
 =?utf-8?B?TU1MQ1JUQ1ZtVEFPUzM3SCtobHo2QmpCYXVjaW1Idkw4ajRvcFRkZ2NMMjBN?=
 =?utf-8?B?MkJxK1o3MDlkSGx5UjBjNjJSWXNvalYvV3lITklSWWVsUDJXOTJ6dFV0NS9G?=
 =?utf-8?B?YWpEYUNGQnVkOUNNcklORjMvSGt0NjdhZTBKMEZZTi90NlhGRnRGdDV2N3JI?=
 =?utf-8?B?eEhZV0FuWC9uOFAvbnlPZ1lnU2pkR0xlOEVha2FmZ2w1WjhCRTkzYlpkS2Vz?=
 =?utf-8?B?WG1DY1pObnZRR0lQZk5TS3F6TXpaNWhQeDdWT0RTeGE0c3JBM1V3U0l1Y2RV?=
 =?utf-8?B?WWI0Y1poNW5rbU5wRnZGaXlFdjBpTTZyckNmZm93L0V5bDZqNHVPaFZxSW5H?=
 =?utf-8?B?RksxdG10bnpOd1ZlTTh4UEp4UnBLSDRvWTUwU1lnNjhmK1daSDBydWNFQTFn?=
 =?utf-8?B?UG1mOCt1b2tvK0V4RWRLd0JPOTFKY202N0tIaUN5WXAyMXdOdFBTU0tHOFBY?=
 =?utf-8?B?a2ptWnkyYlNQblBONTdndTBLYURjSVRMWXJSaXRyUmdNOW54eHJ5aCtGWVh0?=
 =?utf-8?B?Y3lxV0N0YjF1YzFCVFdZR3dpaEhnMlRzQm5rRFh4eGVTY0ZWdTRibU8zN2J3?=
 =?utf-8?B?VGp0d1lENTRPRVFTSlBTL1pDRzQ4SDlZL01QMWlpQnRITXJZSUQ2MnliZjAv?=
 =?utf-8?B?WjhVMGVoUHpoYnJZazBqT0w5Y2NiTkQ5RTBHUEp5anIxM0ZSY1R2a2laYkVa?=
 =?utf-8?B?TUdLSXJ6eFJQY05VbnVTanlyWk1qZ1ZNcWIyY1NpeVZxR3kzb0RNNlBzaE9w?=
 =?utf-8?B?dnBGalNLZi82U0dXZnd5eDMxRno0bnpkTnQvODhtTmhlVFVsNzNtUEt4bTRs?=
 =?utf-8?B?L1Vza1dsUjNtYklvbzFUdzhGeWZGclBLTFk3TmFZemx6YXJ4U3pjSDFpdEN4?=
 =?utf-8?B?bUU0T05xSU8wY0lqUlBRbU4rNlkzdnZDMTU3bmkvVGVHQnYzZ2ZISjJscm8v?=
 =?utf-8?B?MHJJNkxmSlZCS1lDTTR6UGZWejhOcFloN3crTjZqdWlReHAwY0ZBWktoMTJQ?=
 =?utf-8?B?SkZ2dGM3aWhCeU43aTJTWnRDaGZna2xZVXdzc0xjNWJMSW1jSW52VGlmcmhT?=
 =?utf-8?B?THRFME1CMlA1YmZmOWNUQXlLL2tQOGZpYXhvNi93cW5sVjF5eEFXR0ZkVkdh?=
 =?utf-8?B?WFhJSi93MnlDSkVuSmR0cjlhTmlCMTZRN3h0TW1NWnVVUUlibzhCRkxCaDRk?=
 =?utf-8?B?czZUdk9NM1FBemsvT2tqQVo3eWp3bkcvdmdrcEtlL242RmtHOHh3YlQ4VHZn?=
 =?utf-8?B?ZGl3Mjl2WllFQkNEcXRaWjNJNnhHYTF6bThLd0NDM0JnV2ZoMFc2amdpZkJV?=
 =?utf-8?B?dFlna3I5S0V3cjA3YVlGQzI1LzNNU3kxN3hrVWY0UzVFUmFSdzV5Z3lPbG92?=
 =?utf-8?B?U3dySkkyLzNRQWQzdHZwd2hKV1dNSFZoMWxsN2Q0Y1I0a1JhNVh2Q3lJdTRC?=
 =?utf-8?B?L1ZRMFVCbExteVRZNTkrMGlSa1VZcGNuZ2wwOWNmRjkwZVoxcW1kVCs5eWdP?=
 =?utf-8?B?MFhWdVlMbE9zTDNJNHo5UlBCNUhvYWdkem5oV0VWZ1pkS1dYR2JMeWRBbzZ1?=
 =?utf-8?B?Y09UaklXbEZvSEl1YzJsazdsMCtFTHlxRUgyTkgvc21kNkZOUS9jelhHMnVE?=
 =?utf-8?B?Q1kySDJPd2pjRlVUclpDWDRWQkhaQ1lVYTY3RUpkSDQ0OUplYnhJQzU2NlQr?=
 =?utf-8?B?eGpsOHN1Zk9peThIZGpFL1dCc1loSHE2YjMweWZmaFJnNkpvSSsrK3hFeFgr?=
 =?utf-8?B?NUU1WlRVdkljUXh4VHFoTXFKT0crRHJ5emd0T08vdEFMQkQ1UlhRU0loNHAv?=
 =?utf-8?B?L0RWMWIyc3VZM3QvK0lzdmNidGRYK1M3TUpvblg4VDkyL0xUeW1SSTZLaVl2?=
 =?utf-8?B?eHdNSVpVcXlVUmNOZTZoL01RL3N3MmZqalFFeXU0YW9KamV0N01lbFREVTlD?=
 =?utf-8?B?S05pWXVZVjQwSzJkODY3L3BhOUNzcEdkVGhxSTJNMGtiWnVXaC83NUw0SWty?=
 =?utf-8?B?MWlQTkF2aDBmdmRkaW9BNldCUUdmRm54MU1EeXZQdTYxd3kwNFRSZkFZdHZa?=
 =?utf-8?B?TmZEbkZYc0IweGVUNVM0VGtHd3RVMGJkbWl6am4zSlNLMDRuUkFxQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d7871-3517-4a35-d21f-08deb5d57d66
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:36:07.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbZwnke8fVXTVqmLfRs4Pxo6nvLgO7sEQQw5MirPqIP/bLhjZtQlYLtRwyrgjixv87EXOkHMlgjPkwyrFtOjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104


On 19/05/2026 17:48, Aaron Kling wrote:

...

> I could update the commit message to be more like 'Enable DMA support
> for Tegra194 QSPI', sure.

Thanks.

> The primary kernel version I'm working on currently is 6.18,
> specifically googles android common kernel fork of it. I also
> replicated the issue on 6.12 and android-mainline which is currently
> 7.0-ish.

So I also observed issues with Linux v6.18. However, Linux v7.0 is 
working fine for me.

> I was not normally seeing issues on boot, though I think I did hit
> that a couple times when jumping around versions. Where I had trouble
> was active use of the flash chip, like read/writing the slot metadata
> for a/b support or writing the flash for inline bootloader updates.
> The issue wasn't always triggering a cbb panic, but it was (almost?)
> always timing out and failing to read or write the flash chip.

OK, then you are doing more significant testing that I am. I was just 
seeing issues on boot, but with Linux v7.0 I no longer see issues on boot.

Jon

-- 
nvpublic

