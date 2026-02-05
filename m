Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8C2F6573;
	Thu,  5 Feb 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313621; cv=fail; b=PZCFA1GPQtxvREsxPbe1qwayGr3tEvaQgNC+BOZRyvf6+mUSWyclcJppn3OEi6JjUKUqgifc4hp+EmAGt4+DHjm3JieGmCT3CpXQe+1bbDDS+K/W7HPxiXcXThCDqGSqfsS5uDaeglGvSzHB7dtLE5l5uZwKLV1OBuBKnAdRjoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313621; c=relaxed/simple;
	bh=mVbrgFs78Ipuas5V6e3nCnXacCwUyRxUMOY9EFr6yFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dXovGgpzAU8DK06nua2xR7Xyvxi94b3tF2ZemM91WjhY2j+Yi/NpcP8fxh8MLxE6+5VZrjN/7S/o5Ck3iIm+Y0A06XWknAr35CuPMrXUspNvf8tvhwWU4XjYwhkr5NQmyX6QcDV6jZEg/ILInXWx3sH2MpV4CwpjvVBvzwEcEi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OMzGeJTy; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OMzGeJTy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDfj+w6koYkjoE2fgSJNRLHioQhhFJu+NL0r0SNSLG+47qX0gho1HhMYH6+9ExQ7QnFcz8gEoTkaOv/n0hDbCLBMU/YrpVWAQw27ABCTpHizKScmANK4PfAiHlNux9UJo5NcqlgqgRWz4X2Zc4b0yqEfoWAGCyiqSThCDzrH9P8umPx4sEX6f2F5s/1EvshLxtLm4t7jBi0ysd7gInRyra2L9yfqfNcQrv005MURn9ggdElmCGpg4IBbR+vvT2NRRn2VY0lckVJh8FL/XrrwPbiLOowZT2+NIWBShxJLFsndWqJLM7lbQgDO0ZQb6s2No+Kj/QG/d5AkAz8LVA8AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4o1jb8q+Yvyj++OA/g+12T/+nLS+yCuij9qLuGhzF0=;
 b=BCewuUI9imM5Azofk1Xl/IPqstYZlZD+z2ifFlfZ7lDgE39KzczMKoNdjlH1fAAgyRwAriWBNZKP4wXbrfWc9vAc5Dt3gTT2MjhYjbuJpCH7cfToNRruLATpLD+k4PSQk+CkAQJliwmlHwlX69V8tKuMpr1aBjNynfX5nm5Gj2wTSdhuB7/W/H7MqZjCI8KlCqpqrY6WlbCRz+Fm4oeLZVcF9J2jgJvKzg5RHQJpPU1xD5lF+HjTOfMLLFS+za9zG9cF9W+LqMC2GHxJelwQYPPO4tviqsnwjAJLkusaC282Hm7e+K656AH99pj9lNlS6AVImoQHwfVsjvSA2mZIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4o1jb8q+Yvyj++OA/g+12T/+nLS+yCuij9qLuGhzF0=;
 b=OMzGeJTyy5lEe9kIRcjIFBBIfKYlh2NZNx3kqyrCKNi2zhNd9SEBWmbiR+uGqyp/BnEUVg9F//11RYJXxMmUeOPc+YLp7UYf7d9abCmufBSBwFYIi/JQbV0k0LAuMTmeb9VEjW2RRQmuhWj6IvjPCBNser/if5D+OusuVR2Qelw=
