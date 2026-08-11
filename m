Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89B381B01;
	Tue, 11 Aug 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473283; cv=fail; b=KyM9UURSvcqlD39jC8x//Ubw/otUI6kzyXacv8/3n0LS4EnOBDrGWv5J+curueEU6SEoj8WnncSca6DmVqcFNZUtWviAs4C8oVoFVWe+fLrP/lLBzNhbuGp9pCM1tc4Wm+3Go7tEvJvlFwwcY7hwmb6UR7IjxKL7gRY7uXkP1pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473283; c=relaxed/simple;
	bh=5qnezhdC7z+lORuvm/pjPzGWMGRQvmaJD+gNRZlgLhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY68oBr4VAc2cbRgpmYv+BHZrGTlkHe+vvau6eYcyqMPGtWrGvW34Qh3u81HzYIJETViq+2m3NYstMPJUyW6ScSZdVf8wMTjGbZSCsoeN3SGdq02fDeGkdZZ83XOOjRZEQffMNUdJYU2fiDm/53r/jjokCfUaRFhiBUilJPP78w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZHYCwqkx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lqL8+3N3; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZHYCwqkx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lqL8+3N3"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMcJa2174910;
	Tue, 11 Aug 2026 13:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0T
	so=; b=ZHYCwqkxmPg0ox+1UNP3WMaWkSFQWfJcm5v61NdaRaTjoUvv+GXVWS9O/
	6iVyNhUP4YmUS01anX278s/Mia10N44r1Tq8AYPbKzkewW4VpvB5ocJRsLDq7to3
	R5AG744S88E/OQL/Tccwc7gQ3Gle6RCn5QLRxVZmGhqjpIxYKIVEayGsG/2r9UqK
	1HbZF7l0FvNMgPQsjkZB9feiDGilyd6F9g6kaZNLZT1WKrnbDTe+k14h1OqazLLG
	05F2Zo8LyBM2qgCKpAzUgf+B42ffC5cKAetmkWwi7H/Mbxt1sUt166EnviZ/6pnL
	eF6fInNhyMaxhDEHmCfM7ia8YT0fQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uj2e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPnxhxBEXdBMVCG1z8ZeiiJNbnPmmuhFbgZ2lqAYdt2AyOn7I0Xi6mzgO+h4bCkcgcusViZsSW+7jeFt5fOlFqYMwk9VY4e1ptaAqnv4ovnXAwlSjugZwaVjKVA+EOCKMZ8zaWqOHSaNlOuV9J3VQbxdw+1rbP1VTKJ+1HBfBVYTAVD/ixrWFG/gZE9sOHZ0bFR3RuRNEIuVOdCeGsj+jhvPlfBu+ZMbcfLwPorAooXFygl7boZGcJMRaxuWAf/CDFrRJ5c+XBB1gKTaCa5FvfTGK/LU4+ttAo+eDvtTIETCt/KcOTe3rsOqkD5x8Twsm+ATZn3DBFLTbjpN/dKc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0Tso=;
 b=Gug/MOXmc6MPid/ye3KAxpFqdH43FNFYbrs1hk3YAiKvEIX6EKxlxO7cfrS7yFvK0OhCmFkOEquPQn1MYc+lrh4LMwtGgpNrTvvQQzQA2d+Oaur7v4FLVQoUoET4FJ/xp3m3pQD0R0kzPI6I4CkSAcVoYJUAg8Fv1JwDvklIODdWWoYgYoh7aL/oAHD31+9B3VQxXDi74fzFqXwnzZIWIbecD4swAg7m51LdXsLu08MhWcNWKlbUYsnV/1Xim02OY49SQPBlE9CpiXMDDpD7v2Mel8l3XKshRY86NfwGsivem5INvBio2WIxWU0b3aLWgLwNBxSMmrfOTcWEyI9rlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3r4+4BDkKDSVXfOUwFU3FkZBjUujBJu7lCtNDJ0Tso=;
 b=lqL8+3N3SB2LRvICWGg88QIVSFX2ovJ8aquUiTZeqbAm8cISA5JOFPlmUmmCfYhx3QOam2ukXvfTEwn8/bNCLKaVA775IQV7yX0jKHyTjGm9Y8cg1oXFUC2qq/mQt47KJCk2LPaRfz9BQrRnDSlvuy/uYhKm5tOLvi0mrew7Pm4=
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:34:25 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::28) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:24 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:08 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:08 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe1659766;
	Tue, 11 Aug 2026 13:34:03 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Wed, 12 Aug 2026 00:03:04 +0530
