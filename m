Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8543338E8A0;
	Fri, 21 Aug 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312991; cv=fail; b=n9tE58gmDTtyk4z7E1rwozbLgnHrtUrmJjZwfjTXFYRARzCwd19YDYQoolcjgMH/DX+r64LugQJ0/2YxMrU4RcRkmPJBeHz7JZn47oQBVEsuHQSLvb7e3uF16hHl5W49dB7Mromr+EyC1MVjQW6/KvY2xmsbpd1a5mcW4j17u/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312991; c=relaxed/simple;
	bh=aF/DbrmPXM4j0mLlW+L8B/c0eqWu65juxQfllEXfCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACZr5Zf8HU12gk3ZKejK/9ABYLgzE+zdswdNjmmaahduGxia5gdjNLQknIjvLAHgcKoEABFPR4zOSyoUOoK7cMVoKZmI+0CzjyR5qG1aXtrIlUvTMzdsiwBUSyc8VH0wL8ULPJwpDf8B5L98rmobOoK61lAln+whRbtAItUO6GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NpXM/xOa; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ebqrGvc5; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NpXM/xOa";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ebqrGvc5"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KKFk3421354;
	Fri, 21 Aug 2026 06:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQ
	lA=; b=NpXM/xOatgHZcR/EAH2rRD5WNco4w0yTSQy2pbQuuZiEsofY7IPsZ4NRh
	FPoMX2dLT1khZ9V4EX+F2w8D4gujOZI5P0JsDScbupb02n0G0K8jMEU/mWLDgFYy
	5CkEcY+tKwesyV3zk8VnWx+onNPhpFryaSnRkZrWljpGZoHqWp4qAy0wM+oHuCCh
	08J/jDJMt7zBCNOleosMAlX+Qfn6x5lMWSELiOE0mirRKJI95U9fQppMmc5/EoNj
	dMzcRVtA7NxuCFklfvwSGrFCvmzazu8/hTmnBQZ3OstbdYvvE+YRw6J2SCh5WIZV
	dqXIpSjFShBbSidm5DTlnbTZOLY4w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6knmrmy9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRQ/v7AmfTKpyi/e2RFmu0AqbgKzE4X3KP5aEMxHIOAPtHYCwP+LR2gV6lStgQq+qu7sFTSBVlnPpthZ12+SyvA7y6lYdorqL9XjlSi24eM9yZ9T422G01hXSBS20VRnrocvI9+CQl3o8a1O9bYBYgiwfV/W84YvaDS1ZkoQyFSEJIb1IV162NJ5CAua3Q8pVJ9xBQZZRf/sM9+GrRkuExkfrQBqAodEmSfbOt3Yo0fOOxkgSwwkIaG4dOQBVAT/B+zo8UjoB4E8wYIEvAjaR+YWgOWxI/SMbILZTImkM5nBgC3gWi7XFF6g4ic7YWju0KiHrH7d0hHVHNWKTnysSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=fSo3dmN+YORdwdw5LBwHRPOt4ht8+IcaB++EFEXiFBT4txY4dX79xz4OQ4/LKzsRO4Cn12lK4u9CnokrEFJkRLmsaV0xJu8cQi/JFIchWI5LPnLCtaqgS8XB0JmvwNOl8SbXRTPRmVJjUCn09kS6TpTqelr0vFNsyMCxMiEASFjnxNvo1h+rqgf532npsoeGWGF++y3ejU3KWmeKRi8h+F6zy3sw6BDLGiJvSJXxU1NzI7pEzeSTRuNWIYUeklvEhgTBPpU9UU4Ha5nAu/JMBtLgvdu09y6+qmNrJ78Wfi6Zj3iAHACcye1jN5FYuq28HqJPgP/5ad6zowsp08WCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=ebqrGvc5TNEyQtKGPirzjZBSNHTGXe2+Js2BPvqelsF2OIHO1jDPgqd7j6LX2NfSynJvnHBZZQ69/+0AN6iZkk0PSr0XnTMQtEqRcGKvj/rVMKQ+gCOCoN/M85aT/rjg5+IcNDCvI2uTh5dunqhpS+hftIvGtaIyMrJVeVmYKh8=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by SJ5PPF8C7834C85.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 11:49:19 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::43) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:17 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:48 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:48:47 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVld2022942;
	Fri, 21 Aug 2026 06:48:42 -0500
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
Subject: [PATCH v8 02/18] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Fri, 21 Aug 2026 17:18:06 +0530
Message-ID: <20260821114822.4040338-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|SJ5PPF8C7834C85:EE_
X-MS-Office365-Filtering-Correlation-Id: f99b175b-ee5a-4f90-7428-08deff7a3b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|921020|22082099003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	e4xVSwoBP5OmXduYUxMlJpaTUE2pj8LIb9DuEAlIV46HsaOW//hYN0boVFk2ZzykYqD/rWbGlG2ODk32J79EReMSqWa91KTIEQ7BB1okLXN+f81j9TUwWQjMjdSbGKiHv4FfuyFrUankQ0BHn7pJhnQF6ySwDmnVLgHMF+PA7g1UphIGpVP6CruYE1cYXMD5wxvi0z6gZvC6EFunGA0urHx6n4D3wGtFcOY/F8V5ylI979UNoup8Oa2GCt2UaKsdK3lYc4ylzrRhCa89W69LtNqopw9+J0P0pOmr6JW6VBZ5AWSr6yBSWugB2jHV4YM9ciFC0AezGQjnkdBsUJ9TXtpXP1b93VJ6o4gMpo2nA67N4hc7fj+ZER2Db8NGmY+VqjGgBqcio6R0ijWdIt77wGgvY0yOF+cKFs5K+Ru6jl1uMY+wQH/TzJ1r6gNQq4QGhoSOXZrWzdOkxSxHLxywwEK7sr3SSSGKQaVDv/sO+sh8fCbF9YvIkqDK/7cqlwDcuCea6YBrkXljcjqIOJuF4buscae9WWXmsMvRJ3/6s58usYZrt+Jpd2h5tEX6Kk1L20+kmn6ro6AT8/GatcZwgPsCVJmt6vi3Imme5hZU3SZKty9B7b58LA1Ssj1aMTvtknvoQm/tI5hzFdnd8GdGCn3QChIIxA6s9DNXjz/J4JP5dlKPuzF4vJk+jvuGDjCwKn2vr96b4J6sIXxprLqap/6ryMTTRtqMK6yLCB3UMhAjLR6Lk0mbhDgmsZxBQIAG
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8k+rUO6AUgMV0yQLdWykpUlua9PgJU4cenNLXNw01Wc3zYfHVRb3gA2PYHAFxz2CkOF8K9XMO0vb4ZhprU7BIRncMUX1L7gcfycd7FMuOLD1jwbAM6wRqfZ1jpiDaQTBXmpi2ARuqFHdPou1UpXG0RAk+h2JqJ6qXXxv/gSSu+QstgNirjmdXK5vo3O8R67wKjyU5zgTyv6p1oumejOqO4iYnKhIacvLPeCLrVo1wtrezyqsvpcveTKBQeHjjpKlimfM/s7aAsxKi5XcOmUeSys13I6O6M+9z+kzJpT92TIkWDlMOC10crlKKtsSztrkIHCUNA0Ju5zGlqnU9QBCJxFJUxX2Givu6/Dzry9wqUBmIUhzBd7lNCGeJF83D5B/cZDcC9iL8fQm9kzXmTrNoJMxpyX3KE5QNQeKgbnw1oQ2hEr1961ooGkJHh/U8TIm
X-Exchange-RoutingPolicyChecked:
	P+A2NFV0i19y/hEU+FBnvY7ofYCRTHz11lefqDByDiM/9xvQ2s0Q2VKOojMcUgQh49dwh/r5JsUuqgg954SOGmkGxVUWPKiDKchLSSObMsbXXNy6KcVEvwzLrEBHuJqDTLQweY2ZwXzF3309GecnGy5nEC5EkXkkhQWqoOo1LRpF8C+vPXGcc8LNNkJX6DWn0Mlwoo44YPifn5tvHwZn822Fb3onSd/xYbnRzJZNoZUSTDHFuCOFAON5Homg8/YZC0VyYtlR+sLBSpIyxaZS+z7MY2FgXi+dAea4VVNu2qugychOAw9sIwj799g6JaKYoT8LSqUyDls0J3xbT+xohA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:17.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99b175b-ee5a-4f90-7428-08deff7a3b43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8C7834C85
