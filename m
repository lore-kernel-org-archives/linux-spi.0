Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0048D862;
	Fri, 21 Aug 2026 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313017; cv=fail; b=IPNG+5mT85ahiB2SUFC3uD5JzGWJSNt97PvIfKIk0Kp+IEPSU5rDV5yYYPEcbjGZpT0ylfsDC6XzAjEc70wLlXSKm6DUw+VY9xvPzFZKB1L0jIK5Gb9Wlx4GkmXW/QcOHX7pm1I58QeDYXnZCgXdaWVBfx3VR/jxklWo7Lw8O7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313017; c=relaxed/simple;
	bh=/36EtgSHJjgS4ho34Va/fE/UiN7oZO1CuCAHGVoo6vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXyA8ZGW4gQ7tO2vEud9futY/IT75Cuhw0Tcv/XTGxFIa2rFGFQmPHflPBC64+PmNrPfVN0ywFsJ3pYp3DWeV1egYaRnigFm2wev2foJFWMG+glQ22hWN1LQTiMzpKycPbTjeOoTGJ8S4fH2UQHyN7PDTt/trD93sFyJkk7QH+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=SO7SWRU2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YMwCyciB; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="SO7SWRU2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMwCyciB"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KRpb2887012;
	Fri, 21 Aug 2026 06:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1Nf
	eI=; b=SO7SWRU2teduYX9F7R0GXIDa9afi0SuXJlEk64tdjvB7ShDws5zojQf1j
	RZunRR5qPUN8Krke005CNvh2dsx9pFBRxIuIcrmcblr0q3zhGv3UUzY2xXadzt+m
	jlJH94flGOL4T7okoB+onv6hUAdZc53ZdlBSDwldqvlo5YU0MPP4t3Pv8xLHMjfV
	PsiKP+LtB20dL9zgwRCA2EqK2FIlsm9g9Lr7buTdjnN+dhB6K1uCKfqjx/Wha9vU
	IbRv6ObBNNLJbE0L4gJa4M/k4EsPR5A9QJI8Ni1Pi/rwgStTWyhLtSLzHp5FdKFD
	8aiXh3LwsVHL6TOLkBglb1tH2U4rA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g6gke1mkr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDfEghNnzYt1Q2YLo50VdjDCrZh0JqCg95SNFEEFnF0D1xJ/TBy0xjcufNJfu04cgJa6I/bKn1xjyjVyd/7gUpR5rZxTkH1HxpyJBxCzijG+xqzsUKvpiCl3jwS3642PfsYZPUW+dsimCdWP4lon6p0C1TcrQ912tSSlOwaFrcj5rQxW0RAlk0dL3F2j3C9TuyJRSCDawqEFe4rHhanrevUAzF5PcHrdOpvxguU4daLoANzH+aK5Ku5Ue280/u0m2pI7BjfIxVEkvbFpBcn+DZQHAONjaKYQg+P160YXPMPpkC0DEixixVcIjHV4kwsoE5Gbt7m/2rHxufHz9KMyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1NfeI=;
 b=ZfWZbzZL2FucteVHb75049ZFLgSRL7Ndab3x3iZJnspRCIA/s00oOp8v2IfKnc/L17gjDQEW5WKIDUIvXvDc54nZYu2jyEBuLS3ux0pNBMPZfzuv8p7ZWrtIfWVyrJ1u+mW4ktZq1rOfz/QDiWRZ9ebpKIA2J9Yt3t1d1Lk5XYJQPEl097rtE4E5dNfyqgk7zIm7QAdgdIeAXIQQhvafWxiQ0FvVQTVVoyDxBOoy0UnpZq4X9UyCZljvgWUI62hFFNGR2J5lJrVbtEIb2GF2XsIGlKHzZF9SR9ZBVfCo+m/iNrj2+bltd0LEzLwLykCrZ6+zMzuK+1lY1cL8OLLmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1NfeI=;
 b=YMwCyciB9pG2hum2gxupUF2gtUlPfXBl2ngnFVsLHixCu2FwZEelC2vODeWQgXybdlq8xrehYWVKtVGsqaBtygYzoNKcutU/5zCAz8QAJNv9WqjIcti95Tb0joUCn4/C0/FA53vz7kx3VCuIfDDnWYQ66Q7wPvOofOWUuPN9nF8=
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 11:49:54 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::73) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:53 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:53 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:53 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlp2022942;
	Fri, 21 Aug 2026 06:49:48 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 14/18] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
