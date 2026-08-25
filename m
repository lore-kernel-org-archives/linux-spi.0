Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF238F630;
	Tue, 25 Aug 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678350; cv=fail; b=JHpqFTOK2fFkgtoPYDEPY8zlZadwSrPtEUR9eAufzT0ILgqtCwd+fwrU28q9Rlx01OjcWsiC2/mIMPlOuKi1nIMhfpDt/EYBhuwo+s30TGsKw6khAKX0cQHldu76Nuw5Aru/HP8UNPtbxqRMQbk0JFrv3yyso0leBOTJLjvXiKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678350; c=relaxed/simple;
	bh=jWsZQ8OrcqpFqX4dCEKZbtqhz7uNq3Qk8YJy2FkPPYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjJZn20VaO/lZvHiN9KW2WpJWtpqTQMYGKyqli6+6k+aRVqjYn8UtdZceoessjQ4Gz6UkkneWeUdh+c3SXtS86kPrk5Sa6pHH3sDi7jAXPv87v7EPVpKiJFAOoW4OAaOW3QuyIy7qcyf89+E2mlLyjm55Y2Hldu0hNiD+PPUd+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=C8lrNRvu; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iiMNLji7; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="C8lrNRvu";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iiMNLji7"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVcDE2046053;
	Tue, 25 Aug 2026 12:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlC
	So=; b=C8lrNRvuDlZe/hXoJFU8BwzbXk2A3dmQsS7b6VA9wubcGRspjHDNMmUTg
	63xp21NPJpZMTbAbA32/fIUL2IQ7nC9kvN/QZLQ8QjnJSPk6hiyQX94DI3h2TdmZ
	Op2Yrq9pPfvGPupy8kFc/VeyoMqWSXPIlDLMvkygpNoFUT2eLGNVCfDruskUYS3/
	feYp6FUNDJHMquz1U/uGw93nwGp5uMEzBvANqNsSnqvSzsAhVuYbgA1rpaMVG3zd
	ccMCQWQ+vISAaRWcgG6rSfEu5tFlcviC5RKP78cLgOjPGEs6Tktw2a/KGkcEGj+q
	d8ZZzv4/lR4p/I3hA3Et7c8cR1duA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnm9eq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py5uajQ50s1mfDjvpwfp0zgdJaFvN5KrcJB2naq6bmWj88c0Fa+5yTlEVhduvam3BZi+5X5Ho8/8Oyh1D6Yuy8ahk8465ULy6MDJhhOuOcrUOCfhBJ26jXCt+oK4xI4eeYr+Z36opFf1OtGfaW0PS6fLIQyjaP/8pu6otwpCrDXDK3yUwlb0TFZs3dNAAcF92fbMNzHISyPnpgAbZRfEUM348VN3RDCHAt9zxDyoR3pWHlQxGwmczPQUk55B9mu+Xh5cPkJ/llLx1zeRF+ZbQe+iJfqVTG0De75GdhBDru7EyPybL9x4zWHw1dsUWh+DiU1a/EeMYndZxrBu/gwzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlCSo=;
 b=uCN+irbWCc54yEJxJ3gE09f2Zu1dY3OZJJco67WFWvlETKEhq/i6qk986a6z6pYkgsYiYkzq22rl+/ZauDABnZ2vqQFQUF6Z0jsRAlLHt1GHhXlxZlr0KtNdJ9/bj8v8a/Hr3hgq9R2/l+dsVjdd+WjhYp0LOqvdG+4AGNuYvBDsqRyuprmdPBtAc1wvPFXHSlwZhW6EHyED+cKn29nYsY133tqnl3MtaAugi6j7u18+A5iwZG9YHTL1cq4Z3/7SDz+C2t88JgIcCk/fQWypT8NhUwQUxDRxutrQTzfkWVLRnHvYde5Q21QWbe7wgheGGUzoDw2lU51MMLOouzuQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlCSo=;
 b=iiMNLji7VSl0oHt3mOOLpQ+pWvf8fggeo36pUAP3ziIebtjf7zsBYcsfZVhLbrhA7n0qUWcCNIFjr3mbMMLG/UUzWtui+WGSg/LKV5MRVyNhyQ2NvEQEtsI25iUB/Xz+KDu10IMAg7abK7e1p+6CQcaq4HOSWamgSZiKhsBDDkc=
