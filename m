Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876435;
	b=DY4mALDWId7qtQELSlO0qERwjTAXcN8A4VmhRzvlbGVj/AudOmuvSNe986UMjue+/nP8
	 qU7sFRXk/CSAD6OIin3lkOau5UgYqSiuAD3adC6TSgW5UaJqimPIqUMDe3+pvtoTFkQRC
	 24eiAqzG6X8xsEcYSq6Me+rqkPM6p2FZbTTB+MPsFTp07iOu9Sc3g6uTq0w+TkKYJTVM5
	 NzS2/AsFvNnvuKqXBCgN9Vy3pMRh2UJVwylwCmbt1xfLer1kyuVbDaC6axLmf/LPXh/3m
	 a/VyzHkiOl5xT0a5V6TR6xltXIBcFFI+Av6ewHQDyXL71xsn22zRzhh5fsktWj4ouOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876435;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gsATf4FbaTk7ssjl3vSvRSZ0+9IJQ+jC0DqHV5otfV8=;
	b=HPOsTSWXUJ79kO2R9sITys2ZT/+MRN7JK/JbK2TVilINz6+Ji1Mb3xqUyvmSqVo6CXwS
	 Gzl6ZpisBBzBSdoq6T8vMffy9fuyrZuUTOo4Yj5DJPT8dn3Lp8jfSKzi/dAIg5UA0AXbj
	 kfvtWYHfFub2w7dN2PZb1cW/iXD3shnYMht6tiJQb0NkGZPzKYKUAQT5ALhIC1ULIyVal
	 qeHYlOAsXbju0NrfHICLzY+w9FmR6rXN8fMNz2T+hSUPUs4f90diLbZSXzT73CKZvSBcA
	 Bgkqk1AWdT0EA5xFJvB6KtoFMrz6UZ8F1J8ffhfGwglyMBLO+PH+nO1tEp+SixYgltQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dIuCDXhD;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WVt4qQVg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB3606A31B;
	Thu,  5 Nov 2026 11:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dIuCDXhD;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WVt4qQVg
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wGFR2214877;
	Thu, 5 Nov 2026 05:00:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=gsATf4FbaTk7ssjl3vSvRSZ0+9IJQ+jC0DqHV5otf
	V8=; b=dIuCDXhDuW59ZjQoHjbR8SDvREbTTtfmEknCiNf9tDV9fsD6qWRLdh7Rf
	J+U3dfGWfTu9ugZXR644oVNuDIbAfUKiRy2c4Ada/1iVVCBXy54IYlzVZHWbEJ8w
	sHZhRjBxeYI+T+zc8d8xbpV8eCs+9UTozAmlFn6v16I3PUGu40/0SEzftlr/4Ii5
	SosY9mZgESLlr4PpLOzaHvWLnhjVhJUSFQlAyivq9H7oD3visacXc7MxnEc+Gc/I
	2lkYEL1na12E7WCKFUDFNcvy9SwWu028WXxpEfSOSTsb8fxGDz48zpIuUxeY142P
	qm4UGA0YKtNcouoFukq99a/JZ6PPg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k1yu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:00:18 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ4dhT0x0J5PyonHan+nqjOk97eo3MXPPhFwnNl2jlu4A6O76zgFcJvWkqSJm14yrvEHmaEKqouSq4LRFHRprQE3d9U6h3sD+AND7QD7M3BIFJlOaQK5hos4DYjJMO34gNJN0XYZM5mWPzayHzKCJY2N0Q+0iE8/28+htfKEf7UZP8jXX4PxoDXYiaZzkoiU85gK7iB8FX2B45HsSNuvImZhX/4E/yI6g6nML8/w30FcnJO0kzxmXAa4wXTr5s9PZdhN3JjVAR5dmlzfFGfrJsP1dzA0nSgVZqEeTbTvQva8G5jvSm94OE+A/Nq3/3D8suMD0Lfcpo22CFcdpq1nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsATf4FbaTk7ssjl3vSvRSZ0+9IJQ+jC0DqHV5otfV8=;
 b=NkM5TVWm0DXi5vriJRmkYTuUrl0oxT50QPNqTMx+lexnYYpz2XajFtAKzsZVdmMXrFVBHy5YQrpraWiGr8lWzp1IZxwkWJJyr3UI07l00xMY57kL1ekRT9rBvEDnHJ5y70kGHxDXJUIuiBkC+fjpIF7V1e5/OC1XcWnyxMDfo/bEviLDYY+JEebByx/ASzWZ49ssfa9jdL/SSvEUFPd4axnhWS+frzcMVNSsYOWBYlzPkWyY72JZAX62i7NhFtU388rGSKbyiurJQ/JS0SN0VCF89XoobKx/nPdJV2tFj7U194D6YJy6Nfu8zeiyHg4Tr+Iy7a+vZJa/+wejyKiHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsATf4FbaTk7ssjl3vSvRSZ0+9IJQ+jC0DqHV5otfV8=;
 b=WVt4qQVgKhnWoLh2nTX1R2f+xyUEiAKbMe+s2MvNx1wVNfRhLe1lzT87sTaUNHUV+AJ2dcpyhGV0TOHakqvXx+KwuZkVVshis1R+mnVgXDWlZMVY524MbO5bTtNT5JDQuVtQf/yMCu50cgrnb584JBggp2fkOVBrfy/u2FLkA2E=
