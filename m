Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEB47606F;
	Tue, 29 Sep 2026 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663841; cv=fail; b=E72uGSFozX93X7n0g99WFCd90E074FhU9lNXM7SDRu4xkVMwRkWqilOe+ZR5hOhLyWoQAF+llVxsRpicau7pKM7mdLK3ugHks3zfpl7a71zyjfcHdr+EuYorUeZbWhFv/CjlJERIsmUhTapSQgViVqH6hXyE7tU+oMzrK4usFf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663841; c=relaxed/simple;
	bh=iECPzZ03fvIrptJJoZtkIu+RGuRzUKF12dvUYi9Fl3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeIG4Kxhob1kpxOs3J6MYUAab00v8PwYLX9Q6TawDPwesdHzs7jqzAyroDVzWtodgA5wThuOomC3Je39R5Z0a9Og4N5SKrE+H3lDMri2P/kOMLk7Wz4zNvVDIquOXXYxNuiZh/6YPYTKz7EADpVWRhLOLNgwSHtzX2a2xgCQ+xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Z9lO+Qer; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=UwuSejCy; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Z9lO+Qer";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="UwuSejCy"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46TwK3557429;
	Tue, 29 Sep 2026 01:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/yVFsKecbVZ0F/VxjLxL2mLDYs2uMzPYYYhU4eL8r
	qg=; b=Z9lO+QerAx5/64Lq5RitiLEhKJGxhr/Pj1aeUcugZ9N2RXKHXFAj2iYqj
	P4hrK0hZcNe2EB+3UfBSq9Dsdzena7kDsHKdzv3CWTqvrUmoJyj87mVBl0WWtXM+
	YJot8Xc6KYglR3uFj1RNryTmVLr0KZZkeEkqw6+DnUxh8AKGiZGX4Fbs47yik9rb
	ZsJiJu5iEvTuW26sf9boUDImZj7diSW2Zkq3Wdj8/0gVX+YVmrdFdEWY8Rqd18Rj
	tSyHIMgrlHmme57we0hE1MppA8BIXEqaHNb5cgiFixlMwZrxNExr31QvcFQabxKr
	iypy+xb+4U3w/Vpe6j/rT2eMMlxKw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gyyjw333m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJsiTJPTLz9s2KdzJgBIlG3VAoJe+LjiNbedJkrV/pVdH60GbOu+ZFw/f273CHf486smbvu0B1bN1CYaTC0fgVEYIpNW/ZbKF7cRLLkJJDKAJiDukQYEkVRqNvIh3qf/IWgQ3jqm+u/7CSkb6FHWp45s4Sgb3q7OoSJxgufcnBuz+VeFjd6yRkS98LKom/IzV096WG4viUVJol8pq4KiaRowVEUICmBU7Sh9z/2G2MfPZ8/iKL4PYVzybN3NYlGwOoslvVfhs4FfmvS3ZrGEMp1nlyTmnvgyznuqsSx+iaGv0b55SmQ5qV3EuhAm0UD46vKXI8B4tj2TY/d6mZ6VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yVFsKecbVZ0F/VxjLxL2mLDYs2uMzPYYYhU4eL8rqg=;
 b=B5aVi99TedG66efYoGgSZftK/064TiiFpIIM8dN0IvOCIsWywQgLVxrztHPSoDZBx60YtQIIFrpJVXYeSVwxmMxWbl5mFggdK8p3BFGzGRNxwAzyebcVPD2N5qn5yWsP7Nd5Hf/eWXmWXnviLWp6o3QRbg5b0vnP10oDyLnjzJ7s3jz7N295iuzcsdvnsO6NaBpaE/icR58AOKw9xfsGPb2GqSPpLsCkcMf0AF4Fcg3/ns9Def3LeGu1NPK++oqFyrNolMcjT6I01hPYwkUzeWXgJpoV+fZzEGzMMEXYGHdrXFo14J2W32humuIhg13iwaosrdvZ7wsMCMV8xQ9lOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yVFsKecbVZ0F/VxjLxL2mLDYs2uMzPYYYhU4eL8rqg=;
 b=UwuSejCyze/V/3TEoNcZVbYafVYGbn6/vD2MrnySjHA52UJXwyH6+hvGAT2HAvIBSzD/rH9KsdYOQFRVaH+IhYK8p77QE1HrJdeQbAk2SsWNfRazMHScod8VabXNj2Q6WJOmfYz3fXdefF5UA9z/qqdg+4cQofDM4bXnaYao+bA=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by CY8PR10MB6874.namprd10.prod.outlook.com (2603:10b6:930:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 06:37:00 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::94) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 06:37:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:00 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:48 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:48 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnC1395904;
	Tue, 29 Sep 2026 01:36:43 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 12/19] spi: cadence-quadspi: enable PHY for indirect writes
