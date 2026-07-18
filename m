Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DE25A354
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344972; cv=none; b=s602WrtJXYfTGjB73D+Pi5+jq6LISJTqd/Uo63vEIhTs2Yvl8qNhRfXIbpnSOJx94o4MqWLwU+JRthukFJCzqzIqDAXveoVro8bWod6+2G0L3AWMVdfJ2VxqLSmdhVWd7MTJ03QaIpp7T70yOQDWmNPxd1PsT1cgCJ2cardp9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344972; c=relaxed/simple;
	bh=Y/57MkOM8eRSjxGaFFLidAiIlN1hiqs1oi1tNlpENeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgOz7Thn7Dp+nLFi5FAS6UOEoluJPuUDza/vt6y9kz3AvSuoo90scbVc8z1V9B8fahKtotk/4/Q5oLM9FS6GWllUZ8JmhiF4poeB8neBb7zECQ4l3hj6JfIkWx5s1wxvWBuKpuOabn+60uQ1e3e/k2EZ/MgzCp7u2CeIjv6L+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84867f07d63so9677271b3a.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 20:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344970; x=1784949770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KqzS/pPchzVgr+e0CaFrcL+y7UklQglkh+sPLr2Qxq8=;
        b=jaV/8YuoUOEspAvF1q8UVE+33n0dqRPo0IQTKfLeDsqJ0OXgljav69KQ1J4QeliGr6
         AxbFfJFWU6LpbkG9Q4haMPAj+b8VNjQGf82auAJRQgcQfo/LGwKx/775kOnwj7hJCXE8
         hTY56symYlmtQgFwHholv/2uxT5KSZntoejje16oJCdlJVmcAfhqUdE/4klCWmOUwO+I
         XdRUJ04fsz6xmVmtSlbzWPbvgBxOwO8lxdsLGqGHJ2J4g8QXMykoI3SwRVCjiPl+N227
         LyWjZ6YvwewVxRNaiGkkFohk3kCROUIOwhR90ub55Ndhz5MEDCQt+TtI7oEMq02yOh/L
         HlfQ==
X-Gm-Message-State: AOJu0Yw0wYVU678s1qPUDA1vJxZpiJLaJCjLLSCjRU+6gn88V6Yli22H
	K0V/TBQk1JZ7fqZY4j3v1qugrz7UJ0Pa8RBSkl8DbwAtOzFfkGgMCAY=
X-Gm-Gg: AfdE7cno1BbeAC6oPHw/dSwF4QrDZdh8l1dVR16Vttp+TFL6q2J1n0RHZ0Nu0e0PyFj
	rJizNQlJBMZY9qzX4pEuaideV9UUqwF8MHsB8Y8Rh8axoO46/0i0jqF/t/T3TJmsS/LmFasLen2
	Rff6ODi6NegTeOzKCfIi/2jlqdP1sr79py9afhbJJn7oZ6eIqPcBaTPCNfPq/5Hn3o0TxKPL9Su
	8CsEIkUlMXe7AOydfPiErxf9ImGmxOUaVtTJrjUxwNLotL3nsTzzu0W5QxjaLI2WzLDnpEBj3vR
	Zh3WM0PTUc0Y975y+aODiYAQTkezer9QB/YRav7Q3QAaAin9cXDna6X1YxolOx9wvC4aIczq6wQ
	lncuT8Bqw9n8/J9UfuBDeD1wjSVLpZd1sxPUquvxO8L8F2aEyO6aGAZ5/2gCKd480dtb7XZnbkr
	UWerezx1MyYJK08ykXAk9R1TQ6D9dZnNKGDHCnWyypyWsvH3YAQIsCbTWxEBBpzgfwJsL5VaE/E
	KAlMxb2L1+WsC0=
X-Received: by 2002:a05:6a00:a111:b0:84a:32a9:a5fe with SMTP id d2e1a72fcca58-84c2948a850mr5945827b3a.36.1784344969410;
        Fri, 17 Jul 2026 20:22:49 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af31790sm2088157b3a.37.2026.07.17.20.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:22:49 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v8 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Sat, 18 Jul 2026 11:22:38 +0800
