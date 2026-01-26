Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB72356D9;
	Mon, 26 Jan 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449856; cv=none; b=W7kX3AUzAAPnHSfeET+Whexo9MjpHACqGpgs/USe+h2S6950sV6WUX9uSD9Kl1JV00Spg8SlKirL10J8jSRda5EEKPbKhC28K0WDnPMeAUdQvjciO8mxOPHaehFVz5Ib70jeZMUC+3EXrhqjNSmDGSNhmXagNyQAPbW/xVDHI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449856; c=relaxed/simple;
	bh=29+86yxPeFylG545RvRJg40SXUy2vq9Onj5Yiwbn+iM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n/wxgyHtYE9V4khcmkcolLnWbNduUz8PjUp7nLgrUH1WZ8loP4AWm5LVPHqQc2bgByP5OeSAA7D8ASNBQOrBUYM6HKQyCeEElYNyuOSQuapFjeZWNLZTWu1Ni/ThJT8EXQEC6wuP4CNyq3bPmNsZOVIgXQM/9at3Gf0AXZVYuuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nCMQzERs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nCMQzERs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Z/wJnPOaZa23KyAByMqKhhlGb0nDIPQ/uVjLXiBg9P8=; b=nCMQzERsB6EgntxvXrDAA9jCk9
	D7Y6sbYpqMDTpsc63/aw+40/m8FHCRoyapYGocDid+5/mlpajGnEBil+zVSVxWvC0T5XOz37f0CGp
	aySMEIYQfus/ZdAak4aESx4FghZL8LBbXZyu+fYQFXv5SxX9Pmxcy8GRWyf9AyomMYdrSX7+6Z0SM
	uPLxNu7ZNSR7covERtE7PUjILS5vLeOYgSc9UlJCki0NxhzdhmaKcIkvHV+MjlEsdH78s0hrv1Wnv
	j9iY1K7bmqLK17XLAGziPQFuRHztw7+5H6uJRlD9AnYFAFU1Rfe/TchbM5FhhRKZa+HUokaNf4qob
	p4DHIZFA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQjc-00GLZ6-Ji; Mon, 26 Jan 2026 17:50:46 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Date: Mon, 26 Jan 2026 09:50:25 -0800
Message-Id: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKpd2kC/03NQQqDMBCF4auEWZsySSGiq96jSInJqNOFlokGi
 3j3oqXQ5YOf722QSJgS1GoDocyJpxFqZQsFYfBjT5oj1AosWofGWD1TL/6xdiTa+dBe0bvSYge
 FgpdQx+uJ3ZvvTkv7pDAfwlEMnOZJ3udbNkf3g90/nI1GjTZWLpQVOlPdIrXsx8skPTT7vn8AX
 6fN1LcAAAA=
X-Change-ID: 20260112-tegra_xfer-6acb30a6720f
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, soto@nvidia.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5206; i=leitao@debian.org;
 h=from:subject:message-id; bh=29+86yxPeFylG545RvRJg40SXUy2vq9Onj5Yiwbn+iM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lvgdrl4zwPwO5RMIpg7nj65rZ5bKEq3vYbw
 yq190ZsrA+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepbwAKCRA1o5Of/Hh3
 bVoTEACpaAup0Kdr7GGPuwfV7ZgnvnDn/WuXQrql2EefFYfb3qpA9A1jfM36kiklz9Tzjy0bTsn
 53YSBqQj5q1Mg1AqcQ52K0Sxb8rqpuWqHGHMz+FcPYo6f7zva44+9eoUQ4DDqxnLZd4sLghA5E6
 JjdaWxS5OSTJ+fW6MA4y8+tu/LoPc/nhCcq4SN+oSNi+2oHm7+cW8JAYPEBFBw3moObHHV0qKy7
 FE5aOhYAONld5CqQ6nZa3Ga1t/qhyWyflPTXZMGedNWtRCKfsMf+tqyRPcJJy9MXGMIs+GfHIly
 RqHAknVmB7a6o4ijFmufWQzF++HSq1+xdyG+wzAIdegjbSvbuVrpr4LHUEESNVvZC+xwZEpnvyx
 6+bpJahoGBFLA+WVj6Y+gwLO0XN0an/t9w4mvjgtEXnaROABo1EcTEjeQh93TpVZvwQ1cYa8rI7
 pPlSbKuzAOHGod38Lwuf3IM7IHaufRECzj0QDl454KNn2RS7o+FQWb0eh7Hje/1TfMbnGiPjEDS
 Nph9/lNRWjIPECREW/KH1v7v0d7VxPGmKLT1d/AZm8WwFd741wygZmObUbIsWC0L7KsS/zQe0tl
 TP/X30QAapvUVuczfwG+PYHiSkcOv8tsEHGW95bw644d5R6teWVN5tvuALR+9gXb2FT0qRdf21w
 Hy4KidS7jxb3BxQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The tegra-quad-spi driver is crashing on some hosts. Analysis revealed
