Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AE46AEE0;
	Thu, 23 Jul 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804655; cv=fail; b=VjGSweHSL0X3onqkg9UNxSPi2XBUkbWZeq36bbrR3DcqdzgmYed/6BzoFaiWBs+oW4888HUV5f7owq0WN0F6EB2qy4gN2Q3FpsWgHdY4xK8TxNMl8HHou7B+EAaXgHF4DRiw+7ZBQ8IPgidQVrfq475hso3zONAVUhTefytw3e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804655; c=relaxed/simple;
	bh=klTCINip5Cd5Q6sQw9ppFW49YqgxdSsn8/+OTbEeEkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhhVTIZehCM3c/ZiNXohn1nDoYqtlGaYTABdzQCK5uT/FH7YJ2jL3jaPZ2RaQlM0RETktXBEcJoJCJOOh2EHT+Usdqf2LLaL1LhT64CXYr2H2SRiLeLOmZT1rJo3CmydlS5Z/9mSYv63LEHXOFtPuW6HvFLNUAII0sSFF/YF1+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=D6TLqKYl; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CIf0LHBH; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="D6TLqKYl";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CIf0LHBH"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MG9H4111037;
	Thu, 23 Jul 2026 06:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDms
	sQ=; b=D6TLqKYld2hzLZgYkXGJXibTfNYjn119JRUY+A2Ug2vbKof+cNB2tom9K
	9CHhCuw+whrcfkz8kjI6ORGo2KowXBk7/+Vas66c/hXoNic8BtXSXlHaZCCrm0TI
	6n3ZRvLdVQ9KL/CiySMDTnbJ/f6Ez8SDHYG8KolLcRKkLzJYWiU+yBcbAuRDs1R9
	Dk/FMkiagHIPk1FT7FmqjzR0XpnnY8/LJBpvFJzoZuUVAUWu3UtuOuDuau8ntjNx
	hdtxovHj28KmvYr56RLU2tCKFyB5PbUprApshWVm98YcAO0Ex6vySfoY1NY+h5Y6
	xmWAfbzmEHk7tAEd528KIIkYV0keg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908cxx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvdzLQXVqdx9nVUaksjITD/L66y5Y9aMYd7UXQdpNmGGpFqiwjLnpOs1MUMQdnTVOgKUNhN+yxfbuAf10nq7nxdTC9cLvU8SqzCwZ1uQKyVW7lV2duGJ2J2kb0NklECQhnKGZEIbTca8avDXD/93lLMkimAY0t1KmI0tbvD0Kz8ETNiI17PHnGuTQf12hUfczwvQUIHbRrS66WuULpcDh6vSB4pIQ76SEZuYaBhItnmN+c16M6Uo4hIEh6QWBe2YOSJPQ/tTUwSzX/n1P6ce/jlJO6YpO7C0PosSALtUK5WOOKA3iksJRXMG6yRjypv87pQqIMKuUQAylLnW3XtvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDmssQ=;
 b=pye3W8mkUHrNoBoA8qxPBCfGS6xuasCY/CCgm9ezdFNMFa/W5JIXS+PdpM57PEqgSD7QDcsvpjCnVaC22uC7lM/VjUxrktgKFk1N3dKvefmMoaGRBqDTmt15+VXqnGeyw97aWD1Cuh50VGJ7I5a92l5NBLfbNQe7DpOE8bqPayoK6m46BXdMpfysnMz18qczHFUNe+iTwFkmNAvv5tnW6sQGHM9e+oIwyNty1jlEaKO6Tfx2mxVJpP2LKS0tg4x9wlvlHaWJqnsJHYYQOVlZnE9qLmMeS1gnY1cUbdRWjTotdLatK4kCBElKT/iQSR3LGnz0h768MHj53xkLTWe3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDmssQ=;
 b=CIf0LHBHHHAemzqDvQYyoBJmSU/NJ5maJrmAY5SQNuK8KYlmqfv6I57sL/Oi4l9A/V7x5n0nPrxoZ2TpOOosvFkPYY87p9TGvrE2fV1T0hOmpSCoVRz9Oi6LzQEVn3hUHD3HRyq/xijpbRsVVd5eCgmgWPkgLR0OX4SoFb4jG5E=
