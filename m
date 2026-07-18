Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AB3D6476
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386337; cv=none; b=EMJO/Mfd4nTk/yo7Sh9RjeLs1f9195nDOSrVRnTIx7J9EeyJOLfDQtI1e53jn88Qr0NCDV8wbjmO5mpxWkQ5Ge55iO+KWRd8eadGLkoi8bQVTPAv6cAIVDhDlVbQpqBKVww3XQFjoWxwozqZRwYCQo3ciNKCS+g0ExyMM5FIDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386337; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1lZkTKPrx58PKwsrnLou+mx4ydIWgKzc3GeRv3gcNQT/2IqJ+dnZVBXo/TLwvlPYR4ya02Yb5W+xUqGEyx8tO4FDLgJrucAImH0nwC6QqaqQzxAEagwPA19Xjm3gZLzMmN+HKQ5/aUscQjxO7tAGS8EFnvf4GID55oC969gA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cab973140bso108222005ad.3
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 07:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784386335; x=1784991135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=D2tV5xgO3Rl3syNi/6gD/0I0lymyE+mJuoePUWlmzaI/b9zT6yR3Wh0NdZsMN+ODA5
         tuWlSGe6tU9+6w/PESVPeATv5GuSNlkLgy4WG6WG8LAc0vvuBeyqLiXOGNJyPaRN946K
         DcCCsyKPDdoO419P/E8h29ftmztwZGybbSGiFmWlMmQkFY5W3acuRudzAU1eyVZLcAYR
         w+BWAzcrrDPQWso7gotstQgeLYyLo3tnOJL5w5BVS2WsYFSzYKTEwJ86CpXjTVm9ShiY
         3znPJPO4KFvL2s0m6mlvwokW1z7K07yLneTB06vmpb/6piF0iSDVJvsnRk2W/flVzcw3
         FxSw==
X-Gm-Message-State: AOJu0Yz6WWl9UI02dQKstrt35FqkklwLIhZ117GDVxFOD6Lzg28OkAC2
	z2UYWMFEK0I3/e6RHGx/sxdN540a2n2dDlmA2wVZORmpjU9pMQhGtmg=
X-Gm-Gg: AfdE7ckDQSuMUTMYvZwDwAEdUS6Z5otvB6MA2dIAtBoV8FI4+J2If3T/DGdZgRHJbAP
	YF9zGaF0XieA4iAMsOiArJDDL+hID884VPA+DC2GFyv2Kfuy1BrEpy1sDG/Vc+oJiW5K3Je14oJ
	/NY2Ldale+oX0cL0sfsHThruUEqrEyMjxOVDKMPr2GL2WVTz5CcPG+TE+YWdmIOn5U2ZrfplPoc
	EJb6r8xfr307s5pqZC1m+dLLEaawOpE4lnCjRCk9uSf52W+Qj9Id53GsAXVm4gzJA/r5PbD6uOE
	pwlfMnl6oYvCER0kRgCuygGbk4RZeAnfqNDzPyHBxF8PvRRE7Vn3bTje2zEjP5jNltIjupDTIHU
	gE6SrVPRZ8WXdtTIMcFxmElart2ht7dS9JZEQyysW22KKhusG+SaqRXTfpRxC7m9Ln3kWuLIETj
	c6wlOU05vPOW6ETlnnXuupmIkgLWEYbcA+dmTVItJncHADzDCijgXi9AdeoA04f7b/bGLow2Puk
	OfKVhFvtYNkTPc=
X-Received: by 2002:a17:903:b08:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2cf34835859mr81905665ad.8.1784386335317;
        Sat, 18 Jul 2026 07:52:15 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3477eecdsm28084155ad.78.2026.07.18.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:52:14 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v12 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 18 Jul 2026 22:52:07 +0800
Message-Id: <20260718145209.6678-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718145209.6678-1-fourdollars@debian.org>
References: <20260718145209.6678-1-fourdollars@debian.org>
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

