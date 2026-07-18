Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87B2E7379
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344973; cv=none; b=YTOozArwibdCXXw+1okI5PHc700VeLK39lmd6jM9zLPnSuSY44qhbF3S2Sf3uMBqahrkrqFYkwcK2qsl18e3jf571bZzvYzyd7zf/2SCAcr/bZ1LlKbxX8wwVS+ae5JMCghTSefySPvSZ65u4yilw9KqsNjLiAA2L0kRB29i38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344973; c=relaxed/simple;
	bh=1MuJTtWbAuPleMDlezS6XKBQ4UcAo0HPFgrqr8Ze7iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FURwICI8Mn33+EjOGa0JO4litwfd+098c0DG/86L8fS2Ef6saIpXhMSoHLPkqIeVbvi5aQKjXApYn7GOCO1ykVKktkV10mSdhLALNR3BkA+XbAYKV0BQRv0+p3wX2qoTwXf0kNyKxUYuIdpi8K2W30ZGb0bv0258/damtyCqljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84847482584so1826248b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 20:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344971; x=1784949771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXf8o0rZeClVWesXILVN9mkThfzs4A71dIFBvPFH0NU=;
        b=Smx6+/aTw2DNe5rshNqJPKqTQu8FIPRDP66MeUETrzyyyNGc9v2+SW+iRfSmVsRbDt
         fnm10LsVtaEK0oX0EecEcXhpwto1LOm4dW5mf06q3bK4knLZTfVXecq8eDiAd43Kpe5L
         TzW611JDRKUU1pMc+vwvFReaV3Fuc14vIj2G+x2/nRI1x/gWkr9yfg9t79wfg7GhUWgZ
         TTco4zxcQb6zSW4AjHNl248yVLEirXDQ3zs7h+EAuI66qM79coekpfmb4ufwHyneG1Ow
         rhctPjL0uECxJOd2AsWcFFUYal2PAjxe4xWZYpKdL1tbR6OkKtGUmhSUu69bc8fSLHmW
         /Zvw==
X-Gm-Message-State: AOJu0YwDRDk64e4BRx6CES32HCH32OXZC6HNm6jPgZjYxkJXyPq4I4NP
	IsfnGlUita4b4nkj9Smna/DaHtWgDNTEI7RJjhGOYQE+QqPZelPi+6c=
X-Gm-Gg: AfdE7clu2wduT9veTS1jVk1kX3iCDoNl82a9dwclWDE7Y88MYwOQdPAjVwMj1keJ+f4
	pAnBnDtGTxbOS8+Y6Tnc1hhg2Fp5AYlb0ucFpzgQclaR/1yBD5IIZwPRbhV9fO+d1NO99ePXAzV
	aofcWAWlIiD8k2l5ey3l1aLwlKlCzP6N9Ny3zFZACe8njwYRTJvvO3xoLBLglQDmjXp3rR1ZaV1
	2Lqu5tQa/zosHIchKsuqPJF5uuRvuj828191rf7YYYfG5yU22KTA2EAKTO2tvpmhVAHhLN6SsIV
	VbP3IkZgkC/7aq8xe8we9HPEBX7hDT8hwdoKlJsvTGq6+uN5CFptNXmvm5SV5qiPhTPm71htagf
	e3b8RHyjSlfkX95+PdBif4gubH295ZJ9ExPkN7LNVGWyQ7pUsbxi8eGHXtL+rtN2tnHJfBYx9zg
	vRAvaY/bTftkxneGmQW0Zriuv9L2zNVcU9AMHMbDm14EaiqIHOYlgJSeOXy8/DQM5KyIB+A915x
	ohdJ3QF8XA/8uA=
X-Received: by 2002:a05:6a00:2e0e:b0:847:9919:e772 with SMTP id d2e1a72fcca58-84c28aa67eemr5351884b3a.21.1784344971116;
        Fri, 17 Jul 2026 20:22:51 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af31790sm2088157b3a.37.2026.07.17.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:22:50 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v8 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 11:22:39 +0800
Message-Id: <20260718032239.19136-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718032239.19136-1-fourdollars@debian.org>
References: <20260718032239.19136-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel LPSS SPI controllers lose all private register state across S3
suspend because the LPSS power domain is fully removed. On resume the
driver only re-enables the SSP clock, leaving the LPSS private registers
in their power-on-reset state, which causes two problems:

1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
   zero, keeping the functional block in reset. Any MMIO access while
   the block is held in reset causes a PCIe Completion Timeout and a
   watchdog-triggered system reset. LPSS_PRIV_RESETS_FUNC and
   LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
   access on resume.

2. The LPSS software chip-select control register must not be blindly
   restored from its suspend-time snapshot: if CS was asserted at the
   moment of suspend, restoring that state corrupts the first
   post-resume SPI transaction. Instead, call lpss_ssp_setup() which
   unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
   the state established at probe time.

To resolve these issues safely:
- Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
  pm_runtime_put_autosuspend() respectively. This ensures that if the
  device was runtime-suspended, it is temporarily resumed to active state
  prior to suspend. This guarantees that the clock and power domain are
  active during MMIO register access, and that the private registers are
  consistently saved and restored across S3 sleep cycles.
  This also ensures that the unconditional MMIO register access in
  pxa2xx_spi_suspend() (specifically pxa_ssp_disable()) is safe from triggering
  PCIe Completion Timeouts.
