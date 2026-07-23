Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972245D5E6;
	Thu, 23 Jul 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804639; cv=fail; b=UEX14IY/peeaxjNST29m+7wZNQBEmMpFTrj3KzZ5CBL36YDShwHBNcPA5BGQESLUuwvSd90Z43QW0k+m/Z9XT/dgxKEiq3CjLEaxz/0AzkVFaNfG0mhjgH00hHVQVYB++WfdqYRyzPMoGMrxk+/SPf+sDBD1ILRbLllKAvLgUP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804639; c=relaxed/simple;
	bh=Sm4ubbEEN4Az76qfVMNZTIkkcnGNEOC/u3U9uX+LeJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rihJX4eF1St8SdkRG2LAf7ufmS2WG6tu1Btkf0oChbR51pESZBxQ+k5UExRo7VzNU7PI6zHwfSwONtTAPRP3n5TNOSbrl9TbjKOtgI2rVAP8aVRGpIAN2la4/+fAMKBc+6HYol4qYxLKnLU8AEY+AMbQqI83ytSdJHeLCwtlIdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=B3Rk99Rh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZV08AVwh; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="B3Rk99Rh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZV08AVwh"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9IB202039762;
	Thu, 23 Jul 2026 06:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46
	N0=; b=B3Rk99RhcK8qXoI7uGXOptGkvDypcABTtzL2gEdcWXmbSezKKi2NHRUtx
	4UueOF6+Vvu/wntDj0d1ggfxVs0jIiuijIRKnj4FSEZzQCDb/Red8hzollwiPtQw
	v6SBtMA1yL9QhiQudjQFwsFb4K9ZF5vS4bE8yredcTXgo9hyxNL7eUnBqTKT10UL
	AV4EpZoRVWQX3zvtOpf/PHclE9G9XfPANwlW6nm89Ji+V9bKwXlxuqilcvPrsEJK
	rqK1EBcZoBanq1DgZrWVHtSyxpZEbPdtEY3zVF8odwnkj3pMfSHJBTs8V/ygl71n
	bgTY/SovlENJWViDKclg3fErJ1qLQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfE9M/11tyi95XljBGUMBn8Rhm5K3UncYXvZThDLErHC5fBkfTDYQV5f+X57vtgEcRccJGH6thEu9fQvyGmRrvUYISXkdAwu1Zcxs4jDpZrm86Wb50UHgY9cS+f/12fjo9LwrHWEUcQNEkbiJALzLcp3P+gylQCN3xVaHGLKGlyNvRWH1ljDV9H0f681CDzqfVQJXEHnauj0mdaARJkmfR9WOepxqdOoguoqquQ9N/vudOjpTa0Z4EIyEEBKIrKHlFRCoP6uXgZFVitQ8czn45cPe+8Ei2hotzKuvFoiisI7ILsNG1H/p96Za6fQoJSGwhIKI81Kp0ZflunhRE4z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46N0=;
 b=EZukZ4zHi775Ghj7JOlIBQRpGZmBTg3L+Ml0a7PXOhge4ZfvdhLXxX9tMz8H2Fta8sYc4QwyXCu7jkDqowccq6Cp4hMyI25PTKvo4r+wo5Qna3qrwkwNkANx+3S5aJrNxUUyNMrPBqQNmaY5IAzSzB/9MM1x+aQhp2xjIi1qsP9t+T/fPZnSSC5JK5RznCqCtaiqjwIAcWjMmyJesv+Vi5a2GMc8zILjr8PmBx9/cAeMKEF06qKdtBBI9qnWLU8Q8Bwp/sK2hCNewoWuz1ocgWTYbg7KESJSEAtewsD1vu9wkWZkJt/pTeRQyU3AeTRnXMMzLbDcfdV1bIlPFxGSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46N0=;
 b=ZV08AVwh13znxi4lvcra/7LFjcJi64xX6UHr12klHLRfgiebmiMD3lXBeH7JN83CjE6qJasm7VF5Kqpj5gze1M0NadXTVA8iSag69IQ/Taz4Ar/EILlYiS2O9jUOGYjKVIyJX+FtJTArtYM4DBOFR/iFuufHzfsgilDmw83AUoM=
