Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B837A832;
	Thu, 16 Jul 2026 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181525; cv=fail; b=Nwk/NyuvyMlYGbn4TAMKO6nl/tENUpjyjIWyfhmyWE1k7IX+3wDMRX+lShB4dugFZmoGe4DfcUCcLa5/33KGZtzHeMV0PR1w1rKpVm/Bru5oZDpKnxCdkxu3l6dkBxZvvpeaQSHzJZ315LfI5OknLMADx5aH04Yv+SZa+MvmBt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181525; c=relaxed/simple;
	bh=Gi5PU04g749qJEan0M7sBUIBRxKW+ZcW3ETSQ3mTbJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sk0HMohfkPv5bIghUL3XSgx+h+mivqZdHRsNgA0boo/zP+5mV0Tn2bqxGsJpj+40tnHWm033Y2ezr/g6xxjqecdSOgxb9y5+98nnmY8zcli3hwU1WiJnHEMOeRIJySdLfPxmGdOSAF79N99X42gAIkCNgGCXF3w6PG7o5+QTXe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=k8UwSZPW; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tuCundhK; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="k8UwSZPW";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tuCundhK"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G3tqp91239457;
	Thu, 16 Jul 2026 00:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=KYWJfzr/yaA+qJslagbaBne0B2ECpfVHzdhut9VNi
	zo=; b=k8UwSZPW9Jxs+By5DG0Nn14i7kRf46JSwhL2b8unSHQ/InRueaiqzEd53
	8bvWZ6H75QLI2C+kqWa65mcsmD9f24k0huV8M2prF5l9lC2ovKhCU8a18rBB6QEJ
	2p/s+aTgSHMz/fEQo3op01gLbDuZjznfLn9U4BP6ygz66oCfsm2tI14Voqhk81Q8
	rAmpd6snF+zndAdQ4GHtA4065b/kBnOuLZYDUsoLOPnkALzQmFf6cj0qGTvzA+N+
	ZTTt2TeePuOp3vN99LMkP0IW75GEHPwiQxe04S9wpVmtoFW5B3KHTrRKc7XdWE44
	KASHyTMenmXkRiUCK08WmV0PFKclA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fep5s903b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:58:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVcntuO6hZigfxCn9snIfhAN4glAn3KCvGu3ARTzhq+8c8xw3a174YHSLJ0DvMC6PkOfYEL9Uy7TkPFApj2aOZMW+tsSNwZjvZItmlZKwnjtVmQD9PrZrjrLFSUc4A3BQuM74hv6QxVaJh//jfFj2vGyHxw7kqtl9VOQGaqohMrkE3qk0jIfqSKVjyCdTI7PBBNYszFkKS6687apvmTekw5vtaT+QueIH0TpSvdMqoLoyck+YzgOHodVSrVz3XfZNVKBFLyGeFO9Rsqn9M3/ioOYdg820kZmo5eVyF1q5zr/BvvR/AwnXnJRoD/pinUpnn2QM6gEeIEFO7y5XMnFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYWJfzr/yaA+qJslagbaBne0B2ECpfVHzdhut9VNizo=;
 b=iR4+AukUEnFP6JSZUcnqmb/XtSi3DOeWNNZsSiirYBNTAaml4XuRyF/m9jUsX5ddru0PmqPBBDzEWr5qAkJfnVFGVQP9zIa0YWvskotRESe9zgNbveMYVnrMV0H+8PdUPvNcTd8xBYugFHH20tT4IrHbgn0hwtQeBhiHJw2CRPxf452vV+eQ3TYk2Z5yp2VTSsRIIU0ouG6sVO7iJztF4TUljlxYIvhnQMVxPLfGdkoYM1x6aDx6HG7SbpxSEIyN44R9GqUnUqCQbMX0pLNyjlNARMya+EJ8ZhSJwJY47imnrJCrhRhxBVHdySQh9h8EF0byhc9P64ynzUFk8CoY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYWJfzr/yaA+qJslagbaBne0B2ECpfVHzdhut9VNizo=;
 b=tuCundhKYf71hg3S1s+LnwWCa24tIkqXx/VpcoH2NFVv5aRNAZNrJGDBjSca1xL1zjjbY6jOBk9QsZnpsUSzdjTm31O2nisH1UJNt7fWS6w/6QgI+0j9L6SPhjEWa5s1Ty+5SHH2YYTPWqvq3bGpF3/lqSIhRRJnZUaVo2Nexuw=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by IA3PR10MB8299.namprd10.prod.outlook.com (2603:10b6:208:576::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 05:58:28 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::99) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 05:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 05:58:25 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:58:18 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:58:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 00:58:18 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G5wCpJ047928;
	Thu, 16 Jul 2026 00:58:13 -0500