Date: Fri, 21 Aug 2026 17:18:18 +0530
Message-ID: <20260821114822.4040338-15-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a6ca32-02f2-4662-5c2d-08deff7a50da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	vnXsZ/b1RCf75L+qhud72bubYiupJceGoAzgsdrYzZGx4oTqlgldXAjW+c7yaE7YsuEoPaQnFAJmFUENlS4mhHtTq2br/m8bgxQCAK5Y+uxBI5DkOlVlfsx8IZAAnN+H21ORRgMU1C7liYe9Fx8mWRnywGwD+lKQAWpehPKSNp+yr0Aj9zE78LptQK5dnFK7a9TFTaSMy2tVFnrDex5rh1fVGanRvRpbIDHS+tpxjiXW4L7Mqs81Md8N+qzl27X0bqgSslIjNR/8i/V979+Lt4/kkNIwJ2b8uPkYTDBS050LdwPW4WBbo74F6J3gZRi07JpM5Fj+p2tiHIWCZ2zPbYTInVRBuTHOs0IJuEx3DfYMKw/29Z88bnL9eKWQPTw6q+NRb/PCZgcxGlX18mtu0l6WRF33tp72ImPD/OYkjRc+qORXOrCVQid31oYykym4nnU/AflhXQAqR7NUuYJNBZJGEcl6n5izj/GBqSKMicQX/EicgkK50u7WqTQqWBwf5S+d8el+ma1PZKVVk0waPy0swxP0NNasy66bfsrfZi9opyZja++kVJx01/IICaZkVV00lW5Ts+CfCOnhd8yOCu0DY7jhkatjciq8ykpGM0LcK9LVkIpgLHtM09ZpKCHwcjF3ImAtNvvI2SWQN8hHMwlQMQC0wZGG2tRxQyeSGrG6L40TAtlu65f8mzxR9Rmrtj39tt/RBU+izhzviyPTSxF+MeVYSSGU45ruH5HS/7K5BDwmkB/8oeAdjTP++zM7
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJgGf0OuYckrwLWkAkcvreHEOYdhP0Qu4SNhO6KN0sBAtjMSzvzhnnBx4f9gLsj6CRMPdD7gtckhZS7Q84ZpuqiuOVQhTMmn6RowP1RSQbhBfmoUVR2wln2veAsofnbGnrYyFiR/s00wTdyvWwyOGvLQcZhxUo4cyOqp8b9ZOXhs3O1wMxEcjxMDniiPO7wVSZPvLBS7wax3UJ0xSYnrPPdpeoRIskNUaMcctCYgXCqBFQaf9tbTNt/zdj5hbDpJGKhympO0F72kO5otvDTyReoI5A3C/MmEYJdEZqPgvzznG+gJ+bH2WKM/ulI4x6T6QgWgcMkqpcKLj4UP+/szcT8nNIuw6NMUcNCnPudL2nS+o6EZyLzooWmc1zbQ6bET3a1PHDxbei/DIqbfxUlfAdyYHXb/mxGGaeDdC2qyKoj0bUUpnYVcZAKFYDf0ZRVF
X-Exchange-RoutingPolicyChecked:
	bRk5odW/G6wzYKs1BhojFrEcRQBlQ9V5qKT1QuNTz3q/ctzP69J7Yf5GPp+Sm7mfA6T468dXaS42kyq3oRgJsIUjUROhjH1yp+pIDt1bKz0p07ckFGCREpsjavHl2KNbKStNhCD0m7v5U6y/kZEFBWmyXnzIKm7W1io8hrXYuJth41dBaSkbzkdeFJXQ5joSdg3v2iBbAT4NWZ8jr2P0GHwDAdZ3h12WuePAi3GumrsgGc8ab1JVukWRLbYIJfspkbRw3dJIae7JRcsI9UQy51HFqO0RxuSJMU2CJCO2hvrt6ev0dOfyZaPRWKXrHRj8Cb/ETSK3KVtOYb5jPwlD7g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:53.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a6ca32-02f2-4662-5c2d-08deff7a50da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXw0IH/yQzeWMF
 uuI3eBXs0PV2Wpv1hi4O92fUmcPmdNIhkZEviEjpmLjcvPUhX92MJ2WPgMAP/u10BCbecUZLUJI
 jwHuF3BFkfiCMwgELSSsx8h5PCLgfb4=
