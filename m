Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E4344DB1;
	Tue, 25 Aug 2026 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678328; cv=fail; b=iT7Twg3GgTcCSEoifNw0rpgAWlSmtoNLmLM7+6FTwL/M/K9BZmUMhecf+6WR5wjFkcSBscqt+4XoBx70qxwbh1NzZ392KuYBrvHnb5uQcl4d/JONwtScx2ZT+YqUMr4FhchVM8TTjXReLJgi0EfjGtbsaScBiQwQielG0CKVDF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678328; c=relaxed/simple;
	bh=QC80G/46Jyx2PEuvFBKGkKrNTeZEmLvkxm0ph5UVpRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3SW5xfHhvJyVaNmw+yKBlUmwg+A1hP/mNcEA0ElQGMmqPOvmc1gGqCdISBDmwKM0KC8fdGqraxLtCJdKkIU4HnoNiz77x9ikUBMrj6sm44stkkPU6/Xm2VOUPVsbhUvPanqPAPcjsUICc/t3Y2aVIEklcZvlb765DF7d3QdGpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eiWpPm5R; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DPgEuYH3; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eiWpPm5R";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DPgEuYH3"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVaa81165296;
	Tue, 25 Aug 2026 12:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=e/jFaonmcbRPM
	HJpuNTFVz1BjyI1Rc8g+xNkMB/z0rE=; b=eiWpPm5ROLGRtrCGJcGc6MH7DkkY/
	1VezfJZvT7zjbtm9NIb+bxEoz1F5eCNVuwma7w3BA6RtbKKqBdROZQa6p4A3h6ml
	gVvRHuM1Cwh74bij6rKezO87n7ULrQDWXxBm0QNosbNjSOLmPneuCIyO5rI2vIrR
	HrVY2ODaor9bOFxnYK7WNmY5grkBA54fArBOjZqtabqvB6jD8Hli5T099INmDyAM
	2kgeUO73RZX5BNYPMnDfyYMH3dB8vA1VZ23USyLqe5AVFWgagtktP2/xy4nrwqDT
	tbDxGf4lkE+B+dMJel1HGHvudvaVVsyF2rUIv+02dXDhCo0b9ON/FR1Nw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxmjgh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY9zoVTXYi5iagAYcS8/L5dgTyRz/B/WDnhkMkbrGRnAayzqdHrVzjE+R7HO/S34/Ps9nEL53K2/pZDJNk8RxyCyhto0ZwV21pOwiXOxa9aH4yOpFASET89xAZWmyemM0SLIy+7ppWCwDR07sWlk0llt95w8md9UGaUcdFQ/EsB4agCn2K5nJ4JdiYO8H6NBToNVJDVnTjmeN1RUe7Mn/Y2mA+bGr8Q5h73Dc9bDxWBcfbn6bz+q9g6qm+EoJhXg0C2t301YnIoooxQ48UhbTXMeVryID5aVPDBiLn8loMZW57JI1kIB9ZN0KoPfkhP7uquJbtpx5ADNcjGpEabetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/jFaonmcbRPMHJpuNTFVz1BjyI1Rc8g+xNkMB/z0rE=;
 b=aRG2gMehU0ykSEyostCiobW/pJcGGOlFisp99PN+b9tSthINrrrWnrQCs89PTn4ZcUaS+5bB6t/Nw4Eh/5qUw63iPyaAoiyXDDY1b1+qr8NQrwkt+BPjNm7CnvMiHzchyxCzLDSIFqhbwg0N97Goqjv3HLnca626fHsKV/xS+ldtYGht+tX0nEea+Af4qPIfpFDQvk83lVZPIlXQ+KQGgqpsaL9FtewnxIJgz33AHfrNRmdnPHVEAs1wnilmAoX4zvtzkbgyY6XnoymcLWzSktHuemgJ8iwf5el++zkWrvuMWpqFT0M8aRtLZJ/HpObqCdMKkqWfSoFcKXaJhkCBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/jFaonmcbRPMHJpuNTFVz1BjyI1Rc8g+xNkMB/z0rE=;
 b=DPgEuYH3+uSQCvtK4OwmJgwCfnCFpvUDcXhTaVjgp3Y9Xu/KVHY4OqDlJPd4LIFE7yzIGvoE8LPmprMfsRIx8kdkqZkfoKEHfO6B2nNsLCw+ZcbdM6zZzzZ1/H0Rqh8k4FbpyQnJ9qdB8Y9JnSxKFg9mzJD/IW8YM0uuwnRP0VU=
Received: from SJ0PR13CA0094.namprd13.prod.outlook.com (2603:10b6:a03:2c5::9)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:18:21 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::63) by SJ0PR13CA0094.outlook.office365.com
 (2603:10b6:a03:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:19 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:47 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:17:46 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3P1436664;
	Tue, 25 Aug 2026 12:17:41 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 00/18] spi: cadence-quadspi: add PHY tuning support
