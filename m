Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC236A033;
	Wed, 30 Sep 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784432; cv=none; b=NcCeXVSqysYB1JIq+TqnC+3SZhY+Eo9+6+MVd/vGfJ9fFs4uLQD6j6/037gFdFDpFPGe0fzLjTG1dt5961U1u9rBuowRyDUcRbLgEocla3fr/8iRcAmJDMoBihqc+nTBbKNM/P9Ztp1o/F7B3TXWx2P3u/9/IKvtkbce4CsO084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784432; c=relaxed/simple;
	bh=5KrFcKy5EOXX96BQRpcc6jwqiTxzbMEUmPIXhFmLlpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=toxW1l6o7qk4lLV3uqECbX5YnhL9wHA+y1+IliVBuktNT7Dpjbl/n84nTQHZN0YFmUhpXAMWKeb2gSyNiW66UAITBPXnwcGzHwiJ6kKP8zSUV+UQN/AkA3gr2A8YoEoNQqq0rESx21sdBWxKLqaCiKqxIdH3Q3+iqDqiXyHdECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uNswyTfU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uNswyTfU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=XBq0no2Rd7WGrt8AoZwiXYr0+p0FJw+6NpIZTKWyHfk=; b=uNswyTfU2oYZHmrNpW7T9hFyCF
	s3NwNAOA107MrBTBHRE0HZX6LVVLBqggBdR+cjc7LnHgoWcDAXVCOz8jKgd5BNtfxOYwgQSH0OjzQ
	6ZuFWFz5vTp8K6ffOaJWMX39X8PxsFz7XGmxD7bv25CAWOwhHB/JHurQzgGC8i27JgsLfPdiTNOz8
	HfgpCTiHdMYmqpdB8YdGJSdGTzZHJtPRsX3vOhrSo/g1MnTglQDf3Mxd2BYvddku8qBUA760wNg9r
	dVyTPQ4o8DSnmpk6znw2lpfKNs0spfW84YRnOjDcLC5B4vet6kxg383GcrYumwEgaFaThA7dTmWgU
	F9eZO0wQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <fourdollars@debian.org>)
	id 1xBwph-009IoV-0O;
	Wed, 30 Sep 2026 16:07:01 +0000
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
Subject: [PATCH v17 4/6] spi: pxa2xx: overhaul teardown and suspend sequence to synchronize IRQ before clock gating
Date: Thu,  1 Oct 2026 00:06:27 +0800
Message-Id: <20260930160629.1822-5-fourdollars@debian.org>
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

When removing the driver or suspending the device, the clock must not
be disabled while shared interrupts are still active. Gating the clock
before waiting for in-flight interrupt handlers to complete results
in race conditions where the handler performs unclocked MMIO accesses,
causing PCIe Completion Timeouts.

Overhaul the remove, suspend, and runtime_suspend paths to use a strict
synchronized teardown order:
1. In remove, call free_irq() (which internally synchronizes any in-flight
   handlers) before disabling the clock via pxa2xx_spi_clk_disable().
2. In runtime_suspend, under clk_lock and only when the clock is enabled,
   disable the SSP peripheral via pxa_ssp_disable(), clear 'clk_enabled'
   via WRITE_ONCE() so that new interrupts immediately bail out with
   IRQ_NONE, drain in-flight handlers via synchronize_irq() while the
   clock is still running, and finally gate the clock with
   clk_disable_unprepare().
3. In system suspend, suspend the controller queue and use
   pm_runtime_force_suspend() to invoke runtime_suspend, ensuring
   in-flight interrupts are drained before the clock is gated. If
   pm_runtime_force_suspend() fails, resume the controller queue so
   the controller remains operational since the system will stay awake.
4. In system resume, restore the device state using
   pm_runtime_force_resume() before restarting the controller queue.
   If pm_runtime_force_resume() fails, return the error immediately
   without calling spi_controller_resume(), keeping the queue stopped
   to prevent transferring messages against unclocked or unpowered
   hardware. If the device was already runtime-suspended prior to
   system sleep, pm_runtime_force_resume() leaves the clock gated until
   the next transfer resumes it, optimizing idle power.

Throughout suspended states, 'clk_enabled' being false serves as the
primary invariant ensuring that any subsequent interrupt handler
invocation safely returns IRQ_NONE without accessing hardware registers.

Assisted-by: Antigravity:gemini-3.8-flash spin sparse
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b091434977af..2a3fa9ca7213 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1520,31 +1520,33 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa_ssp_disable(ssp);
+
+	/* Release IRQ before gating the SOC clock */
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
 
 static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
 	int ret;
 
 	ret = spi_controller_suspend(drv_data->controller);
 	if (ret)
 		return ret;
 
-	pxa_ssp_disable(ssp);
-
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		spi_controller_resume(drv_data->controller);
+		return ret;
+	}
 
 	return 0;
 }
@@ -1554,14 +1556,10 @@ static int pxa2xx_spi_resume(struct device *dev)
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	int ret;
 
-	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		ret = pxa2xx_spi_clk_enable(drv_data);
-		if (ret)
-			return ret;
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
 
-	/* Start the queue running */
 	return spi_controller_resume(drv_data->controller);
 }
 
@@ -1569,7 +1567,16 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	pxa2xx_spi_clk_disable(drv_data);
+	mutex_lock(&drv_data->clk_lock);
+	if (drv_data->clk_enabled) {
+		pxa_ssp_disable(drv_data->ssp);
+		WRITE_ONCE(drv_data->clk_enabled, false);
+		mutex_unlock(&drv_data->clk_lock);
+		synchronize_irq(drv_data->ssp->irq);
+		clk_disable_unprepare(drv_data->ssp->clk);
+	} else {
+		mutex_unlock(&drv_data->clk_lock);
+	}
 	return 0;
 }
 
-- 
2.39.5

