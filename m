Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B23A6B67;
	Thu, 11 Jun 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178426; cv=fail; b=EyPjHmM4tyX63yBCOu21i4VddSXfJgr6+cMoFLDP13exbhwfmxFEK45jaSfuRL/kb7i7lpgDItArldMKQhP7InDkJk6Anu0cZgIg+X+/MGheU+YDgNUXFKEidjC8ASoGZbbaBdm8r6nczbTlwv51TsvBiFxUlwK+k779WYA6Ogs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178426; c=relaxed/simple;
	bh=fYd5fS1xjpFjCcVzECQ6l3AfWR6k3ieFvpv1qOkqzh0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=McXt+c8RI41YStr7YhYYMRcatym+98km5oPAarMvKXQWtxGa8cfNhO+6WeRQYcEO1Vaagnbhk8KTSWhLL3QyQzjEbm6wKF7tbIZrA2YJ+IieQaSfHF0KPBPHYbN+mdw5Z60sPqXYcG/OQNvwvHM6W5UZ3+GP5VlB0HKL6MIsLeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zWT+y6pd; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zWT+y6pd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1mQ+qSF2x//FWOSV1zWsTJ0FE5wZacS7kk9PCK+zXTsdm2zmi2muJJKwaCqklNFRPJkU8OBZsCm+u5Zwl4BvHwPtQOyTCaX9s4DBdNFKkAP8MSNejxzaSZfpkgDm3klY5n6+zraiE+SdlEXRci3FpfvCgJA1+1E3HgRmxsTQ1xQmS6qA7bnar0rs98U4yNVZlgYuJVKZ8xm8ttCcsjWmhjJrdjYawEX907W9HyNYRn2EcyJPfwUYMMSBWkNEtrqKBQjvCtp+sQB9BEosXojZWYNMPP8nIo7Nf57y7P1uU3GlW2r+D1vSXHqoPw7U27od9qC5F+/CGLis42NujcOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fH2R+4dSDAGVyz4bmZTK/dbnXpI0rHzIE8x5NUYMpc=;
 b=vGoA1pyEHuLfCj/DUecWoqmWwPVBZnC0husOUZ/77PFmMO5ut9YSL/lQKw/2qBKkUXJPzVM9MgGqseVr+oztnhdjbyetBJO/dtBg0XbMkAbVZjuYy/yy8WyacjndJqcRxB4ZpGfLMiFQyv78xrytHyxzYMyzecTXi/JKi/L5QIwlCiq11EvYg1npSGju60T4zCqannm8aBCFy42qWkXQ+MbAmwuLd/UN9FzUFVqc6dwH5Z5JlIIDyF1DKq9LWslcTdQ97IR1ABPh0DUIOM4OrbG6xc5+PbBOaCaZawKzTrFjw0mtqq/pK58BOyVXwzgQSEg/snvYxG51JK33w1ARlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fH2R+4dSDAGVyz4bmZTK/dbnXpI0rHzIE8x5NUYMpc=;
 b=zWT+y6pdWFeaBawkLI0SBUyTGuaOL+sL7LRa+NLHc+jGEG1cTjPZ4/W//sfQqTjdiDUV6fKyLkQdQz3j4KFCjZ6EKDy3JXHvvSDRN3kUA8EC6ria2PhdQCfNywsf+DJtCSDQ1IHR6dz4huElB1Bii91e+PrDSR4Vet1UhvaYMWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 11:47:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 11:47:01 +0000
Message-ID: <f914773e-14db-439f-8992-87fef0835527@amd.com>
Date: Thu, 11 Jun 2026 13:46:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx: use FIFO occupancy register to determine
 buffer size
