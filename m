Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361629E114;
	Wed, 18 Feb 2026 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438034; cv=fail; b=U8SU25So4oaTQp6KCbPuGgm5/+C9kL2mHiYUW0OQZNv21QHegNs4xPOPHNeGCFo5HbqRShAX9bRZks+bFavIFI189svmBTmTXRLB4gCXZuQNb80cngXujQtnDEt7tPkwyT2+XUJ0yfoFogB2vDgeMY4IaOTFGvknyd1kyBmU3zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438034; c=relaxed/simple;
	bh=wKk6V7FMebGBICTt6Z+byOJE8rJCZbDPd4hnFSd7RkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZZ9YtuKMSomn3u13vrQbZQL8PH9+xCIpNPtGIjYdAs2aWfeoG0nxY3HQA8aylQpDs9S2QHdNEvo/hkrenPFvqV0SgTAVtl31UDiKRHlO913gAgG8D0d7O7aTPx8DTq4ZS61DxjQkYlhbG1NToCU08rdBsGkta04KuAUWjP+ST3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wTJ2G+dK; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wTJ2G+dK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sT4GHPaxDwlYwztJ65c/6IA8dH9/FoH++ervWlLB4n/GQxGzoWPJRekyTWJStuMoVssDsCsFznTIF3I2cqygFYSG3DxALgmtLP2aCc+dGJBEWxDZZdxQh4Vs49Z5A7xZuj5MO9az8GfsMsgH7tPQPt6P2JAFEWL8nx1YhKXgDYHnmoqjGANdICpp2Ru+IXQmV2Zqt4+JjTwNbUB4bgflY8nGaS/EnD2qmXubB5w+y+0co9scRZ8nn8m7bKvogT5u0vs1ceA7IzXrdbgup8z+1ZWe5wibeuvdZgITSezchidoAjEbOB8MdOmVXWKLh7tpLq1Qk+blAgfacgte8BIN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig7pDl5OzmxegFmaAYzHV5aKpzbH+lcmfS28Rk0m/ok=;
 b=GsqqvWh04G4Ex2mv/MHOmjIYXEnzO/TyPCIBKrhWPleKvrfNiNd5warhmnvbGlbuJ+ohGviElBwxMqCamrBAY7LtZFYj3Z7ys/aZ5qBmtvtjYQn4eMn0ZGEgbGfhLlRKTcMGCzm6D47g6qMQUw7wgWc9gi/zrJ4rY5POe2wblquG788xy++9p+4teIxfBAPT9r4bf1ZC1CXbhPleRwNWB6wIc6QQeEorc72v5lOractOI9LYy4uU1NPMfduZwz0Fws4DFscepjB5KB+r7nn+8xM/GU8iTVQ1qVnkx+YC7KlJaL7uZraGJu7HNQ7hlZMAmpzyepxNtdnWb16J1BVBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig7pDl5OzmxegFmaAYzHV5aKpzbH+lcmfS28Rk0m/ok=;
 b=wTJ2G+dKbsT0Igoz71BEGQHoW2qjcRXwyMhoQ6dzJJ+G9BXlf+Nb+NN2KgEIe9NbX8hWdoGWILiorDcS0GJV+KlK8IsS9DYXL5ZSM/fAGcamLFeZtXvO7fIWXl5pGnlVHam66qqb5s1U/hms/wb00CrwoKc6azg7iIJhGjdVe+w=
