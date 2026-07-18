Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5431277C9E
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355073; cv=none; b=tR8yfpXFVfC9dl+3sUurZPKAQOZrliYy+Hr6/MTp0koi6Jv8e+LLRRSst9xAaYMClkF11iH1RYdVy5FCTke7Gd3vUTITuGaiAZydmFu40mNcWJsfXC4XKH74taccEsavw410TXxML2g7JjfmXYuHA5ATRewgbefm0Gk/dmr1Mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355073; c=relaxed/simple;
	bh=Gzp/OY5QLmQDPQIlI89LY19arTPH33So27XJKwsHCiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbnATUWtBxxPuuwwmuc+2ZW4n3AuiVS2BFSBRxzjvbeMhtsqZ2TrQizngcymtb6j0vFmI+6nNqggCTLkyT06O82nFYSsCdJFWGdLGNsL1EEQ3HAkfnY6r1F11nYyWVRl6Tk7SQc225xIz+JFeiQuP5irn5tRnPtpRBwwrr+PTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc97653887so95871195ad.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 23:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784355071; x=1784959871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppnELLktKsQ8khpzw0fJV1W8gB6TJVdIDE77UWg1eBA=;
        b=NfI1QLezqydLX9dpfZdQZsczTKTKqAZNPqUIksApJNvYIBwtUB8kad+FgxRs4Gh1rl
         MQ7/50Bs2S5Yn7sFe/1AeRWi9VDKRWs5a63J96HIDPSvBckeHF1Kj74xmo7Ms2DPr1uH
         vIWtXcbb23LkHK1onZP0yq2S6YurgRJwm4Jv6nq8Q7Kn4S9pA/PGMQod/5ucO+Vok9dM
         kF/OOe02sk3ItJhUwOFdkBJSGbKSxgWHN7lciGS6x7JoAPYNv7OSHKHP/nWD/ZCrDUa4
         PZknFJD8pwc/EsakCkHiBSuuiv4dwetd/1dNagecCwvP7FQhEaKnWOUS5bktaf4XNI3W
         su7A==
X-Gm-Message-State: AOJu0YykFhED6TrFY5ZXSNwCarDHkwI+XzUk9zylQe1gtd+LUxTp39lT
	a9RaoBisJy+7cTkZIgG7zJH1hXjuK7QElJHpxgT7Wqo/zG/1Sl/UxXk=
X-Gm-Gg: AfdE7cn3Zcnf9nynDzT6CZJy4Mn/wVSJuliZQspso46QWz7pOl5VOWOEcLF/vCBmINf
	TE/P1Gy4D+jyM4gALo+j5GbSiHxMusfEIiaIlZuXK6QsIdQlKuJUOSaZ3Cp6pvyzUz0xuzTwxBE
	GqmsGGFlGDTqiLhCV3WuGpgfLqvo1h3ZEN1b5RZ+D0VJAJYa1Kq049s4maZxAbRmJnQ09NvK5b6
	cO0CWp/ZDv/F14rAMnia++A9rHB4jBascS16jzF+0mkxTDHkZjm4IvJ31sxHyRwFHog1R+Me6C7
	LSwhNe+TxqKUUAAsT39fLzZf6aYsWWJ1X2aouZ7++13HcjLmYQ15fA/rklwRXq4Mw0+KHRRq8LQ
	6RU27zhCtcbMN60VxeHBqsOXv+qCbQCip/9UNnBCtqgS47l79xWMstIYEVU4ohFviDkf2D2iyP7
	iH7F4fpCKx3EvcC6EiqKKk+lCrfCkHG+Y+HGQrOEBUxM8LGInOFRmxqHFrpm5AgNx699u7QPRKw
	fNoe+RiHqiL9Sw=
X-Received: by 2002:a17:903:3b8f:b0:2cc:d192:50b8 with SMTP id d9443c01a7336-2cf34a31907mr64852615ad.47.1784355070939;
        Fri, 17 Jul 2026 23:11:10 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db04csm22799025ad.42.2026.07.17.23.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 23:11:10 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v9 0/3] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes
Date: Sat, 18 Jul 2026 14:10:53 +0800
Message-Id: <20260718061056.30961-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mark,

This 3-patch series resolves issues in the spi-pxa2xx host controller driver
related to Intel LPSS SPI controllers and the Apple MacBook8,1.

Patch 1 moves the forced PIO mode quirk for the Apple MacBook8,1 LPSS SPI
controller from the client driver (applespi) to the host controller PCI glue
driver (spi-pxa2xx-pci) where it belongs.

Patch 2 fixes runtime PM and interrupt handling in PIO mode: when DMA is
disabled, aggressive runtime clock gating causes PCIe Completion Timeouts on
subsequent MMIO accesses. It scopes autosuspend lockout to LPSS controllers,
tracks clock state to avoid disable underflows, and protects shared IRQ handling.

