Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792454246;
	b=R2++Lc9w0aVrSm8/0OcNHyD3gmR4RQh+hfA5Exc6/kMIztnEnv7NbSNh7bwtOg1KpvN5
	 DsJ6sNeLC3jpDFxriPijjMG6yGPtkBD7L0pN4iW8WPYbJsP6f3aF2MFuBG1vOZl9aaoIC
	 SuQZBR7btOPoEYLD80DXK8D38YKEkgDvXDA31Je1U+QQzhrxyZExva4wWO9UpsCzaMAMh
	 8OZilV1xsi2rU7pdIHmn4aYYSOgs/EOofB9RamYLK/RLlghF8+0ptrsQalraFNIk1PwIk
	 nCvVEi6JaKr0LoBxpe7F8F1tTBQVCcTDIifPDx/W83MMLhedvFVsa3Aag/r323fipCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454246;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=RqMIRwBcrVVbTgmbcl+n75XmdCpcUEKjScKVpOGzgVY=;
	b=OLalW6DM7YVgKajMp0kA6y7035HCoZUTcFDWtqOxfNJxCdV/WLGYjscQX2MrJrZiif55
	 kz6bddlRZRkyOsGaHX9sctPPBwIUNhRRqSv8CUjlZbIpcXZe/NI01fVlUbkj1hHCjwnm5
	 FMFQrUCm2O+mR0dncYu/xgtWQKFCAkn5w3BBaUS4uLowfXIy75CqCzfj9bDaiKb4ePL+6
	 PLYWO3uJYrDpuFmmNWq8YUlrOuazIDbs85E0A1zFEf6yC+7rUbtGgVXtSs7QpcrCENDdv
	 eu/RSYKYo/pk6PS7XLTvQqgHG0ubmdwqEVn2YTbppWrTASpu5b/7yjZA1+H/aLdX34g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sord.co.jp;
	spf=pass smtp.mailfrom=sord.co.jp;
	dkim=pass header.d=sord.co.jp header.i=@sord.co.jp header.a=rsa-sha256 header.s=selector1 header.b=JUw8AvO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.17
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFB606A319;
	Mon, 19 Oct 2026 23:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBFB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sord.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sord.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sord.co.jp header.i=@sord.co.jp header.a=rsa-sha256 header.s=selector1 header.b=JUw8AvO3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB9mpFS59ASXSSHvubSUpDRUaUHReDoyxIUwvO6q3bqSr17u2fisk2lV/X5N+nvpse8uXas1U2H6HVyP4SHyfeeXnd2Zn72DwX8JNlc5DHwKNFUctT+lNOQMUz4HEXIZHbILi1Qa6qRoy7cuvbMF8Ms+LVZVJFPHo9KP3oNcCjzZCPaF/9A+SFmUoNgNONlwUXF32sMD5k19upj74cpLda1ad4/RyoHLBMZ64xMmOHJ5WZlsaL8rrE4ajPZ8fEAVjQku57Npe52mHeO+Q3BhaUh+B2U//Mqkc5LNK05BK2ouoH3jZfYP8kKlvoqcWMt/EiAB1sDAV0z6nCbUptqTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqMIRwBcrVVbTgmbcl+n75XmdCpcUEKjScKVpOGzgVY=;
 b=wlu6GIjEuD3ftiGldI5auAT7pmwnOUt343w/0NAxDuE8FNH2d2lwQUW9VGm79jsg/4SDFsVa5biOPV6d3Uje1zgRnJPDhxXf/l8LxjdY+0dy34VvTRkvRycQhyhXOblOuho6aqi3+sUNupitibfd8GPUel6tHo9blz44fSiKd6fhUpGA2dGrcG4X4VURZdiVc2JQpFlb6FeLH6nl5aA4tRN62/NJ5fB6+tE7ThRiTNud9KxpYtCOob7ECRKHjI2BvQh1cnE+KZA2PuelQsn5Bq+YpoGCDrcGZ6gJGc+q+94XUs97q+dD9CDtWOnTrwxaUPXk5W/2W04n1exRg/oOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sord.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqMIRwBcrVVbTgmbcl+n75XmdCpcUEKjScKVpOGzgVY=;
 b=JUw8AvO3IVU2Q6nXl2wYCRUCW1ae0cMbaUs/jHj8KZKwngtQOrcnaK+kWDHgNYrmS1WYBict/E+dPVrTO6alZNTTLiKVcqCIUy03uP7GWxdHzIU7+M7mWTMtwThxMCuqFRKB4OVtrzIRvjsma/W3d+Sd4Iuvj17Cz+znpC2aMHw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sord.co.jp;
