Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB227BB5
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340565; cv=none; b=S8+r0H6YqIkAg1S9Jlpw/rW/AofScGxwcfLjfQUyltYHIADOL8ZidNOQWfM+xtwSArvS9xmMyZVXDggLO6hBqM2Le6mKVNPHevIsHuXj4YcGcICtAqw8ooxLjaYt7Myga+ZzY9wxQUkhGiwUmygxe1zTM1E9OGK/SU3yk9vyQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340565; c=relaxed/simple;
	bh=QHevhnWjjMW/csxFdHUIwalYo0l7IADIWSlof4PgDVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZulIAQzS+HAEAmMec12t7xRfIRdUKTz6H0M/cn7TKYSynKgdAIN7yw7hkfF+G2O1d5nViv/w4rUJRNhaW+Y2drMTOc1d7ZQfeqws51XGzd1SFjk1fmjVVpznCIlUBU8HneH4Q4yfPRZWvy1sv4zjARfnoYEvKsJ6TpHenilEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so84823205ad.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 19:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784340564; x=1784945364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFUjx71JL+QoHGF5If62CSaoeSBUO44Cle9D/SSujYs=;
        b=rpVqr+7eI6Feu9Ejfm7+WbXhxyQvz4zW93UEJYf3qx2chEjBAZcucWr9HKxh8YYbE0
         ADets3GMyTPjTfnUq03cquz+GJNV+PNI8QrD6gEh59B8VvZqEvQq9WhnhbBlbI+qKWG9
         OrfR/ArEerfNB7T11q72Pc+7Gv3ccBGgSNyQoL9JeensDcNROeVUMID7xPx5eh7jvU+Z
         tn2tGsrQqnvQgw40fQBe/rnL+qg4hnOxPW6fdbvdmZkJeLkH7Fi+KpdccSHv3no7OtFP
         8FxnvI51Bfgiuo32RiyLlLqlZ5teArGplZj+mZoodmq3dOEBBFdPyBlZ/FfWDhusy4EP
         r90Q==
X-Gm-Message-State: AOJu0YxMCy3K2j8kqNmOMvErbtDP7vlcjJei+FdLzOJwsU1taXmEDSUI
	RfTURXwZgqvk0ZGOgA6EUc/hyaNAmI+hroIGh5HDcmRx2K2QZxQj5Zce1YLHTpdDVw==
X-Gm-Gg: AfdE7cnbao4f9B1XBQYIBUpL/9IBFSIL36xDweiV28AxLxaV6fucmgJ9MWasY7XVSaP
	oHaQjN9mFkfIRnykDMdIvNMIEACKep/tFFbJyhdhwbFmRQIXr1Zayy2TNi1Wd/ymmFvjbSaIpNU
	WSajteJ38o5a3pToZm8CL3iTDKLhChmtcXgsNqY7BKUnEg7vPd8ot953GU9x0tqYkLvqiAc/N8M
	SUXO3UjfgrZnSqs4oqIucllASiRz162XXhmrrhpb6fnoZ4j9SK0Rg8S/giYP2fxMykBWn4jhz5a
	aCIJwIBVuouhnzUIYYVbCSGOySw4002nGaNe/Oi8eHdcHWUf89SK7qRKhZ7Xe6vH9cr7sqMbH21
	u1z7hnRxdPXZoJd/3Q/+6YDQCxQRWa1nOm4+e98xSGRhYK/TBhc2xjgJa+6GzSfcXSsrFbZxWbg
	4wCDORK9Up6SyxZs9j8VpR8NGw39gNOCW1slhYFlcCAbV1eZDTy7EyItEk7W1Pejr3eUx9BvA2L
	9O0C6jThJ0s1pg=
X-Received: by 2002:a17:903:1b03:b0:2ce:d957:59c6 with SMTP id d9443c01a7336-2cf349bbf7fmr53137205ad.30.1784340563537;
        Fri, 17 Jul 2026 19:09:23 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db036sm20412855ad.46.2026.07.17.19.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 19:09:23 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v7 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Sat, 18 Jul 2026 10:09:14 +0800
Message-Id: <20260718020915.8193-2-fourdollars@debian.org>
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

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 has two related problems: DMA handshake/interrupt routing fails,
and runtime PM autosuspend clock-gates the LPSS block, triggering PCIe
Completion Timeouts.

Move the force-PIO DMI quirk to spi-pxa2xx-pci.c (the LPSS host controller
driver) to avoid layering violations in the client driver.

To prevent the PCIe Completion Timeout crash when operating in PIO mode:
- If DMA is disabled (either statically via the DMI quirk / module parameter
  or dynamically due to channel exhaustion), call pm_runtime_get_noresume()
  in pxa2xx_spi_probe() to hold a runtime PM reference, and release it via
  pm_runtime_put_noidle() in the remove/error paths.  This keeps the PM count
  above 0 and permanently locks the device out of autosuspend, preventing
  userspace tools (like PowerTOP) or udev rules from overriding it.
- Implement helper functions pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable()
  to track clock state via drv_data->clk_enabled, preventing clock disable
  count underflows and framework warnings on resume/autosuspend error paths.
- Check device status in the shared interrupt handler ssp_int() using
  pm_runtime_get_if_active() and drv_data->suspended. If the device is
  suspended, suspending (RPM_SUSPENDING), or clock-disabled, ssp_int()
  immediately returns IRQ_NONE to avoid reading unclocked MMIO registers.
