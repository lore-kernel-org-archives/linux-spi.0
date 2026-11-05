Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876384;
	b=xYKHyj014AgeFqFfyxGQmJHxPDnnx78lAbMXtfxNDlhyt7ZTnEH3dmvUt/Lkgg169VvP
	 W92qc0bP47geK8JuQlPdYtlHuwKtM+9S9iLtKSqXpHPDwCYfJd3ZW3alddirGM4wlYZKu
	 veJFq0NnBkbPwYrqEmuJa5bt3Qx7P8TMSK2HL+vSKELxqy1AsRPgWK+J+xUuHrXM8yIxD
	 fK9UFwN3whK2jLro7Mhmqz1phk7t5biVayxpWbtVw5l6dEsEBwq/rkQFfz5FE9V4NT89M
	 pdXyQ9bxAXKJiP/IzZtWemIAZklbPsOI/w+D2Ql56Z8hfeTyA+P1UOX0c1jeLZ2dcuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sSRYNy02yoUTOf9nCdJ6rRFSwVzvXwkLlNRPer/C6Xk=;
	b=mvoMlKtpuHfruGNhZsCk2wiK8xk10J6W8mH4QPIUn9OYr6bE6RQ5DAU/6NocrN9GTCpr
	 ixZPSAF+WQcxR03t1owYqPqP4SQ02VUx+mKEZHttOJ1/DAxRFvwmIFOYdQekHOF2MC/lK
	 vPmWathDsOXpwJrda0PhknMThSEqyfeSQiStUxjp/cv+AlDnP9s616guM2L68J1/zIP2A
	 MNkLAY30ZvYKFkWOs8R9aLoinHdwUmJd/mTuL49n9qv1q/lDt2vxCUefdYwqg5Nwm6KVj
	 fAawaah/rFn3IH+H2scGpI4q8wirWefrwoErCizMm2pi8pdZJiozPFZQRbNx1qRHGxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=g2LZGnIY;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DnmjCt+g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6455606A330;
	Thu,  5 Nov 2026 10:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6455606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=g2LZGnIY;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DnmjCt+g
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A8SI3796772;
	Thu, 5 Nov 2026 04:59:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=sSRYNy02yoUTO
	f9nCdJ6rRFSwVzvXwkLlNRPer/C6Xk=; b=g2LZGnIYST1OYC8FPlVfgU56a/9Qr
	ct1oCvmOu5AsoVwGhTz8jbrW6UZ/OC6m11P5QXgij2fahIP4ZaxHFtaN/qoo9Hzn
	YxrpYQoi7tKdZuT2vHw3+plMoAa5lS5Dv02s1mA2hNL0UPLQmJdybBuAqEI2TWSi
	UxSN6/CFqeCNYPIuYwgptEMJ3h0i4c8II9PmSnUU90v1mVcO+aiMz/DstL1kN5Hu
	3ipwKgmwxnIxAdkHCJzphpTxqwwiZtNL4oyYDTqGOE+V514NAzolrXQJT4tkc7CY
	0zGyc44buRNBcghjUgXEc3fUMaMCuOpjIaunOvJUGszGya4y5iZd42Gjw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrqhur7xm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:12 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNAhTmPbCMsK1xDc9ISD79PJ8ywo2wQdgP8Z5OutZOWssk7qpV5Wb/xSfzGgK4ToRxMSdimYMZMMBlhBD/eZGNiVzWhIRAuYgOOOg98udoTSE5ehSu9oJ6QneByqM06e9NLmL9E015dXxghlh1lxFvOCzC40AJuQh9O4RrdZUPcR7mgtFQ1JhW2pDSWode5WPZQ4B0Uvnz7Ye/HAyQuaOa/Fp3y/leENXzFSoWbruvRgHml9vyZZjak8CNpvwxXDaVP/Xbrqnb4mSXqHKq3tpWLxaz5MWkAHfmM7lfQSzUI7rGzUpey2cokJeihxmg4KzdV83xDgTyGk3Do5ytkfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSRYNy02yoUTOf9nCdJ6rRFSwVzvXwkLlNRPer/C6Xk=;
 b=TZs7ASS8Fl/O+AeqNPTCI+7W8k+gEFZXNslui4butwqawlVc+AsPuAeI4yeH/upCae1+Kf28ZmLdHCD8qDARI0+1cGI8XrIi+ErOjJz/lk7UkX+T3ni+cvJz0xImDwpvryIMEm9Ln/2coVxCkaW4250cddoMy2GpKXrDLmFo+it7MWOapz2fHLKv+gvZ/k5et09HU904cpq9Uv+0daOa16I2eEcC/ewBg5nzUhLsSv5zgnVcEBCrT8g49nliLesSBIb64nUM1Bw7sw9csT7Bf0cfw7x42g4MWKzJcmlVHOlWex317aHkcZLGs+uD9k+biz1jSN2gX9jfFx2eZj3hOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSRYNy02yoUTOf9nCdJ6rRFSwVzvXwkLlNRPer/C6Xk=;
 b=DnmjCt+gpoq1yfAPZ6Mq63z8ZGiJmMXNfTQMYoxsEt4DAIkH6cEJzCjx9jxLeCV4FI208yDmiN4wM5SmeWMSEWeNgVYCPWQZuS5FQcz60J1vZb0n1veSgdkX8PmU1Cl/Fm8s2a/Ilr1Dbc9WdwkruFUd67Pxd4L7+Irn0eL/TjU=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:59:08 +0000
