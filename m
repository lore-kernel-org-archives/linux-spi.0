Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513546EC8A;
	Fri, 21 Aug 2026 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313002; cv=fail; b=tOQ0Y95keR9K+gmNFDeZmMo1VByQe+GtpmOk4IqBEQQoVOGXR/DFy+YMfswbMjvop0hOGoe8BsfJbASVp3tIzBY/TqSot0EVZj97hEnKNMQaCNs49ynwMeeP6OAleqHmDoAxUzzvYC5MlNLmWj3IdJekDtDU9Rqms6FWV2Lf240=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313002; c=relaxed/simple;
	bh=F/AnUyhlV2AtS07KGqLS/htPuNT5wzyKdLdJIRHf0Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr6ZlNc5juquyJ+QI573mgb4wVH14Iyo3uc34S5IVwbiZMHoeq6fCmqd1z955qTNiU25W3LVLWfzzTiN7ip259RyN3ET15wGxJcqA18YJjHMZo7wTKL/jVEBRkWb0q8VaDcArfHdC58iv4kMXYPlOVfb1rm6i8BsId3SLZHguWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pG0je7W5; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gVR4vDtg; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pG0je7W5";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gVR4vDtg"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KLvm3421359;
	Fri, 21 Aug 2026 06:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokUR
	pU=; b=pG0je7W5qTr4LPALJs8kqQzV6immm7HNFIbJx7Jv+WisEtA0nITvRImqi
	q8+vg1uxHn8asvL3WtSDDFw0K8MDQf6fcYQboAaPSXVmE5YbuJ/TRSZpCVD8mUBq
	NNlh8b5iY25ZVXycc319bymROaH7Orj1NcxFrzVBHzFXuCdZ5kpHbhi3InUTkl36
	eu/RcPH1oolKERwxRN7Gg4TNiSUP14viTzuk94boEwk6ESHoE+aY/nm47JgRl2ln
	TgaFQ+wtuKywAnUffupJ2LkPjGcfNpHuICf6MKnkTpHzvvuyBK8mRmrnoxBD4G/C
	0ob5T8Dct3/j7xRUAjL7yPvBvTKFQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6knmrn0n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1OGh8dhV1QlqdPGJA14sLBYNwZVKIEqfAvA4ANX6fh8BwFV3ZllmzUMWE/Aqv7X8mLxq3tV9sTrcvaoanYKjuWoJE5s2gJ5MhUovwxeT0V7cgI4KUp5EvpQmHIyNcaU3HEroLh8kn4litTjM8D5w2ub0kWzvKzSkgMA02kPWlWUvV8nBn/QW7NOrDEo3Bf0m6GsNQ1Up57hVmcMKnqVq+qzaOi9WTnFWMoDX9/IQAWjDBIhbq5fQ2ZyD6bczEl+PdrwHes5cWOpersY1n/VbHdPaRs1aL7VSKZftmBniD2LJgHUi+T2iJ0ITXaG4UcAzma1DM7tfY2x4GVBD6tmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokURpU=;
 b=IH/A3uaHQEZq+hcuDXKZXwQSm5OGg8p/wZ6F9BZyAclWfxCUzX1Roh2ZO+Rqm7RgYgj9NsXRs6mxGNhFFR1yfp0Rj4Nyp3zZQlismN9/D1YYTp8y1o+wpfPHJfUjFTUN3FRbZFyDpzvzOxpbZgxzJIS2pYIL5RNMUysqEHXSk5/cQJVJD/e87v3cgpVbMOEess0cRbf92wGYK9qZiR4FhW0Jw7IYfc3IT0fj5DTTUPw6Y/ThQvMBf4f5yU5XODoLobZRvOu6P5V0G0Em+TQCchj1WCqrGh9oOphT8ql+rmILDYGXOabUXgVvK/jnUEdJTw7UkIFor5jq+yjP46YqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokURpU=;
 b=gVR4vDtgRE/T8CbBM+MXl9hAS71mrn4i1A59ZAD/qtwrkGC43sqeFrugDt2QFehmSPQFhiHQxTlZ/Vp0GZAMhrltoYq+DaTvg8fnnA9fakrUJtE8DlfqSPvsfbv/b6AhmrpjSE+pc8ffF+TaC43stAyzv2bhwWEQT5KToSs+UPc=
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by DSVPR10MB998077.namprd10.prod.outlook.com (2603:10b6:8:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:42 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::48) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 11:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:42 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:37 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:37 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlm2022942;
	Fri, 21 Aug 2026 06:49:32 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 11/18] spi: cadence-quadspi: enable PHY for direct reads
