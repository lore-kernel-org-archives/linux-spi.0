Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77B3438A6;
	Thu, 16 Jul 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184285; cv=fail; b=pLckkc5g+UGHFjLWteBc8Uxl7wbKrRRLhH9lG3aTqu/JOCXXEVeyWVBtB/0VzuRN4ThyEo8p0J0l4TS4SRT3v8Bz9YTper/rBGbCFc3OHv3ZlV61Lb/auUA7Y7mAy6/ZfiL0y1d433rOsbtFtkZ96t/GYmlT/zrLnGMsYxZJJcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184285; c=relaxed/simple;
	bh=sQilxfVTcfYU2zn6uHQMxtCzqrWl4P5YYJjlGvrzHiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WQGXv/m7yQq8crOrwk8u2sBlwnh3K2pOa1ixphGyBsPpWw5rXe6Qn96MUiHJhOllpnsarjPKvrOSc4t/m6YzxaQTFpDNlfHJufM+AOY4o8rCR2BFoe5euS+61n0HTe8ppVUYyK10Ov60SHR9SCnOuh1AlL19MCzhQALGgY+nEYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EjYzPhk+; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VJQVH5r5; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EjYzPhk+";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VJQVH5r5"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G3tx8U2797675;
	Thu, 16 Jul 2026 00:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=8lLRXDFrKPBkXOyRfXJr57/WO+aPI/xF9VEmJAuu9
	0w=; b=EjYzPhk+CJz47U20/+eaxfpWltfhXqaP8CpDCsws5JAdZHYkLs5x0NN9W
	Pncv/nQBFMkC/BauvRn8cneqonqct8+EzTxevSOkixMigpOwGC+yHDNRHUX8d+0B
	YvwFmMISXWvQztF/kP8148GHL0Ex/0cHH66Xf7MfVRCuX43qpERHZIVtcMiKljEP
	qp61EdPcU0c5tq1xn9HmfQINdpGwRTHonkhOkbHThVNg0vchCbpIjecn4RqCuqf9
	bYwuzjDHhWxJoPv6n79SPVZmAOqqYEEUjJutERIRTgzMf64PIDMrgweDC4RqRPtn
	qlkeiozCasXAukqE7nOzrbOqv+FZQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fe96hntwh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:53:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHhFBuob4uXP8pbfdTebKP3QkK3qCW03w1gBS5hXXdTum3tULLPhnisggRbK88sZ9bnjUli7sQbg+Y0Z0eiC2Md/kcS9hZCixs5wayBxBgAqxWmbs34KL0FK8pWuUju+n9YhNE9dIg6EAKxjAgLBA1+QiDy4nYD7d+1cGStFp5COLURfMqPukwNsNuWpAF9YT2h5k+PzB7rZK/Z94Z/FS48VywNIJ435UUMmb2RA9X6k8LqVraiCvjcYDF/ncCXytL0PTjP1gLmNkW8be8lQAnUGCMKpHN8x1WmDVntBvnKjzLqBHXnOSqcD/f18Ekid0KQJLThLFui3W8xMAwSTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lLRXDFrKPBkXOyRfXJr57/WO+aPI/xF9VEmJAuu90w=;
 b=RAwtSFLBNl7Alf7BGHk9wCltJHrqSX0SAzy0zXbYskY3Bw+EoX26PZUGO9nj24J3Crt5pFnShnAfAL/Ctmh8uf+jK5tFEl1HPzUF1wb3GAMrIlP4+VpFzpGruHWRjknivJtWnSGagj+X+xN827S9q5vP4fYvILjSyTV5318HSQyzz+MPbt3XViUUPTb04SIbINdc0qesV/JnDHryDTKp+uBmDcL7FsbPIo1H24A9ITdzek3fazXV0xWQpWkzGs9qOXMtSH+ciUYuJ/MPGXRY1aLFrRdzibJBHlxfAEZ7rgNhLZY1uWL4/uOXAoA14SkG0kHJyPQLXU7fBxPR4H6R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lLRXDFrKPBkXOyRfXJr57/WO+aPI/xF9VEmJAuu90w=;
 b=VJQVH5r5PNQTDK0CfqWqqdSjcBoTjInJAQV4Hf02Cs6rtN04HjvcJW8bpUIHlJxbhPV/PIBZ9H1rwixeZIQl91yvb44Bhn9RI69uNvv5T9LjL527SIMjtWM1DCE+CKYQVMGF/rasEEVpZjdz4Wsvu13pPVbrhPBhoKxbn6wm9h8=
