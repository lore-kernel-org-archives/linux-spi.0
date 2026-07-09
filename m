Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98328CF5D;
	Thu,  9 Jul 2026 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566065; cv=fail; b=DJTuurfp3StZAlAK7paYLyfgBxuUbaqcbeuv0gEHhFvesH6AdEAU/D8t+ooybbEN3CygW+ZAjhhs6KQU4XixWprudd9Nm0+bXLTp7rR+rbykhPQTVZeB4/I3jg4ViJabBBe9r1qad2R7jok3Uxo4mjBD59vg6wnnmhgALFdC9O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566065; c=relaxed/simple;
	bh=2q/Ethja1FGE0m1mihhfto2bC0NY3ezU+ELOfBmFd4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIO+/EH71vr77rVLnn4pYSuUm4ygtUZNpv9FrMqb4M+s/cQQKt0BEf0RZlp5J29XmMkO0IZlWhDbw2rwhAPYWFb6fxzTncfSqMEutU8/sGj2Z8EbdFrvqGrra5E58RCjQirjCueUVOdx38Vti5hUsqA1MDmBzVtP0zhVHXuhoi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9sylY5e; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9sylY5e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLgq4FCJCBup5NEm4XVxLApIROiO2vn4+4WrzHvMmYSDESgEk0iruJGeUpsJzc59QE39t4UztLr2qTkrWJ+IQ2EggzdvhMEP7i9B1vrMr2LzWEFFOouuyR02oOxHChBhvyEuseX7mOEGZ/pBOl7Q8wIkgn7uW7CZ5TeBXwNXc13wwkKTC85sHXi8e9dtVlHhNwWjn+iYqzNyOHGKBw7CBeXzVbFwfCTMjfKQrqA9jsi3J5iu9ta5f7DWdIYD72Ik+2/UT15oPZMYxGgLRAVr1q9yRZkD3KMdt8Ldj2xGuSc4a4xeeKDPuwm58WT1qbTpQ725sS/XvIK7RvAfajsCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q/Ethja1FGE0m1mihhfto2bC0NY3ezU+ELOfBmFd4w=;
 b=wTEH/Da7p32PoT9tSd9t/PbWYYEp0NBDkX2zhJIvfgOJbobv7X2mI9kZ+mIYDC5wrUX2sHtPF0Gug01Rec4o9OtQt1K4oEIBesdkRH4vGvxtTMq5k12IaMBmnlfvMMDFZSrEwpQi1CBBUjmKxsWRUcCussFcBARugJpdqRQaoRt2GdnvbSM6iZHzr28On+CZjaR54naGPRNZoBHw920pOLIsyel9n7g1vgbrNxz462FVYQJMDgohd9p8QEArzX+i3X8M2k0/ervfGXH4tr6IF2kebtypVLYZLLZTVNvCIqhkmGJvYrvfbdz+Y6IxEzQxtgnk0aTpEkmeXgh/Pkpisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q/Ethja1FGE0m1mihhfto2bC0NY3ezU+ELOfBmFd4w=;
 b=q9sylY5erche6Xet5Ph6tIVtiQIcXmxTQy2QEAI/88oCCvXDn9xI6DJ3t0z61uANyp7WjvSYPdyrdaOvGNhtsyBr6+xcts36cTa9CAYONiczPV7wDDLWizKHvrvysU1yrC8wd/TFGeKbR69PW8NPMsRDkBwtqf91XYwmKHsfA8yvxnPpac0sUY7pxCPOsy/dNrusWs9cXHtOvL8NJpSokkAgFZPgnC5MdFW/yB3RUbwG+43DPpXbn9fiswOCkNRM5OjJ2waKFENe0NAsh9qIKH3ykBvUGgaOJvZnHcyc1FG/K/PMun5T3UmAPta9ISLBXMVqmA2sXatnwv7cNVrH8A==
