Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD22FD1C2
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355075; cv=none; b=ujFISuzNM4Ys/p7pCY19/A9X1IyLgeXwKGSH1wsBIgnx7OJrVWcE2dni19z8lX8bLkLMnfxMb9dOa9qogT1ptnlvLGee0nIK9GlXex/JGy2mKm33p3kambN0jsEwCzVo+05rfOLZYrYv6GS2dUQjwccmqwBxuKTUFuwch+qNNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355075; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgbAz3sltYnDJV1HtifESSnll8yIXxiSCWImj5423ttyMSk/MKRM0UH2jrNgsLG5x/zM1QBJWPmhnLkWkuv0zpb78NWFdOKYT1Iiu022r30zICJVFLZy1VXdcY79KxUvyP+kDrJha2IHh9Dyq5H02TCj94Av3WG4uc8Sf9SSRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab973140bso105282445ad.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 23:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784355073; x=1784959873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=JS5NDs0yEBpUvP8MRZb0zEEzHlMhH3YaLsYn+eXcOz34/Kjhn6gX9KU4W44UDyfWpY
         SZI1R7ySoL5kzGNZpJXU1n4PaM0ltuYACsseIiyufjkyKsTRObwwQiiNXj6KdQh7MwEE
         nsOIsCZ52/IPhN9zn1r/8H8FE7xnj2digLekp+R5i1kdnVMb7ogWFtczjl2Bygj3tmUO
         j4q7O2I92pHDLsjVmmLOKy0ry3WW8Pedsgzww15MeVgzjzW3QOvoSL1eHMyxIwp09t5O
         Yv6BNDLCgz2pjnv6wj2levFqiNaPC4kMOy0JKN/5/9X66i/egkQd3PpIQoIWLTxOA5zP
         joYA==
X-Gm-Message-State: AOJu0Yx6Of1hQTHsI9s33wm96LiM4SnWUCq/heTytL6Vmyqf4IPlEVKs
	1If7GW76NjZ1EdtmYgLTlBmylxrSM6kMv3OPKkR1VlK4YnCTpz0iEFk=
X-Gm-Gg: AfdE7cnx+CnCkYq42jYFPY/EfI5Qdn4Z67HI8OR1eQ8XTn4XkBmCuimV7vRRycvzED6
	emGMva1xLpZrcFWX9QXwdvmjBOuVdShyNzLYy20eWOxjKlwwrwy45CIScDWlCBQqTPRAI04ajnC
	9tlMJ9/jCPhBD4JPrnRU/9ncrEQ5572JWiNygFMJP9Z/xmnIG2FqBrx/CUznSaKC1+d8/mvKesS
	7lhwRaI42FuSBnB0YC8RmDCa0tGDtMiURVSt9PZDDF5oGm0wZjLfIa2YI0qiM8wK078tfmQ4nmQ
	GzDYRZFQD8PCTdS7TwZsl/w8UYPtsPRwhJnCaZW+j0t9R9WQI2f39VoolraczdfkC8yYZU4K1NG
	DLlvqZ6UNa+nZjssCn0lTxN9VFqO+RU5iHwyO2i1TvI6Zxjo9ABdUkvTaTMnU2UMTmT0GWPYUxZ
	XNlWuI0IRz3zpJhEqp2a8T9pyzrzpdl8SytwAuDjCLEGz/59wNzpQBh48g41FnarlMFhPuVO6jg
	Ig1gjWQeqCGtb0=
X-Received: by 2002:a17:903:1c8:b0:2cc:f7c6:834e with SMTP id d9443c01a7336-2cf349a3e33mr62796625ad.32.1784355072648;
        Fri, 17 Jul 2026 23:11:12 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db04csm22799025ad.42.2026.07.17.23.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 23:11:12 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v9 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 18 Jul 2026 14:10:54 +0800
Message-Id: <20260718061056.30961-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718061056.30961-1-fourdollars@debian.org>
References: <20260718061056.30961-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 suffers from hardware DMA handshake failures and interrupt
routing bugs, causing keyboard/touchpad transactions to fail when
DMA is enabled.

Move the forced PIO mode DMI quirk to spi-pxa2xx-pci.c (the LPSS host
controller PCI glue driver) to avoid layering violations in client
drivers (such as applespi).

Add an explicit DMI match table for MacBook8,1 and a module parameter
spi_pxa2xx_force_pio to allow forcing PIO mode on demand.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..31bdaa096d9e 100644
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
 
-- 
2.39.5