Received: from PH0PR07CA0087.namprd07.prod.outlook.com (2603:10b6:510:f::32)
 by SJ1PR10MB5907.namprd10.prod.outlook.com (2603:10b6:a03:48a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:03:38 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::2f) by PH0PR07CA0087.outlook.office365.com
 (2603:10b6:510:f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:36 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:36 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:36 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW81577597;
	Thu, 23 Jul 2026 06:03:31 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 12/17] spi: cadence-quadspi: enable PHY for indirect writes
Date: Thu, 23 Jul 2026 16:32:14 +0530
Message-ID: <20260723110219.3180747-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ1PR10MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af49e93-7ce2-4f61-d3da-08dee8aa0b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|7416014|56012099006|10067099003|921020|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jsqzRZp/Hc/2fHfrkKlLx3uZE3ainP5bDm/xjrZbLiu3ZESweU1HnFY45yE6Tyj68oYxPpMLvg1ja7xHAEgI4X40ATV9qNRQYnE45BTALkLRHf7Zh3C85LUX9XQ9iIJr/OwxHfDZMaRu2OSa/z8LFqv0PzvZ8/Y2hQatr1z/J0vbzz18Isi2IMgRYS6sQXhAQcBF6dAJpzQxdgg6rFq3nUBNr9xiIu678Btr8GK27Q9lwdMZjwO+wWXOKDKRRVqnH/PYoITJal+s8uY5cR5Rc2RbdsBYoT7MzkzR9D2pFKs2rmaewV6T7lkczqV01tFf0XaNl7w8bQOLnzlUkfeIA/vPRxWAUE62A85PKqMtd3Rj5epCw64XSzhIQo3QxL+KYnc9hKQPHe5r0hzUHwfaOlumGrTorzKSbBPnheNASL2ieOL9w/QUWhg2EL7gF7js61IyyWJ/xL/D8e64qISwFaGEKuACuDEnm9RV1+7pEnLJnyED1lVCedK3frzAp3Rlo09Uyy77I55OTa4NWU+FVEMP8zsUQBYn/TVJvosTXPPU4M5xbrnYGIu71tZebXIh782jI2mtnFoGWz0sowBt/pqyZva7pRSHEVLQHIk4fMh71sHyMzKkaAOpcPHEj0uGRjyhzanJ4MINp4AhhQMZCAPWIp4HicJM+CwknO4GWh18JaBd+xntPXDJ5QZHADA54q5KWP28j6Fov86YaGzHBEWNxVsfpraJGyw/CDg/dA520MXu/tfG2D+nxxS8Va1I
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(7416014)(56012099006)(10067099003)(921020)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5jZggdddEnAy+3r1IHntWG9S6rhvJLla0bdvtlFhtCOyiwJtmfEyYBUbM73KQWqYzaLfc9IJpJqgFMZDH0GDu7MIiz4ULfO7qImzDljGd22m3t7LNWE5Zne86aVdq/W825goJ0lC7VXTEoK3J9t+/O8NQaPG0zXDt9oi6dQYb3gpkSyJbaJrdx9JDB3apoCdq1I7NtAGpJ7Ni7OpulnHxj+nENaiBiViBXNjCL2GkJ6474imWR7T6NfLH/h66Q/EOG9+9skW64X+mUVfbgrXP6yuKCE3I+Ft7Leo63wfUuIK4coSQ6DGt8StnR8YbxyncFrDcdIW8Ed6MijCsCwdGNNrNybfKmBJzs1hwG+CDC1k0uP94+X525nSlhx6X7DS4hIHAW+PtigB4QatzvbEfBdN1J6XuGimI+dkTIPbbgG4tIfvANtQbDmM7wQ4uyge
X-Exchange-RoutingPolicyChecked:
	Rp/QOpLkMEbeUJUv6fzlBzN7thpNoPTENVztTwB0BOzdWc3PK8syVWFeX09znCUU4kvf3IWnU2GEZMx/hn2mEfuTJHddi+tEW5KfDfqpdwTdwr6aCuhlwEOaoVI4uIzxTlx22NYJi45j7d922BxPRrtFBzM/KjQSoqKxu5+5wugNMZsspfDY2/f2PfkheeimFSDikFCKzbY/ZAjhnmTb37EQoE8VfvAbS2d8YrpAUGrxoGTU2uLjBMuYCuwDFRMD1w2Ph/3qlGds2ffci7sVNBfCXCQgRn65g04pGc/T/4pnKaxpvHH0FpgFaaKi3adL5gAoxYuCDktGWv0m9dbDqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:36.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af49e93-7ce2-4f61-d3da-08dee8aa0b96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5907
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX04ZISOoSZ8/w
 guEhBVBu4PwiYFYN91VAMeNZJF4Ytv1F3tZvQv2jBWy0/aXdW+7sZr2tZxUNkwGJtMW5Pj6cQ9k
 g20dR/MemaR3YdjQ8Vqq+9VTTXU+sg4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX9Br3/QWzZcqV
 tc2S4vMdGq+LTaWNGRau1AqYKAsE+L8N2QP6HmIuUv+gxckd0lPq6xNEaWUKIOXkMuZ8qZdSS5D
 YGaG20EvvqaoE5SJDJ0rWg/1E5q0qov5WolnKECqhznsiweq4TckzzLUTJumRbKm/SB/tdNAxMM
 xbSVi4sQcNAJoaAyIB+UmecjqWscP66myYo2jCK4qzCOuHrEGgJFn1s0Y0VYeXRV8Q5EQaNEFpm
 0QxbGU7bHmPdjHJGND1kR986lQtan6Bcph1n0rq8GC8Df5saa5ESKOjPJnQ7NIQYjqJyeg3c3Xl
 TC3ky/x2UewPmWPpDm1Km1czgcMeVxGzpDmngdF2hY+PB8BZZTaK7LpCbVX3QM9ogBokU3KOUTa
 lDkceNcIupd4YUs07dm3VrjLligMyahZzPPJIoEN5AAdYSTuGyV8lLZB6iI7BihLMdvBMWmyi3W
 T+4n0k3LBdsebeCzMHw==
