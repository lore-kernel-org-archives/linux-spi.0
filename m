Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B006431E4A;
	Thu, 23 Jul 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804639; cv=fail; b=SaMGvucTIpqWstOLAgZCxnjBzbbW0OFLjhEjw6OSFJWi7/XXClCXL7lB5xw2oK6HukaZfiqoD1k7g9ZKcQ8CwZ0MSREAHr3YCxoWYL9tGC8nHctg+i0sunVZxWfYjXCU2A6l5cXO1a00O30J5wv3x5v9qYYU3RU0ntQDPSuwD7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804639; c=relaxed/simple;
	bh=NlBClPnibM0KySwnwhBAcwY1mjSRn1kZGPB81D3dGzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZRcmH8A0kGFUBlGE+K+kUFfOKwUMP3iQxCjUx/d9b911nBqk4YTZdMlfRX5nse1jCRbInYP7CpDDHqcKtwc2ZSDKE9cG7NDq34tGIlq9HnagF7tCSPbantXgjegR/OlFm1b6Q19t7EF0DMNr+ou4Is/f5GAOapFkmMPfwdERZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=howdu4Gh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tmfuN3HS; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="howdu4Gh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tmfuN3HS"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MJPr4111133;
	Thu, 23 Jul 2026 06:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0O
	Z0=; b=howdu4GhOg+4lF0F9fu5eI1zFLY/XVErkMieWmkfNQQATeF5wBrY9nBkM
	tdAaK1jFja4cHRBmoTZUJ7YmD9IbST9iV44qNm9e5zediWda4TmX4Qwc8sQGYFdo
	i6Nz3pml4sbiJMEmcXXIjmBtM/HC3K05NYniQHckWVtlhIUuCOQza8KKV1AZ0PAt
	RAkDUTdWAaumKIvAA0wI6BYf3J1gm/uUqIc9/qD9SEdgP66gxzjkVB/Sr9uFZ2Cs
	LwF4UBSlmozi8bcuZFX0EqoE9z69/QQRo2pmPuCBwdk7Y5nG3gf5Rc3zIv1mx5i3
	YOUQI4P4+PaMHQ0pHFGsqd1B6wO0Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908cwu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onOyz5PTazSEWrpq0W8eDsEqnCnZIJOgYQxVDK6C5qjJ15MgN3SrkNI6kkJzwqz2VsbJ196x69IPI7pQeQj2ah8/s+u5CUOO8h4DhB9J8HsUO53oWcr701IYKLnSLJxusyIeU8wXHG+6bg89zOZ5rfzGd77MLpxpZTnZ1YP1iDFmTQ5d/0SoXWUbO+g+NPi34LMsJP/SpKzfUGgX/3VBuMM7AV8/dURuaR5JvNgmANqhmSRhquoK5KpT2I6pU3tSRFjH2v5T1RFSQ+d6SgMIshch8fi8aAdR5RLOGFfkelCgO//CzMYkUorBnlUAOMUA4cEXKFflZ9/ahydv1QOM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0OZ0=;
 b=s0sTnQ9BHAQ2OFz3bTa2zETI+bJqR33XNEeZFAjXWIG9fV+79LVZmfr+eF0Um3t0T45Ryn/WDBU0EW0KdHiOkFb0B9snPOdb3AJ4VsDgw3n5j3eHGEAHOpuy6imnrTgl/oOtGtEX+h2v0aWQ4NuMuGTS5fN+BBDnJROOvpVP6hx6lslETdJhuYTbXsPQOSvD8mF5IKGuqeuz5+qDboafTrHSrsjDLgwnGYc2Vv1wqlf2ll1NXTBxyWPT61BNTR5WmJ2EX67ScgIighIOJLW9uHnj4w8/xVvFx/dHkhQHkUIjHsOU++D6jK/gndMWI4Tbob543OnmW1Yydj2IHSQV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+0x/gTksPXU7FZ2D9S8r1K8rcyMlV9iapZy8UL0OZ0=;
 b=tmfuN3HS5Qwv2CgTwJQwE3rMAaiMmaCnG5BTX5yX0sckJMphvg2aEZeP9BTwjLFQj3/Rd8mOyhbSPwjANIouiLX4yJilzxfNdFO5NDIcYBacbULRzUDZUbTLYLryxhLnCdo8A18lNUgrX6Lwn+vVOKnwk7Q858nyHrUvDjox1lA=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:03:39 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8d) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:03:36 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:31 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:30 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW71577597;
	Thu, 23 Jul 2026 06:03:26 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 11/17] spi: cadence-quadspi: enable PHY for direct reads
