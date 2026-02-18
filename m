Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1C344DAE;
	Wed, 18 Feb 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438125; cv=fail; b=WFqdmYASmP4YbCTJQDQsa7LwyO+RqwVja9W5g6o1Yq45QkswzoDEu6bVfTpuimZ9xbXIlca337aM++I/0xd+tZuv6/bsWzQhnXnpiXoRIh4M5XCfoPwTslHuGOJB84928cJv8UB0nUkLdN+lFXo0BoeQxLLrKerWL4XA+Hx9Ldc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438125; c=relaxed/simple;
	bh=ZvIXADf9OKDJ6p0zm/Gb+DGadXtbxau2g/JcCW1VCVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AzU3EdirWRCxy7n+DtHDQRIetK+5wd5YVlVX5uRKS4JYU8Vp/5UM3ThpFjPqKri9BkoABF1OCDgMhrWU21wyuLOHHvTLBLBONPzOk927UUZdRyuiGjLoehTXrEZOXxc8pD/VTkFJyMt+gPY93UjZae0T9sHjqcZsTqhVAjy7BlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lKYPzYfh; arc=fail smtp.client-ip=40.107.200.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lKYPzYfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFsIab3tFWzHDzxzbIDYvm7PlgGQMeyA9AT1BJ54yRUE75SfWyvrJ13Ra9eTfpbgw09kvw5kJz0A/L6btgYEtOwf8AdDqqe/ITMhUw6XAk+Ly2xd3wy5nEi4M4TqCnvmz7bUra9vxKd+CB7qqQHHYBJdWWgSjiK1NcvEFx+Hy3/q0n/wuiy2yOwhg/kitQZBFth9p/m2Qxp7B2SZgFGM/KkFJNwWPrYd0+tK7bTQe7cS4IwhOJbDAFXS7XeQJi7es/9rwF3k8AJT9e6AQiME6mCyi686tFQRgC9xwBVEdqnYMEXx1uJnSBkZTS4piKF2xTaG2uHkrRmGLCAlW69ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmbEjNPWIHYrB0yDByxNinl5MTIvL8ntql9LVf4QI14=;
 b=RrL7xNc/DS7rXAYlKftQPifk+FIfQK+aM1a5D/PdcZ25Y+4mTNjWMcZFpu5Uf2EXMmAmQghjWgOMoLvQmehoN44tSwy5p5Lh6fmfDBwlulOs2ecsnS0/xi4w0nn88F6ollmkmUBcl5qaLHw+8b+QXHLVjfiJaiGEfdJln0ka3YHimNdfneykEcny3Gt8qoObyg5TXK3St6qnojqzVZbQdvMR9NGTMgFm1UUZBnb6YFZ2O1mXL3LoIX+8adqQ7SN/AAI+r43bHIs/1+E042w/vbbTJMTEmU2jSAq0vZThdB66BVV0jnxbunIQHKqRGm3S6ZUpLZW3+o1/zBHE2DwJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmbEjNPWIHYrB0yDByxNinl5MTIvL8ntql9LVf4QI14=;
 b=lKYPzYfhWV4jv07t8B9uYQR6fmbOAOcUmpGh6o9rQ3cTqWfozuZ8T13aZJAsrRreoKYcTEd7HEM1VNQQtLLQsZlhoWJJdU1d+vfucsKrraVBECO1dweqg0XNpA/PFaecIYH7UhbIQF2C6Kpud9m/1agDF+WzOYFSZ7jecqnziik=
