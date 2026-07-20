Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217A43F4BA
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564506; cv=none; b=acAm3V+I+ETmtaMr9zy2/vcMneumcROINpmXAgvH+udWfQNEzGCwgTyIUGDJltjWEEJIdltoIM+WL5pwNuGfk/FoovvSo9gFy/vifIJUm7Zay2IpDac7Dnt/TPw9D96hz3En8fBEIeuImGttskeBhGHgoZOdVWLiZx6ZtZ/R5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564506; c=relaxed/simple;
	bh=X1AOeou6yS9kGr/z/ALcY89ALvKc5/5jxNmhSrNGyNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPgx0JmjhEhhFu86txDtP12oRy0CSmD93Qx4/olcZ+O1ab97+xiIlo2Td4imah7LVuXZGOQddHxyVtNBuEzpxLDk+xfJw863GKYmp28QpsL8vFcd3gihVqw6B3vZwNZisTAdfs2js7LZzLtr0l8MKWbB5cl5yCCKyC9jHL7I+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf41bab353so37858285ad.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564501; x=1785169301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RU/JGA5nOjMqs/efzn0kjJdYCZ/griCBQ2ley/7YLuw=;
        b=VhOiHGYS56yFnf1Ty1qstg8/khVV/bHXZR7/hVs+QkK8aE/B/WWdpWV2iZKsZat+Rq
         MTdfmABErlz33AjE0pMs/BgB5knEL3I+zgoqm1hftBmzLB99KohNtUBQ6MZsX7l8NZKT
         pAYBqiNNJss1hg5XIG4d90i7UUYl2FyMa5rJavNJaCYoRZ3XKNNtD3ynrrXEKQQH2z8W
         NvdDq4rrrriPOChV/G5DvLnGyVas/mTLbuQ23ytPyurxv7BF3iPvo38VcKu16MOeZUej
         WLmoJHWvVbS24I6aqu/W0sjHogSL0dN5sy6PiP3aNF9dpMe+seKu1p9rUR5R+X/xdqoV
         FlhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rou5LCxpl8kvzFFr29+TdzKwtmKZRzsoZheGIV1ceQy4fTgWbOE3mDuqp4dEO8jjN3hVHf0EVAuHXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/oESbrg9Drxs2fq6OzBV19k/u1U+FFBWvdVaiZSU/HhFk7Pw
	X5baXkgHiJbZSwfFlMeUciXP0MlatGdSd3fZxmqfLOgIf0nLwliqBwA9QCQloe9dpA==
X-Gm-Gg: AR+sD10bYEgeblP6kejoEFP4ZgSdfHLgNkZkm/Pc1g07MVPFxb12BToR375JnmzyozT
	wwD/F/6s6IaocH7CRrpjvhpmRUcXAMS3aJYROMrOL5+IaCl+PVzg3PYp0TZMPD1p9RdtYMFTPdM
	fxioNnT/db6Kg5bzQ/yhzsV5/EWaIdpb7+b9ISPUavPpp439Oi9HC7OXwZ8yXYu2uHFbEjVqZkj
	nRR+HVowHKgRLbKCue7nb6jDKymhLUx6NMgKdOjXS0cWfbSEDdOZkQF16PMWSTyi5oEKH8WLNAH
	O6aHr1TNURVTVPuJM+3VLcmAq6AARFJaEpHopJeaS8V/qDiDx/MnVCHUFLLlrC7IRQDmzptQVpM
	kv/SNAXgFegXI6HjT+CyKCaU+a2hzTusG486oKu3FGrSKCy1NaI+k1+x/cn1IKqUVUG6QeiqOJx
	QfX/C8jXWzNYpLU/KrXaxRVT7N/6IvJnxCN/+mtzM2tLT/dLv2TEaVNCZi13o6uqdT+Kfn805Yi
	4Vgum0ycUHq7OmVKw==
X-Received: by 2002:a17:903:38c4:b0:2cc:fbf5:afaa with SMTP id d9443c01a7336-2cf348bd420mr159082955ad.20.1784564501163;
        Mon, 20 Jul 2026 09:21:41 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:40 -0700 (PDT)
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
Subject: [PATCH v16 7/7] spi: pxa2xx: rename local status variable to ret
Date: Tue, 21 Jul 2026 00:21:16 +0800
Message-Id: <20260720162117.32304-8-fourdollars@debian.org>
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

