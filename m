Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026252C11EE
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564484; cv=none; b=nRoJHuxVDIL1qDEeCsS2AgrnijdaHwita43H+RpwmaYADRN9udD8+pld0/nb8HWot6g/oNRfnU1oRjrHtr1DMPamjWIEfJDxR2FWlSDTXxPWXRE/RSMAotVO7AEyXpD8/Uju2sf90pxhBDPljrZJRuIn/NQkEhL92Aan/S9busk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564484; c=relaxed/simple;
	bh=oZwlRU6rq/N7f09C7B3TohKosfUAiVxfg41/3dgvf1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFpS/2wZISxJHppJA02yYMRxkru+h8r+wk6Ua2PW3ztETw7mItXJB64O2i/EMkHHlfjEG+RfBbAMU4qUNkoM539ITJNR6Fo9j2VJ1YIFhpAv9P736eE4fh9+ZPIzFfwUAGCV/r2jrGi8HLCrmsTS/wIMu5OrETXQx/SOJFIDILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so13652795ad.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564482; x=1785169282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4jnLzYhODQ28ldF6cU1gNdsC8JYdLXk3goyGX+8Ec0=;
        b=Z9nSo/7RhEt5lxM5tCTCRhmfxIU4VMPJ4RzDoOZ4RWd0I7ldH4TMS7/DQ0CXw6f7OE
         wqHXohIE4CKJLXKaZUHK/haJNkuyZtZ09YOuVmqMsGQQwQC5fE9CeSGvOCD94tt1Gsxd
         6AmcXIo3o3ur55uG9RFuP21leIT41Z480hXERvu4MFzbRLB8DTGDWF8I6/udQmGC3Em5
         aoPknGsgL2eEgEIw1662+CozOpbnyN94q8kS7/h6K1CIkG4xvx0nekyMTZBYlSsdSjI3
         UNf53KNK2+MWK0uvlbLWZTle6Ex/D7z+EnBFuVPpCdanydj5XH69rdmUYN0iFMzrqppw
         ntPg==
X-Forwarded-Encrypted: i=1; AHgh+RoaEnipwlI9TKdziZpa9NgzsQxALm+hu60LfHYQu9FDeaggN5/rcEWRB9Wkv2LutmZ9ir8uvHA073Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMOst+WyH7kxAhY5HY1jCTVYV+2J/FSSZWIxxHzHvUUFzzzQ+
	pSDPP0DoQId8deYqzRkJ96mbxLcI13LZqJUX8SBoOAwgGl1ls7yuZyE=
X-Gm-Gg: AR+sD11CaK5wJsWa701FbD1C8oApVT6MNokypdCPXvvqOBsTeUsvtZf+WDp6Gf9nWS0
	734W8HRSXtUzgzZc5yP+kpJ3WIkDmnnvFOyLLOv6P0nYNcYKUF9BZz3G+Qn/FMkUXPVY0v1jW8p
	a+lBZNHUi+dbdNhT0+p8x+DkPPvcFMbQEOXwL1IVUenzWju4rQWrDwb76RqsQ0uoWyMPmhvoUHh
	8jDCdPuwpid3zWq+QFKq/INV0LluGc52U2yEKaf578GZQRsZhPBDPnnYVuibi5SIjMQ+FsGWgxm
	VF4V6GJB6YSuB+6lt5AQ/wLHu8omM3GEtuD6K3dH5502fuNTFcMlVwiS1i9TPc3wbI9D1ivHBad
	LYvjKITqaMuZNDIIY6TPMqOQ3s55DrPTGEbZLg4j2Akb9pEy7Me2YARFiJ3BppK8Atth8P9CR8k
	JhXnj6Kw+jAvu9WEgi4QNq/9og83arSICJg5BaIssUtkuc25mux3S0R1gt5fI4MsFWZHXaUsjER
	ZQKL46yMS82VdvNZQ==
X-Received: by 2002:a17:902:c411:b0:2c9:97a9:2096 with SMTP id d9443c01a7336-2cf349edab6mr150119295ad.42.1784564482107;
        Mon, 20 Jul 2026 09:21:22 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:21 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v16 0/7] spi: pxa2xx: Fix PM and interrupt issues on Intel LPSS SPI
Date: Tue, 21 Jul 2026 00:21:09 +0800
Message-Id: <20260720162117.32304-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This 7-patch series addresses long-standing power management (PM), runtime autosuspend,
and interrupt synchronization regressions in the spi-pxa2xx host controller driver,
specifically targeting Intel Low Power Subsystem (LPSS) SPI controllers and platforms
such as the Apple MacBook8,1.

Specifically, this series:
  - Prevents system hangs and PCIe Completion Timeouts during S3 suspend/resume by
    restoring Intel LPSS private register context (resets and control registers).
  - Resolves race conditions in the shared interrupt handler (ssp_int()) during PM power
    state transitions (RPM_SUSPENDING) by tracking suspend states and guaranteeing
    active hardware clocks prior to MMIO register access.
  - Locks out runtime PM autosuspend for Intel LPSS SPI controllers in PIO mode to avoid
    unclocked MMIO accesses on subsequent transfers.
  - Applies a PCI glue DMI quirk to force PIO mode for Apple MacBook8,1 to work around
    persistent hardware DMA timeouts.
  - Cleanly refactors clock helper functions, PM callback state alignments, and local
    variable conventions across the driver.

