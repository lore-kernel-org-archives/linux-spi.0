Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EC35C188;
	Thu, 18 Jun 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768354; cv=fail; b=G2n0/E4MJ6bTwj3XhFBUvubRl6eVPs8LCuydMFfqEyYaOYXicaN6lqZoqTrIb8vGTogI6oPx3/O+v5hwJp7CVNv5A1aWPntRcgMDoWP8EtO1Jn8vOs22Smu6iPtVX10Nh0j5WjhY2CBG/URnDGjxujFiBHrcsP1mXBVL6EDIBXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768354; c=relaxed/simple;
	bh=dSXQ7yGtMygKWf2xJB5ufR1pW47BXOTYoCHdcXE+KWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEGZeOVnnC6paXm5i1uvJ+N3WaEhle7HUpP0a+HlklGj4WLqLiz0+rctpD8FHBLjod44MbrKX9paOZmG76wxjiP8tirv8TCtC+kd4JyPdsnszj0KZ9etXaRS98NJIR8HVe2qUeUNGZzCGZBXvgOsjr9qvkfI5VAdRTMXO7DSCBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VijqzUec; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CFVF57ys; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VijqzUec";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CFVF57ys"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I6wScI2383668;
	Thu, 18 Jun 2026 02:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=nwuNwmkSyUBvrOwre5d7aS6IC1s9Go/8NOOZC8va4
	MU=; b=VijqzUecUcR5UDcXKnAf2R5toMSh/rTZtid1z0g3L7GqDv9UR3HPN/P69
	OUdMhmPosL+/VFFdypaZgksEPeGHLRyTCc28GM6LAh6nu6jmGaY9iF4Ljq9iSBGL
	9GxeGdbKw82UotS9YR6OYTKBzuhYnJT71AVctde8LX7zJOBjGRDNLzltUqsVcqn9
	xFkplDCTf6gi38lvtVNMo1sL0/Z+kw0063sgGSKnCfDRdMKAQnL35eSE+ipc11EX
	QARaJYwYn06K9dtXXU1zP6Ss4Xxv0zFapm1KTw04CzAOtal/Gh24xcNWakI/SbgO
	kGNucUf4WBCSW6XPF0odHrRE22dLw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	by m0380145.ppops.net (PPS) with ESMTPS id 4euthp6s5y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrLk96z5gxCiK7LK2sXvgEnj65q/2mrwwjQTzg/ZQIfOWItFCtnsOBWGT0kkQ2kJEoA8vvsw9jjzYZDqhi3rde87PW2eglb9//MP/4WCrXGKdK3l5vRXR7g0LQeN3d7SDbAs1v7wXKkWn3Bz1jd0OKNmpoSXK00Rk96R+h/BIt0Tkry8CKhRPQI7R0gUFe8SqdEposxK0Yy6WIxZTKd8wqumO0C386BIeH/nBsCTiQLySq/04Zmpp02ZCvLFICRYJOuHFj/UoWxEgY7GeGtlFSyUuUTwBZJi1cz8yWgVtTXM6F/L8rxmyJ+8JUkPGL+vlxvAM0pbNzvksTV5aou3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwuNwmkSyUBvrOwre5d7aS6IC1s9Go/8NOOZC8va4MU=;
 b=DK0JDbNR81GLbS8DaVETM+fnRRrb7Se/kbmzIkGUgyWJS+zdU4dbQxuTwfHcS6ZjWmzDNhDn/evASTvoMWyph2pgdb6pWNBLjHcoYSjJIGd2N5sEvY8PAnEUGkaPqkKGLc+nQ+LTbocdkxIFJe1p+ZUzqNsasvMiACVt23zFPWkc6ie9abcDZVmTULyLucwU1BLOg0Yt7w+ccIwnBOqjkE6hvuJxuwZmBIhE+tC4bB0HESFUPj5i7XCgvly6Htt5UWLcEXoU5/qlHlZUkmXoz+UgQXA5b3e9TsIgFBRzNz1nLecflmzFgLqUMcSVKrw5agH77PgdIf0oXB1JaZ11pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwuNwmkSyUBvrOwre5d7aS6IC1s9Go/8NOOZC8va4MU=;
 b=CFVF57ysNOKzlkrGPhL2BQDVG8Dk4bbk5v7EIOKOkk9YY7nFKtZyezoOYMGi9a1yk0pSH2JBHc/wiYyUYALzigzD60PA4O458eTvA8WPai4KmpmMPUhqNI6/Kkc2CkXzCRsge3KciYgtuvS20wN82MtfQ5ZIIow9ko3NpIWeyeU=
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:58 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::4e) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:58 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:57 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:51 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvp3521710;
	Thu, 18 Jun 2026 02:38:47 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 14/16] mtd: spinand: negotiate optimal PHY operating point before dirmap creation
