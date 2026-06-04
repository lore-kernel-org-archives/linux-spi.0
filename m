Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C342E000;
	Thu,  4 Jun 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575039; cv=fail; b=iA/BU4D1gsuP+6MODII0PmXCs4CN9eRmrCcVBU2dk1Y8t2nhSeHKkkzRVBe/qAQzAkMpDVl58u3twu4kwjDsuocIfpe3NO78uRhTduiqnVMj0y1lftYrlQd5L1I0nT/ty9H2IYSZp5TO2JA1cyG5FwNv+tcC9l3cnp2RsWLCqsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575039; c=relaxed/simple;
	bh=xAAuc/ryLrWgtzOwjD3irYRg0CqrcP95LpLH1pu5gXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sF2DywNAO5wsbGMT4A/ufAwqEHdWdXmhqB0mJDTkmV3zvuhvSP5oMWAqgLv0Wt2f60q7nl243/xIpo75/DzjnF8gqKGFaWBGnDU/dwhmB1oIggty02rPbp0P2KteT56UBPO3NG6KPNxYPCSnul6wH4lDbYVMv6wqxEjfrk2cTMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DbbtuoiD; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DbbtuoiD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/MANT1qliroruP1lGE8mRgrNCJUOTmmhHC9zroIpG1itQ2oSU7DIcIZyweBbcxnMC8kFXDVQNawuIYYSyi30rIuehfHV80FQk4Ppou/w7iCzRLKF9zRlSNN8PuXB5aAc3lLImLsmN8elcHvobLoWsXjGOx6YuQYq/nAVAxRrSmedbjx4nCvDivHBj9Jrgq1PoBx3tZz/9t/AYe24offdOz4fJFjeQaoKMdL45nXvjhEwdGeohKvUWZ854n8GDrJKyDRq5ab0TuHulHib+1D3+nbd2l46PBUMi4N6KVNO2m3KsOiEruIcKuBQLRDq5TpR3sYwBNMx/vw748gs2OqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhwwG0O90c7WQanZpT4mOZebDfSvyLZ5d6JTDNy1MnY=;
 b=YO7+5UmHVplfBntLghVRKgdzIJGnmkVX8mg51oRIC3wYMxiWivNn95y+0E3FlC5mYASJ3WVIKoJeQ3wWkkZ0nd1CZdHK+OhOF2VRPy/e9gdqdQHx6B44YNJVPrIL1CTF3eRyzJMgZOw0enGiUf2gKcM5auIKCOmilRY01Lw4FxEjfqGtPTZY9QQBMuwREscWJh1IkylwN9MO+DsA9wCt3PPiOZfCLc8wLCmj3dXry2bpjjXtehPgm0V9+3td9N3pv02/uIf93DvBYabCjPE78dJgw3M8xETVY6wViMe4mXv+iFpWTnkGH4M/HEMe8rwS4yUwrhure5BEDzJG+4lDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhwwG0O90c7WQanZpT4mOZebDfSvyLZ5d6JTDNy1MnY=;
 b=DbbtuoiDXc7HBWwt20riRkSnh4obKagDW4DFwe8S+SloOZXP3tYWpLPrdqbMbuF6SFm1OQBDdsZA7Q8E6Z4wCzD0/IFlMUeN1qJmD9XGuWWj7uJzK3g2QwQnHbCBh39r4CYz0t6oCWkuio8mICGWP3RtS1saAUI+t2mcHtnl5ys=
