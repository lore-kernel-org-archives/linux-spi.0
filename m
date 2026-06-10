Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683037205F;
	Wed, 10 Jun 2026 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072661; cv=fail; b=rI6rCrbi04cN3UByAZ4PTzrV88V60MPtMUeTJd6pALpLLF9Lt2x9oPGOyPGaS6stqaz7AJsmV+kQtsDOBs2uC/7mtMUDEVVgjhxOUm7gFcF+4XMkYrmLPeCLKrmT8Ftjk4hgw4ZiV70Znr8VQntbByUe7oYqdpzm+Bsak9LBSyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072661; c=relaxed/simple;
	bh=1h/aQfSkIBJ1QJFcR5Hyv+1ELy7DRTbVojtkEa13tag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6q+XnepjimZvck/os5d2VtuUAxqcopJhBPLnkmDSzT44RgBhxwzf/8h0DtFmjNZWH4+4N0UOQncEWZ7VtIaJ8/klDPIB1Fjivbhy+WGXYO4m8EjZa8YB3yrw8OpiEP8+cotA091av2zNX/1WzSjchwZ/9wRdk6TVCpM93a+z0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RITUXgH1; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RITUXgH1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcCQqKr6CRAz6Ei+2B5XfgVDFaZJgfQ5/gImLvd5mPaE4C8FBBdEDCznoTem5VuJSZE0Q64M6ooXjWCJLmlisCEMeINjQlYbApoZc+XCE+TnZI1AeFDJyXxQMXQEEmPL7yoZyBTIiGXZ2phJ0M+Ccgg8SZu/VH/tDDdyUHYmmupfux/RCcw1kIl/avbVYxZKZNTTRfXFDBZ6Zww/DsOrkax/FdGYLn7mEpbhhYkMSZF0cEMYkrjA4IxlrwcsdyQm4PB0Nwhg6tXDnKj8bzhQ1i+GImv4mPUKq6EAYa36AlKxb2k40476dZ2FSaKoBmxpt91qnyMOnXJEHEgm9W6Lqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liC4AcJbVOiSTQwWxNbRVqppVWEHrSi4k/D/UCLaRHM=;
 b=L2AIbYghr/EX/16jnJXSWFEADEtLowP8+Zm61KorbAe2sTx6J4zGkNT9Bm7ZoAyCxy5BfiX7astDxp7I+T0zeVFCHtfNrpioJKqzyvud9jegvfuQnkfibOtigFm1sfvcQ2bU5NwKwWlpqyQHIlPvgsysxGD8SkTVLgQhl364iaSrVuODnVD6SI3yR+KnoPbHnX7M/0gYfvwzqEZlqk0XxqmZqoMdrPQ5Zv8PfILBJ2cqPz1bmfkLpC0CTUhi7ZIQVmiJJYdp8CYi/pB3/hslNv0fxeqcD3GJKFw89ZUCzOJoGekD1H2ux2ihc/IgWBd0KwYfJ0Mq/gAkXNLxwRZlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liC4AcJbVOiSTQwWxNbRVqppVWEHrSi4k/D/UCLaRHM=;
 b=RITUXgH1LdveN+NMnYsyFHXmHEsOWgd0zOcHon9JO5QDqXYiXqjS7/2Pqoh3eiOWIrQQkTYtq2k+P3eoNEjC8pMQ5vOkIHe7rukddidesXltCAaiR1k6FaSQAweBiQOzdscgvWZcbvK2sXy+9pBqouYp4rVF6t9g3gtfE0VP/AF//vmQcDeCzW1GyYJCVDKTSNqPiYV1QUHHMaqT0kfBePxS9wnbAmwWoa6ZlmjAtwJP/WN9vYFj1pBxFE0llbr+DE+nsX+izbEZB7DA5xUPyn1HMbLmBJbRb/c++Qkho7nwxD1wRsBZ6qCO+Z4ieA3nm8IsEwcjj934bDwYkjVCDQ==
