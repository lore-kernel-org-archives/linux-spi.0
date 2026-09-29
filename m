Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40F437471;
	Tue, 29 Sep 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663816; cv=fail; b=FHjZ4BwusZM2xS9LfiHYTCY5VEnLOLkjfOxCgPMsqqwQMqxo+RFkgvtNAZP8hwsVVMABigDgZiiXcbK68FoEg8aHmPgtfbIQrouwR+2y+1PhMBp3k9OnJ0IrIRYUCjHbXv4MdF58++tEd6WZP6D09PKDFWaaTPif3TLHAd+GOTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663816; c=relaxed/simple;
	bh=TBVwFCWywbzE+MM6sLLvtAlvbm5pg+rK5ej825XBbdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTvl2dHoCA1pLEhOS3Oesb4Z5ZaCblBjddrweObyMEjYYrgiLBkh3oN2uYWuZx7NqPg42sO97oNVBtV5zQADL+LICD+JMZo9IQDZTAHYb7T8HWyRl8DESHJNCy/pyXhjtWoOon1bsvE6FcTOr3T5hEIfV+fS2m/AI/AIfFcOuZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GeJD68Jq; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=UzIjjVHh; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GeJD68Jq";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="UzIjjVHh"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46EFS3557303;
	Tue, 29 Sep 2026 01:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mZnOBa0NWZVQX5xUB6hzk6kVvFIUsSMdagSWZyQQv
	Ck=; b=GeJD68Jq0PtPGZSvEqrZrsQmrKQ4wbvHCvRrtjVNu9/cIdqDvFvwZGP6t
	PSameizl1fb6/wwFMBbvNdtjp16Az2Zo518DeE8iteypd6NKVXkDR/6SaYPBVQZA
	dfOiguVk9u1qMUOAJFIpf0u2DZm+kD5869HGVMd9x4vcLthT70x/kEzun9nsUVOq
	M6AK2Ul5vJeRWBrpRUVCknfjf/Wez3NNcIIYETAyp0sbeJzGD2yfbFt3QoJCd9g1
	rgEjtr52+ojFTtE3Ph+zUk+c9bEpHXk/Fow6/M1Zf1uqm313VmQ4SlNHSlGyatG0
	IhyQmU0DfpX+B9QGP7AMOB77ED5RA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gyyjw32yg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reQ+E+w5YpAgCcnHSBhClqOr2LOtSU4xe8jCJvIjfO074bYDIqRxM/aSPJRl30rIhDHT44m3H1EMUfazbb3vLMWVjwht99+BAYKbIv6sFZHKWA4pq7KluDzGxJzJjTt3dIuLr29Ws2LQqEimBOz6+ENw6UFHWYRvRNVnQMQaIWpZ+KUbiRahhOztDo3MqXJmXxY3KmXRon/lCuZGwgtqYmmlpkhf77iSewn1I6LFAMkKBm5j3ursll/TorAs9oJJRw4/kKT2wfehFYDjDGIaSCodGdyHrStjKYi0JHkHUP107HfkfaLu7u+YdWTXwHpmx04/16NKZqx4yfVJUaAHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZnOBa0NWZVQX5xUB6hzk6kVvFIUsSMdagSWZyQQvCk=;
 b=lB2V/vHC2bStF/XRaZ4bxBTp1dQfMZjngUEaOiq5/mucaL4R+y9s/fKOanQweLtsDv0XH4BE9RKdJNmGBucPiyAmZ7z2m1+CjL55/mDFz4jqTVIbIsMSHORgvDPRysg/tIApXI5PDEV+mPssy7W258XjQkheOxn2JG9OprFjdKF56EvOInYOjlnANEsI8t0ODKN5QmEmkmrHWzTofelVO2sTrOtoP+b4m6ybbGGtRuxmovckQuEYm9piMmhxgOmfNEnFJZVFmWfV6+NQdWYkyH7N/rlearE1ijifwOqYqsQssWDBdkqkh6A0rvb7dqLwLkMJay/JXTKH/iVlqBa+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZnOBa0NWZVQX5xUB6hzk6kVvFIUsSMdagSWZyQQvCk=;
 b=UzIjjVHh/Y3q4XXBf9KuxxcCvgreG8rrm0eGkpghyD75VnYQ2Otnmx+pm6IQFnaY07zfglPGLZNPuse7pT3F42L8+neKyloTPO9iTodSw2/MiBjIrUYetJ2UZQt2UUy0ACHwW5bjnEulDaopxiihvFjZMAnD5OjgV/quI5eqMA4=
Received: from SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22)
 by PH7PR10MB6966.namprd10.prod.outlook.com (2603:10b6:510:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:36:21 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::87) by SJ0PR13CA0047.outlook.office365.com
 (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:36:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:19 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:47 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:35:47 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn11395904;
	Tue, 29 Sep 2026 01:35:41 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 01/19] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Tue, 29 Sep 2026 12:05:11 +0530