Message-Id: <20260718032239.19136-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718032239.19136-1-fourdollars@debian.org>
References: <20260718032239.19136-1-fourdollars@debian.org>
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
  pm_runtime_put_noidle() in the remove/error paths. This keeps the PM count
  above 0 and permanently locks the device out of autosuspend, preventing
  userspace tools (like PowerTOP) or udev rules from overriding it.
- Implement helper functions pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable()
  to track clock state via drv_data->clk_enabled, preventing clock disable
  count underflows and framework warnings on resume/autosuspend error paths.
- Check device status in the shared interrupt handler ssp_int() using
  drv_data->clk_enabled and drv_data->suspended. If the device is
  suspended, suspending (RPM_SUSPENDING), or clock-disabled, ssp_int()
  immediately returns IRQ_NONE to avoid reading unclocked MMIO registers.
  Using drv_data->clk_enabled instead of pm_runtime_get_if_active() == 0
  avoids returning IRQ_NONE during runtime resume (RPM_RESUMING) when the
  clock is already enabled, eliminating level-triggered shared interrupt
  storms, while remaining fully functional when CONFIG_PM is disabled.
- Reorder pxa2xx_spi_probe() to register the interrupt handler (request_irq())
  after the device clock is enabled and the suspended flag is cleared. This
  prevents an early shared interrupt from asserting and triggering an interrupt
  storm before the clock is active to allow clearing it.
- Overhaul the driver removal sequence in pxa2xx_spi_remove(): first disable SSP
  hardware-level interrupt generation (pxa_ssp_disable()), then set
  drv_data->suspended to true and call synchronize_irq() to wait for
  in-flight interrupt handlers to complete, free the IRQ, and only then
  disable the clocks. This eliminates both post-clock-disable MMIO accesses and
  race windows where level-triggered interrupts could cause a storm.
- In pxa2xx_spi_runtime_suspend() and pxa2xx_spi_suspend(), call pxa_ssp_disable()
  to mask interrupt generation at the hardware level before setting
  drv_data->suspended to true, synchronizing IRQ, and disabling the clock.
- Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
  enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c |  37 ++++++-
 drivers/spi/spi-pxa2xx.c     | 180 +++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h     |   3 +
 3 files changed, 178 insertions(+), 42 deletions(-)

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
index 6291d7c2e06f..f6cc39633191 100644
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
@@ -189,6 +194,7 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	}
 }
 
+
 static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 {
 	return drv_data->ssp_type == QUARK_X1000_SSP;
@@ -713,22 +719,42 @@ static void handle_bad_msg(struct driver_data *drv_data)
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
@@ -737,7 +763,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
-		return IRQ_NONE;
+		goto out_put;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
@@ -750,7 +776,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		mask &= ~SSSR_TINT;
 
 	if (!(status & mask))
-		return IRQ_NONE;
+		goto out_put;
 
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
@@ -758,10 +784,19 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
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
@@ -1288,6 +1323,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true; /* Start suspended until clock is enabled */
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1330,10 +1366,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
-			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
@@ -1351,10 +1383,22 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
@@ -1434,7 +1478,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
@@ -1443,17 +1487,21 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
+	if (!platform_info->enable_dma)
+		pm_runtime_put_noidle(dev);
 
 	return status;
 }
@@ -1466,16 +1514,27 @@ void pxa2xx_spi_remove(struct device *dev)
 
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
+	if (drv_data->controller_info->enable_dma) {
+		pxa2xx_spi_dma_release(drv_data);
+	} else {
+		pm_runtime_put_noidle(dev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1485,16 +1544,30 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 
-	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
+	/* Mark as suspended and synchronize IRQ before disabling clock */
+	drv_data->suspended = true;
+	synchronize_irq(ssp->irq);
 
+
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1504,29 +1577,56 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
-		if (status)
-			return status;
-	}
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		goto out_put;
+
+
+	/*
+	 * Now that resets are de-asserted and registers are restored,
+	 * it is safe to handle interrupts.
+	 */
+	drv_data->suspended = false;
 
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->controller);
+	status = spi_controller_resume(drv_data->controller);
+	if (status) {
+		drv_data->suspended = true;
+		synchronize_irq(ssp->irq);
+		pxa2xx_spi_clk_disable(drv_data);
+		goto out_put;
+	}
+
+out_put:
+	/* Let runtime PM autosuspend again if needed */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return status;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(drv_data->ssp->clk);
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

