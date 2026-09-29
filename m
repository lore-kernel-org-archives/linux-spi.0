Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501244607B;
	Tue, 29 Sep 2026 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663815; cv=fail; b=R6yur+edqRtoKQ/pRKOi9Ol7FaGUh0fTtJx26rku5iANdeC1Nbq9hhrfJN/32XZBQVnQ/gvYUj/h2bX+qEAGia0Lzu5Rdle280S1QQWFxr86SbgkoTSr4j3KAkUCAtnmysrXhwdW3UXYNPcB0GZNYFjz+9MS4A1fLkGU9B+DAB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663815; c=relaxed/simple;
	bh=F24H2Pr4k3bYmni/h9rZkKR0YlhIEkASuh0SymAwWT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7ABGlIkvR/vumXTcmEZerqwsrvSvIYghANPEJQpPzlaObq7DiV10vowtd7konNHtsBFsf7f1/UBPHL6TDPaqJKnLJnuvUgodl0ti50nYN46LiX0lyy94lZt4YjanWg++YmX1klangBlq4sMhZvHZlR5yBDZwz+CbcaUNjz6TJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oe7ErV01; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=JyJ9ONOe; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oe7ErV01";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="JyJ9ONOe"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46XmF3284408;
	Tue, 29 Sep 2026 01:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=GZG5LkxyJzUfurkyhbpPubmisrMCEMUVigG4UnInP
	Aw=; b=oe7ErV0129xrXbePQM2mobE+0UvEOQNhozMaYsjaz/teT0o5RtyFDCI1w
	68hM3zpcfMnuxC/8hnoxBHt683qafUllrBeb/PPZVuG+4QjPK7JNWS8zXmEz14qu
	qjYb0+IQWUlGThubFiB9MGf0NXGliiyBm8UfTDbH5OAjR/GNCrqQL8jMuCU7ZzuA
	3zk37PHir+ZvTxhH0QTPMRol6CLLPeL6bxUiaSvsBg/NEwsUEYF7UeEYNBNHIK9E
	IafhM51TdyzGu208mQVnGHeoUpKvH7za9c6PvmBPkUaCa1XDPiSIIRZ1lV8KgjGL
	1XrlhQo2UF9LXA/7Gpu9MSsiJCcMw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h03e7UTManXi9PRJ6nmxvNqIRVOkYCAWIjM00cpqdQv1SCtRQm9I5+ikpShmEoBG42eRV4DSvisaLHWLwdeyvXaB93olRvlVYjqffIwRJMXY7UqfpaOQt5V19EpPU9qgrZFG/QEBJoj5TW+kCLtnCsUP3cY3zngplCE7hRA4Wjer2bwHenkjQoeKRSJl5G1qOiO2hs/XG3ixiDQSvhbmusv+8wAbd9EUC78owctgTIclXY9vKJsjcmjILRLItY62U3Es27ATxrNYtYm0r+xFngeE+xtVErXnjlYWMftmhNCfbG0mAkKqWBYI4nB7fPetzcd6WQCM9K5w/x5DvBzGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZG5LkxyJzUfurkyhbpPubmisrMCEMUVigG4UnInPAw=;
 b=s9uCrZPYacahzlK5nRI+XRQs4rb3O0k3ImgyBmwLfB89SFnAMLoBFUgX9h+Bpm4p2vxrrUyuQtHRWVMNnWE5VZb+FQefSK1em0hOhcxRWMTym6DNIHEFOPG2cwp4jEZRdofTVz69RmONEga9n4aWHUMYrijKDUcdX/eFbrckH1BuqgJt3Le3l3hhF0EnHCm/VulH1DLcZHnXwCltqwQPhMzRGm7wzqacPrTYFD3QJRKDNWqfsRTCmDlnPBRjOPrhLUp2Qisjy7gvbAiyydtyN+FbxKGd+VUheYA4DR+L+4mFtNRbpsIpdQ3VSM10n0evKhRujU3w4O5HdDVfguTuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZG5LkxyJzUfurkyhbpPubmisrMCEMUVigG4UnInPAw=;
 b=JyJ9ONOebsz2ccDiQq4PhOjQZMHNug3yjpoUxMtjTrp81Uey8GPRc38ngijOZGU9jWszE0aOc/U+EevXsBsWY3ii+2JR6zj7jO+eIMJHpfG8b6XMy2/vQyVBaSfyyYjr3TMkLdIymdE5txuojibeElftEP5y+6sIcXnG433UJuc=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:36:23 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a2) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:36:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:21 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:53 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:35:53 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn21395904;
	Tue, 29 Sep 2026 01:35:47 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 02/19] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Tue, 29 Sep 2026 12:05:12 +0530
