Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588989;
	b=PFsve9wZEt8NJXaJYaAg3wnEiJYBwesEbq8bMZAxobvrFvdJzYR1mnvuorI381RrVDPM
	 Q0IpujEeftW+wR5N/bBUUgXyfEP5uvpyTpozqFL3m5qB1atVti4j/4KkPqNYTRcUcdro2
	 LVuJTlUMcPUsMD9uoBj7rxqmTsrMrTjsmDOq7gr6vTxyc3137R5v7aSotVWbqdHJbDHmU
	 izSzQmfiRZv7sfU1rb67fKoEaM9zodFPhpES88/mAUL542f94LvfUAC97HUm5hpkEfhvP
	 TmVyPISGc2pPFkooNR5W/J5X7kbzpLvcX2tQyCO9ibI9jMYCnUeOmT3dfUyEkeETyCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588989;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:Subject:From:Message-ID:In-Reply-To:References:
	 To:CC:MIME-Version:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bzTr+eoFaKbnakAxFxHbiPxhtUEYcfR0MWz20Pqqs7A=;
	b=PRaqGWoMODT9sO3/kwDYS7QvY8CX4zFOulhG+sQ5BJO8EhqoaAts+JFzZn3gmO4pw6fB
	 mNaAEixBlqQ1iMu5xZOlcaJHKWfI5Hw48MhZN6M+01gUrkdAl8UcpTOvF2te3egR5IZ7f
	 LnJ7HdRsJ/W07Hbh3bLsZNDD0iPWzPWbquR0S4dQ1CRLpqCPiSkI9IBn2kTqp7mOI5zyn
	 2zQt613JWUmqVQpgqM/QLDnLGODJvUrppyP0Ur/QMEoWSMFBLp0fZP7aoCt4YFh0TwRC4
	 TadjtHGJFBK9uQSwpl2UlZCsugM7C5fXoB/rR0w4xHA2psSBNKX/sNlctGd0SuLgywQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ii4qSsD4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E30606A31A;
	Wed, 21 Oct 2026 13:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ii4qSsD4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJTymd0pDn/WtyBO1sjLyCdPSBUH9Vg8GH85dZO0Oioqz336ip+mZlkh6zu3UOWQzlphoD3mEyVB+ZiycdK+yNRYPz6hFdRhVHMrOeFcx75WHMOCsfz/sC6YflhyS/a+wEmotHz5RapyhuOgMKABKj4segV4cbQ9ByMplsWRo2sFwAAcSy7CpbCoPmAFp52c3SmskQYTgWS6W3G0fCwHLaUUS3dvB2s+FD7NkTmo9phIxAzb0c8CyO03kTiUct6VO3DmlMgglCaC77/O8t9knZMAc/f3Vj7TzRGyHRVJwaJpeigh2lIEpziKnrtCtzhqIH+v92NKsqfPGaDyk2uZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzTr+eoFaKbnakAxFxHbiPxhtUEYcfR0MWz20Pqqs7A=;
 b=f3OMkM+vVt7r/qXIunbQx/AGt0Ah2bEiE+73WXSGjE84N0IiAu7GYS1F3r6wkBC05W8+ETYsMeI20zVj8uMuEboniC4bhYxg4l2SZhqZoGL5Ush3jdb3dBHmeA8MjwjWy/NhfFXDPhrDMFf4jGQaQRfvUMvwy3aKt/Bg+baqsT5B+TttMivG2cuN86jcJZbt8ZIPlobx/I81/Jvj2YbpNSRssrP7DXH/4QjJtFqf97L66b9gDhIDg4k8mL8flmAfmUa1IY1axUzNjiClPwzIx00eGA6tqmEN+XcMpSJqVPYcQXm1LmjGJOg7L1f4IKjj96jKKmk21qyt33D6rqTOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzTr+eoFaKbnakAxFxHbiPxhtUEYcfR0MWz20Pqqs7A=;
 b=ii4qSsD4Zujx0SglQtRRi65eTaUCHWaPlMtudBabhECBzPQwRzKZ2L26FkotdH6esKLVLaNgwe93mywekwnPSn1ivC358SJ71fuVI4+ltmTe5sfXWQgKb5KMeiuAqHV9NsfrqLkTuMCwVYHKIQT+p4elbZkunc0c2FcOsr9TMSi+vYsh9+fpKxc90XUqBAJXV2b/MGzP+zG/tZYr0ZxiqdoGgcRlzQVdD0H1mMumbFAqfkpwEqcPkBWjyCAAkRtO3QPtENSIAXQB80RvE9rf8zaKLRa3KK2tduaWCv+NrrpA48EsZ87zg/yQG4lcZiZwxJiTJ7VhuuCSNhfgvMJWdw==
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:23:03 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::46) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 13:23:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:23:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:39 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:38 -0700
Date: Tue, 18 Aug 2026 14:56:25 +0000
Subject: [PATCH 5/5] spi: tegra114: Keep software CS across bus-locked
 messages
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.15154108155666791213@nvidia.com>
In-Reply-To: <179258895296.403962.3492255118456900623@nvidia.com>
References: <179258895296.403962.3492255118456900623@nvidia.com>
To: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	"Sowjanya Komatineni" <skomatineni@nvidia.com>, Rhyland Klein
	<rklein@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, Krishna
 Yarlagadda <kyarlagadda@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f974e2-32e9-42e7-39b9-08df2f766f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|261009223327099003|261009221727099003|261009221227099003|11063799006|261009220027099003|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1y/gEDHW3rAKIs5P66PxP03fZ00XVKC7iFKsGNwwz0AZHIBnL04k3osWqjXdLeBZcw+6PVXJ/HIzsSorDHdE42eGxSK1Y+SJMM0Y4BRcq7/YbtP2Lua687yhs80Uh1Phgb4a2SSJPq7FwIpx7XgFUrCvQhRHRlSQ5HBfxYn1OZHWqoUr4IKOJRPM5ZrqSGoJoAUhNF5xr+nsjw+4VF5inoYxnWaUaNAichk9/zpcWTR36bOIEikYkC4wdXIsu6korU5mD+maS+k2ngWPpMqEoNpudny1wk8YOX9DnVdMbUHaINo5jERRkCdQsRM+QennkOJw4L+Ubhzun6dw3cjMNfCgH2rmEPGY4WP5TzNgJgcEt4J2vlRAoEOkmH9pwEQsKoCompDGDCSQTlDQE6Yr6oSdPHGQcaL/23NxB+eU02eg3IkdoQgDCWdddnAOmChr/8hmgTEBvHW7BrMUbjRM10KJTreEX08l7Gy6p0T5MzHnnIHbLOLEmmEa6EL3hBA1GnEEtc5WbwgA4bf/qTOTKaaO+hxGc2uk3VXMZJFytMiWyezbilCgyc6I5aD6ZTlyfRD7Om9XlOzzwhLyspleGLvELZ9ONzXZzM6gLDCeCoe+/lBJR4r+WMgylJomikyuimPS8/VP0hUan0BXff3fW3uM4IcVyFGPG1EIZnRDhdVAoSOoXRjjYvlFw87W/u8Q/nTV4RAZdrvl82IGAAZMgA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(261009223327099003)(261009221727099003)(261009221227099003)(11063799006)(261009220027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8TUuZAoVUM1UhMW6mTyfWDRaLhNg5Y7TMcSH+33KbRIvWKVINcQVr9GNNtJyq/DbqwN9WuL47bnTpjSSUEcBFov7LKyEG8qWkjio8JhR+h+fY7GPyYLc9YqawaFMaEw5re5gMgxuoDgHk7yo27Z5v/vASQcYtO367CVN3KCRXr1RWNRMcngZ0VgudAVhdm+zwaLGdRYMsq3LL0sKNEEkntdDmSZdCQoAIh9SpokvS7P3ZTnPnHNkNcpGQfx0OG9xBJpfUwcY5NbmOzVpEZa9gP/ibMPQMciPDOiO1M2ZN0XxRYln+qbaMR9ly0J3egTguSdo5LU5YEPdRfPbkoE3yrsswTbpSEAaBU9dfzye8ZEr6lE0MBCmGjOCrxpM8P3s9la0jeqUA/dcgxQbfJh6fUsPUbGWXyfpBF+wGzoMI+R16f7gMaOMRjRNE1ycUCsE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:23:02.7218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f974e2-32e9-42e7-39b9-08df2f766f40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

A client may hold CS across multiple spi_message submissions under
spi_bus_lock() by setting cs_change=1 on the last transfer. The driver
records that device in tspi->cs_control so the next message inherits
the held-CS state.

When CS is controlled by hardware (i.e. for single transfers with
cs_change=0), the controller drops CS while it waits for the next
packet, which breaks protocols such as TCG TIS-SPI that must keep CS
low from command through flow-control polling to the data phase.

Keep software CS when cs_control matches the current device, and build
COMMAND1 from the running command1_reg rather than def_command1_reg so
SPI_CS_SW_HW and SPI_CS_SW_VAL are inherited instead of recomputed. The
COMMAND1 write in start_transfer_one() then updates bit length, mode,
LSB-first and 3-wire for the new transfer while leaving the asserted CS
untouched.

Fixes: 1bf9f3c9232d ("spi: tegra114: add support for hw based cs")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 69 +++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 389dcdf15923..14e506374aed 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -779,6 +779,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 	u32 command1, command2;
 	int req_mode;
 	u32 tx_tap = 0, rx_tap = 0;
+	bool keep_cs;
 
 	if (speed != tspi->cur_speed) {
 		clk_set_rate(tspi->clk, speed);
@@ -794,7 +795,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 	if (is_first_of_msg) {
 		tegra_spi_clear_status(tspi);
 
-		command1 = tspi->def_command1_reg;
+		/*
+		 * If the previous message left CS asserted (cs_change=1
+		 * on its last transfer, e.g. across a bus-locked group),
+		 * start from the current SPI_COMMAND1 value so the
+		 * software CS bits are inherited as-is. Otherwise start
+		 * from the reset default and program CS below.
+		 */
+		keep_cs = (tspi->cs_control == spi);
+		command1 = keep_cs ? tspi->command1_reg : tspi->def_command1_reg;
+
+		command1 &= ~SPI_BIT_LENGTH(~0);
 		command1 |= SPI_BIT_LENGTH(bits_per_word - 1);
 
 		command1 &= ~SPI_CONTROL_MODE_MASK;
@@ -818,28 +829,35 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_BIDIROE;
 
-		if (tspi->cs_control) {
-			if (tspi->cs_control != spi)
-				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
-			tspi->cs_control = NULL;
-		} else
+		if (keep_cs) {
+			/*
+			 * CS is already asserted and the CS bits above
+			 * were inherited from command1_reg, so the
+			 * SPI_COMMAND1 write in start_transfer_one() will
+			 * update bit length / mode / LSB / BIDIROE for
+			 * this transfer while leaving CS untouched.
+			 */
+			tspi->use_hw_based_cs = false;
+		} else {
 			tegra_spi_writel(tspi, command1, SPI_COMMAND1);
 
-		/* GPIO based chip select control */
-		if (spi_get_csgpiod(spi, 0))
-			gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
+			/* GPIO based chip select control */
+			if (spi_get_csgpiod(spi, 0))
+				gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
 
-		if (use_hw_cs) {
-			tspi->use_hw_based_cs = true;
-			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
-		} else {
-			tspi->use_hw_based_cs = false;
-			command1 |= SPI_CS_SW_HW;
-			if (spi->mode & SPI_CS_HIGH)
-				command1 |= SPI_CS_SW_VAL;
-			else
-				command1 &= ~SPI_CS_SW_VAL;
+			if (use_hw_cs) {
+				tspi->use_hw_based_cs = true;
+				command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+			} else {
+				tspi->use_hw_based_cs = false;
+				command1 |= SPI_CS_SW_HW;
+				if (spi->mode & SPI_CS_HIGH)
+					command1 |= SPI_CS_SW_VAL;
+				else
+					command1 &= ~SPI_CS_SW_VAL;
+			}
 		}
+		tspi->cs_control = NULL;
 
 		if (tspi->last_used_cs != spi_get_chipselect(spi, 0)) {
 			if (cdata && cdata->tx_clk_tap_delay)
@@ -1045,11 +1063,16 @@ static int tegra_spi_transfer_one_message(struct spi_controller *host,
 
 	/*
 	 * Use hardware CS only for a single-transfer message with
-	 * cs_change=0. The controller treats each programmed packet as
-	 * a separate transaction and would pulse CS between transfers of
-	 * a multi-transfer message.
+	 * cs_change=0, and only when CS is not already held from a
+	 * previous message (cs_control == spi). Switching to hardware
+	 * CS while CS is held would release it between packets, which
+	 * breaks bus-locked sequences such as TPM TIS-SPI.
+	 *
+	 * Any multi-transfer message must use software CS: the
+	 * controller treats each programmed packet as a separate
+	 * transaction and would pulse CS between transfers.
 	 */
-	if (list_is_singular(&msg->transfers)) {
+	if (tspi->cs_control != spi && list_is_singular(&msg->transfers)) {
 		xfer = list_first_entry(&msg->transfers,
 					struct spi_transfer, transfer_list);
 		use_hw_cs = !xfer->cs_change;
-- 
2.17.1

