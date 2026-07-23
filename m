Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C945DF51;
	Thu, 23 Jul 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804661; cv=fail; b=XLUxTeqeS5iG31n9Zes2jR35IYYYKFkx7ydkpsWgjzIIFH49FBVWr7bzV8VSYfewLNCht/YjzAicytFpjVcquPWFm0/2f/eX0WXD40tN4Gaz3HTvxXhF2swd9r8PYLYEXJcrIUg4MWepg9eOG6bP+S2U3kggsnSQ1TyEzQ/PSGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804661; c=relaxed/simple;
	bh=zyzIHZWkbZiJeCTqvhBe5bpyE69d/84Z/bMFLKqBSj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uULs7dUO96X5u+0sti1m0pOj5Rbf8D6hU8aaattmZMkahZ4PBqaQ/6v7dV0faKF9spN/3kZkAK8pmezyra3dWm+LgRIdmKPH6Bdxj5bNJ6gOJse+f9CY9qulpQrPRo7cWZB4+rFGWZSsMO5j/fpRqdadn+IqozVOKHw6zwRJ1uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NdEHmJV0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TGLWYmtf; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NdEHmJV0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TGLWYmtf"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8t3Tc1974385;
	Thu, 23 Jul 2026 06:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yy
	U4=; b=NdEHmJV0+fJZ297uUWTd/nhQCHgVsg7qwju+bQqSSQIGseCP3KS54XULE
	6Or3rpbL1k1JT2aUeUjlYF8TRMZbePhYtXl0gSqv42cDfzZ5LP2Skl3PvPVLFtap
	DgNN0cgyNOJV+++I6E+tn2LV7wQhfdGvnzgWJ3mThCYvQTBS1+zYBvK6KAX0nV0L
	Fys0h2nbWY5yl1MeYl5GOaiJtoxCnZy+oAfJpVOT+EB8IspjjGtvDGVNq6oDiejo
	My3R3RJgllferZEUfJPZLxl7eaRAcC6DlL9ADs0sBdRb2f9rCLBwWUpNa+terDLA
	The84cnA6nbxmu4zUVhPWNJnCJ+8Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjwjbxthh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:04:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv1jsdkgkviBX4RrLyAkY2Y1KUkAuov1f8Ip99Btwqa5mpNrYJYkuQjjnjcNkMb+v1t6pil5QPxdqtRFNXPr8QDro8tntrdMybZl7313oiUxmtO5TPGm0kCGINGzmO1DLudnoXBh3Jy+8dUCEgOYO0NZSfOhxlKNmoPHtcPXQ+eNcy23uGIk577tDwh4uBXVnWBWP1DJNmdob0D7cGv/Qpme4DtBm/49ANjZCOpi34B1cb7sqqPvh9fNlDhSj8EWOTsQR0J3pFt2tF7tcdzza+Y8lu07eU3cwOMCdvbI5BWOHZ6ieaGPwNO6ZKKI8eU3gdKpJDcfJLLwrDSM2QOdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=D2EILIaZQ4iz4o205jVaDarwnhERj24ATLqzOKOub4jCOo/ABZOQZh3ZHOkA/vVB0WKjhO7kM5tz5i8qT0OMOdVJAtlrc7sHWvysDV3by/5AGMmNLyf4mKKsO5536MrREP96lZHtw0kPWCCXr96sf+gZ2uL5byqnAslYcGZIWEpH3yrMjRoaWQoHpRJjMNCfYJkOvxzo3OwdUfv8Xpwn0S7dBM2bycV0GRtS1ZKvQ4oZhtHsoKe/PP6AP2cexcbQImfmVdrwveqnTFSAfUXaugc3/aa8ByUmKBeonTlmharkpMIklbuuUKWCB4WWLi4BkiCXHqh70VP93t7c/4dk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=TGLWYmtfMZZn7CE9C25HAwO4amoYb58hjEDo++2sSjGaDO29WpbuH280LiSw7Zh4yerzBT+JwFJFaWAmtEDjHOYG7AzpyPY0RROJGsoeny7p2C9J1JnySHkz2FXBjq9kG9O7lrezhtHSRKtrM+UVGUWj994oNwYRFdQQ7yJzHYM=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by IA1PR10MB7114.namprd10.prod.outlook.com (2603:10b6:208:3fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:03:59 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::4f) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:59 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:58 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OWC1577597;
	Thu, 23 Jul 2026 06:03:53 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 16/17] mtd: spi-nor: extract read op template construction into helper
