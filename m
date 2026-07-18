Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB31D798E
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337881; cv=none; b=NxCJAFnmY840btwjFF5BrDPdYqmJ2Qd99g0diJiTDlNxX96akaG1JU68fgqXnlgisEO9/xSW3Jc0/1VfVl6sjgloy92phDdyXkGues69BIksaR1u0iTjQmwsuCnRnQ/Ft1R63efKNpWSqlHgER3ho2vsqxqwvt+sI0SMW5UThlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337881; c=relaxed/simple;
	bh=8gIc3oZGuAgm8XgVn5J4ndYtCmSbsA28T1E2e0HAJCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPxp4sKgA+powAh2aXxKWmERdHvx0dJt7Pe7ZAsMmkiUqhu2atj2rG5YWASyaJ1HHRqLqz391B1FCU/9jUZPq4ctL4N9qaWcaaEoGQiFg09QDlW887aBOev7s+EljG0dRvIfr0RWwTwd4vJS7emol6EoxfyA4IevcGE7vZNpRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso103611735ad.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 18:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784337879; x=1784942679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6Z9mICxfxHL0dl4uLzG4QhxdltgYlZ6NX7ZhDURFQg=;
        b=Ivi0LgLqcvqk5GlzdjQ1USV7+JAGSMxVI6JK31MZACvktHGwsRYPiAFpf+/vXE0by9
         MW4FfkaRbi2t/AgYR+WussnGQ4vbe9Dv9iLj8Jddik7V50oZY2TPwyZ9tnLckoRB5yZH
         u4wSLPE8V7pNYzavNiGOKogH7BVTdqExYEeOaH+GZjoH4uBpN2DLdQLk5prGO2ZpP2+/
         kjAdVRW1nEj3cbyddxfVknj+L235EPYmBorpxIeIUas29NZhc6RvKg3jHYXP/OmN8Fmu
         e/H0lD9oSqthtlCgFJcUilJ19vf99e2g2RdTPtDxzSbK6OUtRgkCN6poo89Y5WX3so4o
         0fJg==
X-Gm-Message-State: AOJu0YymCPgkGICnuS0rQhcS98CoUCsa3voJFJbIlsoukMbTyYbTWH//
	SUruGHGV4GvEYrJTA/arP+xjkiyuyOkxwwRpYqUqdXJ2aR4UdNUdkwI=
X-Gm-Gg: AfdE7clnyEfS7EHkPZMOUMi0PKGbrn9cwki3xrDDjar0JiZGS6yF+Xdpgkna6tbXvYE
	D+Yh28tlGrQ0xu+ys2mDzkeif1RVFEMAt8vQJc+z1vrxU5vw+qqIoXp8e9mOHU9UAX5EuunUE/I
	jRPeT0iBVawZ8+4AZ28gHcQbSFSW7wySFAf7drnTITRlyBVMJB0/vbNCVN5ILjBRcXILzrO4781
	jliGI67yYVMLOSXabLaGWtlx0VNMD7l+6LNBje+8eyovdnQVKoWzRa121eNOjunB+oJRPcTaKvO
	zJkIommf0zfgoUDq8QLW1eQqjZxKLiEYSoIRI6AVYttppFHm1gMcZoag2bckCA+kZBt1pHAWGix
	v8KU4WvktX6njvIfoVyR0DcXox0Tff/hFxM6kHrYgThw9pdoR2EJMCGna8sIjDRVMRuxelpFO23
	+lGH100feXIkIAMbc/x5IUfe+LsHgeY+QHeq3Gbc6do0mdkYn+55Uz+0QZfCAYFwflp4b/lIAfV
	pyX9xTuaiOb7Zw=
X-Received: by 2002:a17:903:b8b:b0:2c9:cf5d:d9b8 with SMTP id d9443c01a7336-2cf349a4e71mr60600925ad.33.1784337879074;
        Fri, 17 Jul 2026 18:24:39 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bbe50sm19617685ad.27.2026.07.17.18.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:24:38 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v6 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes
Date: Sat, 18 Jul 2026 09:24:29 +0800
Message-Id: <20260718012431.3443-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mark,

This patch series resolves two issues in the spi-pxa2xx host controller driver
related to Intel LPSS SPI controllers.

Patch 1 moves the forced PIO mode quirk for the Apple MacBook8,1 LPSS SPI
controller from the client driver (applespi) to the host controller PCI glue
driver (spi-pxa2xx-pci) where it belongs. It also fixes a runtime PM issue:
when DMA is disabled, aggressive runtime clock gating causes PCIe Completion
Timeouts on subsequent MMIO accesses.

Patch 2 fixes S3 suspend/resume for Intel LPSS SPI controllers. The LPSS
power domain is fully removed across S3, losing all private register state.
Accessing MMIO on resume while the block is held in reset causes a PCIe Completion
Timeout and a watchdog system reset. To fix this, we save the LPSS private
registers in struct driver_data during suspend, de-assert resets first on
resume, and restore the saved registers.

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
  - On S3 suspend success path, return 0 directly without dropping the PM
    reference. This preserves the acquired PM reference across suspend.
    On S3 resume, release it via pm_runtime_put_autosuspend(), and ensure
    all error paths in resume (clock enable failure or spi_controller_resume
    failure) jump to out_put to correctly release the reference, preventing
    reference count underflow and leaks.
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

Shih-Yuan Lee (2):
  spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
  spi: pxa2xx: restore LPSS private register state on S3 resume

 drivers/spi/spi-pxa2xx-pci.c |  37 ++++++-
 drivers/spi/spi-pxa2xx.c     | 196 +++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   4 +
 3 files changed, 205 insertions(+), 32 deletions(-)

-- 
2.39.5

