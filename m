Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45F44AB87;
	Thu, 23 Jul 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804582; cv=fail; b=n0gmy+MKB/TCI8ZFAlMt8BQWACXezN1G5oXtVN9zBT3peROA4qizvuksB3VmSu/DwmdZVN5U8BDNRsyQ8rl5ymK5DxnGpaISqUAkkRkRsvbjqIhBLKeZnNgDQsG4pUNdKHifCqWwZRQUjVuarNwwpSGoUbT6J3CpNDUbKxD1Gg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804582; c=relaxed/simple;
	bh=f32Kylm7k7iNRkNjHZSlvRzvVRpMFFi3KBZ3QOqACpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5Nif/aZCNbmNu2Aynw8Evvifl6TTlcKUE+QPbRBApWTRKic2njCpYoKgW5TapD0NeVR5Dc32KkvjnLQM+5y0J6hGosAUqgZuoD/oXRd88i+lieU8R5Iax3oBrcEr5eYGVn0qpDSyGXFVjbwGp63PIOJiY1Mcwg2GBNXyyB9jLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BrmcdHwU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SU5acfeO; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BrmcdHwU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SU5acfeO"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MF5c4111033;
	Thu, 23 Jul 2026 06:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=WA8kSQKUMufJM
	4/f4OWRsiVLeLS/y3ED6KCgYkTgjYw=; b=BrmcdHwU6Bt7YZw3t6Q3R57p5rV65
	s5NNrJL5Oo2Pd4VFqOXVMlVWrZ48JFBJTi/hCu7qT6bEdNQ4mfcGNlpJUvCfLYUN
	nqLOsQLVr8w6T4fidCTs0D/4Yi7+H1jOpx04Fqu+qme53vj4CZyec4ZYzfjUvoDA
	uPGpGcPaYNLo3fArxf5umedFLSmCvdAcSvQDVqz32NKr6y2YZ27WVlSfkmRTOEQt
	n28zQAj/YGlbUtpaUdOSg+9cNJinVnDgso3J4WOyXC4XcnVIdqC7DWPIBlpVM3bd
	/xHJyVOu6t9NRxF+TL0eRK78lpJaQpw3Eu25mXMws0nHRJaUNijnRZnzg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908cs8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:02:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLehevNYrMNVQpdX38cWGgxUgBul9uNCGkaPmjllRNo2B3t46bBW4qP63dBSJ2P3EchDXVLwNVc97uwXJdjHTHWBpwnbDKlakhdjHLqCWw61yGvFkIK3OAiGZCNxVs81RsmwgrwiM9SUlHo5vQBDmyjTQwZHSUBWUOoJL4+jRDNqZkcYDQbEYtXo2mjnlUnjn4RHa2EK3+0ENPOh6UDugM1TJ5NqC9h5dVnBgX4JXKCNxHuUiePo3yP4lZwVi3AYYiTFX8bp5zioxUbFSWhuA9m1Kz+aIATcfiBqVwXmn/O8xla+iLXvML8pwuF9fTZDeoo3idQ+koxaEPm5jw3eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA8kSQKUMufJM4/f4OWRsiVLeLS/y3ED6KCgYkTgjYw=;
 b=bBjC8QQnnvWjM22cLFvjZsqUpoi0ajiU7bG8/IKDv32eTlgmf2eAD2/5+SKqz5lbMTGsjS/2SM4q7EeLntS7BJpLX7Xvfscrz4nkaoe/9ySj5EcCjpRhRp2Q9AT99N2r2xSfYtoMI00F06PEY+Gk35ngLCxkWUmE6iLFu2pJduVACRqfTImlg9d1EChsrfvu2+5ZIeBjNFiVRwjNezw2kepprjZsxoWrZD7LAwiOjjDG4u5P9EKR0e8G3N/teoQaofVBCWVXUWcX4YjvknJIuOI4SvYphcTpkisdj/qdyuNJIw8rg0gRGwwIa5SMyHjfFQrAjrn0vqLHYb/H044zLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA8kSQKUMufJM4/f4OWRsiVLeLS/y3ED6KCgYkTgjYw=;
 b=SU5acfeOIH3UOdiGsW+oGtn4XZam+f/gOeVBIZCkeuoc1yzVTQhxDHF46oTanKAv8Sj/7DdJ7Fr5el6X9gWsS1shhBzAiK1R1mNQ1xE8s1mMI/zlLXybTQt0y79yfyA/dfLTFvsayiJ4hhWHg1xEFNLt4AE6NF9mtQDSz1OzfOM=
