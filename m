Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF327083C
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335112; cv=none; b=V8bct16/FaaOs9ojmQbg/e909Kth+4vGHlUlzZEg35HjTa30xqBfdwNoy+3NkW86oUwfXp7d4xQLRIyNKEhSvBRtoMgCbUiz1dr9VaAfwg6p1C4rTURfhS/dTksdceA7MWa+Z1a1e6LVYs3xMBJCSLfKNoLZg/v0UYZFx5bQe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335112; c=relaxed/simple;
	bh=TDXIzuFPFVDD4UOa7HejSQlDDz0BqEFy/GCik5LZELY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rREHquDxtSC0qmRMd7udSXzsRClyggmYYPdQ4jGjRssWdKcpksBb7pCYN0UvoqiiPQVAmcp8HP++eN9sJUBKtoV5OTdhLW16jUyzDKmWWuQBjeWzBjZjYpxtB8mgNoIunuRqTRxfW5QlcaxUd2xIQ0212RTcAXdqz70+DLlF0fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso5600632a12.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 17:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335111; x=1784939911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eM6+9FYR9HGD5QJX2rWBz9RgmV7p843ELKyCm5qjzuM=;
        b=kxHHqJmaY/Tm2Y9r3p1Zdsdrkv68mWkDL4BjxeIswoOy6dEB+njFmt0m9QEvuWrMqF
         scVjTjnFRfzc0MU+qqD/tFH5UzvWCxi+fd6/yj7Nek94aS3V0a/+ivfPuWSTF8HjLskE
         bvf4Te1DUsWQC5p3iSatW1nyleosI7RKQhNBUp2yagHGSw0UTVhV1BImelAM/koHKyif
         2TfW4WjNqWzeQINMI3CrQqakzpX1yQbpR3mVlKKXZmLxV+4CyKpqu5Hsg2ZEoSTgidZf
         7vIcNi0TQ4SDatbHDeNwOUc+vbyNcq6tQ6VvoerVP/ML5FAnFDYFzj77zsyrADHsOMqf
         F2gQ==
X-Gm-Message-State: AOJu0YzIjxpzy5MsfU1J8XR5LERvOojF9+q4TMEj4OzuGz/UCpYW9hhC
	i6VO+6LPZdkbM42vzaM6QaRWg8pZdw5ZIF2cJgI0bsanOLI8R4Mz8Z4=
X-Gm-Gg: AfdE7clt56ZVL4MHVM9GO7YabJJx0HKpfPStUmIDiSRye6hizNUSgb1sYmypx5SoBkx
	HMOHOnVHj30Zh6S6l7f7OZ/wCnfI6WZMeUwVDeu8kjFjAk9CecPB7qsMNIeOPDcqleNgpcBpANP
	3Af4KfzMbOwS9zULJWDDKyjbRVoXMGokb/KxmpJezmjJQgPFp5zJKCa2Qn1M2CoPEmKJVPVk4f5
	sLx0AD64kqWMsJ7SjoogwPBdMmT4lFnSyMB8StCGBa9tKSfSGLntSneyuBXUrauD8an5HM05r4Z
	5pONXU2oSQRPX34ISzXlJephZhqCG94AVKFhSV5KQjX2gKTiftuVd/EuPfzOc3epiLnIMwHxD8v
	+WoatIw90k0gvBXWXelCcNK0mhbJAkHn3965bdn+UWDVVGsY1kcGhnONhBdMj3i3CtJNmx3c5ry
	/+yhICh14Kj2kAK4Qk4nKAE66SE0rv6aBnco0TyHyj4/A0HKT8ksZY2VsaovlD9SHHwXHGpWf1j
	OXS9ou+Nkff69o=
X-Received: by 2002:a05:6a20:9148:b0:3bf:a881:4094 with SMTP id adf61e73a8af0-3c3ad9e405dmr5458068637.50.1784335110797;
        Fri, 17 Jul 2026 17:38:30 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb334sm1564893a12.18.2026.07.17.17.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:38:30 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes
Date: Sat, 18 Jul 2026 08:38:19 +0800
Message-Id: <20260718003821.23334-1-fourdollars@debian.org>
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

Changes in v5:
  - Addressed feedback from Sashiko review on the v4 patchset:
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
 drivers/spi/spi-pxa2xx.c     | 195 +++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   4 +
 3 files changed, 204 insertions(+), 32 deletions(-)

-- 
2.39.5

