Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761877;
	b=DzCiuu0vUNK5ydK+jeKtGY///9Ta8ObVPSIIFzdKQ02mVbRwIhwslDCG7e3gsS3M/bOn
	 9TZ3Yz0K4+KDIMH3a5Ko0JYpZaA+RrtZD3+zIZ7CKXhnZ6FjEj867qg4HfvG1e/fQ2dxq
	 5wXiZ1lkzRoG2+wyX/N8oczUAYGnH62yBuvGKWc0i7GV24ySjxhTl6V/HQHJBPBxurW5y
	 mHm4L3uUEGY1W4SElP4dkCH4+vnTokTYxVn9EiS2MDk2zaE5TUXXNSmhzIt7UQzpnbQmR
	 m/qCQGHK4vguCqUcAI9xVMJusFnpyGwpxNTYCpUTe3oDUFZ0nc+ABnMKOOaDL9zczOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761877;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/vbyAapQEeNQyvs3/I0cIKEWJL+CCecgNCUg/Ya7iig=;
	b=Z+A//vSBdBKBptsXlX2PxQs20ZGUMptBaL54/2v/QleYFvt7XCdui2BS8tAc0KmopLuR
	 1Z5KJhw21Q7zbyq4Yyo78l9xE08+Qy7EosdypAEIbCn7szLFdaft5LqSzWXi1jVIDAnA0
	 hGk5sQn+ifjfFeNO2k6MNqMBi9QndX7rSBTEm0sBjtLsSClzy3NTPrskxcnvWjBRqC6tN
	 uSyRrHqQiXc6vKCFrLLrk1ga6pNtK68YhUxZ5OWivNu6Sq5WP7aUJrAZY11/IfvazbprS
	 cJqa1EdPBiJtBVaZvzTZe0/wXbhYnZa1DbTL4pY1laADrixWNEEC4EWyQ+6WTX7NZ+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BOMaKQFI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.68
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6163606A31D;
	Sun, 15 Nov 2026 16:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6163606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BOMaKQFI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7OReDpYhO/UxNF0wuI6gUwjQXxAFNfgbW+SfbyFuiW1mOdNhZ7BMg9BpDHdCj0sKdrazAU5w61djieEAJEVd6bw9b2mZny1B4NfEWVI2dCk+4J7ONKzZPFfSQf4SPhq6TTcN/3jKaPErU6PUrMkojfY033AMKV1Dx/f8H9l81rNvrLNMm2BtpXQCkG5p1RQl/TD7HmUvz+PfbUY50mIyxHTKm2LLy5rK75cP2YdwzshoasCTioC5djjKBOhArUX5MXn4H78MAMdJiuD2np4rqafcdGs7xicCxgT6JlrquVUyrFYAHBPP86P6M0//Zm6FY7z1H8HYIFAWuxPA9jiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vbyAapQEeNQyvs3/I0cIKEWJL+CCecgNCUg/Ya7iig=;
 b=m93by/lpPhurMhDJb0cnjqxyRr2NKKQeG/781BS5favxAQlUk66jxvoLWSxmeHwaXesw0V27m0vADPYozQuhoZpeUbtqTlev3adravk57Pd/05vj0VOZwI/FnYK2cQ1bMYqj04zDMW9aMjPEYY1X6Jw/3IXLk+InXaThKTSBbFBZJJnAebvDHBheqsA3ZhVu4RlUj+tSpQn9qhMey012dJIYXlmJkLNQTmNY6ei3kcpSwkV1Ux8bh56Tfoe4kLqC1rpIqr69ylYaZQ0WvRoS6lmN85GDVvM9dp0ZusZitD6wKH35w5KuLbQk7DZjOcKaaAvw8k0NeNBK98OihyO5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vbyAapQEeNQyvs3/I0cIKEWJL+CCecgNCUg/Ya7iig=;
 b=BOMaKQFIG9Qs8RpU6T7/H6mv3bVXbpH6uZYgu/SI1Iwnx4ab63xx64o4bZtpYvETI58I++mwTvb4vin4cR8750wWQOwaAYFtSoEp+g5mDi58M0ENitUasZolN6rOZpmq4np0tSD+hGcBFb4elnqwmCOP4D8x1MprRdIvRBVu2H0=
