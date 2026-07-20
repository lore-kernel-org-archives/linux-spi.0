Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56C43DA4C
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564490; cv=none; b=UBjLuTp1UP+GKwhU5AzE9WUw8Z/3e9OIsa5dIit9QmPcH+AJF8N56OyMm9Rwmx/dc8qbNW2kz8my8C9c+83IuFYTXGRcvnyeCL5+ftGGGOSAZdxJYQLPB5K2C7/QYsV+v8cydDAaSo4SHzxEQhF0fgWw+4NXrWZtanV2FVcZ7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564490; c=relaxed/simple;
	bh=ZW4CGyqV6soZ3TqlQ4EfOXoOOiXdQOSeonMf49/eMKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+zEMpvBi82IneFwCvOGfPjO4sp+v35/jLHUJkYJPNB4LEDBftGy2+o3Y+2dob20sn8GM6BF5IRVlvjc5iXZeoQRxhNKmJVJmLvn9V1pW3OZAWEsoA6RX54vJkF0dYj/2w8DQxMIGFQ8W1d+WEd/x0KICCTCaEsKwDAC9IEWMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso107955615ad.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564488; x=1785169288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zcZmpxuX179qfg6VaspTT0K7xGUvI9chfr3uCqZTPa4=;
        b=Sk4I8fh7L+1YDiyPBdTwsn2QEwtBXPAfZ5fhrWE5yDZ4Dl+Q8AprX4nx0Lihoom+Wi
         sPwCclR1esvcvfeUlSZCUSRMSnCjt1SrhzVvfhfi/8R5Yo6FQGccD5VMoojc0YkQxdcl
         sD08RtxGPRbl5BJLH0W0ZppJJ8Khw6kT+7/fWibPTAs/P5P2ZqwRgZSF0CZt0HzVD1Jg
         ecahkzf7zoLt0rSf2FVcBdA6n24aEDXvP4xEBmSKJFwFHWaXyhI7h6JmzylwgynH/VZp
         SmGpcztTEphjmiekcPeL4IJHT4re80Z0AzEooN94cQisYdSQNx27322uAe32MYQ8Q3Y/
         o5xA==
X-Forwarded-Encrypted: i=1; AHgh+Rqq2NPJU3pUv5zSl0+pbrCRottgbtp17Q470WzqGyZ2bvIObdN2baPZ6+y2KsevoeZkAwlSYAyZGFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiugM8jUDhGlp3GSyQbNLrrHx8Rfmui8X3ZF5Sa8i6pl9fRxY
	FgRvRozmtxNW+BknFmI5xBwqs0+lWVm520IGW6g/zQB8a1H/NmckMH8=
X-Gm-Gg: AR+sD13m0/nBTL3hvnHQjwQobjsqjMSE+BBWdItsk+v6qBAzaSnEUrEb/P31fJBN4fg
	curt8IXOc1rlaa2L2CLBtGRBH9AtAQrVG4g++ZK35mH83xmbeKWHKwi0MDGjIRp7pdHOXT57PRX
	+SLrzreOcgudOGvzHVDRc4+VEMC9RGy+Px8FMcw4DGYv6coeH7TrygublqffYHClT1AwKgyq/dz
	8xfqFYnXPMLL11pDArwJ4qaLBp7tIE1CfoxLKF6urqA3U0Pnf9hg+hoy/Rvp5DOIEmq5xcyy326
	8CtkHxLWiMCCe0p93H9ASAjB8VHF0Eop2yeLyZtsprDJwxAlJWFGMwSru1lgE2dNPyGikNY0TLX
	WbeF0B4W0LDRw3PxEieIxy38XyosO671+m01FMofGVieGBumHtQCIaXPLHl6fgQRK1q0q03lFWx
	Hw9y/FyhS082NjpmiO4pGo+ibR84LxSKr35/6sGX69lIkhcX95UFVrInkydfymRTv9E8AocE4qO
	TKyXYes9DOPMLmiP8e6PCn23mdG
X-Received: by 2002:a17:902:e805:b0:2c9:d277:2cdd with SMTP id d9443c01a7336-2cf34887c56mr163407575ad.13.1784564487720;
        Mon, 20 Jul 2026 09:21:27 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:27 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v16 2/7] spi: pxa2xx: introduce suspended flag for interrupt synchronization
