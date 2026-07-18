Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D0348C5E
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355076; cv=none; b=WeyzRxykhkPX+ba57Z8mN4rwFeSjF3h3C36AhD07cI+wr4QdfgWaMfR2ACRXxk4eKWQAp68CvBc0+RKMGTzzVH7VQcbf9LAvxulh5aXFJtkP3G3eq67W+Jhq+EQR/6cS6QiP1F0GckRwBCrkNe9uu7SleOfXZsGd+dg2Nzm3gDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355076; c=relaxed/simple;
	bh=qV/p2+XkNVwVkJSEt92jFP9tfNk6pbvI/hvveSN3nZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKJlP6sKLjv3vpG0iiRCO3nTmqFzIbc/uPSDetAu2IpIeuUFbLZQAyDTMN1qcnckLORKdlWDivaIT8Zj0J3DycCD5XkMxRpWQ0AFcRqjqgeYhIfRO5Oiad3gsdBmvm/awr/95lJWNlsUoS+7VtAj6u64cY79aTY6OE2o6YiC4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cad4170e8eso112156745ad.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 23:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784355074; x=1784959874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8Rq1JpfQ8zra8E3axpyRApcqas+zAJicSHtMtGOCGg=;
        b=X2WyB3wwSxNsRVBydV8Lm1t4NhgdlhzSb6HLDTjVfQSXL0vPP53O4kdzoRuiVftYAm
         rWOY7bFn2E6JEEYeeT/KPuCvNXeXqS4Evmg+pzrgoDfCjjHCEdbfScL631yEWDnEkVd5
         imLJnos/BkE6k3VYfVEMyTZxSvsBlV4RXgfhGLIxyKfcIa5VT0j9zjTY58uqMFiGErO3
         J6yeZZUs3CmI3qRqZojqtSk12TmJIf7OlioNcr3OyfsXqaLD694pQ+QJnL5uKwLybKnv
         I435i5zwlmTYJM+JpoxvtjEld3q3qYKsC19ah0Eu1qxsP2YsNzPNPajqaFdHUJCu071n
         +CMg==
X-Gm-Message-State: AOJu0YyZGLEONDLkwTx9tjXD8+QdTr2dLkg2eETS2q4P2bpfo63W2du0
	1YjChjIUKmw/UInvvM5/1t5yhYwp3r8Rp2i0VViFXEauL3IJDH34NNEktJLgFP05xg==
X-Gm-Gg: AfdE7ckzifFjRMwlbE7dhDhf59y+AKO4tObHOqUlrY6r8NRJ3LtJxU3ZReh6aE3Mc7F
	00P7fxtO7vdTJf1q7lwh011otKgtea38RRKL5VugyuDl/4ka1JeIloDydd5EzkCtpnldC+UgzXO
	YlypSmbAxenNz+eKijhXwFWjDWouDtfeSCtlrT8At/r1rBPruA9Oj6xF0FbYtMTMWTaktew5jiF
	dekPn1jwJYBAYx41QKMfyQLnQQHf3jYAe9C8+qozDozl6lCKVsvrCoHK1J4PoxmUZPcGnUVBDLI
	AzfRit9vJq1OSsUFGtqgv3qOLmib4H3JWk+qBeyQFYnapAus2S4usnHWP7N0mQyW239HymR68JJ
	DwCmRw9WvOe7Cf5I8evglksCpS8fQ43RhNFb6TvQHt2dVzfDjrVWTnuJkzSkkoOsleN0HG8RDZH
	u1n9x5EoT1xrpOVXPVcWbC0MtzGWnvJ0R67XcPCmrcGGzEcTyI0si8bep2sCgMncnurJ29uay9V
	6x9VS4kEqWvemlt4X86JeMIdw==
X-Received: by 2002:a17:902:e752:b0:2cc:85a7:36ee with SMTP id d9443c01a7336-2cf349910d3mr61240535ad.32.1784355074379;
        Fri, 17 Jul 2026 23:11:14 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db04csm22799025ad.42.2026.07.17.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 23:11:13 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v9 2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
Date: Sat, 18 Jul 2026 14:10:55 +0800
Message-Id: <20260718061056.30961-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718061056.30961-1-fourdollars@debian.org>
References: <20260718061056.30961-1-fourdollars@debian.org>
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
  put_noidle()) to LPSS controllers via is_lpss_ssp(), preserving
  autosuspend for non-LPSS SoCs.
- Track clock state using drv_data->clk_enabled in helper functions
  pxa2xx_spi_clk_enable/disable() to prevent clock count underflows
  on error paths.
- Protect ssp_int() using drv_data->clk_enabled and drv_data->suspended
  flags to avoid unclocked MMIO reads and level-triggered shared IRQ
  storms.
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
 drivers/spi/spi-pxa2xx.c | 161 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-pxa2xx.h |   3 +
 2 files changed, 125 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..4491ae0ee8ac 100644
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
@@ -713,22 +718,42 @@ static void handle_bad_msg(struct driver_data *drv_data)
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
 		return IRQ_NONE;
 
+	active = pm_runtime_get_if_active(drv_data->ssp->dev);
+
 	/*
 	 * If the device is not yet in RPM suspended state and we get an
 	 * interrupt that is meant for another device, check if status bits
@@ -737,7 +762,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
-		return IRQ_NONE;
+		goto out_put;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
@@ -750,7 +775,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		mask &= ~SSSR_TINT;
 
 	if (!(status & mask))
-		return IRQ_NONE;
+		goto out_put;
 
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
@@ -758,10 +783,19 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
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
@@ -1288,6 +1322,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true; /* Start suspended until clock is enabled */
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1330,10 +1365,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
-			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
@@ -1351,10 +1382,22 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		}
 	}
 
+	if (!platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
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
@@ -1434,26 +1477,33 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
+	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
 	/* Register with the SPI framework */
 	dev_set_drvdata(dev, drv_data);
 	status = spi_register_controller(controller);
 	if (status) {
 		dev_err_probe(dev, status, "problem registering SPI controller\n");
-		goto out_error_clock_enabled;
+		goto out_error_irq_alloc;
 	}
 
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
+	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
+		pm_runtime_put_noidle(dev);
 
 	return status;
 }
@@ -1466,16 +1516,26 @@ void pxa2xx_spi_remove(struct device *dev)
 
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
+		pm_runtime_put_noidle(dev);
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1490,10 +1550,10 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 
@@ -1504,29 +1564,52 @@ static int pxa2xx_spi_resume(struct device *dev)
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

