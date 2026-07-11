Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE83C140D
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775519; cv=none; b=WxiJXmHy3LbxxdNvdIOoMV2ztKFXrWjAynxBXev4biJJplkzmZzx4ibpD0l1ztw6dOqo28QvQu0WyiMXPVRprC93Si5Z0ZOIjh3IOYpAFDUFedH1grEqVAKCbsEJZUvAMLchimv+xSGsgW7ETMt1ERb03Lzck6HEONwLOA8UTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775519; c=relaxed/simple;
	bh=YRU9k1lERNTxkTc+5YgTqgr3AgfJ0f+mJ5crHfuI4jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zh714EUhFJ0H44WsZAVkYXqerW3FobMpslSV8BvzBWI6xOU/891WVAxqLK2To1+82DOypx6juTCD1g2JjgeW/Ne/zz1E9LmK3ga6y0XH+rzlIa0Ub+xDv9A1Fu3EL30+eVVyalAUVQfNU62102ncLhKP5snEu8NFlc6WD55F8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so715934a91.0
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 06:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775512; x=1784380312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kc4/WVQy8fssVht4RAYrhTn5gJQpHPueTRIgj0gLJ/A=;
        b=WKNdoTQ74wtOKPYzQFy7ONHl0ldm3Qmp24YxCINQfF1dewrYfI+lapqIzfFExszDNz
         gVz8seUeaZh1CxETgbthrigfrzvmGVClUqlMBGHPs8R1R7qwUxFYiZ/RVKhvyU/HS3vP
         VvXMYZAvMIMp2ZUqfjF7u9QX2Jhd7ot7AFRLxp0OPEPTrAT1jRVcm6XXeumu5s8wHG+E
         Kz+6aeOpx9FNJaoTjqpm8Bi4xCOZ4jZqykjxhZKIkg/u7LB4GIeeNddsOx/jEGgNdFU2
         P+4ELRFchHgS4+mIKuRwtACGfxkEx9GjFBPeQZsR+wpVSncztcYrbEVxyVLG90nK4/0l
         Q5bw==
X-Forwarded-Encrypted: i=1; AHgh+RqQxCQsPwYREZ7RNMCjcfSXJtNwBAa8vKfoYZuwIPKiqTRy0q/ewvqL6R0Yx/wp1vlUEUIbhCZE9rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3+jY32cGkp5Rg4GteWDcYRON6X1ReugedbGCFdAi0yPujZKT
	M3y9kFgAbna/NAjvm/WN0goksPmMy1WdOv63K8fv0rKv5NRRiXHCvCCHPq/tyIts0g50
X-Gm-Gg: AfdE7cnIkakuU8Ljn7St/C7+4tvOKmbkcjGdEBVz76lE3zMew7ZKj3bChFJuVtWWJrT
	PU2c+0rAs2VMa/OmocybzuL/d8Re2K14J4Ox08qwrQVf+2se7IqwIIuMyaJUEr5d7GXe2wwRlE6
	co8S0vraMIXEvcFOOV5mDaVpNjuF5eK1T1C9Ybi0aK/oby90MG6TjxV4r/ORS1vmXaRM/i57tUQ
	yRu+a0b/LByC1DO6qFHkVTCdczJh+9g3cFd98rNso7ZT/uCShPi+JMHzWfMiFVtffQNJxGYscDu
	6r2601OSNOnFU6iVon6xvo7Zu8mes+NmdOWkKHQRJRo8VqmBmnK3139ePH7MZyLLWk6UWRPQPto
	wL+J5o0oohyvIdpiDbJKFo3F1Zb+R4bqZStzftA4CvNpIdO3EvWByeIM80gZZK1MEICql9v4Yr3
	QTrDIL1oqIEPcWeye7seecsl45ULzr4UCAqKuZ29EC/kWt0Ua0Ax1Fbc5N2Plw8iUnb9Ug6KD/4
	NZidukYjBVodRlWFUWGXXS+sg==
X-Received: by 2002:a17:90b:4a81:b0:35f:b6a1:8d27 with SMTP id 98e67ed59e1d1-38dc75e184dmr2909302a91.18.1783775512460;
        Sat, 11 Jul 2026 06:11:52 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:51 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 11 Jul 2026 21:11:40 +0800
Message-Id: <20260711131140.18777-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out on boot,
causing the keyboard and trackpad to become unresponsive.

Avoid this architectural bug by disabling DMA and forcing the SPI
controller to use PIO mode. Move this platform/motherboard-level quirk
to the SPI host controller driver (spi-pxa2xx-pci.c) where LPSS setup
occurs, preventing layering violations, TOCTOU races, or execute-after-free
bugs in the client driver.

Additionally, introduce a `force_pio` module parameter in the PCI
host controller driver to allow other users to force PIO mode for
debugging.

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

