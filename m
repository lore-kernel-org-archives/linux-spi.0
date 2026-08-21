Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9F47669C;
	Fri, 21 Aug 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312956; cv=fail; b=bukKERI25cLoA3qt+xuS9prbxkDdteFcAf2WTZtby0fbp6aqpBzf4fUw9KCa89Q08JWs6RKmhiiCHbRoYYjWowYcrPN5Nj+eu74OqINqCElFZGSVSDZobVw+MfJtpQlL+jcBuNuQ7vzNX1O5EEUk6eW4CRwuOVKdmOZozqqfjNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312956; c=relaxed/simple;
	bh=N1BsSdcffJatGFMO+UJ0diov6I42lkqLqocG0eMqmY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVCLSsehQKAY4lI/cIHePgW+T5R2mhpUkB4omEiBAnPSP/kEKhcG+EX4IkUBGaV8ObEzY8PZUASW4/NqHRCTgI6oCM4kF71VKa9eEWrLu0ZEuWCdNtQBugny9hKRarx8JhRBKEJjmRNuKp/3mG3J/CP7/JiNcSwFSS6pn6e7zuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=gSUmK+BA; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BTvk9Ioi; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="gSUmK+BA";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BTvk9Ioi"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KPdq2886946;
	Fri, 21 Aug 2026 06:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=h0k9OpD1mntrO
	INx6O4je3JrUb3J6sQpMFoSuxqu2fk=; b=gSUmK+BAzVSc2VN+BMu3IMVGcrqWr
	JKyvmIkoJGSVQNNrJm/hRWoCC9pKjbYgm0MMyWE5gxK4d6jeHRHNPACgspyN6EN9
	hxBk8eKnHR4l7uRqgAleVTKuoyBxo1a3nNeOFVBIq1y93IYtwTh/+aOXAxHg+lBd
	rN0eTGBumW3jKfuIPuFUWaU/bynsbGowZ+Lth4QvtDm8RVqj/6iXeEiXkQH/T/cW
	7BV1nGk3+Gvr37Sd4e5y5t+c2V96wrnFjFG0HANn1RYMOguznXkhMzBD0Pg6PI4y
	9cjYIGVhAu3kPQTsZovRnGAHsCDxU1HKOU4czE+JTIVG0URYf3Re+YRPA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g6gke1mdv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:48:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNQdDERK1RmGAijxfcTWrHOb/17aw1uD8eqFKuu7ctcL/IeatqfJ3Oo+1zyi2CZQjU3GV1IqrUGnLM6/3MTQsYVv0n69dkI8PJcSfc4w2Z8q1+ECX9g4PjDZCqdb8Khxt7hPLZnEq7WZoZZItTubZZLlnxc34j219r7pF2q5EAvUE6i1LGR/PosxmvBQZAfK69FFip0Sw/AdCOf7GD9vokSWzFhLEgCqSgcbdF+SAd0KYj9G/wZMYfsWqxuThxkKHmgJ0lHo3/b7q69vnN4b8s7UyliFOQmc7gUoQt+biyBYt4Y6I6Mm+1Rekh5wqJq3RHuNt97+vnMaVzvBNdeR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0k9OpD1mntrOINx6O4je3JrUb3J6sQpMFoSuxqu2fk=;
 b=VDBocFOmw6i8ydUIJFNdpnlzD4wGV5BoYZkUyPh4x8n72G6MZ/hR4UgrHv/DIaMtEiGv5u1ckhMsGGWtn3xwBoiGrbJBjShLaSEulSPgXyc+RLG7Tr0J+GqT085NUhzgPFzPX2kSRD5WVxbuthGVmn10j/jUT4vGJ4OrfpwgZtCg+IlPA0zACGsAKllHdLzDK+8BEtlKTLm0GudFGVUORIDUVp9wHNYV5eSSmm8ljLqMe3voq3yXCi8Gm+bDfOEPMPT3cQV1nL/Ys8DCIOP6PXPOeB55rrXDSTMlhpDlDeVT2P7IrHBbb43CL2kYIdKtthF7a8292GYubZBLFU3bFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0k9OpD1mntrOINx6O4je3JrUb3J6sQpMFoSuxqu2fk=;
 b=BTvk9Ioij8vi1LWe5gM3kJkLFA/G/u5q5xpOgAnF6RIkuhYABVo04/q1486oNkjtEafSjWHVTVYoJJHVz/0E1lgA2WkvuqQ/vrqhXONTvPWAa9FoaEsBzc0coBpowwYbSfQ4YiWELfFZnsUGwhDnmvIAAkqS1AyWcElZ/vmDWUM=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by DM4PR10MB6205.namprd10.prod.outlook.com (2603:10b6:8:88::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Fri, 21 Aug 2026 11:48:41 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::27) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:48:40 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:36 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:48:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:48:36 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlb2022942;
	Fri, 21 Aug 2026 06:48:31 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 00/18] spi: cadence-quadspi: add PHY tuning support
