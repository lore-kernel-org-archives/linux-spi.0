Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2BF3A7F62;
	Tue,  2 Jun 2026 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381849; cv=fail; b=pY02Xh12JsI9cDHUAJZ8NwKraATUCJglizZShahA4YTR8qqUJgx/JWYvbIkoy9UuH/b28aTVTeIODbHolx536QVvVww7A8mWV0Q1Z2LNfXuBwKptATvyHLP6KQ4O82iGC7WX06EnZDPGLMtVmOH2csLJb8eyyJbmrZBqt1PJlZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381849; c=relaxed/simple;
	bh=gAgV20Wgm2SPtvEXOrQ/1tCkyvEMWV77LojkDP6jDSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dmKHL9TDMhPAaf1S/asRiR2S3e+I+U/tBeeIToR0zZ4NbXn535uLa6iXH8FqocjFdOXq+fIqdHAzzB1/ubZncbPo8pMEn2xESI413e6NTHqhTYSUMHYPsWZabek+FWRs10MAYX0Q7HqYU49nub7wtxtulno7FHKfc2Dr0i4VPO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mwcTQQXM; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mwcTQQXM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN0OiTvybep+jh+YSW5+WjCpQCozxqTP60d0YDL8B6Lh2p4qKZnCQjlv044Jst71d2LT5p6Ey4fw93ItuiOgCbaMrq49fA+0uZRi3pSWL0GZ1CoqA4bL1oePzr10IRvnS5pI6vCTslt+2ImG9wbrNO3hwzVbsAs2MZmNTAxjFojxlUaHSTri08/v0wY6N22Xb244yP5QF71bfV2nTPnloK06YCXVaq8hlrutB1Qnou1L2Hvy1e++ZkQ7jfJZWEda980FKymV9O8JBC9O+pKfBPK9C+eONSUNzjx3poDAvp80CmekdHI7eMxiD96zif8eI0LX4TaG+NmSM115s9jTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/mEPqm32SSRg80uzcOFEqv4ap05/oZLpL4aUJGzfD8=;
 b=vZYoFbJyxpIxClOydUdmVfiw3/rzhdrag/5SHWfsPMRf4y2/18i9l07PT5WOS7kBSKG6uch20v2jT08WucTPLg7Y3ZO6EWE0lhQfGH/E4ZAXxfU7mOWjnau4DWlisz5LIFG2hwnYmMegaxOkJb5aaMTYntzLDb4F6HpaHqKcRR9hNcVxrDuH1owS9oiEU5SDxYG05Zyz5jjYQ4o23tZOuysC6ztMXoptgeMepRRWotZd1lT02mvVkPBqKy/RFhi/mgefLqCdp3DCMzsL6AXC9KIeXKOc54ELl6U2283QdQJHVBu2jJPNdFBPs8z1X2EdxPqE29bOJdRCgdCtQk+8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/mEPqm32SSRg80uzcOFEqv4ap05/oZLpL4aUJGzfD8=;
 b=mwcTQQXMqCRCjqYdjx6jiv8E6677cMT6X5JHq2FUl9iNXd8Od38z0Yxllkh+XhFVDZQiLL5R8Bc6b07nFplCodqDXl9VIc6N6iK6g7PaYsAHaVl9tLCNUGqJ/ohEVztJS1jY5A+UsT0ybGzkBNy5J7lvKqmc5AYxhQoXNCt3bws=
