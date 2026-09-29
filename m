Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD94503EF;
	Tue, 29 Sep 2026 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663861; cv=fail; b=V0mQ0nQdzgxd5HfFn/Uv7jZqCgXdmUpaTGvOrAKgTrUBBgxQotk7nIP2uniIh4G69BHpjqMTHrXxeCr4A6PUwX1bQItz6YJrfPiv7qyBzeN4czV/I2woa3r6S1OT76f3kJM6rcsEQSk3ymKu62PFRzHbBbtzbZLQVAYiU1D6hkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663861; c=relaxed/simple;
	bh=4I8Ktt0VbPxXP4oyvPBhavCBOX5YSKiwIDiUTy43HxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rks5mGO4tCXiyyoOgee3nFMTcScbhUVmGUg/m2upxezDIqRbonT3LpdSZBVVC/yKEl1bf+V93dlpnfbBpGLdIaylARzxYl6fqpSEY/5XFNRiifOy2BNieR83k9cnCC8DGsxKPTcjIMV26bFoGlvyXBL9G+aSRGkTsAcfmHIOE8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=g0pJKrtK; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=j5dufReO; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="g0pJKrtK";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="j5dufReO"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46XmT3284408;
	Tue, 29 Sep 2026 01:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=QzFs+OTu8UHbj5t4WsAMYkihZfo2t1icgH6fAFV9H
	mc=; b=g0pJKrtKexlhgzGHzsOFydV/ESK4UG7rdY1Y751ry1/7ga0sDgbSDm7oD
	lv4qPxkJwc6LZtpji5LENcjcIxw7Bn2mtzhJ73H+0OPmyK3K1LylcY5L0H9uz3r+
	TpaDpUaeg2bDJ9dVK0t35SkPKWCjzQKiohSPFymdbSm0mpqluejzNjhUA3AKC6fW
	4BlfKFWitbELX1O6ahADf0oQoNSdixNheaVl/kk0tayY+VgLMzoQczFVeGPW/NT5
	zpIXnluEmllaTkH/HNHiUZQMJAJSNoe33txYoXptS3YbxBsc8K8zmGCDSAhTjU6f
	KR7wWyaBZVPnx9bdn78QnLhSgORrQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q4f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKv5RP1RddctO/pyFSZaV9st09z2VHvBW9OY+gu3RK+yUOy5Ypc5qmyCGkYVeeYJqVu90RK9Tqre5mnpiNl7u9btIHXxnTuOP7QfWF8J6JKB7bfHuJ+S2KdpMKdIElz67ZvhnvuzrzWBmhrQyL8dHmJ1E7m30mEdxakQjdC/WTRE48YnA8UAGAE+zvcM42PabQyVf6AB259ZQm/2EdxzSwpI5yNu5bIk1k2TmzEPOOnFjZEtJilQFHwoG4nLOjKUI4OhQyZ85ZuyTEV7boZi6Jqo1tLohB7FOJkUsbQeHQayC1ZFbWhtt9jvlo+WfU0xN6WnqmDbKorVOq2JZVtUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzFs+OTu8UHbj5t4WsAMYkihZfo2t1icgH6fAFV9Hmc=;
 b=OJNO4tqcZPhekgKSy9jOfqrRUYdj9xHPpPH0uJx56Bb4wsVmTW6OoN8jHYv06dBqbHxwu8hcUGQt2RXHpYoIAoJtbFW5Oun8bZcZVgRWjaiDbYoSoLgIzcLUKDmzqNobnlu+Siulmu2BhBUmTU/oU+zsSa3kdmzJP+1M7qWLO3CFD74Aj297vpsKRarnCrgh542kfl5TazLfg4ujoeglcI3+cZrxWxlNvJmaU85e8bv2DZprZS1ISsKizm4RNE8H1eNQYbkmMHXmsUl7U4Z1FSQJG1MR2FR1aGYHVFNyNzknF7fZyhbLj39l2B48xjbt91mCWnbk0sArZ2hdnRwnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzFs+OTu8UHbj5t4WsAMYkihZfo2t1icgH6fAFV9Hmc=;
 b=j5dufReOQ5w86i8yRhKrukpA8VaU9EhnYsn9PVyHQxru7PMMJ1eBipAx+Jfyu0pf0S0A1BbYTyjjFcPMNhQqh8wK+6tMg5aYhXLYxO2yrbms6RvpPtzQ6EsMzCvIBJfj77vdPYxc39YsZmgeZf1CpuwKn6c0hY+Xeeoo5ymWAqw=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by IA3PR10MB8300.namprd10.prod.outlook.com (2603:10b6:208:582::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 06:37:19 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::50) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:37:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:16 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:43 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:43 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnB1395904;
	Tue, 29 Sep 2026 01:36:37 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 11/19] spi: cadence-quadspi: enable PHY for direct reads
