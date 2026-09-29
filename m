Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECD4718DD;
	Tue, 29 Sep 2026 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663824; cv=fail; b=S2SQ6/LxXQYAbCiAmJdBxYrHQYmwz4q43jB03bS7M/b+G7meflu7h46tqBbLJ9j4bOA843d+dhrjeVPn5n1HufrYWCi77YsKr49Z/bbfdCOg8BD/cYl9+eYbOXF43zkK5TM34QsHiRt07w/K9ZQAol1NyBmp5cP5d+7qwlcTVMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663824; c=relaxed/simple;
	bh=+FO3f6AZMhvuWQS+/Op/lncCyNDZDm8ZhLVtnRW1jQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAJOQ8799GqSq+QfxKWoLzOOc+iQc0+/e/SYYOLEeAQc2YOBHsL6+N54m72foeUEvY2XTSrZ9MIRorEcCeYo26nF3RTzpA616LsuISRz19dn0Qi2GnlYUtbD9ZoQyvnjo/tuAyg4zsl86IEKyrBsqOnxmaTrAQT2D5z/82Lm3bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Z+EXpUcY; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=DdZ+6GdB; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Z+EXpUcY";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="DdZ+6GdB"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46PeB3787043;
	Tue, 29 Sep 2026 01:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=d8EGqsCgFEk2nrETDLHRNtbRLcxUQTNnNpAbt7YPH
	YA=; b=Z+EXpUcYxAHozYcgyo/DxqoYvlPbJVudrDR8qGQGDQZh1xdJIQVrVu+nD
	2LA13qr2F/b/nbZL439i+Ir7NO9YCmQv7sxBGZgxUL1Q28G6scF+nmTey0sKfODx
	Cub5D86KT51K3W0qht3NP+8O3CIciU4hpWZ6t/aK5wWIhSaMj9YSVnkDJD59Qts+
	Bf8gIxkFF6UEvlIZ730FLWUvmd1/sjfG2mEzNR8SupaP8BLegCvaARuhVFWG22Nc
	oC8RtKoYSyIV8AdKbH8hgk/1p5I1BfEjgI4qOWnCpFiiBRRnTi1fCnNhXpNYcDBz
	JyAwOFHWJrDXQjmaiQE49DIAP+9FQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h02grj03v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVbB+jrD8i7Ok/EBw9c1BaR4J+N4wUylFpOZg44UkAwXO2FSs4nnqXM7+Mp6/n07f2F0rPDTksLEXAXll0ZE1lThJIGUeYau9IVOvwk/pb003EBX8gzmJY8IQ832THTOB5OlgHFP7vkcgOUzjru0NjB9aJfIp/TdGbWhpnJo3wtVh9dUhkkt4L8q5coH84zwyjR62HZ1sAe5PNPeFmYKlt5A0YHhqiG+kz1leCPM+q5r39jQvQbYkX9KsHvhRsqLUIFytgZeh2vxmbpXlhN+TeaVdfT3j9TdIZGwhIp68F3tCQmMPo9nvpsa6WcBdjx9EhST8b3WrYWxJpRJX4lB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8EGqsCgFEk2nrETDLHRNtbRLcxUQTNnNpAbt7YPHYA=;
 b=XzZa+svWFkcKZhhO1DhP/CCgndaXhRYn4iAjSauR9NzapPOGhlLLwEawrKepI6Nn0ANn5LdSH3FseLp7rHxQE1K7bHMcZSCPGTSHD5FuqcC2oraF6l3Yq+KyLvDKo6owAJZCpOWAuKazHgWle843c98hvba5O2Q1DqqNZqnLDJlKRy4svVKbL6sn2fL6swqFtNzD9VQpzGAWgeYfbB/LVrYgnZiDW0FOV8AQYRrowliWG6BQV/oxbeKp7vFH/KnlJchzjXn5oebIrjtNVf62HwlYRBHaOGmGU9fjgzvFmxp/RrIU5UuGJEqdQbrH/opP2gMneshEvTkDIhKoj9PO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8EGqsCgFEk2nrETDLHRNtbRLcxUQTNnNpAbt7YPHYA=;
 b=DdZ+6GdBkO0YHbIIE/ptIFZfR/L/mwTYgNMILpkNK8LcBfzFk9AmlQ6+ajxLOx+IHX+/n3usXB9CYtu9oAzHwbSeU9YcvcL8h6tL7nCkubrNHGUD5e9fdrh+Qo3oXRMp+XACZg0GlXx1+yRzA2qDeFucENEYkMN5c6OFfWQnDYM=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.12; Tue, 29 Sep
 2026 06:36:29 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::24) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:36:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:29 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:09 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:09 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn51395904;
	Tue, 29 Sep 2026 01:36:04 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 05/19] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Tue, 29 Sep 2026 12:05:15 +0530