Date: Thu, 18 Jun 2026 13:07:23 +0530
Message-ID: <20260618073725.84733-15-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CO1PR10MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: aea68711-1daf-40cc-2b8c-08decd0ca86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|921020|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C+hNAnuwWaImEr0NJkZWOUxkbtiyf1C1vfWHU9tcruEtRni7IZ4aVx/xf/WRfyYQhRj+fH8zOjC1VXeM/HWO/to9YJbr67kco9cN42M3O47di/QjCcysIinwQ88HJrtJ43tN4zSeERH6bKFQ6rUPiiZeYyk822T92gwbbnHhJ8iX3hcoQE0jL7ceOhxKlanEtcxESpsyeyw3IV6iFqHJamVA6lgoqI0KbJf213xqX3Q76YlDGG41L8SDqqWEHB8dJl9xgiqUicxmF61FkpDG8iSfh4LsbMGQ8VwsLZe4axqUJzh/55IsLfdT2fAGCvXMLqM0Umlmr7VYYU+jVMiHkmC2HBoD8cdApU+ki/wyL2kzGL8AGGz5+fQbGok5Q9PQlpw/Pn3edDltOkJO1P7LymWDyhmsrFwiJwidQ195stoQXgxrLvXpvcdRH2ir31DgeuaLdp1TIH1CTSkMNwTI2G3nnh3Qe2BfQ4k7x+FQVfsfEa5mQWv5ZeibYd7V1ZEOejZU48YIwRyr6ZXQI5/8a6YqLaaKL6da3ZoGy3GhWH7rXJquM4Sgr5n3wNcAy304z2PZbUpoK3nnhqX4m62YvIQwNSR7CgnOEED+SEbfUTpf4VyH8P5tt0M6a/KnrDrwe6UOVMXSfvj7hKdgYM1SYQ0uutkUtbBisDEnMHJgPmngiXm9YSo7QJc88ws4ELoZwB/9BdCq9IOhYRyKkg8oHuw2ZK4uCJSTglGabSTEIKzijLYeP8Hn3/XDG+A7Wuohqt1AoYcXJQ8MYwImi4GYqQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(921020)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R6JtNlz+p8hTTxAYkD63A4RgWmcQymfNRmSjBxo4nQRocx9y7mI9SJh6/Ol0LpULQzLpf1+llQADwt5dyQSxE6x1iKrYf9YGCYIp7FlzWUinXezTUmcWETJP7MozNUy+j7PDDtu2SVvlWrHAihaZi1lnb41XN6gDsPrsuBPxYVfBorkRulEno+DeBxWKfqeX+yt/r4WHO58/ZK1zZ+F+jF2Lv+w+5m/2dBz0rXZPckur6fDa+JK8xUhtZSBCn2rQfzURBZ0Ll/kJ7O327TefPJi68psuPyFbAVJTz857wsBZLs0Z3pqCIWNMg21yGBlU08mVXf5PX/iJpDRdJNuXwizUDd6H/L9lHKc/PCXQA8T3zegKMPgnNMZ5nHDUPq8V/daLtGKVEy7hua/hmYHLH5Qk/rrLQGTY2F805tBeBA/PXbCAg9n/AuqBciJwVLEi
X-Exchange-RoutingPolicyChecked:
	RelsBthS1Zz448Ce/Loj0oUXeF8GWCEJOiHPvb6d1y4pHUW54ZuevrQz8abxN312dajVjUkmLcldmFpBdCANe8i46u6JcRu8gkqaqUbgY+/1aS82h/UJf9r6gz+mLV2ZtvVpyA1YanWybmPxolwI+v6q6mWiIAnlA3r1jX3fS+4+exZUfnKrFneB/J3cWssczuc4BVey+rsYpkJ6u+VPn+HycW8bqSjdNhr3Lj8ctnaDefS5SgXUvIlf0QKOmMX1aMY/OeSz++xFPHw7j7RofcwNjqLOOcFRdZJeijeHq6QVazo9DuBRKF88VO1uGAT0GuH0/TnHjv/4Zs9kbAgFeA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:58.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea68711-1daf-40cc-2b8c-08decd0ca86a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX4y6ugKdKFZAu
 v+BY3TXh1voEelJ3SdROI5achP9fumIIgG/fYtBSYeLlvmTYLQLZw+EcyeBKwPVsKBlDpXTuGtt
 ayXrM6GXjLDqTLbnLT1uoWGLSYlKeaQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX6adHRXMxSdyi
 5p1/YDaEGBSwcTaODfL3jrxeuItUeVw5GUWyuYVRAvgZM9OeCA8RT97jDCST2fcoDgDNJfI5nzZ
 +sjIG3hFmLYOefj4c2JBjVjb4U6Wz7P1loeaJASNFji543sLxf3wfQfaxSPBA84RKOO2DbyYMek
 J6mbE4XBJVSsD21DcvuXComl3OznrMgwM/50uJMh+ywHSuPeJWL2E6LZY8Ifr0UtaXEAfITFmqZ
 /ywPi/0zutA+pjokHqg0iPkRaZRNipRCZ0E8DU/vfCAGllrTkrevTiEH9ig34bICX4nrLLaABUT
 aS1Qzi4HldjAEI0upCC1s/ljEUtqjiSerjKhn498M+QEvFVwE/xHIRszG0jhi38svSvYx8fmzzg
 +CHROqumRUq2uPyf3eF8q0z1REkXSKi9Xqz9g7yTaSMnpKHGucOtfl1m5+2Cu+SePeC7cwX2k6P
 gy+/1Binvp8kezjn29A==