Received: from BY1P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::6)
 by DS7PR10MB5022.namprd10.prod.outlook.com (2603:10b6:5:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:53:08 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:59e:cafe::7d) by BY1P220CA0048.outlook.office365.com
 (2603:10b6:a03:59e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 05:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Thu, 16 Jul 2026 05:53:06 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:53:06 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 00:53:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 00:53:06 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G5r0Y8628966;
	Thu, 16 Jul 2026 00:53:01 -0500
Message-ID: <350eb7e6-8845-4dba-a377-2c88792a3937@ti.com>
Date: Thu, 16 Jul 2026 11:22:59 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] spi: dt-bindings: add
 spi-max-post-config-frequency property
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <20260618073725.84733-2-s-k6@ti.com>
 <20260622-private-curly-fennec-7e1ad0@quoll> <87bjcts69t.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87bjcts69t.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DS7PR10MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7b2d09-5fc6-4bb9-1e20-08dee2fe8261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|13003099007|6133799003|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hy/yyCLfQz9gxUByt09n7clfDhjsJF8FJDaT1+U+fZUzCTkUxX46/W8iXUC+NtwknokcIOedOIx/u7KuBnWLoHdtskXPXySfkHH+sPR/RpweJHS/KiTvxQQ/8F/npANtsfH/4K2cu+nGiNy82vkOWFeVe1oEZZK/PbThlTWN5IjYfuDKsw+4+hLe3c97jq1qlSRnLgrJhI8CSPF/uTyT7N3rDUs/fYpigIUY2rF55ZFB7F5RMBkOgiRyLrkvB1v72AZFJzrntogf2014xEwyyF+YhLjX+HtSZqucA3Mp/zIqTdJ26cpSyCKXiRsyEgQ4iODrEtMy6c6TYExm7KOhpahWFt2aLgzvXhxApqiGM+NGbJVUwabqWp4xRb8bic8wuy1PfN04epFyTfIQAGd55YF7wZjF3wDQ4p3hBB1kmPnjIQLZHPa5em6IAUUTo5wxOQCljOwSVE9SLXujvEoDf9eeGHFUZlZ8QzyacHO7VnOlBc9W0+aYYQhaqbSL2F/FndCeYGaFHv1bO1JNqWyAzXiot5vUrtvny6+qRedE8XElaMBqD4Li81AY0s/iEuUpyOvaDavA0L635omxtHErxqlIh30Ymb9Uy3eXFNfrLmkLD0YcfxOgDZbp3uVyFcCsHI8Q2VS6ILOv0KfXL6UXq2SOuaOvF75AgSxA04UppKXeFFDYANiRg6ezv3HOqEa/Zfb4XPc2faZC9dJEIst0rA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(13003099007)(6133799003)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	utcyKP1wUqlbske+XDXLnsoQ0u3JFz+KNocCk6NaObarpchV4YPTyefl+81+l41AVeJyopaT6dCglHazhjXSBZy+HhRsrIGZBP3+glVhlP0LbnMNEJBSvkLch8xG9m3TvhepCGea5DsbN/EngZcoItLgiFXIPI3Hyx+Pp0v1asp9MVOiqzIKvs7glf9824hDSbk6e+RSqlHDY4gA/vMMzZ7PdMz1Sq04mtFcfwIlxy1OiPaK2ycVIurbS5cnuTn5MANz7K+5MZGSJia2jM7aM2vIKtXI4OgDuAz4blqzjoKBDtVIT9WAObAGsb4bqLrAE+NqTaqgciw8nnlWaVP4TI3T7iqySqMYUZFk6piLJI1l3OXAg4vTPsle79mUK31ee3HqBpPUmLhMJVumfGaUXdPnC7VhXX7FhWMypqTv+kUO0hkWTv0dTl2CLSmaP7H/
