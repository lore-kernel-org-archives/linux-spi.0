Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A7435EF0;
	Tue, 29 Sep 2026 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663811; cv=fail; b=UTL+6o89yQNULUMsmi0mcRj25o6InK+poP0lZY6KPihbUPWMK+Rp/bKUEzmiMexXZzDRptmzro+Wca3dZzSr2o4RUb6Z0PLEEMzoeV/K8GHrl1MXdx1MCDoI8xzLW3ligYvfgJelYySSVVO/fL5SRgK1ZjHmqLjo547n5PGVRtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663811; c=relaxed/simple;
	bh=DG13bdJhnVM3omhhS6ZPoxor/tcOt2zcf9e/8wDfWTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2ZsVgK4akqVVj7Mw7HqMDCMw/dYG5KiVyz1Yk9IGRz4pkHaV3O2Km0wI/CkUQ/Ql4eTXEeG2k99S/YViEHwRigKpbG0zJhMAHqLnm5m2XQexhcTDQOL8MyhBLUolTG2oJ5uorUwM5LLYK3HQ4zLfsBe6UbOdxyCN4KRS323t5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=YCktdGOA; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=YXQzDZRm; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="YCktdGOA";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="YXQzDZRm"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46T7b3284117;
	Tue, 29 Sep 2026 01:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=G+P3Usk2AP+uxkP+rz7a2MIR5Sy/Ukw5hExwqlPFA
	KY=; b=YCktdGOANzHsbxKB6N/v3nk0pShBKvl9W35hq+zexhkNIxt+kfxyJQFVg
	TzHbUWUtTIk8MuebQHNbbAdATPxkohQtfNwlklcoFzX3TpIlA8AVvydFkoM/ylnM
	Dd2JjiesP3LqPDGxp6pLQMJoLbLfDT4yEqxlxOererPG7kznvqixMtzG5OTLAYte
	ZnhRzgro46R+5wNsnFAyCGZf+llr2sTLAYZKKxyLoOVZOizBNR7tciShLVCzDgJY
	wmDQyUY0QHofhFarGIn8bK+L9SNr9DhZMmG7OeL+atI1sgA5b2MuBldziz8XNuyx
	4/PFQclJSp/WHeG7N0y07yWr77iaQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq+MelFkCmrNgeyj9A4hu58h1Qs6NrHW0LHd+M3j0LCQy5W+LzXZZOuS8DDEXalerumCmBEQrhlIOJToGHsznJ4IX0r160w2y7ZzbWBfXtYDJCsr98q7U5GdHHTOTryiYt/vLrjJQwBXdcw3Wd3EJ3iznwnairMfD0VmH933btWz6PafB98vjSjuE+Kntj/7rx7wqWc9Y8ddgbV8ot15lNs5kj2m6NFhfRiWmYxUvvPT5zh2IztWRuBFY2GC+46y37tF2ynykkXnacG2YGpOTPK1pE4x89MVUg7bKIuJxyh19QXRMu7bsJSQblR2OZsQ0RULuXX6F2RnYqpYzqTCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+P3Usk2AP+uxkP+rz7a2MIR5Sy/Ukw5hExwqlPFAKY=;
 b=wUPiuK6EIwWLI27exuY/lMM4fiMu7iY1pqrgIvFQL3IZ7UiCjs104T3HK3YiTUZf2I+MxpgcTX0tSAO/t+NQvn5ffefTO6aPV06lbLLDoHLoKj4c8m23al9dLfEs7FjENqlK/X2Dv3O5uKw9ZaZ00g44i6ulabEUHF/hA6maPM2j2yCbbfCQs8qSbGK3QsyP9c46V1/6/CcMD6o6ePrgDVpRg6riTvO3ydZnPh0KaMKIA2wd0r9A5mz+fOFkr2jvcV4Ze5TsYSeY8CFETPHI/quakmKyqJgjwsFnp08zoiyZAzOcJrEdCHgU4mk10t79s5KPvDFeSJ7cWgObvwE47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+P3Usk2AP+uxkP+rz7a2MIR5Sy/Ukw5hExwqlPFAKY=;
 b=YXQzDZRmJiD13adJXQoCa/WIg3P+mQXUGfdac9889bU6HsmEt/GHoLLEE3FfqiELuSosljPndbhComwB9uPMuQ1yCagwy6IKG73y4sPXXhpS5lhhN3CNFUo8ywKVXcw9rAUpYF3syfy2cgBHQGGU3BqXdib269i1NpL/QI3B/wM=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 06:36:28 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::5f) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:36:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:27 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:58 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:35:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:35:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn31395904;
	Tue, 29 Sep 2026 01:35:53 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 03/19] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Tue, 29 Sep 2026 12:05:13 +0530
