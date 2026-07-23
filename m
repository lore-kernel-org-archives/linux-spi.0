Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E445A2B4;
	Thu, 23 Jul 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804629; cv=fail; b=NHN4bK7vBvOllrlsk7+UGhTIzUsT2uYSe403AClrAjnM8fn9lGMbvCLnWcqnseU3nGN3k3Dz280ZeZ9oxQjvII/tJB55ACVu2iu6sM4L/u8+7P+scCxy8+qyt/jPrb9Imlcx3IbytRH8KvmDVPiNwngC4Z6suhjsvAPTRtSOXvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804629; c=relaxed/simple;
	bh=9DQhRF1G/rF0B5GALQ3EZyhGRvGzHOF8xUyHuxCZA/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzM0dJwuT2xeVwZYuBcCWTeX/rvkbrh5GFu4ymlBfFXia5y7zJfLoTELanICElfS5Fd1G2JZgtmDtr6eCdv82vsVBCFEYoq7nKzHkl7PKEg5NB1O+i13jKjjx2WwkfOL46VS6NDTkPU9EeU2bjaSqLaPlxlno2U/50CqwnOfEgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=V66wGVZE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O//rqZ+5; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="V66wGVZE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O//rqZ+5"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9IB1w2039762;
	Thu, 23 Jul 2026 06:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=teGB7+PbNvdPrr/+A55A/D2LxX4bde9Z29W1r+wtn
	fA=; b=V66wGVZEXsnIzMnHz2e/YacWW7d/PfYC7xYCzPfjQbc9Axeq1zgdjwGIA
	HVHa8ECtfPJxxnL8aSkMIicVyZtGI+b0e7+86AttACbzJuh9C4vo5ELU3yUGGsmA
	mgVWYgvRB1i6Lc/EH4SZa7SQErXK8M0mPeKazBIZ79CmNTHiSyK3FdIqIcvNLhL9
	8GQuuJdrqAQsHKls8fce6gE9APthjJejpCVDTOVBcY4fSHlqh/rzV1EFIBFmwAVK
	BNPAhdKCX/zQvALpldKfN9cMTO7zvQlaSZBDRXNsGa4weQMxXgV23ueP2k4ChlVB
	tIC64nMCE0xVXPjlz453OE0SPT3SQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c67-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT3v2yGULrhZC4Asue2L/H8h/34Ipi0HAKIBrwX3ISX3Bwk1OJEX4QoS91vjJ3Vr0zXpRArRIs89Ta0aHI1gqHcJH3B5Abi4C2FNPK6+4d4Klic6rePMuPj6Wwfva1Wk6JGgUg3GtZIHbEGBStupHCy3uNhC68AguVzOunUP3GLUc8vHTvs5maDjUiNlJgMqw0IfH7PCrKvDW1HRUSTaBcd1IJ5M95KPmiqn4+o0HaEmHj004PUjPrVLygj/4ep1m3tY4eBZFnPk+LOtm1/k92/gVtnIoOpgV4Wfmx7lS84TxBiKgEqcgEoRGHmmTuyDOaSGW88/T0tV+L+IWXDubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teGB7+PbNvdPrr/+A55A/D2LxX4bde9Z29W1r+wtnfA=;
 b=MjixRk3KEx57Rkjy3z34UyVZO1Jdllki1jz7Ztz4PXwVOEto9ki7zxJEMJ0su7BzVCTmkUGNSIC9avvecNTOwjTTlLkkLSGbjTQQHW2RiSgqLVqGEOAd9oMoYsHMlZwaeQalICaAubiFBXE/JLevpAj3Jyj1Y4isgEaHujNJTlBun8N15RLCUGLgcejvlQqk8EhWzgk5FkY5N3cAsyl08ufQklRTwnVFSkbBzM7YZMK+lLxZLMZK7dlsR1q/CO9TZeWlkQ8bTeuHIpSJ68O181x7f2FQDE5XqB3ywkMEIRGC7OT53cTHmV4322ERnDbGVZyytfwIihIMKbh6SS5EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teGB7+PbNvdPrr/+A55A/D2LxX4bde9Z29W1r+wtnfA=;
 b=O//rqZ+5PnfL6maTqtuGYFbpr6GLlA514FlJ+n3VY3bbRDppMLlqafB4HAD/VWUh9o6umrv9YK7QkXr6uYR6zrVBM8lBS8eDRaV40J+dGbl7CIohaYIfXSPlDjFIlYF+Fa5pGYtQmMzLLbyyBd3TwvIqqBqjeHyOefkKuIL8qrw=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:03:30 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::52) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 11:03:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:20 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:20 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW51577597;
	Thu, 23 Jul 2026 06:03:15 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 09/17] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Thu, 23 Jul 2026 16:32:11 +0530
