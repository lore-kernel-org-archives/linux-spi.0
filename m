Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794242268;
	b=X/JKHA0WKASCVhpC+NlyWm5VlRR4lzUk8zJ7C2bGLeR8flEzLq0iEY+xC6N+uP8Ut6Vi
	 9CRYZvpP3buXxS4IU5LwhgMJ+Q0Nwxg+wy41GkBAjVa4SteUlLgx6ru823OwbC94Js/gA
	 /YgzcfN28h16T+6P/jI5uT6lObJh8UMlbUMpx8oF8YH11qfsuMYaPoJ5H+w2amyR7z7P9
	 1/POk+Hxzd+4b4lleApEnlGpjFRntYKkCILiLDdcM5IzYyLJXCs4cSKVJnvTJq3+YVFVm
	 kb3Mr1cuwW5zS2UIV6qTEfd9UtE/6GSIzDAQy0uNA+D0QO8SxiNKrQJzHB8MEbZqDRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JkXI4g7TH2Seci2Wn+86S7VOlp1OwSXsbLME6MDXB54=;
	b=WTJxPmTFACo9G51GcdLctkOQY39kYYtOUg2IZ1arppMxeRQgUi9KwwNSDEuT9Q21iFsZ
	 hllU7k515Kd33VxT2nAVwdRCxfGvTDoa88yXWQUPKgtUu6ZyCH4QkBfsc08WdsM+6iSTm
	 GbcFpgFybZ+Pn5adE4h30v0eqF/Qe4SaEh0J+cdVALTlYURc9hxpRJBpfTNSB7sdPuWGG
	 edhiK6pHApcKC7PHn3+r8QfJUOork1kUbg8wqOL098qHB/qzvQPtBdYOs3mIaWN6TbvKh
	 oDPUewuMESCMiArnRQaqmGMSw2E1tSp9w3TxB1h9OcfJrhmUKaF36pAz5MHlW85eduQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=hyvjdx9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.105
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15ED60A383F;
	Mon,  9 Nov 2026 16:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15ED60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=hyvjdx9K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9NDLFJ3C9ucH8IWhyFDB9kKnFZeDp2fYA7Mcgd1Q7Z8nyaOwcyxhUvg0e32+kqWUeEro3aOFu/U2JsNG2X3XPwmad07DNzZ0EMOfvmHwvStGPebWRhzOD+yH4eLAO91l9wcoFQygHwzKm1w3bjHMUlWPEZoi/Kqf+gScBD2Oh7BW8ZqwEZ/8QEnwiDBgxvv7WDTdvDdFJPjnZDse8OdbYpTWv0eB3pOeyk9Ef9llXXJq08hvEheivIs5kGioGjmrLjulpEHNa7JXfL1fQZX/3h6VGlSXUkAjYyBzzX50Zsl4u7HeGtNrNaQSi99FMUr9ZkEr1h6GsViq9KPhR/hJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkXI4g7TH2Seci2Wn+86S7VOlp1OwSXsbLME6MDXB54=;
 b=L9rECj4fRhdRzlmlZ6BZAKc0jphjw57A1Mo1lm1ukpfKoYZmfIGYr9m2zU5QHdDmH5M+PKNIN+q9u/fXh0HKbkqWGMKPkU6lZ1b02C78XWt18FoZV6FEh8mGgx1AUwbPfEQfV9d+VNQVS67J5iZhhqRCtgr9yC0mwzpdMrk9OiasVkyvLZU3MFSLJifjxK4iJkykAMgrdDvD0/j6iUjgvADRNsNxAF+oYmZMsQkP9hewdHVoPWzxZr/Q5gcawrNMxNfCyPHdh/Q6bYXypMlyHtkRvvnBJY6JsdF6uchpDyI06omiIbu9JQQcnrhQ66QDPpk+F2EckicqgeFConIMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkXI4g7TH2Seci2Wn+86S7VOlp1OwSXsbLME6MDXB54=;
 b=hyvjdx9KC7tuWuHVByIIA+I3eGni89b3oJGv+Dpxp0EazLALDsCSRBtVmuVdFfTVEI7LG7BjWRNK7QfjH7hltk3fR81T/3urOuCYsY9Q1KwojncLP5TN53eMZrI+MswPO1A6llltjmKaZYcYTavPw6DcUvxnmu6w4f1xwR19t+g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6173.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:37:43 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:37:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 16:37:39 +0000