Received: from SA9PR13CA0120.namprd13.prod.outlook.com (2603:10b6:806:24::35)
 by BL3PR10MB6091.namprd10.prod.outlook.com (2603:10b6:208:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 17:46:58 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::99) by SA9PR13CA0120.outlook.office365.com
 (2603:10b6:806:24::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 17:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 17:46:56 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 11:46:53 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 11:46:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 11:46:52 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615HklpB3832201;
	Thu, 5 Feb 2026 11:46:48 -0600
Message-ID: <ba78303e-36aa-4f40-9416-c22ff12b7458@ti.com>
Date: Thu, 5 Feb 2026 23:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/12] spi: dt-bindings: add spi-has-dqs property
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-2-s-k6@ti.com> <87wm0sg50q.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87wm0sg50q.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|BL3PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 615a2bbb-70e6-4271-9325-08de64de8e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amoxTFd2enJvOWVWUEhQcjJhVVZ4eTliVGx6Z0k2Wk1adlZFMnJKbG5nZGxs?=
 =?utf-8?B?dUtjNGF0REl4Zi9KSS9WQjRtZW54NWhZaGFubkh4UXR1ZnVyanVDSlE0R0NB?=
 =?utf-8?B?bFNqai9LcVNUM0pwSXYzaVRaUmRqdnFSR29nV3ZGYzk4NElwRlNJK0ZlbVJs?=
 =?utf-8?B?SGRUcGNmeHhqZTY3azNXZXUrYlhzMzdoRmNScW5ZSGhEdUcrd0ovdktOMVVz?=
 =?utf-8?B?c2d1SjBZTTZaRTVackF6Z29RaDZIL3FlQjA1ZG5NaWdFQ3RlaStkTGVhZEYx?=
 =?utf-8?B?RVhVdGRmTnpyOGRNUjRxNC9WRlcrSVdKMk5NYzl0aWIvcDNaKysxRW5hbktK?=
 =?utf-8?B?azkwMloweVlXWFhFMGk0YXhiQmFtRmlnbkwyWG4vMjhLaFh2cVM0elQ1bldU?=
 =?utf-8?B?dG9hZDBwbTFLVnltVG1vREFNb0RPbTNTSTYzblcrYTlzYjBRL3lMZjFrSVRC?=
 =?utf-8?B?bVVqQzBsSG5NU2FxM25ycXcxT2xzZWZUU0JjSUgvdnRINHh5NzByYkdsdDdk?=
 =?utf-8?B?ZGZlcjhEblFtMThQR1k3WkJJOW4xMkdyV3ZTTW9qQmhwL1hZNDNVcGp0ZXdZ?=
 =?utf-8?B?VFVyT2FsaWMwUWptTHhhdFNOa0F3emhFaXlvTnN6aFRlUE1tNnEybk1aMmhi?=
 =?utf-8?B?dU5iMW1wOFIvRHdyRU5ob0wzV2tWM1o1ZmhKYW95T2dMNG5kMXRFM0Y1cVB2?=
 =?utf-8?B?ejJEREpVdTJlQVdVaUx3M2JhaUI5cllTa09leTBKTHFBSFh2Q09uSnBEbUZQ?=
 =?utf-8?B?Z3NuNFpiODZsbEpuZzVETVlGQXdBd3pxZWdDQkZyS2VibEF0eXVUeDg1NVVD?=
 =?utf-8?B?dHB3UGh0b3VRa0FjVkdidDdsYTZrTE1UNGpVeTdxalk3a1dZdGtpN3dhNVZM?=
 =?utf-8?B?QnV1T2NlUFNyYm1UUnBrRWxmRk5MbWZMbWNnYVM3eTBJLzU4U2R3M1dud3JY?=
 =?utf-8?B?QlQwdkhHanNyUk16MlZXNzNJcFh0QUo0ZDZuTHgzaElSdkVqNHlBTXFHL0Z6?=
 =?utf-8?B?di82Z1BiaEozRU5DazV5YjhBVjczT3FIOXRGajhaZ3pteDhobXFzNm1EdUdB?=
 =?utf-8?B?TGlSbTlnNFdjL1RhNCsvblg3ck9odm1Vb3d5QlZ2Rlc0K3N1cWNocTZ5bFlI?=
 =?utf-8?B?T0w2Y1BZUW1mWnA2NUVMR1Uwa1NjZ0xTYm5ncHFwNmhqUGFXa3hVemRtVjk2?=
 =?utf-8?B?bDUvUlNnU3lqSmFvTStjWFU1S1gzVFQzS2M4OEdhdncvVzJZZ2htdEJwYita?=
 =?utf-8?B?UnRvZEFGS1UzQytBSzE4K2poNHhKRm5rdU80cjRqV2xOZmRoZGp6U1FaQW5R?=
 =?utf-8?B?TlNCS1o3TmpQbzdGSUdaVUx4NlZCeGRXUmhESmVCbVRSeWNvUjV0aitISWRN?=
 =?utf-8?B?SFpQQkJ2dkhRV1NnVWY4cWZKWUY5WHFnY0xSRzd4eGIzVG1mbnZYbnJYRmZW?=
 =?utf-8?B?UTUvaHd3QmhjM29FMXgrNC9kQ0lpUE0wVE1hV3RnSzNtV3NUL3VKajlZMnlE?=
 =?utf-8?B?QmFUaFRKQUQxaWZXbVJnRjd1QnpRWFp3MjRJWXBsdTQ4MHJzUW9TeGVtV2FH?=
 =?utf-8?B?dzdSNVJDR1ZrcTJEQmZmcWlUY3VGREU3aHFFTUY5OU5vajcwZDRHaEgxUEhG?=
 =?utf-8?B?cEw4dmMwSWxWbFNWR0MvcC9PMGlnM0E1NzFEc1FCOHpodEUwZWU1MW5Tc01L?=
 =?utf-8?B?dEJwSkEwQjl2NHVmT3JjeU1odE82WnN0b0Rlc0ZmTzlYQlluU3dwTGRUOUNI?=
 =?utf-8?B?eVBGaEdPTVRwbUIxM1lZSm1MSU42ZStoVTdQeUZ0MC9lQmlBWjM2ZEZoRHRx?=
 =?utf-8?B?Nys3dUU4N0thRlg5MUV2d1VPTzVQczYvK05ZTkFLS2FIUzg5QTdhM09UcGVC?=
 =?utf-8?B?VU4rdHRLdFlWb2NwK28xdTczMkFMaThGTmR5TlNGRE1RR0F4Y1gyK0FOa3ha?=
 =?utf-8?B?WUpnZzMzOHJReXFkMitFaW83dUpIS0VsOXpqTkdia3JTRUx2YUdnNEV3eTRE?=
 =?utf-8?B?cUhDVkliOXdvRS9rRDZlSjhBaU5jVTBReVd0SkhqTXVFMDJBWXFwMXJkL0Q0?=
 =?utf-8?B?ekxIN21zRTVmMS9Ha09GMGFwMG5OOHJVWjBya3JsMTlibGErOUI0azUrOFlz?=
 =?utf-8?B?ODM3YU9GeWd5N1A5YWJLSzZZYVNwVDB0emlZNUhkTWFwRDdhUWRJVEN0YmZI?=
 =?utf-8?B?VWlnaXNWbHpHWkVtR1U0UmxXOWZ5c3NDbWRneksyZjAzUTR4RkhhN3FZUE1q?=
 =?utf-8?B?QTNaemh5Ty9uWUhxSFlEQkxkRkRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eRV6ajFUZByQC2y3sBKzMG7VVTNmh4DF8yAaa6lflRAM8hzEc9Doors2NuEDNT5DvWcem5TQ2J8Gu7MkHSn7X299dQa1i3RAZNQo5iDyZ6Y/FB/11AJTA4NhdY9zPeg0D18VFrIsCiUwpk3rivSX9WA8uR7494jGDRUtsw+XYP1UUKV5xtSRZUghuGz+WFztrrba0rQOVppGrqjk7L3QkmDyWF7mhZEmWLRz74m47r5Xe+nXizsVDNge11BaLu/R+v8xm0wr95KRh//+3tL3QIFRCZYfb/7Tmc7kEIBaztUIPVaYlz3XHAqyhhKDEsEuo0oOwltyRTQGelwVLj10d6u+XMASyZzSEZ+riFmxGj20id8KIhkMqxxflIa2i4SejK/t9z5yFtbs31r4q7WMJF7eI7oYBy0/1IS1JbNLQxlImZ4s8nBKtu9TRKj/8RB4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:46:56.8343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615a2bbb-70e6-4271-9325-08de64de8e7a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091

