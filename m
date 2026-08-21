Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386C394490;
	Fri, 21 Aug 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313013; cv=fail; b=EJfcu5l0nxweawTZ7h2QCJ7x130XZ0JBypT7vWKK/1ya5N20IPaR3md0J28faRAp3D6xYrPnL/IEcmsHbziOudM4Vd+bYIRkwpFcR/w4zJMeivWU2y6/GWhLDYA0mssU4n2IO211pjWnG4IJJZ5wKBZNH0IOCWr9f3kCv+Yp8aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313013; c=relaxed/simple;
	bh=bK36dcmI9LM2Zo2CmHrCSD9+IDm/OlfxjIURelHEDek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCX/6HtXYhEZTablS91EOGDtUEZHJMThf7YPpnbNDp4FSk/Hn4/12xAntMKRdqVpjpF6gyDridBvPh2GqxoZPAPAig7qmqGFSae3h+DjkvPMfgKvjqKe+tNozngxmywhOStNZ4oEqFOM5DUORm5R9nxIkfM3RdOOYmRCtVtv/No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RAaYMN8Y; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TYdJgNjV; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RAaYMN8Y";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TYdJgNjV"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KRnH3255019;
	Fri, 21 Aug 2026 06:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StE
	xc=; b=RAaYMN8YtmxIM5NgGlEpNAtJ9FEH+fnZVTo5OdycCOWrWx0v8CCq9QqeV
	bIlYqm2g8q3fvwld/+Khdu8Xw4nj2AZBZsKPFgY9b/odSXAzDKpCHfy6oPNx4qor
	kchCa4UF30luTfFaknOkCydjGUEEwpChstvTr20wQfrDYdW0p6ltxNjLYYYxKfRQ
	t5qpItR+1HsnRZaOlLj+4j+E+mZQZSvD1HlQlGd51fgpuqF7XBDDEauLui7lHrQj
	PtTm3fHPQrR+QTQogRXcvUXcm0AoZe8ruPOOUCdvZnHo48C+oiksIjWyf2ZKojCg
	CI9DCbL7kBZcNxn2Es5+eUqh7pUqw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1dd0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXlNRvNJGdMlhPclpjGogNj60XAb9ppUVMsjmA00wdgM33tpzG/SeviBpE4T5vZeeMigpBBGfoz3xYASBWoqEFBrLYoR4hfSPr90bXsMHW1BXQ/wle32usu8iILrencqktITVEr03DLqGKx7Urzku/eXj4kmEb4DaEQIqLEBYOwQisXZQLF4DuXplTWnhPYy5T8Y0zWMleXRdcPdhaHVZSBLpYQsKWiCXDgho9/R2jzSu5LdUGPkh9zGVOGh40oXPnRMXBbh43rg4/DT35Shuu1NfEm2rj2vrrWRl+C6wMqeq3wRDNcP6F0wtsPe6y+Qw9+4VfQO7efGYXBDO1Jchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StExc=;
 b=kXyXZ2Cjn5c/PQ1+djSMt3udZ8R/DuMKejlWiP+PtWI/5o4EoQtbhJQkpHqxeCQ3y3xUGPaelgg1oGfurw4MsDMvC5uyy0kZ0vxqToaCOA9sI/1bCb4Wo4zq+upS+SmV73LYQNnL9f6AjHgHiWGTAYbKy7gJLDXQikDO9Q3xMmhEbbn9NZuQzFbHART79w1mFnwAyDMNZWuTf0R0Pjo7w4QqSW6d3YCL+YMNmQn7ZEFj9BzYVLm/VPqcKZ5gb4YWQYp78S+0fnG6rzGivEjM4S29RSa35HUffqQcbVGafvviHcDlIc+W6ebuzt63wglapiEjNVb2Viieua8JWAualw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StExc=;
 b=TYdJgNjVGzO5a/92Eh9cV3lJ/PTf7EoLsXWw+CydUWzUYbMAfLgwnCdxYxHS8Fa9qVrFcUrdM6VhbHdgSMSQIWu8B4mHO8a/XEFXD/jZ7kltqp3qu9t/K9abD55zvTs5E0IPG+a4vywIyojRr7iEhCSzW2rlxALIIEmuzDcY9b8=
