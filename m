Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C36F8E6;
	Wed, 30 Sep 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784433; cv=none; b=XXpKk754NtTAWusKwYrbtJNHZ5E1mQidmhmASlVVPMlgFFVNg+DDq9uh28Md7gJDkt2VYfNen4/XQng0PvM2+cHhxT/FrvQO88s9XnCMCeI0fhrOh9KI9GN93ut/AqHNCJ7VsK3D/vAGlOAXTcin5u6JoKztuy9HhEBs1yPqcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784433; c=relaxed/simple;
	bh=f3bGz4vJvRVmKwqlOkVDrITA8jXzvYc1Adch/QVRN7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUmi2xK6i5a6IsYUXXyEqERXvG3qML+cscxQWkV8PF7vEserzv/jdaT+6ZFFteNRPuXX18ywK2NIqwODILXDTTV06nNEkS0nL1LzLaeDwG/SJk41KzmTOGpaVfNuGCKgT4IY71KbPwA0bmAaCB1yCr3593gSbp2I/ftDq9qasDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ICn4PPhg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ICn4PPhg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=QVdJoTZrf5oVRzxuzEqtk4rKJA30YOVUw7GNyyn3X8o=; b=ICn4PPhgtTJvtdEKkmvnxcurZ6
	UXWsLiIdxjmkfaapz4YtRL7tLYHhbd8rW/XVsn46y4Xi/qJ76QTMLOLoQpYIHgISZYQM+yqNTcct3
	RLYq07+Z7CQ7gdjisfzECdVnpfewcrkM7qTuYWm5M/X3yWRQp2CuENOffvU4W28+xE0BfZ6Iy2xld
	QXG/ZgvS28dzawzAziMIssKmDSBGyeIaOcrhTalW/lA45iU+4aitlj1HzPFEmc6JfgDLSADLcOmUu
	+ajzMK1AI9eCeRnvWeu1ezxWS70mPeZlozpN9TkMy9EdG8ddnsBEn6oE+4OzL4PCLk7ZaEJdzvmZs
	MoclClPA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <fourdollars@debian.org>)
	id 1xBwpa-009IoV-0U;
	Wed, 30 Sep 2026 16:06:54 +0000
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
Subject: [PATCH v17 2/6] spi: pxa2xx: introduce clock enable and disable helper functions
Date: Thu,  1 Oct 2026 00:06:25 +0800
Message-Id: <20260930160629.1822-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930160629.1822-1-fourdollars@debian.org>
References: <20260930160629.1822-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Debian-User: fourdollars

The driver enables and disables the SOC clock during probe, teardown,
and power management callbacks. Directly calling clk_disable_unprepare()
when the clock is already disabled—such as when removing a device that
is runtime-suspended—causes an unbalanced clock disable warning from the
Common Clock Framework.

Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
functions that track the clock state with a 'clk_enabled' boolean flag
protected by a 'clk_lock' mutex in struct driver_data. These helpers
make clock toggling idempotent: repeated enable or disable invocations
are safe no-ops serialized by clk_lock.

Convert probe, remove, suspend, resume, and runtime PM callbacks to use
these helpers instead of direct clk_prepare_enable() and
clk_disable_unprepare() calls.

Pack 'clk_enabled' immediately after 'n_bytes' into the existing
padding hole in struct driver_data, avoiding additional alignment
padding.

Assisted-by: Antigravity:gemini-3.8-flash sparse
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 41 ++++++++++++++++++++++++++++++++--------
 drivers/spi/spi-pxa2xx.h |  2 ++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b11e30589074..a9d19d9a5343 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -713,6 +713,31 @@ static void handle_bad_msg(struct driver_data *drv_data)
 	dev_err(drv_data->ssp->dev, "bad message state in interrupt handler\n");
 }
 
+static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
+{
+	int ret = 0;
+
+	mutex_lock(&drv_data->clk_lock);
+	if (!drv_data->clk_enabled) {
+		ret = clk_prepare_enable(drv_data->ssp->clk);
+		if (!ret)
+			drv_data->clk_enabled = true;
+	}
+	mutex_unlock(&drv_data->clk_lock);
+
+	return ret;
+}
+
+static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
+{
+	mutex_lock(&drv_data->clk_lock);
+	if (drv_data->clk_enabled) {
+		drv_data->clk_enabled = false;
+		clk_disable_unprepare(drv_data->ssp->clk);
+	}
+	mutex_unlock(&drv_data->clk_lock);
+}
+
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
@@ -1288,6 +1313,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	drv_data->controller = controller;
 	drv_data->controller_info = platform_info;
 	drv_data->ssp = ssp;
+	mutex_init(&drv_data->clk_lock);
 
 	/* The spi->mode bits understood by this driver: */
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
@@ -1352,7 +1378,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	}
 
 	/* Enable SOC clock */
-	ret = clk_prepare_enable(ssp->clk);
+	ret = pxa2xx_spi_clk_enable(drv_data);
 	if (ret)
 		goto out_error_dma_irq_alloc;
 
@@ -1449,7 +1475,7 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 	return ret;
 
 out_error_clock_enabled:
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
 out_error_dma_irq_alloc:
 	pxa2xx_spi_dma_release(drv_data);
@@ -1468,7 +1494,7 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	/* Disable the SSP at the peripheral and SOC level */
 	pxa_ssp_disable(ssp);
-	clk_disable_unprepare(ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 
 	/* Release DMA */
 	if (drv_data->controller_info->enable_dma)
@@ -1492,7 +1518,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	pxa_ssp_disable(ssp);
 
 	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
+		pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
 }
@@ -1500,12 +1526,11 @@ static int pxa2xx_spi_suspend(struct device *dev)
 static int pxa2xx_spi_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
 	int ret;
 
 	/* Enable the SSP clock */
 	if (!pm_runtime_suspended(dev)) {
-		ret = clk_prepare_enable(ssp->clk);
+		ret = pxa2xx_spi_clk_enable(drv_data);
 		if (ret)
 			return ret;
 	}
@@ -1518,7 +1543,7 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(drv_data->ssp->clk);
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
 }
 
@@ -1526,7 +1551,7 @@ static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
-	return clk_prepare_enable(drv_data->ssp->clk);
+	return pxa2xx_spi_clk_enable(drv_data);
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(pxa2xx_spi_pm_ops, SPI_PXA2xx) = {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 447be0369384..3352239f74a0 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -66,6 +66,8 @@ struct driver_data {
 	void *rx;
 	void *rx_end;
 	u8 n_bytes;
+	bool clk_enabled;
+	struct mutex clk_lock;
 	int (*write)(struct driver_data *drv_data);
 	int (*read)(struct driver_data *drv_data);
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
-- 
2.39.5

