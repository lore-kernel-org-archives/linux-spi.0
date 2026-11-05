Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876446;
	b=CW8GJ1acGeRfcL24a4bau8qxeI8jwNCdOu+v9MsIz6gdptIMg10JKUjyrLnLPeMlv1nx
	 FvF79xcn29hgQJRATDw2pm6EcQfXrHMPa6ZD/hUIhvZCmdehoRrqelFVP1foiAuvLKec8
	 KM/nqrWeSaAHn8HmTJYkyPeBds0snUKNAMdaidX2NuNZVFeAvkB5jNRjfJTV6LtTQO0Tl
	 JlCR5nGVAdyYWGvr/gJmbQpslvZVko8bT2xtpqulSWJOxsfaUvFsDP2o2QiNe1cEQhWee
	 0jlDxmQc84f9KJjHIOCpvx7Wv/dwnRJxlMf9HX7BTj2ThUSiJLxZzLFKT0eHai/+ovg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876446;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=s0stDSBcmrNedcwURHc6VAch9yOXef9eD5FVSuD6mmQ=;
	b=C6zdVZagFdqxuOrvzOkJqZkTvMfRUzGY++WQQA6g03E4ObqmGHgJwN8qoeXSQJQrcWxh
	 TJfT3ZHI+RMuD723iKsmQHl7vGA6aVD+HYkxqaU9WYEk5s+qLyvFEvoyHLJk5hUWVfeLS
	 1Re90RU1/nOGBeP9vG8dAvZLtxjkU9Hz7msU/GyhHMLBJTpoFfHkpoxA4cxeH7ulMjhJl
	 n8hYCS3bRy7umr6hr3yMxy63ye6eC1VgbM8H1dXp0ONUzY2fQBq39kuUODQfXwRDGuqQg
	 7N0Rj3+4GTR05zKXnavICVphzuYM8eHrgMAHG2L2lMkKeyE3XvZ7d6eXw3wWBUKNAZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=GWrIVlm3;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PR8MhbrU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0B606A330;
	Thu,  5 Nov 2026 11:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E0B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=GWrIVlm3;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PR8MhbrU
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59vlVq776144;
	Thu, 5 Nov 2026 05:00:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=s0stDSBcmrNedcwURHc6VAch9yOXef9eD5FVSuD6m
	mQ=; b=GWrIVlm3q9qRSBuL0KuOUykwgVzcUTZcjFyBrT4DBff+EPuhYqW8DPoiF
	e/eY2jHNYWPnxk7yc2lAbbuuSWZzcI0pikJHagIlArwG6KT8ad4fLOpJZYDJ/zJy
	kOdeQy5T12pkaVnWtlKRW6YuOJu+nfiEqfxkvsNDNHjjj1xmsmk47M1pLIphxiZi
	/U6dYizpThaFfJC23n86ubkMadxLzEkEtTfa/MTRS8X20HTeGjTSpEJz0N8MyXyy
	2BzwtLOI7cGfZSPmEILpna3a+eIiJkdFt2cbIeVIWapTGApvo8Bgj4k/BxlbWYLy
	8LFUgcCqR5+71MDcFkETd6lf2Uqgg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrqhur84e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:00:29 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGszvyacJ4rJZs43vfm8g/+l7qgCohKwphkqeafE/E9kg8Ai7tOJpNUNqGUITcim7AVwCF4wO2gklkKcUN54lqlRTF259z29XWZGmVEE+kcViuoIxBcnFLYzGku/M78QetKbJhQypAx2jz7j47Yu7AatZ3WQMFZjL9IrO2yf5lHbHocjk5lPJPLu8puJzmCpZwd/povhVV5hVOODMTSFZCghjG8HimRevxGQpmSd6gnp8aOXNCvEJgzVfYB0vaGS63zh1bGtiuItEXWoFyJsNe9X/7LI6tpkNtSiFwNPNzXU1pXgNxlabgGCNpvI3w156WscW2dhz7aVJFfIzwY9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0stDSBcmrNedcwURHc6VAch9yOXef9eD5FVSuD6mmQ=;
 b=FRWJH0QZYP5tWkIf+6Z78YDcX9BkRB8bQ9HX5lDszvD5Gs3UsDTeLZU7NIYSBvhFsb/b7NnAtiWeJHD6iZoRcSLNnr61NVuPOmb37X7YT+3ElUS7u/vijXYU9SgpEfDlUYiczW5Ex2mzzclJ6vGU33i8ulB1biH9/dbfjwDJw5V4NLJN+yQa5BcR0xG9EYJUp6eVf4GIV/Zl7QLpUQrFRM0lbejUc6Ej7GTqcZg5vbGc+OKdVp/R8jklHQ/TSuj6uZyWq2uW3qLmcMpUZmtHeIX1HIpeo7WI4JnNyUirWIKINswLdDtV6mGBuBzHvew6FyqTx+r7ym7OauJgqSDpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0stDSBcmrNedcwURHc6VAch9yOXef9eD5FVSuD6mmQ=;
 b=PR8MhbrUdySEmClye59eoFKBnyW2F1hfXVpYtQvwJCKziY4wW5eLEWtuNSvJk9sJR9eKmTIitD0BFkjDtkRZ2ww6Fnrah0sycAui4QYh2QNHA/9DYLFIDsRbbYjTlIb+EH3mfPWFmGDObbYGDdELBPDML15BHyAHvKC3MFo9yRM=