Received: from PH7P220CA0177.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::25)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 16:56:51 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::62) by PH7P220CA0177.outlook.office365.com
 (2603:10b6:510:33b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 16:56:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 16:56:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:49 -0600
Received: from xhdsboyapal40x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 10:56:47 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Sun, 15 Nov 2026 22:26:41 +0530
Subject: [PATCH 2/5] spi: spi-zynqmp-gqspi: Mask the interrupt before
 gating clocks on remove
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261115-qspi_14_11-v1-2-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
In-Reply-To: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
To: <michal.simek@amd.com>, <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761802; l=1455;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=uHCAuYwl1cNDFRU6tbxaJfzJqSMxdv5Tj9+b9NWvH20=;
 b=V5GPntZpjSHL7ToyV2Jmy7yOJ3218eNy6wgfwuQHcXKdXFM9WRq/j5GX6Xbe2d63xE2CQ9LIY
 PEUbdnc8CG9CNkzBVb+289FhTBx7nZzaQOLMgTTw7+/Z9j08AmMFeaM
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b50d3d-9226-4482-d4be-08df433971cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|22082099003|261009223327099003|261009220027099003|261009223027099003|261009221727099003|261009221227099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	u/3dgXQIYL0yOabJ5pGsKMtgxxc7woub1Xik6vSHaLtOZjsM5yBQmY1WegAhvDqSUMVqc41+q8RqT7KsvUy10uDTsSOfRVyeUxhfgKjk/1uuvJMTGthcjefKvjxK40z6S5OjdaWLpklhJCZDyWj6bR2/LBk48EQWz1oY1psp5PB5pecnhlqCXWoT9slAOOS4e7mNvoB8VjEry2BVsau8cXMz/UQ7qxusl7yGEPwvj5TLJcTp7xzUgSzRFNdeN3xBCeCCOb+dwgPo0qgJUKBwUbdI9h3tbG+oPrLdejtMtDJ8G47q/o6j5Cu3+J0GJF73w3gshwpPZjvdFyksDrzLljirlx684u4UxU0bnDUsvriSXTaHGoCSs0bFvL2+zW1xAeDxXxkWHw2lkD6+NnZI7Z3i90DfbmeqGDHcbpDABJZIHXE+T4hSYBZzez3OkwLlIJCuOPfCocYVBHCtVX90tmUY1akDzLLPSt3WNjibKoN6Z4IpAdsOGh5EroS0Geyy/mgUGnjeerJ4HZjno4julnK3oh0uaqzfFCavmHS76DlGtHBuxWYT0SQ68EbaQC03BrwYq1iSLDRibEU08rrfMibXRQh0kW/Ph0r7iIQoeGQtskOKl6teMbLxamnPkwyyEXQKKpgqgLp5MHCNb6aSDsFHSuXoW14s6sdXBGuhvb+SGea+R8DHwlo0KnFbQvzlGdOgtqdzZres3Ael9Y9BXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009221227099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m7vbARJAS/yszRY5wETtnWbvsbeuB1UqLEXsW7AEFN+i6CFMwaeR+43I7OPYL+PK+HWRxd8dGCaXROr38hLUyDz3GEyVJSq2JT4eXL6uc0cTdakfaN25zAbw96Qfe1ZqxG0JtP8aukM6RL+fT6OYOnXGBsMt6ty5XDg8MQgF4TJ9W9jqeXjVuxpz6Vw+wl2aQxQYhmrY2qv4BtBK56UOlChB0+SrJWtV+7wf5vM8zUsrOcEY+Pg00Ob9KJ/dIqhIXPTs/LpBFW0PAkJHXrohmRtMdOFLeC478//1bnLMPQWBJnq0WoxV04uTcPidtw0bkYs6WbvEdBUbshEB6FEmY6qo2Melh05cwn4xHQp0y+L4rc6cqo/4CyBnUD7K5yaE3By5QLzCVZvlhTJ36Io0pnhapQD/sm4WtyPjf4jJGNIcnH4y4cwVtdAnJsDOGPsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 16:56:51.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b50d3d-9226-4482-d4be-08df433971cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

From: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>

zynqmp_qspi_remove() clears GQSPI_EN, then gates both clocks, while the
IRQ is only released by devres after remove() returns. An interrupt
raised in that window enters the handler and reads registers with pclk
gated.

Mask at the interrupt controller instead of relying on the device-level
write to have already silenced the source: disable_irq() closes this
regardless of what GQSPI_EN or any other register says once it returns,
whereas the write below cannot recall a handler the GIC already
dispatched.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Signed-off-by: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0da44ebaf39c..cf22ae8d2163 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1377,6 +1377,13 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(xqspi->ctlr);
 
+	/*
+	 * Mask at the interrupt controller, same reasoning as
+	 * zynqmp_qspi_shutdown(): the write below cannot recall a handler
+	 * the GIC already dispatched.
+	 */
+	disable_irq(xqspi->irq);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);

-- 
2.43.0

