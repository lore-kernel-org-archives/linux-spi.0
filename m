Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70592F8EB0;
	Thu,  4 Jun 2026 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574543; cv=fail; b=YpaeGK3ZhaQ5e/6wtZ7IdQq33cu0/RbPHDRxR0bmG6BVrh3gAB33a7Zt6HB1fvxUnKyCGfY1D9+mjBeYh/yAuP0CKlsaZBt4TLQVN5wkfsS+TWgmF57twHa2ibpsq7occqZhjx03OjzwM/vmLAxfjKDblDgS5nrQrEcanCyUk4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574543; c=relaxed/simple;
	bh=TKGqnvq8B2NVexiYYe0eajkr6O6VvStdrs4Ui8NHVNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FfVoLQ1ykOuNmwiriqX/LsQwqCl3b1c9+pnZktQKceX+Z6fGTYWg1kOkEXEM9RaQn+g9dRnq871TWW41l/k3O82WQAsP0NddglKQ2v1JNgGyMLDjjee0zIeDR3LZ6He/e4gelbXTJBTT8rvnVvAvKFW3j8QxyKeo1MehGIDTkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S/69wDWy; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S/69wDWy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOD5qDLijEZECB70x3V+zN9udZuqcaEk0ocxZORT7BajId0sYpAkSXdLWkXeHpI6H6vyTLGLS09LlqkjXLZUjuJpViqN23AZGefM0srzLUk0y9cJacqtR2KtGXOwI6FXg5qJT2h/lDuj/qZwqPe5z9DKC+kgb1Rk8j7KRpPufwds4Km3QKJEnELkQi8iOGtlkWrCuLfwCfOytOHUoIwlEpIhW00ES2WEGoMKC8zzZcQl+K21D912wG3xnkeVpZA6CN75rzm/LE2F1Z1CkCJOOpEssEiua3OPANntHEiElqRq1Oi7E4wT2SkmNfpn0kfSQ78EnjYx9f+AMI50gPIpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvKVNSPvepuQwjyc5GfOAeS2pNUGXsZ5bz1FIHibBZA=;
 b=QYLbyyU7/730BaPCT0hyWc+bW/NA8UtNx9sLz6G/u84uOAzWZCBc7+XVWp49oxy/cmHWgzotOlErRTblswkyz/imOKS07Dzlki2aYQ2jGV6AldCu3ER32GEGykzkxUoHWsmoqTAmYgLttAx4o5UlGpe9YZdOcLBuY4pKEStX9e+v5Xzxe3Hsyn10TAuNR+80VWZPToZ3z9zqvZYEq/4Qrm4s1wRetpXWJNGwMVLunOLuHRtmUN3cHHNKhxXd/TZZ29aEbYs9CW150THEAkcToCQeM/W17Uq4dOFGAjfdk3/UTJEVaTuSoXmKMNcuCdCWIAhhoLp7GaYXmrSV1t5G3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvKVNSPvepuQwjyc5GfOAeS2pNUGXsZ5bz1FIHibBZA=;
 b=S/69wDWyg306qIQTVlo1hz0h+XstL1SCoyBHOqBbXh0C7SAmK25tVtNal005BErZr7H2tY7WLs9hsfI55pOzuqabSlTxWHD09lB85XsDssT+I2jbQA1D7gQyf9q+QF1wpmCaZDWpoQC4AaACqdv/06x/du24LMH4S/UlF40KOcQ=
