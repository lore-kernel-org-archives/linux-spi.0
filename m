Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7F3FF1BC;
	Thu, 16 Jul 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210249; cv=fail; b=T+fFMucTHpDfZYEXbnjcCdlLS5njjk8hMJieIZdA4a6PTIwiYTz2BMotTrJo9tRie0Qn5biLs0lTy2DsCOII/dbgP66GozPEEPtCSxSLjQKJuUvwAs/uIvFBSx9DBMj/KJSL49iQVeBY8F7Ki8Dc1lwdQtygtxjZBQ/eAY69F+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210249; c=relaxed/simple;
	bh=16xdDo6SZRHa0Rr2x18Y0GwbvYoY85x/dR8D0EavV1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8Fmc1xafnvHcqCRRJ+1xbzb76j3XiKjJhAuvcIzATuu9y5jherGP1THIcZYfDcjiik68sTnCYAik6uhmZxBs6eyYlwbruHN8ti9Dd1CMCC5orggjteJidPRX4I/dCBBaQ+eRDEYJMz9q866dxt9CseiF1TbxfUP94AaCrA3ZDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oEShmw+e; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oEShmw+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xiy2bIR2iOO9y7tATOCNoXTSCmC4W84J9WbecDR1SkUKtVgZCJpy+Ci8Dzu6+I82bIdK1Brt9BWRgbxFch5jxGPUWjcWWPLXDytMwHvc69LNd9DXneIzHxoAA69ScSlzM79IwOgU8KIM4vh9UAnlmRGSs8RCXR7+Xhmmuc55unA/93Tnk8fnUAqM+ro+hYoJhC7K2v0ZR/nL/MCQwf6HkIEyrCVe2YCoIRG/hNrud/EUPJkg0Pxaaa0RjNRmvc2ngxkjXRJETzTpP+u/+hYMue8udm0utZhQpi55RdMx5F9F0WOCPsEcVFbuGPaLqOSYsBseYV1JRNYvWATccGVbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZvSRWYodKkMM9SUhKz4VpEyKocTeHkDqe0gltuLMUY=;
 b=LQ2s35QBUmC3wHLJ0NPwZUhz2nkfelHip4kV/Jd42xDmGMkcc3UZeSs/Hv/SReyMKDB0OpqpEAYugr3i0JYmRn7IhQ2THdoh54MmvlrL7FkMhWulCizPgxnfRMJq20DQ5nxgNvyLq9lFQnKxM0rIxU8C4r5wKour7/sVjhZaiHDE4Bs0MEDDusXi8oFpQRkuvFWXf4l2ZTxkZyrLZRvhF+JJBw78RRL3Zw2Axteop1vrnW2Fo42MORQlWaZn5X3Hv6tHlLGDoSZk3CftqMXur+ounJHCAO0y8ccW93kyLpWB8acaGWJ4rZPpG3r+PTcXjY9crElQTK3Rw0JBc5uL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZvSRWYodKkMM9SUhKz4VpEyKocTeHkDqe0gltuLMUY=;
 b=oEShmw+ezZSxwdXYjiAOFiwvlvQ6NjIu3QjYKOE7ZEcpPBESUX4W0pnLrl/1lYge6wkMvVOzztLetTrkTIsoEDNRuzB1ViCF28uKq08zoa3itJ3L+xZbbRpSr+nTT0MbqCWG8qXXD4oNTNH5XnVsUw3ypmlLg7Aw6Oa2m56NtB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 13:57:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:57:18 +0000