Received: from CH0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:610:74::15)
 by DM6PR10MB4121.namprd10.prod.outlook.com (2603:10b6:5:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 06:30:44 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::85) by CH0PR04CA0070.outlook.office365.com
 (2603:10b6:610:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 06:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 06:30:43 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 01:30:42 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 01:30:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 01:30:42 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6526Ub3j2665621;
	Tue, 2 Jun 2026 01:30:37 -0500
Message-ID: <4a570d36-dda6-4f3d-9c16-d3e57ac55f1c@ti.com>
Date: Tue, 2 Jun 2026 12:00:36 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
	<a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
 <20260530-original-peccary-of-cubism-af68ed@quoll>
 <2f091813-fa28-407f-892d-bbbbe3cac4e4@ti.com>
 <063fe976-9a28-4670-90df-921fbc1c3a8c@kernel.org>
 <20260601-stirring-tested-mayfly-e97c14@quoll>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260601-stirring-tested-mayfly-e97c14@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM6PR10MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 96916397-fad0-43d4-314b-08dec070790a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rDI4v8CAnrWvndT9c5RlqoWp7tEWUyqHFuwvPR0/yrtRLFq2isxICCRqFMLQR+J6gI1BlmkNg4X+2U6Wg+iXyBxif6r5tf26MnR7dCjit2MJAxMmwk6PJjTExuj7Dne7IM89HKyldHXT7oRve0hmdLROvw4AEb/+lxek5odby4s2UETGwRtA71FvlNlSRAcPgTsvjZXGZCIb0S+pMvldVpK9L5dYmx+w3XkHAcsS3cE0TThSGpcVnldHQdDYwsO1q8zRVHK0bC/GzSJjiLPnY6hEdSiVEAIC0TjpC+uxwEue1UmAqbWNSkXGZGEINROM1CYlB3TwZC9+bsuNOyhlVUARABmNlcTVDH//IbDUEtvc1+gbQuv8H8bkR/mVFTey6wEUtl9va5fRfI0GivjL4/wSvrQ1CKSfAq4JZtZp9imBeKc6ucz5OkRVzbz5ieANu57XDEZA+rFxjJFaWAyBVf0u5UyrVduvZru9+p6+QetxZ+BdG1wV7qnzSAdOs6K5HmFLIvf2YlRxzkVqFVpaA+cPqy5oFBTzk2Rl3wxkH0CNGJwOq5bbrhYMYZFY8NfE2TvLfkOEE57AlrXtexMCLSdOf38UwvgXZDSkS8tFDyLSZPQuRCXP0CveEDxV8aHAa+DecvoMR9gtfS6GNNzvcEzzP3e9mIl4SpEFTiwIL6tbOOcMxxcNwZX9fIfHTABkQEED0/QfwIOD6tO2qW4fgXSL+JGrTXeM3yXfe12gwsQ=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/DSPLaJY/5KYuZF+cdScMQyJfWZphFUPVIO+Y8Z2rD0vYEzR59tBzecpxekeQJnJqzrJy6FhKK915+ijJipOD1a5e7mWWHJCVnuydpcIbyzvJdRtsFWy0g9DMjk2lFefLpRvZndjfLls2nZpXVC4jXeIAtauDJXKuagaMRIG5dWFfShMbWJkj6RKffSL9+nSQ81FMkNU9mqFcmK8v38T4N1zpdl9XCqVf5DPBTgbT+lGhqIvCr2zCccVcJCj9cu4kmCcE3g0m/5SfGEEk5EC+SI0CKBmFHTRm+deEQ8X6XSJoJhEVHOm58fcr/++NkBlA3pf26PT5WKl4syaZpveKpA4CWxl4laN8EwF+Yl+H7sqdpjfmZAgrxbn7tGu2Jm1UdUuE8uVb5PENK9l/H1T6m6215/AwLCOvyGHYV9OwQdZ/S583GDoFLWx3w4F5vg6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:30:43.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96916397-fad0-43d4-314b-08dec070790a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4121



On 01/06/26 17:17, Krzysztof Kozlowski wrote:
> On Mon, Jun 01, 2026 at 01:26:27PM +0200, Krzysztof Kozlowski wrote:
>   >>
>>>> This should be used in any of applicable examples.
>>>
>>> Please refer to the DT changes included in the repository linked in the
>>> cover letter, which should provide a clearer picture of how this
>>> property is intended to be used. [0]
>>>
>>> I'll also add a DT binding example in the next version to make the usage
>>> more explicit.
>>
>> Why do you new a new example? Why existing examples are not applicable?
> 
> typo: "Why do you need a new example?"

No, I  wasn't planning to add a new example. I'll extend one of the
existing binding examples.

> 
>>
>>>
>>>>
>>>> I also have doubts that this is per-device property. Your commit msg
>>>> suggests it is per controller.
>>>
>>> This is a per-device property. It is consumed by the controller driver
>>> only to locate and retrieve the offset of the PHY pattern partition
>>
>> So with two devices on a bus, you need two separate partitions for tuning?

Each SPI NOR flash device needs a partition to store PHY tuning pattern.

Regards,
Santhosh.

> 
> Best regards,
> Krzysztof
> 