Date: Thu, 23 Jul 2026 16:32:13 +0530
Message-ID: <20260723110219.3180747-12-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cb9f77-0e4d-4cc5-85f6-08dee8aa0ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|10067099003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	0nm4UakhCcA7vS8gmvw2QAu+ay2qQl0gqs+NvpLsz+tS8ymCAwJVpk4aOmD+1aH8TNuS8B01c5gSf8cueA7FmbFNmV6ds6pFMZB1HoH9uIKuRtXNAPDQYcav2el6EmVSMVu2ChFuRtAFy89/tHwyjlI/ymT21gQm4MalTwSBd6uEC4U7iBpcQs954RvEEq3nd+/mK2YL6nOZj9KU1ftPC6bISmZKXrEiFtgbIX12vrfRWzhPAJLk+WQGajK9cpNqQQuiKe8n6N5bOcvHT6Q6eq8UIDHbENSrcYCF5aYk1R62ZcCVPeTSbgstRm9UvOilJDj8rCi/0UGnW+ehbkcLFh7iZUWR1Mz8D/KPWmgsksH5L/IPC0XqV565jkcpDoTol2N3UwxZLMFejDD4u6LhIB5NY5SsOsYCMmS7vaRhmY8US10snHKUh3F9LcPkKqzs/GJ4N+GQ8x3yLWSy390ex6LTUvqQIzMi93h0SzvTBi7TrLPJweknULfAuW/wTL1inNwBbxmsAJiTu32ssujzKDnkjS0v5/IDJdAV0jHkBA43Y4mFpOe9d4YB1HHSWP3FvwKiCBhnzVGEgvYNjTer1DL/ulKkglRcOuqka19eOPKwTh5ujtvxUrcV7zK7HUBQjM4yZM0dLDXKr4xlc2J4WoZx3Ki9OcXKRqGyZ65/uyHOPpeToRmD6cpFkKnkdfviIKNfUjIF5eUIkB8tBkWU3K0hqzFzkXvH9YV5/rdQG6P/1DltEPKaSyJwYRZUAieb
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rY+nSmfHuzjnzx9I/BuuR+aRnYX+kauVyHw6zYerYO3sTqe0U06QEZO2fX/ApqNBX7CSEkgcUb7LaQ1TaAMqLD1Y076AYI20LpBQSMQ1azRGcHbYV1piLZjJ/WZL7QS7hGIDXJLNdYlE2ZwjMspRYAcsjP4nPparPTMH4olLMIHzFKzTtNxbWkAr9qEQIpxgsjQ/eBjyNJaSiBrp72THy5lLA97LKCurZUBXreX+CE1geG5XpgavJZGWNoWCqsGl3dW3qN9NZpkLYhLv8zm1jjtjnkStTJzk/L+zdiZ+5Y6dItftlNN22MPjaxYZ4srur4b/AifvPXLXnL5wlC5kXWbmuoz1gdN2mn6GSHnWkA6o5eCfYPNtggRqcHnaVD2PJWSAF5imK95ZuPm0HBtvY/7VjEQVTEXNTZfx54RKc1FAZA5dTfvZvAlFip/PPIMs
X-Exchange-RoutingPolicyChecked:
	jq1zy2CAKFIsMwmRDlH83S6B37pccxplO50fEZQwEXD9hAL5umlsvEVR6aeFn16sNAjy2hbOeLUUuEWF2AAaYqq4a6DuRvLZInwLyhaGPVf0CF0+gwGlmI4aOIR6i9siUc8XcMRrm6V2yAqP0FXLHGQ8+YqdsJsFSRmcNn97uVa+2GBCAkfCaLHGaRw8l+cFcHinxfAvwHJJcFBWtfQCtnd1MUzUcBy72+Cd046N24BWNWTUP55rhKgmubVBglxQOWHV8dTGDYFP+Xboz33/nGccy+EhnzDQISsTtLiHsp/K252l7nqhyPm8dq7q1xIr90lrzjMEv2uuzI88bRACIQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:36.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb9f77-0e4d-4cc5-85f6-08dee8aa0ba9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX4Wz21CyMwydw
 HHjuMlpxdgfBYT4cYHAUaMFbxLEjjjDjYm/SzAeFTON7uSsi2/MDfByTmEGgtrG5JrsfbqrnFWd
 uRpbWfY6nKP4ZOcN6VBLYI7InQnPlJ/Zcphm8T+cau9Z6GyXu1DYHgbmF8xaQ6eAK6PYtR+K5Y5
 MBzz9Hjoox8A2LJFwi3HeerlsT8OHy8r1eFvBrHbkRWFLlTe3A60FiaKlgiKIK5hLBPvRGnelM+
 nRIvNQ0Bsz64hVHpSnhP2Mkvm5tFiz0CbxoZDzpaBV23DZojlwyehkzhME56CfQncnWKoBGFsYg
 w6p1DeeOHyaOI3SPXhTZsbDKEyRRU7xPoLSyzdAYukIVZjkKxgxWMp5qOvYoSNHYx7pFXdyU+VH
 eXnYeOJEy5P3za6zij8cceFRMBX6UVvSHSjKdIHZ2aXMUkKTVAoDPSwIdRtRu8dRVRPZCvOzYtB
 WVTrSLI+AzCuYKFu+rQ==
