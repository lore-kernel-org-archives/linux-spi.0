Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68038AC93;
	Mon,  1 Jun 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302403; cv=fail; b=Aqjhbr9hzo+mI1XpFS/cgqhMn3VDccgaVo1ywwaMpu8zVAMmSw1SjpMG3e7l1jZo7dcbKwKU86gqxMeg1DpftDg/pwUZ6+qqOJDMO3bS++0vAbSyVQS7nn37rUuW3o9v6uVRKHaoe6vwIb5XJXNUi7pi1/1qzNErAzEEFGxfrOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302403; c=relaxed/simple;
	bh=z9igVhP3VwNL6BzXLNYazL4jbK5mnEtzV9ArQ7vsdeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4EhP2MJtUkDMImC12PscYPmN9Mkpw+K54+w2VNhTT0wrmW+nSSja4/zaaGYgq2/DHHYlCfdttmtzAepUi9Fyk2faonLKbf6o2k90a3UQX6GrxcY32laUFj4VQ+QfOJUQ4VwYiVTJdxJ82Ks9URVLQZoISXQY3RUWftztxcXNQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O0yS7Xrp; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O0yS7Xrp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3wQI6nTQiSrcvc4JKatbCuptmC8qS5GeXeAJx+0t/0aqaSkCUtB2Ej89szWfnbLc4hma0jYGL/1hF2Qz9eSPzQYTuVz7tW/wUE9ihY4aq0YhTJWPGx0TYazvncYukPSeehi5GlRtWS+v5Tjn1WJfIoY2C/MJXyboX5KHDSgEi5XLW92frfjcPx+ywQhfqX5v7c14zqqnhEHdLataODn8HPjpWf2ByU+/TtFbVYUTA5smpFO7kMVD+pmc/cFIZSqgARICzdNBSLlrr42g/NdGsKNT+6s5WBmE2xVoQx4SjoLtvEOM8L7AZchUDjtktgbYrPbQrkDK7nyCeh5H9FYMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh9tyOqP3lfqgyLKYeMAl1bgjVNE+BFUW/THl3D8CZk=;
 b=kEdkdFtEgx9i2Rya5H+0SLiKZJHRqLU4yP1eGEGX8wERYTV0Ruqh3MceRZzZc4pOh1qHGUHcLwu+mt55qKhu8KW+WvrQDpgEJr4QWGS5a6GPo1PkdGt4jF/VcIRE4Pc/U6YAHRZv8atdm8PMNHJNPQnxif6i9nAOCp/yVE/SBmWwTmX7f4NpeBJY4wIKmFMIvrJkmIjykQz/9Piv0pH0JTdEKkTC5ZED9pgUiq9n9xr704HXY9JRgD87vPDRu+g/cuTO1pCdMOcdm5gPmXdD1cNYheGwvyEYWjp47FBdSzIIyCvFxYHc06Q7q3GOl5AD+YX971X6PvANdyv1T9HRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh9tyOqP3lfqgyLKYeMAl1bgjVNE+BFUW/THl3D8CZk=;
 b=O0yS7XrpffrhhrBfHa1su7LBZe+2kmNH/VoIyRcNgWxn6NCTVqF52Ml3VI2ieOJMzMGMpRMiwZw8iL7JaPMsYe02sNJ4GUjbnycsQvnQ4njDFhZMju4dyLxwiU0je/rO0+ukz+w2P0tG6A8IWdCAW1f6bEkAg1ge05RIthiihyU=