the following failure sequence:

1) After running for a while, the interrupt gets marked as spurious:

    irq 63: nobody cared (try booting with the "irqpoll" option)
    Disabling IRQ #63

2) The IRQ handler (tegra_qspi_isr_thread->handle_cpu_based_xfer) is
   responsible for signaling xfer_completion.
   Once the interrupt is disabled, xfer_completion is never completed, causing
   transfers to hit the timeout:

    WARNING: CPU: 64 PID: 844224 at drivers/spi/spi-tegra210-quad.c:1222 tegra_qspi_transfer_one_message+0x7a0/0x9b0

3) The timeout handler completes the transfer:

    tegra-qspi NVDA1513:00: QSPI interrupt timeout, but transfer complete

4) Later, the ISR thread finally runs and crashes trying to dereference
   curr_xfer which the timeout handler already set to NULL:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
    pc : handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad]
    lr : tegra_qspi_handle_timeout+0xb4/0xf0 [spi_tegra210_quad]
    Call trace:
      handle_cpu_based_xfer+0x90/0x388 [spi_tegra210_quad] (P)

Root cause analysis identified three issues:

1) Race condition on tqspi->curr_xfer

   The curr_xfer pointer can change during ISR execution without proper
   synchronization. The timeout path clears curr_xfer while the ISR
   thread may still be accessing it.

   This is trivially reproducible by decreasing QSPI_DMA_TIMEOUT and
   adding instrumentation to tegra_qspi_isr_thread() to check curr_xfer
   at entry and exit - the value changes mid-execution. I've used the
   following test to reproduce this issue:

   https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh

   The existing comment in the ISR acknowledges this race but the
   protection is insufficient:

       /*
        * Occasionally the IRQ thread takes a long time to wake up (usually
        * when the CPU that it's running on is excessively busy) and we have
        * already reached the timeout before and cleaned up the timed out
        * transfer. Avoid any processing in that case and bail out early.
        */

   This is bad because tqspi->curr_xfer can just get NULLed

2) Incorrect IRQ_NONE return causing spurious IRQ detection

   When the timeout handler processes a transfer before the ISR thread
   runs, tegra_qspi_isr_thread() returns IRQ_NONE.

   After enough IRQ_NONE returns, the kernel marks the interrupt as spurious
   and disables it - but these were legitimate interrupts that happened to be
   processed by the timeout path first.

   Interrupt handlers shouldn't return IRQ_NONE, if the driver somehow handled
   the interrupt (!?)

3) Complex locking makes full protection difficult

   Ideally the entire tqspi structure would be protected by tqspi->lock,
   but handle_dma_based_xfer() calls wait_for_completion_interruptible_timeout()
   which can sleep, preventing the lock from being held across the entire
   ISR execution.

   Usama Arif has some ideas here, and he can share more.

This patchset addresses these issues:

Return IRQ_HANDLED instead of IRQ_NONE when the timeout path has
already processed the transfer. Use the QSPI_RDY bit in
QSPI_TRANS_STATUS (same approach as tegra_qspi_handle_timeout()) to
distinguish real interrupts from truly spurious ones.

Protect curr_xfer access with spinlock everywhere in the code, given
Interrupt handling can run in parallel with timeout and transfer.
This prevents the NULL pointer dereference by ensuring curr_xfer cannot
be cleared while being checked.

While this may not provide complete protection for all tqspi fields
(which might be necessary?!), it fixes the observed crashes and prevents
the spurious IRQ detection that was disabling the interrupt entirely.

This was tested with a simple TPM application, where the TPM lives
behind the tegra qspi driver:

https://github.com/leitao/debug/blob/main/arm/tegra/tpm_torture_test.sh

A special thanks for Usama Arif for his help investigating the problem
and helping with the fixes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Replaced the TODO comment to clarify why the lock is being released.
- Link to v1: https://patch.msgid.link/20260116-tegra_xfer-v1-0-02d96c790619@debian.org

---
Breno Leitao (6):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler

 drivers/spi/spi-tegra210-quad.c | 56 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)
---
base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
change-id: 20260112-tegra_xfer-6acb30a6720f

Best regards,
--  
Breno Leitao <leitao@debian.org>