Message-ID: <11c30eee-623c-448c-a9fc-9a10b7dafea7@ti.com>
Date: Thu, 16 Jul 2026 11:28:11 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] spi: cadence-quadspi: skip DDR PHY tuning for
 2-byte-address ops (i2383)
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-10-s-k6@ti.com> <871pdlqztf.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <871pdlqztf.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA3PR10MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: f515d409-1cfb-4521-0d2a-08dee2ff407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|36860700016|1800799024|13003099007|6133799003|10067099003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	1i6OTVXcyay0bF4jV8ixW3zuRic8iWkKlBsNhsN3GWOu1dsMnTtO64PXuSvzgeN01mfZP5VjjnfI80R+NT3VaC69cES86YmSXWeS9hefGnUngYPvA06smmdglbJBsVW0djztUHIsatHNXX1YHqt2q2R30VFHBdvmImHJ8ewI9GHwqns8yGlOMoCrK50z+PkHe8piUwJjBB7O5T0QIvosZI06r1pwxGA8dWpCCJd6dpP5/K6NBLhEYBL/vubIm2NxImVW9wF22iQHniVBEq1RXntAXpWtsKsrOIKYfsijEERh/Xm1MtSbpZdSBRczgXcJY2t1lpKs5UyV247TIdoUL6DX/ELlYKQzghSA5GxvaQTNYP3QpampGSp1CIiYoDsI8v6XIGmb8hcXqG347X3+m+7lz4yOZX3W7/Cssr5ZKgUC5u+ftztlF4NWXouKZMSUlZc9cixlkqLiD4WyR8fvvN2JIw8X3N4c2BD5GRuysHqBCaVdpBeQhgXhUlH98zVhgI9OoJMf6GH90Oo0QpyGTOTSFulF9SUby64TeqXhlrzJKBEwiaFitpnAut1AfiryrUxDZiplT3kYprK1FoWFnB93WRhPZXDyCYoUha8+JcSE1pFERSJTCac5+nqHvjOKOC7HSvZxagyHuIaGYHN/Tw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ynialzmfacikYN6bFYuZb8quR3ixZIaOTFSSCHDGNKlf5h6QU46ZHv/T4kGvPbZs4pOP765nLA0DZqUCoRNTtCHd30C4B8z7+m49iCGBVlhU5xKIQ5PkLwelT4Wxl0HGViuaqxl0/puyp0FDtmxUGhSzGvoZOblbWbY1KIfm03ME15c1vxxr5KiueyQ9KY6C//UOY+9C9XMk60vhbqJmuJysWo6qZfq0BqnEen5YYGNd/o6Vpvv4tPHwz0wQLN5b6SuWlQNYRLyukoevX73uKq08fhTstj0xip+LS3Pdvvs5GWHSs5FqEok5mQ1piSe4MTc6FkWjP+78WD3looimuwJt5weQH+FqRn5td/AcfFUakodQVGNF55FlM1EbuZO1G/zDehHU1t4S6wlJKw09L8Rx54sbbEXCM3dqyEhoH4HOM7uQ2wkvNNBCx3rfdya9
X-Exchange-RoutingPolicyChecked:
	rsr8fMxkzNrJ3gMEsQX/s1quOjcXeq0Zag2/gA/ZRIW2bQtvye2szYpBVF+H3ZZhH1dLXcFNeY1b4+nZcR2x1Mh4blidI9LzXRb43OBg8aWPu+CCXNTksfcFhISRIlngjqnu4veoOYkX/ol8kbtmvCdH4J4z4k6+gmpSQt1cpKaLRAaMPZPIk9NvnKkPt1fgn9+RJPUKJrNT3UnzC43+npjQOttVOiUAEfheofjPzoSpHDt4jTUpjmBnwvOmJRwhb/R+6fIJJLiV95iy+pkNXzaoGN8nvUE724kKbKaJLUXw/e5ImqGc2LqU5Xbtal0sl1uBqNNmgPdztBkOoFpyTg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:58:25.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f515d409-1cfb-4521-0d2a-08dee2ff407b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8299
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1OSBTYWx0ZWRfXzuxNX8IKX14G
 DzKmqNCY6nOG/UDRMAYRvIz0ek1xDdWXnH0SjDnNWi4Ra/wke11XOLjxZA3tdl/7gu0t9GBTvf8
 BmQ86wmUuIvMoJzygejy4kUV+BfmlSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1OSBTYWx0ZWRfX67JjFnzxsMPB
 DTb3eMhTFaxsiykOAbWma1SR+EZoCQqmNK7s6U6BTq0QFAxx3DQESyw3VNWqgMzqaxWcfibRtF+
 GgofJlaCZVBhjD64m1vN9TqIt9yhKVBPPVKSAq7NmqnaTDlbMMGq4SY5BwLpDwnPl4kYZcKGdAj
 k2mr6NWVTyj7vTgL04GI33eBu0Ill0WNfh6IBe9/A7LUdv9dTlKY+hDMeJAn0BnGrlVlLj3T6xf
 LRX8iuQy2dRRUdMt2PsJH9bbgefmHKJIfn1DB8M85c1D4kGYs2mLR3UJ7D7NjizshEhLoRd+t2B
 NNutfp5OJL/nrklnHLhmXZsp7FWUAgQu0sPqpZiejUh5q5TGq8DkdNIgc8BA9FTGGqrpdw6oCso
 UYQuzTwEUmbR77oBP/zrmcFHQ0/i2rzLxU/BXQXnI+E0j3ElcJs3hgiXIA1NRh4AeWHLqirdMuf
 f14QHpNQfyJyu5hGFmg==
