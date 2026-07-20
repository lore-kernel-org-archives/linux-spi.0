Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90E43DA4C
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564492; cv=none; b=PO/8Ao5uYIYi8yqdhgglA/95YMJpYu/WrE2GwJsuDmdtqNn2ewvy0vrfzgP8nAGy6inXmfNvd6t+J+axcyZUlm/YxNTX66+Kof9E2toI6NTPH4jvAREGUYuXWCgVh7AhFtY2R8/bXaW6KUrP3eLPtU9vlld9P5MFp4vh94I3XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564492; c=relaxed/simple;
	bh=HzKgSIrjEnCFgGyoWIETQ8+443CNcjWwxAUt1BL2sx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmIksCu5eAKcK+gPN9n9Fh8HHj3XFmcPCmwZyaw27pGFlC3ga2CsGfaiBtPIxygJ9A+i3QbUk5euUBmMKe3vEAYEwCsjJByXqGqJtU2UQbkEevZkRqoxL0ysYZEjjSEDGQnTl/dGsp39rk6na4smxObgMoMkInuFw2mZ4EdJ4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad4170e8eso142214975ad.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564490; x=1785169290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjfjMNm+cQqraDceqixUdtwSS848knI19QAP7FSOitc=;
        b=MmjFN4Gw+hhS5gCYPL4Im+7Dq8rFFgElniAjNiE5shTTCBBKXRH/fMrKoWzMgjBue2
         Di5NuLecHiS/c/VxC8uYWWKA3Ifwf5XfAGdn8VuSHdcjcV9e32MUSsVJzJh6x9qX+ncY
         1GuKNVNDj/AdSNnCT1XwQaYD1aBkO80UaDL0PrLhtO7VyAhz01nU/fHtfgiEOVZH20vE
         k3uhJWcDZmgMbTzi2y+dIHc5asfyv1n4NKVHGxq9qMFRKVpVH9dkt0wf5PCnAiGWfWyJ
         A2/t3+h37nBJAecc/iQZF1+LI4+gM2fhtNtqynYvbj+KsuVC+H6amDbs2O/nqR5sq5n3
         So3g==
X-Forwarded-Encrypted: i=1; AHgh+Rr5Z4K8PeUPNESV0IrRlNjYdxRzqQa2gBVDoTcbIPKXoc5Mpj+MYwPkoxSMOn05s05EQWEHmQwARb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2E+Un5FsiWUUz6LJkdSzFf/N0/OgLLgQG1UF+gtVARfS/4Mjx
	clmAFwxGBDdUYyGgh6eTrYSZJERU5cQyj+KfmLhTFUuxyLqxrelSWjI=
X-Gm-Gg: AR+sD13CB+45uIa92XOtfBrxz/NN8LHeQuhZ+z1jItWYcPHGZTRxu85loCIRHba7UMu
	GEpLbKhOZITDOPzUrLaWvrMGstqzSSBtVJF9wujbTUxc4TZJVfMBCmJ/ifQVJR2eUu5ggwODBEs
	/9xz2NSRY0k1EhUIAH+6aUJXeSNwO6nDObcKcK6Uh6o34orYMA5xDgXwUw52YqaW3epTLap2Rg2
	fXE9m3ju2evNhIF9iG+ENQ1gvg37NggLeT0fAFZDbNL7l09q/AvaIzYcMpx8K6hTMtdvI1wwApY
	R4WxyyKQHItJuj+tXBk4LJTTFtZG3Ie2o1m3uqXhYF1D8irT6P+vukD/4CwCkDLQ96j/fjvju2u
	KU9y2a2d3Q8eLcu4pP73NQ98s52P+810Z6DWoSLvPjPKliPswPeYPojzywTTCcM00uH69FiH8dR
	xa6kWWgWylhvgoh1ncgond8ooxYpIOoRuND5DwHdDg4+FURHBJ39eJh5MZQDVy/Ih+KZ8TdEe1I
	UUFMbSVmGJeXUV/ow==
X-Received: by 2002:a17:902:dac9:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2cf34853397mr160016285ad.12.1784564490463;
        Mon, 20 Jul 2026 09:21:30 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:29 -0700 (PDT)
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
Subject: [PATCH v16 3/7] spi: pxa2xx: overhaul teardown and suspend sequence using pxa2xx_spi_off
Date: Tue, 21 Jul 2026 00:21:12 +0800
Message-Id: <20260720162117.32304-4-fourdollars@debian.org>
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

When removing the driver or suspending the device, the clock must not
be disabled while shared interrupts are still active. Gating the clock
before waiting for in-flight interrupt handlers to complete results
in race conditions where the handler performs unclocked MMIO accesses,
causing PCIe Completion Timeouts.

Overhaul the remove, suspend, and runtime_suspend paths to use a strict
synchronized teardown order:
1. Disable hardware interrupt generation at the controller level.
2. Mark the device state as suspended (suspended = true) to prevent
   subsequent interrupt handlers from attempting MMIO reads.
3. Call synchronize_irq() to wait for any active interrupt handlers
   to drain completely.
4. Gate the clock via pxa2xx_spi_clk_disable().

Additionally, commit 29d7e05c5f75 ("spi: pxa2xx: Avoid touching
SSCR0_SSE on MMP2") documented that disabling the hardware block via SSE on
MMP2 SoC platforms corrupts the RX/TX FIFO. Instead of calling
pxa_ssp_disable() directly, use the helper function pxa2xx_spi_off(),
which respects the MMP2 platform quirk by bypassing SSE register writes.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 45 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c44349ab2b52..6bfd3382acc3 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1495,16 +1495,24 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
-	/* Disable the SSP at the peripheral and SOC level */
-	pxa_ssp_disable(ssp);
+	/* Disable SSP interrupt generation on hardware level while clock is active */
+	pxa2xx_spi_off(drv_data);
+
+	/* Mark as suspended to prevent further IRQ handling */
+	drv_data->suspended = true;
+
+	/* Wait for any pending interrupt handlers to complete */
+	synchronize_irq(ssp->irq);
+
+	/* Release IRQ */
+	free_irq(ssp->irq, drv_data);
+
+	/* Safe to disable the SSP clock now */
 	pxa2xx_spi_clk_disable(drv_data);
 
 	/* Release DMA */
 	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
-
-	/* Release IRQ */
-	free_irq(ssp->irq, drv_data);
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
@@ -1519,10 +1527,10 @@ static int pxa2xx_spi_suspend(struct device *dev)
 		return status;
 
 	drv_data->suspended = true;
-	pxa_ssp_disable(ssp);
+	pxa2xx_spi_off(drv_data);
+	synchronize_irq(ssp->irq);
 
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
 }
@@ -1530,6 +1538,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
 	/* Enable the SSP clock */
@@ -1542,7 +1551,15 @@ static int pxa2xx_spi_resume(struct device *dev)
 	drv_data->suspended = false;
 
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
@@ -1550,6 +1567,8 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
 	drv_data->suspended = true;
+	pxa2xx_spi_off(drv_data);
+	synchronize_irq(drv_data->ssp->irq);
 	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
@@ -1557,11 +1576,11 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	int ret;
+	int status;
 
-	ret = pxa2xx_spi_clk_enable(drv_data);
-	if (ret)
-		return ret;
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		return status;
 
 	drv_data->suspended = false;
 	return 0;
-- 
2.39.5

