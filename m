Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C6302753
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303219; cv=none; b=CNEJ5wLxI/EukaP7TOpMtR6KAA0PhmzqyK+j4UfOKyk4DnmRPV5EXp3WySUdqyY7E/jcniJcpWn/0aYxZtLjwQkuRfCZklyAmmfkgTUoTJPRSzWmI4JSWvgGOuA86Ll6zJFWpSdVmZ/HN4mJxAM7jjFPxgNw5NZ38A8jkhWJAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303219; c=relaxed/simple;
	bh=HAFauFP41CYCUuSK0DC7SycE+4WHF4gz507BMTfJC5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSCgXIOyNqtNSchxWS3TOIFWvVuBaLiOB8Zn5qcxBbaFV+Q+XEdn2SX28I0RFaJY/KapwDcVZTVXEr+McUXhVgPKC0r4sOkCAQwQzFpkxWWVfmgyEB8G1d+va0U+hFLxPcXLcoMb+pxEPSaNrGdz6jjV6OyZZ00b7rSYWuomFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845c92bc464so4420055b3a.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303217; x=1784908017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hj/nAMls8Idqw9YqxnSe6WRiiMInWfXR/jNJRmfXPBk=;
        b=m5aR0sCJv2IXkspK4EH8I1O+pfjjzn2N7+RFA49o5qFWW5JyePKZLbOyvFSryx98ew
         7xw8P5fHXWB0eU756V7U8GszDq6fNSs9bamlG3/Zlvk9F8NKSgPb3XNJJZ6KFF0iMB8B
         /ZTHkWQDTZcix8QJhTfMbmnZt3VmxAjN9apw9c9jLNCPGRuTmMRMGEeFLgOZmr2Exx9j
         u9IKA2JF2+aPU/+TqoGylw0GnEVr6wqiF8oN7ky3VhTUNyc/UqbdICqWafdU63SIsFH6
         7OvTN1HhucVNgxysgIBCndFbPKMwm7ckJynyCzZtnJ3+kXrGNlSMxTTpAVZOasGnzMfI
         hqUg==
X-Gm-Message-State: AOJu0Yy2ID77zmeI5aNxtcRDnEMokYoTSGSQ9tw5eM54V37KPIqkx5Wl
	Cxo5Y8qZegTL/fi+tlJ+mjthZpeYNEOu9Xq4fwzHrQ3OQuqbP1c57lX+HoSPcfY=
X-Gm-Gg: AfdE7cno2+PWzkdW4GPCRXQRdQCqiwR1tgZRXVQVtAGFTj8lKPUkLEjwhJq8ox1gWIF
	nbZHeIODoZuny+jM4rFZ5Cyx3RUmeHqQu+o2kbQ2foHH8m2Smvveqd7f2vxEUgqB9G6acaTa0Jp
	YM/xRteLcpzvDXSOfy9Cp/MNNDgxnVSZt1SpgSPxbIzkZIjeZWH+pRO4i8pSxZJMMoDR96F5dP+
	yo1FwN6/4nfg9rfHPHWIIDGzrOOkHIuQuNi6h6wKMXz40PQX+fRMT9mZ0I73xeOTnXxS2GP1eVO
	SXJEa7DThHFcAuljpY2XE84I13x1Y8ANnwIlpMVbk09lvDXS56v4etuLYYpm8oGofFbykYAbl2Q
	oRsqUz8ahNzBGMiWwq/BYyb1I46zkUYuT1dIZagxfKeKbCydryAXt8Mb++GpP0z7qBpYTbBkkSm
	i6vMaZ9CCdOWCzpTByGWdRzTP6/YU4TKKW9pVSd3ncKVAeY5V6dURq72xHrNi3zTUuyXYW+8g9Q
	w5c3hwuJVBFXTA=
X-Received: by 2002:a05:6a00:10cd:b0:845:dfef:75b8 with SMTP id d2e1a72fcca58-84c29263072mr3350708b3a.15.1784303217344;
        Fri, 17 Jul 2026 08:46:57 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad87f83sm1332576b3a.3.2026.07.17.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:46:56 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Fri, 17 Jul 2026 23:46:45 +0800
Message-Id: <20260717154646.5854-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717154646.5854-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260717154646.5854-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 has two related problems:

1. The DMA handshake and interrupt routing frequently fail or time out,
   causing the keyboard and trackpad (driven by the applespi driver via
   SPI) to become unresponsive.  Force PIO mode to avoid this.

2. When DMA is disabled, runtime PM autosuspend clock-gates the LPSS
   block between transfers.  Accessing its MMIO registers while clock-gated
   triggers a PCIe Completion Timeout which causes a watchdog reset.

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
- In the shared interrupt handler ssp_int(), check device status using
  pm_runtime_get_if_active() instead of pm_runtime_suspended().  If the
  device is suspending (RPM_SUSPENDING) or suspended, ssp_int() immediately
  returns IRQ_NONE to avoid reading unclocked MMIO registers.
- In pxa2xx_spi_runtime_suspend(), call synchronize_irq() to wait for any
  active handlers on the shared interrupt line to finish before disabling
  the clock.
- Adjust the driver teardown order in pxa2xx_spi_remove() and probe error paths:
  always call free_irq() to unregister the handler before calling
  clk_disable_unprepare() to turn off the clock, preventing concurrent
  interrupts from reading registers while the clock is disabled.

Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 47 ++++++++++++++++++++++++++++----
 drivers/spi/spi-pxa2xx.c     | 53 +++++++++++++++++++++++++-----------
 2 files changed, 78 insertions(+), 22 deletions(-)

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
index 6291d7c2e06f..22020c43fbe4 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -719,14 +719,11 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
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
+	active = pm_runtime_get_if_active(drv_data->ssp->dev);
+	if (active == 0)
 		return IRQ_NONE;
 
 	/*
@@ -737,7 +734,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
-		return IRQ_NONE;
+		goto out_put;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
@@ -750,7 +747,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 		mask &= ~SSSR_TINT;
 
 	if (!(status & mask))
-		return IRQ_NONE;
+		goto out_put;
 
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
@@ -758,10 +755,19 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
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
@@ -1351,6 +1357,9 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		}
 	}
 
+	if (!platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
 	/* Enable SOC clock */
 	status = clk_prepare_enable(ssp->clk);
 	if (status)
@@ -1449,11 +1458,18 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	return status;
 
 out_error_clock_enabled:
+	free_irq(ssp->irq, drv_data);
 	clk_disable_unprepare(ssp->clk);
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
@@ -1466,16 +1482,20 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
+	/* Release IRQ first so handler won't access registers after clock is disabled */
+	free_irq(ssp->irq, drv_data);
+
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa_ssp_disable(ssp);
 	clk_disable_unprepare(ssp->clk);
 
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
 
@@ -1518,6 +1538,7 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
+	synchronize_irq(drv_data->ssp->irq);
 	clk_disable_unprepare(drv_data->ssp->clk);
 	return 0;
 }
-- 
2.39.5

