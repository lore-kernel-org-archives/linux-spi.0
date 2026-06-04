Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA404279FD;
	Thu,  4 Jun 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574664; cv=fail; b=PZ9zuf0vvIDog6bV6sn+n2DA+DoJNHyAYrShVUEBBr6PRfXTK5iCdwOBU4b1MHEaK/j1HqoUj1QzofKVW7eMH08wenacdiOAYJChx8VTCByw45C37fcPsm9hNxFrjlYsEO8ul83gX53kCHCpF5P1x0iiyQ3jjTuwYKj5PEzI38M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574664; c=relaxed/simple;
	bh=ori5GP4OFElku2Jr7bw/fmRidiz+vfPfjIndWRMhV9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1XB2XsdjBPSFxaiBcpg/tld3urpj9hFdTBz8n9MnoEUxuu4bcmi4PhdNCL2/+wIY2S64hrYItUgWEREPTPIj8QCcx3XzyuvFrUdiAw/m3nYp1lFpKLpePIsv04+B0Lf08mxlc2myu1su73UU05mgYktXir/TERwDSzvqHUVwsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RQDhEcgd; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RQDhEcgd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALd6ElrmDoFwE5J22/9iWM4SHzwVtM6xAixmEjr03rySwL3WChOuPZ729U8LCnjqN211QFQ5MNOuM+5pKAiiV9sTXZJNOkWEM+jSCAgkUwaI9pXzj5jjyFu2znw/y+OuHVpTi3Rq+mg52gUAmgF6sXCgrSnjL5JXxAl2vV2n6iHSW3zATJ/Ekr2ipyK5uXoIVLGNvJBrvH5edwrl+GfkWHkGbvy2OHoQr/Ya3gynlrZ79sawFmiMCIj96J2rEyGJQalrhFxgnJOIJH6YF6zPqZxf9trZanrrjTu9uY9IJFx8ApWTgOO3F1F6bCzBo6gLJGCLUHZOAw+bXezl4bVVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFlR2mYE9+ij18ctHJUpd8B4x5AEXkXiQDfM1fIuJQ=;
 b=wjtutbOeyKgnSija98i620p4TjPwLJMFMrQtKJ6f+LiY+yjGeTfy6/g6Sywd2Q8K4WAfpWNjrC9vNdA+jtsmPxJo9qXbhkqJLI5we66jHYR5QqlGqy80Lhpk9OUSBlZnu9s/wkC/deAl6NAqWJJVzCOH6bzaBLgeb0mFGxUHmUPKevCXTbjBHXuL0I6cdKTyaiRrnQ99P5E0qzG/Y1K1bUd7IgbRypUqKTFFo0ds5/TZOfWiyb4Mndzk7brjBCGbSs4ldrMRJFqx2T1/ChCTC+mQHAOtH4LCY6pETwwAoJFuQ+1JnUvBBhtEK28WUfCKbvOr2KaoFeEof7ZdBHzwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vFlR2mYE9+ij18ctHJUpd8B4x5AEXkXiQDfM1fIuJQ=;
 b=RQDhEcgdPC31mu5c8K8W+1xsM1S/FswRCx/C9SaoCZtGJpgXL3CdB0HudOEqOtr5eEaB469rewrHoRDiBG/zP90spgcI4hgCUVx80DfaxdmWKpege1QfZj0jAg7+s0UL/VHsFlfSEAYAZe9u0xhHtbU6BmVuYF8XQXsUrCQggjg=
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:04:19 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::5d) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 12:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 12:04:17 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:04:12 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 07:04:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 07:04:12 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654C47ll3864081;
	Thu, 4 Jun 2026 07:04:08 -0500
