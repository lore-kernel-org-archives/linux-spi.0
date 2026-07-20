Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C413DB64D
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544042; cv=none; b=fzmrukO2R6gfmsWcCTyIU+/bh+yjLNbHzRYtgTBaUdUyUQTL9SaZHMqHqBCNEdSEZ9wWEBfZSotFsX5YOWK0ihcnm2EEk0tVux6iZTpK0dennxizPIGWLbdek4tJ3AHc/HD0+0pQgdpCndRBLd+aRHsLZ63bEOU2O54Ih5eYyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544042; c=relaxed/simple;
	bh=PRHUXV6tls2F/eyT19L26E36CgR4Jha3qL9Co67zKX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVyR75wgwq6P83TeTANn3Ucl383FFkjbYYTc+qoaQIWsVpNj9LwiyVYyVtdSgsStjiTQaUu/GQOK0CqhJ/mU+ffmuge/U6iDFNBsL7qlNGF0IT5fkiyj5BKDbx+HgxQmQQa/VRRdo9yb4PFk/8S0GbIQQYvLwgluRm4t/Hb9oqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf452def93so12486595ad.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544039; x=1785148839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2COBYw4BWPBdbvvAp87MLasINrhEHK6G1ompJUFtwUI=;
        b=gy+Ixrof6IQ7VMTv0HWu0rT6FuZWqaRAA+V+f5xDLyVDdJUh4Q4y9qNlXKnZnG7GOd
         JlaWxq5F73wtAju9lFSH9HhwTWCdbLTEfY6AcxvtGYbsHZyOfbB+qK1uPbBjFZi88ycX
         LdssMTocKzcpq3Y5eKvkMQ1oAOx0WNUZ8AS2Es69UXXe8lrYosKUSxo+3fylZG0pt7jV
         bWPHvjq1Po22HRZGPs6G/70DCgKEsvUMvpOVxt1Pdj2c+ELEN1dBXIk2qtXCml9pjYBI
         LdBOLsMoctzOdVaktiqXjC8xdFvc9a+l1phom8foUCc+zT+Gqc7NX/MOtDWTghqWukoc
         FFdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4rEQtvrRs4AKx+6zu4ljOixlobm244B07GdEGSEu/J2fV4WZMvAYxLBLiMcFeslNax3O4siUcMK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu32k/k3YJ/dhqInvdmTIpwPWpEnEwGG2+wHCsbwZZeB6vSask
	FURyLWVQ31WyPGfr9boRHUFtd4NWMeI+iqF4rWrBKCQmmiYUgI1lJto=
X-Gm-Gg: AR+sD13byFRnsOB99WU1adyUHaJ2voXxGQD8RGuuAYdB4zPDL/0qnREwDY7wY5pYxUb
	XNhPkCbCm5JRFv1Re+DDrf5IPbd6FmLdmng2yMyD5BXpcgNtSGtAsIMu/rhsvqB/QRDYCnL6wyG
	P8U7aMAJ1YAR/XnTCZYCMpFtFAgs8at5A17qkBjO4TSkqMWeZ+zEiWB3/ELqH+KM2k1VboeHT4T
	5kYETFBv0azzBV1auL2ntYAPglOd1IYYbCyNSzMgFF4XJoKh/t42/lvxes3f2MSNfMQbiSSptCC
	rqbyOEuXcv+VL9lAz8pFlec83XUhgCRkGFdI41ZuPPs3lntIX9UxUiHliui9eeDDC+Wj8ljAfUp
	xvcwZPYlcX7pS8M9pcQzkseorGW2EISLl5SVY1brotlMfa7DaS+ewfHiPdi16shbqq1rV1EaZSK
	HgxFsCQGya/dU9sKcLCZfo58BrgDBe7UrgHlxCNNIkMf8e5nxi2h4UEkePGE7sNUqneNiMWW+kW
	nh4ovyEMr9jDADSWQ==
X-Received: by 2002:a17:903:1986:b0:2cf:18e5:1d18 with SMTP id d9443c01a7336-2cf1f5d7491mr198894955ad.29.1784544038972;
        Mon, 20 Jul 2026 03:40:38 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:38 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v15 2/7] spi: pxa2xx: introduce suspended flag for interrupt synchronization
Date: Mon, 20 Jul 2026 18:40:24 +0800
Message-Id: <20260720104029.13740-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720104029.13740-1-fourdollars@debian.org>
References: <20260720104029.13740-1-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d50152aad348..d4a9a48c2624 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
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
-- 
2.39.5