X-Proofpoint-GUID: XFpRxZIXfOCKOyekEHDiwUaX5kT2hIME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX1KOz8FyNlJJ2
 LpyH2pN4ANlkS4qoPLh6BMbuUFjjgciyILX49GonxaoWhxcF4R5yZ0h5Tr0FnhY4CyUyKCq5q7Y
 IVzS7AkjMcbmG1bvy8+IxETRdncHsyJ+NQm0cqTn5gubLt4n9lMCmsshbnBO1JzPoyv/fxYJSSb
 zsEsQCUsVWzdQyV+FeMdkx+pk211jwnfsZHhmAR0hEH/RORmU2LaJUbLP9EXWySIfayiuHgkP4+
 HFNUq9zlm8Vdl6sXZ7KX/jouK5/bjg29q2Y2KQusJuzxeM71PqN0aEsVToMwfRwdjJR5bD194cC
 YFYpdKhaopo4cch8nXZ4PN+IpHZzc+y597Q2SsAvj4XbptZXEq10r+66sC1F9tazEnDQYIA6XFt
 j8smQloxd9hMsnOjdeGiqtYUYiOg6fL1vnXRr8NZxfDx9Y54c5TaM7Ky8H8kY2hKMpzGs04TH8t
 al4SovGPo0VkmxVr0SQ==
X-Proofpoint-ORIG-GUID: XFpRxZIXfOCKOyekEHDiwUaX5kT2hIME
X-Authority-Analysis: v=2.4 cv=fuzsol4f c=1 sm=1 tr=0 ts=6a883b43 cx=c_pps
 a=bw0VQspFR1l10E3Rz9sV8Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX0h+m7rkHEkeO
 Vy+G6Xh/cxB+dZPzmLsuwsOZ+EhapSbueh2lyOF2yHNCpiuIOH+HnkuQw61mlYlzYymu+2s0V+b
 C+PNH73uOJ/9cZmRKK0rcYqhqoP6xwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

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
index 84976fd3ee1b..cc01b643fe9b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -123,6 +123,13 @@ properties:
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

