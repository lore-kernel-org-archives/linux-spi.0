Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F922A80D
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383250; cv=none; b=Y58XarFgAJZGh9PDb4WUY8dcSVr0r6tXH94F7Qzo0SHtvl1cvSLxyuD52vAD1FnzzVJGlQ1a+AM63BbHXEv3HWhsH2hBP8V5Dqd4NNCp4IO67JcgV3qqejdoFR/WabJp5uxFKJzlNlTlNkNHtTkTldbryssQj5q9QZraYP1WfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383250; c=relaxed/simple;
	bh=tDlVSsVqNbieKlyczNpsnz0R5D5oDLSOtarrtWuaDAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw3mgf3noCzIFpUyx9bi4D+j+aMXYNZmJrG94WG0lAmZu4yEyL7W5G8PnnP1faIubut7xl2XDUu5yTji2hzZPgsRzLcYuRw5t0ImyKEy9LWTUA2RYS7l+MNlCnSU6bhwWNPgMP+Q94Blp/lBNN5gut2jHlry7z1SkbIwEFSamio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so4484240b3a.3
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784383245; x=1784988045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SaUb3joMwOU8IGzXidt3GoCyQrxG1SYl6RBSHbchEh8=;
        b=jZNaQdLsW/FHK5pgeeMNzaPKRwYmRMB/geCHpS7WunxWzYAQb+okxDooRRrVwnA+4/
         po0iWvJy8Tq4IA92RehOpuS9e28Ew9f//8w7jgStGEANUd++TyF/DonpfhTmu4LG0+fx
         Qpw2A9cvl3t1vVLaTf64wNhbi5zPCRrtoWmimogbs32KWe9d8k3nZouu4uXEeh4TkkUR
         m/HIvq2U2bTd8/GUs1zIv3Cbe118AAMpgQPjNIbu1j5tvYDAf/PtpQ55vGzJfTbHZhAu
         28uLnPr7YjPcTL3woBzrjvIp0pvJIISK2y4DxBVqgLe2ENua5OJ3DnJnbFG23l9oxuQd
         dW4A==
X-Gm-Message-State: AOJu0YzW6SQszIWl4lvpVlDTDQAPfR1PxZUB0H4VQfW3WIuZlsDUvZFb
	5II0GXewAbXuZvxD3aJNIOiGq3RAYBeuyJBxyZfS2QWQXQaL393z68/WOR2RroL9SQ==
X-Gm-Gg: AfdE7ckLB+1Th6gEbUE/WpvfPLvc36yyhDo7zFbOaxYaZHh520qAlE1zX14Jw1mmu6J
	2W/fTkilH31L/RG4cWxwYwCWC7o90NMezw/XmcfnrnXW1JreV1jqDnRpawG0vMn+OFsIh4OYUTv
	GO+k1NY1wRVfyfl95CRm8eP28YlxMmEvp/fHl9hvarHthUingIXgLi3ROKpU/GYRfQjk9X3MeNH
	aDS7u74lxBu/lE1XihT4BxrIvLkQO5jWFZG9frxyD7iNxRcag21s/VBGdS8O3f2hMNQ0lN2DaNK
	jpExvxoQhWUzQtlxWrO5y3evLGM8j0p+AVCYxzR4CMNAITC1ywNSBbToOVZCpgtYr3PeVcP9kVl
	bXsqxFbmjZfy5tdfA+NUjt/Nd4XdrG1aghGtxvDVnoN9jg8TgKBiXi+jBwl5TyaW80iKnI5b3/o
	fmx/BXMUWBhokcvJAWThaP1Sthkb8MMSDlOv0nUupSYCTBeohr6Tq8LMP1R2kKCx5DFxtrmR3BN
	zTULK2RV1FonNU=
X-Received: by 2002:a05:6a00:3a2a:b0:845:e04b:565f with SMTP id d2e1a72fcca58-84c292634e4mr7624262b3a.14.1784383245345;
        Sat, 18 Jul 2026 07:00:45 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6ea1csm2816890b3a.49.2026.07.18.07.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:00:44 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v11 2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
