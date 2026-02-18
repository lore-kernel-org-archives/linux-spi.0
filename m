Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FC30C36D;
	Wed, 18 Feb 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438093; cv=fail; b=QLQ2sopuSgvg3JfuVZMYcVC+HsVYSNlgjMuUvF3TGcMSvynFdDJil2yaw76QzNyDlrUDQize1OVdpZs3xjkmUwFgs8K+k8MBS8UQm9ohjQ+wm7vCITE/8pDXf2ku9WmIWs9FudM9A1frBdeyCnb6ATBJCNcM0a5IUG5P/ORCV6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438093; c=relaxed/simple;
	bh=Nzx0XfOxlyS6Q066u5txz73ViKOB4f5Oo3rUfUkf8vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wm9olcgn8Nus4nnymqqeJ3PUPNP2SUN1rnBaHyoEV1das6jwsdgYX5YuktzLTYo/wfLjEYXwe9sEQZHAZIkCrDrT0awxrxmJ7YT81U5qv8oU058NXGNojLWgFylvKg+74Ew/hLi9hqLShOUQHaAeqD9NDMW4MZuzQ9OGC34Akkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zad6IcdW; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zad6IcdW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtyDguzpRkJiv3+mHa3dtEvYnOlBhezCHxWewDJGo9IaHuOyxHDYAF6sOvCaRMRZs55ockw0fVKjOi3C/jOcwYwdiG/j17Fw7m4MvnBWgUeAqirlb4IRFIo1PdAmOJ0QX+XPbvbQhW6BRVWwh1RlNP1yTxGqvnd8/2uMVdr+NhV3pY/Y9ABzfPYtMttBS4WQ0NjXkbN30T0kA6Oa+ykJMR0kt8F+gxghCWmanPrUfhqW3+dCZm1OeXw8g/pivx2Y5hFpEplGCcrPHASsLvLLFUgFKU8wXtLNZDCtJ5XEHtIYeWY4JMgsLiQS/C42gzBQvZaf3y1L5G6YeFugsM32Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dcZOWHMS7YyPOkSRSy99DcEZShodwpSoG9gulsI58g=;
 b=RRCyrD3b6rD1CGHWRfv6yt1ubYb6CfzPBw0XcFfNyIww23DQp/Yh4RzN4Oux2PKQU7GVE5Xka35CxP6iN2Ts4lGFu9EHW9pcEJb2gPQuqsX5SkTKIypD5Ulb3CgVLEjKVzDDhhJTbR8fbLrJ7wUqWVxlRe6eKdZ6v+tVvmo4U0EYTevxk35bZTdQI8SJDlIzZSg1q2gOZvJu8wKRLD3ibQNEQDa30/zBG2jd2YYJBmxU/lrr9puTl93pATYbs7ezsueATeILyfO1iTAi24C7A8SAOJhjbQWdK3rpBM3O1zTlZeFQxSz2lXLwP55fgaoojfy9XS1pKhR1eCZfL+MB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dcZOWHMS7YyPOkSRSy99DcEZShodwpSoG9gulsI58g=;
 b=Zad6IcdW5ndUTdPJ+wufgDXAn9mROZKPMFbsJ8mHcsXfTv7CxNTo54RaD0G0GhhG+GGKMqA9LVj8JBvZ+AQaeCt4dbKEx+mgb/80dndobfI3R/AeL3DdBAnuoW1yCH13sAdNBIMWzNMB1Muk7LUmYA1UOFftMWwb4X1t+PZPwHM=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 18:08:06 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::b0) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 18:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 18:08:05 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:08:05 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:08:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 12:08:05 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61II7xgS802418;
	Wed, 18 Feb 2026 12:08:00 -0600