Message-ID: <20260723110219.3180747-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 09785edc-e485-4207-bee0-08dee8aa06a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|6133799003|13003099007|56012099006|18002099003|22082099003|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	bf8C1DT7VQ1B8e0PMVbJ+XYevEdE3Bcl5wuMv1b0Ld5eiQ3jLagfyPw9kW7UJ84N2zMZrtcR2jKdgz+CXore4LeTFeLB0BXjxQbvCnGMMUf3Gs6o3wMPjM4lFQ4+lsqxBDZNSR12MfPpLq9Rrtgzv4zBvVUr4vspzDDH5cW0YG+6b4YpUU1whrez4WrvQN9AnuzHSK8GgNTAkHp/2rkil09CptA7ERCQd+DN00ODtMkQ0a2tRPEVUzODSs1xgzNQFD4jQr6nhRljYPLd9UkdzU12xEFc05jSv8bmCsxYiAI5F5Eku1liFEFH/KpQWJasv1Kv9b4snT0yxHlH6jHzAx3zve97WyOaPf96EFgg2JA6W2MK8lRfcAotphhcG9TGHfNLEjCVQuHzo83NA0WFr2vyVlpDSFbqzoo57InFXI9PW94IGGpfWVWL37mxGYRH7p9gvtDqIPjYRCklsNVhi9XDKCXMFgFkwP2Urh/Rb1oV78UqvXO9+GWCFzMYTFn1XpsfHvrj7ZdtC8bA6vpEqdMh7yOWVrtXBA3Q4URVI9jH0kBkbf4+05g1W8xfOURxajgO4/Rs/OMU/IefO+bcA0BPDDT+BpXDjQFErmAUut/A+JuXl1Dg3I8yIZtATmeBJyPNs77zenijXda2TX9/RgK7EPhBUFQKFtRqR4TFKhKygC8DZlCu2WNidZsR/LPuurK7945aiCTFv8tNKT0K6w==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(13003099007)(56012099006)(18002099003)(22082099003)(921020)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L27yr59aLdFTNzIZ4G5fwscvE1oGGXuhW+Bc27U5XCCJsT38DyY+dUXYdpGPd80R91krn+W9WKiqYITEWx4hSggOxVm0/hBWfp5h87wWNln+CL+TzklGPjZg9fockJHUz9jn/4GBFQwoc0wi099cuIW++sRdIVtQjt/hF4BOj0Q+ozKCISuFso+Uu6+8Oq5/LsbIrV6BjEPxWUKcn1nsdejScQd5C1Cycsu0hgNn9rez7UtOdizbo/R7/Iyy89hRENmyqMaCIDgLOElUk1+BqwMEkgMXdDEm+Qr0EPgkjPyCAk5g6oWrEiLTdc3FRa9V67HTkKm21SVRbap0yba3dD+k30JNTfQI4OB5owJ5a/SNhZlC+A0ce0VSZZGLl91qNGefbhNeBbzFjUYlaDvzBzLu966pMmPmQn2BLwr6TL/sdAPot03Rwslf8cZrw3kU
X-Exchange-RoutingPolicyChecked:
	o6b8zM96Rx+R6lMKynBukXAt6ZJ4EUmupBySzuTWiWZImCzawW7jMC9erIZgfeOPC32HV6fJScsK7/BaZZZV7xKmkwnAB/mgZTSq8NyKE2aC+ESOYAG71uejOz5B013LDidPy+ir/uFlvlOfsu4gSMhiUCBQvDR91dHrMURPhZAx6r+pJ5GRSzzIxaf/C3SIAtuvWvDNpc8vH/3KXv82n62GnsMTp6O6TxMxZ/cO7yqU+7Zh1JXtoLLyQIAQHUojl4Xtik8beSgRw/AVOYFDPDLL7ZXhoUIUDgSNVZ2qY26socRjgpeScF4ZbTqiIy0PJzAcXZxMu77+PmqZWxOACg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:28.5704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09785edc-e485-4207-bee0-08dee8aa06a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX6NvJoxKgXZEL
 AEpAQ1ENe6DxUEXl4ASD16yy6i9gJWrWlHUzB12qG4H2AldwfjBxj6RPqh8VCfddlAMNzc3jDR1
 3D2KHQFRP9Fe17WK0RAHgDn9mR8JJ00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX8KG7g3XCoLiY
 NtRamrE2JMu0foTEzldS8IXM4o5osSaSpPYPgFkYCJYzhPBeWY9UllijfYc5bNkao11qOu7u29o
 XJIQjKDxbIE/dM9uYgftviGWER0fMa0YkeISRb0JjqvGBPyf8V+Tx7KQjirDUo36kFlR4m0yKrp
 i9l8MMEOkd6iIIOTjWVOP6oZCQn2KZeY16P/sQu2GkVyE6yVudoPiasRPiQKdfahOxwDRGEWF9C
 YQ/sGQSFALfSe7sAjF6HdAtFpAAUjAPIrLuFe6EY2bQSzsUC7QIgDmEvuwYARLQlggB5Zb3mfBc
 pGof85LT26xJjPa+ZH77K8Wkzio55vcaynTRfKfOTsCCgDoMzW1zPysWEks8xZ0pM9Zt0eFxHFU
 VGtCAEx7kOnTmgLd5tHKUAt8KhT1MT4NtoifHXij9uSoqqQ2MWVFCbA+Qa/lOU/3qRdOCMgnPb2
 huyS3tr0siMpWUm9kqg==
