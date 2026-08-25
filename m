Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92148988D;
	Tue, 25 Aug 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678378; cv=fail; b=SUqRWW8ov8cNYv2yRO2avaxVEdGHoukmxTVAGIwF+SrzZjbBMOT2m/hiKGmyHJkaeib3SH0yK3Y0RHD2UcI15HhbVnxeRejLq1fEZzvvPgaUPaVDBqlwvn+i73b9I+QMqaGPLy3IuF/iRNCSyXPV+d4SdTQR5yGC/oQONmOrmBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678378; c=relaxed/simple;
	bh=1LgbfpCDe5qBgtIvWd06YEVkJtl02ZWz7bU9T+cSz3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckJ9DNxpTOcF2ZzzFN787+7uuYtTHoeISemw+r8JbIbgapcsuEqYp0SqWgE/4l2QoCjd6smgv+UXtNELEOI95ZaWay837JihEuv+/pET4XYB/hwl1AXpB6Idntxj7o+1UtHKbN40Hb/SYNvjIz40m+2rOh6tDbciJ8CBuceHCkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dfhjxv0o; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VA31wBYv; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dfhjxv0o";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VA31wBYv"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVASb1690158;
	Tue, 25 Aug 2026 12:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/PmNbrURczxytwHiKeKxulGmhVYx2+kPjEXMx1A5J
	TQ=; b=dfhjxv0oZO0jvKvWuAEUXs5vJT6EGWQgEh53K63y4DC83U7gEiq4woUfy
	/FR6aqcMWhNLP9yh2a15sibkdwQj1XZpMALVIwrPs1mETBKIOnKM3bh5lIiv07G1
	u7/VCJPDevegewgSriSACNXjNxFK1Mx9dqcm5btbQflRBZ729Y3FjkmkNXYklixa
	A3GaZpR69mvn3NsO/GIrJlGTbf0aeqcgcdvxPGCtfFBiYRdThXn0Y7Z6jA95Hkon
	VNY6IE7gpOTXyNt+fvUNyKOg+2YeD0c0HqDHf1uYiJUKrSpEJK8u7ZR8d1EfkjzC
	p+3rAKLbuFMo/ehtAbpknreGxYgxg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8xf0dc21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddw80RaUCtBWodq6IFdUQKx1p8EosnfwnYcq7Fgz26VL6bE38taS9U65ANDuyi78utnbyfqEL1szJOSFCj1mv3UHBgdGi1lFaTI9t69gsCdruXvZo0qtYC0/MNhHww5pba3zro45Qmryzzpq+SDmHIyefIvt3PLpICLqFo8TtW08m2pZl8COLrT9dhS8rYcR+Lo3m0GePn42qCqRAkFxLw5zbGuV/kf8L1XdTIxMxdH2SPOsOcC3ZnVUqJCDcbJ/XBbNMZAhEF4kh4sj7RDUwIRmpgV8tKJ9x5seGTcFkHaGrcYseAb3BPNwHWkqliLemm38Sni1/tZySI8mXxHWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PmNbrURczxytwHiKeKxulGmhVYx2+kPjEXMx1A5JTQ=;
 b=xMuJ9NpUtLGSKBOKunFLN70Un/c+jbevP9SNCfiEYrxIpGq2YpeaSilazemWGySc/M0LJlW1yZZ43RSrt+lp3gI1OVNlXA5Qvk67frq/jPTgziOlpwyznnNSNDt1AAVitZJOtXaN7qn2SJyACuiMxziGYtwMIpEPiEu+CXgUuukgnhYSNfSPsyoGukDrFu/PlchrDcNvcysfuqNU1URQTkjY0ktnQcIjM6+yeCZpv2lWrabaa/yKinqAYv6mAPpbWQepmrRzkoT9IpmdNcNkScqEKg+jC4TCNSiH+Sw3YB5xFOXOr3dx5eL/WosOCIsG+dJXZuWZCEUe5HEskNR2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PmNbrURczxytwHiKeKxulGmhVYx2+kPjEXMx1A5JTQ=;
 b=VA31wBYvC7Hy25fi3sQw+XBy54DyApaJXd+VffFHyQs/zO2sEN/Z+dWa/CnmvMpBNZ726FY8g7tZURgYdTV7bvcPnTFm0z32mUM0Dw7PqhnxP7mXrMB4ljF3PAgm2j2s8xqFR5bd3WBQPgAZnrOJYVAkGqyyawautWISR6jdW9Y=