Date: Tue, 29 Sep 2026 12:05:21 +0530
Message-ID: <20260929063529.1235417-12-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA3PR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 32941627-4490-4614-3997-08df1df41ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|18002099003|22082099003|13003099007|921020|3023799007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3LKY/KIecv2Eii4f+iKOrt9KNQutK4FfwObGdz2d2ZgoHosbJRCvwFxXqKbV3ejtKImemJsqGRXuvYK94HEZooZOi/w6x8j2XGe9YiHiXuOcLXKFvx1A9qllPtLTi5mqOXrniozaK9htp6nl4alOHjMCjqIYUfcgJTf2eGh0s6nCcPjRnEeeBvS9wPR4MA8EODLDkX1idUEeViEVgiO0aqXJUBzfXHW8QvfeL/1zo+66VlNz30zwdNK3lsJB20hNVqs1iX2+Zsf8wOtBs6j+oxZ/hFt+DWAqC/bevVGilP+ZQ8yCe0155bVzTQ7Z5nxG5haBRa/iFFt1hEEy4QDVz/pHBlTgDBdiVWhPG+zAuFNYRLuEGOUNfN4V22ufnjg9jlV8Q5BX4UWFug7DrQxlij1dQ8rSx+3rEE0GyGb8eJie8PiZG86RtDu02BNTkeDx+CjtRk7IIwG2J5L+uaBkr7ny/YWyvLxAj35BCweuC7rw3UvMkN7pwh3MCN/fRLpXqgBD+lf0glmaWTwX1lhfFPTNXRMaTULKsjaK+jdYagWv5V/+wJqVwjDpPBTqWIOxBTOw+ookXW0NXmOtuQj5Dj+pZBE9HdcG4li9/P42LELXjids7We8fR+eIWqYcQzKqJiqIjTjK3PulvNpso5zdthgV8vhxE4bBPBHd2TkN7NqVP+ZHn5vVwlPTrN5Bczx
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(13003099007)(921020)(3023799007)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rK86FFkKfRHUXt890DtgxG7a84xtRM6d2AqylJ0ykIQSBB6tl32XpoL7xlcdA69WfLhaRippqCf/UOO8VHUFgGdGe1Zhc4tDlXqPiohEbnFIBQUSrmSc5ooacwu3nYlt/LJCmYWId8TXyOxCPiQQK9aHOCMigxYIOZtUiCEKAWL4qUkc1S/z/Togcpk0buf145ML7UKdAE/kcDDGTFMfK/KPGtsOrz9gv8pNjnw70isEIEynvjodmckWXZcoMyzejBF1KoXrvzv2MzCucOVLZ1ISqhk3FdybQV+l0a9S1f5XZgmvBQhaUMa/TGP2arRSbtrOgcXXId9GOahJ+m9++uWgRxDPfeYqWnSplBM6XYJ6yL6supwJEFdQDSkVOR2zO43g/pIhLzXcTnT7Jb89rzapcUaTHzNDwbP3bqU+5HBfX4SEd3de92C6N2HOrTKz
X-Exchange-RoutingPolicyChecked:
	QOvSF9xh9mh1REkVmX8gUFWzCVeSotBYeXU6/nkIrIknUkV4taOuryow64/NfeS2h+ZIjODjjzwPH9qNHDPBdEI9UouRbAuTBiHBqus1Ow9QwR40XVyx7OIc9/5zfRJ3UEdFuqj5X6G6rkHZKw1R5dnWvCIso1qgr0lifVjEr4IBK9/2j6DjbxuXZ5G3LbgJwPwacRCU/LpHj4QU8RQaUiP6hkMpozBp/Bea8mOf5zmXNkRYGCbPL52+tYa46QI5j4nh/yhfNXB0yoiM+gICU0F3EKtfsYoR3sPZjJP6QCwZ8rzEJBlhKzA0l4a8A7oUA2/SJVVMv4drKoZS472Osw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:16.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32941627-4490-4614-3997-08df1df41ab1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8300
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5ca3 cx=c_pps
 a=TIoD7Y9874wd1wHQAFcRHg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=xvvdLyzBXiBTOVs6KicA:9
