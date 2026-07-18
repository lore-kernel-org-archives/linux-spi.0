Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED71E2858
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383247; cv=none; b=MA3KGaEUNFUF49gyo2yYh7YrepKmNiTYA8TdTaI91LvH09nBlptU89HIU1F9+QrMjFFs8zPXZ0mnvdweWQ64Gy03PM85eplbftBRAbx1pxL26FBvFPkmJZNfr+8WUg12ohVm5a8Ido93DIdxDc2CwFHqkhKeDIoPU4FKA4o9k4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383247; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6Hmr7l8u/ZCW+VwGrsJpKmZS58QjsRQJFFJAeSWAVZJBXLfsK/Mk+GxYoOE+ZyvpiJ4nxuXxvMeGQ9ntRNYRptz28Bzc75hPSuXSlF2sOu6vriV0nPzJpWKvv4nXfuJ662sHGNs4oTZMoksqrL6BJrcb2mHf+2/mYtkyGUFn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8484f229529so3715619b3a.2
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 07:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784383244; x=1784988044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=fmAIw6wLdxIX7YWQr49NyOeuAkeRaFyV7c8Ydj0SyWeQz3OSpaZFPqsQQdHvnL5bvn
         tP8ZeWp1ZCs1GMFfXibkrE96fERiPsFD/ARKFMv92u1W0vxm6nAMT7EPlDtET1ECGTHg
         WpkJhxK5OavKSZZdi9DW4BbFXOKnGL9PPqs8YCHaJpwGuNRXegr4kLteXGQo7hItoFXs
         Xw/A/SKEt0s2PNVBG4hMlhfihkoQ9coaMKRXA1dWNNNO1BKh2SH2xcOLFXZuphkKBuO+
         O70BK0ipKWjYDy0v+H8vV0572CK3P+hyfBJX66VpVyfojNS3XYOH+sp2oNfAwcYrd4FJ
         ECpw==
X-Gm-Message-State: AOJu0YxrKeK2jP+NO/SdXUb9zS5MbWu5A9Dh5HUedNpFRIXCGMz6vRcW
	NhjxKSOxqQQyifmmTfPphtHglm5s8AEP57e0URLKCLKPdXEy2G6f/iKpSqn4hOHy7A==
X-Gm-Gg: AfdE7cm4FWYW/WYNI+a67SCjalTFBdxEWLjN+My94vUFyh12215G11revnKa9sKQ1nY
	bGjYjs2myikZBcUFXPU1J6Stek1FKEcQpWGu5ftByhpCqvecpIOXL9aAeWPUNteuDcU6WX46H+g
	XSAUlO6+o2UhfztcRXeTP68l3tKL0rCNOckKvyPhgs7nw5GvfOgT4wZVU6gSQEAkiQ6JGz+8M8L
	GC8iOaeLlNDIQjBBtzkoOZN5nk2Ym23qqhRp43U0sX9ftROJlzvc0ZN4m9FXSU9GSHsO8cJGvB5
	krYHecSosAg52sdLEvJlfSbwRgmTuIHoBV+tlDOXgzbWi21Xp8oGjbBTbwn/j6XOkUM4O8asUAt
	bw50+/lbwo9eR9mpFTVjKqTNoxr5pynDeWirhjnJES++1CkVuu+Rst4gX6UIFKVmcDn2hlqwlgd
	L+h9BWd3NJhT9inR2sEYm72BfGu0RhjEn9ELRHikcN+aTmOgSCAfD+e1gFrj36J4YsdgtDuFEB8
	Ib6OObzMb1/M8E=
X-Received: by 2002:a05:6a00:9285:b0:848:438d:3665 with SMTP id d2e1a72fcca58-84c2945d173mr7360565b3a.41.1784383243653;
        Sat, 18 Jul 2026 07:00:43 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6ea1csm2816890b3a.49.2026.07.18.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 07:00:43 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v11 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 18 Jul 2026 22:00:35 +0800
Message-Id: <20260718140037.4299-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718140037.4299-1-fourdollars@debian.org>
References: <20260718140037.4299-1-fourdollars@debian.org>
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

