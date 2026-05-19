Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C97352020;
	Tue, 19 May 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205906; cv=fail; b=krSb/SDuTNhU7KuKN5m/QFUKtgb8tiEhF1qDYZmAINruCXR5B6MTtsHgePJVsooAy+pWKAg5LM0qU5R4NwcyYFa810tzQeWutnvhqUbbamhDsMIHPyUKgyABsWGOpJZj+iCCFRQSlG4jKyYqEjZGoHxCJkxW9TV+J4YSdoOvtlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205906; c=relaxed/simple;
	bh=eTRI/sqi3oY23gY6xwaybUARj4mzdU7b38v5rlwJJrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghtYYjccr5ZBccdG2QYLdz6njEPkcx0+6yGnXrD1o+t+o5KmHuJirTWD59TNlMjcjCWeQ5Yt2ujovJv0eU20z3GJXRX76AajZPlPTd6kLDPSJdLqjt1EwkzgL/NTyLsJK0wahDvL+yqm1OADyFw5yUsTOTP7FkBx8iEeRcZ6Rw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yuew+E6j; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yuew+E6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T08N/YtFlNxM7e2C9OhZQPIf1xxVJSffaaz+Da8td4phSSqARVrMLgIVY90yhM7c6PueW4pntlUWHuSQS01P7VAkvU4zKBon7DnVZwUQIYhToHtaWJ5a7Sw3kPIbUMtubDsB79xwEejby413kK3Yhxi8snk7DbwajbnqlL/9lj+bNVB/LDnnG3n1PJOxjC2Qi+rASCyo6nNLF16rTGiv+sGLXcp1r1H2CTF0iuYyoVYUO1B538l+y3or5wbHUmhVDCr4QsCRMd+dTwbJsbcq+NGb40YZvgNQl2ChMSOKMZcKgUHWlo+Z+XckpE1QPTgJnD9hzFliPb4Gg3M7z+IMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHVfHy2nu/rIfDrvt4H3icdJ1xR64BHUco5I8jKIl1s=;
 b=eAu8GVQ7cBaapD7m3OqJi2KwQtXDIj3lLNeDv2x5yS0aD41l37SXH0dkmzIXlI43JDMzQd37FCKiLuqnUGubywXSov6u9BDZqGB5s14EKK89VycDU7wiaSW5toPjHXdjqFGGxdvvZUJYeZTt6Gupn0smgSbS3jtQuydBUjWYXSahkqGn+JHlEde/0sBhTdcbhPS4sRGxRBoE42xtFsq1Nq4FvPIyU5t6MDOV9w2K8sh7LxXD4e4vlmr7APXxq/1VL8sNcwpS9LZ747vLZqvHFLrnCDCpVpe9hHZmTNOm4vDcyBIO8v0HRYgOm+2f1BGVplBHMwid8KcjK7fazgMm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHVfHy2nu/rIfDrvt4H3icdJ1xR64BHUco5I8jKIl1s=;
 b=Yuew+E6j3sCB9CxRNh9qGucuX7gEe4wPLjGgbsN0od4vx5EXRDGlo2cHz1kVPEqbVqrhWjHmVfL/BE4QJrngj5QNdfLdkHynMzUW1WjyiZRVVEeCJQj0+jKClrul7Tc4qtlNme9HE+RX7l9u3Xd7RyiF9e64RQtiOosgcC6bYFFo6Fpx0h+N2d5C7JKmXOEs/QfP8VjyV2MZ9sbboDnm6OLqRoyUH9b+M+Da8a6N1JAY7Hud8/hHfAdr3EFYX118cJxLV9C6tTT2fQK9VijR5biBHzgOu9jI9m+LrxUagxvUBr99p5EAbG9Fk5+09yYfG6XMiWcO00rGrJg+BpQ6Gg==