Date: Sat, 18 Jul 2026 22:00:36 +0800
Message-Id: <20260718140037.4299-3-fourdollars@debian.org>
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

When operating in PIO mode on Intel LPSS SPI controllers, runtime PM
autosuspend clock-gates the hardware block, causing PCIe Completion
Timeouts on subsequent MMIO accesses.

To fix this:
- Scope PIO mode autosuspend lockout (pm_runtime_get_noresume() /
  put_sync()) strictly to LPSS controllers via is_lpss_ssp(), preserving
  autosuspend for non-LPSS SoCs.
- Acquire pm_runtime_get_noresume() exactly once in pxa2xx_spi_probe()
  after spi_register_controller() succeeds, and release it via
  pm_runtime_put_sync() in pxa2xx_spi_remove(). Using pm_runtime_put_sync()
  ensures the runtime PM state machine transitions to RPM_SUSPENDED upon
  driver unbind, preventing active child count leaks on the parent LPSS
  power domain.
- Track clock state using drv_data->clk_enabled in helper functions
  pxa2xx_spi_clk_enable/disable() to prevent clock count underflows
  on error paths.
- Protect ssp_int() using drv_data->clk_enabled, drv_data->suspended, and
  checking pm_runtime_get_if_active() == 0 to return IRQ_NONE immediately,
  avoiding unclocked MMIO reads and level-triggered shared IRQ storms.
- Register IRQ in probe only after enabling the clock and clearing
  suspended.
- Overhaul pxa2xx_spi_remove() teardown sequence: disable SSP hardware
  IRQ, set suspended flag, synchronize IRQ, free IRQ, and disable
  clocks.
- Guard MMIO access in pxa2xx_spi_runtime_suspend() with
  drv_data->clk_enabled check.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 158 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-pxa2xx.h |   3 +
 2 files changed, 122 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..317e2c24ae67 100644
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
@@ -713,20 +718,42 @@ static void handle_bad_msg(struct driver_data *drv_data)
 	dev_err(drv_data->ssp->dev, "bad message state in interrupt handler\n");
 }
 
+static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
+{
+	int status;
+
+	if (drv_data->clk_enabled)
+		return 0;
+
+	status = clk_prepare_enable(drv_data->ssp->clk);
+	if (status == 0)
+		drv_data->clk_enabled = true;
+
+	return status;
+}
+
+static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
+{
+	if (drv_data->clk_enabled) {
+		clk_disable_unprepare(drv_data->ssp->clk);
+		drv_data->clk_enabled = false;
+	}
+}
+
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
 	u32 sccr1_reg;
 	u32 mask = drv_data->mask_sr;
 	u32 status;
+	int active;
+	irqreturn_t ret = IRQ_NONE;
 
-	/*
-	 * The IRQ might be shared with other peripherals so we must first
-	 * check that are we RPM suspended or not. If we are we assume that
-	 * the IRQ was not for us (we shouldn't be RPM suspended when the
-	 * interrupt is enabled).
-	 */
-	if (pm_runtime_suspended(drv_data->ssp->dev))
+	if (drv_data->suspended || !drv_data->clk_enabled)
+		return IRQ_NONE;
+
+	active = pm_runtime_get_if_active(drv_data->ssp->dev);
+	if (active == 0)
 		return IRQ_NONE;
 
 	/*
@@ -737,7 +764,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
-		return IRQ_NONE;
+		goto out_put;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
@@ -750,7 +777,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		mask &= ~SSSR_TINT;
 
 	if (!(status & mask))
-		return IRQ_NONE;
+		goto out_put;
 
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
@@ -758,10 +785,19 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!drv_data->controller->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
+		goto out_put;
 	}
 
-	return drv_data->transfer_handler(drv_data);
+	ret = drv_data->transfer_handler(drv_data);
+
+out_put:
+	if (active > 0) {
+		pm_runtime_mark_last_busy(drv_data->ssp->dev);
+		pm_runtime_put_autosuspend(drv_data->ssp->dev);
+	}
+
+	return ret;
 }
 
 /*
@@ -1288,6 +1324,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true; /* Start suspended until clock is enabled */
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1330,10 +1367,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
-			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
@@ -1352,9 +1385,18 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	status = clk_prepare_enable(ssp->clk);
+	status = pxa2xx_spi_clk_enable(drv_data);
 	if (status)