X-Proofpoint-GUID: 6qG5UXoWv6BUzgG5X5p6lbGlgKTLjKO7
X-Proofpoint-ORIG-GUID: 6qG5UXoWv6BUzgG5X5p6lbGlgKTLjKO7
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f507 cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=T-kh0MV4vbdY-aS4Zb4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared — the op-skip signal that tells the
caller to try another op variant.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 43 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 22a5c88bbd8d..5070ffc53d5e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,19 +37,20 @@
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
-#define CQSPI_NEEDS_WR_DELAY		BIT(0)
-#define CQSPI_DISABLE_DAC_MODE		BIT(1)
-#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
-#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM			BIT(4)
-#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
-#define CQSPI_RD_NO_IRQ			BIT(6)
-#define CQSPI_DMA_SET_MASK		BIT(7)
-#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
-#define CQSPI_DISABLE_STIG_MODE		BIT(9)
-#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
-#define CQSPI_NO_INDIRECT_MODE		BIT(11)
-#define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NEEDS_WR_DELAY			BIT(0)
+#define CQSPI_DISABLE_DAC_MODE			BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA		BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION		BIT(3)
+#define CQSPI_SLOW_SRAM				BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR		BIT(5)
+#define CQSPI_RD_NO_IRQ				BIT(6)
+#define CQSPI_DMA_SET_MASK			BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET		BIT(8)
+#define CQSPI_DISABLE_STIG_MODE			BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM		BIT(10)
+#define CQSPI_NO_INDIRECT_MODE			BIT(11)
+#define CQSPI_HAS_WR_PROTECT			BIT(12)
+#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3183,6 +3184,20 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR) &&
+	    read_op->addr.nbytes == 2 &&
+	    (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	     read_op->data.dtr)) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3829,7 +3844,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