Received: from DS7P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::7) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 9 Jul 2026 03:00:55 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::47) by DS7P221CA0017.outlook.office365.com
 (2603:10b6:8:25c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 03:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 03:00:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 20:00:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 20:00:34 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 8 Jul 2026 20:00:33 -0700
From: Vishwaroop A <va@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan
	<ldewangan@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, "Suresh
 Mangipudi" <smangipudi@nvidia.com>, Krishna Yarlagadda
	<kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Thu, 9 Jul 2026 03:00:33 +0000
Message-ID: <20260709030033.1753627-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ak4-h7tAemS9PmFk@gmail.com>
References: <20260708011257.1712961-1-va@nvidia.com> <20260708011257.1712961-2-va@nvidia.com> <ak4-h7tAemS9PmFk@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cca900c-c15a-49f2-1b2e-08dedd664b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xFESN4DbqvwlZpdpRv+adXwpQCivkxDT0Wv0w9i+70ku7KwF400vdS54EMK30Oc1ybOtKXah21aPNynriI5LEZzOgulgq+ymZPpcZiyx2OE2ztD8PnJwTMyJ8fYY4uz6itVhuaZQKyEqiq/cYJICN8l5SDUhT9HP6irzCpVpqYZly7zCC1uh3+qSXZsLpo8KdaTFI10ASSARrb20QIwyoB4YpvxUacBJN5sPFmQXzh0XbzQuEgCF6devw/GxNHjs+JftPiksalHKy0+H6SMps2MD19ybPJ97WpLM366SNMHTE6yxxbKME6rIn30xnLjf008SBxvGxOzuE8d8ObmeV3CRYFlzNhrjuuf/cLscgiSq5fTV5lnn88IS01iWf4aqrUrhm8sgx130frnGP5GAw5KWn8szldeWZD/iuAoayqYynn6pcG7BxZyNkHXLBNQ4exdEoYHuCrYWDOYpFx9MpF9hrhuH9CCCpVNZVuV9e1bCIv1Xin1x56LqNVJulGNHKnVi+IX2ST82hqJKd6f4Qt0Cc8ZfKa1jpkEX5joIE274J1nYKG5Ac050rXKmxwgiYuq+E/cLPWHewQajbhpDQCkUaukotk4tmNLYY++w7r5/g4qpnf/aHDKarg87R6jgVuxmlxl5oMrN4ZRGWJJvS6HbysuX0mDY3McLLnqQfDydR9QiRcoNIs1lLdeCvNfX/Y2D8gqJ7O6Asoyd1O6iQg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tP+1yInDwtggrCj0aiEm2++IQwjppaL7Mabm5yGCciZMiVIk1/tP0X9bBKQuNzdjkCX7V3N7T0yAdZsMWbUR1iWSp0ZtMamTHnFED/lN72wIH6zhoB7ybMCtjJEtE1xgOdfYsO8hE1bjN5DvOb2rAsHarC9Zx72hLIyxXqObHfjl5Jw0/UnQ/Z/9PShZWkDgEF0pbL+fW/qjrTgc1bdFWcMxMhG2AjaGqEX+szC9wJVVkFONU6jUTHEPBbW7h56McClrxn0mFOMWA/5mvZzgOpP1QTLW9MOEMRdP2glP32OSd6Uu4YhhGSySB55+RE+SGr7MGGM9+SDHSIY2HJjGGBWGvEPUKiDixWlfqdBiO7XP0Q5m/qh6KSySFqn/COy3wJ/oSZSOaPE1cQhe/DAkxpkR+b7wnMsA2s/5LFg/rRIdkDOB8Zapoo/2YcBcuoPy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:00:54.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cca900c-c15a-49f2-1b2e-08dedd664b3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Wed, Jul 08, 2026 at 05:15:25AM -0700, Breno Leitao wrote:
> I am still quite confused what tqspi->lock protects. In the code above,
> you get the lock, then you dereference tqspi->curr_xfer, and then it
> releases the lock, and use t later without any lock.

Just the pointer read against the writers - tegra_qspi_setup_transfer_one()
which publishes curr_xfer, and the completion paths which clear it.
After the snapshot, t refers to the transfer that was current at that
moment; later writes to tqspi->curr_xfer don't change t.

The spi_transfer object itself is kept alive by the SPI core, not by
this lock: tegra_qspi_{combined,non_combined}_seq_xfer() is parked in
wait_for_completion_timeout(&tqspi->xfer_completion) for this xfer,
so spi_finalize_current_message() cannot run and the message (and
its spi_transfers) cannot be handed back to the caller until we - or
the timeout path - signal xfer_completion.

> if tqspi->lock() is protecting curr_xfer, shouldn't you hold it for
> longer?

Can't - wait_for_completion_interruptible_timeout() below sleeps, so
holding spin_lock_irqsave() across it would trip
scheduling-while-atomic and stall IRQs for the duration.
handle_cpu_based_xfer() gets a single lock scope because it never
sleeps; the DMA path has to split.

Since v5, tegra_qspi_handle_timeout() also does
cancel_work_sync(&tqspi->irq_work) before invoking
handle_dma_based_xfer() itself (Mark's v4 concern), so the work
handler and the timeout handler can't both be inside this function
on the same transfer.

Thanks,
Vishwaroop
