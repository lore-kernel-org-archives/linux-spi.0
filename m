Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828A1A9FBC;
	Thu, 18 Jun 2026 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768291; cv=fail; b=I5ZB4XaETge+8bNNoK7uyZ+LuvAzg7MmzW73LDTUsjtUc8wdDGGDSyogg6e4YYSVspgh29dtINmPlbY6aweC9REi33HTk3UwUm2YbxkZxlmI0U3afPyG8oRlZ1XxThI8vWHBQQ5k//3518UAdwEFHYEG7wfzDnBfyImcypMnNqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768291; c=relaxed/simple;
	bh=AsVhe6L3MQfghehMSMSpCocnEqyXIhWQttA/Ph603Fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+/BOJZmfVkU807g10AGorgpglGe5z40N+Qx6avAqXn5HuglkYrUwClqmu/acXr7BqQVbhSGUNQMZrG351g+BawDLfhiodOn9TdnbldudYSbU73DHqS93ObhbHV64ilXWS9mEINusitmxwkqDA/bPqWZnZIEoBnGrMvYuyvOjxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nzibxjtE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C9LAkHMm; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="nzibxjtE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C9LAkHMm"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7XvRt1333681;
	Thu, 18 Jun 2026 02:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=0Oi5Eunr2NPE7
	a9KS09ozXY3oMew/EEn1sNEA9EHxMU=; b=nzibxjtEopM49GHl4O8xdCCsn6AWR
	8FIvelL6spa6UjaMIQLgiz4E/b4nwwpYFc5/4T5YCep8Ett9s0X9duOKNj9Y4P+R
	pNmQSWEt+Cnd0/+Mhh2PVjzfGwMpAnOchE4nJdqPPrYKUyOXuEHD3aPDls+6Gr19
	evqm7SVvYQztfUwpE4JlHaL76pp9AV0iMhcuQQSE1ah0+9Ll/CeBmpRyzOj5yn7K
	V4s50AOTjXKJNd0CEKj/BC8U13sMo7Ld3EFcmmr6FWmR9g+s24rGLV41T+p8TaG3
	H2M19Wu1E5dQGT87nko1LU/ENaonflrV7pjhpw9qQE9SzxdHWpdPu8ztA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eutvept0h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:37:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhPOd6qY3c+BHR8KZdYG9AAR3obPMvGt0NYQzyyQnTJcSHdWOSgh/fiyMHQMpJu5a1FehCmm1/1PhC1T/hoHLl3YS6aeX4NreQ7C8giGPQlJZb3lTCYGfUpoOo6VlObwKkkOajmf/zo6AF0cbi5Sxhc2XhoFeVus/7rEX29J61goZjnbEmueRdwDIuMaqg7jKPPqbzzTWplmRsdM3ZM6Ump7SP4ISwSyaxrxm/c3oWVLA3bO3BsgoIYHJGVM8Z9QfxAGEL7BS7ufvX8AEpXdTUN9B3O1AJYyu5tpfu+aL8mi/ar2CrJ1kLuUvDejAWPb/hfnffPmegW9BMt3MbQAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Oi5Eunr2NPE7a9KS09ozXY3oMew/EEn1sNEA9EHxMU=;
 b=OLL9EO9pcTG6HAlxwhYrCDwh6RwMRSAgBtv3qJxubdbisBy0ltIVJTAWsBsHPcRINS5wpnGCX4taas6Vsm36POBVTzFdw2kxK57MBwzk818cHJ8KwEbBUto2C7BWB4qfWumkH032iuUoe8JNn6IQg4aEBFcI0DMlAVocPmfhBFSYl9uocGJdKiTMf1h0+AfUhvzp9MxUCic/GViyZx8S3OqYNRkJFdKvAU1Up9O+WztEps1enAtetOGCFOMQpav1ZOy9MgjEuP6MtqzOknR42O4iDEeJI/+Q/y6m44y5F8wxeh3zeuo2guG6pwpL91Me29Zu08gos4/YiyhjUooWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Oi5Eunr2NPE7a9KS09ozXY3oMew/EEn1sNEA9EHxMU=;
 b=C9LAkHMmZ7/BiicqLAhTx73xFZ/8W34IRxXIY2w/e7lrRGGkKEVCmYc5ta8qwHnXx5FBlRNok5bx3ESWLXJ/Ch3sGWB11BuMYkzS3K/gT6cdxmD/ctLiN33gt/DD87pC22nZYWIKxMvUUn3UM6Zing0VL2VcoIhlW9iLWUd44BA=
