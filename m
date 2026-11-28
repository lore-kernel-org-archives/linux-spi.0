Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.147.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795834159;
	b=k7ohzyQhky4t/TWhhOK6Qk9QUFOZN70LtBm5N8Ru6VcyJIhb8Qg0TMZg1hzdyCEtknNO
	 Kw44qNUTkpBh1N8ZwNA153VoPFl2DpVbni+j52fq3CU6f66ioTVbBdOu6g09tcpFDeeBb
	 bQM8WxLlWlHlUwPepxpJH/cGL2lvd58i/iiGqL/Hy0b5XdV7MI8QhgXtG3dSNF6KGHeer
	 xWU2MSz/MeouXeYOthKkpEfdgzMdxTCMd+DRveQkJByMaimAmgqTGqFlAd5W7ddIBblXB
	 8L1lMPjQDkjMecIZcLy73cQDyk5PbpJEUo0tYhLOp02Na2Ryrx0Bz+G09tpyWT2GVkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-HPE-SCL:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Reason:X-Proofpoint-Spam-Details;
	bh=vlJ0d7vbXRShVWUajLubmLU6PTxbTVEg/IFnFxQ9wi0=;
	b=eqkZ+lqP7IYX6vWPVMXWvgIHEU58WLseb2sgd29KB0OTlOZDZ7wfPjAJyx5houGxDeP1
	 QBtryFNBPD1FZV/t1G6ASwtz+Qz+rg2LCebBjeK+8d+X+bna9Lck75Vx4y1uPsIPKBPC6
	 pnhxX2FtW0sd7Fdw7NAmp91S7SIBxPf56a4Y11F7NiJJ9QKi7iwTp2HuWwUvEQVp9IUWB
	 6cFRUSlSM8rS9vpcHPLHOOvLH7b+odosoZfPhAGucyierngzxoKZBeTl3Upxdwdd0bztf
	 9Gxb5sevD9lncsaBjU3kJhgt9nJx5EajAu8Ey0sNWXKd4sxcCIDy6zKv2fpuyWtz/Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=juniper.net;
	spf=pass smtp.mailfrom=juniper.net;
	dkim=pass header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=jnprhpepp0429 header.b=ps7vtbEp;
	dkim=pass header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=selector2 header.b=LhYPE9R0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.147.86
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062D606A31C;
	Sat, 28 Nov 2026 02:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D062D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=jnprhpepp0429 header.b=ps7vtbEp;
	dkim=pass (2048-bit key, unprotected) header.d=juniper.net header.i=@juniper.net header.a=rsa-sha256 header.s=selector2 header.b=LhYPE9R0
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS1GMUu256288;
	Sat, 28 Nov 2026 02:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=jnprhpepp0429; bh=vlJ0d7vbXRShVWUajL
	ubmLU6PTxbTVEg/IFnFxQ9wi0=; b=ps7vtbEpocXLZ6OOr/WG98O+UqJYbDypBN
	5rW1ClC5aaGa9p7w0gi7gDgywZ7ccjCaaevGX+iISRaMgsXb7napLM/a69GWUTS1
	T1OQ4KOnsoL8dZNJB8kEIFhZJFttip4x8FFk1Xgm04F0wd2n6MSyPii/hfL5MJ9f
	+WzqcC4QE6ODtz5Ky3USA33tXiD+f2j6joxPkIbc/KOfeYGWB8yqbkIdGoyjwb5x
	KLc2ZGdeWD1WInafL53KN+R11RFUvZS+wsz/huClGiCpv/oZHvF7gFS1bLcLkb/0
	rCfAB2Y5j8RPM+WRgh4MA+3+Ms+aC1Dq9K+1v4INyraRbirmlwZg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4j7n590knd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 02:48:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M10bE5t8CkIEt/A5UatfcEhq4PwnITDTk/p7BT2nc1VByZSGxpA6yS80Y+bhje/++Z5OVOj55qlweiIQDIkgHmnMhAXg9TbdFXTOPWXMLrI/OLNK5VbIIUVcAfP3bi1XQb3JJsxcd5sYFJQpw0wgcvAqdRpdANXhQvlZi/9FuK1TO1HXoZYGeEuT1Cf+oVG7/JMb7R+oXmasTpk96BuDR5x4QcgvO7Hvf7926at6I/eEKTRiDUTeI53zj6/XTBCCYe8ZV5VXsXmxlBK+o5lhrmWBGvlPLqnII36bIZYc9km7CCFfBA7SnKKybaWxaaB3VQePr91wi0YAy22lkIEhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vlJ0d7vbXRShVWUajLubmLU6PTxbTVEg/IFnFxQ9wi0=;
 b=J0RbdXLSitdM9wVugVE6hiLAEmwEBSCXPj8+9jFb/qcLuY3gXseN7mR5dqSm83pkPWJnyhyayCfBQiLSaRMVUNkdxBhLI6yP7IK9sa/vqUDmkHJ/WVl9gzW3kkqDk+p5oveXZ8u+oGV1jrDs6s8ka98/LUnaUkdn3xymbESsrMwz/5HWATwGqvkckSRuuqt+PrJsWKL5X8aYR2p7avtaGBoLEYRtFRIWD6bKN5zH198oKtam42qBuB44Cg9QldQwIXJlbGefIqHe5uvabEdV8EGggUc0DIflZIjMbQGxg9J7MQV8Kutf49AWHLulpagDp/l4drEeQoBi+mKpK2dB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.19) smtp.rcpttodomain=kernel.org smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlJ0d7vbXRShVWUajLubmLU6PTxbTVEg/IFnFxQ9wi0=;
 b=LhYPE9R0e8yGryz5ohUh1sJ5GI1Y+4ZlcU0lpADauexopIICBQlJnobHLLiEjKtBaNtypYdicWTuRbCBjm0Z3J3SyyZrbBaFz4B+Lq54jZsqP7wbFF9HtIKFRPoRHEFTquJAq9cUARFOSN85SHPCYP5B9ZBWV8cqRozcWlYxcny/scdSj94VQ+Xr6Y7RIfjQgkU0kalsQc1k/Him9/qMUBes0nGnXtqEOW4v9Yb5bS82rxMc8ljg0tK0grs2O6AhbXkpTpXqiRxyVM+o6b1enEcwIaJI+7D04Ha3qzB1drNKuZWEe2f8kJk/77xJHLjErQlYkllAFmr7nEqqefkJfw==
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by BY3PR05MB8052.namprd05.prod.outlook.com (2603:10b6:a03:36f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Sat, 28 Nov
 2026 02:48:56 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::7a) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Sat,
 28 Nov 2026 02:48:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 66.129.239.19) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.19 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.19; helo=juniper.net;
