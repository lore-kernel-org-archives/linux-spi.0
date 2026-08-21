Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7398345C718;
	Fri, 21 Aug 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313013; cv=fail; b=NuiYhjVAA4DQL5V/kIqmj/habLiKfsOEKgq+T7Rv34U3/bCzsRPHu5ILTO1xqIcR/Y+5Bm8/msDkuGTacY7/J1FfwWXhkf3PAWs518o0W+pdwd6IoknDFC8gtEvAmbBYhNEvnefAKwecSCZGe/4nrfqJkIs1C0OrRLh3GJKTYNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313013; c=relaxed/simple;
	bh=hq3CAzkpUTFk1VJMd1fRN0aOyH91Gsjw88BXwndIXfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOeGyIAd5s5GlTB4ZS6czLWj1069MTB0Cc4lXDIrrUnCvkLdA1KS7R4g0zH7OUsNY7fEUiPv6TtRe6prhVb8ygOlQdwDpOGjix8bePdefRQ657meuD8ZY4zXbrEpb4w+ZSJbUXprRbDT6qVLo4Gg7VluvLMlaOnw/Xm0OOHxdSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=DscyiKgw; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oBFk/9hK; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="DscyiKgw";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oBFk/9hK"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KJBH3421338;
	Fri, 21 Aug 2026 06:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7
	i4=; b=DscyiKgwgStsfsc19jfYrc/UXsh/ylYm3XTEO8eqQGTIH/Brz09fFBIKZ
	ddjxkMeFRkOmn12l1xYyaeP5R4es5K0O2d+76c3XLuZfvaVIo7PL0gk20TKp+u58
	tbW21dByX8C5w/2+Cdg1qtvcaETBlDl/wxfYdZlTJCTUQqis3Be3gkTjyS4ABvmp
	afNFVnJlYM8boPiCKrgLh0nrBcsLxmgP8bGg8g6MwWeCnfsptPo1UgUwYxOxy8cs
	UoE8onMPVfb+qd7U7vU/dDt1FHxKDG+CPcr+DMY6QdH4vVshu+s2/wzVQadhU4u/
	B+ye020IcYFBy0vxLtglWvL6X2Ylg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6knmrn0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXRGSwcNtxEEaOhWmJlNNTyCQLWuz3Dw/xYzsOd0EQkkHO1vmdPtPgobQTfZ+e2pD4sM3gXbm8C0Go9JlVW73CKJicxmhVw9eXHaEIThz4NW21xvwjSJgMe5y8fpBQY25eUYTAt+vQ8y0RU6jBNw+KuOUn/pPPhJGC3T8C7QVfnVO/tqkLPidqOreBtHsY7auVaXIXRB3rIyaHWNXR+uqrnJpo0MXZ2cIh6CSDyhlNNiv551fwR7JHU+n81UthVFJtSKILLky0Zk+Vc8WMntqc8Piy97py5Jqcm7ILkqOxaa28w4eiKtXm9X4xJQCUvtqnFiisEebaPQaRGZ4S/ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7i4=;
 b=hoS1Yo/Z/3MAB4Z5M89ooC2sPuvOcES9C5engxnlHAyJqpynwJzUQ1jBdb0Xbl6Oh1YfFmytbQv9xmIdrmcpeQI7UHpeOgauhGwOwYlFa1tZsr+fJf5l7yNx0mvRo1uqAYO5qokwTjAosIuB+UmTiqQITblOXXgkKlDAP+aWbuPhmvk4KBDKpTQu6sxIDLFtfGBwf8kQmoqdA0UxShETnqz07STK0FN627M33rGBdJaDyk5zIU5bCeYJUyDANYK8vwnY79qGU+KcKcdmMbcDAsFCJhPapYXr4K4OX5+QjzfwZqnurrwYberxBNkPyaWAJQdWp6y56av74A/ez4YD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7i4=;
 b=oBFk/9hK/Vp5fDtuhMxH6nUTUUgttOPAHNNfNuGcZpx8SvAEYxpnSOs2NfPenD3qD9dbQAErX9LZbj3X7chM2hsrULosA3MUl+zFPEjYeOQ7I40Zvh8NTiKoev6IotNzIbSC+AIPwB/yn9Al0Gf4pBvE7RawJv1yIsLe4S9qxJg=
Received: from SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14)
 by DS0PR10MB997650.namprd10.prod.outlook.com (2603:10b6:8:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:44 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::8) by SJ0PR03CA0129.outlook.office365.com
 (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Fri,
 21 Aug 2026 11:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:43 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:42 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:42 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVln2022942;
	Fri, 21 Aug 2026 06:49:37 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 12/18] spi: cadence-quadspi: enable PHY for indirect writes