- Reorder pxa2xx_spi_probe() to register the interrupt handler (request_irq())
  after the device clock is enabled and the suspended flag is cleared. This
  prevents an early shared interrupt from asserting and triggering an interrupt
  storm before the clock is active to allow clearing it.
- Overhaul the driver removal sequence in pxa2xx_spi_remove(): first set
  drv_data->suspended to true and disable SSP hardware-level interrupt
  generation (pxa_ssp_disable()), then call synchronize_irq() to wait for
  in-flight interrupt handlers to complete, free the IRQ, and only then
  disable the clocks. This eliminates both post-clock-disable MMIO accesses and
  unhandled shared hardware interrupt storms.
- In pxa2xx_spi_runtime_suspend() and pxa2xx_spi_suspend(), set drv_data->suspended
  to true and call synchronize_irq() to wait for any active handlers on the
  shared interrupt line to finish before disabling the clock.
- Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
  enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c |  37 ++++++++-
 drivers/spi/spi-pxa2xx.c     | 143 +++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h     |   3 +
 3 files changed, 148 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..79642fd811a1 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -18,9 +18,14 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
+#include <linux/dmi.h>
 
 #include "spi-pxa2xx.h"
 
+static bool spi_pxa2xx_force_pio;
+module_param_named(force_pio, spi_pxa2xx_force_pio, bool, 0444);
+MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI transfers. ([0] = disabled, 1 = enabled)");
+
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
@@ -93,6 +98,34 @@ static void lpss_dma_put_device(void *dma_dev)
 	pci_dev_put(dma_dev);
 }
 
+static const struct dmi_system_id pxa2xx_spi_pci_dmi_table[] = {
+	{
+		.ident = "Apple MacBook8,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook8,1"),
+		},
+	},
+	{ }
+};
+
+static bool pxa2xx_spi_pci_can_dma(struct pci_dev *dev, bool verbose)
+{
+	if (spi_pxa2xx_force_pio) {
+		if (verbose)
+			pci_info(dev, "Forcing PIO mode (disabling DMA)\n");
+		return false;
+	}
+
+	if (dmi_check_system(pxa2xx_spi_pci_dmi_table)) {
+		if (verbose)
+			pci_info(dev, "MacBook8,1 detected: disabling DMA to force PIO mode\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
 	struct ssp_device *ssp = &c->ssp;
@@ -166,7 +199,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev, true);
 	return 0;
 }
 
@@ -238,7 +271,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 8;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev, true);
 	return 0;
 }
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..c252d19a1e8d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -713,20 +713,42 @@ static void handle_bad_msg(struct driver_data *drv_data)
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
+	if (drv_data->suspended)
+		return IRQ_NONE;
+
+	active = pm_runtime_get_if_active(drv_data->ssp->dev);
+	if (active == 0)
 		return IRQ_NONE;
 
 	/*
@@ -737,7 +759,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
-		return IRQ_NONE;
+		goto out_put;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
@@ -750,7 +772,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		mask &= ~SSSR_TINT;
 
 	if (!(status & mask))
-		return IRQ_NONE;
+		goto out_put;
 
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
@@ -758,10 +780,19 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!drv_data->controller->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
+		goto out_put;
+	}
+
+	ret = drv_data->transfer_handler(drv_data);
+
+out_put:
+	if (active > 0) {
+		pm_runtime_mark_last_busy(drv_data->ssp->dev);
+		pm_runtime_put_autosuspend(drv_data->ssp->dev);
 	}
 
-	return drv_data->transfer_handler(drv_data);
+	return ret;
 }
 
 /*
@@ -1288,6 +1319,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true; /* Start suspended until clock is enabled */
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1330,11 +1362,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
-			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
-
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
@@ -1351,10 +1378,22 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
@@ -1434,7 +1473,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
@@ -1443,17 +1482,23 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
+
+out_error_pm_forbid:
+	if (!platform_info->enable_dma)
+		pm_runtime_put_noidle(dev);
 
 	return status;
 }
@@ -1466,16 +1511,27 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
-	/* Disable the SSP at the peripheral and SOC level */
+	/* Mark as suspended to prevent further IRQ handling */
+	drv_data->suspended = true;
+
+	/* Disable SSP interrupt generation on hardware level while clock is active */
 	pxa_ssp_disable(ssp);
-	clk_disable_unprepare(ssp->clk);
 
-	/* Release DMA */
-	if (drv_data->controller_info->enable_dma)
-		pxa2xx_spi_dma_release(drv_data);
+	/* Wait for any pending interrupt handlers to complete */
+	synchronize_irq(ssp->irq);
 
 	/* Release IRQ */
 	free_irq(ssp->irq, drv_data);
+
+	/* Safe to disable the SSP clock now */
+	pxa2xx_spi_clk_disable(drv_data);
+
+	/* Release DMA */
+	if (drv_data->controller_info->enable_dma) {
+		pxa2xx_spi_dma_release(drv_data);
+	} else {
+		pm_runtime_put_noidle(dev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1489,10 +1545,13 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	if (status)
 		return status;
 
+	drv_data->suspended = true;
+	synchronize_irq(ssp->irq);
+
 	pxa_ssp_disable(ssp);
 
 	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
+		pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
 }
@@ -1505,28 +1564,46 @@ static int pxa2xx_spi_resume(struct device *dev)
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
+		status = pxa2xx_spi_clk_enable(drv_data);
 		if (status)
 			return status;
 	}
 
+	drv_data->suspended = false;
+
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

