Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919E45D5E4;
	Tue, 29 Sep 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663885; cv=fail; b=CuDedJ3wEc6d0BhlFmoGy35UjQ3z7pDNqbnEmrkeCRSzu//xM/KV1+i51pi+DE8Ic939Vfnma3Yl6Pf5r0qTe+PAb1xnGl4MukEd7iy566dbDnVLdXUwxVzGZbEfI/KID2kPW0z5A0QWZz4M4AhmA1wz9Jzyu4evRVc8C4Wrgvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663885; c=relaxed/simple;
	bh=Pj6yQbOsj53bxmtRDKSZhC+KN8K0HV9tmICMJ5SZJYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gglNVseuSVS/sfZqnbZZ5S8Ztnx6BNOXWBwIPLdN5KVu2O/qLa6PAFg9FXbLRfXca22Zr3xg1XU+MaLeuCO5CeEOwT+7RgECd6AUlJGOIBp24ZdSS2IL3uXIE4h6LM56nOL5hcRAW8mNLaCRVv/E6PUhzsCsNX89f5R+oGIh/QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JxDp+dsB; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=mDRP3Smp; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JxDp+dsB";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="mDRP3Smp"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Vnl3284299;
	Tue, 29 Sep 2026 01:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=DvH8Ldy2w+swo4hBvbF24Yk2iycD+jeLT6tAfK2M/
	BQ=; b=JxDp+dsBXQ+epxZ1oZOf8V4D+z+iXy/YjxYi3ZB9CwdR7pqvgKjGL6WmU
	owzKlWO8UAQjiKcR2Xu4DR1ibCQDREtfYwdVXN7VcWkb6tgKb0FkRTaloUSHH5Ga
	uUGp7SzJ8n4KytepIxg4VG4JwFIOErg/TQ4gAAMa2W/gBuQMQdekb+ReY2Hb5cx6
	gP5slD/8q6csnaejFky5OL8KN3tZbUkjIC6SN9HQDJPaulu/6JBPdVswpBrIsyRo
	Fjh9nr3p6KOjkLsmW00s/E9yRtXdGjDtiYPEspZCgPkZxBW+y/CVQJU7O8SqjGZ7
	DsYG7qjnNy5gOvYhaqxJUkZmKjkuQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElFzvo90sRcN7XQczCMxmYPaYtavOfIs/V4EFb0wBW0KRDpkwI/R/THSoNh8USmlkSV3BTmI/4582YXEBnF9ORudD7NaB/I/UAPStwLo2UwWUQ1ybzXeKsHaofba5EOtJK1jmJdAwxwGPmWF94XdnS6MMnhzznkRNzNEmFiVd9NxGvhlNP97+v/0AMnR57lrg1KeXlvvFDhoyvx0R0++0BgcVy9DUPJVoYkUn3t0EPyZLNSgRU/fnVlCvIOQps1qb5sbSn7si911zuxsepl8zCo39hRDlhwi+KhMjN7Ee7nTDtpEUOLO4+JqOZOykUNvzqm7YZifmUPGxaAe29UX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvH8Ldy2w+swo4hBvbF24Yk2iycD+jeLT6tAfK2M/BQ=;
 b=ZFTHAcEulK4IcG0r+CZp5nL2WgNafFgasfiozAX2Mdp0KXB4ZNQE1dwwz/UBG9EPD+RaWoQTMtVJ0lbq7AiNj9yaCSX1wLAhWe1kueyPagt6ucFJkR7Vv6eVUUXqv/4EnVTQWT4ZzIn/+pXFmZQdvnCly1S/2BvKz/XymPf9Xh+djv3tVIPxGfPk3tkcWbwozvKKSaBdW6IYiNBcUODjo6UIKNW2rgkNH1z2kFmjka6+fI3ERDR1iv4RVFzExVJ1L+IWKdPI/Kq+jPQqaMuE/48Lq6XHxctkbWyayuFphzwh33SZGGLjsgC3ISiWq/wRU/FSDfaMlvWT+4GMpeQvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvH8Ldy2w+swo4hBvbF24Yk2iycD+jeLT6tAfK2M/BQ=;
 b=mDRP3SmpGROQhQ73HgrvnnNIhjYkHbXw7lA5CL1YljX61R2Zyc/cX79fBxI9eKH6ZY7rlSvJf2ff286hINxy09sy4+7Aexetacr2wc+lr7p9obP0KlXF7bAXadQeFP9J3Tu6i9XoM7rQ/civM/lijNdyNe7OCREXtrQYfISMOTU=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by CH9PR10MB997859.namprd10.prod.outlook.com (2603:10b6:610:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 06:37:48 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::80) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:37:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:46 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:05 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:37:05 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnF1395904;
	Tue, 29 Sep 2026 01:36:59 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 15/19] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Tue, 29 Sep 2026 12:05:25 +0530