Received: from BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::14)
 by MN6PR10MB8118.namprd10.prod.outlook.com (2603:10b6:208:4fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:03:54 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:59e:cafe::30) by BY1P220CA0045.outlook.office365.com
 (2603:10b6:a03:59e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:53 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:52 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:52 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OWB1577597;
	Thu, 23 Jul 2026 06:03:47 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 15/17] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Thu, 23 Jul 2026 16:32:17 +0530
Message-ID: <20260723110219.3180747-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|MN6PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a0dbf3-78c7-44c5-3360-08dee8aa1562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|23010399003|10067099003|6133799003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	YKaSK2/fw86h2MqPFgTHT4M71FCeSNmnRhmXq91s+nYQ01QLdw7ZCuW5xxo0CXluWiwVa8/FyhzT/YuivQXKn5uzfyvNGzAj4cLLirdWCMwsVgO3sF81l84nJnExFJGYnEBMhX2Eifs5H+4/7WmWvUc2/0Je+0E8qUkRl0xAY+rL5ApCJ6IdUZRGPP5QuB7HfvQc87fTftfkW2Ucwnhjmk0fkli0JY9EHshcwZfD0hXxkbqpf3aKEOMt6YyksdzlrVVFDVFwyHPfhQmWzXtZJG9IFQj9PSTAQTCWaDGq/VIRkW4bJOWv6pb7wrGx3uBuAwIr/GY6YBJo/nhwGp2Mxcy9WkaFDvn3xgxj++x6+uMdD3YNZoiW4HSGsE9tL4x9mxg0J3+LmIMKhbeskLEDPD00uz2zAacObUgmxnAAtDh0/a2HHkb8vZ6x3lPHdsDEhom49mWrUXCRYDIVOhZtgCCZBpVdsR0kD7WD0Y/sFoyApAHBi1GuT96H3xwtPU4UfrhGqj/4Z6AwbVp53ppeioqcKFXfWGnQgvrWfPSgj2DpLJ7+XPQrEoMIeNcXBh3GwgDRrfQQIv737U1zqAE2ELl7jS4A6lV9AFvFpM8rpCZ1ApFoi5KWCS54G4UbPLhYMlqUpCA1aLE/JlSQOS2+HxL/WJ6YnzW8tWRc+VHkZASa+Ophlgb5zoM/XIeCseylBA1Me3GsDdBNWlBew9+aoZlmaBVwJFZ2eeTZLy/SFpBrPEv2byeVtAWbluJWR+x+
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(23010399003)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y4+zCMmTqWEVmHooQaTVQepYEe+9abybIkMo7OAAaXLRv1X6C5DD4pJ/4wDXNKOiscjct8qdtH33zqkGJRTEyE+8NjCJbsE1ZZ/aPDc+YaNSTuZxucCfSQ4lpwuB8PX0JXZA9AqnwqHs9HtYm6qeR9AArUWhFv7NeHrytAOQTzYzQ7w7nkQmCUS+0a9uPJNYDjZQT79N1BZCYgBXfJyKO0Bbs7fBJoSX3TL/Vq0wSQnjr9EjtMJTL8m+BQUiGityPD809fabo0252f6EmPSV+Z/2neNXZ+jVBhMQQDWAp26iFYYBq5wvBE68G7YRORSX8GLOQMcW8rmnoqpNobtZcYzZY0/TFmGqqv228JJph53IUB0YEukL/A6GF5+QR8OWPX/zxHtoo7m8ZqgkwwwfOISSSCUyZDbVUyaHNJ9n+WlWAWdcKJRYhmcS1v5tsgIc
X-Exchange-RoutingPolicyChecked:
	kRswZQQNUCRR6ZY86iDpcvwswSvseg2z6CQE1j9Li8NdY23cQwHCMaguCUpzPNV9CnkKn/dG50T7kwREmb4N7OExrXyPeBrBKVLEwSx1bt73KFwZuFDnq908tcQfkbX46KFs4hhoy427D5K25JezImbwSJ1WrBlPiX+eDJP6X6XSr2PV1SRJuQ2MTY2kWykGYTEawAK+m3bS5tgy61SscVIAo9GHiP/5MelCTeNyNTwKbIU338u/9ayRQi3v4hZQKg+KNX8+FowlJgXXiUdi/ULUutTze33ug1ZnxyVkgSKCuJILf6X0pKWEwRZqP+F6AldxXb5h04XNp2728U7syw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:53.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a0dbf3-78c7-44c5-3360-08dee8aa1562
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXyxNF0YXcl+PZ
 HBKw9jFdPCVUwL6fSIwzhlNpRToiiCyWbkVyAlWRe0UxY/FhgYGJVNK+7AyLo2+Vl5AvtdgSnzW
 9LCcdF8qZgvFTHAR32O/JyhYAKBlUPLjSBvW/sz0jR0zsyS8F82ivfCRqDJoEit84JoTx30q4ir
 s1abPw94taPUig61gJRCIaqDBjnZF4X+eIfwxMeUOVGMixbHcDKHq9SljKuggtjEvHd5IlirLT1
 tccIsPrFMZYHRBCcXbjMUzdFjfBiP8nW61DaPc06n8IhO4OP9eIqZn5XRtJ+MImnBC7rq5wjIUs
 7Fp8WSoWmJjT1DK4iSv+OTQL65f1P+maetDKSVUMvh9vLirgNtIY5xI81we/6KHka1m+hqKP43j
 xFw7a1gYm/G3uhNxR0CKxPAkaegV/O0c74D1Cc4xyqPv4dv9wSqVDkqtIPbdgW1eUKG81vXAdF6
 scC7VQ4FXMC6NluqPyg==