Message-ID: <e3ceabe7-008c-4969-8e22-97ffa4afec4f@ti.com>
Date: Thu, 4 Jun 2026 17:34:07 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
To: Miquel Raynal <miquel.raynal@bootlin.com>, Rob Herring <robh@kernel.org>
CC: <broonie@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richard@nod.at>, <vigneshr@ti.com>, <pratyush@kernel.org>,
	<mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
 <20260602164945.GA475455-robh@kernel.org> <87zf1by5oc.fsf@bootlin.com>
 <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
 <87cxy6ydb6.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87cxy6ydb6.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 348797ea-dbf2-4701-3ac5-08dec2316772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ChX+34hodUHqwbJweaRWv9igi/nC02rz/Vf8fMfelATkbdfaIPF8v32nc50NuvM9QiJHypXjJBuU6WkMVgILSnxAna6mwPZySJ+EqvrgeVvzne/YUhu/sZkG3OSy+IsmApGuE2/FCGTMfz/ArrENxArevEyAaqOR0caOyl4HpykjTy1tOxoR99rfxaRb2lFLkcf3DN/4/vpV++v2xfq2Zha+QSFhhzYeAQo9oNAyk1jsR4yGFHKLJNcZ4uC/8DE4ahPUkB416ICZHuegqlL4Dso3g19EUWIp7jqiMyDqfyD6uyafHgYrSQWiIEA/SdvpTlZ6gbaZwnl7PyNF32hzoaLKMu5v7P6iEPFOsQu7K/z2JeQL0LxcF+zpgnMo3NX0mpB5B/PAi1Js5FNy0uDTJItyC88fTmXOS6GAEXekHcZLgtRv+PJLWYkVmmISh9uBpg6ie6OgImlW55G9D69auCC3E6D+jQ8p65/vuln9vQt3uyUncIJcNSfQw7sscKu7EafX67nyVYfUTNi+5vM/dqVLfjqDQ+EATRyOE3+jhaQN2tf+H7xUyQ3B6MRhh2O8mwo5Qpjb7m8xXil84dE0Oa3dYOBiek5mzTcXCbL+5cwDXaHnd3dUsBqSChfy/RaUM5WSVaEKfpyEU38SNP8fzrUk+2aoK48nS0N0OzEuVCVNkAKQJ0ZUIpR4NS4uRX2LSvw1+YzeppUjMaFw9jW7U/39Odh67XYXkHwC3OMEn0Q=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/MSLLA+opXrqHQCuN2VhDS8kOVQ06o95tGWmdNIVUVppdcOKdQ930WE7n0ewtMMl1vtGxtBpadX4+pNw6gwleuhq6USQgG30xDGdrQfSRlk7SbaMBUS4n97PxvuUToyVWAcS9MMcDJH6vS/r3Lf0ZT9VBxhOrKGojtqH/xUFSDaXTvxGe3X00SjqG3VQBo0Vn8pqg1NQtYJ8/xDBV4Q7HKCvKZfiBMJKua0PjS0KMsyEsNm16iGAVI6cvJMuP0KKY51qKi8onS612Fv+uu8+r0VDWxOJMRYeFcUg1zyKlQnKXZQnEvFnytJmVSnpb2ksJjowrBdZ2X9D1fb4c7V+KB6/M3oPYRnl0jD64hFfxrdcg5jwRqGMDvziP06dlSvTae20pmBpGnQkkcL7TPvFh5Vdvk5i1OsGisaLLDQKC7Arkcnziwu8f0pCoMc6zs8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 12:04:17.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 348797ea-dbf2-4701-3ac5-08dec2316772
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998

Hello Rob and Miquel,

On 04/06/26 12:58, Miquel Raynal wrote:
> On 03/06/2026 at 12:38:46 -05, Rob Herring <robh@kernel.org> wrote:
> 
>> On Wed, Jun 3, 2026 at 11:01 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>>
>>> Hello,
>>>
>>> On 02/06/2026 at 11:49:45 -05, Rob Herring <robh@kernel.org> wrote:
>>>
>>>> On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
>>>>> PHY tuning requires a known data pattern to be readable from flash.
>>>>> When no partition is explicitly identified, the controller must search
>>>>> all available partitions to locate the pattern by label, which adds
>>>>> overhead and relies on label naming conventions outside the
>>>>> controller's control.
>>>>
>>>> I agree 'label' is not the best choice. Software should not care what
>>>> 'label' contains. It should really be 'compatible' instead.
>>>
>>> But compatible does not seem relevant in this case, right? We are just
>>> flagging the location of "some useful data for the controller".
>>
>> compatible is what tells us what a region contains and how to use it.
>> That seems exactly what we need to define here.
> 
> We usually talk about "programming model" when it comes to compatible,
> here we just need to point at an offset which is in no way different
> (from a hardware standpoint) than the other offsets. I honestly feel
> like a phandle property would be simpler, also because compatibles in
> MTD are already quite complex to manage and I would prefer not to add
> more complexity into the parsing logic.
> 
>>>>> Add cdns,phy-pattern-partition, a phandle property that allows the DT
>>>>> author to directly reference the flash partition holding the PHY tuning
>>>>> pattern. The controller uses this partition during calibration, avoiding
>>>>> the partition search entirely.
>>>>
>>>> Do you have any data that this approach being "direct" is faster? In
>>>> fact, it might be worse. Instead of searching just the limited number of
>>>> partition subnodes, you now search the entire tree for a matching
>>>> phandle value. We do have phandle caching, so that might save you
>>>> here.
>>>
>>> True, but besides performance considerations, I personally do not find
>>> elegant using a partition name/label, but maybe that's just personal
>>> taste :-)
>>
>> I agree. That's true for all the partition nodes with only node name
>> or label to go on. We should fix that at the source. However, you
>> already have to support using label,
> 
> Hum, no? There is downstream support for labels in TI kernels, but we
> explicitly asked Santhosh to drop it for mainline inclusion. His commit
> message may be a bit misleading on this regard because he is mentioning
> labels like if we were already using them, despite the fact that we are
> not.

Yeah, my bad, the commit message is a bit misleading.

Just to clarify:
  - The phandle was chosen for correctness, not performance
  - There is no existing support to reference via label

I'll update the commit message in v4 to make this clearer.

Thanks,
Santhosh.

> 
>> so anything else is supporting a
>> 2nd way whether it is compatible or a phandle property. Is it really
>> worth it here?
>>
>> Rob
> 
> Thanks,
> Miquèl

