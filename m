Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF475441619;
	Tue, 29 Sep 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663787; cv=fail; b=NDsRVfW1FRcrCqlVm6Db5UGb/YCkg/4+i4Ai4ELuyOyCiQGUlT+ZmRsJNgfpP6R/Y/KDpUe59Titw7FZmaY5+VE812/YGuWDyfs/GeAj6TgDRkGkDiqTZCF3tycpR5EukDS0eTFWQEbsEleSRqkwP8/LJulW+Th76MJfHcpkAcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663787; c=relaxed/simple;
	bh=+XPUzr0TsM3g693Qjaf+myE5eegyjc5fkD49VwwEQgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MgOW+0aiKuFqvcBd0R+kLKhFH/4vTzC0d2T87iCQFFgbyTYF0oeQS6wvTWKO2KmlzFBUcy4oVoboMb8A5KVINCV+CmhJBidKP7wQegNOecd+JMXe3BouNsRj3LqfoQuKP4UpIxOZbfHnAcZLlXYg6Ly27vEoVBXyLFC0pueGZ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=da0dGsQd; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=mGZVHdK6; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="da0dGsQd";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="mGZVHdK6"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Pdx3787043;
	Tue, 29 Sep 2026 01:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=4Ue+a9TT4Wqec
	0yGAT+pP//JySdJfJsh5qZVLAjBSwM=; b=da0dGsQdgG8NPAxUEZF+5WnjcdiLV
	BQYcgqh1+OUZ7GHUXFZqMFIR4jaWTLtpRZ+rNoyGfyCy8ejSNHe9ZAqnf0t4Chn8
	nSi+NcphE8ufSWncCCg7SkhQ4edgYNGTKrVflD7ATKGF19WLIAZlf6Eer3nP8dDL
	Uszex8a9ZA4o9D5fpd6n5pMTuajm2vDTMWJafTqsbHWBMhdPRwC4h4wd/V66c5E8
	dDH7QQnixLa1XeIH+aG8inUq5RarglItIuUWVR9V3xE0/xv8BBR36g5Cg11dXEUE
	4iHsox68vbVpPFCXpaczMWyY6b8alIyyjKlehH+9HaS6loWezaE89Ac+Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h02grj006-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLC0FnJ2xSAyUxJA97I4PMalMPhmpFSJEQ8kZEYb2wcfEx1Qeug50xo1udV9NOBHiNKM3ildEieyPZuMh8YQeBZ9yAKf++i6lDD+EoFXhJ09/FO3SQzAqL5DfactJoAmNAHdrNO1aCRCQ8HPx1e0nJ1XPtR4tb3pOWYk9WBG/e7J/MAdZZPsix5ahfnllgVI8ZfXykdl11bqhweqd1DBfj89fRHEdMGVR4S2SQHE2HxwufxLp14J/h1mlxLIev871jufpE58f337ycBMqhMr6HkgNCNwUS0AbMyejdF+k14P3LJc1YRIlJDHi6WgTPXso3LeBYH8XDqR7woDrEtwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ue+a9TT4Wqec0yGAT+pP//JySdJfJsh5qZVLAjBSwM=;
 b=tCwb0jSXvf7YXTt9t/RjpA3mgPYZAYFHScfXAHyHofQ03NuNAcXxiPQHvOSGjOI14n8b4pB4wl2PPOiRofXwILtxjlkRbODEI4eLgdl2ojyR9Fg4rtFaypDlYQLs3XQFpqqkRTd1SdiOIMR82HjspFaCzNsU8rXNEXZORYGxDu56kRTsj7Cd/OogNujSfuFBryYOM3qurS7kDo7gVDp65BfHcQdVxFoAbyMIkX1mIOZZt0otnGPuc0WLakAQkdFkdZjbUCfy+poTIpuQzRMD81GtvndTGfCQE0J0gO/M0rH+kC9prBGdDziSbN1NFiNxR/k/bS1a37y8K640tlS9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ue+a9TT4Wqec0yGAT+pP//JySdJfJsh5qZVLAjBSwM=;
 b=mGZVHdK6etzJnHUZW8w+8x3WdSGuiGw9kffJQBe5PL3xymqat8O8fLnd5t6ChwAYr0mBIiKSSZTgdS5MMvOjQvadHdt+E2j3L9hR1pexqsLdBrGXIPRDxqAzmDdTaQjvQwKUfxOWtEAVzyW9IEd1BELcbwTsj5/rc0ShKKTGU8E=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:35:56 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::32) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 29 Sep 2026 06:35:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:35:55 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:41 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:35:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn01395904;
	Tue, 29 Sep 2026 01:35:36 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 00/19] spi: cadence-quadspi: add PHY tuning support
