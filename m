Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD53A0B38;
	Fri, 17 Jul 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314375; cv=fail; b=X9lE+ltRuljZrpUmnbFAOqLdskQQRYv7GZ1zCwogKL/TDe3YpmGPDBzNaCVveS9uoOQ/cVfPoeqF4v9+M1nulyF8JkBeUK2NthIaCmG9EKqN8nrkdjhmozT9NyzYc6d25EdHilx1QAnLyeb7uINqxy31NYHW1MjPvPihJxR9ciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314375; c=relaxed/simple;
	bh=pIn6FQMQVRmpAi1OIWqN2WjNohkALTG2Vfo107304pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk/Wv7hcqjgjyA6zjRuov0pap7/vw6f+vQjbR27ojJ4tQkPhB30I0yc61br2IdVZHiGuIrJ0kLgpkqJ+RPEmZT9Cu6aobaqbNk/6gSMLsnvCYO5RQuoB2NHk0s/CGImRNtcUR2BYRRJWNNyptbiGy543LI1QfwdZ6tsGVliT63c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=iPK78LUx; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xuz7YDNj; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="iPK78LUx";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xuz7YDNj"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlKJm3222741;
	Fri, 17 Jul 2026 13:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Ql
	kk=; b=iPK78LUxrHeSVFyQGEheOmfuoh314U785Ib6mnsrJhe7Ew2Ca8iMc0SYO
	NlskoNCqgdpAHDrypMFGRZgT6HNjPnqcguIb9donJWp5gt8OLa2lZpJZBHx8f4Ms
	EJMS6IbVeuVTt60/uU8anLq0azFJrp/E64tKFlFXDyajfQUm4twi2/xcZIf+ofE4
	Lwffi/9aNvgglA6wTX6nmlAVMd7ral4ZLI9o5jdvN0Stpz45gpWdPRbgqw7p1kSd
	p/vZCNgBuRPXdjHL9JQouYtglMKYXAa2pYyHB4XiOUdrgKmO52hdQMENIu4+z6sq
	b0aUUZQEZSZW/bmdTDMcLaMgyevrQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3ju1c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFI6DNW8Zr2q9IJAI1xrQBRbvHKHN4skOI11gSOkNLMIttwpu+cfaHciiuUO04rTPbTN1/6KjJw78YfseQ6/s+XJex8sKYX+KJDdflUFKhz7TiDnSkj5d92p87JZA4cdBHXxfvzGmhOXhtou1dtZEiDkd6m2/nR4FHxopskMFrco7dXZZy1E4TFemPUUiREezmS32Ut+2+SlrzxQExc1NEfeTGc6Rev+xb1zg1quFubPbHupIAiPamsWjUH160hFOzyCoZN3lJSzHvBeWM4/EGXc8RzNH7fZ1dWEB9uWWCczrEKTg1ciugSDjORYIr7Nw5AB2O86Kc73UY+AQS1Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Qlkk=;
 b=mdmEiPF6vJVuCm63DeHuoDBmrAeiXjYRz0zgRnRVQkjJO1+Ro5XSkM7PvyjMwJj0krgnk1CXDPH1Ug33oydbd7qD1uVRxyRkvQ0GSpXjmWg9nhcIhO2o/S6YSYPpwaGnD+CYbwJ+kIi3AQ7zXwF58ikkjE1jWP9VyLSaOpTzCxB88aP7AXsKAPdW6i0OQA0JzRl5+shOprW3o0vAIjXHo9ODSmTXYtHeLrhoO2kTxYHNoRbQ0RL7dezDJJNgjbxkIF5OEHczDrsHR/R5+hYSdxMzJWjhZ9xHEtbTXez8oRwDhjg6ZZrJvPq23HJQpXijqXmwEpz5+8hT+EE2KdL3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KQVMFD538yJ3bW7oX3qUKzdhPkCw69tpRcHsh0Qlkk=;
 b=Xuz7YDNji8ALdCv6Yra5SG0SHo7MDyGG8v5lwS/nngbxIKFsq9kcz9L5HtRNoPiU1n4TtfvfXAIkneEQ9u5jbN5CsyUpkfoFarGlOSpOFCsaNcy/uJgMf7yVzVcnW1tSEEBwx+OR/PD4rymz0lBui3+zHYnnEC5YPZiAmaGYTfs=
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by BN0PR10MB5061.namprd10.prod.outlook.com (2603:10b6:408:12b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:41 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::e) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:41 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:40 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:40 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4x240969;
	Fri, 17 Jul 2026 13:52:36 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 13/17] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Sat, 18 Jul 2026 00:21:12 +0530
