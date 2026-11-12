Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794475907;
	b=kBMFkNXkb+DC8OlEo/6ohK0bVJHBPdxXObeut5YwdOf60RfMp/A730pKnMzBTao2MwAZ
	 FJAuTYbvJ8FUeAgd5Oh4ON8bMh/SkAA8uKAKsYkaakjeZ2UTMVHEj3HUnRKofY1nca7lK
	 uR218JOSK8yRATTN4OkJMr9xjjdu2+Mab2KW0TvougzH4PXj00g/fMSaKVGqEP1WXb59b
	 DTYkBQFpHbk/MRJJCFRQSdG4K2WWXbB9GIi+Y3OpiA3tdEEKJJPZlMwdUD5Ou6v7gqbnK
	 +SsRJumnMlYHXjVsNMZuGjjYi5YCAzgjYB34YVF+VkODeKS1+jVcuiguaznIamGmb9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475907;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Rz+9dxNxlrHZ9gXvw9ErBTRzSWevDUiqsOtoh217A/8=;
	b=aB3KtNBqlC3fESy2caHmLN3i/Uc9HLLMC+Ttp/NjCedbh+zuBWTSgGFIYLibDoxG3KIl
	 329O3WFcKQBKtsDMB/I96Jx/YECY2ovG4yz0xb1pHSbSKFkkaXlTthL/ang49BstF3tNa
	 C8Cb9veYYdfrwf4k2ZcD9hQcyv6yUipfYaYUJkxMAZdVEF96V/wZW++3d3+dTGW6u+6pc
	 eyuS06iDw6owtQWsYNGbzcHhtwzcP/wufEY3X/cZWDJO7Snm1+t55Xb+TSEkExfjUgw0+
	 Qp2iWm790KLfQ5IKgowBGaJmyIuRHHekoUNW7fiXI0EdTISJx6SxpF0KurB2VoEtzLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=HVrCxV54;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=m+UNG580;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE67606A323;
	Thu, 12 Nov 2026 09:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE67606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=HVrCxV54;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=m+UNG580
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC63udb2028325;
	Thu, 12 Nov 2026 04:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Rz+9dxNxlrHZ9gXvw9ErBTRzSWevDUiqsOtoh217A/8=; b=HVrCxV5
	4tzLjOeY2jOePL0kOHR4+oD1AflYa4bs3iiQ8CacxBGxoURnoDnDltV/7Rr/pX/R
	nbG0y9RZ6/TqdibRqXfXVWcz6nxU4YmNM0DN3c36scyGBsJNciAQiGVm83TgYuBQ
	ZvBHSAzGcefFmFybmHqtCiHvRm36LIYMkqszJEqVYpiin/jtVAMJgkIGWUawI1pg
	hEmgq/9tXm/7rQrSdV6YQwJLXMEgRXck3Jtw8MtwIpCJdl72wh4eUDgAFkT+/R8Z
	9OnQssGRSyZbr8GOJ3FhZProJ70NUze7+b2sw1/FRVS1jkISx+eWy5pKpnwo1AxB
	7certrdtclhIasQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Rz+9d
	xNxlrHZ9gXvw9ErBTRzSWevDUiqsOtoh217A/8=; b=m+UNG5805C32oQdE1SplG
	351oDsJko5i29WqgxRfKoayxwectMxSo7f5UsC5/B+W6D1tsJoLxlAJmp311v5yv
	1gq0HYjepkB6rmzg1aD4VTPcwvM8s05rRBBj09CP2GjZVxTTSkIfH2B7ptsFSaI/
	Z/4EV2FBxkjjWaJwMLYL1o8xH1GFhD92hFlYxHQXCPBJaZo4YFPIuMBnx8Mp1z44
	XhXpyxSXc4TmpH5ya2EgsQWEWwtwinpWOUfftf7ParMSUuOObMowfQDLljEu6TXk
	rcnm9fO89fPTt/nk4rlU4ufPjPpCHSRSHqPoNEx+/mQKmKWdI9NtShI3ayglsv37
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hvg580a8k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 04:31:12 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnrIME7R9L137NwgI9AVhCEFc6RtoO/siy8MIi8KglfvbHAwwtHk1j6zlwbkyBlbvs/n5nSa+HgvuUQTyUypW0yJSgVnBhWG644XCKToH7lFK8jCCXFBNZEHHj8ggFldGg4kMt4uKmnF7V4XyWpC2T7plXTBF1ZWDIJi1j6Gd9kEP7+EUmIPVLUWIWeqoekU2zlxT9foYZQFZMq+aSTKk27wbJs8nLJn5ALcZDjQBOwbKkwsIsCL9Wxi9iaKTiWzaZ/9zJuUWbyKMQ+pe8vBNa+eiNhQFW69T2KvNaQRTMyHUsbldedd20c/eyErTNDbvBsRjKi5e5RXVS/wg8AFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz+9dxNxlrHZ9gXvw9ErBTRzSWevDUiqsOtoh217A/8=;
 b=A/npesPKmMZBOC/fvNLO3Ju+lfxL6VC6ckIyIGsfyzP7nMhNpZ/dcZ5LxMGfHze6WulXWUEF8VkO1BfJ4UpDvSZLLFqIM6P5EDv+XHJS871HzULVIqB3zOspgjAlOPbmVEFmmgTLnpKhe79/TM/wKMR6rcg6EfdWYcX0sx6DsEjgWtRqCwJ7GViZrzH4ODURHfmuzuA0ikUteKquaSjp9g+ywPjjHAsQWj7mTn0YRIoeXVDVG6K0eLEhaQCKE9B+gG+7/iOLk9I39ldwDhEgdHWeekU+htpFHkn1LUJOxcYtuk1FKzsNUyajn5Q/4axhXN8la1l7eO5rUHvTWHkVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by CH5PR03MB7910.namprd03.prod.outlook.com (2603:10b6:610:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 09:31:10 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 09:31:09 +0000
Date: Thu, 12 Nov 2026 09:32:36 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Pratyush Yadav <p.yadav@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>,
        Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 6/8] spi: dt-bindings: cdns,xspi: add ADI SC846
 compatible