Received: from CH0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:33::34)
 by SA1PR10MB6517.namprd10.prod.outlook.com (2603:10b6:806:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:18:54 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::9c) by CH0PR08CA0029.outlook.office365.com
 (2603:10b6:610:33::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:53 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:16 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:16 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3U1436664;
	Tue, 25 Aug 2026 12:18:10 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Tue, 25 Aug 2026 22:47:24 +0530
Message-ID: <20260825171737.776052-6-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR10MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9237d38e-0bd3-42a0-4632-08df02cceff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|10067099003|6133799003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	5R5wz2iVVxqr2V6VR453rSRVd4FiKLNOZq+nGouYz+quC/vWcH7qPMvIaWs6XmweOoyUyzH6FvPE3yH/IEIowhNIWtRubgS3fPsdcoFkTwPFyKuZ7qKDazEDoAwcU5V14LnbEBFSsYuJztBRVsHarr5WqWlcjcC1gij9NXhDB34WGBUxq5bmYsxMnYFXNFqeuY3I5G8ONejtCxvbLLTJfgo/C0flMuOg1cKoTvvb+kaXat6uHLzBqXfyzmM7pBZelrlYhrmTTYVuz/ediAzzbSd9eVTvD0VXfo6CxMnx8r84b8Gk+c7Mhqrda531QY8ad/ssX+kK+UBohqlsC+6PLHjpLCfB2vR6vobv5nR3OuzJPuq+/c7i+C2Lm9bv35vfJbq/wioen5CvB6eHWtsxEIuJKnPlbHlLp7BIA8UbsL6KdtFZpCCtvf3rSl2GT/zbPZ/ncxGojENg58vt35nqXcOkp0+sLoTWPbVJo42QhXfi6ezDgPumkxwOvlMbgAhfPE1JGFqc5FdP8MgGJ27erKhn41tANrioAL5UbrABLEQ2FJxDX2IpPI+H+oRWQSDlGWqLbs/oadvWpy0I8oHB7s7o43FWKe2Lf1ljAduIZn0pzgMAMOj/ila9BrS4nxpOj1dUhrj9MJKRikxi4nZ4TIT75OMgfatfR+jpm21/YVbsuKZEGgMLv2LPVyj9bGD3lEmhKf4J8XV5z6qeQ+HIeHXc2QCaf/6jaT2OPcxIn1IH+Q067G9C7zHXmdV0ySHI
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uv2UcwnN4dyxfUowasokXhZgWhaKPFiupbvx1IMn7Gcf02cH0V/afZ9Hl4F8F3D/ruYp0DpJQblG55Zk3GXu2zF8sx1r8HUOsCiDnvg6QqXId9gVdjENDqyCurBvtZV0aRW26iHUuwuxi3WjeXMxvb6vqzRwOL94EWiSeaU025a8Y7YW26x1fqqJ0aFZrtThIkheLc5BB7tqf3wvMEWaoIdSWtNoVCYl0GFKZ6d3y3SFnyh9eTdUWy/HC0UZpupJrTr1bH/g4wLxCkPO24QeUWG0dHiG7yWKSgfBgK+aKc8hb+TvfnW5ya1FTeVJvsp8olIBQEEdWR2pfSaR85B3HY0cG6Hd+1Sfm6Ow7VpmFY0u5wOJZTfq3wGttUZ2+Y14O4AXOKh5zwS8/+MxP5JNJdgeV2vam/HiU4QI5fvAPOK6Ds0bhTXad7bEpCDxrHHf
X-Exchange-RoutingPolicyChecked:
	tKp4eGceDMsTcp9M2/Xte+RCx8jj5pmC8n6wlApwEtoaISUyR8xtTEVYGe8ZtxcuCmbOXNBT8jDJw5O8ssQuIItj+/jGJF461GO7PEvJwLWdUs/7+uesg4lm/WQkGjI4kzud9nRGWapvN9NRM34+NRwlm6UU0WhyFf3sXpZbFfaU3rJAXMq2DoxADH2mPQNWDQVXX2rRxvzJw4kvhbjurWCEF9loAR8yD30z8F9z00k8ZZPyQltGdTozzdvdXqrluR2jdNO/TKbacFf72Sjh4VtSkosAqRrL/dNmQcG5Qd8CKIdHGHHpXcxipSEs+N0lwX56eaeNCGfX+WZ7Ice6sw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:53.1161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9237d38e-0bd3-42a0-4632-08df02cceff3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6517
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXxpfW9Xy+8+l1
 y06wYA88A2Ph1/4qCarDZP5GHgh83uGx2t01I2Xzbt2kagz5EwrhTlhEbYISxcJO6CVfjVQJ86I
 Fh+aS/kJlf/e2Se+hqWLU1U0K/S1KXg=
X-Proofpoint-GUID: 7H02jvWU6i17PE5LefVR2dyP1foZqIls
X-Proofpoint-ORIG-GUID: 7H02jvWU6i17PE5LefVR2dyP1foZqIls
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dce82 cx=c_pps
 a=6EvF431pKSa3MhyLnoL1tg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=XczTfz52Gg2yNcvB9tIA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX2yN/B8UpPKnp
 u0isPSlQ7wPAu19CW2e0j1F4VUSQ6LSukhuJZcxbTWbjOZwNIKIL7VVj6HTVm12vv8DdgZYO1x9
 fIi6xp/5L9Z4ZWUv+8Cpc2MbAe4Lg5HOiBkk9/xJFZaW0gm9Es+g/nV13VloOCOZQqNcqesBnIN
 zWtC/Cio9oZqsHmXw3BpWVMBA4XKjdVAW9XohO6vSY4ibbUxMdaZB6ch8SfdXnzlMtuaXUXCO9T
 uqgB5ag1zuJtTWnKGxhnc+C2Ol+iEvKbV/anFYyDNmUy0dmZ6VcWLbxHIhvnY1Zw2eJkPisf36T
 TjZKQzi49B8PdtftXkevKt4iWUtANHPNUuZccHLdTU1sT5LdxHUvZMbxrA+33CJF4/w/5OdBen2
 lULJCMai3KMfJp4+sdFbJnMiGhLfZy0oH0BCU6FQoGQ9W+jkhHwyK+CN64JcAJmP3pmAC+3fFnS
 k13tGauKHNh94a8pt5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate. A callback return of 0 with
max_freq left at zero signals that this specific op variant cannot be
PHY-tuned (e.g. a hardware erratum blocks it), allowing the caller to
try a different variant without treating it as a hard error.

Add the corresponding spi_mem_execute_tuning() wrapper. Like other
mem_ops paths it serialises access with spi_mem_access_start/end for
serialisation and runtime PM, and rejects GPIO CS configurations which
cannot support hardware-level tuning.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cd4bc4c914e7..79e89de1ce8d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -693,6 +693,49 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if the controller doesn't support tuning,
+ *         or a negative error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+	int ret;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	if (spi_get_csgpiod(mem->spi, 0))
+		return -EOPNOTSUPP;
+
+	ret = spi_mem_access_start(mem);
+	if (ret)
+		return ret;
+
+	ret = ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+
+	spi_mem_access_end(mem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..b69f671c40e7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -348,6 +348,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -378,6 +387,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -469,6 +480,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