Message-ID: <979c6ed6-4e75-416a-ae5f-a2a8d3ec1a4c@amd.com>
Date: Thu, 16 Jul 2026 15:57:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] spi: cadence-quadspi: add PHY tuning support
To: Santhosh Kumar K <s-k6@ti.com>,
 "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "takahiro.kuwano@infineon.com" <takahiro.kuwano@infineon.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "praneeth@ti.com" <praneeth@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "a-dutta@ti.com" <a-dutta@ti.com>, "git (AMD-Xilinx)" <git@amd.com>,
 Amit Mohapatra <amitrkcian2002@gmail.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <DS7PR12MB9503EA13A8FB71938556F1CDDCEF2@DS7PR12MB9503.namprd12.prod.outlook.com>
 <13926125-5e55-43c5-b502-4e487d561ee2@ti.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <13926125-5e55-43c5-b502-4e487d561ee2@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 21feda4a-6711-4999-b07f-08dee342265f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	whGIZpVcp11BLsMA9T2cmF2Uf8F1kuIgKNrEPa4Q2B0SfhaLT9bNuJgnewf3xGF54Rvm9URdlNO0l2ijxuBAC0Oa/sMHEQQZeK+PmWcivtEDOIte3282kVdlGK3Yv4VaVGngzMFvlfQSG+fZLR6PpWSzaW7qt35BseDMmh4szRKLNoORaZZrjBF5+5tH1LXUMFkF6pX/gUlasI2pywSow53xtAX62tlMR6AkXnFd5bE0ewoLNhh1ISem0F2xcjTuQSumnq5nzOdlH2iD+rq6fc8rheErHJBIQJ4BSelE4NWnWPsiSk4rEhZRFki4ivcEeTT9eYX6iom7tGtsspOSlYb3lD6YDXauJ8dyXUwQOIIhbC8oIGrMThkqlF89UMBEOsos2EOS1gFb2eFIIKWOdX899QKM7sJhWeFY10iaHK/LmhHeVQJSYph2LYUXZCaH+RaXPHikAwmMBf06o7i5nb36YQUPuvlUiseI2J27X2rjcALH4EoUY3681mcB09cxaV9tcooiUPPUXJWOndItmBAer2AIwTNbpihxuox6cN0nxubjPZGRj9nL/+5iKAiTEOCq3tAeS4JmZsedEGkt18PL0G6x2qpN5MQazDBBfTd5tZYVG0dx3OZ1yGtidh3a6wctSCw0hoM4GSDKGihNTr+YA+CPxGGG4OROwJonaDEHQwEVdv+DFDskkOt2DzB3DCqrW5VZ6LG80bT6KGdNcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3pBd0ZKUjZwRzdpeHhKWkNLOVlxNzJGN2lScGlxalBWRHpwY2xCbnZ2bUts?=
 =?utf-8?B?R0FqNStmMm90Nm5SUDhnVCtNR3NvcGs4Q0xraVVNNEdnV3U5RHVkQ1RtK05o?=
 =?utf-8?B?Y1dBRnVkNnMyTWdhSzgycmZKcXhDNHV3aE53SG9KRTg3L0xKOHQ3WktuN0l0?=
 =?utf-8?B?N2w4VmErZllLdTRnNHk1cm1XWkRaVUhUR1RuZUpka3NuUndRcEkrMVhZS0No?=
 =?utf-8?B?dEN6c0l3dnJRL0syQXRkRHc2eklRbTAwTlFqQTI1RG9Jdy9idmE5Tmt6Y1RD?=
 =?utf-8?B?cStzRzVWUTFxTG1lYWVzN1NJQ0JSOHp1WVhJR0RPVDRyYjFBMExCSWJQWWZl?=
 =?utf-8?B?UDNTOGNtRUUzY3h3b1NEcWtJaW53T09FQUNnVkNzcFZMTDBrZ0hiUytWZFBX?=
 =?utf-8?B?T3FPTDVMcjhuZDZBWGppTTdDL2lWSWlvb0lTV1UwZ1FhRHFzcm5rUUN1by8y?=
 =?utf-8?B?ZEo4RXBwcUJxWlMzOVZkYmxTc00rRnZ1YVI3Z3o5V3NDR094bmhNaldCWG4v?=
 =?utf-8?B?Z1hnWFhNMlBQd1hiZjhzZk00SnI5OHJLLzlGaFZUYzNSSVdZYWwyZmtEcC9v?=
 =?utf-8?B?d0RLMHZ5R1YrRWRlUk1Ea0dyRERQeDN3SU1ONTVsckNiZE1RVWZpTkY0RlB2?=
 =?utf-8?B?eGNBOWh5L2h4YzV2eXdJU09mR3VRdWIzNEplTkZqSlJWVFlVYVZ1OFpLRkJP?=
 =?utf-8?B?a1YrWVZDVU9BUXlTYTd6cjVqYzA4N0UxeFdpdHlxK0dMK1ZwTDI1QnhYeU5a?=
 =?utf-8?B?NGVrYlVKbndlM2tGNlJsOFZ4Vm5RMExqS1g3WmlZeWc1b0J5L015TWJkNWNr?=
 =?utf-8?B?T0Evem9saTd1OUFQVlQrb21ZaHAwVEZMWW1IYlp4K3BldDN1ZGxPdFVsVHd6?=
 =?utf-8?B?enQ5TG03bVEvSGdsWHArNEZ4SG41bzc5c0tYemo5eVpwRGllNnpQT1hCM205?=
 =?utf-8?B?ZEVETzNybld6Q0MzVFpkdDFhaUV6amUrV3pMQUpOSDFGU2hZM0h3YkVCRGp0?=
 =?utf-8?B?VFU0dGNNaWNrN0xLaWtoRm1CRDVGczNKODl5c2tzSkd5TEdnbzhON1NMeTN1?=
 =?utf-8?B?eUlZWXQ2ckZFMDJFNUZHeHVPQlJ6ekFneE1BaFlWY1VpbE00dndhRVJ3ZnUr?=
 =?utf-8?B?cWhXSGxTR0o3OFYzcGUvQm1ZWk11bW5BV0xWaVZLR3lXWTJHNmhTeE5jemRh?=
 =?utf-8?B?MDR1RE14UGlFS1g0aDJvVzFaaFdpZm5ZQ0p3VnVLSDQ1emdqTzdQT0FzeHIz?=
 =?utf-8?B?SmczUHZUcnlPUFB2VTE4SlBWMFhiamt3NTBvSEFBQTgvV1llcUt3Rk5rbUVN?=
 =?utf-8?B?ME5rN2s4OFRCZyt6L2g3cWxxTk9BY3FHM2xmMGJpV3JTR1RUaXdRRDF0cElt?=
 =?utf-8?B?VTRxVHFlbTNoeUZOUWhhYk9HMHdTbjhldkJIcTFiUFlGcW8rTGNqNzZiQ0hr?=
 =?utf-8?B?djFKZEY4QUt1bDBKZXpLRkF4WlhtR1diQnV3dUxzVmkwVk8yeUlBRktnVUZq?=
 =?utf-8?B?NGVLMjBXK2c2OTZadUlTdHZFUFNVR3JMTko4SDhDYzVqVXdyU3d4cm5LbTM2?=
 =?utf-8?B?QTNBdjBzQVFVZlo3SGtYWmllc2RpSndFUHY5UUR1aFZKMTBpaVp6M3h6NDd6?=
 =?utf-8?B?U1VsU2h3MFBIM2x2QmFkZ1Y4T29xbGpMZzFlR1pveDJPbmlJZHVVeUo5ckRn?=
 =?utf-8?B?V2ZMVWZrVTJiNFY1U2xTOG5xYnBPMzVZRDNlY3RHaVlvTjdXR2JhR0l3bEd6?=
 =?utf-8?B?ZVJMaERFYjFGVjVaRlZrdHRYV3R0ZnplcUMrSGhYRi9LZGFaM1FxNzNKVjE2?=
 =?utf-8?B?RUNsbnJnN1J5czQyZFQvYm1mWU5jR01GeTVVZUMvNmMzdk1FdGdVUGpXQWxo?=
 =?utf-8?B?NXJmQTRibTdldlZaK2JYQUd3TXJyTW9WK051L0RhK1YveWI5WFZZL0hyUFRL?=
 =?utf-8?B?TElOcGd4d2RyMDc3M3ZiUStuUWpoRkJiTklYbFZUTkFYc2lid1FMUU5FT1o1?=
 =?utf-8?B?NUNRbEp2NFR4MXNaVm9jQVBzd1FPMmUzZk5IbmF4cDUvUHJweWZMa1N3QTha?=
 =?utf-8?B?ckRwdmFxNmF2UnZFMXFIYStlZ2kveW5tcUFVb2dWRy81MnVCenlHdWtBZE9B?=
 =?utf-8?B?MkVYcU1tUEhuYjduKy94bU9YNFhELy9SOC9TZTUrNjY0aVlnWHpONDMyS1Z4?=
 =?utf-8?B?Sy9Xc2EzaE1DSjJsUTZBeDQ2WWdVNElYZkxEQkVOM040bXBrYlZJTUt2NkRi?=
 =?utf-8?B?dkJOc21HdTcxdnlERmRjSjBaQkxKRFhUM1VsU1g5N3JTM2dsQ2JFSkxpcmdJ?=
 =?utf-8?B?UElPc3ZzUWloVUxBRmtSanhUR1NBb3BBanplSEp6S1FlelI0RTlDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21feda4a-6711-4999-b07f-08dee342265f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:57:18.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kd+eVnanPAsGD0mCfmaNiELBoLcpn2f0z1/dB4K4PfUZMun3MraUBMCoELkc2l9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5