Message-ID: <20260717185116.2065505-14-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BN0PR10MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf41d07-c2fc-4b09-b7dd-08dee4349481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|921020|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cS4xHRvP65ayRknD8S32XEwXbsg8OtmSCXlK9l+4DHOn+L9+RCKscqXdGQaAFgDNRAjt1GyxewbCLjhIe+Am47WwJJ6iU0mKtCfRyS/g15KbcrGNadONhFEXwX2UaDo68fCAbVykEUPXfUCxYK/2RUBaYdyxdCdM/NJl54Yev9kCRPcza/UOvGMBwP9HiaAlz+Pmo08XBbwY+Q8YrXcj2yvTekvXkAtNQZxZI1X1ixhdpPxkVbP+O1dtcHHnqdpPI/chvWAIfu9UwJcGRrx1EfgcxgIsmwTrk4hs93XUlETVQ46xv5GBZOR4Uj35XFCVDpEBBaPf1JUtTS+BnnAtdPUnknb2RbVDrfAxx5oFOI/kHRZdbscWSjC0uLYz+fi/fE6KkZeYkZY81Os7jLzaIfmbFf9vmlLc9Om9PLM8ESn4IiuRwckYnVOluFKI9edsWFQrxq4jLRm+I3WL+4pF0fyrW/+XBNFR7P33CsbGhFvTeo8bRQ1cNOZq30OWZS20K0mCThi4aOOx5uhC6SivecOTi1q3LiEcqJrzj0p2hk3QYhvRD0JUMPPgCtH8mgPNJSL93Wv96tI+yQbzp2aZcM1t89ebPvq9oIt3kL+QRBQACG/Z9sfAY8WcyjYV+eds6WlOIp7holFYDNmA4wKZcN+Pmo+5MOPfxVzx1RkRWJV35K2OL35tREqxs+iZEKvLS2rkwFdVQz6Xm9ba6dy5iFjn6vjr0kn/UiWWpodvv2HoP/6ugjJMYNiRqt2eM/u8
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wtl89I2qS0pzjvIyIh5+WGto3iBY6elxj5MkHwSB7ldFMa4xr1kyg+0G+uaKq5JyCSw1wso5rGWeCDX2XQruTbF+d4Z+dwVsITk2m0VnM/9UXNt26D8zBJhzTjCiy5ODm5wwQokF+g+v5oznDRHoiRcgqfRi9/+gBvEBVeiGDbTLcVfkJ+rIvF1gL4fIUd6SEptGINharJ8T0nuU6ajWSm9hCJGzOHVikVcnWgsbxhnvreJd4ICVcPkhx4o6RLQsDeWpbIh4NNuH2/znUGhKuBwOcbb3V/4c1cxOPsmFBiyYlzEPZehLmYGqJXkcUM2TFCfsUlkXjNED2rmgc3RIlDA8fQONtcDSxWL+Am4FVP0XVGgBfZ8DEIDq0VNoQKvAJvaU8Vcxe4ksf/0KMREVmHkAM9NvVLMM+SZgA9yWyXyOes+kra4nTJ3pvRHuTkc5
X-Exchange-RoutingPolicyChecked:
	MErphH8CLLVBY3MUtDv7Y0ZjWybjIvDwd0rwt943RWjSyy5GYCPiCcxq279KZD5K7brMhYuNnciKpWHeMEZBmRsDNUSZ2PcgJO2YlTx7/jSPFenvqqBjBlwk5qlqW5muvbYWIbJKcAeAvtr0uPoLKGaYWFh28vbhFcpWqdx0ziqK6oishq8yKiouDZsmlyaqWSQUVD8Pc8s0elcLw7Bw47OTpD7f5QXT4ltDOZMFf0A6rNF6KJCxyDLHT9CBnj7UXuatsBp6E4/VLoUd4MmsJ5HRXGkNdzwbYA0RZ6VxJ7pEnmuy0LnrazwuP59boOjyxCA0tbzt5dP30htBiGFtvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:41.3021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf41d07-c2fc-4b09-b7dd-08dee4349481
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5061
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX30VWd1aIHy5C
 J4s4Icv/ily/HMoSMi7QOMDrNnNCljf8cKoqwbK6Go5ENabmbrI55SR//5H5Xlkj0EwTqS7TdAd
 xrKR2DVLkOlQfoYMzhcPYBDcaNwBAuc=
X-Proofpoint-GUID: gzx9GSDdYGV5EaJ7BoBIiNtD5-RVo7YX
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5a79fc cx=c_pps
 a=SWHM+P2JNiUeaYpOZLdr7w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=okWzP3EbMLmikBYkquQA:9
X-Proofpoint-ORIG-GUID: gzx9GSDdYGV5EaJ7BoBIiNtD5-RVo7YX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX259U0WaAZROn
 ZNFGoM9JZertdNs5r2rqLj4LB5HimXb+QW9QxUgOzCagJDCZSEFt9iKjFTrnTk+aRlrV7g4EKMG
 5IsjpKg72ZkheqeB4xVHhShSnpMKmUZiu+Fopqe2md1Ja3Ith7BIFMXUKgekb+DoBAY4SHiFzJN
 Xj6YfQ6F6jT3eLv3aIB3QYq2/MKUqw8ZHNnENYDFCkx0HjNSj7KXBOe/33hqYYwehZObU+LSjqs
 uLo5k/bhXu2HJVtAkuShBqbKjK/a4sG8QDrDOYCpY9sGifv8lux48O74UddAsvRsPODd6dJi4yq
 pnwoaexKFlLQudUBL95o+QAtGP5JhqktNCoFLOhSO9X1W9NI9Bxx5TUQvaeZmt1qf5EUzP7pTXB
 3NN6q49YqVo24ApEjOsDgl+Hf96l/bvkYBRZqdk9RG+Wn0fFz8lEkqe2ey7Eap+/dQxQvnbcaOw
 MH3XiX9a1rRvtZ8GUcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 542ad331ff16..8bf3a5a8bf43 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1570,10 +1570,19 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (switch_cs || switch_ck) {
 		cqspi_delay(f_pdata);
 		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
-- 
2.34.1

