Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876382;
	b=s9AFpW9fpBM58MK3Tm+vGjg4CqS4MoSH3sbmQ0mEMe0RRTb1dq2QAWwfKtDeWbpXJT9S
	 vvZIicSYfX+zLGhEltDqBzNTmMovagULo8lULRFZK5AFcvD3QB5ZkzMHfc+q29lGx7GYX
	 MxMt4nz5ZHKHMeo3Bhl8ZIdJ/hueRBlNYqLsnrM2TrPf1bbLS2TmNJf2HAkWwIdDhqGUU
	 HPihVnc+FlxVDkDgRoeY1PLrVkNvt5fKn09RNuIjHtnoWaw8RhT3gJ0HYG+uJvo2HWLk2
	 njGWfJyJbnfksbBzZIQoyY4zFTpgxpkxiiQl8/v173QNZCTkd4Vbg3zCv4zgp7RR+zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876382;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wq897I86koOD6iO0lqSmy9yAb0i4oqZEu0ld2pQyJPo=;
	b=SzDF3sx1BTSvzbF6uTWf/SGiEUcZPGubgRaP/SlOhuJzAxcGF85kkEUlxRDGASIELsFD
	 szP56eaLOXoboREYDLQLQ1RU3wZ/HcFfVEIVcUHFUPA1xtxOJItO6+VUYTI2NiukMFTeW
	 rJVtDaTUsLJqrOtVlU2z7mkFAz/+CGIrgsehGdxj0vO6E7AzC8LIKBaOaOyeT3FCuKKDT
	 hLwU319tRSvz5hiINqwMRJsrzM1K8bCSYerQ2tprODK6TfFgl/KwwP4P99+Qe+bqeK8XR
	 HkQDv+uQ9X7BG1qPnpBbJw5xMhEtiQ4pLOfDp9u+gOmCbKRYvEE2AcK4celohlxzaeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZUBUzUen;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UXKjcJPD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125AB606A31B;
	Thu,  5 Nov 2026 10:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125AB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZUBUzUen;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UXKjcJPD
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59voGx505704;
	Thu, 5 Nov 2026 04:59:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wq897I86koOD6iO0lqSmy9yAb0i4oqZEu0ld2pQyJ
	Po=; b=ZUBUzUenVwb02ZQF1MdWwIEuh18IV4uWw+EDnMXPdp1ipEroixeKEkjw2
	g3JouY7+evflxJmAhyISVpbq5j7DqfmPSKcZair5mtTnxHU80WvCuWWiuorzcLwH
	fTtNI4XtHBQfUAEyeoG5pX9Tmd5uK97QDPrPpsFkcQ1AJwtPgeGNG7Gtr9nRlRJH
	mzwF4iYsneZClMwDsY7QXcEJzZl8BX4jqoa5pF8QpagBQcAstYf7zgPtOrVwDUcE
	hM6AgoUZjoEjGUBxYGhkgRAtGZAp00mN55ai49Ms6i5I5FgTeYA+CG3eAzS1SQsM
	rjABCjhdIZ578uRlDm9tax8r4tWcw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hrq6tgce4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:11 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVV5J8RrVnJTwosxHwlAU4I7k4OM9J/TdgTUbxFd1DfmIIPH5GtdzNNwHkRTYU2DvGiPjG/nXXPamvvjjGX7CuPCXCJ2kakbVgbNpBzNyZEkT81w+UlekRmv6IufuLdkAlfuqKZdkI5HfnEuYzhP2Gw7iHTZvj5/x3URjzLByBjvUQXo4fb/c1NPnk7ueDn3UVUAmCBQoftCWGzv7KcPIj/T3pYF3bjD9lnpk+USH2JTMX3dkj+snO3ZOG/akiSEzhYqfUBCSal4KTm1tNpxw3GAfJKHsP3SxxehtOPrf7OU/+givokQUQGls+KGuTtI68XOofyeAEJh4HGElTzaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq897I86koOD6iO0lqSmy9yAb0i4oqZEu0ld2pQyJPo=;
 b=Q3I+df+EesLYXyuk4rVFqnZt+LDRSj8SfsKI7YynPYB9yOqrYM+2YfWV6HFG6pvx+3E/dl6BCe2puftWoYNrYDjXq3sqf+1ejrYpm2d+hAo3xOqxVTvXfUKa6yP9upXV3f759G3WsMR+U0R7NOq5e+NzkuAROc9V/MbeTq+TNgNVrQS6eVSjVVzNYPU3cTdTOtdBTUQMk+TR8UzXdhCbP2CN71pdNhRSU9W+HMFNbNb85zVjLYxxrIo056ZWMKlipYv2dvl+FphQRbRvlte8X0EeL/ZacxxhLGcmIXy1KMzObTZIIjj1ERYnTbXA4edB3TRBLsgKTmFAl21MnUGvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq897I86koOD6iO0lqSmy9yAb0i4oqZEu0ld2pQyJPo=;
 b=UXKjcJPDWCDKebFiVYCRMF7+MGQl1KoblBtLV3jsoTPahh/H8QZjJD6Uj/DkBOO0p40+Ywm23THxr/3v19AfBwC0m9/8ZL1sOUMJJG5dj2bQnoWzB+iGjs7E7lbyJp8n8BtPAZl9Uggn8G1mBv0ZH3RiPIfNFq453rEqFVMmt6I=