X-Authority-Analysis: v=2.4 cv=N/wZ0W9B c=1 sm=1 tr=0 ts=6a33a096 cx=c_pps
 a=zj1Wid/uFNkmIHgSYpofMA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=Pt3BfWhVW9kp4qBOMRYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bwwpx50fkWCDU2PKKW15lgunLrJEijvL
X-Proofpoint-GUID: bwwpx50fkWCDU2PKKW15lgunLrJEijvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180069

Dirmap descriptors encode the op template including the operating
frequency at creation time, so PHY tuning must complete before dirmaps
are created to ensure the validated frequency is embedded in the
descriptors from the start.

Move dirmap creation from spinand_init() to spinand_probe(), after a
new spinand_configure_phy() call that negotiates the best available PHY
operating point. spinand_configure_phy() tries the pre-selected variant
first. If the controller signals that PHY tuning is not applicable for
that op, spinand_try_phy_ranked() iterates remaining variants in
performance order — DTR variants first, then SDR variants after
switching the bus interface if needed. On full failure the device falls
back to the best available non-PHY mode.

Add spinand_reset_max_ops() to copy op templates with max_freq zeroed
before each execute_tuning call, enforcing the invariant that a non-zero
max_freq only results from a successful tuning.

PHY failure is non-fatal; the device operates at the conservative base
rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 214 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  11 ++
 2 files changed, 216 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b678d0534297..5dcfaabaf2cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1280,10 +1280,16 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	/*
+	 * Propagate the validated PHY frequency into the dirmap op templates
+	 * at construction time.
+	 */
+
 	/* Write descriptor */
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1300,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
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
@@ -1744,6 +1752,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for PHY
+		 * tuning iteration. Only saved when all ODTR templates are
+		 * valid so spinand_configure_phy() knows ranked fallback is
+		 * available.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache)
+			spinand->phy_read_variants = info->op_variants.read_cache;
+
 		return 0;
 	}
 
@@ -1922,7 +1941,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2014,14 +2032,6 @@ static int spinand_init(struct spinand_device *spinand)
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
@@ -2050,6 +2060,178 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
+ * spinand_try_phy_ranked() - Try PHY tuning on variants in performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @odtr:       true to iterate ODTR variants, false for SSDR variants
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until one
+ * succeeds. The fastest PHY-tunable variant is chosen regardless of which was
+ * pre-selected at init; ranked iteration finds the best available variant
+ * without re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
+ */
+static bool spinand_try_phy_ranked(struct spinand_device *spinand,
+				   struct spi_mem *mem, bool odtr,
+				   u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->phy_read_variants;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best(spinand, variants, odtr,
+					    *tried_mask))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_warn(&mem->spi->dev, "%s PHY tuning failed: %d\n",
+				 odtr ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			if (odtr)
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
+ * spinand_reset_max_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * PHY-validated; zero means the base rate applies.
+ */
+static void spinand_reset_max_ops(struct spinand_device *spinand,
+				  struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/*
+ * spinand_configure_phy() - Negotiate the optimal PHY operating point.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * PHY tuning is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-PHY mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * PHY failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_configure_phy(struct spinand_device *spinand,
+				  struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	spinand_reset_max_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
+			 ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	if (!mem->spi->post_config_max_speed_hz || spinand->bus_iface == SSDR ||
+	    !spinand->phy_read_variants)
+		return;
+
+	if (WARN_ON(spinand->phy_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->phy_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"PHY tuning skipped for current op; searching for best PHY variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order */
+	if (spinand_try_phy_ranked(spinand, mem, true, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order.
+	 *
+	 * Only enter if we actually have SSDR support and a reconfigure
+	 * callback. The hardware is still in ODTR mode here so no
+	 * configure_chip call is needed to undo; just set up the ODTR non-PHY
+	 * fallback and return.
+	 */
+	if (!spinand->ssdr_op_templates.read_cache ||
+	    !spinand->ssdr_op_templates.write_cache ||
+	    !spinand->configure_chip)
+		goto use_odtr_non_phy;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_non_phy;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/*
+	 * Only ODTR variants were candidates in Pass 1; SSDR bit positions
+	 * are clear
+	 */
+	if (spinand_try_phy_ranked(spinand, mem, false, &tried_mask))
+		return;
+
+	/*
+	 * All PHY attempts exhausted.  Revert to ODTR for non-PHY DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR non-PHY\n");
+		spinand_reset_max_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_non_phy:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2072,6 +2254,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best PHY operating point before creating dirmaps so
+	 * the validated frequency is available at dirmap construction time.
+	 */
+	spinand_configure_phy(spinand, mem);
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
index ec6efcfeef83..50a8319cf11e 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -791,8 +791,19 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_configure_phy() to iterate all
+	 * candidates when the pre-selected variant cannot be PHY-tuned.
+	 */
+	const struct spinand_op_variants *phy_read_variants;
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

