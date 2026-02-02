Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A451DEFE8;
	Mon,  2 Feb 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046733; cv=fail; b=jX7YexvTN/NOCDEaotsUb2WgCt1qXU143D7A/w9Stacr1SA30P+e0AekCEcE4r8Q1m7sEngjJk3nu+SixkQRcBvJKKqduuCKhrzZ2Kj4sDX7MJViieZpD58HBt4dNE1jzPNqZfe39WKnnfNOSGYwCstYYf4ZSpEb+4bjc9N1MgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046733; c=relaxed/simple;
	bh=zWlu6qdOLMjRpPPmHdxVFCZ9gGAjj1aKRDHcXwfZTdo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HWzb1HICurE3QtEjNxA83GLWzPTv+WwtHLjOsSRtb4Go2AEm5WIk7IUkwvdSMzsSn6nzq+IVFKszkJ7gogw1UdrtzzIhcg35/XQGGl3O4jyCwyLU7GO6KQu+SVEen+KMxejhXr2PYKdC5yX5Zu0VrcGRrnS11yNmr0L2pbb1z54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FekdXBu1; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FekdXBu1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbf85UpJqhgL8BTGaeTFnmzjN/d9MPYG1bYnaYVgMlJc/71tbV4apW1Tu6kLrydIiE95cCrdBBZb4zrvJ0Y+MyZOWn9XlZgGqxoh5154mvNdgq4jzgAxnXz2hSEyMYSyK3Qdl2m3CurmhDBcANjb/imt1oFaei/FEEiYrCFN9egx1uWq27vEfeeZqy7jz8Am8w4ceeg14VXdMjQHwXSpFKG97eRnNGQFcUKHV/dD5bUZVHyuFpwE+IKtGmB1IJ8WvNDW/9qOaTO4QaCcBLDwHyDchyJrhC3MNyffF8DQZ1kdyAtq9D12Aa8YNSc55HUaaqGAWNTcqXPv9wE7xsq7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07McWu8HAOtB/IQ/MS1acj5IzTjR2UUMq8i77AWMss0=;
 b=CTHQ1hctpdTSLZgLbnVHmi81mVKEA963kPHCFsoMFvs5iHICUshV9oQwv7Wt10PmTvU5/iN9FPoUJu1qtkAOgsEsPbJxV5kjj/XJNzQm8EQeY6Nz6c2EMSZpGnvl+7YQiJqfnO9g8+NgpYJ3jj1zaXKAgillLqt4tmVf7eDNh9Gk7ZWtq08uo84+43bhpe9Bt1k09H0fjuz7HViSGO7Vtcz2DLjcLt7o6nUx/99xKPo5pla/PhMFWI5ld3gFnq3CuJiyRVP4lbr/b5GDspK9cHpluUdskdf4KTlce8D2lA2lts82nE7fy331UHuvyin42eS19avEyULUA7vwYFsw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07McWu8HAOtB/IQ/MS1acj5IzTjR2UUMq8i77AWMss0=;
 b=FekdXBu1+CHqmO09QFPtCjrESIlgRIyT6mUXfJkW4M7+vN36UsaInctokcziytp7JUU/MkpP+YJ1Lw7qzdlJR52ZaxS8mvTUiihnuAArZ0r1sYzzDlcSUYCK8ELE1tPJ+zfXnnsZNAs8GU4+utgPHY0FvkeTe1jWwjgyQzD/ojZhVd7o7iXYo8AEqEBI+KHtX6QJg1EEzH1UCrhnTKuE+iPxfhLxLXs70dRyxGR1+DtapAwIzEWPPHvbmS0AcKgwZ3/9Wiufu175sqvZXcCbPaX5z8v5NTcq7EnM9H404ptTgop/ghhpNeqP9hy8V699QBgtU5EHzOabShQTUPg0lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Mon, 2 Feb
 2026 15:38:46 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:38:44 +0000
