Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F4332907;
	Tue, 25 Aug 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678337; cv=fail; b=MoW0sFPm7yLPuIC7DVgWH0FGVpQ4GZyhtYvOSxGjRuMLai/hHjoZ7UQQN0bUBUnmLlU1Uvv9zgmbA+1HUZQw+5fofZxCq8lRiUEKhjfgA+pHdFnqTTla2y4bxLviZYxOhZ0sMs4HoCuyQbUe2/X2mv2nLzZvoWb0A6fXVekkZTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678337; c=relaxed/simple;
	bh=gyaZO0E+rrhsCMTAN/oPbCVoC49S8MVm2o1Jd4zzFPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwVTC196OT+HE4TljXOBXjsJm6WPr0bXWM6AGguMtlD3wMiC0laumO0/w1YQss8w7xkOVV4WjCp3gXWEOp61vt1c4O3E6GF0RTl7v4u88i5PfBSGdpuNlG7oI4zZg42v5lhuV0kXHR3+hKiNh8tNilM2v+gbWO2puqiJWyNBS4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ol9fwn9w; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=el3ptP6k; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ol9fwn9w";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="el3ptP6k"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVZDS1165228;
	Tue, 25 Aug 2026 12:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WqKbKD/soeFcbh1lJqjJKm2uSOxeSrqp7jeBsCY4k
	UY=; b=ol9fwn9wHrAyH6gTNXbNw5A4at4dFniXLqB45fbVvb98jiLl1o1SQNfNE
	rKv+f7NIGCeqviRVyxD+ph4sMkYt3oJdDoY8RJUJbwUCnFWPY6GsHnnzxuMOFPje
	4MuFVVpol8DieuceE8CfZZfkAMPADox2Z8l8oRHQPjD/oYRNb0NMGSkvH3kFzOmc
	iaJakVjpuWuq/sDO554LbTbgyUmkHrx1r9pgZ2nSF6b80ltew3PeSW6yY7a+e98A
	orH18UC9kWuObNl5saXp93/2plpKgcaoDdY2jOh8zrmRFEilqmloA4k98Uc+3C7k
	JEN9wEWFh1XdDyKLXoXIiAMysU6CA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxmjhr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay9pOWtonVpKD4OYMjCfIp/LgE8E0eYoFAl7NMU4bRlZ/K33Slq1gttfc/hUNls25qh25s0K1UoMitD65uZcLpArb0LfC8n4iLChj4X7IH8XPvHu2BwwUBfZbPcOdCUte1G18WdAaoi1dDA0BQGCrX8N88tr9sTvXajO7VCGkypCBsgQz1sHyXt6xQzX+QhkowOIWKQDC4tq0/wwVhOPy8/hXhkN7DzPrYyBiUmlsZSF9h9mTVmGBSsQEvgTVPFoj6KU+rJms3NVvJ65zgIVh5iCW0oFCaT4bM9kDC33jsR3n+u0P3iTep2ovIniDkxL5wZXCIaq6Wfvk77sJ4bT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqKbKD/soeFcbh1lJqjJKm2uSOxeSrqp7jeBsCY4kUY=;
 b=n7JvM7M3a9Fx3WdBQRY99NhjiJFY9TJIuPCUnNHtzomtyhDqDND5MqwoP/r9sUTd4I28XRqcyg8MVFJMHmbun+PsVg7mVkPJdlvhs2MZkhJs9JreXutFkpcIW+C26cc8qPv4fbOLW+45ELYmbqSYHTZRSxVa4NhxW8+W1RWKIvXY9/2uWL9hENy5eGjPHXPWz5qFrPg2FUmMIMe4lz5CGGkwxphfZyQ+df6NPI8nplGA5p8OeXJhiVeS+geo4jCx7HMojExqWhOFnEwbmr4gbJLjFbkt3QYw+VlGI8n6olpm98P3d7RwMK9qGBnupfWUdX8rcTg/CFDVeBUqZJJfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqKbKD/soeFcbh1lJqjJKm2uSOxeSrqp7jeBsCY4kUY=;
 b=el3ptP6kLCaaXTW+ZpiTfz4IUS1Lt03YGapA77PAKD96Ry8in7u3HuhUApQsOuRAQwDE7MYFq3oIfOUp9QRnjcOaA78LS5O88+S275Nfmsaq9o1WbS2C/4QGIZ21plFH47PzoduVJbDMOb3aLtRACwSHSjNdbeHPXQ7YpGM5gjg=
