Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384E3D9040
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544040; cv=none; b=hY1xTvNC10XboIydlfq/BkL31Xj21DeyN8VLfMizVLcDtPQjHVkBm0NwmU1ZiNFb0vPS/iy50I7tOofjKrXatz2Oe/uhQ//pRcnlZQZxhh6GM9J/lKzjiXA7OhxRQb0W79Kk36JTD8bBbAw7MfQ2SU5wZUZvmgdm77k/3m7YUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544040; c=relaxed/simple;
	bh=Vdt+qeuvpREFSA5a0TrrLGGVRMBDEdjthERSl9sDPT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHRMwrtSllGIFRmAWVVneuLJUc01n7yTpNn5l1aS0ig28eW0KgM/3/TQZYgHxzQItYq9FOWlJu7HSuy5NzwrWQITAccKejsAGXaq31oXvyHSuq46r/pkhezlBmc8IFaNn54oJ3wEnEjxxTfWl//WxIN278DefXVBHfIgX7ZtDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc73e322dbso117054555ad.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544037; x=1785148837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRbZTqGpgqv9f3V5TsJU/zSn2sq4m20JPxg1ZUFyYfw=;
        b=gqGjMvKj4vIdWE6snVawfiaE3dKfTBs9qtnR6kL43IKEne+GS3fnmJFmyna7JrlbdB
         VrbBM0zBUTsoVC4PD8FLh5X+cChR636uddToVH+cAnHXsaZwX+Z3NTDCmVmWbmuj0/0M
         88MU/SoJYA7NxfCIdxZtjRi8IDt3I3lwZuKGAjhbtNcfJk7GrfXK2/qaBChxlFfNwN9j
         EXxTjEeDUdePYxsJB3MAqbd3HF0xbhu3cThTzzfsmoTy9zCyXJKnyIz2kYCiUXDTDEJT
         M4FzFcC4nU6pDkCjIJmhTNiUctG+F3PjXvxuo3xzUh1EVGb93AUsmbqzVzif/GC6vkMG
         E8Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1jCHjUboAQ1ezvcL2eTX+NuNS8et5t5q/K1LZt7pXygLfp047y/6jafFOXCJi8zQXvtTZArrHozw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwYoy8svtQk9bxFT/2kDqDuZDc9iecEPFAkcREYbzKu5gQlII
	duAhcvcQaK2IsiP9IdEZQqnBUzmGx/y5a7sLJehtHv3vpVC89WNZvHE=
X-Gm-Gg: AR+sD11Lv83E2ksSG3nbdpphoVM2geTpxG9fWMdrMUVJNMKlbSRWHTXT71HOgs+iETT
	neNR95a9gAZ4dZsuFY38p+UP+wdJIrnpBUL1BUxYPD5L2Y+d5T4YRBHE2hOy5dqc+d3fCbAOJLq
	ULL4Ui3srSyj0BrH+EkKjsRb/hDh5Mi3eZN9gh2tog1yHeut9v6kohZbsQEGh/q5QVUwuRbLMtM
	anlUOGpwIrviUTuZKXluQEYw+cD5YokC9gHB796WWeLVzOZKVBkxUPLZFv4z0cW6MGfdu3IWg+D
	I4fRAj+Gr/NMCYmMrpLr8Cpxh/w0Q4h+8Agn8G2jZibnTtw94rGflpjmXs/XG8FcDkFLShdadpB
	DyV9Q9DjisQZ91zezXtMiO8sNK1EeUStLm6wMwuCz1YyPzhmeoUNPaaoJ+Z9xlGTsm2f1AEAq0K
	wG4D9rCqtWh1g+eqshg82ypMf6/lJ7GnLRZsyO7QNi74jNMdOfa13AWXeO5XFYVVQ0y45RJngyK
	zdRghq+IdfAd8qkjA==
X-Received: by 2002:a17:903:2c05:b0:2ca:ec6f:aeca with SMTP id d9443c01a7336-2cf3481b670mr148842085ad.8.1784544036593;
        Mon, 20 Jul 2026 03:40:36 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:36 -0700 (PDT)
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
Subject: [PATCH v15 1/7] spi: pxa2xx: introduce clock enable and disable helper functions
Date: Mon, 20 Jul 2026 18:40:23 +0800
Message-Id: <20260720104029.13740-2-fourdollars@debian.org>
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

The driver disables the clock during PM runtime suspend, PM system
suspend, and device unbinding (remove). It also disables the clock
on various error unwinding paths in pxa2xx_spi_probe().

However, if the clock is already disabled (for example, if the device is
already runtime-suspended during driver unbinding), calling the common
clock framework's clk_disable_unprepare() again leads to clock prepare/enable
count underflows, generating kernel warnings. Furthermore, in the probe error
unwinding paths, failing to request the IRQ does not disable the clock, leaving
a clock enable leak.

Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
functions that track the clock enable state using a new 'clk_enabled'
boolean flag in struct driver_data.

This ensures clk_disable_unprepare() is called only when the clock is
active, preventing clock underflows during suspend transitions and unbind. It
also allows the probe function to safely unwind resource allocations without
leaking the clock or triggering clock underflows.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 37 +++++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..d50152aad348 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -713,6 +713,28 @@ static void handle_bad_msg(struct driver_data *drv_data)
 	dev_err(drv_data->ssp->dev, "bad message state in interrupt handler\n");
 }
 
+static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
+{
+	int ret;
+
+	if (drv_data->clk_enabled)
+		return 0;
+
+	ret = clk_prepare_enable(drv_data->ssp->clk);
+	if (ret == 0)
+		drv_data->clk_enabled = true;
+
+	return ret;
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
@@ -1352,7 +1374,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	status = clk_prepare_enable(ssp->clk);
+	status = pxa2xx_spi_clk_enable(drv_data);
 	if (status)
 		goto out_error_dma_irq_alloc;
 
@@ -1449,7 +1471,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	return status;
 
 out_error_clock_enabled:
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
 out_error_dma_irq_alloc:
 	pxa2xx_spi_dma_release(drv_data);
@@ -1468,7 +1490,7 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa_ssp_disable(ssp);
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
 	/* Release DMA */
 	if (drv_data->controller_info->enable_dma)
@@ -1492,7 +1514,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	pxa_ssp_disable(ssp);
 
 	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
+		pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
 }
@@ -1500,12 +1522,11 @@ static int pxa2xx_spi_suspend(struct device *dev)
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
+		status = pxa2xx_spi_clk_enable(drv_data);
 		if (status)
 			return status;
 	}
@@ -1518,7 +1539,7 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(drv_data->ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
 
@@ -1526,7 +1547,7 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	return clk_prepare_enable(drv_data->ssp->clk);
+	return pxa2xx_spi_clk_enable(drv_data);
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

