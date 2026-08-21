Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504C49218C;
	Fri, 21 Aug 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313056; cv=fail; b=CgMeWGuYLuarAPyZ7nY9YAS80ui9bLD7iYYj0zn4BZrXqG1sJJxdQNwdgmW199o8OCQxjrN4bQMn3/+v7QnbNPCKSKxFUjWwCg7BqOEpk5HBGRVuWohzDpwzoDGDW4kQAZvlvjlLOdcSkKYLnvHkTssltv5H4o1W/NETEpzMo5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313056; c=relaxed/simple;
	bh=QCZfApz0WI4MJamsj+4VqpsLIBBqXuUtwo6CKXU3FV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTrIc+brdoE19QncI26T3R2M76k5DTZSzrn4zZQTDrHx1TuhK4phudsFMlnauwMdroTIl4a/sueeO5lgQXwHvDOR9dJ3jXyKbl6vebzpAhNPR5qb4+KlknnVg4AClXMxBUrQ6T081luQ2NOjSfDKUzLLkqCWtbVapYR8nagcq5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RR2ltqSv; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FhRFGO+q; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RR2ltqSv";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FhRFGO+q"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KRu72887015;
	Fri, 21 Aug 2026 06:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJR
	yk=; b=RR2ltqSvCMprVOfRmaTOlXQBqZwG/oyuDH3jBB7uvrfK1pGqdDM4xiqec
	UI+whvzg0xZt+D1nhU3gVGGV+OGY0XNVpkVW0cy9jHXOyL2ItJF+xfkxZGWsGIKi
	LfDFv+M0KLRI3vn7chT+9EZTqw4h+lMsCr+JR/28dWBg11lN9xwj06yuVcXELtw8
	xHduiiajWy5RA4uPG4BqU9Mdsh7mOoq61hy1MsIA4F64xV5d8mi/Vq2Mf4C3xN2E
	9lkpt5pIJ/fvfslSacmcv102D7WdxP2hJsPqWp4JYpD7bLNClYvf2A4hrKKsnAcU
	+42WNcqE6KYRVl2Jg2UyYqc2eF8dw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g6gke1mqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:50:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUcdpNWbxtryHMpf2dt8siNtXmeYKjBiggZTICbKUk/87ZhdcNHX7o9CokCtOkkTLeY+G/qSxK2HPTcOEKidaRRYe69YOfLYs+aqdjpyosoIq8eM8TNDODDGPfo+MSUv+MdEAykq6CNWZay9VKPyy6Fjnz14S2LhCTh+zL6f7JY5YRUN2JGYTpPD31USXfiEOxLtGhYHRdjgu/XdAOaGvIhlK0I3SYac/eRwDyBVcYPGZBMy1XgP5O0z214oIGQAHzwiRM/g8t8FYhnwxMgzks/OkFnVyvAP6zDcFt4dIAbCRruy+b6Avl8hSwVimodjLz5OVRcZYwkzlLzAKAdPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=LA5s2eHraEgpcss2Yy2crT8n8893Hbsv5bhI7/jS+NPnQp9GnnO9WpysEx3btdo7BJBeNONncEmqVNUiUTPZL8m0XskgrgeTN8AUQRBMRN84Y2B+0OpfsXLBlQ1PjdrqWKEqaHOLfpJgOhn5Lx7OY/PdRXK7x3CHz/wzb3uz2oLHktupFnHiI+FJ91t1beIRv33lTw4010++6i2lopv5zNgIc0egWR3gyK0pIojT1BPB2gfLNofcckeGwJ4taK+rHfnzBe16SPw2oWZphiIaF8+ySmyweYDvegMgSYzTEpT4D6RXN7YT1E0HHTllL5tDM7y42aMAHVa2NMjuYXgRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=FhRFGO+q3VTqWoo5hllcYz1SYJKfHRmBIoq1/FHjeOnwNR+DnQXTlOUi6e37b6Xe7/QCh/uM7QLgR0scjY0//CmRVcbeRGpfiq/j/AFs44hUStEAvNYrXXGE/C+UirUUoTH0qxM77ALCVLjc+CmzfJCd6TGbxKOyfQk61CvtEQ4=
Received: from CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::28)
 by DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:50:39 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::20) by CH5P221CA0010.outlook.office365.com
 (2603:10b6:610:1f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:50:37 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:15 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:50:14 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlt2022942;
	Fri, 21 Aug 2026 06:50:10 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 18/18] mtd: spi-nor: run controller optimization before dirmap creation
Date: Fri, 21 Aug 2026 17:18:22 +0530
Message-ID: <20260821114822.4040338-19-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS7PR10MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ea8083-7bc7-4976-2601-08deff7a6af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Het1R0eX8tseFNAqo7LqkZijY9hre6owpUihL8Ddgp0k1n/lJdT3cli1xktrKWcbHpExBg/Mc6EPrgN2zxoH+JBcI2Q5K/LtswCnzMP3Dg1UnQwkLJUgX9ZfA5mGGB65tZ4i9B7k3njdeMzr5CN6t9BjjlJkbI5fJ6aNBwhlVi7rnfG/pVYZL6yv4vmFbUkowL2wXs2L92vOm2TzSWt2ODfRQh94CnzvA9NhXRvrpZTUmd+l1XkRDNDyTcKRUKRf8CVEntBUr8DfnjeZdvN2tLCNZDLrNV7B8LoCLevPSe0SMx+Ycu3por4R3wWgT1urK0xQBhpyTULUCOILD3T6nl8UCImYNcWxCBihBnxTsU3OBTkdpzu1RqhRcO+W+NSmGO/y/DFHJhGtLjfUH/8+kDxxzhC12KAGMcyf7tDNidTyGnLT0lU/v0rdyZnrk5sViSOBwzBPrfPh3KFi628aWSmKWEeeTasrz/hjZktaA0IWbgr0x/STTqj2Zp6rWaAYOYOL1kOEcSVLdLvxo+SYzUfV+zziL2mHrl0mq5Gvp4VMzVRgpgiKY7lMpPu75PjfSgEIiWL/UE/9sep8QDbu/Regbk/tzxzLSXClQcnRglwNp9C9twr0eCkHSvZmghKPboDhuy494qS4I44DsGqk+DeNkJSKdoUsJ8J9QYq4+Co4hAqkMn4JGgPNE8589PwNPTZaGd0Yt8xuf7IDvpmMp0OPUK0HL7KcD5QwmEQqgsvhGnmoZF5Gb2UboHPKvueb
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I/zM+AeQc95vf9y+1pBXQ8953M2uHw92+cS9fn8tO+Y5UBfoSoBnhpbAboIok9GkqqMLqaFcOSDQB3LWbsJBPHNE5o4zkFUTJKJh9yI+dNzuRbTBrqqa3jwEd1FXe5lUUI2d3lb7bITxUgDf5iFYV8yHeI0JKdf3kQSA9m4uhaE1/59iomLKejLAKjwki/Z0MB5xkRcv+SFFE19XWUlJIlwe3jOsdWVKcX3v5IoE/iNnLLwx5xhRkw32+W8EoVdud9BtRPd5GPSwdoaCXZfiajcmm5xeh9O6bIT4yc4+VcJGsBHZeYt2UZ+Vv1MvhBDyqJL7Esq+tyoC9zgpCSMZJyu/n/L22YhXUnqeRrax4MeebiWaCybytmt8Z2tcMVA7YbQ6xsgeGBnVdXsejgdVIx227oD3c5NP1TtpsQ/8ESx5+gvJn7WUfWR4ocKOEGHr
X-Exchange-RoutingPolicyChecked:
	B/JDjdgiG6CJ0tCx6+AZqn8d8pkyiT+Mph3919Vvw1XGk8b1x/m8aANW/qkRIF0MmMXQXKvZuSamaBDfSQF7MEHAzyAgkAF2qjImFgeddLWgkWK07I3VV1mFL0nQbnJQn0YPuD3bnV1TZoD9M0t05McyDu1liSv74biXaxSxaDxgORY2yFxDyQbFr81VXwE+zWCH3WhDDx8AfFy2Hk85cCmrIUGZOBjdfgRA02opJDZfejbRcP4Dy2he/OcWU6unPBTFgBr5cQeEneVyPf2j12m7v1fdUpEVkDcbdInPoRBbQBIww3bC0h5It01oj9fDeJy4LhALo6aHSkXtv5IxRA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:50:37.7955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ea8083-7bc7-4976-2601-08deff7a6af8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4990
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXzHGxEWX4aBny
 FdDz2Kck7p+ST8AumHAY46L0qwKU/bcDVqBtZ0VLPxPkg9fD09dizrIvhC1yT6VFnMbb0qMwU3O
 ASrEsNWiAWCKxLdGuSVWD3UOJsr5Ci8=
X-Proofpoint-GUID: GWZylLNDMpOvPOZCsasFcpH5mXP32QKd
X-Authority-Analysis: v=2.4 cv=Fp41OWrq c=1 sm=1 tr=0 ts=6a883b95 cx=c_pps
 a=s0vAXdo1X8BWGfCUIwR35w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=dAWDYLcBFR4q-bF-ZFAA:9
X-Proofpoint-ORIG-GUID: GWZylLNDMpOvPOZCsasFcpH5mXP32QKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXzgjs2m39bDfB
 LKKVDm+biyI8JzNZseb62y9TrOiO9l1/bulYVpS6aZ7MXY0ae8l0MNNfwuuGT0+kdUxVEJ8G4u2
 fjAL6g67oixBN8hxq2OfnPtLsXUhUWtqMK0vvQHDwsTOYmV5sUH7IPvryeZgbfPfuP86w7BylcC
 Qu3comNJ3YKmulzFQCgIB7Uy/Xob+wQsPVr5O3pnwN/N1XkYXxwf6gBdvN00+Tv/Z7+5Ez0EdzT
 xa5AWDZz6fireDKqt2ikMtIL4FoVJz2dWbu1SsPZ8rk69WosuORuKPwZ4AUBQsEZRDqjTE/9uDy
 XmJfYiHGeL6MBokq2c58b8wunWGpyXmnZX/+hr0Wbx9lBfi8NLLHnZYGWYV0aEG9CVYDgiCZ1dc
 Oj9jbAZFkZLS/gk7lgZNYQb2UYPl8gtDDqi5EqS9dMj/Hqj2I0EznmSGJwTV918DUST5ytMhx0V
 zX3EhDGXlLQd2znd5UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Run controller optimization in spi_nor_probe() before creating dirmaps
so the validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate.
spi_nor_spimem_get_read_op() propagates nor->max_read_op.max_freq into
every op it returns, so the validated frequency flows automatically into
the dirmap template and into regular read ops.

Optimization failure is non-fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b683c077a233..2efcdc7f637f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -216,6 +216,9 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/* Propagate the validated frequency; zero before tuning. */
+	op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3843,6 +3846,17 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * Populate the persistent template and run PHY tuning before dirmap
+	 * creation so the validated frequency feeds into the dirmap op.
+	 * Tuning failure is non-fatal; the device operates at base speed.
+	 */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(dev, "Controller optimization failed: %d\n", ret);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4b92494827b1..ab498a50f15f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -422,6 +422,9 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	/* Persistent op template updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

