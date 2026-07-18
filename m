Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410E3E0236
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784390838; cv=none; b=lcee0bitEtBfhZjvKTOV7LsIPC2Xo7bnvBXxBOeNb6/p5prV6vsV6WnNXPfFap4saI+XlZ7NqsM8yuWMjtSzNNWlq1C/b4/GVzLkTGWkrYKrnudVstWL7r9DaJ/+Kst2VqFInEoshYD/IXpfH7vPaJMWzXCyuEfpd52UIoAnW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784390838; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jg9pPj7aDMxAwVgU0VhSM9VU2u5Pea2JJ10e6uU9tFiT8KOt7N2cNxYexfF0NLKvTYn449u2OCC89/K7rqHdkmA/BT6ngtbLT16b20QuyY6F2Lp7KFsu0AVlg29Ny3KleC8hf5p56Oij8bxOFzPyMaO58+bXRSrr2oIZEoxIJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso28563015ad.0
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 09:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784390829; x=1784995629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=kzCl5nKtTrIa5vU4+gzoqs3QMrFRH/eBSsplnxB6tiYL4oaAoq55ZKt+DdbksuSHzI
         SVavk6Fs4d4vhDlfCGgvYoLmXiIpsF6HCgzxYNa2x4t227v0tpAkc51mg9mOP/LHNUjC
         6lQNCa3d7M5otp9eBAcX+GncQQ6gAqwNKHxB2JXrmHOnmz10gbXahzNHc9Gv4jx+387H
         NXKyFkjBuhFN0vxZ/y8L0vezIU5BKjW/kVJl8jgfcYH15UGlsUalmAAevKgk0dO9IZQQ
         CFsKeM3yLC/HN2FCuWBozHqAEC3UhHhDGltFqMK6F2p/AAlF2OYfCh02SHR1Acvh0oHo
         3QNQ==
X-Gm-Message-State: AOJu0YwnFNDa+SKa7BQDg9Cav2F93rGHG02Xbit16N1VE0q6bw4kDeeO
	pmHkzK7nlYyC4XwQ9Z+7P2QT4Nq/ggVBhyO1SkomQyBXzxqIgMl7oOo=
X-Gm-Gg: AfdE7cl20Eb/HsvVazRcoCntKf9Mm5MdMCINfs0bccjeACVfNUuW3JTszD9EyQgC6hz
	vZCqckTefwfwve+r3LCfj3mTq1uBEJE8K8zKw8zrBvYyraEhF6N7fT62HaQXRrtHu+P/uOkSNXC
	RcE+7UwPe8MCYit98kYIFHsIMyleRYtGAVQDIaDNBZI03xR+GTEep+VUbqLJhsNbuBCl7p6ktok
	Q7jGGm+bddFphxa8x9jCVi29eKUm3v71rukRTJUoyQrGCo/3v4HWOrv/BhE2KDVcD+0/M7ale57
	NFpSHFzKw3uw0KUd0fa1skpOgeTKwgJ8LKrh80byCruHTDKuZin3zslvY9JEPt5acnQRHNsZlob
	5ErIS1/3wxl0XakpJPtyB3GOC9gMSbbmtQQgOUqqZlfrcWV64KaMqE64yGlPubErn+VjYo56F1k
	jQHujoYtlEOhsVyvvylyfqk/3WsuvbuHLHCqUDq8l/Namr05O4tC4Kq2RKOLh3KY8T7n3R2pOls
	nYdX0egxzoReYs=
X-Received: by 2002:a17:902:f683:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2cf1f2561eemr117409905ad.2.1784390828783;
        Sat, 18 Jul 2026 09:07:08 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b16d4sm28996715ad.20.2026.07.18.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 09:07:08 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v14 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sun, 19 Jul 2026 00:07:00 +0800
Message-Id: <20260718160702.7861-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718160702.7861-1-fourdollars@debian.org>
References: <20260718160702.7861-1-fourdollars@debian.org>
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

