Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8046AA70;
	Thu, 23 Jul 2026 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804651; cv=fail; b=mevZBeCpAmPTMlDQWJlHmvZcZWTuetTVx+Gq5SgEyDycb13dexdxOmn/dwo//89R764mHeIVYq5DDkI3vQ8xFuuP8Da2Grq5lNsWEJ9VxXDX5TOFFzm1JdfruQP/mMDTtl905/eO6YCkOj12EtRRifWWcZhuPR++UTdvc//FfHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804651; c=relaxed/simple;
	bh=EgPd8VbcyrS6pF5XRBydAegNzfoN1Y0GfOtUmoBoCs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbx6sDuFUPkw17XtPhv1vPi4gO0KeXMe8WMy9Hfanh3Hy8qLmHF3/9rCnfMOKVvNXdAMPXMDTN26JwnsuHhkv+jK04z2bZpYBik6jo5U5SSL84OEcR0dIyFVTYh8YxtAfKohpnvjX/vf1x1pIJ12kl9PS4Jsl+Ebcki2RzphsRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=C2+ACR1H; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q3+SeUPF; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="C2+ACR1H";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3+SeUPF"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9I8xf2039510;
	Thu, 23 Jul 2026 06:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhh
	gI=; b=C2+ACR1HmqPrG44R/asWF28ZQUD7vofV+gpIOn45umti96c/Kvywht087
	r3/QVSSljHUumzSDyLlc/UI4cLKHLbudVW2BG++UIRyw01CbCjrhGe0QcsmOh84H
	uu9JIF+fIoJ3GJiREIjegtgI0ARaSDTplcKrisqCQLVcFRpHRmnO/D9K5KauuIzn
	WWbhzSTnYn4zAki30Sd3lAolFRdNSBeQmPLFX8V/CCZN73cB4WYWO/ZWezjhU+oV
	X7XqcMDhbDTMCTOo4gh+b3ZeL80Scv5bvhfLFZ75i40VdIXu7WaLL6gUmiw7pFg3
	00DTnalTUeVTutf0aOTSbyw+fws+A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Teub6oWlF1p/MTVCv63nOy8q0DhSKmoWlO/JJySkKc3tQdkTLxyoeVBu4MxUHNZ95eai3unTjhnBKvMDUo27JCngxDbuPPvyGkMQgEnRerzm2LtWTle21WkqQACj/ugjlPAukSL0PEpFAEBpGaoWmr+aAp6d007pxozGpio5Ety2lWE0IrRzmlDiNwNBOpgVL5saNNqRCXxnNqk7AYlgC3nyxiZxGyzsT9Z9FuFjS0/SLXTuFX5LireI23kwfj+RRZbJBSZ0kpgmvxpvP5gD2AqWnyBR/cO1GXpDvixh71zz8eei9zYm5SiT+6GxYbgfr8kqOj6yzxxnFoYisWPISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=APhN+I7aA9edoxFGr9hy+9z736zhE8QGGQ/OWtMJ2FpVLkTcyg/bPpnOz1D5SbFBsDA7SnmwmwlV8Xfd+WeO5rJoeRyxx65xk4GNVIv3lGN//CvuA7yiK8KCKpMhMSyLp18P8JiziMPOmWaKxfdoYI79Vsfs3K3JW20eDkHuzo6Pc8LrIWIL0BWsa5PSBrMAWipOCuGZegNoXeNLpV8Qwuirz/SB5uwmNhR7LhUzpwm4/H/E/bemZm1nGxfSIx1j16PZd+Pgi7IsqkWkmEiZfkoYT1R2JiW3Xqlipu5VmrwoyJMTa0Ia2oG1lGh2VFBQNVblY3FNWEiaA+0Swgx2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=q3+SeUPF5ijqpDi5FsnEo2gGIXTkNVuyQIdtW2yKPABNOtg28JHD/J6VNwpKDIxudLcYMLJ1GUxoXR/8aW/oVqLrYv6V0SMwF+OK1qKgyKhU9SywtDOkjuLvodW/HonTdWL6sbPz/Xe3bVUcVZxXiJJ0Ak3KXrawbh7omfL1Zb0=