Message-ID: <20260929063529.1235417-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: b458857d-a4d3-46fd-f3ab-08df1df3f9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|10067099003|3023799007|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	h2VHMRwQCbs3I1zu+kMCIAzgPrGrEIW+8RpVjbJrcle/s9KAplmu1weWI0FkrmIf9uC0z04S4iXrIycVGDD6rvnMK6FjJBe2NKPk+6Dd/O+/O4Nz3r1sU4L/AZbi0DZdVeIo4pN/LA3XSrBTy+woPsKAIWBXtBL8q+qPz9aHo5cgllNiYtTkcuZ2WTbzCGgd/Y1r1XWCGKyKZJUg8a3QVyENLtUNbP5EDtRMdsooHH3g7TtCMjoQ88z9UPz8OR2rBr0QQTPnHRuf6+f0zxoi8K8iw8CFbG1hNkSRXkmsfLMEJUq9HZb1PFulMXpL5WYwAw6hrTBiwQ0RB1ZK4Om+HSKDLbA9jlbiBzH9oghEpJ0IFCDe6+M2RZPqSDNFxL0TM97+GPgWPG4Mjb/DdY5Em6dpIHErGx82c09sBP4SGY7GyEUKSLUFahV0I2OHT65wV6GjvD+zs3VKJiv3Vw1j944kXXoCgOq4vMi8T2iMQW/msMS03Kpe2lezREBw3psdjqSevD1EwIRHfYBo8sDljNl3B0Iii75w+AYjWKbt3KZjHosVM1+Dv/2ETv9/WighCnww4fcDm5veSZ4IaHaHZ5G8qV6uGvgVaqpxupKnMXDkyMSMechJZVFae3MZ7wZ4b72K+k6Ns5xWqPSpBmIvkV4Wr2/BsyD/4OEEkDiiPlvCSmbZAwgqWLZMbBPAvUkliu+giaiabOrxKidN8/Clv8AyYf40h951+TVLOZ2CEzT3T+thr4WWTefjUfkhYE3d
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IdE9v6KxgZVYZ273+EoztcqWDmVgI9z1/q7d79yUMl7yV3cIQ6aHNzZYcr8vLbV1VtpmTGrr47+yg45uTLXFXoZamTgQpRkxt3b40ecyOVZOvwVIeSXJTnm04f6TqHh4zV341ZdDSnqubStRA+urrB8jWUkNLHwRPyLrGxRAGME/+TxsITsFGDqY9CR4F6trCjHsX3DC9mu4cKR6BZ34USatgA0Rmk6O7z+Aw+6zCapxRGEgImQJqwjTNdrGPGyi7w8TXrsei1htDHsZ7BEFpNWIaeOBlTRgyUCsCuuAuIrkn2+st1VzpmMBB7OdqHEB/RhxEINLOoWgVBxD6muPoWEz703VKSailwxeR2MzkxGmWOvjJiQsYD4MFnT4nvDO/V2vmrAkiqXs31tm9IfD4zzbKmocExUbcO887o5Ptfgs5Sh1rvKI8h1lR05swXVv
X-Exchange-RoutingPolicyChecked:
	GCMXU2XFf32btugAoReBi4GwzljcShj8MCzLkk9XSZ0DJ0NO60TiwFXEpRocQGv1RJ8LUQvvyRfW3TsAMDmNE9Xvkw2gMuLyY7uHx1Ywjp8tXGoCecnxFJrgjVAEtv7GtR7Alq3DnfMqCC50UwCarO+4OhzDSa7V7XjX+8WDgpuXrCCDqmV4NXltixQguSfkgxtc1zPzXKXUdjXhjf1X9CtOJn3ptrDcQCvfN996H6oc+xfL+HERf2Q8UPlKXxRE9YiDHu46KLwiRD04yxN7IzAPWbKYvzRCVUzADnnbM/1DwiBWfvkyXcRp3XFrTN2gzvIkrxRQUCiLFjTOtpFv2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:21.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b458857d-a4d3-46fd-f3ab-08df1df3f9ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5c6c cx=c_pps
 a=qHyJGWWDR7+eWeZXJqH6eg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-ORIG-GUID: uXqqGUAG89B4Sjb9g5ojGYfZv8P8ZHxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXxBqt6hD/7eUU
 IGZoo+lBi59Zso5qFPtk6wEOxWT1ys/Yn8NWv2OZOEeoFli4E7YruQeTbRz2JtJ3vD10ZIAOdIt
 rsH8xdKPTf5G6Ngdp3MRAwzZZMqkGry1hrXmwcsfOlWERNZTKqc9YNRaxUWUDE9c6y7j+A7B3Iy
 HVUWsjD+/G8Euu3ob30G8HcfgoWmyXYhJeON327wWAMGkhER9Oq49HXS/A6Eo3qCuIKNQhI6Q5V
 Jeaf2bNY/vIQ3ItKaDwpMoZfNhJLy0qCedzbUpbEK1FxjOKxkkNgxj10uNUzxutfcgHO6wKqY6B
 qGxdlJN/6ztsgov7D0DP4JYtE2VyaZKYCeGRR+DOn+XwMHsxQgo1F4FUegPeRKmd+TP5I5rMkLg
 Cg2t98aOA4ynHLDMWa/w4S24fev7wZWDVV2Zr4AjXUmS3idCx2hku0jaI6O1NHdvpbZIH6+P8Qi
 +kWd6s0tLFqI1OJAxug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXxtxl6yL7YmHc
 uoq4phL7ggHUxYg6Wb22Ufwega0dLC9FGCem+O+/BxtWLCB4AYNDvSkhQcSuKC+kGKU4hOHW1ya
 7jGKxw+dEKdsNJFgl2xJA6V7pQP2Fuw=