X-Proofpoint-ORIG-GUID: vMQe3wLFJn8XiaKso2D6qZVRytqlsx6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXx9mVn+QagWQK
 fIFZVFslPq8wtJTd01QbJBzfpscD9kgWKkVTyEYPB0VxC8GYZRVSKRhGYqXe4XCKbkFUEC3wuqA
 SZRTeDBgMK6v8gD+x9Sm7JVLmirNCkd0bN1TfPmD9s924WCHmvBt8FuiLvCsLOhBPXbX/8Q8cba
 ouafDHVFUJpAYVPkR/kqtxNCAq+yY3Ey9Krz72fHTi++dB/B89T9GVXMChIwx13FIBJzwUszUK+
 jtEn9hnU9nLkzDhFLJ5ZQkd8eGZhAQeoskSP/61KKhuSSA26tmcf+TkSLa8mM7bOJfXK7VBvZBA
 fyvViV3VFZ5bZ0N8Gmo/ZBn3panVqx+t46tcV3pLL+LTZL2vUKVYoSZcFIwRBDG2Ftlqq1Hg0Gh
 GT1VSt+QZJB8F+eDTplvk0CcmfvfYuvMgvmivTRuzq7ZznqocM0axZ7SMgdm44LHpUZuaPliOVM
 W6RBWTbgVUMH7cRuYyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX1U415xdHfSA/
 ow4gDmmMCOKVNuFeMSebJsb7BIAsLKR6zM/3AzmZc2djQnFy1AJ/k6jdjGMlUo8xaYb97H7LkjQ
 TA03adDkY08+NlUziff30fW+CLSKLIQ=
X-Proofpoint-GUID: vMQe3wLFJn8XiaKso2D6qZVRytqlsx6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Add cqspi_tune_phy_read() to toggle PHY mode around a direct-mode DMA
read. On enable: reprogram the DLL from the per-CS calibration result
when the hardware values differ (handles alternating PHY reads across
chip selects with different calibration), configure read-capture for
the tuned delay, assert PHY_EN and PHY_PIPELINE in CONFIG, and reduce
the dummy cycle count by one since the PHY data-capture pipeline
absorbs that latency. The controller is confirmed idle before CONFIG
or RD_INSTR is touched in either direction -- including on disable,
since the preceding read may still be draining.

Add cqspi_use_tuned_phy() to gate PHY use on a successful prior
calibration and on the op requesting the post-config rate.

A read that cannot use the tuned PHY -- untuned, unaligned to 16
bytes, too short for DMA, or lacking a DMA channel -- must not run at
the post-config clock rate: the controller has no way to sample data
correctly at that speed without PHY compensation. Add
cqspi_direct_read_fallback() to drop the clock to the base rate for
the duration of such a transfer, and apply the same rule to the
indirect-mode path in cqspi_read().

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 195 +++++++++++++++++++++++++++---
 1 file changed, 179 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 494008b953cd..ad99e7257833 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -6,6 +6,7 @@
 // Copyright Intel Corporation (C) 2019-2020. All rights reserved.
 // Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -1075,6 +1076,105 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_phy_reprogram_dll(struct cqspi_flash_pdata *f_pdata)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	/* CQSPI_REG_PHY_CONFIG is global; resync if it doesn't match this CS. */
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	if (!f_pdata->dll_locked ||
+	    ((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+	     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+	    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+	     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+		cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+			      f_pdata->phy_setting.tx);
+		ret = cqspi_resync_dll(cqspi);
+		if (ret) {
+			f_pdata->dll_locked = false;
+			return ret;
+		}
+		f_pdata->dll_locked = true;
+	}
+	return 0;
+}
+
+static void cqspi_phy_restore_read_config(struct cqspi_flash_pdata *f_pdata)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	/* Shared by the disable path and the failed-enable rollback. */
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+			       f_pdata->read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  cqspi->phy_saved_dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+}
+
+static int cqspi_tune_phy_read(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	/* Wait for idle before touching CONFIG/RD_INSTR either direction. */
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	if (!enable) {
+		cqspi_phy_restore_read_config(f_pdata);
+		return 0;
+	}
+
+	ret = cqspi_phy_reprogram_dll(f_pdata);
+	if (ret)
+		return ret;
+
+	cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+			       f_pdata->phy_setting.read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	/* PHY pipeline adds one cycle of latency; save count, then reduce it. */
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  reg);
+	cqspi->phy_saved_dummy = dummy;
+	if (dummy)
+		dummy--;
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+		 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		cqspi_phy_restore_read_config(f_pdata);
+
+	return ret;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1494,6 +1594,14 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_controller_enable(cqspi, 1);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 			   const struct spi_mem_op *op)
 {
@@ -1623,26 +1731,66 @@ static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
 	memcpy_fromio(to, from, count);
 }
 
