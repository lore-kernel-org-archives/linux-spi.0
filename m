Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A854A7F7;
	Tue,  8 Sep 2026 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872841; cv=fail; b=U3Fws4ttvFjCafaV8KdeVvywPhA+cf3UVGp+GWGIf2EnMimokd9c74ZQ9B21XvAp0g7u9v09WeV0EZhctV5/O2At8tfpFeYwv8aGRpOlHHVvS7ZRDpMGRDM8m0rbHplnm//7R8uPaXB0Vmxy6wqPV+XXHtlbwYReMwXMD4vL5DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872841; c=relaxed/simple;
	bh=IWZW8H8HOwgmgLr/o6cJ3CJJkwpYcRDxXPIGW72poo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TnWvfPw+geujkW9k4GmzJNQx8ZhDkyMH9ICNFZhS2WS0bQ4bcKUlrlOr+eNlY0T4dQhaJtleNwMNEJ+xHIuQJFylap83/+QiADirjbgM4embqDsEN+EwBRFafRrPzhooJoPW10j+hAizyVGoYomj+I4dQCiVN5MKN0TqHXtdq/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NOSUL7OF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CLg1ZNQz; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NOSUL7OF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CLg1ZNQz"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Coq6S1605258;
	Tue, 8 Sep 2026 08:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=BTIEvYiFOjvuEdhRPLCPLhYQ5TrAjm0ROM1LqLNvW
	uQ=; b=NOSUL7OFGZ5JJS9mjLrNnY/vfgYrl9gP9eOAuXggBabom9YEWRBg+F9bC
	qE0LBhFF5a+Zc3FROaFCmBPhUs5UC0Diyfm6vA8yquo64Tm2u1Buz+SGC16QG9zM
	oXwHsBRQLz7bFJq04EW77rS6cCEyeQQ5f8tTZotrCLIqLuhjewWgru+XhrsFM2hC
	Cd8i2V3M+XO3i4XXc6gvk3NdiTWb3B5dW+vIhn+PM99jB6QNTbkFeONtXhbEPUYu
	NdoD1uHM+R6fRUhinYrxkyxEP5ve2SyduzQc556NDjwQwYKffOu0pFv9+CJ7XzLa
	t0FMdwboWw3lBJ/t6cqV/eRBkMuTg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gj940k3cr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:06:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evzsKren/8rSTtrz+UdZHpdisK371Vp457A02XJQAigIf96cDYKOIRtXp4p4LGVyQ9XjAzIOUh8Kk063YnTVrCMGdnQSEAv0cte0Pp+CxHgBlKCYlHIDBi/3c5NvRvYaV5tGLZ9Kwowv7LWWszlW1CtnW1vbZuUkFD474TlvSHbPt1Mf+SzGYlvyAV0H618K8tXWJytpzH/XSzohPljlP0G0DNN29zJUOME+5T7AhzQ9G8RdJMQgQJAMbNdDq6L6zPogHqgK7S7ncbumlAyuPsRtvlWCZqdMNTVnZbvxESnjPetniREFEcEPDr3p8l599AL2tQ7mSazNiavzh3ui9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTIEvYiFOjvuEdhRPLCPLhYQ5TrAjm0ROM1LqLNvWuQ=;
 b=v5IJRlxJ5JsmD0PzN6w618StD4pX34I41S/3UQMotHIMZ9gQsmM4XSKoHfXpP1VLpnvqWJpjO5D1UjDjqdcv4GkGiO9jkBRFOnDYjLXXC4gsiAgV9woVB+rq8vLPlrNDLXCtKUiV6oqu2zCIBx4rveSbXnoggF3UCBOthaE05F9UVpBmtzmkddx8hcgtVFjLoMfK0g3F4q5eJYBE9TUp2IXgwD8FDdvHV7LmRJAIKGGQPGgaxeIoP/zOPzKN8vjVJqy5QkvlTc5HSmHKu9qB6oQzuiIyLZfICY8V4FVyR1eY3PEfjTXxd2Wc0d4b85DTFrIWGWJrs+APH81h8dFVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTIEvYiFOjvuEdhRPLCPLhYQ5TrAjm0ROM1LqLNvWuQ=;
 b=CLg1ZNQzJg+nxJCWCj0rDs5RSeAMowoC9IdpXH9kQaSoY14s6kQeSdgLdcZdUFkei0HmGlM7POixiun5ZgCzuSYz9ynGmJXS854k0eOqO+tLkvm22/+2z63api5DYAaZADU+4bSXPlgYobYfSK5k0aMkQXDTAVqvxgc9Ii+qC68=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by MN2PR10MB4254.namprd10.prod.outlook.com (2603:10b6:208:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 13:06:19 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::69) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 13:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:06:17 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 08:05:24 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 08:05:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 08:05:24 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688D5IVx2503909;
	Tue, 8 Sep 2026 08:05:19 -0500
