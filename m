Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEF42A16D
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298989; cv=none; b=KgRTd/gN0rUiR7n0DW8gjVd8/1K4gEg7Q8qmE8QDZAZB+UjGiUpuFWTX3tLTtzjpUFxMiA+oUaiF9KtvF7ikYQ2ICXybQR2rOX9I1lmJTkEV9JG6+latSY50KEz0t/AC0jenKV+ICpuqRLWgw+mXRJaVOPTRyweHmSnG8SmeY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298989; c=relaxed/simple;
	bh=cWqs/xM2NprZgZsHcWAq5boJInsoGn33q+s2JuodFJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kX05oYp48UpCdar+1n4M+eNjnFf52EBTjzFuFy884LhRcMWSfqLSNY7sjWW4SXS4gEBfdHEIruKwAHec9zG8vL0cuY983qp2FSXWCT0Ko6BxYMNV45HQbx35k3AIdXeIBZWL+gDq5BmmiyDDij2whnxqTv6ImBNkCpTaTuN4bZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdP3vroJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdP3vroJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caced6038eso24060015ad.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298987; x=1784903787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/Iq76p+Cd5De2qDXnt7YXrGOFcOFv7tn5csU1+2pLk=;
        b=mdP3vroJu4ENOLXdaCZIAEJkgtpgUjIS/679P7unjM/KZNe/bGCgxVamBz5DBdTbZq
         nSaNuu/xYTBbOZ3Uwc508neSGUkphNN3+jZQ70kdXPquOxgPZrxScp4xqqIa/1VmdNQI
         IZXc/x8U6Ud8n1InGbaG3qIylYhCyHrcD3QzEOXT2Zy4Ksw1S4OEyNNy01Ef7U2clkz4
         RlAzbsgp4Mx7NAoe/k44AC3jw2skAwOTU9xv5IkUYkLCVlsUbgF6zDqIY839liit3MOF
         7VAK/pAH716KWK+3e1B5Clt0cMGUYxy1xRMVvMtzNvb6tHOcKw1Y8ENXiR9yo1lRSMT4
         LpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298987; x=1784903787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/Iq76p+Cd5De2qDXnt7YXrGOFcOFv7tn5csU1+2pLk=;
        b=Xeh+LuhKuS4bzu8w/h8xhd4KofRPitBowJQB/mu3lQX3IXC1kxD8CvB45wEko7UkJx
         tfoUZEYcfCeD9VjTahkMltaFNPhqlR4KIbOhFsJJbfNdrK8ENRyJcvDlJMyOdzn84nAV
         9RxMx8kIejWNJOsNneQepYN5zCgts5BAzmPjnLu+meHl1O3tMbKCjjJiG3XLnlxXarx/
         8WllKQYqUucgbpTxw6TM7YauZ9nSL9v6pur7LeBvB52Vy8MzVVZ5f1m2MEmsIzwQp7Ic
         hJNeFXQPtdpBUcWFTWN1vFPJj0xgVajkBBgZ7AqCQ2NGWUtp2cpuedMjQ3818TK98ciA
         VUEw==
X-Gm-Message-State: AOJu0YzTdf0aWa71hCLbF/hckIAV4j2by9ApKvmilPDk7/uvjrdQonW8
	ssjpK/6oPDvqp2LLaLwCcocXKu6Wm0Ok+hPQ91m+qDSFm29LEhrjtJU=
X-Gm-Gg: AfdE7clyMWw8FRHrITKnMemEifvRWPSR42d2AHdY/sbFvCCHTQnPznX70e6tDywtxNI
	skwzDp8q46LUZYWejuYZy0KPeFqkkY1hX6sIvXbccXmLbi6J+FKxD9eK8JlfwC/rXD+UaM4g+5+
	uDyOZ7OhxAYYkfmdaZzhlHYJCSv9SnknBGe8z6Zk9QX0ZfPkq7On4+y/bmUB0UgyqyhUIJBdKXr
	9yBsPBMv85kb3QUoNcDVO2ar9IWsjT3cv8Sr0mgcKt/TMD5RELy2jc1Zl6J2MgqOixV8Kt/BoqV
	pIGUOxTfevWZbab0qDnLNemNZ43ajz/WL3vOcMZgLIFlZ4fPHJtjk7sNyzj5Aog9ghvg7HMNxRS
	BcL+RDWD1ZyaxjWTL32NMoTFIzTGYDbVm8s+SPTtoznzfMe5AIUVM7hS7hPTVj13NZyVgyqb9FS
	mWvqncVpYRJNjE9J7eaQ2n3XgINP+Ota+REZsB9LQQHzIKRKgpdV4cI5trkfUphPpEHk9rf0WLB
	ua0GJfVMS8utA==