Received: from DSSP221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::12) by
 SA1PR10MB998139.namprd10.prod.outlook.com (2603:10b6:806:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:00:26 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:3d5:cafe::1b) by DSSP221CA0012.outlook.office365.com
 (2603:10b6:8:3d5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 11:00:26 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:07 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:07 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2M4171076;
	Thu, 5 Nov 2026 05:00:01 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 14/19] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
Date: Thu, 5 Nov 2026 16:28:27 +0530
Message-ID: <20261105105832.2134313-15-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105105832.2134313-1-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|SA1PR10MB998139:EE_
X-MS-Office365-Filtering-Correlation-Id: faab3703-90b6-4040-11f1-08df3b2bff5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|82310400026|36860700016|921020|261026140227099003|56012099006|261022075727099003|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261009221227099003|261028144727099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HrWAj5zRduQfysRg5xTKu8uTMin0IsCgeNbtmNuKZs2KdzuqEwCTkh5bVenXK1MswJYhiEMzxLd0pMQhmhbmpHEl8jVVmMcThMSHHvG1YlWnm+4CRn915OFjkqZj+ijKv4sWBgMnHfjmyS/kLv65bjBqwIBUQa/7PRi6ht6Vkr2EZ66KB7EXQQxmXprA3ZYwaI/KJIzXa59f4ZpvgTqiwYkneKK3VkTzB0lBXlFMmuBBrY5d8m7Ypgc3BirrVPAPUyMvXYFSlT0gImMhWIB4DvM2otFSaxjQl3udtUzIRNNKxJ0q+S8Vp1X1DYNA1CW4uRBTY2OXCVaPLQYle3D5djlRAczTxTfJx7p7DGU1oVjF1T2rdVS5iGPQv7pe1Ef0ztnKJhGhpeVX3/l0dRQBiX6yAPqdtZ7PaB9os4sBq2bu4cu+EjDwpCPZBHpdJD+k8DBpz/9M606WW/6jg8NklR+oENLJFnRmQlfX65jhSK+2bqe/ep/6qIGfdkyPgoMp9asuZu8M4hdDfDCDOD1to/W8rtB0uN0yyMeePwA/hIjRSWrlXTmTQsXxIqDOnnHMLcxtXs7WqhmKvoA4TioiwOpGIFLA7gXMrwmKpVX7YCjfRRWAcBv5L7PH8W0C8r4QDPPDi5LmG7u0mQdoyRhAMyEJj8CxGyiFswDWFkwtfDHIdQgsDOyrDqKw9h/89GFn6ftRLa6yBjMLiZBUOS3znSoEAYfoHVfkQBrXeA6quTiYLqme8RdjGYaBsB1ZizVH
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(921020)(261026140227099003)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261009221227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9j6P8Ouxgschw7iTLP1LnEEHhE7V6E3Q5rimwc3fLmj0TwbDc5Dj9NTtZvjXyZrWSkRm3g7E1gnCr8lriCtemZGOLZg9HNhKZ+PtlaWJzkXtu5uxV56mbO4UhHRHQQki3SrVRz10zTE3axZW51rj4MOiDSiACOgX+vVd7BwgA3KUPyaEX4sy0C7/KPaJ+6p4JEYFMcXHvzLIvFLgL/oVxL/IgcR2cvtEzZsiEhiHSnBTZbfyDx3ZKlnBH9XZvG1NIMyWBpEjZyhJ2avsDNn0pITsTxMrIcuz+OUU5TFbFqDmaWo2AubXwydlAyriiXdgj1NNMh/GwMu5lKfi3dTKiKgjBVrPMb7/w17m9GIYqdfwX/rgCz8BbA0eYAX9rQEEN6U5eo7QZT605kIU/YkvaCEhzLWopekdzyTrFfcFaRoh7SkCJB3QZBHZe+gKXmJo
X-Exchange-RoutingPolicyChecked:
	V0Dq5CtFK64noKwnQFKtbyYmmOGQ4joMdIhbbq9pJ2ketO4hS9gq4oLF8XyjnDpC/ZgWK0qcJN7AWp4ImUWT69xOKm487lzV5UzxVeD84nvO/ghI2YG21bkfKDX8s11VyNA9bHw0J1mKSYXjrf9c4fP/0LW09xMBktCDdxf2eWWWg6Dwubh9aUxxfEFXOlZA+6hBSv4tmDqmaokgkVy+CwvHvdSQIr2CRCGdecNLI03590qJZVTVUxsG15A5DkqaBj2e5zSgKgA222++8QIDFExRcBITG9vWPKVKaJy6xxUFI1Vm4dm8GPexI8ypFi78FiC92+69VNV8/2YNCytXjw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:26.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faab3703-90b6-4040-11f1-08df3b2bff5c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB998139
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX4iUnN7Rc1P8W
 ecAPU3L0hBZZhIA7xMLO1aF5qn3bjmi3H8QzGo93peROaWB3U+32NBqQhaL10vrtAWSCL5tlcBu
 QCHmmmGPEhnRH0r4QSDDrFc6Os5MLv0=