Hello Miquel,

On 04/02/26 16:16, Miquel Raynal wrote:
> On 13/01/2026 at 19:46:06 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Add the optional 'spi-has-dqs' boolean property for SPI flash device
>> subnodes. This property indicates the flash device supports DQS (Data
>> Strobe) mode, which provides improved timing margins for data capture
>> in high-speed SPI operations.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> index 8b6e8fc009db..c6f330fd32aa 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>> @@ -89,6 +89,12 @@ properties:
>>       description:
>>         Delay, in microseconds, after a write transfer.
>>   
>> +  spi-has-dqs:
>> +    description:
>> +      Indicates the SPI flash device supports DQS (Data Strobe) mode for
>> +      improved data capture timing.
>> +    $ref: /schemas/types.yaml#/definitions/flag
> 
> This information is currently lacking indeed, mostly because nobody ever
> cared about it. The DT property is IMO not the correct way to give this
> information for two reasons:
> - this is a capability of the chip, we discover the chip dynamically in
>    both cases (NAND and NOR) and attach many capabilities to the chips
>    already, so I believe this information should be provided through a
>    flag.
> - the fact that the DQS signal might be supported does not indicate it
>    is actually driven. Winbond chips, for instance, can either enable it
>    or not depending on their configuration (probably through their VCR
>    register, I need to check again).

I agree. The flash device's capability to provide DQS - whether in SDR,
DDR or both modes - can be represented as a flag in the flash
description. We can list out the possible combinations and use them to
clearly describe the flash's supported capabilities.

However, whether the DQS signal is actually connected to the controller
is a non-discoverable hardware detail and should be described only via
Device Tree. The DT property is not meant to describe the flash's
capabilities, but to indicate whether DQS is physically connected to the
controller.

> 
> The question I have is: shall we enable the DQS pin automatically if it
> is available? Not all controllers support it I suppose, and wiring the
> line might as well not be done (or incorrectly). For these cases we may
> need DT properties in the future. But for the DQS presence indication, I
> bet it is not useful, and should be handled at the core level (not
> parsed by the driver like you do) because it may have an impact on the
> chip internal configuration.

We can handle this in either way: keep DQS disabled by default and
enable it using a "has-dqs" property, or enable it by default and
disable it explicitly using a "no-dqs" property.

Thanks,
Santhosh.

> 
> I will try to come up with a proposal soon!
> 
> Cheers,
> Miquèl

