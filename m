Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF33AFD10;
	Tue, 19 May 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205839; cv=fail; b=NVwkfKBthkKl7V/cl/HKZRP3+k6AtFWjGvt7Curqghx4ZfbDZsfjTx1fiFH8K7dzKAfkDDJUN06KddcTLJpuDkMvYXxJtaH6pamoizwP7TkXvKm5Y6ZN1xVgJCOI5jChcvuDxfo/HqTMDoeN1eeN1i/Jl6Nr8kZvEnuQeoC1Sbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205839; c=relaxed/simple;
	bh=LBRP8Sc0zlGX2W6qUQV0dnBgl6w7V55gW0B5ctZClL8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CGbvdeIRHx4zEWA/d/tqhTr0y/mmvPlqG9ss0aR/KCgzPXv5e7jBj/2JNicFOTdSisdncXIVv2MVRUVws5yXkS/SvEDJNfZ7BjZS1wDaWCeW012ym5nAs02pICSlZ3tKikQTATlVMmCTD8MQdEa15C3vZ97Dmd0pZwXIhTPKUzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQ1cegyD; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQ1cegyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrx9jE+ba80ltsAhSzPM2geKQxYJATMiXIN8BQqotMQnleKeCzPPLfB3jhg31zgotQ/2unm3hGb313yWxTnu9qwqEyXvWbZnYIPsLLWb5nF8nQCNynvgB+KJ6PvF46CNxa+aB247W6JI/CaOPw4KVDSpglSi1vPVWiWdCUEym96+/YcaN5Q2NrjHmDrJYxtD5Dl2Q9bIAnkVCB/Do2mXj0kYhAN6ANZzG6kq/6v1GngjDsLvf7f9l9p0qsQQiD3y3dZu2z+/eb2PLM0E0x1LYa6VHrq8m7JQy8QpuOUPuYXogIrHoWzaMHl1jkgVxijMSeRBVruzfxPkGay/TW0Glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzVtRXhmlhQfCColSM1ZsdSRqmx7lbeaM35CbawM1Jo=;
 b=oNQGl0hKpdpqtODxAygSCIt9bEzsYRH+q7Kcj6Yo91oKNEZP2IeYVOGpdcPiLbnT/xaYLxWJt0I40fAjvMUEXaFZb7ndzwhcRhmal7XiVkxyflXQuFW66qOSOwvZiIdPEa6MUCqccBIBFCr6IW7VzX3u7ZBwGIs76ymVKZgnjjm1OxRGeNdORENcuRv++z4f6m549CrdfzdDG2GAWtdUk9yRkDCdfRMS0wcAlFxlKIShXCO3lmrY7dm2F/8kUfs0q6Ag6jLSVllSZo8iHYFylQYiNPpHVRvud1siU8HJd9wSNdhuXNfPHjuhbc4UUUB5xU0QhC7dNMCXDDIy1VYi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzVtRXhmlhQfCColSM1ZsdSRqmx7lbeaM35CbawM1Jo=;
 b=jQ1cegyD82zGh2QLeWmhEu3q0asPqTLrygRAK6V2R0QrPtlmwRj1mwVrx5CzsFcSg+IOl3lQa3NPQQm6JfiZcFJCSeUqcCL245R03h3PhV1Gg6NQOwiQr4wd4q9ZxInRPHONHKaYQcbNGMrPLgkL0Z0BKzhuCIQLlbO+LApYqZxZp139wYXUCrPwPH3gxxFHZyhAZ1GGMmNBgfGF/3ldJx2PLtKdRDEW7GfvUulAi4Ve3b1DMULO1hV+YIALwjKl0Llsna9kwoi7stlMJFWKo2qQ8xyvJv8GeNtfflXHsa7BCK+RvlChrdkdYORD+OtZynTuIRew2/ErcXKeS4WFZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 15:50:32 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 15:50:32 +0000
