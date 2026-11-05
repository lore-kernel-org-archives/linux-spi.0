Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876433;
	b=eW7Rn4WkqfahknHNemrBuuKtXNeHP/rGyPEntoyz2IXMlewDUAKwV+lxa0mBtPO8h3hG
	 2SuVw7BRJ3MQHzVSB2AOZ+VWxf26Hwd77aq0gvenxnCHKAdFFRFAGYAXpj4P+8LQ1uYon
	 VawTwQITvzKZIDq3d89498vDr1p3nORFZ1dvs3covEpgsP4u7nr2HezsLSrOlyBrpgn0E
	 MlFhWAoFyPXBpT18s7rzB1AuRvQnB1B5T+m2vKiiEZWgue8V3Ke2qiglrKiF+JI484klN
	 ream3jegLjtACusNCuNbDU1j/HPbBK2Twa95TXnWzsMYczUNhHIfN3I6YxJqhSLVzhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876433;
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
	bh=WnRgwp3U6Jq9r1q9anp1FeyfdpMfmZX8+h0sywRbeDc=;
	b=x57q1b5dQIS/ypu05cTCyvnskLMEHl1Qm5F+1iAuraHvvJrH1IQEaVsP84WKvBhxNAe3
	 nUdCsS7jOZvlucVlqMUvB3n7eyI2WjNN20VGzsxTBuubMjzUDU1QMKgFjvrxQPCnjqRT+
	 +OGDd4qCWfYZUYx//uRZVT3SsAN0kXITxN95PT5GLQUeYZRa/xQ6xN4+p17RQDDwoQ2Ll
	 rjO61W4HpQ7zeGXNR+YT0WnRFFJSlbIfx5gduIVp/ZTxksQYmcEofBNhopPV+JhNmf5d4
	 LvqafFsRAT1Toaur+wy/bWeEwfIMPU9BMsAofSAXxWrbflGvYGKsTttdUZODyzVY19A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MttoKUYN;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CbVjn7fV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EB606A332;
	Thu,  5 Nov 2026 11:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7EB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MttoKUYN;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=CbVjn7fV
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59vgBR505157;
	Thu, 5 Nov 2026 05:00:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=WnRgwp3U6Jq9r1q9anp1FeyfdpMfmZX8+h0sywRbe
	Dc=; b=MttoKUYNKJP0qxwrF10t09myo1Nc8OzQCr8SogHX4EB9De7ghhI09Q0qR
	G+jbryp5TiunmYViai2X73aUd+OshDZxPrp1yZb3tm/iOVtv9eg4ZWJSJILY9AXq
	a7OkTBcTnZioD6CJMZSJedbe6M8O7jGaq5w5+PRm732PbfTVmIlqR7wRkSpRmKN5
	RsEa/trZwAhKaxWE93PSvd3OSpfN0x5D9jhzZNPvYpGkwr0VJ/8UJDB2+z4Ixd8A
	eVue+jNVvSJdm8GZWRFnl9knj/17EesYywUppfSCItOCUrzOIZXg4zss1hVHjtEe
	XQrHzT/FyjGMrTeHkyIeP/+DRruEA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hrq6tgcj7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:00:16 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um3WZ8wK5DuI4FLiXWttTIDlTPU7zTyiiRUntenECHX79iWvIPbDyP3uJWcoJvIqo3H2NSmhx2P0T8Opj6P+8+eBYBsL5uSilvnIE/TbdQTu0adB07uXv+YSAbWdTAytufte+zwIXCepCvcht/V5B8i4WNhs9oAreB0FiwV+o0hz3KSYtZpqiA1Lg9EmVaH4FDyJ13ITpwaEteOXbIB7K9jDJgNNs1reX5Gn18ApJ2Fe/AcI4NtJx53U0yTyuhXiZ+gZ2WDf2PABjPXt6n0zg3G/mPBcmAKqexVoJRr2tbWwoJVd1rnpzpz6LR5jgthB1gV/LeQkXXJp/FZ98THPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnRgwp3U6Jq9r1q9anp1FeyfdpMfmZX8+h0sywRbeDc=;
 b=SE37w8nJyachBu2qXmjAJ9O+xcIpM9VpBQqMuBsip2xhfuPh/Zc0eXl6KuYdpRLjCQvibiMoe4Uo13Qgt+V7fCN24o/0YfBRs5b3jNtVnXDvWZMWMp5WSbMxqTOA3CKuWh9PIsV8Q1dgN7AXLJlehAVPN2iYN0SK+erbnKfuaprGPgCg0Rcue370Ad/DPOAcD5K2I8T6c/V/nFF8qNDa/QGZfegtg1pKQdpcauke4cneJeyARys3Fzy5k7hAF+YyOZCPz1VpF7VfLKSkvK/fBn3kCH+/Z4f+QU/z8sDI6jww+If7qskj2fcvXlDjzVcRNlrAT9XfCfni1eKW2pkX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnRgwp3U6Jq9r1q9anp1FeyfdpMfmZX8+h0sywRbeDc=;
 b=CbVjn7fVeV/gzOmcYLb7Drhk00iORf9KzBPZTCFOj4NTw3p1wk+Tv2aVJw6OGOfZrZSbcCIDly3li2mDdJRwYIu2sFgZTbmlLdAgAFK8Vnzef1sVfuqy5OWUgfxU0+/YhKzKdo2X156dISW94ZhPRDW9LF95UKotXGpE5k/0LcQ=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 11:00:11 +0000
