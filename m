Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA643563E8;
	Wed, 21 Jan 2026 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983311; cv=fail; b=qhQsqpbNE0U6WcAo+I03afOdjDC7VbaZ9giWGv7zZOXOajMbmBee8ojOO/e8tGKtO/H/piF0yRkwyavHy4HLF5W0XRc+vKB9Ar1PSeU1DFYOfGzd2bJSmPN5jCC4D1ebq3I08f3LVgLoVZZxKL/0lgmKNpqK2AfQfEa6yZBURsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983311; c=relaxed/simple;
	bh=+URF00vjq3ESu9kLZ/mmvsoTZmqxk1eUi8kN2yHo+v8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDk/E+hRe+PxDNLN7Vsu3OHtKECmYn9s5Q5LIieBv0DGxcGB91vHmBH+vu7d8dv8+RjyofkVHraQVBgyEHe7y4ni0Ofo6PshGllbiebS79MKJQPFpjE9zAoXGmit6DT/BGcGmJZpy73iXwa5pDc1bYSwD3kccj8+bbgGt5/wURg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OV1jEfnA; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OV1jEfnA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMSXfFCtP6zTNRVc2bo1TIBElP8g36ToxlLUUoSHySAQn+DlG60bRNLGMjHpexXqNP6sUHRzDbXBwJBgOTltw9oZ4oa4YL2YJYuh9Yv7GtJOy9YN063iNIb+tOJwpy+cIfqCDFcnJB14TiYYOIzKllN+DFeHyk79Tth0ASBWdf0YzX8v/l0E9iSkVHPXTaS4JQOlpE/ppml1yvZx7l/1HsYfX92Hy4Oei/LVPLFzYKNy9+ftXhg32dth4qDgqulXMIE6/qB6rz1SbVUE51TvWgEZLvCiSuaK2+VdMrrS1vU8oT+HyqCz85eKqxbVkAk1GTu+vWV68fViby5xqBBZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJH0uWYcJ5cvSiCgRJKrCBtUQ8O1B7HsDNCBE65NPOk=;
 b=MlCyoBV7Azxb9gMawa+FOq2XVnEJ5ErImKXG89o+VbHFOPiVYYOKdzyo3UUslWLYf4lykq8IbjOOmgZ+6hqtnvTBVAsQO9qIYG8cBxm87r0fdDByyQzTY+jr/PMZ1UpkdfZRdBH+kGMQ7v92wJroyNWJvUbZPA+f/oUAscmIU+OA5piNgwPHwlNtPbdGrPrPrMDTQjLFEG7pYbAb74Hz1eoc2TYVuL3w+YzVOuOMIghgv9L7MF6gKt/itAB78hEDJQHuFx374ylgK+8skAVPNRetAUPfI2wfjsWImvrou6QdX3F2x+oD8g0Xfay+x+4uNFwaYAidmGt/DxO20p7pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJH0uWYcJ5cvSiCgRJKrCBtUQ8O1B7HsDNCBE65NPOk=;
 b=OV1jEfnA/awJ2g7Swd3Ezrow+uFs4JP6ys6X2GLMId+/5q3cjf59JQcvwJhOBrqJvet1jVbJ5hvicRfWXLzeWPZ7LQesZCi5yKzPIkXvNLqKCKbpeDvUFB0BHw0jQkaA2BsEy+kfv6UsXn8bVeK8/aDU6LeFsz4tjlOcfA953NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:15:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:15:06 +0000
