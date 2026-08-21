Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6447CC97;
	Fri, 21 Aug 2026 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312989; cv=fail; b=P0ghE9nGdWqMbtJP3EfOJHBp7VFThIJUN9a68DYB3aDqZ2nhHx3ihKnEQ7dpI9G+QOQ7NJv4Y50WzvUiSQ25xQ14serewxLJ+vA5mMC99NnQLusmtGZ+NfKmeDm3T9fmqa1jrzAvx4nsrKquMLQ6X6H+I2J3M2WrTGKVee8nJoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312989; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0rTlbIfi6ULrozjCc8tc7kEJ77t7QWV54fKE7IIgERESylyNDYHVh0uS3CcOaJ28jWC49i4T2XswpnASU+1YzhLq6k96hS1t5WStBr1cs49q4Ku6tJJXbEhDzpY9H9F7x4M+vU7OdXhiiC29Qt2YHWJO2dz9ei2fQ0LMD7X9IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=m1hZ2JTS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UXokbEiP; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="m1hZ2JTS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UXokbEiP"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9KnCu3056096;
	Fri, 21 Aug 2026 06:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=m1hZ2JTSXadfjIxkyzEu6I2d0MVpXw1nPb7UUmVseWtzofAGWGtlY6JSr
	KuJRlRKhhIO9c61k6gnHrh4AxSNpbhP1HupXr2S1w+amQxVRaygz5TIOvtFifk9c
	4727gSTlZdyLKl5u4ki4OT3y+YfcvOQW5sycb9k/WUHWtA3dH3FLriRkvcl/0z6B
	FT7r+AAj67IdDOpIK71Zs45iLicywK+fEpDXFUB97le8HZzWS3IzgZhdbuKh/eJv
	qmILHzzbmXuBuEckhRWA/WExHRdwE/dwvVsPiZyQLRglZWmY5+4aUFKDGGh+dp2Y
	jsWIJZCMo7+MbLkXDXVHomqTJEPjA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g6c9c2t0x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqHXzjWgi0SED7pYYqz+lGYHgbo67F4Ca2mAwWhMLOU09vwq9txkRm6xvzbBefMKYQ67uZPnUv03hBXdYV/t24bpNTJgA/+Kg/Qf39N0eBqlVNCjXDkYGBNHbxnUOuxJS3E9qLNug0CQeFzcoJDiIDlrQsaIjRoyc2UZHyrVUmkUPSsSNCbMabcnXMheTE+9IDASYlsg1+Kw36QZYH0yVmbqoCIJvXwk3jJcTlEzfEvvqVBPIsiFV4pHOgApPyfGu5zCtxnT6B4AvuaQizG2tWFgwIA/XRnBD4OmLr3B2elJ2kp4X+aLevI+IyvELX8/xkosXnSbqWqTOUVPpbVl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=xyzUfl1QjDM6qvt54B4YugYBuJC+g7BUvynbhHU1eGSAnB/7gOfO8vUiPrZbz41VbtKU4uM9vCwe+hv70q1Cml75hC5ZgYLW19j4PNviU5Xx5dtpCas8hdGmifOm6Vtv+9VILNu56qxxdiBEFU7rDMsg6fXUodL8g6LKxSoanw0QyztYoKLS1zBKSy3QeOquzloZrYiKcpLDRgErHKkyPvHqRLdgcJkIllAsPd6iHvYzIXKpdqCbJI3VdQlUz0ViexEzdfmvt2KNJeZ+slcbjF2HtA9/i3WQN8TTLEcO3gzXgtzMgBMxHcy9UghqAVncSFgnZP2XAz4gsxEvhgnjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=UXokbEiPWYagxJ+uuY488XZ7Oz8mip9WKUFlbyDHQT+dWSO8J0Hu7FCC0s9kAnNNy+biJ4EuvsSXkKFEgJ6Q7k3UIPWV81kfLHsIupa2Jm0Mvhx4dd1Ig26tDVbaKuMNP3OxGVokwHgMha4iP24N/TgxUm2BsPdnhoRKHn9whaE=
Received: from SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19)
 by IA4PR10MB8471.namprd10.prod.outlook.com (2603:10b6:208:55e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:16 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::6e) by SJ0PR13CA0194.outlook.office365.com
 (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 11:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:15 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:15 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:15 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVli2022942;
	Fri, 21 Aug 2026 06:49:10 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 07/18] spi: cadence-quadspi: add DQS support to read data capture
