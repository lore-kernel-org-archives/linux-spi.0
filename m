Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7997390239;
	Tue, 11 Aug 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473329; cv=fail; b=XW7zWRBNq97w93TLDH0rg4dobFr2S2a4IPh0lHrQAPkkMf5rYwekf/e0cC0Gk3Il7adOwbdxOHGTY3Fm4ZSp+9nrYujWuCKSxkHHf5dGyVoL5jjlvck/G7xz0AQVXPVkKwQP16KGc2L0ftr2GErY2RGZiT/lXA+S9XWP+hr4IQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473329; c=relaxed/simple;
	bh=zyzIHZWkbZiJeCTqvhBe5bpyE69d/84Z/bMFLKqBSj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sShI/sTzNJpVqeQkBPzs9uKg5wz3FCPB0FIn8Gpm8B6RfFWOJWxnLpFce1XZRgZQkIlddlpYAsiPpq9SX0BIvTEo7yKAltl+Z5L55xwbpGrs2tARj0gOkJ4f5yPyaf4lJeN18hRKpJWBXyVVmiyuWNb/RqueSDcfURPfTXnf1kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IM+gGpv9; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w/xyvjbZ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IM+gGpv9";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w/xyvjbZ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMeCZ2174931;
	Tue, 11 Aug 2026 13:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yy
	U4=; b=IM+gGpv9LBkN4aH/iCAxFZOCR1knkdIsClMErzyrfUKWiuuwkVo8/27jO
	ofvCEOkATqr0T7qZ5hQ2bWa5itSuv1feSSuPirc3CRLiGNuXNuhbN78a/uVUAkNA
	PiR2Qp089MqNt3m3/jc+PVbozYnpNx93LJeKfW7/GmD6qDpKeULMQ6xSFtH03csb
	NYzKvCqqGDg1F7k2dsyCjvCVM9GZidO8TWh0bqE2QSlxp86GvNHxOpjlb84ikaF2
	ccXWYIIXEaGIoipQtWgzUBTqma5wxmDB9JYBUmI3Sg8GDbd8lSy/qeSdN1g9+wvI
	R5gd2RPLn2YJ0aVaTDsJ496vVOMRQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uj75-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLlRHP9RjCyQ7kMzz/uOGxPhx6nMBClPw3NEZMrgS/pjUTqqk63xF0hcK1CUGy2xNNcokh5JVQJBqFfCkY+vmSvsaOUO1mGdouBWfsMl8WFXsHG/Ynd/J5tUeboIRD1ioR59UQrCLIGuIC2DO5wrVzvA0MDaECEsv3qBf0RDeDFnCbLwDZUxCL5EWcdo3lYp4GsDKBo7Pm84uxRH0/CD3Rs59sVP/U1z6WpTkwzEGeuW+ckbl0eHHfJLC3guaudxfvhdkPatnS1msVI06nv9n47lUz5BfmbKshVfEyRa3XQ6fSohuWX4ogzRutnEAIKdpjUgofew23oXjtm3o5owdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=HcBVWe5qqv2QBLKI51l1+WwAzmDGWx6OVLtk4rLSo/fjLkTzAIBLVjgJoXyFdlNNvtcCqs/jF/Iv+mLmYsvIWIf/lJ2n2Gi1kFHCI+J5+DIzhBqK9MPBOPU4zqg0ZOk3Eu9XX1yzjCk1a/duLLb98pM1DTFTi4dyAg4IQiG/MGy8jrex4MnXYT5ex7JYHNVh+yzwo6g/SkdbMgW8RuYBOlZcjJcyOJ+INZYSZNIrCnhAkhWhe2f8ne7RbcpcDrrKReZOhvvt6MFeC6OM/u/F6ct7ShBjG7ikEVMTNDF78gatBRzP22Wl+hkdWsvPF2GzBaT9yn5jE9GckDiXsE9yZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=w/xyvjbZPO8I10BCksp32ARIvqMlrA9lRoUWcUmsCNTI9tEyiBYh9PjPaduD1v9fHFyh2uZbK9jG6lWwYVAK5Xne0rKqHHImCJQGf2Jan+RjvFbM0Jgcrnnk4NC5OTE3pXtcYmwwBO8DpkZJfzU3ldS/YCvqF3r5VT/snIDqQXA=
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 18:35:11 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::93) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:35:10 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:47 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:47 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe9659766;
	Tue, 11 Aug 2026 13:34:43 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 17/18] mtd: spi-nor: extract read op template construction into helper
