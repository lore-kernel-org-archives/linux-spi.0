Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0383FB060
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306262; cv=none; b=JdWgOPbXQPlxbStTi5r87HC5TavEXWrYH9yrRZ1RaL7Rj9Y3PXk9HzPjEg01QR3WJSp41JDKp/MY2OtSYfw16VhD+b9EIAgzuuGH+H3umU+giEJ4YceyPBIoJFuX7MXrDpz5XIuJpJYsJQHjFEpsrL0VtOvPA3c4oxKZdsumjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306262; c=relaxed/simple;
	bh=9BgpLGZDrBypOf+TYKA487jGvAQ/RJEDYcYFJN6ToqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lZyCtYXNy1UpJIB7Vy6ubn8H+dbrijZc664IT9++8kyg8Z2oqfHuTD95EzkONaV7NXpnEASZWydqFTjTsVm2nBVgy73ql0BnHpgKJmtKsjCALfpzLaTB15yTwTN8Q36EyizdIr+P5kM3HrXna+ttr3x/Wu392B9Z0S65/2TVRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so8028056b3a.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 09:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306260; x=1784911060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzhVSlDmYmL4yUGAPMw6ROM56XBmkr2uXme8y30m5DQ=;
        b=Nm+sIu+smMK1HwJ+pUlz+EyXS3VBKJl1Kzo8PqMbrmBbjLc57oGoNzRyRUgiigR7G+
         KwK7AFaalwtsykUOlKmTnnvl8np1tHxBesK0gmGBFFNGIdg2vbWBG7p9xqRmDT8UgZMU
         BdH4+M+sc4JM+HL4Um33NAerggC35DYR9Z+8/j9PDGubuasDgarwudITh3hbaaZPTKTw
         WI89DbTAfcDVSYIQbfIDee7WpNmLcMXR9VW3wOX+2+rydQlSEiBToxdgUW1Bk5Cz/R0H
         0VAGvu+YgbuLJ6ThnpCVSH3ZbXvqX6Pg4hJBzFeYg8qoaWv/lZS84ZhoDR1PSe6fafjI
         5+xw==
X-Gm-Message-State: AOJu0YzvfoAYIGDkLzTBOjudsYg4YAa7Ep32EP6gRSQrLyIjxeqc2kW6
	LAa0j5KVekAwTGncKe9S9Lyr00DcfYGHfsW+Uxc+rVNz1L9FxPNo5+JN8pobrRI=
X-Gm-Gg: AfdE7cm/3LKSazKem/u6cAUjdXvinDWF1U5jiTUtyzWnaYPzraSg3VDjXeHHqmhpr3Y
	3E95TvpM1NFxzwEaPupkCzq2rzXSotBZccVUGhvXwSp8MJimeFiiuYZZICuDB/YbgCa1cXlZQEo
	BlWEkn2PYhyZ8P8Y+ChkDlnvy+h6LWsynZdli5M+FcabWW4jLSbz4qrplaS+/JfR2jAjk0REHFK
	PmpkduCQZeoR70GjnIDaEZRKGSZW5yQ0Ayq3NqexaSnKD3Gaa1Rt2Em/vf4awpUzbJfkK76Rnf6
	aILH3Y9hjpfEMyh9uTiW2BH5ZWnt1hJSkhcrSK90dL2X2V3M8ejD+BOEJ1aDt+XXIufgCZt1GW9
	s8s8D9JkoBWKOnL9YG28Ex/X3/+yLdt8AdTEzSLeED+RC2SUyvJ8bUTnAK9srvcGfCgUeOBUhXy
	IRTmLOnsyxsSaCOwmQwZidkWjXFg8hPbjvejxBmTCbrjlb7jIJzoAWW2MRNVMwDV2csKBvWu8a7
	WJ2zIXflVouyp4=
X-Received: by 2002:a05:6a00:ace:b0:848:4742:90a6 with SMTP id d2e1a72fcca58-84c292cfedbmr3533647b3a.15.1784306259966;
        Fri, 17 Jul 2026 09:37:39 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b86dsm1441669b3a.8.2026.07.17.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:37:39 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v4 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Sat, 18 Jul 2026 00:37:30 +0800
Message-Id: <20260717163731.6782-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717163731.6782-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260717163731.6782-1-fourdollars@debian.org>
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
- Only enable runtime autosuspend in pxa2xx_spi_pci_probe() if enable_dma
  is true.
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
 drivers/spi/spi-pxa2xx-pci.c |  47 +++++++++++++--
 drivers/spi/spi-pxa2xx.c     | 107 +++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h     |   3 +
 3 files changed, 128 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..c107b3b53d33 100644
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
 
@@ -300,10 +333,12 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
-	pm_runtime_use_autosuspend(&dev->dev);
-	pm_runtime_put_autosuspend(&dev->dev);
-	pm_runtime_allow(&dev->dev);
+	if (pdata->enable_dma) {
+		pm_runtime_set_autosuspend_delay(&dev->dev, 50);
+		pm_runtime_use_autosuspend(&dev->dev);
+		pm_runtime_put_autosuspend(&dev->dev);
+		pm_runtime_allow(&dev->dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..dcae43a04eac 100644
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
@@ -1466,16 +1510,20 @@ void pxa2xx_spi_remove(struct device *dev)
 
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
+		pm_runtime_forbid(dev);
+	} else {
+		pm_runtime_put_noidle(dev);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1489,10 +1537,13 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
@@ -1505,11 +1556,13 @@ static int pxa2xx_spi_resume(struct device *dev)
 
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
 	return spi_controller_resume(drv_data->controller);
 }
@@ -1518,15 +1571,23 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
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

