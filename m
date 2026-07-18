Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948E1D63F3
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383249; cv=none; b=MjRUfrCfB7A3q+sQKdH+4sz1XmorfWZgC9Wp7wXImvzt3GX+YAMQmPBTeW608cZOMbZTnMH8Z8MzmlJ3fVmWSGaTY3EauA1FNmavMM3n9mUjFixG0v1l7ge5sviPV0zgsZeaililITraTfpAqQoCpuzXQoGZsKm4Vgaq+9/F8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383249; c=relaxed/simple;
	bh=KHAPT0VOSNNyr+gu5L9PbXnDUfTOXEJw5BU5RjRERgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hW0YiYxBEL1d+R1ASvF7/H3K+vQHLvZBHj28tCsUWgyiUZPp1mmXXs8rSCA8h494sa7gUz1Mek48BM2W2EnqhQVyPsh190t6cyDOPvMFtFry1iH7bhpwgfHc2UXpK2qGpy726SzCi8kAGDoL1jS+2QWkG7WTLSUEjIiAMoJGTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848595b338cso10165563b3a.0
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 07:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784383247; x=1784988047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+3p0nOPDFK1jgflx6KTezX76UCIvfC9c0mBsjVxCOQ=;
        b=mOuGRDlZfF7r2OAMQbIwva7MFe+aByhWf/KEbTgFnyUoL2sSDs/6V5sqXl9essSGuj
         RGN7e2MUk+RQLJ9vqUL1Uvjs0VZMQWQJXSafjXwDQFRiL9lZkU/Gm3MScrtYCv6ItgD8
         5gtDRc7rJOPHGG2iC+hAPY0LM9Kky3TdOydo9Zs6bYOOKX1ucDM5E97uN/Oz7cKJ5quu
         +CByP1PYl1iExI1EtWGe84RGH21mdF1n5PzYl9FdDWuUGe1qaO2G49n20qq2/rkS6gcW
         /J4Q2pEqTg55LHQSj/RO2DVJxF+3wGH/S25MpN4HfgVYiOO1dbsLxaohlnXcEwVkTeY2
         W+Cg==
X-Gm-Message-State: AOJu0Yz1BJ8CcB5KYxYxexV/v2U1KLBIMIL/4/0deCJ6zn74IIOWjhoR
	iPmc/UUhAz/3rANqBQBAkBCd6HjdkapNxQkwUSQ9FzIIJPdxAe4JGe0=
X-Gm-Gg: AfdE7clowsd7OSPy8XK4fqttX98VurE326di/NPKH5CEWEXv6hP6EadbtZLccy4OpFk
	N5XWryqMWKugp1Jux2q4JOo9tO9Rbds/v9F/kiA68zM97vgVtPcapSoFoZWZfeX7VR+wA1y6alH
	ND2WA522bD1U3XPKA0NITThsX3D/dGDrKqR5ciMpYoex3yGGrHVPNzbHE9jHBUgNJZbG+n5qk57
	wODyOrALwacHeX24l5BvmFIj4EXJQrSKrseVGNSCXAjUXvsRgXfnjmfUkSBGLWamJML3VskABxC
	e8Y2/gM6goIesgCgG/oRJFLy/547Rv+/L1d13aeJRRka43wXnMlhRUQ33bTBcF3UBp0wJXcXNTV
	Tf7SE0LfTC/RYd9Lw8N/XaOM0duZACx8M5dm0EMlRcy5kyDwEL+JIXrbQ199P16pST4UCg5i4kx
	hlWOPtFiLWg6ZdVXYR1lQgoYLg8+SEG3ixVnNWDErKsa6tp+z7MhZQGXhR9bjWTBnTRdiaIVaAt
	SDDTHQQr1YnFYs=
X-Received: by 2002:a05:6a00:9092:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-84c292a0e7bmr7650997b3a.14.1784383246977;
        Sat, 18 Jul 2026 07:00:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6ea1csm2816890b3a.49.2026.07.18.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:00:46 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v11 3/3] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 22:00:37 +0800
Message-Id: <20260718140037.4299-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718140037.4299-1-fourdollars@debian.org>
References: <20260718140037.4299-1-fourdollars@debian.org>
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
  pm_runtime_put_autosuspend() to guarantee active clocks during MMIO
  access and preserve PM reference counting.
- Restrict LPSS private register save/restore to LPT, BYT, and BSW
  platforms via pxa2xx_spi_need_lpss_restore() (newer platforms are
  handled by intel-lpss.c).
- Save only the first 6 LPSS private registers (offsets 0x00..0x14) in
  drv_data during suspend, avoiding reserved offsets beyond 0x14.
- On resume, de-assert resets first, restore saved registers, call
  lpss_ssp_setup(), and clear drv_data->suspended to prevent unclocked
  IRQ access.
- Add error recovery paths for spi_controller_suspend/resume failures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 94 +++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 317e2c24ae67..368c7f97bfe9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -194,6 +194,18 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
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
+
 static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 {
 	return drv_data->ssp_type == QUARK_X1000_SSP;
@@ -1542,16 +1554,46 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
-	status = spi_controller_suspend(drv_data->controller);
-	if (status)
+	status = pm_runtime_resume_and_get(dev);
+	if (status < 0)
 		return status;
 
+	status = spi_controller_suspend(drv_data->controller);
+	if (status) {
+		spi_controller_resume(drv_data->controller);
+		goto out_put;
+	}
+
+	/* Disable SSP interrupt generation on hardware level while clock is active */
 	pxa_ssp_disable(ssp);
+
+	/* Mark as suspended and synchronize IRQ before disabling clock */
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
+
 	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1563,11 +1605,46 @@ static int pxa2xx_spi_resume(struct device *dev)
 	/* Enable the SSP clock */
 	status = pxa2xx_spi_clk_enable(drv_data);
 	if (status)
-		return status;
+		goto out_put;
 
-	if (is_lpss_ssp(drv_data))
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
 		lpss_ssp_setup(drv_data);
+	}
 
+	/*
+	 * Now that resets are de-asserted and registers are restored,
+	 * it is safe to handle interrupts.
+	 */
 	drv_data->suspended = false;
 
 	/* Start the queue running */
@@ -1576,10 +1653,15 @@ static int pxa2xx_spi_resume(struct device *dev)
 		drv_data->suspended = true;
 		synchronize_irq(ssp->irq);
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

