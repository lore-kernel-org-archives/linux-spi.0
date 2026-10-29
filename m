Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289986;
	b=rasaKkToP5QqPjzLTbRslTiNJtkRpfLul28vSMMVgpTcExQJod/41yaqC/Uyw6GFmr2m
	 6b5HFxI5/0eRitKs04peltkTB3ZMZtDa8UCJ4Mlaz4atlQzob2sF+29WDNMxzLcvunksL
	 sTQSh9SKkY7I2Ciz6eVDNewV8xJfbwXUMsC9L5Hva7R9Uki+sAl5KpUsb6zwPoVAHHt1e
	 RumGWLhMM5oOTIjIYEKJZI3BRN3kj6TeZqXkyUFl0SwTW5pLHivZdjmMXgUR19TWwKaBt
	 87x+lSmv7v+NObI6oLQ2t5u4kMadUHcHdJJ9LrqxA1xUA09s05oQq/Dbs6EsddNArYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289986;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nvUAaeF+iOpZk0nyfp1NHbus7ourbOiVLvpvZv6WSIk=;
	b=Jk2xtVcf8ChcTxVCIlmSLSb3OM5wj1fL0/9jbk+aOcQY3pxaBOUa/TSMCQ0N/v5XgsKV
	 qVXWpg9VGEw8mqD6tsWCU34MMAmS3D3Y+KMKg/HY9MVR6POTe+PyO9rww22hwhTOLu4V0
	 Gc6NkQvXOgkB/n69FQd4xGniW2yJukMNZHYT5iCF571HRkDQNshcHhMTwInWjOnKbfTGE
	 LapLwDRqdmaAxTy0eR7xbn7UU+Vg52VMEw+jhHyRNTXzkeL6KHFZJQKUOhbMyzCfEk3FE
	 kxAlpZxTxUWZ5NSTIghf8FTYEEkEuIGCaPE709hTtDVl3ysN2nHAI7BNKCvUKSw6qTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kR0Me4bN;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="WlN/iANN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39A606A31A;
	Thu, 29 Oct 2026 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB39A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=kR0Me4bN;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=WlN/iANN
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TFNhta766801;
	Thu, 29 Oct 2026 12:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=nvUAaeF+iOpZk0nyfp1NHbus7ourbOiVLvpvZv6WSIk=; b=kR0Me4b
	NZvn93AUoriu3pHiONGr0PtzSi09sC42tYuJtYbsV+cTL+hpkIYbOxGd7yZDFfri
	t54GcfOecS/qfcokkqw+t72K5pHnElylhFu3G7DEVfadfNqT68PS8PZBHyUQPMEk
	OQPOVocgj3f8rsCE4FRfUgEzuL5x+3T/6YUVRXBcTQvnAGFxYmEnaWWZCnK6/LMY
	hY7lKnku1Mw2psAzCIiRXuo5Wk7YKs9+4MV8IXaRa3OoR0oTKnJEhDy2zeW60U9z
	pLQ8ipVZdLx37LcNHkkTuMJe5Z9yIH7RKTvzGsDRlczj/YrBc51zS54qJThcDMVY
	2t5Bw4jbMK8JOnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nvUAa
	eF+iOpZk0nyfp1NHbus7ourbOiVLvpvZv6WSIk=; b=WlN/iANNreYlAGMHUP+u+
	6lQuF6IFm3AhTTMiVy3r/x3i4Qt/2+mbdQUCNvJz0ItGdx3GAL4UHRVodDuIJMUG
	L/bea/P/SxCG8x6CaQAAufszjY1MJTgRFwugq+MY1GHVWueV860K5aChGGfaFfsL
	UnemT5mijACE27Elr0Y5loYxa23vJwG+tVy/d9uG8QvzJPMxYNaD7b9gKtMl+duU
	Bb7PMaGxju4Xx19K/mXDuX9wT4UQygt+XmKf9IzpW64saIFmw3fGoqaaLC1Kqm7Y
	t8Vpt+xVOYqUW7J2M5rKjy7cjevdKGK76UuS2YM1VvsM2EZ+2T6RNh1zZS0hJjCe
	g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hkv6uvcj8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 12:06:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqmXx7oLwiibGeXVA/kPVYXBgfRM6FkinmO/Kf52riYBfyKzGJdfud5Kg4ST08bkb7GkGwiip0NL889dyqoeoaNQjzWtT1dNtdPo84a7wW1etXmp+k845MGCeTCtQC3rKdMlufh7quv6wPhuu2hlG5bft/mswb6bDvi04R6mAazSgaCStfDYOvwEDZLNJdJb7NLf/zw1IaINPkhr4m2pv0En/cqn06kWkZ76f9fuhgGzIU/fk+/S4d0EctlKcddejCPzPA07MZADeVC/ObY0Yf6hRQXMABZN3Cm3M6GRhw/dFuVxlUDpKL2unRnIrl9fwan4mMmb9FbMF+XQvExhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvUAaeF+iOpZk0nyfp1NHbus7ourbOiVLvpvZv6WSIk=;
 b=Ifwg1fjn8vEfJ+RAgaRGgIzxer8ugMYg2+XLmMs24oWnhrAQK4yA8vcJLj73z7pBIyD3ohgSXf0AbOMW0aaizECZAsFCwgqe1xp+q95AsuF17Wk9ZgUywqDz1LsRORNClAyII8GtYpdWMhjiwKE+ZePJsYA/XKeY2qxcgWk2iuXN1XJNAIw+dQ1neTWaQxpkhGv401cJRn/g+fPb2vDs+wz6v8ggWLlk6L27s2VOvHOgm5cUP6qs9IAdaVC2gnpFW5fN5Qtad4m7r5DQ0yMzZ8b41qa+mqg+bC8fCTPUvckB+ZxZfyGrIappKzgNR4a0ITWi1mkxs3PSZ6/QQ70Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB5255.namprd03.prod.outlook.com (2603:10b6:610:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Thu, 29 Oct
 2026 16:06:05 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:06:03 +0000
Date: Thu, 29 Oct 2026 16:07:26 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Parshuram Thombare <pthombar@cadence.com>, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <auNu8LJ6lpHqCTAH@nsa>
References: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccc3f59-4c62-4833-1e9c-08df35d68809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|7416014|261009223327099003|261009220027099003|261009221727099003|261009221227099003|261021121427099003|261009223027099003|261022075727099003|261021123027099003|261022105027099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|261028144727099003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	7aSOqKnEUjj8peBdaXV67vZ21lVDYnxQ23JyhYoMGToaiCKziCnLAXWM9nUMHhdIY5GkfsPGr/oDqLOMxo/Fgb57jupmiDSY//lsJA3+XchaTNJVqL40EIEIOFhvf76ayhf5ToWyIwZ6eQwwQKfEa2Bp4ZzzW55r66kDgCd4sc5kNMwgZHPCSdxzyzBCNyblkV/HrO7upCEv6eZGOv+dNvTPyy9YXPpUpIG7d6dkQcX0OND7wltOg93hy9opsRoKjU332u2OQ+eUvRKaPG24s+dI3fQuNHA0d6lESJdjC9b2zob1Qjx7PA9VXpggx0o4Z+aijAV7Gd+3rQXg+SR7NNr0oB1XtqtxrO7sWyVa8vOnwQmSjQcCOf9xSUAO7v6QrWk+NTp8c5wGSeUs0Q/BSMR8E9IA2wYhPhjGbtyVztydXpj/wAibbH96UTR6F0rd7lZZjzu5jBtAVXujhDJbUCPQvPpogU+kvdJDkzbQQPPSXYkehqHK0ET5CqWEWe/Wqsxcre61WPQRnie3uWWCCiVvzzwCKLXwYRAMvqF1hJvKDdKcFU3PNntN0XdXX/SePtj6wUh6g3qFivO1QTAfpZffCjHzDpk0tDuJhLWa5sgE7P0fee8zJF84mOwk8pHD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(261009223327099003)(261009220027099003)(261009221727099003)(261009221227099003)(261021121427099003)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(261028144727099003)(5023799004)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlpScXA0ckE2MkpmWDV2L3czTGNzanFmbnVqdTE5Qk1tVVRzeUF1bU9SaFZO?=
 =?utf-8?B?ZU1JZlpvVkNCOEljejltVkZnRWpNR0xCMXlTSkVhVm1OemlXcDI3SGVZUlAr?=
 =?utf-8?B?Q3lxVjZBZktxSyttYnVZV0dQVXpqV0l4WGJEd1FGb2w4U3k0d1JTMXNqNCsx?=
 =?utf-8?B?T3kyY3NmS2EwaDR5Q2FqUjhxLzlQSHpyc3pWaUliUzNCUTMzeVFJeURPL3BW?=
 =?utf-8?B?SGJqRGp0K1NMYmVmampIT3VEWGl4WCtWT3NydXh3R01wY0hyZFlFeU1jWEdu?=
 =?utf-8?B?b1VZTU5QRnd5Y0VIemZoYXZ6WXdDRGdodVpCV3l2UWlmMFJTcjQxclQraW5R?=
 =?utf-8?B?RkpzSXR6K0grM0g1TjhLc1NxT2hQdFNuMjFQTXh5VzlXQ1crTkhzYnZmUFRU?=
 =?utf-8?B?cm90aWZhbksrQmlJNTlzY0JvbDg4NktEY1pzT0h6U1dEQTAwZTRXVHF0dC9o?=
 =?utf-8?B?WWlWbDdZWXdQSisvOUpMeWliMFYvaGFVa2F1NjBsSHlYVkIwc0pwaUh5STJ4?=
 =?utf-8?B?WUsvM2JlMk9JeXZPRDgxbjhralVYSWNpRFEvZU5nQVhuUXhuOGU3YjY1d3FV?=
 =?utf-8?B?VFV1d2hSaFhRSng5NmVvbDd3OVV3ekVxQzczSEFRMGN2MjYvbklNanFvT1gx?=
 =?utf-8?B?U1B0KzZwbkRITXJsSjZ3SitBVGtvRHRQamx3dUMraE5MSHlTYkZlZjZqT1M5?=
 =?utf-8?B?TmlMSlRIbTdPN0V0UC9jZjJCWkZMemlMajVlQ3hXbUwySWFscDJ6OUkybERJ?=
 =?utf-8?B?VmliZVE0ZitrVi83ZTVld3dSNVNocTZabHE3UGw2NWJnUVVqSk0xVjBnSHVQ?=
 =?utf-8?B?d0FZQXc2c0VhTTV0QUlDOUovR0x4MGFXeUxuWFp4NU9sOFlHZU16U2JRVGZo?=
 =?utf-8?B?VGZMNDVsVEJSZlpJVC9OcXN1bmprSnIvemhpV2V6a3lOU1lpdTJqZ1RRM04r?=
 =?utf-8?B?ejQ0SUhVYnNVZktVaVUzc2k5SWFuTm1Dc1J3YXk1ZDZjMktJTTVQcm8xdEYy?=
 =?utf-8?B?cFk0bUkrbVFyZ0dOSVl4TkFuUXluZmx0ZW5kbkxGSGVzTmt6UEZ0M2djQnRS?=
 =?utf-8?B?YTFkZTVaOW5QTGl1WlF5UWh3M1gxY0R1dlJVcGdnZGZLUFQrNWV5L3BqTXB4?=
 =?utf-8?B?ekRPd3FQamJhUTlHL2ttM2w3SnFxRnErSFl6b1RFZEtWaXU2aWVycWwwNEZj?=
 =?utf-8?B?bTVpU1hlVVBRTzNDcmZtTGphdCtiemRDUXNhc2wybkRMQjBqbVM4dVY3U3lO?=
 =?utf-8?B?b0E3Rm4xWkFyQzhjb3pDMmQwdmkyWFVzdzJtQjZIL0VJN2wyYVJJak94Y1Y1?=
 =?utf-8?B?NXNuY0JhekgvNFZBaUwvVkNDb3NtYlVKclM3ek0xK2c4VEhoRUVFMFNKWWpS?=
 =?utf-8?B?RERFUENzNWlXUXFXeWNBQmNHR2J6NlBPRk1DU1hlaEVWSGpBQ2N4NWZ0YWJ1?=
 =?utf-8?B?ZUdjRDNHOG1KSWVqWXo4d1FVb3dDV1JsTDQrRkVRVS9KS0ExS0JBdXpGclR1?=
 =?utf-8?B?b1JZNHI3WDhsV21KcTErOFo4NG9ZVFBPdkYwbnBRNlFYVzJyZTY5SnNLb3FZ?=
 =?utf-8?B?TC9BNVcvTHVFdDBJSWs2TzhzZVhoeU1TTERMZ0hWWDRpVExhRGpNTGFoVTE4?=
 =?utf-8?B?S2NoT24wdmNMckpyeTduQUFCR0N0dGdRVWJ6NFl1ZGUxQTI1Umw3Y2JtaFl5?=
 =?utf-8?B?bTNVMU1vUk1Uek16OW5RUGJEQzNoS3ozNjY2UTEvUjFScHF0S1pqbDJFZndX?=
 =?utf-8?B?anlmSnlGdGJSenE5M1RIWC9XcnJTdUdGWUVUZ3pGYS9VNUI1NENDOHRxQkMr?=
 =?utf-8?B?bWpJakU1SytweHZXNTRzRkxiSG1GS1Bra3dMb0xXekNrY2F5WGt1Y2ZaQmRW?=
 =?utf-8?B?aGFwZWZ2SFJ6OUxaMCszQnBPMDAyejgvVW81d2VlS204NFBySjJFT1phNVpi?=
 =?utf-8?B?c0pSaVhEcEZuR3JhMHZzS2N5cytVOGc4cEpQU1JpbEdRcU9MV3dWQitIb2Ja?=
 =?utf-8?B?cStFRURYVlFZT3NSZnNiZVdHdU8zM25EYk1lMHBYVnAzTStCWCtpWmtjL2xw?=
 =?utf-8?B?SXBsbjVodW40UEJtaVFHZEJjU2M0bkZzVFRqaUdocW9SSU91bFJZYXBUdzlt?=
 =?utf-8?B?MWV4UEVFRG1qdkRYbkRMbTBvY0t3SVdXM3dIM0VkNHhKZG16aW5OOUJldkkr?=
 =?utf-8?B?NlQ2MmI2NFdrMkY5eC9XUG9YN05WTFhhMHVTR1dGekk2YVN5NTYvcU9YMEh4?=
 =?utf-8?B?bGo1OXl6V2M5eVlVZDBmZEFEMk1idEVCNHoxcXBscEpFRm40OWNTbVhyWnI0?=
 =?utf-8?B?bVZZOXhJcHhmRit1bVVPeFlMMGs1aWtYZVZiNFdaTisyTUQyQndWZz09?=
X-Exchange-RoutingPolicyChecked:
	I2rMjwvJf2dJlqjeck3GbiWb6cHwSLSdcizQHc57adbm2ijSPqmhEc4gxmS6P59S7UdWXLk61CF+lD0golgtZRjCjz0x3CXFC0mUgBOZuBAVR6Rldk6+TiH2+uNTWFvItmCi7GKJvncEJtlFLdZ7jaYyGu6N9NWqVRYB5jAVNU/wmUU82gNEHCfP6oH2zcVBKzskE4mo5Ue/gwFC/avL1P5AYDk70hvvGxi8lJBUoV6M/0WK3EoBLwBs1zrLfid4SX93iAS1uwCU7V0akWFapaS62Uhy2aAJASczpupBS7iZM/FwXNISqwswO2gw492kSerKe+ujL4H7vjiHrwO7aQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc3f59-4c62-4833-1e9c-08df35d68809
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:06:03.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcuoJ5QkoLJwKmqGzAkoxuIFtNQ+MuIuX87x1v0vpidxSlmKwIjnsTvJET9qqmLrxkg7fP5rcKfhvHL9zHYV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5255
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXxWUFXnkUguRu
 cf6WHolF/uyTWV7wYBGF12Urhd4CtxfebXKsv9bJb/vkXn5aTbwrgaoYoPW8O6RA231TlZskvYQ
 sUBL7oOKOkYhVV2a3+AsMIGwVr/+a5SwwLG6rANslDRO2BticRf+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX5Arwa/19vhDB
 rZLM9xdV/HHGvICWMrECYGvWVeqw3sQmtm93oR4TXkbF9gBJIG9wGDI7h23JN5Qpqza/Q273P+r
 e0HslB+/KJAKCIpVyKTrjmVmEaQlR0jdA6eXGQxNJm4l+WDInQer2Fl5FsjIx7y3TWq5K/wRhnn
 cLm8mVLDKfXQFZTOuaBKVNqA9OpgPwAhPOmMF4a1IQmD/W3PB92hqo9MYIF+b3SuecqzucxGDtw
 uc9c95IwFaqawvUVAiSE4pzXDvqjX227pJaY6MrDBH4i7tImncfSzMs5bXKHdMfvrzQxJbcr2b6
 20s/qfyMBWEKoHh/4B8r3XQVsDLzBBIqsQ1lne3vYWlkM1eJMbM8ZWBsSCTOfgl+f9L3jPGTpGS
 FuxW2/yjOFFkBnqpKQ+1h1/aZByKyFuKQnvQJ3Ds68CL2ev8iTa9h8jSk315XhCRM9jv2SzJ+wt
 XPObLu4TFceOFqwpvAQ==
X-Authority-Analysis: v=2.4 cv=U4QHnuru c=1 sm=1 tr=0 ts=6ae36ef0 cx=c_pps
 a=lV9semjb6HF4qJ8WeHToSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=VwQbUJbxAAAA:8 a=oX8nJL4KjksvM-XJzGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: y27r3Y0Y1HteIY2b8JDIejXV_ZGpv6FL
X-Proofpoint-ORIG-GUID: y27r3Y0Y1HteIY2b8JDIejXV_ZGpv6FL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290062

On Thu, Oct 29, 2026 at 03:53:07PM +0000, Nuno Sá wrote:
> The Cadence xSPI driver currently drives every operation through STIG
> mode, where the CPU builds each command and drains the data. The
> controller also has an auto command (ACMD) mode where it runs whole
> sequences on its own and can move data with its internal DMA, which
> pays off for bulk reads.
> 
> Whether ACMD and the internal DMA can be used depends on the SoC
> integration (external SRAM, the DMA bus requester interface being
> wired), which the controller registers do not expose. Hence two new
> devicetree properties: cdns,has-acmd and cdns,has-internal-dma.
> 
> For now, ACMD is only used for reads of at least 2048 bytes with an
> address phase, using the internal DMA, and only when both properties
> are set. Smaller reads and all other operations stay on STIG.
> 
> NOR and NAND are handled the same way: NAND operations are still issued
> one by one, not combined into a single ACMD sequence, so no NAND
> geometry is needed. The real gain is on large reads which, for NAND,
> means chips supporting buffer/sequential read mode.
> 
> Another attempt for ACMD was sent in [1] but that relies on knowing the
> NAND geometry which brings much more complexity given that it needs a
> proper interface implemented in the spi-nand core. So we agreed on
> starting with this simpler approach and then build on top of it if we
> agree it pays off (mostly on cpu load).
> 
> Some stats:
> 
> ACMD
> -----
> 
> SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 106666 KiB/s
> testing page write speed
> page write speed is 1035 KiB/s
> testing page read speed
> page read speed is 15238 KiB/s
> 
> SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6497 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 44137 KiB/s
> testing page write speed
> page write speed is 6336 KiB/s
> testing page read speed
> page read speed is 16842 KiB/s
> 
> STIG
> ----
> 
> SPI-NOR
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 64000 KiB/s
> testing page write speed
> page write speed is 1042 KiB/s
> testing page read speed
> page read speed is 14883 KiB/s
> 
> SPI-NAND (Cont mode)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6564 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 18823 KiB/s
> testing page write speed
> page write speed is 6400 KiB/s
> testing page read speed
> page read speed is 18028 KiB/s
> 
> For now, we have a static threshold to decide to use ACMD or not. I do
> understand that's not ideal. It might depend on sclk and number of lanes
> so not sure if that value will be accurate for everybody. So, open to
> suggestions if someone has something in mind regarding this.
> 
> [1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/
> 
> ---
> Nuno Sá (3):
>       spi: cadence-xspi: rename sdma_error to xfer_error
>       spi: dt-bindings: cdns,xspi: add ACMD and internal DMA properties
>       spi: cadence-xspi: add ACMD mode support
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml         |  18 ++
>  drivers/spi/spi-cadence-xspi.c                     | 269 +++++++++++++++++++--
>  2 files changed, 273 insertions(+), 14 deletions(-)
> ---
> base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
> change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
> --
> 
> Thanks!
> - Nuno Sá
> 

Ignore this one! 

Somehow lost connection during be send and only this went out! The
complete series was sent afterwards!

- Nuno Sá