Message-ID: <avWHJuW2Xj4BJ_cv@nsa>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-6-d339046ada8b@analog.com>
 <20261111-entomb-backdrop-815e4dc81c7e@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261111-entomb-backdrop-815e4dc81c7e@spud>
X-ClientProxiedBy: ZR0P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::10) To DS7PR03MB5464.namprd03.prod.outlook.com
 (2603:10b6:5:2cf::12)
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|CH5PR03MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ba68e6-b5e5-413f-9d9b-08df409faf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|4143699003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	OY8yKW2bgvxoAVC0VBJxSAgvd3cGw6PydOgNhViSi2ocutguIRMipuob/cDZwx9Njp5ZOuqVWNbQMOKEVF0AOOVkTSb6RfpkIID8MchumfGEpHId6xxv9Eawu8qycUsv63eb6jo+wFdiVWLCHAkRbkrHlqmhM3JT8lXWatj7BNCHi6nLZA8OrzSHpHQaNKkkX8A0OYpsGdHUR58jMUkAmKzLtf6xpW6zZJRZDiCaL00fkcMgvX240eoCzybVzhJOoRGg+RSsImgf6TgkDk7SzfGJtmeGIyfRGiwKNxlXeDDxEXoD1aSu/WE4ssY3QPhQtVj3mFVA5YjHtInEA/QwKCBDQO79EDDCmwwaKMz3azgLvA3gnq68X10acQEnEfFewFRoPl0EN877ADS0m3vuemNjGW5bLfH0OPYP738y34PEvi6mIKf7MT7So7gugRyJHJTeUxA3kw8DmaibPehAfPlKov6Gro6FcQcE6LZrtipZ5sv7UastVy2N1ZGi19oBJl7nSLfITucDLn6pb54npGK984R/i2k++A/UcF2RqbRaS/R5d61TiO1VJ5h9G7/WT+vibwp6uCGXghKfcIeUEX4MXgk73PLb6dOvu1ksdbOztdv203citYqDBxSLxDDizLeibmPZVFh0Sjhp3m+LlPHbYztoGZt9ic8QRSZR0Io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXloVzQ2VU4wSGl4OW9CSDczMTFUeitKR0V6MlFvWEE0UDdrN2FXMUEraUcv?=
 =?utf-8?B?R3REaCtuNi9WNGQweDZpTEJ5ZHpqbU5TV0dac0dIcEZ0ZCt5TjRXakh4cHMy?=
 =?utf-8?B?Q1lMQ3E4WWpVYWZxWnAzY2VRVWRyTmVubVZZU3k2aEJ6MitmOGlZT3BNY1hI?=
 =?utf-8?B?U0FLbWNhUDJJLzRZR2E0bDByZEJyV1hJaXZFVGRUS2ErRkg0WS9Hd05UU2xL?=
 =?utf-8?B?QjRrTWhJWVFPVktSNDVZaGkxYkxqcU9nOGJjOEVqMzBXZXVKMjVoU2hYYjQ5?=
 =?utf-8?B?cWtRNWU3ZUp6bllsd0tZemFKaDRyRFFwN0pFMmVPUElCS1BSbEFlRlh5emta?=
 =?utf-8?B?M29yWmdCbmxzV0M2U3ZZdUdnbUVBOGJzSjVTKzFYc1F4WW83UGVvOU9say9n?=
 =?utf-8?B?SG9IdDlRZjBIWUt6QzYrMmRvb2dhbDRKMG1XMG5oTUVnY3dodDhZR1p6anJW?=
 =?utf-8?B?blNpelo1NVIyOUF4OFA4eDJvRSsvcUhkU1dCUlRyRE1ra1pkMGljajJ3K0Y5?=
 =?utf-8?B?VlFQdmlqZkpKajE5ZVR4SFRsUzRUT0c2RDZHdnFaakZTUUIrekVmKzV3cUhs?=
 =?utf-8?B?bGIyS2VMTHV6MFRmeFRITitlWWNlUmZnY1Nnb0ZyYXJjZnR5NkQ3WGVsSUtr?=
 =?utf-8?B?ZTRDTUFhNHNza1l3a2FPM05MK3piaVJGa1NvazJWNkNQVnQrbkxZRWo5RTFk?=
 =?utf-8?B?eUE5RnhDdjlTL0RBSGM3RUFsVms5cEdOMGdoVWFPYnNYV1I4TVdsZmFkak1D?=
 =?utf-8?B?TGV1eFRvTjhGWm9MRisrT29qc0Q0ZHN5cFBMOW5zaURPUUhrSS9HcXRmRXVX?=
 =?utf-8?B?ajJLR1V1bmFhdmpvVE9XR3VJbkpWL3VwdW53UDFrSHRXV0duRWd6Mk1NZkM1?=
 =?utf-8?B?Ri8yaWNDRHdkbzN6cVNIaWZrM0w0NmV6T1NkSEFkWVdjL20zWnE1aWlxOUJj?=
 =?utf-8?B?Nno1ZUZydEszVUQvNHIxTVI5NnN5OGs1d1l0bHdwcjBnZDV4N0M3NmJmRXZO?=
 =?utf-8?B?WFhFc2JDVXpnYVRsUWZ4MkhtV1pJN3ZNWUVVaHk5cElvbFplczI3Q2NKZCt5?=
 =?utf-8?B?eTFqS0w2NGk2U2dzdG9qSk04NklwSEg2NkdtQ09WQ2x0TGg0M0FiWnc2ZzR4?=
 =?utf-8?B?VkVCNzNwOUxvaDh2NmUvc3R1bEhpdGRpWjFOeUFxUVVnMEJ1b1lPeDh6TWFQ?=
 =?utf-8?B?UHhLdlBERnIxRkFZUll2WGZQSUNkQ21SSE5DZ2JNWURwU0lhUXRVMUllRVVY?=
 =?utf-8?B?QVBMYzl5OTMrT1BhaU9yN0s0aXpiWGVoUTNrYlppbmVhY0t4c2QrZW1IcjFl?=
 =?utf-8?B?SGVhVU9oRzFhYTVWRm9ieG4vWXNCQTZMWS9GbnJOY0JVSkVtUE1LSVBLVklB?=
 =?utf-8?B?NjJhemVUZ0xpZFhFYjh2TXIvMHlITjFvWTBHY0NFYmxkOXNSM1ZwMWtmd0lS?=
 =?utf-8?B?VVp5QkNSZGtDbnYzRWxRd1UwUEpDYUVIa0ZFZGQ0amRjOTRrZkVGcTI4UEZ0?=
 =?utf-8?B?V3QyQVBRTjg2THpxU2NuUDZkanBISDlXYU9mRTNFL3QwcjJYZXc1MGd0cTNv?=
 =?utf-8?B?S0Vkam1CRFBrY0FlRitRU0dzRmxlT0RWZktJM3BndnJabnUzMnFxbjc4dUJ4?=
 =?utf-8?B?VmhTVFpkcC9mZ2ZiWnA3ZGZHNTFPcHZLQUVUdDhqcVVjSGc4ZU9oNFluLzQ5?=
 =?utf-8?B?S3ZjTWdtN2RMSW1PWkVEelRIdHRXMzF5Tmd6MWxQcDJQV3k5WFlaR2R1cE5x?=
 =?utf-8?B?M1ZsZGM2RStNK21rNjlqeXRNVlpSYWEwTEtaTUNYS3ZuMGI4RVkvRHV3QjJz?=
 =?utf-8?B?TlBvS2E0cktld2Q1Wlc4ekRHdm1ZWWswcG9SZVUvRHdraTV2Y1ZJVWNxNmZD?=
 =?utf-8?B?TjFETXZSemRRcTZ4a3VLb2Q3VWRFVldyVEo4aUVTekgrYkdrNGxWa1h2SmtD?=
 =?utf-8?B?MEd2NGthRDY0SlJVdzN0Z1BGQnJBR2pYK3JGaHFPWVQ0NTNHYkNaaHhpNjJX?=
 =?utf-8?B?S0pKSmZxNGE4cU5meWUwZmt1NzNML2dRV2FCNk9say94ak5Cc2NkUllBbWhE?=
 =?utf-8?B?TXdyRjNvYjVkc1lKbUk5bVpicTkvSUtlMmFaZStsMXBWSldvREV0aWFRajd3?=
 =?utf-8?B?eU9ScHRmOVlWRG5kR010Z04wSVIzMmtHZkdKZ200Z2pKZHRWdWpkWDlnZ3RB?=
 =?utf-8?B?dWlxcmw4OGUrL0Y3RDFmNElOaVdNaUQ3UXFVVEZVaTlqdnlGOWVCTkZiaW82?=
 =?utf-8?B?RndKSlZxckNjWHlEdGNiNW16VEpQRUdwR1p0YWhIdHl3TUg3dUtFaTVuS3cx?=
 =?utf-8?B?ci9LbHloZVpzNjNBV3Q4WDc0bzFMNXA5WVpZRDV3bklDN2Z6WTMrUT09?=