Message-ID: <20260929063529.1235417-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CO1PR10MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e5779e-f501-4da5-2822-08df1df3fd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|18002099003|22082099003|921020|6133799003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	E436SPHaGZt+prIiSynEc7xUxqlkSR9ESD/0ophdtx13c1Xy5Osx+dXeX86bpaEnkgV1/ewCaMwQOZ7HlIAEnyM11HmBvoM0blO/38i0fv6RsGB131RYsmdCw0Z7v0Piys04k9QVRnudZ89a9LJkIMV512CkA5jZuquwqLHqO90D00AVArmlp7aYA1ru1aWwue46UImcX5JT0CwrXFJYq4jkkM7ggsGl87LG2a4qV3V5/mqcDNOr4YuE6Yb6D5I2Bq4hKrWZL6T6Uz9Wpji4F+cmrzL3b+0xqMW40N4NEX8f6szzSQ3XT1z2SHSfDW9ObdkHSuqkgFbnuCzFueb/cloQ1YtYSFIjlXF6A+G/bn5Cctq5USU7bIRDs4UA8NEpHPRfIvZd+bfbffLmQU3rWYBKgs1HuVsIrsc3YbYKW3mUON8YT4kVzHCFNEJ80GXeSqWzjIJlR5bmtBeb/gTPgh7SlNY4vZtr73DU4/4s0Mo9oUFarJkO8PjmD4RqwRY4t0Z/BRBHmjxx1HrAntlr3cuDAera6VftcMrv3hEfbufl+KDwZoXYs5UdtxRr7NErDiwwi+JaETUUmBnovwrmiS1s/+tP8rQuDtcmZjyvCqNhikMdYMDI0AZLQKuIEcfgrdjNsFS+/NlZwcZZyl3IzvCTYwwfmG9y3+ZxcbzbtZWBH5FZIWq1ezsszojmstoP3spOSO+TggeHl4BdTgBsfg1GhW/SH5IX34i5rx4j15+Kk4Q9fIRiDVnM2mOrSwkg
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(6133799003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N8zCQqok+CHIp9a4IZIfSozlN+MCML1Rm5AD4cG1Y2tsomISEQjwy3l1gkoDJPbYGwaNpYUqpFlu8k7JFhCw5d6lasyOPUWA4So/PljHrFdC4w7p7432GIWCcLFxamWA1sfJrFl/9KpN9wPiQlgNXmGvTYvDQ66qIXl2vE3rezYwJQyoJ4YBAIeU5qvTCJ5fw7malkC46qD8oBSrFRM6kv6rJgMVp2bSdPXSnJlRvscXC/ozoZbjWiVmNnp2gcJ1hs1sm+BERtGkqFTXCDqddRW9rRFx1/nUJuV6ozN+1WAarhHpXufIG3qo8/hlwMQnDd4oXFI+SFg+Sd9VoQgY2qP2ZTdlsAQ8cnhoX+LaW9dZLCmFkx0CtebsKVS7ybYG0La7la9JvLqjq14qPscSOyHprsmzQMKQF1tBqgCN4ElYrcThkkASpPiqoIpoZprm
X-Exchange-RoutingPolicyChecked:
	UrTexiHO+R/xQE8nny75Se8Eo6jCnojkKy0LWYZQy2e3R2ZZEfFv7JjwmFWifuYtS6j3/clGixL4S5qPAEagsqK3ccDnr8xGIc59GA639wfYA29zGnym235B0V34yq+/AsfvrLzYmGmUK/hbe0Fqp8On/UAdmXsabQ6v58gYNM1LZuRHg4+L92Vi8xiqcPah37NzfP72KkUMkTEQxIe+mOL/TM1ls991gEGefuogOrQKxCRxSVIpsKiHasGcG6Wtcr5y6SHJ+y0tbCf622haz/HYl36DudEReUmBmeToLIusDrE0edEAcLA56EuYN4XGAqwh4P05h67R3zg8sDHR2A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:27.2920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e5779e-f501-4da5-2822-08df1df3fd53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5c70 cx=c_pps
 a=YKnEkNs9mh/nosOxSBBx4Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: hMlS2OEZPTxzceJwLgHUYvZpVa6UEGzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX5f0VhwPHEPVG
 gmISNjhLQrAR1RmSkWJRjVp7LT28QMAj1ICIKzjkFFk+d8AKpm/96aXsRxT9cGKS6ggXzPjX4/g
 uL9+3xPCkQbb6UQduh2W26g7agI17HJ9tv3Piz74OIseJ6DBs2YVmo+qNQjtbHy7bYex5typEcS
 rwMfpiv+JSrtCHX0uLh3jdFHu6JM1ZFnlMAa12Jyc1nMxPswFLZKz2xkMpPVCJ7lRwUdglDATnM
 BXDmoW7IO+SjTCLTmLhsetfjt/0pfyeKVZgWhIb0LM16N8175KNZTYy0LgpiBEkTe5Vagr7s0pX
 7/LnJHYWTfXiJmoC2s3hUggo0h0+H9l1E4uNE0jMGLRfPprXPXSoS4NTN2jptrLPpNgZw4hJbyJ
 ZPPgn/yBUYqEA42jjyc6dedfOBI+ZblVujgWtZ7dwOoSqDN2cqyizMtQ6D/sarkNY/nH9C4KsOE
 4edNYDWRfO+7+vNYaTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfXxumy7rlkdUMc
 ugXkD9rWV1KY2syLsP9cXhC/FBlFr2cb8ByMqgTNh7rF8+ZzslVGjKfM/AITXkdCW6MIiJ5dv7D
 cq7xWP1TpclqLEdqorGVzFeB3Dhvcp8=
X-Proofpoint-GUID: hMlS2OEZPTxzceJwLgHUYvZpVa6UEGzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 015d93680e5d..97bf58dacd06 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2809,6 +2809,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fb4baa0d3398..a2c46cc7dafe 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -201,6 +203,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

