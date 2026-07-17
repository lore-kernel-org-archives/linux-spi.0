Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928836C588
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303218; cv=none; b=s7aXttqgZ6mlKLwC7Ja3r+PaIIynkw9tfQ545Kp2IMuJJN6JVVDNLEzKKprK1a+x3F2xQ9vFcZqQBb83vIKGVpDeJCsnnUlzOZIVApKqEXTGmz43YeIoanUNIQIR2vcpei8WW/B7dDmYuaqmL89XONYBSfHoXQF5j1B4FvCILMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303218; c=relaxed/simple;
	bh=UfXkNxj+FB2tqPSd2EHdoJ0ydOHvmml4jVP6DMSjvKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbDEIfsgUa9QTj5SK3edqH5WvGcpc8o1lm9q2Z1qTs22PS4vdjrJPneIF6xFYWyA/U3n7ntRUPqeFVYwhEijD3OmJAMvoIFe7wpy0BmibUNaSU6e7lw4zvUaTz5bY5HqGleeB7W8MqGaTRp1u3UE1ncs/oWNZkHDdNfym0V4Kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485b358552so8795339b3a.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303216; x=1784908016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quYbyLZibH7dNf7QOxx9IVZ6zzx1g0W5CRE0n1Q+z7E=;
        b=tUN/IL47nQf6ATzFcspBoZiTzB1btvscrNOV25vmBTfB3qxU4gofvtZVYIxcx2dncl
         kuzQzj1L6VNaLX8tZS5d1QrUJ5gDSQzdiNJWYvgdNZYlqmOaDIemQsQ56mJ98H+1/1lX
         l8FUggYPm0n2IS5qu/2gLs96n4+mp9scJE0cto0elm/BCmiC6FbDB0IS8IguZpgfESfh
         LCBxa+GBqSAAz9oLIQCzJfJK6P6/PBVn4MeWaxjGGF51S27DwRXEbOx8/ggLCGWVLDzJ
         yKoKWShU01sa+bjMmjl469kK9TCvVAHu6jdKB6DX8AtGdM+ZCoEBIPBPULV0aiGrb2Ci
         c/bg==
X-Gm-Message-State: AOJu0YzB40DYYCJO58Gc2gHVA34lzYQDMol6lf/cn7QQodA6LqBvvM1T
	R3a0ez41XAKkC08m+YbxBHTehoJCcbi0zpPcIZTKw5oB64p5xgYQXqA=
X-Gm-Gg: AfdE7cmdhraAYJjTRhQ/8cjKcpyJZ2aOTvGqWHB2ulx2zqQMm/KwUBidHTiCmxTdORe
	T4C6LI8uYyeoranm+JO8Wby5GSJ2rNJr7aefeINt6SDxWH4THC4cIM1VPsY8dUkRMi3vlzB6P/9
	Uh2XvZrCKuHIZF8QObA4maYrkD3sIFg240nvs7b8Je1BthL9gZBqCW7FjPdRkbMDMysuMOI5pJ9
	t7BlpiXzee1mZTJg0cjT9gzX6IFyjvP76FVtErPiuY2n/m+e7aPVHMmZ3D4h6sKIzi8EiNafezJ
	vPXrv8IDlyh/Pf+buA1Cw8CpKHQNNfylVtG+gYBSuzV+oZRxrGXH6awOLPfacfq+jqQIj8wDFWQ
	2h2F0+1FZ6MQCtWAwDp5AHtTEJSWYqH5Mo8tB16O/bfpHEP0QBLK0VxzPLTyRmKZWK2YEcjx6R/
	U8vJu2hHlxOag1DmB1eOMfS5bhd5ljWbl8k1wBginiG9vtHg5SfvENVcFQs9yyCSWe6hh2/88ta
	FNv9FlLVyKK9yem2KxMgsR/OQ==
X-Received: by 2002:a05:6a00:1887:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84c2928948dmr3262716b3a.25.1784303215610;
        Fri, 17 Jul 2026 08:46:55 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad87f83sm1332576b3a.3.2026.07.17.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:46:55 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes
Date: Fri, 17 Jul 2026 23:46:44 +0800
Message-Id: <20260717154646.5854-1-fourdollars@debian.org>
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

Changes in v3:
  - Addressed feedback from upstream AI review regarding PM reference leaks,
    races in the shared interrupt handler, and teardown order:
  - Avoid PM reference leaks on probe bind/unbind cycle by keeping probe PM
    configuration symmetric.
  - Prevent userspace (PowerTOP, udev) from overriding runtime PM settings when
    DMA is disabled by holding a PM reference via pm_runtime_get_noresume()
    in pxa2xx_spi_probe() and dropping it in remove/error paths.
  - Check device status in the shared interrupt handler ssp_int() using
    pm_runtime_get_if_active() instead of pm_runtime_suspended(). If the device is
    suspending (RPM_SUSPENDING) or suspended, ssp_int() immediately returns
    IRQ_NONE to avoid reading unclocked MMIO registers during power transition.
  - Call synchronize_irq() in pxa2xx_spi_runtime_suspend() to wait for active
    handlers on the shared interrupt line to finish before disabling the clock.
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

 drivers/spi/spi-pxa2xx-pci.c |  47 ++++++++++--
 drivers/spi/spi-pxa2xx.c     | 140 ++++++++++++++++++++++++++++-------
 drivers/spi/spi-pxa2xx.h     |   1 +
 3 files changed, 157 insertions(+), 31 deletions(-)

-- 
2.39.5