X-Authority-Analysis: v=2.4 cv=Zrjd7d7G c=1 sm=1 tr=0 ts=6a587307 cx=c_pps
 a=TqpEWdQu6X+pWU0GeT7YGQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=9DmQmDZJl0solZ4cBQMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tl5E6lkODLSTLQDMqIn946jX7rHsGsxg
X-Proofpoint-ORIG-GUID: tl5E6lkODLSTLQDMqIn946jX7rHsGsxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160059

Hello Miquel,

Apologies for the delayed response.

On 02/07/26 19:05, Miquel Raynal wrote:
> On 18/06/2026 at 13:07:18 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
>> 2-byte column address is used. DDR PHY tuning must not be attempted for
>> such operations; non-PHY DDR usage is unaffected. [0]
>>
>> Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and check it in
>> cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
>> with read_op->max_freq cleared.
>>
>> [0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 72768292a32b..22df5f3bdb96 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
>>   #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
>>   #define CQSPI_NO_INDIRECT_MODE		BIT(11)
>>   #define CQSPI_HAS_WR_PROTECT		BIT(12)
>> +#define CQSPI_NO_2BYTE_ADDR_PHY_DDR	BIT(13)
> 
> Can we rename the flag to make it more readable? I would propose:
> 
> #define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
> 
> Long, but more self explanatory.

Yeah, it is lengthy but I agree on your self-explanatory point. I'll
have it renamed in v5.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

