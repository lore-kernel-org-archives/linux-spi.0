Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266448F831;
	Fri, 21 Aug 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313022; cv=fail; b=B5zQUrS8F9horQVkJm1qb59z3dcibDHTanOHGd/yOTTk0cyLrvZoIgb0ginnx3zw/lXZn0IPWeaq5yqfKMR62du7tdsf7McNbhY9DhZ75FGFZtmgisIO/T3119RdumllsDHcAtRjqEOgZMhzg74fLRt/9h/n2xnhVNryXVbK6tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313022; c=relaxed/simple;
	bh=Z6kI0hhZdkpmUOsoj8CKbrqn8KbIVxP7eRMt0m77Rac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZ13wJkqolagZZOnfRkqYL5x+7ct/zw+U/JSPp+uIH0roeJDtW7wBg9AhG6ORuPKKupXPyMuCiXhw3sz3ZChO54zyq5ecypUbnHfhe7VemRG6omusYMoZhxJMbLOFe0cDOgqgTpyZ2tJIBGshmaaUn7/GogZiGDV4/uxvRG5hu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=AMh6JsqI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rn/SXSYn; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="AMh6JsqI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rn/SXSYn"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KP923254958;
	Fri, 21 Aug 2026 06:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpc
	F4=; b=AMh6JsqIGBOfn/9dhM9hQWbwffK/AQgfIdKt0ZCFIc+H8OK1h/ajw90En
	Vp77QtNz3xJTQldjFeGWOsuv+uxAvWcOfA1CvqeDC5dh/CYsosX/86V+vwROw1C7
	akQNUd6D87WHSSezspVEwR+Z63CVkJfXIqIxSc3nisSfGs8iG9vKvxob+lCSr5GK
	VHyuE8MbW6+u4S9NwVpHwLKeWmJW5nndow/TeVMMC8UVgguBZGdY8mJcclo7FVTz
	Kk4uF7Tzo3kETYbj4lCNXU2Bb0NTw9dripyrBVw8DUwu39CLgjHCz5evuijzqOc2
	TGt1FmumvjBDFykRLmDAWLw/JTPPA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1dgp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:50:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN6B9TtcHK91br0+qrqJCp3c2CDdbTBBjM6Oc2WugwwNR/YhXlWDbNzVHZlsB4js0SFrw76d32JPwLkQiNnMSVA0U9mjURddQzX7J5w83rMxGBnGDrLoenIgapnLfqIcv8FfJu/wk8Iad1fzmKA668HUx9POuoMl4kHOz0Rf9uXzTS+W0AkDWuzROdqkkREVXsEUrhcUJm23WJDPBXFH8dQm/1YnuE43IbvIqlOto1GPQSkT19nf1O4phApYFHsfbIWV/Eg6WvguThmHM5Sq+7g2w9AhN6nlare1QO5m5m+qQpCX4mOjCAm6kfKCMVLF5ejRJ27qaEqHv8r0Ro9+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpcF4=;
 b=yvSgbCDVBh6ADNOb18EV9ntlFzlEdq5AtWjFFVi82+w8BV9hp0vT1rUQhEvKVKN4PSxRBMz/6AGyL3K1BIBLK7KdxlyYI8K/ok4ArY3lcHi7S2lJlJ0XDFIeHKwJyv5d7djuYn6bA4mkzyNObaw9EqWZBp+nHoVVfw+SpZWo8ar/+DA6qxV4+HHpGDZVfV8HX/hXuVzK1EbL+xFcEaB6rwarjepz1TEzOuxsi4is4cahg1Fm0aywbxTnw2eLuMv5Uy8Yy9mKluBXZZ05jqcfvCy8dSc/7iq6xft1H2Fh3OaJAZr6e3NPySZN1PXcfpsU2mJx45vFIg3+0f8GDKtdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpcF4=;
 b=Rn/SXSYn5xCx9C0uR/IqLKaVUdZjXqjgrp2z5USdYxnazZG3CJGP9cEFIwycxfjhJDKYnE1z1dFrtFa9vusBSyuZFAre+RDlwPjNqnexrKRuVPaNuAKzOMKW36/DEq4e5gdxMij5ESycfssOuNSAayRWfHeZdQQw9zgJD657tnc=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by PH8PR10MB6598.namprd10.prod.outlook.com (2603:10b6:510:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 11:50:06 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::a8) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 11:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:50:05 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:59 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlq2022942;
	Fri, 21 Aug 2026 06:49:53 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Fri, 21 Aug 2026 17:18:19 +0530
