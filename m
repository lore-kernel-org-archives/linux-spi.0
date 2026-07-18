Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C70233921
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784337885; cv=none; b=lbYNID1iU+It1MDDum9k/Cat3c4UrxPEpD4Uk4lQx70dQSORY7LkPC8VBkMNVghs7K7/tdaYN43zD0BSggoJ6ztoyVzcDVqzFta1I8FGwkUQ4vvpBgUz64zfv9hjGDD2BE+aIqszrE+xtCd81C6mdNecu0cDeWmIcc/Rwl0KBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784337885; c=relaxed/simple;
	bh=l1bq3DsJG4uh3Dv/FLFlUYN0S6aEx5GPltmFWHYKhZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pjrvi/kyHWdz1bhMiAR+KczNmj0XGU4DzPMFldJvub3pOY8Z9OHkud0J33CivZS9XByZ+Zs/hOGv85YtHlKww/a1V0aAXlInVmzpu5aXZ0N7LAnMpJ1dEh8zfHUkvcVJ7K2+HeBQkFQ2jK0RYpPPiqug1QuJwrR8EYY4Ju7o/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso103612045ad.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 18:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784337883; x=1784942683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NLP2sl8iOSAmuo8HaX8ireR2VF4CDnio99UasypdBgw=;
        b=tAwHLZhxSJaTNrb+Vt35pfmbED+VNjDsam9jDDGywqXCAK9uITnrc1C5U7G/E2Eq8r
         ZNubYfAO90ujwFHJl1Ros493duFLVhQJh9Q6glD9u4tg5FE2MFGleo0PJfWKdDjrBS0A
         J4pLI6M2o09V2aTqj0hLOUPUBp/b3F4LLyhBpg0/nNewq49jxihfpj7sFT5c+dKb1DgV
         KVSWqkk7yc/DknMpPjPbaOyBlizDmom4CdLsZlPrPJVVGua4s9pTrMOXBQVi/wwHtTgq
         4InzUGVaSkrfOLm0KslwcGCkzHZ9iiQqjbPN+w0CBzzVBTxykaqD7rMtazoNu7g9piX6
         myNA==
X-Gm-Message-State: AOJu0Yx6e5lUkduDPNaD8/DtNyyPP//b6qIqbtjTY8seTh4AoEyrch5d
	DgAdwfah+zQbRZ7V+/qMfhdmSyEGnLdC4anOfu3nUb//iHhu8kN+kQiVax31f2LTsw==
X-Gm-Gg: AfdE7cmRiJXtoDwBtheu1vLo1YL4LPsxOuYrdxcYpsQ8zPuPy8IU0QYARK3u78Vmwda
	13y6JglwVj/OSRenWhF3LzcUJPiTVwp7+8t6xPAwMy6J7TpRge2LLhxO5O9/v/KA0ZtlgH2rbjH
	wak1MYb0BxTweMeEbfQVu4hM8NmyXCyS4Q3eZhIwtYkZ29PyHGh14gaxd03Nt9XVpr9uRRuupSv
	2kbuG2NM2q+7XX4hQFTE13zwd/1Sw0rlgd8e0vA0v00HmbeTV57H69VsIkfsd7zDOX+9YkPYLpE
	a5bUth9kP3hqnpwnP9sP5tB5Q2If9hIr/6RsfPsUdmDp30/o5D7+PlwAI37jzA8hrlygj2wLF2I
	clRyU2oEAcmVy6DRO63PWFrF2Y9hP2VmX9SHXKCkFs+du1rnl+k92Wi6mv6vQksj1nLpxd9HRz+
	02qVkbzjlLfEhSYHD/Kt1lehQsxJYIj3JevRlK1abFSDjeHmkE5u7EwW/8K9bF8gFQD5/am7NOC
	cP7fdx8uEBFeDmhJs3205437g==
X-Received: by 2002:a17:903:40cf:b0:2cc:76fd:6537 with SMTP id d9443c01a7336-2cf34835f12mr57215675ad.2.1784337883075;
        Fri, 17 Jul 2026 18:24:43 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bbe50sm19617685ad.27.2026.07.17.18.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 18:24:42 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v6 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 09:24:31 +0800
Message-Id: <20260718012431.3443-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718012431.3443-1-fourdollars@debian.org>
References: <20260718012431.3443-1-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx.c | 89 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1ba239d28d74..427342bdd5f2 100644
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
@@ -1554,23 +1583,63 @@ static int pxa2xx_spi_resume(struct device *dev)
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
 	status = spi_controller_resume(drv_data->controller);
 	if (status) {
 		drv_data->suspended = true;
+		synchronize_irq(ssp->irq);
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