Date: Fri, 21 Aug 2026 17:18:15 +0530
Message-ID: <20260821114822.4040338-12-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DSVPR10MB998077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aac8424-9ead-4490-b7b7-08deff7a49e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RvsnJiLykKjvJJ5nNTkwgZUpu/Xt+8tc38Nbc5e7crwLj11PGnhO4OOTU+ESyTc/D6ZXavSheGQZh/2bVDrsdzu8nBkvGeEIFi9fpZKNWihiO047q92xiocWPxDeHA+W/HGXKVotvRTtHZc0clp3ppxZ0hN43od63uHaQ9/BW9kcVcvzAqZ1doGGWI6pTbDvjsID9Yc7ZDpWPyuZF8xn/Xn26CdBTG2Lc8wJ10nJlEv+hPpxlAcy/+UfWrMz+84fbAH1ONLtpwBeITb1Jv4FfD+ZudxLaZWB0wXupo8zUASo7+CgyNUrA40gcVbW1eke9zWWWVbvtz/crSrBt5GZHzKT3VnVmYs1ospWCLDElAweGgt0W2vM2t2yDFqg+XAkrP/DYu21SvJNp7TGQ7RFrieecuhBkQCaVxAYcXOPLTZmiEj6HvHYc6/HnAfvFg7/7sK/x6YuPAcHTg7K9ur8hubSgUaYTVy1rv+FcK3/mCKdzNabgfwKL8IhoJtyS5WyMvWFxB2H1M/oMSyYkivdhnP2kPbbCm1aQpGjoUbvXLbkSS1GETNMOLdbsTlcfZ51ofbh1xC0f5eYzW6g+oPABh1R8+M4eULxgsI9T/mZFQlR7SJvOfELZZPq2PIxTxDEoDu+Vb57ZD17AliFHhxtbxER4QoYa4zoHyqMtm0B48H26kdNXBxKrKul+OLZpbdO8cz8ov9WPFTXax9cTjGbirWrXsjtf8uLvsZ6YSQAEH4N1+bCbriEzcVV8MPcqRta
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oA87Q+RLsO1dSF7YkH/ijIgtIAFm1qhUDTqqhAsb5SfS3V92yK+VI1CzZs5QDQq7x3I0+VQCce40RDLukb12ZHyj2honNDRsoBl12KRQ7SLwmIOxJmZxfnrVOFLgVcYevFWN/Q+bivFt8ZT59IxvHF7l4puzjxY1OtQTk3XFKOzkWm7A5n80tADjCAYFFSdTUSinz1HlV6cWNCfpYTjRwR+Jd7lgh00o6YMxyP6Xqtc8QKwm+7GCFaaNKjkCjrL4gR3L71GA5bwAoGfEAkFKz1bxGTZsN0oCruRmUO8g02pmMLFWQsBuCbJjEoKI4AiDNGPzsjELdEZayzJjCHf2f3LEEkd6ltlsJYTFX1IHqeWOqnMt4+z2ofMYlA+8spNEk0ACeuyZPvMvPOx2KSeESmx36/otbbj5rBOCIhW8dp1APxNktXzDxmktFV3rkiDc
X-Exchange-RoutingPolicyChecked:
	oRIl20JAJPQUUkwdqxV7vme5YvIHrlhxiMzVN1w96EcNlBUlYCzSJv6IAT2zqDL/xUtx7Co8mQyAOJ9r34iVLna5lXjDcm+WuRp3AtYhm5mLCch9hAyLF1AJXxqDAzFPdc3tkVPErdSPWv0fXI6d8h1pKBxl4QV/4C304iNUP4dJOKIoG1U/BHwU7WTV2zhXXhL7tl135yaO87Fj3ZzTge+x/xBph5zuaLzDLy8QgHfEFq/0l8wP3FFBrZp06OQ7ub8BI+lQxqEEn6OHLROAph+vj2ibn9chozGiJJExaWBJWOk5BgRO+eiUZ7iSXeNWvMomCWDXGTRsEhelUT4UOQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:42.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aac8424-9ead-4490-b7b7-08deff7a49e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB998077