Received: from CH2PR19CA0014.namprd19.prod.outlook.com (2603:10b6:610:4d::24)
 by DS0PR10MB997674.namprd10.prod.outlook.com (2603:10b6:8:311::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:06 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::8e) by CH2PR19CA0014.outlook.office365.com
 (2603:10b6:610:4d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:05 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:59 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:48:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlf2022942;
	Fri, 21 Aug 2026 06:48:54 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Fri, 21 Aug 2026 17:18:08 +0530
Message-ID: <20260821114822.4040338-5-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DS0PR10MB997674:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6d62e2-14f0-44c4-bc4b-08deff7a33fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|6133799003|10067099003|56012099006|5023799004|22082099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	kzI7rBmN4knvxjzs5cfeYwSfu2NwXzR7bXgxs/K/HHhMulUQTknynk3EwGM4YYe6RO5AKtyHP+mImkLZ4GJfZWyTPVBfMVRyrNfu+mlQLnnVIGLMnOBMlgfXOGcsVs+2iz8XXGsFqnoStWwwQgauQbk0cjvHLhRHbB8P0HeJUfF/cRZPV3HPp0/MKoNeFUIO+KE/a7cLjvnbBpf5VuvptP5ANp40Sh81BW/rI4wu0Gzyi7Rck2mtXq0X5uBr3v5vru26BCk1cfWmszIuO2vVjaLFv7f/Pq062+D1FZI4l42F/BFRTbtjK1RrJOnIuW/bPiru9UtRPerwwOYWJcMqzJrFKO9knhuY8wUDVn1ywsbUbl2px4iN7PXrMYG8lBzvXS50GnNprCN07CiRnqjnJDJQd2QrKC+JMscgY0MysxrKk3jNImFovcIJagX/6X6mLDUAdCI8CT6m7V+PQtDaDMVI5fUh+9uupH7VGbmltLS8qmzOsWpuDvy3RTDGPKYvDeg0OJyZRIf5qK+JshaLDyRfv1i0t+eEshVvG9bCvLYqr7mdcS8svLqZRdUVfXTfHOWhE4X4r8FHsHpiQk10YIhHdNLcsCrH9yyCyTxznamQFkZGDyvvi4yAu9D7w1GtVq5evvIvnE3YucCH5nSFJY1JWUD9DyoqjtBQkw5vOMrZ9Yb81RUnAx7GKI7oZuloeS79maumWPL6/POPJf/ZqkSoFBs0GB0U6bUp+qBWxpgmSn86bC7rkuLlVtWR85MT
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mqV0VGaY6QyUMfxZU7jCUDH7WQ2k+M0Z0VIQZo9r2bBc6E5NS7i8J0iUaAu7SYWby7vm64fXVPLmRK7StZzNeml7MP1OZ/qh01tIg1k7eQlHBv3TSgGV5IY0VQJ6DKfaO9UIC+ux0nTEuhBu0rReDuZ1+uVu2mV/8vn/Fl3K6p05Ptet6ca1i2IoIjnaMArSjDrKUYM05GQ+zEgLqvM46zVv/LOW5B+w8D/0NRtJVuiu4VSz5p5mj+L7nrxAf7g9BIXcXZzegbGsDYvSTlYU+m2YTm8RYnpC9337EIfwpBO43mbynY4DoPp+tFYhPmxV0YKOq6pqUuxyWsG5nsKU0IJOe9qCt8g6EY7JF2lAZjrSN13v09gc258ULFCzlCsduZooRv2wHd46KmopoCcZWVDz8d0qC0/SmSXB5Yj3m1zcpGQZFtyXy1E+QEAdFnPj
X-Exchange-RoutingPolicyChecked:
	pFma8xx+oomI+AssYW3gOepY792DFUU/DjgwKyxvY4XlEPh8tovgg0PmaR4tJ8Eq3SwPSI5Y0wmaB8ku3JYs7lL973PsGpRx0FGlorQXeNGGgdLYWrmFY6IoT2SaGIbSfJbXewzLVoe+ffX3ypdEKtrLuZOUqeY6Kxa8LwA3QcIcxu33o7nITcKHcp0pWC3rBTI0afiZKxlx8bmIbvbjeXtv1mZ256eql9T7QGgbzrH72NnVepXFeY5XJmD+pSa7QOqVEP7cFvUbb51DFG2oq9kuEC1dfpqqp392UUBC02QjM/rlJexzkFZKfxAf5TlZtTUHIPNvmVmBayB1ZbbIZA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:05.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d62e2-14f0-44c4-bc4b-08deff7a33fe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997674
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b5b cx=c_pps
 a=AENbiTj01OTyMXuKFo/uig==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=gHTh7DRQwxBKnKwRL7cA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: liyfRz4nfwq-sXqKg5GC7bWwaiCxn6n4
X-Proofpoint-GUID: liyfRz4nfwq-sXqKg5GC7bWwaiCxn6n4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX2MwRFtSndfgx
 mgaTu4G4W+bIv5sPIAL0R1T2+U4aBXxdlFV2qa34tCx59GXUN/C2faEwUUnRI6xAyXVeQKC1rjJ
 89gND95eOEr5Tg9p3Q6NQSmD+UoT1aA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX7mBEIMgzb4UG
 1GbSS6qDT2zqhDSsJst7tVCXx9WhFYpym0ilI5JXM8Cm6IU+RobV9SK9GqGtkVTywDWr4L41zmP
 O+CeNYb1ZW1zi8MVm0XK4MS4gMZjRFrVocQwZsYgaVkJPF+E2UgI4VwCc8zDKMq3V7JRYdfn93y
 DF05P9f8xjXBUQWsfKKv/Ah7f45MMYkNbtNI2l07RXBPQCxlMsfpe4fB93mmVO96iN00v2AgD6n
 YmUrAZJVyF2l02y3/2aIzlcZr1+/Yy4oX/DRFTU9TUUNPMvPHcUY71O9MAiKbOBPvoMA5HMqxvy
 4isJe9s26Id6WmxM2NaMfF1sSga8OxNFtQQisLCnBoVwHnZIkityPR+jiSi70n4G77hvNlTuOEy
 j9zzbomkz78KXXCPuRsacSJW59L4eIgIbjZ94Qm/+ace/cfWMCjWPUPuYWI/4l7l2GPi5l7mn4l
 LZW2NG1iBQxIW10xgtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Extend spi_mem_adjust_op_freq() with a bypass for post-config ops:
when op->max_freq equals post_config_max_speed_hz (the value written by
execute_tuning on success), return immediately leaving op->max_freq
unchanged. All other ops are capped to max_speed_hz, the
always-reachable base rate. This places the policy at the single
existing frequency-adjustment point so exec_op(), supports_op(), and
calc_op_duration() all see consistent frequencies.

Also extend spi_mem_default_supports_op() to require per_op_freq
controller capability for post-config ops. A post-config op runs at a
different clock rate than the pre-config base; a controller that cannot
switch frequencies per-op cannot execute it correctly.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5f973ebfb8b6..cd4bc4c914e7 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -206,7 +206,8 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		return false;
 
 	if (op->max_freq &&
-	    op->max_freq < mem->spi->max_speed_hz) {
+	    (op->max_freq < mem->spi->max_speed_hz ||
+	     op->max_freq == mem->spi->post_config_max_speed_hz)) {
 		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
 			return false;
 	}
@@ -623,9 +624,18 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
  * Some chips have per-op frequency limitations and must adapt the maximum
  * speed. This function allows SPI mem drivers to set @op->max_freq to the
  * maximum supported value.
+ *
+ * When @mem->spi->post_config_max_speed_hz is set, ops with @op->max_freq
+ * equal to that value are treated as post-configuration ops (e.g. PHY-tuned)
+ * and are allowed to run at the full post-config rate. All other ops are
+ * capped to @mem->spi->max_speed_hz, the always-reachable base rate.
  */
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 {
+	if (mem->spi->post_config_max_speed_hz &&
+	    op->max_freq == mem->spi->post_config_max_speed_hz)
+		return;
+
 	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
 		op->max_freq = mem->spi->max_speed_hz;
 }
-- 
2.34.1