Message-ID: <f8eaff92-1bda-4c3b-9d3b-83a156b95615@ti.com>
Date: Tue, 8 Sep 2026 18:35:18 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <praneeth@ti.com>,
        <sebin.francis@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>,
        <s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
 <20260825171737.776052-9-s-k6@ti.com>
 <8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
 <ebf61988-9fe6-495b-b1e2-eaeba9f6b98f@ti.com> <875x0m7ns3.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <875x0m7ns3.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|MN2PR10MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0418d356-ae92-40c8-891d-08df0da9f85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|6133799003|4143699003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ESmFgwqCI2lKZqXYQk40Q9qSgKjL469J/v2e8K/b5gTNMFpW6yOEqYOx0jMvRfZJ5ThRfJlAYcabDN0hAGgHoU+Pdl9tx31FCiXx1pGgs8fvA01knP0pYNQQV25i7i9fSBn++Wlj7zn/0WjLQr3owM2cDOgNqvc6qJV1X+VAo8TXaxmAhIcPNSONyS1BOFpA2cIvx5X2yO3YJtRMhJLzhCzO17w0ExKJrkA8B3/sE1sOQZacfEfvIthu7o6NuMxwco4wzaPDamQYHeKHV+JMFN/2hJe7heUgEgulvPkWo/KEAwlnbYK4mll+L3ryQC5mw9knhhoxpZItoPlPhtk0JZocZvwunIjj9AtdWO2h8yib3NqOPLgUyhZLR7klvS/7dS7s0zM0cFkZEfLmUBri6OkoVEg//aRAIq9TDS1ktO/vGxRY1S2V13wx7ax3Ix03P0JJSTXaSSo4ds5eum0DMsB8krVr7Nu55IA4KNZs3LvfE3m937q4ahz+nmHDcce7fM6X1kNHXUzY1s8QUH1PPn7VtAuXOtzlBWvJOCaK8J88Z7nfyt7T1FkjNnqcy8pQIbYIqWuoODC/K9asIaYMnXCKd/+xBMjUDQmeIy8B+zljabuu7RyKuIm/JhntwmnF4MBzHusFD49iYD8bJDFGoyMrQeNiwT5/rlsgDvfFBAWXraK5t9zSD4LQVknye99YSTFcZhNNJ8K1Jpjx6peqCQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(4143699003)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y1PuW6FhcwFyTqZ/4YIenohF3bVLHo98I5c2ArNLJvZsTeX2GzMHgjWfw3z5I51ee4SX/S8W83j6kYUeNcPkL+nB6B/eufn82vmHAyMXiA4Ozlflz3b2J8UcCS0Tk/WvoxJNDaIrGtmIVE5P2i3YOEQQhwW988SpcAAOq4JyKq2vRAQmUQlgWBwXj/jAyvXpt4HmLMX2uK3pWg3285auE+ABo2vHEc7qgsTqGXsgfCOan+EaKp3rXcMYYYGIhdcdJCmBBvu3h4KjaCV6TmmIFSPXE+0eBX9JK0j451gF2p8GfzZlWw/9PccrRXjWv929jJXN/BDTvRSUqEEZ1UfM8RHHDo7xTBWmwKMvf3DZowYZVvzJXqxrEGM96FW5/l1pLFqYBWuccsnyanVVcx8M+siGfBratqYP6vyc9KwwKrnwSc3cXKoNRzzRcHaOxurO