Received: from CH7PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::6f) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF00000016.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 11:00:10 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:01 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:01 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2K4171076;
	Thu, 5 Nov 2026 04:59:50 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 12/19] spi: cadence-quadspi: enable PHY for indirect writes
Date: Thu, 5 Nov 2026 16:28:25 +0530
Message-ID: <20261105105832.2134313-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF00000016:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a88fcba-43ef-48bd-1ede-08df3b2bf5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|7416014|23010399003|1800799024|10067099003|6133799003|22082099003|18002099003|921020|261022105027099003|261028144727099003|261026140227099003|56012099006|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261026121527099003|261022075727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	KXD7kQAf4vLNMfOYuhCMEuKc2vhc2yVmd1xCCkBM5BEdl6yIAk9pKppGyegZrpgpXUm6nMIokwVL79XpBX4uJJMKZFQ0oZNXth5++5Aq0N8AyUOAJ0PZkZe0BtH5HDt+eO5aBbIGtWO0rKrUfn7A9BqDBUEF5xlszsPQS3TzK4tbcrrLDAeoXiR/SlSk9ffrnE7tGhCAo5T5xVtKu87iHrqE3VgJlr9QDrzUjrQk7bHAxWxZDodbcuQ7xIhOkM/zp8dG+JLFLjrStC+r57O/J/wcvM/sR+fAG8jpyXcCn7ZIlNGIht7L1AaazlJpmTzvtL8lIfPE34cdV1emG2usxOfttAmGTMNbEipzmdzLLoMhBJB27BXLKLQlR2k33SCEyuYATteSBx7n3LI66rYtra6Eyo6xyllOpRzp2W0B4SsiVUSoZw8cOCfTJXYVGbdwDRWLPBoZsyFDkexlhAAubuFZlArLJ5i4pBhaE09fnNeeMek/iKWDR+uDYDdU+jEnUC/+j3ZKx1ypwwNeJhAS9KsMbGDlBxg9/QInSdvI50vVseNzskNJJ895ifPcnXcaYnDFqoIxSbrGei2cuyFgL316wntdS1hM3CXdXmmcMOSB+Mj+jZZ7+71NC2VC8XHcrSb4uy5VqqMy12hXQMEDBftHFy70/VpQur2fho4TVJK/C3Q8pS9D0KHIJlWaoS1Xew8V5ohFf2SLsm/6CNd+5iuYvXHopRDKMeJOBbK+Ho2yDtowh3MXX26p/8Nk1OGT
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(7416014)(23010399003)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(921020)(261022105027099003)(261028144727099003)(261026140227099003)(56012099006)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261026121527099003)(261022075727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	63nkgRoqKSer9gFbcrETIqvK4aufirf3+9Zzyybrzh6pqwel5q+gzrIxeTLJBQYRiWxKux+gHvYMBD2o4sxydcqq/u9IijwcbxNwr4P1SRCFAtErnXGnjlM5lQg8OTQHkH8zyBdM3WHjwm6k5keLeQNtot7Sp1TldPM5o+L6PiueGXQ16cbp3WCldc8qgV319e5Cy72ZwaeGI9g7bEqUDHl+/yrPsBbZz98ZZv8i7a9RFsT/jqf03c9C0IhoYkclHAvLr4OJFLc3ZJgApKsKMgWEgOOdohVrGE1T5w9J/bcgQRjEelygjJNxfUKrhfmXH5HPAyc0Ag1+TnwVSglhBL5i803w6Jo4iACbtEMqxxnPhpgx2RheSrIf8jSXENTUU9PoWRMX541RtxQXASclYjdkBZf/eGQH/Fx9hnj+Edq/k7br9Fn2Wh95l42Gi8oh
X-Exchange-RoutingPolicyChecked:
	HCH3luHPE1zkigE+nOKQt4GlZnosG5KthA9mzW/lg5LoWFY6XWlJalWochKoAHz8X2bivEoadey8TOoZDgyV3uwRfSMqz5wyhgOeeNZdsYUQ2s/9IRpDymxPSBx78xfqni2Kav1j/bCOHR84+Af3yM6HKi29iR0y3Q5sQMJcorxe6W/m1D191rIVvKRzv5TBHAvu2RjPllMsSFq7sKHwLvrsUTnlaoyW1kso162KQDhEQjnJ0t2PSyhN9+cuwR8GgFFuyIc5txpCxvFBGCL1D6c604n7MqdG/bRW2Qb8PkwCrnqXYcSkwEZm8q2D7xEmMx1mGnXhFmPCM+NGOXYYCw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:10.5602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a88fcba-43ef-48bd-1ede-08df3b2bf5fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-GUID: JJcce_vzgpmPgE8nK6D4wyz2U2nNkQXy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXzi4z0fLEH9az
 ifm2ZbG6RZFya7Q94EOUI9ZbeXr5SS1Rp/Ndlr76rganFORtsWHvvyyTufvscm/2lubIzp8NQIL
 HHCDdP50mnvgDlOtkcphC0FfmkFsNvI=
X-Proofpoint-ORIG-GUID: JJcce_vzgpmPgE8nK6D4wyz2U2nNkQXy
X-Authority-Analysis: v=2.4 cv=Q6xHcI2a c=1 sm=1 tr=0 ts=6aec61c0 cx=c_pps
 a=F2A7jaVQFOduNxX/8CKReg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=FPdFx8wxxZkYFc-TLiwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX7te8QPmZ3D3T
 cw+zos2dihtSgQGLecByt1PGzOSnndstiIwOKMEJNpLMqW+V7zMasBQQIAoB3wHA9J0yMXgQ43S
 JgJilw2qiputcDq+qfpefKZ+5AhFiKU9g8dK54vRW3s/Qi3QGN2FbpJ+wY1fxoeAywyeyoL7a4P
 M+3RVQEjNAglcliptYIQK6Ka7OzD4fB7of/9LnKI2ZkfHIVTEuqLgpLGXgUFTwhH7vDTPer65yM
 67pETTD4JeNAhHBnYcX0FfYo8ltHRxJRcZw6ETWichg/hT7DmvYv2kgpnyGUX2qAgk6Ccb8PQZe
 +j5FBiG8HPyjhm8NRyc0W0y+Y80fcknLBa7z02NDMiIxxfYQ/E44Qso2ktch+IYhXQ3VSMEnU1e
 N95e8krhGBJ66lj1gW1AnOJMd/dK0YKgrIa47ICCYFlZVmU8DCAAT9dM7d43BFzbvAvuU9ezpVR
 exJrtGt6VHcGhm+/HoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050043

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. Add cqspi_tune_phy_write() to toggle PHY mode around the write,
mirroring cqspi_tune_phy_read() but leaving PHY_PIPELINE clear -- that
bit only affects read data capture and must not be set during writes.

PHY is used only when cqspi_use_tuned_phy() confirms the op in hand is
running at the calibrated post-config rate, the same check already
used on the read side. This restricts PHY writes to NAND devices where
a write op template was provided to execute_tuning and subsequent
writes reuse that same template; NOR flash writes are unaffected.

The indirect write is cancelled before disabling PHY in the error path
so that cqspi_wait_idle() inside cqspi_tune_phy_write() does not time
out while the controller is still waiting for AHB data.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency
check.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 69 +++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 55c446f4245a..806bf49e814d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
@@ -159,6 +160,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1175,6 +1178,37 @@ static int cqspi_tune_phy_read(struct cqspi_flash_pdata *f_pdata, bool enable)
 	return ret;
 }
 