On 7/16/26 08:04, Santhosh Kumar K wrote:
> Hello Amit,
> 
> Apologies for the delayed response.
> 
> On 22/06/26 10:00, Mahapatra, Amit Kumar wrote:
>> AMD General
>>
>> Hello Santosh,
>>
>>> -----Original Message-----
>>> From: Santhosh Kumar K <s-k6@ti.com>
>>> Sent: Thursday, June 18, 2026 1:07 PM
>>> To: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
>>> conor+dt@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
>>> vigneshr@ti.com; pratyush@kernel.org; mwalle@kernel.org;
>>> takahiro.kuwano@infineon.com
>>> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; linux-mtd@lists.infradead.org; praneeth@ti.com; u-
>>> kumar1@ti.com; a-dutta@ti.com; s-k6@ti.com
>>> Subject: [PATCH v4 00/16] spi: cadence-quadspi: add PHY tuning support
>>>
>>> This series implements PHY tuning support for the Cadence QSPI controller to
>>> enable reliable high-speed operations. Without PHY tuning, controllers use
>>> conservative timing that limits performance. PHY tuning calibrates RX/TX 
>>> delay lines
>>> to find optimal data capture timing windows, enabling operation up to the 
>>> controller's
>>> maximum frequency.
>>>
>>> Background:
>>> High-speed SPI memory controllers require precise timing calibration for 
>>> reliable
>>> operation. At higher frequencies, board-to-board variations make fixed timing
>>> parameters inadequate. The Cadence QSPI controller includes a PHY interface with
>>> programmable delay lines (0-127 taps) for RX and TX paths, but these require
>>> runtime calibration to find the valid timing window.
>>>
>>> Approach:
>>> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>>>
>>> SDR Mode Tuning (1D search):
>>>   - Searches for two consecutive valid RX delay windows
>>>   - Selects the larger window and uses its midpoint for maximum margin
>>>   - TX delay fixed at maximum (127) as it's less critical in SDR
>>>
>>> DDR Mode Tuning (2D search):
>>>   - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>>>   - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>>>   - Defines valid region corners and detects gaps via binary search
>>>   - Applies temperature compensation for optimal point selection
>>>   - Handles single or dual passing regions with different strategies
>>
>> Thank you for this series. I had a question regarding the Virtual Concat
>> driver patch series [1]. Now that it has been merged into the kernel and
>> enables support for multiple flash devices connected in stacked mode-where
>> each flash device is probed and configured independently-if both flash
>> parts are required to operate in DDR mode, each device would need to
>> perform tuning and store its tuning data separately.
>>
>> Given this, should we consider this use case and adapt the tuning
>> architecture to support it?
>>
>> I'd appreciate your thoughts on this.
> 
> Good point.
> 
> The current implementation already stores the calibration state per
> chip select (delay line settings, tuned flags, and operation templates),
> so the data model supports independent tuning for each device.
> 
> However, the runtime path that enables PHY mode does not restore the
> per-CS delay line settings when switching between chip selects. As a
> result, consecutive PHY accesses to different devices could end up using
> the wrong delay line settings.
> 
> This can be addressed with a small change by reading the currently
> programmed DLL and reprogramming the PHY configuration registers
> whenever they differ from the calibrated values for the selected chip.

Are you going to include it to your series?

Thanks,
Michal
