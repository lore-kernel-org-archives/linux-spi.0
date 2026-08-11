Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D3B3BEC;
	Tue, 11 Aug 2026 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473307; cv=fail; b=UvWYhE4mt4D4VbdPDFb9KE38M3oHSjkG66uqANEFLjvgHWHQeOf5DDhqxIOIikqloRdfEkYv8iyXOSpq3KHyyhXtEjitrafSN+sVTAX+RNNu1XvWr0INwVChe8gztmPPoQt5eVU/Ra+PdLbITo+S3iBZBAUpDgN2xMXQxOe2RNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473307; c=relaxed/simple;
	bh=EgPd8VbcyrS6pF5XRBydAegNzfoN1Y0GfOtUmoBoCs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBXEOpZTS+PuZkMQujjw2fxSn5joqoKpNBlVW8bHw69l3w6EVHVFUSqX/IQNJI2A6KBQAsEAP8U9hsWh7OJN7IAJVZJ6WnWlvTAx1LjDIg5hFlF6OSDr4YLHzWbVC3iR2xYoWMaVmGw3rkg/MK+DeDIGWsAKBUb8Ir7xxjZTtnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BUNtkn8F; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZG14m/jx; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BUNtkn8F";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZG14m/jx"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMeCX2174931;
	Tue, 11 Aug 2026 13:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhh
	gI=; b=BUNtkn8FpFstvPoDKdCOMOQo168URZK6HSLXQnOk4uOQHlBgR4NEMsGrg
	Eos/oBaDZDM/OGHEa9kqYfPBMke6nUizTa8kKIwK2cQPMysDiAtQEzlcW/t++Tv8
	rPnEJigb1Yp2d9QV1x/KbZgJUO5G9X38yxyxc1qzb15m8sgQxES5aW0yWe6ZbSU7
	lEZoyLiYvhCNrAtSyBuxbkPyGl8MDjGCtOEXhkuat3zOnCU4k9WcdsWEis6LJk36
	qoI4cib+DLE2wuucF25UbD5Df1OfKIl4exHpdvfWQmuQtsZD3zkph7LxdCqQbtw7
	QhDp5MydWiEpitf0XizCWdwZRZuVg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uj4e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTNgQ1qPxk6fwmnI93jbWqh+yrX9gTWE6f0rQV7TuoLPDygaKUIxnvtixQ+LJ3n9sJTUIrQNYJ5LRgRr2WsT4K9JPm6Ci9GJz4IR4vjK23QGoTT1AQYn+uS8mr5ns1GRhN4DsikzuYBjT4L/qxuln8Gg86qGdneEskHXW/ydqUP5rQz7KprmxjzIFaa42ZIKy44XOpe1GR0ETDJkhM4evuVDXcUJUQYcGIpbvGWR6qfZU5woaBG6XUphqhKgZClsC1WRrQqFiMGiP5TvND6EZ08NrAkitH/PCj7ipRyxG/dMM6+SmVYGE5ziQ+V3n1iTifnURRkx9skZP7go0F8E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=q5aOOhZXrriAsNSwj3Egox0PFUFrLFX8uPXT1KIuDLXxDfDetyMEgSJkGEvGSKyXW5Cb9+9PtoEIDNg77sUNQBgPSAob9xmTWz6udaoq8N1hC4XFczI12edh5qmnjBjo+tLM6Jt8mKAanmaNkhLhQwqNFRTHhk/rcDMKTA+RDVZKfNEUOUlLXWQt+E5Et7OfiPhwn/XQxeRjyFjwtQaaYqST918V8LXcRAmp5sCjvuX+AVfH73480jmmVsojiX2ussWAI8blna1yR6heIKQ7TgMtA0mCrmXrsCP5ha8ugmnAsEiEIYAWd50PjxUybl6l9YZvwn1oZ2x0DTSvmzI/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=ZG14m/jxNECOMS4qnd3O14eZVw3UEhzpNSpAWgDIRbMVepapTfX9roGV2uQ4Vurgf8liNYjrja2ZK7+zrQEPbsrEoGWjjfhn/HLPLKQPSP61WSJbT5sVVe1AQrSw1h6LEXRuHVrjIzQV/aHJvPEEUmV6Mu/dGUJ1+SAcXAaokdw=
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:34:53 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::7c) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 18:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:51 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:38 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:37 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe7659766;
	Tue, 11 Aug 2026 13:34:33 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Wed, 12 Aug 2026 00:03:10 +0530
