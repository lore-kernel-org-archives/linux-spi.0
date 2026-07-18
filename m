Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E6212D86
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335116; cv=none; b=nhGJ6nXIzKeh4uQpuAm1E3N2E20jCU4QvEPRQlK5UTb4/Xos5LWx+36kj7iwPbkz2vlsywe8aq3CVhnusH6k3rsMGVaRqfuEMGNPz289uYYxziLcno5DGjRmWpQyp1iiqbOpnwUJ6X5KQ0R2z3YOEQiFLQM902vkeuc+CPyD7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335116; c=relaxed/simple;
	bh=gGAwGk8gds8iaqjE97/cnDQgwF5uW4fn/WjQ4kwG+kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVSA66gmznVofJYPqyaeyhV+nzB9IvLmwjwvBqdKfrKoiSqKnHkZ69UgWpu2WdHHJYu07h2d+H7s8sS9CAQ2x2jlYMfe4Xsx09T+aR8NEqIlKfjqj1ak2HHIJBOwxgXc1NHUsE8CaziEz3ocnlK0wUgLJSsZvHOm9lexuIy4Dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso3175041a12.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 17:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335114; x=1784939914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUDXIRchJDsaph8A7Yc8ldO3JY8TN6RDSEk2pPx+8T8=;
        b=pLEZxr1blqhCkZAAyMlEL6gvop2E9hu1ntp1VXXDaoQ4MOLQo6WKb/G1g2Z5LzXaFO
         PDAaJ7Krs2GPxUUJ0YT8UyZ0/1LRugYHoqG4NpnkQ7cM+GcvoAef335sHK3Ohn34yxDT
         cQkJDSICcIRwpAChn/mTMFsceq6/3P4Y6nF2IxeZlZunGlczXgqW6TjaLRFrN07nDc1x
         NtLTP2gKEVVsNkiAr0OHlPfm9oD+nD5zG3XKNnL6hMzMe354sXyBZpNPsce9mAMmRcjw
         ZP8A22QGAe+J10iWHJl4nEjTFeFeVbKgLWGTsMFPgp9X5DYb7FwF9zNCx2uQ9OqagiKO
         TvvQ==
X-Gm-Message-State: AOJu0YwIWOS+esEfEEtpyLoTYy286l8NLc1fRQZDp5Rg0AfqQjYktqlq
	EoY12N1IB0dqkZprhdEGg/1mio+p3tb3n3XaEoG6KLrkvURJJlBKubI=
X-Gm-Gg: AfdE7cnBMFvSeLH0Wq76VLdbVyWC+lYjFLMqigWdjUnno/LUp/wXiXZeoeFwsEz4dBX
	vZnM1fnGAQ07IKyl07keAAkLUkY5yE0J8DJXGoC7/1CXDIoZ7srTXPoLbxgzSTrufYTg7cACB+E
	CtZHPdePkUq5XB0rknZDZH0n5Yd7yea0jdqgjsRaC6GoU0qVwJMHi16T/yoi4p9pi2LRlnCKQbz
	v9Jm8ukzzcO5hbNVZat4YYe49ATw9tv1cqdHZQmfrqtujm73JkQp0hrBJKlWReP71PHi0Uq+AAP
	f5BpUAg2RxE7wVzmlMu0xw6BgNMiF6c5ZhQY9IovxdENJPfxkoTk4Qn5tDLsWjok5eXb9P3mM2X
	X1mi/uXRGWaX+0vmfVTURI9uI8MPqZRQV8de1JuZRGD+BTkTAZBwH0rC1hSVuxw6Zqh6rS+eo64
	nFDR/DjTCZzgXLgDNpTfLuzt0YesVSAVXdeRyLlOVQKpkdUOuv0pJgP0tLz57+AKQoJaKrTHkeP
	u/dZPQ/C3V9rEE=
X-Received: by 2002:a05:6a21:b97:b0:3b3:241f:66c6 with SMTP id adf61e73a8af0-3c3ad857fd7mr5471577637.26.1784335114211;
        Fri, 17 Jul 2026 17:38:34 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb334sm1564893a12.18.2026.07.17.17.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:38:33 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 08:38:21 +0800
Message-Id: <20260718003821.23334-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718003821.23334-1-fourdollars@debian.org>
References: <20260718003821.23334-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel LPSS SPI controllers lose all private register state across S3
suspend because the LPSS power domain is fully removed.  On resume the
driver only re-enables the SSP clock, leaving the LPSS private registers
in their power-on-reset state, which causes two problems:

