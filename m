Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876395;
	b=WkUzXCmn7l/JJy/rf5G2QSEke7kFnzdBQkoEQdQSaGnbmiNgOYIZI7gHphj+YwShcmlo
	 Y9p3mmJkLN02kmVtX1CLcOfrmTRMldpHy44S6xylJVzmZfUsRrkBhC34AluvkM01ru/Dy
	 t+WHqjcY7sTxZRIUPrQ/Oa9J37sVd2kpicSg2T3QzJVh56PEWGou9GAwZ0orAz+c1wiC+
	 a7LGBFfS8EYaEZrJTfWSlyuC2cbNch/OWbIr8NK/1gfHO9VjS/W3omnkKTxp1a4dsjvzi
	 SBf0Qz85oiJBBoNGg7HEq6vzpvO/WHivE5PFaWWyE+mKb/q4nZSO7CJGtwAtQTZL29g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876395;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=nkF57AsUduynYudaM5qXVb8yJMaRom/dRgkIJM6W2IM=;
	b=4tSoGiqJ+hHTK0iYwdoz8C88zxd8B5qdiTv3Q1rjjlVnbnE81Y1b9uNc/uJcgzLgg8Tw
	 MpVGDhwjDgD4fb2SJkOJ4NUzU60FUtSXYDTOpoNZjRw5DKjDTrxCNrvhMSpVORXfoQt/W
	 DUSElrgHEdE7cSibpSTV8xcDUcFjB+xZi1JdB7u9p7goief4Sjz/2FVV2E+VqaSTiTyiK
	 YX/WtXz07c3i8HPeURNl0oLZitiX4zs/fTeNtSquDtG/IJZA5WwU6LuSIwQcy3cGSK5Sy
	 TEnkTpkun1ZBQi9EzkrDX+6AzBWCClldOAMljL0GZYqRrY7yChsRV73rq9oXhC+rGdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cUI4P0x2;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ao0K0Ef7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BE606D80C;
	Thu,  5 Nov 2026 10:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 658BE606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cUI4P0x2;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ao0K0Ef7
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59w8He102469;
	Thu, 5 Nov 2026 04:59:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=nkF57AsUduynYudaM5qXVb8yJMaRom/dRgkIJM6W2
	IM=; b=cUI4P0x2QqJW184C4gZst8K57HCNSLQVNVg36kRH6D6rpWl+xsD+32BIu
	gYeiSe5NEvn0Z+vKUnbzh+481sp1PfoLfsT4KMyZVkOnKbWMxrXVkR34RilGSB8p
	Fd3oE1wkWwKbRDoNqx0hcdgAXBeYUpf7goNqPMXXCr/Vjf57oYdRfOSBvGFG1jVp
	tkUVE/4cRvr1NbgYNUFVNjXeUplnGP3c1SoQ4monI+2pzWi/vNsx+/GCFbTkz+H3
	wXqEfL/8Vs7kUHZXlJdIXJThkQkufqTmuwzImO6pEcSKrhxovt8K6gEd8Ki3cQIH
	bZlw0HiZcoXu3f+1IRyCHIPJMhI7w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrdte3uvt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYPWILD0cMo51+kve/e3/KuX8EOjithaU/PZovHtsWDw8KdG0JvLOoSbsM9Wy0+PtKvZXXyz32CuKHquoSHIS0nEW1KwimDVOaeS0YNjXzjaB86/QAd9qHGV239SUgnhk6zgdqcp10LBGmtpi1AoQd2TOH1qVrDj5cw/O8cVR1fGgKq4RYXSk3HTcJ6RC1eiDUZY4fbvJFDsjcjzVLS9r6S8cNqPxAexRuvlaIP0zWV4Rh9zto53P8ZP6pLk6jXCbEyijz4JIEKO8JhG81iWfZ+Frkjw/Kubd8dMuuKCRy8fGAGSa3HZVQUqfQ/mSOMPR73fgoZoOzs7E5GovJ8Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkF57AsUduynYudaM5qXVb8yJMaRom/dRgkIJM6W2IM=;
 b=IWWpkAtz1hLhxlZ4cW3Nf8ClUIf48Z40gFyrv4XZoerj0NFAe/+azi6gt7KymJ+13NzZ2n0VRo5qVyTQJMe6pwfxlaRhpMf46aKu+mxQojqa1iCI0iGQTY7ySEaFAG3MqI2feUsgmjo+kS911ailYzz9jGtGJLFCDMktOIF1qtYX5JANJZ4NCtkqaBDR1/JFielbgmVVT0ZD3HpDGTnYFe9RKsNzvFwGgNI4ES6dvZvdc2wSNZwRwC9Tzza5mtHf3ceuMQbz1xUSneUIk2QgkVsAC6hOqjio7FFuETiP3lNXWN8Pp7Ym1zEnxnhC5ypuu4VM1x831gKl+EAAhceoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkF57AsUduynYudaM5qXVb8yJMaRom/dRgkIJM6W2IM=;
 b=ao0K0Ef7RSRXV5ekfPPqBFOkUj/i1dqyIKWevJeMtupx8megk4Ut4kV2VBL9LL1MBSvOgvwySO1/PMjeeFOjd8INAkm0MowifzZdWNFLmjwaz5/fJn2kCO4dWubHC+RbE7uQuadgyZSmTnoAftl3AOYmBS3fta9JZZvvgMnvTmo=
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by SA1PR10MB7594.namprd10.prod.outlook.com (2603:10b6:806:38b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:59:26 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::35) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 10:59:24 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:59 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:58:59 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2A4171076;
	Thu, 5 Nov 2026 04:58:54 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 02/19] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Thu, 5 Nov 2026 16:28:15 +0530