X-Received: by 2002:a17:903:1b27:b0:2ca:16:c169 with SMTP id d9443c01a7336-2cf1f2ee1ccmr78657245ad.12.1784298987071;
        Fri, 17 Jul 2026 07:36:27 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9bd5sm12145695ad.45.2026.07.17.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:36:26 -0700 (PDT)
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Fri, 17 Jul 2026 22:36:15 +0800
Message-Id: <20260717143616.4765-2-fourdollars@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717143616.4765-1-fourdollars@gmail.com>
References: <20260712162420.7453-1-fourdollars%40debian.org>
 <20260717143616.4765-1-fourdollars@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shih-Yuan Lee <fourdollars@debian.org>

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 has two related problems:

1. The DMA handshake and interrupt routing frequently fail or time out,
   causing the keyboard and trackpad (driven by the applespi driver via
   SPI) to become unresponsive.  Force PIO mode to avoid this.

2. When DMA is disabled, runtime PM autosuspend clock-gates the LPSS
   block between transfers.  Accessing its MMIO registers while clock-gated
   triggers a PCIe Completion Timeout which causes a watchdog reset.

Move the force-PIO DMI quirk to spi-pxa2xx-pci.c (the LPSS host controller
driver) to avoid layering violations in the client driver.

To prevent the PCIe Completion Timeout crash when operating in PIO mode:
- Only enable runtime autosuspend in pxa2xx_spi_pci_probe() if enable_dma
  is true.
- If DMA is disabled (either statically via the DMI quirk / module parameter
  or dynamically due to channel exhaustion), call pm_runtime_forbid() in
  pxa2xx_spi_probe() to permanently disable runtime PM autosuspend.  This
  prevents userspace tools (like PowerTOP) or udev rules from overriding
  the setting.
- Call synchronize_irq() in pxa2xx_spi_runtime_suspend() to wait for any
  active handlers on the shared interrupt line to finish before disabling
  the clock, avoiding unclocked MMIO register reads in ssp_int().

Avoid duplicate can-DMA pci_info() logging by checking the pre-computed
enable_dma status in probe and passing a verbose flag to can_dma().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 47 +++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.c     |  4 +++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..c107b3b53d33 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -18,9 +18,14 @@
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
+#include <linux/dmi.h>
 
 #include "spi-pxa2xx.h"
 
+static bool spi_pxa2xx_force_pio;
+module_param_named(force_pio, spi_pxa2xx_force_pio, bool, 0444);
+MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI transfers. ([0] = disabled, 1 = enabled)");
+
 #define PCI_DEVICE_ID_INTEL_QUARK_X1000		0x0935
 #define PCI_DEVICE_ID_INTEL_BYT			0x0f0e
 #define PCI_DEVICE_ID_INTEL_MRFLD		0x1194
@@ -93,6 +98,34 @@ static void lpss_dma_put_device(void *dma_dev)
 	pci_dev_put(dma_dev);
 }
 
+static const struct dmi_system_id pxa2xx_spi_pci_dmi_table[] = {
+	{
+		.ident = "Apple MacBook8,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook8,1"),
+		},
+	},
+	{ }
+};
+
+static bool pxa2xx_spi_pci_can_dma(struct pci_dev *dev, bool verbose)
+{
+	if (spi_pxa2xx_force_pio) {
+		if (verbose)
+			pci_info(dev, "Forcing PIO mode (disabling DMA)\n");
+		return false;
+	}
+
+	if (dmi_check_system(pxa2xx_spi_pci_dmi_table)) {
+		if (verbose)
+			pci_info(dev, "MacBook8,1 detected: disabling DMA to force PIO mode\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
 	struct ssp_device *ssp = &c->ssp;
@@ -166,7 +199,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev, true);
 	return 0;
 }
 
@@ -238,7 +271,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 8;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev, true);
 	return 0;
 }
 
@@ -300,10 +333,12 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	if (ret)
 		return ret;
 
-	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
-	pm_runtime_use_autosuspend(&dev->dev);
-	pm_runtime_put_autosuspend(&dev->dev);
-	pm_runtime_allow(&dev->dev);
+	if (pdata->enable_dma) {
+		pm_runtime_set_autosuspend_delay(&dev->dev, 50);
+		pm_runtime_use_autosuspend(&dev->dev);
+		pm_runtime_put_autosuspend(&dev->dev);
+		pm_runtime_allow(&dev->dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..f9dde4b28c32 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1351,6 +1351,9 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		}
 	}
 
+	if (!platform_info->enable_dma)
+		pm_runtime_forbid(dev);
+
 	/* Enable SOC clock */
 	status = clk_prepare_enable(ssp->clk);
 	if (status)
@@ -1518,6 +1521,7 @@ static int pxa2xx_spi_runtime_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 
+	synchronize_irq(drv_data->ssp->irq);
 	clk_disable_unprepare(drv_data->ssp->clk);
 	return 0;
 }
-- 
2.39.5

