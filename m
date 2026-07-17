Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D383914EE;
	Fri, 17 Jul 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314392; cv=fail; b=pkWk2xTLwBjUtGGoCf4cxUikTKTZMSi0Y+chbO2h6JPPczbb0LsAhGNff/X4v/xIDCAJMEm58AvdJDAl8dhRbfibS6suugqHH3kJueV0pT1SD7nvQPPgV0r7gQILbIzysMOL+0Bz3n+tfDpaK4fhXZBjwbRrsp52XoSnUxqUwSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314392; c=relaxed/simple;
	bh=EgPd8VbcyrS6pF5XRBydAegNzfoN1Y0GfOtUmoBoCs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMQwTpaTnxCFKoNiDuBPUAYpAdyozTzG7ievGWPRbY6C+97xasv5t856mreqLI2i5heJXNOMUFaabl4p14eFSz15sP67AwA7hDqiKnUGQzD7ikZCN5UB87bV0PcSIFrkACuejiIm602JWAHSyHc8HrKK5cr1M/aJKJ7pG5aw9F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=gTOdtuPi; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RsWRe+Ds; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="gTOdtuPi";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RsWRe+Ds"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlKQD3222740;
	Fri, 17 Jul 2026 13:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhh
	gI=; b=gTOdtuPiiD2GYRYcrg5F5aRtuOCf+0akK+ORoMx1ET0+KC/TDMu41uwoP
	4xUFSbu1MtuF8CbCo7nBAAFJ6p7SSwp75+mGKi8HecRhKsh47AILyi6YW+hOvZuJ
	I08qFMYfNga+u0DtfhbPlrUki81JIjsLpV4+HcnDNK/jU4b1SGnd+L/Pb/Btwi5f
	64VaDH5R3W+pZCXPo0CrLffnVIELrgm4oZepqLz1wuzRk5sflwiEgZTQi3r5+6bF
	V/LskUXUZu4ynLy1A+8EfGyj66sYSmF+0qmsxYdbjLOWlAVPRF3mGlbeZfoPHKPe
	2RzJCGOiCyvHrqOdpJP84QjzERJAg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3ju2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:53:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDfZFtM3/oyfVeNg+XZFsd+tlAGhmOZABVvIOg/b7ez60aeSi0eLbgYVx0/uoAOzWhhHiM0itqWhmhF1SLZWLMT7j9Eu6Zot48GdWa0Nu7wxwJMEecGSUOGmUFyirphwqXxfIdWnAcfBaih6mUGQhZTALngL+ADWmO8MiRZvCt7Ae0Zs/XPB0KUs4VlNXy8yDZ2CeHB48ezG/dgJr6Rg/CSvon6cbgjUr/0uMTaSTRrxqFSDMNuD2g5O0Yfmbq9mLnzmphS3xbVTXeOql4Z5P2YU/D0d7bLiFTejBpybFisky0p8d2M5rhIIOsT2FMMi0us5NvfFeL3ncO9FiJe9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=c7hLVT7dxxmgmnBo89hX/3Ka/uVQZMmqhRxWKzai9niyHNJOcKy0nbvVxnm8VyIciI5aLoH+7NY4C5Hs9JXvAqZXlMyyWzetIscRii8W0VNWaLgatlMZuXSLa5b5Te4BgpP6Vur5ZhxWTOughkNzmYQtWzw9sKkkVDS7vcRIHiQMn6Gav8X6jSIxyZYe+HcaHUNqO7bTjHvbc8DgSs7PlUiWA8+1fBySMylKMuwLoxAtrZPPN1IK/YDlh0aFfeSgjRAlgYo1C5Dm7TZ+CkFASESdKUGk/73SHBb8KAeiY4jmB7dnA7CQMkCj+bdOVl0pKbi/XFJrvefuaH69JiLYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdoYsWBenFgsbLRwW1KUBdy/3KraCabI36s9hznhhgI=;
 b=RsWRe+DsbbchC67epfl+MP/kWZ29guB80jh+COlb5B4V4DVoUy7obwZOjNwsol7KFjzlTPa5osLre/1b1t6XbIUckScdVn0d5hXrOT/6tap3ap/hFgUL7XloidjRXNwC89mm4/Ic5bBm7fJuH49tV3ZW/pqAWTsuWqCjxvu7jcc=
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by CH3PR10MB6858.namprd10.prod.outlook.com (2603:10b6:610:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:58 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::55) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Fri, 17
 Jul 2026 18:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:57 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:46 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:45 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU50240969;
	Fri, 17 Jul 2026 13:52:41 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 14/17] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Sat, 18 Jul 2026 00:21:13 +0530