To: =?UTF-8?Q?Lars_P=C3=B6schel?= <lars.poeschel.linux@edag.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 lars.poeschel@edag.com
References: <20260611071033.1937983-1-lars.poeschel.linux@edag.com>
 <f98775de-f2a5-48c1-8d30-c39d29d0c4dd@amd.com>
 <e6af23c7-1ba9-4acc-af16-394fde75b4da@edag.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <e6af23c7-1ba9-4acc-af16-394fde75b4da@edag.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 427a0c5e-d764-4345-2440-08dec7af26d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|6133799003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CgAuRkhtAYepYI87gRmYq0z0KfqYZK9ktLKY9GpLGbpJYcZmvAYMLPPTrCW9vTHrN0i3+SBBILhm7YyYkjCDVwXbjA7KxoeGU7GM7NEX2Qq9wg8ADjfULa0qy2mqL/HLp9Xp8nGRPkkrCJO6ZfiBE8IGVMwj/m3rTNIW3HA+8Z8dqe74spiWvYOOpgfCs5z3q0iL5T3fvuRLJAKQfuEciAmSyqCifEL7WMSX9cg4ezZMw3O/Gn5UTE+J4y//77afqwuoiynsLHdFIzyphYqyD+vGiELRud8XPj+5R3pAPk3evHKAfh/mWJBt+qHR2vfRACDU/xqarqfsvqnaoIURX21PTD80d3So7/uUzcI538ukUKTsJnew0D77i1QBOP6Bn7KQmGNie7aLpOk8ww+Ig3C+lcYmHnhrbrYW+1f0tu49SsxRShnDNmF4W/Pnc32/CuUfgcYcd2pl85aBOCPqculV0DOf5bWwoMGaotFovoQjW+/o9hDZQIvLKJXT9xw7OxVAXdRjcXMw10sC4uShV2+b+/bLp7B/cfbL/4LVMWyssg+IaaH5c7+2WBHwPIdVUq9Ve/rKBcMcWOKeFmW7Fc+bcudCInPoICTl26m9QERJrjj+FSqXsGnBgv3ahKxy1jcMkOvlE8rVF8YOk30afAFKyUpi3pXyUOfpX7IIv59nXakkFPxMj1ob+HIA3mGH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(6133799003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGN1Y2RWRDRrUCtIT3JKNm1zQzNVWlZnVFNpdFVVUTZHcEdoUGF4TktTU2RJ?=
 =?utf-8?B?Wjk4Sit5VGVMb21IVk8rMWFaQ1AzdVhlK3MzTisybUZRNUNuOGxZVmNFYTB1?=
 =?utf-8?B?K2Vqd1dEbHgzYVJ4SkordSt4dkJEa0ZPdm5SZ1FtSGp5Qjg3aEFScENuU1Np?=
 =?utf-8?B?R1pOV2hQUWcwdEZ1MzltNHk0NG9WYVN6L2h2WTU3aitaZVZ6bUx2a1JuZDRh?=
 =?utf-8?B?T0NML0Nxb2gxNEpJUHZta2FnNk0ya3g5QXlEWUFvcUJxNW5ocUJtRWMrOWVQ?=
 =?utf-8?B?SXp3cWdlR1ZFL3RJRUJUaHlEdkV2MGtmTWZ1OGp4NnFzVXFPangwSTNPdk5h?=
 =?utf-8?B?VUhGWTZndUhNSGZlVXVPWEdRcSt6YlBwTFM2aDlMeDNOMkVkQ1VjcktwcStI?=
 =?utf-8?B?Q0ljZkx3VHpEWkFZWTRxVWVWQXIxVUozS3ZScjVSYUo5SmZnWUFrdURTVE9k?=
 =?utf-8?B?dExtdkFRQXB0RlliL1h1RHd2MDBkQWxsUkFrcXZNTGdqb2lKUzVibUxHUzFj?=
 =?utf-8?B?YVEvUGR0RXkvSWk5QUp1WWFSQXJyeCtFYndCSy95WWtYb2V0T3g4TjZjOGxa?=
 =?utf-8?B?aEZFRWJoZ3NhWHl2UHJBV3hQRDJFcmhsSWt3ODVMVlZiSWF0dHdOcXVKUTdU?=
 =?utf-8?B?Q1BQVFZMRUJaQ0sxeEdGL0ZhclhyczBNSHE5d3dRNVJFTVZNMFl5UGc1WDQ3?=
 =?utf-8?B?N3pJTWcrSVZkbm9vN0ZHMytlVTcrRWJObWQrZjJwYVJmRHA3dVllY3FBUzZh?=
 =?utf-8?B?MFpuZUg0RFhLQWhQakFSZDJUdjZOQ241WDBNbEFXM21OVCs5Y3pQblphZUFv?=
 =?utf-8?B?MEl0cUdJSlhLa1M2UGpud25hcWx1WndvUktnbGhqVkxndEM4VjJwclZESmNX?=
 =?utf-8?B?Qk0rNHlFVjJYVG1UZHpxUms0SDA2YlIrNTNacmx6Z3N2Qy9SenEvTDhPQXZX?=
 =?utf-8?B?cHpFTkFieUV5MlQ3ajV5WnZUT09QT1FBa1BWUTRJU1ZNakg2SUhnR3BCU1Ri?=
 =?utf-8?B?cEgwVlhMMzAxUmhJSnR6ekxlSlpBaFpwMnFmYmIrQWJ2RGpLMWwrTjN2RHVj?=
 =?utf-8?B?amd6N0xJRDlzNjRaWFhDaWlMaUhWRCtjS2VjcjZnVWIyN3YzZEF5NlV1eXpk?=
 =?utf-8?B?Z25ONzZQbnRpTmZreG1RbXpoV0g0d2l0UWNRZ1BJUThqRTdOa3RVVlNUcHdi?=
 =?utf-8?B?VjlUMkdrWXIrQXVXZ1hpREdra2VrWXJLOVEzeUI0N3BEdTVhSWxsR2hOclZ4?=
 =?utf-8?B?WUl1OHhPUmxkTXdlMUNCdUFTd2pkZk9GeFpROXJ4TS9ENXlqK3VkaS92cTlR?=
 =?utf-8?B?U21nVENlSHNuZUdMWTQ5RVR0U3BFbU9EM0dlaDkwQ3pvUmduMzJkOUVDN2hv?=
 =?utf-8?B?VG1pMytvZGRoZW9tUHdKeE1aeDR4YzAxSzhYZkJjWHNJcFJrQ2xvTzhEbU1x?=
 =?utf-8?B?U3BJc0NJVW5EdFM5OUIzZzkzWVh5eW91RnpKUE4wNTVZckp2VHNkQW1sKzh1?=
 =?utf-8?B?NU5pN3pWc3V3UG1YdDNUeWVHdHRBNDB0OUdDN3h1cW5YVWhST3dzalczeUEr?=
 =?utf-8?B?UTFkbFJENi9ZSXBnbXhZbk1LQlJYaCt1eWhsaTRURUxwTU9pZnRabEE2OHQz?=
 =?utf-8?B?ek5scW9UWXkyZzQ4MFNORWhMMU1xUjVSRWE3TlN3c3JrNmdqN0paZisvY1lr?=
 =?utf-8?B?M1M1eW9rU29WYzBoVncyekI4NytRWmRUYXdEdXRQdlEwUzVWSmdHSUE2YUFo?=
 =?utf-8?B?aVZuSWZzV1RMaEhHS1RJQVhMSVROVjcyUTNyQ21ZSTZuQU1taW9BK2k4R1JZ?=
 =?utf-8?B?SjlzNEpkSUpHQjFuVXpMS0FsQ0RIdXhPOHBqcUN3OVI1WXhMN0cyaGh0WGtk?=
 =?utf-8?B?V0dUUzQxdm9zMEFjOUhvWCtFSFZ3TGZOdGNLRFdUUkU5dFc2U0xiZEtQSFZ6?=
 =?utf-8?B?Q3hsKzZEVGphRlIwLzl4V1RLMDZ4Mm9nRXNTQVcyUHF6Y3hEempucjBpRDJN?=
 =?utf-8?B?SEpxazlGb0R0M3hlTVJjYjNEelhtcXRncSs0cmVnb3M2Qk4vVk9TS1RKMWlY?=
 =?utf-8?B?OWk5ZkxmclY2WWhpQXhFMWVoNzJKcml0R1RKYUEvWEs3a1dlR05xTnVNY2hm?=
 =?utf-8?B?QUZlNnRKcXhvUjRZMjduVVJKYjFuTXRTUDIzT2pNc21FMHFTYUNNZHg1VC9S?=
 =?utf-8?B?ZEtrZ3p1Zjl1R3dhY29vaUNWTmFneWhUNHZMVDZPTG5pcm9XMytRd1g0RVc4?=
 =?utf-8?B?M1BJT2JNSzA4YmcreXlacm51ZEV5OTE3TG9KNzJHOGJEL1dYY3JEdDNMdFJO?=
 =?utf-8?B?SW5XbVl3MGYvRDVuY0FUTkx3S29mbmdvV2lmeXFreHBiaEJRdVUvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a0c5e-d764-4345-2440-08dec7af26d5
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:47:01.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLhui0iUC2+WOZQcPDhXUH/DFPdmcJ7Ilk/jzu2lqQoLTMhEEgeS41/IXfqJ+Ttr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314