Message-ID: <dac06237-7684-43e8-a414-f9728cd60365@nvidia.com>
Date: Mon, 2 Feb 2026 15:38:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra: Fix a memory leak in tegra_slink_probe()
To: Felix Gu <ustc.gu@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Zhang Shurong <zhang_shurong@foxmail.com>,
 Helen Koike <helen.koike@collabora.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260202-slink-v1-1-eac50433a6f9@gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260202-slink-v1-1-eac50433a6f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::20) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: a009c708-e394-447e-bda6-08de62712623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGlSWVV5eCt5Y2JxSVZqL3Zwa3VaYTZDNnJ0cUowMkk3NWNIL01ldSs4Y0tr?=
 =?utf-8?B?eGVNMW9tTzl1V1Blbk1UMUMvVE9SQ3JsKzBDdVNJRTNNaHB0d1J3Unh3TTRT?=
 =?utf-8?B?RHlJMFVrTzFhQ3FwRjl0enZDcDVodnJYZXZBbUJUbHNVT3k3M0VrdDVZWmUz?=
 =?utf-8?B?R2RUd3NMMkFsZUMxUGQveHpybWEvL1kwM1YwMDdWRW03aTJOc09SRHJEL2sx?=
 =?utf-8?B?NEtkdTZDVVdRN2hVTWxPMGpDT1JZSFBkaDY4SldSYVNjSHJHVzhJREd3Y2RP?=
 =?utf-8?B?WDlKb3paRjNBQ25ja09xNVYwR1UvRCtFODVrVmFnYjBZcDVuc25pQjVndUh1?=
 =?utf-8?B?a1hucDVHbVJSRURPVnlCL3hLMS9rbC9uektPSlR1L2h2L3k5MldqVjdZbWl5?=
 =?utf-8?B?a2hjMDkxZmxGWEpqRE5abHcxb0JjcTFDbFJKRmFXYys5RUtJaTdHUzBqQi9J?=
 =?utf-8?B?WlduZElsYXBFU1lKL2M1N0RYcXVBQXlOY3JiTVNoQWxWbkx3Q0RNY253MHhF?=
 =?utf-8?B?eTZrQ1g3QjFKdDdmSzU3Y2dWdlQyemV3enJ3ajRxSU5XZHB2Z0w0MER6aUg1?=
 =?utf-8?B?YUtoeEt0ZFQ3aVhyZzNNN3U0MVM0MEJlNlBrV2RISFgxOXdZZmIrWWpFVDJ6?=
 =?utf-8?B?bzlwYVY2TkNOa3VFOWF1REU5YjMzT0ZzdEJkUlZvZ1VzUC9HUTI0aFNIakpv?=
 =?utf-8?B?QTZSTlhNTXVmV25kUUdzbFBPeU9wUFhiVCtjV0xVMVA3dFluOUJkdmQ2bWcw?=
 =?utf-8?B?UEZ2NVJpTnZNRE9Ta1RQQ25ORGZmMkNzWGMvdm5yajYvM0ZOWmZ3dWE5U1dK?=
 =?utf-8?B?bFdRVnB6aEtlUW1velZmeVpwR1FSWW04eVVjRUw2NjF4Ulk1TXNxYnhJUXdM?=
 =?utf-8?B?eDdxUHZ3UTEzS0J4Y1AvL3QvcVZlMUttKzMwV250ODUwLzRZWWcvUHdvRUNI?=
 =?utf-8?B?ZzY3ZDB4S1d4K001bGRzYXo1eGR2Sk5Ca1dGQUVqL25uQlNEenBKemhNUWlu?=
 =?utf-8?B?QmpPNmV3NHdRVERkRE5pNzg4OGpkRTRqbkczNkJrd2JmWnRxTU5NeXIyUHlq?=
 =?utf-8?B?NWhnQWxaTzJKdEozR0Y4eTZlSFl4QXR4ZVA5TEdIOXJlZktTWlEvMk50a2R1?=
 =?utf-8?B?eWYxWnBFUFdCbGZ5RU5MWHBTamZZMHRXMkhBZ3NSVU52bjdFbFJ1d2kxRzRT?=
 =?utf-8?B?dlE1UXQwdlRYZFk3UngzNzRFRlZrY25xZjZsNWRlR3pBMXpYNmtDRUticFk5?=
 =?utf-8?B?NmtTRDJWcXpQdHJHOS80N3pyQjdQYmd2eWtHNXhTS2duMU1OS1oxcHQ4NDFI?=
 =?utf-8?B?Y1MxTHJEZXk0L1k0S3hOcGJFMVZNVFJRMkNycVpqMk1JRlJBb2lseW9sd0ZI?=
 =?utf-8?B?RFZzQnYyVUR5dFVhdVI2Q0ZKeGdzZ0JNZ3BKRTI5K21wRWMvQ1Rwc1pseGJS?=
 =?utf-8?B?T3lQY29Qd244WG1WTGpLc3JML3JVdkJQK2hMem5pSkZmSUYvalI1dnpJTDNS?=
 =?utf-8?B?aWg1bGdFaW5WNXdpNml2Z0xQa2lmNGZLS2IxQXprTTg5d3JONFAyeWV3cDN6?=
 =?utf-8?B?bnZ0SURKeUJZdEhrTFNKb0ZpY1VtNWRUNkoyV1lJUjk3WnFxd2hpS0IwdmVN?=
 =?utf-8?B?MEVmdHlBZHdCbmZ0TmZsZG1wVkliVWcyUWxGa2RHWnRCbzdQaFYwWnluWWdm?=
 =?utf-8?B?bmJIUzdvL2tFeWN0R05OZXNPWXlVWVNpNXJ4THpYUG1SWkdWN3cyNDBMWnFt?=
 =?utf-8?B?Z3FuVG1ISmJqU3ZoeE9oYlF4ZExtbzI2QkdIdzNuUU14dnVPMWlkQVhoZHhR?=
 =?utf-8?B?WlUrRWlmdERMc1F3bVBVYnh2TlpwcHNHTU9mVlNid1hZME9TaEtMdGNtY25D?=
 =?utf-8?B?VTRBWS8zZGVFR2pSSmkwVkY0NzhKaUhOVXF6RU9YbjhvbUVZdWZoNFJuMHZB?=
 =?utf-8?B?WDlBdFRWNGhFZDM5VlZFbXpndVNUNE5BaGk5Vk1ZQ2VTcFdKckxxVTcyaVFO?=
 =?utf-8?B?NzZVaTJpaVFtT2RGdU01S0d0OTVyOS91MDJWZFJEUjh6TVd4cFBnZDcvT1l2?=
 =?utf-8?B?OEdHTWplbzBXSWxPTExJLzRDbk93V1RzNEMxN3lLdHZtS29NUUtFV24zU0Rj?=
 =?utf-8?Q?iAJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDhTSkc4YmRUK2dvV00xcjNRZVhsczZ6amw4RXpqaDdBTlRDV1kwcEpPZ01Z?=
 =?utf-8?B?UDA1UXFwMkpiRVRpQzlRdlY4dnhQNmgzR1MrY2FWR0xiMUtpK2NFem5qYmlX?=
 =?utf-8?B?akJCTEloa0had1k2aTQrR28wdW40V1o2UUQ2ZGwvV215UHpydkZFMWpLak9x?=
 =?utf-8?B?czdOTHlZSlVoNm5xU1IvajJSWmVBZG5XcWxaNWVzbmNWV2dWZHZ5bnMrclBM?=
 =?utf-8?B?Y3ZuS2VrYUpsTndjOCtNNWhIWVI3RGQzaVNIc0ltUktNRFBpbWZVSHdUck9p?=
 =?utf-8?B?RUp5emVvOExMMjRxVDlnV3hpTXJ2ZlorNzJmWFc1T0J5bTFrYjdWMDVkaVhr?=
 =?utf-8?B?c01MOE5sMHU4S0FJK3J1UlE3MlZDNzNFbDBvWGVZNUd6UDR4OW1lKy9yMzhs?=
 =?utf-8?B?V0l0bVZEQVpQMllNNDdCcHVCK2hxakhjNjgwQlhlTzlEUlpWV1AwdE9VSUYr?=
 =?utf-8?B?SDZqM2xwUGFDcnlKaTJPVUkvaHRMcHlXbXhmRjBMd2ZwZkNsMTNjZkJicDdP?=
 =?utf-8?B?MnU0UmliM2tYY09tTENJNU0xMlQ5cTVHQTZxdEZKTE9qMFBweU5zNFpaSEow?=
 =?utf-8?B?ekhiaHJCMVdmQW9wK044akcvY05ET214bWNPUG83UXZEbTU1V0dITjF6M0Vi?=
 =?utf-8?B?cWRkdzlmd1l0YjNrYkxMSWZSTzA0V3BYVG4xQjNSTm5NeGNBT2tGQVozaEVz?=
 =?utf-8?B?cEc1UDhTL3dDdG05MVBVNnJKaEdNMWsycUpRWVNRMkE5ak9raTFPYUVvOXpY?=
 =?utf-8?B?V2pDSjZ0UkVqQTBHaTFOSTJzb3NKcXEyT2s1UVRZbHJrS3RENEZxUFhSMHlW?=
 =?utf-8?B?VnNBVUVPcVgwdFJPdUJKaExXY3ZLbkx6dituRlUvUnRXMzVBK1huTkRWVzF1?=
 =?utf-8?B?akpNTytwbHFUM2loQjVyTHpVb3BJeWFmVzRHZ1cySG1Ddm1CQTZKQkc4TDNa?=
 =?utf-8?B?ZDRtb1IzS2pGdVFEZmUvRWJjYXNyK3NNamlMUjdqV3RCZEYzekdnbTdscXZW?=
 =?utf-8?B?UjBIOXdFckhVaUMybVBqcytqL0RRejF6NElheXRhMEdSWjBMelA0dGZDS0dv?=
 =?utf-8?B?UkdOU3orMHY4SGFLdWF1cDFoRmRCcUt0SDhCdE00RXVwL0k0OHNCLzJTSEN1?=
 =?utf-8?B?SEkvS0NET25yTGZpR0R1bFlKelNQVlhPN2dacWhaQ2RSMGhpa3BtTW5wSGNl?=
 =?utf-8?B?elA2a25telJtU2xZYXhaVHJmajBNa2xiVVBjREdaa1U5RTBncGw1YUxQNVh0?=
 =?utf-8?B?bTZ2Vm1YZldaSWx4aG9ncmE3ZmxxQ0gvTWx4ZHJiUTMzSSs5dVFFQTEwSDVY?=
 =?utf-8?B?NFpXS2IwUmtraEhaYW5BVkkzMUttNHE0My9CZHBDbjd0d3VZTUxzRUxNRnFK?=
 =?utf-8?B?aEtjeW93eEZLTUVxOU92eFpKTUpjUWZ4dnBPNHcyQkpKQ25SQlVxb3RDcHJY?=
 =?utf-8?B?WjJOZy9Cd1FiSitUaTIyaUQ1TDdSOTVrNDBBamVJTUxxQnFzalZCY1RCanJK?=
 =?utf-8?B?aEdvK3NVa3lNVVdxc2ZnS2RMN01GU0FCSDFCSzVZRTFoM01HYm1nY2h4bUZS?=
 =?utf-8?B?YjBhcW1sQXVJUHJyNGs5NzF5RUVkU3haS3ZSNjRQSEdpMG9ZOHlyN0U2a09Y?=
 =?utf-8?B?QlU4aHJYQ0VWb3BXRmxsNjhJWHduUGVFYTUrZHZZSmVKK1haVEN6cStaelRj?=
 =?utf-8?B?SlpMTjd4YWIwSEM4eFVMNkIxYjJwU21YRWwwK095b3VwSDNyOVV6Mkd1UFdR?=
 =?utf-8?B?UlB3UnJQdVhNQjF5cDN3RVJBRWozUFpFeFpINTYxWDR6c3RxOFE5YmVEbGxM?=
 =?utf-8?B?ZWJuVnk5c3Y1RTMweUJYZ3ZCQWt1Mi83VnlIWnlGMG5EMjhtbEVuWmQxUk9h?=
 =?utf-8?B?YklCYnY1MWcwNG9FNjFQNWF4MC94VzBYMVFVOUNzZ1B1ZDVIRERVTFBlWmFU?=
 =?utf-8?B?U2pndWZER1g5KzJabnkvNzYwTllhNXdMNmFxRVl1RHNUNnlka2ExbnptRkRS?=
 =?utf-8?B?V2t3TGxIcjJCSWc2Z1lBTmJaM3VBVjZtbFVWQTVkS1RmdkpmZjM2Wm9ySnJ6?=
 =?utf-8?B?cGZ2YkRNaXBwVW1Rc29yYlRJZ2dwZWxKMEpKUzAxTGo0VlM1MkxMRG0zOVEx?=
 =?utf-8?B?c3piVjkwUUJYMy9pNEVsZVBFNCtkd2wvazg5VG4yaW4xVWZNdkRVd2wrRGps?=
 =?utf-8?B?WXlNUkc5OSthR2pyVkN3Mk03K0ZNcTRkbEtXUURXRExuVnBEN2k4WDAxMEpv?=
 =?utf-8?B?T3ZWNlltcEZFRjBGcTFxWkVEVm1ob2hjRW9RN0ZqdFNoU1FVQW1VME1CL1dn?=
 =?utf-8?B?RFlwUHU1R2NtNitiZ3NJMy9kd3V2bDAwODM2T0EvRkFXOXFzcVEyTHhvYVdE?=
 =?utf-8?Q?zEUxVvITqJvmIzeMNdeh0hqx20aypepEU/WkYXbX321gx?=