Message-Id: <DMQTSR52MFG2.HUM8KW5WEE8Z@garyguo.net>
Subject: Re: [PATCH v6 0/3] Rust abstractions for the SPI driver subsystem
From: "Gary Guo" <gary@garyguo.net>
To: "Shuai Liu" <847807867@qq.com>, <linux-spi@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Cc: <broonie@kernel.org>, <ojeda@kernel.org>, <dakr@kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <tencent_2588854DF4B99B4897B3F4CAFF3461E14A0A@qq.com>
In-Reply-To: <tencent_2588854DF4B99B4897B3F4CAFF3461E14A0A@qq.com>
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d68afb7-8ee3-4e66-5f1f-08df3e7fc564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|23010399003|1800799024|261021121427099003|56012099006|261022075727099003|261022113327099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102130727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	audb4SmIpD1/uwEDeviByAgBvR1PeDtqqEA6jLlnmEqMDYbeg1oTBIG979DQu4kd4aXqqs3oHGjemZp0P57XXnRdaHfUmwLr05S/kWx0gBhr7fsgMlYXNJSYZum1AqIJRpXIwLGM1pq1gZKNEMHZofQVW/RAHfrvXcGjtHTOMujT+2e/qD8iHDpVzmInrU7obGUXIeQoTckDBQ5zrymGaQ8EYWfVRqJ0zBNhl8VZQYRol6jlEmlJ1Q9UrHkk5JsLLVd7OG8Z3ek76mxJpPsN/hpO6qxXyGiQHQq2cqQhc6loyljDKMQxp4ObLDNqZequjXJWXF4qM7v2VMy7BRkKmnccKSe1ncVFcQubAh8Rac+t+c8gE/jH+zU6M0nd5+bplW0bR9chzsPV49QMtD3PHp9z/Tx+YK3mjup7GEQH/zYg7ev0vXPJ8wGAAJ2d3+68FtLmidvqkfZ6NqAy/QmKW9SpcJvsbDnAFLmqZfPVEjivyK/xXgs41b8iV0Jwc4y6gbhudT2smV3uuOMtZjWaczSqQraZ7vPgmMazbOH8flundABeDTPpKr1pKREinj98vPu4lhla4s+5Y01J2qcayZ+35BkLu7VxVhgVVf1U1FP7sAxJ6cE0YddvjfAmDpsSIDALBzNPkaMvbvRSol6rWBVWyBy8A1MvexmrMQbdthc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(56012099006)(261022075727099003)(261022113327099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102130727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0JQN0dCaHB4eXhNM2dZVGhBUTNVYm9tY0xZY0ZxTDFpNlhWU3hERm5tRUtp?=
 =?utf-8?B?cDAzQjZVKzBhREQ0UkxTcUVBak1NVkhBWTZpOG5HNUE5UllqT042MGIveHFI?=
 =?utf-8?B?MS8yS2hFSUJUL1gra05pNFdKM3NJeGozWXRiMmYxbFFiT2NlL2JuaWxNUFZ2?=
 =?utf-8?B?REhnUkZpVTI3ZFUyMkdTcitVMXFzeE9taHhWeStxbDcwVVNJaUhvZFJkM3Bw?=
 =?utf-8?B?RWx5WHBRd0RDbERwbjdGaDdOUEIyS3hrNHZPZ1JBbDdtYVNzZ0VOUUhNbmF4?=
 =?utf-8?B?WVk5a1lNZzhjRHNhQnkyOW1iTVZiRlpNM2VuMTVpdGx6d0hpeTM1ODNHeHpl?=
 =?utf-8?B?Y25SalF2VkFNZ1IzeUJCN1VZRHBGM3hEdW5od1FTY1gwMHNEME8wZEJBQ2Za?=
 =?utf-8?B?eE5zT1Vnb3ZTS1Y4ZHRhUlVBQVJ0TUJhclVsQlJhUVlSM1NNUGZOUmlmLzVn?=
 =?utf-8?B?OFZDYnpFYVhJazJLdWhwWTZweWxlYjZJcXM5dmhmR0ZjbElkM2wzVmZ6SjVU?=
 =?utf-8?B?bUZPbCtpYUVIV2lndHVWWXgyc0lxMGY5dThPQW8wTjRQd09hczVPcDJ0N3dT?=
 =?utf-8?B?VFhvdzFwR0RaTElQZXdmOXVkNExqbmh5UERyQ0RZcUxjcDNGK2x5MThtbG94?=
 =?utf-8?B?R3RQdzVxVU1qZFpjWXZvWlhUZ3lnMzhjM3Z2dnZ3c0RFZFI3Y0tMV3dxWTc3?=
 =?utf-8?B?L1BBSEcwTVprRSthbTFIM3VFS2EydmNMbVZDdE5RczNZeWE4eU1EeUgzVmgw?=
 =?utf-8?B?Qk1GcmtUekNCRHZTODJYOTZ0NnBQSUxMMXhCTEdoalMrUFhObDBMQis0bWw2?=
 =?utf-8?B?RmtZR245M014NGJNcWE5cFlIaWw1YlhZOXFEeksrNkthdStiVzBIVkx0a1hS?=
 =?utf-8?B?eVJlN0UwbnJ2Tm1KWWtYRlU1ck5zSXhLL2NzZENYNEZaT1d0eEhUU0JlVzh1?=
 =?utf-8?B?L3dJUlUvNWZLbXdyUFVaRmlYQ3BENWtxWlBBTkFKVkl0ai9GcGtsQnhyTlFH?=
 =?utf-8?B?dURzckJBR1J1ell4UjdQYnpDR1g3cFNmMVdIbjZjOUVVVmhWSkZsdUtHQitp?=
 =?utf-8?B?SitHRE8rUUE5REJRdGZSVmozVjJwaHNQTkRacUZ1YnozS29tV3kzZFgvUjNK?=
 =?utf-8?B?REhFSi96NmR1MmJ1bGswMXhOWjZjSmhPclEyaGxnSXBrZGVXTlBGSStvcjRG?=
 =?utf-8?B?eEFpWGs1YW9MeU5MYXpQMVdOQmxPK081aHNDcm9lSW5zMURTcS9CT3daemJu?=
 =?utf-8?B?Q2VqYjNxdnhlby8wQVpmeWN2ZzRLcjlYdkx2RTJNS3FybFpmNFFZa0grUVRI?=
 =?utf-8?B?MlllS3QyOU5ORTB6aURDSEhKVU5DTVczNlBmOFBBUHBQaFhmZ0tpV05QN3BB?=
 =?utf-8?B?ZndHTnBHT1YzNG9ucUZHSm9vN05TK05GSms4UDJHMWJwekhta2d5clRPWTBR?=
 =?utf-8?B?S1gvME5nQXJCUGRmc0tkNXJDejhBanpRSC9HV0JhQlB5V1ZwaHRZNllHWmhh?=
 =?utf-8?B?SDdHZ2FyTGpLQ216RTQ1Z3RodllYTkc2ZEJhU1BLSlNiSkZwVjRVejNTZzVS?=
 =?utf-8?B?TkVIdDdVR1NHckpHU2tZc2VMYzVlZ241WTFrTEhGcEJEcmwzbWE1T0Z4V25G?=
 =?utf-8?B?aWZ1WGIvTXdjNThlMEVkQjZVenYxZnhIbUZ3WEQyVnNZZjVJamlEd2hlZXA0?=
 =?utf-8?B?NWkrUnNJNTJGL1hseEtVUXZRcE8wTnNuK0xvN1RJWWVJNDVhSTRabENheEoy?=
 =?utf-8?B?eDlxT0RJMDEvSFZlbkJHN09tTUM1RFNFanM2WWdQM2N3MS9RYSsrTys5Z2tD?=
 =?utf-8?B?UlJvc1RzSHd4eC9DRTFUb3F2clcrc1lxUWhoZWZiU3dtYVB5aDd5VE9rZGlJ?=
 =?utf-8?B?Q0M5SDNSbE5uV29td2FhcVgwQ1phSU1rMWhrZjN4dU5lcFFrRmNxd0c3UEhB?=
 =?utf-8?B?NjYyNldsc2FQaGNtM1lNMnE4d0hNazM4Mk5MSFM4dzJJdmlLOVBNR3JWRmxn?=
 =?utf-8?B?SFhtR0gycis4UGpob3BWRjZHMHNqTWU1UXVFWDdQN2ZrNEFMRXk0SyswTjlN?=
 =?utf-8?B?Vlc3em9jdDE1UDQ3S2R1YUM3SVJKYnlRbEdMNXIrZXRWR1hFMi8vSUlFekV3?=
 =?utf-8?B?MjdFdkpWSHl3aS9MM2JaeWRwNEdBakZpTFJpRTNUVUMrMGZNVUQxQk9NYmh3?=
 =?utf-8?B?S3NRT1pnb0pGU2lZNlVtRGtNeE9iRHViNFZMK2FxMHNTenVHMGc2ZGlsSGp4?=
 =?utf-8?B?YXRrVGhFYWxvMlBNRTBGRkt5b2dBMTQyd2Z0RW9OL3NGM2tYZ2pqRUdsSE55?=
 =?utf-8?B?dmtVT3NKWEdlTitibGJVczJ5bmo3K01yRXZMRk9zYXUyNlBacFkzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d68afb7-8ee3-4e66-5f1f-08df3e7fc564
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:37:40.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QORyzveaSvZaLSgPm1toxZYekSilvV5LA+eeb9uKcVp6Nxbb01q+KlgrvFHJ7mj+qTUZloTuNi77N6ZZeKl3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6173

On Tue Oct 27, 2026 at 5:42 AM GMT, Shuai Liu wrote:
> Changes since v5:
>   - validate in `write_then_read()` that the sum of the two buffer
>     lengths fits in `u32`: the C core's spi_write_then_read() sums the
>     two lengths as `unsigned int` when selecting and sizing its bounce
>     buffer, so two ~2GiB slices would wrap the sum to zero and select
>     the preallocated `SPI_BUFSIZ` buffer, which then overflows on the
>     copy. Found by Karl Mehltretter.
>
> The Rust abstractions for several buses are already present in the
> kernel (PCI, platform, I2C, USB, serdev, ...), but the SPI driver
> subsystem is still missing such abstractions. This series adds them,
> along with a sample driver demonstrating their usage.
>
> To my knowledge, nobody is currently working on Rust SPI abstractions;
> if someone already has work in progress, please let me know and I will
> happily drop or rebase this series.
>
> The abstractions follow the same layout as the existing I2C and serdev
> abstractions: a `Driver` trait for drivers to implement, an `Adapter`
> for driver registration, and a `SpiDevice` wrapping `struct spi_device`.
> This first installment provides synchronous `read`, `write` and
> `write_then_read` operations; message-based transfers (`spi_message` /
> `spi_transfer`) can be added on top in a follow-up series.
>
> One deviation from the I2C abstractions: `spi_match_id()` is not
> exported to modules, so device id matching by modalias uses the
> exported `spi_get_device_id()` instead, falling back to the OF and ACPI
> tables.
>
> The series is based on the current mainline tree (7.4 merge window) and
> has been build-tested with CONFIG_RUST=3Dy, including the KUnit tests and
> doctests for the new abstractions. I do not have access to real SPI
> hardware to run-test this series, but the included sample driver can be
> used for that purpose.
>
> Signed-off-by: Shuai Liu <847807867@qq.com>

Your patches are not replies to the cover letter, as your email provider
rewrites the Message-ID. This break lore (and email clients).

You can try "--outlook-id-fix" (but it's not guaranteed to work if your ema=
il
provider doesn't report the reassigned Message-ID in the same way as outloo=
k).
Alternatively, submit your patches via B4.

Best,
Gary

>
> Shuai Liu (3):
>   rust: helpers: add SPI helpers
>   rust: spi: add SPI driver abstractions
>   samples: rust: add SPI driver sample
>
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/spi.c              |  25 ++
>  rust/kernel/Kconfig.test        |  11 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/spi.rs              | 570 ++++++++++++++++++++++++++++++++
>  samples/rust/Kconfig            |  11 +
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_driver_spi.rs |  66 ++++
>  9 files changed, 688 insertions(+)
>  create mode 100644 rust/helpers/spi.c
>  create mode 100644 rust/kernel/spi.rs
>  create mode 100644 samples/rust/rust_driver_spi.rs