Received: from PH7PR17CA0025.namprd17.prod.outlook.com (2603:10b6:510:323::27)
 by PH0PR10MB5657.namprd10.prod.outlook.com (2603:10b6:510:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:02:32 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::96) by PH7PR17CA0025.outlook.office365.com
 (2603:10b6:510:323::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:02:30 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:30 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:30 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OVu1577597;
	Thu, 23 Jul 2026 06:02:25 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 00/17] spi: cadence-quadspi: add PHY tuning support
Date: Thu, 23 Jul 2026 16:32:02 +0530
Message-ID: <20260723110219.3180747-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|PH0PR10MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 88def387-8f47-4109-8c9d-08dee8a9e44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|6133799003|3023799007|56012099006|18002099003|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	YQuMKoHCYIHkgjzD9RbhHlaVXJ/igMqyIVtEJkMl7GQbamjVWaETg0UhIsu78Cj2xz1T48KiRu8JuO6LJZZ0Jo1qEdj4QTHa5Wae8T7+XJPfx+YgMzoQ5YtZIwVc9gQCYtFOrbSqVg0BR62/7koFuyLlAbrfhTNZC5NZ9DpnZhT0qgTE2upniy1RCh6QRN/T8EZAHbcxRQGiEDm78RQbVkpTtY8ltlo2P5Lmu8RF2fADg2WeEpwGJy+VJipzGoVe+5jFhVSxTk+X1V2m1zcTTpnJTO5vLymaZlfu1IMLabl6UsqTZbVsbEGNMibnMftUxz8OPOL9dQec9igQ5G7K6ZRvEENJ2zUmRuS7Hm4s4AmQ54LEsZee86nWMdByrT6jYcH81cP03UkdubVtkMx3ypfPJGFUC5nsxd2Qs6TCbQY744eJnx3c1JfjBMqGYehNtdhEtGtRQb/tLYBShEzX4bfbSE6YhwYkLYf94Gvhw5Y64eyDXNjIojBNLPQx6Zaf0p2jhBXU0WAUPizmOtG88n1cw583R34+l7kv6Ef7WSZiENyRe1BCOvDcMI7ALvx1XCAvJuXKd52gJvWa9B5r0kUNNMpvNQwmGc34t9BU/xGhY5BDZ7DS5u1v4NMKm9oRmqlmLgj7LPex2FGVyJp0T2VWEPZxWS9txeyXX1H4ITt/UPBNEYZ3sP0ROC7fbw/jceOLIpVFILjd54KjrupFfijt4FsmPKwraAKpvZD5mYKE39dCVgS9VMpMxYirPK2X
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(3023799007)(56012099006)(18002099003)(921020)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K+j4qlqmydjzgU2DUG9pu92/lv3ZC3v+Oxoebw9JLUo6QGFt5647u0Gw+ef9oZ+MtG0uqEpUhyvLmCKGDVwau4uUWkikAIuHYzKL3l34YpbBI/kaZDN+zNg7fN6T9K5dgVHZz8u9J+QAtphLFHCtSfBn5Ol4woICZiU4YsZQuW+M9Qxs3F10YT0NFyxOvbfq9tkblavF1J2OtoP5EZKVe9u3RD6a0tUK29PWlN7SsjOFXuTAo2Eo48oNbsCtYY42VhlICWZrSFTUEgIr6bR+eOoWcFa3urnPhT1QJgxuAAw5iz4a2LozrdfaW/h05p++QZ3XmVjxeLbzVaWKRjXreD60OqWXFtstFXHl3kpJ8o76QrOGWfiGU5IZfgAQ6suU2ssPF2v4jqTgxYV+x3qIxcJM/++XSQtYO+So7XZGSGFvxMlU5rbbXNvK1EETP8Tt
X-Exchange-RoutingPolicyChecked:
	kJmSQSlT4IQpVqrFvEwQEMyZDWrVSHvE3DL5+meRrdJd+BupjLBV0gia9uH7fn1BQ9agi75sJARPty+phar0WBR7o1Ztg8nyu6BCszFCeyb6pTvh+jMSeMLqACFvMVEgagBY4JNV61n1GEpZch1VoZu57MKzTbx5oNEFCNtQCwLI3A9RFKVaKcMcH+WyghVkyfeRWk+H+H88ngxg3pvt4tJrKKKzNMV1LCVeYECWKrQGQj/PIFPumvO2UkJHAemAuku8x6AS+gcJXGNMOomHSHj5oNxaQFD7mQrkQH6BPaqvicMmaLxYr9ydbu33oAIXXiKsxyOXVgIMALPcDMf5dw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:02:30.9000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88def387-8f47-4109-8c9d-08dee8a9e44a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXxN5ZHL7ZX01r
 ZW8lTpr5IuoexqOr88BxlD0wCwUAnPpYQwWuknnx4Xx7fHCRUHcFHC4NLe6hDkwobyO1CUlBmup
 i2v3130gm8nVQcIJQe5GjMPG0j0WAKYmCFdnCds6HGnH2wQW675FxpXfd16cfGGVe1Ggt45LPOb
 dgzKpZgWsv5RHIntbfYN96JZsjsCe0mHXL3ure7VdKiGKhVqjaALOQNUBXRJ6PIkt3DELzLorSQ
 soBAD/nfsvtchc/wAhOhak11Vf4fFz7C28cWx+FCdvBcdK3DvXwPADRKbMcxBshd8K3/Cgvoa7J
 dhd2Vnj+FLgZxbMzFxdHLP5TI8raMoYqD1xV6gRMhTV/dwxVMjqNIVYsk9JwQXAENNXhqrbm7cj
 IZCm0Y9lNuRtEVn2TwF9dE/pxpB10c7Q4Iux8X3F27Ua6qAZplkVZvI5s+gplW+xDMUZSHWVPpf
 rB9lLJloSyYLz937qUA==
