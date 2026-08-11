Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8F37F8DA;
	Tue, 11 Aug 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473244; cv=fail; b=LNEyXV6HXDwlA4T+ehT3FQ3UxdRrDGS62XWqrm8GCGyv9U+5iaL16wexcVi7eYKiUXWu1UBOfw+BMjVJp3IxrHle8UlH/ALyOh7VdOwuv8sj7fGGlLdKdZbY38JbqdHnAtZ0seKoy2cmZnMN39HBcXu8/FJ1STahtqkXK7dFNUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473244; c=relaxed/simple;
	bh=wnERlqfmAuu77gzReU3OkSfWMkjsuLlHcKXPU3t+tzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O+SfialuuGJo67y7xfKOwUX6JoK/VIthhXDjFw4kfFx935/oIfncvOKkxpfbov4Xr6o7H1cC0dLG1FURZnF+rQaxwJNNCIy/8QOrRneMD4D0RCEDXRc0AkYFHQQ9HXfncfaved0x2iUpfPudyADMfRerM90mQF+twqz6Hn+Rgkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KZxy+UrW; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jcCrraPs; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KZxy+UrW";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jcCrraPs"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67BGMJDs2014146;
	Tue, 11 Aug 2026 13:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=7bnz3FJneB5J+
	0FWvXl0RenCnLHA7QUsqoe8rUYxZ34=; b=KZxy+UrWF7DE0Y13Cl5+FAMiHkDUp
	SenUblfCgqczp1ChYXkqIHt7Ik7gWXZUyEU4YPtRAghrE3gs7XrzZwIRwJkaPoHA
	UPPfWmCLgf6wxXCnwKOyTCV/6KtaTmO1e2PWQJ8YluE0hNHjWtbA5GpI7noLO/VN
	hfx6LPfuL4NMGZ0HGH8Fk7OuIMWfz11sSRc9ZzlWsDvttD5InSokV48swjYdov2B
	GVqARsmW22kcLUYBdQDtKKVEFOyFmOctC80Uzz8zktVDLS1qFFXLf9e/1cGTDYDi
	07AVPOI+Yi0QUpOMI9oI6hNQfGQ0wgK/yaeuOoxk1Bv3vCqXNei7rVB1Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g02pbb2w0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:33:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep7iOB3elpGOaAlIKx6929zBO5e3PmWjd/ry/OhqayUKtwuY5/hf+Z6wdXtEB2rCpEHJ/mYnnEWzyyk2bH2XFsPWRahLrId3Jcdn3EOvEQFtALle4bSM8BlnlP9kNYiSsufnI240YBVk3adqupBEx3z/ohWtFIaTgUVsxgk4uFthTYnyhaBTQuaBjeouPS49CcizqCSDS1Oe/YE5Qlz1CzKPmTBg35lLk5gUzRLm1IIT8RcKwRvLogyCpKtZZebpWYh9CY7T3rtXvY8vqGTucNsWQkK0d5DPgEqnyOEvtJbMHO2UzECqtMqFB/oSdDg+RVwdkJ5/DtV392rHwwf2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bnz3FJneB5J+0FWvXl0RenCnLHA7QUsqoe8rUYxZ34=;
 b=K5AigzfrlnXONgItQsLlH03n7d2IFG0AaisntPA4R4pdQUxcKKZLkn/iarBQEa+nwsP4kCZiV+lbcrpOEa7cO1uj/Zb1wEeViv8z1OMIvm4xd5xSUwXP5OfoEHE8mYfYUub0q1AZ9/+DF4XBvdnMJjHrYRtlT/lu3QN7jh/xKzUBNhqjzyA+Nk1gC/qgdiFkazPSdN4OVurKEWdhO00RtyaN8d4amqZveOJRnhtT+mIRT210pT+eKy2Oe5j9Mzw+gEKZ18ApkYR+XJpvZxYeVdaxFaO6CMo+dFa0BxDU9hHDbhl/C8pByPQojVRxd9MXD/JFrH3T5sk54bH4f5HT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bnz3FJneB5J+0FWvXl0RenCnLHA7QUsqoe8rUYxZ34=;
 b=jcCrraPshzAPxaN1pkmUk78TwDZ0rT27Rzwv20PjWIhJOGVzY8FDaN7SKZVnrajds/qa/FvKHRSbyybRp0dBPldl6qhAo3g7JrXqC61sDGilpaawIp8UYWQtF+TVaRp7TRASKLiS6Q3VqqV/YQvQclUamoWU1dm/XM/8od+t0lU=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by DM6PR10MB4188.namprd10.prod.outlook.com (2603:10b6:5:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:33:38 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::9f) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:33:37 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:23 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:23 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdq659766;
	Tue, 11 Aug 2026 13:33:19 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 00/18] spi: cadence-quadspi: add PHY tuning support
