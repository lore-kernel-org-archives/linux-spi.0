Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E33E0230
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784390838; cv=none; b=MhOo9QloN82O1kyeclGiSohBhfciKwmo/+6PfTE7ZUiY+a1f4GqFiUgjTZabr397AJgll2JgzSJFtV5vgA8lrkVv+LiAF1gnUyt+pzdgYp5Bs7uHyxN1Mp9/HXzh8/62RUZzPHEjYJJg/xqUbHB2fdDUIuS3NhvDsuDJSiBjJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784390838; c=relaxed/simple;
	bh=YDnQFdPwCBW7eH/vBC0Y2pUr/Vy/Yrn1cOoNSxM0cQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uH2Kuv9IuDijx8Zqfs5yAc2OJBf1nCRmgZD+5suXJagHMr7hnoei6NMjxcSBgzE9ArN3K2n/ogid5nnSB5G+MSKyziy30KpuG8aOfAcVmZpw4+4QCtMVtg/iUGiJc0RxZq2PBhvFMdXiZgm/XWHzvrmUX4d/3am/VRsjXlnb/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccf2360620so48893995ad.3
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 09:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784390831; x=1784995631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uM0tAwthgToT3VeGfMSnfwhxjrFH6rpjiLJxkB0QbHM=;
        b=msoqMEBuH7e0OP7ckcZRFt0j8KSIo4kHPULvqCTDp4Cdx19otm6w52t6+FR87RkTV9
         gwVXMkyao0YeCLvJcOMP0yGTF3VhS2WgamvPVWbU11MOsuC4NELRYtz3/bnZH8J7tNb5
         MRUqV461KRAdcB7W8SIDMlhyQJxBcMLTpcWoaQbml0k2bMU0+bdThT+pLgWHQ4Mt2d9N
         Gj8pS+cpfAImUEITck7TpFA5ojSaOXkqw6OP2KJRqI5taIrdsdh5ODTH2G7W/dCfrYH9
         HFXg0vyI9v5h6jHViE3jODgE/U99VPMSzzotxQz96vIficmpXpf4NPSI9+aeKtXFdkau
         0O6g==
X-Gm-Message-State: AOJu0Ywq7A5w1BbdXLk00a+fD9T6rbWHZFfcb667ixzdmFpevA1dAshd
	Gwy2/fdPAfYAvR0P8/hvqnFnltH/7dsODLG8R1Z7cJOXsxd/SWHJfPw=
X-Gm-Gg: AfdE7clSAOv6NrO/kTT5K/k6cXC2P2G9TlUSsoehUgIs4QM7mdvDmpABo3YB7I1HbaZ
	s39RN8jic5tJItMNQMqvZi1Ityke5ktDknu9lmiFFsCiY0WXSzaMBRiK1jjF7ojiR7Jj/YY2zR/
	Z61w9653BbLRektB/DMLisGArddq6gIn7wHio9rXndAULwv7p3vAgPVyf1AyvBI1H64xkPptGEN
	9fH4zWqxxI6paI1L9u5B8+ttazKALyJ5FVCSadhhQuYGxS+gRuadFjqUL7aaf3iDzXsCkfRqB//
	QcGuHt8PZ2NGTMt5qH1vTJIj2NZWYMTm06rnA1uedxGrzg/ns7fei/NHeEB82QdvptA4JBoMukE
	DF1SSE4yFpYRWGzzYG6w9+HeHkrLs7ik+2XkWNu6l5jK1IMEF+G31mSFYoifykr8RNgprZ7zqx5
	a32bAvMyp6flEiF5XP8/K+KeJ3El2m/FcXA335v4aS6W60aOngST0n+6aSG8xo/cFquHvBXuxaY
	+fOjPJl7YH4UrI=
X-Received: by 2002:a17:903:1b2e:b0:2ca:281:27f9 with SMTP id d9443c01a7336-2cf349978f5mr77899165ad.27.1784390830506;
        Sat, 18 Jul 2026 09:07:10 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b16d4sm28996715ad.20.2026.07.18.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:07:10 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v14 2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
Date: Sun, 19 Jul 2026 00:07:01 +0800
Message-Id: <20260718160702.7861-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718160702.7861-1-fourdollars@debian.org>
References: <20260718160702.7861-1-fourdollars@debian.org>
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
- Protect ssp_int() using drv_data->clk_enabled and drv_data->suspended
  flags to return IRQ_NONE immediately if the device is suspended or
  unclocked, avoiding unclocked MMIO reads and level-triggered shared IRQ
  storms. Active SPI transfers hold a PM reference via the SPI core,
  preventing autosuspend during FIFO transfers.
- Register IRQ in probe only after enabling the clock and clearing
  suspended.
- Overhaul teardown sequence in pxa2xx_spi_remove(), suspend, and
  runtime_suspend: first disable SSP hardware IRQ generation via
  pxa_ssp_disable(), set suspended flag, synchronize IRQ to drain in-flight
  handlers, and then disable clocks.
- Guard MMIO access in pxa2xx_spi_runtime_suspend() with
  drv_data->clk_enabled check.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 138 +++++++++++++++++++++++++++++----------
 drivers/spi/spi-pxa2xx.h |   3 +
 2 files changed, 108 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..443800bffbeb 100644
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
@@ -713,6 +718,28 @@ static void handle_bad_msg(struct driver_data *drv_data)
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
@@ -721,19 +748,18 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	u32 status;
 
 	/*
-	 * The IRQ might be shared with other peripherals so we must first
-	 * check that are we RPM suspended or not. If we are we assume that
-	 * the IRQ was not for us (we shouldn't be RPM suspended when the
-	 * interrupt is enabled).
+	 * The IRQ might be shared with other peripherals or trigger during
+	 * power state transitions. First check if device is suspended or if
+	 * clock is disabled; if so, return IRQ_NONE immediately to avoid
+	 * unclocked MMIO reads.
 	 */
-	if (pm_runtime_suspended(drv_data->ssp->dev))
+	if (drv_data->suspended || !drv_data->clk_enabled)
 		return IRQ_NONE;
 
 	/*
-	 * If the device is not yet in RPM suspended state and we get an
-	 * interrupt that is meant for another device, check if status bits
-	 * are all set to one. That means that the device is already
-	 * powered off.
+	 * If the device is not yet suspended and we get an interrupt that is
+	 * meant for another device, check if status bits are all set to one.
+	 * That means that the device is already powered off.
 	 */
 	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
@@ -1288,6 +1314,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true; /* Start suspended until clock is enabled */
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1330,10 +1357,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
-			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
@@ -1352,9 +1375,18 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
@@ -1434,7 +1466,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
@@ -1443,17 +1475,22 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
@@ -1466,16 +1503,26 @@ void pxa2xx_spi_remove(struct device *dev)
 
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
 
@@ -1490,10 +1537,10 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 
@@ -1505,28 +1552,53 @@ static int pxa2xx_spi_resume(struct device *dev)
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
+		status = pxa2xx_spi_clk_enable(drv_data);
 		if (status)
 			return status;
 	}
 
+	if (is_lpss_ssp(drv_data))
+		lpss_ssp_setup(drv_data);
+
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

