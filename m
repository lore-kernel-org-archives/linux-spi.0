Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED71D61B7
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784335117; cv=none; b=nSio1f0Pp90HiMB6Vt3v4l3MTmcKOwY/EmCc0SGJYhtGKZmHFVA18w2aXlbGHqUXijZAXxZUDnYVczA8DdJubUzzz55CkXpas8JqTpMPbwD9MhIdFtAiJN7T+KTXjOe4GEzBetK3FaH7uAwr4rSNMwqGhXxW7S3GImv15qSVBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784335117; c=relaxed/simple;
	bh=NVlQq/0ienIKK4mUYtZaXaxaziRDpv1e2YwiiqahKGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhVWbhlrUpwsuuD4puzDOOKL9GeFAhzFAvF8sR1HYIs+U8mOkvAhWT7iT8tKMj+XPt8pxBAJGMyXNikvlZEiO2cP0F+RW5qrT1bKv+OqR1OX5k1iNg9JJ95a8tEcve2wfcxuONNy6tup7RbKPJr3TOi+JoKoBcSImpZyOat9bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso5600639a12.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 17:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784335112; x=1784939912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKbP12yEVAd+t/2flnwPCW+I+ZRSTt8lopaLIRWMHHQ=;
        b=bmfbkYu2X6cFekptoFN3Lkr28RwGiBOn8D/uX7a+/SN4weiMu/9QbIN5gyxMn02ugJ
         XRYJP8YjQxykwLgghpfqk2MEWydeFZEOYTCH6BeThIAeXhYtpGLIcK0xqVEazljaV1wT
         e0NxJb1lnu0gp91UYbKHk5fP2K8WONqgvPptQuaCH+Kl3lwDY5yUEB5Z/3KsbgqjIkot
         PcfkWfYJimkr+4nX5CyTRt2nQL4dCG16MJeoWMNu+aFoQ6Vd3QYXDi/NlSGK0v0anRVE
         2cktFO4uFGS6mxvuqmWQPNPAk1YWI7mxsy1hPmk89Hb0Xg41AMV923Lel0QbOTMbKnxk
         nydQ==
X-Gm-Message-State: AOJu0YwJPyeSqqDa10NPSMzGxMIvJDmALC41ksmy/BZOuR5kG4rm+WUN
	VKKKENkB8lC68Vqfy4xanTQsWU5I0ex2Sv7ClRCqh1W+VeyQeM46ug4F3EAtXOOQaw==
X-Gm-Gg: AfdE7cnv3H8VMhvx2ARn17NrjNllpFGQvLAsUbsr3AC3vcp7XNjum2G+EZF+23coIWP
	GjV1PJBT3HJmC0ZnhipguE4fxp/wzwAb92q85UVGvuvfDqdQIec/ZNWIGBNB8cbR49YDIwN7JBM
	qN4xC+b2Ujb7gCl+XI5WUjXQKegvC8Nc55tKkqtPkeMUcDiD2X8vennZsRMzkMezGuOtoYlSipI
	H3reWUD4LMjA8idHeEvEBap6AekmclFNjmWRE+X6MAWNKiiQ/F3ywGt1yqHqdMLgMVkvG2cgAkp
	V8YF5PRIfdAnV1lQEbYlHiLmgeHqPKGr08cKE2sEgWiFiv3xv5XEAISHXVXH08mTV2PhWAiohvm
	d5BH2IC3RYZ7VFw39RhjRlttHZEjDL9k33Qxjh/mb4PWY5BAveHDa0/MXT7vkTwm8YVsmXek41X
	mLup8Jbdx0xI+DguzQzWDmyAuTHwky3fxZGrxt5G1nMD4v5tBXPbO4pB9SnIE8zuKVD5OjDbpGC
	UUiCEHVdchdai8=
X-Received: by 2002:a05:6a20:ce4d:b0:3c0:9c19:65a3 with SMTP id adf61e73a8af0-3c3adaa8bf4mr5499821637.75.1784335112479;
        Fri, 17 Jul 2026 17:38:32 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519aeb334sm1564893a12.18.2026.07.17.17.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 17:38:32 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Sat, 18 Jul 2026 08:38:20 +0800
Message-Id: <20260718003821.23334-2-fourdollars@debian.org>
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
- Initialize drv_data->suspended to true early in probe, and clear it only
  after the clock is successfully enabled, preventing shared interrupt handler
  races during device initialization.
- In pxa2xx_spi_runtime_suspend() and pxa2xx_spi_suspend(), set drv_data->suspended
  to true and call synchronize_irq() to wait for any active handlers on the
  shared interrupt line to finish before disabling the clock.
- Adjust the driver teardown order in pxa2xx_spi_remove() and probe error paths:
  always call free_irq() to unregister the handler before calling
  clk_disable_unprepare() to turn off the clock, preventing concurrent
  interrupts from reading registers while the clock is disabled.

Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c |  37 ++++++++++-
 drivers/spi/spi-pxa2xx.c     | 115 +++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h     |   3 +
 3 files changed, 129 insertions(+), 26 deletions(-)

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
index 6291d7c2e06f..1ba239d28d74 100644
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
@@ -1351,11 +1383,16 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		}
 	}
 
+	if (!platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
 	/* Enable SOC clock */
-	status = clk_prepare_enable(ssp->clk);
+	status = pxa2xx_spi_clk_enable(drv_data);
 	if (status)
 		goto out_error_dma_irq_alloc;
 
+	drv_data->suspended = false;
+
 	controller->max_speed_hz = clk_get_rate(ssp->clk);
 	/*
 	 * Set minimum speed for all other platforms than Intel Quark which is
@@ -1449,11 +1486,18 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	return status;
 
 out_error_clock_enabled:
-	clk_disable_unprepare(ssp->clk);
+	free_irq(ssp->irq, drv_data);
+	pxa2xx_spi_clk_disable(drv_data);
+	pxa2xx_spi_dma_release(drv_data);
+	goto out_error_pm_forbid;
 
 out_error_dma_irq_alloc:
-	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
+	pxa2xx_spi_dma_release(drv_data);
+
+out_error_pm_forbid:
+	if (!platform_info->enable_dma)
+		pm_runtime_put_noidle(dev);
 
 	return status;
 }
@@ -1466,16 +1510,19 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
+	/* Release IRQ first so handler won't access registers after clock is disabled */
+	free_irq(ssp->irq, drv_data);
+
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa_ssp_disable(ssp);
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
 	/* Release DMA */
-	if (drv_data->controller_info->enable_dma)
+	if (drv_data->controller_info->enable_dma) {
 		pxa2xx_spi_dma_release(drv_data);
-
-	/* Release IRQ */
-	free_irq(ssp->irq, drv_data);
+	} else {
+		pm_runtime_put_noidle(dev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1489,10 +1536,13 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
@@ -1505,28 +1555,45 @@ static int pxa2xx_spi_resume(struct device *dev)
 
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
+
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		return status;
 
-	return clk_prepare_enable(drv_data->ssp->clk);
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