Patch 3 fixes S3 suspend/resume for Intel LPSS SPI controllers. The LPSS
power domain is fully removed across S3, losing all private register state.
Accessing MMIO on resume while the block is held in reset causes a PCIe Completion
Timeout and a watchdog system reset. To fix this, we save the LPSS private
registers in struct driver_data during suspend, de-assert resets first on
resume, and restore the saved registers.

Changes in v9:
  - Separated the original "disable DMA and fix runtime PM" patch into two distinct commits:
    1. spi: pxa2xx: disable DMA for Apple MacBook8,1 (PCI glue DMI quirk)
    2. spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode (core driver PM/IRQ fixes)
  - Condensed commit messages for Patches 2 and 3 for clarity and brevity.
  - Fixed checkpatch.pl warning regarding unnecessary braces in pxa2xx_spi_remove().
  - Addressed feedback from Sashiko review on the v8 patchset:
  - Scoped pm_runtime_get_noresume() in pxa2xx_spi_probe() and pm_runtime_put_noidle()
    in remove/error paths using is_lpss_ssp(drv_data). This locks out autosuspend
    for LPSS controllers operating in PIO mode without causing power regressions on
    non-LPSS platforms (e.g. PXA25x, Intel Quark, CE4100) operating in PIO mode.
  - Guarded MMIO accesses in pxa2xx_spi_runtime_suspend() with a drv_data->clk_enabled
    check. If the clock has already been turned off (e.g. in pxa2xx_spi_remove() or
    resume error path), runtime suspend skips hardware writes, avoiding unclocked
    MMIO accesses and PCIe Completion Timeouts if runtime PM triggers after teardown.
  - Cleaned up pxa2xx_spi_pci_can_dma() signature in spi-pxa2xx-pci.c by removing the
    redundant `bool verbose` parameter.

Changes in v8:
  - Addressed feedback from Sashiko review on the v7 patchset:
  - Fixed runtime PM resume interrupt storm in ssp_int() by checking drv_data->clk_enabled
    instead of pm_runtime_get_if_active() == 0.
  - Fixed PM disabled configuration (CONFIG_PM=n) support in ssp_int() by avoiding
    active <= 0 early returns.
  - Reordered suspend and remove sequences to invoke pxa_ssp_disable() before setting
    drv_data->suspended = true and synchronizing the IRQ, closing a race window
    where level-triggered interrupts could cause a storm.
  - Masked hardware interrupt generation in pxa2xx_spi_runtime_suspend() via
    pxa_ssp_disable() to prevent unexpected interrupts during clock enable.
  - Avoided PCIe Completion Timeout system hangs on newer LPSS platforms (SPT, BXT, CNL)
    by introducing pxa2xx_spi_need_lpss_restore() to restrict MMIO save/restore
    loops to LPT, BYT, and BSW platforms (which lack an MFD parent).
  - Fixed compiler error in pxa2xx_spi_probe() due to unused label.

Changes in v7:
  - Addressed feedback from Sashiko review on the v6 patchset:
  - Fixed a race condition during probe by moving the request_irq() call after
    the clock is enabled and the suspended flag is cleared. This prevents an early
    shared interrupt from asserting and triggering an interrupt storm before the clock
    is active to allow clearing it.
  - Rectified the teardown sequence in pxa2xx_spi_remove(): first set drv_data->suspended
    to true and disable SSP hardware-level interrupt generation (pxa_ssp_disable()), then call
    synchronize_irq() to wait for in-flight interrupt handlers to complete, free the
    IRQ, and only then disable the clocks. This eliminates both post-clock-disable MMIO
    accesses and unhandled shared hardware interrupt storms.
  - Clarified that the unconditional MMIO register access in pxa2xx_spi_suspend()
    is safe because pm_runtime_resume_and_get() is invoked at the very beginning of the
    suspend callback, guaranteeing the LPSS device is active and clocked during register
    disabling/saving.
  - Added spi_controller_resume() recovery to the error path of spi_controller_suspend()
    in pxa2xx_spi_suspend() to prevent the controller from remaining permanently disabled
    in the event system suspend is aborted.

Changes in v6:
  - Addressed feedback from Sashiko review on the v5 patchset:
  - Added a synchronize_irq() call to the spi_controller_resume() error path in
    pxa2xx_spi_resume(). This ensures any concurrent shared interrupt handlers
    (which might execute because drv_data->suspended = false was set earlier)
    finish executing before we disable the clock, preventing PCIe timeouts.
  - Checked and confirmed that active == 0 is the correct check in ssp_int(). If
    Runtime PM is disabled, pm_runtime_get_if_active() returns a negative error
    code (like -EINVAL). Changing this check to active <= 0 would cause a
    regression on non-PM configurations because the handler would always return
    IRQ_NONE. Under disabled Runtime PM, the hardware clock is kept constantly
    active, so it is safe to proceed and read registers when active < 0.