X-Proofpoint-GUID: KO_OyvUiwXYl-dcKRFfreAcsTVJENGph
X-Proofpoint-ORIG-GUID: KO_OyvUiwXYl-dcKRFfreAcsTVJENGph
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f50e cx=c_pps
 a=0JRlrhwbVVPmsaj0kffiDg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=-A2lziRS1w5XIjWNnAEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. PHY is activated only when tuning completed successfully and the
write op runs at the calibrated post-config frequency, matching the same
frequency guard used by the read path.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 32 +++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 35a400073944..542ad331ff16 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -153,6 +153,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1335,13 +1337,15 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 					loff_t to_addr, const u8 *txbuf,
-					const size_t n_tx)
+					const size_t n_tx,
+					u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
+	bool use_tuned_phy_write;
 	int ret;
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1377,6 +1381,18 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
 
+	/* Use PHY only for large writes at the calibrated rate */
+	use_tuned_phy_write = n_tx >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+			      f_pdata->use_tuned_phy &&
+			      f_pdata->phy_write_op.max_freq ==
+				      post_config_max_speed_hz;
+
+	if (use_tuned_phy_write) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			goto failwr;
+	}
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1425,9 +1441,15 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 
 	cqspi_wait_idle(cqspi);
 
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return 0;
 
 failwr:
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1562,7 +1584,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1589,7 +1612,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1805,7 +1829,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