Received: from TY4PR01MB17105.jpnprd01.prod.outlook.com
 (2603:1096:405:368::17) by TY5PR01MB18144.jpnprd01.prod.outlook.com
 (2603:1096:405:3e6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:57:21 +0000
Received: from TY4PR01MB17105.jpnprd01.prod.outlook.com
 ([fe80::b881:90fd:7199:d1fc]) by TY4PR01MB17105.jpnprd01.prod.outlook.com
 ([fe80::b881:90fd:7199:d1fc%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:57:21 +0000
Message-ID: <c4f4b51f-b33a-4527-b069-a0637c523f40@sord.co.jp>
Date: Tue, 20 Oct 2026 08:57:21 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: ti-qspi: handle setup clock runtime resume
 failure
To: Jiale Yao <yaojiale02@163.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019084443.1824122-1-yaojiale02@163.com>
 <20261019084443.1824122-3-yaojiale02@163.com>
From: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Content-Language: en-US
Autocrypt: addr=atsushi.nemoto@sord.co.jp; keydata=
 xsDiBD5pq4ARBACDYkbmfj8Thnt/0lQQ3ZL83pkmhTmYHB3fXCXH54s6xiGLifMjZoJRlRk7
 be8YS6I37UqW98CDzL0wh7G3PVoz/IPAFjzrOaOjjb8/hbxw+EljhlLzw6jT1DLp7f7+TRXM
 +wlsv4MKoPaLdJQgE3aF39uNESmOb0NFYPzos4Y95wCgshVvpSxz/n/5GEitYYt0w5xhLfkD
 /2dMwL8EMqwbpMSg9hcMTTjjNRZo+eOkdl/J36OCrl7/JtHrLDIQKR65mR5F2E88DNxZVvpU
 dBAvJ/XnynJTGLldWleRfy108J5hii7NSItfnhZdzzTZmw1cvZphZ2DaYreT84+SyKDrPUuT
 FIWYBHrwXktbd+RGjnhZt14nBUaSA/9F6qNQXmEE9Q/X0RpcLjLsU8xeHZ6afX/gU4/hCq3x
 PaImcjNzF1kIRHniBv0yHjjXTzB4+5KZkUSIyv36zVTeh5P6NKXAWqNzRq3oKOJYpH1TK9ZR
 4V/9UAGbEU6qhnllj70MXs+KsOAt4kak58fGymurLhtz62v90W3cRNz9vM0qQXRzdXNoaSBO
 ZW1vdG8gPGF0c3VzaGkubmVtb3RvQHNvcmQuY28uanA+wmUEExECACUCGyMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbOX/NAhkBAAoJEMp3/pQodNUvl3wAn3lxQmyXAFhllzIFog2t
 Na/9ZiB8AJwN+xEEsG4SNm7CmP2AVJUUiL/FRM7ATQQ+aauGEAQA/TgDTprw/Cfqeyn+2cMy
 ULu7NYa/svJ1mHGeIpRnd8ESyC+YaLqmTiEs1p5uSGPHhVNctbVNcF/pzJPId0IYERwt4Ck8
 WBEQrGGOx7rj+2+eyHI4ZB1H3KH9E6a8U6CJv49W6TP3HuYxWLbkQZIIrdwSCwVZSmzTDhPt
 8OEL7hcABREEAN8nY2k1m66jIgviVInRHzR2mHa5T775M8+97eMcA1W5T8uJELbwWKs6rCgE
 hglDNliA3UJGjEKbm3nvUo5oO44RUbl7nYDWBoffQYVltmLYTAIFoh/D9N/8Bet80bsQAX28
 u2kv363344Ex2GWeDjVQY6rpWsPLwhXFmb0UnlN6wk4EGBECAAYFAj5pq4YAEgkQynf+lCh0
 1S8HZUdQRwABAU91AJ96ztctq3IqC/uwUz5Nzz87N3JVIACfeG/Qwv0DqLn7FtmxwPHmUgnu e/g=
In-Reply-To: <20261019084443.1824122-3-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::17) To TY4PR01MB17105.jpnprd01.prod.outlook.com
 (2603:1096:405:368::17)
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
X-MS-TrafficTypeDiagnostic: TY4PR01MB17105:EE_|TY5PR01MB18144:EE_
X-MS-Office365-Filtering-Correlation-Id: 839478ed-a360-4dfe-444c-08df2e3cb743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	v3io5nnomFEgECmTSrW68gomfu/rFIJ1k8PEApLz+WCGrorVIA6ISNB3Hi4a2FVFtkgSo6c6qv7Qp5CBnYELCKTAJCd8+Eku8lmjSLAdjzQ1JY1GXRuLdwKed51b3eqI0quXOICHmhmbg8vi4k/q4RWf4L022lR1DJV8WYXcFmDehHdyF7TN/Pllcxw2sdssXV1eOQYV/Inn8HQQd8o12aXAW6uYkd/9qnHjASNaxs2WE9qzhu/7xPU92DNXARO/ygtkElk9XkV3LmuKPwcJiSJ7JVIWGvYSrbyb6229RxMHz7DV7ApMuQ/9Wz0FRVnVmFI8zKcjcB62B3XxoiXkYZcX1cdWFCgJ7CIdV3ZPtQKhedTV9lE3XoWj/umbvVsMrrA0vLG6xSHHyfxI5rXEU2bIX7+wN//QDPnHbq5YnruP1MX1hLyWEX7L0kBCnc1qIdjQY2ERwHUbcph0TW/lPubEjWUN5nC6dbj4LluSkLQqbO/nLyfV/BxukuBj0vqsx1/wS426r7Imm7UUM+m537FPbQGyojuijXRjsn7KXk+2wQO9aln/D7fIiiykZ0Fa416u2kXvlPLzco01B6GwX0zU2b6RZne+wwKqzV6eI7gPuXyPKnCb8fT/os6bwYO6DygNKQ7DBYLY9HN+PDFWxQZG70ilGuN/hBzCXD5qpJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB17105.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZadUVwRjR0OFZhZ0FEOFgwTFVjdldEMEdvVFc2cU5QL3RzZUpISCtIeGdh?=
 =?utf-8?B?TVp4UVBXTlIzVDlKSjBLUEw1TW5EaC9yT1Nxb3RtV1VxeE40MzJGTlJ5SEQv?=
 =?utf-8?B?SEpFamtBS29oY3Fma2pVSG4vWEQrWnNYM2xzU2RlcCsrYmhpZWRDcU1sczZZ?=
 =?utf-8?B?aWU4TG53ZEtDakN0QVNHV01sZlk3cytKRElFTko2cnJGSFh1NzJFc1FhQnpG?=
 =?utf-8?B?TmhWcTJjTGJPeThLNTdHTUNLdFJmdGRTZDhQQWpGamtEYmh1Zytrb3Z4ejh0?=
 =?utf-8?B?U243SThGZ012T3B6Z3RNaERTNHgxVnl1Zmo3YnRIeDVQMFFyY1c5SEtyanMy?=
 =?utf-8?B?TzhNSkJwcFUxM0NULzF1cXgrSDFFNjdzajVmSEdEalIxcUZQd05rcmhpMUlV?=
 =?utf-8?B?UG91bUVhYWI4aXFMY2xqR3Z0NDlHQWJyeEJBbXVFQlZwVlMxZG9JKzZodlpo?=
 =?utf-8?B?c2J0YkFhcXdwV2pnWWs2aDhFODdlVGxqN3lSMWd2dnovRGp1ZFc0Ty8wb2hD?=
 =?utf-8?B?L3RMcEExUThWZFJ6dEp6eFJpOWcwKy9PU3dkVFE0aWVMZ0VIVGtxWml3OEta?=
 =?utf-8?B?U2xyKzl0ZkxmTk1VNU8yQVhVVmxzTEN3cWhxV1BqeGUrWjdGTEczU3FIVkUx?=
 =?utf-8?B?Y0k3QmQ2TDZab0VNTm5KMVZycnNselFZcmVBM0VSTmVNTEExYmVJelMzNmsz?=
 =?utf-8?B?V3hLeUlGdWNodWFJcVQ1U3pVWlRnc1BrOGNYSFVWeTYxUFFHbklia0o5dUpM?=
 =?utf-8?B?OU9MUDBGRkhVaGNLS3NIb3FxUFVxNUJlQUdSUlNkUU0vQ1RtUHhRS1pWRjVG?=
 =?utf-8?B?NHFPL3V2NWZvSldiTU51ZTRHZGtxcDd6ekIvdk5acDFoREp0bEtDeVp3RUM4?=
 =?utf-8?B?RUVDQUZjU1RmcWd3RlFXTy9qYWtNMjQ0VC9sTnFyTC81Q2FGVUQrT1hmTkVx?=
 =?utf-8?B?c3RXV29zemZyUFRkeE44TDFteWdGSnNuQWs1dnhtZUE4SVliTWFIQUhPeEtr?=
 =?utf-8?B?OENzN21rMCtDbHJBYzEyVE9wcjY0ZG0xYVlZSEx5eFZmNThaNkVpVi90Y3dT?=
 =?utf-8?B?ZnM2L0dLMEM0RHV2U0ZrMElVZ2hEdEtPTVJxSXdTcUdia1NLM1BLSFJvZXgv?=
 =?utf-8?B?a1FNT1ZVdzNtL0UwdFFQRHVtV3h4dmVYNStSV3djWmZEUmtHMnA4Y3VVbHgw?=
 =?utf-8?B?ZXNGdjM4eXRjbnI0RUpNM1NhR0lzUWtZT2ZxOVBLeC9wSEVWNU5ROUkxTjBa?=
 =?utf-8?B?OWN1S0pONGt1WE1KNmRqamVGTFpSaGxYcVJiNGFzVW02OEJWNzJRVjhjazI1?=
 =?utf-8?B?TE8wSkFPOXp5bmlNTXZ5cUprM1hlUUlieWdhcWxIZnlwSklJT0paU1FMd3h1?=
 =?utf-8?B?UzdVWnhDSWVKQTNiK0k3bVRSazQxcytWSS9RclFON2U1MzlXWWViZVprNGda?=
 =?utf-8?B?T2xDWG5xVUZJd3M2QkdFZWl0RFg4TkVlWVRFcllkMmJzOVlKUHlZeE9CbURI?=
 =?utf-8?B?d1Vka3lGWFBoTmgxaThvZUtSTWFqUGNRUVpwQWxCNlFpTG41a3YrdXhkNVdM?=
 =?utf-8?B?a09VV09hZklueTRjcTBFRGtucHdVbmN3SVNNckY2b2FQeDdOc0IxVU9TQ3Na?=
 =?utf-8?B?TmVnS3J6RE5XMXZJSC92cVk1blVLVGE5UDZlTnVZQkNWMFlIM2owUEp2amZi?=
 =?utf-8?B?bS9ZY3BMVUhtbmRZS21IRDJzbFR0WjNOanFpT0J3VityT2Y2K0oyVW9VKzNV?=
 =?utf-8?B?TW81aUE4aENxOVRHcmdVY3ZlRnExcTdGaldEMC9SWW5NTWdNNEZUZUZaUWhV?=
 =?utf-8?B?UGJxRm5iYUxVdjdWSGhiTG1WbGZLZEd1YklQaDZYMVNIdzg0amZpT3YrVFBY?=
 =?utf-8?B?aytGUTkrenVwVFY2WE0xL1FVQVl2VVo5RnNhWmFUalpGWW03NHMxekUwVkFR?=
 =?utf-8?B?dVh1VnRhZFBUbXVqTDhnQ2NwQnppcWJBdTFQWGpxbW1uSEtOd0k5MjdFdWNS?=
 =?utf-8?B?VGUyZldYWUJPMXNoYmFtVnV1MTdWVmxud012UE0yb2h2TzVRUk5DZkRTcDhs?=
 =?utf-8?B?Z0pxMnE3eXZneFhwR28rWER6SU9zTkQ4T2hnVnVKb01XZFZxT3Zmb1VSbGNy?=
 =?utf-8?B?Tmg0WnlGRHJzYVlGcGdYS1ZPQy8rb0xjMnBtZ3EzT0ZGcHlMZVFQTHZCbk5I?=
 =?utf-8?B?NlBTb1QzQnBmSVQvaXZkbW5IdEhVZVU0blVYYVpmMmNjYmQzeW52TWJtZXhK?=
 =?utf-8?B?N0Q1ay9kaGlGWGRjTEloRTN4TUVBZjB2S1gybHZvck1aOXMxd05yNm5hV0hP?=
 =?utf-8?B?ZVQwcXA5QnFlbUFLR1R3NVpRQU01a3FNUFpBRmdIYWlUL29RRkkzNHVXUVdh?=
 =?utf-8?Q?hUH7sCSkRknd9VjM=3D?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 839478ed-a360-4dfe-444c-08df2e3cb743
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB17105.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:57:21.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3X7XW2MYqyYqtMovZ6YVzId9lvYdbg0w17eVHAP3xIeWdtddJVSvfND5QgGxezzEbWcyOo3TSPnwnneOBfjEuKuSdZ5MDL3TPcHRmY6MLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18144

On 2026/10/19 17:44, Jiale Yao wrote:
> ti_qspi_setup_clk() writes controller registers after an unchecked
> pm_runtime_resume_and_get() call. Runtime resume can fail, leaving the
> controller unavailable while the helper continues with the register
> access and later drops a reference that was not acquired.
> 
> Return the runtime resume error from the helper and propagate it through
> the memory-map and transfer paths before any clock register access.
> 
> Fixes: 8d0b512844fd ("spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/spi/spi-ti-qspi.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Thank you for fixing it.

Reviewed-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