Received: from BYAPR21CA0003.namprd21.prod.outlook.com (2603:10b6:a03:114::13)
 by DS0PR10MB6749.namprd10.prod.outlook.com (2603:10b6:8:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:02:17 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::4e) by BYAPR21CA0003.outlook.office365.com
 (2603:10b6:a03:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Thu, 4
 Jun 2026 12:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:02:14 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:01:51 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:01:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 07:01:51 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654C1kjA3321266;
	Thu, 4 Jun 2026 07:01:46 -0500
Message-ID: <bcf49d9b-0f95-44ca-bb74-61bef625be84@ti.com>
Date: Thu, 4 Jun 2026 17:31:45 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
To: Krzysztof Kozlowski <krzk@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
 <20260530-original-peccary-of-cubism-af68ed@quoll>
 <2f091813-fa28-407f-892d-bbbbe3cac4e4@ti.com>
 <063fe976-9a28-4670-90df-921fbc1c3a8c@kernel.org>
 <20260601-stirring-tested-mayfly-e97c14@quoll>
 <4a570d36-dda6-4f3d-9c16-d3e57ac55f1c@ti.com> <87mrxd15mm.fsf@bootlin.com>
 <71045249-bd49-4a95-ba17-589cee255eda@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <71045249-bd49-4a95-ba17-589cee255eda@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DS0PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d0dd58-f047-439c-32f6-08dec2311dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|56012099006|4143699003|5023799004|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lpZO4PL8kxz4TABN2DfG2B9EQoI5ZrMvJuXa3YcY9lOl+b9xUPcACD1HvoK3u2ikUd4vyNne1qJlsrSRqBBo0dyonteyglFn6qB9/I4LRcaCS0GSeIVsN7aaswPEOwR6hPyoAS7B5RDrL0Mlpvk1zCYolvGdcMeqR4DeOOhMoW0zQGxbmQS6xk26hgHKHNY4uPxc9EIxv7Abio6b53eIWa7VOrKE7g+bb4H6l0YQCur5mcM6zXLJYRMhsLVe7g9xoHYq/zqT9geg+H8uDO+1ZPCuvwdMfsbH0qg92I0FXXo4DX8zgOehEJMuJyJ+hNAe7uYgaA1nSR7nb/HaIGo3RSRKExrankkR546yGTAjUn/ZSyNbdkiKlMTsofaJK/zXvpnP+qj6D8Eu4CoyhLWdAAbPuGwaCb4ZsJgCrDUINRncVCVM1c9qWohhMQMhZTlsKArMfNKIVe+dRB6lUyBXgiTj99hn5FDskNMLjWxIqwXIwmT+HfHOiPwKEbNcaYc2+KGZzx5ZTKNdj0jjj3ni3eFLMdqxaJ5QHkLoIL7Cze8WzZ/ooEX2Z64m7yuIUaxFdNDpLjPG9vR5dlLxRozwxto+5wDw314mGSzLlt77qK40DI0da0gYzK9dO6RhKFu/S9ISLbahDYvvX1QzsKesw1C8c52V5HHeSK4BHqht7czhWwraPIqV3EjuK8bPEcD4BINXzWDwLgNy/7dINj7gAxOiMra9Tkn+UUgjuJzs8WU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(56012099006)(4143699003)(5023799004)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0hfgEQZqgTpph9k2uP8NZecTdyCArJLRbrPzox1633eZZR3EYIXreUnXzfCloqyOwL9YAFYLdUZandUZPxftDtcf87JNn5H6bo86zap1vX8cU2SIYreYqwZWe4J53ozfKo8x6bkLYm6g71Kgb5gP8XfBj2YDjuTVjpwhasnfwMDksnUCMi1lICoLX6IuCmlqaBiL1ICakDC9s3xv48CQxfovrzV1IobNoxsiD8AOo93WDfYAvuFQwrCatBmJddqOhbnEve9imOnD4XSQbrB1oiY71vBftVQ94SGqGdhgFg6vNd/nbaUDoUjk00+2KBf/T8IYPBS/DDmNKewp2a8vmFmjFnJIUQKfoRrzHfh2R43BFInFnjXIaejXDnfXH5/YPZNqULvldYJtwXQunBf3F/4fQmuLDqexoPK/CQ09leCULRprGK2Jawso3l00h6GF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:02:14.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d0dd58-f047-439c-32f6-08dec2311dd9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6749



On 02/06/26 18:18, Krzysztof Kozlowski wrote:
> On 02/06/2026 14:36, Miquel Raynal wrote:
>> Hello,
>>
>>>>>>> I also have doubts that this is per-device property. Your commit msg
>>>>>>> suggests it is per controller.
>>>>>>
>>>>>> This is a per-device property. It is consumed by the controller driver
>>>>>> only to locate and retrieve the offset of the PHY pattern partition
>>>>>
>>>>> So with two devices on a bus, you need two separate partitions for tuning?
>>>
>>> Each SPI NOR flash device needs a partition to store PHY tuning
>>> pattern.
>>
>> If I may try to explain a bit what is behind, the read tuning procedure
>> is about reading data from the spi memory cache (some kind of internal
>> SRAM) over and over again, while tuning the controller parameters until
>> we get the best stability (the controller driver knows the pattern it
>> must get). While SPI NAND chips have "write to cache" opcodes that could
>> be used to load the pattern into the chip without any actual read from
>> the memory array, this is not possible with SPI NOR devices which do not
>> have such capability. Since we want to keep this training procedure
>> memory agnostic (and also somewhat simple), we shall expect one pattern
>> per memory.
> 
> Can pieces of above be captured in commit msg, so it will be clearer to
> folks without domain knowledge?

Sure, I'll add a brief overview of the tuning procedure in the commit
message in v4.

Thanks,
Santhosh.

> 
> Best regards,
> Krzysztof