Date: Tue, 29 Sep 2026 12:05:22 +0530
Message-ID: <20260929063529.1235417-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CY8PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6b8f9d-8616-499f-bac9-08df1df410e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	misdgbpnGosyHCg/BUe+QMviAN6N81RneGMQ8OUurRhLsuc0N9maNFwe+JD6DBmJri2qqpHhoWBqCHZh31hBk/aSNuep1IdKVtZq1adpvanrxqttkN5a73j1KG6iD9n0hSnhQhnULrf6+u+/OpkumXHW3//poyrM70CeyOcjTz23G33YxLXdLF7Vz3W43aHuZyoaoWAcAqq773N+bZa00lkB4oggJx6fOPXFNIiUKOkgfPfIWamPkkDVSkvlVvmf3ZMZn4Vn3BLWZ860BXjGJB8pDenwGuKz25xnCwiJlv5j2GjWw/lRtLN1tEYkQmnnF6R/ty9cZR1/XvFXOwg+ptpqBxtJGtWoCS9j8+U5hj/H60BZwPJKV3iW2cN5MEBMWjYQPP9TGtJ5hImriVaHtm5gRYR3cLuPPrqRgupLqwuhOgJxzfdV4XLQnskjQTM6Z87UPCPuCDRJE4eBnl008l/CDp4tY4MFN6UHwXlY6Slju+PUmdQnDLITfKRv50aQuKS9iPMh7BSNUdVsW+ENAFMD8m/PGyvjaTyzXQdKBV8BiJCU00/sOld3QNtgEXZ222QKgLROCEULy7uGCfe8GMuOieRdlxWWoPRCTeKnMUHfV6a+wPmZyFHo9blx5LfzM3OgNfGRXZQrTpcLxuO0s7a1fvABvs2ZZQQ8QuRBliRrciISVe133+N4IreHmOluYlN4rBV7anDXDY9a3AAs2essQOnjjS7dtgbEn3QDfsy+0/BeqL0L59TzPh4NKlDa
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3jlu1cI1tymGx7Jqc/VUoDXtNnEomRFWP3bS6/+OW/DCks2IfNGGJdUhuKuKamegQmKt4IrbmY5SZ0weDfx6eMwNbDoZ6jwbJX871UXCQffwnhQi7Glm12LPiH285d27vk1CmVZOJdPM0c53E6/xFLzgo7Ps24hJEyPlRA+956V4DhfKdIJL4907vtOq45z9DxFun7+PZFQBcNtfqnCIEYMbp4myee6LYjA15jb1FJeFIPik+N0DxqDlV9kCGNNzKnAYeL6yq8CBAOPh4cvLZniyRCaYiCYXKuyk+mNDT9vWmpY5uG3d79WtFw7pIsVklKYJu7hKQhjtBVY/ZK4u/oTZP26194ezl0qgIUMys2qpYWVJDmazJ0hm7EpUJzsD+YfBHXOHD9/xYWsFjjOnMaX0PKQMozDF46vr349F7iaj5Fem9zFOFPdbws92SkQ6
X-Exchange-RoutingPolicyChecked:
	oorJ8Kp9brSJ24+fSNl4cCDgV4iRmnSS+5b70PGXzLYm+YXVwUR8stBVDGEr1jBiUezr11ceRK2/UjbHVlibk1dCslI/iIYxYd/gGuw7fT9ApppxTOIUlqNNFHgnEDSxg9Gqq9df4WvUw8bSEBETUEPTxyk181nrDom7zV4IyqfQTP6++anBMVALBwguuNrVaeDTQeTGVaaKJQedpkQiD/62UMkNYnjgOwQmPQlxn5MI6MG542+/K3ZzA+OHVs2SEFeFgaf6F0lTN9Flu4Vy1H0z4UTVDksptYqhufM+dobjywclDbtYw5hsjs6guLUMSezIkhPQ+sqnrXMYprJCwg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:00.0977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6b8f9d-8616-499f-bac9-08df1df410e0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6874
X-Authority-Analysis: v=2.4 cv=X6LHu2Te c=1 sm=1 tr=0 ts=6abb5c90 cx=c_pps
 a=beY4+7vfl+OHeoikwBMclQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=eG2k343q7fkHpxl68vIA:9