Message-ID: <91fc534a-6529-4880-8c92-a8713118242d@nvidia.com>
Date: Tue, 19 May 2026 16:50:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
From: Jon Hunter <jonathanh@nvidia.com>
To: webgeek1234@gmail.com, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com>
Content-Language: en-US
In-Reply-To: <d10a46b8-2a01-45d8-b1a4-7d003fdb25bd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: aab93706-0f53-44bb-34bf-08deb5be5b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gKasyes03/aNllcZ1LBcO3n4hdfvgY0I7Xr5HLpe9C5bFbEhmUxn0xbJI2/uQ7S/GZuLp7czqa1vwR6nRhk5Mnp2lgLKTT4PH0vheyHP6HMYeO9wEdx/Xq/Je+6R2/t/mIa7n3vdhBdSuePDW2HE49jNM1mGjetLOIKO2d2CyH2kbMQ8T/9yzexZTcdyvAXxS7LBvQhAJ/4LddXTtH+8lAZKOAq9+m7ME/JBZBf3aSnZ0GsUTWQUYDx7zdEaQ6JOLnlFERueo/H7nA8glAlvrT6g3K3NntZwSkxSk8wmbh/YeJzkFbb+s95mC10lJpzlR6qzU4zCEdv7OsMIl+aieH071zrHhOWUZ5O/K/auegBymzDKzSHQAoe3awhh6sv8AWN7A+6YqCCSzVPyUtnlbcshlW546Dn4pObWkH0pbyyUubKAfeCcNyR0LYHQeNrWtk0SoDR0z4UheKiICgiIz0Y8LizWwc/B93PpcfXx2JLEKlULZ6/7/2OzVYerd/fMCtVgoHWKt/2AB8EELz2dCj1Zol3Jw0vkdwI/Sz9lEXy3rHaail/AVDNwFIYh2tKNSCwU4OJRaaWiswKhgGzIvWid4DN16vrIckIU1jHjVOVStqUJWBDba9pDi4Mn4ueivgcO4fbCnJ1zD8jgApld2rrtTuXJoAD7+eFscWitQYHU9u9livh91Omncc5O6D7p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1ubi95a245VE1Lcko1aWpJcWZLTDdyOE0rMmRzbVhodnIrVnd1ZnFhNHpT?=
 =?utf-8?B?VHVrdkxPWXArZERQa2drdkNXNngyaXVhMXNCVy9ENWZyby9aVGR3UXpsaHVM?=
 =?utf-8?B?RVV0Yzhrb0N5NHBzNmYwYVMyekNSbW5DQno0Tzl5SUZwaGI1YUN4WDlycXVV?=
 =?utf-8?B?WnhzWUhibEc4YjZyZVhmVGJicUJWUVdxMklLVjh0Mkt0WktMdnNvNFNId0xh?=
 =?utf-8?B?YkYwcS9iazYrdGp2THZ1MFNObm9PbzdEcklISnZQcVd4WlBBSTk3ZDB3Rmxa?=
 =?utf-8?B?TTZwRFdJTFhaNk5zZ0twTnpDdVBjVzB6eVFzUlV0R01hTTExTWNkcWhSd2Zp?=
 =?utf-8?B?YnEwSnZqYnVZeXRmWHhjeHZjYXBodGh3bnQzaGkzRzNiNklPZm5xL0NGUGRa?=
 =?utf-8?B?YWtueTZIOC9TQnB1L1N5UytCYk5NeTVXMFdtU2pvdGpyOTBkRGpkd0xKOTVR?=
 =?utf-8?B?WXFzUWUwTkloNGZiMFhnYUpCbjkxV2dQUE9TanFmRXNXUlJQb2FaMGI3RVNr?=
 =?utf-8?B?amdaVExCMERVeURuNEJPYU9mOVgvVVdmZ01lZmg3TG9FQkgyNTVRdkpHS3ZR?=
 =?utf-8?B?Tk0zK3NXbkNTMUdsbkZZOWNNdjQxOWdlS0pIc3JuenZqYklnZnNSS0NHUmpS?=
 =?utf-8?B?V1FCSkVHbDBpOXMyVFJURjR5S3k0Q2ZJOWp4MDJMR0tGNWJxY2JOcUE5OEdr?=
 =?utf-8?B?cGRVR1BIbUVob0tGdVM1RS82Y2txZThaQWZmUDZ5UmxFYTdpQlhLNDhiYytX?=
 =?utf-8?B?NjF0cGhMclloOVN2VXIyNU1qTXVjVHBsbHB4SW4vbnB4VGlMbVUxUEl3Ymdx?=
 =?utf-8?B?TGtWSTBPc09SM3JpcldTeklGOHFHem42SitrYXFJQnE1Mk1vLzRGbk0reE1z?=
 =?utf-8?B?TDd6VWxQRUZocll4Q1RHdUZLZVJWbWxxaWppS204bnQvWlRJYkRrTVdBdStE?=
 =?utf-8?B?aGtRL2dhV2x2Q2V6U1M5a3FTOW1QR2U5SFUvSThkbXdDR0tXZjdlOGdHMnhY?=
 =?utf-8?B?NXpud0F0czRYaDNVMFY4Z1BaU3JlTW1TWE96aEtPQW5ESG9SMC9iQ3JrbFRU?=
 =?utf-8?B?eUo1citDcHZDamlYV0ZxYlN6Mk1vOXFYTEREa3pudmNEaE5hVEZVeUJ2NEtq?=
 =?utf-8?B?eDZqRVVHS3lUWit5NThMOFBTbmNFOFM3djZneWVtOVFlTFJaWWRkNTF3Umpx?=
 =?utf-8?B?Ujc5Tjk1YTFJM2I5MzRhaEVHZEw0RGVlS0FSWStvN2RlWDI0NVdJL3NneDd4?=
 =?utf-8?B?VlExM1NtcCtmamVwR1JhVHhtZUgrVG9xZnpralAvVEI4aVhXT2RXZkZVZWN0?=
 =?utf-8?B?UW1qQUNuSjhzTEo1YWdCYnF0OG1nQ0lpVXBaZ3dVQUwvanFkbEo4b3NIRVhJ?=
 =?utf-8?B?bUpCQmQyVmhaVCtUNFkwK29talgxY1p3SVdSbGNtdUJLc1YwR2s0M2ZXbTV2?=
 =?utf-8?B?TGFTM3lSM0l4UFhXd256cEVFbU5tS1VzQStDUjZwckpvc2dlZ0ZPdVlQZDgz?=
 =?utf-8?B?cmhRYWcvR21rbTh4RU1KL2Y4TVY2UHJRM3FjTVpmeG44RVV3VFZYUlpIM3lZ?=
 =?utf-8?B?T2RNSlFQaXArWmoxb3hwM3RDVlV1eGY5NkRDa2lnZVhEd2l4SmVLMEJqaVA4?=
 =?utf-8?B?Q0ZuWlJyTUZTWDNvR2QzdzNaUjZoNHorL0F2K1psb0NxajJFRWdXZEY4b3BM?=
 =?utf-8?B?bExoWDk0bktxSUltY1dicnQ1LzFOSHRDdDhTaS9FMVJtSG1zOWtkRTVJZlRn?=
 =?utf-8?B?OHVPNjNVcWExUXEvY05CWnVDNTBrcmVla0YranJiRmxBYTRnUE5xQVE5TUFj?=
 =?utf-8?B?OC9qcVlQN3JhRjE5Mi9RVWtWKzRVZ1pmazl2b1M5WHhkVmFsSWxuSnBrbTB1?=
 =?utf-8?B?Q3JGWmFRQmtKRyt0cEdWMmErNHpOcGdneFBtcTlTN0p4RmwyWS9seVcvZ0tB?=
 =?utf-8?B?L20zVE9YM3ZZd2xibkZMZHRyeHNuWkpJRUxIdkI0MCtpUkJQMW9CMEJrVEVN?=
 =?utf-8?B?V2NLejg3MlZQUHozNTQvNU1FRTV0ZTVOZzZkTDBlM1JUWFBvV1hpQ0VjMVYy?=
 =?utf-8?B?NE84OW9rN0FXTHQvMkFIalhYSVVFdFg3a0sycDFqU2ZmelV6WUxZRmtncGlp?=
 =?utf-8?B?VEMxb0FEa1FNU3NrRDdleHFSdjdYRFE2ZTREcWFXcmZJa0xRbVNaRllYc2pu?=
 =?utf-8?B?ait2Um16VlFZZWM0dUp6TitGcTFaSVdVVk53Z2JrUFA3Y1pRWkoxLzBKQTlX?=
 =?utf-8?B?Zy8rbVArT01uTmNHb29DMXlDRlhXVFdkamlSUUlPWUxFSFRSQmNvT2NtSy9B?=
 =?utf-8?B?NWlVS3ZvSlhzLy91YjZmMWpINWcvRUloV2NnUUxTbG1kM1U4TGpHUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab93706-0f53-44bb-34bf-08deb5be5b9d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:50:31.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/X5Ce5HzZluZ3w9omV5GKlwT/lOERc9BVtDDhxaNi7ydeTffFicx7NVipVgXr+sachOMHABKD26yz6SE3tn0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642


