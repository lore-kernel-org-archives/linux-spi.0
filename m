Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B383361DBC;
	Thu, 18 Jun 2026 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768337; cv=fail; b=FZpCoLYrkXiThpg3qtyYjR7QTzfZ+3UpVUUOcxSAn5x9VLefMOtrOCArfkpessaAyqyNTdQ/ubnLuCNV2Eap4d0BohPDHFMs4Fc7NZ5LsO4Blwst3RTy5maNAWIFAV/j/DvytEJQ5k/FCPNhqvUqcQV/uzqQWyokOg//ST9biZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768337; c=relaxed/simple;
	bh=xaFT7Z+NeN8X4WH7wDqidU8PiR/6ae0dv46GxhlKZ0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1tp50wTTPMV8T5guNwyQg/vaRQVuaW5CsgPD3Ah3Meybc7ZPqBtykitXBq0tmu4nQPJH4Zkar4zTFJy4+roW9V4WVUwD3jAzlzOypaBX6cT4hIX1uKxA8DGXUk2ABzFGqt1+AowyI6gxfpipWkEi7axtqM9iiW7kragfRNuM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dUKprBIA; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=syia+itZ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dUKprBIA";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="syia+itZ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I6IjPv1333613;
	Thu, 18 Jun 2026 02:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mscrmtCJhQFK22ELCgCkzBfMR9vXw5IX+aotF08Dt
	Ek=; b=dUKprBIAjKQf629P5VbkzqrGE7VZiPQYkg4Osu/ncg46KDvqg5r1Nl+/5
	+L9s2h8heyExCAPRS6CAsc/uBUFz8AzsuOW15EJV+dntLjxOhl6u03W3oY9ph/zm
	c8ta2UiO+DgxadTFRZ6MAhnsvrnQSq+NtN0wrUaZDjBqCWzTHmlDZN5mP3WySwJW
	JHD49VXMCjsl+5CZ12mps0zUNpahB9tHGvX3qqjuXfJDV577+AwPsHq1q0+AkbGs
	C93RPiCyGkOciZ7pQNG+GRmhvaX47amkQCdiKcLz6ubKbRx/v/0IDAQOO28vu6Xb
	RxL+N4XC56NSiZYJUCDGaVtsm1mzg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eutvept5r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5JsX9NwFSRKM1W2vHnxgQ32YWdnYvrBXdaswgoePLaFxmuEnxKS5PATSmrMPA1SISlTmEn0SJrCcvIFpcrwPeC/7Va08iTwDt/w8ijeWHGyC34hnyw6PsKP24YdeY3GV1SP3WzoE0a218bB9ISaa6qZ/un9mfmh8qP1fNecMU5gmHj4KUH/xO0y4pdI99BEyaevdrRFlSbPR9575VMSDXOFlwOYCddbzxtj4F3WSwc7idmyZXfkoGwWT3oRtvdkzLMpY+JLueLf0VmvBev8KKjbu9Qw+x/qNrHpjuBG1/bfnhLI5qih4vuo1cj38yQv11okcX/x/T6z+hkO9UzBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mscrmtCJhQFK22ELCgCkzBfMR9vXw5IX+aotF08DtEk=;
 b=fL/EpW40qKRT6+aLW8hcbMxbibE06wlrYIlHdu7is+Dsrb3qcuo1YB6hSUrr2ZUxmQKMWHIXj7EQpkL3LHkP/AvTJQdnTEIlYvwgi/pOc3Cj5Zbj0cZdVo4sD5vXnwaa7OASCZFSwuwZ55agbS+s4kSYCzkTGFznuDRZZC9taFTvccjx15tzr37yNWAjEBZS8xW9DCAukJRKFavDlIChOLwMJHYSkc8AgeBxzMLrI0W6n+gQT7ZMcNaCmSWvP57wuUHvJcbOBSKIK6aq6g2QnneCrUPwP7H/LqV+P+SSrz7xvy13awmU5hkrL1KiyZXCCia6tXauc0pdwDW7/LJotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mscrmtCJhQFK22ELCgCkzBfMR9vXw5IX+aotF08DtEk=;
 b=syia+itZXMRrV5nARFceknLDtRjCfRcJpIHpAAp6GFOdWzpnRoL15RbvBMkrcJzF+vcvwhLkYHiWdISk8607G7RAb/sCq0B6y9qGNtOMdczaPtu91vUXJY6GoCLAbuPvqcOEwB6A8CRQaA1JZNtl/rv0Y/dV8I3nYZ0lrLbRzys=
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by SAWPR10MB997878.namprd10.prod.outlook.com (2603:10b6:806:54d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:38:43 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::23) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Thu, 18
 Jun 2026 07:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:43 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:41 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvk3521710;
	Thu, 18 Jun 2026 02:38:21 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 09/16] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Thu, 18 Jun 2026 13:07:18 +0530
