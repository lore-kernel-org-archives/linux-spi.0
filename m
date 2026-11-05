Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876464;
	b=J8phfy60pGACxPCM5xSV8ZU/7ygbJzTpApEk0PKg1B55xdm11OiPtRjsWAKUkgVRSj2T
	 jjezPAFyp/R3neEbRksFTgxHXfgCYvVQI24RMKzEd91Af2+d/kYT82qMCUmA0vEscfoXA
	 UfjfaqTj7upxjpSerEyVO/7xAW2TdepAfoEuJCfOTjEHK3YtvMaOc3TUZiz+oM8AahOy/
	 oasuoryV13iWLPi+m7roxgEb54GAs/oc6X1YpkecvM+ySnJU5LqVWKGHNt9nLbxKYueYH
	 IV46jy/I30C9pKBW+/6QDEZs6S96vmhoTjlyqe5xy2SGeR2AS9mjHE122NXWUBKFflg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=QOFZ8tGub23PVpkTvAPQNcJTeTlD1nayTfCVYJFL7OQ=;
	b=kuhTdVb3G8rNFQKz56UzVEJ3f90sfIG6cVfbRVunIQtSOV7ve9k+vteSYYbT3e8jWn18
	 9mRlEIhSjyrTrpyujFsmYFSVq4TlbxUFShwiNbQcx8HxtrSo7/dO9LX5RhgLbwEXgIrnL
	 DFiGhn3R4Q5fzixsZ5+pfu1N3Ax3p1JD3GW9519XfyQf2jJlpUXo3jaRoSylgC10rFnyf
	 HwaEV+z0uckfV7Qz6uDAP+Yk30PUfys597txYYZ/FBeZKDmh9edbhBEkdAaRMo7x4g5ex
	 ZRS1YyRL1njS1CwpxwCaCZHWjkpbjIPIUX4se45vQPhsLl9uNaFC03IiVyGwqGKYsGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=LbE8ASaF;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WyVN7JoY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403D606A33E;
	Thu,  5 Nov 2026 11:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2403D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=LbE8ASaF;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WyVN7JoY
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59vggN776002;
	Thu, 5 Nov 2026 05:00:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=QOFZ8tGub23PVpkTvAPQNcJTeTlD1nayTfCVYJFL7
	OQ=; b=LbE8ASaFicLvswGiHXvvVxOFO/hRnllZr/Csx/XiFv/YlXRWKRdbrcRJk
	4OWkOWSY6p2ZJr2q8S298dOqRu9m/XwncItmuZAJ7jm1/LZoJVGXnJnbzTUp1Ku6
	/kqlfBzZQdLqI+kMhq7SzZ4cGfP5K2LUo3cZ5E/DbziEFVx6Lj88Vt1GMnHKpP/r
	DUEicMJUH+rKo2WI4Bs/4elgYm8PwhWW3yP4IWYBErQZYg49V8krme9q4a8OKDzp
	ZYvBO2ha02tHucdF9lCxyxD48bU2KG4oZgC1j0Ll4pUB7qzhFRpaPUuoSkWGGdNn
	W+/sqwNAp6e8buHaXhn/kuVR2dtUg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrqhur864-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:00:47 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nea2h1UsD0LgQGdWjKQwpR00ewoJrf5tTmHQMM31Fu4CX3zRmirfV1wANi/OQpWAx4bueKY5yD9hhC1r6Qisq5eGI+QlScWHyBtsUGR4WqV65i0p15jaU1Sla/b/rohOeuutWBFmlsnIodGS1UOnQBR8qsQA2kQn+9C7td/XAoLweFxEF4mv9nAZaGZRy9MHN+m/Ks49Zr6POoloH+UmxLXP9aTCXV6/8eb81jsVN9hvl0DLJ+mkLY5aZGj7nY+MVP0VaAuuLqUatTyCB/bwUkbdsKviUy2ztmIBOeX+NPBXt98ftkQRu7aZX2bWR1xflEqirtgibgWmi2gJ8dvq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOFZ8tGub23PVpkTvAPQNcJTeTlD1nayTfCVYJFL7OQ=;
 b=BrzDZMNg9tCJt4oKCDc/az8a4hODUwDbR4bHrVpF5HvdVprDiozCX4ud8PiyxChBTvezMMdk2cG23tsECeKyNSSowvuZZI3rYYpvdTs4iUrq7msbH7fX7Ytm8HE7M0By4NCM463bUTX621vDcf3xhCQ2uEOBfIZYryycyP/WjNbx6Gcp2fndeX+wkTN5vy/sgAaRJXXWaDnnaxIZQa1FNUJsJbHxNqd4P0QWM16bk+dPQ4V8Pmyd7W+BUEH2OHhl2av92bTt6+jaSwcHCiyWdBj/JTQ2tpnjPH3tY5/cN4XDb43JKPRNYNK6Pw46rDin/+TtRW3qOalzbeHQhRdqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOFZ8tGub23PVpkTvAPQNcJTeTlD1nayTfCVYJFL7OQ=;
 b=WyVN7JoYCyBqk7qlEBfcVLtp116b2gQ0gVqT+5PZTwypVR/MXN3lqsEA1ihs9nq4sPzMgr3OuPgW5VJpFiDBd4Whb0sd/eebE71qiPvdUP2+smFms+TXW725hvVIc67rMOQxEmjeHQiDv0WeU9CbZoodG/4su/0TDMGlcNFu9E0=