X-MS-Exchange-AntiSpam-MessageData-1: DA2+AVMy+ibpYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a009c708-e394-447e-bda6-08de62712623
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:38:44.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC9yTIQEwjER+7H1JHAQO0246lztFo2foJ/g5HXWbhhCSZKTQPmrzgHGLt1QQxe3wJNH1ajmJPhPAQg5lN+F5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275


On 02/02/2026 15:15, Felix Gu wrote:
> In tegra_slink_probe(), when platform_get_irq() fails, it directly
> returns from the function with an error code, which causes a memory leak.
> 
> Replace it with a goto label to ensure proper cleanup.
> 
> Fixes: eb9913b511f1 ("spi: tegra: Fix missing IRQ check in tegra_slink_probe()")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/spi/spi-tegra20-slink.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 7d6f3fe8b7e3..8c608abd6076 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1086,8 +1086,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
>   	reset_control_deassert(tspi->rst);
>   
>   	spi_irq = platform_get_irq(pdev, 0);
> -	if (spi_irq < 0)
> -		return spi_irq;
> +	if (spi_irq < 0) {
> +		ret = spi_irq;
> +		goto exit_pm_put;
> +	}
>   	tspi->irq = spi_irq;
>   	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
>   				   tegra_slink_isr_thread, IRQF_ONESHOT,
> 
> ---
> base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
> change-id: 20260202-slink-a229f708611d


We could get rid of this 'spi_irq' variable and just use 'ret', but that 
is another clean-up. Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic

