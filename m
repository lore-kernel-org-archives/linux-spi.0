Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475B3803E1;
	Fri, 21 Aug 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312999; cv=fail; b=C1dNPMNpwUnqJNYeTtmba51tMYT/StldiVg83XCV5TqRE7hb8urWOPCDr0PaI7IDi5O5zin1iO+oQQ0PqJypGOjdgGrNMk4BKPndFwegVmtqGDAMuIx03eIkIUly3sMbyxjmStdvp35tw0nKfv2+XujLPgVtgaQg8Q/7dnElbHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312999; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiBC3Iron4XBU07sNwrtXyokpVA1RS/RdHp7K/iX7edDnGAcuLyFHI3aXpWsatDqTYSLHTJTEbrcFC11MNRdh5/6JpLZuyg7HLmH3w5ym26FwBxCsVGVXsDzk6rZLl/IWeq92NnQrKqaqhPgwo3H4lCCMFtR3jhqKKZklzAXoEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=EqSFYVQW; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jfELBJfC; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="EqSFYVQW";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jfELBJfC"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KNIG3254941;
	Fri, 21 Aug 2026 06:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=EqSFYVQWWMH4lrEyBxY9GSAkySXYBtxMmCsXs46mn9M2OLfeyA42l7DcG
	4csatyo7sMPZLDpzQY6ODkwtrAqFppzAXtSDHe6P4u1WFQ/X0JrpY/A2YCZPy2zv
	yslKwZ8xSqRIjofOzcOB9k/CLslrrM5CHIVVNxobda9BbR0ti9u9pXny+dYQVMpD
	myNNkwwQydsaAv4z6bpB7MxFi+5IwKV+gpPgwjhjszNsFKOtbqnfVacRRcPgunqc
	gZzSpXLDTFpwWit6i1QIzCKf/Z5K3vKPiMiYoimTvdwfu4L/4LR/zoygBLelbAOp
	WJSRWBZmjlYlhI0LKWsXNqvf4Ym7A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1df6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUgJH8gxU8Gvv7TAIFk1TXvFja59qUg/efuiQR7OMZsFj2omnXtfnl+Xwgdm9g+QuawgXlhNRiwn7wGafTvL2KnC4sxtEg0NvjH1KuE1YfmczNa7k1ILMNLA56uvVIRZ1TamomRsurBRkzy/LMgE2NAVFtPKUjBYOQkzKQ889nbr7NIZ3uw2bGQv7Jmv3j5oSN56g4xHmwYuA+O1YALutE0TrvVy0LOdFvGWwpWnz+mUcVpjrFYwbhv4irS5bwpRFfprYQb4PA6XF3R8tOQRkPTN1qbHzRHD9gymHww8YIJzPpRGkp0nsuTiWgre1eHb+h7ax6ZbN0embQeU07CGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=bCYDjASr7NADnSrQo1jCZWXnSxyB0z74QexGQc0HaVH1kNoiHpvOsEsZqRTeaF++Rq4nv04+ga9myrcnxMttlxXme2L3roiQ5Uqbxy+nxMxyU2tPWHyv7CD3CDznySE6qKtU6HO5uzCzYQXH11eVdl8buV5eu+oerEgo3KGwGxhL7CGC8gu0EBcrG/ec1Xz3ocQ6dy0j2QlP9wL6rc+UTU9TPcVavlTgao81/55S13TvCpMn6gq3mxnbaxNq93FUggDbfhhdZOt7nwwvgs/eKcE8aXrvAtjcx2LIbufJrOSXoYZLVkSCwhwIcsDlRo7Fmb8QpLk85sxEX0YEJzrIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=jfELBJfC+3od7MWVr8AEv96mV7GqhQfEYq8XKkP3t9fwx1Uy4h++eESuQ9s99OPO/ccGvlMoL9PWTSM8KTRI5Q5lJT2IUrvgu+BeIc+DE3PuiS51w7EwziWL21vbNYgKExFB7mSUbW2KyPTLwvKhmosnDPIelAG0vD9KTgk8rRI=
Received: from CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::13)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:37 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::2f) by CH5P221CA0018.outlook.office365.com
 (2603:10b6:610:1f2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:36 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:10 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:09 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlh2022942;
	Fri, 21 Aug 2026 06:49:04 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Fri, 21 Aug 2026 17:18:10 +0530
Message-ID: <20260821114822.4040338-7-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 416628e3-10b2-4d91-3df8-08deff7a4685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|82310400026|921020|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	pLyPs2oxokESth/MDqbNXTYWOomMZ0y1WJfDABOKH1ezQ2tD1VV0djmLqswxOyD0PE4d4/FUMeSM7/5aDXaBhpP1zYWEGK94s80ZaOuSAIibr36BZyPKkABgeIiXXOq2M5sKLjx3+CkM61srFqgbpvXc4Hcy2LsIqcM0Z8XDuhRVyD4CJx7olAMHZXswASDpJwMkAPxDVGC+sEjAlEdIBEiAUEUcokuOrbNxGz/1WasBpeEYYt6imPdG6CwmkO1Is90zaJHjVjTeJ15F55DJu0iGtFHgCx+b3+u68GmeDLRIOyzbkHEpgPlPljlOTt26Ka+dpntBKkdDjtH2MRQC6tlHzWvnSiUb8XT6yg6IjUwkz9JAc4ILF1AjfyhGAjN9jycRh+WNuaEIxgPpjxvs6FSuoKe+He7GQGD71KNBYqJVAuGmZKv6C5M4RIv5PadkzBVMG4cVCXKT8NN/GdFUTyKh2QKg8TjPNIgn4NDn3zKECw4pLGBH5byMKY5a1X57/TOZ87znOIaITrWBGwLEVBFc1nXvD6kdKlWyzt/1AEG0o/+zp3Q0AWXBu0jhYX2ekLFEz6JEgC2nY399R6DVIg3GEmLcNV7Q6F7kFVN2GOo9W+1/1kkyXRmwLrnyf0W+JWexeEAI07PM27LEBiXEdAO8hAKyjWuSkQ6LkwWTANdbVYpN9J1abpdkMrHDmOUyFlUgxJl/ZlD1TOW27ODWC7+nktsNTncjJxrY1g3gXBzLuDZOAoKapGMjKVtt45DW
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(82310400026)(921020)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mp7XE/4J9qzIY7KV0gRJ4zKOG8wJOtnXHo+u4ebKP2G9qGNfcQx4ACT4X9RGCS94eko1lZxWxSUDwY5y6ySQVOIPMeYyCzD6bSkUwftvOecvNwOwKlwn3KYJiOPBNkyV9xRU7Fifz2VvdcywfIB1Yr0cIbC3LfAVg101eCYK4sBsl8dYUO/QCKKRCMQyts6UsuJ+gZ3nZs+zTAB/1ZnLf4iigGgYC8Sr7zY22KpgTvdG9nbTu8KAdR2ZM0hW3K5Kea5eD+TGPXHVyssgQKkw/phH5qE4zCeTrh48geeBa4oQXVes2UeIuMmr0Vlkjh40Ojfo4CJMP3whjR0hqwcND0RDGSY3ZL80Yw2UBswejGHwFkP6xYRQZM9it0tXyTuJ3NVtvDzLwSGl6zkd9mTzQStIy7fO9D6aRw1Cpko/g0RMmm3j9Nlol0eavouguQCP
X-Exchange-RoutingPolicyChecked:
	aqDRODeNufUrgnXV38EPLEvbdRD/JfTTfWN0YmKXS4Nwzt6HwyMTRI+vXIhDOv71xLzzyJ0PMJg1YybQt/SfgLNrrLSaB3n/J3ptZPNDAez2Zf14jgD6jw43LWwgktIPLkf/MAThyjjALp1SenNOAkCrsPPy/VoMDSpMmXXxa32C3Ls9+7fz3knYZE6HNM4zAXCe4kJ18U5NysxNIp5qtUBRjoowSNgp4QCIHyPgGlMbYQjUB41rtfFJkD9ncyG/o6FnAlAsjK7Lt5kRAcdn8p63AGwVwHivV7hXZVXch3AgaUOkGSKQMgUEe2PZ2+36ZAAzhFtWU48UqYvJQzW5+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:36.6436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 416628e3-10b2-4d91-3df8-08deff7a4685
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b55 cx=c_pps
 a=1QNZTIC90Jmhh4/qmb3rWg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2vpyfyhlguDYHLkT4YcA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: lE1KpSXJQPdrNgMKUPmzA-g7jp4YTHzb
X-Proofpoint-GUID: lE1KpSXJQPdrNgMKUPmzA-g7jp4YTHzb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX56Cq657ya1dn
 MBlNlRRR2CyfFXzJfNKcjaTuLyPuOwCQpRQ2NbHTHiZHVuK5ULQ2GTZ0C6gsWNe8k/cztNl88aU
 hhNBA8Flk0Jr0zkq4LHy7Rzj6+kzDpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX4mvWxl0sBFPG
 6O+Zw4HqCfjsloFpUXuINvGikUh1h5X5TQJYNvRH+FODxVBuATLwIyhGuwXlg4b7VHh3dLJax4E
 PdbOgpc3D/k0vAzqp1UecUfDSQLsmWpW0RY2bINktpUCfYt9jLjb1hmRhvKEBairJTBFve/rxNW
 X8DgsQkAC9dNbTxXv3hTceTm09bIt+W48Z3IZMbMEHDbgBWOJBVSx93eA30zYPzRd8DdS8ko74F
 4+DPjPnkuFMO1vCKsF+z1tfob6Jq/HHEy0ARNL9J3crACkTIILiLQN3HT6/d3p/i1R3x4f8nhQL
 FucJddJxiwDT25PScc3Juw86pH7VPqcd7Pv3Y0i44G0+M9GmFpuBhDqLu3q/I2gLTAfh5YPzdnu
 Y8e3+8u60ZlOAJmTtxDiakar1ghjwiS2bBKTBHdC2N53vuQu0pOzXJ5tGaSk+MbcLB+lXenRLuE
 G8gPq55PpBd8Hk/5CaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..f8e266372367 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -457,6 +457,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1274,29 +1296,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1