Date: Fri, 21 Aug 2026 17:18:11 +0530
Message-ID: <20260821114822.4040338-8-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA4PR10MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: b71bbbd6-029f-4d2a-10e5-08deff7a3a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	4AIMtUKi9q9mNBimIuDa/3Vz865Oks66vpuvQn7mc1dD3qVJg3A8CLA04QPsxhrcZEXJc/PNtZ6/ltJdzggkkXcCqghXSJSVapoh7zuyEp/U9s0aBiKphc18mRA4OH/iaP86F9m72lSzzz0wsh6R/1NlAq0poiVqh8B8fqO3ngq3eI+LQxNtRVx+n+03ZIie3Nm6xTvGEwk9ur0aBDiB5vx4a5jsuhitjICh09m/Pgikz316OIC6/TAR3pehyuJikDJ1ymJEs9i+OtPe0qccn0K4rl/W5eNYDCxjLGXZtyIutuJv3hm45nxYZpzsxaSkBTcYxp2UKIeIwCBZL+kNBA2feOXHbX6T0XD3LIDr8YHF/u6a1G/i0qPJsxv1R/0SZ6eCu5ahtz8eHZoqC4brqtrqaTxPUydSeMvN8wNKvLI49eWeBfos3Yl9OpgWUJoe880JhP5Ais9Xckb36JCiim9N2y99cHPPgxvn0BfXJ7U+ABYAqOtddI08JZIp9AhdPWzGTGM4kDYzmJ4hOZcei909I5DBk59yu8U4E4XG6VZBmOHfYmBR9INdCNwuEdVk8X603d+f0pMZI9CiqhiDsVylycyJx+KA3GGAMbWxDZcBW6PvcGNP5yk1o9rx4E5YEaf8ZFSTFpN1g0K5oWHy/iqjBMoHbnT4iA8apTKaoMWRErweFHEKoPeQrx16R9wT9V3nU01owgAA88dHKL8oamPlHVP8LAWLFJcrhOxqMrTl83mMVGdF5nsvnZ0m59ni
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nPN8ryrxk2jN8eX8GI3qbqhzHBahEWYCemOHjwSa7T2+mrI4G8BR1sSmSywibyFmz3fWy6608wWQ1DgBcdsBagzfFtvWdrv99G96IAxeM5E9njHwjJiwzVgofb4t7wEYN18gFDXw+v4GVf8DS//M7t9ROdJHL5kbgipLMIPo8eT6r9992dLcDdpqWW5VvvO4RmnwBriH9WskcZHPu5u1OhXQfW1naX0s1bYIhwhgIjvRFnBRr0j/P00D0CRf6vUBZl3WKuu/jiTbCCVyyK1tleF+4vSiJNTTDhz+wVianRaqzjCpILgyM0RwRHP6EPUnlXBzT0HlVqa7OrISMALzwSOibmSNPNdw8lIMMoqJZwU1L+7TFTFGZVdK/34H/iEwUVxZPAQS2814A/2mmpIcuQsVDXHbnUMPBVd2zGyfNEz45aVDC/HZ2B7RSUVokH44
X-Exchange-RoutingPolicyChecked:
	TS58fT4caH1aSXSd57ycLd1xiJFbE9nsvir3CyotAblsbLhporfsXX7t3glwWFpnhEME8LzEvxH2ClJV1o5ydmg3VqFEiS6IVzVDyGNyqYFZEokyxrHSUqQgXLtcP0raUYwHzIXHLLf08Mgyew6F6PepEu50JIMWX9V3J8LpoogH6hk6hu6WnflLtXc/fvcqXvdIDagOm8LPwSOEt1eLV+g3dyd1UqmE5psZNX4Kga8OR1oANvZRRXyKlA3OX4vlyBgUy9/2TgdHuVCH7D0looK+slRCBGPPQKBdM3pHeBGE1H+nkL2XDtU/1i402Abu45V6Dl2pdwlqm8MnUtAzHA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:15.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71bbbd6-029f-4d2a-10e5-08deff7a3a14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8471
X-Proofpoint-GUID: CIL5f26xvuQTDNk9oE7LN7JANKNkPeih
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfXwebF2VhedOLX
 z1HY1ihqS5E/d81i3txaw6FYm9v13Hlv3JP89RQu5hfkMKLwHV9s6pNwUQqQkreqNS5qbOYUwNs
 SUi0UKkGViLHa+HNyHEjy+k2DthOEo0=
X-Authority-Analysis: v=2.4 cv=eqjvCIpX c=1 sm=1 tr=0 ts=6a883b41 cx=c_pps
 a=zrdfMquBAX+f6GZXohoIpQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=by1YfaDFVIW1-MDklf4A:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: CIL5f26xvuQTDNk9oE7LN7JANKNkPeih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX8l0NmG2taehu
 Spe71wEuzIocz2VnE+zrD7z+qfA1cCqcKy7xE6Ey3fQbiPSPqcJbZBZr+aZgsciZCvJvLb743bg
 MIZoJ/56gyiEmUFNJ4QbsnpTx3fYvtjBS+d7ri7CevmeK0mpAbDQkjY1fyZHFi6WNoEEFBmd0Su
 SEcUai3sSRgVZbio9cT6HyXxzJwgGH9ohTVSaP4VM6YW/koUFMt2MzwbSZHut2R3BaWA1NwHxtR
 G6O4JLWU/lU+zXOLRZvSEYJujgBCNudjzjIy+omdSt+Ww+hnJ/otf5N75NYjFd21AjgJFKiug8f
 qFBU0n//zvy/qnB2c9DeWC611HbleNBtS7JPoFBrT+ckdhSacbaSycyBdCBsZ2KGHQQ5oS736eE
 8qqKSIBUpqhmb5dRvha79uwwzOPJpMxCHFlyDh4AmzinZ6Yvg/dUNGSvBcQ5FqGNubr+MHdNoh7
 +8+K635Lc2SkLz4lL4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210089

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

