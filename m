Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013276;
	b=q7J0svJJVArpOu+5v2Pli+8jYwsWsWu9IchHhTLVovJd6dUKs3jUJnETxcINmpMjCiUf
	 aOoHu57vGM0kTNHWutUlzAl3Lj+iwCftXHnzezJkJsB7uzdj5qDS1CuaryPZvx7E4tM41
	 esKtqJenD0d/eQzwG+pFwmNjE83Afas6A1nxLB26RfEFTGTOhTE7ikFu2H1zKXr6cgpDW
	 HgY+yBj9WfYqaJrHzkhkLfUGlWNErVA5y0pxSjnupBiYgV0DeV4Jn2mxOHPzC988rwKjm
	 qPiDjwumD8R988vvqFhg2afLY5qBzJV4i3g6hE4vOg6WreN29iPiNcB/FU+7r44j9EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013276;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-NV-OnPremToCloud:
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
	bh=jy/zYsP+aTL8TNSxnrnrKhMfBDcHGzwJifNTFywvtNI=;
	b=0+I/p+qwWMRxRfNKWZtv0S8cTikA/m7FeqbHfyVW4NohzV4ZriZ1rp5ZLuNjm3tmlDXc
	 gyUxE6M9wI0ZyAEPdHEn1HQZmwu553LmREml5sg1VE+WPHfZZyfAvXIb3p2JwPn4CP4Qg
	 Gw6Pi7hypFWFNL24end4cWbjPqa/F8R+6BOX5lGQYa+jTcT9xLa9Vk4nP6/0I0KAaRP8h
	 lSSNKda1ZuRcvNBPAR4vApFLWLs+RFpR+rGTSw5bjJlv1IJwb+FG/BC/eeV4xxRXap5Pi
	 ClZbg3aIneROZ8AtPKpyYYTMAhU8QGBEpNjHE848TUyivdHDgscS3joJ/6bgV8O4xtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P2kyRKz9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.24
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B82606A910;
	Mon, 26 Oct 2026 11:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B82606A910
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P2kyRKz9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSQBzvUW1DHxpdEoBbxuaXS8+tcmx3uMJjSmSWvBWmyVMkl/VHvyaC0SxIyQiH6aacpdISeQFSXUlP7ZXVfuqCkSaG20EVNtPmuSlRAn/gXJqOy6bvBOo9YnR4nuwaEAZ9omU5RVhNBlaVexSox1SAWscuijmMv/eNRLKifFy6+vJD6i7B+M6UBphrVOwdJUZar1wqu6eUZPF2jKqYtA3m5xntxp2GUGnbmGYQcK3UWjoNRvtgBMIsJEQC/3C9I3v/S8LP/FR0xf5wRXO7q5OFUYunU7/xzgtX9zW6egVbJ4R/9sUWhNcU+Lt6YubsEi+EZT7it9B7DOBlySo1sfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy/zYsP+aTL8TNSxnrnrKhMfBDcHGzwJifNTFywvtNI=;
 b=PXmS1tFLpL8l8I3xL6rNsILAQ58W3CPmLAfyk21d8yxHDhoyBKruBN4E57t57k981YO8cFzboUN3rLNSjRVL5A0nyklCiX1/jr3iCLd7+ndLVCbOjE2mOG6VJKBNZNHbwjl/EOZ56g+o5VvQa+fm0KqvwMA7PrWNUAh2SbKc6W1dmU74ef+Q9GWjopUIeG8IkKpu2ciBNZJPxoBt7H/KLMYY0zbInaNqSeSi9vT7mAIG+vokuNb4x1Qsa9M0O8IGeF+5sx1r5+oqokHjb3SWqcYcJenurONEEsmzIK3oWxXOfT0ODXrGkAvIR8htV8O47JD0uRMWKJA4K73RLs40zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy/zYsP+aTL8TNSxnrnrKhMfBDcHGzwJifNTFywvtNI=;
 b=P2kyRKz9Qe6Ka19fR+9M2soGBQYmZfEA1A4ncv1OCSix3JQGMIGAx3u6hxWJbLRfAfC7+STRaMTCSu8GEuUCJnEhmAYiEHYNperrqIFYHM7nLqNUiVLl/vHy6fYxrk6sBRtndbYzl76mb9NjmF3zI1HzU8HZaC/QNHbtXSelwX8f6QdzbcRGpOgTXSwcFv5FFRJepv2cjbyG+PtCMicNWFRXsSGJ+KCB7imCjkKgY7xOYFhNmQ0Vf2OmFBpXiE9sWIEzrm6XBbirXfUtd0mP2IbWM+gToA0KrEQm5RTaZNUJRnX6j0t/ifzVca1h/wSoOoARDIUisswOvDsFMO2nOQ==
