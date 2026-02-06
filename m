Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2B23BF9F;
	Fri,  6 Feb 2026 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405962; cv=fail; b=J2+SDhJQ+vn4feA/LHH11nbL/lyqnC58Wn5Y9JliuplB5HhuZXLHjwyP124IOnGyzzqWtTJf2TMQXtslP0JM9wbZ4MZW50aMSZgYmJEO1cgfmAYNPs3UJ9Bxi5r4b+25jzgq7rmWDo9+VGX8+Hg2aZM86gcRYnNES62KN6fVy9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405962; c=relaxed/simple;
	bh=IztbdW/sg9+slYq+i4gPSvF181vNw+LM6+3Zlz49wsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cjM8QKe01+x+b+3oR8wl/K7fe2HrFxo5EmrJ5ZXrETlFCcq/xHrcwgoZhQnUsJU9LVXqT58a69Ipf69G0SAIwjTtm55qFZrHQyfS17ji07Y6Jd+A0bdYcTK4zPEcVHYI2zYLN32tehTTuEjMjLfXuwwXDgsemxrJ3MXRWNbRxdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G2utgd1b; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G2utgd1b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj5KyNCbJXLzGeTi6WRkM0J5HOLVtR/UsJI6+5FdZVqTjeu9VPVLuyEbmj5ZNF0tBXcbQua4KDju3B4QAhUhx+auGeQpDYvWpg/f8qZ8OBmgdfz8zJl2fI7/8v7QvTRcPE9ABTbXJzbzcolhDd9UV8M8goPV9eksM3pomxMxe8Zi25KdA8wpbT00vyyKpbmJrDQTw4gGZ7rk5RJziWu3KfdT7eSuPtCQb8oXwoh3et0M9p3oZlbx+DPFymJDcqGEVVushDS1c79IF59VGmadqmjKjjryt8yRAgYSJgJBILSWl03xRhRrLl5pEK05cyEib23ps7vw9+UWom+M+tFCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuwvJA7bdlfxJyiF30BM9B52vMs4ZBX1zMrBZo7Iyu0=;
 b=plg2+uwtQ5+/ZRoec7A3eVCDruIr5xb40bdWnxqQHgvGWlMdSiwqM05GZs31eeh56hm4OyYzOH4zgZ4mMrij5x/2S9zhYDEliQIfIMBToULNZjHCbieVYBaikMimP1HuMs6OYB5zExRXyumt0GBOGN2xs1ANUP9X6ymJcMmstn0lYz3Xr/lfj1wjwZ6pxCxZbM4UGCQ6nTjdUilDYikuhjQzVFQPo7oLfgOrTp1gNxdmgIBV+x6IzaPMNeDr4aCVjHo+X2bWTT3i/K+sS4766sbHqSjlH+4C8mtmG8ZbwBYb3USKItoYlPLH6jbZZjlP6ny6a0XDtcKoh8aUHu6PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuwvJA7bdlfxJyiF30BM9B52vMs4ZBX1zMrBZo7Iyu0=;
 b=G2utgd1bZ+wCdEfRSMKtZUvjWd9vMklbwwwnLiiDtftHJ5I1sF9X1Txw/zGb4rA936Tn6olaB3vI8FZ0olmoZuaAdXoVdtoIMilBRrKtHFtElkKqjzd/PKkVzGnGqGZ75BswJc0gJl8ZHcMt6NWKCBmj+/BY+J4bv5qZolpxcaM=
