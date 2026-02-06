Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CA23D7E3;
	Fri,  6 Feb 2026 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405798; cv=fail; b=mEbbkNdQm0j1AClik1KWFdKNCx/YaIuJCzoaNh8WRDg0fCZ3KpLJl+xIjU1UOOOOKP7fgo5IHM7M+yLQpISFAjTHtjefp6ZU70QVfz8dbkFxp9yZ81RAPkfXw1X4+S+/5VK9HFmCZh292BjWZUCJoTQDTEpCs4lgwnXxl0WWdJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405798; c=relaxed/simple;
	bh=IAZYNFsPuIpFD8fRCkGl+6MG6dJVcPq7/iFItG+nHus=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jQB5wGl00KhmjaHvdlNTKWbXZ98TMWDzG4wZgC3wk8EBFjk+myuhob/Bak0p6dPhTKsVi8h6OfgL6m4LG4xtJLzORxkJxqqnCUh3Z6T991eUGG+Ha6Usx4ozJEtjiLGKKgdcOMeompeBcvJxopWQPB637XoBV6FCRTrMP+qbNi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sv5/tgwB; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sv5/tgwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFoxLQbRn32+g6MkxORbNVdU3pHCxYr7zusHmiZ3NDJzEXO3+mv90bEDrnb1vPdAqcRBsffSj+e2lVcjPo8bFdCYgm+kKg7qM/fVuvUu4T9F1TRP9aPkG9MkqN0xbbN5XdSMdW3a2c8UDO6HOUk8qQ+4inCye2B7IkQ4RzJJPEyKgSVKoo3DknIvdcpSpz/nHrMY0jlhZHZtwyH0iMByRD5APR2wpOpoLSk30mrl7scw0v+lJz3OewSCIFvY6Ua1O2NchtHZWkA52KVkOmw0uJia0hCJ6AdpAmKa2wRs0WtIYqjRCDWmjQIQbYqL3wReitzMa5Tu9AWqu4uMyUjMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgoOM6lAV3k64IYQQGV5llq9GZJioKG2YUcoxIP9IyU=;
 b=ut5DMmMYzFc+upMjZl55pVjYwgsN7kLnWFOsXLGwE3K5iljZ35Q2lLyqqAECsnzyXqlcgNSU7cJqL/HBitNifSacsYKOI3I9WMEi581PPOWZpzJPK9Mrz/GNeSPE5xbzWksnfzK9jUq6wlDN0xwxY4BaZU9DD7h0zHWqxrQIV9WvKgSFXr2kGw7goBREyaTafjDAL1GBQgm/nm2IC03Z82Pt83WpDsAU7F9lW8Rd/5IyMnHZYopzqH4GJ/zkCc7PLe6b/aBLK5lHx/Os0F59rR9WKHuXV/qQWhR3MggMRlGCqdo4XMXQ8pvOW8KcvYiMA7YXMgDTlQG5Wj2dNArIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgoOM6lAV3k64IYQQGV5llq9GZJioKG2YUcoxIP9IyU=;
 b=sv5/tgwBFIrGWx/T9wAZLq25hhL2dbLhjmV2M8dFyqujakuJKWCQi7I8ZytPG9TvHkjxAqWwcr7+klNIRaI9R/vgJ1J/AfFAMkvBSOEvPqJGeZoHKZ5qoW4v7RUh9u/9k0or2bliT5WWf14MK88x1f9sRBKALWjZkHX+BxP/l/s=