Received: from BL2PEPF000352CA.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::1b) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL2PEPF000352CA.mail.protection.outlook.com (10.167.249.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:06 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:48 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:58:48 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg284171076;
	Thu, 5 Nov 2026 04:58:42 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 00/19] spi: cadence-quadspi: add PHY tuning support
Date: Thu, 5 Nov 2026 16:28:13 +0530
Message-ID: <20261105105832.2134313-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CA:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aee9310-85ae-4a0a-8a74-08df3b2bcfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|921020|56012099006|261009223027099003|261022075727099003|261021123027099003|261009221227099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	oLv7BI6Th/hjnfAe8OM4IH9+kr2uHufCf9VjdBKcv8EYm2ygnh+KOxAzWkGaqNcpjxh1XLmBDweKD50gN1o7/9Fah31W3J2m3SRYaIvJy4UIIhKJ5GkZcY0rWePhTtEGdsLUhmruSmXr8jlAdxT57eYlOFaLubFdFp3Ls9X/cbURB1r/OtYg6WYOs8p82H4ifaDWjC0g5tziC4cp29M8KV6I5cfGEZp8JiNCOjc5hfC+TuUOCl2R3TBIdH9oFsO4qOaYC4TNtHonF9JzQXoygJVUweYf4tbBb3mW9D+nF/iZArzCyQbCh+mesHEuct3FUNeHUly1Rrz+39PxpNf9rhGJcuXmiuqgrh864PLM1NzGFxpxXC5pz38AkyL9u9D2Iuc8xQyxuRSzeWtze6pN2VYSpt9PZFZdk0fYgu0HFqOdBdUezYR2LzDCxzwz5fuoFl1TxvRn1OFR2B97ruYMd35NOp4QSChE+2jIRLVEtnlSnbgUH1ebEkZEsdZRw5eb3tGfyXc0KSApDycvrncNSE+iTc0N4jgA4basVxxeEYrCO/imgwFoiZtfHDCZXZmvQ7Tlu/kRrE5plW2U2f+GWe+ZyH9YYatjP1RgUd3KIWJ6UqHL6J69MbS4BL+m3DZkIm9EsylZrICGN4Q9xp7xrlXPAB3eWaDpbJFbd1vuDK5qnWy5hjRknZanedGNy10NUFXwfToiWuQ5etARZbxh8Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(261009221227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ld6gQvpAUX+mOiQDaBfqgKtq0pGS/f5LkHlHNfbWbicnxyaULY40+xJyDeEQ2xZD0EMRLq6lgqbqz+hldGuKNaXKtXVHQZEHue7p/PaHD3skGIww2nKok1wdlWd4pUsRwjOfIQQhlHkqOjYniInvVRX71vXy6X5mJQRyb9v9W3uhzEVQVWon3uT4M1S2A8DVh8AKZ9n+zr+ywGBieE3e7hRx+XBItypbC0oqstpKmtOLoODz70moFD64ix7c9wDtEN/r1epVyV2ZVlZdNdMO2a/nlOpgH1t3Psbh4wD12p9d6/KEDspIpW6vTU8rKwbzZZ/flnUh74e10KuJAld8VXwIYzKmtAYPQq147wFo1W/ztApOlVGMAIhEAZztphZGhp2Bb0ZpH3tXMwI2HAWPHp6m1qb1q8t+9VlogsrDvzlwR0Jc1B23wXasC/ZZ2rjR
X-Exchange-RoutingPolicyChecked:
	xmIw1/t6LGX9AEYsCrFh3Md7wH57pkTHQcQLo4bV7Rtgw9E32LUhmnc1CyQpGzhcCErLBQpdTWV7wYVtEOVzrtmCIr18q1hKnVzN13qKg9G3XKbMn15ihrXfSi+sM+chBguA774zM01r0HA8AF+3p+gyOel9uMVIRjioBtvLNpuK5e8pXnyx6hQy4ECGCoNGTS+NTpMYEHm3ylA+dtAXaqI1nHSGPmDF3upWlUxOBBL8TzjelMUkAt1gmDkoVCKOBiFuIK4SGC7R/5bm4h9QpIHKFZesjeKk37OhTMQ1F+DT6hueT5Sjqdm5ZTgbGqP2GQv+Qn2+7Jd7EWKhxZqSgg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:06.2175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aee9310-85ae-4a0a-8a74-08df3b2bcfa7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX9b/qIaD7N0Ds
 T9Tcxs1AJ+cn6bVx/AHu/9tryLbeAbAJo5x3hMltcbtcE5te53pOMt/xHyl/YGLEEEh8qQDRYps
 sRn7qtyDI+shVJVKISXp5ehumoAvTQU=
X-Proofpoint-GUID: 4-WPtu_oCUSSx5OOlaY14ZRIyGFNibov
X-Proofpoint-ORIG-GUID: 4-WPtu_oCUSSx5OOlaY14ZRIyGFNibov
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aec6180 cx=c_pps
 a=ikWRpWbkSoEIfbFFe8At+Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=PwNiBegNm4SnGFYtT-AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXzWS8vBC7Ns0w
 u0P6j0iBr7TjBxzPq9wF8dEGOnjnH0WMsgSEOC57XmWR97Z9v3AjtwB73WgGMJ8TJcyqxO23fJ7
 P7YzNEI4FXqPielQ6Kg2TMujUy7PZ+/wbMEGFmBlDwAKb5vZS5IsSo0nV90MTR6PBc3iBDGI3gW
 9Lqlxum3X0c/QIcOB1o59nf5svRrtfnSaaeGSOLdMtadaQYA/wdJZNjg29UdqHPkngs+7WixlEP
 GXv6djTm3J0JJGf6DNbUdmFCpZ4CmEBy2Yvt6r7O2yRZMk13pJExPQfWvkb8aQEF1gib3iWukba
 aPUS6nQQW0gz7PtXpnLgvVuUmZEoj5QoQsNTE+RQFNxEM4fg7UndALEAwHUMnO2o3FzBsOgrdaN
 lbRElWasHRzB/vwqFjXYh1DCyWjr+eZ9wjrteniqr8qqfl10KGkz/dK6yIaQgLovYUjbbiq8Ep/
 4F1mPmjK1xOvLWOHIuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

This series implements PHY tuning support for the Cadence QSPI controller
to enable reliable high-speed operations. Without PHY tuning, controllers
use conservative timing that limits performance. PHY tuning calibrates
RX/TX delay lines to find optimal data capture timing windows, enabling
operation up to the controller's maximum frequency.

Background:
High-speed SPI memory controllers require precise timing calibration for
reliable operation. At higher frequencies, board-to-board variations make
fixed timing parameters inadequate. The Cadence QSPI controller includes
a PHY interface with programmable delay lines (0-127 taps) for RX and TX
paths, but these require runtime calibration to find the valid timing
window.

Approach:
Add SDR/DDR PHY tuning algorithms for the Cadence controller:

SDR Mode Tuning (1D search):
 - Searches for two consecutive valid RX delay windows
 - Selects the larger window and uses its midpoint for maximum margin
 - TX delay fixed at maximum (127) as it's less critical in SDR

DDR Mode Tuning (2D search):
 - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
 - Finds TX boundaries (txlow/txhigh) at fixed RX positions
 - Defines valid region corners and detects gaps via binary search
 - Applies temperature compensation for optimal point selection
 - Handles single or dual passing regions with different strategies

Patch description:
Infrastructure (1-5):
 - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
              frequency achievable post controller configuration
 - Patch 2:   Add spi-phy-pattern-partition phandle for
              NOR flash PHY tuning pattern location
 - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
              spi_device.post_config_max_speed_hz (0 when not set
              keeping all existing DT fully compatible)
 - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
              op->max_freq equals post_config_max_speed_hz, return
              immediately leaving op->max_freq unchanged. All other
              ops are capped to max_speed_hz. Also require per_op_freq
              controller capability for post-config ops in
              spi_mem_default_supports_op()
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core;
              serialises access via spi_mem_access_start/end and
              rejects GPIO chip selects

Cadence QSPI Implementation (6-14):
 - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
 - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
 - Patch 8:   Add complete PHY tuning support: DLL management, pattern
              verification (NOR via spi-phy-pattern-partition phandle,
              NAND via write-to-cache), SDR 1D and DDR 2D search
              algorithms with temperature compensation, AM654-specific
              execute_tuning entry point
 - Patch 9:   Reject 2-byte-address DDR operations via a new
              CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
              around AM654 OSPI erratum i2383
 - Patch 10:  Refactor direct read path for PHY support (preparatory)
 - Patch 11:  Enable PHY for direct reads at the calibrated frequency
              when both transfer boundaries are 16-byte aligned,
              falling back to non-PHY DMA otherwise; also reprograms
              DLL on chip-select switch when two devices have
              different calibrated settings
 - Patch 12:  Enable PHY for indirect writes of at least
              CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
 - Patch 13:  Reprogram per-device CS timing on any chip-select switch
 - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
              runtime resume, since the DLL loses its lock when the
              OSPI controller is power-gated

MTD core (15-19):
 - Patch 15:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best_variant() with a skip_mask
 - Patch 16:  Negotiate optimal controller operating point before dirmap
              creation; iterate all read variants in performance order
              across ODTR and SSDR interfaces; re-pair cont_read_cache after
              PHY tuning via protocol-shape matching
 - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 18:  Execute controller optimization in spi_nor_probe() before
              creating dirmaps
 - Patch 19:  Reset max_read_op frequency for security register reads

Testing:
This series was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash:

Read throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NOR (8D)  | 37.5 MB/s | 218 MB/s  |
|----------------------------------------|
| OSPI NAND (8S) | 9.2 MB/s  | 35.6 MB/s |
|----------------------------------------|

Write throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
|----------------------------------------|

Test log: https://gist.github.com/santhosh21/08257f0af05c39943e68e1910f342427
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v11

Changes in v11:
 - Rebase on v7.4-rc1
 - Collect tags from Srikanth and Moteen
 - Link to v10: https://lore.kernel.org/linux-spi/20260929063529.1235417-1-s-k6@ti.com/

Changes in v10:
 - Gate the frequency spi_nor_spimem_get_read_op() propagates on matching
   protocol shape, and add a patch resetting max_read_op.max_freq around
   the security-register read override
 - Split cqspi_tune_phy() into cqspi_tune_phy_read()/cqspi_tune_phy_write()
   so PHY_PIPELINE is never set on writes, per AM65x erratum i2189
 - Fix spinand_try_ranked_variant() to only clear, never set
   cont_read_possible on ranked-variant fallback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Collect tag from Miquel
 - Link to v9: https://lore.kernel.org/linux-spi/20260825171737.776052-1-s-k6@ti.com/

Changes in v9:
 - Fix off-by-one in DDR PHY TX search loops
 - Fix cqspi_tune_phy() to unconditionally execute the disable path
   and restore CQSPI_REG_READCAPTURE on enable error rollback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Link to v8: https://lore.kernel.org/linux-spi/20260821114822.4040338-1-s-k6@ti.com/

Changes in v8:
 - Re-pair cont_read_cache with the selected read_cache variant via
   protocol-shape matching after PHY tuning instead of unconditionally
   diabling continuous read
 - Rebase on v7.2
 - Collect tag from Miquel
 - Link to v7: https://lore.kernel.org/linux-spi/20260811183313.1550425-1-s-k6@ti.com/

Changes in v7:
 - Serialise spi_mem_execute_tuning() with spi_mem_access_start/end and
   reject GPIO chip-select configurations
 - Fix cqspi_phy_apply_setting() to also write the calibrated
   read_delay to CQSPI_REG_READCAPTURE, previously software-only
 - Use local op copies for pattern write/verify instead of mutating
   the caller's op templates in place
 - Fix the READCAPTURE bypass bit in cqspi_tune_phy() to match the
   value validated during calibration instead of being hardcoded
 - Enable PHY before starting the indirect-write state machine instead
   of after; the old order was a guaranteed deadlock
 - Add a new patch to reprogram the PHY DLL on runtime resume
 - Fix continuous-read and ODTR/SSDR template handling on ranked
   fallback in spinand_try_ranked_variant(), preventing data
   corruption after a fallback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Rebase on v7.2-rc7
 - Link to v6: https://lore.kernel.org/linux-spi/20260723110219.3180747-1-s-k6@ti.com/

Changes in v6:
 - Add maxItems to spi-max-post-config-frequency-hz property
 - Rebase on v7.2-rc4
 - Collect tag from Krzysztof
 - Link to v5: https://lore.kernel.org/linux-spi/20260717185116.2065505-1-s-k6@ti.com/

Changes in v5:
 - Rename spi-max-post-config-frequency to spi-max-post-config-frequency-hz
   per DT schema unit suffix convention
 - Rename CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk to
   CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR for clarity
 - Rename SPI NAND identifiers to remove PHY-specific terminology:
     spinand_configure_phy()     -> spinand_optimize_controller()
     spinand_try_phy_ranked()    -> spinand_try_ranked_variant()
     spinand_reset_max_ops()     -> spinand_reset_max_freq_ops()
     spinand_op_find_best()      -> spinand_op_find_best_variant()
     phy_read_variants (field)   -> all_read_variants
 - Replace bool odtr parameter with enum spinand_bus_interface iface in
   spinand_op_find_best_variant() to preserve the existing enumeration
 - Replace cqspi_get_phy_pattern_offset() with per-flash probe-time
   phandle lookup in cqspi_of_get_flash_pdata(); fixes incorrect pattern
   offset selection when multiple flash devices share a controller
 - In cqspi_tune_phy(), reprogramme and resync the DLL when the active
   device's calibrated settings differ from hardware
 - Edit cqspi_phy_apply_setting() to update phy_setting.rx and
   phy_setting.tx alongside phy_setting.read_delay
 - Reprogram per-device CS timing (CQSPI_REG_DELAY and read-capture register)
   on any chip-select switch, not only on clock changes
 - Move post_config_max_speed_hz early-return to the top of
   spinand_optimize_controller(), before any state is modified
 - Remove dead NULL guards on SSDR op templates in Pass 2
 - Downgrade tuning-failure log messages from dev_warn to dev_dbg
 - Rebase on v7.2-rc3
 - Collect tags
 - Link to v4: https://lore.kernel.org/linux-spi/20260618073725.84733-1-s-k6@ti.com/

Changes in v4:
 - Add spi-max-post-config-frequency instead of extending spi-max-frequency
   to accept an optional second value
 - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq() extension
 - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
 - For SPI NAND, execute PHY tuning across all operation variants available,
   perform duration comparison, and select the best resulting variant
   by taking controller-specific restrictions into account
 - Move i2383 check from cqspi_supports_mem_op() to cqspi_am654_ospi_execute_tuning()
 - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
   cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_phy
 - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flash_pdata()
 - Extract DMA refactoring into a preparatory patch
 - Rebase on v7.1
 - Collect tags from Miquel
 - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1-s-k6@ti.com/

Changes in v3:
 - Drop spi-has-dqs DT property; DQS is now enabled automatically when
   the selected read operation uses DDR signalling (dtr flags in the op)
 - Extend spi-max-frequency to accept an optional second value forming a
   [base-freq, max-freq] pair; the presence of two values signals PHY
   tuning intent and encodes both the conservative base speed and the
   calibration target in one property
 - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
   two-element array there; single-value DT is fully backward-compatible
 - Move frequency enforcement from the cadence driver to core: new
   spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
   the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
 - Propagate the tuned max_freq to dirmap op templates after
   execute_tuning() succeeds; store persistent op templates in
   spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
   frequency writeback survives across the probe call
 - Replace NOR pattern partition lookup by name with a
   cdns,phy-pattern-partition DT phandle pointing directly to the
   partition node
 - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
   ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
 - Remove RFC tag
 - Rebase on v7.1-rc5
 - Collect tags from Miquel
 - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-k6@ti.com/

Changes in v2:
 - Restructure the .execute_tuning() call from spi-mem clients instead
   of mtdcore with best read_op and write_op (optional) passed
 - Add compatible-specific .execute_tuning() call which can be called by
   spi_mem_execute_tuning() if exists
 - Handle tuning requirement check by controller instead of spi-mem
   clients
 - Add support to write the phy_pattern to cache if relevant write_op
   is passed or get the partition offset which contains the phy_pattern
 - Add tuning algorithm for DDR mode
 - Add support for DQS
 - Restrict PHY frequency to tuned operations
 - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (1):
  mtd: spi-nor: extract read op template construction into helper

Santhosh Kumar K (18):
  spi: dt-bindings: add spi-max-post-config-frequency-hz property
  spi: dt-bindings: add spi-phy-pattern-partition property
  spi: parse spi-max-post-config-frequency-hz into
    post_config_max_speed_hz
  spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
  spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
  spi: cadence-quadspi: move cqspi_readdata_capture earlier
  spi: cadence-quadspi: add DQS support to read data capture
  spi: cadence-quadspi: add PHY tuning support
  spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
    (i2383)
  spi: cadence-quadspi: refactor direct read path for PHY support
  spi: cadence-quadspi: enable PHY for direct reads
  spi: cadence-quadspi: enable PHY for indirect writes
  spi: cadence-quadspi: reprogram CS timing on every chip-select switch
  spi: cadence-quadspi: reprogram PHY DLL on runtime resume
  mtd: spinand: extract variant ranking logic into
    spinand_op_find_best_variant()
  mtd: spinand: negotiate optimal controller operating point before
    dirmap creation
  mtd: spi-nor: run controller optimization before dirmap creation
  mtd: spi-nor: reset max_read_op frequency for security register reads

 .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
 .../bindings/spi/spi-peripheral-props.yaml    |   13 +
 drivers/mtd/nand/spi/core.c                   |  328 ++-
 drivers/mtd/spi-nor/core.c                    |   94 +-
 drivers/mtd/spi-nor/otp.c                     |    5 +
 drivers/spi/spi-cadence-quadspi.c             | 2275 ++++++++++++++++-
 drivers/spi/spi-mem.c                         |   55 +-
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    4 +
 include/linux/mtd/spinand.h                   |   15 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 12 files changed, 2671 insertions(+), 154 deletions(-)


base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
-- 
2.34.1

