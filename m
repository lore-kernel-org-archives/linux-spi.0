Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FE37418C
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306261; cv=none; b=g299rn5c+ulmv52WG7IkvMw+Dd/7nHLvaxvLnd3QOroe2SLyFeqOAQ14AjnNGe1ifEIji2LZjd59leUcZi8f6CMSpR2tb++vquCn1Ktwra34tu83SXAMF5bUqjIzLSE9R59auPkPPrN4INGqrgwyzfgZoTIY80SDE/fQGNICh6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306261; c=relaxed/simple;
	bh=HZ5YTF9GYoAlsnM7oJOGBeXrYjPlbnRvkM61SZGBasI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKDzre4FOoWSNTm7cpaxfXMmqPcU2R0809QB/6iMfM30FDXlaTQNLDfwbQnpDYlWJx6dtOt71MZ0CmYwXWtwrG/y5E4GrOkbcMaZU4rpoHRVfEGB89olVeVNhrreT2mdA7XVBmLLeNlXEYW2cHyo1kycY8RRTGxV5vbGc3F+frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b4066so8392586b3a.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 09:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306258; x=1784911058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hKG+gBr1FSGAqfveOYcKJx+zaEocGibVUi6lGcuay/w=;
        b=asVb9bFVDIoe2q03WfkjcDfJacZ0AbFGEhSelrMn2fZzA89Cz3q3MqbPZDHgeDGYz0
         hPwZJH0L9YlJQo/r5j+f+2XXjSQyUX8tPolGXOBd++Qcngjb4gUDBF8q55uBEFT3dT9j
         vetBa+fsipQ9xODAKfd8IQQ522ghpQZjmddRTS6cBhcjPzldz+loXgw5yqHCBITj3aCN
         mRAUyy7pGatzSe9wVYsjerkOwWnpAUfffmicbBOKBFjYyKG3NxOapsCvLw63rD/iKa8K
         Gb6xN7SF2iXmakuB+QNIAl0aFcNDOTO1ibY16fFgbHQecxLUoIhtOMyKglEkP2zcFH1H
         IvPQ==
X-Gm-Message-State: AOJu0Yy07x+lZrXIO2avj9pOi2qk4bQ+SaNd4cqHUVaHiIEi20leA2Sg
	hG1u2Gc4mN0o0BQ5CHQkY/DLAesJNNLNS3yfyC4ajr6uMJchSOMS0grSDY4J6mE=
X-Gm-Gg: AfdE7cmHV20yc2rtiT/P8OKSwYdLqOBeru/TTX26V2LMqKutY6ssrGBUoAjgyjF0hFI
	ozsaDFAHgbH0OV/kWTubCnHuqwHYJuFp4KjDItESrq/TPo/W91SlseGPL9w/dCr2y6raISdtgG1
	hkwLLcDnM0ykvQeVtt5tDKXivYG2NyPqm+nDDDCuUXAzj7gTbfC/Zzs+IN/ZZUsY7N+dcgcH169
	m7dnPq1EB6P98XSolOLj25/SsXsVBDj3p0jYoyVdxfXh4rGCOyHCI43tdJil0rwWR2s9cqoNVaz
	c+R9fTTrPzwsXh3EwMol021hMB/Mp1R439496Sqd9mXkxWJ1uljxRy4Tw0P/6q7f10iAcljCgTG
	xy6tWwVYrOGSWGrUX8pAEyG6WemqqgdCbl326Pe0u1VOzeMX/5Xc+zKjcys7bBfKISW8r7jZ3Mg
	K/VRA+Eix327oaaObgIiArYEOyCwWwRvp3blK2ybk/44bj190h41dujbjQm03GRzfffPuu/+pS5
	v0O+G1iwqUkmiA=
X-Received: by 2002:a05:6a00:1a8b:b0:848:34ad:3d6c with SMTP id d2e1a72fcca58-84c2926bf9bmr3526231b3a.15.1784306258273;
        Fri, 17 Jul 2026 09:37:38 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b86dsm1441669b3a.8.2026.07.17.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:37:37 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v4 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes
Date: Sat, 18 Jul 2026 00:37:29 +0800
Message-Id: <20260717163731.6782-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712162420.7453-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
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

Changes in v4:
  - Addressed feedback from Sashiko review regarding clock enable count
    underflows, interrupt handler race conditions, and early probe races:
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

 drivers/spi/spi-pxa2xx-pci.c |  47 +++++++--
 drivers/spi/spi-pxa2xx.c     | 191 +++++++++++++++++++++++++++++------
 drivers/spi/spi-pxa2xx.h     |   4 +
 3 files changed, 206 insertions(+), 36 deletions(-)

-- 
2.39.5

