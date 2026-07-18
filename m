Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490425B0A8
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340568; cv=none; b=CUG68RufRKdyMztqVIT34nOPpeE8kUTANoAv7XDFpNYknuvgsqY096vij9+qk4bJCaotSNaQKPsjYSXX0p6pumOhC1dj9lXXBBn1FCs0vVEQarqpdiSAgXgQqZ5yH//8+b8INkmP6ilzlbHfALATJ+JfuT4C6gceHdTYQlHx6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340568; c=relaxed/simple;
	bh=qedcgrYftvdHdRtsvjV6gG9t6NdrpvhFn7QIh2ApED0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrQMIjK+sEo0Y0CQldajarEhobldDe0gDV39arzib9Su07rThwCAfXFt0lNUb5BaRDWbAqAewwwD1BSKbb6xDB7QyjJWJukrG5tvsYqqSosUqbMVPmgHUX7KD9VG7Q81yrgFfyznmn7HbqIcW9Y1VCa1/+eJQnboQmLKNmd+uAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf27856f9cso26237325ad.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 19:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784340566; x=1784945366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U/RNnx2ny7OdJmA6vweE3/R7vIimduxmFjYsAxBy2Xw=;
        b=hlEaZgbmiiKrmnJVaMg5w0Seab/9cEHhNStHKruF8rrIqRHQYEgt4e+CKVYHoBYyPA
         0UZJTLOzcBHo6XABs9VQPQmTzXPZ4Ix2p6UoiKfVbUD9Yw3a5ymbK1iSxDbVeb0ijcvs
         YPfsV0sme72DxuqSxuRtxnbuyxqpzQGV1rFw6M5ytBIU46qwF2rdFuW1LVllIYHWHq8i
         k/Eix1Indf4bhaZT08METh0uD+tS7d18Q/TzQA3QBIt3CNb2OkMs4wPpPAuMPMvfYm1T
         /6RQ6IJANKwmJUgocnYMxcWCezY3UhBmzuSvw51FweqzGG5tN4XporWL+8KXSz9zdKcX
         pKDg==
X-Gm-Message-State: AOJu0Yz63Ag7g543gjjnrulKx2GiWtQXZ0I9t537o+s9AajM3bEIq+wT
	8sJq4AkvNqDemnUSH4F8qoCdrnM+B1xz1dRlyz1SQbhUDNxJJNrsWhtGOkLi31/SWA==
X-Gm-Gg: AfdE7cmBKZdU3vo9eWZjTaE3/hoZ5LhGmbCf+7Ukyj7v+U1/04pWn0aX4SbHyLu4WxS
	hfsQbp2LvJ3z56Lo/7zIJt1FH/xxkwKvJvdu2LZVdVOmF6ciBQA352o0p+aTgTegXw4++H/dqJm
	j7DpaKXuLdEfYlUowNaWoIu0WTbwQVukCUhU13/Y84k4nLRT9qAw4zySRi2JEV5tHcQ65Xdb76M
	W9UgLDkVhOg6rAzAXzbh65yEFLg6UypZyIG87RIRJYSqZuRBtmlc35ruh4pi32DrO8W3Rlwm6FU
	oRZCMMciPmilveCj7id16EwttmI/aNYroWHcYieeaUsQgtJZJCgU+k91o4dEvTz4RbPwmp4mN4I
	ZLxt9gWtmZuPdZMmGNguwgYPSxQPsLdaGJDo6pxJA96K94FhAYN8tX6Si2iI7MvvoZCrXz3DcQR
	W6Z3B43AxY0Owbb36N6qsPLbiieYbWHu0nVbbtYTgz9Nf2y02X8HiYAR0skbQgQtitAi2B2c4X5
	D57n0frZwFbCfw=
X-Received: by 2002:a17:903:3c4e:b0:2cc:9179:335 with SMTP id d9443c01a7336-2cf3481b661mr54746865ad.8.1784340565829;
        Fri, 17 Jul 2026 19:09:25 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db036sm20412855ad.46.2026.07.17.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 19:09:25 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v7 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 10:09:15 +0800
Message-Id: <20260718020915.8193-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718020915.8193-1-fourdollars@debian.org>
References: <20260718020915.8193-1-fourdollars@debian.org>
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
  This also ensures that the unconditional MMIO register access in
  pxa2xx_spi_suspend() (specifically pxa_ssp_disable()) is safe from triggering
  PCIe Completion Timeouts.
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
- Revert drv_data->suspended to true and call synchronize_irq() on
  spi_controller_resume() failure to ensure subsequent interrupts do not
  attempt register reads after the clock is disabled.
- Add spi_controller_resume() recovery to the error path of
  spi_controller_suspend() in pxa2xx_spi_suspend() to prevent the controller
  from remaining permanently disabled in the event system suspend is aborted.
- Store the saved context in drv_data->lpss_priv_ctx[6] (inside struct
  driver_data) which is private to the core driver.  This avoids changing
  the layout of struct pxa2xx_spi_controller, preventing ABI symbol
  version mismatches with uncompiled platform drivers (e.g.,
  spi-pxa2xx-platform.ko).

On resume, de-assert resets first, restore all other saved registers,
then call lpss_ssp_setup() to re-initialise CS.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 93 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c252d19a1e8d..c3a59fe58f19 100644
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
@@ -1362,6 +1367,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
+
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
@@ -1541,19 +1547,45 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
+	/* Mark as suspended and synchronize IRQ before disabling clock */
 	drv_data->suspended = true;
 	synchronize_irq(ssp->irq);
 
 	pxa_ssp_disable(ssp);
 
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	if (is_lpss_ssp(drv_data)) {
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
 
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1563,12 +1595,46 @@ static int pxa2xx_spi_resume(struct device *dev)
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
@@ -1577,10 +1643,15 @@ static int pxa2xx_spi_resume(struct device *dev)
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

