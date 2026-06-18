Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D023D45CB;
	Thu, 18 Jun 2026 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768357; cv=fail; b=IVrFC7zlMpSqKalUauylhq4nEAjlLLNIxrZE4E+2aHQlVPPhqdxtNNExi2sFN8gjkbglQPhZm75mwj690PTvYH2dsUIk4uduG7OVfpgmKo7cXO97QZ0GZrewRlWK8lJvjrkidsMtxKzCRF/uZ4BKhbQ/J09Opk8duqHYHQzcWmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768357; c=relaxed/simple;
	bh=zsLp+yCjAKKcuE3SeIa0g8jRo3bb5PldJK6axaGlK0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klzqeA9ozmc0OnXSNf3j6JfUt4httDDU3KyMRAEvyETcWsoOC/IdV9s6jXFZSonzjKeJKhxAnxaQIkzTNjj+7WbAha8opLvtHptlxf6EIWbdUooczJ34XqH/hOvEimeGZuyyNVR2ShCyrpR1DqUsZDl4fPUeYRFgtd+qfVFz9a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CmI65Txv; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lo/4NUem; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CmI65Txv";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lo/4NUem"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I5vmK33435965;
	Thu, 18 Jun 2026 02:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=75dngkiC36yZ4kKyz8DjvnZmAhZhVWeKW1KhPKh+K
	fI=; b=CmI65TxvIjgnV5bCfZERtohnUhm2EI2lE/1FQb2rEqBA6B7bRVDNvNoGq
	70024kinxpMU5KUw7zonp7qq8bGcDdbDHKQI3zOYQ8DSq7vf16QQ6Z7rAycuOPOn
	f31XMPNHjdWJ06CFdFtKCAE1/Icqp6o+E1/vzMDM2WiLddNqfL+xnZoUc8vHJ0XA
	wj6N8K4ht/fDUGfnA6Rn0cEqPRKd4H1sh4fJNrIFXAtrBlRwLjV0Ncl60Ii/P1nn
	LOMAWvwHsjcbJSml0tdOVnTCZR85UY5/Q+pSt4LxT4PMaIl3tlrtfBaQa47tds68
	XQLOnCxo8oROCf8cwlCAR06jUBv6A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rj158-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9X2djA0eRDU3TvcE9r2iV5A44oJP16XMBKJ0xH2UQhFH/3LoE7vnu341rIX1kzxMAf13tw25S6vekqegtEtfxZwSsRiIhYarwlOWlN+liUg8xrTZruu4xOy9/8616r6KaCymle+gqYFyhRPoAPsTt3cLW7tZp78g84LaLRjXoxHzhL04o4rJ4qlVpvb4U+fxB+zI8nZy/uY5pDPINcbiq+YJHDum8e1VC2tzEfOvxUhqtgKra6wS6Eiou5SkLzhxmX6WhOrUU29bKox8ay/ltHNWOv4G6qtoYHhh0oolgpKgP5Hi5Ua7FxcnTpvaSYicaR4sZxk8xT4hEbf+PzF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75dngkiC36yZ4kKyz8DjvnZmAhZhVWeKW1KhPKh+KfI=;
 b=w9xVz/4cT38rXHBSTZ5N8KlBJz/lx1eQ8weBlTyxxvuNw1Lf5hnQPFSTWc0CMFHJ9EYue46xTAnWl1fF4dQSWYJ0ItDcq77lGcpvcsvTt4cKc6SrXCFbTJtXhgFYEjiBXS82xz9VOSwAayE+bSmtaCRy5pHnax2qRGPYbGpod7wVUKl8JnnUKY0sqZVUyfmZ/clzMcQJ9Y3RzdQypo57v1Xg6xw96+vUp8UtuUc0CP0cgXabjmqBp0lr0KP6vrasSWNXnWTrOkO1xRCtq5bKCdEfJBXjJzQ43QQgcC3Xo5avz8aWpsv3hFMQg4S7jIE6lexrLrblOB6htF5cmYtUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75dngkiC36yZ4kKyz8DjvnZmAhZhVWeKW1KhPKh+KfI=;
 b=lo/4NUem434jPE99c7HPXSTDymBTnSQ+lLwnaA1tBlKS2u49MMp0mlaSx34+3mNt1gvUmkWrfpcUYRmfNTYTx1GeEYTyy/eZ2082wA5VV4tgAxmNbkaViIT2iD6jrXj4jr0oNE8jc5IBs1aNVFMIwrbRj84nH5BFyuzkGnUpNR0=