Message-ID: <20260821114822.4040338-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|PH8PR10MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f98e7b7-a6d3-4c9a-0923-08deff7a5795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KADRxmwHqChhTlv+fHyU60PD4o1TGZly9MnoPzotqz2lpI9PeIuc9ivkpBqn6ovOocf14l55eU3LujNvJUez+KF0ode4THGstF1k8HnxM6JHwHxtYWyoqjvx95W0PAx4DMCE40qSvFMEf3OLvawK7JLUnNFGN1yu9HkT1O7XJCBF0iCfkUC0lFXRh6Cp9bYHpRhQjGE2bzULZE3KFNL9Mo2NR0spBhft9wCrALR8ggsHpXURc5u5wuYodnyvyHGFUo1Uu7RvUSyPzBvsPMBoCGjTTMqaVv7LvQCDcb6JRcJULfJU8mkbNtxPKP6364e3eMwWYTZlltna6qNtdGXcRBVV0q2Fgi2P6e3roD5Oe1i/6vewCR0xrA133MSjOvlyaA19mEzmTb1SN9/zVOnqp5+qPQuNbA8PdUGADHSF19GsLhjlKFk6OM7FiwY9DcX9UB4A4duemzyrZvbKMCE74uXGba0IBC6WAeWnprDJyVDajXpNsF35oiom7Qa0w9VA+y5alNDVGAEBXUK59gjKABa5NpHgbRFdertCG1fPF10w+VVBYNrW9VwbENXHQvVE89nyYU1SADTkRxTttKoxOm6jMeKeXgVtOI8cEAPXDoW1s7OdP0kNXajGyA6luIGdZi27E/PgoQ+X9Bd4BYo+tM+WaVrtsEiI0XaYmbmqpcMe3HEueCojxYRTxGw/y9wT8+JyM3+sRnChL+LPDyY+5QpXPpRcPva2OienEk/UDMxQ9JsHEroH2GX2aPbyXaNi
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RfdZ1QgpSrq3aS3ulHsoQFXBsqcpPRcGgfRsSiSnRCb9z7McdGs72tBtY5EeZPERx4L6taEI+HZUXj4cuOkMxLMDIdFOYOM8s6uT+e9/LDMv7DoS5mFz8tvzXYD9wwYshh3+hQMrTowfY1VNBR908dOTMaJOxsiiC+bJ+vE2W+KoEtWz2sxhMCkazF9i0IEiCX2hsd+t+NO6uHyluAJOPZeTOcgGZuMm43wffo+/FzG7URZESo8cu7xIYWlfk43DBXj69Tf4oCJGOwOKJ922gLdJrt+eTn3gddeyWps/qTN+I40nYv8FV+SmU27iuOB7GV/uCrdU9IVPxpjHGl+Gj6GeGvA3JnInxXqfoGm/i5PShZ5pv5y0LZjRjvuNvsSSQJiPNDhk9HKjTtT/NCNHfFQr+ZJEE5bwhwBhQrCgsqcJOylHlEVy1oVVOVUdesTN
X-Exchange-RoutingPolicyChecked:
	C8/DXWiDU2FCqDG/ehdgxWTEphVAamzJD5eDIldUIC2a1rCxBLGH/ZTLP+Spx1EFU4JILOLe+iolLpZGOmjriPMVnfR1qD+leBYEbBBfTKsmDoIOXfIqHcq795xuj2EDZcUgLNKATHMZgtDnwkTp7n61mw7o83xeshoN1PUZ+9X+AacKeTV7Z9Nb55UThWgcsimn+tr5negF5tnZ/XhDlMxGnecsb26Z1QSCoFwBYN7cHsln2Le/Um9DQeP+A43V0TFwhwpX0ylx569YqfpiQSzhDK25+fPy8MScmdjQCl7W3KgTXBNPBc4swqM33KIWLBg35oBceRkXDdBzlZ/7CA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:50:05.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f98e7b7-a6d3-4c9a-0923-08deff7a5795
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6598
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b72 cx=c_pps
 a=fVVZRgaqDuj868rfKEvgUg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: Dn8a9FOgEg_3n0DWDZuBF0GMr3HCILJ1
X-Proofpoint-GUID: Dn8a9FOgEg_3n0DWDZuBF0GMr3HCILJ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXxZq59M4Z+Pts
 Kvb3KAdnOSO1PIaZKMQoQIlrddXFAo4EwW2bAp4i5LxVRjmzK9U50DGrddr47h0mPpfnHZZa/N+
 eTZDEDIPm9+oAATzsYUHLj2hSvukvJk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX9QBkx7ft8kw2
 pgMfChOtbBOnWJQsG6XHgvPsFooVv8UplyzlIutrOeCq5gGffUPQeKenfvdL10u3GNShB/VUFcz
 hmUbV8e6JUXVhk0XbXhLJweeA/cMUrJnaeV4n3zfWYVq28/JCQ4YyPSWHTxCVbiWxy8wp8ShCqT
 hY1CbYU0TCs/HBQ8mU9Tuv5aFXpcJwHoAhqaVi3V0njW55Cx/BdYLA9z5KdX7nSobtTkxPuEMUF
 UBGP8nGR5BdUNiXpzMeScmSIVnBsv6E8hgLH+GCqoV3SgfQ6a/QKU8zulSKzN7zvoTE/ik25674
 3zacRxEdVa9O8J5eKFZBftFAV+olCgKi0SVSwBQoKH78zHPoTequizK793VTBqx3BkuLXFHW7mO
 EJBzTXkFfXQenVJ4D2YLegGF310rXH6mdh1mxkUZafR/ZBKxv4mvMigSs24Y8aKhg39yRgTPzI7
 BUaiYIhuMWfuz8JHJsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Refactor spinand_select_op_variant() to extract the inner loop into a
shared helper spinand_op_find_best_variant(). The helper takes a
skip_mask bitmask of already-tried variant indices, enabling callers to
iterate variants in ranked performance order while skipping those
already attempted. spinand_select_op_variant() becomes a one-liner
wrapper. No functional change.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

