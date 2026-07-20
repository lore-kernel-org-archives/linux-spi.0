Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD824398E0
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564486; cv=none; b=nruYRh+BoFMOkeA66D10uFQUZ04J1NPeRsvxnx0cvcyWltNe2pEQXcLgw5uuIZi8/7+2eDtSzmtA1OxGMgQ14QftSyajVCZZAtbhvHHPvLpZg+iISuhyenbx+xn+NiJASlCdV8FARsng4XKoSmxBZybf1aIBBNgvXC1b5OogOh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564486; c=relaxed/simple;
	bh=Imf/IZkqF6PpiJDJtp4aeo003gOTloJRnScD2xi2wYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRoByo+P1lVq57iulUxf9KHnTZTO2IvS0EVAdAt79jsJh1MMDhLyGVd2iGQDvc8/RUxOy6FMrbG9/0RpNVpCVQqCz27QGA1g8vMJvo79+FG+D+M73br3Yg/TAtFLhUsCg8zr7wsCi9g4tXzxV9jqtt9e7iFSe5bfvuZmXHOBI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caed617615so114024445ad.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564485; x=1785169285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49rBEbH5fONL/HnT9WXrZZOfwE9egzJjXhPVZNXFswU=;
        b=qg588iKFc231VQ7GF+2keO57aMN6gNxKJ065ne1SSvRcigbn0Vxyvao1o/zJJ1QaAV
         AytvvYHgFwQ2JeTbJY2DsQgGRxKUDqzQj/8FLwyu4m+5HkHA/zvpY7uEZ18U6ExZfWYT
         PQuLW1+eeCTKFk1DdmRa33skYYqcEth2zCuAtFK0XtdJoFniq4aT0NIzCxQXdQqjCiAx
         HdmK6tt/7GwJoFha41sP59Fopa6j/pEfPmwwfMjarxJVBViDXqhq7pKWWhPOo0tAqPFe
         hAWJaprna3K6wXC39Z/DXg17JFVortm0ZV6aoTRBRtqcPEQ7n7rkmrApUuCXZ56VO5H/
         cOAg==
X-Forwarded-Encrypted: i=1; AHgh+Rot27gOC7NEIh6iLnuJExTgcUn5hsSYqGSu5b1YSxOfOfqVObZMCif1DczTsepxtc9HgOKzIrMYfBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEEZS9kw03HXHIFt47CCp5RIr0pYeNc3HG56yjw7SS+Z0Bnxz
	l7DcLIPQBgvUXhR1IZiPArJbxAeia+hk0f173aLlLrj1B/NAnp8WqYQ=
X-Gm-Gg: AR+sD111f1C1GkoprVh+CXLnlljIP7SxRqHwdHV/SJCswKucpi7lfwLma/aGmVr8SCa
	xdKQsZnB6TPRFN7h38IHCwjWDfNXoBvXf7OCHgydbWpnZe2u3DB55E+Pgq2oKCPayeaHAbv/z+y
	r0ll0ptBGMISxRgJcseBdUaYygqlWN8D1Jcc4D0pvJ3sC9NL2WdBI8gEZfmMZWAhvV+aoveGXcl
	F9TdiqCs2mQYnTSX0Chhvm3pJUV4LZfAuucaondPPov5wzrINd8CFD9+HTbOBgeGrfk2TwW+xOX
	071cPR2u2VjD2enT83R6tVLHSMaa5CNQ8uIHi6uayp3XWfB6i1M/EA8/ghQr70xSR4RT/59m/yn
	xc35EGii8LJ97966DIfEzjxbKL2LcVg8ccRjO5i3MlacB+PDVRiHe4DgfJ+2LwX2JRZjV4R8Fz6
	bjATCN+V63x0+0JZiyPW2XYSuGa2nyn+hivZiOIqV3wuIM4SmEGROWOCHbgG/ANO1Kd0PnnliQe
	DnTamMrMQKm+YMUmg==
X-Received: by 2002:a17:902:f542:b0:2cc:741a:ff33 with SMTP id d9443c01a7336-2cf34a39f67mr156765115ad.43.1784564484731;
        Mon, 20 Jul 2026 09:21:24 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:24 -0700 (PDT)
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
Subject: [PATCH v16 1/7] spi: pxa2xx: introduce clock enable and disable helper functions
Date: Tue, 21 Jul 2026 00:21:10 +0800
Message-Id: <20260720162117.32304-2-fourdollars@debian.org>
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

The driver disables the clock during PM runtime suspend, PM system
suspend, and device unbinding (remove). It also disables the clock
on various error unwinding paths in pxa2xx_spi_probe().

However, if the clock is already disabled (for example, if the device is
already runtime-suspended during driver unbinding), calling the common
clock framework's clk_disable_unprepare() again leads to clock prepare/enable
count underflows, generating kernel warnings.

Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
functions that track the clock enable state using a new 'clk_enabled'
boolean flag in struct driver_data.

This ensures clk_disable_unprepare() is called only when the clock is
active, preventing clock underflows during suspend transitions and unbind.
It also allows the probe function to safely unwind resource allocations
without triggering clock underflows.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 37 +++++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h |  2 ++
 2 files changed, 31 insertions(+), 8 deletions(-)

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
index 447be0369384..820e573a3c60 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -72,6 +72,8 @@ struct driver_data {
 
 	void __iomem *lpss_base;
 
+	bool clk_enabled;
+
 	/* Optional slave FIFO ready signal */
 	struct gpio_desc *gpiod_ready;
 };
-- 
2.39.5