X-Exchange-RoutingPolicyChecked:
	BLWmwNCWh2vLsteQUkwDBDTOjyyHC/7KoEkOr1lWD8oMHpcWub+YFcGENLIj24wH7burx+n03TAiee3ZVdu6RKcVxVkmo4kxxaecf7rRfuw9W4eQpOJhzb1wSqbe0q9b8Lh3hGzAm/8p7WFOo72S7jvUkGVInqjEEMjxcMdM4rqRI9WRdIs65E/ixiDEW5CwAfgQ/0HryoP2QOkumkIisQUr0r2zHuAxfz1JEgh15DXFjBmKw54zzo46TxFODKZ2xSV6NqdkfEuQPJRLkqw/Gmsg87sE6VLQgt80i6XfcbQICggp+83iU11Xo0r1XEvCNZ8DcA4bRgGGn6FK8Ib1jg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:53:06.8803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7b2d09-5fc6-4bb9-1e20-08dee2fe8261
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5022
X-Proofpoint-ORIG-GUID: 1TW1t8Erk7NOblg0gOdcExX-Q-7LEs7V
X-Authority-Analysis: v=2.4 cv=Zfwt8MVA c=1 sm=1 tr=0 ts=6a5871c7 cx=c_pps
 a=zwUidnFXtIpczQ2t7519XA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=YG64nluAAAAA:20
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=tMuN0zyhxCScRQQC4vMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bn7x_FpfJtc3yKQXRW3z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 1TW1t8Erk7NOblg0gOdcExX-Q-7LEs7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1OCBTYWx0ZWRfXyk0gGIOHLuLs
 I7SmJne98Y2AlEKP+0Kh5TVSETVIdLTPVOJ9adSl+UqxfQekthsmrYHhAF9woykT1ydYnJW9nxk
 7JeTUnfJBedisKZD1uRfx0TQ6Zb2FUq8K0pABjdeKkHq1FfgGrhW5cdVinENmzkNGYvyF8nDCZI
 zG3dhLJMhvfSyfvgMlRg0d3HOxkb4FEUxDhRMX1D8FMqP/pMNsnFLl17IdkhrddFuardO4efE2e
 u4AxKBpel79m8/1xQ2Cc9VRlH3/TyjZKBHJrTznUQbTnTiClxXAe+kYQnhV9hr1aKW0qUFlTUqS
 6uTnQ0KW97NKHBu1yHSGXh0ZB86BI7Glv9ca1pVw/y5okwO8rF9mGik85LJ1VH+RUteCMDk9RtA
 ye8B0+1bZMWL+NpXLpgkd5AVljfNu0a+WPcX5nKZJlOh2k+jLZP3plx+vx6lzxTwPOj1QHkPyZ7
 5GaTx2Z8X5xgBqHFnVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1OCBTYWx0ZWRfX6LXSY5pG2oju
 fu6LvidRkwjYRtxkC0y7MrLbT8yBiwknCquxAo9jYXtOxDu1DuXojaRt8QBmhTlg9LDF17rcmSh
 npNtVejA97edhPB1O471ZEIyNfEs4/I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160058

Hello Krzysztof, Miquel and Conor,

Apologies for the delayed response.

On 29/06/26 21:11, Miquel Raynal wrote:
> On 22/06/2026 at 11:14:32 +02, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Thu, Jun 18, 2026 at 01:07:10PM +0530, Santhosh Kumar K wrote:
>>> Add spi-max-post-config-frequency, a generic uint32 property for SPI
>>> peripherals that support two distinct clock rates: a conservative rate
>>> always reachable without controller configuration, and a higher rate
>>> reachable only after controller-side configuration such as PHY tuning.
>>>
>>> When both properties are present, spi-max-frequency gives the
>>> conservative pre-configuration rate and spi-max-post-config-frequency
>>> gives the higher post-configuration target.
>>>
>>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>> ---
>>>   .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> index 880a9f624566..ece86f65930f 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>> @@ -45,6 +45,12 @@ properties:
>>>       description:
>>>         Maximum SPI clocking speed of the device in Hz.
>>>   
>>> +  spi-max-post-config-frequency:
>>
>> -hz
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>
>> and you need maxItems: 1.
>>
>> Now, please take time and think if this should not be an array instead
>> (maxItems: ...) to cover other possible cases, e.g. different tuning
>> levels? IOW, having single spi-max-frequency turned out to be
>> insufficient. You address that insufficiency with one more frequency,
>> but what if this is going to be insufficient next month as well?
> 
> It is actually a very good remark. I do not have existing needs in mind
> at the momet, but that does not mean there is none.
> 
> In SPI NAND we have per-operation maximum frequencies being defined in
> manufacturer drivers (you can check drivers/mtd/nand/spi/winbond.c)
> because when the speed increases, the number of dummy cycles shall be
> adapted accordingly. So we kind of handle the various frequency possibilities already
> (the property added by Santhosh setting an absolute maximum that cannot
> be crossed).
> 
> However, I do not think SPI NORs have something similar, and also one
> day we might have different tuning levels requiring different "maximum
> frequencies": we could imagine a first mode where tuning is very fast to
> configure and speed gains good, in competition with another mode where
> tuning makes transfers extremely fast but with an extra configuration
> penalty (this is pure sci-fi in my head at the moment).
> 
> It is hard to tell whether this wet finger guessing will realize any
> time soon. Maybe the safest approach is to go for an array, though. In
> that case, could we add a mandatory name to ease (future) parsing?
> Typically here, we might want to call it phy-delay-tuning or something
> like that (name to be discussed, because there is the risk to make to
> too controller specific).

I would prefer to keep it as a scalar for now, though we can revisit
this if a real use case comes up.

The property represents a single state. The device is either optimized
and runs at one post-config frequency, or it is not. Even if the tuning
procedure tries multiple operation variants, it always ends up selecting
a single operating frequency. I don't think there is any hardware today
that needs more than one value here.

If such hardware appears in future, we can extend this. That would
likely also require driver changes to parse multiple values, so I think
we can defer that until there is a concrete requirement.

For v5, I'll add the -hz suffix and maxItems: 1 as suggested.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