Message-ID: <20260929063529.1235417-6-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e18cf2-0fd0-47ca-25db-08df1df3fea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|56012099006|10067099003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	1u/SNPA+BxFJuUqyO/IleZWHc23xc6yOsDos12Uu9Sl7LKwHU74RuEwPdgm82VitS0IHJjg0TWsbSoubwOnVMB4DmES8qkQGMJM2hjzaj/9ZG3vjUFRLul7ZT26nI2dim+MtKJwJE3p7Kci5+/AtFGmFmnVx4jCET9t0DvQBZ48BmDjpk8JhHujB76CxMld1lluTCNImpsahMG3p14Zm4ve/wc3RWvMdMidczFdktXi2BX4/5ubC7wA0lcNFb3U1LP+ic6MuaHXs1EjwecRthha5XaVOJ/GlXMLQ02TddnvgE8OKhUfdt+hyD2FGB3pqKHMT+kkTLBogavKcciqDcgR7aj/5ga7nerNIRJl6aAGwl0H9DoDtY1YweMKHsfaVWUdt/cxv0QPwvsVoK2VeElgf3EDmaV70iyNDtc2j20Cl+5JP8HhFgPV4MjaNs3MAagsKoEMV4dE2OhJcvNfgA93qaNc9mcUZMM70IcvLeWyOHegvlvlWbtHG17qC9mgmpICHCkDfDbRnzymAAzjKe62/Bl2jAYox0Aha1zFhNjw3stA6fBO0x5JBOOi1XtIjKX6e7SWcj2wf3/H6aTgzP1Z+o2yvTC4jErurA04TC4aJMHGu7sE4vIwG+OL2/jeLrago3p6HGacD9qOZ8iFt/cvApwmWlvkqmRLpUK5jLYx6+v9kYWx+srOoiG/cTTwzQTyqcVQaVMWknOlK2mmeoYZ+72m4ejx+HnF8YazKfnFHPykxYLTC8A7G7uJl0L6f
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Q4DhjR6Yj7ICyDDG7xj9FgV5rChRlcvVLKVLR5ChrRDRcinWnYI87DiRY5N03ozvkUdBzqe/+Hjwt8XH5f/BORQOuF3mIv0CSVvu4bKPib3LId6ZNN7WkNqWHZw0RTO+noY9/dOxFmp6fNjFdWkFQku+aV2J2Y6vEo2vf+HEDCSufXMG5zZiENHysubtBKpnUfykNnaep3gFCFDW5HStYSg3RklsMdk6GYW/riXgTm56ZhRw1XF7LxbQQXSAM3XOKEbLL+qad5xcKxKLOJNXKMkJRK0yB94sxDkK3gSjUYtBg/tNLFrKtaL75fY1vn2YndhYu5qfz+Cr1qDV9ECiTL3iQdBIKL0yb6EOzKIsPI2iQ2iiB4Z5M/7tPLtiq42YRZ55StRxmzAZzQTCpG50BxdkXCHAqgRT+D13uDEtnR73MUQbP0xwWkAtwQ/cT7G
X-Exchange-RoutingPolicyChecked:
	c59qIlhvEJCfcGGcVavr/i8FodFAmbocDNyEi3E60Ca1N619JCfNRDxfAVHNbsqSg3Tdq0DuTTE+l0gBqh8la+mvHnj9Fr6ItaP1DskL5OZXhBjEclRamW3fg9G/sNjk5gVGrs4KWmWn42xik+KXad52iFJnxwiMzeHiEOMcc6qUG8W59/5hxw98unW8HjFqfGIzUmZxH5ZpuWdD8wSlkaJclqbHghXMhLZ+J9cq0E3DUBxPs5yd924dwUQ4QnFjyT3wnc+2AI10FN8Be/tiKfrSM+JGsxEOIDciZyCqgRsgeMe5CbvoPtW3WSOWdgovxtCut2vE5ohNaWU650LhDg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:29.5198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e18cf2-0fd0-47ca-25db-08df1df3fea4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Authority-Analysis: v=2.4 cv=SsEFe/O0 c=1 sm=1 tr=0 ts=6abb5c76 cx=c_pps
 a=48c6PaPq82/B1OY+thwv9A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=XczTfz52Gg2yNcvB9tIA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 5YVKg5ILYJiGFkUBTO8Hr-KkHxCXgr8R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX6P6IHdeOJxM0
 fMxt8dXvqPx5m7HJ8HAXf9GpHm3GKj02kDVH2042RuLueRhXi15llskGdmzlY1w3pqp+P70d4CC
 26mJhp/dcEgvjO+HbaMaR5IP97Kh/mg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX9JRhM9CmRyau
 zgIi8dMJX1A7qm/XK/T0bNI0W2c5ToYxR+HtaBG08xCRe5Faj4RvDiDXPb+TGi4wSd84qigCZoD
 YfnA5Hl9nkXTQs6KCch1CRQ23QdPCoThzXFzxrPOHqc5AhCk7WgDAizrxzJVvIVegQmQGFOiRqT
 kv2RzP6PYjIu3+vmYsYuSB8qOWEzcGGyk6KxODsabNxmYfkHVGLHAfjwQmgMvFCGM9lmCc1QjkC
 JTPgOuneeEP9VuuVoMEYHzbgrOrn8AZCzpbv4E9vl2kKLxGVG5Zh7mdG2qiU2runaKvLPyuTDgC
 0/U4L3tFASbDBF+zsCqZSN3rqk+7yAUV7Iwf941Q5JLGZUszvFJVxxZ+bXIKHmE25qu0AwUg/1F
 SdcOuXSbiYQBGx+qZKHJfpf1sKGeUnDKZ4BK8XtMp1J4R0MEcdrRRDyPRtIGNqOsbXuF7QPwFh7
 nntXlSnsa1OsV88u89w==
X-Proofpoint-GUID: 5YVKg5ILYJiGFkUBTO8Hr-KkHxCXgr8R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

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
index 7916387a4f1d..ff085b8bd54e 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -697,6 +697,49 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
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