Received: from SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6)
 by DS3PR10MB997726.namprd10.prod.outlook.com (2603:10b6:8:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 08:26:39 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::e) by SJ0PR05CA0091.outlook.office365.com
 (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 08:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 08:26:38 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:26:37 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 03:26:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 03:26:36 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6518QVrp1158396;
	Mon, 1 Jun 2026 03:26:32 -0500
Message-ID: <2f091813-fa28-407f-892d-bbbbe3cac4e4@ti.com>
Date: Mon, 1 Jun 2026 13:56:31 +0530
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
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260530-original-peccary-of-cubism-af68ed@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|DS3PR10MB997726:EE_
X-MS-Office365-Filtering-Correlation-Id: e07823c1-38cc-4fdd-8e9c-08debfb78094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	l0k//yK8w4P4eKjp/aooygq+8Jn+/EaS5By7FfhEv1D64Cah+JhrrRMCebkpvLDkNfG2CBolrMXgWsJtLsLtTee9YjVzpljgwZVa8QIjFhk7VEmukRAHHolz3qnG9LaWCY7LUxIFlTyqsad987Rus1FvvA5GhL59O4+oki8KPFLaZoZbhXKgt+dpUjOlFECKhcEA2MafZUcINxfDsiLtxUJ66PuKf5RV5hYybycLeIK9roYoriSaBOLDD8ypbXCaJX1TZiKcAbYv447/KXhLF4daVQQHpkjklY7R2rYEbSrwx1sUOpjXt0QJkhxsGZyTea05C507dvAj+mpsd3EBOIpUMM22iVq7tbJnCiV+Puj2A1mX98gwcL/zUKUQ4DD9sLQnuJeqEjmDcmwOsdlFk5jMHn5cB/ojQVV1ose0bg6wLP48yQJSYd4jYr/2HNeXzO+W5J4JxnacM85dsVFe6//pPQ3o9H45tpOklDrz14x8QVQqb4j2XO4I3nznsVH6Vc7RuQHGT2lDUvbQffmeUYZRxX3/COYFeMT4jhpfgFjoOmuSW8or4reHghXiH1CG1xVuyQ8VhPr4NidWZCbvc6xOjPcy57GvSUCXk7jY0+zrll2c1qxo02e0odPdpJPTjqoGhFQresNuh2QNrU32DjYPQMOZevv5vrYY33W+MrPpX6INw2fyBEbAmn8H4TOThmEsswBzJJKNkkKxXKLKHquHGzbEBo2ElmJz6qaQWznWNxKBlrKjgaRuSraHCWgM
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Q2I2gSxv559XVqw7CmLaq1dh6WbGrz4PMQtB8Xony2L80IigaM199yfyapOaSFdzS7LxSJ0TGRzpEP9mHMlWYZLTy8Qa82oRL7f5PTfwZ/klnWix2y1rnUfzyHHwEUBm+Tm/qDABUaPbDzT5BYfCK0WMRRgxdur3G8Lrl/mKWSpEAd9+09mQ8DMMeTk8J6/rp3OpuXXQwBpUcMhfMa9kr2YN63Hf035z79/n/JRRM9UFY9WmHEd91BGuw0odvA7UCLW96T9SNUJAKADdVJSmQ3+BjZ5nMTFLX9uwlszMNgbAVL9pgdvKeZQvR3KFq/+ncwQ83l+4XaPeFMmJ9u5xWXc01XhssVlK3EHBRP8UulZIrSVt7J8/58l4aE0VJY/ni1cmR/eoCcH0qMZJOPk+/R8iXahk9QZd6t/qqjnvAIZ16uQK7rFVK09JHthOLkL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:26:38.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07823c1-38cc-4fdd-8e9c-08debfb78094
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997726

Hello Krzysztof,

On 30/05/26 14:22, Krzysztof Kozlowski wrote:
> On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
>> PHY tuning requires a known data pattern to be readable from flash.
>> When no partition is explicitly identified, the controller must search
>> all available partitions to locate the pattern by label, which adds
>> overhead and relies on label naming conventions outside the
>> controller's control.
>>
>> Add cdns,phy-pattern-partition, a phandle property that allows the DT
>> author to directly reference the flash partition holding the PHY tuning
>> pattern. The controller uses this partition during calibration, avoiding
>> the partition search entirely.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   .../bindings/spi/cdns,qspi-nor-peripheral-props.yaml      | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
>> index 510b82c177c0..0ffcdf5b00d0 100644
>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
>> @@ -39,4 +39,12 @@ properties:
>>         Delay in nanoseconds between setting qspi_n_ss_out low and
>>         first bit transfer.
>>   
>> +  cdns,phy-pattern-partition:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the flash partition containing the PHY tuning pattern.
>> +      When present, the controller uses this partition to locate the
>> +      pattern data during PHY tuning instead of searching all partitions
>> +      by label.
>> +
> 
> This should be used in any of applicable examples.

Please refer to the DT changes included in the repository linked in the
cover letter, which should provide a clearer picture of how this
property is intended to be used. [0]

I'll also add a DT binding example in the next version to make the usage
more explicit.

> 
> I also have doubts that this is per-device property. Your commit msg
> suggests it is per controller.

This is a per-device property. It is consumed by the controller driver
only to locate and retrieve the offset of the PHY pattern partition
associated with the device. If the current commit message suggests
otherwise, I'll update the wording in the next version to better reflect
the actual message.

[0] 
https://github.com/santhosh21/linux/commit/07e9281a6dcd2b0a01088df21e798b64d099f55c

Thanks,
Santhosh.

> 
> Best regards,
> Krzysztof
> 
> 