Received: from CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:10:35 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::8c) by CH2PR19CA0027.outlook.office365.com
 (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:10:34 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:10:32 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:10:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 07:10:32 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654CARCp3334378;
	Thu, 4 Jun 2026 07:10:27 -0500
Message-ID: <354e81b1-3070-439b-b404-20a2c30bd774@ti.com>
Date: Thu, 4 Jun 2026 17:40:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] spi: spi-mem: add spi_mem_apply_base_freq_cap()
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-5-s-k6@ti.com> <87fr3bhqkk.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87fr3bhqkk.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: fd936aff-9a05-49be-5f6c-08dec23247ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	vrMAdnEenYIVVN7PiPDKNIgCN5Q0bGPHI3gBtfz4vz+/rg5KJ0NsLYfQOngujhx6P6Wtwi8xIxngl/ZiRagzrwJO//czZIB1AoZOJlpVpgwP/ercdp+Gp3RmH7JvQVWV4CC/yRtRr5c4OyBkTU+WnYZcnsEXzb7Euvejd9i3lpEGnMs4mqvx3rRpfVCa1qKkFtL+hQua7NlJ5TVWicmH+c/9Fyi+tBVe52dx7TXqG3ltTYbCrLeFM6jRdYO2egmxLSFWMNSP9c3kmCb8ebRvwQ73OQsbWwjCoSjzPPRcDDLEjqAu/Rc6YjpGyqI8DTM1cq5X3muKN6EGbmSLi3dOO08SzDSRMgCKZZD2cFYW+1LK9u2HSPDdIjZkhi3/S7fxEdPydBUzXirFgyNmJrKS1yJkDsHN6CSbMMUdKuapyrVKVgMxgBRUGYuSmmp0brdRCqDWEmB4ttftnxi2nSjLc0X1Dt5PM9Qo70Fl/Tyk0jYGQx6XF2y0btsBftajsrmy8JcMuUwV8efFiuefSiTUHsN+0a/yS35hfNyhPGYSBUZjdMNROy+UNFpnM97TmWGa+ieOh7HOGEyopYXVLKVJTZU9LnIuv5nJFqOxxgRnwTffxWxZy29Gy2FJWFQq3MBN5Nlz4oM3vGOr5xJQ+hOHVDXgs7MmcuKWaf9RUm6fEVXU+YWTSSVa4VCgmdpcK04AYH/R9UIkvONbBTMkrEvf04SsMcmL8fSqff+fIWcsy9E=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J5DOqjoS2lwCYlOWFgH9Re5BAkVNdVXKHakYNtm4yzJjgylpOT9H1ilZDB9rNasrzBZne3RkLggalBtq+yEeJ2vPb8imISi7/9A8emzccJdbyVkgYfCmKLW8SJ/DjuucjmtnXN/ACy/US4pePoo+yrV8NoEPe/jNRwV8o4XANZRI3mbCZrVMNHXMUAukiypSWb7SQsfUeA6Tn1KD9Sg3AExptq0j0GBIpNWhQZKgeiRrVHIBC0QKBStUHWXlbnlOxJQCqpPWKoSTuE8J7p8LCd8IGLCt5zv2jpMC1ZuBbxGz+eRMfmjnLHzufBk5ovUyPykfBR5eIcElkPeNZfhyFd5lTX8sopSw9x52F9Apz71hkkUFEU8H20gbpPiqlJ/pwLH219xYj5o60Q9gjsdgsWm8Arlbw+RgUEU6HdPgwByXHOkChR8ZGp48o5KqVyWt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:10:34.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd936aff-9a05-49be-5f6c-08dec23247ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412

Hello Miquel,

On 28/05/26 14:13, Miquel Raynal wrote:
> Hi Santhosh,
> 
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -398,7 +398,11 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>   	u8 *tmpbuf;
>>   	int ret;
>>   
>> -	/* Make sure the operation frequency is correct before going futher */
>> +	/*
>> +	 * Ops not configured for maximum speed are limited to the conservative
>> +	 * base speed; spi_mem_adjust_op_freq() then caps to the device maximum.
>> +	 */
>> +	spi_mem_apply_base_freq_cap(mem, (struct spi_mem_op *)op);
>>   	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
> 
> There are many more spi_mem_adjust_op_freq() calls in the core where we would
> not apply the base frequency. Aren't we missing these places? Wouldn't it
> be more appropriate to call spi_mem_apply_base_freq_cap() at the beginning
> of spi_mem_adjust_op_freq() ?

Moving spi_mem_apply_base_freq() into spi_mem_adjust_op_freq() would
affect operation selection.

spi_mem_adjust_op_freq() is used during variant evaluation through
spinand_select_op_variant() and spi_mem_calc_op_duration(). Applying the
cap there would cause all candidates to be evaluated at base_speed_hz
rather than the actual max_speed_hz. As a result, variant selection
could converge on a different operation than the one that would be
optimal.

Keeping the cap in spi_mem_exec_op() restricts it to the execution path,
while allowing operation selection and duration calculations to continue
using the maximum achievable frequency.

Regards,
Santhosh.

> 
> Thanks,
> Miquèl