-		goto out_error_dma_irq_alloc;
+		goto out_error_dma_alloc;
+
+	drv_data->suspended = false;
+
+	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+			drv_data);
+	if (status < 0) {
+		status = dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
+		goto out_error_clock_enabled;
+	}
 
 	controller->max_speed_hz = clk_get_rate(ssp->clk);
 	/*
@@ -1434,7 +1476,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
@@ -1443,17 +1485,22 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	status = spi_register_controller(controller);
 	if (status) {
 		dev_err_probe(dev, status, "problem registering SPI controller\n");
-		goto out_error_clock_enabled;
+		goto out_error_irq_alloc;
 	}
 
+	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
 	return status;
 
+out_error_irq_alloc:
+	free_irq(ssp->irq, drv_data);
+
 out_error_clock_enabled:
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
-out_error_dma_irq_alloc:
+out_error_dma_alloc:
 	pxa2xx_spi_dma_release(drv_data);
-	free_irq(ssp->irq, drv_data);
 
 	return status;
 }
@@ -1466,16 +1513,26 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
-	/* Disable the SSP at the peripheral and SOC level */
+	/* Disable SSP interrupt generation on hardware level while clock is active */
 	pxa_ssp_disable(ssp);
-	clk_disable_unprepare(ssp->clk);
 
-	/* Release DMA */
-	if (drv_data->controller_info->enable_dma)
-		pxa2xx_spi_dma_release(drv_data);
+	/* Mark as suspended to prevent further IRQ handling */
+	drv_data->suspended = true;
+
+	/* Wait for any pending interrupt handlers to complete */
+	synchronize_irq(ssp->irq);
 
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
+
+	/* Safe to disable the SSP clock now */
+	pxa2xx_spi_clk_disable(drv_data);
+
+	/* Release DMA */
+	if (drv_data->controller_info->enable_dma)
+		pxa2xx_spi_dma_release(drv_data);
+	else if (is_lpss_ssp(drv_data))
+		pm_runtime_put_sync(dev);
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1490,10 +1547,10 @@ static int pxa2xx_spi_suspend(struct device *dev)
 		return status;
 
 	pxa_ssp_disable(ssp);
+	drv_data->suspended = true;
+	synchronize_irq(ssp->irq);
 
-	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
-
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
 
@@ -1504,29 +1561,52 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
-		if (status)
-			return status;
-	}
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		return status;
+
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_setup(drv_data);
+
+	drv_data->suspended = false;
 
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->controller);
+	status = spi_controller_resume(drv_data->controller);
+	if (status) {
+		drv_data->suspended = true;
+		synchronize_irq(ssp->irq);
+		pxa2xx_spi_clk_disable(drv_data);
+		return status;
+	}
+
+	return 0;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(drv_data->ssp->clk);
+	if (!drv_data->clk_enabled)
+		return 0;
+
+	pxa_ssp_disable(drv_data->ssp);
+	drv_data->suspended = true;
+	synchronize_irq(drv_data->ssp->irq);
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
 
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int status;
 
-	return clk_prepare_enable(drv_data->ssp->clk);
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		return status;
+
+	drv_data->suspended = false;
+	return 0;
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(pxa2xx_spi_pm_ops, SPI_PXA2xx) = {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 447be0369384..44f37bf9c519 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -72,6 +72,9 @@ struct driver_data {
 
 	void __iomem *lpss_base;
 
+	bool suspended;
+	bool clk_enabled;
+
 	/* Optional slave FIFO ready signal */
 	struct gpio_desc *gpiod_ready;
 };
-- 
2.39.5