Message-ID: <fcdeadca-5bd4-4b03-8076-34d6cad940cc@ti.com>
Date: Wed, 18 Feb 2026 23:37:59 +0530
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
 <012a44f3-973f-4f34-be69-286cf924a6c6@ti.com> <87a4xdxdht.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87a4xdxdht.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|CY8PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: feed5c0b-d9b4-41f9-a0d3-08de6f18aa53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmkxTEk0clhndUpMZlp5cGg1QW84cmZGQk8zcE1JLzZJQmFQNzRGUmJTTnNs?=
 =?utf-8?B?QlJ0ZWx2MmhVME4wS0RXY1Fjc0VZVDcyTFdJSExUNllua0g4UVJWNzBsODJl?=
 =?utf-8?B?OUxSSVNlMHZ3bVJEVFZ4S0ZNSVg2dzcwRVNKOS96SWNqZEdCTUpMTXgxVDB0?=
 =?utf-8?B?azZTUGF5RThYdEk4WkYySlVZQjdMSDFBTFlMais4enFFeE1PMGtMUGpFNWRF?=
 =?utf-8?B?SWt6Wm5JdkhRK3hwRk9oU2tTUFhZdjRsM1UreTlaeGJNazd2N0xVY0xUYjZ0?=
 =?utf-8?B?M1ZRZ0pLZVZaTG1IckJTVkp4ZVlCbnZQTkl4RzRzcGxSdXdWNWpWeDh4UjBM?=
 =?utf-8?B?c1YzUkJxNlRYRVhuUk5QMTVZZ2tZWVVkbGF6YUhWa2w5dk94eVcvdEkxMklD?=
 =?utf-8?B?MkRlc2FCMnEvaVVlRG1jZGRnbEs5cWp5Y2QzY3JLSE85QzJ0RjB1M1NVN0k5?=
 =?utf-8?B?MGt2V0xsT3MybEN1QjczSUJGcFFhRFZGQ09jSHFGblVuV3doemY5T293Tjgz?=
 =?utf-8?B?d1lLQ2V2U0RvbGtTVkpmbVJWd2dTZE9USUZDQ3BZL0RwNU9OUnpoZjcxRDNw?=
 =?utf-8?B?UHJnQ2hXSCtFbTNOZ1RMMkpDalV2bUNpYlBYS1E0Q3g0M1FZMkh3SEZZb29i?=
 =?utf-8?B?U2ZadWJlYzdzSUV2eGd4ejNKOW1IcXQzUE9QWlVnaWFWWnJQSnI5VEhhdnpx?=
 =?utf-8?B?L1pQRHFSQm11Y3dCQmtwSnNrNDhRRGI0YjVFOEk1cmlqSHhsUUpPREJrZmN0?=
 =?utf-8?B?OHIwOGdOdU9QNW1YWEpxL3pjaFpON3dtSmM1ZGZ4R21sbEZyWGhCcFYyWC9j?=
 =?utf-8?B?VlJDYXlOeTVDdlRZMUMvaDFKSkhnMWJGbTFFTnMxWkRaT3djdjYwNEFlK3Fo?=
 =?utf-8?B?NStycDV4bmZLbGtRNS9XdEpCM2lQaTJWbTNORllOeFRNcG1HS2pRVVRLNElO?=
 =?utf-8?B?cDZ2UmJSdU9reGVNT1IzZkNSdmdyUnlCbmF6YXdSbldXMkVGTHdJQXRib2lR?=
 =?utf-8?B?SmpxMDkvWmQ1QXVROW1HcTR1aWhPd0FzLzFINnh4MklYalhPMlZDMm9WOXdp?=
 =?utf-8?B?N3JPN0o3eTlBS2tra0d0akRFRVZ4YmxHaytkZEllVitlNlhOY1NyK3Z3VXN5?=
 =?utf-8?B?aWYvZWlJNzdzem5IR0lQQlRTU1pSNXpLK2F4UWdWdkJBdVFlQndlUXA0QUdU?=
 =?utf-8?B?NXFMbnIvOUdvZGRNTmZXc2IvaytJTVpTQWtvOWZLL2YyUGtRZ3pkSkF6K1Ba?=
 =?utf-8?B?dWRVNGFsN2htdnl4Zkk5aWE0SXRUR2hrNlBNck9lTUp1SkZ4OTFmV1pIM0Z4?=
 =?utf-8?B?TnV0WTJkQ1F4WEFyU3BhZ0RKQ21abGUyQ010dkRNQXF6eGxsbGFHUG5WK1Nz?=
 =?utf-8?B?MmtQL3pxV1lyb09jOTNndmE4Zkltb0ZWTnVTeEpSdTM5b2s3QjBIWWJCUVQ1?=
 =?utf-8?B?YVVqTUlLY1RiSHVQK3pzT1J4OHVTdmZDd3RwcEI1QjMzM2F2SjQzUzNXUU1T?=
 =?utf-8?B?M05wVjczbE9nbmpvMEkvNkdsTlVtS21iSEl1MStqTTBDa2paek1qckxIellz?=
 =?utf-8?B?SktLbHJPUWRDdTB1R2JacjZFMXorc1V5cS9LamFydXEzSzErNHA0MU0rSE5X?=
 =?utf-8?B?alBuODl6K0toelRsSGdiWE1ROU96cWFEWVRCQlk4MzBUbmNTWTVtTjZaTE01?=
 =?utf-8?B?S1pnZGtOMVdKWFpkS2ZGQUFHQ1FsU2k2a0xUQ0JiMGkwQU94VzBZMWNxSFBY?=
 =?utf-8?B?WWNTUWVHK3JlR3dDK2tRbk5vUFlRK1ZxZXBoNG9vSWlQbTBIdEkrZmdMYjZm?=
 =?utf-8?B?aEc0YWNENkRWdCtOeUYycHExNnZSUDN2bHIvamVwZzJudnorZGJJWmhFUXlT?=
 =?utf-8?B?djR3Q0xUb1B6dHNkUG1nS09wZEhzeHExTXZCTG80THFud0x5Qk9XQXQ0cEZQ?=
 =?utf-8?B?ZkYrbmNwMEExZFZoVlNpMC9IYml2dyt6Y0pmVEM2aWRpNE1SMk92aE1pbnhG?=
 =?utf-8?B?SW5mNzY1QlBqLzZxL1FLQmhQdGJwaHBpSVlFV1JwKzRFMG93RGZTU3pYVWpn?=
 =?utf-8?B?SCtWNU9tOEVLUEUzTTBTR1NUeGFrdjR6VVBMeGI1MVJhNHVUM0hnY0xlTEtR?=
 =?utf-8?B?UUZ4amR1aGJ3c1NBYlYzN3QrT0g4NTl2WXIvTzMybFg1eitTbWRqSkdyb0px?=
 =?utf-8?B?aWNLZms0bWZxeEZGSjFPaWlJUHlCM010MHgvd2lXeDFVYVplKzF6UXNEZGxi?=
 =?utf-8?B?V2piQWVNUDdJL1VFcC8vck0rSUpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MyaPTViZISQaMwOu+clrlcedqQewv7tEYNPo7RZDuVcZGO+/QdnQx11y7rhkyWJMH+bHVT0Wd1iiFdTZTHX3IAtqnHF6PhIyOVl+9B2EYiWWpvv/cZPy7Dz+TVP+4Y7i2gNiM2ekqMzixM/NgwJhD73BpuxEYymJFHAXAEsQTvGzpUbr7d0Xr7Z+cpy5HQ5Dfh38dteiJHf9gFf0qoIqal14nV/P+58ZlT0emsWBtM8h7wSAuAfSgX2m3NWuBEQhrhQ9TOFH0mhgCALpCjGNDU3n1J0wZmd71c4C6tmOOT0zBRhRwZVuWrw6p5fpIowhP7iyNgAE2+oZXaY0pz05WMQ62l6+gn4udxqK3V7YXxDfQdL0GJ/Caq1iDhWVn28gRXOzZbWc+yrUmZSUM3NAguuVwQ0/QzItwctMmAHAF2bSArx3CzHusxant4VHCNH3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:08:05.9424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feed5c0b-d9b4-41f9-a0d3-08de6f18aa53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218