Changes in v16:
  - Addressed feedback from Sashiko review on the v15 patchset:
  - Fixed 'bool suspended' field location in spi-pxa2xx.h (moved from Patch 1 to Patch 2).
  - Updated pxa2xx_spi_clk_disable() to set drv_data->clk_enabled = false BEFORE
    calling clk_disable_unprepare(), eliminating an IRQ handler race window on
    multi-core systems.
  - Updated pxa2xx_spi_suspend() and pxa2xx_spi_runtime_suspend() to explicitly
    set drv_data->suspended = true.
  - Fixed pm_runtime_put_sync() in pxa2xx_spi_remove(), moving the PM reference drop
    to before hardware teardown and using pm_runtime_put_noidle() to prevent
    runtime_suspend calls on unclocked hardware.
  - Fixed PM runtime state alignment in pxa2xx_spi_resume() error path using
    pm_runtime_set_suspended().
  - Resolved merge conflicts and renamed remaining 'status' variables to 'ret'
    in suspend/resume handlers.

Changes in v15:
  - Split the large PIO mode PM and interrupt patch (v14 Patch 2) into 4 distinct,
    single-purpose commits (clock helpers, suspended flag, teardown overhaul,
    and autosuspend lockout).
  - Reordered the commits so that PIO PM and interrupt bug fixes are applied
    before disabling DMA on MacBook8,1, satisfying kernel bisection safety.
  - Replaced raw pxa_ssp_disable() calls in PM suspend/remove with
    pxa2xx_spi_off() to respect the MMP2 platform's SSE-disable quirk.
  - Renamed return variables from 'status' to 'ret' in clock helper functions,
    and added a cleanup commit to rename 'status' to 'ret' in the PM and probe
    callbacks to conform to standard coding conventions.

Changes in v14:
  - Addressed feedback from Sashiko review on the v13 patchset for Patch 2:
  - Updated commit message text for Patch 2 to accurately reflect that ssp_int()
    uses drv_data->suspended and drv_data->clk_enabled instead of pm_runtime_get_if_active().
  - Clarified in commit message that active SPI transfers hold a PM reference via
    spi_controller.auto_runtime_pm (pm_runtime_get_sync()), preventing autosuspend
    from racing while an IRQ handler is reading/writing FIFO registers.
  - Clarified teardown ordering: pxa_ssp_disable() disables hardware interrupt generation
    first, followed by setting drv_data->suspended = true and calling synchronize_irq(),
    ensuring in-flight IRQ handlers drain completely before clock gating.

Changes in v13:
  - Addressed feedback from Sashiko review on the v12 patchset for Patch 2:
  - Removed pm_runtime_get_if_active() check from ssp_int(). During PM state
    transitions (such as RPM_SUSPENDING or RPM_RESUMING), pm_runtime_get_if_active()
    returns 0 because the state is not RPM_ACTIVE. Returning IRQ_NONE during transition
    without clearing a level-triggered interrupt would cause the interrupt controller
    to endlessly re-invoke the handler in a loop.
  - Rely on drv_data->suspended and drv_data->clk_enabled in ssp_int() instead.
    If the clock is enabled (drv_data->clk_enabled == true), MMIO reads are 100% safe
    and will not cause PCIe Completion Timeouts. If the clock is disabled or the device
    is suspended, ssp_int() immediately returns IRQ_NONE to prevent unclocked access.

Changes in v12:
  - Addressed feedback from Sashiko review on the v11 patchset for Patch 2:
  - Preserved the if (!pm_runtime_suspended(dev)) check prior to enabling/disabling
    the clock in pxa2xx_spi_suspend() and pxa2xx_spi_resume(). On non-LPSS platforms,
    if a device was runtime suspended prior to system sleep, unconditionally enabling
    its hardware clock during system resume forced the clock ON while the PM core
    retained RPM_SUSPENDED. Restoring this check prevents PM state desynchronization,
    avoiding power leaks on non-LPSS platforms.

Changes in v11:
  - Addressed feedback from Sashiko review on the v10 patchset for Patch 2:
  - Replaced pm_runtime_put_noidle() with pm_runtime_put_sync() in pxa2xx_spi_remove().
    Using pm_runtime_put_noidle() dropped usage count without executing the runtime_suspend
    callback or updating the device runtime status, leaving it stuck in RPM_ACTIVE. This
    permanently leaked an active child count on the parent LPSS power domain, preventing
    the parent from entering low-power runtime suspend. Switching to pm_runtime_put_sync()
    ensures the runtime PM state machine properly transitions to RPM_SUSPENDED upon driver
    unbind.

Changes in v10:
  - Addressed feedback from Sashiko review on the v9 patchset:
  - Fixed ssp_int() by explicitly returning IRQ_NONE when pm_runtime_get_if_active()
    returns 0 (device inactive or suspending). This prevents reading SSSR and MMIO
    registers when the hardware is powered down or in power transition.
  - Resolved PM usage counter leak and double-increment for PIO mode devices. Removed
    the redundant/unconditional pm_runtime_get_noresume() in pxa2xx_spi_probe() and
    moved the single pm_runtime_get_noresume() call to occur strictly after
    spi_register_controller() succeeds.

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

Shih-Yuan Lee (7):
  spi: pxa2xx: introduce clock enable and disable helper functions
  spi: pxa2xx: introduce suspended flag for interrupt synchronization
  spi: pxa2xx: overhaul teardown and suspend sequence using
    pxa2xx_spi_off
  spi: pxa2xx: lock out runtime autosuspend for Intel LPSS SPI in PIO
    mode
  spi: pxa2xx: disable DMA for Apple MacBook8,1
  spi: pxa2xx: restore LPSS private register state on S3 resume
  spi: pxa2xx: rename local status variable to ret

 drivers/spi/spi-pxa2xx-pci.c |  35 ++++-
 drivers/spi/spi-pxa2xx.c     | 256 ++++++++++++++++++++++++++++-------
 drivers/spi/spi-pxa2xx.h     |   4 +
 3 files changed, 246 insertions(+), 49 deletions(-)

-- 
2.39.5
