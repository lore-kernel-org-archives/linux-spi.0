Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50113388394;
	Tue, 25 Aug 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678390; cv=fail; b=LChqC5IgbXIvYl5Ll012VA0cNr4s+WV0ydeKI2yuW8ZiOI6o3utCuvLEjE88ULrp2S2AzQOpAziASk7fpiK2PXkGFwZugHE4NPd5QqnUCZlnmhEVRZoweLQH/dq1UYRkH5mAGHi3yJPwbH1kfEv9bCX2TuKzOAa1UCi8R+wVhKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678390; c=relaxed/simple;
	bh=Z6kI0hhZdkpmUOsoj8CKbrqn8KbIVxP7eRMt0m77Rac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmzLTRC7izQqfW6XAqhiyYEIIum6PRUs6VTnVnvf1PF8VNcOmha4am7SVsubqYGvd9b7qNPGcZ8f0TYZhnfD9Cn5YRsZv9o/nAWcLjyteCNveEAkZxZJUWCIwCFu4HLM2ukLUkRPdJm1l3rguwQ9ga8TfxfjlH9K7pXb0w7MCfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Mu3/v3Fg; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AZ9iEad+; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Mu3/v3Fg";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AZ9iEad+"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVbZ72046023;
	Tue, 25 Aug 2026 12:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpc
	F4=; b=Mu3/v3FgzPbz4ZuamY4ZCZ3Lbvfxspg72JkMyncR4kxJfblunSb7UOFEy
	S3kXMqdpYKc3wUOd6C9qhmYtnS3Dp2Xc99BEHFxUkHiNhEfLqYLHM+qJaiJCtGuG
	GUY2a096RruUI/46NLbZw765wZAW/tJKmSZsbE4Dp0/rs534GTYFhd9fI7qmXj66
	Is7Wb/+vx5gyjFpbKkgRgDfU0BOKcWOreoL/iFMSrfHorQy8wz6Tki1gc3ZoKtT5
	1JhLYc0nnXDRCg/2yi+c4g+4F7iazcHdidjo+NMlggBcpWPBRVcoqjYc07juH0va
	gosJYX7R9fLJSAt0Q+gQ8f+sTCruw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnm9jv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT0q9D3HGxE5TTBl7NpSEtwwCyQuzfdNbCgDZT9p3HIvAREPL/z8tUKIpSoRRb15MfsP8Np9cVRShClDprwCJBXVA5Aa99aiSO5mAZa0Q4vD/w6wjvDhaJKHP/MGRGYmRvIvmYlqPwP+pcuj4xfM3R8Zaz6oj/Mf38TLVGX3ZC7kfLZ+PW3a08zpfi7JexlsMyu8dJ7fPoH4sW8bqNThopmLCMvBFvXsOlNotQ0cIuikms1cUH/VDj1DvwpHIESHNanpYnuDvsMKpGyE/Yg/UNfmQvFfXEf8syLMmFkscPlC1j5fdJ/NFMYRBg/PdH8brQcjylxGSEcDyWTGAXL8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpcF4=;
 b=YolcincmGKS27Jb/sBefGIVDoMRecgdkxoxLtexVZLQsbeUNXie2m03w4tPJ7Kn82JZzNBQYcF6464tjssrDjBeER0jCr1EcR13ZEptpYFssS4JGScRd6gEmmlHL6y/gICGhNyDq5TazpkJWyRkUngHwvdNxTFkz73C0c1Z81TP3h9nf+j/bNT/nxKh0M6GuyNZsayga9YqWrXCHfYbBNPy73RkFEIHis469SYzwgAksQGZzLpDXSzHQlk6f1Pw4oWIzKs3WPSyRrVmngs2qTpmVPJK6zJCA1tJoTeCdD5dzufOL+9YCNaBrkqldJjo8+VqQhj5oD0OYXw2k2ape3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Otz2lO7GjrwnPQrwz7VTA4tB78J3Rlz8nvNj1qbpcF4=;
 b=AZ9iEad+p1tE2edSKijl9ZBYPtoSlM0CoIQUMAqY/uOkA7kP3f+D8jdf5xRurGLNrRztZnXR9/fkSRlyizUKMQ7DOboLZr8ntx7p/koFCIHzLDgZak7fgsH+CPWwjLaD3P/iEQKkIblzEHCs++GgSfQIFCvDQQVpyzNpwssP5WI=