Message-ID: <20260929063529.1235417-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH9PR10MB997859:EE_
X-MS-Office365-Filtering-Correlation-Id: b21fbb6c-85eb-47bb-7687-08df1df42c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|18002099003|22082099003|921020|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+ejCPLgk+f+r4FKU3SV/Q3bppmOCWFrARtVQBVR5qrZkJ3AXy97FNMvtMehVdmpo+fXkb4tl3dOXT/aBnvmEMwz2Y/wlmzOJMSCrAT1LL5zlKsCocMQAjDzwW7NUKL8w2BjpypnmKru48kx3mRPtH79yqB3JArM9kOuqdRlmAiimPBYOSp17DvP4pakjQZOOvvmw15azkW3gsuv1IwlkuMv+mNAi0EwbYglCGdqsuQvI4BFc/mqJQ/jbZLKyIv8B2cy+EopfuTs7kKU5AQID9UP8O3EsKCHX2Y7KMLvKsEdlB5GOWYfIl11OmiJv8tU1MhMZVHSakdgvCUqsRg58eezgB5exKSBXjUxBpt0k+HU8YEDdRvhDVpX3iL5W77iPRvGPRCbQ10b39X6r1XCkCqPKJWeLvbaaV1c4RD6tSo3+Vpgk+Wtu5llTHFX+LMhOymKGL5TRHYWEY3zcLIhyoLgFKWwMmh9HAW6+5+/EsO3qRg9VGlgtEhQzKDE6kGCe8pfbzdBhnRBSOy0tZg2iO7vZHjm7UEmNePd4sMPQCD0pE/vgvYZzQuGNDOViBkFsnht8bCm3aAqmhq8XGUt0RoIznrAjSWd0Q5VWIDugi8u5JrBLW6j3ptooCdDySZZ5CwXDgauOamYXFAe00w3xY23iCCEzvAow5mNJe7A6K5xCjWw3+hp/b7hjSWgroLedLHc41CD5s4OOYof2eEMWvOPlBsd+y46FEY/sJK4pVoepfVdOlpNoYmA03vCB1Z+m
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(921020)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LygkKu9GcImQ5lAb/5mjYXdDuYdgDnwGAGYpar+T+S8Nn5uOyMLyfohS7+MQoCj00hYfgFfd/h39jBld2Zk8R6x1WrFJ6AweTfuWfJnS7ZELqGYrGyANROUBUPEUkv8P+S0Xdq1S8ECsnzE6U8gH6nJ8qdoPEnP8tmBWWWz5IaEQ5jk5OZH75roJhK1z60AigosFZnYcWKD6V5buJud51Kn7AD+DsFbMwPRDVSkeY2dRSTVfmm+x7JYsu+9VJpTpH4zn9GxYR9tOFA2nl57lXUkdbBeHGV7HRAHKwSLrjivb0W6CqbeIynnYKg0LJ0AyspZORjI2Eh6RLW1cOBfIo41zxkWitPAnJ2CaF9YbAHHVltbka/ZjguEpnomrNK/LJSMmzJdO4Xc5C+yp8y85ZUwfRc9oCeKoH5cWrwauXIGbXToPl+DPTdnrggd5RZqu
X-Exchange-RoutingPolicyChecked:
	oX42bbhB8Xg/gvbKIjCLcYvqnLYSIBt7gAORCJl/yoPJUAQkEmeHktr+Lfh/dy9uzX6XqWfaa9NF5x8VI2YHJhuumpTrwZIb2VBPe3fL4Zz4TtANb/jz4O7pRRumYaRC8hZxOXP+OBqgFV2KDiYJM3E1AHKfR8lyMufM5bEdOM1UT8YN7N3pC5ilRvlgAYljiTm3Xz/dmiBebhRtj1rphYwwH9/qJIpSrn6umSR5RhdPWNAAgBnvFE8OMbz4sLrcMg/SVmW0PjJhvnEimBVMD+SxRhPx4kTw2IT4oEqflM/eV5VyLGV3K8gBdUQyQvOzpJhyD+rUej5K9oCR4g1imQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:46.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21fbb6c-85eb-47bb-7687-08df1df42c8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR10MB997859
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5cbe cx=c_pps
 a=1g1g+NiJF5nyOkqFb40SOQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 4RIAOoY7cNynkbDHAv8-PUt7NleTxWdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXzjQlvMVcTbUH
 atjETl3XP6mUyZ9He3ywym03ykDih1yIG+q8w983xPX27pYes5cFvXesuHaa0qiOJtTHurFDfSy
 jDGRk8J2ZAZm5mouNKVVxiCCgn4GFnX+ar3JElkeK55Rnv2wygsIZDW2uANeM2hM9T3BbCtAUEi
 mHbHsToLnne1fu2/hy+q7WrsQV3DNmBvBUP7k9oyps447pJ/0zsyf5PI1AHyCHmYbAKLGwfCHft
 fFc5ma42fI6TXMtDphYJY99/m5QnjrF1i8TN5SOPcRbmaYMoq8qMjeqFfpGgNxBn8Yxb1B+FK6M
 BniQczawtUkssvSmNC2/+R70j9ehIjSPvmYzduqcKTnqAUv31/8XgX05W2PfQOFNz5AGzd/Y99z
 fjd/6vcR3PIzjoAmlkD4aogZ/MkWL6pmkqVe7by7ulG0+QI3uioZI5K/1DQFil0+8E5SPXa/DC4
 /uasjhDb7p8sQL9QYCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXzyC4tJnKJrNH
 WE6hB4VH+oNeY1lVqsVOpblB8wC8uKHmhxrLBUP0dyPJ2a5ez3avCmUaiFgu+OCNJrK9zRwREkO
 smYXpwhR6iSVNeTBtryX39jclHXebf0=
X-Proofpoint-GUID: 4RIAOoY7cNynkbDHAv8-PUt7NleTxWdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

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
index 133776ba53da..9dc43c8c4162 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1559,9 +1559,22 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/**
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
@@ -1569,15 +1582,16 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
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
 
@@ -1606,6 +1620,14 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
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

