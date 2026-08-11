Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3E38655D;
	Tue, 11 Aug 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473259; cv=fail; b=nZHtGqr2Gp9KEyoXFhZxme6N44ujKctPHSm001r3ZvmBdoZTVsg9cy7+ApfnzlxuH9WIBWiQtZYNr8Wmnz3px7l3uZZ+lCwobOi076t26NAJpHJSAiHep2jRgoN5nc7P7HEpNzN0/dionzyOkDJfWlMwQaS5/eakvL/lJHl8su0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473259; c=relaxed/simple;
	bh=gRzYTg5YzeP4zSd6C5hQMTHda4VWK0ANUdYXRmJh8Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6cTmctBOkLEB+6Dyi0ikpiQC65voozN1eeUMFgx9szOu2K5712KK7ODdWwEcnZyYDRnknsC6RHaEQdnB5ihXuxLvISD8n9x05Wy7Gt3z8pTwWLoyTQeQK42nbtJ+Qqf8g3SzuBEV53LjD5naM6Jm6hiqrhTJf1rtZrh9+go21g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=O5AHoiyJ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yg+kHzSF; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="O5AHoiyJ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yg+kHzSF"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMepN2174930;
	Tue, 11 Aug 2026 13:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZTWujPJJoyVHaVBDHyuFci9COH1pu2HMwliq1pdCX
	h0=; b=O5AHoiyJYlPWYjNLa1UACzOE/Nj4UlHaXdpDeHIO9lfySv7WMVoe+WuO3
	5vBsq6orU8yHFJOotsNMwlyH5aUvhAeHdIU7JIdrMmIGlNCk5yEBtNcrGebejZSl
	NSIGFJvDLoEOoqnYcdnwhGaqvjcbe6Z/cpbK8JwGnMUpfAKVvlUwv24oGgQg91YV
	syiK6ZfBFBcNhFtILBi4xHJopSrzPTRIJdgQ0Wn1GowwEyH4uc7sAAJEmQ6ZpfeV
	C3Sb8U/Imsgn3fcXG3N83K0ucyxfZaIceoRJIaOh1dWfanYAfs+CvHYOEi8Azp5g
	qS2swS1dNnrVrBBLpSP+Do3POolmQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uhyd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHUb+vanhfSEAbwT86s0hDcoBeTiT6VP2z6MUskXic6KoTcj1n4ymasmhlgkKU5qT1oSVYyiFO79vzlZrp6A0V+G5gvliFWAcixQXDmEXwkpJ5MRxcqVJ0dEOFd8Xei8WywNKEh12g2jdUJW8TXx+k6CkUgVoaLpddFl6lKMARS2i1y0N74xVlnakYMd+Ja03BeM3nZ3tO7OcsYjr/8A+774KUoVsBq5ADCOJQOSYAxL220GjSdCOoT4flOqKt/1zTGyQ90yt07IY9L692f7LptSoSp7tCMa7XpXw3zYf/t5z9t4DJKAsnqxnuDwxUmjlqrE4z4zoWLNiD0L3f83WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTWujPJJoyVHaVBDHyuFci9COH1pu2HMwliq1pdCXh0=;
 b=OxkCVgt5gvafzxjKRWzYKBSHeX3XMLxUUJPhMnxDytIwUVwW5TbFJZbrQUarYacoOk2O3aCrleaQPiJmvXR/Qxg68aXRpRSQIdxXXzIWSbzwwGohGb+OOEwX29sBjQ/9EJIWNTSWjujrIz4HZ/FX6hHToTfczXF7Zgsk8c+DE1vt7/RNYit+nlM6Sj56DbmhPP7IluKCkjUTsARDNOYRdKWaI6aVP/oprVA1Q6TAGmMwKTnD/9iT/R2taerzr5BxHVD9idqxjIDBq+WVXSb6NRk65RKJ05WREJK1GUP2++dya51gTgsrchFc4wsq7UVTbbGiCoNpo1K4kXmOP+8Ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTWujPJJoyVHaVBDHyuFci9COH1pu2HMwliq1pdCXh0=;
 b=Yg+kHzSFWev8LfAtCiX7ZuPd5jVqFucCYuhjI2/OkcfIkng/eJjMIVpEjLhtgXR/iP7KjZKMN8HNCoXfVO0mYcX+QyFFU8k6DR+AeeZSYTmB2q88CVLFdC6ltrRtPkfZp8IztQu48pYqEd2UPcD8E720GrOuCZ28V5/o/qnaYDA=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Tue, 11 Aug
 2026 18:34:05 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::5e) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 18:34:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:04 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:33:43 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:43 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdu659766;
	Tue, 11 Aug 2026 13:33:39 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Wed, 12 Aug 2026 00:02:59 +0530
