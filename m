Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC6459AFC;
	Thu, 23 Jul 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804606; cv=fail; b=rIZdKKgESGnBWEu18rk5y4dlzM+JJ0t6ZPg5zx4SNm4caVnqVK15WSQmV0bl31mtkErpa0wZ7GIZigU+cvKB0nUCWjvMCDYOH3z9U1Tk72iPxh9JCyCBxQmSIfmLMFOaEgLzGdpB/l2XOpkl/jTezR2FKneUoTHP48qjO3Y74FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804606; c=relaxed/simple;
	bh=XXod5gsYdwM7TuNfFFwFZK80u1YkPJ13Yfu54EWDiXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxdXn0A6ls9bWSyMZIo+wyHlCa8EKacp4SHBsQ/vRi6voRBGW1McddKjvmPH1SjT4YZyEHHv6y8b5cEXkPrTshlAXZWonKAs2/rL9xRuRLYZLypMMDTtWSGizAjyayi5eWBsXgyos2kWIcGwi9J19fojcy4RTr+aUcq7Cq2+yGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UMMce4JA; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mw0XQhMM; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UMMce4JA";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mw0XQhMM"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9JkQx2008572;
	Thu, 23 Jul 2026 06:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYM
	C8=; b=UMMce4JA5uHIfzLYEHEwIW4j8y7dABd7s0ovfjz34YV+0Rfxu/0qJ3ath
	g7EfquqADas1j98UkPQF64s+EZwkqUr+ElgP9Wo3CCRjrIki6KJzhTRuKZvronll
	wUDLts4uu7neUvil9SKJYX1KsXhoORTfgdE/xtWHH3Yx5QoVFFbigNjl5UhE2ht8
	hVZnZBBVujJjS7IGul3K9h0JGv6ePrbKj8WxZuOOPE7bLea1sUgZwHWFhqCxkO4n
	N4sq5iLLlfXKdlmnmpaK2iJtrrvCmBTJ/btwqa91A+/yXttoKM0ROdnXI4PYJmPC
	WWNGUM4SqdcqBSKXsXmwqJtkqMYJQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fkg7ugcey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYwjWTQc7F2HOrDku2N2UjNS2Xt3eA/DtAMptgUX6rzWN4wkIuu5erF3Bx2eL3hXV7tCjtJN9q9xBXgfUqcBHzfPJoLX8enky+3d+jjNiMBOYYjNtIIsXLtn30t3YpMxqv+zUgInG8ivxsPpgVORfQqtXKY4eh2lEcVuyU7LWr7dxJqaN0nA9RQc9AD2anJLbP0gOwMkUs0PUJUJIncubGWmZTds1Uk7qXshIfBLM8YdpEq/gkUdhgRw+g/8cpUSwS0SeYHSP0AxqigUXEUndOnECvH0BftchmyF/avB1mYyFtT0bx+cYB/ssSR++9gsonIMdUbc02RSALxwZBlYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYMC8=;
 b=Th0Je7eI2cDC36ROBVePXopyeLBNBccczskq8PzGpDNuVYkugsjaTYs51qnAkOgqQieEvo8dBnqCeolArpLWX4GHD+SlaLWPSzpAuXjvWEufmghxTA55gsetzD1viLdtTnUe4RHmdMwLtEkNs46amXt39lt4pzp0MdzKpxp/JjypFMfF2iQDhBx6f++FzaqVeDc2XPxUfSnBgcJh5WfPzI/N0NzNKQ3edLedf60KSyUv8pk1Nl8/5Qg1B05GNdPJnbPQVRb8cWq1jIzeJ20DP83CfE3GjPxhyjonZyjSiqNqlKH+vpZBWXXnimGNKbaCq2WojPeRWCBpfXwB5m1n3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o06IxgyXWxwrCIaljlzC8v05IGlfq0oB+3XuQYWYMC8=;
 b=Mw0XQhMMIMPzxUAHAyvz2PUo4RmDLsh5HMiZN3ONtd/473TZC/tzSBs0pWtTSujeUwFO3vesvvzEjsRHRp7tOjAHcKIlMcZvcSNxPwnCeOM5ntgWT71JAbdtckQccFQWeiFCSQM4NxlRhf+D54gCL0Pj1sIVdnydzOCXmibeyyk=
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by IA4PR10MB8496.namprd10.prod.outlook.com (2603:10b6:208:561::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 23 Jul
 2026 11:03:02 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::1e) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 11:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:03:00 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:58 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW11577597;
	Thu, 23 Jul 2026 06:02:52 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 05/17] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Thu, 23 Jul 2026 16:32:07 +0530