Received: from MW4P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::32)
 by DM3PPFEC98198CD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:03:48 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::6b) by MW4P222CA0027.outlook.office365.com
 (2603:10b6:303:114::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:47 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:47 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:47 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OWA1577597;
	Thu, 23 Jul 2026 06:03:42 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 14/17] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Thu, 23 Jul 2026 16:32:16 +0530
Message-ID: <20260723110219.3180747-15-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DM3PPFEC98198CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eae1107-ae3c-4e90-6263-08dee8aa1237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|3023799007|56012099006|18002099003|22082099003|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	72rmeUi7TL5/E7uGfSv9r/y4xl/1zxWLwUELqEbeJSpUI1hKTXc52IRuTcYwOmHt51eH3qfB+MFAwksqFvtCtKZYAE2z9IpVulwWXbSts4rLicQk0KcJLz2CPR+WmrmCyCVcZO1ftkD9yaWY2GtShVPL2iazEb5ubtmUNdV8p5HlYj0ag/xKJsZNPMn94t4pJYAqcoyOu2PqYUsDHUpNUcMuW33NdZ3PU/jZBrfgT9F0/akIb9tXOTLtdJmNcS5Z9o3WkSrGfrczRQlKtsUGh1PzjNoEiXZJA0EYINKY7Gk0kIc1kuqUEqF5WaZMNSXmkPWSVgrShON7V25ZDY6Df8/4YI1MO66yrzuaCwrNvYsU5ZAJBVuU41zXB0239g8xhF5KMScQW6l1hGq4zxfYI/GYG9LPqvYpwk85MLUFhip65FktFty7fyCmf5S5NXYdysHU/3WGcQgee99wcNzlU5hx7bC5yh6edRE5C0osVSX9CtFhaDDORiK6hHSnKa/4gpVii/FRRCg/nqM6oabAXpHMWl2EoWnVRfogWBhiQMADvRyxiZ5edYWnZBumiC4j9oDsV9Xe5iilB7zoRhu65kb2m3HkU1WtK5mA5aPYlUDRQmu5fNc/GFyBrq1gN1rML6YG69BCC9RNvlCPss+z0JpKfBmrcLfDDUZhS/0m+fgVplT85mbiTNmsBd/Pfa8bDr7JpujrCr8lxYZVGbTWNEnumm1OMIxQyuO+l5SByJ+q7nTn/rS9rkF790H3xpUE
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(3023799007)(56012099006)(18002099003)(22082099003)(921020)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wfj/WrzM8y9oYgIgYcTYT4Uwe3vTN0Nd8eRjrMNiXFs7LRAQd/Qesumu5+f8mbK/EGR9q/qw2TiDw86r6iLWaB1510wfoRTck9kFiiDkpeX/08eceA2jS3Wd7U3tnCkLfO/7eranbEL1rlLr9h8Beo64PCF+bbn8h6LgIhtql+bSChTLjSiZat1DOo0ng84FausP5a3ZaN1YyJbIGBqmn4oVWiB9PIkdRVRyvlbC97mJkFNILv1OYYQ96s8MASBCLBp3WH+GJnCqQbkHIU13WwovgOBxTm0K7IM24Qa9Vux74lwhVhhA1M6UO00Oge7i0iSbbaLJ2wmxb3SerCoFQ6EFvDaO1mZXo1KYu0QPe1WCzpruORIEsPCiQ261wKbYmVpuK8RtsPgGFRaArfobpzmfDwDFP1nrQ2qoJEIeBmb/MwwAw88pBNx7RUP8tzkQ
X-Exchange-RoutingPolicyChecked:
	h8vMYBbcC3/ZwWUXn9ZtbWqnpECqDbFu6IH5eF+zI0RIMZKfuKZZ4YuSPL5DstItwesA97oLg7bImcVHScng3Zh2zAHBIww9BBLywJwCuTbXBCoMN3YWoKpBztH8HY5QaIA/CXfJBOFyWUEUfVK7scMG1ei4LNdcNE+Yws7S1CrKlrYcqTyNCX7PxDxeGXgicl7V7qMOSyDpT30ce8rztPl7gjlfwK3e77pq6dIGaPQhqd06l3Hixzp5sysR0BLJbMaX++hXRvC1YrwxLQOGg3Yp5TZzr4O8lZInjENjAnuxwwvA+d/3CNnrNG32sPi95OJSknKichkPFywtT+/C2A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:47.9497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eae1107-ae3c-4e90-6263-08dee8aa1237
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEC98198CD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX1vfkMxR4ZRAx
 evdaGbeJ0u0H1Rmh/Sc2egsiSjSxI9CZu1uRc2U3IeqOj43Jml4KOtrekjYsaDqMI7cQrC7rnBU
 huoYTqv7ArGuS0cuzLMHrxWWwqa5/B8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX+C1rw+2nAUId
 BvMOV4txRae61xCCMZZDPLPapRPdSUhGV+yHmZOy9bz7RXQAxXgfThH2cX1Mm2Rl2XVVc8ggN1L
 gP5QOeXUaYIeauKc+/F+krEJyGDnJZpspiUmbpqsxreQlI9QkPxgTZyRdFizbnQJiVoV9/CRUXc
 1gf5AtiDxAD/MM4Y+w7ZZV3T7B/C2QI70ayE2tJQkPT3Klh4riBL/HmYgkl1CurA2jDuH/a1M1N
 uTIyrSLblvuSPQ+dTdcetquCrHwpdxqJ+PstGmEV04aVPIHsVwy/sNb15KCkGAa4kwPrZyZNBrh
 /At1SpZTcLZOx5VpgDpjAedrFMn9VqjJGdy8Yv2vngQzbcnmNC9YjIel+AoJb3uRysKZyaxLk6L
 rqNs8/RLRfdDAUphslQ/G/76D/PJYrs7F3NoIWsFaWY4C3rbUruwPIUoUhcOo81Mv1ys4UDg0Q5
 8CQHRbiK0eNc77ZJDAg==