X-Proofpoint-GUID: fdljtLPmi9KQymp1frUYaohEGbC2GEX6
X-Authority-Analysis: v=2.4 cv=Fp41OWrq c=1 sm=1 tr=0 ts=6a883b68 cx=c_pps
 a=auv0RDqIM0MEGdyBMEg3Kw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=UNEB7AwOHobNk7BaE54A:9
X-Proofpoint-ORIG-GUID: fdljtLPmi9KQymp1frUYaohEGbC2GEX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX4vzvKPv3BXkD
 P/Es4LiSPURz0iKC5FOtHuYUW0SU3V/3+Vj/cYQuJvn/bfiUC5+9+UbTKqhwvZ5O5u2KEBQxMRH
 kbOBZ67yzyKss9DV/ZTRGtGAQZkmHcWkdBqcWxbmD4MH6palT+kvFAq45wZVs3g8jljcAbjuSFr
 kEhp/S6uEqm8wqJc64yyH3KSoFK/u4O1GIV/MOCGGoWRXJayT0Twu/hVXJdC4BRjEeSd5c8A/xc
 c4XJTris1wnbGTzRl2RiV/Pf1vbgkFugzr5inpcwr5KllHvBNI5IXZN88ycueeUjcJcuT5CAWrf
 x/XApE5mCt/Fluh2K5/XPvqKRv9qSBRNerPVYgblZacjoXX0UcKkEoiBk0Jxec8OfNXyrFaYk1m
 fhKSYJRI9A3UgnRrAf3sTtWCgB7lhmnf8n40LlE6NrZjPpnWFsJlspKV+8GvhkTpuCdckLQfWIU
 Kmhx93IMLHSSGo8QC/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

The PHY DLL loses its programmed delay values and lock when the OSPI
controller is power-gated during runtime suspend. On resume,
cqspi_controller_init() reinitialises the controller but does not
touch the PHY DLL registers, leaving the DLL in an unlocked state.
Any subsequent PHY read or write would then fail at the cqspi_resync_dll()
call inside cqspi_tune_phy().

After the controller re-initialisation, iterate over all chip selects
and reprogram the DLL with each CS's stored calibrated RX/TX tap counts,
then resync to relock it. One invocation per calibrated CS allows each
calibration to be independently validated after resume. DLL resync
failure is non-fatal: a warning is emitted and resume continues, so the
system degrades to non-PHY speed rather than blocking the resume path.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d4181b501d8d..c78d4ce1c930 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -4017,7 +4017,7 @@ static int cqspi_runtime_suspend(struct device *dev)
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	int ret;
+	int cs, ret;
 
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
@@ -4030,6 +4030,23 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
+
+	for (cs = 0; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		struct cqspi_flash_pdata *f_pdata = &cqspi->f_pdata[cs];
+
+		if (!f_pdata->use_tuned_phy)
+			continue;
+
+		cqspi_phy_set_dll_master(cqspi);
+
+		cqspi_set_dll(cqspi->iobase, f_pdata->phy_setting.rx,
+			      f_pdata->phy_setting.tx);
+		ret = cqspi_resync_dll(cqspi);
+		if (ret)
+			dev_warn(dev, "cs%d: PHY DLL resync failed on resume: %d\n",
+				 cs, ret);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