X-Proofpoint-ORIG-GUID: f_5kkgQ3i5OBzso8SM4gP_cisRDvUwPG
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f4cb cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=1qu6GB6xxCx-qJtXegsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX1yGrogYNh2Ja
 3f5l0gDt8Z9b6geu/6M8Vf75CEdEceRyJRbISyWrMy7adN02bVihAFoVP23q14gMDKr06HHfDVW
 zEGpaE8URiGF+GZx1XsAKZkChFAT+fc=
X-Proofpoint-GUID: f_5kkgQ3i5OBzso8SM4gP_cisRDvUwPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

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
              ops are capped to max_speed_hz
 - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
              spi_mem_execute_tuning() wrapper in SPI-MEM core

Cadence QSPI Implementation (6-13):
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
 - Patch 11:  Enable PHY for direct reads; split the transfer into an
              unaligned head, a 16-byte-aligned middle section with PHY
              active, and an unaligned tail; also reprograms DLL on
              chip-select switch when two devices have different
              calibrated settings
 - Patch 12:  Enable PHY for indirect writes of at least
              CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
 - Patch 13:  Reprogram per-device CS timing on any chip-select switch

MTD core (14-17):
 - Patch 14:  Extract spinand_select_op_variant() into a shared helper
              spinand_op_find_best_variant() with a skip_mask
 - Patch 15:  Negotiate optimal controller operating point before dirmap
              creation; iterate all read variants in performance order
              across ODTR and SSDR interfaces
 - Patch 16:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
 - Patch 17:  Execute controller optimization in spi_nor_probe() before
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

Test log: https://gist.github.com/santhosh21/13016b6d5d63851d3ad466e711a5c80a
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v6/

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

Santhosh Kumar K (16):
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
  mtd: spinand: extract variant ranking logic into
    spinand_op_find_best_variant()
  mtd: spinand: negotiate optimal controller operating point before
    dirmap creation
  mtd: spi-nor: run controller optimization before dirmap creation

 .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
 .../bindings/spi/spi-peripheral-props.yaml    |   13 +
 drivers/mtd/nand/spi/core.c                   |  238 +-
 drivers/mtd/spi-nor/core.c                    |   80 +-
 drivers/spi/spi-cadence-quadspi.c             | 2232 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   40 +
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   11 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2468 insertions(+), 185 deletions(-)

-- 
2.34.1
