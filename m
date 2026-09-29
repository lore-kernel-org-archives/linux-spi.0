Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD14718D0;
	Tue, 29 Sep 2026 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663826; cv=fail; b=n+HH13te2Dvb4Wl2xCXWSR/QjAx/Kkq2UFd9sdtOet7RdRxxdukmmCUteimk6ps9zCXHMqgj7fqC3dvGOSN1gLGwQx2+vHkH/uZhWygySuCAZ91NfO1QisueJkawQ8KFucsQ9EFHvI0iVBl6/6zWjhQCiKYedXp6BSEvQ96Tbp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663826; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr1cNSTkz9YlupP+GTaxaL/iQYEgq2AkPbArg2//qksybCS4GMR2sJEf5F0SmbAKvY4adOvFMaaaYfrkx2MW6ubL2vir+v6b6LLqDzr+A4vzyYFNen3YXPxysbPWG01dd9tO7mo7vBwcJ9iwS2uuvs3c4l9No5nwqYpnbsgImis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=T1DJ0pAY; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=jstymB9T; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="T1DJ0pAY";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="jstymB9T"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46QgV3284092;
	Tue, 29 Sep 2026 01:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=T1DJ0pAYRMuTzWQ3J5OyJRzYq1/dPhJeUshH0oxe1esZUwov5Vy3eVXyb
	zVWP7siCauR81C93FzBNLEllkMjKZZWMevH63sfmlu7PnjPJFU0NgeOSFvEBEhNb
	vXqwayoiaVR3VqSv1zIRuv7k2ebQ3F6YjC/9Pv4FtiO6Lbcz2CQqn0G+dKbxA8Y8
	8dFYXFI3JJwKwK5vAsLgbkW4BGnBWBVLGdZNLI2RrHbRaCk8BMOdxXj5oTCqAN0W
	NZ1qezBo3G53fOMU2fdQa7c8GiQPr8+wCZab7HaeZUfKgjX9rlY55/kGkOFR7XtJ
	XNLtipy+0haOCyD+2wPhdxTbUKCaw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q18-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIU5AYZxdXqOZCiMSBP3YV0wYAccfZZsxgpUVqvrKv0vG7ZccMZ6TTA7VxzAbGI/uHAtPSW/n/BIUsEztqrs4HlkAX7rsd4HG1p11YQDb1RVln0PZZ18LFwZZHtjqQlbEyTYVqVIJbsE0ycvYkm5p80FKO5qIHRx2XD9RRhwWQrqGx1rYtWLIKoqXApgOxkArCDJBHC4Qiku9jtgOJF/LrxMeXPwfIx0mQKbEfVPZZKlCgsQ7WJr/fwKCmdC2dWwSxmca06hAcb3o+XbUjYW5WfGzQfgEWwCfcISj7dtrd53FbQZtkiUVqXKOIPi4sgCABx/0mrv2N5hlgSj6AKBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=O4cBHB8culhp05gv+pXpqj2DyR140Zw1oR77QRorA1HUSShOqyX5ers1ZaSB8TVhbEvc5OYNrUetJmicWmaqV/H6q7EjkhGWrQUYS947cray6rCOHRrsAWmncne4MVIlrhXz+AAiG1rTnasqKWs/QmZIDKMKW4LdmzxAyAQIx9xX8hcxCKHP1fVKo69fM513Yxt1m/CXdltd0QrETZ80K0Z+oPuzMJZcn46HxGXNGv+FXNjZlx1v+J4qw7BGp16+BVEFWe8PunH7m8/QIhlE6J7+fpOU67VcG6EYA88aaYUyRXNJf9eamn1tnnfApQX6BrZ0SZWosjxn4HNcALTlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=jstymB9TGDolvwpnfbOy9bcF0WnrijSopEq+E6kaZp0a0pMxod6YP9rJc5dqoBFY8rxR7rQVdWOwe9HMDFZmcLjtg2fhPNMC84YyhzsJSC1xJV70rnldiBcfqLfAsILkN8eikmdWa5tGEbqKJ+eZ16Z7uqK1vJhAsEFjYkVT0OQ=
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 06:36:39 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::2) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:36:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:39 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:20 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:20 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn71395904;
	Tue, 29 Sep 2026 01:36:15 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 07/19] spi: cadence-quadspi: add DQS support to read data capture