X-Proofpoint-GUID: 1SYcASCU8Ei-rTLUadVdyqjVkPEALVb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXxqx68fOw1mc9
 Z7pjtVXahb37alMAlfAb/UKpNUW6QuVMhrgXUR19vs/Hx5wgGIKag5sjOT9AqKyGNkFngJk53EG
 KrKJKua8x+5uxY6A3grPfTtaUnv8kVUX5BPSVmDbn6Lx+m3WIdKJLRaRpjFNodUqMzH7A1fJgSc
 ujSHYR6Xpjb4FEkO1mwb5momUwbp8HUyWlz3J3/Ga+wd48tOeNjIyy3uAn4ihx724L9Oq0Cwlmq
 xhO/lK17kMrqHgjLeZL96leXoELZeJk3m4jNjStdQCRUFumQnwf3OrMUVvjZ/rsXLu6kx2qTwlQ
 p539Hjf75BRUZj8Lqplshp8CkCkFOowGjI2wKejWxBy2TzjmjD2AqGFjJSkqa2hpWksczFa2RKh
 GlQJf+zUcSzcOoddBpLvkD3aXqUS6eqIeL8NH3yg1ivWzpbqJszf5ATX4m7m/zsh8aNFV+xdDAu
 GTMGiWxZnQXPRcDzOvA==
X-Proofpoint-ORIG-GUID: 1SYcASCU8Ei-rTLUadVdyqjVkPEALVb9
X-Authority-Analysis: v=2.4 cv=fuzsol4f c=1 sm=1 tr=0 ts=6a883b59 cx=c_pps
 a=PWz2vMGk566g1z9MD32Dlw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=DtXw2DrE-T2x2gJjnU0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX99UhNOxP0itu
 qiswMDGosaOo2VkwXMg82RdLfAJfKp1+oNjHgaoo37OGV0rOZWoOTEhxipAd67l6oxa/lnOhiHs
 uh2hOGJZqy0VVr1C3ESvHQCL9Fcqf2A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Add cqspi_tune_phy() to toggle PHY mode around a DMA transfer. On
enable: reprogramme the DLL from the per-CS calibration result when
the hardware values differ (handles alternating PHY reads across two
chip selects with different calibration), configure read-capture for
the tuned delay, assert PHY_EN and PHY_PIPELINE in CONFIG, and
decrement the dummy cycle count by one since the PHY data-capture
pipeline absorbs that latency. The original count is saved in
cqspi->phy_saved_dummy so the disable path restores it exactly,
handling the case where the original count was zero. On disable,
all settings are reversed using the saved count.

Add cqspi_use_tuned_phy() predicate: PHY is activated only when
calibration completed successfully and the op frequency equals the
post-config rate.

For direct reads, PHY is used only when both the start address and
end address are 16-byte aligned. Unaligned transfers fall back to
non-PHY DMA.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 119 +++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 99a0ec0e769c..8903b4cf4f6f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1074,6 +1074,102 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		/*
+		 * CQSPI_REG_PHY_CONFIG holds the RX/TX delay line tap counts
+		 * and is a single global register with no per-CS equivalent.
+		 * Reprogramme and resync the DLL when the active device's
+		 * calibrated values differ from what is currently in hardware,
+		 * which happens when alternating PHY reads between two chip
+		 * selects with different calibration results.
+		 */
+		reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+		if (((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+			cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+				      f_pdata->phy_setting.tx);
+			ret = cqspi_resync_dll(cqspi);
+			if (ret)
+				return ret;
+		}
+
+		cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 * Save the original count so the disable path can restore it
+		 * exactly, regardless of whether the original was zero.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		cqspi->phy_saved_dummy = dummy;
+		if (dummy)
+			dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+		ret = cqspi_wait_idle(cqspi);
+		if (ret) {
+			reg = readl(reg_base + CQSPI_REG_CONFIG);
+			reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+				 CQSPI_REG_CONFIG_PHY_PIPELINE);
+			writel(reg, reg_base + CQSPI_REG_CONFIG);
+			reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+			reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+			reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+						  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+					  cqspi->phy_saved_dummy);
+			writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+		}
+		return ret;
+	}
+
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+			       f_pdata->read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+		 CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+		 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  cqspi->phy_saved_dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1524,6 +1620,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1629,6 +1733,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1636,7 +1741,19 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	if (!IS_ALIGNED(from, 16) || !IS_ALIGNED(from + len, 16))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	ret = cqspi_tune_phy(f_pdata, true);
+	if (ret)
+		return ret;
+	ret = cqspi_direct_read_dma(f_pdata, buf, from, len);
+	cqspi_tune_phy(f_pdata, false);
+
+	return ret;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