Date: Wed, 12 Aug 2026 00:03:12 +0530
Message-ID: <20260811183313.1550425-18-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 75827002-b065-46b0-9b2e-08def7d74653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|56012099006|10067099003|18002099003|3023799007|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	HGjo1UTJI6NfxMP5eX1eCyObBN7HskhFXZoGjmQenzQx5OGPI5nbAHKgVgP9oEyE691wkCwL6UKbkmvxWl7zZuGlbKonFhimEmGByJI5FDDbXPTBN6oEsLmU/QjRPXoC4rcFtQ9HxiXd5qRwQwNWSqPmMNyUAS7Mfk4BuQxqZS0mn8PdP7GaPfh2kVXWH3ncsNDq2z3cJNjOfznjby27zvzKNAsEDfZpYXW9BQUZxRlPPcccyFo/zaJ9nisCr6cl3JcbbSyrlA+hB71UEqeozuSHu1812Mjt0KODmMfb9PpHiTai2CEPDWFUkMBShkfiYWpOW0z5bjjbiIksMIOgdWEMnB9dz0+iQMxGuXiZ0pakNrdEL0IBp/rBFN2r82wB12++n58vNvScwOdZ6wmmsGbO+V23g4tKIlF0Ng+LBb3e4KPfp0U8MrtoPd7UeXXbAbSYq9mVm8Ppf7zQj0qcBHBADNmgewt5KkvaIaCk9K4r2TKt/2VEjZIA7z6PWkCzK09N2QQ05x85N/5hdMW694+Vhwz5H7mW809f6rr86NyYvNUqZScGp47oMLXfb7qNBoOlzzQBmig/UwuJtQe3RxkKVj7+EEG4oWGHMrnYGvcnFKrj7EE7rGwUjGJK/f7W8yd893Dvr9ggklg35jNMTkkzowIaJNVwrsKpHYuTboj/0+k9DEBYKad8FOygbjgNMolIApG9rw6DyJAfn2qr7FjBJu6QOq19NIU/TEe80ZysuTCB58I78DjCE+JLzySD
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tNeyPhrszC2kAsCZ9ng1pp5RyKs3S/yvJMNZM6F0amwarkaQlNCa9FJEajCTLrNeSUX7VToACxuXJRGzCBkXcQulWvE36MhJcGUy3uDnxr97IuErX1Kn5+df3dOAIS4CKGOO9PUA9Y43GZ4r0v9zKYqmM+ZWjpxNzoYV30cPEuDbSnpJD3gQRKMjljqdvE0zq5k1buQd5ch08EML9yHUtZaWiUzIKZJjBZpyJtQSV5LvpIXZes/k/gKZu/PBOvVqkEDXZRinoT7UaKQLveW2jB7xJNwE8SMtALQ5R1sH6loVqeG5/8gWTAoktTHDkNZcRdbXa8FJEP6f7hiSScq3XHWrvYnrkX14yfKy1SH5GCfwWXj04uvN44KoKrGzmyO3LU3ZKQ0lCkS9oKFyCNzWlyb4HODCgRjWBcLJlCEldNZRDuGCFoomhejcUQr8jh3v
X-Exchange-RoutingPolicyChecked:
	oNLEmtOPw+1ZUdi3dW+WMzoImPVnymslG+iJ/NYTibo5iD5Xkf6IAAoEuynY2iQF34xAvl6eDdGF49cVzCa2mBpKZwZh5MuMknH7XBkZTdvHRfEJcqPtsquHHfh5i1gklg7w3MGkzVTCc9QOQ1sfakpwl4gkrY3+b0xrt8QLIAuvN5a0ed2bzQwi4Ex/9afj79ytL364WCFmmoeezEpeGjonr6qfDW3kMRYWLiWPETwTx40DXouuuGNTNkY2u/n8gkiCI9WbkYsoetcW8sNpb4Agk3gqSv27J4jqmTV11eiefghYfgOhpwpw6BbAexlec/JWxHFW5N2kYyoIzpVIDg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:35:10.2231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75827002-b065-46b0-9b2e-08def7d74653
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX+hcGws46SBTn
 IFmz6T1eHlQKpat5DR+w7cdrGrQ4aPtzt/+CcxBL8aNn9Z9OehSRAg2VPMcstbODCWwNR6hQyVO
 8BCHGiax+hg4y0MWdpi93RM11eTUlVlY/FRTvT8bao8JDO9Ozl7voghpJ9wZc/SzvSFFGsEcscu
 AX6HTbkcjhTacv2eUWV5Kd+oubKMBU/LXwRS1bnzz9/npRBF/zMixAH2MFUPj83UAuHfgHpu+T3
 1f58yS1Jp0WO7iHke226gR91lm3Xc/kmYqpPA2qiG3ncrsohhAaCyIrsIaW+i0pyTbj4G1x8H2P
 GiZ2hxe9YHF1EAemQKpflHAK++UIxU1KVvL0kGrvHT685jeBLCtp/u6U3as60/g0NiSCDNPXfAK
 ulqy6PUbmzDjST1HRcGJ++oOpSCuYz3QNWZXx6Q3w81ZFWd8pxMLiWLV9WAQVyVdNjy59VK1OvT
 NEzoq8ecuU/+PHIPcvQ==
X-Proofpoint-ORIG-GUID: hF17pYc0Z2jUeJIjVlfq4GzgchsNMLRt
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b66 cx=c_pps
 a=miQpwXaPIJxEFudIojRT/A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-GUID: hF17pYc0Z2jUeJIjVlfq4GzgchsNMLRt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX8Hx25+PIB6kJ
 aPr82TwoWwI5i0h+KxTUAcnqs/LTKyvh8e5GuaN4Wpk0PIKMciRXQlMAAdWGqVudsoc8bFtzNet
 Bn/ML77U6FbR7InoF1R4QGkZd1rediM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

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