X-Proofpoint-ORIG-GUID: pPUVeKDu8xUHYklAlQvJ3g9iNMQBffek
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f50f cx=c_pps
 a=+kBkz34/1DjdJIz+AnMsKg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=EeSCy0yzjnJx7k32krcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX2RCiv4zlCtSo
 EEyaCAU522JUnkaNddKz+J7PZvp7LkVqhYLsVlS9hiQcWZXD/116UANLydr4Ibukcoi7/6XddID
 29PHxDxoqpNP5YVAJb6WPZFw1h6ybsw=
X-Proofpoint-GUID: pPUVeKDu8xUHYklAlQvJ3g9iNMQBffek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add cqspi_tune_phy() to toggle PHY mode. Enabling sets the calibrated
read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
dummy cycle count by one since the PHY pipeline absorbs that latency.
When multiple chip selects have different calibration results, the DLL
is reprogrammed on each enable to match the active device's settings.
Disabling reverses all three.

For direct reads, split the transfer into an unaligned head, a
16-byte-aligned middle section with PHY active, and an unaligned tail.
PHY is used when tuning completed successfully and the transfer is at
the calibrated frequency.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 124 +++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 322e95b3bc17..35a400073944 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1067,6 +1067,82 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	if (enable) {
+		/*
+		 * CQSPI_REG_PHY_CONFIG holds the RX/TX delay line tap counts
+		 * and is a single global register with no per-CS equivalent.
+		 * Reprogramme and resync the DLL when the active device's
+		 * calibrated values differ from what is currently in hardware,
+		 * which happens when alternating PHY reads between two chip
+		 * selects with different calibration results.
+		 */
+		reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+		if (((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+			cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+				      f_pdata->phy_setting.tx);
+			ret = cqspi_resync_dll(cqspi);
+			if (ret)
+				return ret;
+		}
+
+		cqspi_readdata_capture(cqspi, true, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1516,6 +1592,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1617,8 +1701,11 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
 	size_t len = op->data.nbytes;
+	size_t len_aligned;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1626,7 +1713,42 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/* Split into unaligned head, aligned middle, unaligned tail */
+	from_aligned = ALIGN(from, 16);
+	to_aligned = ALIGN_DOWN(from + len, 16);
+	len_aligned = to_aligned - from_aligned;
+
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			return ret;
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_tune_phy(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