Date: Tue, 25 Aug 2026 22:47:19 +0530
Message-ID: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba26f84-e5fb-4f34-b533-08df02ccdba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|13003099007|921020|6133799003|10067099003|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RgQqrrEExnq1K9mNuAIWAE26Uctz550QAol2FygaEtcdNY6eE2IJyeZ/KofsMmTYrT55O4gc6fmgGlB17v67rRHNTolt9+eWdr2/SaNUvcndJW/fLpZX6T+M+7dZOUXp+evgqgytKKFB4MB0PFxPnnI43YjSM2FZmtW3bfzExPoirYSzktwAIpBA/LNVFWRSv0+pNXuIX48ZYlhFTp2DfsoIKmZoGs/qJGFU45KigJQ+LZBlMWbfmyacbK+nYmmupQh8fveO/kafDHTmDCvWpbusFt+S2zvI8SaE73a1VTqdZ+q8Ciy8QaI/wFzUqvLVhMQxRK9dQpuxfT091X0Jcdx49Ayhd3jX+4icmBH2mX3vRXY0V5JarlkS4HOOxiRM+tY8y0JaCqhSeJ4oj9jFK9WIQYIYcyo4jBw4nlbVAjVjUQgpWjWdt1PAx+Rrppt1Y/R6kAKAhnRZqd61qGGD9b7AuM7qzewcM0tFd/RcTmeYssiqHJ/W3jCvz9F+d5C+8ZxlPtBgS5//6nkDR761JygpOu2h3SIAR7ptAufMeBYKMeTmiIAD7zfT/AZqxZB/IFd/sM93ge4LWHBmVZWss5fikz82HrCtcDsdQ+z/kUbvK0AlmO9oGhXz+W+9vrTUNJguSpXaibYSGMrtAqdlHb1d5lHOvuRNctoJDHWevZGrEup+WBk114zK3OZT7WMzmFJjVwTVGKYSBZ0pT9n9VPoo5Vy1vWwyhGfmUskJ/AyhgxiEmcMPaWUhbowXlEJV
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(13003099007)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	icyKSNs7n+DgJJZy4HzPBDRUgTtGpTcNd3t5FOzIldBKdK656NIT7Rhg7AaoGDz4UNaMsP+6Br0rqQnMBYOGfHmL54jTGPHRjIwv1Mxt5kBKDzDQG5nQaH9Eb+yRPBR3n84hgO0FnYSn3EZw5Orc1k6PAr+Nf+moZy31DhezJoR435W3pfW4AkDTs4+syvR2IXdIWY8yn7BPqxZUya72ikJAlS73Pn+QjATBjjkMgCBrK3ZE1s8cPXjI5ugdNYIr1hMqDZTM7XetE0O5cbiwQ9OrzJn+aN1mzTT7S8sstv4avSYLkTbpGqq+k7xxL7SBBLI1uc8RgD4RFy+u0ge9cyrzNyiejoXtSQ53WwDPd7esSKy+MsY2p8K/kHfh21eLMajkdlgdV5mHgqlchZL3Qy3jhKccw7UszJbIR+RCuRU/iKAcSAzba1/2zg1koLUS
X-Exchange-RoutingPolicyChecked:
	Agxa3Y+vIz4mB39E0TWus9I/ssK+MLxv++uFM16Kx2EbehO8/nH5sy4/73fsSJTLyR7oNq/iJ3Z/Ya40y102VHoI9SW6h+EL9cxjygP6FTjQ3qQeCApIyXr71xlgU07MeVXLZ4rKza/QnxZ1qjLAEA0SjUnSC27REX2V6Htx3unN0rWTi/4bJzFfmSE4WExWyfNh9+w/RCWsJuk7JLw7zf9Pu+JpJJlY4cvIcsPoctx+E9Fm9YhzbYq4YNvp6b9Stl2KOpflPbsc5GzmrxvKwXjk8fIQLZGWmLJ3DM5PC4MJL/fHKY5wLCsBkQjFBONSREwJNbG8N1R/R6bkPxI3VA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:19.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba26f84-e5fb-4f34-b533-08df02ccdba6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXxwaEvU7IF1S9
 yy0Kci5eb0fKKdM7Uc46txheUlDfNhYnMzoySQ+UDIbQXM+9AfTCnDMGB1Y618RXPDx7ODc3sMB
 RA14XkhrigW+W9u9Sp+JSV77NTVxKpI=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dce6b cx=c_pps
 a=3r3V3iWCG03xnAr+XYP7tA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=dgxhBYzsHcwBPZuLQGQA:9
X-Proofpoint-GUID: cBJPdcOpsWsFZg-DCg08Hkmog78nEjnw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4oBd1NSRzQMB
 JGWuEYZqn0/8ooFxjVTitcsEaMmGpMUMgc9OVjBzb6jP/whe+nVfbH0o4MY+S0YMk1wTw8rX7vO
 9Na7aDiYBeIGZPUslKY2jxBki0jJlY1dTllMCXfz1hLDkHC/RtnHrQ14Ylzbp0Oa1vqzDFnDJFM
 9nzJZPbbphgy6CXM60w6hf3k7phqd+PTKetQJTTgbN6G7CRI4dGpxD8eVW9B0/YM8Yazwcw1pTg
 nHHgsV5PuKamL+MrHloXD1OE3LDF19zunq9rLns6i7CRjd479NsnwZlZcFHvZmCYRlP7sFJVj6D
 pWy2D4OoGNegEbouemArjxOXFPWT0VtUu88W29smASnQ0oLuSawn40rMOnjU+Ao/nSLrrkAzeNO
 Hh/PLkK6waZTNrpBnOL+uDEO3JgxMmwGMvt63/wzCyx3Y8ZijhWp3Ela1tqg5rCnIGXLFgzEWm0
 GopjCp+e/xaIDdH9Rww==
X-Proofpoint-ORIG-GUID: cBJPdcOpsWsFZg-DCg08Hkmog78nEjnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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

Test log: https://gist.github.com/santhosh21/fb481d09486d31134a1601e8bd2a5540
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v9/

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
 drivers/spi/spi-cadence-quadspi.c             | 2295 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   55 +-
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   14 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2634 insertions(+), 189 deletions(-)

-- 
2.34.1
