Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2640EBA7;
	Tue, 28 Jul 2026 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272996; cv=fail; b=YcNvNx9j4oi8k3gWW6K6AkXUCh8CZCthXGWNFB/dHgmPoaS5Ds7NwmgYdrPQGPyDo6J5Bfc+RS11CNAwSJRZcehPp/k4kNUPfgP/yyyf7yOtLmP/odbeIgaSLq41ia5JfZsnkR4vLz2owlXuqQoBw+m/LXC3OShhDYNFyOeIPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272996; c=relaxed/simple;
	bh=As3ZuMnvWsdz1FiTnK06jRwtQemqmuuIbfip0+13ODM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yu4GqxWxERQAjDWF28dlQjPggjzlkbybIjvE3k3BqdTyRq02iAGqx3qNjrMto5ZubaAquamYe0AUC3R0kjdrY4sfSwCWOZ5VbZPgIU0MGQ9uMknr0CqRfdb511xll5Vv2OWQpl6gyF6RmF8ny1fgFdjZp2Osc7KIwAeFWi7ucyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKoV5DQK; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKoV5DQK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMiLJfq7TVLwkf6MB+bOgCvAHkzgJjxnuWRzUuZTQ9EVPvNqeTTOjYw4n09Qof2vyZU16FYgfg9zYRP3Xo8/Wvelnm2TPtWGyxsRSZzJZ+NMkpyFBsePLHAlkWd0+9u/xJKsHA3x5co5zXcldC7pNM8zBJWTK1H+BzENr1syXTFWZE7W9dHbRVA4n3TKx5msrOYkcbqtlJoQ8TbeA3LPDuAQ12oPIDeiR1f11ze/TscSej5MZSIV4C7rqSCs0/7chNfRx9SM3Khq6VeCijeAQu+I4N7BYjT7H+fRksBDr53vP2A1b7OZuFQow9ciJXaGg3FP3VZUD8k98Uvc7oTczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjT+TtypJjJDKMsHPctwMQ2o9NIYhQfDRelw6a/vPyE=;
 b=Lv+QRQqU9W/nALCRdWkN7S/RChhQCvN5f8pSwSemtV1gHTchAaNQChueQTRGv6gLZ3nkxbi4deImL+Hnnvuo7qhenrTF2uerAPjUhqJl6cXUgnUYlEZrQRjGszi4stlq3yDn4OukZrZj8iYya++RsScZByq4RBtS1Igi9eSNNGfJmgNo/61KWoLZF9UzaE1mHj6VhxPp0VzoZtehGoAQekEHNDE7MdTsdbzZLbbbqv8nchcSIFp5UA/JjY92VavhuXh/Hba0MCxYJ1Ubdzo5iuPlDTGu1aVrpXd5Iq/9PrufPFZroiJeaXGGyYcXWX1TwjByd+SW9vtKNch4fKONaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjT+TtypJjJDKMsHPctwMQ2o9NIYhQfDRelw6a/vPyE=;
 b=SKoV5DQKMuGgWEFMNAIPXf5nxz3wTdzas5+F6CJMeX1KGyWcj7aw0o3ZcVxB7SJv7BEAzU/XxrQdmeKyYddKD5fvBPMfQkiF+s8aYXLFqZ5Ei7elEK1Fs+MkRcOj2aG10gA0S96FM02ijMAcX684iSv//xe/AI+/3B/SJK+IGQ1ycaGG7ec0M708SlmYjLYqOj/49XMHRePB4sBNZR/pwax2IiSTDr13FXtB+w3ma6m/UuNrcGACjqd0npWXkXKp2ElehOHOGXfxWjU+UiyYeuBsl38UpP3ip6vBQCP+LU4O6INkfAyhDWOfs50EgWZJy4D2BOwcSDsVGrIFc09XUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 21:09:47 +0000
