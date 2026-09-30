Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C694E0B66;
	Wed, 30 Sep 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784431; cv=none; b=sEVkyTCp50VYHFWVvdbla+fZat0fWU4inh/snKVdTpZ/O+bU+oIIwgiexIdrE83/ojBTBOi3ZbrMXaA/4XJLKHc4V9dckdl0PFJ6TrOY+eo5aENXVvyoYHSD+TfOn6QqBy7yekCQxjHo1XlYfclugCCuWIXoKKOr2QyTD4J6uUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784431; c=relaxed/simple;
	bh=wXqDVT4tr0KBXwWfvGrih3GTquJ6fdAM0CpILUZNeoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HyUPYfkzLErQ2sFzIlEhdfjOg3mi4VDKMxOBqC4JLh5l2HwZCVdkT7cqKPAOqaTtuJeg3fcjaMKBluPA/5BGZZNQowXmKLgExoRkiFjRT94Ot9PVHW6lskSl+ofndRhC9ZsLEOk+Ir8HGKdVNkA9p9tJ1bpShAdrfnKr+nLm1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Mjrq401I; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Mjrq401I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=+0BZdGRdvEFmuDuVk4rhgJ6D4Ekp5JlHxfNwF559ihs=; b=Mjrq401IxyYujswkhyiFsQFv8+
	WKDTI7ujJxWADS74sjQSEeW/A9Sw8kRQ1229jxZsqisEIB5vXNEaGKEn5J7u1kSRwtFaXcIedY2Cc
	cHtAScTvu+9JDboFmqCOBU5Gp7xpFu8q4QmZCRTCClwBUfz8/edfn3IdektdgxXE4JYJn7ZhsAQh/
	xGIkq+eCfKEJGBwuJCS6oEynz/T15HerHsLjelfIBgiYRW7AjGjshrM3GGxFsDNKcNQeglf56Rv2C
	u25SVJ8k8Iosuz1RmVDBXvQO/n3AVcZB9/0fDngCMsX+cUU9VS0bJyEOxAKMNNeFomNZpDiljF4BQ
	EnBVFTdQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <fourdollars@debian.org>)
	id 1xBwpT-009IoV-0c;
	Wed, 30 Sep 2026 16:06:47 +0000
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v17 0/6] spi: pxa2xx: PM fixes, teardown overhaul, and LPSS restore for MacBook8,1
Date: Thu,  1 Oct 2026 00:06:23 +0800
Message-Id: <20260930160629.1822-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Debian-User: fourdollars

This series addresses power management, interrupt synchronization, and
S3 suspend/resume issues on Intel LPSS SPI controllers, particularly
focusing on making PIO mode robust and enabling reliable operation
for the SPI keyboard and touchpad on Apple MacBook8,1.

Patch breakdown:
- Patch 1: Rename status variable to ret in pxa2xx_spi_probe(), suspend,
  and resume to align with coding standards.
- Patch 2: Introduce serialized clock enable/disable helpers with clk_lock
  and a clk_enabled flag.
- Patch 3: Guard MMIO register access in ssp_int() by acquiring an active
  PM runtime reference, properly distinguishing suspended state (0) from
  RPM disabled state (-EINVAL), and synchronize probe IRQ registration.
- Patch 4: Overhaul teardown and suspend sequences to ensure in-flight
  interrupt handlers complete before the SOC clock is gated.
- Patch 5: Restore LPSS private registers and deassert functional, APB, and
  iDMA resets across S3 system resume in the PCI glue layer, scoped to
  Lynxpoint-LP (is_lpt), taking the register snapshot after the queue is
  quiesced, restoring registers and deasserting resets before power/clock
  resumption, and disabling D3cold during runtime PM.
- Patch 6: Disable DMA channel allocation to force PIO mode as a workaround
  and keep the controller in D0 specifically for Apple MacBook8,1 using a
  cached PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND quirk, resolving DMA timeouts and
  eliminating 60-125 Hz input latency spikes while keeping safe autosuspend
  configuration in sysfs.