Date: Wed, 12 Aug 2026 00:02:55 +0530
Message-ID: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DM6PR10MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f2f5f0-6942-4a15-8bee-08def7d70f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|56012099006|6133799003|10067099003|3023799007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	TK/kZor5OibSijI2wdmfa1vufIyFrRrFjnsnUnVFvpUBDdHjgiUH1/S6srN6fLlZiIGB1tgEaMD8CeLOSB1UgpSSzFUOEEoGdSKVYod7rEQNBFaAL6KT9CkhY+fXCNgRLT7iJyHht2OeG/c0Ma0nDY6ZSJIGOQRAmXx9LULtbeNdMvXUNzsfqHZoEQlLS5j62A13UEVrk5DpEu4kBooYqzVaigxMqNkMHfopqY9K0ARkJVrVgCprOitL66PbImHFU2LpbgbnzlSxyPB9w3eTLpRvu30TB2b26u5g5x3DyegGVhVqWxrGfu8K0GxRYUTPO5UYAx0lagKCzAAuHGgIfSrFBe8v10xYt+vg9Nnkq4Gh8jCl+dTGK7i8qEUKpDJd/9pF4FynFXty55stl8uCIRmU2BBCGZGPp3M+CGh2swBnds4q0UM3ptDqeJrEUbiM0TuzpKw8SEIGzz6VAXbIjSYXLnM5F9xAic7CZSxOtRF3kuf045YKqHbbGTetvDTvg1QnnTLQhInywDZXBjj0OMEjpREpD+SlzaBKi5Du4hConQCsP0tqbw6hDYA2Wy5EfTP+PZFNnxb3pctX3hRKLZGThuYxx/LjCM944cNLMbQsTdwxIR3Euzk+ea1GO/HtcAmx2lD/K5eXB4xANkwDV8OvbOpR3npTkg/JBMV9DI/FxcS7tE1SJIh2AdGzKN4GF2lAuw4RZSIEgzwp46CaT7thmoMjXRvc7Uufx45k6Idi4yScrDKpyUDg6q7DGDtn
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099006)(6133799003)(10067099003)(3023799007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vatA7ZvWmEx3yXrzOsnfGZzpwqWctwgOfD71Ey342jnQeJfLPNBexIc+H6aSY2kYmPplfcI+b76jBP5Ioxj/NylrWlqvzKF0T4SB76WwH9N6KTv+t9GI2ltgBdTf4CExCI7Ezh0BJ2Yg0FctN4zR06iViALWry9uaNpIX5pwGd5m5UlQFXrsgG/Eg6qj+HAfmrmoeB61vrm4IrhGFU0pbnKBeA3k6LfPdGSQ1QcbBcASl+pBzObI1SPP9VoQig+br330jEVpXu9keux8ddqCLYc9FX+S7QklI4MHJ2OUJFNu8OrQepxLDFF8NsnNJn63gpe+ij50bbGkH01zWOR2VSaEMwjOegV4Mvh8HwIu65fbe3RsbybXunnJ+42ngQG0XvZ8gOlOB2MhW8RgTrHGRTKqnJSZ7geKkXo65XZ+GOEOPYGhBCrpIZx82UoHdWv2
X-Exchange-RoutingPolicyChecked:
	gQ+5Di3JbiWBjozgIFlpxbja9adHYe1mKIccf9tL8WhbXkBZn2kHxp3FJWae7eLHC2gZ49YiETZe1hiO/wGfDRrmwzgI2hNGx6rQK3Y5Jr2CdLDp1Mft5+veG8gnSXMOyFRcqeS8TtJfsk3Dxo5MZu3Nrnn/Df/+2ceGB4E6XG31F/cjFig+kBzwPonVZakRsPYmsv9vhFyfGK4MVTh+EJiVWi+ajnONYUWdK9ibiT6SeJKbctNe4igq9WiBP+7hKGQLeeQADYYetkdQfydiAvMKb2jTkq/KsTNVhri1LStnKdUjnPDJHYNtMt7deujyTTR/7bgoJL9Os6R3oAOuzA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:33:37.8024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f2f5f0-6942-4a15-8bee-08def7d70f3f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4188
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXz3GpIg50SPlQ
 HLBhUaYqjnBCMbq4LSsI8sRdXsNFmKRJv7o+7+b4fJ+atLqFBYvGueTiRcVDvl3Z4MjxXPf7e19
 QZBYx30s0rFuFQuuC8hXhR/8ZduQjXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX+iEyG0O7+LJq
 Tykh9xDaqAEMuptkvo1anHb2S+Orr+xqhprXefxuIIKesiVQ1jy2u0xAH6omDDEhtlJS2QsM42F
 MfsElogVniVZ8VLzDuuhXl2ecV+OcXtZcXWkZC41zdCl4Rfto6dcxSlnoPPpzhMPp5c4oGMoqKk
 4FlqtWH5nnG/w0LqEgzPqj4WGWXwtgFK+PHqMjwi7YSrz6GiWPURo8GqJFE3GKCShRoMntfBfoM
 r1FAgrcM+c3OxkxK7cHe23zQi09bTbz7+mKBOJtJskjJUjuuXQKPwxPxLjWMqTHP73HtdbEO2kP
 Ob0eQLNijsoFiJ3kqp/0BWUzwS3LL7I2dpm4x0ocpT5/CHISUOHN4il9BzouOwpsaCnFHh9qcAo
 27bh6yk3+JbLh6k0BtEYek3678v7r8cVi1UbW3nqO+WYD/nrLakP7m8bYGJlgj2/eU4GHCtOg6m
 mPzIXPylHv1PqfP5M/w==
X-Proofpoint-ORIG-GUID: cStMG_jifiOyIceTUPkKijgWdh-oX5dO
X-Proofpoint-GUID: cStMG_jifiOyIceTUPkKijgWdh-oX5dO
X-Authority-Analysis: v=2.4 cv=Ic+3n2qa c=1 sm=1 tr=0 ts=6a7b6b06 cx=c_pps
 a=GYEwMlAgQavT3rNqZldEpA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=dgxhBYzsHcwBPZuLQGQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

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
              across ODTR and SSDR interfaces
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

Test log: https://gist.github.com/santhosh21/79c89e104e6d35c4071845293901e3ad
Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v7/

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
 drivers/mtd/nand/spi/core.c                   |  253 +-
 drivers/mtd/spi-nor/core.c                    |   80 +-
 drivers/spi/spi-cadence-quadspi.c             | 2280 +++++++++++++++--
 drivers/spi/spi-mem.c                         |   55 +-
 drivers/spi/spi.c                             |    2 +
 include/linux/mtd/spi-nor.h                   |    3 +
 include/linux/mtd/spinand.h                   |   11 +
 include/linux/spi/spi-mem.h                   |   14 +
 include/linux/spi/spi.h                       |    3 +
 11 files changed, 2541 insertions(+), 190 deletions(-)

-- 
2.34.1