Message-ID: <20260618073725.84733-10-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SAWPR10MB997878:EE_
X-MS-Office365-Filtering-Correlation-Id: e18ef744-6cbf-495c-a33b-08decd0c9fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|921020|56012099006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	bkdC+6ZFAeD8E2Ddmwcvn17dwQOr30yvydZQAEOhIApbR9FoBcvj4A3v/6u27zNQ6S4S3NOUUe22ljDC4KfhbPPTZaZVsyhWOB+ARX0/SoQSKezAtyU5vwz1TMnqE86htmFdeOjJ/N3nf1gFllOK3T09VxzL2KZwKk85duchTvawQWtkfsrLewxJeuWZ0gt+OHEYr7FdDhpfrkAkreIcA5X9QbrTPVPMjmoRF9qkeN5dMXf2w0XV3wuGU4Bgfh/LTPy9aewzqvsAnsX6x/DwprD9Ghh9woTqHi8T6T6ziszsv+J38PyYtoKVv8GnI9RER8YJWsPu2Pv/3V2YFIUTHkbK0puPCBvp3AMLpUDRQ7elWQkoE+WWidN96Hm46GqmP8jhkZLnU3YiQOhjoXmSxPzXUuYWkwtSo5xwPL7t5G1/8MRiMtRTUcIB/iIeW7qsmk75mn+BLJOBZ+19USakYsEeqZV15g5J+1rB/3i7B4ZhIgXZ5Ar3XY46kmkqYDF6Alx1vZQi0w40mk2R1//531oNG+KsHOJuWu323iflr1GQLRflXS2Np7ZEciq8h/gQKshtsYKifCvRYcOLIO8vMMFhWAEy7htzOkB+TSfZu9ybdnGs2aJV7TFiu8bQLGpiMlfr+0dWa/eKqat8MZxtWJ2GwWUzVh5H8UdpjU4y1+7SkNFNvoux3XImTQl+DgXFSXROGNtUFkwTDqI5mZ7f6UGxQU+XrW4SW7zxOajGshs=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(921020)(56012099006)(6133799003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AoNQdM623tSsf0/cKl3FubETfPcxelP/nvAdpy6l4qm3widx3T1td0tG9RuewZxhXcbuLeFe9gWHXGVhcMagjHgw9OVUa4HJdUFRWlBtpG2fZuTBc75pMKcyECXQfxvKQcMSX9meu0C51wxZi6O5+G8LO/bLZBZR2qCW4/itoafK79mnUa/TU77j7fvN96nzo/8ze39a/jbQ51cSVdqWkNzpI18SQOjw74/ggrMOnf1tbPGeo6ht0+1XRM8RpL4o/pZ6KnaKf1PPbb3vPUirTFDIefCMDiSQhOi9zbLWo1pwK8XmsmqVwgKL6bmSC40tWqzYypxVFBTpVqmnkT/gP5+RlmMdL41/JjCIUmtEEKRec3Dg1GtwketB10Rvn+1w1c6BAvjWqw6TDiio20qqm4Jyf+UL+vvbfUbwl+FDq5hyvWeOUXJVTf4rIHR6FiMZ
X-Exchange-RoutingPolicyChecked:
	D/LorTkETx/BY5zUY+hOzHpGani736bf1f4rtZxne1hKKc3CWAftInMp+zBa6kAYn6ukOP+8RzFi9F9nu/uKLv1c36GYKga7NapKEmpo/nvZFi7sAenXPiXEH1wFrrRKUa46j0RZYeKrtFr9Ym1zMPlO9+D1VY4mbBZIsPloMzy7DGNHPhFm3OAIdlq7gA0pSeIYp4p6WvBGmOjxcp7V86nR9aaoCpS06Jgtoid/8/Tcb3tiFzK6gQHovXOomUVDBtUiRO6mZjXUZ/3aO5aYP2otiGiZm9zrecm5F8lZBKOJIwrktPpIue5kft4F7GjUkUgT1J5v3vEs2iJRgQdIng==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:43.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18ef744-6cbf-495c-a33b-08decd0c9fb9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997878
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a33a086 cx=c_pps
 a=rA8xTxhMCG4Q6PG1LLvkJA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=ozk51zWbLLA4aPkmxGIA:9
X-Proofpoint-GUID: X_GRh59PWAa_a2KU_4h1QrmIe98llyDm
X-Proofpoint-ORIG-GUID: X_GRh59PWAa_a2KU_4h1QrmIe98llyDm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX2qxocoBwuUYM
 dNpSDr9lht5Hjg51PS4DQtJOl/exVaPd7S3Cr+0eCzLWCtl9DOK80QYYfMHY5gfMjp5ZMbj2als
 IrxUtmotVECfx8G5RstJpzMvXkaEyqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX8gdpyIIU/e9J
 KLwgxLkG/fhmHW2Me0f+OkUHxEwl/IjTt9SHSBaCtv7ldTKLZfhwA82fWZ8362msU+XPdSXOuCs
 6oVlCydTxK1UR3uXPboOOR5JjLLHz85wEciV7NojUqaDexILF5B3D6qwxnsYCuwbsXaA1sk+BUy
 DZ5NPo1ujXJ2FoqnEvkyT4+08gKKD4k4JbFwMmk936RQl5eV8W5OqM9AzGlVYlYoIiV75IgWYx+
 zmWDl0mAsrm1oOJ+bc5PqskjaCqqokZctoS2QEsrbEGgVNh7+dmptcMtPiLBv4YPjptsgiB36lt
 tNZc/3taVbfUZOzZtXbdcxle+24xF8E1e3JMs5EyguS9EPKlwfLBGYvbDnngXUWYaAwGN7IepET
 GkeDP8xjnEDp1d275AeVtFOL8xheOCYSnpuCdiJy6eCD/71fDxE4I6yxiqy4C697QxSDotAdneO
 Wqxae0+t05lTdIiyhIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 72768292a32b..22df5f3bdb96 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 #define CQSPI_NO_INDIRECT_MODE		BIT(11)
 #define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NO_2BYTE_ADDR_PHY_DDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3211,6 +3212,20 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_2BYTE_ADDR_PHY_DDR) &&
+	    read_op->addr.nbytes == 2 &&
+	    (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	     read_op->data.dtr)) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3852,7 +3867,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_2BYTE_ADDR_PHY_DDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