Message-ID: <20260811183313.1550425-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec79d20-38c5-459c-9298-08def7d72b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|23010399003|1800799024|82310400026|13003099007|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qhzlf51Y7Q8ukeGO9UoyZr19lV8koIFMFM//BMnofXzoE5dGR42v+j5j2BzyLVtggMYZeX9QsHy0h7JVZUutk8vGs+9pKOfYnEQGNrDyj9K0jgqgrJhlaGMRd9XdmtdyPYx2uMWKc+9BwfLgD/fAqTKImYgmhS/6IWm26+wJ+j4LPtYmogHETYQTxVxsaUhQ4n/vu7OrzWD9xi4NF9WCGQU7ytrEKMFShx20AsRgPKp44WY9LwynKbBxwEEPtabQAE4FK1HRHyQvcwq7ocvNufyKbyguBbQq9xWV/FhxeSxEYtsDsU8/aFoKLiA3vGwZpLyIVmwq2vofHvn2C+xTr/KfiAIblcG55uju36Hexq8W88dki+8AJZgXwMMyok8BW0DLixAibe7UxKcEH99wX8AauuZuuyT5t+k0cDdLeT20ikdt3nkgcynViH3Mkw7IPmCYRZUKN56yd00A47IU+ODHNr58TK+0q/qHmLIc2muqUcm9ukenwl42qXBWl5qfcCFvHjHLSqWprRt9M4ywH6ll/SKhdISItRDOEfp9RqmL/LL5WOhutRXEy94VJpLdheAd4RtRc8xbBz8d8eGOkemmCv//Jd9DtcgYvQtsUrq0NhpFNygXximJrWA3AG2iiWyrWx+Ro38oxRWUBg0ZVKkiyma4bs3s4Q5i4BWJb6Z0LStRk2IOUPEvWTx4tiKKHvwmUDdWlRlvo3RVHQYBuJMGQUX5iLJ8xoX40CNudyTopNbtLZLcbZwLf9seOxXL
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(1800799024)(82310400026)(13003099007)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f1u5PF+c8eFAetgK/HMvmeAJ20rOOgobX1GNH/PEZuyNbMmY98MSu8UDmgbQnI+iaaCYVMsbtJV7El6VAygzhhLwWbqSAVvkauYCMna/Y5skE7pJqs5TT/cqyLbDjKp2XUOjUEK+oMPllroa3wckkBtZ92dk9RYkxl5t20PgqjZ1b/Q1aKEyw2GxbLSBLlSGoE5YAzAgmkD1Hb3Tqq1yWRHQqI1DmumgHiiaGgRy0Bek8GGs/uzNM8/aouIwaHwqTcmeQz2D1OpOrrRJm1HKMcIRgXgawvxfJ8qgbuZcCFzhETZfCGi/u7kwUE6/OXXgzCgZuQqVLWm6mEnDvtFhsI5r9K4nlg/aqcubLGbrmUDmNe3jcRiQ2d/oXk7p+1MR+ed87s6k7Th33G5CunMvAM21VNBO5Ji2qP1KGGHbhaYPZq8arIeZek8kDbKuLIrt
X-Exchange-RoutingPolicyChecked:
	kKWJiQUx/l5Ld+4QpuQiaILBt4dL677Ll2a7icrNgaKM39kDfByINi0dbWVdKCQmkSq/++gNB8kO8tOpjlyK2xiEjrHqGeZqUVeYpjh9JsIduqXVcXlvwLvXLUbK5qKmzngq6khHlMrzhbiBJqHcPLsovwykJtJ5TxB5uT8mgWL3S3sn2Z879bPKLoWBN5A5plvFVwHrCWSJEzHlzYDo60oTHC82fMwjKOuILQ9oxxbkO4hura8L48yGRA0SkxeNsxcElvUHUjx35YWZMDUQutf4SGBXboUkHzoZSHbq6ZE7/0qo9nwYkYtEz1piy7Qmkt3UvdVnQLuqQlfLykA4nw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:24.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec79d20-38c5-459c-9298-08def7d72b26
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfXyR48vf/J1E2s
 PEetTeI3Y+K9hHC2GSd8XhAZCAOE6ajpIXwsxRkRryRfiPaUq/9E+n4fn4mv7u5dPXuzZMt2Y4b
 YXt07VEhvPMMU/hQ30u3V9TZVM4bMi14zsATm4aN+rGOAUCkBv7m9Sa6/lIDiJ2Gf5/0tfv+lX7
 qGQRniNmFYxBXmwBIFvhqacxAXJzmcHkxrUbgKfk7QLVOzyOFWLgsi8z9wdZ1437ueTQ8LZT7wr
 Th71ka5ERY/CekjJQnc0zlbLClxI/4MtvNYjp1Oh5bvLEcHRTVxWnm/MsMn3JdwcgiaOgUgWhOn
 SgwiIg2ZR7kX2GXeQs5eAWdR3pBwvxhf9Dao6zrD8DXQLHp/4Zf8jreeXVmkC6zFinauOMra9+X
 lOhARPlMfsk58Yza/OYuAXUr9MoJachd+Pc8XEEGGxf/6DvbUr5QxDTnbEnJLCSkWOJtnc1pCvR
 rL/Jf7QPY39ww43hVcQ==