Received: from CH0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:33::6)
 by PH0PR10MB6960.namprd10.prod.outlook.com (2603:10b6:510:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 17:19:22 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::43) by CH0PR08CA0001.outlook.office365.com
 (2603:10b6:610:33::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:18 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:55 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:54 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3b1436664;
	Tue, 25 Aug 2026 12:18:49 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 12/18] spi: cadence-quadspi: enable PHY for indirect writes
Date: Tue, 25 Aug 2026 22:47:31 +0530
Message-ID: <20260825171737.776052-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH0PR10MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ac96bd-3c79-45b3-bfaa-08df02ccff2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tlQPq5GOyDqbqNAPDkQ5zFS7B1W5kt5p2Kz/wKcArInmVp4QGL6sFVedquWuVCXhNtF9Tyj3zr+uHEAf3KYi9cE+dL0KRcqeqINP1MJDgWGreiz0+AWjOfe8LZi5DGksSQJZUpcZj2lIpB3pxvWA8fGN8MSAondkY038FGfF1ldTGMHVipEvCetwS2YVK3Q8fmVOZlcpMxcVIjhqEy7oBKIKG1iHj0nUyH2hORrxmT8nDna/aMKKisM95e0NfBl9XAJ/n/VlvwAZhC5h0hW+NokXbsqaLtj/NhzOTlcrcXkLjN0z4y4vquvrM3OrSveIzUJNFzaMOVWx5tHe3YLaXXIXqAWwsXsVs6Zd/tfgmh9SCdw2YXY+XpEIJ0jUxFYazOM4Z4AvpYe3kDDOm2rEZui/jTYQnkEmh75lz0CrVXuDAcqi11c8cI+wopTqMi158bhPbwCxP1Ch46eGEY7Q6msZfy7A10O7l98Ss1AW+JgfXRlEgulcd/62h0v8Uz34AdZWuF/PFGJQXYpGbGmC/X3QXhTZz0KGgCHpSYQf1Tum4dSkRskpRJ7/BsoI3oKYvK7zMZqkPvc3IbTlsA4jnFeT2wuoGuUXeBNRgSu7dscsQvGFuhYgvrvN0zWrlel4zjzS/NuHCNw/Ko8NpNlGhqVKHmiuHnvska2VGdLS/t2LNJ1H86sy9/E7ri+x6ct0uoEITbJQMKovT+ae3bBG2NV29gF3C/otBcIzr96/srrNT/7zULRRsJZgiwgUc9uW
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAFhn3V45DKbP2iQhI2F36rnvVu0/Cejd/YtCMS691kbTtgvaUpc0DMm6jVL9C6mSinuNzYnnKkg/ZKW6UzBWH7FYOBqXVpQHgylo+4lUK66jDMmQY/UIFl2U9+jK8wYKiznfZsq/fvBAkrUwUpLYK1HWN9rc3ZQjGG4B9g47pGs/XZGRFsPPOkfxe3JMuPwTyus5pIfo7X8Zwu5oFMdFKRhOVImuFVxsFQTwwWQ0NPN/Rda97g+B/IS4j7aya0V/BxnWYGSPRUwJdqYzI+H+C0VRdUxX90WgmM/jyGbfvFD5ZGn+XPNxiLWrXRAsyD9fxttVyuf84JDLsTrcVPpX96Ce86gAi95in+VmA/kkvp+l4xb4Vi9fUd97r8/mCUUG/1TF/ix5xls/8oRUw0nLI1tGHQ81raDlSfejrORflZcxVDsyqysK9yJyFtc1rQa
X-Exchange-RoutingPolicyChecked:
	ltdA5ptCvVLaVv/Ze6onqJ5zObWeEwTwHT5L9VJs0Gk+XWYoJ/x88c/pTX79KtFq4nrurIy97/tjyd++R9LWmVX8v75DIXTgSpWlQCM6Txv2EOOT+u2ZRhec5ytjIB29CYIKp+uGX60bY2egxQjEaGS9dFDuOC8QtHUuDsu66HIJp9jS5TERtsmYvMBctDdBHdvffiI/6c/Tg3RLc9YBbl3hYtOlyE0GvFYCMIak4vZgycqjzQ4wwOomM5oJ+yy7ZPlQavt4/X0whEPHuMlFlksdZ25To7Jr12o5GDy22D9Ck9gAUAMxl5bSp6ZQG1XzL6gsiownseCyjd6kWwWoBA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:18.6808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ac96bd-3c79-45b3-bfaa-08df02ccff2f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6960