Changes since v16:
- Series restructured to 6 patches:
  - Merged runtime autosuspend lockout into the MacBook8,1 DMI quirk in
    the PCI glue driver (Patch 6/6), avoiding any generic core driver
    pinning.
  - Used PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND in struct pxa2xx_spi_pci_config
    to keep MacBook8,1 in D0 without calling pm_runtime_allow().

- Clock management helpers (Patch 2/6):
  - Documented that pxa2xx_spi_clk_disable() provides idempotency to
    avoid Common Clock Framework underflow warnings when removing a
    device that is already runtime-suspended with its clock gated.

- Interrupt handler and PM synchronization (Patch 3/6):
  - In ssp_int(), distinguish between RPM suspended (return value 0)
    and RPM disabled / !CONFIG_PM (return value -EINVAL), servicing
    interrupts when RPM is not active and guarding pm_runtime_put*()
    with active > 0.
  - Dropped redundant lockless pm_runtime_status_suspended() pre-check.
  - Pair READ_ONCE(drv_data->clk_enabled) with WRITE_ONCE() updates.

- Teardown and suspend overhaul (Patch 4/6):
  - Documented that pm_runtime_force_resume() failure returns immediately
    without resuming the controller queue to prevent queuing messages to
    unpowered or unclocked hardware.

- LPSS S3 context restoration (Patch 5/6):
  - Renamed 'is_lpss' to 'is_lpt' in struct pxa2xx_spi_pci_config to
    accurately reflect Lynxpoint-LP scoping.
  - Verified structure packing with pahole (152 bytes, 0 internal
    padding holes).
  - In pxa2xx_spi_pci_suspend(), quiesce the controller queue with
    spi_controller_suspend() before capturing the LPSS register
    snapshot to ensure registers are in a clean idle state with chip
    select deasserted.
  - In pxa2xx_spi_pci_resume(), restore LPSS private registers and
    deassert functional, APB, and iDMA resets before calling
    pm_runtime_force_resume(), guaranteeing that the controller is out of
    reset before the clock is enabled and eliminating the shared IRQ
    window against unclocked/reset hardware.
  - Eliminated dead was_suspended branch in resume and kept clock helpers
    static to spi-pxa2xx.c.
  - Added pci_d3cold_disable() in probe for Lynxpoint-LP to guarantee
    registers are retained across S0 idle states.

- Apple MacBook8,1 Quirk (Patch 6/6):
  - Added 'quirks' field in struct pxa2xx_spi_pci_config placed right
    before 'is_lpt' (152 bytes, 0 internal holes verified by pahole).
  - Cached DMI match once during lpss_spi_setup() to avoid duplicate
    scans.
  - Documented forced PIO mode as a workaround for EFI leaving the
    companion DMAC held in reset and unrouted DMA completion interrupts.
  - In pxa2xx_spi_pci_probe(), always configure autosuspend delay to 50 ms
    and arm pm_runtime_use_autosuspend(), but conditionally skip
    pm_runtime_allow() when PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND is set.
    This keeps the device in D0 by default while ensuring that if userspace
    enables autosuspend via sysfs, the safe 50 ms delay is preserved.
  - Maintained factual documentation reflecting OS parity (macOS Big
    Sur and Windows 10 Boot Camp) and logic board schematics.

Shih-Yuan Lee (6):
  spi: pxa2xx: rename local status variable to ret
  spi: pxa2xx: introduce clock enable and disable helper functions
  spi: pxa2xx: acquire active PM runtime reference in interrupt handler
  spi: pxa2xx: overhaul teardown and suspend sequence to synchronize IRQ
    before clock gating
  spi: pxa2xx-pci: restore LPSS private register state across S3 resume
  spi: pxa2xx-pci: disable DMA and runtime autosuspend for Apple
    MacBook8,1

 drivers/spi/spi-pxa2xx-pci.c | 212 ++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-pxa2xx.c     | 177 +++++++++++++++++++----------
 drivers/spi/spi-pxa2xx.h     |   6 +
 3 files changed, 332 insertions(+), 63 deletions(-)

-- 
2.39.5