Received: from SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) by DS7PR10MB5184.namprd10.prod.outlook.com
 (2603:10b6:5:38e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:23:14 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::bf) by SN6PR2101CA0005.outlook.office365.com
 (2603:10b6:805:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.3 via Frontend Transport; Fri, 6
 Feb 2026 19:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 19:23:13 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:23:11 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:23:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 13:23:11 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616JN6J51835842;
	Fri, 6 Feb 2026 13:23:06 -0600
Message-ID: <fc8d1ac0-c713-40ee-b818-47548f9d1818@ti.com>
Date: Sat, 7 Feb 2026 00:53:05 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/12] mtd: spinand: perform controller tuning
 during probe
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-4-s-k6@ti.com> <87tsvvgkks.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87tsvvgkks.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR10MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: df51f4a3-eb77-4a09-8265-08de65b52c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEVsSTIrajVub1BJU2d5OCtIQkU3dmpLSDZrOElzNkJOdCtodFdnd01GYzIy?=
 =?utf-8?B?RWpDK1JpYnVyWVBMOG9tbHNUOU93ZWsvWXpvOHZaVUt2UmhZSFpGSU5ocC9V?=
 =?utf-8?B?RFZJbUhqMkdUTDZzN2t5N3BwOTFTNEtTT2VpUzFENk5LUVp0Rm16aEZVODNi?=
 =?utf-8?B?YTh4OU1pRnpDdTNyM1VZMnVsaURKMVVCWkVrYmszZFF6cHZQOUdXRUJqbDky?=
 =?utf-8?B?ZGdGTTMwZnFIY0xmZmU2d25ENUprWjFTbTQ3MzhTZ2VTUmt3MXJHSG5LRzNC?=
 =?utf-8?B?TzhWU0Z6WW9lK3NMZjg2VkJiR29oV2JrcmY5MFdoeEpndUFtemlSSG9WeEpp?=
 =?utf-8?B?anIwMURtZk80a09LRGhKUjdxS1FJenExVkRmUTlLMW9zclFjSmQxK2xMNWxZ?=
 =?utf-8?B?QVh4ZVl4MjQ0Ukd5RHdBc1YzZEZ6TXluTmpkNjk4MDB1Q3hxU0NEdGljM2pp?=
 =?utf-8?B?WWVtWDlaN1UvNEthVEllVlpWM1IvZ1RPYzdNcG1VY21jeTFTODN2MmRPYzlH?=
 =?utf-8?B?WnA3dDh4enZkWGN3eDAyTGtSNFh4OWZWZE5YL1ZGYlROaXZCaTNKSVljUnNa?=
 =?utf-8?B?Q1NGbUtJNUExTjdJa2U0c3pkOU9VTWhqcDhYcUU0dThsYnlEOUpsMWFuKzBM?=
 =?utf-8?B?K0tjckFtUnFWMytuN0U5NEE0TCtnRDE2eHJTWVdRY2htbzl0KzN6dkEyUENx?=
 =?utf-8?B?THpreEIySmNjQTV0WkdzNmtJclR6M1BZOGJPakV5UEVvWGtOVWVFMDAwQlN4?=
 =?utf-8?B?b2ViWlB2VTZiYUxtd3IrMkRxNTlKUHZjMDE5ZXdzLzJVSWtiSXg5Vlp1U3E4?=
 =?utf-8?B?SE4zM0xFTUlyQmpLYml4VGtUdVZzWG1vNU12VXFtaVE0dkxtcy9pV3c5Rlhi?=
 =?utf-8?B?NE1SQjlCUHIyaEZqaWpCcENnUUs5czBYSThCL25nem1kVVpGNVNvUEVuanlQ?=
 =?utf-8?B?cVEwTThzL1Q1STRhUlVET01acjdUSm13YXFGeHV4Q3g2SC9Vb1V5alVTMXNX?=
 =?utf-8?B?NXJ3ZnUxdkJ4c0c4cEh4WktvMFRWOFZWU3NpR2FDanNBOFAxMk1HSC91dDVX?=
 =?utf-8?B?Tlh4eTdXOWFPUXdhR3I2QXNZamdvR05acEhyeFkyOWV4bG9xRkhGWldTVXV6?=
 =?utf-8?B?UEJjUnd6aUQvdzRhdFpHMXQzL2txdmtZNEFKc3AzWnVzcmoxa0k4MzN2VGxJ?=
 =?utf-8?B?Szk3djFBcWtob2R2NlA5VG9SOFZGUzNobUo3ZjJFTFhsckRIWXU1UUkrcFVF?=
 =?utf-8?B?bkt1aS9JeVJ2ZTExK3JyQ0pvb3RXWHlyY0cwWXdhUEoyVmEzellnNlQ4MXF1?=
 =?utf-8?B?VHJEdGVQNnowaDFldkdvT0ZiMkxqUkZPRkdXMUIyRVp3c3JJbWF3Zk5CeXly?=
 =?utf-8?B?SHU5RzBEaWhvblZoR1FjcWJuVUExV2NYemV4NDRlZnB0NnlyUjIrN1FBdE9D?=
 =?utf-8?B?T24wcE5iNjg3Y1RLQUFRUU9FKzJ0cWtQWGlnMUlSYUV0QXRnNDQ0NmQrc0hJ?=
 =?utf-8?B?WEpHNmM1WThPTXlNTURRVXFuUk5ZbDVndSt1VmJueVVZOGZJamFjMVFneEt2?=
 =?utf-8?B?UFlMNS8xcEN1c1ozOEVXWGVBQmlHV2FFN1F0aXkzUHpqclB6cjJxa0V0bnlM?=
 =?utf-8?B?N3ZMeTdqQWRpcHh5VGViZ252VzBFVXF1UXlWUzBlTTI5Tlh2dmx2VzVwZ3Jz?=
 =?utf-8?B?VWgvNkx0aVFwckZ4OW1jM1hzeFFIV2tJeXFmOXk1WXBXa1Zad2hUZkRoRmts?=
 =?utf-8?B?NlZEallnekhSN0xVNUxOMW9qM2p3L0RVUThVVHVzejhacGJ0TVgzbnJpaGRv?=
 =?utf-8?B?c0JxeVlmbWgzM1k5MWVlZE9iWlN6ZWRacFJ0cDNWb1pudERuVmtJV1ZucHV4?=
 =?utf-8?B?alBEV2xOb2w0STk1RHRxRS9WYmlURDcrelk2Ym1iem05TFptL2VKcWZrRGFo?=
 =?utf-8?B?OXNZckFlclR2QjR2VjM2Y0llcmdaKzNFK2g1VGZRRnl1T3lCK2c0ZkVlT2ll?=
 =?utf-8?B?UW5oQzk3WThJYTZPZzZ6WldBZFhOTlpaMkF6OEJQVU8zWHZncCsyek1ydCtk?=
 =?utf-8?B?ek9UakVvaVIvOU0vY0dMYTFtSjlra1ZGWmNUM0pLWHRlc2VvQlUrWmFmNmpM?=
 =?utf-8?B?SkVoWFpBOXN4dHR5c1A5Yzc2dVpLT2hPdXFjR2xobjBsVTV2VWoxRlRQKzE5?=
 =?utf-8?B?WVYvbmFHaWJGS1lCTXYxNGZHSnp6aU8yejFURDlOdWtUM2RyVFY0UHRheFZK?=
 =?utf-8?B?N1VUaEpSV1VXZkJnWjNPWDN5ejN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d0BTbG3IPxfD1Odg+20owAN3l30ZZr1WdMZPBcKhuOkc2F6M2SessOqzqEEsatOpviRsdzpjsj31YfBb2LiIryMDTwQMQUcoJd1iMZghLswGeE05PfRpi+oz7vIN5xG7MCoRgHVsA/xE3xVuVgOYJLPNkstvu0WivG2E/xXUaR5mPeQaoLm5wcDhKqX6v+evqQDKnvtItRSfJokKxOlQSmZPexvSsL0PQ5s2ICz5bDnHZeaWVELUsG4/0sRJsde0TJifJF8u+in6CknGCvPLvxQxSss8WH8+nA5YN5UXh47mO8mWbc/HwYmiDiGR+qltlfvPHSIwAVYqiACL0mTQCtk5skfOBSbxylh60nI/mVYTWqHRCK6eE4Ei8/6Q/hrH4Wr+vtu81F/JYL6h41F+mADkluWr0aT99RMqS9EGR0/S4R0I0+m6xe7Xe8X+iwTi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:23:13.9375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df51f4a3-eb77-4a09-8265-08de65b52c4f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5184

