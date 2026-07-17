Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4460390228;
	Fri, 17 Jul 2026 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314390; cv=fail; b=oCeaX4W5may8wgFp074iaBypeM9YalQTGHgF1YoCaan5MVxv/0Z3RdswbRVK9QYJDQ/AGuT0nUTGVOb8bPnBcEZLWRUj5NbwxJ9olGARyO8SwjNGSH9WLeujFWM7sG9Cx4nMNGvOE3++vjW81Bbo06eb0kUjLmOcrPGcRlZ7Caw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314390; c=relaxed/simple;
	bh=klTCINip5Cd5Q6sQw9ppFW49YqgxdSsn8/+OTbEeEkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCyNRTlZ2Iuy6Y9NFKKoYsvLwsUZVEAk6BtuN5MI+0ylCunn+NnRfGcCYHZoSfySGlQWrRRa3BXi9YqvQbQq09vhaFJ5EQuFP2Rmx2EDDE2TXPQHf6/H5axbrWVj2bG0VEbOJy9AgalVwkG7YBmQMtkwx5dBNs4R6KLcGRDzjXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fMM1Esfd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rf7LXToF; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fMM1Esfd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rf7LXToF"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlgWM3222831;
	Fri, 17 Jul 2026 13:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDms
	sQ=; b=fMM1Esfd7NxVm9DM7i7UHBLGXS2nrRw/OuH9Q+7rfyukkBtWyLyBxtpk3
	c1I02JG12fb2vONFq2ztVRZiRccmDb546wISZYA1Sy7m5omTtYQ+x+FcwHFCJcpY
	TuBXNkBLtZYscsn+NQQblVDqR8Ep67KJuCgoLEMsCQN16D3K1v03OwnzDbu9DfpM
	GCRJjRIUyUuSqwHcctztthANQMhOwrnjy1P5SeyughlrQK9U/MTAgX1TpypxVuG0
	Fh2Be/IXTO79pJDxczIxD8ZAcw+9MCYw0EMeXRVQcfcCSfVyJhlrODJzEPzfqf4a
	EstbAd4tLRwhYgvQVj8haiqBFPu4g==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2ccyxqg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7qKEcBNbDXDl/W/pFhSJfF/9PKJ1smAL+AduMmigQXYBlYNgV67mCKOM2V9fGGT6QExPsrjfhBQTKBzQJ4nJld3c4gMKFQAedMlAX5oPtUwey4dfwohgvpmKEqLdTb4pGanE5AnUZ5a0BnUcVMfUuqx+lH0IupEtnBcr3PoFpeiKAiVH3Gxh1hewUcabutZ3QIvNNfHANQiG+TvkUI1TSNeasVW1UJ+wo3fu10t0mzLJypNpX6V1mg5tblVA1fBf587ZWD0zTZxtk+Oplo5AW3+7/Pl0TDUqdJ5gax9gtXz9tuyaVM8AFNISnNb8kSLBz5zCcHr8bpOlFDOtBQCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDmssQ=;
 b=IEHzd+QlQUdYALDfP9H4vbsev9j++icrlATQkDiEYsvTXz7+8qJ0W1LBkM3jtXtbx6/L5d/F9bkPljWv1hyAaSkdVRphGRBjETQMTuEstJHIWMNQrqJ4pYZJWPr2hOXY9xME9G14Qy+or+MuhX6PX4H06ceEjWgNe99qtxEozjm46rCYbmdlALgab15xzYox1snuq2qLFCTlccE9cKZ4mRmc5oYhhZJLsMrFHIHM4xpYRpb1RtTlQ924rBwN8GYQSYM/y/SBB7+Hl8bb/icPHZMqbvLCjv0r6BE394oDku979mFVsB6f3yGKAEO3B9odDX/c+FGyQkoaOGUQ6vWaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t8AMDRHjLNpJH6jG/YwirgiSkZJEXr7FStcsZDmssQ=;
 b=rf7LXToFEKcbBn0vwVeqWlGOs4YvjtgDxUEONu7ZKXt43IHefVNjvpCL0DWFIGG8fMByQPlZlzLxN2s7FtbCrWGD3DIzYAdiD3UjBAND+GeHE6vhnQj3a7GgJtGslViPQOVlezyzmx7pDjwjDjEbYBViTLAuUDexs10Ghto8POs=
