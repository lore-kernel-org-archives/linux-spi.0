Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023077.outbound.protection.outlook.com [52.101.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6E23909C;
	Wed, 22 Jul 2026 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784686882; cv=fail; b=EOsUXEfReeQ1odJ26vBkqNUO+6ZlNtjolQ1vCIpR6HedTJKN5/+V5V73VOypIzlgVM/l5wcmvvlfeFRix7cbPSpX9l05z++SFfiiQ5y0cN6RbzzpvQ5axbFttHgAVgPXFXuw3E6i9jeAylPNwE4csS8uJ1BGMzzHWzWKjUbkTeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784686882; c=relaxed/simple;
	bh=DYSMUfP5WqCH8STjHU1hLRLeK8+WqdJJt3Xddo3WDQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfnYFx9XAbCrbLYBpRqctssMkBxDU6uqAU8ICczcdtDsFihs0rb0b4zpoY1TevHBR2vIjtl39f1348xSSIxodqB8iOfsIO7O/Yx2iO4CGM2JULDk0e6c6tE2vWfdZlC0c8zadmouIYlUPaJYxQFNXZMGTQ6sVDr0hP11nd7VIaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=dHDuK2fo; arc=fail smtp.client-ip=52.101.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="dHDuK2fo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM3jr49uox7P5UmO2XjG4Pw2MQWORQcen39JlMdtKc6PjMzDtJTM0TkssTraN/N32QR3SyIJvcdQ34kBS2WI/0rodTADlYnWE611oLMbGDtF5b82+njI+/fFqbekoBwmL/elAO+4c0dkyXFIbflDphssid1jQZCFGJh3Rr2CXKM7T5osc0Kk2t4V27hcb52t9iCNN59ZLXe5F5lXqm8qM1eOPFr8bs4ma7Uta5ORS9bSvq2i/lpz/kJx9r7z2UWpf/zcF6cnBAI0ClTZt2agUtPs4nmzCO3MYzdScgyWimgcdRKleyTldEowBuVwMxlJDFF470XdjC7Z9rMLP4ewIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63dv/dniBjV4ZvxkzpSHAkzQqfUJVoC8s4IFRL7jr4s=;
 b=yOrS8BaVNTFD3F60ppnkCcsCmuvAMfmObMluzbtEVWM8BzPpy7gy2MJPu7K0JvMUeSZ/LYXfej6P3vku+iSsf3jFynzxeaHKb7F9UNBAm7mr4Qtvm5TlbuvT8IXVaZOt0scJTPjvyeMYy7M1yCDu+iSzcjOwbSN7WJn2cqQd/qFX7sdYve/tCT5tpcz7dC9lYVBXzSUJv5/eTzoBhOjT+VS0Zeo6XQJM/sixvFDBqAyzrfJVZGmlEkByAyLZQy3Pl3MDK84DGUqGE9CNEHS5Gmnr75O3PUggThrywpx9Axb2dInchGx//MtJSD2CrUUn11YdwQI8H2vJRKrDY84nKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63dv/dniBjV4ZvxkzpSHAkzQqfUJVoC8s4IFRL7jr4s=;
 b=dHDuK2foToFXfHRjFzTKfl2IZTvyFDbGfYORw4+JMjCIMVANv9voGRxgoasNdgma7vWBq2pVSyaTiuYz6RwtitP/7RdRNdo1Xbt2U+9Z6PikN3FyYa4a1me1mqZzYjZvDiMjG0DpQ8VXUYQ4vXi/j4wby59ImzSpYZUrLVfTU50oLm/pmWkqWTGexkMf+0+sx+pzA/RcPpT6o/Hg4ROi+NTgcfIp3ppejWsqdxR6JV3CfcXfnZmH5aN1Oy0kUwFympQQAYaVChyjN0N9dVs/2pRtP6CuFPOiiLdAxpcrjRHRnaCAmTlGiwUHFc+lFHXE2Rq9G5E6Z+fdBlEfZoowRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PUZPR03MB7187.apcprd03.prod.outlook.com (2603:1096:301:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 02:21:16 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 02:21:16 +0000
Message-ID: <9568564b-be74-4a5e-a84d-c548af398995@amlogic.com>
Date: Wed, 22 Jul 2026 10:21:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com>
 <20260717-a9-spisg-v1-1-2eeea77be19f@amlogic.com>
 <20260721-determined-melodic-boa-c379fb@quoll>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260721-determined-melodic-boa-c379fb@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0P300CA0021.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20f::25) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PUZPR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f1e905-6b50-4b25-02fa-08dee797e867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0lFicoAkeZg/PWTdOHLSfnQPg3ZK/tmUbw7EOJdFrvhq0srdzu+1xAP7o2aK7fsxI4tVNXe7e/d8ENM0MwO1Ox3lJxdJrjV1BFD2ZMC3LN+GJc/O+YzpW44smCGDERxNFCXuBPDDm9rsnPedsOoYyjDjD6AW6h11ctvjTz8DLfuJh99GUwlTl6cDxF5g6PVDHr67t64+qKn/hqe48Sea+UmYEX59Fl3/esMcoTupuyZr7fosGNtH+bET56uCkIbfIEGAinflpS5oxjZDQ21ci386F1gmq3G0dRy8MtgAk92WGcu1nUXPejr89Ev2CXyOyzHb/FH5GZ76EK9GZThuCUJtdwAa39aXzmbIEDXkxhgUevMbGLkmdfiafxz3KBISEaWXcXTBHlFaG7HQFgOFrEBYpxOAhEFYKVnScGnJlpJc2zSS5CYcLz1Zz5c6WssBZ2VHxXrZicl3tpqmvz3xMSUCGkBo2Qh77ILWyXA2SEPT+2XTMtVjTQE/2Urmj7wIl6ur7dFUFGED4FVHy9ijX79OlkdpRDzOiavnSshgzflM3RToY417XlFaCRcHtyZFN+AwYx2knI/wUpDg/Ywv29CTPdkXwvLG9yZNDSnnu24pt83OnnPa2pGtdE/uQjTfcUeNqANf0eKNdk7Fc18S/zXsgQd6YsLKSOziYTE7D5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEpBMXBMa0RaWlhCZWYvQjdrTm5hMVU0eUczbGZqQWZWWEhZTGE0azJaalFJ?=
 =?utf-8?B?WGMzTnJpWTRLdm1IU3V5Rm5McWpaa2FvTVJPZm5HY0ZHVUVaWE9DR2YvRHBs?=
 =?utf-8?B?L3hQUWZPa2J5VzBmQktlRnNKV1NQeXVGblFJMFgzOGE1dXVCU1JKYVlPRk5z?=
 =?utf-8?B?WTFXMjhUUDRsTzc4d0ZidXlxVVFxbFA3RkJYa1Vlb2tDcWhwTHFCL1FXcVhB?=
 =?utf-8?B?K2lvb2paQkFPUmwwQkFnRGRKTm9yUkdqQ0hJQktISDhKU2YrUHdlM3N4cmZC?=
 =?utf-8?B?RFRRTkUxM3U1OGdOSFhzRkhqeVpNcjFtUktHVzZ1Qzhqbk9aVWVZdkFzNEsz?=
 =?utf-8?B?SmZiYzFxMzV4MlJBcWJleERrOExmdWFPZk5UT2VHWWNEMmVpK3BXREYrWEo5?=
 =?utf-8?B?NlJ0SnZvbjZuWDNaUUZvRi9RMEhKM0dPOVcxR3l1K0E5R3VqQXVobi83a0ZT?=
 =?utf-8?B?dWJLUGh6WGpIaEJzNTdiTjRYa0NrU092ZEIxWTZkS2hQYkRMMmh5Z3l0QkhL?=
 =?utf-8?B?NWp0VmZxVjZTQ0E5TGp2YVJGcWt3bG85WVYveUxuclROY1BZR1JLNjR2SlVQ?=
 =?utf-8?B?ZzRDb2dJQVRrVDhwUnN0WlM2U0ZJdGExTndIVkFvQkk1U2w5bVg4U1NqM2to?=
 =?utf-8?B?Wm1kV1FGcGRmUDd1ZE5Pa0g5MG1LRlZkWGM0K0hHNEUybGxoR00wVWwyTkRW?=
 =?utf-8?B?THNGYk40OEtGSHJ3L3Irb2h0cDk4NStJNDJaaDdZYkRvMUN5d3NYbEVmblhW?=
 =?utf-8?B?L2FkeGJEcTV3OExiaThXcGU1MkxiRzlJSHMvSEpzU3JkVnppRndlNHdrS1Ji?=
 =?utf-8?B?TzVmbkEvaEEvUGdCOEk5aDZISnJRNmd6eTArWHhJK042OFJOd3h0ZUJDN1ln?=
 =?utf-8?B?dzhRUWM4eVJlWXFOQkxJalFDc3VwN3pmSCtXVVVwRHBpUzNHekMyUS9UcldQ?=
 =?utf-8?B?OGV6dFpDVlhCR1BXRktkUzB2YWVyVWFtOFBubXRhVGN3VkVqL1JVMXFCMEF2?=
 =?utf-8?B?VytGSkt0RnEzVVNxdURRblZUSExONWZ6Mjh2dW5LTjRuSitkT1VzMDlQcGdk?=
 =?utf-8?B?YVVaM2hrajd0R1ZhQnNneVp1cStLc0lMUjVGSDBBWHhjY1RvZC9jUU55c3Ez?=
 =?utf-8?B?UENVTHNQb21pMDE3N0xldHJ6cXdjZUhydEw5ZjZQM0hoejVtMG84Wi9jTzFR?=
 =?utf-8?B?dUdnQlNaSUk4eWphWEhGM00wbWZhL0RWTGlOMkpIN0ZXWVVBelJBK3dCQnpt?=
 =?utf-8?B?Z2c0MnRZMzNWNVZRVmJKZEpKc3hSMXBQSnp3T0ViR2djSlFiSFl4TUIwQWox?=
 =?utf-8?B?ZXZXcFp4cW1aQ3N4c2FHK2JZVlZmOERPWUx2ekRMLy8rRzRSTUQzemtWWHZF?=
 =?utf-8?B?Vjdwam5sTWVIK2hQL1pIZlZPYVVMSlNOUDgzL0xFQkZkTVZvVUJjSDB6S1Qz?=
 =?utf-8?B?em1OTTJZWGcweFFNK3l2eVdPZG1yZE5EdE1HVE1lRUNObEgyU0dmL0QrZDU2?=
 =?utf-8?B?T0JWWnJRSEdJS2crSWJQWS91RFBCeVc1ZkkrUjJVaFRXblhkUDN6a29nZUFu?=
 =?utf-8?B?QlQzNmtXOEtHR1NYZDBaclJ1V3Y5VjJKOE9BREN0L25lWFZ0bFg5eDFxWS9K?=
 =?utf-8?B?eVVSaXVyVEF1NUNheWR6dE02cnYyOE4ydTN0RmxrWTkzdkx6UWplejV2dDBu?=
 =?utf-8?B?bXBNOTEzcVNXSy9rTVpBNjluQ085ZFBZdStqWjF5OVphbGpoaDM3WU5NRE9U?=
 =?utf-8?B?OWZIcG5VNWRubG82Z0MyMUtkK3VNU2dVOVFxRzlVd0xsMk83V2FObjVsS29h?=
 =?utf-8?B?L1J6U3lISFk2czd3VlB1dFoxWEFSbFF6aUVYRVdubUI3RkhoTkMvRDAreUhR?=
 =?utf-8?B?WFp0N0FNa0dmbnpzeWxQQ0J4T3VkTVRvMVc5ZzdDRVZHaHlZcGplZGlubkNn?=
 =?utf-8?B?eTdXaGY0Ty9TcnVMS2lsWU1VRzMvWDJlL0tHbGdUNUJQK1Vsb1VNVW1xeFNz?=
 =?utf-8?B?M3d2STBvTVlLT0NHbFVuTGJiWHBLUmZSWS9FcTlpWW01b29WNnhjeHBiK0tl?=
 =?utf-8?B?dzZ4eXRUSGthUDQ0QlA1SXNGcEtvYmREM2VhNVRhbkhRa1JXandydndzNjN5?=
 =?utf-8?B?ZTRKbVU2TnpSanBsSGthUWJoWHlTSUNtS2xiZFR0SW9oZnl3SXpoYitNVXhp?=
 =?utf-8?B?MCtyTktNcXNXZzNGSzBnbmRqRFJPSEVRS29wNitzQ1lyaFdtTzBJUFRDUktF?=
 =?utf-8?B?Sis0VU51Rm5CYnVocmVJcVNFQWpCOUJjNSthdFhleUNwRVpVY2dMaVRCY0pL?=
 =?utf-8?B?MkdYdFZ5Z1hvUE9zUDBXQzI1U1lpODVlWEF0dFNPY1hsNFRNY0c4Zz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f1e905-6b50-4b25-02fa-08dee797e867
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 02:21:16.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sAA/yERMMlgVXwWJB/RuoOkhqeR0zJhsbqrBhGC634K0jFhM42oMSV4Arb/7iySrLa/hozOz+Wt/SYjMRjY7knz6PiBaLu1q8sLrRVZIr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7187

Hi Krzysztof,
    Thank you for your advice.

On 2026/7/21 18:18, Krzysztof Kozlowski wrote:
> On Fri, Jul 17, 2026 at 07:49:33AM +0000, Xianwei Zhao wrote:
>> Document the Amlogic A9 SPISG controller and its additional
>> Device Tree properties.
>>
>> Add the "amlogic,a9-spisg" compatible string and define the
>> A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
>> properties, which configure the MOSI idle output level and
>> the inter-word gap, respectively.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 36 +++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
>> index 9bfb8089f7ea..7efdc748d566 100644
>> --- a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
>> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
>> @@ -11,12 +11,11 @@ maintainers:
>>     - Xianwei Zhao<xianwei.zhao@amlogic.com>
>>     - Sunny Luo<sunny.luo@amlogic.com>
>>
>> -allOf:
>> -  - $ref: spi-controller.yaml#
>> -
>>   properties:
>>     compatible:
>> -    const: amlogic,a4-spisg
>> +    enum:
>> +      - amlogic,a4-spisg
>> +      - amlogic,a9-spisg
>>
>>     reg:
>>       maxItems: 1
>> @@ -42,6 +41,35 @@ required:
>>     - clocks
>>     - clock-names
>>
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,a9-spisg
>> +    then:
>> +      properties:
> Properties MUST be defined in top-level. You only restrict them here.
> See writing-schema and example-schema.
> 

Will do.

> Best regards,
> Krzysztof
