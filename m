Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC5390228;
	Fri, 17 Jul 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314350; cv=fail; b=lZZtHMFyy8/OVHLj6v7/ikwCxR3r5yDcX2fqgCPcB8bpdbCaOVbSqyKHXm6EvK0IH5z/sYVBXKDiU5x+IC1C1uV0wZcmsGCrX4kxz0u2y7oGznYfgo4qCnfuDrIn/4I9nCqlposZ11Ta3ZehziH4Q8oSIIvxsxvXVcdHQx2TFSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314350; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJqFLyBCVALNT5Kb0V9Myo87A70kD/dxeFC27A7IuR6Tbi0yL18Pu6JlC9FV5eOV6BzIzxucjVXD45T21vHwp3ygztjQz3l40suB/u5E/RuQxzqqfugc0dTArQn+1x44wxOtVT5BMe19RqjM4gGIMXOCA0XldLB9uKDl1f1zCsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ETwZcZnQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ls/wFkEP; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ETwZcZnQ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ls/wFkEP"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlFLw3222590;
	Fri, 17 Jul 2026 13:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=ETwZcZnQebBGluAKxwUBtg875N/IPKDZ/aX0i8o9kHUvVE4vNnISN87tT
	nSKYNhDpi3lDkTP6MDPPp6uoRHCxDsT2dsjZOsUiH2D1LKXkF0Q/IeZp8Se5E6FW
	07OXPLSgUq/PtSoyFoVb6GeUo5iJ1H3xVN7VFDUoGhgwahzOfykH21RgCfHdtTbY
	jl0OQNMzv2akXEzU1ebaLjCIFm1ccjfTOxRLwNXjsDDZH4S5urlXAJOvNRATw0xy
	PhxJOs4Y8wYQDxt8QbhqK6FNqYdlGwxr69ug5WVDQD0K0coX1hRzH2JRciWIOA4E
	aZyVIEdH+lhwMd5n+Oyk7p5nNE6iA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3jtxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8IfhhJ1RcJAY3QJrkpUxJ47dQElT6IpCDqZ2S05xveOP0oPJt50ZFk7GaU/UzwSTY47yzkTkm6fXC5rL9CCzySVkuYUIvT89DVB+qvCPz7Fp69bXKFTcNEP2kKuro1VgE3mLMVL42LwvnzwLnPim4zOwNcGBBC1ikHe86mJlEKuetvbY5/wGACRobqECpwXxGrKY3/BUmd0c2GeI0Opi1LCfSzHvMbbNsaHPCbY6Grtb2Z1f1UbDMNVqe6WH91Gid+NP8m73Q8uwHO5SjNuKdmZc/MXEq5iuDLMnkO77BBvnM+urzi6DOJMmyVORZ8m59ssPxsQj9hCy6fS3/BQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=AQ9GDbzSqkCYmy7dnbONRPy9Vpt8bd8pXzyZeLQhfoTXWO9dxAjbdKJ+XqHzvhiTyVQB8DCTfea6HNqDhDMMfoj0YW2FEEVMzVE9kSs2IUPH/I9uA7Wy1f8zFqJdplcqi8H3O58pp7rQXqAVQscLbCynES1ztGSEbRkBlb2sJQtGLUBir11UrtTi/iZiUwkoR390R17sTlutffeAhcxhVoC7ispnXyjbm5uKLWMK4bVay+wIznkIGRB3Sb1HUlK1IpwOQ2bgNqWKWpbIe/e8ABcA11ylpuFkNCuhkf0knY5N1W5sbPeFUHwuVSdHmAMRmtY5JyctcOvrvfXZxYpKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=ls/wFkEPL5r9AYBeBiDbe9Rkmwv9KWELdJetkXlGJz97CK/gCtfPv1I4EMuEEB+rbiTCH7RwMqb8Rho9FK2nsMMgW8zUdtsdnfLjqD8FuNxULmwSb8gGRay/eo2g82ZN2h8AXLcYhga87cge8whXFRkaQ5FOaQo3fGvquZYtCys=
Received: from MN2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:23a::31)
 by SJ0PR10MB6432.namprd10.prod.outlook.com (2603:10b6:a03:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:52:15 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::a9) by MN2PR03CA0026.outlook.office365.com
 (2603:10b6:208:23a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 18:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:13 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:10 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:10 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4r240969;
	Fri, 17 Jul 2026 13:52:06 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 07/17] spi: cadence-quadspi: add DQS support to read data capture