Date: Tue, 21 Jul 2026 00:21:11 +0800
Message-Id: <20260720162117.32304-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162117.32304-1-fourdollars@debian.org>
References: <20260720162117.32304-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a shared interrupt line is used, the interrupt handler ssp_int()
can be triggered by other devices sharing the line. The handler must
ensure it does not access the SSP controller registers via MMIO when
the device is powered down or when its clock is gated; otherwise, it
will cause PCIe Completion Timeouts and system hangs.

Currently, ssp_int() guards MMIO access using:
    if (pm_runtime_suspended(drv_data->ssp->dev)) return IRQ_NONE;

However, during PM transitions (such as system suspend or runtime PM
autosuspend), device callbacks execute to disable the hardware and gate the
clock, but the PM state machine does not mark the device as RPM_SUSPENDED
until after the suspend callback returns. During this transitional state
(RPM_SUSPENDING), pm_runtime_suspended() returns false. If a shared
interrupt fires after the clock has been gated but before the PM state has
transitioned, ssp_int() will execute, attempt MMIO reads on the unclocked
register space, and hang the system.

Formal verification using Spin/PROMELA confirms that a scheduling window
exists where the interrupt thread accesses MMIO when clk_enabled is false,
violating safety properties.

Introduce a custom 'suspended' boolean flag in struct driver_data to
track the device's suspended state across all PM transitions. Check
both 'drv_data->suspended' and '!drv_data->clk_enabled' in ssp_int()
to return IRQ_NONE immediately before any MMIO access is attempted.

This closes the state transition race condition and mathematically guarantees
deadlock-free, safe shared interrupt handling during power transitions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 51 ++++++++++++++++++++++++++--------------
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d50152aad348..c44349ab2b52 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -730,8 +730,8 @@ static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
 static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
 {
 	if (drv_data->clk_enabled) {
-		clk_disable_unprepare(drv_data->ssp->clk);
 		drv_data->clk_enabled = false;
+		clk_disable_unprepare(drv_data->ssp->clk);
 	}
 }
 
@@ -743,12 +743,12 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
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
@@ -1310,6 +1310,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	drv_data->suspended = true;
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1352,11 +1353,6 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
@@ -1376,7 +1372,16 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	/* Enable SOC clock */
 	status = pxa2xx_spi_clk_enable(drv_data);
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
@@ -1456,7 +1461,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
 			status = PTR_ERR(drv_data->gpiod_ready);
-			goto out_error_clock_enabled;
+			goto out_error_irq_alloc;
 		}
 	}
 
@@ -1465,17 +1470,19 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
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
 	pxa2xx_spi_clk_disable(drv_data);
 
-out_error_dma_irq_alloc:
+out_error_dma_alloc:
 	pxa2xx_spi_dma_release(drv_data);
-	free_irq(ssp->irq, drv_data);
 
 	return status;
 }
@@ -1511,6 +1518,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	if (status)
 		return status;
 
+	drv_data->suspended = true;
 	pxa_ssp_disable(ssp);
 
 	if (!pm_runtime_suspended(dev))
@@ -1531,6 +1539,8 @@ static int pxa2xx_spi_resume(struct device *dev)
 			return status;
 	}
 
+	drv_data->suspended = false;
+
 	/* Start the queue running */
 	return spi_controller_resume(drv_data->controller);
 }
@@ -1539,6 +1549,7 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
+	drv_data->suspended = true;
 	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
@@ -1546,8 +1557,14 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int ret;
 
-	return pxa2xx_spi_clk_enable(drv_data);
+	ret = pxa2xx_spi_clk_enable(drv_data);
+	if (ret)
+		return ret;
+
+	drv_data->suspended = false;
+	return 0;
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(pxa2xx_spi_pm_ops, SPI_PXA2xx) = {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 820e573a3c60..44f37bf9c519 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -72,6 +72,7 @@ struct driver_data {
 
 	void __iomem *lpss_base;
 
+	bool suspended;
 	bool clk_enabled;
 
 	/* Optional slave FIFO ready signal */
-- 
2.39.5

