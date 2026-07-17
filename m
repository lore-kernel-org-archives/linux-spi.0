Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A839B94C;
	Fri, 17 Jul 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314396; cv=fail; b=qyXHKf76rBB1R4XAJEc+CYakwL+SFoWuOz6MSWzO0GPS0ybMGTyTjP5yCSffCYnbHUxiVtEanmUEZv5U41OzJkn2tRcMCSfqfS0Eq7bdGs50OdEoIbZb+Jl0tf4fSwSIwdV+dto+CBYycxdk3D5HFJiDZxH749xCUwiATuqPi7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314396; c=relaxed/simple;
	bh=QCZfApz0WI4MJamsj+4VqpsLIBBqXuUtwo6CKXU3FV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MS0SS8DEFQFtMIRf3aBVgobZk3cTe4VcQ/EULjQn0BTqLlUJw8uljFvaIy+hntWwOsIN+kQG2qqzyTP7VdDOdcq+UpK4I89ilHYXHu8LBjp5XxFizKRZbOmjrIPgxogE21lU9xvzVMGrZXn6i+qgrUdW6crrvQUxqj8duIBXsHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EhTsaIu5; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AxNtIQyb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EhTsaIu5";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AxNtIQyb"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlrKL1570556;
	Fri, 17 Jul 2026 13:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJR
	yk=; b=EhTsaIu5f8daQ0SmY0JGuP65Vk078swajK84UZh3zVTCj7rM6PKLju+1m
	tdcQLgnEGfE+KLYioJXhO6g5mqva/uoNHJAuHUO9e0JLo1qqKqvBBl6bwUz+of2V
	P/nT6JtMCZ6mUYP8WpXzJy361qimek3IaplL9iQ3aDMyhcfkbeN2G3w/Nx173iaI
	aaUpNRQVBYRmU8+fqcfXVKuUuAR8GJk1WzSjPHh5LUoGq4qO9bPa7k/1SWWnc0XQ
	RnZQxzIVbUZHkp2aZQrlUiVGSWA7LFBNwsrxJGeWsZLyB3TKReIY11K9IPQ65E3R
	F7MxNk0Thb1s/hI0j0r1e+o7FoN1w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmbgwj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:53:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rywdftgb/andqpf2euHevZN64Iaa/IHpPB4uqfET/eNw/GLCmtS00Ir7gDwKBmI1tNfyrwZ9Ni4E4A6wFdr/kE2wywGmi3UEBzubp/sNDetWFaENJPIM7+lw7nEe+FrVV1AnqnK9+b00a5bvQOmD+qzvwbFM24Lvk4d80veyCTQ1vPZWUkezKwqeJYRj5fYjeTwtd+qk8OL1QYleXTUaEqEigkYHev+fMN0nhmqDgSeWyjBya6cFcCmpVezSVq0EPt7dSRtst/bnJkJ495bD8MDP7MZZf+3xANujalMNCT1q4H5lXO4O78KZ3LE/nwOgKs/P3mIm7SvqiPSWKa0bBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=BfIX888qjW3jlxlc736RI+wCDniESYBznAx+Z8TWli4RYH1lQJMzi4tQbfC4P/Hih/u59Gi3DfpeQdjVCm/DKWjn1xd0kjcV4vCNdLg9yoiCiu3ZtH8k6+iunkFy3IOliEFINkjNM2DCUjSFofcxjIXbgmLp6bixRND8PEx7HW+uVRdSIvDg4y382yE5tRLTXXAF+IpNdPu1N46FIubvsiZAo8PMtuE/hfOQ7PD10bIkV/GYx2zghTW28ujaGIs7Rs4s+MNtUghN2p6MJeo9Y/TDe8lqq/1qwgTyf7MDTpCBctnI7Tx+UGdu0FAeefq9BSGc8T2ev0VNXzs2QEyS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=AxNtIQybMfnwtfUDk5U9ztEQFD/mdSSMsUxgCuFxJgZMr73J8ksbxPmv5jVNWlnzAbdzKPxy8achxMwYp8uEQV83I6Mp/zCzfo/eMjYNoIZX34rvtGvz2t+ERHwWVphAVkYGIvhYYyJjUL3YPCkTkfRPdX4IjbOsNgE8GWmcuAw=
Received: from BN0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:408:142::29)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:53:01 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::72) by BN0PR08CA0018.outlook.office365.com
 (2603:10b6:408:142::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 18:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:53:01 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:53:00 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:53:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:53:00 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU53240969;
	Fri, 17 Jul 2026 13:52:56 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 17/17] mtd: spi-nor: run controller optimization before dirmap creation