Message-ID: <20260717185116.2065505-15-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: b8831eec-6bfc-4371-226a-08dee4349e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|82310400026|1800799024|921020|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XB5Do4i6BnL2+DmOL5BOsSX/jo2vH2Y348ahM9MSyXbpsPB3vhYoLwqau6eUs15xVPNNI7fToZ/ZFkAWzJ/4cP7rXx84EieP7kdd3Q2IicaGs4as5I2lFd0oJVnNievUuPRLpCbOMSQM7ftnt17EhZ+DAEOZb2pbnYpxIQLgZGw3T+8VNB6y1ospRs9N7kGz869ocPowxPvz6bUebZb4cJD4wIrsu41Ssdncu45hZOwMvvaiIndqhyqnedCt0ysN/sNZDzLLXu0vVftxJTt2JqIwoxM6ZvZRwqKDKjbqPuUo5FicCpeR/5MHzOPCUfBTh4alBPma4yzRxlrMBlxJIMsCU06DhVPRTjzoj8HFN4y43P04NCaVBAeZ+KKEUC96TTaSMWq6EDRtUG2/cXlDCkf8UtEbF+DlcyL0zqCNEV9Fyp6dEOP/thgWsX9gla/Zxa2EjVc40Vcmg+n4kK+Kg9hW8MMKupD5SZYv5MT7lYR9C+68uNz7F43rGME1xgSyha9F1vOL20vY7X/T9S2OPsmUvM9Kn/+RYwmKiFxPd9A8JYGSYj2gZusxofIlWqx22IaWkZXDxbM6D5m8Qd4qTg7ucwdrYrpn4IXI92IueHdb+zVwet4HuTvELvpwPX3uLzEwfoT/6c7wZFRX+27gSs+oxJFQfw1uPrfophcqiAiSTQOtVjX5OxwOEwKCvHAJQRA5nTiYeVyCGxltoOLR2tCVe+jAhN/KuRLDMqSxRK2rP/O4BAq4ivZp78LWmCyL
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(82310400026)(1800799024)(921020)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+tiVtGdkZJzM1FQyuJPNNvXACkQbSCO1tbIKMXAio2ErHckctySbBZq9/DnSZjGgLyfYB92lVx6xACjj3baFPhTIzuhP4031yLqCrWIkEZKR7GqxsS2em1sqGQUPaLlDpggJ4iTlxzAhrsH8k3wB4xxrpdndCH/dSJ0iLhpsOHqnx5R1ldQhK/Yad0SRGl/ewYdWTfjmKMosx236C/l9Djxv0aBpJ/DV+f4ZGWc34wowm4+j7cmdafHFAicmInPVJtbPLCUZyjM2YK+xArtDXxOwgn/BgtXV0CD10WfoI9J0x5qMfjstaGvmxB8MJORu2d64pgD5+Sr08HPQxD088Av7aVhSely52qRwsHNOytXp1YUUNFbbbonwYkmlWsc/UqjItqXpX//5oAIGhbi2vYt+5X/9G6pjIxgD+OV2gsSU0rzAe49nhcCupiBpz0Ny
X-Exchange-RoutingPolicyChecked:
	L9RDnoBnUB3bdh7kQPpVEqXAMQSkrOOxgID+0Yi1cQm9cxsE9xmwdtaA9rvV4lGRtCmxTFy9e+Dok3qIr+s/yBgoqsZqj1IlyEh/QfnzTwXZsfhtG2NWiiPFXgrMsdTFw3lzZmURLhYamzu1LiAut1WFlUcXpZJoL/oOSqP+5TPwMdo/EjBEg93fw35GT7zQxUn+Riz1e27loTg9zJ2NRTkxtH/a3q2SdK/HW4iuSaRId2pFLuUf6JnmKA5Ny62SsKTcpqQ9Cre/y7XUFrqljlGpvvaO4daxYYo0qIBMoZNFNXyh+TCgSpUwBJreT2VS34YYJMBpCmy5/jATUS/Dcg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:57.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8831eec-6bfc-4371-226a-08dee4349e05
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6858
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX1yBqnwEq9QYh
 0ThlRqALM+lIcVIidLw1G6wxVh2FHLMdljjznBvvwk3eMuGcGrmDxc7JFqNA+NL+3HU4Qr+8uZQ
 Tf2c/BqH2CuZzViizVH8U+AgR6iMtug=
X-Proofpoint-GUID: Q3Z0MAG8Ir7ROu76lGmtOBwL5SIK8GP4
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a7a0d cx=c_pps
 a=p9IRwfs10qZ2nHdxx/cwJw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
X-Proofpoint-ORIG-GUID: Q3Z0MAG8Ir7ROu76lGmtOBwL5SIK8GP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX3AY0X8dedHYP
 mK5QFpyC/MTA+Ehr4zTSKqG4RvSt8R8HaPvPXHh1HOL88raf2brKWQC1YrQslgvNqo0fDgye6wN
 iRFOG9EpDECSJNPKVGs9XlzItkOAi5Sou5Tl+kh6OyXtjbaMTEQShwiq2ciMWONzMjZfF8gRRK7
 zXqFP7pHP3yPHDxBFoAiKQw7Wdhv8N1bIHHHPuzgsGhyPhaja4bM5IQI7GQiW1/zbd6IYu32xWD
 ARNB0XZypYBIAUtwWuJ40ewhX+2k//acH5kk7gY4i+m9SCwEcYf5zQtjQduShi1tv14IG37rDxu
 gjVo6Nhnp/wcLMCjsO9ocmFM6p1MkpsqDRpXT8FJC7dvBYSkzN4E7B3vF/eWmz+I2MxdbJ5fucN
 mi/5U/E62Q8lWqrGxoMtDzD6eIJvBbob4RZ+TpUeUx1I26arW9uMbK8ymcR04AI3vzBQ082MEK2
 NAduGTEcD2kGSoVyEOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Refactor spinand_select_op_variant() to extract the inner loop into a
shared helper spinand_op_find_best_variant(). The helper takes a
skip_mask bitmask of already-tried variant indices, enabling callers to
iterate variants in ranked performance order while skipping those
already attempted. spinand_select_op_variant() becomes a one-liner
wrapper. No functional change.

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

