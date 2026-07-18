Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED52C3757
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388793; cv=none; b=c9hxHNF30PmuFgbAROrVJH0iUfV2XNVFvKvSVbDKhtE+TspacPgOZsJFNPWgAf4idmRPzChD2hYK7Kisz/5b/oeFUauDZASTK0T8WM3v7HuTCApc5f5RaPWOrf9VTi7Pi/9HzSMYqDND61kt+K+F79kRd24vacK99Jmlfs0pyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388793; c=relaxed/simple;
	bh=hoX/TWo6r/94eyI3ahhuk2BDP1Nd7ZgqQk6yVk0sUDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5UB+fPXvoJOIxcZdrjf6uX3kLcVqwq7BOJOB8l7qeKAQiBkotYBGyMdFZlfObuoyR7iOqSTi+vJSS0/HuMmy05SqD+LpAFPk4jXQZEZAeeAcSQ/pJTOVvyx9SezsapLOjD/BPWBg8cQfpMXE/gjRNaerIclZZ5V3N+WAbZ6fsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc73e322dbso105127565ad.1
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 08:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784388781; x=1784993581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+m7QRADgnNK6LEYYEyJLdDHpqpIoQWfFeq6ZiuFaq8=;
        b=C6fEo0yKk/76FXoRATnFwMLWhMytOCaiN0l6hAnx5oDH6ikNVaEWqxg6q2uQ+Bs+E5
         lwNanASQ0G5wJO5jUYsgPR9Y25/dnF0JwLfctrOiIIKnEIzM/EkYTLh9xJroQM2I5CxJ
         tKpkvG42KazTdzoBaQhNk+kz1+th1qluQ7CXjWIPHIdazGur5lPoSXq4vKyfygk3HQMU
         JEMmBEUyBPaHCj28mO10OM5f8KweELbLiMdq8NgMQ88VSXumvI8xkQlOElIQnRXqersy
         wZsEKI48c9DwfbkadOe3UiRqTZ4YSlVWFa5r6MYXuGRIIZPmXGA9j1J1hHYLEJ2i1Opi
         TbMg==
X-Gm-Message-State: AOJu0Yy4+oudChEq02TvT9vV6svGCz6OOHlnrnx0QDkPY9/uwF/gjCQv
	lJdu2k24/0utXgiUzKWIl/jEkC1NAo6A1sXj8aN0OGIHm+BSo2wtnoo=
X-Gm-Gg: AfdE7cn2E55RVOYMr0IgLK0vUeoG36awMWRkQf2jeFl++HDibVIW4QKJdoUmHKLIzHG
	KfJvHhqfYQEK0JBKPSwFgLgey3tRfkREWcnfKm7HQ+KL4raaMhT2BDYnOlyvfBWCFrYXCKs9nLJ
	CyV0Yy+EUI2DXm885kt/AjTuldYPzrUVYb3D9/iH//SzjXPUxBv0y+boMbBiB+5v+DB7zcWbNx1
	o6BiK67ZCn0rZF2PNmhNn2vrHrVax4yxJSRYmq0wqNdF1fNEyygPnOzu4WQFgwT/RpeZGsJxFiy
	RNCO4KeyZOvu61X0S95EmmaUmektrdYq4vCGxD7+L0LLo8QxE4+SZKvPOXQo/HBN8ZN7pBEzgye
	Y7mRzYVrdX/fV3lesiEmk9q8FuVvfjbVqMLu3VRvZZ4oDk4o2j4IU/JnXrj6hDewugWzjHRT8Wy
	f41SXYuwzCnFHLb4mqnZFMzabE0r8RWA1UvC/0cadscoZ5mfNXaVhpJvPYbLBqxAS5fLM2CWq5j
	pdXWWiqdeeF5eo=
X-Received: by 2002:a17:902:f70d:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2cf349b8d41mr77809585ad.28.1784388780771;
        Sat, 18 Jul 2026 08:33:00 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bd3aesm28731535ad.26.2026.07.18.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 08:33:00 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v13 3/3] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 23:32:51 +0800
Message-Id: <20260718153251.7353-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718153251.7353-1-fourdollars@debian.org>
References: <20260718153251.7353-1-fourdollars@debian.org>
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
index 443800bffbeb..864b9ca61bb2 100644
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
@@ -1532,16 +1544,46 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
@@ -1554,12 +1596,47 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (!pm_runtime_suspended(dev)) {
 		status = pxa2xx_spi_clk_enable(drv_data);
 		if (status)
-			return status;
+			goto out_put;
 	}
 
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
@@ -1568,10 +1645,15 @@ static int pxa2xx_spi_resume(struct device *dev)
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