Received: from DM6PR07CA0096.namprd07.prod.outlook.com (2603:10b6:5:337::29)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:37:41 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::2b) by DM6PR07CA0096.outlook.office365.com
 (2603:10b6:5:337::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 07:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:37:40 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:40 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:37:40 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvb3521710;
	Thu, 18 Jun 2026 02:37:35 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 00/16]  spi: cadence-quadspi: add PHY tuning support
Date: Thu, 18 Jun 2026 13:07:09 +0530
Message-ID: <20260618073725.84733-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbd8d0a-cdd9-43c2-7bc1-08decd0c7a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|921020|3023799007|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	VwTCVIhuNOixAF87DBxClx6eNCHdWSiYYCRwasoD3GyoI3RHAU8S0/27fb5aKBWcXdNVjuH8yVf2svYJh7bYzsv4WNwcRDdbDH9jnumLyxB13p151KLkm1ocQepRB5QwfPTI48Pi4WJKpgCrWw4jvv2jXXrRZR0yYx7j/uTzEUOMjGapMhmSRgy/4YrT2RJOQjjYo/MXSBqUHwXpBb4PMw9hikCWhcySZYpz7MSfSUtP8d1ygeKnHqBbgCZ5EELtZYwZf4HF0toK22eyH2qSX0NzyPzWhytT5Nm2cqd/la597TxzsuvGyOj3cSSY+aBqA3TYf9XxrtThNcDbD6T9+tAQpK+iRjCPofq/zRT7JJdcQs3vcIzQ1HcMUDcZ9dNjQdDFKvQSwtZwim1y4beE9SqICsWs93z/Xf7hDigvgZBA/NznFQCl0CemRLNkGK5cba6EYmNz5susnq9/8GOiH+QsSTAmRb8jp1OIC9SjUbbcw1Q8SLXJavRIGCajJQGUcgl3tLZwIyN3tggyYOtGo4DxA+Gh/zu4mIFNXbkJrBg1Q2mWKvK4snNreqMy6h4wLYlItHq1bmAdLlTCcYq7a7WCRiT2c2SvWKZrYJBCLOJBDxe7X1DvuNitVYiNTF6RhWYD+jjzPloT2f5piwy9HduWC+KG0iERw9VZ+aeiyc/hISxkau7ze6H+qax1//6QxKQjNSBTTI4hX8b2FceS8w6oSWBMQBM850r7J30Y5CH0sVoBrbZNTe1+AfJZSAb4lP6M4dHcoz26tpAWZg6vpQq+XVkyiFVgbeRhhYiwlsw=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(3023799007)(56012099006)(6133799003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3xF+G15CD19fim8TVCBbfT1pao4w1OJ7hb8iivTG+AY+6Hr2e7u7umoQa3MAmG9VvP98W6a7X0A4PKrlIpgnNFf9qqMVQvN/+56SixlxZKTD7a/bVmM//LtlA9mjLnpkV+MkJZ9iksyBFaMnx69IL0ldyXC/WsQnZ4TLgyxfJ7qmGLaP5QqO1X24JXZOvWHVVrxG1EU3GTFiBEdsR01d43i0NrntjrpEZabMG1Zw/QihjMWOUCdHbJxpBNxrN8P3rj1vx3HrqgveC6q1/cf4mmnmIHfY53c6HTuckiU/m2kEj9D0fMtPGEmxZMJ58kWAVvQUGDBwaLIg8lGzEMtiEQ2qsYS+xPstZiam4GJZ56sHuDPc9DAS0Uwy6LeksgCF5aOn+KQrNAEHyJnVLIMW2lhaVj4CfhEYUZq8zTdBDsfBN28+lBtJ/Bu24gvysWqg
X-Exchange-RoutingPolicyChecked:
	nIVFZA8N2LyG7uSomfxdSSIq0F9bi0IXrvL4ovAacwSPadQBTQJ/XA9Jd0hyNXGT2/zyjF4DC5OB7X/b5cAl7REHIq/PH7vr8ShOXe++8ZuwW6B1pagbfWgEdRXJ41GVAQbOShhPtyGUIt6V5u/F8QCn6FdeRFNcSspAFA2TaIzTkiwzqmT4e8csNd2WvWbdw9V07cuiVPaEYolUbjq4RlzTmz4kWIVPg0GBsGQ7g2tjvE0He2e2jHgveTLu5bNdjlfgQu4Y3Kseaz9ki+JmKOJmrxhB0iAZl9J8b1zYeUT+1ayizaGjCS3MW/g2nwqgoNqhGTZyITNn/xZ5/3pb7Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:37:40.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd8d0a-cdd9-43c2-7bc1-08decd0c7a6c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997631
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a33a048 cx=c_pps
 a=Yf+1g9CPtaneS6NJHGTLjg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=nERwp8zdEkyM66nqGi8A:9