X-Proofpoint-ORIG-GUID: q_px9SPIjT6WV43-rzl_K23qy8wat3wW
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b35 cx=c_pps
 a=nAh4yJc8K/mwxcjpRfPwJQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=T-kh0MV4vbdY-aS4Zb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q_px9SPIjT6WV43-rzl_K23qy8wat3wW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX+g6/uts+Oyze
 wGFfqyZS0m8mCuuKFce1vIfLGtwxUj6655ntQSA2PQBTChEnSiBn9gfhdKL18UGTlP4CVllkCOW
 G7LfmmQJSaACS17szPVGJrRWgot087I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared — the op-skip signal that tells the
caller to try another op variant.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 43 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5651320426b1..a1aaba7c1a7e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,19 +37,20 @@
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
-#define CQSPI_NEEDS_WR_DELAY		BIT(0)
-#define CQSPI_DISABLE_DAC_MODE		BIT(1)
-#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
-#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM			BIT(4)
-#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
-#define CQSPI_RD_NO_IRQ			BIT(6)
-#define CQSPI_DMA_SET_MASK		BIT(7)
-#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
-#define CQSPI_DISABLE_STIG_MODE		BIT(9)
-#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
-#define CQSPI_NO_INDIRECT_MODE		BIT(11)
-#define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NEEDS_WR_DELAY			BIT(0)
+#define CQSPI_DISABLE_DAC_MODE			BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA		BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION		BIT(3)
+#define CQSPI_SLOW_SRAM				BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR		BIT(5)
+#define CQSPI_RD_NO_IRQ				BIT(6)
+#define CQSPI_DMA_SET_MASK			BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET		BIT(8)
+#define CQSPI_DISABLE_STIG_MODE			BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM		BIT(10)
+#define CQSPI_NO_INDIRECT_MODE			BIT(11)
+#define CQSPI_HAS_WR_PROTECT			BIT(12)
+#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3211,6 +3212,20 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR) &&
+	    read_op->addr.nbytes == 2 &&
+	    (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	     read_op->data.dtr)) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3849,7 +3864,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