X-Proofpoint-GUID: ziajPMycfSB_4T35WXAhbnY1nY60n80S
X-Proofpoint-ORIG-GUID: ziajPMycfSB_4T35WXAhbnY1nY60n80S
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f519 cx=c_pps
 a=8rPU+5JwkgyrUHCwJFKWcg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Refactor spinand_select_op_variant() to extract the inner loop into a
shared helper spinand_op_find_best_variant(). The helper takes a
skip_mask bitmask of already-tried variant indices, enabling callers to
iterate variants in ranked performance order while skipping those
already attempted. spinand_select_op_variant() becomes a one-liner
wrapper. No functional change.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8bf9301f25e7..7c3341f1fca0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1542,9 +1542,22 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/*
+ * spinand_op_find_best_variant() - Find the fastest eligible op variant.
+ * @spinand:    SPI NAND device
+ * @variants:   full variant list to search
+ * @iface:      bus interface to consider (ODTR or SSDR)
+ * @skip_mask:  bitmask of variant indices to skip (already tried)
+ *
+ * Iterates @variants, evaluates transfer duration for each eligible op, and
+ * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
+ * no eligible variant remains.  Used by both variant selection at init time
+ * (skip_mask == 0) and ranked PHY tuning iteration.
+ */
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
-			  const struct spinand_op_variants *variants)
+spinand_op_find_best_variant(struct spinand_device *spinand,
+			     const struct spinand_op_variants *variants,
+			     enum spinand_bus_interface iface, u32 skip_mask)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1552,15 +1565,16 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
-		struct spi_mem_op op = variants->ops[i];
+		struct spi_mem_op op;
 		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
-		if ((iface == SSDR && spinand_op_is_odtr(&op)) ||
-		    (iface == ODTR && !spinand_op_is_odtr(&op)))
+		if ((skip_mask & BIT(i)) ||
+		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
 
@@ -1589,6 +1603,14 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	return best_variant;
 }
 
+static const struct spi_mem_op *
+spinand_select_op_variant(struct spinand_device *spinand,
+			  enum spinand_bus_interface iface,
+			  const struct spinand_op_variants *variants)
+{
+	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
-- 
2.34.1