Message-ID: <20260929063529.1235417-2-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|PH7PR10MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 282c30c1-1321-4ca5-9a31-08df1df3f892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|7416014|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Lr2dYEeHGOqOJe2Js0ILHh+zfeMm3g/Dj3AC3QLf0K/LgYlFTJyAPesD55/2OkoCMp8yVBvFTkARnKViFfb8vtXV1XQWbD0VM24Y/dxBO8pgOupiwnqQrY6kgdO34S1O/uxFGJToA3PtB7XeG8ZZKsh4LUum3j1Hig8PQHb1DEuG0pE/D4asDOtFnnln9S1xavrbRVFO1xEb8eTLwsH/xVhOAOgfSbqAWm3tJ6CTxbUGT3UYJU7jsWd3/8B6DhIPFkegNZ9LlAZ6HJR4/5rTZYqUIACUA+2S0txXM4XPtnJIpEGt/mL3PMPrbwo7o0v1yIi1/fxc6c4YLQeFhEHH9AX0KxWsKZKpKQmt1AR9bX7NHCLkXGAS6LfsW7RfOHDjq2f/NDtw9ItDOuihGjZe/q07FM/4clvSGFearWDodgRze0kkqfRRIxH80qjclNWRu3iP1Lk+jH7sWct1c1iZcXUPfTjnk3OH0h2WvtdgJ4/iiMDeDULCZDyscKvQGvgCZzmgAf4IwAA3kex2B746Cqk9ymL0zmGTX34dFDuvRtwDt8fbTuIT4jq8uUOqWAF3XQcpHxyUiNHv1OhCdXnmo0y275cBzkwNph+U8q9Az6X19jfniumQ5xiqXpAYJN5PPlFgxYIvQakPDietJBoMQVu7Qx2boQZlfJLgRtk1XO76aduZBVAA0hdDF/J+1ddXgvTMrMw2GouW7V1K4I87UAp5oygr1bq229Ps3vUycmm72G8CrEwxjcc/secC1sTx
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(7416014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UqJcpsl32+9HbP320eMnAMY/uwnAVcv921xkICFH0a/jow6+gRZaKFG/sKB9B73IqxTojdFSwtbevXFV5S60ygjC89Z/2D0V5bGHPsPVEIVQkLUoIeb2kBGQWEMkJbl/Q+zZfAGYrsglwdh5WRpijb7byJO4jpzpiWWvFP2Urrj9oLAT/o5kgRuA6dSlyOyy8oT+nsvup+qs2xQr39/tksrs2IV51CeKfrEZ2wdymlSPnU6BlDFVJtBAkoAeuI9Q00+f7VlR+OIk0/Om6js/Fu3SdCZtSpCB3g8qDK1AwIlZKW8z9uZ1uAzVkOK6oUwCusy99yNNNapibFrJaEf2y+tVJ4iaOX2Zyqhk89Q69PWloT3rphuvSHbVvLXWog2xb2E/7NhqpJ8w8AJd1B8w5IxxdxSkCZR7pCoHJJMHbnqBdP5+k7IZQzm1KOfF3FvB
X-Exchange-RoutingPolicyChecked:
	kQNtYr4gMOScEVC4M9WTMoAjG4Kqb/UXDb86yd90pGqi/T07XghDpG5MYR7g6UzpDBbY9j6zbv5kbJYB+dUsdAhadIdUpaz6/XnjsoXdiccT16QK00OjniyVRlrW7CWT4uB5h62W8rsw8SrMt+oxxS/gce+tNj+3UkMOWZ/A1qCo0LFGWMEutweMMlsmPSe0jSO9kQJh1eCFZuVQ+bZ981W0S/hk6tWqPGb/Cl1rlMaj31NkmV1tqNL2PF9iE7/LyxT7N2FEzG9ERCh8JUDkYGqqS4BnmlvYx80mGEXXsHEBFb3Sk6pkTgWRSNW2qFsyDA0TRvgtLO3dUAIPINV4zg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:19.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282c30c1-1321-4ca5-9a31-08df1df3f892
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6966
X-Authority-Analysis: v=2.4 cv=X6LHu2Te c=1 sm=1 tr=0 ts=6abb5c68 cx=c_pps
 a=Q0mMAVO0nY0JadJ+SMvTrQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: NAXN1TXsxyQIkOm9mElp3fxemweroV8P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX1DC0Rsg2G3f6
 R+FVIP1BjOzkqvYzxMKYAtpTlUhVG8bFmi+yF+jHoYNHR35jtg9ukUHt76vD22AYrQ/IWRXEzI7
 LKgDl3U2CKYpyctGiFi8JD/sPR8ya1U=
X-Proofpoint-ORIG-GUID: NAXN1TXsxyQIkOm9mElp3fxemweroV8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX4Qv4jobsrl3H
 Rpftl+5zT+TOj7skjDVASSRZDfCrGpIW4d/o/RFrtDc4ZouvUuniuJlMPYImn8dMJlWEvA15i+T
 jFyb7UGBx86IZLWNRAZJfhjydhCfEhgulFZpiNQkgr/zhBabJB8+aKBfx1c0DRooMHX2Q8PWHWm
 6x9AEyulNIxQxHWUhdxWgQt8R/+fLGsu111uc0xW0hkJw4YZ/6LptDReREequwK+zBe58VfejQq
 s8oI1ujy6gbFidgMRVpm0HkEk1iKH12SRlZ93D8RP2X1H2g0Ss1XSBxmPuDogm6dL+pk+6J4IlG
 YepIMqrS49kwwYlnqAr1U3oHp/LrhJcv0yZKWcj+n3Zs0oe/8GSMLXr2fOnxinLT9Kmd0cqD9tZ
 tMA5QkIhH8kAB1JBy7ExmtNAU7cRmV9kRntICVlQ/0KDjp0g9zmxfXtgn2NydnzfcXGQa6n2kc7
 hDYZLkuF3oelHsGeoWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Add spi-max-post-config-frequency-hz, a generic property for SPI
peripherals that operate at two distinct clock rates: a conservative
rate always reachable without controller configuration, and a higher
rate achievable only after controller-side configuration.

When both properties are present, spi-max-frequency gives the
conservative pre-configuration rate and spi-max-post-config-frequency-hz
gives the higher post-configuration target.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index b3ab89f70df9..dfc965500744 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,12 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency-hz:
+    maxItems: 1
+    description:
+      Maximum SPI clock frequency in Hz achievable after controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