Received: from CH2PR17CA0006.namprd17.prod.outlook.com (2603:10b6:610:53::16)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 11:00:12 +0000
Received: from CH7PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::19) by CH2PR17CA0006.outlook.office365.com
 (2603:10b6:610:53::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF00000016.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 11:00:12 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:01 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:01 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2L4171076;
	Thu, 5 Nov 2026 04:59:56 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 13/19] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Thu, 5 Nov 2026 16:28:26 +0530
Message-ID: <20261105105832.2134313-14-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF00000016:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: 31393b8b-df72-47bc-7954-08df3b2bf703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|36860700016|82310400026|261009221227099003|921020|261102123227099003|261009223027099003|261021121427099003|56012099006|261021123027099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	37RhdlzX6jhjcTwyqzVdXpvWAIuEmOLMMHiMQRBQz9FGC8/deQTe5VO1yS/DlGSvvXd2okKZ8bEI6aoPeZMIJE/CQJXMFRKpLT6i9HBCsoqOg+CTJjfYX2xNClcFeX2JvJbv4z2hgpOWF8JaGJRv3XDqR9bj9OVP1mF3hw/U6E6DNsZrDkPd+TZP8easrZDyrkkbUHDjfJ68Q+I6dfWFeskKyaYEsJfAL53UWBNmFTmnjLGQojQ+g8MHWk/+h+gCG41wUyQtDMTZa5MrlpLm3RYpR5RwySEkGR+vc7al5PtXcnvMY4NAey7BhIpCjlN0KGivhwTGmKh8bRzHnWsp0UroneQ9h5TAbFgawW0EXUIBcHantHdXgqZTBRQCmi6gGsoZLawhsfJRetLrJYzs/yMv8CDJ1j++oJz5qAtk+jUyXyvonol8yz2VDUCscnzztISBTkezvQc88vdQki5BUr/nPu3mcJuiYErOXJGfOdc6dwYqRxMtvnwoAGo9Uhm1EgDnc8v1x1jYh10ZLKxZ03qXXImVLOMjoepRXKCyeGtNfhpixKC9CK+j9/xeQyMkB+1W/MdSq+Ik3CewOz3fNUmYqGEweRpZPqjB51l3Vzo=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(36860700016)(82310400026)(261009221227099003)(921020)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xNUKmSq9u4KUZY4cqD/9m3S4Vl+JCjgAH2mtqZvlRsIkjG2bsegATf96nFoLNwQMotyz9sfjrtJ3oeskQzk9pBt7cD7TCGG5MEf7mzXBoVNjKM/lVYcm3UTCkxr5i6olgdues6dxoMyI0kaAw9Q4P11wP3vykqYmZNBWHyRs/lV/NzJA48wpSHvMrEDAVtu2pw4uvUFZCL6aJkzF6jvMlCmbG5JIjf4zxtzsK1J8amkvp+/PrCXTcRpX1fQhUO3oJjyRuwOIkYtmymARyGufGL2SU3GF/ZPI9i4OaC12mloBmhf0AYFyMwKXns9DD/8Nf8Zc6eTyQNFD6/HkJ3jNdwCYoOjnIu73qJxLKxtvXMdDPoEul6DBEdf2aYjDENgsj7Gmvmbgq9eExnxJaTuiCJIJNz5kJAN5UkQwI9MdBbUTgj7Trj+8oMihJLgp/rm5
X-Exchange-RoutingPolicyChecked:
	Dv5/nGZ23USTH+BZdynTfd8CHtB2LaC+SvR5uFHWzzTsc75jdC5Sdd7CrEHPyHjMXwHm3S5lVWkDPbbgDHYlZHgDv+A5fPWl+jK20E/VygQNtZMdMk+Txk4heWLo1RD6+8YBi1fRexSsOUaMvJxS+fBTocbgbOHyQdfqIIar+m+Xt8YHZ3ahq5Rl+lCxlVXYxq209DbHurLhXaUv4GkJH/l3K8fmv66dWpwawaWQE15YX/XC5RQtNkVQ7M1uWuTQreeXa8EuL1XszyoWEwKv1hyHIZJnZPCQ6KZtGTSIlBHJ8axVTNb719jBLwIsaMiK2+UxKvN07HJyzcjz/07PhQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:12.3071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31393b8b-df72-47bc-7954-08df3b2bf703
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-ORIG-GUID: ilXqnZb-jam7m1YfmK-JjFCjpJC-2EYD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXzg4JbDzIuIHd
 5wNrrh+Cld01paduyARKmnqjH/BC32Bb8EtVkUrGjlkpvWGcgkuOU1ksVV5hl26NuIR2YnYbuYb
 j53acqqZnTTfmxQcK1va537j5+6Bngo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX89jpWt/NZqn0
 neJ5wjjV/VaVUzfWomUbOIA8+rCKdkrOvvsAGdShhDNdFkmO5XW4lygbsPIPzSuwSBppnXNCeoF
 eyAMcuMkckvmjyYmPSMtkQrr+B+dRxB/d4T5Wny3aWyM1fXsKlG3jIe6egRH3We3/a7hxeMDNcy
 GKtuOXSmEX2Z1ED1ZPVmieLJVKP514Gwje6LIgXFn3Q+k0+V7SOw/qmcjaU245yYuNenXL4C8yp
 bsDJKzFBP+2MnULfnTMkwCNMI4shjYNRq2Dr3YpUVHEFC0N7vJWAWZuzVJT12cnXbCuzelN2aPw
 KNX9mC7J/fKAq1KzahufCY/VQPeChFFlOQaGJ4Vood4W33U8CKcmz5EOxigmY/1FcIoh7PrnMJC
 BFdYBL8XvmVVcxxGUJu14eaOC9ER6LehWmxpFO5KN6ID9ukALIF2rN1WhbAA59Yff8rMnRnjGE1
 8dWaAdc54ZZLn5T4qTA==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec61c2 cx=c_pps
 a=Qq37X6yQjtlUzqIQK1H1Rg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=G053T6RcM3nF4xrB7AoA:9
X-Proofpoint-GUID: ilXqnZb-jam7m1YfmK-JjFCjpJC-2EYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 806bf49e814d..12714a9f04f3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1620,8 +1620,9 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	int switch_cs = (cqspi->current_cs != f_pdata->cs);
 	int switch_ck = (cqspi->sclk != sclk);
+	bool reconfigure = switch_cs || switch_ck;
 
-	if (switch_cs || switch_ck)
+	if (reconfigure)
 		cqspi_controller_enable(cqspi, 0);
 
 	/* Switch chip select. */
@@ -1630,17 +1631,26 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (reconfigure) {
 		cqspi_delay(f_pdata);
 		if (!cqspi->phy_tuning_active)
 			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 					       f_pdata->read_delay);
 	}
 
-	if (switch_cs || switch_ck)
+	if (reconfigure)
 		cqspi_controller_enable(cqspi, 1);
 }
 
-- 
2.34.1

