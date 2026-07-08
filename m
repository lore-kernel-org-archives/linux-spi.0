Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64DC3ADB8D;
	Wed,  8 Jul 2026 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473207; cv=fail; b=tUZ1a7ZgSwtgNPZCJtxgDZzrQZFe5PEeEeG0Da+xJwhn2QvRKvw3GHXKlZMbokXhy23eDM5EmzV9SsMGXKlCk1bdSh8Xvtw6LRx79Nf0s2gARvR/9XFwDX4FfVcuKlyNbVMJrt9bZ340liybN0gTPiYeXbkxq5o3wXaOFhubpZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473207; c=relaxed/simple;
	bh=FaPZyOL7DiKY9FVYIX/9q24sme+0fJNvYN3ZOrUBAN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UC7CcFixPcvrGhds2P68mgGBisR/mgz5oQNZJHJzt7pBYbWcXXVXdsmQQPlJoLhumREcnXqAQnbvCrITa0du5dk9xoBUO1xvRcy5AJG/ooVMtB3+rmnC0QuuBzUdRgwi6/I6+Zo43SXv5B4dywycaYvM3Ns3mfPwrRivHyW15hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAUK+IGO; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NAUK+IGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugTfP+C12O54suIL74/MYH8+wl7Rh1ve3hcWnJZgt+tirul3a2juq4K2sZejMwOKiteKdrYw80OHNZjjStY0KPbZenJGE+K7DB22Qlu0MNzbQSy/ufPh9uSKkDg+nXzozmLF+i4MU+BX4ue9QfoMGwDXxMnOhi4q51nYMiE54ng0LAhM1dCnyF5iecjjQXBHCDsXkXSE6Yo2apYXXYWtBhvF8okIRzqKD7OLvtdh9n1+ezqQjnh/t9lGwrMtB9G7ukvbr9bDBWw8i/TkBdi5RyNvV8ZnCMg8n/6qCNzFx99lZU6G38DUNxvO41RdTZ1n0MkrUgTdOgFNAckTi243Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp0+SV5/sZdQjsSrDyQ7gDkKbalSXMTnLHqwd0MR7oo=;
 b=Kv5LwCz8JPtWC67DKODtHJGBCE6lKqriDBQ1U13cZas66/lOl933j5lcSOAOG3ewThmI/h8KWXENqgQ0Z8e1Yai5m6+3ii86JHD+Td8u9Y/R54qn1BgligHcN82B+GC5qZQYWfiBOt6po7Ll6TkvBpaWLJSA3xN77Lnz5gnpjs75gK233DlcPZQQ8J+bsB6lwisEbRGhYFX/L6FCQbgrow6oe91GK3bREVlc2UsjVhkuEqXDeKFizTnAaj6vuVFZ5nVSM2bp4fTjeyueKVedYXLPLDrlyjfOD4zAqloB+OjNt4U7dqFqsRARwHr6SU8VQV2NgQ/8PrRBl13jUdFufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp0+SV5/sZdQjsSrDyQ7gDkKbalSXMTnLHqwd0MR7oo=;
 b=NAUK+IGOGr9JqF4YAwrKaZyzgNLtk+guDur19uGvyy3FJchJ6HcvIZO+D0i8aTs48TzBsxAxJZo2YEdLCdoyJkGHSLXCOUHUw91HCqOgb1bEDNQjXttkmn3esnYqNiOFlDrsJjGc9Jv2oCUt8dAsYN9Nh0MG291ZUbbQKDOauMIQttGtkpTevuiE3Ab8zZHWLOIXLmKHEy0rUs7njfK67euyfel7GJYXaVnZEw1HcYyn8yoFKwlG00hn0pxLbf5TJUI5hIadM58k0dU3BvQzz5oPTjtMUfYGQt+gzfvWx7AwDkjyzU0tl7LSrfx6+1iAEHaEk8JuRJdktBD/xg0m4Q==
