Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C42F5331;
	Fri,  6 Feb 2026 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406343; cv=fail; b=UIa+SITB0vVI0z6NO5FzJb3PKh7WWlAac3qFezeZQljXgzAsBhP9e82EyGlazK5Z/nvzTKkv5InYPcB5TBP42RHJltyErFRJBpRDppxmA6xxJ8oYph+g//fu5ZA4xh0mVopNtpTDIXQH+19g1PKBRnjNAs7dpoTFGYOn55EaUH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406343; c=relaxed/simple;
	bh=0lP0bnBqd49F/4k1MWPrvu9HBPWBVzxvBCpYvZlQ+cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=an14HY0A7xASmxz61E/4gqWDzJpKUdNfhqPZMzzXNxd5/YuZFF7EDdixX+4hjtZI2v+KapjWfRY9O3oQ7RHxJAzJoVGswma+uYieOMDWlluvX04WrNDKYwuCy+O02xgBNEzn+8915pk+0yRUfJ6AdOoCryohUZ/CLxKsDWT9TeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T4nCEZXm; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T4nCEZXm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SssBANvf5jBEGBrFZ4ysNK7I22AJhGsuXgZ9g2SkNRZBRLHCvL8o4Bwo1o6pgAV+rAk2+XZCKow4CKlymumE289KU0H6AYfH1qgp+Ph6w0HX+41g5f3B3dq9pGdzb1BiCAkAwqUqbbg94tIeJ1LQKXFdlqGXE8tYI37E+9wrN8dVQ7KHDKrNAjqxcIxR0jktQTCf2SsNpAbvEkhzsqeU+mBmkGuq7Y7baMgU1FyrAD1/WQ4WndVyV71oED1qmbVntjlY0Es95DhrZTpcDCSoqnu6SW8lFGSI8Kl2ASuko5TGRcVrLJhQ49rAr6v+LdZODx83PvQJ5HKijbDK0XASxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MpZC1ev4ph/0v1Arn5ZY5WpdTgWI2MnuvXC4CosclA=;
 b=uu+Ym54RLme7+m0d0A6N3qf/inD5oqI6VHGZBMp/o6YclxD8XmiakhkUPbi4eXei7lkgID+OLcJFnTyAXuoRcstWMqdAvLaL1+jBHStc8XNUghXtlZq+W8Lmub9/atwQ6CbVx9EPoICxaDGFpYyQlZBrCv9BK7RYrXmgOed+bAPqluelY2EK//evUIBlKhgJThC+/P9uj4MOImf01/bZRZDDJel44Io73ccAKXABvp0gdgnpm3Nqa2iDoDYi8q9ifL4CyfYPA6wHjOJNgOeYP+QviRat/aeWK4f2LGMBUbhisl0aTkDwj2tbLafOpeUoNFdvMUSNoYJ/YMQidbLKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MpZC1ev4ph/0v1Arn5ZY5WpdTgWI2MnuvXC4CosclA=;
 b=T4nCEZXmsrC/SMrGdPyTRCMN3OFXQK5R3NfXH+o6vkjWPVWz1U7r3YcfbpMIVs2X4j/7JLrYADpWq/4vv+lYgp3I1KSrjU2JgfSRxUehG/M0P5h0F4Dr4fNCtsD0HcSDgA0XBnzKixjWmoEg48IKLj4y50wIW6QEu4nlvDYBSA4=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by LV3PR10MB8153.namprd10.prod.outlook.com (2603:10b6:408:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 19:32:20 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::b) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 19:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 19:32:20 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:32:17 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:32:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 13:32:16 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616JWCZt1846514;
	Fri, 6 Feb 2026 13:32:13 -0600
