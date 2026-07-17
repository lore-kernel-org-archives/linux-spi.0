Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5883B71D3
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298987; cv=none; b=UvATZTZeMq8o8SMvnSC+3el+ThhoL+RR1rbCUMvVCGO8aYK/LTTXoA+PNJW2lD/PLWXu/mmH0XQwkE0Mtp+yqSAltNSaIKDq3/Kg1txXzZdVIgB/9dOgqd8QGjSKf7gZMYii2jXNGAQKiuh09Q8RRoksqHn/AEx3XTH1wtWthAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298987; c=relaxed/simple;
	bh=8ymFnmY0ZNuVBOicii49ROHHuhSo0C0r1iGUdnql0hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUCOqDl4NsXuMlwMdqP+rkG6iSQ4+sUp40NzxFDaio08Vv1NPty7Wc3rhdPRXMH/O6Ucxv9FSt554urAGpuJ1eQXeYPFMMne1vW9Ga+ZG+H046GD37VjHU4sP/HTtXM3qZwSyPlenqtoys+4aLgff1QFqqssScz7/OPLywlZDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1gyapQT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1gyapQT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so95379815ad.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298985; x=1784903785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lAkG0oiR7Cpxcc7khZktHbhFdZU2bsEvQSvh4knDgfU=;
        b=G1gyapQT0llZPjMz+o9X9i4JKfOE+2iFul3mKM7E9KgO53B4VUh5pE+weMWfygFOSQ
         YKhlwHW5xLN4nc7GMXmRrWamHIMMxHH8MdjhYRlL7vo6HwvhK5DwQrc7BgBbARpk60kA
         gooRNues8kpF+jUGONVa/pMumniYa9I2ipaLBwrVNoErIT/MuA/0qiqwB9gbvQRr7cCK
         IDleRYpYwfOctloD6RiH86KHjplTvD+VOTelj1pZvYAoPdhCysLzclEmTk8UQNvmMLFz
         NvWvOM5AR3YLNQIZ3pU1766BhrIiTqkfkNPp0ggqmLXIE2lxWSS8kCE/EIpjbUIG4/3l
         /c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298985; x=1784903785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lAkG0oiR7Cpxcc7khZktHbhFdZU2bsEvQSvh4knDgfU=;
        b=aQOIU03vgMLtXDRDXNUtqxwgoQWtx599pTK5yb5H0c6JKmNgGNfkUcf5lSo++58/wH
         0J63lBCvoOIu1p9Fj2gtdw03Ko+W5TIUfm3BIqSuF3wJCaRt+6U1KlGgOi4gjCphmCmJ
         5efbBn3uH0hoKMK7i7o863FPl6MYBP0+D0tDJAy+B0x9u3vKA+L9I7G7Q0qj32srnOZ3
         UlUSXr1N//W65PvzDwXFANzOrSc7CWyDYvqluYhUq0a5x+rAfwhvep14kW5dQqKT3SN2
         1mtL3UavK5aWhAp9Z9z/LL1oTDMz448mOsTxE7pm+lGc86qyQM/bhhbFN8/ZzPuzMUys
         h1Aw==
X-Gm-Message-State: AOJu0YytpPi0mCms7zkaXq1daXLI8Jl3M26WsEypZF/yj63N77sCplsF
	MO9Dov2Itz6NUf5XR1Z0aAwixmPdhSokdlKiYPcZw3HCAbZJ9xB79vY=
X-Gm-Gg: AfdE7cliAaNj7uyxVTvcMNn+WJwuCgY/PX02nezCHsNJ9yUtcf3pY+2hQy29BaubxvD
	u1n9iiHGWTE3auXn6PAX7LponFu3QMX9FK7zbQzvikSmYCN/zYsusXsMnAHogd+VwlGZ/prVm8C
	KejHEXyVQ67/cA4lUYAG/WScASVYOm3wWjWs8xYC/iv7+TWP4pgDPyzjK296SiJLbrTWNCs52M/
	gK5BExhUCLnXGjyftM5+DIKebikDMAF3Kj4WJ7Wef24CanePWpawC3L5re+VgUQuXD8L3unNF//
	maJoFcYVPbJ5CQCPs1hELt3QxAlMDW3IlA6ma7ZhvdYoZnyeuCILHDzrnxKHcq73oqdfGXJjBt+
	timOIagDeN46MgegUtB+LkEuNGGe0zU6xcY5C00ek2trqWYzLYxvGnebnYuqiVEb+2b/yyXwM8b
	2CYsyZFLgYtvze9J2Y9kMLICmBcp2u4gZQfsi3XZLdQf4R0TscxxeKzhIlh7dTSP599m2vBe5GK
	ZVpSOCn9EC+Sg==
X-Received: by 2002:a17:903:1aac:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2cf34883f97mr34752935ad.14.1784298984989;
        Fri, 17 Jul 2026 07:36:24 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9bd5sm12145695ad.45.2026.07.17.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:36:24 -0700 (PDT)
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 0/2] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes
Date: Fri, 17 Jul 2026 22:36:14 +0800
Message-Id: <20260717143616.4765-1-fourdollars@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712162420.7453-1-fourdollars%40debian.org>
References: <20260712162420.7453-1-fourdollars%40debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shih-Yuan Lee <fourdollars@debian.org>

Hi Mark,

This patch series resolves two issues in the spi-pxa2xx host controller driver
related to Intel LPSS SPI controllers.

Patch 1 moves the forced PIO mode quirk for the Apple MacBook8,1 LPSS SPI
controller from the client driver (applespi) to the host controller PCI glue
driver (spi-pxa2xx-pci) where it belongs. It also fixes a runtime PM issue:
when DMA is disabled, aggressive runtime clock gating causes PCIe Completion
Timeouts on subsequent MMIO accesses. The fix is to only call pm_runtime_allow()
if DMA is enabled.

Patch 2 fixes S3 suspend/resume for Intel LPSS SPI controllers. The LPSS
power domain is fully removed across S3, losing all private register state.
Accessing MMIO on resume while the block is held in reset causes a PCIe Completion
Timeout and a watchdog system reset. To fix this, we save the LPSS private
registers in struct driver_data during suspend, de-assert resets first on
resume, and restore the saved registers.

Changes in v2:
  - Addressed feedback from Mark Brown.
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
    pm_runtime_put_autosuspend() respectively. This ensures the controller is
    temporarily runtime-resumed to active state prior to suspend, guaranteeing
    the clock and power domain are active during MMIO register access, and that
    the private registers are consistently saved and restored across S3 sleep.
  - Permanently lock out runtime PM in pxa2xx_spi_probe() via pm_runtime_forbid()
    when DMA is disabled. This covers both static PIO and dynamic fallback to PIO
    and prevents userspace/udev from overriding the setting.
  - Call synchronize_irq() in pxa2xx_spi_runtime_suspend() to wait for active
    handlers on the shared interrupt line to finish before disabling the clock,
    avoiding unclocked MMIO register reads in ssp_int().
  - Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
    enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331

Shih-Yuan Lee (2):
  spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
  spi: pxa2xx: restore LPSS private register state on S3 resume

 drivers/spi/spi-pxa2xx-pci.c | 38 +++++++++++++++++++++++--
 drivers/spi/spi-pxa2xx.c     | 55 +++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-pxa2xx.h     |  1 +
 3 files changed, 90 insertions(+), 4 deletions(-)

-- 
2.39.5