Date: Tue, 29 Sep 2026 12:05:10 +0530
Message-ID: <20260929063529.1235417-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5f1328-faff-438b-c439-08df1df3ea82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|56012099006|10067099003|6133799003|3023799007|18002099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	NqgXHgb+drN0IIZ5YPzT+30SSgqmWiudv8JOTrmgDC1Iedz+uD0TUpVNB4MeYgifSq+M9JVJypZv4H0I6QFJ2V6OzXx6kOA1XUV8lsnkgCTyuG5X/3cVVk8dA7fi4F/7ISYKNpuyNxdNcdL7aRmoWRwbTT9naXGT+DcduVNpywWm9J47BNHgRt8JU07rmplJmUvM/tYkGChvqSEFEGKsCyAXDBNE7OTmpTH+iNAOcXsxajtHix+Rqts/wOllu06rG2kBmxP8AFbTP3VDnqY8JVNQ4N51OMLnOevZHSwmrME8T/2WxKQvn3bGFWTkZIy3IR7ejGrFqf8+VWnH/6GI5VOz/JwyenqfIoG19CySc0h0Msf7D/7FI4fz57p24c5yngcjYQ2bt9/Kcd9S3je2SQQBdKou91ScNpyQMBJabF1XznUk9sZsqd9pLWoA6Gkh5k/xhj/HJa5aq++5CfHYzy9JYCSUqUJmekihxZZtgTddHg1yh3pSTRiCA+OHfvBnE7uIw/iY1VMBaEPiTDocsZjbwUwVFp6wgRW0L9UBhehte6h5oaJ7kIUoSd66bfup5dyMVb9H7moLzDCM+7Pa3aBCa8+lSYvUu2AYgiq93eiX7zaDbohU6yd3CnaRbKSN8jDovWVKvecgUgMwLnZGM0mOkdPIfuJ5NETsKy3Ytpoucup90zy/77obvki8RnFTUK1MtTGUzFL/rEJrSkp3jw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YTbE/bGXaSFEcVH53oPtpOIK9886Cz8kLajaCoM2buzMG8sJqpyYZJAQExDIoS/IO9S8pOceQB8HQMP5mzHHPEAzvIlkL0PmA5G0e4eH4Z9gOepIhMJudpk9jwmDez9hL4gpwoNyOCGAilhd054KateTLrp1euAn05VZB5eCC/kGvUQAgJtk1rq+TvhUADj5m0kBDFgC+VXmWSDpew2C4i/JtMfybkmx5TPlsTWsIaBh+vTg0fDEWtIXXPgxiW+qFn/Gml6D2oYMuWjuvCOa7d+7DSNxSkBzqvADW76+tezTRIumzLXk4HwjGrby7HUEbV10Xz6Uw2cvST1fMU/brYBRsQjEOZYeoZY8Ea+efUNf7WjsIL2ZrJ3jTeVxW5B+lVzXF20OoHskgFjxAJArCfLH28rtSCc5iwPiA7gpxxIcRxHJITsQc5Jb+DnArf5M
X-Exchange-RoutingPolicyChecked:
	WWsazfEGq7jmD0tItJz/e2qFSgsqls4+mzZI/QkcOL/GB/UijNhcTobmfuBy5tK3BOa3arRyDlNVljE5oPj2rszDiEBfE60fLsA+DPyIYi0RL3ZJFZI1g9PSUVuvIXbqwLksmHvqQGu1FT3m1E8u0ygCeX6znazEYscIvjBgPpQ952CO8Aq+9rE/HtbCnK3lAq7Yef0A/PzJK46M35IcS0RjZ96bV1BJ8xlp/bO+xGxBpMPHZPbgWbr+/Pafbtq2HM7AkfhLC6+AnFAGVvSyvz6a54wOSk6CHer9mJsceUwlmeA+prqUVlppPbaDD1V0Ob/fy2dqpFJg7HCti2+ndg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:35:55.7209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f1328-faff-438b-c439-08df1df3ea82
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Authority-Analysis: v=2.4 cv=SsEFe/O0 c=1 sm=1 tr=0 ts=6abb5c52 cx=c_pps
 a=NkapyFR+xBWi1egQVwNhyQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=8s8V6SSlLf0v4YxbqfoA:9