X-Proofpoint-GUID: LtKhheiDBO7A3Lc1qXMVRICnjmtRhFFh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXycvt9/ynNxp+
 jpV4P7KvSdpGw/QyRCjRQhMUE2OLN2YJfXZ8+jvq8tF04x0Ae4KaJFuZ5i05SZHmxc1EcD+G4Fv
 yihmX50+bczjKdJPy+2spH6S+Q+iJVo=
X-Proofpoint-ORIG-GUID: LtKhheiDBO7A3Lc1qXMVRICnjmtRhFFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX00TfozYa/h82
 fDmWBHM+Kp5lieeHYO3AtRFELDw9XpXqO7pW+G4lPfsGCJrBIm/GaT7opUZ4ilXGe3jluUsLJCk
 9ZrOF60VSxgl5VdEDci7gfK5dN9X8DDwxMJgMuqoRS8uwQzPxTaoyKWYpVQGC1q4yN3JyR7yzw0
 7qfLA3fu4Dx9MMCb3bgOOjJxpEgwE2YjnMKNRQA+UB76jf0Rah0FXeMqFs3QN5lmkK2YQ6Vltm1
 6M7cIbn4KjcLd/AWDXBuzNB1eOL55inz87Ol32W/nGxRwjMxUSKlaf989MJiKyfl9qpuT4qlYxA
 Hd+Xg73r9GYyCDtavKReypMEI8SrBAa6e+QkdHSH2cJS5Wpe2rBb+GNq2WS95WT9HJJnVZQZsRq
 rfmF/YTevMlCNjY+jKbKVR0c9MV3cfgiG6AJNPu5BJBj0+g/CBvcOWPxe9kkO10MI8HRoCK1gyK
 3Kc0INRbnp9dJYeQXDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. Add cqspi_tune_phy_write() to toggle PHY mode around the write,
mirroring cqspi_tune_phy_read() but leaving PHY_PIPELINE clear -- that
bit only affects read data capture and must not be set during writes.

PHY is used only when cqspi_use_tuned_phy() confirms the op in hand is
running at the calibrated post-config rate, the same check already
used on the read side. This restricts PHY writes to NAND devices where
a write op template was provided to execute_tuning and subsequent
writes reuse that same template; NOR flash writes are unaffected.

The indirect write is cancelled before disabling PHY in the error path
so that cqspi_wait_idle() inside cqspi_tune_phy_write() does not time
out while the controller is still waiting for AHB data.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency
check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 69 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ad99e7257833..2752e7cce16c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
@@ -159,6 +160,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1175,6 +1178,37 @@ static int cqspi_tune_phy_read(struct cqspi_flash_pdata *f_pdata, bool enable)
 	return ret;
 }
 
+static int cqspi_tune_phy_write(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	if (!enable) {
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+		return cqspi_wait_idle(cqspi);
+	}
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	ret = cqspi_phy_reprogram_dll(f_pdata);
+	if (ret)
+		return ret;
+
+	/* PHY_PIPELINE is for read capture; must not be set during writes. */
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_PHY_EN;
+	reg &= ~CQSPI_REG_CONFIG_PHY_PIPELINE;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return 0;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1367,7 +1401,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 					loff_t to_addr, const u8 *txbuf,
-					const size_t n_tx)
+					const size_t n_tx, bool use_phy)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1379,6 +1413,12 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (!refcount_read(&cqspi->refcount))
 		return -ENODEV;
 
+	if (use_phy) {
+		ret = cqspi_tune_phy_write(f_pdata, true);
+		if (ret)
+			return ret;
+	}
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1455,17 +1495,28 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
 
-	cqspi_wait_idle(cqspi);
+	ret = cqspi_wait_idle(cqspi);
 
-	return 0;
+	if (use_phy)
+		ret = cqspi_tune_phy_write(f_pdata, false) ?: ret;
+
+	return ret;
 
 failwr:
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
-	/* Cancel the indirect write */
+	/*
+	 * Cancel the indirect write before disabling PHY so that
+	 * cqspi_wait_idle() inside cqspi_tune_phy_write() does not time out
+	 * while the controller is still waiting for AHB data.
+	 */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+
+	if (use_phy)
+		cqspi_tune_phy_write(f_pdata, false);
+
 	return ret;
 }
 
@@ -1603,12 +1654,14 @@ static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
 	size_t len = op->data.nbytes;
 	const u_char *buf = op->data.buf.out;
+	bool use_phy;
 	int ret;
 
 	ret = cqspi_write_setup(f_pdata, op);
@@ -1630,7 +1683,9 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	use_phy = len >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+		  cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len, use_phy);
 }
 
 static void cqspi_rx_dma_callback(void *param)
@@ -1858,7 +1913,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

