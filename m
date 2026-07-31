Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022095.outbound.protection.outlook.com [40.107.75.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370134D397;
	Fri, 31 Jul 2026 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785467745; cv=fail; b=jLwJPmztC0I5cXa4e2zP/jk+jQ/QJV3UdjwNrMby6BSxfXGoh3YD+5LUuWQWkFDPWCv7aHuN9+QWYDcykRk6FBSKAG3PVpCQM1yBUyR5fydAwMcLf8aOV1HfQy9pUfPooa9C6rHA3kiOTHsOI/oSs1piqNDbwbO/u6DFL1/B2oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785467745; c=relaxed/simple;
	bh=wni07n//mXhE7VsQZdiwX2j3YASuye6Uk72YypiLNQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2GTQhaSkdtlt6CQf199Zz5F/A6hOJxEGXWjtXjbDqLvqk3HK8Qdi9ed6iFhj3UaqwLBn0hldw7/NePlQ3BjsbTN2Vez3Fxp932tdg4pPpxmVXw3GPN7zXBE1RoCEVsLYahGW7I9Ac1WlypBpnCXbaQfUC3SaL/Tk19NuAyfGbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=NZ67onGg; arc=fail smtp.client-ip=40.107.75.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="NZ67onGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov/1VjynLA2CCpxk/hiuRn+9QnaC6kLMw1GUAwqA8smoML7kVMm3RgddauiCQGxsPDDz1Z/fY9wZzRAtmAUGnzJYF6twoPOFPJ/ExmxkPu1G384dj4IEYFr7yx5iR6LHBvU9E64MFUOeXl1q0yb/rlcGWGM0MVVbC5ACg4zvcxhgMmILWsNNanlbLIPVIoEM7akjVFNWB14DnRUJZStcocl8M71wmXRr69KXm9CY9vRDNqbuwSziNg28hNjEajjmwaM2IX3io31y/iTCuUoAg+LZijradXLcXFuotLzSLJLIwAFc0JzXqzWYgHD+bln0yl2+AcXP584tHhIQcLavyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IWw0UZLTilE2t+xyIAttGb7xx3/vxH7X5dHAzu9aAA=;
 b=AUdwT3/JgXrRnJIrU1/rb9U6HcTrhGbX9r2uX2PRUfHVRU8POnUYMBQTG3nciuwz5M2ujzESewIopINbvPS7X/LJ5H8mCqpNHsSsuRBpT8kXiC/EzeZjtrpDVgeaeUb3QvF5DumtdF0xT80uiH7Fnz1Jap/yPhGgSyb2G7G/yWHW0/WpOd1Xk1XEA/yf0Z7Pi6zUndI2pIRCrUuZnygUrY8I7q//qLTUyR31/84u0FKPCJnvHBeDgK7v6N8ysekqPpP5cxfx95mB3eIFD4+LCdHO3liXRu8ZKRI5FhUoAi8V1/vtbfupc3iLP2HEBmj3nkYIm9/PxSkWrbY7kdvxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IWw0UZLTilE2t+xyIAttGb7xx3/vxH7X5dHAzu9aAA=;
 b=NZ67onGgf8tmb8BB1cWyOXzWrUVCuseyRxv8/2EZ5w2HvcOLuOkadogbM94Iv4KtJxO76FE3LKyUvN40W0wrZi5O76CNG+fHIxOHclWcwWFef3e2dvMpEald51hlT1c5tuQ7nZpMLGLntwygR2VqnU5yg38jKcD9QRr4HJXk0DuIBeCyP0SFS3ybYv+a4Fsbk+094KehvPZPg57mqXszfqah1r9R8bKyFAv4HiRSui/H2XuqSZPoz0trqChasgMefisSGkSmmTwCEYgHOz3n1LHFp+gkDuxrY8WJpJeEM2kXHj/7nluTEfvwmrZhH/7CCVVy7cnzQhJfWatkxtFxSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OSNPR03MB10184.apcprd03.prod.outlook.com (2603:1096:604:49e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Fri, 31 Jul
 2026 03:15:41 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 03:15:41 +0000
Message-ID: <cd9e63b8-7c64-4a69-b772-014b03c9e3b1@amlogic.com>
Date: Fri, 31 Jul 2026 11:15:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
 <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>
 <db111663-27a2-4299-a692-6154f1f842ca@sirena.org.uk>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <db111663-27a2-4299-a692-6154f1f842ca@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:990:77::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OSNPR03MB10184:EE_
X-MS-Office365-Filtering-Correlation-Id: 962f6b5a-f838-4e58-0a61-08deeeb20037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|3023799007|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	bxevEzfYGpfLrgHnXPBKpyth8ZwRz900MM8sWx07guH/5Ke60sRepCRTH6d5er80G4dCx2Y4aQJOd7t+OxmrIAEZQow7AxGNQgx41nZ0c0pYGxrC0UjmpoRVXHgzV9oMazSMHusYJKaWggwrwIcSC8u7mh1rl7w17upFANxAt1p99Y10RRrDJIcCxO40teGARXB3ZBimFlkGghb7rs1KdiWBZM192m0OgQLl9vFDOZLuerKimAVtDk+6Ew10qBKGfb9REirTnWGaNJkrsKwHXZldJggM4Aw15eDcwqZnvLCBHgj/0MU8PeGyUtSYT5N0M4F43l3LFOVYzAD2fpS7QBw/Y743Gn9csDvadqoBjcTI+H71Hm+p/wzvl6JykAUAfd4/3t9tWv51Ndv8fZDXPtUADMVo8s3XFcaA3XCtNNhIvnXW7732pB8HR15bb+nNUVxWl6y7Iaoz2M4f24r0VWDDpkEX3wmj4CAfsBXNyIRWDxBPqml2qmEMpxOis5bIaIW72xU/pAXYtYn8rhLwHrOQ4rP8nBXhyI0xLFBvofjDJkOMAaghMiRQW7RTZral5ERt3sK8g1qULx8Ncnj3+aGF1OrK2CsY/eMmPSCmDJDlfZq3D1EWyc2VT2/hbB0muoa8teiS3RRDGNH+ECUpgO3j1eLPFZ4t3yorY/uweDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTEyMnBHQWxrNjRIZGhwa0VqdEh1aEpJYzlab2FrWTJUNGw1eGpsTTg1Qm41?=
 =?utf-8?B?NEtZanREWGFTUFdDdTRhY0hWYWtuYU5ocXpsUEE0L2tQOVE5QVF1WHZoTWhT?=
 =?utf-8?B?bGVHeG5icUk3MnVraFFBYW1iM0NZWk9QSVZiUEdET213Z2dZTG5xaWR6dVZt?=
 =?utf-8?B?U2FTYlBsQm5wYzhVd09yckswdmxMTkx2TkV6NnpWcE9DdElBRHFtNFZCTjJU?=
 =?utf-8?B?Mysxakk3UmxGYXNuTi9Fc0JiRkI2RjFQTHBlZ0ZzR1hlSTJXeDJBazdZa1FU?=
 =?utf-8?B?Zm5FL2loREpDZVJHdDM2U1VWT1IvZm5hQkNkUjg0QXJjMG0zRFppajl2MXJt?=
 =?utf-8?B?L1hSeDErMDB5WHV6NmFkOWNpNFdIV3ErY2RiM3BqajRJSjFydUtsaDhoMURI?=
 =?utf-8?B?SFptNzdTd2xhdzJPL2Fsa0dqMW1oVkU3eXBaOWFUUncwN2UrVUl0K1E3RTdU?=
 =?utf-8?B?a3A0aHFEQ0NVU3ZkUi8rWFM0V1EvWFFBNWtTNWt5d2xOWkZoTTZMQjBQZEdv?=
 =?utf-8?B?S3pLcG4rVGdhMUZ0MmI3TkZtWmQ5Z0pTd3lrREdSOEtOTDhTNUdlcjFKeFdS?=
 =?utf-8?B?QTlEU1JsRlo1NTMrV3Z3ckw2S0l4R0RYbzVpSWNlUU9sOGd5MDQwcElhS1hS?=
 =?utf-8?B?M2oyUE1mSURxRm9HQ3Z5N2VYM0VwWit3Z2NOYTN6YXVPVEJ3c2JBS2NlSjFU?=
 =?utf-8?B?SHlub1Q5YmhLS09rSGwrMEcvaU1vbjUydjFyTngrbmRHZ3B1Ymd5RTcwUmY0?=
 =?utf-8?B?QlZDdDRVa2U2bXZvUDdkUnBWV2JRS2ZLUDc0TWxZR3NPUzB5Yk55alZhNm1E?=
 =?utf-8?B?WWdoMDRRZm5sdm1INU9TZjJkczNtNUNiRE1JV0JiNUVXSVNwSWgrT3JEUzhS?=
 =?utf-8?B?SzVrOUdQeERBamRoVjJhait1b2ZlUytpV2o3NzliY05oNThWRStSUkRvOUpv?=
 =?utf-8?B?UlVGTEtDMXJKZDIrN1B0dFV5NlNtL0dpYmlVM1RHS2trR1lJcUxOZWF0RVlu?=
 =?utf-8?B?ZVdtQWlrMXpadTBzQk9SemNRNC8wZjU1N1hjOTdxamJscXdWWVFpNFg5RXpX?=
 =?utf-8?B?bFFwZk9JazNwNlVzYUcycUVNdG5GbHdWRnI0WnhuMWlWSTdiUHhVQjZZWHYv?=
 =?utf-8?B?NWo0eUpyc3ByM0F2S1FnTjlWUDVHTkhSeFVTbmtPZ1BMZ1VFN3dqYWZHZnYy?=
 =?utf-8?B?RHpNWkxPbS9tTm5oWU40UStsSGFnaUNNd2dVSG8rZEp5aTZ2VjJWNlpPR1g0?=
 =?utf-8?B?dnBYTWo1L2tTcDFEbldNWFZVWVhtejB2TGdOMEJWRDRzMmNrMmVHT0lIM0JQ?=
 =?utf-8?B?SHBjQ1ZzaTlRWTMwUlZib1gvTVJTQXlXRjgzU2xjSGVycmhpcit3ZXhPTTJz?=
 =?utf-8?B?NGcwWk1Lb2lydFQwbG9vVlM5U2Vyd0pZbk9La24zK3VRcDdTVnNBM3ZPcXRM?=
 =?utf-8?B?ZVUwMEw4Z0hBbTU1T1JnQ1VNeGpNQnFGdno4SlU5NnlwQm8vSWgvWTd3SmZn?=
 =?utf-8?B?dTBacE5RdHBDc295UHhFL3IxNi9oTVcwMXNqVmI5Z2JsYjlYU3F5R0R3aysx?=
 =?utf-8?B?WGxqbzB4Q2VodVpwRWxzQ0c3RStRT1BhZEJBTE1nTE5kRnlOZmZKK0lTajNG?=
 =?utf-8?B?V0tVZzNEOXJJZEVIU3oyR2lESXczOHdOR0NQZWhYR0VLYUZLUmVpbTUxWVI0?=
 =?utf-8?B?c2VNeVhGb0VDbm4zZU5lam9LZklrU25Yc0RCMkJMc0xjMEtPU29YSXhMWkI1?=
 =?utf-8?B?ZXRmZjlvODJkMTFUbG1NM2VUdDh0UDF0MXgwY1RGM1ByeFFwRTFaN0VlVnhG?=
 =?utf-8?B?RGhaZVMxVnFkWVVpQ3JKY2ZlYWxJUEt6OHlTbkJab0NFVmhNRHVxTVoyZkNu?=
 =?utf-8?B?OUtRVHRqV2k4TzBWOVdlN2tYTUNENzNjOGQ2NkFUQWJlT0ZmTFVIMFdGbVRU?=
 =?utf-8?B?a2dqa2htOWdORm5IaVZDeUtrTHZQSzY2YUloSlNaN2JPdkJvN2VpNVpWekJH?=
 =?utf-8?B?K2xLdXc0TlJFQW81Zjg5RDdVN0ErVHZ3c3RuM0R5OVgzQlJvdzVXOE5NL3Zr?=
 =?utf-8?B?R1VLTlQ5SWFOV0N6RTNkb05lOEVFUGQvTXNGanpES2J1Y3hXYThZMEtHK1Rt?=
 =?utf-8?B?MnVGMVhqbGx6dzFMeHNNWFYvZnRzUWhVSndhSTVBRHJtc0ZVMVRrSWgvbXZn?=
 =?utf-8?B?ZVZhSFZkN0dicHFhaEtmdTcwdFdGQWhxb0Y3VTg5R0YyL0ZuMzZPMEE2cTZE?=
 =?utf-8?B?YUw2TllacVkveE9ycEYvRmplTC82czJFVUJqcTEyVE92NFNwVUp6QU15SzUx?=
 =?utf-8?B?bnNMZnRhMXpZd05wOXhJcnRyV1lUVDlpSEttdENvVVdya29KcDRvQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962f6b5a-f838-4e58-0a61-08deeeb20037
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:15:41.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30rf9/KEt6/yT6EX8NawrE4ZT8Mfy7lMKjrcJLll+4xymMLguRx7H7/ZMqNWASMl+q/YksGsHZYgDZojrRsUzoS/JDj9reRIQayvvBbmLYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10184

Hi Mark,
    Thanks for your review.

On 2026/7/30 21:22, Mark Brown wrote:
> Subject:
> Re: [PATCH v2 1/4] spi: dt-bindings: amlogic: spisg: Document 
> A9-specific properties
> From:
> Mark Brown <broonie@kernel.org>
> Date:
> 2026/7/30 21:22
> 
> To:
> xianwei.zhao@amlogic.com
> CC:
> Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
> <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
> linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
> linux-kernel@vger.kernel.org
> 
> 
> 
> On Thu, Jul 23, 2026 at 06:43:42AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> Document the Amlogic A9 SPISG controller and its additional
>> Device Tree properties.
>> Add the "amlogic,a9-spisg" compatible string and define the
>> A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
>> properties, which configure the MOSI idle output level and
>> the inter-word gap, respectively.
>> @@ -35,6 +34,23 @@ properties:
>>     resets:
>>       maxItems: 1
>>   
>> +  amlogic,mo-idle-output:
>> +    description: |
>> +      Controls the MOSI output level when the controller is idle.
>> +      0 - Drive MOSI low
>> +      1 - Drive MOSI high
>> +      2 - Follow the last transmitted bit
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2]
>> +    default: 0
>> +
>> +  amlogic,word-gap:
>> +    description: |
>> +      Number of idle clock cycles inserted between consecutive SPI words.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    default: 1
> I'd expect these to be per-device properties, not per controller.  The
> word_gap sounds a lot like the existing word_delay feature we have - if
> it's different it'd be good to be clear why.

You're right. There is no functional difference from the existing 
word_delay support. I'll drop this controller-specific DT property and 
handle the hardware word gap through the existing word_delay mechanism 
in the transfer path instead.