Received: from CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::23)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 01:13:12 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::8c) by CH0P220CA0009.outlook.office365.com
 (2603:10b6:610:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend
 Transport; Wed, 8 Jul 2026 01:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:13:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 18:12:57 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 7 Jul 2026 18:12:57 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Vishwaroop A <va@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>, Breno Leitao
	<leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Wed, 8 Jul 2026 01:12:54 +0000
Message-ID: <20260708011257.1712961-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: edafbf67-1b08-45f3-3f21-08dedc8e146a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	WwyP1ehV5v3I7hnX5jg62rWOPkaRxKCp400BlgQHiHX1iLo6zWZE2VGZwyXg6ELdeMoYb3kAdNE/QUvRUeiRy3kgxrZ41mdwLk3zZ0CEf1faN63ZhiSkztiKmJre4DQ4qhtKlBUHIaGpjLmgWIaMVIezOSNlVkrvcP41owBrD1MbU7rTw0Ahn3WcA4njalgaO8kh+3I4kitsyAcltZ3T0bhG5WYLw6moAzbFZZmVZAOhz7ckk7b0weoGo76/2XDbGYTK08RvkKXiQuv3Ez8GwkNPt/bEw3cnUp4ZbdIQnX0HGk1kdKCgXTscAaR65TMEbraJBgSBKbNU2UodBT9+2qr7CTEjguLP1KGj9Gho8pxces9Yn6g5fIqEJc0zGrekyw2xWC5gYDgaQvckHZ9T/wSHliYj/1OXSJhp2KnbRNB3hUFmOGe/78fDvvAmRQebgt+ogjgUEEnDqlwWZaPxzhnXULWWaxvb5FpU+ske6PdENcI0csWCTzcgpL74mkIx2X+3QrMbouCuO0K6folBk0b2MJdudp5EyyvXk1CQ+mdp8mCP8awsGg+RhEtyiHRziwltjGY0+sE9n0TEcRnVcNssDM5I4Yhv6ou4Df9JFKp7NGtTnDFOumeosN04SOGFHsYH0ZfRRSo6r92YSIVK0LniF72HJQRpRcySomLQKpS9bsgHykP8/nrs2mGMzqBGVDvbymdqEX/EV7a8TtAMEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lqy8UpvYIpqoTfm06uDlIiCOx7EAZLJtkY3cbRxs1wP45FA3T7nPiZu5JOMFERatHakvPX0wVd4nEGXt8u7Ii+2ZVxjRMJ8IgB1CA+QoCyLu12+XgUibPJ7OTXX0QizJT56J+Y7Ax3lntqi/FxUApcghXF8CiiRaQ6onp+XPxcdYl4iNAV0mtrkVAUma9p25miDChndjXQABFM9bfRTJLdIf5ESoUuhhWfTbgoiuKtUwL83uTEvb9m64W/JfdyNs1wCTdmSc4VBV8jWGrF3CDlqYSdq33FLNhzfpqHup/Vz9qlRGXtnwQ2WOKkQPR/oefI5N+v3QxD1H1+x5bt7ZgVMTPp4Pj9wVuA+3amzF0dk9qniFCZeEIXOhjahY0QFD1wdl0+Xk8p2t2dki+r6j+f48zQ4ndB/phRPqCD7AYFhCrQCAzO2R0WBYixSAWoe9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:11.7619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edafbf67-1b08-45f3-3f21-08dedc8e146a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668

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

Runtime PM lifetime note (unchanged from v4): the work handler only
touches QSPI MMIO when curr_xfer is non-NULL. While curr_xfer is set,
the transfer thread is blocked in wait_for_completion_timeout() with
the SPI core's runtime PM reference held, so the clocks are guaranteed
on. When the work handler runs late after the timeout path has already
processed the transfer, it sees curr_xfer == NULL and returns without
any MMIO. With this invariant no additional PM reference handoff
between the ISR and the work handler is needed.

Changes since v4 (addressing review by Mark Brown [1]):

  Patch 1 ("Convert to hard IRQ with high-priority workqueue"):
    - Rewrote the tegra_qspi_work_handler() comment to describe the
      new serialisation invariant honestly: with the cancel_work_sync()
      added to tegra_qspi_handle_timeout() in patch 2, the work handler
      is never concurrent with the timeout path. The curr_xfer NULL
      check that remains simply catches the case where the timeout
      path already tore the transfer down before this work got a CPU.
      Addresses Mark's "Can't the timeout handler also be running at
      the same time as this?" comment.
    - Converted the tegra_qspi_isr() header comment to a proper
      kernel-doc block, with @irq / @context_data / Return: fields.
      No functional change.

  Patch 2 ("Cache TRANS_STATUS in ISR for timeout handler"):
    - Serialise tegra_qspi_handle_timeout() against the workqueue.
      Mask the controller IRQ (tegra_qspi_mask_clear_irq()) and then
      cancel_work_sync(&tqspi->irq_work) at the top of the recovery
      path, and re-check curr_xfer under the spinlock afterwards.
      Once cancel_work_sync() returns the bottom half is neither
      running nor pending, so the subsequent
      handle_{cpu,dma}_based_xfer() call from the timeout handler
      cannot race with the same call from the work handler. Addresses
      Mark's "This can be called from both tegra_qspi_work_handler()
      and tegra_qspi_handle_timeout() - I can't see what stops them
      both handling and completing the same transfer simultaneously?"
      review comment.
    - Clear the cached trans_status per chunk. Add
      smp_store_release(&trans_status, 0) immediately before
      tegra_qspi_unmask_irq() in both tegra_qspi_start_cpu_based_
      transfer() and tegra_qspi_start_dma_based_transfer(), so a
      multi-chunk DMA transfer (or the DMA -> PIO tail-chunk
      transition) cannot leave a stale RDY from chunk N in the cache
      when chunk N+1's completion times out. The store happens-before
      the unmask, and the new chunk's IRQ cannot fire until the
      controller register write below the unmask, so ordering with
      smp_load_acquire() in tegra_qspi_handle_timeout() is preserved.
      Addresses Mark's "It looks like the CPU based transfer function
      supports multiple interrupts per transfer ... don't we need to
      clear trans_status when we handle the interrupt as well?" review
      comment.
    - Take tqspi->lock across the ISR's status snapshot and cache
      publish sequence, and move tegra_qspi_mask_clear_irq() inside
      the locked region. This closes the QSPI_INTR_MASK RMW race
      Mark had already flagged on v3: setup_transfer_one()'s
      mask_clear_irq() and the ISR's mask_clear_irq() no longer race
      on the shared INTR_MASK register, and the cached status /
      status_reg fields are published atomically with respect to
      other tqspi->lock holders.

  Patch 3 ("Process small PIO transfers in hard IRQ context"):
    - Comment-only reflows to match the surrounding text and clarify
      that the fastpath cannot recurse into
      tegra_qspi_start_cpu_based_transfer() from hard IRQ context
      (multi-chunk PIO is only set on the final chunk, so the
      continuation path is intrinsically single-chunk).

No functional changes in patch 3.

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
      published with WRITE_ONCE() and smp_store_release() and consumed
      with smp_load_acquire() in tegra_qspi_handle_timeout(), so a
      timeout handler that observes non-zero trans_status also sees a
      coherent snapshot of the other fields on weakly-ordered
      architectures. Live MMIO fallback via tegra_qspi_readl() only
      runs when the cache is still zero (the ISR never ran).
    - Kept the WRITE_ONCE / dev_warn_ratelimited() / dev_err()
      diagnostics scaffolding around the wait_for_completion_timeout()
      calls in tegra_qspi_{combined,non_combined}_seq_xfer(). With
      the recovery path in place a timeout is no longer a programming
      error; the existing dev_warn_ratelimited("QSPI interrupt
      timeout, but transfer complete") and dev_err("transfer
      timeout") diagnostics are preserved.

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

Tested on Tegra234 (Ferrix P3960) under sustained CPU stress (stress-ng
--cpu $(nproc) --timeout 3600s) while running dd if=/dev/mtd0 of=/dev/null
bs=1M count=100 in a loop; no QSPI timeouts, no softlockups, no lockdep
warnings, and mtd read/write + md5sum round-trip clean.

The series is based on linux-next (next-20260706).

[1] https://lore.kernel.org/linux-spi/cover.1781037385.git.va@nvidia.com/

Vishwaroop A (3):
  spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
  spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
  spi: tegra210-quad: Process small PIO transfers in hard IRQ context

 drivers/spi/spi-tegra210-quad.c | 324 ++++++++++++++++++++++++++------
 1 file changed, 265 insertions(+), 59 deletions(-)

-- 
2.17.1