Received: from SN7PR04CA0177.namprd04.prod.outlook.com (2603:10b6:806:125::32)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Tue, 25 Aug
 2026 17:18:40 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::92) by SN7PR04CA0177.outlook.office365.com
 (2603:10b6:806:125::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:39 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:38 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:38 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3Y1436664;
	Tue, 25 Aug 2026 12:18:33 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Tue, 25 Aug 2026 22:47:28 +0530
Message-ID: <20260825171737.776052-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 631de544-6b20-4871-6e93-08df02cce7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|23010399003|82310400026|10067099003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	XcXDC+0JnUOlSbThobWJb5Pe58da33sCGwVGY7hR/tFcmv10JDYpOcQ23vs7xC4uFEZNOWise21IEez+nWdQnVPqWC8lRFPNnhgFDT7E1hoB2IUeR27LuIJm6bJjie1e72Wht+yY2EHqGjfMP4X6j98WaJXfJp9obGz+VlSWtoybgIiaTx+2MPNmb2Xi+g5TX+5BczwNZrZOSZcOuc2V98DT4gUyhoWVXS79KbnjW/0O+nb4bExyTtG7Gl8UTIUu4DxwhxO6QcbkjktvyblRfJNEpurOFTQNqxEfreODRyCnxYNXp6PW6fyYHjXsQoRKrnLGfOIt0OOQ3p2xOHPqcHWR3E0oCdszT6Y9/YqjTywHe2hferTzLOMEGEKRwXiO6Fz5/NgrRqjdrYfqSRJpSMIZFbQs3qXm5+DPP4E0aXFd7cO8Y2pSYmz1s02fKA4I/z5tg0sINWYQ6TISbk/pmg59o9KufTEgV177atT+7EwQFj9U7/uOVr0gLwnOnz/dwWMBd+ypnP2Acho+4nx3VYS1T7iDP0vUPprj23d9EBpPnJhjdrh7IK9GfZFCwjdcQbyIHpXLuahum+uxQf5VVJFdAOqdPkLoQ5I5L4Ggued8PsLLoLTzqEIZj+2VGwbP7qhKqOdvd4QP/aCjrNW3KfWiWbPnkLOqXh40zUzWaO6m4IoVmAnq+nYZ/6ywFgkz/HwK34kwT4L8v9DXbmp+Aw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(23010399003)(82310400026)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zrjdoOhMvEDSl2pUegKCCH8r7AatOgQiFKugZZ4QefHeb/+RR6kJKNx26iklHyW7zNdBAhD2Lk7SxAvhC/tpyoo2eFVRk1TVtuzAwXkkFByHrO/RUNYezj4XFElTB6uRXnjrpcVjOfA7U+jNuwCL+Ay4jIkK6RAKL5QtdVhyGyGQY98VzLKfOXDi+szNgqNI6vchynJsX0dDUAYHQpIilJU6k5jOiwl697jeafZ9LEOgE6fe0X+4+YG6TPcJ+HsSVD7zZlNbrmVib7E0oLKtNrFdutGyAYjZqQuc3+G02KTtOhOT8W3soJ0SCfv1cp/JNQknOXAmQV1pCABS37otViYECcSOCsLN0FI/MWhSBvNqKZ3Bpl6h6/yNV/F9oQn7JcizZxp5R3I+SFnElMfaStka5fu4aAwm6O/90bARue1n2PF4SUexzy11a6vgKD/U
X-Exchange-RoutingPolicyChecked:
	TWjrkSZ2OTv2FzC8EjW37kLGcc8iyCsAhswlffQS+H4QTRTRud5nJJQaU2AywasAQOXJkJGBNcbxX7OwQZxJV6zBsxZA6nW/N06eopz6Rrg8NxfjOGIWalGpdwT6LbPU8ssO/bOrVww/jaz2HD2Nv5dnu/H2UlSnUwM+D7PVJM0LxUi6Fwz7aK74cYotzd24byWEPnMLzJHWziZz4ob+5ZOo2xyu0ZuW/o9n0laGSyXA8vMEt2WcVYFwux1xKptmnMaEHHDZTpn9hJ4P66sLfBR5nd4r+o3YDR1pPIP1DnuOcf+HfIcF0onVjcheGwKReZX8BzUlmHEj6+2qhnSHCQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:39.7849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631de544-6b20-4871-6e93-08df02cce7fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4YukMQdXIJRw
 u8FRgqz/NCZM2nDo/GFN79c39xfHPG788tHDTSLneKi1E8c1Qk1iIbnyVTTp/Y16cVcoIm/DXOG
 /ctu922jb7VkNo0VuNebOLJSNboQTTc=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dce74 cx=c_pps
 a=WZnQmSLi22PDpTVDJlFiDQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=T-kh0MV4vbdY-aS4Zb4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bbNrsK0vP1_QW0WV13k5VRph33cGMEcF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX2Zl19k40AcWS
 AWdQVX8EhkyWE6RaBoaQYCoLdQOpUi5DxEiGMhpPiHsC5Z1WMr8CphWiBdFV+0ukjRZgSUYiRFE
 YUpQGKpX6KiUBmtxIPeVZdN+LDtVROFJ5Jyq3LddGmLdn3+YHVPtSPn0Md7lkK0ilnSgn1K+Z89
 woEQZl/PwTjq2KPhQFdYC+9pm1AwOoQWxOP1R3TZX2xoqPwok6G+fTmDHRN18Jq8OWvMY67Sbt2
 +FxXS1D34oQ2/7Jslha3ookdqOG9CzoRd+iZKXbZAl1s/owVjqbYITztQYn6bQ8lG4j4DMU9cem
 Aaw12+37kTUjCGjRbJyCj43jfHrUvIak74WyZcFfXYWRJUZEMBZ1blezLpjtFZmxaZHezyqF2wG
 xDMRJy+AurnmHXQdj4LPhoQSsYr0fRt2ZZtyNY0NRWaJStTfBwpUn3xNqZGbuUwXBnrbEDSHrHR
 rlp2+YEUD/tTyThfW6Q==
X-Proofpoint-ORIG-GUID: bbNrsK0vP1_QW0WV13k5VRph33cGMEcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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
index f7cda1bc7139..fc33bbf56dd6 100644
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
@@ -3216,6 +3217,20 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
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
@@ -3854,7 +3869,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