Hi Miquel,

On 05/02/26 23:05, Miquel Raynal wrote:
> Hi Santhosh,
> 
> On 13/01/2026 at 19:46:08 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> SPI controllers may need tuning for reliable high-speed operation.
>> Without it, controllers use conservative timing that limits performance.
>>
>> Call spi_mem_execute_tuning() during probe to optimize timing for
>> the device's read and write operations. Failures are non-fatal as
>> controllers fall back to default timing.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 0346916b032b..2a45d1047736 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1658,6 +1658,7 @@ static int spinand_probe(struct spi_mem *mem)
>>   {
>>   	struct spinand_device *spinand;
>>   	struct mtd_info *mtd;
>> +	struct spi_mem_op read_op, write_op;
>>   	int ret;
>>   
>>   	spinand = devm_kzalloc(&mem->spi->dev, sizeof(*spinand),
>> @@ -1676,6 +1677,19 @@ static int spinand_probe(struct spi_mem *mem)
>>   	if (ret)
>>   		return ret;
>>   
>> +	read_op = *spinand->op_templates.read_cache;
>> +	write_op = *spinand->op_templates.write_cache;
> 
> These will become:
> 
>   +	read_op = *spinand->op_templates->read_cache;
>   +	write_op = *spinand->op_templates->write_cache;
> 
> after rebasing on nand/next or next -rc1.

Noted!

> 
>> +
>> +	ret = spi_mem_execute_tuning(mem, &read_op, &write_op);
>> +	if (ret && ret != -EOPNOTSUPP) {
>> +		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
>> +			 ret);
>> +		/*
>> +		 * Tuning failure is non-fatal; the controller falls back to
>> +		 * default timing, reducing speed but ensuring operation.
>> +		 */
>> +	}
> 
> Can we move the comment before spi_mem_execute_timing()? Then no more
> brackets needed and it will be easier to read (imo).

Yeah, I agree on the readability concern - will move them in v3.

Thanks,
Santhosh.

> 
> LGTM otherwise.
> 
> Thanks,
> Miquèl