Received: from BN9PR03CA0540.namprd03.prod.outlook.com (2603:10b6:408:131::35)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:14:31 +0000
Received: from BN7PEPF00000097.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::ab) by BN9PR03CA0540.outlook.office365.com
 (2603:10b6:408:131::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 26
 Oct 2026 11:14:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000097.mail.protection.outlook.com (10.167.245.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:14:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 04:14:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 04:14:13 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Mon, 26 Oct 2026 04:14:13 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
Date: Mon, 26 Oct 2026 11:14:10 +0000
Message-ID: <20261026111412.3843954-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261026111412.3843954-1-va@nvidia.com>
References: <20261026111412.3843954-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000097:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bc7528-c5b3-449f-ef08-08df33524ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Jlj1YXXeiE93z/+hNGEWdQIpNOdCo5SqGRWgNQzO5GGZW88qrktUl4t0ryoB/BrfOHJD2dqLjenj6z7ho2NU1FiXYIe+g5PWZz6zk03FJgs1+GyGBVC2y28hes7lYbc2j6VQitujbvydm2/E0PL3vU4JJaW0qbHpcN88wFRIi0XEy75vynAvx73yPmyyPWs9q+QHhdO/EhNK0PJBOiQoNvJN11AgPm1DRQwMKwmIpB2g9wwjqqq0lEHvHAZmOqk9XeU0XpjBXs/vLNbN97ETzCh9XYS4zwv1xU3PA4RcTZ0rJIUk/NyBfn0qroAwI9XgRPnl/N/LUiHEl/tySrUWye1ABWpKj27SREIDB4r5R1hYAipKIht45M8AfmsWv9ziYgNVlpTfRTidcivZIwk2qxQgt8iQl7zEo81CRT7DOd5hXW9qiv66C1ywFZAjjM6FbyjvewK7yHCJYCIBH+Xllne5pbBQjuj7IQtAWIQsysWLNZCnJ6ngZOGP527DmPcFq0HBGSKX7p8KXBbLHJ/+0KPVlZGOKUGRoakLgYV7Xqshc8dPaOfu4vPJ0Rctz8PGVRuUGiq2O13jONrt0xIeItIDrwZ+X2aIb5+ph9wLakGl8rQ14vM5T6YOE/N7UXuvLy4EeaVjuC6ewICRF9fcsqUyG5FySjAiN9ri9pTaz7wnF5IJiBXTqx8QcovSGn78LP9M0h1jIPz1buEzh7+RXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2ERBeFVwd9Ob5S4TIepclXORTQnMNthQHi5yjE6cL3FNk8xPYfKZKE6Hgqk4oIjn34W40nK45TQ3sABccpIrvLEeH+xSJgmgNJIkuvUU85/MAWekY6tdmG/6sCLmTrCWSr/7M5f//gx53K5pKKU/rLUTZdRA7o/Lxo+c7Qz/INssA8tmlBc2y4z0Xz5kz5kniQl4/nghWrLoibZ/Z+mEwpvFbR2L02gh0R9Po7g1ZI1iAUplKKBHZQe3RlClhAONnFoW7/9R9UUpoefedreVEVLJOBSNUWyJBm154i/nHQ9B8rBZ+Mq13X3u2+UxFvC2AwHfhAkB18irlUzfjbw0pdaxcylw6Jw6+LoUfWmfUzp7DRLhIm+zbD7chRa7AYGLyoWFN3SgASQEr9JY42fUCxlzXOb3uRxqxpVTSgTPccrwyQmg5oDd63670Y7eGfb0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:14:31.0031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc7528-c5b3-449f-ef08-08df33524ec5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000097.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

tegra_qspi_handle_timeout() captures a "lost IRQ" FIFO status snapshot
when the ISR cache is empty on entry but QSPI_TRANS_STATUS shows the
transfer completed. After masking the controller IRQ and draining the
workqueue with cancel_work_sync(), it re-loads the ISR cache with
smp_load_acquire(): if the drain observed a real ISR completion, the
refreshed cache holds ISR-published status_reg, tx_status and rx_status
that reflect the true hardware error state at IRQ time.

However, when both cache and snapshot are set, the code keeps the
refreshed value in the local status variable but then unconditionally
publishes the pre-drain lost_fifo_status / lost_tx_status /
lost_rx_status snapshot into tqspi->status_reg / tx_status / rx_status
via the lost_irq_snapshot branch. That snapshot is racy: if the ISR
fires on another CPU between our live QSPI_TRANS_STATUS read and our
live QSPI_FIFO_STATUS snapshot, the ISR W1Cs the hardware error bits
before we sample them, so the snapshot may contain zeroed error
fields. Overwriting the ISR-published values with these zeros makes
the manual completion handler downstream silently accept a transfer
that actually reported a FIFO error.

Clear lost_irq_snapshot when the refreshed cache is non-zero, so the
ISR-published status wins over the pre-drain snapshot in that case.
The lost-IRQ path (refreshed == 0 && live QSPI_RDY set) is unaffected.

Fixes: 1ff82c13ea94 ("spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler")
Reported-by: Carol Soto <csoto@nvidia.com>
Link: https://github.com/NVIDIA/NV-Kernels/pull/579
Signed-off-by: Vishwaroop A <va@nvidia.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d8cca3aa276b..4a5933d8112c 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1260,8 +1260,17 @@ static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 	 * loaded the cache but before we masked).
 	 */
 	refreshed = smp_load_acquire(&tqspi->trans_status);
-	if (refreshed)
+	if (refreshed) {
 		status = refreshed;
+		/*
+		 * The drain observed a real ISR completion. Prefer the
+		 * ISR-published status_reg / tx_status / rx_status over
+		 * the pre-drain lost-IRQ snapshot, which may have been
+		 * taken after the ISR W1C-ed the hardware error bits and
+		 * therefore holds cleared values.
+		 */
+		lost_irq_snapshot = false;
+	}
 
 	if (!(status & QSPI_RDY)) {
 		retval = -ETIMEDOUT;
-- 
2.17.1

