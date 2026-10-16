Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4E4C77A3;
	Fri, 16 Oct 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157157; cv=fail; b=k3I5ENSQlNNQkrgX8JRGUyn4L9PHAI+7rN1OzHlWaJgB3d2ejbLHmDD+HVi26SAqeAzOamF8inUW7lTVxg5meqQyJHoVmHACW+9T7H9BC2ZrdawjlyQVICYfCsxkFkAtt+wcyvHvFnpcg0TcSdsH8hsoSFrPWzid6r2kH0jv0xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157157; c=relaxed/simple;
	bh=hPZA9qi36brLVpPKP3NK4juP3U7yLqdr6HNI0TGrNuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0OJPXhj3JBbMZLvn30Pu7VQKr2QSSwiczYUmoX2SVpjsVlQ4BnmPVGCfaISoeUFxXAojk6ag0/+JWjtv//D4XbK3zSUzCWOwIaAitmnbN7vh7NUFPCgAtylwx002nWqwU2xFrfBgKwUXE7zFI5WWoOe+rbO4N46ygPRxXLv3OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMJ685i9; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMJ685i9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl+pwvu+7IJWJUMZyQ7W0Wd4mNqkq3msyvggKmc4weJmSoaw6iTPv2HWUrzXs+4t6kICLDciAhRAS4pjA1KBTAUgAcDQx6qip6r5C2pZCPgnJBORB/ZdeJuQanXDKXA0+zKL1zOCzTxK6Snapr+Zyp+hkGJfz2Mzn+edyGkdb//XwahyZBCMCPC8mMUTGvTDcCVqdU1EugeSTUV385tMD3wEdjKjbhoBHUGE/NQJu+q3DOU4epOnFlwr/QrnV4JmEYz/XusudycyXWZxFLAqXXUHZcncOAO8026fn7Xk/HrHdL3JuziQGiMMXNIjPrBfD9FOcJ6NEkB3mcYa/W/6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyAsyGG/jlVKXj46dmIfsmWbii62IxqvRaDwRZ4zHNY=;
 b=m6nSvADtGJC/pmu6U2uiVujhg6nH+Dt1FWI0Q6vZ0SuOFZ4vteQhlZaK1VCyK9ZuQytqeaQ1HEzx3MYxRipnNSmOoS+8KlhKWFEX18VgeBcRwbC1Cam3hIzh33ASQjRYD2x8lV8XlTMzSaB8fxDikXysutRnY+OhPw9B7XngWfZeRRSYm+m1SAmjsfjHdBtDtkgFTYAABlOrLvlqkNLEyiX7uhngQAAN6lOEcI2n84bZc83wnPkQwzZZUnLEaRBEw/+oR6mb0vu53S4mQ/NqdBH2ktrnLLKiSOAB3ppqXM8gLTQFzQs9m4xjCzcrmgWOKzYbVZW9bWTEfrb/Ft2rSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyAsyGG/jlVKXj46dmIfsmWbii62IxqvRaDwRZ4zHNY=;
 b=YMJ685i92utwQwcwW6++C8DOYKgnjxRuTRroJtYI+gCMj6UZZdxo1CT7mWKJZmFrhlnwRac42PpAG4GFetxcijPuWVLbgbN1b9DsP/twtFPqp1TGzuOxOzzODJLjCx6y+CUoKJfiM+Ouf8fs0YIsIwdT4g2/4GZ0/HiADdqruRaOK5QZYfOWjVpXivMrM7jO2e33GaXback7ysDqkLdk6MrWVfbDC1Mkg7x1oiKsZhA93KMxjsSskE1gfO4y/xEpyyec/Cvzb6TgbM5Glalclh4UJAQdJjHCZ6NCLg43f7y7CFk9hLOYU+tnSHz3dZhyzySjgLhcYXD01MMmuQEFBA==
Received: from CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::10)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 13:25:48 +0000
Received: from CH3PEPF0002457A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::4) by CH0P223CA0020.outlook.office365.com
 (2603:10b6:610:116::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 13:25:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0002457A.mail.protection.outlook.com (10.167.252.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 13:25:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 06:25:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 06:25:20 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 16 Oct 2026 06:25:20 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
Date: Fri, 16 Oct 2026 13:25:19 +0000
Message-ID: <20261016132520.3723412-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261016132520.3723412-1-va@nvidia.com>
References: <20261016132520.3723412-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457A:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 005cce58-6823-48d1-2419-08df2b88fde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|22082099003|10067099003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9UQn+zVkXGAo2nP9almQb0rPivMUVEZv8x7vN4sYl7m/RK9vqak1a0OFMFt6Vela+9N5er1ezWhDLQpIrOMVGBfGEL1q9kUOwU6EOkBOS42DNi2/YVx9Ex1a64alY0J2WnkdmAVCm0X+ZwJoBzUbTWWAwF1Lt6jBLo4PBGoKhvxHMQ/UssfaWkrRVg8oS3jZ7uWRLJK7XNPNABKpK4Yy0NeliNPJLR+tgKiCHQ1RHjDJtvlL54xCh97UOTWn+9uot4FxipNx8ICK1gVmKs6f4PJY7y3rrR/ySeKDRMWuaDFod8+4/q2S6S2PR7s/75SGtE0tYLwtuzuKn6lGChdFLocp6isUQX+RXqiKcyNVl19Sk+K/kSFVIdJTQca1zYyBY3aqYTkCggaxxcuRP6b3yX1HTi7lVQodWfeuV2nhgpEsuMgcS8rVF8p0JNcfpvPP9VtDQ/v+7cfjZUongqizwYxYoyoCiTfo/sJ+e9KSrcAHpyH5HBOhUzMCeFIAjH1nzcyR+zXDcYMFzk+v4hzl0rbZwcaLHOKj9h5+59UcoiG/WR/16eCBOe2CJJzqZo2jJFRYFAjS0O5YFaXOoQF6B2p7WTLrjqv6fnwAEyiTn8lKy/tIenrR/UZ7c0Y6Qfr2tX7mcfA7sToFKN96V5sBA2JZ7IH9TETDX2aaLx1+alIm6vX4CCcW52LJUWOt4qhQuWRjHQu1NAlhSgG//bulfg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zu4zriHt8TYN0zfe6Y/vbFaT40IqIAWeNQXyb+vKVmng0cj+3Ux7EtUiET/90DxgKUu0koilaagkzH6OSHCJV1YkZfvZMQqI1w74jAO7hYwsY0N6JvvWllAI97Y+/5tj+AdR3XIJfSgcoJIs1A9xUgQxkBfnEw7g0NF+pfYAxZH1CAv/EWAoL1svHa8roYhifbg1F1bvhUIgCdEAARNNEBTzr0HWIu/YhgOlXtQoou+fcR3QqvKpbUNkfFFIYpk7bnD13cb02tbkHi9OOlhP9FLzQUhYx+eKGKCJ7D+hsmlxJJKf+Z9DQod3l1t9lDxvWpNKUeLHHc7AkREPxPsaUaB5VuMoSLTneYkOagDZeNAgocOwHJSnP4BjBSbYqvZ1INGjvP9noGzgwCAeRExjyT8ZxSbh6R4rsMBmerjqZ5I0jnIUwLXxiJ0wncAl4d+N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:25:48.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005cce58-6823-48d1-2419-08df2b88fde5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737

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

