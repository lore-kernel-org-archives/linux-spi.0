Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69038AC7D;
	Fri, 21 Aug 2026 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313037; cv=fail; b=aKJEG+dt9i5QDXaI6mxn/YwDmN1gfph7GeTwuDamh6Hwrng3FKW759JmINbiq7gGw5mI0KCNwIHqUeunj6oM6CwYUhoB//Qw0Jve4VCZqDXL3OU/wUq++7f/ljgYE0kNkpWdQVfWpU635xCJkBqb+Ue+XRNrXgQC8eM9WnTDYqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313037; c=relaxed/simple;
	bh=zyzIHZWkbZiJeCTqvhBe5bpyE69d/84Z/bMFLKqBSj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grN8UbpD8c+Su581jiANpQaHgLWLmoDdNgzdBNecUYu4PbZInSoxn9ryLwcRyEB5ReHmQhYF04inkoBZlpTOLcy0hz2QYoV4igqzwoGExeHRnHQ6b1I5ud9Jky/wAP3hm2UYXyVQZHpjF97SwB41+As3v+rvYyeO6pbi2Tm7PgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=bpYkwGRd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k3966MTU; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="bpYkwGRd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k3966MTU"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KN2b3254934;
	Fri, 21 Aug 2026 06:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yy
	U4=; b=bpYkwGRdDy2ZkrjJFGgZ4//7AQaZkcsGUD8uBljoD3EqGAn2JY5witDyV
	xf5VQ8EWiBaNeLpgqoF3giQ8NoBl4IgfzghL0XFuqiF8q023jlAGz9eO1VKMYGGH
	zCvFDClHrHzpyYL6aLyO6YmED4Cu0zFAYOJtUUqAC3TOwapDPhM6TNvffNmoBh1t
	ZWEB1zYWVOZOlVIyHHegjq91J3vGhMr4sONM2ElNe610LVkF2McjmYSiOUYKkfbH
	xue8YYGAq1Pju9SSMWABeBcfm0VRy9qYemiN0DXO/00s7HZzcE7eWG4lOaVGLFsA
	46t0TGJRLbMG6nnAntz5aUjRd2pnw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1dh2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:50:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPk09hSsLIk2hS5ABMaJLCGIsbN4FMn+J9YK4kl3icZVXeeeTy1S6A+dSHE3XrsPl8/O6tJT2FL/30t7ue1onwO2vTX6seJsIvVjKTGCSitc5fTXtDAy/tVjsQAtYoX3pRj6vE9MUZ1emWwIcjnLYHRpJ/ju7GwrJyb8m7p9+VZSeLj+LKv1hrXVb2q6insYI4nbUe7Da6UxF8oQOykRfygE2kFkP62FHj1IftWP91O23iop6/zBN0bC461pXIULlaIAEUhFx5O62XWmy7IgREBqZTPJpf1BWpgrj9H+5QUWFZXWnn30JG/JHaEKJc4HVKsvSEbv/SyTQkU2Ij2DxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=jY05LZadUKGmTem0P87zTuTVWT9K5vhGWLlw/EGrkXCx+npO8lethj4I75LPYFsgIdCrHdIcFsdBLYJRMs/GTrLixgbEk2VIG8ihChzHpkVlxKo5xC2UZihgM3bribxI/+DEC0MGfKZK5whdBhkqC/NTBYmYYvB+HCBfFc1NS0jKxWqIJ3Dg4mssx7c9Sif08zA3tCvX9doNzcwtUPc2r1jroCF4ASi+2u5i03/aID2kP0SdqmQ0ytciEzmBR30DBgiFMKPXdpSJAYuMPMwkV+8myfJ0lxZV+07G8XZlXpuywUURdprng/iuEKNsHprzUplszT3phQMaLr+Sy7HwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=k3966MTUIkSV/hjlm06tsHwl8zfpzjirt1PsJqgyO0/7xC9QfHKsLivhFj8mkKPrCrQ8WjHR/q4Sg3Eg3suaHlnMUDQlN1eubDyfrK2/163fQ6tThxZqseK4pDoujn+wuPQBkdz9TOxYGiT8lXHSVXkpX4swD9jIBv78NSxpRU0=
Received: from CH2PR19CA0007.namprd19.prod.outlook.com (2603:10b6:610:4d::17)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 11:50:10 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::32) by CH2PR19CA0007.outlook.office365.com
 (2603:10b6:610:4d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:50:09 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:09 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:50:09 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVls2022942;
	Fri, 21 Aug 2026 06:50:04 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 17/18] mtd: spi-nor: extract read op template construction into helper