X-Proofpoint-ORIG-GUID: Lc_bKfdq5WYJL4OvGya0Gd1FZ78r9eTG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX52RLkAUiwSl0
 VQPjneqQtS73LJcrBRsQqCWE8YrcfRXgZRGMl9TrJDX2x+tbrp0VCM98rN7AKpyZ2WCm+XpmZ5v
 gIXGKXxiuEYbo7hDac2ugouciZqh1c8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX8JrXnBsiNPQI
 sZ/jfIr2WlesjcG3Re30uP5KwCkRgr7M+MtvVSRUcRz3ErEJ5+LRfmsQcJTdGflA6dUyXGwD0wS
 TDvKVhScJO+6hpEvEgrfrBZQqKBchKtXpW7VyIfjZk3Z0eVTAJ2gAQvGxmiyvw7dEV9tDibunf0
 Tb3FgV8Qrr5A5BmK4M3LtcTMVgjgAaZGdcKx6BloQOjistwbestWfa/+pt6X0WGX4LQ+0WYliAk
 0KVHDzYXlRySpBWNGqiQekr6DQoYjnJhwakbLwn9fA9EpzFOX/yGfzO1Pp+Lh4hFqle1nQ9Uh05
 lwx+cXBuYZ3xZl0l+PjJhEzBRtCqLRMICB/uqNVd3H329Tng90UYNLVoWd2qTdYWbTsI1AphJhK
 Eq1uIghk/QhLZcENHYb++JL3qRLVe6IZ8aCCiJAOPj0vbpjKKHGlv3XSj8RtTugHdXhMg3qM2HM
 VYoWNF5kz0IT0fHFsTg==
X-Proofpoint-GUID: Lc_bKfdq5WYJL4OvGya0Gd1FZ78r9eTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

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
 - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
              frequency achievable post controller configuration
 - Patch 2:   Add spi-phy-pattern-partition phandle for
              NOR flash PHY tuning pattern location
 - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
              spi_device.post_config_max_speed_hz (0 when not set
              keeping all existing DT fully compatible)
 - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
              op->max_freq equals post_config_max_speed_hz, return
              immediately leaving op->max_freq unchanged. All other
              ops are capped to max_speed_hz. Also require per_op_freq
              controller capability for post-config ops in
              spi_mem_default_supports_op()
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core;
              serialises access via spi_mem_access_start/end and
              rejects GPIO chip selects

Cadence QSPI Implementation (6-14):
 - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
 - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
 - Patch 8:   Add complete PHY tuning support: DLL management, pattern
              verification (NOR via spi-phy-pattern-partition phandle,
              NAND via write-to-cache), SDR 1D and DDR 2D search
              algorithms with temperature compensation, AM654-specific
              execute_tuning entry point
 - Patch 9:   Reject 2-byte-address DDR operations via a new
              CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
              around AM654 OSPI erratum i2383
 - Patch 10:  Refactor direct read path for PHY support (preparatory)
 - Patch 11:  Enable PHY for direct reads at the calibrated frequency
              when both transfer boundaries are 16-byte aligned,
              falling back to non-PHY DMA otherwise; also reprograms
              DLL on chip-select switch when two devices have
              different calibrated settings
 - Patch 12:  Enable PHY for indirect writes of at least
              CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
 - Patch 13:  Reprogram per-device CS timing on any chip-select switch
 - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
              runtime resume, since the DLL loses its lock when the
              OSPI controller is power-gated

MTD core (15-19):
 - Patch 15:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best_variant() with a skip_mask
 - Patch 16:  Negotiate optimal controller operating point before dirmap
              creation; iterate all read variants in performance order
              across ODTR and SSDR interfaces; re-pair cont_read_cache after
              PHY tuning via protocol-shape matching
 - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 18:  Execute controller optimization in spi_nor_probe() before
              creating dirmaps
 - Patch 19:  Reset max_read_op frequency for security register reads

Testing:
This series was tested on TI's
AM62Ax SK with OSPI NAND flash and
AM62Px SK with OSPI NOR flash:

Read throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NOR (8D)  | 37.5 MB/s | 218 MB/s  |
|----------------------------------------|
| OSPI NAND (8S) | 9.2 MB/s  | 35.6 MB/s |
|----------------------------------------|

Write throughput:
|----------------------------------------|
|                | non-PHY   | PHY       |
|----------------------------------------|
| OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
|----------------------------------------|

Test log: https://gist.github.com/santhosh21/e1b5c7cc5cad4acb94b67e826d971ab9
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v10

Changes in v10:
 - Gate the frequency spi_nor_spimem_get_read_op() propagates on matching
   protocol shape, and add a patch resetting max_read_op.max_freq around
   the security-register read override
 - Split cqspi_tune_phy() into cqspi_tune_phy_read()/cqspi_tune_phy_write()
   so PHY_PIPELINE is never set on writes, per AM65x erratum i2189
 - Fix spinand_try_ranked_variant() to only clear, never set
   cont_read_possible on ranked-variant fallback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Collect tag from Miquel
 - Link to v9: https://lore.kernel.org/linux-spi/20260825171737.776052-1-s-k6@ti.com/

Changes in v9:
 - Fix off-by-one in DDR PHY TX search loops
 - Fix cqspi_tune_phy() to unconditionally execute the disable path
   and restore CQSPI_REG_READCAPTURE on enable error rollback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Link to v8: https://lore.kernel.org/linux-spi/20260821114822.4040338-1-s-k6@ti.com/

