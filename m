Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEC38BF70
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380488; cv=none; b=bfZ66iG0bx9ggYZxtCEl+Y3Tki+6ZNWnSboK0hNzsTANfRt1XdQl4cq0dvt47FyAbWdLNhdj9QZiMSNwFiztr1Lc3N8cbqh+WDcRL1vIQUFR1FlsXuoy/e0yiTHmf3wJMf5DfHO5Yspwhru569c9NhsS5/vky5/6/VZ1D94B9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380488; c=relaxed/simple;
	bh=WladfIEAQLUPpPjz+1JEWdoHWvt8afWGcuwpogh66ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n4wd/dZIuW/3W0ErLZj3v6Nuupfsv1y51tLhCNpkB8l3HW/JU1KUwu8gQ2a3tcqrJhPq6jm8OzhhU2/azFpO6Ms+C/fr5/cZ6B6yG0jQK0BY8eh6AguqBs2DIh1lMZOUqPzkXv+RU4rVycYjwjyXUbZU7LU4WOsjEshXSOA1akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso108798a91.1
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784380486; x=1784985286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLhd23KbMwoOAHk8AvQYbwBs9IqSFQE5KIg3tITPIw8=;
        b=gqH918A8eYSchhpbK+xFf9t0JXedOV90Uj+ciOt8Zcwzyy4wTAS0rISUVUS8LogAjq
         aALHxNsTgW7zrwaAXl0UlVk0+lz3NUwJcSPDE1z8lakAWsZ94RNqWID6bFVIYNFZGQN3
         HOHGvX0Bh0+a7XKdjQYqnvUJlNCbf4qUpV1BP/Gp7q/NH+049VlVPx6kcVVh+HIhnrO8
         uJu8j5lxU6iB9I+iUFCSHVM+Gu7Yy0FerSMwrRjskvIQ3y5LDI5UNXlAaEd70osfAkRL
         QyKQUbxvRSdaXBLm1KCPK7/yzmfGmTn1XVoFwDibOB6Yp4OqERnuLuHXMDoZEK48kzAX
         Pm0w==
X-Gm-Message-State: AOJu0YxqvxhuXfR6Qen94ThxJIoc5ZMaoxHqnm7syvFG5pdD8vjF8U33
	E0s40ISYY0EWsrkvvt85WgPP/fvISGjy2Fo8iQ5zflIXkwfYyzCAjFM=
X-Gm-Gg: AfdE7cnTn4phitXK7DhM7YrtBnzWBj97++pbiRYqwnAU617MHZdY9p+X9bqOS0UjWFU
	3WHdmpWaPm8xJPgeYx0g4GmXo/aQJmB27V3sB/9cep9aVO4HOSdNDvq3FXjVOdvPynt3Uw1Tbep
	UP1JVujN8+uLTitRZH18eYDFEMqP/GbWtm7dvWT0dFQDbD2diM1bSSsrI6Jh/O/8lFr4WWuzzCx
	pLquMPpqHmXhS5ePDtwfY6x/bKuSzS/tujfNFZJbK+xNZeIULA/G/RaL03Jkv085riIRqeblF3m
	eesEEJMe6NTuz0jYqQe7xnuJ9K6kQSJwWYsQw5EaYe9aP7JCb0Vk391EJWUNz1JCJ67bePlQ+6r
	TGn1cahZ2ryDn6Yn2IAN+udpMPepRUvMzE+RlAjzLwOT5nZp/7Ti8ixoi27uPoODrC5Ty/kxOnm
	NMK2EuXW5sBsa79Bs2b1ZJNPqlRztweC0YKXz+7HGoo0KgU5Oo8PJi0p9HLSCMq7w/QLq72qp7I
	7S1m6g0FtUqOTw=
X-Received: by 2002:a17:90b:4a8c:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38e4b43c580mr7688422a91.2.1784380486201;
        Sat, 18 Jul 2026 06:14:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9bb5sm2706400a91.11.2026.07.18.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:14:45 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v10 2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
Date: Sat, 18 Jul 2026 21:14:30 +0800
Message-Id: <20260718131431.3393-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718131431.3393-1-fourdollars@debian.org>
References: <20260718131431.3393-1-fourdollars@debian.org>
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
  put_noidle()) strictly to LPSS controllers via is_lpss_ssp(), preserving
  autosuspend for non-LPSS SoCs.
- Acquire pm_runtime_get_noresume() exactly once in pxa2xx_spi_probe()
  after spi_register_controller() succeeds, symmetric with
  pm_runtime_put_noidle() in pxa2xx_spi_remove(), preventing PM usage
  count leaks and double increments for PIO mode devices.
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
index 6291d7c2e06f..d50afd408dcf 100644
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
+		pm_runtime_put_noidle(dev);
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