Date: Fri, 21 Aug 2026 17:18:04 +0530
Message-ID: <20260821114822.4040338-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 48500bda-adf3-4292-ddbc-08deff7a2522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|7416014|10067099003|56012099006|3023799007|6133799003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	dqN1SxoUttBbODq30hdpvIiG/gQ435Em/SdBnUbsaSWQIGWK7P5AxbaHROVsD2T4ImAyTXVxyq6minN7pojl6/+05SfSjVy+nYFCykFIdNB4lGfIWrC74u7sQX4QFsMB+IXjCtk8usCzOVQtCNt1ayt3Pey+9pMJ3KGokFejprcwTXlLUEoSPLqHvv5ClwHKNUtQdWNc23chWP3g/tWEw0L662E8gWyX0kewj6mpKaBu6XGUMs09NFk2S10Wom/IFbTC6sVDm0l0UvauCnfYJJnhjeh/Y5GRf5SttTCXYxGxHvDAfAKzas9YDPMz2kzcn33hbd6mt1K8pwaJSO2WAKGU32PpGqtZKp3XCZZnaKaRoNwpu0AqhjPMssrYe8DwffVyAslxUl3EVJFxC822CQ3m9QrptfrmvRRsCwI5A+57xhGW5u4j2c+4j5+NYEFgbD8KvB2ATW2Kuiowahv4wlL1TcyJazkbAcxHmXpl7BYswpgfooeJsbuzkZjm2IXx84QW/RQcOJGIiqJjVJTc1jcviF7tdr2y+r5imJrVFGz60wZICLrt5YL3MlCxEO90to4KVFHpmpYfZwhgNZq0IMNMmXzPRUStQ2N+shJu6ObwbYFczSUKXHAwlSVHqnD6IzD8X+Mo8vCqFKJGqzQ5ySBBC3JgmpwMj/k69brQrvWF/NgDFXc9zMGVEpRCRxeGoHdLOSTs7dL60omhD+UQltDghNaVAC245KbqRHUDLvcFLm2S35pfXOV6KfAT7xAz
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8rbOKn4FEsL9FpF4zzxRtdutRacsZMVvp4eipvAetUyjS/Iehnwa40pY2cTGCG/Q1brM7telCs69yPvC9jAN4298vj0rjDRDUh8ph6pdkEQ8o+tuZ35dqVUYeCptiLB3OC+ocagFrCzsXMJQIpP6WGiO547j5VvnQlYNTjgTGjB4mZrWDmBT3jkaCqbPlLtAd5UChBBdCEJW13Rzeu6R27ka721yTly69k/TxJsnxVck3EaT3R8p2teJncOOShl1lMGRhNOyluQFejnphPYcLXNrdIV36WkFcZ4M1hAG3Tr72iH7ZOvUtblqbh20WmmjcOh/K2SKCqJku+DZSsi19/+U32o1gmZQAm1tRlggnl875WSde1z8sC/dYH6+i0iYAdxvKJWX20clVK5dDZrr9+QfU3qJcxLk2Wk/pw5+S0qjVM2KHY/lcTJEfQXA/iPq
X-Exchange-RoutingPolicyChecked:
	Brb3PJPr8NxVOEbc/o1gONrTK6OsolVfMB+t06BGNSQIQFjTkQEV/M8X/tp6HjUWm5i66AeomThEbGYJbNLPhJTHA6Lxed/DUNNHffwVbcEYN+8nWTNdYhwXts1DEvRewnBWrXTeMyQlaOY4TxHde2f/bQOTzQXXEAKx7siMRh9AuORi9fylp2Sb7O7JT3/PEEitUtottn60hW1PloU1jCt/qWYwmsUlMQI8DFpEZMpvQbwEaHEWZIT8Il/+Nu/1vp8LT93dnaf/EplORa4V3pb9EQnbFi4W9CrktVbfOMTGuJwHVl7VTXnAzSL+Z37/SLqrNC8+/yDBmQRdcwI32g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:48:40.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48500bda-adf3-4292-ddbc-08deff7a2522
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6205
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfXwaCCnn7RBLYd
 x5/ozueV81DkT40lYuDv+z9Dck+rGGhazL0IqvggsJxAQ1XwbtMqkUVXdVCXlaHkGH6iUM33YYF
 ztIvqqN/6VMDw3CtpHBNG6j+xMqGWUE=
