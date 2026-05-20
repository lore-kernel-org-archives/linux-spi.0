Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E883403FC;
	Wed, 20 May 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305072; cv=fail; b=KfGIHyyLTHaMXdGZFAboCOH/iDwP4SjPUyi4OcuI0P+wtsmBmhGjxf6R2GXpU4lxTDfG1w1csJdoxsnhmCCS+KJdXiTEONbGekbgFkF/FxeisOzTGYg1CU4n7+xV6j3O9H40otIt75DYnFBuKQx/ng1whAz78G2dMvVlXBVIvsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305072; c=relaxed/simple;
	bh=3BDb+hiUSFFEbaLofEmBKQiQ3iAYMzMhr4eaRm3mz64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZfnlYOtMgQIW9qpDOwxu9doWJLQ8p7l+YJa7ZfaN96oKwhli5qey2GIlwMqeEkXAMIV3OvFgE7OfnWGPfD7kQgCQ5NrURruVtCoPprCoPNVZRqwZcFEk0zdVFeHh2+Y/Y32IZl7SHD2BSB8bjSIwiigZMYj8Z9KYMfqAFzbQBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omsbfWkL; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omsbfWkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHCdZj4OyVWKgFRGwAVxcubr1ptS+4xnlMG+y2OBOxIhJ2bsRADt2qVj6EgB18ovFpWT4fxQhaAmGBE/vthtk2aRSqefFSw5gIrISLdX6VHQeR+DvjiUAiTPaeUC8cgPwTwq8IekbsY/yAMLpw5Mj+Tx6OSYVdzW9HLF5hRRVYXdHoPFT3FWGP2qDFq410tq+13NWtIViMKw+XZmNc0XgXbnE1j0XQfRe7hNu54UAIV9HRsAPZfAzB6tVZWgXHRBg13SOZ5Bn8/mQYSbV8OXv0kpRCwjUAaXiyOZ+q/DhNxHNc5P9mtMnXpsJE3+VSS4SgqVenNg2i9jtfNs0jvPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95UTaMYwTqsImawRvi6KJXsk4cxbKTXsffsR5qVHuv4=;
 b=Ek2K0bHaxCWWF7niCjLWCBGhWKhWb25EYq/8UdyiiZL6IW1Qs/1mkTSIJqlvzxfSzXRfb6ABj/KHjQM4GmTU23ulNhfmVrI43TdumuWjsEoKuvwT3ELRqk0gD5ouQFuLuXMap86CeODKG10M1cBkKnUr7Pu1o52kZ1+NjuzdggWR0Z2k0A8GIkmIWoYKoE7Bu99VY2Fm3lvuun5QHJAKpMHKsxjVcL1TPOmCtceJRrwTH5BsNswxHIJ7J7JyP2erGDKwaRYScQI7B13JGif/lSUkkjkiljk8NYeREEEIeItH8N/ec5kHIlSgpR0svv9FsXxrQV5h4PjGMKNdzFM/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95UTaMYwTqsImawRvi6KJXsk4cxbKTXsffsR5qVHuv4=;
 b=omsbfWkLssymmDPe4Sqh1SYh6WBRFSFnj+8i/zwUlOu8iJAqKEmysKWurWdU3+tS27pl2cjF+8OIv+IDC3i5vY/kjyWDrE2N4QXwsbTIiW37LQNmTW3J+O5FNZHfEccQ4h90PKLXc4A0TuhV6hCad3qR82tqQSwNbS9xTHmhqc7hhgRbklrVy32m5Q1ZbMEpY5lXPVa3XzNRXeWo0HeZ25vDj4cwDH5uFXtwF5KXJKYGA64yv92H3ZBCakYPZ7b0wvdv9UAzPRzwkD3tXCyx3aFxMnJESKyFHRjsjHykZIOMLA+0ttwcu89nViw1gywyPOY4+lQqugGLN59gihonEg==
