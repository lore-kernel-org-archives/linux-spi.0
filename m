Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC96427F85;
	Thu, 13 Aug 2026 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651259; cv=fail; b=hWAC86iX+b3ajiKVeywwsZ80DMvbRNXCW6q7WtpP9YywiVZSHMtfen1cgY4aMAZwywxDAM+vgz53TKSx/IqJXYe3TGo6KxoZ2ty+Y5lzWsxQjkT9VPBszUCilTX2patYwOa83dsMwFRkAy/4za8/8Rew8+2QxdS3YG6x5TiSPdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651259; c=relaxed/simple;
	bh=zpS1bSBYYjraxxRMlr4EpvlGANZcXQ6oyyte1HEp9zE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cy8VY6JCzhEOf6epUshHX0W21NdAxRoSFLtGjOclcORzShEFs8qFBE9kViIeSz5rAWOf01bai0QNACPVJHOtT7578arFfECYkPq2Fj9hpssdSlhmOdxwu9bNPLX6+lIjTMkeWpcFdOlPhrKdQdmJp/V5v0to7sRQuvddlSrixgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lQu1/tXe; arc=fail smtp.client-ip=40.93.194.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lQu1/tXe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLSdsD8Dfdrfq+5qX/m5aYL+ThveuwIqQS8rsBXa6yixDgf5jJ83rP+ICb1dRVcpKY5ItPX/UJuywYv6T29exZygs7WvXRJeIzY9T6X3aPgLMWTtzW6HrVYfCJ7uV2yPHcrBqOyEBrNExNPusaXQXI3S++q9/52ZT2tHaWUv4Rc8IgMSCT0pR4XfXJeryRGfcsZFAomy9fAGmgxPEbArzgDxV3JJj743vE3I47ioK3K8I87O2bCcMknVQvnvN2PEqwGULRtMPK7s+j10e5UCVcn49r4wF3OQZHgB2JD50GrLzWEaJyLVw24Njc3BQ5uquafHwQmL5SriW+w3jdk9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBQN6BDiE33dQJwNkP/e2xc3lWTeuXaMkkA+qLP6bIQ=;
 b=LM1bb0NoL3JWurg1zokeWnZc6BY731mrfLWRXJ0H72evUjeiH3cBylOA/i3k3eQ6YBpr70+Gduq3TpUrn7AsX4GIgW59o94TX/V4+T+rU+36GGS/KSy8y8xkSayakEAuZ24da41yP4h4J89uJyHRDLdvLrEyQurtDD/IsCx7vpM7Cm083CpvuuZDNuT1PDtbkRvgFfDlXMJQMgv8yUY4wsO39n5Qb7nk9K//5T/miUWIAZ9le8yPq+zmcDLh9A062Sb6f1qDnHGL8ZqbPwYYcov4rrXcue9pcWaq5xSg/2Yy6bUnR75ZQ6oT0N4uhp0wkbrDECn2upTsP/3Gxnw98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBQN6BDiE33dQJwNkP/e2xc3lWTeuXaMkkA+qLP6bIQ=;
 b=lQu1/tXe/EW636ty/7RmWOeKJFQU4bp2lFkthoP0H8AOd53QpiRBGvDacVGgXY/BHLX6/NZrHpvgJSRmnnPYKWoCVfT4xpshMtdg04jmx66bIt7mOal3DysJ6FAzxfSycv1e0jKkNm9X1RGPP9pTLSk5v5jRIiiYvo7a9WBQoN8LgBjQgpqI2/dgVufbC3wFhIztzjZpFKLK1SdRZDx0US/qIgjdiD/doUIuX7rAmF0dlmC5psLG/79cLJPGRqvokFfaSZySgyXyX/Nf6YcDP7k/N3Ftyi3TJuj3DV8WS23XiLqX+6UNHUkVKaMe2vVNynrXt7LNEwwLtlaSAepFdA==