X-Proofpoint-ORIG-GUID: he9Jg7myGknCTrgjVKwnK-STt4amHQHJ
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f51e cx=c_pps
 a=7Di9vct5tcmjM1itADynpg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=U5cn0f2nyUSNena3quMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX9u/XHEn9TwDe
 Fy/r4DDdVk+7A8FQFUtWFkh7V59FheD9s+e7fICnSF4im4AswcNF3Hc5nBNAuBp8Cr31KCCCsFE
 zeL2Q8QEky38FofkHUtJzysQne6ofnY=
X-Proofpoint-GUID: he9Jg7myGknCTrgjVKwnK-STt4amHQHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Dirmap descriptors encode the op template including the operating
frequency at creation time, so controller optimization must complete
before dirmaps are created to ensure the validated frequency is
embedded in the descriptors from the start.

Move dirmap creation from spinand_init() to spinand_probe(), after a
new spinand_optimize_controller() call that negotiates the best
available operating point. spinand_optimize_controller() tries the
pre-selected variant first. If the controller signals that optimization
is not applicable for that op, spinand_try_ranked_variant() iterates
remaining variants in performance order — ODTR variants first, then
SSDR variants after switching the bus interface if needed. On full
failure the device falls back to the best available non-optimized mode.

Add spinand_reset_max_freq_ops() to copy op templates with max_freq
zeroed before each execute_tuning call, enforcing the invariant that a
non-zero max_freq only results from a successful operation.

Optimization failure is never fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 206 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  11 ++
 2 files changed, 208 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7c3341f1fca0..b79d06d9ddaf 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1284,6 +1284,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1295,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1745,6 +1748,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache)
+			spinand->all_read_variants = info->op_variants.read_cache;
+
 		return 0;
 	}
 
@@ -1923,7 +1937,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2015,14 +2028,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2051,6 +2056,175 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			if (iface == ODTR)
+				spinand->odtr_op_templates.read_cache = best;
+			else
+				spinand->ssdr_op_templates.read_cache = best;
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/*
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/* Only ODTR variants were candidates in Pass 1; SSDR bits are clear. */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask))
+		return;
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2073,6 +2247,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5f4c00ae72a7..7eacda949719 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -792,8 +792,19 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_optimize_controller() for ranked
+	 * fallback when the pre-selected variant cannot be controller-optimized.
+	 */
+	const struct spinand_op_variants *all_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	/* Persistent op templates updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