X-Exchange-RoutingPolicyChecked:
	LqHlR9ZXvwiRqcbOZqRt43GE7vlitO4PKXFMt15FLylk7v/boesZrtD33sX1OGh75OTV0NVKJkLfTR9fyaNkYSdW8z1XVfBqijD3eQRsNS84k4EBkPO+0m555s4V53+66VpZ3HxFAiPk3FWtI0P7BQqHiIDk52sjGPTeWjdQjlKYh+DfLTUFrATk0naZ/8LD5RHiBvLXjl60lqDYrDEjX7rftGqjESXgZ6l8nLEKjiCbXV3Tn0NsTtfmcKvPQKr1SCvFBlZ0feJHc86LiKRUILKYVTDyg9FoRdBG8zq42hPumkXGszOL8Arvr3jYw9XqG7c8RQjIXFNwNmhHcfd08w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:06:17.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0418d356-ae92-40c8-891d-08df0da9f85a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4254
X-Proofpoint-ORIG-GUID: j8rHqAOXputn8xoFTD2kNhTcZWbapKHH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfX7xM2p3oESfx2
 e5A1s8fzXjOUz/Zk4BcSn0pVYdqqUI/Vbr0PoigCzHkgZyLNZqkUi1XJLsauaq8WHOMYy8do1AB
 tf58rpF4ewovE1t6rrfI14L0e0ATMJ25Fc7Oz4/fO76bExeDBfKanO8dYuxYi4DkPeK1O2j7pqi
 bxeTOAuvWfuLBAzUTj3t8oGaldscFFSu47ZOM2VxbIW2env4dU/epP07h4/sRsKFtOhq6jmpeUS
 NWxl8XThk3k++PzFNjXnt8Dco8pdRx55gPn7ex63P1In7D6A7ia5ywkjQerjxznMkuf/177E+cJ
 EBcWm3RDcXCJMZHa3+d0WrZC8Yit2jKtKYuM+rguZC3zqGxgXAzWZSal9MWudpLy5TB5WkCwn4a
 B4tsZZWrf8DuamD5qGT5wJ92tY61cKFhhvCw2s56H2K2rwXfQnsH+tjCcn0goY1b5HysnNKP/HW
 vSa/APJ5bjM2vq6+VjA==
X-Authority-Analysis: v=2.4 cv=UrNT8ewB c=1 sm=1 tr=0 ts=6aa0084d cx=c_pps
 a=wX+iSCk909IGAd/hxyKeOw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=maD12Jb3oiePTm2HS3MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j8rHqAOXputn8xoFTD2kNhTcZWbapKHH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0MCBTYWx0ZWRfX/ZZohfNtLxob
 ZKiULVpVzFG3jq5A+kOr1SDdXOWIx/tya9UPSnJ/yMO+vXV3M0VlNbjJc15+imECj63dHK04gJC
 N59RKNB0m/V889+E5UdociCzF6tWM64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080140

Hello Miquel,

On 03/09/26 13:46, Miquel Raynal wrote:
> Hi Santhosh,
> 
>> The DQS bit in CQSPI_REG_READCAPTURE is used for read data capture and
>> it's not consulted during writes.
> 
> In the end, how do you know you can expect a DQS signal during reads?
> Will that work if the chip does not enable it? I still do not understand
> how this can work.

The current implementation derives 'use_dqs' from the DTR flag in the
read_op rather than querying spi_mem_has_dqs().

For SPI NOR flashes, this works with the current SPI/MTD flow as the
device is switched to octal DTR mode before the execute_tuning() call.
The current NOR mode-switch implementations enable DTR and DQS
together, so by the time tuning callback runs, DTR on the read_op
reflects the active DTR and DQS mode. This is consistent across the
current octal-DTR NOR support.

For SPI NAND flashes, this series only supports SDR PHY mode, so DQS
is not involved in the NAND path.

The gap is that the NOR path relies on the implicit relationship
between DTR and DQS rather than tracking the DQS state through the
SPI-MEM API. I agree that checking spi_mem_has_dqs() would be the
proper approach and would also handle any future case where DTR and
DQS can be controlled independently. I'll address this gap in a
follow-up series.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