Received: from SA9PR13CA0078.namprd13.prod.outlook.com (2603:10b6:806:23::23)
 by IA0PR10MB7181.namprd10.prod.outlook.com (2603:10b6:208:400::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:39:00 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::36) by SA9PR13CA0078.outlook.office365.com
 (2603:10b6:806:23::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:58 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:46 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:46 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvl3521710;
	Thu, 18 Jun 2026 02:38:26 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 10/16] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Thu, 18 Jun 2026 13:07:19 +0530
Message-ID: <20260618073725.84733-11-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA0PR10MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: d10fc8f6-0c9c-4565-1e19-08decd0ca8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|23010399003|1800799024|921020|56012099006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t6J04jAw/v+0jmvX5ker1lfPpfe+Kg+BOXCFL+cJIsdQuYKTGfCHBh3F065T/PRrGeiC1bG0wCtFoizGA3PKWGHos0CXKBT5HYcFWrHQdGlHSk4yQRF9Og3dAcDo2cs/ZFDN383TpVTtSwDTdMBtKR6IDiSN/o+/yr/03Zu7w66RLYAXuCNgelFSWHEADfs/5gwXVEgqjXWCTwXM+0Uxe84lQmUB/aZWjt3pDXVEir4gn0oAcwS9MMNsOswopBahiuDKqU4Qk/o6TALfNObqku/3oLvgiOuFezqfjefHpsv6IuIefz4jB5h90zecjjqTurmaYDeYS3RkFwGzl0E6pmN9qfsT3SYLlbZKi9Al3IhbA2MslD2pXGz5LDjPcN/CEVA6tXRi8prT4FMQgqILn5HoyTPZgIyo8gVfHPXccPOyg7i6d5PBosokVYCSh9BaCztUbjaBxeNFLCJHC+lKL0TttmIFvB+lgz1x9XL6/gmp/QkN4GE7jGp8DFBZgQW4PO7xTKZSm2Ckwnj9a5YB6uXFpCtT2DdfYQEXHaEv7UF5bG2FZP0pvSh2M7eLfhelKncCCixCDMyhcYwwC6ERYsJ9ZFPwUvSwJ7ipRVzjI0ABruAhVxqSB5mi2SUC0M8ZALjEPg9IGSgETuHgqd94g5eBxWQtQdpH14FSRKIrXrgxjiM5Cf7vIe9xlpT5FaAcnl6HGCbuAHz3tBg/xjj14RfRFdB93sqtzMsLgXk7XLlgjhsl7SSJytLs6Xmmzt2GtsHjKI9pDbomT7r3+mtlbw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(23010399003)(1800799024)(921020)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RcxyzWMROlDtcjPNhINn8SiMxUWV2hGGkxQHJTKp/xaS8ShIsc7LNMd30RSrl4pJ7awLCLyEfBqNVI6lcsKUDgjclEsgfG6EW57oCVSCI7i/Ze4vsZya6Cmcz4wJBVjN2wdE8VlqUHQIknlngVz2bpbj5KgtDk/bzORE03J3kWdcf2zYzV1T6iAQK9vNcVSVGlKBPrci0OvesTuPATF2lZ1fXNsJkLxMn55Zg3GMVip5KmmMxOK9+e/hGKWQx53S9wZwACLZNXIX9gxSSm91c/ru550/J2TFaxtcMBJMZ3yseXCf8FNDj6T6OaT1Z8v82wlJhTAYasDhHaufqog2EsnzT4ynw78LMZOql/tszKD0md6l4yQDOW5LW/jHvUGGbzAAXUahNHQtDY1VuvbQBhGaDkglFz1j/Qg9tkFeS59Y3Q800X9XPy1lo1wDPsAC
X-Exchange-RoutingPolicyChecked:
	Vn4Kjsn+8136IseOypdU00dZWtRSZPOEXdJOQAja43FajGnVvrnX91e7jJbH2uxmL1yIdTpqUULc5KptHLAAi13jit5HEFo8RKrh6zhJDdkBKuMPpQVAkyQRbbSOGGOyQQDPNOODBQN5yxyn3Z5NGB3J1RFZsLM2SudXt+I58B0Kj0X7LucH2F1TaTY2SUGLWnUrzx8RhrmFhvJfuV+8vKkh6Ec0F59SzwVSllwtx/WGot9JZJ1sfaw0kVk3GTgTMPRLsBFE4xEwibSrB5tqnK8N8PF4u8SkbKDZL0jFNUCnyRt73T7HOn9JLqzF98eylXdSi/KvJTyZ3r5QR+Slzg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:58.7291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10fc8f6-0c9c-4565-1e19-08decd0ca8c7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7181
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a33a09a cx=c_pps
 a=PQms4psfS+nBHIg3Mxsk7g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=kQoCic6YF6TU8Y4tUr0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX2Pw45N462oFI
 3tF6ykvSgnh2F2tA1EewRiz9KtsihYD0b1GcvmWyOQh1+pF36MBcdVZ91WBIuXCcODCxhXLq1fv
 78AxWH3ts4QntTSVQqcFzJRai3NZrXOp1dOaKH91koFaba7KAoBn+96c1pazOTNFFuskHgAczTL
 j/504XEsQB4MxaqYok2sFbJ/FYZewGdXD+0EJYcAM4ox+GTA148wd5IUftvzzxys+C4DY6QcyIG
 qy6n4+73BVcWvijyqqrC2cM4Mv88N+pDZN5PXXflJgQt9GqJIw9JFnY9ZqVp9GGWK9yVyaUSNU0
 j8CQZLTFbOTqEvRjG2MDgwBN/1s5SlZv/V61ji2D6pJfDRsm//4+DBBjyTsK1eKCEfMvJmSMdRy
 awy34oqTQDMmqf8aER+yU2uavSDqlFxaj2FYsBsNKIFHsjMppGsWf2X2v3vAP07tQmHUB7bRqX/
 d9ov+weFjVRi1Wp7dDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfXzuG2wwEzIrK6
 ySiHBpSXz8KO7ZXrbMbs/JLBwM25hQO1AOKfY0aUdew4m+CVZEBu6XpxEMpr3LHaNVBd18EvHf6
 ic7s5H3as3p7XZSeu6icS5lXCpL/Nn4=
X-Proofpoint-GUID: ZNoL5rVrE4bhCxdCB-R2v_i3UpVjoh2O
X-Proofpoint-ORIG-GUID: ZNoL5rVrE4bhCxdCB-R2v_i3UpVjoh2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, with 2-byte-aligned I/O accesses for 8D-8D-8D mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
max_speed_hz instead of separate buf/from/len parameters, matching the
interface needed by the PHY-aware version in the following patch.
Thread max_speed_hz from cqspi_mem_process() through cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 72 ++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 22df5f3bdb96..e41aeca47885 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -149,6 +149,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1447,8 +1449,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1460,11 +1462,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1506,8 +1503,61 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/* Use 4-byte reads for aligned bulk (no readq for 32-bit) */
+		if (count >= 4) {
+			size_t len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			*(u16 *)to = __raw_readw(from);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1523,7 +1573,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1551,7 +1602,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

