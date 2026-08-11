Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F93D891F;
	Tue, 11 Aug 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473314; cv=fail; b=ixXFuwKlHKuHei+QHqMHNnY1m0p6HnzKTQF+hJTSekHwNwqAB3lUMBwShr+n35Hj5iZ8dL4XjeWdgn2QMuivtTyXMZHO7S/pV3QWR3thgTxopOa9QeZ0nqUNcRRR67jBNba2UEgN5OUz6rXrNL3i/ccAk/7wgJiOJw9NjoSlo4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473314; c=relaxed/simple;
	bh=hq3CAzkpUTFk1VJMd1fRN0aOyH91Gsjw88BXwndIXfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2Lq4RpaKZ0cEr/H/12wgsVLXWmY+BpP1OtrMTTmSpCkI82dapfejVTNGxd7VBvcMXO1sK98/2BUM2mNXQKyhmWKEn0WcYjUrVgvY08NshLV/81JSplSeWKJstk+y/ragZFAJJop/R6hbGwxoAfqcw4ZXESU/IXNGHqjaww2Z0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CVK/hsC/; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bwDu9xgq; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CVK/hsC/";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bwDu9xgq"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMa5O2174814;
	Tue, 11 Aug 2026 13:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7
	i4=; b=CVK/hsC/+AbQ2cwd24hxreD6V8j94Ps1D+sCfmIKPSszKX/zMZGfKvA0/
	LlEU/cKxmTxecTnCGcEt/5JTlG1yH/5oPcutI6ghOOyn5CkHWRlDr08Zxr+rrCPT
	Ay4SzKHf0uLG/8+Q7fDO36Mzhm3YVjRLC7gc8ToqoFDHFPV2If6h/uP1Q880Esrs
	4VN2xpwRag/TUSk9Wd32EqmKyqwNNo1WENu9jSavjoHkIhuy1W9aXitfthcO1/o2
	7G5bswHw5pPT2GBmJBHvSRKH1JfipsVpjH0Hf1YEx9lDoIlJjKcSl4zewHdKfQdH
	VOdOyJDPAsreTv7/t/TLjTRl7qK6A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uj4y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgm1Pmoi/88ER2/LEPPsivjdgdJpEe7KQ4rpznMSKIAaPBTorElznt6gsg7Zh3EMQTp7y7O5jtDWCr0K8+klmsyrdvHiJtdvSt6pfTkimCUM6P/5fpVz7Qz6/LXihfmk/v3Cuu0q+HNcoW886MR7s+W2nCSNPn8w1D7IrJWab3poiN6zipK/S/RY+w72aN+5QVAGlp4spFZ8sCA9EpKyLNYebYB3X0aFLq2TqWXYmMpzvWnxhWaIJ4ydinli0mAkp/H69C94gjDEK0EB3zGd1p9XPD9c0j/x5mR6Tm4h6z0XeuqFUuTv+ZCAj3IpihOpae+IEzbhxTz5P1W4BXmr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7i4=;
 b=zH4iqARXpepocEsQN5HslrMOj3QkoPIfTer6GNU+6yjZFrtKXI/Z9dqHNO2q6rbAqAyMlQ9o51kP1kQ3eQIzj8IDWDoHMSdbhjtdkNPf2lWpQZtbyAeKwz3nc3xwA5vr77nMHOABNSbKVZwtq9M1hYLSYnKm8jiTOa+o7/s2e9jJls0+o3Q+PXPbQZkQsqy6AmUa2ySxprCyW8GV7jFXfBc50fVS5WT7SOJlKrSJDcRTfZCRCkUf3k6wd9G9uXEJoLvgirz2uVPIbSjk83z3IufCJ3p8lH/mlr5AhNk3yU0ZLC4OlqiptRq2LTy1149MQ+o0JXCCGdIS1AGWYBhtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=320EJlLRqwG8h40qGDXjoLwm6rLEiZlkRgVW5kT+7i4=;
 b=bwDu9xgqQ84kcxfgEXiin6tNQmdA3r+OFGmYkhXBWWNWVPXrinyFYG0+6MXMpf0EwMXzQNwbt2xdu07DRCTQ/1UtvELkxvMJ+VVggkjenr3B2n/GMXDRUgcLcECUfEb7Vu8Xcbj36iREB/aKVYvr9a+ErJRDLn1TFP8Yqtbly8Q=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by DS0PR10MB8173.namprd10.prod.outlook.com (2603:10b6:8:1f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:34:54 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::58) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 18:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:53 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:23 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe4659766;
	Tue, 11 Aug 2026 13:34:18 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 12/18] spi: cadence-quadspi: enable PHY for indirect writes