Message-ID: <20261105105832.2134313-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|SA1PR10MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7370bfa5-5b30-4446-571f-08df3b2bdaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|23010399003|3023799007|22082099003|18002099003|10067099003|921020|261021123027099003|261022075727099003|56012099006|261026121527099003|261102123227099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	ze1rk5F8J9EdsxFmN0O6fAIMcgtT7QsQQdU6mwLXPPswaqPWiDBahDhR+96u3otlKqWd6iyjQF8qp6N5jCeoUnAjZyXpJvKq3YEH6uRZRVzVR3d1XBRnpEbtgERtfuteTgmon+vCjc+Ou3lpdkketXsinLost4JemrbuS8Vzu38CVIzvTuYwMc8A9VWqqQfsMgyy1YfawancnO2tabsnqC2Om35GdtVVlIQTqCl1MQBAi49zHCMYUqh5Qm0OZUMBEv7btzDRD9S8aknlQ+LxvIj5m/ABadu4glz6LDk3wQkbdGjONlmtCoJ5UVr23cYp6xsNbqMMIC17HJ1l3iGvej2MXwXcvd1mHbGy4PQI5LyyqVMssX2m9fgK2bXC1uYGRt+Pf+X8Bzh/86MuoMzNCK09d3iGy/sdjI55/XujibhjkQXVEOntsiCPLDOrLwbm3vp0ECXPAxTNFZGjy/ax71GQDIs+fNnqW2sEVQ5IpwiFooyzBSfFInc0UJEgQ0TnHhBbBDNNW+UK2I3rH7cXF/QUaoE/fKxJUwur12W9NDdjVagK6v3CKP6a30rHjdqUAJJpZrSi0/bZ4iriDs23f+A2iOy8TFQbzMXwcu4ImL62TaUHn6nrmKoBupcqSo/X2hRp2dzzj9Ixu0ukEKZ99wedGi1dY5dlTed/d1DKGnyQPzAaRttPjs66n4B+frxsIH6OOCfJtYGd1zlqRqBuSnHNMgitCFxI/WGt9EY+tX0SjF+F8FBPV+2DnxrADuft
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(23010399003)(3023799007)(22082099003)(18002099003)(10067099003)(921020)(261021123027099003)(261022075727099003)(56012099006)(261026121527099003)(261102123227099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w9ufBS02cJxfg2kFdpO6/0/B4wPnzAd6yjVDYhFE5CbuAWNV/aexyMflNXIW+GITSV3Dx/Ca9yzLJbPCF60zJhmz5oottc0CyQlT154sI0ClCMrE8r9xGlF1lYhfmr5RCUDbUigiuLPEvD+LrBEFEaFWRImSauK9/nKCHNmNKRb1Mw6Fwk59eKtjJdz4tDz3emwwC44AJcvc9bQ5SsY6DtwSLp5XmsGlyUSJ8Aldt3vv3Ouodw4KKfSlJByNhTQ1QpfxlqsNW/XTMitDgbuzzttYS9rtpXGgJa7Vqa9ypS5vSyNfFuBykKxgtDsnqLm53gsvTnroGu0mw2lbjynP63OEdl1Gi8ZPIeah97SExA/0Xh9Fxlo/wAmdZDPkDIjmjRIUPkrzdKtbwdkmzmXpbjFlSy2CXc8/j/rOejPA+xM/P1bhZv1xOiGemS0EW1pZ
X-Exchange-RoutingPolicyChecked:
	kYYoLAAaOUWJSGzBSPtT1NGtDdVogoPuwNX/WoCIdFyZZi//kMSLcjw6V7bN2OSQAuy/xDEnww7rRW4Ldc6YEPqurLzVczq6KxhVIGkO3Fsu15NSQf46wxdLgQQYHRYGxd9Jd+Jnu5gCi5njQS23qfIaukrwj/CR4cjAS5LwZt+o2ytw28Gv+3Lu1PQqdk3Hwjq7l7xfE5EFE5rfG9MutbX/XUCDJhwXbWAPyF1GanaEBE2blPMSShQKZbeoE4xDWS6IVWldt8WHJj/0A28y5g2CTh1R4b/RnLeOyYlhjdKDiD62gMIof4TAUYV9J8g12OxC/5Qjc8yHJihumD3S3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:24.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7370bfa5-5b30-4446-571f-08df3b2bdaa3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7594
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX6THrjekM2Iw9
 Ou7yMFD644qqoeAN0bTj0Dc/N4dlDSdJGsjQSn3oYzmQG/CNRY2s+azy9vFvWb7G6VDlYq5B96/
 tYblYZ/VbC76aDStHzKTiz2VUv7e9QMr7vFQFPplOJQT56hxpzaiDBhalyuoSI5x+FHH2uoO6O8
 apG0IRjh0U/nuf/rZU0BtVX1xGJBRDQwFGOaRB1svk49mYoYmxz+jtudo1qafh14OgVibXb0+SG
 U8hC3cidsLJ7Ri53Ll8e0dG4r/8AUOn0Ugv/cfX7IK1FAmV13/l68DXb3Sf3d1c7sfm+61QH/dZ
 9DCUHrzlKouH5ysXZ5exoNLk8s9n3+2eg+giMiVLDGnRR/tYFsYuQcm3DMwImFylMMPFVWCBUOT
 4HQhYsFXQqkVzCBGN+JA8ZWbBi1a1LYXiOQbrxmSQnVUPiB2t/gb/djwVzfb1sF08XQ/vG6WcIo
 1uoclojjp5lx6NP2yMw==
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6aec6199 cx=c_pps
 a=+tUgqrp9vGCFEjR5l+cGAg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8 a=S03zC1y9aomtN7BeUG8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX0/4ko+Dp6w/g
 TvxogeKPBUrF7ls319+12CWnuS5jYAdpO9Ts+EixP54lIf0RfIue4fBqICXqr+leeIYjAvZiKgB
 PuHQamNafGw6ZBaBDo0PyhHg2qCk/oc=
X-Proofpoint-GUID: CoHjmfVBBzwcDNabeeHfJNAVFnoHeVNW
X-Proofpoint-ORIG-GUID: CoHjmfVBBzwcDNabeeHfJNAVFnoHeVNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

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
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
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
index ec91d5bed96a..d730442e5255 100644
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

