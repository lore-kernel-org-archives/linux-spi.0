Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B1356761
	for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873516; cv=none; b=R1T7TkR5r2IVZfHRkdSDJtA97vw5zQVvv3dsEYfLUNiwBfV0Nir6uMxptiDxINjuA9foBV9Zx5S8E3pY/nWKa79DRG9GqYeEjFEU1WIwK6QYSgzgu8jzR4Zyg5Yi25fl2dVdjH+oXO16qfm2/uVzYiQcZH9OQ+bH++GoYMCWB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873516; c=relaxed/simple;
	bh=o2Vhi7GivQSf2+k7EfqeLt1YyVoT3zZsUCJbqV9r+oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQogd4/wP+MAQiLspnuci4Bp2arpTuFYokSD0sCSJn4Xlc1sWsIyBt19oqwH/SbQeuhlybhWmz4d5O+dfLhZhOL2cpMPydmqYxDlQAYw1xxRjvAyhpms71z8Zz7s+TPFUBAIzHTQcxMvMzrFxHWPESbVN7XabZi6uMdsf43Yg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1386305a12.0
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 09:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873515; x=1784478315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K78DbQmH0SJ594fefmYwIC8GEcVEilCgoWHJzZIgOoM=;
        b=V6dBpn4AHwbbyG2z5S6CzEA1ZNWJSQ+ZTbXEZbtRtE0u4wtt9DwO+xKSjSP6tcKt1E
         uK5/04lxJwQTsr/Zc6uYLbnJC1ejJFQxPOsg6NXF2jKjkGMTmk614vH24xpUm29fwGe+
         GHXCpgcEJRyUVToBQYvjA8kx3/uyG+0qSNQqQ4giwMaD3HSVM6/8oCLyAgdvXeAL4FB/
         /PUFfa1rYOwg4clOBhj/cllXfGTo0l9oVTMupeg7GqGakicHw2cQeIi+lpwu6ppm1Nv0
         sej0UvoXTMUcoAwquEwPI/kfhD/BL5GPUuDVCOC71RF3Xnl3TAw6d+pZbtawIoIMAiJA
         82JA==
X-Gm-Message-State: AOJu0YwfUqvcjyes9A2A4IylsmMLxvCUewIQX4m/J+f7QAc8D6L+Nmqr
	+Tie0c8FlpiTxIRvMvTFMbkuhkRwSbgJ0ODr+bnYXz+3IN5Ss7pzBKs=
X-Gm-Gg: AfdE7cmTmf2VlWBUrq1KePMuAf0CSQK5Ze7wqEARqicuNDNoLCZtmBH2dpf/2Q/wPb/
	QNJpXg0o/4vCs49i5YpWIk2NDa2ZU12iwvlNS0RjygSAdU9NqSfI3ix5X0LX2pXvGgATI3vySh1
	/kdimDxg0oA1L/3f374v1SjjyC3RAVrpnS1/2ry2ibuRRrfzCxTszVQMRzotgXXUSHZ8Fi8nYSC
	t64P6tR/vakNfDnluXVT8ivmt7vyXNvKXWGM0mtgm/xBUDQRSxlUhuP3cZktKBj8MDmvSRotOFg
	pd0DTqfK9Lv3rvt0Ptd6Td8e7fbL7KDL7tdh1l9NTufxoepQ5lo98AEPa+Dy8gHWBrDqZtDroFN
	K0Q+LtebT34yqbAesFwXyuY/XdYdz8r5ONJ9wmWHAwtg6MFZy5eUfwxb3a0ON1qFfI/KdIVCPik
	sR82PihsyI2tn8TnXUXwMV6L5EVLRS3vlaST0kRHqFAuXniFh+iwmSkqJTwTIW2loJC7JvN0Ag9
	IL2WQebtu+zuH6wWySge224Kq4Q
X-Received: by 2002:a05:6a20:3d0c:b0:3a8:800:bdf4 with SMTP id adf61e73a8af0-3c0f0beee64mr13024754637.33.1783873514864;
        Sun, 12 Jul 2026 09:25:14 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm12329887c88.15.2026.07.12.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:25:14 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
Date: Mon, 13 Jul 2026 00:24:19 +0800
Message-Id: <20260712162420.7453-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712162420.7453-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 has two related problems:

1. The DMA handshake and interrupt routing frequently fail or time out,
   causing the keyboard and trackpad (driven by the applespi driver via
   SPI) to become unresponsive.  Force PIO mode to avoid this.

2. When DMA is disabled, pm_runtime_allow() must not be called for the
   controller, because runtime autosuspend clock-gates the LPSS block
   between transfers.  Accessing its MMIO registers while clock-gated
   triggers a PCIe Completion Timeout which causes a watchdog reset.

Move the force-PIO quirk to spi-pxa2xx-pci.c (the LPSS host controller
driver) to avoid layering violations in the client driver, and guard
pm_runtime_allow() with the same pxa2xx_spi_pci_can_dma() check used
to set enable_dma so that PIO-mode controllers stay permanently active.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 38 +++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..cb61f1d2d9e6 100644
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
@@ -93,6 +98,32 @@ static void lpss_dma_put_device(void *dma_dev)
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
+static bool pxa2xx_spi_pci_can_dma(struct pci_dev *dev)
+{
+	if (spi_pxa2xx_force_pio) {
+		pci_info(dev, "Forcing PIO mode (disabling DMA)\n");
+		return false;
+	}
+
+	if (dmi_check_system(pxa2xx_spi_pci_dmi_table)) {
+		pci_info(dev, "MacBook8,1 detected: disabling DMA to force PIO mode\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
 	struct ssp_device *ssp = &c->ssp;
@@ -166,7 +197,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 1;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev);
 	return 0;
 }
 
@@ -238,7 +269,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 
 	c->dma_filter = lpss_dma_filter;
 	c->dma_burst_size = 8;
-	c->enable_dma = 1;
+	c->enable_dma = pxa2xx_spi_pci_can_dma(dev);
 	return 0;
 }
 
@@ -303,7 +334,8 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
 	pm_runtime_put_autosuspend(&dev->dev);
-	pm_runtime_allow(&dev->dev);
+	if (pxa2xx_spi_pci_can_dma(dev))
+		pm_runtime_allow(&dev->dev);
 
 	return 0;
 }
-- 
2.39.5