+static int cqspi_tune_phy_write(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	if (!enable) {
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+		return cqspi_wait_idle(cqspi);
+	}
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	ret = cqspi_phy_reprogram_dll(f_pdata);
+	if (ret)
+		return ret;
+
+	/* PHY_PIPELINE is for read capture; must not be set during writes. */
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_PHY_EN;
+	reg &= ~CQSPI_REG_CONFIG_PHY_PIPELINE;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return 0;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1366,7 +1400,7 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 					loff_t to_addr, const u8 *txbuf,
-					const size_t n_tx)
+					const size_t n_tx, bool use_phy)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1378,6 +1412,12 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (!refcount_read(&cqspi->refcount))
 		return -ENODEV;
 
+	if (use_phy) {
+		ret = cqspi_tune_phy_write(f_pdata, true);
+		if (ret)
+			return ret;
+	}
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1454,17 +1494,28 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	/* Clear indirect completion status */
 	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
 
-	cqspi_wait_idle(cqspi);
+	ret = cqspi_wait_idle(cqspi);
 
-	return 0;
+	if (use_phy)
+		ret = cqspi_tune_phy_write(f_pdata, false) ?: ret;
+
+	return ret;
 
 failwr:
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
-	/* Cancel the indirect write */
+	/*
+	 * Cancel the indirect write before disabling PHY so that
+	 * cqspi_wait_idle() inside cqspi_tune_phy_write() does not time out
+	 * while the controller is still waiting for AHB data.
+	 */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+
+	if (use_phy)
+		cqspi_tune_phy_write(f_pdata, false);
+
 	return ret;
 }
 
@@ -1602,12 +1653,14 @@ static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
 	size_t len = op->data.nbytes;
 	const u_char *buf = op->data.buf.out;
+	bool use_phy;
 	int ret;
 
 	ret = cqspi_write_setup(f_pdata, op);
@@ -1629,7 +1682,9 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	use_phy = len >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+		  cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len, use_phy);
 }
 
 static void cqspi_rx_dma_callback(void *param)
@@ -1857,7 +1912,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