X-Proofpoint-GUID: uXqqGUAG89B4Sjb9g5ojGYfZv8P8ZHxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Add spi-phy-pattern-partition, a per-device phandle property on the
flash sub-node that allows the DT author to directly reference the
partition holding the SPI PHY tuning pattern. Used to locate the
pattern data during PHY tuning when the device cannot load the
pattern dynamically.

PHY tuning works by reading a known data pattern from the device
repeatedly while sweeping controller delay parameters until the
capture window is stable. For SPI NAND, the driver loads the pattern
into the page cache once using write-to-cache opcodes, then reads it
during the sweep. SPI NOR devices have no equivalent opcode, so the
pattern must be pre-programmed in a dedicated flash partition. One
partition per device is required to keep the procedure unambiguous
when multiple devices share a bus.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml      |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 891f578b5ac4..277dedcd4246 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -209,5 +209,22 @@ examples:
             cdns,tsd2d-ns = <60>;
             cdns,tchsh-ns = <60>;
             cdns,tslch-ns = <60>;
+            spi-phy-pattern-partition = <&phy_pattern>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "data";
+                    reg = <0x0 0x3fc0000>;
+                };
+
+                phy_pattern: partition@3fc0000 {
+                    label = "phy-pattern";
+                    reg = <0x3fc0000 0x40000>;
+                };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index dfc965500744..ee84a3c2b34b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -131,6 +131,13 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-phy-pattern-partition:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the flash partition holding the pre-programmed SPI PHY tuning
+      pattern. Used when the device cannot load the pattern dynamically during
+      PHY tuning.
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip
-- 
2.34.1