Date: Thu, 23 Jul 2026 16:32:18 +0530
Message-ID: <20260723110219.3180747-17-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|IA1PR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: bab235e5-0252-4ca3-0d18-08dee8aa18d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|3023799007|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hXhRjZNpF+gd1Cu/5eTpGy076YZJ/gQGIczM/7bjbUMshQuA/tB5IAGfU+vx4ThWlFLP/5Y/wX0A677PWMnQDFbjuNyViF61tSc2LqbQzlAx64YIJ94mLMb9WlMsHzRPYkn8eTWNYmzIR/ikWY7vT1VqHaqRSKNiVZleq0/l0vG0vbstQBq0tTkG0rhgXeiDSmq00VoEMEuJ3Pq1BERHZ5iyJb1QWNe7Qi2aS2auqQrJhPqgnGQ7lPysx/gODTxv9wA9lqOhXj4f306gQ0rRqxFs8oxjsTGvuqJJmf3m1lFLtzTVUsO0VNwAUl98p5iBi0XXyu9B8SyrUHHxgVtXng1NORH4Lc/zdmyHiOOPG6W7UlPUOzoCHZ+c4kLL/76L5lP99VXXQO4uMJnzazrlyNE3Zvc9Zjrm/fxCrfD+wErZV5zUhcPahH2+M7PaoVgMTWMwZpwDhQslKbMrJ1ODAaYEVcwVp8+bkFNv3j1TrZKT33Sfcgev7hyqtX+e/PiUINTCNqhUmKI8hEwZ1Z7VREsPJFWaigCsUfdSgakeSqdmssh1uvIA2B1slyFruiBRP7SJOY59WaQ0l9NDzGhKMwzCBuG7EwVTzp1GOFbzhn1P2tg+bDTe9Si2dbPeJ793H7l3GhB8fGjleaiiR9OH46Jv9akHTc7lSuXnTZRkORgoUjEFeOmW9fKVJEejS5vz0FbOwDlRcg3AYnRfBCCTTuWLzOx3KQOrQlWK2QqKJr/p3wmEJqvdlcM5Qh7U2PYW
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(3023799007)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RovVbBks3ESbiaFdv+HNXXrQIFcwt3du+WfIAdzcPrjsm2c5v7b/2ECxogL3T8DoF+BOUV8ipT01ygxeT4zBBN0P/xwLIgJiXUCV5vSQiD32C0b81Ey1ESf4zMef4i2smldwVdwRvKTlsqUBqZv02ia2aNqemxLLBg8EOpX85vt26p0j6cr1q5ksNReQsGmPu1DIxratZhWRkPLaF1mw+vkMdZ6RTv34HulzLvWzHCGpydbjXX8/CUAeBkVuq/h1dghDNNE+Kgf28FmDL33Bkwf25X6B/hgXurqLqLEE9Xt3R5OiOCiakaBi2yB+jJbR1lblUf48Gk7zTM99i/KQB4jgFX/MaF+/323/XoNkjOZ+mjFBDDDWu6MZ5g+SoRI5ZAIJLPPRDZ5J4zoyS9Pbvcos4+Qjdt55ktQMaJIHQVvpllIa7cbWDEll4JPiT9/3
X-Exchange-RoutingPolicyChecked:
	dEWS5t9Knbn2LixhQxaxqzBi+QOWaGN5yKtk9Vea1rgMCKTH18rXh/Mm39GzBjPY8SUQilLnGWSRLR6MMxibStZM9tbYMs3RExm3f7BQIeu04xb3kNUHh8gcfarLdDOUqzYUXQvzhBf+Lq/KR6FOBR6c5icDurPO3ACEsw3B3ZXTEPiGZdohI0Q2vC9GWCaWD0jzgOeRCH/TuF0IeBeqBNFzMGALUuiw1adgOuZSKsqo0rQs1otVbSKxEX+rn/I3dVELyjZEJBS2tE6b/psRU7+1TTNAHzdjcT7yxxQyuO3L6sP+fdMzEDQLu6fwMAkvG1BS5rYbX3ePwXP/lhsLhw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:59.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab235e5-0252-4ca3-0d18-08dee8aa18d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7114
X-Proofpoint-ORIG-GUID: fi9T88fyMVEDiwi71EDHtKdZmK8-ikWO
X-Authority-Analysis: v=2.4 cv=LPRWhpW9 c=1 sm=1 tr=0 ts=6a61f526 cx=c_pps
 a=5I5pDAtSp800fId2YpAiPg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfXxgN6epr8Urmk
 1Bab1wf0ejjQMQuwfzvCAYNy8rY/YjqujwbdDwtjnY2/TbVJQ0kLLLY0On8kBSyUZ2ENkeC6pgD
 2DTSVgTA7FlpW+9/8TGfIjgqpEMr4ds1R+pHIPFwUhfn3eYpeqS2p4J1/c5Pu/VT087jKTV3fwQ
 1RIZNXbgLhtaXoiHhsM+C6cJwhTZD5gEGrY1lK4OxtjVJy17gADW4ah8+YHYBhBJdnhqYy6rTyz
 V4DfzXbY+un/2qZFKaQzdHfTnbCQp/Qs3GMDHta075DJev6o4vT+uGGJnwrqVTXe3kcTHxw0p5C
 R7vY8SZzd8AXyL1me2egvuzVSVqASBE/QtUxxgpK7kShK8r/aaFUZ/VPDwCkXGppPTp3OnF5u9E
 1rGqKDOYqHZ4IkIGC8lTA8mCc1N4S6tgMFSZ2HeTaaTcAPkUdtguAai/AhoURMM3UGUWc5rbUqv
 XbdSb2ey2al53hLIeIQ==
X-Proofpoint-GUID: fi9T88fyMVEDiwi71EDHtKdZmK8-ikWO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfX6TMX1NGtDi+Y
 zstO1FLQ5MDPXf4D294KSmNp3hXezJRHTJB/H3mKLJB98wY32c2RulnSBdoYc9Zk0GtoyBcXi8x
 072swyUtkxS40wWPsCpkRbqvpuLo/tU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230109

From: Pratyush Yadav <pratyush@kernel.org>

Extract spi_nor_spimem_get_read_op() from the duplicated op-template
construction in spi_nor_spimem_read_data() and
spi_nor_create_read_dirmap().

Using data.nbytes = 2 as a non-zero placeholder lets
spi_nor_spimem_setup_op() configure the data buswidth without a separate
override; callers replace data.nbytes with the actual transfer length
before use. No functional change.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..b683c077a233 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -188,6 +188,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -201,21 +232,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3712,28 +3736,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