Hello Miquel,

On 13/02/26 13:48, Miquel Raynal wrote:
> On 07/02/2026 at 00:55:49 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> On 05/02/26 23:09, Miquel Raynal wrote:
>>> On 13/01/2026 at 19:46:14 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>>
>>>> Implement the spi_controller_mem_ops execute_tuning callback to enable
>>>> PHY tuning support for the Cadence controller. PHY tuning optimizes data
>>>> capture timing at high frequencies by calibrating the read data capture
>>>> delay through the controller's PHY interface.
>>>>
>>>> Tuning algorithm functions (cqspi_phy_tuning_ddr/sdr and
>>>> cqspi_phy_pre/post_config) are placeholders to be implemented
>>>> in subsequent commits.
>>>>
>>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>>> ---
>>>>    drivers/spi/spi-cadence-quadspi.c | 241 ++++++++++++++++++++++++++++++
>>>>    1 file changed, 241 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>>>> index 0df286d24256..b8b0e85f4f68 100644
>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>> @@ -32,6 +32,7 @@
>>>>      #define CQSPI_NAME			"cadence-qspi"
>>>>    #define CQSPI_MAX_CHIPSELECT		4
>>>> +#define CQSPI_AM654_NON_PHY_CLK_RATE	25000000
>>>>      static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
>>>>    @@ -65,6 +66,7 @@ struct cqspi_st;
>>>>    struct cqspi_flash_pdata {
>>>>    	struct cqspi_st	*cqspi;
>>>>    	u32		clk_rate;
>>>> +	u32		non_phy_clk_rate;
>>> This is the second (and last) main issue I have with the series as it
>>> is
>>> right now. We cannot set this type of frequency in the driver IMO, it is
>>> too board specific.
>>> We currently have a DT property for the SPI maximum supported
>>> frequency. I believe this is no longer enough. Why not making this
>>> frequency property an array? First frequency would be the default,
>>> non tuned maximum frequency. The second would be the maximum frequency
>>> reachable when tuning the PHY.
>>
>> If the concern is only about where this is set, we could introduce a DT
>> property such as "non-phy-max-freq" to carry this information. This
>> would allow us to avoid any changes to the existing "spi-max-frequency"
>> handling. Let me know your thoughts on this.
> 
> Naming is difficult, non-phy-max-freq is too TI specific. I was
> proposing the evolution of spi-max-frequency because it is backward
> compatible. The naming can be discussed after you send a proposal, but
> do not include "non-phy" in it. It shall reflect the fact that with fine
> tuning we can reach higher frequencies on certain operations.

I tried your suggestion of keeping an array of frequencies in
spi-max-frequency:

spi-max-frequency = <25000000 166000000>;
                   (non_phy_freq phy_freq)

and updating max_speed_hz with phy_freq once tuning succeeds.

Bad news! this doesn't seem to work as we expected. The
read_op->max_freq for both NOR and NAND is initially set to
non_phy_freq, and it does not appear to be updated again by
adjust_op_freq() after tuning completes as the if case fails.

Regards,
Santhosh.

> 
> Mark, any take on this?
> 
>> I'll also test the approach you suggested and share my inputs based on
>> the results. By the way, where are you insisting to adjust/switch to
>> the maximum frequency - within the controller driver or in the
>> spi-core?
> 
> It is preferable to make the decisions in the core and avoid being smart
> in controller drivers, if possible.
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