On 6/11/26 13:36, Lars Pöschel wrote:
> On 6/11/26 10:52 Michal Simek wrote:
>> +Amit,
>>
>> On 6/11/26 09:10, lars.poeschel.linux@edag.com wrote:
>>> From: Lars Pöschel <lars.poeschel@edag.com>
>>>
>>> The method the driver uses to determine the size of the FIFO has a
>>> problem. What it currently does is this:
>>> It stops the SPI hardware and writes to the TX FIFO register until TX
>>> FIFO FULL asserts in the status register. But the hardware does not only
>>> have the FIFO, it also seems to have a shift register. This can be seen,
>>
>> I don't think you should guess here
> 
> Ok, I will change that.
> 
>>> when writing a byte to the FIFO (while the SPI hardware is stopped,) the
>>> TX FIFO EMPTY is still empty. So, if we have a FIFO size of 16 for
>>> example, the current method returns a 17.
>>
>>
>>
>>
>>> This is a problem, at least when using the driver in irq mode. The same
>>> size determined for the TX FIFO is also assumed for the RX FIFO. When an
>>> SPI transaction wants to write the amount of the FIFO size or more
>>> bytes, the following happens, let's assume 16 bytes FIFO size:
>>
>> s/let's/for example/
> 
> Ok.
> 
>>> The driver stops the SPI hardware and writes 17 bytes to the TX FIFO and
>>> starts the SPI hardware and goes sleep.
>>> The hardware then shifts out 17 bytes (FIFO + shift register) and
>>> simultaneously reads bytes into the RX FIFO, but it only has 16 places,
>>> so it looses one byte. Then TX FIFO empty asserts, wakes the driver
>>> again, which has a fast path and reads 16 bytes from the RX FIFO, but
>>> before reading the last 17th byte (which is lost) it does this:
>>>
>>>     sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
>>>     if (!(sr & XSPI_SR_RX_EMPTY_MASK)) {
>>>         xilinx_spi_rx(xspi);
>>>         rx_words--;
>>>     }
>>>
>>> It reads the status register and checks if the RX FIFO is not empty.
>>> But it is empty in our case. So this check spins in a while loop
>>> forever locking the driver.
>>>
>>> The new method for determining the FIFO size is to read the SPITFOR (TX
>>> FIFO occupancy register, value = occupancy - 1) after filling the TX
>>> FIFO to obtain the true FIFO storage depth, which also equals the RX
>>> FIFO depth. In non-FIFO configurations (n_words == 1) the register does
>>> not exist; return 1 directly in that case.
>>>
>>
>> missing fix tag.
> 
> Ok, I will add one.
> 
>>> Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
>>> ---
>>>   drivers/spi/spi-xilinx.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
>>> index 9f065d4e27d1..2d31e30fc4eb 100644
>>> --- a/drivers/spi/spi-xilinx.c
>>> +++ b/drivers/spi/spi-xilinx.c
>>> @@ -54,6 +54,7 @@
>>>   #define XSPI_RXD_OFFSET        0x6c    /* Data Receive Register */
>>>   #define XSPI_SSR_OFFSET        0x70    /* 32-bit Slave Select Register */
>>> +#define XSPI_TFOR_OFFSET    0x74    /* Transmit FIFO Occupancy Register */
>>>   /* Register definitions as per "OPB IPIF (v3.01c) Product Specification", 
>>> DS414
>>>    * IPIF registers are 32 bit
>>> @@ -377,7 +378,9 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi 
>>> *xspi)
>>>           n_words++;
>>>       } while (!(sr & XSPI_SR_TX_FULL_MASK));
>>> -    return n_words;
>>> +    if (n_words == 1)
>>> +        return 1;
>>> +    return xspi->read_fn(xspi->regs + XSPI_TFOR_OFFSET) + 1;
>>
>> Based on pg153
>> Exists only when FIFO Depth is set to 16 or 256
>>
>> Based on ds570
>> This register does not exist if C_FIFO_EXIST = 0
>>
>> It means this is not going to work with all HW configurations.
> 
> I think it will work with all HW configurations, even with no FIFO configured.
> You are right, TFOR does not exist in non-FIFO configurations, but then you will 
> take the
> 
>      if (n_words ==1)
>          return 1;
> 
> path and exit before reading this register. And then according to PG153, Table 
> 2-6, Tx_Full bit:
> "Note: When FIFOs do not exist, this bit is set High when an AXI write to the 
> transmit register has been made (this option is available only in standard SPI 
> mode). This bit is cleared when the SPI transfer is completed."
> So n_words should be 1 in this case and I think this should still work.
> 
>> Pretty much you wanted to use this register to find out how big is the fifo
>> but I think in this case you should be just fixing logic around +-1 caused by 
>> n_words++ in a loop.
>>
>> What about to change logic to be like this? It is clear and it is without any 
>> +1 logic and no fifo is handled separately?
>>
>>          while (1) {
>>
>>                  xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
>>
>>                  sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
>>
>>                  if (sr & XSPI_SR_TX_FULL_MASK)
>>
>>                          break;
>>
>>                  n_words++;
>>
>>          }
>>
>>
>>
>>
>>          /* Handle NO FIFO case separately */
>>
>>          if (!n_words)
>>
>>                  return 1;
>>
>>
>>
>>
>>          return n_words;
> 
> If you still think, this is more clear or better readable, then I can change it 
> like this. Let me know!

I understand that without FIFO you should never reach that code but I still 
think it is better not to deal with it. Pretty much if you want to wire this 
register I think dt binding should be extended to cover this optional feature.
That's why I think it is better not to introduce it.

Thanks,
Michal