Received: from CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16)
 by PH0PR10MB4549.namprd10.prod.outlook.com (2603:10b6:510:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:59:07 +0000
Received: from CH7PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::7c) by CH2PR17CA0006.outlook.office365.com
 (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF00000018.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 10:59:06 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:05 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:05 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:05 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2B4171076;
	Thu, 5 Nov 2026 04:58:59 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 03/19] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Thu, 5 Nov 2026 16:28:16 +0530
Message-ID: <20261105105832.2134313-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF00000018:EE_|PH0PR10MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: e0931814-1129-4a35-d44b-08df3b2bcff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|261021123027099003|56012099006|261009223027099003|261021121427099003|261022075727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sjef4jT1u+0KC4/OJzwWQxzjv753ALe2T9euwhUU1d+WZ/3F6S6X6sQ/GiB69/WiK+t2fz6shGX/MxAzCf5JONpcsm8d1nNkWsnsMCPxI5zJw1BDuzJ7yqPE/Pl1TxYcTndF4ZX3rGWauOnd6PSZU4Ectqawmavy/Mmll7Vrdc1Bisnfg9YFpHZiHt0eioIHYvId7nlnEcq8sxNS8iHhMcdXGcBAIpiK7fWX68ohvRPgqHKLwN4mxCrvDmZXnnpRo0tyx6tp39qYiySfaTFpE+Fl0oA7nQWxWY1hwjMCPcUz87MgqRDyePQUYTqX/d9JS8Jn+56+nIusk/EzxiH3YUHx/ufRGC8ddeURsBL39o63kfH/gGO3yNk/EMctyotMNa6qGkuZJy1xBB2O/qB1Ux3r5zG6vxJkeJjM7CTPqgZbNTyfHYkhWFYgNYx20k0DGa6L8ozKeMNs7o/1zBX/ZfWaUZIUjS/wXIp4HHLY4Hu3V6+NXqehoU08kxcScfzm3ESECnWOAOAR2adH8lM+LSVSGPcYtYvj6FPM8/vbKTdjvnECskZxTa0qpksNIKkA3aiMv7liRpF+NkCIDeMt5xtvmNBxayTDJ5sSfGUdDB4oLu0ZEIssiyeQ3faYDDLY0J5MwIQ60jD4xxIFDoKPva3k0EqmPUjwxaHZQF5TLH0XligF9U2MuffFMvJhktRTLNQCQrBTJ1wLEKjsnIg+hIbcs9hiYi404OIt0GfmFPsBpHLkKALYhEH035hwDZcU
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(261021123027099003)(56012099006)(261009223027099003)(261021121427099003)(261022075727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cTUCu4Fcs2YzBOCVmjd21oEt/CDRRJVdkEiimLlPASD0i2Z8xIewRh7Kzxdx6ZYE3kad8zLKWAVqBs+lwVW2hZmYY1th2yzSYhjc1pUjtSlIYbnAUaXiGYeNqY2EbmPpasi2Lpku9wk607YXUGs3qsMBaIYuiujg36Z+vodrK6pkZ1yM2PYZQ11mJpyuDl2TfLLcRhYKdS6uHAIsO6el/cdyu8AmA5QEyIa3EQnK8jWG6cxWgJ12MRYfDpnAeSTl9pKlcXQpO6aqTC4luhFOMJslQRswg7mi6HefXrJQfy1JbRv1/57rMCtEYW/qz4DjrdICxJiMMpn6O/1YzO/CyGyKqPyvhzXv+kOo3RsnDBYJ8TRW3ygZCcy+MIeUI3q+789MGeVbJ8HYTrHgOTxyoKyWxITWpKp0Mz4GbDguz36NDCb7HNHOmHM8LqzhOKsZ
X-Exchange-RoutingPolicyChecked:
	4W7Wbs3qx8jBq3H+aAFXNnH79DH6vCKfm0oU0giYtE05+z8NwiMPBLImk/ZNIgeqbctBRKBI5NKwjADzqcKci97jMUFTSmaHLBoUt/ueAq4LD/p688w2Ad5H23pxA6z31fUSe+B1OW3KlUk9+DVowHv0ry9Md1llvmgBIbfYS/lcEuR58Xo8etMpsBC07AceGmonzjTQ8lbPoc6Vj94S8S/1WX2lhf8h/Qw0zU0hzfe3g5numFaePjQRN9DplAKINK1XeI0J9KXW17rV7ZVMnZFE9Q9dJxscxQOf0igJxd/oakrp0zQoLbJh8G7VKjcp2qQwj+GaXjXvrMPk/uQkEw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:06.7782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0931814-1129-4a35-d44b-08df3b2bcff8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4549
X-Proofpoint-GUID: sIue4jOyNQs5z51NtsBVMFdL5w5kW_AO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXw4ccXSF22e/V
 ZyzqCnism3LBox2NDeIKoVm5apqr41WkgBvbbbRrBJjCUEgecaaiS7gi/pfFcFVDKskAZ0O+Vw/
 lcZC/PC0zXDZZItX3XAYqM/2bXfqGzE=
X-Proofpoint-ORIG-GUID: sIue4jOyNQs5z51NtsBVMFdL5w5kW_AO
X-Authority-Analysis: v=2.4 cv=Q6xHcI2a c=1 sm=1 tr=0 ts=6aec617f cx=c_pps
 a=INYzEgT09ABq+JfORImVWw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXwJ41oDXRrg/2
 GXhf6XxnVuchwHih9JRLDCpv94zA2BMlI0C6uHK6Wes4wtT3cKb5EXabEi2w4dUCT55YwWPMOYT
 OLXz82dpDD96BS8T6g9isp8ply2FoiyJ64I/CQLQfpgxHzIS24q4uSMCA728t9Gr1N6elhr5oKu
 skpN2fybnmVBlrMYDJ3hnm1pJrsPm9TZgB9ukakOFBC3IELh5x2hlZLNc426NxwNl+g4cb5jzYn
 YNVqMyE6hvPxKkWFBGREl0C4f6PNIKhg9gPfnvt1XNpXYVAWsU7mGKUZmafzV8ZS8t2VxSIU5dQ
 FQZOPBMGWG2IfDKyHSwCE0pi9BIUd/ubRDiIyGNc5fgoHRN2CBGI29IgspwGaVXMwrMrUXkwdI4
 N3Ehswl0U7Nt4I0iDRZYipAOacv9cCsxBnjV2Ui4nfMjETCJ58PndEAmKPkwj3ylqqsMjAmXOAH
 sq+c+ywZCMmH2sht/aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050043

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c29ffac59c8f..3f6add21154e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2825,6 +2825,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fb4baa0d3398..a2c46cc7dafe 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -201,6 +203,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

