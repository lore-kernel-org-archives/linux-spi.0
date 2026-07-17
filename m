Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE363876CE;
	Fri, 17 Jul 2026 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314331; cv=fail; b=Fg7S75uX9b+PRqQ755G24Q4WncZSuWfjssvzp/V+/cqxCFOmWWEbxN7R7KGqGHCN5ebn7GCc8oBcMDoe/yho1397fQJxYupqNrfEkpaoWqjYr7KweH3jYav30VwOaxh5jhZb83QG6dCLThtbwjMj3BRDWf3WzaiCQRk5F6orPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314331; c=relaxed/simple;
	bh=ttBwH70sqy/txKZTDc6BvDC5Fo49FbOnLDYVolU0gEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/CbtDr4dsVSgczhmKHR797nQ44ywENszkPfyyGAqOro5Aqj7N3nNNsWvPhtv81IdTYMtKLN9E1roshJCY8eyiZsDjZjuVic407IQx03TW2ef2xEVtz5G+O0YIU3qkE8kueAtLwuaWUeaEPzUuzapUrMw9uc3MUnpLg1lVh6Hao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Rz5unEAm; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=onFda8xz; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Rz5unEAm";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="onFda8xz"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlFO63222589;
	Fri, 17 Jul 2026 13:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=tAR7iq+VvMXykEbHa93yZVIqmDwvMwzOdF8NwxZut
	BE=; b=Rz5unEAmS3SqmL2OB05y7r47QHIEBGykO/r6ESHUTVqsVHpNJ4MPJt6Q3
	PhIj60NIVgfbqf0CrsnGfKqbqysQP5xV3cO2BWlCbp/AQbTctHcgGU83OJ90PnB8
	ak0P9CbhO0HxmfyNFMGvYM3UHmPpi1fsZMSKrPbrlT6zSWKPZlrOa1/oKHcC4fnN
	vTSAUqUL2V7zRsfFrSFwgvJNbBs763ksFK8dK4NG1H7CYE7HqFWQ+Q2KMA1Kin92
	J28kUKKvV2YP/vAXIw7dxCC+HA8x22Upxffey80llQPv459oksx2EyR7PepFXG6x
	rLve5TrJkJWN5Da0SpHsxD2dBsc7w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3jtvn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:51:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5JhMLBwPVJ14+fulfIC2NtRt4MlwxH+AHUhEFhTGPqGwOTuTYH71OyoIVZYSkkZAPYRA5mjnKHRSoG8eeYiW9DSWJuvzuOuox5ca4+F5heBrx/drEBl5vnh0IQ2A+Swz5imvwdsAZj+QMDvtaP0IrPm+u6JLNu3q+y5j2KPv7WZsTBBouPcfxgMXtntO2YqF1IWqP536IEVelz83j68FqRLYOaL7q1hy+SpK8n/V+F2dgADynbAesaz01hI4SQSxQOmB8tWpsu8Df9uG9Lpn5hS/zKxwxSAx5be+hg8IGj0mCTAGbTt9WHWmR+IMnFCRvJU+PH9TEbauCRjM9DVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAR7iq+VvMXykEbHa93yZVIqmDwvMwzOdF8NwxZutBE=;
 b=bJx4/N6YT4mys0MeTO5Ug1zb1YoSFRIpmg9jRnuI/hP2/51Al1t5/dccxVnDVNutIqaO0ClfqzlXH7Z/0i6TB6qS2ryYriU/5Z262sqDyKj6aKMcmJz5IoLeWBswvJPt1Lwsb1WZECYbr0IVRJDscPmFBGR3kAg/CDA6xE5avUtzMK1OLe+Zc0lCGBXzIY6c9ydx/21oAaAkoLPDJhemT1SCbgXI/IoBGr17oQMS7/KPLmL8xZMIxsfVamoqr9GtmWvD6prwUdNpyHF1XuedI3sxEgpbF5E9WFFYjFncrb9RJXRK2qmZSAKRi12TOWHtSyeLbLwbFJz3YxLD+FMNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAR7iq+VvMXykEbHa93yZVIqmDwvMwzOdF8NwxZutBE=;
 b=onFda8xzEa+3viDXxDuzBNL8hhMT4VNc/ZpmGBXfDfS4Srg5SPcrLqGcWVhiI8fFliyWM0vIW2306HsW4eOL6L3bKZENGt0shYAJTSwVGnFHHY2mie8FWTnQ8+JEzFMJ5leAjxOpOOs+9YEMBD64ocL3eOGlPi9nm6MtOuekcdk=
Received: from BN9PR03CA0201.namprd03.prod.outlook.com (2603:10b6:408:f9::26)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:51:44 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::8c) by BN9PR03CA0201.outlook.office365.com
 (2603:10b6:408:f9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:51:42 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:40 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:51:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:51:40 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4l240969;
	Fri, 17 Jul 2026 13:51:35 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v5 01/17] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Sat, 18 Jul 2026 00:21:00 +0530