Received: from juniper.net (66.129.239.19) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Sat, 28 Nov 2026 02:48:55 +0000
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchfe-eqx-04.jnpr.net (10.104.9.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Nov 2026 18:48:54 -0800
Received: from p-exchbe-eqx-03.jnpr.net (10.104.9.86) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Nov 2026 18:48:54 -0800
Received: from JNPR-MAC-9VDX3G.juniper.net (10.104.20.6) by
 p-exchbe-eqx-03.jnpr.net (10.104.9.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Nov 2026 18:48:54 -0800
From: Debjit Ghosh <dghosh@juniper.net>
To: <broonie@kernel.org>, <robh@kernel.org>, <saravanak@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Debjit Ghosh
	<debjit.ghosh@hpe.com>
Subject: [PATCH] spi: serialize OF notifier device removal with controller removal
Date: Fri, 27 Nov 2026 18:48:30 -0800
Message-ID: <20261128024830.57367-1-dghosh@juniper.net>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|BY3PR05MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 230044a5-9d09-45f2-14d3-08df4cfa24e3
X-LD-Processed: bea78b3c-4cdb-4130-854a-1d193232e5f4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|260925021311599003|260925021911599003|56012099006|11063799006|260925022911599003|261009220027099003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|261102123227099003|261021135927099003|261021123027099003|10067099003|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261028144727099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xlpKhHxCXsJabRMoRKLSdW1fPa/CrrvdvdXcqXYXzIhnLmnjY8knV8OLoU0RNciVPMW7fU+xQAkX459mGtARdv5kLsOc0u8pdO8Kl8mGC2b0BUvkDUdFoPDy6SYuHXkToIqAP/G3GaLzBmBuJ1YV2WeNj2EysACIm0UrroMm+7f1M9Ms1lr5KUxVs5Z2oLtFeYcEGM7ghD/hC/s0ziDJOB4j5YnnJyfLqPyH3UOD+DoZzkK1CsYb2QYxp4Mug5tBLTq6np0rL6h12IBOkRkaREH8/m6AcjeraAzGEtm3+Cu2XeYRv28iYTByumh2I2NRmTrmAHeo0+89IKuyGNpfeEsELYRnweW70dLh/Bi+ZcRfOxS3aTup6iVimTBag/hv3LOmhd3OTdNo0HsJ/HjL7ZjvsKNhXdquNsLX9gWyXKG+s9+BimLAH2oj4SWX9nFUzGGPyXR8PnA9/oiEoHcQGr7MWYJ1XEf305MgSF+GEN5zxxHWueguAkgM1zMlgILx/rKnYon4rrHKO8Mh4O+dfaHAP1NzR0e320cqZMOHV4IWbOxUfhJKrKeSrdHLMhISSwR6kGC21CAUM4BuOvQViwYcjaR0wq6vEU2w1n9t1WliTeefO88Bc4TZHa8YMc/V5eicGh3nmLA0c/B/TSWCj6vU0Vti4LbApRdTCVUH1H3K3ZspULeP1Tj+6fitMCyzSA8MrAENj8NaCWxS0NsfzQ==
X-Forefront-Antispam-Report:
	CIP:66.129.239.19;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:juniper.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(260925021311599003)(260925021911599003)(56012099006)(11063799006)(260925022911599003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(261102123227099003)(261021135927099003)(261021123027099003)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261028144727099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CAUX9nM1YyEM/3W+0b3zuOOZtwwodLEn06DuLwszjANLJj5vcFClxFNydGyclNzCtlNKp8GWK4yAj1Qwa3WIxhe3Euov0PBLorJ10PfotauCRSkLrTL2fUQ7RBIFPUSnFex1EBkXsVA2y/w0qH1Z/VCHCXT2IFffX0JK06NMgbQ0g4n5UZ9NF5ID98DUey+uTJXjdXcDgVfXVuaIxUoI1c5Jr7LSBmc0FoNMjc+XTEUycGd8mxEPy5sBqQWBMI+PxQSzu97VYVjxIxedRMImOmHkXvPpR2rb0qPr9SMyvH3y36BKjsXJss8JfgLFAqrVwMlT2XrXMG7LSxa8rGqYcRNf0QaRZbVijmq5MY7ySGlc20yq7BGobtBnGrff2TzPY/HmBmlBaICDcvC6uJGHX6jOJGsP06BtuBslJjsvFIqw0X8vGzVUJ1dyC/jbBSHo
X-Exchange-RoutingPolicyChecked:
	nO3+sTMiELU8s/cbekVHKoX6b+MfooF9iFGNIEWhRfAa5BBzo9lGsMw6rF9hcJpNqC7FZSpo5m4+bZknud/Z+3lOjnpz0puxCCcNJNax4jyDyFv8ymgZmWg58sSYXtYecXajICoDfXQpKSvGUkpGRkCNzuX7YgOP24A9/rhfeXX5gFcqQBbxDOk1mIoQoJvJnAorvHFNbJGdUFJJ/Ahfb0eD2xz7iFWB/W8Tg70I1SH1OphP9+etAnuVDPyUF5OBeu6OyizjMqVtU+taff7480MIoUkk6KM0xs3lywrC6pTBkRcXFOp0Z2ga/biehNQAwikM3H2pNObH62RBScbixQ==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:48:55.2982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230044a5-9d09-45f2-14d3-08df4cfa24e3
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.19];Helo=[juniper.net]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8052
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dd8VTnXe c=1 sm=1 tr=0 ts=6b0a411b cx=c_pps
 a=7iDNbrykdXu3VEpdGPV71A==:117 a=SKdRtqzh2DBFgDMvUaaGnA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=ay80y3fxfMS_JZZz1qJy:22 a=MvuuwTCpAAAA:8 a=f0m63K4f3OUlbL5KzP8A:9
X-Proofpoint-ORIG-GUID: GgWd9UMJAZwd1i2lPEdy-7yb3Llpuh6M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDAxMCBTYWx0ZWRfX/tmnBgNq8vIJ
 ifJezbAME/291vmE1vbn9P0s1Joh71JId5Sb72c1tujV+DTq9l+Pg2rdZixExVYKjFxVZjgeMrO
 0NwG89uQ2LNf7nYYVliQChMYSNwLzdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDAxMCBTYWx0ZWRfX8BTBGPshQUNg
 Vu3IA9UMAUVjsDmDnFse7GP/uOGpcylJZOzKIoDMmvWh2EXLeDwfeanMaJ6CjrV6kwxmxFrJSGi
 bsoKnOxew9fgdFHLyDtKJllv0pikg9jZ73HGSCpBPPEY8iEg+xhWCglUo9QBw8qfS80NuqqENVZ
 D7ennCoutt+W97M0vkp/OkjkiROhlWNc3TDvb7K8OxQeY5i1xmj9q3rHIlp/kujG91XtNaHNWup
 Wf7ajYLuEFybUKFhH4uOmNB1W6UtP7xO6XafEsQlDMNYNpp5azD3shXjbRRvwjWSFp6ytzpRxZ+
 Nms6vNgErk0CFQqTYXWU9YncqIKnNSfHfG1uG3JpnT4tlGyn8iGxItFQeQYtlmtJgO1EkxAs+EH
 iHMkNSxfdP0eLtbCDDEzR4HxqlMXybqcIbHb34VXBzysMHEkVdQD4qK1Y7UkFPlqewVif08kQZu
 l8TQ76qsmIKXzsAQfbg==
X-Proofpoint-GUID: AmkrK1p0H_zr6mXjQEdmbAH2EWl7EGxm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_01,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Reason: orgsafe
X-Proofpoint-Spam-Details: rule=outbound_safe policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=orgsafe scancount=1 engine=8.22.0-2611040001
 definitions=main-2611280010

From: Debjit Ghosh <debjit.ghosh@hpe.com>

The OF reconfig notifier and spi_unregister_controller() can both
unregister the same SPI device concurrently. However,
spi_unregister_controller() unregisters children holding ctlr->add_lock,
but of_spi_notify() does not. So both contexts, sometimes executing
concurrently, would call device_del() on the same device potentially
corrupting the controller's child klist.

  Oops: general protection fault, probably for non-canonical
	address 0xdead0000000000f8
  CPU: 13 UID: 0 PID: 173 Comm: irq/38-pciehp
  RIP: 0010:klist_next+0x6e/0x140
   device_for_each_child+0x5d/0xb0
   spi_unregister_controller+0x3a/0x140
   ...
   mfd_remove_devices+0x36/0x50
   pci_device_remove+0x3d/0xb0
   ...
   pciehp_ist+0x13c/0x180

while an overlay unload mechanism was concurrently removing the same
device through of_overlay_remove() -> of_spi_notify().

Serialize the notifier's removal path with the controller's child
unregistration using ctlr->add_lock, and recheck OF_POPULATED under the
lock before calling spi_unregister_device().

Signed-off-by: Debjit Ghosh <debjit.ghosh@hpe.com>
---
 drivers/spi/spi.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8a06fb4e309a..6562e3ac4dd6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5308,8 +5308,25 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		if (spi == NULL)
 			return NOTIFY_OK;	/* No? not meant for us */
 
-		/* Unregister takes one ref away */
-		spi_unregister_device(spi);
+		/*
+		 * Serialize against spi_unregister_controller. The device
+		 * can be unregistered concurrently by its controller being
+		 * torn down (e.g. on surprise hot removal of the underlying
+		 * bus hosting the controller).
+		 */
+		ctlr = spi->controller;
+		if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+			mutex_lock(&ctlr->add_lock);
+
+		/*
+		 * Recheck under the lock as whichever context executes first
+		 * will depopulate the flag.
+		 */
+		if (of_node_check_flag(rd->dn, OF_POPULATED))
+			spi_unregister_device(spi); /* takes one ref away */
+
+		if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+			mutex_unlock(&ctlr->add_lock);
 
 		/* And put the reference of the find */
 		put_device(&spi->dev);
-- 
2.25.1