Message-ID: <20260811183313.1550425-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1272024f-4b80-4482-29b8-08def7d71f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|7416014|5023799004|56012099006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	78QFUSDMU7R4/5PcNLL1Poi1idZHFXCT6vUe3GUCDPxgNMqWoMrzsjUFKMHmZ7+IW4N0iekXDrg+uVVToj5S2WBbQD0WS+VQGPAsMGqWns+jhymVxC+8iKdyvSMAO1lB9z1umHqd6gFTmxWnvYrxSWgStu6R2qkdcAeLIzyp1KMrg2D6RVFoRhlZj+NXSsFKSXg9hKufXHjDzdrD36PXZiVsUbVOi34g0feW5912KTPnIkfwzIkalsNQK+5NK6Js6s8SGVtdAMHsa2ExPXE57X7Etn4XNGiaz3xywRp1GIk/w70Fa7NQGsOyX1cXCYOhQgnczB5JFOstL68aR0sJ7tPICbnn4GRuixe6HG2PJaOwo3Nm/J/nw6eUTBR3kLIbvaEBRHLUYMOfpYzNiF4Ow9fu16q8qZLPe/7m2aLKWSgjID/NscZGlEi2fgh7XbXUOxq24S69jhFEm0nkPkqwFz0T4Bg7RJlnfH9Ks/e5anJIsZefahgCnBuKrKPPI6G9rRqNhwbyEAlvYLTqC4P+/koxLvn2t4PQrBG3HFKXFDR854f6tHoV+svo0dv6bMLtBRdWhAgi/ys9b5KQVfDX2lUvtJWY68UK2FkW6kYCPu+2HlXB2EKVE0Pizi+HYWyNy1Dith/X39KcXoywrakAlEFVWzlMSNqQK0WNr5Vs0fX6slLsG/ebTyZe3ia2KFqN7KpSXxwQkFQnVPk+I9EIOK04Y/XPNpeOj+kvc4iVKTwGBjdp7ZqxxVvFAWFTyvaJ
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(7416014)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J8WUknP+PqTDxqCaUoTRNTwfun8uVEKR74U0gQKMEpMw1fJYEI6/5vDJkhjcu1TLLAWG1/MJxT2UxfnhTof55mGTEvbSJlvRur/8y/NUDNiTX8SLQ5lyXD43Xcj3bgWFMVOQvOU/h/vW9azbaQuhEdQlWE/7OrHaj7plUYvm2KQcOFHwMawbLycGnq1mfggRhqvIAav68soqtsg7FzCcVYrQJR3fHO2ETVUhZiKrov/Zlh8PICI1uU/SYPz74P03l7BwKlod/jDqGrJlC+eSAKuZ4WA58bqwlWsQjP8OkxHBHUso9wjpiHwzYdRLF4HEOPOBIwaQF81+JBEt3+9581w6CwWy/+39r7N3ODBTxxRiBebS5zQ+zdp4zeC6RfjeLj0QL6uBO0sTeKgl2d2uKw026fRPbVgQwTLz4Pp7g5+6sXvcNrgDUAFIB6TeYZgd
X-Exchange-RoutingPolicyChecked:
	dPCfgdoIedWl3wFkaqeYZDb/Vj8XBjMvGO2ZBkR31HGNLi+6nehtZi/igb5xSM3Fbj7RXTm+MJwQLKshW86nwxYw6uc2GkkDfBMimMJXnIF3pcyAEShSgKVm6l+f+JShfXzSG5zutS18VP33bTAh5HOJbH8aISIzREQnV4JSTOK6o/Vn68qlyKS2ZrSzdC6CDiF5HfAHCENAuss3IKbDdS5HgopmgK0HdT3GE8far41yILsaFnUlvZgUAIIyseUeN1bfzU5CYnvL1NZa1VY+Nknfo/2Vr7s0SJ2edCCe4bDP+dLR84l5Gjpg6GEXankENBAtqxHAYf+G8cW0nniqNA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:04.3337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1272024f-4b80-4482-29b8-08def7d71f15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX56T0S9pEnkaR
 Pi1YwIB2j6AMVZlJYEb2nSC3dCfu/akwtG82Q4+jJh1e/xPa/9IFoIEBpN49YofZwsKtuJVcYRl
 f42mWtJvWNERUbPKlsyKs9mI0wYox7fGYIuH0+DaVhwTSprxS9Mz4ELksGRirNyXKR1vdSlt/Qk
 VQc5UShkybW/KYh0xAHb3PXdknVyuKo4yxUYZR1g9XRcFlYPrU0GJMu8oLPL5l1PkkNgS4nDgO0
 hCa/ImFYxxrddCFZzOLDNH9o+qPM3G+KK0QgDmsKrz9sBPXfTm1V5QugWcWu0W1595kt/wUWaiw
 LnNR2XCf+4SAbdLmSdOgfLfUsuIEoRhWOk7ke7sT+HGY65afhLnBvlMZaNKaJmE9EqHtBAl8igo
 xYPOronDun77M47gfe7nS5D68QJKEsvAd4KxUK7JRkHes8l3nasp2sNGfR+3oIIKvR68KRGkDdS
 9UHOPuMSTd3Kd0Vz15A==
X-Proofpoint-ORIG-GUID: pmL68WHegTaC32GYQCeiFhxwrRlDRtxD
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b20 cx=c_pps
 a=5LsHMtEjVXEroYtotTqlkA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=gHTh7DRQwxBKnKwRL7cA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: pmL68WHegTaC32GYQCeiFhxwrRlDRtxD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX903IiU2qXuyj
 U8K2QeoeytqhV0pSZweYqpQ7fKyFX7C+iYo6XJsFmH20SVwkuSHtsp3dELxf5VdetFX/S1iWzmh
 Nz3bYpVnr1SwGHKhVX6ZHy373u9feYE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

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
index a88b9f038356..c74858e58073 100644
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
@@ -591,9 +592,18 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
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