Date: Fri, 21 Aug 2026 17:18:16 +0530
Message-ID: <20260821114822.4040338-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DS0PR10MB997650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1360da1e-5070-41af-1a87-08deff7a4a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|921020|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hDINCgiJ+yzRytAA0OUCsXva1ZK3bDovYCXK4OPs3IK9qwFiforTOxxXs9kWn986HsK2wF3IZMcdNkBxQC68C5/2kRnugI3FVHB5WTORepoEIinFlyuLr4nemqTiRNDCPxpHpzC2ZHKVdfnslGEcdbrpbDUyAM3O0T5/QBKmq+zyBip4cfcI4JFe1owU6k/9A3nGNnq73iD8NOyzGiIcfVm+qwKQoi6Y84XhFE86cCRtR47PTjVFebXoZsb37sBRIOtdtzkaVDZCUZvS5NODUVVw7r3Codcfn+ihnbVmcPVbKm+DrKyeuzXMpE6zfkdwZ12o4MklZY4B0xbw1H5IMJGVHj+bU2Gz1TelkxPOE/cBT1j7VbrJ+uN56nj2Urnuk7BZPNwA4f9gSDcuYCKo8E5C0AIdPx57hLc817ZfGK3rcLwr3Hb9tmw7tVsGQfdgf9V7CrihGS/rK9A8x+UBHaWdmYbonSIp1qLoUKCYZbLuRKSN9ox4hiKgxspZbNOZDW04jyA/SOlefHi+ropLgIRV6u6oQzqgbdm5ueQsZT/PZV6p3ZeKH/v6254OXmfJIy8UfUGY1KKruwaty0iDqAiGUYsercTPs8xl7bQ70TDVaX60zedJObaqAc6H52RQpcEFBcxk5+JwgCQXifA7aYdJuPFM81PIqO5PDA31zn0cQtE4jMbo42ClZc0PdlLwVfiwKk3V2SwKfN4r0FOQ6Da5fEr0SCHV/r+qQm3WVgF61hQYKtiHRInElEGBQuCB
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gKWZY6M4lHKnyqSnPjZ9K+u3vFY0vBLpvNJgKy+uel3tz7408kpiq3InO0Rz73xO/LmTMmv98DBBg9s+yCDLuz8QFgSZPtkAVImPFmQDG91YKaDqZ6saNwH4+96vYXVJnSGFByXjELpAGNPWtV3Sr2LxbL6j32wfwbERp7zblXTPXN6mKxnqMlfROhWeu08mZE5ckSeqf3dPE/eV7rrOOeORyO1hS7s0ELchi/2oaZiyrPMdj4mx/xWq0F/gcN8+Rz4mmnqRltFqFdgr1IfBPcE/ZM630TiqTe9A5M8N/54ZN4pH/ytMnsRXCumYAIciwzUOUPBSRVENJpRW0m8dY5QerMwzBNxUTG5DmZU6A/vnpbD2ppj2ijvhdLNE6J+E9hFsd4X4SJtkGaWuDoVNpnUsQ9vYE/cfzB3HvSSUuGX4WJqqvBP2DXVfEsj5YZYQ
X-Exchange-RoutingPolicyChecked:
	gz/JKrhKAniRPdeoUdG/upS65AVhrGSaky78SFIRKg247XBjS7xx9geexlLgwOwJ9kfPcBJ6VTxrxfQJJ3zMyOrh/y4VkXS+EdwBmPF0zJxltRbaWndTak1gAu4Q4qeWiF+hBjXTRAAfhsMbQk/Dt4jVPEWopXqPpfAnbqTkGvw+SDzvVXgbILPFldouzxn60f/KhhPv1sdzFMkmr6eoPPLHjMnTiAwf7ZWjV+yLzs43q1oRKmyoPADYRbUsgaIoybfnDMXZTmx9P43MgWZpALErebLQOBMCGPyix8CcVC35pFTNugpj6VpVXJvNzBVLj7eKL9/9I1oQx4la2Xu5mA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:43.2127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1360da1e-5070-41af-1a87-08deff7a4a6c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997650
X-Proofpoint-GUID: m4HhcOeUzFzYcVmXUQxuwi6asdVEjpHF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX1cUMpOUURgZ6
 lzY/Q5nj3lcV1Fhpg28EvC7Ls8i+HiywagXUGfeuckTMWJ8YPUft+nXOiJt+dz6V0ndSZ2v+Hpm
 iQdAInB/yY/rDTZfp+aQODn74YvyufT2vdgTrLhhwPzrjWeRkOlXKf9MFIR3FPqkGRbMzsLhozF
 95JOHz3hAHsYrughjyfEgY1csNEQT9641DDWrgwA7c7cZL+xu1OlO+Si3xTgqZUHt3bPbw7XhcM
 HM0gGnK4O/uGlR4MB9uGgqEAqoAvwB6vOw5taseP9ZcWME/vjcNChK9ZnniVyKXwWkzBKfS7YIL
 ObKD74L+OrYnQDhO/wvWUJ+jfCyWuJKoP7Gk9M81fBASjPobJy3EhEt2HxqqgyKYJ4MLHzxL+A3
 EuHnceMN1yy/+gJRLKeGZf8sN2fenZcUoL9eiqP+MaXYnhFjS0ducbSnz1FR6Cz+XK6fISCFnW5
 c6hRsKFhPEa4BvLueew==
X-Proofpoint-ORIG-GUID: m4HhcOeUzFzYcVmXUQxuwi6asdVEjpHF
X-Authority-Analysis: v=2.4 cv=fuzsol4f c=1 sm=1 tr=0 ts=6a883b5a cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=JqbSXTAX1eT4zVGs_pkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX1VOd0AqR0etl
 r/Lk4pzD2VpVYAVJdkKDx5kyfqBCwEBbejADaOG1lQDZ627Un0PtExTxiImtfUPoTEJSu0qd1Tp
 e23qBuLl5da86KHkMQomW1hwLgScCx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

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
 drivers/spi/spi-cadence-quadspi.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8903b4cf4f6f..940cfb72b946 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -157,6 +157,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1362,18 +1364,32 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
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
 
@@ -1452,15 +1468,26 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 
 	cqspi_wait_idle(cqspi);
 
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return 0;
 
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
 
@@ -1590,7 +1617,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1617,7 +1645,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1810,7 +1839,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