Date: Wed, 12 Aug 2026 00:03:07 +0530
Message-ID: <20260811183313.1550425-13-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR10MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3fdb63-0b34-4a69-cee7-08def7d73c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|10067099003|921020|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ek2hI1FKEZp/ySqNomUVWA4+4SOTQiUjq5QtjDYseknoru/KFkZJubmm73nE2+HUhsZgOInY8QJR3m54hDvppEau9ppMjamdUVqogbWuOUi2TsPSB5xVzrLyir7s9R28jKDXA4Ms43bCE5CX83wprYFnsy4+4Wkk3+uuQWrV75z2wTrdJ+3r2c+In/B+9bZg18xFP5vc3gE5Wyz8geMTuJ5hp00Q8nMajrI2BFBoOzL8/W36XCyaZuOp7nzTymR+x2r5xE1O/a0257Y3uCYR3sHwvs1L5fI8u0t4NcWhKpyq/rS9gKUk/OYI9Wbtip4tKAJ7XFlFxI4MqBCeYzpwgIJJ68m7fZtbj9M5Dk7oA4PuDKFzDRAnU+3gac204e5gX1RN5MAtHke/f/gEdd69avhpzvwTsp9RZ4pTzqfxZWiPBJ/QsoojHo3bBT0cjipXvYhJDB3kBmNk1RPZWgx3SN8RIyaJCSxOAPorq3ZQ2R8XoMoQgHA0vx3Kx5yoxb4LDISY6Gts3GF31Sk7co1iU7Ex7WB/cRSWkFEdiPtOxCpuz5oqHqBaP0L1nfKnEdeilNQUNvgW+ET0Ns++9JIVcgVtCcX1HjoJj5owsin1fKyOJ5i0okEgZz6Gq4No1PTTshDxQN20U69/NIWHlvDMkWlab7P4+gde6iTd5YnsQRNyGaDbXzQUXyXYgokpShMqL6vB7bzNpq2wGwN8pc0+lA3qByU5WkYInwVHK6o1ua6ERr6CtlF9pDnMfteMTEJh
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(10067099003)(921020)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i1AQhxbffWW3LH5E5XnXQgRNWags2lmILsYJdK4QUG6rs7HaSqX/7/HRd6P/f157G5pi+flvto6fGg03wnDVog8/aO8nwxbBCQRO1QEh6moJ5BccZWZZ3KHlnTUrW8NhCrs+owQzisAQViZ8WphVDmh8zhw93f6RDOMvYHLXk6SzjMWWwVHrgeqPgqk8TZ/qBElnidUE9OPht66aAUOa+/WoJTEr8gKpFcSbp2osFgFFRZ22IdsvfEgP8spxqMT43s0EWNmiRShWBenKyuo2ZXa6K4aeuwKB8gGWTJTOjv/CjQoflmoGUnFHzx1F8BD4Vd1UjnqIV0pP2IDsBl55K+qtIFyHQVRDYm4IFEdekk95QhJxXqa86L4++ZgFm3NN6TcCaMx3TB4GkS4fmSOPXB1Fsc+c2ER3WONS27CKV58BrvdnQfbVVwZqWKdsm8I8
X-Exchange-RoutingPolicyChecked:
	FS8GTgRiAGah7eIwL7w2s2t3/jH06/RfNxLqYz+c0R25xTo9ns12FMjXZI+5KaT3QnuxOAywhz54lP47LGBCLEECkn58GJhv51vAR4JjZ9zRiOG2dlYHDD5sMALFEIi6rtwkX4kDENpO5IRdOpLUlUtuaYGM7hGAG+jIopqCwZeUhu2i+CutczXd0v3MfmbAfOHwrfBqaZjEVISjdQyP3hZdQwWsdoe4WWbkb/4P2qkONpr6ai71qKP+2r94HKPQuEdle4cPuIq4yaGNL5SelsaIZDGkXIjSsGhRKqEr2CqBZ/lySmzFlX8DRCVtDtFj1n1fOWgw3pjsF7U48TxL9A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:53.4492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3fdb63-0b34-4a69-cee7-08def7d73c54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX1UPXl5TREt4r
 mpMS2+ejYNTiKWQZk7BhObKO/FNndTIYHJePQbC+G0nj8uKoPgV32pTJj/Em9X08rpFTFEkQvbm
 zI5m1yn+nQliGdzyhW8Q6XxEJz2KkbQoIOfCnqvsRqQt9ssBSi2gZmfrH5PaGfWDFmKeb5lCuMf
 z6Puy62MVSiTrGd/9e448HoocuC/7v96cj7s0rYO8/LKmWUXAoT4w3DiDoq/u6ndpFSbqfZMLLf
 eb2lgzY3ylsnRL74AjA2w/x4hTjLTEZRz+fY6bV4jMEwU3GHeIttHo5j/nJLCX/ApDJSqygWahQ
 RBB8lQ5b6nXarOyEkZrKf2J6pInCh8/QkqNO9gz0pPUE4lkvutY5LAU4SxvifOn4Ejm1KCF3+UA
 jPyo91wproftqbfaLMjWSwvv9/I64VtQiMnep3Evbc0jl6MBxSegtBpxioYiwVg7TbXQqjZtxxc
 e/MiQ3WB53/gI9d3YrQ==