X-Proofpoint-GUID: A_uDgHuSbAcaM9xLSqPItKAFNx06W9sg
X-Proofpoint-ORIG-GUID: A_uDgHuSbAcaM9xLSqPItKAFNx06W9sg
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aec61cd cx=c_pps
 a=pKtxidU6TXaQx3FGc3VI+g==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=00RIKaukA23DCyUQAnoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX3Z1CxgRvOmSD
 W6DbPbSJMIko4imdcwpAYl3pMf4nVBpRV7eiiXIZJnPuaSOiiexLJnvAuDP4GOtjTvK0xXj8JDu
 JR9KqsyowMzqQlH68Qi1uts9tSSqehcS6GzGAm/wPqIeDM8UAteq/22bDMNY+m/7Dn2pnDW4WLe
 3PW8KFq/wJReVOFeqHqs3kVZkxnGCnGtSgMl0YH6apO8gf1EdJrhkhBPJpXxuDJAqXhTLZB2KsO
 rCb88VtNlkM2dom24Qq6P6j1fZ83yBbJaQtDuAhBC+hfDr9qUB19aQ6RzxCnCrHzYkhKfwyQIlA
 VSYFMPGAo/5uUDFvMF6U6YKiBlp6GBQ/Jad83v/5kndneAzDNqBxYDhw+Y5HTWb9Pr7wrHIfIbM
 uqih4tfkEO+jY/hENv2pLD+2A0pXazYJA4JYzxPzUW61Wcpy0Sdo3J3DLbA6XvrO7ps3FUjLRfG
 ieQDMwmeW6U7PPrhaxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

The PHY DLL loses its programmed delay values and lock when the OSPI
controller is power-gated during runtime suspend. On resume,
cqspi_controller_init() reinitialises the controller but does not
touch the PHY DLL registers, leaving the DLL unlocked. Any subsequent
PHY read or write would then fail at the cqspi_resync_dll() call
inside cqspi_tune_phy_read()/cqspi_tune_phy_write(), because
CQSPI_REG_PHY_DLL_MASTER -- a prerequisite for cqspi_resync_dll() to
succeed -- is never reprogrammed after the power cycle.

Restore CQSPI_REG_PHY_DLL_MASTER and confirm the DLL can still lock
once per resume, not once per chip-select: CQSPI_REG_PHY_DLL_MASTER
and CQSPI_REG_PHY_CONFIG are both global, not per-CS, so iterating
over every tuned chip-select to resync its own RX/TX delay taps would
just have each iteration overwrite the last. Instead, mark every
tuned chip-select's DLL as unlocked so cqspi_phy_reprogram_dll()
reprograms its specific taps lazily the next time it is actually used.
If the one-time resync fails, disable PHY tuning for every tuned
chip-select, since the failure reflects the shared DLL mechanism
rather than any one flash's calibration.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 12714a9f04f3..83a83db62ee3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -4083,7 +4083,7 @@ static int cqspi_runtime_suspend(struct device *dev)
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	int ret;
+	int cs, ret;
 
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
@@ -4096,6 +4096,31 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
+
+	for (cs = 0; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		if (cqspi->f_pdata[cs].use_tuned_phy)
+			break;
+	}
+	if (cs == CQSPI_MAX_CHIPSELECT)
+		return 0;
+
+	/* PHY_DLL_MASTER and PHY_CONFIG are global; resync once, not per-CS. */
+	cqspi_phy_set_dll_master(cqspi);
+	ret = cqspi_resync_dll(cqspi);
+	if (ret)
+		dev_warn(dev, "PHY DLL resync failed on resume: %d, disabling PHY\n", ret);
+
+	for (; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		struct cqspi_flash_pdata *f_pdata = &cqspi->f_pdata[cs];
+
+		if (!f_pdata->use_tuned_phy)
+			continue;
+
+		f_pdata->dll_locked = false;
+		if (ret)
+			f_pdata->use_tuned_phy = false;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

