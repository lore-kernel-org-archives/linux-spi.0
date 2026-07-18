Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEC38BF70
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380490; cv=none; b=iYFFodE6Ot8G9LVCZqnIyJu0Aetgq2kYBLlvRiN9ypYNz7YlOrhfv7ULkwmwykuriACawifUmCYn/tvCWlWLCZj7hvq7p1AGOAPD1uFqaxEmnwsOzVRlL3RBYpj6a+CSaQaeEaBogWdn/jhlk0kLQVQ6ipnWiKp/WgikmDArJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380490; c=relaxed/simple;
	bh=EJtT1hnvRWnDCWIdxclZ4LgOtxPz9vE9H4Q9LYyEytY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ET801ftHTUmnCJqoNKa9Z11T3d3hIaHxaXRGK9/jWGkprmWKv4lRcRDtQVd5AIJLZTWovpRcPPomo0LrVmDkgCsVCX85jBPSnAyZI2ARUujalThQlnQYf8f015nWPsVLRlqMP0h9+6Upy81RzIiHAg5OjtPawplIWm19+6EOsrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so8526453a91.0
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784380488; x=1784985288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OHdFVzb2lFUOIiNiTi/6Kki8f3MfJfKI4vFmz9yyZr4=;
        b=KJLqhZVB3A0OgeV6wewelP/rSOYRBf7xkXOP1VP6bBVF3rL43VGdYcZUrvg8boLbBI
         ONs/SP5RGOsV21N+6Jk8P11S8yHnid6f/cmgCQmWtFO4Ekypse7EmOyBrzZYi9bRFpt6
         Xm0hbj4QddfrTX57upCuCyl4L6XZSRh+E0c/UDJTHcAOydRubx68opnWgYlNEZqORzli
         4D/2ZdOuvJv3ichFcG3QqwTQ8gkiRd76vNRXPGty/wmbcLq9KPOMxqdE8Kwux5oQqyB4
         hn436pKy8153soOaHYsg62wx5iz3nEHq2/IyxnZhSngLDKXJlIZTvV011qYR0+LfuxmK
         SgWQ==
X-Gm-Message-State: AOJu0YzDpVTz0fiZPhLIaNwN3Vc4nk/wAXRAOmBkZi5alfWVJ7OC6UH9
	1Bw6VDNtlrzQxE/c1SdmTS2mTYJWLFMSg2SvuYOCmV+ZJ8Uy3nwmdno=
X-Gm-Gg: AfdE7cnUaMGBKjIwA8SljUIwY1gW4k7TzJLMiUbZNRXtJTMHZKgOCNkthLPVItFlgUz
	f2fuybE8bjzxvfqnk6ii5aIqqhRxVxhigUmyxRbgrIoKinSmxJuZkM3TlrwxUsKRg4Frl3CZU2E
	yFOhTDKcFSmHTzmr0FLx2tNQNmZRUvYfVv+qlnxi4rJMa56cno5RcHad77+MeNrxiMNLRGDfZ6E
	LJIJQ3dfQO08Q16e9l6sE6Ak40M3nTRAKbfMHBNhgH8jS/3Ul1Jij6NKSfcwJ8hfbA/jfcAilwf
	VtfzubLD8SbQ2QGv8foh7TL2NbZpsobuEVDE9+siSbhQ5AHMJ79I+bS9YmqjCJ6PK2CofA3WFVk
	VrgeMaGf2w4NTOG1xR1jG9bzHB3knpGhWz8aZngSi309IJQod9GCbVXNQ0hRJ+a49QSKE4dUgXB
	DDLoBwFnDd9cSPMrdMVZ/10GDQZLBgdWb17IArFYfrH4htB2vnZ+pWOLPb8as9NVV93FN0zlYyv
	+8G9H0vOA7TMgw=
X-Received: by 2002:a17:90b:4fc3:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-38e4b418a20mr8284246a91.2.1784380487954;
        Sat, 18 Jul 2026 06:14:47 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9bb5sm2706400a91.11.2026.07.18.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:14:47 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v10 3/3] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 21:14:31 +0800
Message-Id: <20260718131431.3393-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718131431.3393-1-fourdollars@debian.org>
References: <20260718131431.3393-1-fourdollars@debian.org>
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
index d50afd408dcf..3c725905d1d1 100644
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