X-Proofpoint-GUID: RrG9nNWeyZv4LdM0eOZwhz8EGCfVw7mu
X-Authority-Analysis: v=2.4 cv=Fp41OWrq c=1 sm=1 tr=0 ts=6a883b1e cx=c_pps
 a=lZTGddAnKZ6AR5Pw1xQKMQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=dgxhBYzsHcwBPZuLQGQA:9
X-Proofpoint-ORIG-GUID: RrG9nNWeyZv4LdM0eOZwhz8EGCfVw7mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX9mX4Syrk9GCk
 AxBiH6NwnxVuE6jUlw2gGy37Cg8wYgV9DRN6fXDZ4zanKNRx6Kgc1S4VwJIje+TSvJh7u2Wb9X9
 wxu3Tue4ZYAe3ZmH/cYW5a0ivOXQBbdVilxFdwyVvbw4DgpErxPgNI2LEzu+v+C9jIrozSvhpB+
 PKLddFjYyiK2g+mrtbBj8qyyO5nmB3dj8ShJvIkqlm3u7ot82nVEJMUgaKeD4Blevdn+EChPpI+
 uB/+BvCdLEwRqt9aVEinpF6+VWI2jjdrN47M38YfL+cTpd7A0Qf7kkD2SohvWsLDV4CdfqJ7mDB
 6E2kmMliO+gb+ncQQcTWNSoBfj84kz0IQ4eovTIe3F4kxSSl2gqyg3UNX3WWgjmB4csS9IwE+4F
 2P4qzjyUiGaProehwewDpOXkpyIWupnFnGTo+a8//0VmQiLfG1gmB478hm2wzrlm9ArEMsqdLNZ
 9POrD9bS9xmNk9763gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210089

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

MTD core (15-18):
 - Patch 15:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best_variant() with a skip_mask
 - Patch 16:  Negotiate optimal controller operating point before dirmap
              creation; iterate all read variants in performance order
              across ODTR and SSDR interfaces; re-pair cont_read_cache after
              PHY tuning via protocol-shape matching
 - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 18:  Execute controller optimization in spi_nor_probe() before
              creating dirmaps

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

Test log: https://gist.github.com/santhosh21/6ba537a984acc2f98abfca0576459118
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v8

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
  mtd: spi-nor: extract read op template construction into helper

Santhosh Kumar K (17):
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
  mtd: spi-nor: run controller optimization before dirmap creation

 .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
 .../bindings/spi/spi-peripheral-props.yaml    |   13 +
 drivers/mtd/nand/spi/core.c                   |  327 ++-
 drivers/mtd/spi-nor/core.c                    |   80 +-
 drivers/spi/spi-cadence-quadspi.c             | 2280 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   55 +-
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   14 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2618 insertions(+), 190 deletions(-)

-- 
2.34.1

