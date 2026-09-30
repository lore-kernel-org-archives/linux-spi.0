Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0D4F7CCF;
	Wed, 30 Sep 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784433; cv=none; b=S5g/BLqLjXTcSwqT//t65uJsluXX0Dm5JtTjqyqVXQENqdEIMPKr1kO2goIOMV2vFMtoUsrh074uI3/qlxgfcq/rE3P9N+549NFRgYPQeq2NnmO/6w3ET2fwSNgV3C4qqwcKcMgDyGb5WuRSEsotT3cZ0qn4vaEPNjQy38gah3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784433; c=relaxed/simple;
	bh=0+gTcyUfHIb7hVK6G5V6L9A5b5wPHTihkP0AZwgJbqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTAzWw/RGyPmiiLUXrvYmVUtRCgrNxOYaydo3rfoVI7Jsq2rpKB4Zbe4eiY6xxF+fW1gUNXW4NsZSH5ArPUfSBRWiBYHRk1eKbO+jebR0PKTmgu22e9E0CAS1MJKZ3HlpbefE+kvi9EF0vCCgq5iVjLk+/W5L5ip48zjCjP6Yfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=E0LLOzBO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="E0LLOzBO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=S8jLYSQ+fGf5DtGXjU2wWRzq8Y6nl25gGAKxq/Rq4tU=; b=E0LLOzBOOZuUrX2ECuXXnUXFDS
	dOgkh3Kq4vF3Tn++1m5UgurND3KdewqeaBoasSkGMpPYurLxHqiAj88YvtbOj5SRk4bKzBUVrZpfu
	b+ZxRmiGbHImKr6G6Gys3+njLn0NfpN7dXRRBHaC0nXjHE0WRy5CIdASe2dipc5sUjTAWIJ6IK5cf
	FI41Ap2W9m2Sd36eTaKhWQ+rhKCs6WlecGcg2+iS+Q8/IKJBZ6J0/z3dZDT6aq2iBg37dxkCXhcVd
	7Br3ZVkFyMkAkO33zMpRNvWWXL1hajnT7pmN8dK0rtwWpo4Ywk6iiifG5l0p8sUvkIW5Lki6pBsZ0
	qf7zCNLA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <fourdollars@debian.org>)
	id 1xBwpW-009IoV-26;
	Wed, 30 Sep 2026 16:06:51 +0000
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v17 1/6] spi: pxa2xx: rename local status variable to ret
Date: Thu,  1 Oct 2026 00:06:24 +0800
Message-Id: <20260930160629.1822-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930160629.1822-1-fourdollars@debian.org>
References: <20260930160629.1822-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: fourdollars

Rename the return value variable name from 'status' to 'ret' in the
pxa2xx_spi_probe(), pxa2xx_spi_suspend(), and pxa2xx_spi_resume()
functions to conform to standard Linux kernel coding conventions.

Assisted-by: Antigravity:gemini-3.8-flash sparse
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..b11e30589074 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1274,7 +1274,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	const struct lpss_config *config;
-	int status;
+	int ret;
 	u32 tmp;
 
 	if (platform_info->is_target)
@@ -1330,15 +1330,15 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 						| SSSR_ROR | SSSR_TUR;
 	}
 
-	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
+	ret = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
 			drv_data);
-	if (status < 0)
-		return dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot get IRQ %d\n", ssp->irq);
 
 	/* Setup DMA if requested */
 	if (platform_info->enable_dma) {
-		status = pxa2xx_spi_dma_setup(drv_data);
-		if (status) {
+		ret = pxa2xx_spi_dma_setup(drv_data);
+		if (ret) {
 			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
@@ -1352,8 +1352,8 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	status = clk_prepare_enable(ssp->clk);
-	if (status)
+	ret = clk_prepare_enable(ssp->clk);
+	if (ret)
 		goto out_error_dma_irq_alloc;
 
 	controller->max_speed_hz = clk_get_rate(ssp->clk);
@@ -1433,20 +1433,20 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
 						"ready", GPIOD_OUT_LOW);
 		if (IS_ERR(drv_data->gpiod_ready)) {
-			status = PTR_ERR(drv_data->gpiod_ready);
+			ret = PTR_ERR(drv_data->gpiod_ready);
 			goto out_error_clock_enabled;
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
 		goto out_error_clock_enabled;
 	}
 
-	return status;
+	return ret;
 
 out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
@@ -1455,7 +1455,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
-	return status;
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_probe, "SPI_PXA2xx");
 
@@ -1483,11 +1483,11 @@ static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
+	int ret;
 
-	status = spi_controller_suspend(drv_data->controller);
-	if (status)
-		return status;
+	ret = spi_controller_suspend(drv_data->controller);
+	if (ret)
+		return ret;
 
 	pxa_ssp_disable(ssp);
 
@@ -1501,13 +1501,13 @@ static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
-	int status;
+	int ret;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
-		if (status)
-			return status;
+		ret = clk_prepare_enable(ssp->clk);
+		if (ret)
+			return ret;
 	}
 
 	/* Start the queue running */
-- 
2.39.5