On 19/05/2026 15:43, Jon Hunter wrote:
> 
> On 15/05/2026 21:35, Aaron Kling via B4 Relay wrote:
>> The reason for this is to properly support the spi nor chip on the
>> Jetson Xavier NX module. Prior to this, it would time out on all
>> transfers and sometimes even trigger a cbb fault, locking up the entire
>> unit. With this, reading and writing to the flash memory works as
>> expected.
> 
> What kernel's do you see this on? With the latest mainline/-next I do 
> see ...
> 
>   tegra-qspi 3270000.spi: cannot use DMA: -19
>   tegra-qspi 3270000.spi: falling back to PIO
> 
> But I don't see the crash. However, on linux-6.1.y I do see the crash ...
> 
>   tegra-qspi 3270000.spi: cannot use DMA: -19
>   tegra-qspi 3270000.spi: falling back to PIO
>   tegra-qspi 3270000.spi: transfer timeout
>   tegra-qspi 3270000.spi: error in transfer, fifo status 0x20400006
>   CPU:0, Error: cbb-noc@2300000, irq=15
> 
> So I believe recent upstream changes in the Tegra210 QSPI driver have 
> fixed this.
> 
> This series does fix the issue on linux-6.1.y but I believe that is 
> because this is really enabling DMA support and so PIO is still broken. 
> Ideally, PIO should work if DMA support is missing in device-tree.
> 
> IMO this series simply enables DMA support. May be we should clarify 
> this in the commit message, but otherwise, I am fine with these changes.

BTW, that said. This is a much simpler way to avoid the hang on earlier 
kernels. So I would be happy to get this merged and backport to stable 
as a fix. Again may be we just need to clarify this a bit more in the 
commit message.

Jon

-- 
nvpublic