- On S3 suspend success path, return 0 directly without dropping the PM
  reference. This preserves the acquired PM reference across suspend.
  On S3 resume, release it via pm_runtime_put_autosuspend(), and ensure
  all error paths in resume (clock enable failure or spi_controller_resume
  failure) jump to out_put to correctly release the reference, preventing
  reference count underflow and leaks.
- Save and restore LPSS private registers only on LPT, BYT, and BSW platforms
  (via helper pxa2xx_spi_need_lpss_restore()). These platforms operate directly
  as PCI/platform devices without parent MFD drivers (intel-lpss). For newer
  platforms (SPT, BXT, CNL), private registers are already saved/restored by
  the parent MFD driver intel-lpss.c; accessing hardcoded offsets 0x00..0x14 on
  newer platforms where offsets 0x08/0x0c are absent/reserved causes PCIe
  Completion Timeouts and system freezes.
- Save the first 6 LPSS private registers (offsets 0x00 to 0x14) via
  drv_data->lpss_base during suspend for LPT/BYT/BSW platforms. Offsets beyond
  0x14 (except CS control at 0x18, which is re-initialised by lpss_ssp_setup())
  are reserved/unimplemented on LPT platforms, and writing to them triggers a
  PCIe Completion Timeout causing a system halt.
- Clear drv_data->suspended only after de-asserting the resets and
  restoring the private registers on resume. This prevents shared interrupt
  handlers from performing unclocked/held-in-reset MMIO accesses if an
  interrupt fires during the resume process.
- Revert drv_data->suspended to true and call synchronize_irq() on
  spi_controller_resume() failure to ensure subsequent interrupts do not
  attempt register reads after the clock is disabled.
- Add spi_controller_resume() recovery to the error path of
  spi_controller_suspend() in pxa2xx_spi_suspend() to prevent the controller
  from remaining permanently disabled in the event system suspend is aborted.
- Store the saved context in drv_data->lpss_priv_ctx[6] (inside struct
  driver_data) which is private to the core driver. This avoids changing
  the layout of struct pxa2xx_spi_controller, preventing ABI symbol
  version mismatches with uncompiled platform drivers (e.g.,
  spi-pxa2xx-platform.ko).

On resume, de-assert resets first, restore all other saved registers,
then call lpss_ssp_setup() to re-initialise CS.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 60 ++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f6cc39633191..c200930a2fc5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -194,6 +194,17 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	}
 }
 
+static bool pxa2xx_spi_need_lpss_restore(const struct driver_data *drv_data)
+{
+	switch (drv_data->ssp_type) {
+	case LPSS_LPT_SSP:
+	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
+		return true;
+	default:
+		return false;
+	}
+}
 
 static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 {
@@ -1561,6 +1572,22 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	drv_data->suspended = true;
 	synchronize_irq(ssp->irq);
 
+	if (pxa2xx_spi_need_lpss_restore(drv_data)) {
+		unsigned int i;
+
+		/*
+		 * Save the first 6 LPSS private registers (offsets 0x00 to 0x14)
+		 * while the clock is still enabled.  They are lost when the LPSS
+		 * power domain is removed across S3 and must be restored on resume.
+		 * Use drv_data->lpss_base so the correct per-platform offset
+		 * is applied regardless of LPSS IP revision.
+		 * Registers beyond 0x14 (except CS control at 0x18) are reserved
+		 * or unimplemented on LPT, and accessing them triggers a PCIe
+		 * Completion Timeout causing a system halt.
+		 */
+		for (i = 0; i < 6; i++)
+			drv_data->lpss_priv_ctx[i] = readl(drv_data->lpss_base + i * 4);
+	}
 
 	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
@@ -1581,6 +1608,39 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (status)
 		goto out_put;
 
+	if (pxa2xx_spi_need_lpss_restore(drv_data)) {
+		unsigned int i;
+
+		/*
+		 * The LPSS power domain is removed across S3, taking
+		 * all private registers with it.  De-assert the
+		 * functional block and IDMA resets first; any MMIO
+		 * access while the block is held in reset causes a
+		 * PCIe Completion Timeout and a watchdog-triggered
+		 * system reset.
+		 */
+		writel(LPSS_PRIV_RESETS_FUNC | LPSS_PRIV_RESETS_IDMA,
+		       drv_data->lpss_base + LPSS_PRIV_RESETS);
+
+		/* Restore the other 5 saved private registers */
+		for (i = 0; i < 6; i++) {
+			if (i == LPSS_PRIV_RESETS / 4)
+				continue;
+			writel(drv_data->lpss_priv_ctx[i],
+			       drv_data->lpss_base + i * 4);
+		}
+	}
+
+	if (is_lpss_ssp(drv_data)) {
+		/*
+		 * Re-initialise the SW chip-select control register so
+		 * CS starts deasserted (SW_MODE | CS_HIGH), regardless
+		 * of the state it was in at suspend time.  A stale
+		 * asserted CS on the first post-resume transaction
+		 * corrupts the write-status response from the device.
+		 */
+		lpss_ssp_setup(drv_data);
+	}
 
 	/*
 	 * Now that resets are de-asserted and registers are restored,
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 44f37bf9c519..48169494f74e 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -71,6 +71,7 @@ struct driver_data {
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
 
 	void __iomem *lpss_base;
+	u32 lpss_priv_ctx[6];
 
 	bool suspended;
 	bool clk_enabled;
-- 
2.39.5