Rename the return value variable name from 'status' to 'ret' in the
pxa2xx_spi_probe(), pxa2xx_spi_suspend(), pxa2xx_spi_resume(), and
pxa2xx_spi_runtime_resume() functions to conform to standard Linux kernel
coding conventions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 66 +++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 851626ead25e..9379aac82c7a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1313,7 +1313,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	const struct lpss_config *config;
-	int status;
+	int ret;
 	u32 tmp;
 
 	if (platform_info->is_target)
@@ -1372,8 +1372,8 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
-		status = pxa2xx_spi_dma_setup(drv_data);
-		if (status) {
+		ret = pxa2xx_spi_dma_setup(drv_data);
+		if (ret) {
 			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
@@ -1387,16 +1387,16 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	status = pxa2xx_spi_clk_enable(drv_data);
-	if (status)
+	ret = pxa2xx_spi_clk_enable(drv_data);
+	if (ret)
 		goto out_error_dma_alloc;
 
 	drv_data->suspended = false;
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+	ret = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
 			drv_data);
-	if (status < 0) {
-		status = dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_clock_enabled;
 	}
 
@@ -1477,23 +1477,23 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
-			status = PTR_ERR(drv_data->gpiod_ready);
+			ret = PTR_ERR(drv_data->gpiod_ready);
 			goto out_error_irq_alloc;
 		}
 	}
 
 	/* Register with the SPI framework */
 	dev_set_drvdata(dev, drv_data);
-	status = spi_register_controller(controller);
-	if (status) {
-		dev_err_probe(dev, status, "problem registering SPI controller\n");
+	ret = spi_register_controller(controller);
+	if (ret) {
+		dev_err_probe(dev, ret, "problem registering SPI controller\n");
 		goto out_error_irq_alloc;
 	}
 
 	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
 		pm_runtime_get_noresume(dev);
 
-	return status;
+	return ret;
 
 out_error_irq_alloc:
 	free_irq(ssp->irq, drv_data);
@@ -1504,7 +1504,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 out_error_dma_alloc:
 	pxa2xx_spi_dma_release(drv_data);
 
-	return status;
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_probe, "SPI_PXA2xx");
 
@@ -1547,15 +1547,14 @@ static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
-
-	status = pm_runtime_resume_and_get(dev);
-	if (status < 0)
-		return status;
+	int ret;
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
 
-	status = spi_controller_suspend(drv_data->controller);
-	if (status)
+	ret = spi_controller_suspend(drv_data->controller);
+	if (ret)
 		goto out_put;
 
 	/* Disable SSP interrupt generation on hardware level while clock is active */
@@ -1586,19 +1585,19 @@ static int pxa2xx_spi_suspend(struct device *dev)
 
 out_put:
 	pm_runtime_put_noidle(dev);
-	return status;
+	return ret;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
+	int ret;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = pxa2xx_spi_clk_enable(drv_data);
-		if (status)
+		ret = pxa2xx_spi_clk_enable(drv_data);
+		if (ret)
 			goto out_put;
 	}
 
@@ -1643,8 +1642,8 @@ static int pxa2xx_spi_resume(struct device *dev)
 	drv_data->suspended = false;
 
 	/* Start the queue running */
-	status = spi_controller_resume(drv_data->controller);
-	if (status) {
+	ret = spi_controller_resume(drv_data->controller);
+	if (ret) {
 		drv_data->suspended = true;
 		synchronize_irq(ssp->irq);
 		pxa2xx_spi_clk_disable(drv_data);
@@ -1653,7 +1652,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 
 out_put:
 	if (!pm_runtime_suspended(dev)) {
-		if (status)
+		if (ret)
 			/*
 			 * Clock is already disabled on the error path; align
 			 * the PM runtime state with hardware reality before
@@ -1665,8 +1664,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 
-	return status;
-
+	return ret;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
@@ -1683,11 +1681,11 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	int status;
+	int ret;
 
-	status = pxa2xx_spi_clk_enable(drv_data);
-	if (status)
-		return status;
+	ret = pxa2xx_spi_clk_enable(drv_data);
+	if (ret)
+		return ret;
 
 	drv_data->suspended = false;
 	return 0;
-- 
2.39.5