Date: Sat, 18 Jul 2026 00:21:16 +0530
Message-ID: <20260717185116.2065505-18-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c291d47-a707-40be-4c36-08dee434a06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|18002099003|3023799007|22082099003|10067099003|56012099006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	NWsi9jdtI/YfG5zKf2+YY4HtU7jHlwsspFfBckKDY+ERaAhQmOZ8CTNJsPKr88Q2mbBKaSQZdLdnVNw+ITGPhONK++ho0ObKn2cBLfb//GmvV0WBY9eyG7gve6K0F4zwU1pwk65vLoO1Vu3tKh6+QhQCMFb0/q396zRliCdUTFL0h2C92N2jZKVPdDv8Z2dPt+G+Nj+N9XmKaBRY+NsauyrYwQOYgoKdc5ZyyOg1WhGyq4/y1FrtH8ONqZtvSNaEnrl2XSZNFEgvMnke8s5GAnLZ7AsUDLWCanTy4tFI8TXc41BqfySAGstSrNHbUCLajAUiFRDK9q2dmCQ7wD0YBgvWC1HvMXxIobr4xj4ru6z5T5ZJ5ZnvTXkueGB9RqP2cCZtB9aemOBzvBdROON47nqmDg5U3Ue9MOZr0xU9dn8J1me0Wg+rnokKCUIV59oVOrxXUp/afMeUatfxStRQVic2LQL0kQuSDKpWvK6jL9UbjjveCZjB4dGcoU12e4K0CpyO63PvPvEuvk0AF3//nj/Nj9ObJ9IreY4oC6cecuD+U00aMNB5nPEK1Cw8Rb/4mJ7iA+38NTG8hlC4Qq74fKXGu3QL8X0q4Ps5KMZ+/QUGnFdl1MSfxtpnIJYHCIG3s7AEIV2CcjrENXdC+BOvAVNKlOGUwd2R9d1Jy8POwa5qhXOfySYmPf47CPXdVnQVs+zHpJCtsl2Qgg7tC0O5mFbbfs5vX31wks6+uaJIbYuT+cYPf2iUu9wXLrhiLCgE
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(18002099003)(3023799007)(22082099003)(10067099003)(56012099006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FklX9CBc2DWexH/Eui4jCdOoJ0KmfGc5JbDtmkJfK8YxNvHuAaTYEwLUTkn7UeAKMKbpkg/uxgo8d4VbmipLQZFgircTAHWlFDB7gVx/UbOQtQDCN67LH9FU01YXsTobp1bhOTXz+jPVFw46gEDszvheYaMSk66awDiQFBnpWmD7qALNasEkso9w56oQEv9nm/7DO0Kng5g9chHMNGH+fPjcW23OYSumNf/UOB9GUCuYTsc4SGYvu6TVIebiaQ0OY2kbrDVD67ZWOGFw8ctQuoZB8PDHmVx6DtVgIaywB6fGl+ic7mh7F4qQk6wZAtF0mXK+7xF7+0qOwE0wqEoqku4Os9ZnGQmlFxQP1xU/i6/no7tlqT/TDwfnZcJEfX9jlJb7pkrN12UwYgFrSfIqZwpE3oIvDfBu3Q6v+O1joT85Mj/bvocPQYgPuJaU1v5n
X-Exchange-RoutingPolicyChecked:
	U/lWUQ8qVGO5+je1tKQbj28wx6DXHk/k9UnEbF5TY8/IeppvRGUDhsGEQ7fQtjBUkLkKxYsiJgR4F0aBfzQouGwFKbdH4q9inKAtiY/qyd0DbOqLKNcNFXjMjQH3isQiiYmnDlSQOpVb1cQFhfkjX5zwy8ihkoMqypbAu3U4eeDYimBt9+xd5fU30zHY8LD6nJomB6hmP7X/Gnbb9IuJcBFtXEg0GH2bI1cbqM3PsLbwyvCvB4jMLLXNpiEtNr7MII49BB0aERpwh8/zqiJtJgZ0FXwtgiB5nBKpffISwnHgfPZlzdS7OoAW0kphePmjB11v4bPi16e6bL5E938YSA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:53:01.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c291d47-a707-40be-4c36-08dee434a06e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-GUID: 1Rh2_T_m39VeQf7atppSnFQfcnhBLQgf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX4VXONPxKMCE4
 UXkHQhVj/JrAVL90h2sHN1mclAfBVcmuRevjcc5J2TIkyBHJYmitenTDHM+gfKdtgOZR4V+UBwT
 8VA8fDepK0bW0s5/PTzBO9BO7zf0kex5g+l2C0V57YkVe5AcYtDqWIfMKT4B97n71TfAeQWCSzG
 gRm7P2sZGaArwiqoKd86ssU0At+jHvyW9lzl6otxvj0z+VJR/huSL0BNhVVtDf3c4ZfSncqe0hQ
 T0H3xyAv8N/Xb/aw1Dce+u8JwhXzRDdqvc2+5QZqz1EaLkHh7SHKCDBnnKB8EeWYKFEid1ubiJ5
 Y3nHYPqIxuc26rjTbytov/bjIfe5Sf4SPUNXFiuplwXeLXYIBe0nXZGHIRi/yYEyvJXK78E7BkJ
 Sq+uefxCIcOQqGCPiM7F3SMJSbQiY7x0yGSLUw7xz17OubkSE75WBramXpwrdVDFz5vgyvQqNnQ
 PeRi2/x67SZOIjdGeIg==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5a7a11 cx=c_pps
 a=Pcpo/nSjxNMkuCW/QO6CAA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=dAWDYLcBFR4q-bF-ZFAA:9
X-Proofpoint-ORIG-GUID: 1Rh2_T_m39VeQf7atppSnFQfcnhBLQgf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX+B/GnoF6oUB2
 4tocqRRRDRloVO2ly9QDAyW+AfkEjkAcv79N5ZZTdqEcsqK2lS6cvMEeMmwmpEQv2WCOuBjQkmI
 ngcg2XU7M70iVe+QAVfCOclr/XkCB4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Run controller optimization in spi_nor_probe() before creating dirmaps
so the validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate.
spi_nor_spimem_get_read_op() propagates nor->max_read_op.max_freq into
every op it returns, so the validated frequency flows automatically into
the dirmap template and into regular read ops.

Optimization failure is non-fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b683c077a233..2efcdc7f637f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -216,6 +216,9 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/* Propagate the validated frequency; zero before tuning. */
+	op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3843,6 +3846,17 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * Populate the persistent template and run PHY tuning before dirmap
+	 * creation so the validated frequency feeds into the dirmap op.
+	 * Tuning failure is non-fatal; the device operates at base speed.
+	 */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(dev, "Controller optimization failed: %d\n", ret);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4b92494827b1..ab498a50f15f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -422,6 +422,9 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	/* Persistent op template updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