Message-ID: <c0288962-6a11-4274-9e93-91bd5a6997c5@amd.com>
Date: Wed, 21 Jan 2026 09:15:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/3] spi: xilinx: switch to device properties
 and make IRQs optional
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <176893698361.778248.6867023245726406177.b4-ty@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <176893698361.778248.6867023245726406177.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c520e4b-30ca-430c-ad6f-08de58c52f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NU81dDZrdjZ4NWgrMDdMeXhNUXVKaGdLUVpmN3NGU3hTRkZlY3lCbUlrRG5h?=
 =?utf-8?B?TnVOTmZzN21vU21SakRGd2R2a3NJdUNlemxFb2xLeFEvNmNhM1Y3M2p6OFpC?=
 =?utf-8?B?TGs2ZUo3VnA4NE92T0JxMHYxQmJRd3AzcjMzUUptRTBXb1ZRL21QalhTN000?=
 =?utf-8?B?a1J5cEVTdERORHplMmp6Z0pYY0FqUjh6UUtmQkRTWVgwcnAxSGNsU3BycytL?=
 =?utf-8?B?c3RYdEpiNnp3dFlJYTd1TGUrZHFnTWkwM3V6S2lxUWRZWHBqY2VDZzNXMkZj?=
 =?utf-8?B?Q3B5dEhnRHg0T1FhU283N3BnaVBlazlMblpUSTNIWmFHNjBHbDJRQi90dUZP?=
 =?utf-8?B?S3NodGViZXBMWFdFV2dHOFlFUU5HTDhxQkxQN29WbzFjTU5VdEVuNjBWNnAx?=
 =?utf-8?B?QVY1cnJpY1RjVTREaG1BdGdDeFY1cHdiZWcyZHJPQ0p1aVJlY0FNNEx0ZkFp?=
 =?utf-8?B?eCtBWlZhY3VHazJXSlhtZmx4KzFYR0dtZ3M2RURyYXhlei9ueFFkalRPc3NO?=
 =?utf-8?B?b21aby8wSUNyRG1zdWZ5ejhpL3djekMvTGNVRjUyUXhhZGtLK1pzU2ZPUGJJ?=
 =?utf-8?B?a1lPZGp5SHY3TTVsVHRMVnFEVm04L2FXL3VtQTg4eGgreEhFclYvNWlRWDB6?=
 =?utf-8?B?Q3pCYXN4cUxPOEliT3lydkFGdVU4WG5JRUlRUW1YK2x6VGZlV1NlMnE4bzRT?=
 =?utf-8?B?dWwxRXY3eUlvb095R3loeGpmTlV4VnNEVHJCa24xV25wRUlROWVUMVoxZlFM?=
 =?utf-8?B?ZmZmOXpIUkV5bUhNNmp6WllLV01LNVV4dHNobHVFVnRpZjZPNlpOUHE3UmdM?=
 =?utf-8?B?SC8zakRzRDdNODFiU1dpb1RhRHR0UnVaTnVZajJ5U21NZ3FVQUEzNVRuSjAy?=
 =?utf-8?B?OHV3dUdHSDNRQXZlVlRaODFhNnFJUlJ0bnR4azVsV2NvUG1CTktqa2Nrd1Iz?=
 =?utf-8?B?Um1ZaUhBaXFBVmhldU5kTDFoUE4vZjFYSHFOYTNFMks2Y0ZxK1pQNnRMa1NK?=
 =?utf-8?B?ejI5dk1nTm1janVWSUpPbE5xYWJDZWh3b00yYUJGYTVkaHhPbVVFeEpEM2t0?=
 =?utf-8?B?dnh1Nk02WXROL3VCbkRIVTB5ZmpMbENzWU1aYzY3Q0hoZVJ4eGprYi8vV1py?=
 =?utf-8?B?czJZQmdmZ3FHMGlSMVM3U2dPWVNWTjY1YzdPUmM2QzB3KzRNU0g5QTlvREFt?=
 =?utf-8?B?eUY1ZmNCd2JLOFAzWEZaNllqbHhmeFpYUmNHN0NxRUZZeUlCaGtjUk9YS3Vi?=
 =?utf-8?B?bzYxWDdsay9ldzNiTW9xenR0NGMzNllDNk9ObDlkTXlXR3MrWTJtM090bEpx?=
 =?utf-8?B?QTdzTm4yTGZjMFlWdlVtZmYwUlZ5QzJNWCtRRXI0bUZOZ290WWVFMUZUTCty?=
 =?utf-8?B?UE9mSm9VTm5vQkVpMW00ajdRZ0RGbDRTUmhPaHdiL0tENEh0SHBqZjlJakZh?=
 =?utf-8?B?RmxCTFFGejV5ZWFqbG95eEpWd2lPcFR5NkY5ZGpDNmVhaitiekFHamlOdzRz?=
 =?utf-8?B?Vm5Udi9ibit0L2hRQ1FuemFET0c5SUdxMDRSKzRxOHR0NGlFWW40cFZESWY0?=
 =?utf-8?B?NXViN2RsUHlVYWlvakphMUZZMTlra0kybTluaEtvUC9ibExuc2xRNER6MmVB?=
 =?utf-8?B?WFIxTXJkZURvdWNadVd2VXYwV0VseFpnZzNmMHZpanFsangxV2xpSStTdTVH?=
 =?utf-8?B?dmdXWi9KeVVOT2JGSE42bVo0UTZXbkpqRk1HVHBVTXdnZ3NRWnN1MzU5S1hx?=
 =?utf-8?B?cFY3S3dpelhOTm91SFdPYjI2UW03ekwxQllLM0RoUGczTEswR01ra3E0VEZU?=
 =?utf-8?B?K0c4RmY1Wnl5VkNpT29BMExkeER6ZElJbEdJNEMwV210cytjVzVTNTdRemVz?=
 =?utf-8?B?bzVCV25Ed3IzWTI1US9jWUJHU0pyT2I3NHJYbm4vY1M5N0t6VzlIeW5yVGZV?=
 =?utf-8?B?UFM4aTdselNKa1ZZQkp6akttT0NlUU12ZVpjWFB4SVIrRzFLTVM3Y1Frd3Y0?=
 =?utf-8?B?aVVIZnY3ZzFtL3VIL1JMcHdnL3lnd2JrTVZ5MTNIRGx5Y1B4TXAwSTRZVEJ0?=
 =?utf-8?B?ZlRYUitRM0dQUGJJaGdFUlNkejgrK0NlcDNaVm14NUtTaHdjZ0tzakFFbDRD?=
 =?utf-8?Q?jYm3NQk4Wh9FwBpwv6lde/SIn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0ZZMElCSjk2M3hXZ1U4TGpndEFIUmVRdDlYZ01ZSUtIWkt2L2FubE5zbVhC?=
 =?utf-8?B?REtpOWVsNzlZRFJRUVpSSzdaOFY5RXZxaExJaG4wRitmYVMxbXNQa3Z6dy95?=
 =?utf-8?B?VnF1cVRMQzluZysybi9jSy9wWUovUE9JdWRUSit3OGRacG5xYjR5WnM0aGlD?=
 =?utf-8?B?Y000Y3FRb1RXL2FCYUVLT01UcElFSmNCTW5aUWsrSkhibTh4R0ZTMWlPL2Uz?=
 =?utf-8?B?TFFhVTMyblhycEhrRnp4cHhialRjNlR0eElObjRzWkM0czVpcTgvN29iaFZk?=
 =?utf-8?B?ZUlRTkxhL0F6K2tZRVc5SkkyQ1ZON2dRckIxandYckpKcWhHY1h5Tm1tcFVa?=
 =?utf-8?B?cVJpM0YrRFhoR2dlNmQyVXR0NTY4N1BYem90MDk3V05GWnBhcnA1dy9WcW5B?=
 =?utf-8?B?S1ZPQnpkVnhnYStJWWFNM0pKUUlnR0FPYVFjYXNmUEhJaVh3Z3dzVlNDTnRK?=
 =?utf-8?B?a0g5eVBQZEJsUTFUVkd1UjhmUlBPVnFwR3h1c3V4QUtreWVDbENlakswT2sz?=
 =?utf-8?B?Y3M0SVVJVklWK0pIbm40N29TdzNSVXhaMStLM2hST08zeHBEL3ZhK0R4NWRi?=
 =?utf-8?B?QWhOZFVEdFR1U2U5eDgvR3NMWjdCdlI2S0hRUmoxYzBnNEtJVkwyVExzOE81?=
 =?utf-8?B?cG5IQktIMEJMVkhvYkxwb1NIeVVOSFQ3QTNsUkpKTU1MS2tvRFlPZC9GazYy?=
 =?utf-8?B?aGd2d0hpQWJnazAwV0ZiT0EvUVRHQTlEcVlkY3hWUXlib3Q5MXFqWC9NaUFn?=
 =?utf-8?B?Qk5yZVZETGdpYi9hVkxWcUZuSG1uQzRJZ0xYc293cUpjSDd5c1d6QlJtSnFR?=
 =?utf-8?B?NVVLeG16a3lwSENhbW1uTWYxVW5XeGhHZkFhdklFMDZseS9BQ3AvK3J6Z0c5?=
 =?utf-8?B?Vm1OcVRLaFVtVlY0MCtKcjl2SVVjV0gxZW8yeHl0cy9NQkZQL2JqMW1najVI?=
 =?utf-8?B?akh4N0hkL2hjalRkRnFid1U1U2xuM3dZR0Y4UVJZRHVsOStJd0hGUmJJeWlK?=
 =?utf-8?B?MFg2eFFYU1JhdmtIazkwelpkOU9yZXVCWXhYcWJ4MUQ1SnZ6ZlJxY3k1RnRM?=
 =?utf-8?B?WnJ0VDlpRzZvejhhZEJwZ2xkdFQyODJRV1I0UWtEclpxWDZEMWVnVjROTDcv?=
 =?utf-8?B?L2o2RS9iWTBzQjVaeXRNUnRldERzNk82U25naUlXN1c5WmdRTi9Sczd6VGFt?=
 =?utf-8?B?eVl1YUlsSVVlbzVUeDVxZ2hsd1lTYlMvM0F5ODhFK2xQUXNwREpNMlhQNFRZ?=
 =?utf-8?B?cHMwRXJKQ05PbmRZQWtWUHI3YnZXZWUybmJERzdxWEFqVGhFQmVxNGNITzhH?=
 =?utf-8?B?YjFVZnVvY2hWanY3dHFQREhtN3Y5R1Fzbi9LTGplS3BwSEE4WkoxMmxhOUNX?=
 =?utf-8?B?VzJXaUNnZ2hVYVBMZi9YNWZCWWxjK1dXY0lMRHBucXpRUzdOVUJSWWRHb2hz?=
 =?utf-8?B?VDRzcDYxakp0WlE2Q3F6N3Qyb2NKZ0tsNTg3M3gzSlVFL0crOGZ2eUtRSTY0?=
 =?utf-8?B?WlVicTJVNmZ0cTBsVzFvek9hNkczaUNQSEpXdGRGMi8vQ2pTRjZoVGJLU0Jv?=
 =?utf-8?B?VmJKK2Q5MG8zT3VMR0dUQkxLSGFWaXBoaVlQLythdkZTbkp5YXZSYnVoM0hE?=
 =?utf-8?B?NkhNS0ZrYXNhTDk1S2lRbXpFR1ViRmVkUEJRaGxaRU1LNGVIQlZLNElOM3Az?=
 =?utf-8?B?NFkwU2N3MG8vaU9jVGVuZzIxbHNuMFNzTTZmWHFaL0pQUmE1U2h4RXlCT2Jy?=
 =?utf-8?B?RWo2QUZXRTNsSTI5R2VCZ09BMzJnVDd1ZFpwWE14OW00bW5JZ1BkQUo1YzJB?=
 =?utf-8?B?bGp5Wk9USm9xSlZqSzFaTDV2YllvQTBtZFVSZlhQb3hBRnF4N1cwYzZ2SDQ1?=
 =?utf-8?B?VEx3UFJyOS8vbit1Sm1YS2c4aEtGQkRvN0xsZEMwdy9XTExEVDBKakhVMC8r?=
 =?utf-8?B?SFp5MENjVDIxT3ppTmFTWXptcmtpcjZvWjBJMTZOemtzS1Y5ZUwxcXk2TFdV?=
 =?utf-8?B?WUE2cTVSVUNWOG1TMmZ2VHNZUGNqSXc2N2FqMitXSjk4a0szRzRFWHBnejFP?=
 =?utf-8?B?aDk5bnJyZFlRby82OXkzekxsVkk3TG5WeGM5MFdFN1NzTnNET2FRWEpCQkxZ?=
 =?utf-8?B?dndTZmVLbGRjSVpJeFhPNE9lalRFYVpMbW1iQ0syNHFSejZxZ1V6bVk0d2hu?=
 =?utf-8?B?RlZXZHdtZ0Y3K1R4UlhUdWJCTE0wRExNQWwvNDFGWDNEM3ZNeTljTmM2QW5N?=
 =?utf-8?B?dWdMN080dXRyOGJOZVRObHYxQnlYNzRISVZTc0Fvd1dtVm5UVmNxNHJOYm1V?=
 =?utf-8?B?bjQybklzOFVTSnBJN3IxWGpjcGRwemxweEhjdElHVVFaTjVqUEN2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c520e4b-30ca-430c-ad6f-08de58c52f82
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:15:06.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xK5LEn88N/dutuL9D1F/niKj5S6tSmVlH6l0wKKO0nenCBf3N2Aaz3k+yNwzTWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

Hi Mark

On 1/20/26 20:23, Mark Brown wrote:
> On Mon, 19 Jan 2026 07:06:21 +0000, Abdurrahman Hussain wrote:
>> Transition the driver to use the generic device property API.
>>
>> Additionally, make interrupts optional to allow the driver to fall back
>> to its existing polling mode on systems where interrupts are either missing
>> or broken.
>>
>> Abdurrahman Hussain (3):
>>    spi: xilinx: use device property accessors.
>>    spi: xilinx: make irq optional
>>    spi: dt-bindings: xilinx: make interrupts optional
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/3] spi: dt-bindings: xilinx: make interrupts optional
>        commit: b603500de20fbe15ee54580481c1df4212a4ec44

Are you sure about this one based on my discussion with Rob in past?
https://lore.kernel.org/all/20250605130331.GA2370690-robh@kernel.org/

I don't really mind but would be good to do it in a consistent way.

Thanks,
Michal