Received: from CH5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:1f4::22)
 by SJ2PR10MB7109.namprd10.prod.outlook.com (2603:10b6:a03:4cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:19:37 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8d) by CH5PR04CA0005.outlook.office365.com
 (2603:10b6:610:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:35 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:11 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:19:11 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3e1436664;
	Tue, 25 Aug 2026 12:19:06 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Tue, 25 Aug 2026 22:47:34 +0530
Message-ID: <20260825171737.776052-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SJ2PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e1e170-539c-4308-bbb0-08df02cd094d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|3023799007|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	8A8aYWvhI9xLNaCU9qO6IsyZ1+1Un88JsbSf8gZG6kNPYPq27SjOgRy3ouxm8KCi5bRNa5cBVMB1W/hOwTy8qPcecuvrHdtj5snoJRZHl8KsR05tDdh2FBkdG6LywhwdpnFbxSjEaZl6+wRlShK00YeUI9xbwmrHETYDo1SK9ROZBA23K0D7Mt2BWPb5ONkfb7xsWQgqMdRCQte28wUgiKu+B2qo+m/9LbrQCbFvDZ6aM54rb8BTGJFf8d9eUy2z8zr6DG3jCL37RafWEhLxQSpF9RK9eQuhhqiQK6BBXbcoh6H6nKPttjUszzY0iIBD3fyHbZobbZNHSUzUBLYS2C1Ed3T2vGi8LuRw0pJxuvV9jc4z0J50xJar0iEqWh8RO5IHKGmKoCQJ4CuxzupZVKxC/8q9vwmKawZ+9spYblRa6VoKT/J2parYBq5GBDzsUK5FEPPItHcpWRWX/HU47SG42WFjEADwq7oPkZR5RZiv/tsxjhodsp5MWa+ClfTyW57HfCorevdofeI0D//q6l1b6nxRK/0Ngs7DUiDAm+wQR5rYpExje3tRqqH663EwaiBvw66sO8vHgIBDR167B18R93TGTbAznbMytCqtEzArs2ZH/IObr2VeqI+zgnsRblG1QDnwmZRwqQxZCwq0m3nql5BI+5gfowFK1lYFGscPPzTRh5DpSCHb1EzJmSSBgFqAxUh4Jx1r9Vv9VSMrh9eLzKMgfrYbb2YVpfeJeK76an/uX3/hBOjETehdpgZb
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UX7XubqdJ7CDEDWrRI4+DfplG9XmT0nN1Jh6yuIe8aGIdlsrmXDsacs0YFoiaz31S+4l5lZMgP/qul9uWmtLGg/VDJq9JXIfMXCbEjvq8DwoaT3fkGQ/YrYkJKXkjkxCb6cuTcThA88gzGvHe/CEIHi1m52i6imf0KollaI7h/vsAJ4+z6dMTRhFCYm78a2XyfnZHYRXWd/xgfCwSfwcbCNhNs68JALbrZO7kQCi8OaEc3QknWukoiRwUFAquJLMh4LftSh5YLXjZvKiwiTIOygmQxfs3pR/PANqT+Ds81mu0L2axzNQvZUMQRrmI3179Q4ndPhu1GjguWMNSMS5zWxAx4zNlf3MTC0Ysu9dOu1C7iEL2LrEv+sG7f/DAKe3wR5a/ABQ6PZ7z3Gk/y/eczuqIwIH+S6mdEUj1c8nFlUov5XsXMJgoRkF89ULUZVI
X-Exchange-RoutingPolicyChecked:
	AydVVIBIZ2Kv8V+rAKOgmRD3BpdIV3TZr+ITJnMgKRKMCEv6aabxEpyRlr7wWQaH9XxXdbm2UR5OjSFEb6lZX6c5X5Mbyte4/XLoTi7ToRgiQSJ2fq7T2NfWOKykJ0zxGyqIH//03vX771B2YvtLTosYuYfZKoQSHZgxmWBVaaFGS/iQwzKf/cXaLxoBiiW+NXXnZAk7Vp1UVC22jkDScNo+GaNi4v+JbFM4xWTN/eYqdDLFVQO/0WcGUlRbMEDHvh/tFVOd+yMKxftXBo/Ak3GSflERcBpIBzga3EJR5gKdVh0oG8T36ybgVaYGO8bx5xQ3qyKAUJdo9SmEDo1Lfg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:35.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e1e170-539c-4308-bbb0-08df02cd094d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7109
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXwOEcoWBUgwBI
 12qgkU4FX6WLUXrQC2ElBtiGFkGR94Xachhbi3zXRy2nsZuHv2smNTlnZDaqPZ4wRzKJbf1UWR4
 b8tY+83ivVkfNWCUbnqSsdy53FSoj7I=
X-Proofpoint-GUID: sKs9ONK9DyYJhxdA5wWlt6GscgQ0Hevq
X-Proofpoint-ORIG-GUID: sKs9ONK9DyYJhxdA5wWlt6GscgQ0Hevq
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dceac cx=c_pps
 a=bKR93RD0qenpecP8xHJc8w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXwzXa3kW4AKU1
 Wzolu+Tc/7wH4PXrgTHuo2MVPHGYsKKumlGPREtnDoQgVWnPJK+kv3TPuskGsLKL7SMkJuEbuez
 0Pi52r7dIiPKXFhSL5w6e2Xu3GVVMZEJ+FMDmOW4Z9YR4arandytNsZp79Uh+g/7gjv5S7/f23F
 LZbmHAUXygRTbXHKeHxoqgFdkNT1Xn8DhWL0JLD+YxIN6QwgR2Xg2eUKq2B60uJU36Ax/LjB7no
 rXTPeeWjHitbfs+8Dpk8TaZWwKvdXAbCKeRgo10bvD4B1RKnK1OojV4pEi/WIM39cqRXu8NrNeJ
 Z0I4wNQjUd/lPedN4vrWT9ONROkzpJSuAfEJJktibNOH9nUAdI8wDKR1CkIa/1jN5B1OJi6eecm
 mR0Au2sjDTKUXFjml2X9omxmQIriN5ScXXYdKxgqgImuoSfvJIIaj2XgrtzvwV6YdSa0+HFypKa
 vNRn6gvmfH5TycSp+aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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
index 8bf9301f25e7..7c3341f1fca0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1542,9 +1542,22 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/*
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
@@ -1552,15 +1565,16 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
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
 
@@ -1589,6 +1603,14 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
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