Received: from SA9PR10CA0006.namprd10.prod.outlook.com (2603:10b6:806:a7::11)
 by CH0PR10MB4842.namprd10.prod.outlook.com (2603:10b6:610:df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:25:57 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::62) by SA9PR10CA0006.outlook.office365.com
 (2603:10b6:806:a7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri, 6
 Feb 2026 19:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 19:25:55 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:25:55 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:25:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 13:25:54 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616JPnKH1408853;
	Fri, 6 Feb 2026 13:25:50 -0600
Message-ID: <012a44f3-973f-4f34-be69-286cf924a6c6@ti.com>
Date: Sat, 7 Feb 2026 00:55:49 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-10-s-k6@ti.com> <87bji3gkda.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87bji3gkda.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH0PR10MB4842:EE_
X-MS-Office365-Filtering-Correlation-Id: eb98ce34-fbdb-4302-80b6-08de65b58c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTJhaHpyOWVaZTJ2NGxucE1CNEpiUjMwZmxjTU9UY2FhMEZCUGFGMTVNU3o0?=
 =?utf-8?B?U01qNE44S0dxWlp5aEQ2Z2czYVdud2ZERmtKalZqZHJNcXdYT0tEQzVrK05F?=
 =?utf-8?B?dXA0MVdGZWtROFEzdzhrbmp3RWZKei9QQ0ZkRlh2VFg4eGdZY3ZPejVhSGxt?=
 =?utf-8?B?eTZJRXJHSndraHErRE5nUWU5T1RZZUdtNTlmZE9GeXZtaHAxcnY0aHZNR3Bp?=
 =?utf-8?B?aWtMVGJuS1plSG1TSWh5SkVNQWdmTGtHdDdadUpYNmk3bWRkWXpLZ3FvMEdB?=
 =?utf-8?B?Y3hCUXh0eVNwY2JtdFVsak1xZ0JqZFdncDRxTnNnR3JDVGlpeDZ0eGJPbXFr?=
 =?utf-8?B?Y3J3dEd2VkMrMFFUb3FLWFkwMHJWdVFMQWxNaWROUEU2U0RTNjZKalNsKzgx?=
 =?utf-8?B?ckl1S2hvZ3NkdEkwR253aFFlWnBVMmsvSVBxbzkxWVVvdkFjdzVrbWtQSEVE?=
 =?utf-8?B?S1FJQUk1VG1xOCtGSFVhaWUvdVpjd1V6dUhuMWYvZ0h0bVp0NTlhTHZycW5l?=
 =?utf-8?B?clFwVWJpejBGSUM2YU1QQU43WEliaWxLSm0zR2MrWjhlYjdsOFpyWWo1Q1Vl?=
 =?utf-8?B?K29HVE5ESWp6T2JOd2wvMUlQS1FUeTBtRDVwODY3U3RhajRNSFlvRkpicFF4?=
 =?utf-8?B?bGF3VFpCc1UydHdwelVWQ2V5bmhCWUpxM2ZZM2RqSkl3SzczTEVkMFZEdG8w?=
 =?utf-8?B?ZXNsSWhHbWhXdTZaL0F5LzRjZjMyUEJtVkNkMERJUGVkb0NDN3MyWUNwV3FT?=
 =?utf-8?B?Y0M1N2RzVG5yN3lJdW9wTFVML3Urbkp0NUcxdzZjR2gvRllkSzJCTlkzOGVD?=
 =?utf-8?B?Wm9aaGpKWDlSNFQyaGdGNGk1dURwQ0JxSS8yWE5RaVhta2tYZC9jUGpWRmo4?=
 =?utf-8?B?RGRPM1hoWnozL0hFZTFxb21hSU9kUWlxQktLL2hPaGpCSmxWWFo1QkNsNXlm?=
 =?utf-8?B?S3orSjQ0SGNTZVJabHQzcENIRHZRS0lZc2gvblZGM1JoamtFNnR1Sm1SRVdS?=
 =?utf-8?B?MnZiN0JhRmdiZVBEaGhEK1NXOE1NQlBCa3JPMVFoL0ttOEFIVWtrNFJheWFr?=
 =?utf-8?B?QXVNK1NnZXMrZGU5c2FrSXpDTkRmWDVCb2UrMmtxYkFSNHpUWXl6RW0yNEpw?=
 =?utf-8?B?L1daUW1aWE03bDJCOFRPNmFLR3ovUHpDaXIxTFA2ZmhSNWlWenFGejRISmhW?=
 =?utf-8?B?M2xnc2RFVmlaVHFGcXlNRFJhK0VXcHRvVk9BWkJ0b2JFSzdKN1FlT2tpaHY5?=
 =?utf-8?B?ajd3aytJK0M0SXE1Z3NpOTNrMXdVL2VqKzJXVzBlWEhid2E4dk9HbkVVT01P?=
 =?utf-8?B?Z1A0c0pQVXhvQTBJL1krL0VXa3FWYkV2ZTFCQThabEViZTNGaW1zUWlYb1Bo?=
 =?utf-8?B?U21MalJHbDY2dFZIT2t0bG9Bb2gwWmxESHZzQmU2ZERnSzNBZDBidkdTVzlI?=
 =?utf-8?B?WDZLRWdVeCtnYUdiTmpMUDJuYzkvY3RQRFc1M2QydkZEYi9UQVBoZTlhMDJl?=
 =?utf-8?B?N3hNTVgvNjU4SENTZHlVbysxUTZNOVNxV2Faa2hRUFg1cVdlK1ZjVHYrQjJs?=
 =?utf-8?B?Ti9taVRhSVFjbVFYNS80T1Q1emNlQ1M2TjE5dTFJRm9OOW1KVWRpQVl4b004?=
 =?utf-8?B?SVRaUm13ZnlRb3NJa0xOVmdqWnNtZzREMWdBYnluYkc2MWo0dFZhOFhNeGM4?=
 =?utf-8?B?V3VEV0thNjdRNytGWDJ3bWwyaWVvT08xb2JzYVJkUFRaREZMMHNFalBzSzJI?=
 =?utf-8?B?ZHhuNWRLN1RWaTdIeWt4ZW93UkpnTjZnNk1nNndYV3hJbWlkT1c5ck5Icmsv?=
 =?utf-8?B?Q0tkcEpQMTQzRFJYSWIrT3FCcmtoSmlyTUdoNS9oTXJUdHk0NVovdTZWY3J6?=
 =?utf-8?B?VVp2UEFXWjNMUGl1MENaOHUwZ1g3aU5XVkE4V1NHU3AvWFVsZWNkWW9PNkJx?=
 =?utf-8?B?cVBvUUF1NEovc1hIeGQ0N2ZyVmlyNXluYXVJMEF1dXp1dU05UGxPbjZ1QjFC?=
 =?utf-8?B?TjJZTnc0a21iTUF1WWI3Zkp3aUpoUnJmRkx6Sk9NUUtyampNdHB6bnB3UmdG?=
 =?utf-8?B?UkFYZHh1WjZReklyTVVyUXBmQkZoaytRZnZUY0lBbnphaitWN1BLRzRuL3Q5?=
 =?utf-8?B?dURZblVQSW5TQ0o2c0hZR01FVVpMV3FlRW1DcWxEUm1IWm0vOWIrUDRSaUNo?=
 =?utf-8?B?RXRFMmpQQ3FIaVVIdzhtUXZncTRtYzhUWTV0bSt2ejc4WFR6akcyaHZkS0pD?=
 =?utf-8?B?Z0xjRWpOZDdmUFJ1RkhlR0M0eU53PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	giCB68Z27E+u/nbZ9uYPUzMG2jXmxu+6HWi+OiieGL41RhIKTNAdmlkV4sCUowUXM/LHhRpSlHEAKx0BmbJNYI+nd0lJ8pFX/PWxx/KT41CEVCyE6T9/KHbogVPe8VGIWrMgjl7x4fxPKb219xWW5s5jOHub5nL7l6ASKzHaN0oSUQTgiZv0ZW8Fk1TcbUnCelVw4Z+jS2KKj50nehjjeHvpvxdT6GTylTJTxa+DjQ4xY5jttCjQWr5HoXznuICU20OBisceWq/tvvPLeGbEXf+LQIwrsUTgNcfC12T5ys7ACuUpY8pHJ9bxtGbdj1cuYXvrRHo5gsPImV8kip3noNiJ9+T3k8psnBZ12OKZxnenWqm1bSURFMZh0Uzg9zWgunq0qlNHOIEfL/2fbK3nVoX5VXHzj2+4EtEQkb/mv2hpSysFuF97ffuHmOc4IqUG
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:25:55.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb98ce34-fbdb-4302-80b6-08de65b58c8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4842



On 05/02/26 23:09, Miquel Raynal wrote:
> On 13/01/2026 at 19:46:14 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Implement the spi_controller_mem_ops execute_tuning callback to enable
>> PHY tuning support for the Cadence controller. PHY tuning optimizes data
>> capture timing at high frequencies by calibrating the read data capture
>> delay through the controller's PHY interface.
>>
>> Tuning algorithm functions (cqspi_phy_tuning_ddr/sdr and
>> cqspi_phy_pre/post_config) are placeholders to be implemented
>> in subsequent commits.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 241 ++++++++++++++++++++++++++++++
>>   1 file changed, 241 insertions(+)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 0df286d24256..b8b0e85f4f68 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -32,6 +32,7 @@
>>   
>>   #define CQSPI_NAME			"cadence-qspi"
>>   #define CQSPI_MAX_CHIPSELECT		4
>> +#define CQSPI_AM654_NON_PHY_CLK_RATE	25000000
>>   
>>   static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
>>   
>> @@ -65,6 +66,7 @@ struct cqspi_st;
>>   struct cqspi_flash_pdata {
>>   	struct cqspi_st	*cqspi;
>>   	u32		clk_rate;
>> +	u32		non_phy_clk_rate;
> 
> This is the second (and last) main issue I have with the series as it is
> right now. We cannot set this type of frequency in the driver IMO, it is
> too board specific.
> 
> We currently have a DT property for the SPI maximum supported
> frequency. I believe this is no longer enough. Why not making this
> frequency property an array? First frequency would be the default,
> non tuned maximum frequency. The second would be the maximum frequency
> reachable when tuning the PHY.

If the concern is only about where this is set, we could introduce a DT
property such as "non-phy-max-freq" to carry this information. This
would allow us to avoid any changes to the existing "spi-max-frequency"
handling. Let me know your thoughts on this.

I'll also test the approach you suggested and share my inputs based on
the results. By the way, where are you insisting to adjust/switch to
the maximum frequency - within the controller driver or in the
spi-core?

Regards,
Santhosh.

> 
> The rest of the patch LGTM otherwise, but there is this frequency
> information which I think should be handled with more care.
> 
> Thanks,
> Miquèl