X-Exchange-RoutingPolicyChecked:
	Y3HSPtccZEy663Rb9kpMHqqhEcfNNTESSfsi5nXmy/qIIOZe2L7I3QrnqbYvPvn5kzgAoUk2u+w6Nim8davJSd8CnTcEBiGjQb5Ob3DQR2t1fzLvioTY82Yg5vnSsDfp+aLW07SKV/lJaYRhVsFhdamB/h0/5iVMiiMK2H9yqW1DakhpjjUByL0BZpdtftDPCjsqaZ1M+CCKVLoYEXyNyMyjjwRzKeff2/NWzolDlKSs86ZbMPWAy3fIIATAMjN3x1LhE5zOzPVh8BC13cL37gRDsZBp52M7/NPX7wQQxgIi843N3MLi+sM+Mb3bypemCAEbodwZPKtf/IJcO32kjw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ba68e6-b5e5-413f-9d9b-08df409faf81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:31:09.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkQZxAaOh2qtYK6RJUv3HRqPM4xqK5nzWE3RsQiA/OZ55qzBTdTamV7y0w5HaTa9YA52J3tWfxgeBxlFHmVegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7910
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfX5NWAp+v+L41R
 A4ArH2asFUvTqgzd4/o9KyrC6kdnyALWO3HuTa9bn2/TGqEIEaTneUYK9v46my06DPMeX+IhSWC
 ha0Pr91/rlj3jKXjMEhc+as6/xID77h6gAqmVVvoMwtaUNy+OYaYm/PGDybVosmrDfO9oqLVr28
 blwMHKcGvuk2z7I37NE3bsP1MaUu/jtSH1Gu0SnJly8N1vc5BBkfnUDYCyaa/mJ3agVRITZIt1N
 wZTCAzRxbVHh9UQrqthjrzs/EvdP0htPeSJPzLNqBKsbRvA7kTqoxF+cNd9iZ2Eh1OCLc71v9ad
 zrRwjNoZiw8qsmhvdbj4cXJl2wylrk87s7dOLi+dU2Tt7u3Ss0kAMd/MOUmICcsrVP5sqzGBmJG
 N/1w8K4/6FlNajhnf4joZHzfL/v4b/pgg/rC1LijPC57YueFIW+NVIVlyK3tOdwpmdRfLxB3/K6
 f0OgDDzU48t5ZaNiMzg==