Changes in v8:
 - Re-pair cont_read_cache with the selected read_cache variant via
   protocol-shape matching after PHY tuning instead of unconditionally
   diabling continuous read
 - Rebase on v7.2
 - Collect tag from Miquel
 - Link to v7: https://lore.kernel.org/linux-spi/20260811183313.1550425-1-s-k6@ti.com/

Changes in v7:
 - Serialise spi_mem_execute_tuning() with spi_mem_access_start/end and
   reject GPIO chip-select configurations
 - Fix cqspi_phy_apply_setting() to also write the calibrated
   read_delay to CQSPI_REG_READCAPTURE, previously software-only
 - Use local op copies for pattern write/verify instead of mutating
   the caller's op templates in place
 - Fix the READCAPTURE bypass bit in cqspi_tune_phy() to match the
   value validated during calibration instead of being hardcoded
 - Enable PHY before starting the indirect-write state machine instead
   of after; the old order was a guaranteed deadlock
 - Add a new patch to reprogram the PHY DLL on runtime resume
 - Fix continuous-read and ODTR/SSDR template handling on ranked
   fallback in spinand_try_ranked_variant(), preventing data
   corruption after a fallback
 - Fix other, smaller correctness issues raised by sashiko-bot
 - Rebase on v7.2-rc7
 - Link to v6: https://lore.kernel.org/linux-spi/20260723110219.3180747-1-s-k6@ti.com/

Changes in v6:
 - Add maxItems to spi-max-post-config-frequency-hz property
 - Rebase on v7.2-rc4
 - Collect tag from Krzysztof
 - Link to v5: https://lore.kernel.org/linux-spi/20260717185116.2065505-1-s-k6@ti.com/

Changes in v5:
 - Rename spi-max-post-config-frequency to spi-max-post-config-frequency-hz
   per DT schema unit suffix convention
 - Rename CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk to
   CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR for clarity
 - Rename SPI NAND identifiers to remove PHY-specific terminology:
     spinand_configure_phy()     -> spinand_optimize_controller()
     spinand_try_phy_ranked()    -> spinand_try_ranked_variant()
     spinand_reset_max_ops()     -> spinand_reset_max_freq_ops()
     spinand_op_find_best()      -> spinand_op_find_best_variant()
     phy_read_variants (field)   -> all_read_variants
 - Replace bool odtr parameter with enum spinand_bus_interface iface in
   spinand_op_find_best_variant() to preserve the existing enumeration
 - Replace cqspi_get_phy_pattern_offset() with per-flash probe-time
   phandle lookup in cqspi_of_get_flash_pdata(); fixes incorrect pattern
   offset selection when multiple flash devices share a controller
 - In cqspi_tune_phy(), reprogramme and resync the DLL when the active
   device's calibrated settings differ from hardware
 - Edit cqspi_phy_apply_setting() to update phy_setting.rx and
   phy_setting.tx alongside phy_setting.read_delay
 - Reprogram per-device CS timing (CQSPI_REG_DELAY and read-capture register)
   on any chip-select switch, not only on clock changes
 - Move post_config_max_speed_hz early-return to the top of
   spinand_optimize_controller(), before any state is modified
 - Remove dead NULL guards on SSDR op templates in Pass 2
 - Downgrade tuning-failure log messages from dev_warn to dev_dbg
 - Rebase on v7.2-rc3
 - Collect tags
 - Link to v4: https://lore.kernel.org/linux-spi/20260618073725.84733-1-s-k6@ti.com/

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
  mtd: spi-nor: extract read op template construction  into helper

Santhosh Kumar K (18):
  spi: dt-bindings: add spi-max-post-config-frequency-hz property
  spi: dt-bindings: add spi-phy-pattern-partition property
  spi: parse spi-max-post-config-frequency-hz into
    post_config_max_speed_hz
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
  spi: cadence-quadspi: reprogram CS timing on every chip-select switch
  spi: cadence-quadspi: reprogram PHY DLL on runtime resume
  mtd: spinand: extract variant ranking logic into
    spinand_op_find_best_variant()
  mtd: spinand: negotiate optimal controller operating point before
    dirmap creation
  mtd: spi-nor: run controller optimization before dirmap  creation
  mtd: spi-nor: reset max_read_op frequency for security register reads

 .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
 .../bindings/spi/spi-peripheral-props.yaml    |   13 +
 drivers/mtd/nand/spi/core.c                   |  328 ++-
 drivers/mtd/spi-nor/core.c                    |   94 +-
 drivers/mtd/spi-nor/otp.c                     |    5 +
 drivers/spi/spi-cadence-quadspi.c             | 2275 ++++++++++++++++-
 drivers/spi/spi-mem.c                         |   55 +-
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    4 +
 include/linux/mtd/spinand.h                   |   15 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 12 files changed, 2671 insertions(+), 154 deletions(-)

-- 
2.34.1