1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
   zero, keeping the functional block in reset.  Any MMIO access while
   the block is held in reset causes a PCIe Completion Timeout and a
   watchdog-triggered system reset.  LPSS_PRIV_RESETS_FUNC and
   LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
   access on resume.

2. The LPSS software chip-select control register must not be blindly
   restored from its suspend-time snapshot: if CS was asserted at the
   moment of suspend, restoring that state corrupts the first
   post-resume SPI transaction.  Instead, call lpss_ssp_setup() which
   unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
   the state established at probe time.

To resolve these issues safely:
- Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
  pm_runtime_put_autosuspend() respectively.  This ensures that if the
  device was runtime-suspended, it is temporarily resumed to active state
  prior to suspend.  This guarantees that the clock and power domain are
  active during MMIO register access, and that the private registers are
  consistently saved and restored across S3 sleep cycles.
- On S3 suspend success path, return 0 directly without dropping the PM
  reference.  This preserves the acquired PM reference across suspend.
  On S3 resume, release it via pm_runtime_put_autosuspend(), and ensure
  all error paths in resume (clock enable failure or spi_controller_resume
  failure) jump to out_put to correctly release the reference, preventing
  reference count underflow and leaks.
- Save only the first 6 LPSS private registers (offsets 0x00 to 0x14)
  via drv_data->lpss_base during suspend.  Offsets beyond 0x14 (except
  CS control at 0x18, which is re-initialised by lpss_ssp_setup()) are
  reserved/unimplemented on LPT platforms (such as MacBook8,1), and
  writing to them triggers a PCIe Completion Timeout causing a system
  freeze.
- Clear drv_data->suspended only after de-asserting the resets and
  restoring the private registers on resume. This prevents shared interrupt
  handlers from performing unclocked/held-in-reset MMIO accesses if an
  interrupt fires during the resume process.
- Revert drv_data->suspended to true on spi_controller_resume() failure to
  ensure subsequent interrupts do not attempt register reads after the clock
  is disabled.
- Store the saved context in drv_data->lpss_priv_ctx[6] (inside struct
  driver_data) which is private to the core driver.  This avoids changing
  the layout of struct pxa2xx_spi_controller, preventing ABI symbol
  version mismatches with uncompiled platform drivers (e.g.,
  spi-pxa2xx-platform.ko).

On resume, de-assert resets first, restore all other saved registers,
then call lpss_ssp_setup() to re-initialise CS.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 88 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1ba239d28d74..f99eff359e46 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -72,7 +72,12 @@ struct chip_data {
 #define LPSS_CAPS_CS_EN_SHIFT			9
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
-#define LPSS_PRIV_CLOCK_GATE 0x38
+/* Offsets from drv_data->lpss_base */
+#define LPSS_PRIV_RESETS			0x04
+#define LPSS_PRIV_RESETS_IDMA			BIT(2)
+#define LPSS_PRIV_RESETS_FUNC			0x3
+
+#define LPSS_PRIV_CLOCK_GATE			0x38
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK	0x3
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON	0x3
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF	0x0
@@ -1532,19 +1537,43 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
+	status = pm_runtime_resume_and_get(dev);
+	if (status < 0)
+		return status;
+
 	status = spi_controller_suspend(drv_data->controller);
 	if (status)
-		return status;
+		goto out_put;
 
+	/* Mark as suspended and synchronize IRQ before disabling clock */
 	drv_data->suspended = true;
 	synchronize_irq(ssp->irq);
 
 	pxa_ssp_disable(ssp);
 
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	if (is_lpss_ssp(drv_data)) {
+		unsigned int i;
 
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
+
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1554,12 +1583,46 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = pxa2xx_spi_clk_enable(drv_data);
-		if (status)
-			return status;
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		goto out_put;
+
+	if (is_lpss_ssp(drv_data)) {
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
+
+		/*
+		 * Re-initialise the SW chip-select control register so
+		 * CS starts deasserted (SW_MODE | CS_HIGH), regardless
+		 * of the state it was in at suspend time.  A stale
+		 * asserted CS on the first post-resume transaction
+		 * corrupts the write-status response from the device.
+		 */
+		lpss_ssp_setup(drv_data);
 	}
 
+	/*
+	 * Now that resets are de-asserted and registers are restored,
+	 * it is safe to handle interrupts.
+	 */
 	drv_data->suspended = false;
 
 	/* Start the queue running */
@@ -1567,10 +1630,15 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (status) {
 		drv_data->suspended = true;
 		pxa2xx_spi_clk_disable(drv_data);
-		return status;
+		goto out_put;
 	}
 
-	return 0;
+out_put:
+	/* Let runtime PM autosuspend again if needed */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return status;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
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