Received: from DSSP221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::16) by
 SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:00:42 +0000
Received: from CH7PEPF0000001A.namprd21.prod.outlook.com
 (2603:10b6:8:3d5:cafe::86) by DSSP221CA0004.outlook.office365.com
 (2603:10b6:8:3d5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF0000001A.mail.protection.outlook.com (10.167.244.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 11:00:41 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:18 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:18 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2O4171076;
	Thu, 5 Nov 2026 05:00:12 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 16/19] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Thu, 5 Nov 2026 16:28:29 +0530
Message-ID: <20261105105832.2134313-17-s-k6@ti.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001A:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 80028242-2253-4f35-2000-08df3b2c08a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|3023799007|921020|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	+fRnOS7gfYESshMjB3CxByRsTsMZFdbykl93kMZVB2KlUdtF8QRAjQEmqTaSHSjvZWQJhZOLOdywWFeoJNabT5k9TxXqW4Kh8Fu8cNzoSr0QNpcW2g66HEW7IDmfP5nagEuuxqDiro3BCTL4FodNOFXlTwbuVbCoxxkLcYObZyoplrsJEnLXsvyVELVB0vQPgS18yVOAh9V2gWYO6MNr/P/s1IBYZIeo9eHdmQ85QnPGkc5rSWiF5U4UwQz9qE4MzMXPwfIjrEIu6bYBWHFQKSMJhfSdqXUEwXlD9SQDiMeEPQFl0RLNAS37R4ydeiQdZ6+B3sAa2PGHUOYLAeX4ARgjoAW05VoWbkkLh52pPwU3Mpiwkezf/a7eIn4Iuhr2Kv1e3a6iryMDAx+trAl56R1KWlY3as8e2wUTjWJqz9mjsE+/hM2FVxzxH2/98j3odq6LCekahi1x3CocSY7IkgtDzAtf64wMb9751YZsikEQF31S5GclSmtcRUBgPpKGOolaLIGOxt9nO332rbzBEPTRyd5yg9eDRf3/xUAIbPZWXeqz92+05xBOMaG8u7MIlGVsps4AODsJXyPVyircjieOgoJnzGjzDIZHNghBETpYHz9zYiBnSZpk4/UDt4CwR/P2t7T/CaLZRRuJ9Cw+HfV8rElfWHuXag+K8Dd0bSc49lUAW4jLDtjo1f5qJJtVSvFGhM56AVPf08w0pZNTXJmJpRQjm9YR3+Mahlzp0XqXwpDSz55IQ1ZBAMQiorbz
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(921020)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NzsAAJ6vsLmicJ2LKrgnCzyM4wNyXH7KhpPyNcOsuoIpIxlF7YPND8d5suR3P1ZMrTCpOcyYrQieNr9NQL8hckrgKN/4tMUtw+zBzReEu5JlavN2GGTHbFN4RSoHPdTc/ye9n6rOVs0mfCSb8LLJ/sg3wekNqxqj2s1V6fsJy8QiqFHUJ6swkta/AizN923eWCyAeqmP9+ReqDSeYJtC6umZiZZgiNIG65piDCTOnphHplD5bSYwFd9mgQOqth3hqNGe71Z6w+ZnwqtQdzCmQP/8MeIh4YBZIuDq9C6Ykr5wKhm5vv7rjeKwOmHuhcFzIegb+gq65T9jsEKUehLnodmtVlSZi0pfhCupggcOiul3z8wZr8vV4l8Z2PD35gJs8YSRLIuJ+pNRsJVoxXB4T3+qNqZr0m9k1hoVJuprAbIcd3ozetU5PXVJmkKYDckc
X-Exchange-RoutingPolicyChecked:
	kpiYdVKeNHGtVGEqn/MNTTJJHStkj7JFZ/M+UMqcAotcqkuEUz/IadPFzh/rIQ1GA4U1BGaCPQzWtwjtuVzWVZYZSs38dOnkqY3fsuTP3TUTt3gosHzvdyEotzNVy0QdN2ejsBMSXygFgOQdIrtD/HHir2MN6xZXAPz9wRfu/WdfkAcLshpcMmupgbjzEMGJu2Ln3taGXiuQbNSRN+9hZZpRlt+sNmEYqqMaAnWWgtiKjWQynFa63iyOKZkPaxoYtmGtNTKdObDTC9ikTf2EzluAmkEWY06pAhgJOB7QddyCcOZMRzCnfGcJtJGnHRLCooOf+fykWLB/PmAusUEQHQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:41.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80028242-2253-4f35-2000-08df3b2c08a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXzko9FKpYkHtY
 3ztaUE9qu+t5W3qFLvu7X5gzi6LI9Rj0iVmjxlPQRz2ZhvExeCqoC+x/DXnVUbVYgYet7W9KpTA
 BLLMU70ROgrQBsbL+h2do0JadoOl8NY=
X-Proofpoint-GUID: GnYI0dhG8R0hlG0pn-Fd8aGMwECJsP8i
X-Proofpoint-ORIG-GUID: GnYI0dhG8R0hlG0pn-Fd8aGMwECJsP8i
X-Authority-Analysis: v=2.4 cv=RMQmjIi+ c=1 sm=1 tr=0 ts=6aec61df cx=c_pps
 a=RzNzSA3Xhmsnv5027CV2rw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=ZE5v3KcJ7YqXqyeUJPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX/wAELEqSF8Pz
 PCtuwhRXSHi9ivCtTYs6XH8M8VL0W7+KipnsxN2t87CMjhClxTTH16BqVjoUiei7/aJj/xwHyaW
 KwZ/TGmYNg/QsU1Nk99Lg50Opr6ubhd6OlZAGwKtIAoQRScJvTty5yAqKmjYkjuweiJ0Vw33Mu8
 hXvfcLihC28TVznpi9ZPckE4fOf0hwfTCqmptDZk7DqNchVOkXDQutUp1O+vRvAGY4aI6tyjbhA
 +TcHXJiAOJ2Qi6/kwcY7DZjApZd3g6F1QjfXzTrat6uA5yR9RA9K3TDEuUnb8BFm2dwQNdQdpZn
 1zyO5B4oA1Z2/uIJ8kDQrRzVfRn7dJr3zIy64L4XBoxWGnVVoZ1ac1Gjqy7ErBYcTu9Uq+u+zRi
 cBK6DvrjPxgUkC9wE16qNjX2oGRA2pVFuqAZDydU0hDtob/vf64tSmJm2HdHLKKs3fiHnEGWwPP
 4wNNo5ApK+Zp2lQFSGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

PHY calibration must complete before dirmap creation so the validated
max_freq is embedded into the dirmap op templates from the start; a
dirmap built at the base rate cannot be updated later.

Add spinand_optimize_controller() which calls spi_mem_execute_tuning()
on the pre-selected op variant. If the controller returns a per-op skip
signal (ret == 0, max_freq still 0), spinand_try_ranked_variant()
iterates all remaining variants in descending performance order, trying
ODTR first and falling back to SSDR if all ODTR attempts fail.
Optimisation failure is never fatal.

When SSDR is permanently selected, clear odtr_op_templates to prevent
spinand_configure_chip() on resume from re-entering ODTR mode with
dirmaps built for SSDR, which would corrupt data.

For devices with a distinct cont_read op table,
spinand_try_ranked_variant() re-pairs cont_read_cache with the newly
selected read_cache variant rather than disabling continuous reads
outright. Re-pairing uses protocol-shape matching (cmd/addr buswidth,
addr.nbytes, DTR-ness); addr.nbytes is included because different
address byte counts represent different controller configurations
that cannot share calibrated settings. Mode-toggle devices are
unaffected.

Move spinand_create_dirmaps() from spinand_init() to spinand_probe() so
spinand_optimize_controller() can run first.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 312 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  15 ++
 2 files changed, 310 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9dc43c8c4162..645528b6c2d7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1300,6 +1300,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1310,9 +1311,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1559,22 +1562,51 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/**
+ * spinand_op_shape_matches() - Check whether two ops share the same protocol
+ *				 shape.
+ * @a: first op
+ * @b: second op
+ *
+ * Compares cmd/addr/data buswidth, addr.nbytes, and DTR-ness, ignoring
+ * dummy cycle count and address value. A continuous-read op and its
+ * corresponding read_cache op are expected to differ only in those ignored
+ * fields: continuous read typically needs fewer dummy cycles, and always
+ * targets an internally tracked address rather than the caller's.
+ */
+static bool spinand_op_shape_matches(const struct spi_mem_op *a,
+				     const struct spi_mem_op *b)
+{
+	return a->cmd.buswidth == b->cmd.buswidth &&
+	       a->cmd.dtr == b->cmd.dtr &&
+	       a->addr.nbytes == b->addr.nbytes &&
+	       a->addr.buswidth == b->addr.buswidth &&
+	       a->addr.dtr == b->addr.dtr &&
+	       a->data.buswidth == b->data.buswidth &&
+	       a->data.dtr == b->data.dtr;
+}
+
 /**
  * spinand_op_find_best_variant() - Find the fastest eligible op variant.
- * @spinand:    SPI NAND device
- * @variants:   full variant list to search
- * @iface:      bus interface to consider (ODTR or SSDR)
- * @skip_mask:  bitmask of variant indices to skip (already tried)
+ * @spinand:     SPI NAND device
+ * @variants:    full variant list to search
+ * @iface:       bus interface to consider (ODTR or SSDR)
+ * @skip_mask:   bitmask of variant indices to skip (already tried)
+ * @match_shape: if non-NULL, only consider variants whose protocol shape
+ *		 (see spinand_op_shape_matches()) matches this op
  *
  * Iterates @variants, evaluates transfer duration for each eligible op, and
  * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
- * no eligible variant remains.  Used by both variant selection at init time
- * (skip_mask == 0) and ranked PHY tuning iteration.
+ * no eligible variant remains.  Used by variant selection at init time
+ * (skip_mask == 0, match_shape == NULL), ranked PHY tuning iteration
+ * (match_shape == NULL), and continuous-read counterpart lookup
+ * (match_shape == the read_cache op just selected).
  */
 static const struct spi_mem_op *
 spinand_op_find_best_variant(struct spinand_device *spinand,
 			     const struct spinand_op_variants *variants,
-			     enum spinand_bus_interface iface, u32 skip_mask)
+			     enum spinand_bus_interface iface, u32 skip_mask,
+			     const struct spi_mem_op *match_shape)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1591,6 +1623,10 @@ spinand_op_find_best_variant(struct spinand_device *spinand,
 		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		if (match_shape &&
+		    !spinand_op_shape_matches(&variants->ops[i], match_shape))
+			continue;
+
 		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
@@ -1625,7 +1661,37 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
-	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+	return spinand_op_find_best_variant(spinand, variants, iface, 0, NULL);
+}
+
+/**
+ * spinand_find_cont_read_variant() - Find the continuous-read counterpart of
+ *				       a chosen read_cache variant.
+ * @spinand: SPI NAND device
+ * @read_op: the read_cache op that was just selected
+ * @iface:   bus interface @read_op belongs to (ODTR or SSDR)
+ *
+ * Devices that implement continuous read via a distinct op template (rather
+ * than a mode toggle around the existing read_cache op) need that template
+ * re-paired whenever a different read_cache variant is selected, since the
+ * two are not guaranteed to sit at the same index in their respective
+ * variant tables (some devices omit continuous-read counterparts for
+ * specific dummy-cycle sub-variants, shifting every later index out of
+ * alignment). Matching by protocol shape instead of index is unaffected by
+ * such gaps. Returns NULL if this device has no continuous-read variant
+ * table, or no matching variant is eligible on this controller.
+ */
+static const struct spi_mem_op *
+spinand_find_cont_read_variant(struct spinand_device *spinand,
+			       const struct spi_mem_op *read_op,
+			       enum spinand_bus_interface iface)
+{
+	if (!spinand->all_cont_read_variants)
+		return NULL;
+
+	return spinand_op_find_best_variant(spinand,
+					    spinand->all_cont_read_variants,
+					    iface, 0, read_op);
 }
 
 /**
@@ -1762,6 +1828,20 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache) {
+			spinand->all_read_variants = info->op_variants.read_cache;
+			spinand->all_cont_read_variants =
+				info->op_variants.cont_read_cache;
+		}
+
 		return 0;
 	}
 
@@ -1940,7 +2020,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2037,14 +2116,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2073,6 +2144,199 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/**
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache. For devices
+ * with a distinct cont_read_cache variant table (non-NULL
+ * all_cont_read_variants), re-pairs cont_read_cache via protocol-shape
+ * matching and updates cont_read_possible. Mode-toggle devices
+ * (all_cont_read_variants == NULL) are unaffected.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	struct spinand_mem_ops *templates = iface == ODTR ?
+		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask, NULL))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		spinand->max_write_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			templates->read_cache = best;
+			if (spinand->all_cont_read_variants) {
+				templates->cont_read_cache =
+					spinand_find_cont_read_variant(spinand, best, iface);
+				/* Only clear; never re-enable a denied capability. */
+				if (!templates->cont_read_cache)
+					spinand->cont_read_possible = false;
+			}
+			return true;
+		}
+	}
+	return false;
+}
+
+/**
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/**
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/*
+	 * Only ODTR variants were candidates in Pass 1; SSDR bits are clear.
+	 * Clear ODTR templates on success so spinand_configure_chip() on
+	 * resume does not re-enter ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask)) {
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		return;
+	}
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 * Clear ODTR templates in either case to prevent resume from
+	 * re-entering ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2095,6 +2359,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index d7c99fcfb85e..87107f0955eb 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -754,6 +754,15 @@ struct spinand_mem_ops {
  * @odtr_op_templates: Templates for all octal DTR SPI mem operations
  * @op_templates: Templates for all SPI mem operations
  * @bus_iface: Current bus interface
+ * @all_read_variants: Full read variant list (ODTR and SSDR ops together),
+ *		       saved when ODTR templates are valid. Used for ranked
+ *		       controller-optimization fallback
+ * @all_cont_read_variants: Continuous-read counterpart of
+ *			    @all_read_variants, if any
+ * @max_read_op: Persistent read op template updated by execute_tuning with
+ *		 the validated operating speed
+ * @max_write_op: Persistent write op template updated by execute_tuning with
+ *		  the validated operating speed
  * @select_target: select a specific target/die. Usually called before sending
  *		   a command addressing a page or an eraseblock embedded in
  *		   this die. Only required if your chip exposes several dies
@@ -793,8 +802,14 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	const struct spinand_op_variants *all_read_variants;
+	const struct spinand_op_variants *all_cont_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