Date: Tue, 29 Sep 2026 12:05:17 +0530
Message-ID: <20260929063529.1235417-8-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f004e4-9fab-4dff-86fe-08df1df40483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|18002099003|22082099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dZ44bipaPLYPHb1RTgHsy20H+RYqUIfPyt6BFtNrdNTF8PTY8z7U1fOmmZQ5CN5kK7Cx5BgaWDRVeA5S53DAiTOCaGDf3zwD4KM/64JM94hYV1Jwwt1GWwOKGem4jHSwWAGMlxu/PgMIc0GUhr9eQNDT0+RYVh6ppY/Tw1XWk1qaZefosOPgDYIQ6V6CrP9Zqp6QGLT/rmv50Jt+GfGF3M/pZZPjEdVkCR1VOnkmpMowk90LxxO05jRaaFXdHEBTgHV5m62sjBLDZGWr0vJAhdB8Q3XWagWlICtjSlkxRog3MgdHobm5+bNzYJXzeHVRQk9MLr59NF7S5+TUE84eZlWIy1D3ifFI8eYd6p91M6UNs+iTpTCd4vd6h4IAMiy5mBFhQl6XvfOtGHLx3BJjW9VMHbuAQkz0ut/cUBvRod/RV3kPcvM9KsmM4jYDHQ5k37sgPE6SGg5gkHWHQDUXHETfYNB62a/OElRnvG6ExU2lRwXEScfzSWjADh1CbkFbJegTZjcZhRAxKDkpgBFG7wYmyV3nh9ycY4Hvs2na7WRbx+x5Ha48YM0dm5KLvYzdMd3pfgJt034OzYXIacg8vvtWHkgb5BYU1VopznJo9YFolsGdjKyKredEeAP2Sk9ODq2hJeyYGz0VBTx0L6b85hBh7Dl/WbTWJPqvMlWJBpC9asBzvGOGVVHiK4TABX0V2NHsSW9v7H8a/xdeq0fSGbFsh/9H+caPOEqBHg9jEJ32cdEFI+UDWCjKcpdWZJCH
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	plbqweKoUbZ8ydbCVhNLneMcZIg1W09y83gAYhP0acpHhj0M3pS2+Q2bUUsoAr6DcyKzgH5xn2AVergm2z0aUvrrshlR6L2hcb86V1b0s2+gRaqnIG4suCA/1lXI85V0QmdhEdBksA3g3R0GU1A/28rl7EyEJGwKPLLNG2pWHcZ9lFAnobMd3Mpu3DXyJr2ac7e6YGxfZF36jVLIyrCoDfHvQnUZ6mXdZMj6KxW5xWcPXQF/P1upKI1kWe1PMqF7KKULDCiNLSRKlt2N+BmLXBO3tCZI4wbxt8ld/+qvTR0E/EV/SoN4396r7CMsg6wrnh1liTMYpLtDzw1xkoaNlmCzHlq+0mQBWtTL6pXuWvaWormXKw44hKruf2E3auau/ibfMEHd0Ue+GoJYp2V8gS+/vqfz9Bcs3WKAXt3D3XLHXfYhYrIKhMFOPcQf0c5I
X-Exchange-RoutingPolicyChecked:
	VMsE54be3QC1xpY89VpUxrZe+Wrr/jfE89jbJ5j6WrgD1FZHrVRoOPTKoTNDnoEg12BGMxaeRX/dubsYslugsGU4xIv7sSBKSWvPFjkG5K5sdSYuOH/2Y/48GwNFPgt/8uV2xu58p+Rk0Ne8Q7cgMNS7GnXyH1cmraN/pdi6Eksuu/57Q+22wsddR+UYNVaTwHukg29AlA1kyzH7if/fQVwXhRH6FLEcyMJnDb2iQhtNRZZzvDYT06iUROs1liD25ZwKB5AjLhvJ055tfdnVkv6EMo6F6GS4SkGNWH0uljMQ+t2h8WS9I7RbgaX8uNC0S8z6qGH4kXK/SLYolXmLeA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:39.3732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f004e4-9fab-4dff-86fe-08df1df40483
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5c7a cx=c_pps
 a=xQfGHK7Kh/zEjKjNz0BexA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=by1YfaDFVIW1-MDklf4A:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: R9PrXbqJUQpQm6fGg4SnBHIGOdYIQ5a8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX4axOkFN1uegq
 lFQ0cli7QJCDsrNGkg1upDhXHkyC3hWKl6h4BMtzQsnhMxaPp/2h+hoKywxCKFoIRGcSSrShgTG
 5d5OEe9eB2ETqp9xFxWS9ZixciDYSDdohzGvNE3rn+ziqj6uQc50JAmn6zEJwjyMrjoqydzIdJv
 S5LpuacqMlSGY7xVjbn+Lz6FejYYLfpajjPi3M4jbfgd2PkgYqDQF9hIyjufkU84liDe1md4UTV
 FftBkbsm7ZLVexuwE8zLrPvM3mUu14fSZQGvfvFX+ywyNUVNRohz0DW7bJ8RQC3FRbCSZ+CujmY
 naO2+WbXbMcQwKU7DHdXRrnrs3PfZWmlVycim5Y5qXWuuoc3V9kUYhcMdj0AJheE2zTwIKQtPtX
 uV7Bq1np5gfVggX8usIeFZxv3T9H6RKt4xqDxGOdnvPTR/LrMGxf3PsEaN7xhJ2OyBcojqd2lDf
 am1wTsvCIF3/vPwmp0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX84EAc6eqK64w
 b0nU5Ekeqke+h8Qtydc9Es42Qqj5RPQZCfJrxorgrYEv3HJGRLI7GZMctIVzI2mAfqrh5j3Fqzl
 cDwk7Vhj4A+m0oyUr468zwSUbvSKRiE=
X-Proofpoint-GUID: R9PrXbqJUQpQm6fGg4SnBHIGOdYIQ5a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

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