Received: from BY5PR17CA0042.namprd17.prod.outlook.com (2603:10b6:a03:167::19)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 18:08:42 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::fd) by BY5PR17CA0042.outlook.office365.com
 (2603:10b6:a03:167::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 18:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 18:08:41 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:08:40 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:08:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 12:08:40 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61II8YbL803002;
	Wed, 18 Feb 2026 12:08:35 -0600
Message-ID: <485b5e4c-8260-4f40-80b1-c0e85bdeb4e9@ti.com>
Date: Wed, 18 Feb 2026 23:38:34 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <87343ghkek.fsf@bootlin.com> <87v7gbdwdh.fsf@bootlin.com>
 <775d8dce-b567-4f21-963c-a843e409fea5@ti.com> <87y0kxvwyf.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87y0kxvwyf.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ac3e8d-e633-4749-f3ad-08de6f18bf53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ptRXphOC9wUlBlMWl2N1VCRlFSZUpibkQ5T21JVXQvdHkzc1BSOTkybHZ6?=
 =?utf-8?B?aTdrT3BEZHYwaGdxS0VJbGRndUNHWHA2U3ZPWWUwNit5MlhJZ2dDYk45TFF2?=
 =?utf-8?B?dFFXSEFiQ2ZjSFltcVZ6WWMyclFlbUQyVXVKVXJqQkIxb01ndkxPSFFGempk?=
 =?utf-8?B?T3Myd01NUE9Oc2w0dUxPSEFabFJqZ1NZWlV4ZUpBTk9yRldRTkwrbEVLTHUr?=
 =?utf-8?B?REVMZ0xyYm5MKzN1RFJnZGhvZDlUWkk0U3B2S1p0cExuMkFLbS9LeDdOUjVq?=
 =?utf-8?B?NHozcS8rNndCUVdGYWp5S0JmNHlKeU9jTkN6TDM3ZUhLRVljd3pVZmJFbzNI?=
 =?utf-8?B?b2YwSUF5Z3QyRDJNNCs5SkRzbW1SNHAybUN3T0VnSE9ONU1mSm9lUWxyb1Fn?=
 =?utf-8?B?aVRZZWU5K3crN3JBalZZS0NzMnBzZGhBWVNEc3dnY3VCd3o2aDh6cGpqKzhQ?=
 =?utf-8?B?czFWUXVZb0RMU2hyR3NOZFkxM0tVUEp1WWpSTUthUnhKaXRaQkZFaEFpc0hq?=
 =?utf-8?B?cStvSWl3L3EvQnZnVEFDVS8xS1MwTUZIUkFQT2xEMEI2THJPREtPdm5HR0lv?=
 =?utf-8?B?eXI5UlVrdWdXMkt1SlYyTEtBcDZsWGI2R3NsSzF4MU9EbjBmZFZHeFlpaUov?=
 =?utf-8?B?MkZhZFNSK2x3THNZNlQvSDZLRDhlRTN2RGkxZ0pNRCtoT2tBMVVYc3ZkaUpy?=
 =?utf-8?B?K1JHWW83YitzNDlxaTdONk1VYUNGcjdLdWdWR0F5QjNjWjNZYVpGVkNtTElS?=
 =?utf-8?B?N05lU0Fwb3NrWGFGb1dkUVo4dDJrZ05lVUhNMStNSEVqSkRTQ0tnZ0IzOWpE?=
 =?utf-8?B?UE90SDdwZnlsdWV3a0VucFVtVzlXWVBUUjhUNUprQTNGTUQwOWYwUGMvVzRN?=
 =?utf-8?B?aC9acDAvQkkzUEc3WHVYZ1IveGRzSjNENTFMcFpNR3NZMmR6SDI0R1hxZ2Iw?=
 =?utf-8?B?QUtnVmF2SU5BZURUSzR1QnJRVFo3Y09QczEraWY1R28wSDFHK3pJRUllTzda?=
 =?utf-8?B?U0xyN00wSVMwelJFazVlV2s0UnFWWWRYbHhZMVg2OHo2ZHRKZjVXTCtUcmtt?=
 =?utf-8?B?L0FkTWVoVXVPMWVSY1RWc24vU1RsNjlVR0F0TzdCTWtUcXVjTnJxem01cmVH?=
 =?utf-8?B?a2JRM3l2V1NVMS9Yd05ybkg2ZW4rUDBvWjRINkRzMG1VUEUvRVRyT2tBZXZj?=
 =?utf-8?B?VWRLRHc4YnR1dW9VOHpaS1JvMzdNVTFCVEdUVDdrMlpqeWlMOFU4MEw2ODdY?=
 =?utf-8?B?d1lFSHl4bE9YNDN6aDN2eFFnWFNlTGo4OFNlQU9FSXUzQStMMWdnU0NFdVd6?=
 =?utf-8?B?emh6UXlMZnZLUDFBazg5cEFtbWxrdEx0YWFtU3RtMng0Tlp4eCtSYmVHZERk?=
 =?utf-8?B?REtmYjhVcjdQV1djNzlzSExHRHo0QnA2Rzh2RGNMbEtGNWliRmhod3JNazRU?=
 =?utf-8?B?ek5iZjdUYVUrZ09SVzFmazUyT1lCUzVPL3VGbnNLVDluWXlPNnVnTXlKa0J0?=
 =?utf-8?B?L2RKTEdkZzAxMDBTeldaeXFjMFZ3aGJ1VzAyMnlMTldZRU9PSVY4MC9VempD?=
 =?utf-8?B?UVVxa1Q4S1p4RzhRakUvYkQyTWRWN2JMVXdHdHhubFNHREFKYmdtZVlVWERZ?=
 =?utf-8?B?OTdFRWRFYUwvYWxkQWpqZVcyaERzSzFVUkMxZ1psS1kxbjdpSzhBQVBvdFhu?=
 =?utf-8?B?U0JTbDFIVnpsOHV5eWQ4dHZJWlNyN1FPcDVsZ2dRMHA1NVRqdytWbTd0SXZM?=
 =?utf-8?B?RDVjWVg2L3BSdm1XOGlDTlJwREhIVTI5N0xXcUFQRGNsMmJwUkMzODhhRThw?=
 =?utf-8?B?NC91Tm1QWE9XSDZPMTA3eVlPSFUvOWtWK0tlakxhOWdlYmxRVkJteVZRVnZy?=
 =?utf-8?B?eFZqanBJVy9zbUdTRlRwWjJRa2htK1p1cVI4NzN0SVRsRmxJOWlYSUx0dnFI?=
 =?utf-8?B?OFlweG1nOG5IaUg2RXNkSHlzTitKUmduL1d6dmNWZlpzalNwdmIzS2kzbjJZ?=
 =?utf-8?B?ZTM3aWNwaHN4ajRaNlhYRTdJVnQxTUhkQmpxRUF4WFZUNjNwNFA1L211N2Ix?=
 =?utf-8?B?dmZxbG5jTFdjQ0Jzbm9VVW43M2JnZUd1VkkxWU1JdUkxV1pVRkE1eFhaU2hx?=
 =?utf-8?B?dGZRUUsrd3lRZ1U3QlVERFlzSWttRkY1YkppMWl3Z2hqQmZLRVREQ2ZzR2JT?=
 =?utf-8?B?NUJEeXU5amJ4YzZ2MTVCbzQrcENTcFZSaDVZTTd1ZXpwQjFlM085VXlaYS9j?=
 =?utf-8?B?UmhjVGxMZStldE9iOWs1NGdOUmdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mq7wDWG+D/PQS6b0277xTVhaQrVj6+c9Nhk3IFNkV7XoxRYu2QHylIMV8b35ADzYlN6Cq/HIa7njXstV/d07Fzk90lYRT5USWRlRyEmqRyriFRHPKB0WQGXfmk76f3hqvvULv3K8i96m8p4ezKa0chbKTvn+DxWDzNp47KrymzOqU3LMC30tKL9hl3rU+/vpW5gTgobPBH72NtIA8X0kH0fuWjo/olmU9N3TspA+e59KXhXmAoPOBOiDm2PIXx3ACqhHqehE4kIhtsVFxZUkKT9SIuzboK20ojgswqIhjpNQMKbD+2DsKG4yCAHyWj1ZKIPLnsPfoxM5ZL9MXMXEqPqN1WhPvKGGwZUWs1mxGEQqpBAzskremRkAo6xJs+m+Hle+1m0AiYK3DfosGUC/VS+2jEAZTqOqy+Coz/pEc6hEsVVhVwE94cF+LSsIqMFV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:08:41.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ac3e8d-e633-4749-f3ad-08de6f18bf53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547



On 13/02/26 14:31, Miquel Raynal wrote:
> On 07/02/2026 at 00:58:03 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> On 05/02/26 21:18, Miquel Raynal wrote:
>>> Hi Santhosh,
>>>
>>>> I am surprised by these numbers, I would expect these to get higher for
>>>> SPI NANDs. I will test the series and report my observations, especially
>>>> since there is also ODDR SPI NAND support now (in nand/next, should be
>>>> part of my upcoming merge request to Linus for 6.19+1);
>>> I just tested the series, here are some numbers I grabbed on TI AM62A7
>>> LP SK with a Winbond W35N02 SPI NAND chip (so in the end very close to
>>> your report):
>>>    +-----------------+-----------+------------+
>>>    | SPI NAND        | no tuning | PHY tuning |
>>>    | Unit: MiB/s     |   25MHz   |   166MHz   |
>>>    |-----------------+-----------+------------|
>>>    | Octal SDR read  |   13.8    |    34.2    |
>>>    |           write |    7.2    |    10.2    |
>>>    |-----------------+-----------+------------|
>>>    | Octal DTR read  |   21.2    |     N/A    |
>>>    |           write |    9.0    |     N/A    |
>>>    +-----------------+-----------+------------+
>>> Please mind I used MiB/s and not MB/s (so kiB / 1024), I don't know
>>> which one you used for measuring, as you marked MB, whereas the most
>>> common unit seems to be MiB.
>>> However PHY tuning failed in Octal DTR mode (your series applied on
>>> top
>>> of nand/next) with the following logs, can you have a look?
>>> [    2.261647] spi-nand spi0.0: Winbond SPI NAND was found.
>>> [    2.266956] spi-nand spi0.0: 128 MiB, block size: 256 KiB, page size: 4096, OOB size: 128
>>> [    2.285257] cadence-qspi fc40000.spi: PHY tuning failed: -2
>>> [    2.290835] spi-nand spi0.0: Failed to execute PHY tuning: -2
>>
>> Unfortunately, due to a known erratum in the Cadence controller, PHY DDR
>> mode cannot be used with 2-byte addressing.
>>
>> Refer:
>> Errata i2383: OSPI: 2-byte address is not supported in PHY DDR mode [1]
>>
>> As a result, the Cadence controller supports only the following
>> operating modes:
>>   - PHY DDR mode with 4-byte addressing
>>   - PHY SDR mode
>>   - TAP (non-PHY) DDR mode
>>   - TAP (non-PHY) SDR mode
> 
> I do not think we have 4-byte addressing capabilities on SPI NAND chips,
> esp. Winbond's chips. So there is a down side: the core will pick-up
> Octal DTR modes rather than Octal SDR (with PHY) mode, which is not the
> fastest mode. Maybe we can guess that once we have access to the max
> (tuned PHY) spi frequency, with an extra flag in the driver indicating
> that the PHY speed is not accessible in DTR mode. But this again
> requires different handling between SPI NAND and SPI NOR, as SPI NOR
> IIRC may have 4-byte addressing capabilities.

I'm currently handling this in the Cadence controller's supports_op()
callback, and it seems to be working as expected.

If a DDR operation is passed with addr.nbytes <= 2 and PHY tuning
support is available, return false. I'll include this change in v3.

Regards,
Santhosh.

> 
> Thanks,
> Miquèl