Received: from SJ0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:a03:3a0::21)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 15:51:35 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::73) by SJ0PR03CA0256.outlook.office365.com
 (2603:10b6:a03:3a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 15:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 15:51:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 08:51:11 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 19 May 2026 08:51:11 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
Date: Tue, 19 May 2026 15:51:08 +0000
Message-ID: <20260519155108.4092518-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519155108.4092518-1-va@nvidia.com>
References: <20260519155108.4092518-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e935d4-5ebe-4a8a-ce7b-08deb5be816f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	btatC99NZxRzNL5vZNZTI17dWbUUKTeL6RWINm/BpXobjQcgAtmBhEBCJZqD1qaDJUvojIBnyNjyvB2NDIzhJyg4TtozCq0T7iNLolGtNIdKta1WHXCNZzNpm2mpv63ggBkxgbZlGbCDk9WFAQR3Teca6qtwPtSpHN/Iel03X6bq+Jz2bRlcQy/CPqyoQz12KOhAnUBhxirmhq8p2d89KDu5NefuzEeynNAzmHloYdOGGZ9glR8zNCwdMcFh1L0VSfhbnZlpruV5fvwIhAVTBV4+3vqk2FVWSKLwLicgs/+rtI8Jxay9Vd6CYMMvpUBYVz32TEm5fxeMdea7LBawm7AMI6ckeEU10vCNiYk12qhIGTTbZOBXXUgDXZc2+TTu/YDR4gQM3RDG06S7NhzM+tTrsjSEgQrN+4o89gg/LoAzxUIkZATiXH6E7pKFCum/aQJ/sjdvLqJ7/zcFRyyOzzGf8gy6SOo/65h9Tl3bx6Uf2dn7pxXE+KFTvQP1leOgj8sVAO3G6cu6c4ygRO9xKaQ6HyISjbbrRHqVkg25gXKks7nTY4NvJAWyDbVbejWimsvCwF1cgo92Y/JE0LfO81AjBbHxsp7VTYuiEuNN45uXSD1QdvpN9CGLEZGX5POEjhEOEKFM7ciX//F3L5LK3X8TrZz3t6vjBwAY2J6Cy4zRFhmh3FJUoeoVoXL6K6m+cdY5N9qVJA9ALxBgvE0B1Y4Nsoqi3sW8Y2MBa9+JPhg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wHXhc0GDbhz8txWY/8oXb3bgXe014OLfwlL1RIT3lOsHG0V8eVYMP64fd7ytBZ5adTHY/7ZEaajUqCFYx3aQYlPoP/lSlEJsVbfB8buc1E2tzg3dPlTdzdIRA5ijECIhdwBktRYNu1KremlS8ofttM0PB1DHv6pdjQBAHsNwzCg6sy8E44UQ1S+rtonsGRwUfzQ+rKA44svcjpaCM74dBMHc4HlO6hQH0olSIY+x+zjuo0zc8QBNZv53iCbNOHr6J+lk0f/yakRFDowT451QNLVK+NjRLNZVbwS1CJWz4zxKxdJ7PhooNrIgeyBDLgLqfa351rWmm0yjRAEPmq0KVlSxwsEVX/f8xRcVW+tbsuCNqySkcb8YPFDOUPDn65PM1Hoe5lIGy4mp5CKdT76+2wLoARBHnJxqYlsFfHR420kb/dASlfpiUAU1k1CnRzxc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:51:35.1787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e935d4-5ebe-4a8a-ce7b-08deb5be816f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

On heavily loaded systems, workqueue scheduling delays can exceed
transfer timeouts even for high-priority queues, causing false timeouts
for latency-sensitive devices like TPM despite hardware completing in
microseconds.

Process small PIO transfers (≤256 bytes) directly in hard IRQ context
instead of deferring to workqueue. This reduces completion latency
from 1000ms+ to microseconds and matches the pattern used by other
SPI drivers.

The 256-byte threshold (FIFO depth) ensures small transfers for devices
like TPMs use the fast path, while larger transfers continue using
workqueue.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 72f66f2c6dab..bb3c51b3a57d 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1664,6 +1664,15 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 
 	spin_unlock(&tqspi->lock);
 
+	/*
+	 * For small PIO transfers (e.g., TPM), process directly in hard IRQ
+	 * context unless there was a FIFO error. Error recovery calls
+	 * device_reset() which can sleep, so must be deferred to workqueue.
+	 */
+	if (!tqspi->is_curr_dma_xfer && tqspi->curr_dma_words <= QSPI_FIFO_DEPTH &&
+	    !tqspi->tx_status && !tqspi->rx_status)
+		return handle_cpu_based_xfer(tqspi);
+
 	queue_work(tqspi->wq, &tqspi->irq_work);
 
 	return IRQ_HANDLED;
-- 
2.17.1