X-Proofpoint-ORIG-GUID: 0Sxc_pdsVtPsnVWKdMLg7dAaoRWTF4Wm
X-Authority-Analysis: v=2.4 cv=ZNVCCn7b c=1 sm=1 tr=0 ts=6af58760 cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=84fI81jghMrZIxD1PNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0Sxc_pdsVtPsnVWKdMLg7dAaoRWTF4Wm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNyBTYWx0ZWRfXxC5wFYz+FB31
 Me5YLafuOEqwfw3bBd8c1fT5qpUE8gH9YIVFEVHVG/ueCei64IxJb9KJM8TDvgXyQPDO9V9LZ9I
 o/c3y45MjdhB+3Ty+btcM388lzdF9baQ6jskePPgX9HGgxeZ9krs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120037

On Wed, Nov 11, 2026 at 05:58:09PM +0000, Conor Dooley wrote:
> On Wed, Nov 11, 2026 at 01:23:07PM +0000, Nuno Sá wrote:
> > The Analog Devices ADSP-SC846 SoC integrates the Cadence xSPI controller
> > with its own PHY timing configuration and with the support needed for
> > the auto command (ACMD) mode with the internal DMA, so it cannot be
> > described by the generic "cdns,xspi-nor" compatible. Add a SoC specific
> > compatible for it.
> 
> I assume it's the phy timing that means the cdns,xspi-nor compatible
> cannot be used as a fallback?

Exactly. Without proper phy settings we cannot probe the memory chips.
There are some works being done to support phy tuning but even when
that lands, not sure how generic it could be supported.

Hmm, I guess you want the above mentioned in the commit right? 

- Nuno Sá

> 
> > 
> > On this SoC, the controller clock and reset are always wired, so make
> > them required.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > index 3cd7321319bb..d6ac05b2efb4 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > @@ -18,6 +18,7 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - adi,adsp-sc846-xspi
> >        - cdns,xspi-nor
> >        - marvell,cn10-xspi-nor
> >  
> > @@ -53,6 +54,15 @@ required:
> >  
> >  allOf:
> >    - $ref: spi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,adsp-sc846-xspi
> > +    then:
> > +      required:
> > +        - clocks
> > +        - resets
> >    - if:
> >        properties:
> >          compatible:
> > 
> > -- 
> > 2.56.0
> > 