X-Proofpoint-ORIG-GUID: RvLRlUtSBxBK6I_vnKQJpm2_THjQ6zs7
X-Authority-Analysis: v=2.4 cv=Fow1OWrq c=1 sm=1 tr=0 ts=6a8dce9f cx=c_pps
 a=xtX6lszn+wSwJ/mzueWfcw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=JqbSXTAX1eT4zVGs_pkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX05pe7J6YS1IO
 DF8ApLB3FWA0PuD+vC4y4BEVH9sruKdTNQ26bqPXVCrHcv5oumyZsd3juF1hYR57l38LDmGL8k3
 NdYcALyak31rYMzfSMQDGgs6v3rJIv0=
X-Proofpoint-GUID: RvLRlUtSBxBK6I_vnKQJpm2_THjQ6zs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX8/gJT0Jcgc6N
 w9NLr9TN2y+HcAgKi+mEVo9+bal31qTELa112E4y0XV38SIx7V/ko1U3PJbZctFPG6YBjrvLBsK
 uGvCrNyb1Yd0ja3x4kYSPwvjKOrwhxMo1D0xJzN9kapkNv4nmRMgSsfkF+X7o1m5G3AniA7W/cM
 5Lf5XPlaGd1S5msTLJCNOLo31IvBhWX0oiP58CS+35lhjHNfQ4iBClxBPyx+lcz/2jC1D+1HQ75
 ZZmtHua0Zo+1XFXWB/wVD4UZGmXVc4+wfz58ryxyJB0NkfHNlKTBfClBwfMoWR13nIO5XPgExIA
 pbGrXtvm3omBVmplxliQ9Hdtik3BOpbmOAIq4cqWuqwjq+mEdT9+GWR/MNeHK83WoUZ8xN0ATDX
 iqeuvF3GWNnHYXE4YYHkQc2K9KmDU0H3c6eFbBBVbCIRQcwQ7yx5u2zaV3r5joKya9Eqq1dhEK6
 BzpYcvdjZh/T4pNr39w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. PHY is activated only when tuning completed successfully and the
write op was calibrated at the post-config frequency (phy_write_op.max_freq
matches), which restricts PHY writes to NAND devices where a write op
template was provided to execute_tuning. NOR flash writes are unaffected.

The indirect write is cancelled before disabling PHY in the error path
so that cqspi_wait_idle() inside cqspi_tune_phy() does not time out
while the controller is still waiting for AHB data.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 43 ++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d38a0253e4bd..20ece785c97a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -158,6 +158,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1370,18 +1372,32 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
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
 		return -ENODEV;
 
+	/* Use PHY only for large writes at the calibrated rate */
+	use_tuned_phy_write = n_tx >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+			      f_pdata->use_tuned_phy &&
+			      f_pdata->phy_write_op.max_freq ==
+				      post_config_max_speed_hz;
+
+	if (use_tuned_phy_write) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			return ret;
+	}
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1458,17 +1474,28 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
 
-	cqspi_wait_idle(cqspi);
+	ret = cqspi_wait_idle(cqspi);
 
-	return 0;
+	if (use_tuned_phy_write)
+		ret = cqspi_tune_phy(f_pdata, false) ?: ret;
+
+	return ret;
 
 failwr:
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
-	/* Cancel the indirect write */
+	/*
+	 * Cancel the indirect write before disabling PHY so that
+	 * cqspi_wait_idle() inside cqspi_tune_phy() does not time out
+	 * while the controller is still waiting for AHB data.
+	 */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return ret;
 }
 
@@ -1598,7 +1625,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1625,7 +1653,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1818,7 +1847,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