Received: from IA1PR12MB6042.namprd12.prod.outlook.com
 ([fe80::f308:4e47:d46d:e55e]) by IA1PR12MB6042.namprd12.prod.outlook.com
 ([fe80::f308:4e47:d46d:e55e%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 21:09:47 +0000
Message-ID: <0513a557-762e-4390-b5f3-84ac26a38de4@nvidia.com>
Date: Tue, 28 Jul 2026 22:09:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
To: Abraham Zukor <abe@maticrobots.com>, Mark Brown <broonie@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725042944.1204409-1-abe@maticrobots.com>
 <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
 <20260728025503.162543-1-abe@maticrobots.com>
 <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com>
 <20260728200316.1363536-1-abe@maticrobots.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260728200316.1363536-1-abe@maticrobots.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To IA1PR12MB6042.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6042:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: cca1efb9-0178-4687-b1b1-08deecec8e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10070799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qLVLjkooHobgP8zMG1q2GijMcy6Nh8yJYtlaqNR2PqRmCzcYi7jA87Z6r7sl/5fqbrldpEnkkhtx6SSuxBbzgBsK8EBix0BTIEyzZtsQ7Iyi0UfSZi0KcYlNpySrISfCdUpE04ZSOV3t5aY3qeZ6INYaE9u9EXafc2hB10kwGOdOBlbj+fCUnRpX/RuWRSBTg5jKXCPQ9bkTI80/0QI4ys6I+jKokAruOAipVA/xjyKWIB568zHMr6R+0VVz8K6ErNDJb/jK7lwznn3w9+r6kxw5HLhkIhss9V2KEKf3Fk96rsfdDTE1ElegAqHQE9LgvcaptvpGESLbm4OSCD272DIiaMBqS+yY90f4c9QI+RPEJvUX2Pq+XZ07jpPoW5N3b6Jvk51eB+apZov3DTWMMRiF8H40U7f/UL9azOvaQUq3lTom4129Bnw+zs6akyPe9T3ZdgVQR9k6XX/+MzsgWiM0ZkXFuahnKbOFG9QWpdoRwuA8X2bXhu3F2+UzOEwy/zT66ea+OBbxCONr8j4b/8L+MGNvB0Pc9or7nHLv6GlzI2Yeybw8zMzN/20YcquGDfWs6E2WZabd8GB1fybi5n9AgV1AKwW8Yqq3lj+DB8i/vXFczHONm26Fp5L2DXpctiPe6R9lklQqVxQx8ED0g1kwtkrAb7d0rfYOzeCR9HY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6042.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFOcXhybXJ4dEdyak9SaWpYT21pbWg1TTUramRVTGVCajhhSGJtZ3VHYjli?=
 =?utf-8?B?L1UyYUhhYkZOQS9uaFJqc1g1ZHAwR3plbm5PVlJ0UlhNdGk0UUxpYjB1VlJY?=
 =?utf-8?B?bWVQbUNBNTdhQndnOFQxcENwNnVzTkozK0FGSmZ3SnZhcDBCRGx4ZlNRSmZ0?=
 =?utf-8?B?Qk1RQjA1L1ZUdVNLYWU0c21OdGc5NWJ1UWJtT1cwV0dxUjkwSTgycmlCeUhP?=
 =?utf-8?B?YzF2eFBWUmVTcVArRTBGM0k0RlMyd214dU5IQ2dOVThQSytoSXZsdm4vbzUy?=
 =?utf-8?B?MjdDZzljcytqZ050NkhGcXBrR1hPczNrR2RoUmV0a280cFVoYUZQemQ1VWJ4?=
 =?utf-8?B?enNqb1NxYkNmZEVnZWVkckFCcjZlZEhQTk5WN05WNHlrZjFTSjc5VUhpSDVW?=
 =?utf-8?B?SGE1U1owSGJpeVFLWDd6MkVLdVAwQ0dvZVpFTGZzVVgwd1FDVDVtcHNia1ps?=
 =?utf-8?B?bE1GRWxCZkg3SHJCUG9Fd0RnYWNtaEp6ZGFITDNZQmV5aGV4UmpxeXdHTktn?=
 =?utf-8?B?cXc0alZaZmEvcWhkZHdqTGgyQU9VVDZjeTRyUXNRTG1la2dyQkVMZUxHTXND?=
 =?utf-8?B?RHRCNUNTYWRQYVpVaDluWDZ3WEdzRGZURE11c2x2bDFBTGIyMFJEeUl2ZHMx?=
 =?utf-8?B?ejhPaTkyVFg5aEhMcy9EN1lHYWJWeGtzK0kxY2JPN1ZNWng4cWprU2d0MFhn?=
 =?utf-8?B?UkxnYWhncitOUlR6Q0lzM01BV0lWVEM2RkRRakFDVWhsVnltenpNeGFtckNp?=
 =?utf-8?B?MGQrM1JqcWROZDZJMVRHZ0pRNVFYWVVNZFZ6UTZ0dTZEb0dDbjZyUW5jREVM?=
 =?utf-8?B?Z3pTcEdFNFBJNHJmcFg2TWhrUEpUV2MvdlJwcTFSS2lmRnZjUlYways0a1RM?=
 =?utf-8?B?RlBTaFNpd0VBWnpwK2JPREVKdEYvb2lUcUNQdlkrN1VlUFFBekNKQWxoRHp0?=
 =?utf-8?B?M0E5THI1REh5cXVMZU5VM1UxMS8waDF5UzZURUd3SGxTVlhsdytlWlNoL2Fj?=
 =?utf-8?B?eFpkZTZLSFJKWWh6V2dlM0lRREF2TGNpZEVjY2V1NTM4S090SGpPM0FCZmNY?=
 =?utf-8?B?NE9kdlF0c04yNVM4Wk5vOXJEOU1HVkFIOVIwY2MxOXF4RGhwVHBmT00rb0Z0?=
 =?utf-8?B?WjZpbEkwZCtVNTVRbEpuWXUxaXNORDV0KzVnTEN5UDdBeXFPZFg0TmR2bkx5?=
 =?utf-8?B?NExWWDJSVUxWUGNuSmpwYlBibzViRTVYS2NMc0Zpa3c0R25hd0gzcEIxWDAy?=
 =?utf-8?B?T0lod3o5OVRVQkN1QlNncmJJQ1ZkYkdZNjdBWnpqQ3g4aFR4cmxGMTFXOXJC?=
 =?utf-8?B?WURKeWx1dTY2cTh5RE5DemRXWGthQ043RnY2WGs5K1N6Q3BKY3Q0eWw5aWQz?=
 =?utf-8?B?amNGQjlUVEdYcS9zdEd6VTBIaExjbWtDVDFmblNhakFFeVVUZ1VCaVVibVRY?=
 =?utf-8?B?S2JaejN4TlBKSUxPbzI5TW50RWVNMGJraFU0KzZZeC9iRVVFdmQvU1k3T3I2?=
 =?utf-8?B?STZaTHpaeDNSQmx5VXFXN0V2eUNhZWZjV0JheE9SSzQ2T3JhRzVzMktKUXNl?=
 =?utf-8?B?SlNKMHJPK09TS0dPNzRMMVloNlFyQVhicml1cHlqakVQWEhSQXV4WGtyMkVD?=
 =?utf-8?B?M0VlL0lMbDZQVjIrZ3VpMnI2ZDRuVW9maGZVbE5IeTVzNVFEUUJIbk9MQ1Fm?=
 =?utf-8?B?U2NONlNNYTZRQUhLMlFHS3BzS2hhVkd3M1BFQUx1Wnd2MW1YUVJsbVJrc1g2?=
 =?utf-8?B?L2FhdHNKSjc2YnRLNTl5Y2JCZ0Q1WEEzUnpYbXNxMzhrSXc1cDBKdkFYRzZE?=
 =?utf-8?B?SURQejgyV01rRzRQNVN2eUFOeHJ6ZzBIYXNJZ290dGRmY3I3OE5iRlEzNTlY?=
 =?utf-8?B?K2g5SysvU1NkNzNZclJVN2RUdElZR2ZVdTA2bldTbWFiR0lXRXFNRkI3UTdR?=
 =?utf-8?B?TTZHd0JEbm5RS2NYK2Z1OHQ1Nm9mMmhsZElzV2NkVzV2L2JheGtxMWlKRnRI?=
 =?utf-8?B?MW1nNE96M2Z2NC93cXZ1MVpxc1h2UFBadjhwSjFacFlBdENCWXh2TTZ0VGty?=
 =?utf-8?B?RVlQakg5NXlhTGNDZW9KUnh1NWFMWlJlZGN3cjRaRUNuWWJyQzVsVDBNaE4w?=
 =?utf-8?B?RVErV0p3cTJOdTlTTVZweVBEUGFaNlBUQjRTYStScXNLbTBnaXVJMUhnSC9y?=
 =?utf-8?B?VlVTVkt4L090UU12Yk0rQi9wN0JFNGRocXZwSC95TEJpSWlhZ3BsUUVzQ0ho?=
 =?utf-8?B?Zy85RDhaaCtHOHQwU3kxKzRMeFd6bjkwZDk2TFdsVFFDV3JKZnRuVU1oekhQ?=
 =?utf-8?B?a25hMnN1bDdmTlIzWmxlRzRMOUI0WEFwYzh2WElEVERvd0NwaFpQQnBXRFNF?=
 =?utf-8?Q?qZ4Bs84e5PXeqtjxEQSMDwRuN09iF8knERJAQYl9RNRnj?=
X-MS-Exchange-AntiSpam-MessageData-1: 18wtoQebC2u+4Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca1efb9-0178-4687-b1b1-08deecec8e15
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6042.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 21:09:47.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDeCPnCvcv1XlxSnSJv4/msgZexMKjjBz1JHRB8LTQa2lqpMEg4jc97R5epxt/gf1Y+ANKF/eqsW3ZQq9wqa/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346



On 28/07/2026 21:03, Abraham Zukor wrote:
> On 28/07/2026 10:34, Jon Hunter wrote:
>> Exactly. That's my point. Which is the right one? The answer is
>> probably neither, but whatever is present on the bus.
> 
> I think that defaulting to active-low is correct. The Tegra234 SPI
> controller hardware defaults to active-low (all bits in CS_POL_INACTIVE
> are set) so an active-high device is already asserted before this driver
> initializes. I checked the controller drivers under drivers/spi/; they
> either default to active-low or preserve the hardware default.

I am a bit reluctant to make this change after 10+ years of this driver 
being around.

> A more complex option is to scan the device tree children, check each
> item for whether it uses native chip select (as opposed to GPIO CS) and
> check for spi-cs-high. I found no other spi drivers that do this at
> probe time, and I don't think it's worth the complexity, but I can send
> it as a v2 if needed.

Right. Although this patch is specific to Tegra, I am guessing that 
other devices could also face similar issues and therefore, it would 
seem that having a generic facility to scan the devices would be ideal.

Jon

-- 
nvpublic