Message-ID: <20260723110219.3180747-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA4PR10MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 98409caa-9a33-41f8-bd7e-08dee8a9f5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|22082099003|56012099006|10067099003|6133799003|921020|18002099003;
X-Microsoft-Antispam-Message-Info:
	SkSOul31+Jh1YBkf36OADHCWrp1dAFcgHM31uNJSQhArJhOVNxtb8qd5Xd7Pzdm2uZx76Qk5mxNctvKZQF3xkn3zdrDAxRRWxeBtLcZrYRQT+bjHo5CF9o0EL8NtkTuurh/M+11v3IJ6lxa1pQ8sV6ik62Es5jJQrRrIoPp2mAGL5cOP9PoUI/k0pdKjc8wCbCqRbDUAphq60Em5ZqDoXZHC2EYWrpq2Xju/2uWkjDQf6sswxvHxvlMDQ4HRY0Ztzah6DSc+7jvm2zhCl5j4A41mpTyoYUTTjRftkAC+oXO3KCAYSKG/Czhz81z4N+ERditbQ+lLFGejXQYkwx5WyyYoQ9Cz+z44lNo164LrpFGx2/NDfCJ4fu8ESE9Nulfomnxe0IT+KnhjExGljUqeGR9OotFVxrhST3flwgj7AUkW3/A9P072KxtOk6lUQDvlu3UW62RF2Z0FpcGzot3WCcEWcwVjjC07Jw+FA0C4Fuys67yMIdmhNFDgO1BBywzUBzpCwCrbaWFc43QV9w80NErNf3JRivHnmvwCP61skMkwVJG3Ct9q4YEqB3OrbelnjEAfeDY1rIb6tvLZ/yNz3sQKnx+b6H8KrU5QaoQt8zvwel3LVtyPAq8tiBbF5G6Zbi5khy3NH3egReLmpK7PF0XA9caEb8NHTC8xknISbSqsbKc04fV4n/A0BHhMtlqozU4fj3qeMbZTjzyd6U0CNzXX79X7xJoudDRuaUGQtnQEdhGmw4nLkDeg+aIPAxYS
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(56012099006)(10067099003)(6133799003)(921020)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wo7n5hffNG0MQaGdQS3/2KHCnmUG6Zf7iRgOKHfRHNFgQ0+m2zzb4Y744VwrtzYhdjB9BbCNV9YC1PiD5xTY53Ty0DJCQMkGoWCH8d5/NRs/KAgGPFwgHIxed7lEcHmU+jyBAjCYfqWK+ggEaUhf3/1YmW6InDEWjjVqSsVH+d0XL0BBxfLKg4DJTQulZsHOfP+iUgQTUU3oxGJN1IQBgAnKyHnBDP0tdSF4nItHNcq0+2t0+Wnfr5MWApsnxSnLKosw+46VgOJCgSpaG5mT9webGEFkIM5eTfAF2Irgk4k0vWJnOLWjrxSMHlg+ZlFSLHFVy/T5fVE+6il7Yp/xsf12RwsF6xkG7QPnke/nj7v5b/aLaYX68GGVsHbqdz6t/WTsbFM/4gaKkjC1hrr2IcRbCP4HUPf2/MfRzXns+P2OzGwOMNbwgb2gojkWyfON
X-Exchange-RoutingPolicyChecked:
	e/bTkQmYGSIYzPtoPBOlnL2X59XPtjF0dXbyjm/mrOJzW7NCLamA9gqWHxR0ovLziIoNhuakvw8uQNk+8pd+TCsALq6s+4VSmED6g6uUpc805nJBHIMEI6Yy9/xTqdQWefxWrQIxWU4DlekodjmQZ53hvv1jl3auMF6O0YJbKgxpIV2qTZ/eMljZ3u1SzMpZnwgqLUiQghMRY9HYJFdjracRaBS3/keovN0pA20Z84kuBDsxwJSwD4RdB7ssNbKXvOR+BLoCDdOy87QZ7sFexlU0zf4rOkHvqjK0OnFexXp00Z7PowgarZObY/v1v/JfVH8JZoNiuM9wzsFeZ2h+PA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:00.6004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98409caa-9a33-41f8-bd7e-08dee8a9f5fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX1QuU9xLp3F5c
 h6i3zAaPGn4ieRaKePeSHhWb020ArHfN7MgA6lA9yuaVdisCOsiQxQxOYZwYT771x6aquBOFc9r
 yYhUeh7PeE5kj2ptaIOookBDT2c58MXMMcp2yWfOOBqIHpqHWQtxamC0g6GKWmIGo3omfDfoy/n
 F+BnAlw7V2J01nahpFrg/9omr6W8NJ2BGqyEJr8+Zt6obGSP/RdYdYhyS8q/eK6vWvrEiL2wus/
 vwhWt52F9O7H6EmjHDoyvSSl6qcwSJAU/U+s5MI3B3hX87zYfgs8w8N3IM6xrO1bS2kkLMtlQ2D
 o7sAqNPUHqw9MbjJ/c6+kXvm0GW9GquW2jtkT3KLiIlU4vdcQ0KJ9huHHEQKIBV0okIj2Y/7+XR
 9onDmtnxwg3ZyBQ2XfILLunOxKLTiV7YrYDJH7BOI6iaBnJWda4zlcsEwhgiryl1JQRZyRa7Bpe
 2pAuDmViBzj0vEC6jhQ==
X-Proofpoint-ORIG-GUID: 3JutbkMTXzGFsUT3iJ9msOrcrXrZ8cul
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a61f4eb cx=c_pps
 a=nfJ3K52CLbhVQgIdADXVOg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=XczTfz52Gg2yNcvB9tIA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX18Yve9Q+ppdQ
 oPCnwG5MOoCsst9li2DS98YT1g1oA+61zmuP+W1to3hUWPqjbU0uPALAcl63GSpwZmaA1iNEY0h
 fF8AQNml7fucjIFZt95GxfOKzngI7LM=
X-Proofpoint-GUID: 3JutbkMTXzGFsUT3iJ9msOrcrXrZ8cul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate.

Add the corresponding spi_mem_execute_tuning() wrapper that checks for
callback availability and returns -EOPNOTSUPP when the controller has
not implemented it, allowing callers to handle controllers that do not
support tuning gracefully.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e20eca1b8245..ae9e2d7ac6f3 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -660,6 +660,37 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
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
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f660bb2e9f85..ef5a6d60bae9 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -346,6 +346,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
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
@@ -376,6 +385,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -465,6 +476,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