Date: Sat, 18 Jul 2026 00:21:06 +0530
Message-ID: <20260717185116.2065505-8-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ0PR10MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: c74af2a8-a892-4856-7c95-08dee434842f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|22082099003|18002099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pXEqX08TWRyfzOaw8mFs8vTlVlzelGlF6GLvjd6gdgFOb1mU8xfDQI6RVQZAt2P7Ubj/wd/PnWIxmUIsl552wrWaZgeXB8+vUZdQXL7wyPmX3+SYQofyBVw46nuvpVjV1MTCnG7wUbEFTY6YuSN5H7uxgER0sGsm7rIfKkAsoXZmwTdJjxCY50dHpfSwtmowgqkl78g+anOIES0/jrNYsTWZ+eD2/duHKV5wjGyUbDHrmpMAzigFfC8617bpMUdZ/pAkb3JP+n+Ge5uH6ZXPmhevP0TbK37HyE2LMGuF6X5F89SApEeejuP31Q7pMgabErliiccs32y8vbwe1/xLl8vxkWuF8xh4+qGZenywIzaj+vQOz4xL5K2jGJj2ph0kaw08MLGVrw//7TjYjU9DEdtON4TQNWnYA6bErUJQs6334pMzHTBsG2n3ozUgH3fgEqgLpGTmvZEFK2jy/Jmgwem97sBy9+rPKG6WekBQ//UjqaZ9CnXDnaGMCIpK4CzASOyCjMJ6gQX5RQw5tR6DQ0GGCO66sznkFrATI8sJaz4AE6RrKrYQKYpLIakSBp8W8pVOCaPiXGqSNUcK7cveFdCDScR0J0w/6XqRCoYnAxrscGTpqBSl7N4yPnBHhtG5dVuIK/yR2KwXm0zsUqMeQ4V6K/g4VdL0JtVcO2bDYLBAc2fERlbSrm4abH4vBdcH+FhfnSA0NMcrJ5V1nANgaxqyNXM/9RnaZ5Niu2mpx9Ux3sAC+JxKZDA41Aspukio
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zratcQh1+I8e9wkPFB7eOqE0BhSriYO3TkM40XX6nZyJH0qUw7cySjBh0xR+ECF8KPF/0kTU0Ed762NohFqN7QmcVR2Go7w6buSz2l/hhuNmXKiOPHv1IgWYPyNOH6Qw7TLqKx79ONxbPQX5zwHbxxDvwctRtUjnk3V176By4arvBJyj5eleV5qd6VY3ooLJUnUrNK2tnm8Apfh7eJYJIJR/fAo/UW5zu5fXaVh5Yhua1KVCPRg/FSC2ctSB8fLz46LHx8kGpGcAzOEsUNXdzs8o2iyTe4IUFsxL1R4k83BbB6RfRl9ojUm8UnNRvw0fHbYYPS77n8f67xjL02SX2blTw6wobzxmOjewHJlt76Zj6Ooe2AZMn34ttJ9JOuMDrNhDZ43TQGyAJmQOS8TO3eLbsSLeSxiNFDWt1oUZqVf0vxTmmzhPnvIrFAdw0yW+
X-Exchange-RoutingPolicyChecked:
	XYA21eoTjigRycCXyJXGdrD7VkdPbht198RO+iX7+vCs/QVI68rv7PZzLCE3XQCy+n3eVe1GlAjOWqWyJ4wadV/wnjSTZGQWA/sOk8SnFohir6jLIJinSn8XWGz3YELNtyvYL2aBk3+3ocWTbtlY5YUQRbNNaCorSvm8yoYXEn4ZM7eR3zTqQm32G/yiHF+9j5Yo7V+ZbD8XRBk+/2Le9E088+oIU3FxBui7MsljNaKiSZ/76QkDv4aQJk3QUsH/MAkFueGMa32j39HUYQPjWW0q41/U8XhjFAbTN4pHRFPI4R9jBJD4knUKLM6cizKYfVtUQYkesy/2MV6URgTNug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:13.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74af2a8-a892-4856-7c95-08dee434842f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6432
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX1y4ehPrMeXNi
 TyRvsFJgTQA7CUyr2lwFSbK8evSeRenOy5DzZWBKI3tZpX9MzkW9AL40VXPO/eimHpWSZwZiHeo
 7MpCGqphz3OZnQKIsavjozsTzlty6KU=
X-Proofpoint-GUID: -EqEQBDYkva5UdJlQa5ompPQmXZfyFtP
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a79e3 cx=c_pps
 a=Sa5LwqyZh1jbhgnehO2qiQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=by1YfaDFVIW1-MDklf4A:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: -EqEQBDYkva5UdJlQa5ompPQmXZfyFtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXx+6bTWegbwWH
 qc9g3J43uAO8YN7EXSNfMD8MK9Fm7DPPQRn6Hy7yl2xFxAd2jFk/rCe/BKvNFBP0ofYgxAL6U1K
 Z/2tdqJk4LJOyPvL9be+1W/tsEKc1buBVqxSsuMwSmb4PMEFypS/btlurhFKMe3Uk3m81nk7DCK
 0hN1/McbtH0xR2xmvKMkfB/pzWN4zm6FXzSQRTl5+7EHn02jOuOzPuWP0y+LRSYyVxBOA+8CbP6
 WgGZra7dhyzRMTHNiH5oi0Sz9PsUU3lDxelTtTp/uiTvEgh9SDrMXzcf4HIiuNRauEfrNLvsEyU
 9XnJSb+OSlcGedh0YbHHOf4WMUSYa0DjcQCeurwszv6EpK6SXHvYi6VhP69s3CtFWV2H17sHtRd
 SpAvGq4sih5CzNoa3WSP3WB+a1S7A06K20w10gWL58oQdlxdIrBKRZS03Lo16/oujNM/ecEY55e
 3dfVeE7s99pov9gGX8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f8e266372367..046fa5d69b0f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -458,7 +459,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -476,6 +477,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1317,7 +1323,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