Received: from BN9PR03CA0316.namprd03.prod.outlook.com (2603:10b6:408:112::21)
 by CO1PR10MB4435.namprd10.prod.outlook.com (2603:10b6:303:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:51 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::20) by BN9PR03CA0316.outlook.office365.com
 (2603:10b6:408:112::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:51 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:50 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:50 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU51240969;
	Fri, 17 Jul 2026 13:52:46 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 15/17] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Sat, 18 Jul 2026 00:21:14 +0530
Message-ID: <20260717185116.2065505-16-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CO1PR10MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8c46ff-ce4f-4b7c-374d-08dee4349a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|921020|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	w6HQ65nehhY+Z5h40ayHpW2PF/X/Rqp/tRo753XNB4iI58wSmZzxyHuhif5FG8Za9iJ9UiC4dyf3LfuTURLQswvzJyyN4fNCRKXXAdT3im1MT4gOE/L3tTjj5pEeMwhxgqFh6oGd68S+Pa1BQIJHVTS1xIlfuQe1cw4u3lhf+WJ9wsz1gOiIxAjCtaZlSR6xMWAwB1zqdGuFaAG/X92ieP+/8uRMvruyW1N6g5TQiyhWs7H9ilN24YKiQPTmeh8O7aNOQKlueahtmJy5WZEo/PVFU8m723d5nhNyMiQoi14gRUT3jYkKeX87W2euYst0B/6vt64Xw/n64Cs6snJI7OnYRubWIqBjLaLAGWp64gyqkOmAbHqmtx4XsLf7htNAnpulrmHIq2d9Pe44jdaFRZ07euzBc+6RKpKdVuMAX9/4HqUJiJdl519pd8wdcbm4QOfBIkBbUytHSf1qucX3Ts3sbcMRCWs9x6MBW0uSNhitaS0V3oOXUhd1/BwaU5x5P+ZiuGl7RpaKJWyHzBkwlhl3HPLS4Ai/TXCnAFSEz2S9/3xqXJXGNbgm/U4e6Zgwjpkuk6wBQAS38IW5QRpGc17MpzlR7sD25guunFNJluMYiiypv8h/V5VQagQzJD1R7lXTKuNDf6G02gGWtoYKXGcXWusCewGuobutRO6FWposXvjuGGbZivN5k6fQFn4yVvGflPnDMbBGT0l1k+Yg3hKf6h1Jr+8dFVXPHaGYr/eMOHEgdmqU1HZB+s+n9A+C
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RCSgXrQ1BOpsVk0vXn5+0hlLdaG9pQPLZvTvU83XdBH5SEl6QihPtIqfzUGYedL7qckdLh/5HeOa+fEK/Pmme7kqtqLR6xUNukrCxZdp6khG2SMK7KwFMkU3KtOoL8rsy+WS9WHQT1zfMafN5HBSJmB3p2R74amIRKeRYCj8WAAf5tMtyYEPdVmn8VGJf98cZa21AxSrlpwuu2wu9ibZPrE4SqqkrK0zGlR5CTQoriqUm5KiNR0rHr0pQ8+BSswJ07NOjf2TeOpvovvCpjY1AL5AhaEizeexm6144WqmRWpyU6ghBE9oJk0eePFdlQsOgZRe0JDTbqJoOamtertUcuKzLf/wocFZl0UORCgByexOXrb3G/GsV6E6rya290tGLBMXN9j0uU0TChjFcaeD5pfy7eg+0LB904rSQHJV6m2jgO9/mVeu/J2TIf/Ah/D0
X-Exchange-RoutingPolicyChecked:
	KC03dT2K7np0oEFZ8sid3xsdkCIOfpeodFwfTIMfwhThmFWrBckqvcdITxq+3oJ0mQRINo0wTwn7V5vMQl9K3Bmoy9e2yCEPvgchZg7r3hygKyacLDWVC5fNhDTXv8JXvxmX1UIah2AeX/GbtHf9nG0h8hFD/43IAI7rQz9375UFbAWbteGqgFvL5BKMUwLnprMSYKF2vr5WsPhkrfg7B/nHKXET9xynjywrjZRphAUVBiN39BrsLe8NjlXA4vIN9MN3biXaMASx5kxRGbtHouVMXY1E4YUlenKEgMK76NegehtExJtbVi+0gFhqbSqERQKIscaDTfaGzuIyDqkb4A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:51.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8c46ff-ce4f-4b7c-374d-08dee4349a85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4435
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a5a7a09 cx=c_pps
 a=SvXgiSASQu/JPdBzctYFLA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=U5cn0f2nyUSNena3quMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TanEGkQ5Q-j7OciNGqBiZyPyHgZjA1pt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX1LCu49qKSD+t
 lHbPEr2DPLPVdBlSGExT5Lr8LGSVMR/CSnN1gh/oy/+3+ePjHuYPI9EpTWTezXlw/LEYn4KKQFx
 aHpgx3URy1qLvgYkNZvgFN+q+jdSHgIiPYhff6oJc5mWzTHrnrhX5PFbXbWTLXQjodMAsq3EoMj
 Y1/JgJYMNuq0tgPhPKaUOAjz2M+gbpYZeM9N1sh/Y7w+GqQxFJ07W09ndG/mJxSTHZQsdhz13/2
 LCGxkkx/gc4zSdguUclgx0TNndR21bZIG2h0eFDJcukNGtcfFoSRyAm65AMJxSwVrCB33zRU4m9
 wtmajTk/Q/pDwks8IYmcrb4ahRGvt3eRcOJ5WaHiWKLx/57EKH/VvdhV1CIBXnBHffDy8XYq/3X
 VhKoAV+01IkGjxOP3B2FrZGgzav2NE1oQkpB5c3e8Epq6j+4oAVmmNStI9mdd5nSD3iSw06+h2a
 IoqBqwSr3VpvKLPp6tQ==