Changes in v5:
  - Reverted runtime PM configuration in spi-pxa2xx-pci.c to be unconditional.
    This prevents the usage count from leaking by +1 on unbind for PIO mode,
    while letting pxa2xx_spi_probe()'s pm_runtime_get_noresume() and
    pxa2xx_spi_remove()'s pm_runtime_put_noidle() handle the permanent
    autosuspend lockout for PIO devices symmetrically.
  - Removed the pm_runtime_forbid() call from pxa2xx_spi_remove(). This resolves
    reference leaks for non-PCI platform devices where pm_runtime_allow() was
    never called during probe.
  - Delayed clearing the drv_data->suspended flag on resume until after LPSS reset
    deassertion and private register restoration are complete. This prevents a
    shared interrupt from firing during resume and attempting to read the SSSR
    register while the LPSS block is still held in reset.
  - Set drv_data->suspended = true on spi_controller_resume() failure path in
    pxa2xx_spi_resume(). This ensures that subsequent shared interrupts do not
    attempt register access once the clock is disabled.

Changes in v4:
  - Track clock state using drv_data->clk_enabled via pxa2xx_spi_clk_enable() and
    pxa2xx_spi_clk_disable() helper functions. This guarantees clock enable/disable
    symmetry, preventing clock disable count underflows and framework warnings on S3
    resume or runtime autosuspend error paths.
  - Introduce drv_data->suspended flag to protect MMIO access in ssp_int() during
    system suspend and runtime suspend transition windows.
  - Initialize drv_data->suspended = true early in probe(), clearing it only after
    the clock is successfully enabled. This completely prevents shared interrupt
    handler races during device probe when the clock is still off.
  - Call synchronize_irq() after setting drv_data->suspended = true in suspend and
    runtime_suspend. This ensures any running shared interrupt handlers finish
    executing before the clock is physically turned off.

Changes in v3:
  - Avoid PM reference leaks on probe bind/unbind cycle by keeping probe PM
    configuration symmetric.
  - Prevent userspace (PowerTOP, udev) from overriding runtime PM settings when
    DMA is disabled by holding a PM reference via pm_runtime_get_noresume()
    in pxa2xx_spi_probe() and dropping it in remove/error paths.
  - Check device status in the shared interrupt handler ssp_int() using
    pm_runtime_get_if_active() instead of pm_runtime_suspended(). If the device is
    suspending (RPM_SUSPENDING) or suspended, ssp_int() immediately returns
    IRQ_NONE to avoid reading unclocked MMIO registers during power transition.
  - Adjust the driver teardown order in pxa2xx_spi_remove() and probe error paths:
    always call free_irq() to unregister the handler before calling
    clk_disable_unprepare() to turn off the clock, preventing concurrent
    interrupts from reading registers while the clock is disabled.
  - Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
    enable_dma status in probe and passing a verbose flag to can_dma().

Changes in v2:
  - Addressed feedback from Mark Brown on the original v1 series.
  - Used drv_data->lpss_base together with relative offsets rather than
    hardcoding absolute MMIO offsets that vary between LPSS IP revisions.
  - Moved the register save block in suspend to after the controller is quiesced
    (after spi_controller_suspend() and pxa_ssp_disable()).
  - Store the context array lpss_priv_ctx[6] inside struct driver_data instead of
    struct pxa2xx_spi_controller. This keeps the changes entirely local to the
    core driver, preventing symbol version mismatches (disagrees about version
    of symbol) for other subsystem components (e.g., spi-pxa2xx-platform.ko).
  - Restrict the save/restore loop to the first 6 LPSS private registers
    (offsets 0x00 to 0x14). Offsets beyond 0x14 (except CS control at 0x18, which is
    re-initialised by lpss_ssp_setup()) are reserved/unimplemented on LPT
    platforms (such as MacBook8,1), and writing to them triggers a PCIe
    Completion Timeout causing a system freeze.
  - Added named constants for LPSS_PRIV_RESETS and the de-assert value.
  - Wrapped S3 suspend/resume with pm_runtime_resume_and_get() and
    pm_runtime_put_autosuspend() respectively.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331


Shih-Yuan Lee (3):
  spi: pxa2xx: disable DMA for Apple MacBook8,1
  spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
  spi: pxa2xx: restore LPSS private register state on S3 resume

 drivers/spi/spi-pxa2xx-pci.c |  35 ++++-
 drivers/spi/spi-pxa2xx.c     | 243 +++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   4 +
 3 files changed, 241 insertions(+), 41 deletions(-)

-- 
2.39.5

