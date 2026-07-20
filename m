Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18F3DCD97
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544044; cv=none; b=KyCsPGUFRme1G2ZDA2mH/1vBYQtVdDeo+5V+twm/Y1YnqeJ7WEvIODeiFtivrj+eHaOU+B1j6vZ0Sp0J71WMHhD3a4ksWr/7hgmU7fIEMqlFqXfxIlBFlFnVAvBGJ1PT/GAyhPANRcB2FkzTiJqDKm6nVOGlzy6MhVmz2yPdi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544044; c=relaxed/simple;
	bh=UnAsh3CjibL9YdkOiPk87mzPv+ZX5WAu6yNK19PE3Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sl3vtgY8DfzTiYUG9xrRr+1fHKmtIroNfKQ2eQ8GJ7pXEdTSr8ZhkJzCMa6qrH0tluwaPgvXKUvmOCRKXwFXeLa2ZOay/RH7FTIVC2pWmFYzeyc0OyGBc3VIUMlD6GejlvyuyDi0ssRzB87o/7EMNZ2eglNRPFnwZFWAvIyXOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf41bab353so31618585ad.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544041; x=1785148841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECUv2OBEiZbNwjfMV3/65e/S6w3Th/UZLtjgLjuN8Rg=;
        b=iI342VswQtyGdSqB8bBsaNvvU+sFh//8pEq405y2lCDZKHGE2icNaOrJIiGVRlAwQu
         aQ3znQEd1gtLKCBHZVM3Ur2HA0cS9l3Y06LAk1SYIlbNWd4oUBQO6CzSAEJ3j2vLlAoR
         eqCIyl33M0UZKLfMVMpHosFFEZ3WcpVVX84h8e8UcGOt4GDs1fw5iI9DWQTfYF2ty8q3
         QlWlb1wRV7QXGLTUbThHMz0lixNyFC0uAzOASKr4izt1QkHYfvvx/Azn7AB0mvre62cQ
         7Lq52PUr9ShBGs5Fp3d4v32tksCtGoYb0riSA2kHRtcvyPgKCS2ziG7xTWmK1ui68Ttr
         FTDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqjnl1imxIOP2z3nn5crXbsSU5EBCZq0sJBeF9h+RyEPXZAJ+fVKrxpKh/kTwuE10rNOKvyAN0IhI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XXpe1By3kmIbQzncnkpo6L4m0cAW8Y8v2cH9eA34oFWUmtN9
	J/3QAWbYiF7G/6Fv//1+k8LHfcbjG35m88N7Q0kdQiuoOEBZaptHJUg=
X-Gm-Gg: AfdE7clAUWI8rs47axzIAx5ObO5pRij9kBdLprrJtJL9Tg91sDb+REinmk3Jp+9LXtP
	WUTtzeE75yIHQ3IHx38/LeOUSv9aF9C1LdHLFkLY5t94EaqtSiiMDC65lGaX53A6tntC5mGZWT/
	KhutysnnxiRZyzZVXOI+dAfS8FDRwX3ICyl65DGAXjim5JIcuTCbGWSKvoXGb56HYs/c2CdC/l9
	FEcjgnaRRv4jPwAd9m7dLuJyaSzkdBItxgfcAn9XzSMWDnX6MkZBLDr9KqkLYMephMN7/MipSYn
	JOHBEarsTgbbTx9RSi+qjK2s7Q3I9MsoHFKaZsZp3+vNIASQRP/mq+XcGxfDcpVVus9MVJiQpdp
	Wvadl3a62Cihz9cT3GgyosidNklJrDYd0nOuXz7yrVq4m7069e8Tdzj4CvJcNJmkIq2jCvHNCHa
	Bt4dOe09gCk5dSpL/m6F9VbIBTnspl1lq3m7jW5JWOkqmDslE3Vm/Rs9CdUXW9JBoekDxTQN6pC
	ZHxazcsxlDvraJKRw08c9o1aMyt
X-Received: by 2002:a17:902:f70d:b0:2ce:bb47:6f3c with SMTP id d9443c01a7336-2cf349c262emr151302235ad.34.1784544041432;
        Mon, 20 Jul 2026 03:40:41 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:40 -0700 (PDT)
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
Subject: [PATCH v15 3/7] spi: pxa2xx: overhaul teardown and suspend sequence using pxa2xx_spi_off
Date: Mon, 20 Jul 2026 18:40:25 +0800
Message-Id: <20260720104029.13740-4-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx.c | 49 ++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d4a9a48c2624..64b5ec744756 100644
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
 
@@ -1518,10 +1526,11 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	if (status)
 		return status;
 
-	pxa_ssp_disable(ssp);
+	pxa2xx_spi_off(drv_data);
+	drv_data->suspended = true;
+	synchronize_irq(ssp->irq);
 
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
 }
@@ -1529,6 +1538,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
 	/* Enable the SSP clock */
@@ -1538,14 +1548,27 @@ static int pxa2xx_spi_resume(struct device *dev)
 			return status;
 	}
 
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
 
+	pxa2xx_spi_off(drv_data);
+	drv_data->suspended = true;
+	synchronize_irq(drv_data->ssp->irq);
 	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
@@ -1553,8 +1576,14 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int status;
+
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		return status;
 
-	return pxa2xx_spi_clk_enable(drv_data);
+	drv_data->suspended = false;
+	return 0;
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(pxa2xx_spi_pm_ops, SPI_PXA2xx) = {
-- 
2.39.5