Message-ID: <20260811183313.1550425-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH0PR10MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ff7f2e-0785-4c13-beea-08def7d73b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	z1Wo7QZtjFbnWZ0QVbWk7AY6p5E3qqKg4LEI5c7HlGkwO3nhvUq60/GOn3EoEo4tsiwsl4d2B+NmCZzjr6QReJn1xv5G6w3uWB8O335deBswCqfrdYnLTKNJl3oMWZEq8gNop3bNyzYRdOIY1AqIDMWMHEf4AAv8J4uSYmZHSoGT6S1SDucMzP4x4tzDWVXfwLCygnFNwYGZk9RHHfjbvyPcE3d0hBOiWyIvpOUklDGhzWKdLk27P4mLnHJcp2tQnAXbSMtIjmnxI7CbLSpuKEm7lBkjtGjm3ZnKUF61DaZ7EW+hkBvQ39GtivCXOGZKDq58e/WW3QN+VI2eOmOfMo33Teijkazq3dSqxVQRplxoXKSujQFTYrK9pZ3li7+CJh8Adnn1G1eQXdmMX8dhf7ILGPk2dWjAh4ID3oimArJ2U2bUXKnAiZHeE0N9UTqzKmz+SyFMQgmlYBrvzZ4XJ7i/d/NUPwZyW+AAKtyh0p7F31KIfBwRxIWFbY5KE6LO2+d1FKkt0XRxULb9zLbh+lG4eOYoQFDUhrIXWi273fQL3PaXa1halordY8BmU3XhIOoRTN5HSlD6Fll2fwGk6AhEsP4GPZIgdL9Tj0XQWhBR8CgJEZcy7UZHd3wwNfARHfBb1EbapdBIgHADdTgm5Ncgcl50/h/Z73vJr7tmFRbZtCgr3OMQ5U62ooX4OVW/HmK5Jh+1b9VwsWeyttKa+9Aiq9Cr+3tDngtCbbmCxDInqx8lVo0CaWHxA7Hr7Eef
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mtRUzakiqSDxWWz5QBN1dJirPelF6tXUvzScUazCctLUc1nShSo/AIgCMv4U/3lHwFAQ5FfBDjaoCAC2hbnKMDYZtFlr93ji47xzCYySYM9oPgaWU2K3BdPTXkoG0KT3LS2v6IjQtERQiz3gh0XH/ESB7NcTlzTUUU9hCz58a4SNSRxuhB37hWY1PQHIO8lJ9xvA6VdBbPjZ/Yj0FShcvSChMPlBm78r2f0dvn6I7yarTL7da0NES5E+Cyco/ac3ah57pDNd0cbQKnDWEdmcdsytwOM2gyJBZVfqaaNalciiF2XEffuVWaBdS8es4gmDzWUIry0PzkiWeisgT+/MGW2gErVlIpjwoLl552y+aroc+ze6bi3fnKNDPKm6aEVpI/0xQhsmOuhGSeoSlFZr2rGM7TBp0ISAVQUEG+VyC8WoLehdnilEgJO4C3FPsk6F
X-Exchange-RoutingPolicyChecked:
	nYxAnsh/+7X3yes36VCWT46ImM9zvzSf/CsnGJmmbrZJI8Wm78B71P+wil2uour4661/DjR9QzqXAeywgZh/tbhU5I5R89nL4B4z0C6DOvyuLI5pfhh/7wPqbx9SfeG89t2LjrVWoqYH6/TFemd3Obc7i3tl+YlajaOYyXhhWupo7G14f2Igc+sH5s30r2WE8prKKBd1uaDwvPlsspkpqpnd7b8r94OwOF1oiV8LMwDA+TdSIU/UkWzzcnGQg5GOLyhpElwNOgawHNtbfq1+Tuyp6SVYDXBz0fLS2dGAgTOBXeZdjVpMBFh3g0F11mDQgOpte2dXHDKN+JWKNOrtZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:51.3475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff7f2e-0785-4c13-beea-08def7d73b1a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX/RFuFPTOY9e3
 XI6qITwcPIX+G/U/2/B0LOSaqBMqfWxaFRzBStbMc1ZrwFo87seKqvlIyzCTDB873pGgWeOiyMt
 wCXawPkfBW70EG64PkK2Y1weZGI9ByYcK2XqWj47e/hVfpnEi1V+EjdFopFc3y9oFbF2c523P/P
 mIO7EuaDWvM3SNBO7qYjs/N9dTr+BNsWgEskRhIvXvhyLEjrjeP+QIiFB4GuF8NbuUNOJOZlt4G
 aJPWycap6DYNMbSGv6CmODTLfq+AONPBpzDzVBKhbi1Pi4pey6+moO/76ibICM7Umtn0T4n5T27
 R1u0K43fMY6dmtDVGN4DuMBot03KUIVqrtKj3bzz9RkEzroqbd4bxAzcQ6IOpfOq1aZMznONXYj
 l7JjRz9LjhI9kBdUcGy3722uUFL5TzrbEZzaVPwcjXEoZx7cy33bEPfrku2nm3KCttj3LFrnuPi
 SeQGb3PKW/NNRXqwPRQ==
X-Proofpoint-ORIG-GUID: On7-fam9sYau_YHG4JE2QA96Muxg150S
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b50 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
X-Proofpoint-GUID: On7-fam9sYau_YHG4JE2QA96Muxg150S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfXw2gOYJOQZ2jt
 PaOj4qRA9Yax9V3AUEiEvVLQtCobf3fBwmBppMgQGmmVodLG8pgPEtn9LxQHokqAsc1bJqhBARY
 0CqgPyXC1sAGQPf21VpFp3gXofuLHyw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

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