Message-ID: <41f49187-e68b-4731-ac86-7c346de63173@ti.com>
Date: Sat, 7 Feb 2026 01:02:12 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] mtd/spi-mem: Enable DQS support
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
	<broonie@kernel.org>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <praneeth@ti.com>,
	<u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <s-k6@ti.com>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|LV3PR10MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d7b127-a0f6-4745-6908-08de65b671e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlJPcFBSNXRIZHhLeGRzQ0s0bld4RTZFVjhKamFFcVFkZTJFekMybk5FcDVQ?=
 =?utf-8?B?cG1hVjFXT1FsdlJjSGRxblJmOEE2dVRvMDBQdVEwYkw3VHVQV0ROdkRSeXpt?=
 =?utf-8?B?TGdGMlZpMEFsQmxOMDJGZ3BKQTRmSWhnMlhjQktlS1F5ZDVVWEYySWg3RU9N?=
 =?utf-8?B?WXQ5M0tpWE8zMG81ejVUQ3V2MTBPVWRocXVBL0ZFcUV4eFhvY2lHZGdZQkl0?=
 =?utf-8?B?OVZFTnkzUHIzOEc5MUhqSkVnNzlhRjhEQXl6d3FNd1BOZXdDeXFpTkJ0Q3ZY?=
 =?utf-8?B?LzAyeGJXeVE1N0xWRWlHaHo2b3hwN2V6Y3YvTG1PWmhnekR6ZTF3LzMyVTJx?=
 =?utf-8?B?M1JVRFdvSVAwamZTNW80OCtsTXhvK1hjS2ZpRS84OWUyZ0tnY2FkcUxwcWMz?=
 =?utf-8?B?UVZneHcrTUdLRTIxZDZNZ3BpKzlZeTBwdlZNbWd1b2RjS0FsQ1BNTlpQalVZ?=
 =?utf-8?B?YmtSVm01THdRazNOZ3haTUY5M0ZDbjlhRk9TN1hWQWVYa2tVTzIyQnBvdG9v?=
 =?utf-8?B?N25ENEpNOEhvZFBsVWNHb3JmK2tPdkduWllpWXE2bGRJSE5JMlNYMGgyckp2?=
 =?utf-8?B?VUpWSHQrSEtCKytXb29vaUJPamtGbEk2aEVXYUM0M0RadGNWY1d5MEdjbDJK?=
 =?utf-8?B?aUR6V21FbjhPWnJUTmFIVWhvQjRvN0F4ZWVJSm9rTGtlVFlsbkpuWFdQYm1K?=
 =?utf-8?B?V01hTVhlNlh3c2FvNnJWYldZcjN0MnB6LzV4MGtoUVdPbkFjancvWmt1dkpL?=
 =?utf-8?B?RmVvV1FsMFB5RzF2SDJ3ZUFkSFlONkpObU90RTlwMk9JOW8rc1h0V2lNTFRN?=
 =?utf-8?B?cG1JNHBKV2tBeFI1cXNPTWx6VW1JdHBoMEE2QTJEWEFndXRhNjJoL09ZUE1G?=
 =?utf-8?B?ZVkzOWR4VGc2ay9oeEF4a3hycWQ2UXJwelk3VDNmanpzOTlHa21iNzgxY2Js?=
 =?utf-8?B?VFpjV3IxL3lrZUFPdHFXaURib05nWFA0Z2lTTzEveS90VTJRKzgrbGlOZXB3?=
 =?utf-8?B?RE5yencvTEdrWTVhbDRsN0dac1ByTm5xTithQ2RxRmRiYzJEeUF1VEUza3F5?=
 =?utf-8?B?ZVp1azRWbGxkMFpBSTl6WG14NmtDU3dCVkQyTmJVZFhYVGNrMGhuSy9UcG9m?=
 =?utf-8?B?RE5FRXkvM3J1SUdpclFXdzJyQzlaU01YbkF5TCs4eDVQV2p6Skt5dVZBUHNZ?=
 =?utf-8?B?ZE84MXhGWmlQSGhEQ0M1aVh3ekdOUkRwVko3ems5OE1KSVZzMGRjVE9OSnBP?=
 =?utf-8?B?VjhGTmRXczcvK0s0VDNvQXpTcjBKUFRTYzUxQnUrRk1DLzFCMk1LRm5wOVN4?=
 =?utf-8?B?TnBJMTl4Y2wrM1RzVGlYZFNKaU9nd0RBbTVZK2hid0h4d1ROVTFoaXVqYmtR?=
 =?utf-8?B?OHhUL3c2S21jd3Z3engzOUNZbE03d0pDS3dKQys0R01OUjR5Tnd6Vjk3WlJs?=
 =?utf-8?B?MWtYRlRiUnhYZUt2T3FKL2phS0hEM0k0eVArOHoxL0pudVZkaSttazA2NFZ4?=
 =?utf-8?B?Q1lnNGhsTjduSXY0eGdWRzVUNUpTOFY5OWQ0U2t3SExhMzV6alVwKzQraXVv?=
 =?utf-8?B?ZkUvTW02ekxucDhMeGtpbzZkblZ1MUduMEt6aFBYcWRsMUtweUhLOVFQOFNP?=
 =?utf-8?B?RXJxK2ZwSDNLUlZHbXRrMkNtaHlQQXJ4dnRTaWhTQm5HL2lRTzE3QWRRTXB1?=
 =?utf-8?B?VnFoRVVVSUN4RWt1L3EyYWM5eUloWTEyOUdpWGNDMDNHS3N3a01RWjMreWZt?=
 =?utf-8?B?K0xyYWZDLzROSFFvTFh3czlWTmc2WGpyTGlzSTAvSlc4WTU5ZTBITHZYcXlO?=
 =?utf-8?B?WElDWHFMc1hFKzI1UVQrR2o1NHVOaUc0eElkSHR1eTdYQnM5cytReHRRRTRu?=
 =?utf-8?B?OVo2YS9aMEUwUml0aFB2YUNNSXdkRTBlRXQybE94SmNQeHU2ZXMvVnJqVFFp?=
 =?utf-8?B?RUpHaTFpcDU0Sk1NTWR5SnhIc3RRc1FXK2RPYUR5dWYzV3RPVWRaQ25oUEp5?=
 =?utf-8?B?blFMOTQ2ZUErSFp1VGdpV1QrQ3FxSnNiWnc4cGZHdmovTDdUeUxzV0dIemI4?=
 =?utf-8?B?ODJzZjBSMVpiakd5T3NEMzFtYlpBdFRNZE96eXdvOUVyYkZYc0J4TGpqUmxn?=
 =?utf-8?B?dkNBSGplUStSK0ZPdTNWem1YSTJ2MzZ1Uzg4WWNpOFBmQktRdjdJcWpNdDdV?=
 =?utf-8?Q?CxjV1CglKqyhoxIr0MkTVTc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+1cNRni+HtiHaS6OmKgVSDBZkhBOx7+9awAqN+AAcwbYerr7HbhlDndpNrQDCgNPF8BWuONN01o99kzeGJeLVWA+83b7s9pRp6Rw/DYOq5aYorcvPAPp3gY2ETJlC+6T7vlmIpArmtx6FI61e6vwuFEK1GMg4kEhRbTcJ/SEPrYwTER0u/jgR7aIu/OAU+8Zg4c07pu0tFSCwa4ob4096TNLT0BCigIyb6CPOS/mES4n1A1SX30hoakqi39DXOAFfNwEsYr5D0AEMBbD3WazsSV/D8hs7HMgmpRhp48ebTHUlqWQh1NOlP4vVcO7wl0NXWNEqlih7T0hjl15MhcxKBdN1NbDZUVFCCDQFzCgUabBZGyHXIv4vyWKercLUskElFPAPp6q77PaOCCtBfjGsxf+PRdt/9JVhtt6eL/qznKUeafc+0Kl1P7UOO4qtqWL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:32:20.0962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d7b127-a0f6-4745-6908-08de65b671e1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8153