Date: Fri, 21 Aug 2026 17:18:21 +0530
Message-ID: <20260821114822.4040338-18-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bb8b1b-2276-4694-3772-08deff7a5a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|22082099003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	sfU+jiC+ugdvCma9zKGXKB5NrkD2EaRBX77hi0FwvmgqPtAdCiWYFxiR1qXqz+RBIvHSLG6yEkN+e3dOkbHoCo+Gn9hcB9ik3l0VxwklXhj1Dpfwv0DF7lBurpm4lx5KX0f8Q96DrI59SBYM9+VvN0QAx6O2j1/TwJZuW5z8/furZ7dEW7EYp5VbHBJjFRwy5hOX4294YycZWIVW5ZjcNWyjDeooQgOMoA4Fu3BaGFb5gZSfGeP5/J8T7hPBuFYY34r/Lb/RcvBvzTennwU869KX/EnKNpr14iia0BeY9eWIsb6yLMcSQrYhe+4aCZrgok6Uw8MfkQom5OFUnwrgPEtjsKppjX/+gJesikIDgYTmJcc7Hd1/Z/+cGSCIafR68zZvWnNg9b4iw1gi4EiOM3JoEYiYtccXY5OdrmHswiVvY0bkqogcRycy+Lwd1ypZ0Q9QtCgI5Rzzj6fJVtj8546+X86Ghtmj+9UuhNb9Jm17OZKR9Mu1BsPEJJKqatSfQqeM+WinQ/pcNNA90MOuiEbn1fQr+loA7RnjWYWFzv5cZYM3Ascqeah2pDdYss0Re8LYnZYLN45yrJHRBS/0Uk8EkTGKZEzGGATOonIlbp/MvzYGKAvOiIzrcA6yuV1BSL+q0qlTncZWOGYg8WgApLtqP40Z82Dv6yxF3SF4FIVC41olQowahYQiGDVkg4fnPFzFWbGyedAWS3s7HPbCjth/Ge3XXO1HVQKTcZfwjrvLRzfEs04NTVbrg9W827IV
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(22082099003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V6ksmP/n9UGjnSwu+h3VDwfkdsAGlpQq4zAe2YCUr84keyXkaxjsZyWtg8mHx7wSTyRe2+VyA/DFW9Qdz6ZxjuEN/BG5VqJhQjVVBSiOJ1X2v34RMmzdQYBWwtEJEMODYqCtHxB0X/IKxEQlAKfUfPKYE7p+ydieiPIAx7Umr0fzUdSM9okoQkCt3ralfkcoZFetD8iskwvLQ1ak6+mu09LwZXZHIbdB9gbbvGoLFp35q63mrabBuhYIZKkL+xnFZa74egWU01p3muWVeJfYvOwHKl5GsaRuZHXnsSBKduxrmHBLFES2hW9iPMQq79hFOPh6oTG/mGP6kKqV4czGSPhUYFG400rKcjZoWBhrQZlB3ULVMm6oWYpSpdgpauTRLE1F2FDtMD/3SIhduWMkfI3RdxA7nAy8jk/5VSHW+Puz99s59o6d8pTKYyejT0Wl
X-Exchange-RoutingPolicyChecked:
	i67teFPREjJluLm4o5rVB2zRpGfqkydz71lFc5nM01lan9RhLyCLR7ywl1ugxq5bxW4stNtsD6PQt1cWDRmsY0V7wkNHba7moL7tYmus1mxOFl8efNjUsImU7wSOvzq5JpDmmzOP+UYERb/F2CaE1W5Z6S38GR11B0CGfDJqz3WwivarYV8AHcNxlWGO/EtIF12r37N1NpC/cr9Jop3rwZmHX3fDGRMSKupPKNTUOuqpEyMOP6O3gozZWjhc7vYkwJIbZqWafD1EH1gq7EN62vg1feTDwIiy1xvcAWAiUePhweXJbRj4PoXCvPf/CyKteBEYNifv2f8hcbCP3yLRZQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:50:09.9437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb8b1b-2276-4694-3772-08deff7a5a5e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b76 cx=c_pps
 a=9n5CQ2h0WC+XkeHDVU/11Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-ORIG-GUID: _l6JOy-uMQj3CB_8nzGg3YNLVNCaQMCT
X-Proofpoint-GUID: _l6JOy-uMQj3CB_8nzGg3YNLVNCaQMCT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX3SIsj22vsqgE
 tRNdszX/oLvYHPxxuT5Cp+tkF/pBKl1QdbW7xlZYurZeE94ZC0u70g8tjdvZJmLJ2CrVCAhFQ73
 JIxOHNX2orDKj0dqOObTMxfw3P1cZLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX0mg/Q8uyfpJc
 oU5vG5v0ELj9FEwYNGz+XSbLsJ9gpdgfbqUUAglBDl5+KQiQyRJFLt4RTimImKHVd+avOzXwmlx
 gZzjqsX6wN/R2C3r4ExTOk4zockQwbk5ALmTMcIqYlS4WjA0TQsUXP1py4GRyYXSL6sWJcC+n5P
 4TaHBP92nhxk3fR+iNLWRntK0AGl2QUCSgI/vpHtVvZCEc2w8ok+JHu8LH0/ZPfjjTD/3iJo/mv
 yfLBUq5D9ZHJAcwvTtXIunzq3WiSzTa8b4YiWKraJ3Rq+ZMcrLFlJyVSiUX/DaJQuLpOHUQFecX
 q9wsYxcXXJaOc00UZ7RWNy2LikaAbQnry4TqKj/g4WXtKWm173lJEWELhmNa2mH02JECNLLNPii
 8Thlx38gzYgJvlP/aFEU2TJoOFu5QbEVTgvxvPCbWQ0E5Qi+L038s5XoqlLogruJ86XWdbhiebk
 BikzjJFM2mGOiUDr1gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

From: Pratyush Yadav <pratyush@kernel.org>

Extract spi_nor_spimem_get_read_op() from the duplicated op-template
construction in spi_nor_spimem_read_data() and
spi_nor_create_read_dirmap().

Using data.nbytes = 2 as a non-zero placeholder lets
spi_nor_spimem_setup_op() configure the data buswidth without a separate
override; callers replace data.nbytes with the actual transfer length
before use. No functional change.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..b683c077a233 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -188,6 +188,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -201,21 +232,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3712,28 +3736,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