Received: from CH2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:610:5b::20)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Wed, 20 May
 2026 19:24:25 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::6) by CH2PR07CA0046.outlook.office365.com
 (2603:10b6:610:5b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 19:24:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:24:06 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 20 May 2026 12:24:06 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Breno Leitao <leitao@debian.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
Date: Wed, 20 May 2026 19:24:04 +0000
Message-ID: <20260520192405.70469-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520192405.70469-1-va@nvidia.com>
References: <20260520192405.70469-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: c79f2ddc-8ace-42ab-536d-08deb6a5675c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|11063799006|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C6KgQlZk3FqssMGRSk9rJWKj8ewDbKvIcrPxuv/dQGUJtHW20h/963GfihOwLdkDV5sk28ohVjvpBIY0MIsYWE6QDK2auN3zNVv6+zA5TlhrwY5Z0RejvCn527An2XuyHrY+IF+YsUeYZLrRy+6JWQ71C9L9SAEbYu0n/7kZYSo0WqxRTnpRt5aXrL+eVgxk9RsJ/YmLp1q6lzKozv/RAIg3/SeQpKrH1sCtu8KkO1cquI+5xLtwmgJGvI5gx4kEv4b3N0TI+qLmUkLSg3oIf3Z+eU/adMKy+6VtAZ/18A5AeXPEwiHcvGI5kvYrhprwxuZtQqklBP52lulDAnHqypkEkZ3W7X+kRBRGO2N69I3gvxtS4g3kIoh9YwM8acgGnONuIzjabRbzfDDMkYrp1SzrNtXevfmCIk99Dn6MMO2X9RrEOZX0YsomEfSKP+2Xm5/BbJtY+4h6BEpuqt+qmKc01MjmIw7BT/ITS5WvfQt/LwOUA84a1oBwb4NwaVFP+uNfGAVqjFhpwD975eP+4arImVlxnkGH0VzWe9+eDOrcCppPLImi/+QJGFRUKf116DndevDmM8By8P1k3YVFbi39nqt4ENr6v3pq6YcYUEFO0KMUAPpwG4zD5gwtiOxYaHNHNlMJuDqHwKhOrRVb4kyUO30kzaJMOPa3GoLcQFvJMLSXC2kZO3vLsMdwt7HNbzrZdxgA2d/gHubuADbk7hqo0vmNGtX7ZO5+bUkTmEg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(22082099003)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gLYuCg85oIV2vs8LDjHWlMr5XIkpSBhXSDCHpZ5shCLjEV6xEfGF/Je+EKog71U4vpoBKvYq4eioZnnuQ6rM8EO6JOP/QFRqhXgwvyQ/nNmuNbrfw6qQzUVxvxo2whsBBXHYHBZZ3xWcVJU/nWmwB2a1htRsATDl5s7xQf+4rQSTaRxyuAaSlXwh/jXDBZCeUOd9JQQmiHHmO9Rh+M2pmFXQ0uZ26xfTedx4833vxlLj+pxse/m86fCxEPW69B4r4RAKKeido6TkTF/RO7j5jqc1e3T3pRbyVG5xXT8aHAkUhes7gJ66vusoqdlJx30Kx3FFoLJ8pGRMaJ2sT+eDZ7u7HSX/IsFpgnSb/JqP/SelijuzNFtouhmqvp3t+MUCP+JZT3ax/1HHwS33jQG/DSlV65PX+X5jEkGiviNsmZqLH6YMq7Q58m9M92jL00AW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:24:25.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79f2ddc-8ace-42ab-536d-08deb6a5675c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894

On heavily loaded systems, the workqueue bottom-half can be delayed
long enough for wait_for_completion_timeout() to expire first. When
the timeout handler reads QSPI_TRANS_STATUS directly from hardware,
it may see a completed transfer but race with the workqueue handler,
leading to double completion or use-after-free on curr_xfer.

Cache QSPI_TRANS_STATUS in the ISR before clearing it, allowing the
timeout handler to check the cached value under spinlock. Also guard
against curr_xfer being cleared by a concurrent workqueue completion.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index b37c1b9816f7..64ad17d38b84 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -214,6 +214,7 @@ struct tegra_qspi {
 	u32					tx_status;
 	u32					rx_status;
 	u32					status_reg;
+	u32					trans_status;
 	bool					is_packed;
 	bool					use_dma;
 
@@ -854,6 +855,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	tqspi->cur_rx_pos = 0;
 	tqspi->cur_tx_pos = 0;
 	tqspi->curr_xfer = t;
+	tqspi->trans_status = 0;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	if (is_first_of_msg) {
@@ -1068,26 +1070,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
  */
 static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
 {
+	unsigned long flags;
 	irqreturn_t ret;
-	u32 status;
 
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	if (!(status & QSPI_RDY))
+	spin_lock_irqsave(&tqspi->lock, flags);
+
+	if (!(tqspi->trans_status & QSPI_RDY)) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 		return -ETIMEDOUT;
+	}
 
 	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
+	 * ISR or workqueue may have already completed the transfer
+	 * and cleared curr_xfer between the completion timeout and now.
 	 */
+	if (!tqspi->curr_xfer) {
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		return 0;
+	}
+
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+
 	dev_warn_ratelimited(tqspi->dev,
 			     "QSPI interrupt timeout, but transfer complete\n");
 
-	/* Clear the transfer status */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
-
-	/* Manually trigger completion handler */
 	if (!tqspi->is_curr_dma_xfer)
 		ret = handle_cpu_based_xfer(tqspi);
 	else
@@ -1642,6 +1648,8 @@ static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
 	if (!(status & QSPI_RDY))
 		return IRQ_NONE;
 
+	tqspi->trans_status = status;
+
 	spin_lock(&tqspi->lock);
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 	tegra_qspi_mask_clear_irq(tqspi);
-- 
2.17.1