+static int cqspi_direct_read_fallback(struct cqspi_flash_pdata *f_pdata,
+				      const struct spi_mem_op *op,
+				      unsigned long max_speed_hz,
+				      u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+	unsigned long configured_sclk = cqspi->sclk;
+	bool reclock = op->max_freq == post_config_max_speed_hz &&
+		       configured_sclk != max_speed_hz;
+	int ret = 0;
+
+	/* Drop to the safe rate for this untuned transfer; PHY isn't used. */
+	if (reclock)
+		cqspi_configure(f_pdata, max_speed_hz);
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN)
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+	else
+		ret = cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	if (reclock)
+		cqspi_configure(f_pdata, configured_sclk);
+
+	return ret;
+}
+
 static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 				     const struct spi_mem_op *op,
+				     unsigned long max_speed_hz,
 				     u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
-	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
-		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz) ||
+	    !cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN ||
+	    !IS_ALIGNED(from, 16) || !IS_ALIGNED(from + len, 16))
+		return cqspi_direct_read_fallback(f_pdata, op, max_speed_hz,
+						  post_config_max_speed_hz);
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	ret = cqspi_tune_phy_read(f_pdata, true);
+	if (ret)
+		return ret;
+	ret = cqspi_direct_read_dma(f_pdata, buf, from, len);
+	ret = cqspi_tune_phy_read(f_pdata, false) ?: ret;
+
+	return ret;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op,
+			  unsigned long max_speed_hz,
 			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
@@ -1659,9 +1807,14 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, op,
+		return cqspi_direct_read_execute(f_pdata, op, max_speed_hz,
 						 post_config_max_speed_hz);
 
+	/* Indirect mode has no PHY support; never run it at the tuned rate. */
+	if (op->max_freq == post_config_max_speed_hz &&
+	    cqspi->sclk != max_speed_hz)
+		cqspi_configure(f_pdata, max_speed_hz);
+
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
 		return ddata->indirect_read_dma(f_pdata, buf, from, len);
@@ -1673,22 +1826,32 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
-
-	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
-	cqspi_configure(f_pdata, op->max_freq);
-
-	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
+	unsigned long sclk = op->max_freq;
+	bool is_read = op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in;
 	/*
 	 * Performing reads in DAC mode forces to read minimum 4 bytes
 	 * which is unsupported on some flash devices during register
 	 * reads, prefer STIG mode for such small reads.
 	 */
-		if (!op->addr.nbytes ||
-		    (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
-		     !cqspi->disable_stig_mode))
+	bool use_stig = is_read &&
+			(!op->addr.nbytes ||
+			 (op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX &&
+			  !cqspi->disable_stig_mode));
+
+	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
+
+	/* Tuning inactive, or STIG (no PHY handling of its own): use safe rate. */
+	if (sclk == mem->spi->post_config_max_speed_hz &&
+	    (!f_pdata->use_tuned_phy || use_stig))
+		sclk = mem->spi->max_speed_hz;
+
+	cqspi_configure(f_pdata, sclk);
+
+	if (is_read) {
+		if (use_stig)
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op,
+		return cqspi_read(f_pdata, op, mem->spi->max_speed_hz,
 				  mem->spi->post_config_max_speed_hz);
 	}
 
-- 
2.34.1