Received: from MN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:52f::16)
 by CH1PR12MB9597.namprd12.prod.outlook.com (2603:10b6:610:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 06:24:13 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::6b) by MN0PR03CA0028.outlook.office365.com
 (2603:10b6:208:52f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 06:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 06:24:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 23:24:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Jun 2026 23:24:02 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 9 Jun 2026 23:24:02 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Wed, 10 Jun 2026 06:23:59 +0000
Message-ID: <cover.1781037385.git.va@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CH1PR12MB9597:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0dde1c-d328-4b67-e296-08dec6b8e3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eK/6XE7ZsPDSEu/hiTHu9gx3SCIRBqd2cEusnXJAP9ZdiXQvV6Ye003frUrhPXpTjImR7RZr9g4Ua8pciOXFcVY88q5h2QcgnGmtf17crOBdWQ80qRoKUowTM/Fa90eyQGU+fABxGoHH/wqhY8JznMKsSf9OZOvcnO+P5tAJbbRgwianAknFkS0yNE1hIo1ZjrVOgc2QVXvoh34Q8EcslrVYD942jhu+egf+KbaUPQ9/ItMP8J4vU7BHnB2uFhegciS5f5QbJZzCYAEOD2yLDQ1DiZriijW22XoNhqj2vUjcB1+Ti+61jeu1mWP0KlpIgzMrr5A81bwtl19I2c8rmKdn7VKIg18FuF2Hb7GkVsGL57E7NvpLNoqzXBH6sWf2x7ujIiKzaAS4CAzszcgTvlH3Xlww+AIU1jlnCZcxkwZYe9cWbQtlg5zV64pOC9mdRyTCDDSNx61xVR22BO6GSftUnSb5Zk1DsgPjbbx3E5xO8ovG0Qq5zy9fjD+Xyz1xJF8FBxFSjRWb77NBy/bxYRi682TcSo1edC11CbVKaprrDhWdtgVmhn6B62xJp1WL+rgrEcs2cF5bQ+H2rr0gqsijgmgJAFzs0lwsJ3Cq3D/z9iZqAc4mrfBnyFdoKz/MqZHbxAjBwVV2Buor0O/MyeqQFadUTg2s7undbTUhjdjM8WeJ4+Zk3A9tdPreihBHs028O7dL2V2iAMBSRAklwFS8gGe1gZSAddtAwahS3Y4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I8DIXocNJjPyBvzZNvBxXU/VIf9EZb+jRjsFksYYWwPtlcQoDoZRW4Z/7rnlkhd2jVY1UGszu/N1wBbFBicbL3tklDo5OVl9DxbkkG9+XldcEP79C2/Dkc2SNERKg/wEiuMjMT51ycesilL+QvXrB+x7C7lzMmM2v+2+46IGFgAb0suPjJqPmkcexkp/jZM1v2U7AmH+p+CajYCZottz79UKOlrL8SQ/mILK+CEOxlzftrO7GSVihC4YdOd/p/eDZlT1kzvEoq6X1r47WQ4ANXRWor5gCFfrFBc7vMnJbIP9S/40sO8bXWK/LQeB96vpH4hYQMzaJ5lPq1GPZV89YzDE0p85XFF5GjtE5xUADrY9V4DCoT7j1+QFyawry5+xGM+thWWdsgjLn+AmHWfJnXf6zFfRVmg8JOqou4sX7gTSkDvn1GJUTQCcnWwZUPGy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 06:24:12.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0dde1c-d328-4b67-e296-08dec6b8e3d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9597

The current threaded IRQ implementation in spi-tegra210-quad suffers from
scheduler-induced latency on heavily loaded systems. Because threaded IRQ
handlers are subject to CFS scheduling, they can be delayed long enough to
trigger transfer timeouts even though hardware completes in microseconds.
This results in false timeout errors and WARN_ON splats during normal
operation.

This series addresses the problem in three steps:

1. Convert the threaded IRQ handler to a hard IRQ + high-priority unbound
   workqueue model. The hard IRQ does the minimum: capture FIFO status,
   mask and clear the controller IRQ, then schedule the bottom half. The
   workqueue handler runs in process context (can sleep for DMA
   completion) and can execute on any CPU, avoiding the CPU0 bottleneck
   inherent in threaded IRQs.

2. Cache QSPI_TRANS_STATUS in the ISR before clearing it. This lets the
   timeout handler distinguish between a real hardware timeout (QSPI_RDY
   not set) and a delayed workqueue (QSPI_RDY set), preventing false
   timeout errors when hardware has already completed. Pair the cache
   publication with smp_store_release()/smp_load_acquire() so the timeout
   handler observes a coherent set of cached fields on weakly-ordered
   architectures.

3. Process small PIO transfers (those that complete the whole spi_transfer
   in a single chunk) directly in hard IRQ context, eliminating workqueue
   scheduling latency for TPM-style short reads.

Changes since v3:

  Patch 1 ("Convert to hard IRQ with high-priority workqueue"):
    - Dropped IRQF_SHARED. Tegra QSPI uses a dedicated GIC SPI line on
      every SoC that uses this driver, so the ISR does not need a
      runtime PM reference. Addresses Mark Brown's "Since we now have
      IRQF_SHARED we need to take a runtime PM reference here" comment.
    - Switched from devm_request_irq() to plain request_irq() in
      probe() and added explicit free_irq() in remove(), in the order:
      spi_unregister_controller -> free_irq -> destroy_workqueue ->
      pm_runtime_dont_use_autosuspend -> pm_runtime_force_suspend ->
      tegra_qspi_deinit_dma. Addresses Mark's "devm + non-devm mix
      seems likely to be racy" comments on probe() and remove().
    - Removed the tegra_qspi_unmask_irq() call from the work_handler
      NULL-bail path. Addresses Mark's "unmask after dropping the lock
      feels like it opens up races" comment. The next transfer's setup
      path re-arms the IRQ.
    - Snapshot tqspi->curr_xfer under tqspi->lock at the top of
      handle_dma_based_xfer() so the (potentially long) DMA waits
      operate on a stable transfer pointer even if the timeout path
      clears curr_xfer concurrently. Integrates cleanly with Breno
      Leitao's recently merged protect-curr_xfer series.

  Patch 2 ("Cache TRANS_STATUS in ISR for timeout handler"):
    - Cached status_reg / tx_status / rx_status / trans_status are now
      published with WRITE_ONCE() and smp_store_release() in the ISR
      and consumed with smp_load_acquire() in
      tegra_qspi_handle_timeout(). This keeps KCSAN clean across the
      hard-IRQ / process-context boundary.
    - Reset the cached trans_status to zero in
      tegra_qspi_setup_transfer_one() (under tqspi->lock) before
      unmasking the IRQ for the new transfer, so a stale RDY bit from
      the previous transfer cannot mislead the timeout handler.
    - Dropped the WARN_ON() / WARN_ON_ONCE() wrappers around the
      wait_for_completion_timeout() calls in
      tegra_qspi_{combined,non_combined}_seq_xfer(). With the new
      recovery path in place a timeout is no longer a programming
      error; the existing dev_warn_ratelimited("QSPI interrupt
      timeout, but transfer complete") and dev_err("transfer timeout")
      diagnostics are preserved.

  Patch 3 ("Process small PIO transfers in hard IRQ context"):
    - Replaced the previous "curr_dma_words <= QSPI_FIFO_DEPTH" check
      with a tqspi->is_last_pio_chunk scalar computed in
      tegra_qspi_start_cpu_based_transfer() before it unmasks the IRQ.
      Addresses Mark Brown's "Is cur_dma_words always in the same
      units as QSPI_FIFO_DEPTH - I see there's packed transfer support
      in the driver?" comment: the scalar comparison is units-correct
      (cur_pos + curr_dma_words * bytes_per_word >= t->len) and the
      hard-IRQ fastpath no longer dereferences the spi_transfer
      object, so it stays safe against any teardown race that could
      clear curr_xfer concurrently.
    - Fastpath additionally gates on tx_status == 0 && rx_status == 0
      because handle_cpu_based_xfer()'s error path calls
      tegra_qspi_handle_error() -> device_reset(), which can sleep and
      must not run from hard IRQ context.
    - is_curr_dma_xfer and is_last_pio_chunk are written from process
      context (the transfer-start functions) and read lock-free from
      the hard IRQ handler and the workqueue handler, so the writers
      use WRITE_ONCE() and the readers use READ_ONCE() to prevent
      compiler tearing and silence KCSAN.

Changes since v2:
  - Added cancel_work_sync() in remove to flush pending work before
    devm tore down the workqueue (Jon Hunter). v4 has replaced devm
    altogether per Mark Brown's comment, so the explicit teardown now
    relies on free_irq() preventing new work being queued, followed by
    destroy_workqueue() draining what is in-flight.
  - Rewrote patch 2 commit message to describe the race in terms of
    the workqueue model rather than referencing the old threaded IRQ
    (Jon).
  - s/NULLed/cleared/ in code comment (Jon).

Changes since v1:
  - Switched to devm_alloc_workqueue() and devm_request_irq() for
    resource management (Jon Hunter). v4 has since reverted to
    non-devm for the IRQ and workqueue per Mark Brown's review, so
    teardown order can be made explicit.
  - Improved patch 2 commit message to explain the timeout race
    scenario and clarify that the issue pre-exists the workqueue
    conversion (Jon).
  - Removed unnecessary local variable in tegra_qspi_handle_timeout
    (Jon).
  - Moved "workqueue was delayed" comment updates from patch 2 to
    patch 1, since patch 1 introduces the workqueue (Jon).

Tested on TH500 with TPM and QSPI flash devices under sustained CPU
stress (stress-ng), and on Tegra234 (P3960 / P3970) under similar
load. With the v4 series applied, transfers complete correctly without
spurious timeout errors or WARN_ON splats.

Vishwaroop A (3):
  spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
  spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
  spi: tegra210-quad: Process small PIO transfers in hard IRQ context

 drivers/spi/spi-tegra210-quad.c | 280 +++++++++++++++++++++++++-------
 1 file changed, 221 insertions(+), 59 deletions(-)

-- 
2.17.1