X-Proofpoint-ORIG-GUID: WVvVbxXH7Hg_2aqhWod-21F3TQ5xFoZ9
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b54 cx=c_pps
 a=97Y4xzKGYTGm8d2IOhb7pg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=JqbSXTAX1eT4zVGs_pkA:9
X-Proofpoint-GUID: WVvVbxXH7Hg_2aqhWod-21F3TQ5xFoZ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX+Y4VPnge3f6b
 DtePq6MHG/fUI7nNetehwvXcPOOZdC7+804JLzeNxP58CWJHcX61IXVkmfUM6tcjolN96Gq3BNx
 szZNJoBj94iGSLEQjUnXxSPJhVv0Lj4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. PHY is activated only when tuning completed successfully and the
write op was calibrated at the post-config frequency (phy_write_op.max_freq
matches), which restricts PHY writes to NAND devices where a write op
template was provided to execute_tuning. NOR flash writes are unaffected.

The indirect write is cancelled before disabling PHY in the error path
so that cqspi_wait_idle() inside cqspi_tune_phy() does not time out
while the controller is still waiting for AHB data.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8903b4cf4f6f..940cfb72b946 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -157,6 +157,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1362,18 +1364,32 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 					loff_t to_addr, const u8 *txbuf,
-					const size_t n_tx)
+					const size_t n_tx,
+					u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
+	bool use_tuned_phy_write;
 	int ret;
 
 	if (!refcount_read(&cqspi->refcount))
 		return -ENODEV;
 
+	/* Use PHY only for large writes at the calibrated rate */
+	use_tuned_phy_write = n_tx >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+			      f_pdata->use_tuned_phy &&
+			      f_pdata->phy_write_op.max_freq ==
+				      post_config_max_speed_hz;
+
+	if (use_tuned_phy_write) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			return ret;
+	}
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1452,15 +1468,26 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 
 	cqspi_wait_idle(cqspi);
 
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return 0;
 
 failwr:
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
-	/* Cancel the indirect write */
+	/*
+	 * Cancel the indirect write before disabling PHY so that
+	 * cqspi_wait_idle() inside cqspi_tune_phy() does not time out
+	 * while the controller is still waiting for AHB data.
+	 */
 	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
 	       reg_base + CQSPI_REG_INDIRECTWR);
+
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return ret;
 }
 
@@ -1590,7 +1617,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1617,7 +1645,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1810,7 +1839,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