Received: from SJ0PR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:332::13)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Thu, 13 Aug 2026 20:00:46 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::2a) by SJ0PR05CA0068.outlook.office365.com
 (2603:10b6:a03:332::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Thu,
 13 Aug 2026 20:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 20:00:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 13:00:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 13:00:27 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 13 Aug 2026 13:00:26 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: Thierry Reding <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Breno Leitao <leitao@debian.org>,
	"Suresh Mangipudi" <smangipudi@nvidia.com>, Krishna Yarlagadda
	<kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vishwaroop A
	<va@nvidia.com>
Subject: [PATCH v6 0/3] spi: tegra210-quad: Improve interrupt handling for loaded systems
Date: Thu, 13 Aug 2026 20:00:24 +0000
Message-ID: <20260813200027.2711863-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f59ef89-6fc0-4a3e-e29d-08def975902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|10067099003|56012099006|5023799004|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/XTekLtTjWY11jMxhpPX/+PHViTT0S0ksRIPkw09Et6ZOkq82hayAbh6jQkc7JPEMoHQ6INIeO0K/43PVG0JyavQtbdEPZZhtTWIjE4sTOT2q7bKhSlx4g28drxZcoDOToWo/ki7+UZWuakI4F0mlLcOck5ydUNKxjs72plPSk/t+KAGXpzr9BlCVHVyFkz31+M0TATJxuV7ttzTVI4MVMjCfaTR0YTczez7sXSmM9adqA69vL4FIhV7HqgAFbnCHQDG53eHufQsBWElNblN0v2/lnfTyLnyK2M/2AdcHt6RmhEtWXkDTEQ4PBD1o69im60xh1e/Lg7/1VXP4AxSTrpB3BT71wMSN2vH0dLPKm9enMUToPpQ4aVaOyjMYrYW70Mtr9Cfj12pPpDTwFOdx+71oJLrSxq4Dfd4BenzRTNH53unCvlgkRcP8N4GgE5mxDsoKpbJ7Gkb1Bt/yjePAVGZBK7RNNecPVELFchyNvQ0bc+KrDJomljCGEYc6ilJ77PThqhb539zAsllG4nzxDho6pC3Mshecch6PO1INQ4eFZxekOFY3s7w3P/zFEz/+5172SQrOEx+ziLT/VvkQjQDKAFPrnkZq6iR+Plb63LwWdVjGMpeOVztWX6aD8qV2WQk06TYBnHG6Ya/jPb72kQksJEn2crLMhtZmgpbclN0WG/a2ZaQA/zZQB/GCSUQn8DiJFSzQPx23Y2koewEXQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgb46Vsal5L9CNQ6iO41CCPotdymPH74b5B1iT6fqGkhW32WwDDSQD5ANz1hMyCavYTyESTmK3lS5vzXed66rWUY/LGYrtxDV/lwy4/opnqzhzC7PjiGV7ZXjqDgUYuhSPvxFPzN8L/YmqRqH7ElRbXQplrtHcD+0lzyI5lYFoh1WF2ZLqGyPDw4U7LGfTpUDnWAZgBz4XVYjdXRZnrIyV0WLQDGspsoVxE42g1t991fWVdl3RZd+Fd0Q9AGJaoe/4YIQ/VFfdyz0+Awy+pt2BDzD0wtvxAghTuxoOrLtOnqv6pB3QMmGV2KnC+rRjx18uOtpcJpl9TZ7Xe7JTdp1sNXnQe8i/0Iq3/Ss4ctLX9ghyDeaMlJNtlttp+e/vGhnttzFxTlO/knpBOpEA4DKlGUl9Hc3LRmb792T8KFbx7b1QOZog5LmGECs1solCvW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:00:45.7968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f59ef89-6fc0-4a3e-e29d-08def975902e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022

The current threaded IRQ implementation in spi-tegra210-quad suffers
from scheduler-induced latency on heavily loaded systems. The old
irq_thread() runs SCHED_FIFO but is pinned by the kernel to the IRQ
affinity mask (typically one CPU); when that CPU is saturated by RT
workloads (e.g. NCCL multicast) or by an SPI transaction coming from
a higher-priority context, the sleeping DMA/PIO wait inside the IRQ
thread cannot progress and wait_for_completion_timeout() in
transfer_one_message expires - even though the QSPI hardware
finished on time. This results in false timeout errors and WARN_ON
splats during normal operation.

This series addresses the problem in three steps:

1. Convert the threaded IRQ handler to a hard IRQ + high-priority
   unbound workqueue model. The hard IRQ does the minimum: capture
   FIFO status, mask and clear the controller IRQ, then schedule the
   bottom half. The workqueue handler runs in process context (can
   sleep for DMA completion) and runs on any CPU in the WQ_UNBOUND
   pool, so the bottom half can migrate off the interrupt-taking CPU
   that the previous threaded IRQ pinned to via
   set_cpus_allowed_ptr(irq_affinity).

2. Cache QSPI_TRANS_STATUS in the ISR before clearing it. This lets
   the timeout handler distinguish between a real hardware timeout
   (QSPI_RDY not set) and a delayed workqueue (QSPI_RDY set),
   preventing false timeout errors when hardware has already
   completed. Pair the cache publication with
   smp_store_release()/smp_load_acquire() so the timeout handler
   observes a coherent set of cached fields on weakly-ordered
   architectures. In v6 the timeout handler is additionally serialised
   with the workqueue via cancel_work_sync() and only runs the manual
   completion fallback on the last chunk of a transfer (see "Changes
   since v5" below for the multi-chunk DMA race Mark identified).

3. Process small PIO transfers (those that complete the whole
   spi_transfer in a single chunk) directly in hard IRQ context,
   eliminating workqueue scheduling latency for TPM-style short reads.

Runtime PM lifetime note (unchanged from v4): the work handler only
touches QSPI MMIO when curr_xfer is non-NULL. While curr_xfer is set,
the transfer thread is blocked in wait_for_completion_timeout() with
the SPI core's runtime PM reference held, so the clocks are
guaranteed on. When the work handler runs late after the timeout path
has already processed the transfer, it sees curr_xfer == NULL and
returns without any MMIO. With this invariant no additional PM
reference handoff between the ISR and the work handler is needed.

Changes since v5 (addressing review by Mark Brown [1][2]):

  Patch 1 ("Convert to hard IRQ with high-priority workqueue"):
    - Rewrote the commit message to be honest about the priority
      trade-off. WQ_HIGHPRI worker runs SCHED_NORMAL at nice -20
      (HIGHPRI_NICE_LEVEL = MIN_NICE in kernel/workqueue.c) whereas
      irq_thread() runs SCHED_FIFO. A real-time userspace task will
      therefore preempt the bottom half where it would not have
      preempted the old irq_thread. The changelog now spells out
      what is gained in exchange - hard-IRQ status latching that is
      independent of the process scheduler, WQ_UNBOUND worker
      migration off the interrupt-taking CPU that irq_thread() could
      not leave, and the small-PIO fastpath (patch 3) that removes
      the worker from the latency-sensitive TPM path entirely.
      Addresses Mark's "The high priority workqueue is a SCHED_NORMAL
      task with priority -20 so it can be starved by real time tasks
      running at SCHED_FIFO" review comment.

      The wording explicitly notes that the hard IRQ can still be
      delayed by higher-priority IRQ handling or local IRQ-disabled /
      non-preemptible sections; it is not subject to the process
      scheduler, but it is not literally immediate either.

    - Removed the reference to cancel_work_sync() from the
      tegra_qspi_work_handler() comment in this patch. That call is
      introduced in patch 2, so the v5 comment described behaviour
      that did not exist at patch 1's bisect point. Patch 2 now
      updates the same comment to describe the serialisation once
      cancel_work_sync() is actually in place. Addresses Mark's
      "That's actually in patch 2 so we have a bisect issue here"
      comment.

    - Reworded the tegra_qspi_work_handler() kernel-doc: threaded
      IRQ pins to the IRQ affinity mask (not necessarily CPU0).

  Patch 2 ("Cache TRANS_STATUS in ISR for timeout handler"):
    - Rewrote tegra_qspi_handle_timeout() to close the multi-chunk
      DMA race Mark identified. After cancel_work_sync() drains the
      bottom half, try_wait_for_completion(&xfer_completion) is
      called first; a full-transfer completion signalled by the
      work handler during the drain is consumed and the handler
      returns 0. Otherwise the fallback that invokes
      handle_{cpu,dma}_based_xfer() from process context is now
      gated on "is the current chunk the last chunk of the
      transfer?", computed under tqspi->lock as

          cur_pos + curr_dma_words * bytes_per_word >= t->len

      which is the same expression tegra_qspi_start_cpu_based_
      transfer() already uses to set is_last_pio_chunk. On an
      intermediate chunk of a multi-chunk DMA transfer the work
      handler may have processed the current chunk and armed the
      next chunk (unmasked the IRQ and kicked HW) before
      cancel_work_sync() returned; running another handler from
      handle_timeout() there would let seq_xfer() clear curr_xfer
      and finalise the message while the DMA engine is still
      moving the next chunk into the client buffer. Multi-chunk
      continuation timeouts now return -ETIMEDOUT and the caller's
      existing dma_stop() + reset() path cleans up. Addresses
      Mark's "handle_dma_based_xfer() starts a new DMA after the
      current one completes if there's more work to do but it
      looks like _combined_seq_xfer() will clear curr_xfer if we
      didn't get an error from handling the timeout" review
      comment.

    - Added a recovery_in_progress guard. tegra_qspi_handle_timeout()
      publishes recovery_in_progress under tqspi->lock; the ISR
      checks it under the same lock and skips both the small-PIO
      fastpath dispatch and queue_work() while recovery runs. Both
      dispatch decisions inside the ISR now happen while still
      holding tqspi->lock (queue_work() is safe to call from
      spinlock context), so the guard is atomic with the dispatch
      decision. Any ISR that had already released the lock and is
      about to run its fastpath / queue_work() is drained by
      synchronize_irq(tqspi->irq), which handle_timeout() calls
      immediately after masking the controller IRQ. This closes the
      residual re-enqueue race where a running worker armed the next
      chunk during the drain, unmasked the controller, and let a
      subsequent RDY IRQ enqueue a fresh worker after
      cancel_work_sync() returned.

    - Reordered the ISR so trans_status is published via
      smp_store_release() *before* tegra_qspi_mask_clear_irq()
      clears QSPI_TRANS_STATUS in hardware. In the previous ordering
      a timeout handler on another CPU that saw the cache still zero
      (release not yet visible) and fell back to a live
      QSPI_TRANS_STATUS read could observe the hardware bit already
      cleared, reporting a false timeout on a transfer that had in
      fact just completed. Publishing the cache first keeps the
      "cache miss -> live read" fallback consistent: the live read
      still sees QSPI_RDY until the cache is visible.

    - Re-mask and synchronize_irq() at the exit of
      tegra_qspi_handle_timeout() before clearing
      recovery_in_progress. The drained worker may have unmasked the
      controller IRQ when arming the next chunk of a multi-chunk
      transfer; without re-masking here a lingering RDY IRQ that
      arrives after this function returns could enter the ISR after
      recovery_in_progress has been cleared, queue a fresh worker
      and race the caller's dma_stop() + device_reset() + curr_xfer
      clear path.

    - handle_timeout() now enters recovery unconditionally rather
      than returning -ETIMEDOUT before serialising against the ISR
      and worker. Every expired wait_for_completion_timeout() masks
      the controller IRQ, synchronize_irq()s to drain any in-flight
      hard IRQ (including the small-PIO fastpath), and
      cancel_work_sync()s the workqueue before deciding whether the
      hardware finished. The RDY classification runs *after* this
      quiesce, so a genuine hardware timeout still ends up as
      -ETIMEDOUT but the caller's dma_stop() + device_reset() +
      curr_xfer clear no longer races a delayed ISR that fires
      immediately after the entry status sample.

    - Added a cache-live-cache retry to the entry trans_status
      classification. The initial smp_load_acquire() may miss a
      concurrent smp_store_release() from an ISR on another CPU; if
      the subsequent live QSPI_TRANS_STATUS read also returns zero
      (because the ISR W1C'd it between our two loads), a second
      cache load observes the now-visible release. Without this
      retry the timeout path could report -ETIMEDOUT on a transfer
      that actually completed but whose cache publication was still
      in flight.

    - Added a lost-IRQ FIFO snapshot. When the ISR cache is empty
      but the live QSPI_TRANS_STATUS shows RDY (a genuine lost or
      severely delayed IRQ), snapshot QSPI_FIFO_STATUS *before*
      tegra_qspi_mask_clear_irq() W1Cs the FIFO error bits, then
      publish that snapshot into tqspi->{status_reg,tx_status,
      rx_status} after the drain. Without this the manual final-
      chunk handler would operate on stale tx_status / rx_status
      fields from a previous chunk's ISR.

    - Updated the tegra_qspi_handle_timeout() kernel-doc to
      describe the last-chunk gate and the reason multi-chunk
      continuation timeouts must surface -ETIMEDOUT.

    - Updated the tegra_qspi_work_handler() comment to describe the
      cancel_work_sync() + recovery_in_progress serialisation (now
      in this patch, where both live).

    - Corrected the cancel_work_sync() description in the
      handle_timeout() comment and commit message: cancel_work_sync()
      cancels a pending worker without executing it and waits for a
      currently running worker to finish (v5 wording incorrectly
      said "executes a pending work synchronously").

    - Changed the is_curr_dma_xfer read in handle_timeout() to
      READ_ONCE(), matching the WRITE_ONCE() used in the writers.
      Consistency cleanup inside the function this patch is
      already touching.

  Patch 3 ("Process small PIO transfers in hard IRQ context"):
    - The small-PIO fastpath is now dispatched while still holding
      tqspi->lock (the lock is dropped only immediately before the
      call to handle_cpu_based_xfer(), which takes the lock
      internally). This puts the fastpath decision under the same
      recovery_in_progress guard as queue_work() in patch 2, so
      tegra_qspi_handle_timeout() cannot race a hard-IRQ fastpath
      run: either the ISR observes recovery_in_progress == true
      under the lock and returns early, or it commits to the
      fastpath dispatch before handle_timeout() can proceed past
      synchronize_irq(). No functional change to the fastpath
      itself.

Changes since v4 (addressing review by Mark Brown [3]):

  Patch 1 ("Convert to hard IRQ with high-priority workqueue"):
    - Rewrote the tegra_qspi_work_handler() comment to describe the
      serialisation invariant honestly (superseded by patch-1 fixes
      in v6 above; the current wording lives in patch 2 where
      cancel_work_sync() exists). Addresses Mark's "Can't the
      timeout handler also be running at the same time as this?"
      comment on v4.
    - Converted the tegra_qspi_isr() header comment to a proper
      kernel-doc block, with @irq / @context_data / Return: fields.
      No functional change.

  Patch 2 ("Cache TRANS_STATUS in ISR for timeout handler"):
    - Serialise tegra_qspi_handle_timeout() against the workqueue.
      Mask the controller IRQ (tegra_qspi_mask_clear_irq()) and then
      cancel_work_sync(&tqspi->irq_work) at the top of the recovery
      path. Once cancel_work_sync() returns the bottom half is
      neither running nor pending. Addresses Mark's "This can be
      called from both tegra_qspi_work_handler() and
      tegra_qspi_handle_timeout() - I can't see what stops them
      both handling and completing the same transfer simultaneously?"
      v4 review comment.
    - Clear the cached trans_status per chunk. Add
      smp_store_release(&trans_status, 0) immediately before
      tegra_qspi_unmask_irq() in both tegra_qspi_start_cpu_based_
      transfer() and tegra_qspi_start_dma_based_transfer(), so a
      multi-chunk DMA transfer (or the DMA -> PIO tail-chunk
      transition) cannot leave a stale RDY from chunk N in the cache
      when chunk N+1's completion times out. Addresses Mark's "It
      looks like the CPU based transfer function supports multiple
      interrupts per transfer ... don't we need to clear
      trans_status when we handle the interrupt as well?" v4
      review comment.
    - Take tqspi->lock across the ISR's status snapshot and cache
      publish sequence, and move tegra_qspi_mask_clear_irq() inside
      the locked region. Closes the QSPI_INTR_MASK RMW race Mark
      had already flagged on v3.

  Patch 3 ("Process small PIO transfers in hard IRQ context"):
    - Comment-only reflows to match the surrounding text.

Changes since v3 (addressing review by Mark Brown):

  Patch 1 ("Convert to hard IRQ with high-priority workqueue"):
    - Dropped IRQF_SHARED. Tegra QSPI uses a dedicated GIC SPI line
      on every SoC that uses this driver, so the ISR does not need
      a runtime PM reference. Addresses Mark's "Since we now have
      IRQF_SHARED we need to take a runtime PM reference here"
      comment.
    - Switched from devm_request_irq() to plain request_irq() in
      probe() and added explicit free_irq() in remove(), in the
      order: spi_unregister_controller -> free_irq ->
      destroy_workqueue -> pm_runtime_dont_use_autosuspend ->
      pm_runtime_force_suspend -> tegra_qspi_deinit_dma. Addresses
      Mark's "devm + non-devm mix seems likely to be racy"
      comments on probe() and remove().
    - Removed the tegra_qspi_unmask_irq() call from the
      work_handler NULL-bail path. Addresses Mark's "unmask after
      dropping the lock feels like it opens up races" comment.
    - Snapshot tqspi->curr_xfer under tqspi->lock at the top of
      handle_dma_based_xfer() so the DMA waits operate on a stable
      transfer pointer even if the timeout path clears curr_xfer
      concurrently. Integrates cleanly with Breno Leitao's
      recently merged protect-curr_xfer series.

  Patch 2 ("Cache TRANS_STATUS in ISR for timeout handler"):
    - Cached status_reg / tx_status / rx_status / trans_status are
      now published with WRITE_ONCE() and smp_store_release() and
      consumed with smp_load_acquire() in
      tegra_qspi_handle_timeout(). Live MMIO fallback via
      tegra_qspi_readl() only runs when the cache is still zero
      (the ISR never ran).

  Patch 3 ("Process small PIO transfers in hard IRQ context"):
    - Replaced the previous "curr_dma_words <= QSPI_FIFO_DEPTH"
      check with a tqspi->is_last_pio_chunk scalar computed in
      tegra_qspi_start_cpu_based_transfer() before it unmasks the
      IRQ. Addresses Mark's "Is cur_dma_words always in the same
      units as QSPI_FIFO_DEPTH - I see there's packed transfer
      support in the driver?" comment.
    - Fastpath additionally gates on tx_status == 0 &&
      rx_status == 0 because handle_cpu_based_xfer()'s error path
      calls tegra_qspi_handle_error() -> device_reset(), which can
      sleep and must not run from hard IRQ context.
    - is_curr_dma_xfer and is_last_pio_chunk are written from
      process context and read lock-free from the hard IRQ handler
      and the workqueue handler, so the writers use WRITE_ONCE()
      and the readers use READ_ONCE().

Changes since v2:
  - Added cancel_work_sync() in remove to flush pending work
    before devm tore down the workqueue (Jon Hunter). v4 has
    replaced devm altogether per Mark Brown's comment, so the
    explicit teardown now relies on free_irq() preventing new
    work being queued, followed by destroy_workqueue() draining
    what is in-flight.
  - Rewrote patch 2 commit message to describe the race in terms
    of the workqueue model rather than referencing the old
    threaded IRQ (Jon).
  - s/NULLed/cleared/ in code comment (Jon).

Changes since v1:
  - Switched to devm_alloc_workqueue() and devm_request_irq() for
    resource management (Jon Hunter). v4 has since reverted to
    non-devm for the IRQ and workqueue per Mark Brown's review,
    so teardown order can be made explicit.
  - Improved patch 2 commit message to explain the timeout race
    scenario and clarify that the issue pre-exists the workqueue
    conversion (Jon).
  - Removed unnecessary local variable in tegra_qspi_handle_timeout
    (Jon).
  - Moved "workqueue was delayed" comment updates from patch 2 to
    patch 1, since patch 1 introduces the workqueue (Jon).

The series is based on linux-next (next-20260810).

[1] https://lore.kernel.org/linux-spi/bbc6a709-7c83-4866-8905-39ab4d8b3b77@sirena.org.uk/
[2] https://lore.kernel.org/linux-spi/c1100cde-ffe9-42b7-9f21-827cae7248e7@sirena.org.uk/
[3] https://lore.kernel.org/linux-spi/20260610062400.1502354-1-va@nvidia.com/

Vishwaroop A (3):
  spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
  spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
  spi: tegra210-quad: Process small PIO transfers in hard IRQ context

 drivers/spi/spi-tegra210-quad.c | 509 +++++++++++++++++++++++++++-----
 1 file changed, 441 insertions(+), 68 deletions(-)

-- 
2.17.1