Hello Miquel,

On 06/02/26 00:36, Miquel Raynal wrote:
> For his PHY tuning series on the Cadence QSPI controller embedded in TI
> SoCs, Santhosh needs to access the availability of the DQS (data strobe)
> signal. This is a chip dependent capability, which may sometimes be
> enabled.
> 
> Create a SPI memory flag for it, let the SPI NAND core set this flag
> when it knows about the capability, and show how to use it from a SPI
> controller driver.
> 
> This is an alternative at needing a DT property. Please note that there
> are a few blind spots:
> - the line may not be wired (this would be surprising, but can be
>    flagged this time by a DT property)
> - manufacturer drivers must enable the feature if it is
>    available (especially for high speed DTR modes)
> - this implementation is proposed for SPI NANDs only, if this proposal
>    is accepted the same approach must be taken in SPI NOR.

Thank you for the series!

As mentioned in the tuning series, in addition to the flash advertising
its DQS capability, we also need a DT property to describe whether DQS
is physically connected to the controller. This can be represented using
either a "dqs-wired" or "dqs-not-wired" property; the exact naming can
be chosen based on the majority case.

With this series, the controller will enable or disable DQS by logically
AND-ing both pieces of information.

Regards,
Santhosh.

> 
> Here is the original thread which lead to this series:
> https://lore.kernel.org/linux-spi/87v7gbdwdh.fsf@bootlin.com/T/#ma79fc364d7b882a48dbdf47203dde75df4bb0ec4
> 
> This series was compile tested only at this stage. As DDR tuning does
> not yet work on my board, I cannot make sure this change has a real
> impact.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Miquel Raynal (4):
>        spi: spi-mem: Flag DQS capability
>        mtd: spi-nand: Set the DQS spi-mem capability if available
>        mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series
>        [DO NOT MERGE] spi: cadence-qspi: Retrieve DQS capability using the core helper
> 
>   drivers/mtd/nand/spi/core.c       |  4 ++++
>   drivers/mtd/nand/spi/winbond.c    |  8 ++++----
>   drivers/spi/spi-cadence-quadspi.c |  8 ++++++--
>   drivers/spi/spi-mem.c             | 32 ++++++++++++++++++++++++++++++++
>   include/linux/mtd/spinand.h       |  1 +
>   include/linux/spi/spi-mem.h       |  4 ++++
>   6 files changed, 51 insertions(+), 6 deletions(-)
> ---
> base-commit: c5884449d02575c7984000eb30d2a2971c7dfcc7
> change-id: 20260205-winbond-nand-next-phy-tuning-aabefc018032
> 
> Best regards,