X-Proofpoint-GUID: TanEGkQ5Q-j7OciNGqBiZyPyHgZjA1pt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX/bv+YQfQ89GF
 UVTl60DcUiq8ENPnmWxWSSHg+5RtDwq1MLjswJJc802yM8U/DEkp57uRifuOkdP2bJx5XJfhx+p
 +0yTGnngMD7wQczTitPRfMjPWh+D4Is=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Dirmap descriptors encode the op template including the operating
frequency at creation time, so controller optimization must complete
before dirmaps are created to ensure the validated frequency is
embedded in the descriptors from the start.

Move dirmap creation from spinand_init() to spinand_probe(), after a
new spinand_optimize_controller() call that negotiates the best
available operating point. spinand_optimize_controller() tries the
pre-selected variant first. If the controller signals that optimization
is not applicable for that op, spinand_try_ranked_variant() iterates
remaining variants in performance order — ODTR variants first, then
SSDR variants after switching the bus interface if needed. On full
failure the device falls back to the best available non-optimized mode.

Add spinand_reset_max_freq_ops() to copy op templates with max_freq
zeroed before each execute_tuning call, enforcing the invariant that a
non-zero max_freq only results from a successful operation.

Optimization failure is never fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 206 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  11 ++
 2 files changed, 208 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7c3341f1fca0..b79d06d9ddaf 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1284,6 +1284,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1295,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1745,6 +1748,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache)
+			spinand->all_read_variants = info->op_variants.read_cache;
+
 		return 0;
 	}
 
@@ -1923,7 +1937,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2015,14 +2028,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2051,6 +2056,175 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			if (iface == ODTR)
+				spinand->odtr_op_templates.read_cache = best;
+			else
+				spinand->ssdr_op_templates.read_cache = best;
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/*
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/* Only ODTR variants were candidates in Pass 1; SSDR bits are clear. */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask))
+		return;
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2073,6 +2247,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5f4c00ae72a7..7eacda949719 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -792,8 +792,19 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_optimize_controller() for ranked
+	 * fallback when the pre-selected variant cannot be controller-optimized.
+	 */
+	const struct spinand_op_variants *all_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	/* Persistent op templates updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