Received: from BYAPR06CA0023.namprd06.prod.outlook.com (2603:10b6:a03:d4::36)
 by IA3PR10MB8466.namprd10.prod.outlook.com (2603:10b6:208:57f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 18:07:09 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::43) by BYAPR06CA0023.outlook.office365.com
 (2603:10b6:a03:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 18:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 18:07:07 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:07:07 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 12:07:06 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 12:07:06 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61II71lt1265958;
	Wed, 18 Feb 2026 12:07:01 -0600
Message-ID: <54964ad3-64d7-4f4e-bcf9-f0b92b1df034@ti.com>
Date: Wed, 18 Feb 2026 23:37:00 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning
 infrastructure
To: Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle
	<mwalle@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-10-s-k6@ti.com>
 <DGAC4N62UZQQ.3R7TLX87PECU3@kernel.org> <87qzqqxml7.fsf@bootlin.com>
 <DGCXTWSCAH6R.22SIL82AUVGYI@kernel.org> <87fr76xgsl.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87fr76xgsl.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|IA3PR10MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e29eaa6-7607-4b04-47d9-08de6f188792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnRJNUJ5YXdXckJlOE8rYXhRN3ArckxqUjMwQ0xiY1NTb1pxRnRNWlpCMkJs?=
 =?utf-8?B?YlFScjFTa1pvVU9TaGNQd2VJRU1QdzNmL3FGaTFmU0ZPUERFUDhjZ0UvN21I?=
 =?utf-8?B?aTdkZytuV2NXNmo1V2VTeTBheFRKMlF5Mm5ENVN2dlFTaDIzK05OVFl3UWFE?=
 =?utf-8?B?dTdvUDFqa1FmWXVDaFNwVjd5YXlUdElTbDNVTUZoZ000YVUrY3ZCcDZUV25i?=
 =?utf-8?B?UkR2ZFlXS1p6NnMzS1dwL2t4T0FsRkxucXJTVG9PeHFod1lxTkVwc2w2RVVY?=
 =?utf-8?B?czNQVmN1THMwc2xMSFNMaWJSeSsyVmNzSXJJNGh1N05hVE9aVU9GNjZ3c01Z?=
 =?utf-8?B?SjVEd1UxMXdrd0pHcDIwZThTVFFReVo4VEV6NTdiWU13ZWRVTTZTdVJBRFFu?=
 =?utf-8?B?QlZ4dHNnS0hPS3ZzRVR3WmNIMDE4Szd0cG5lU0FRVXUzdTFtUUdLTG9yQzVx?=
 =?utf-8?B?cTU5SFdiN3h3dDRhVkhwU0puSmhUenliUmFNdGpSTW1lTHFOYWMwN1E2YXBx?=
 =?utf-8?B?d3hUSDAwRTFVTC9MRzNqMnBOcVJoL2tRb3RUNlh4WCsvQURUY2NRRDRTamJJ?=
 =?utf-8?B?OS9KMjMrWkwrMVZ4enF4Wkw3RUt6ckkycnl4d0NYSlR6eVFJTlRVeVNHVDJQ?=
 =?utf-8?B?MWJxUkoyYUI1K2ZpaWdPNEM0MUYzNmxOaXk3aG5LdEVETVg3dlBjbWlqRU1D?=
 =?utf-8?B?aXVaY3FmM3pzUDFESUtqeGs2cGQ3MG50Z3JFR0lEUTJwN3F6RW55eCsvQm85?=
 =?utf-8?B?UWdLWFFVeW9iMzJWcVlxMUtiOHpZaXc5UnJsUmZUelBNWFBOaWZ0eWRSZUJH?=
 =?utf-8?B?NjY1VzZiTUhNNit2dkkwMy9QdjhxUDlqRExOU0EvV1RmU0JLM1ZmejJYeWVn?=
 =?utf-8?B?QUJyQVFGUHd6dmFoYmdyVitaV2c3ZmFGOCtvT0lWSW1KNTJKUzdlb2dLTUM1?=
 =?utf-8?B?MmtuRkt3cGpYTlBLazI3Yk1yNThWb0p3aUZEOFBIV3JWc0k5TXRLZ0ZWYU9s?=
 =?utf-8?B?Y1JSZGRlR2dGTUhwQVlVemZqRXBjWEZ0RzQwS3VhbU1RSGRnbmNaTElRcDFL?=
 =?utf-8?B?a2JYMVNLdU1aRGwydkxvMldvQmRiMHRMcTEyS2oybXVSMU8wV1lwb1p0UXJr?=
 =?utf-8?B?UlJKS3hLZDkxMktXTWlLcFJDaDB3Y25uV21mYWNuS1Y2VFZRYW5KazhZNi9w?=
 =?utf-8?B?dDlZTFpDY1graXpXL002U2Q4R2U3SktvdWhneldZd2pNNWw5TXFhSVFjOHhO?=
 =?utf-8?B?aUxjR0pNeFllWTc4b0d6SFZIT2lCNmJmNmh6eURNKytlWkw1bHc5eWJJdzhV?=
 =?utf-8?B?L1hBV2cxOXlLY0pESlVISXo3bzQ5NTh6cFlEVVQ2OWFYaXJRWTZsa1dOMDFN?=
 =?utf-8?B?eXZET3h5b3lORHV3WTVjWW9xZ2hKRHY0SGg0OUl3d0Q1bEs1SFBaVEhocCtx?=
 =?utf-8?B?Lzd4SlNXbUJLandYcE5FMXhUZUNPaG5ScGdPNnF3Tkdxalpnc2hCWjlvd3Q5?=
 =?utf-8?B?ZENEcW9WU3pmSEJ2MU9JS1IweUVLZW00VGJYc0tNS1hXMUNPblo1c3c2TGdh?=
 =?utf-8?B?ZG1yQnZwbmduNC90MTNIQnVvMjVhaUY0RDJ4Qm5rL2lscERMdk1lOGtxSWlN?=
 =?utf-8?B?QStMRkJCenMxaGgvazBrTmZoZHBOaS9rU2ZmQUgyNTB3L0hLdXU5V2pwVlZM?=
 =?utf-8?B?Mmo5ZFBkR0I2K3RNNTNyMXUvZm55QmNXWDd6N2N5YU8wTXRzNjV2dktVVTk4?=
 =?utf-8?B?Q2JQZHZGVmpBYythaVIrSVROUE9wLzdSTXpZZUFKUmVJZ0NuR1JUUUZyYnM4?=
 =?utf-8?B?a3NHbnU5V2I0VDhqdGRBTDljdktiajMrOEo3amVEYkg3N1NYWCtMc1BZODYw?=
 =?utf-8?B?UXI3cTJBL2ZyNjJlbVRuRXcwcWl5d3FLMnEyMFVRYWtoOHRQOCt2bStYQnQw?=
 =?utf-8?B?aWE1UVVYeG8vZTE3NkZ0ZkI0Y3ovOEVhQVByV3hhNXdIcUhrYjZMMGR3VGh0?=
 =?utf-8?B?N3RVZHYzSWxER3NxZGNHdWZINlE0cVFmVytjT010QWROdzVlenRIdGt1SmRu?=
 =?utf-8?B?alBuOGRYRXNKUFBQL0NCblF3SlRYZWtvT09HZG5UcFdnanpraUlGNU5xWHI1?=
 =?utf-8?B?TG5rT2dZakJWK3o3Y3oxRzAzREJvU0pHeHNubXgwOERWbFJMcWdxSXB2bktK?=
 =?utf-8?B?WGVVSWRpUzBFei9xRzdwM3VjZ0FBbnhwMnZpbklScDdzWHArSFVLZ3I3dXlo?=
 =?utf-8?B?UVJ2Yjl4U3B0R1YyM1NtWXFmOVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hkj+9HmtAl55yJygmOP7Sk9OvBbZcpgO1nrzH1Z6ZZJZSHakon6xzK1MRacM0TpSRbr3NZ+wTHaLfAajYUzj63SpZwtOrY2gyG6BjtZRgJmXMnPFLoUobxIRvAJIT+HNoD5+rrFHmrZ+fFRegIbhN8Xfue3Y6QCwTqajaEk+3LYkvyknHBVSlmclhXnovI9h/gjORtHAEOrWGn5t5Fanr1q+NKNyWfdOyx7Cnvni4GVY9mrGbkLUMfnqmODG69mggOTUvI4hJ2yeCBnhoHgbryNYUjFjWmGPq5P2eB45nJO75JCyUjY9+iS3ooAe+Jo0SOAipnK0Hy76fyujElbyxuqIlv4OJXDSKvYIKNbWIH8H+HXZOj/31LxhrOwuFubhMxhlrdknQ1tgrv1YT4K6QHiWKa0CLiXgVGpCsvaaKg2Ndrt1qizJbUcuccCPoPfb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:07:07.6241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e29eaa6-7607-4b04-47d9-08de6f188792
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8466

Hello Michael and Miquel,

On 12/02/26 18:25, Miquel Raynal wrote:
> Hello,
> 
>>>>> +	for_each_child_of_node(partition_np, part_np) {
>>>>> +		if (of_property_read_string(part_np, "label", &label) ||
>>>>> +		    !strstr(label, "phypattern"))
>>>>> +			continue;
>>>>
>>>> There was already a review comment on the last version. Moving this
>>>> into the driver doesn't make it any better. In fact this might
>>>> create a (bad) precedent for future drivers.
>>>
>>> I remember complaining about it but not if there was a solution
>>> foreseen. In SPI NAND the solution has been found: the pattern is in the
>>> driver and we load it into cache before PHY tuning. But for SPI NOR I
>>> understood this wasn't possible. What would be an alternative?
>>
>> I'm not complaining about using a partition for the pattern but
>> about the hardcoded name of it.
>>
>> It was proposed to use at least a device tree phandle to point to a
>> partition (or so).
> 
> Ah, yes indeed, thanks for clarifying this up (again) for me. I also
> agree the hardcoded name is not ideal.

I remember this was discussed in the previous version. As mentioned
in v1, using a phandle may not be ideal since a single controller can
be associated with multiple flashes. Regarding the suggestion to
maintain an array of phandles - consider a configuration with three
flashes (NAND, NOR, and another NAND). In such a case, we would not
need a phandle for the NAND devices, right?

Also, I'm trying to understand the practical difference between using
the partition name versus a phandle. Since the phandle would still be
named something like "phy_partition", it seems functionally similar.
Please let me know if I'm missing something here.

Regards,
Santhosh.

> 
> Thanks,
> Miquèl