X-Proofpoint-GUID: zTxXQLYF0iNCgu89040-hMkI9DoHBaBl
X-Proofpoint-ORIG-GUID: zTxXQLYF0iNCgu89040-hMkI9DoHBaBl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX5OC7KcBOdv3q
 OxNxMAWOWAKUlOyV2KPQuljugboh6wxPx5STNE8tz+Ljphv4lbx0dVPohjKYUuQqPtisIY88nl8
 FYce7DSE+Cv4HqNEpOFue/ha8PZuFgg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX6zD2Ci6Mnkjc
 W0I9qOmvAi+Xy5OkqYhOseGJh5xdsbkPz71katxUz4gnEnW9OrAaHo1qkt2oo7XRVRFGzryIe4E
 sxtRdPkfjp53qxa8RHvLhVoOdGdY8EP3uqBOU9dVGyuZ4E/2aCrXiS6sXFc9SdGQdopcPC3PK80
 rUvU1/KVt34tBgDHKugjWXFvt9eXz2kBiSt3OcYp+w6jQwvdXdtvLoR3jyWaWng77yCwZeT5wxs
 us1Ly9fRHuCvSFsSxH8Zp2GKdITxs/xMq+KEBK8E6ZS73sElcKOAUhRxytmGuGYdD/v3EpX4+bA
 +/Sb3EIRz3Pr00qX7sygGkDIb0NKV2/NdRg18rx7/o/OwR3mMLWX3RtXVMyHAiQtcJ0z057I87p
 voyvGHK/BUxSiymo6bnb5ZBg/iQTSLVI19st05nzxL5x5D6VmkJXWOcRMSWXMcx8noNOAPPH1nt
 K/zsKGFGhldMXkZBS1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180068

This series implements PHY tuning support for the Cadence QSPI controller
to enable reliable high-speed operations. Without PHY tuning, controllers
use conservative timing that limits performance. PHY tuning calibrates
RX/TX delay lines to find optimal data capture timing windows, enabling
operation up to the controller's maximum frequency.

Background:
High-speed SPI memory controllers require precise timing calibration for
reliable operation. At higher frequencies, board-to-board variations make
fixed timing parameters inadequate. The Cadence QSPI controller includes
a PHY interface with programmable delay lines (0-127 taps) for RX and TX
paths, but these require runtime calibration to find the valid timing
window.

Approach:
Add SDR/DDR PHY tuning algorithms for the Cadence controller:

SDR Mode Tuning (1D search):
 - Searches for two consecutive valid RX delay windows
 - Selects the larger window and uses its midpoint for maximum margin
 - TX delay fixed at maximum (127) as it's less critical in SDR

DDR Mode Tuning (2D search):
 - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
 - Finds TX boundaries (txlow/txhigh) at fixed RX positions
 - Defines valid region corners and detects gaps via binary search
 - Applies temperature compensation for optimal point selection
 - Handles single or dual passing regions with different strategies

Patch description:
Infrastructure (1-5):
 - Patch 1:   Add spi-max-post-config-frequency to describe maximum
              frequency achievable post controller configuration
 - Patch 2:   Add spi-phy-pattern-partition phandle for
              NOR flash PHY tuning pattern location
 - Patch 3:   Parse spi-max-post-config-frequency in spi.c; adds
              spi_device.post_config_max_speed_hz (0 when not set
              keeping all existing DT fully compatible)
 - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
              op->max_freq equals post_config_max_speed_hz, return
              immediately leaving op->max_freq unchanged. All other
              ops are capped to max_speed_hz
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core

Cadence QSPI Implementation (6-12):
 - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
 - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
 - Patch 8:   Add complete PHY tuning support: DLL management, pattern
              verification (NOR via spi-phy-pattern-partition phandle,
              NAND via write-to-cache), SDR 1D and DDR 2D search
              algorithms with temperature compensation, AM654-specific
              execute_tuning entry point;
 - Patch 9:   Reject 2-byte-address DDR operations via a new
              CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
              AM654 OSPI erratum i2383
 - Patch 10:  Refactor direct read path for PHY support (preparatory)
 - Patch 11:  Enable PHY for direct reads, split the transfer into an
              unaligned head, a 16-byte-aligned middle section with PHY
              active, and an unaligned tail
 - Patch 12:  Enable PHY for indirect writes of at least                        
              CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes

MTD core (13-16):
 - Patch 13:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best() with a skip_mask
 - Patch 14:  Negotiate optimal PHY operating point before dirmap
              creation
 - Patch 15:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 16:  Execute PHY tuning in spi_nor_probe() before creating
              dirmaps

Testing:
This series was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash:

Read throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NOR (8D)  | 37.5 MB/s | 216 MB/s  |
|----------------------------------------|
| OSPI NAND (8S) | 9.2 MB/s  | 35.1 MB/s |
|----------------------------------------|

Write throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
|----------------------------------------|

Test log: https://gist.github.com/santhosh21/fe98754e52970287eb9011154100b62d
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v4/

Changes in v4:
 - Add spi-max-post-config-frequency instead of extending spi-max-frequency
   to accept an optional second value
 - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq() extension
 - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
 - For SPI NAND, execute PHY tuning across all operation variants available,
   perform duration comparison, and select the best resulting variant
   by taking controller-specific restrictions into account
 - Move i2383 check from cqspi_supports_mem_op() to cqspi_am654_ospi_execute_tuning()
 - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
   cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_phy
 - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flash_pdata()
 - Extract DMA refactoring into a preparatory patch
 - Rebase on v7.1
 - Collect tags from Miquel
 - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1-s-k6@ti.com/

Changes in v3:
 - Drop spi-has-dqs DT property; DQS is now enabled automatically when
   the selected read operation uses DDR signalling (dtr flags in the op)
 - Extend spi-max-frequency to accept an optional second value forming a
   [base-freq, max-freq] pair; the presence of two values signals PHY
   tuning intent and encodes both the conservative base speed and the
   calibration target in one property
 - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
   two-element array there; single-value DT is fully backward-compatible
 - Move frequency enforcement from the cadence driver to core: new
   spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
   the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
 - Propagate the tuned max_freq to dirmap op templates after
   execute_tuning() succeeds; store persistent op templates in
   spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
   frequency writeback survives across the probe call
 - Replace NOR pattern partition lookup by name with a
   cdns,phy-pattern-partition DT phandle pointing directly to the
   partition node
 - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
   ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
 - Remove RFC tag
 - Rebase on v7.1-rc5
 - Collect tags from Miquel
 - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-k6@ti.com/

Changes in v2:
 - Restructure the .execute_tuning() call from spi-mem clients instead
   of mtdcore with best read_op and write_op (optional) passed
 - Add compatible-specific .execute_tuning() call which can be called by
   spi_mem_execute_tuning() if exists
 - Handle tuning requirement check by controller instead of spi-mem
   clients
 - Add support to write the phy_pattern to cache if relevant write_op
   is passed or get the partition offset which contains the phy_pattern
 - Add tuning algorithm for DDR mode
 - Add support for DQS
 - Restrict PHY frequency to tuned operations
 - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Pratyush Yadav (1):
  mtd: spi-nor: extract read op template construction into helper

Santhosh Kumar K (15):
  spi: dt-bindings: add spi-max-post-config-frequency property
  spi: dt-bindings: add spi-phy-pattern-partition property
  spi: parse spi-max-post-config-frequency into post_config_max_speed_hz
  spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
  spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
  spi: cadence-quadspi: move cqspi_readdata_capture earlier
  spi: cadence-quadspi: add DQS support to read data capture
  spi: cadence-quadspi: add PHY tuning support
  spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
    (i2383)
  spi: cadence-quadspi: refactor direct read path for PHY support
  spi: cadence-quadspi: enable PHY for direct reads
  spi: cadence-quadspi: enable PHY for indirect writes
  mtd: spinand: extract variant ranking logic into
    spinand_op_find_best()
  mtd: spinand: negotiate optimal PHY operating point before dirmap
    creation
  mtd: spi-nor: run PHY tuning after init and update dirmap frequency

 .../bindings/spi/cdns,qspi-nor.yaml           |   19 +
 .../bindings/spi/spi-peripheral-props.yaml    |   13 +
 drivers/mtd/nand/spi/core.c                   |  246 +-
 drivers/mtd/spi-nor/core.c                    |   80 +-
 drivers/spi/spi-cadence-quadspi.c             | 2265 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   40 +
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   11 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2493 insertions(+), 203 deletions(-)

-- 
2.34.1