Message-ID: <20260717185116.2065505-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: c85c9f5e-63b1-4af2-1289-08dee43471ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	lvHRnrhN98I3m5hxRwdLuM4q0+aQh6hkCOBT2gTzBrlZAYEBVBnHgq+U+sLdnkbnW83lvlySag3/B20lDS9A9yqdJQcVT4MvcwTAwg8A+mq/GMYWF0EqtbKCj6uKYGqFZJvW6gmdujuL8UUKbX9zTNOjeUjuiVUIRIHf4HHx+YfHJzaf3JBXA7e5Qsy3Uwn5kKr87GNMNZ9huz0S8zCE1jBdf/suZwsWDSbY11pU1ubTPK/aOYd3pXiCbAuofGymUWuQdQMhWBncR/CPnMBC+s2OUyNSc1LXCk8Bw2f5uOvBcXK2zuMfEg9+CNFJS/Z1XmHvvvTPIZjD+qGfMwSlPb+r2PLYdJEg5rbolwZwp1YKXgffGRCDdk8KHGM6QpD3N1qHDIS7Mrm19R2lqL/E15LYkvWRruqbxSwUzKmT+Dkkqiym77xquqGHMwcrordWJS9Msqm7ObvtCgYuXKIf7RlMLplkCOZ4J71VlydDUBSeZXSl7aU02zxfxQHp/97htzAVJJe//G9JQHkgkLQkQ9TIe2+fSFAjqSfYt6bL826Pun3GRCt0xxecdm8h+pnjY7f+4xe/veBj0rVeuMIxc+ruSfBc+I9+DVZCng/VLnXc6tpgwT3cusL9zHj+lLKtGoaURD8g1Vd+qtjcdRQnkyeyqLURuZUvBhBX1zSJSWSjEfHuM00jGJ8CfPLkbqOOKAb8PnE5RROdmZBEwzaQ3sHYSQBq4JPWiHC4VT/EyYnvb0I2We3bmwxVaxNIXz6A
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nl+kqrFyC6qg/cCJMXhDnklPScsL7VO+3X3qLEkK4EQKBtbkerHKTsT7TFizndN2Xy9BIEh900zc17PZuMd3P/IGDDylRSFcCprQQbNulh7Y9+uPfzbYAVNIAt4E+Q0Xx8L8ZW5o2IOZcoQeT6OmNLvJvFLExHu5mZzT0ZilYTqi4T7TnOSZo+ur3BQQWDnUuA+GPmznRk9devTgwfebPpoKUlmCkZCczJ9doWvfn9ZOpHnFrqC4DNRyD7ApUSz1tCOYj3RBSF5TsLN2LCtkL/KB3SBIpdtsIJk1OIDzJinXa/r5vph2JCdxid44SwJwn4RHUVCbCaC0Kr/kSzKSlERpcFoMsHOVDJotprDcMwxmKF3rTuobMeW+EUEkmFreYaHnf6SRNJiEiDyCCggCj4DMfy6HDc36TsUvay/6XvzsJTl87wMcXCHNlhYuNJfO
X-Exchange-RoutingPolicyChecked:
	Sbhp8cQJGDIMQw9LsHya2TQsZZcqje11qlWvNm5zHY8pVbD1BYnVVC+8fuEHLWEHdU4nVoOnD2L3pPlMwATmqnMl5YGIdRjsPIXhHoN/pA4O5wAFVBAbzlaLx4nCzlqdKY6GQzogRZ6UHLDXUk1tl+GkrZgERc5SmBZmiLujHUxRXSWDQ2eZKq5JfyeHoS6qkyUyrnAOUf0urGve4InN2TyMfb7sBsvUy36Qsn6tkBAc/d+EGwpso8eCimrQffMpdIDQ2akhzFyhDHSxATFjuGmPAQxvZPHydOgTFjvzn94CNdiWY+eMizeDgDsJ1I27CFCHFN+CdOvLpaDWhua+zg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:51:42.8461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85c9f5e-63b1-4af2-1289-08dee43471ac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX0WQV1NlgJYHR
 r14v0P/WDWBS01Xe8A2gTk2kjrzrU6IvQvoA00SrvektMf7Jj5dKruEkFm0U+ANoc7WpA2UXEhS
 AHgwazFPL3IyA9s7pd4pp4XkZX+zAcI=
X-Proofpoint-GUID: WP_yUjVogvD60RezVV3vpRqalJ2yOdPS
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a79c3 cx=c_pps
 a=Zn3nEQaGnpTLJDFXYNee2g==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: WP_yUjVogvD60RezVV3vpRqalJ2yOdPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXzz9g71ojn6A2
 0a2Md3d29yGVKmorJh31IJWQXbPExtcpD1J7ew/cvA+Aw4YjQQ7gssZaLXpyNY60Uc5Xm9eww99
 v0VjpOHQpqIIBaWP9EqvZJJ2tZtrgsYIBw9Nf8AhyQbKKwORUll2Z11Y4+SF1deZ8Upsy/EHxY8
 uly8mf34JWbaaL1ejCtO2MdprE90MDso7qch+32r1NY0eS8lqYflNbj5gKOCxKswqI3LhAvjAr4
 ZEbUgN3TKjMexyXlMS13uMkXiW+2lUBasqnCvRg8RAIVSy6xgtbfQZDXApZ3oIS78tVsEiiPg2c
 XbTor9HNTGpfLEqXqP9+EjYCXxu89SE5gp/rIxo0I9NlXggEUPL4TPkAdfS37idgx7HiRTPrpE4
 JOO+I7gypCx7PodtlTPWFdHzrPm9RIvSm6xIf0pu9XJU0CuEO8vET1Hns8Xs9IEbcRoLJpoj92k
 mGuH3/KjlDqIseD6iqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

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
 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..12211f8c9f7d 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,11 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency-hz:
+    description:
+      Maximum SPI clock frequency in Hz achievable after controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

