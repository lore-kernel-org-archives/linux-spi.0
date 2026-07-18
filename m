Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71E36E48E
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784380486; cv=none; b=E2FIaGMOXpOo0wXIqpbqdSEqnPHCQj/53BwQ3cNBmpAuieCqQ5LL/lKF3B2WAC8pUGqSQEJFLTA4qet1ACnEZTZIlqEKA/zVHS3mr6hUQfeabxD1nQjZntF8AhDnh7BLUpbWwZuXUx3V14l3aUaDTt15Q6ZO1dtavLaQQ7xKDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784380486; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGZR7UIWW0wF4YRtvr4BhmK0KtwfOs3lrAQDX5wtBxgbBINJNzxhyoKdR0PHgNeJ19XyBrwRdQbBhYSfR3Hi1vrhgQz0zXLQ+2qT8drGfGuQsQxHHA3eDKjbl1nFTa8eKvqr4B1mjPuX9iwfiKZ0Hn1vbcUxJ01Uk1oqdG55xg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381216921aaso8618905a91.1
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 06:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784380485; x=1784985285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=q3fDIUCXxrpZIotQIylTa0EGOmhY0prSFRehxlN13xoPmXKuv2539y16GwXuK7n+U8
         zznu/yNeLbwb6LrBjAMnxPLJDf1/TF5EC9FqiDKKTuAhs7v/sYeF/ENl8QrIMsvOo1Jl
         lSHI+E9EealmN0sExMurvdqmsiASd2aGTj9oAd9tk6qbl1/DfZB6DTGhsM0M9mP/MZ9b
         9HMlXCW6LLAt6N+4EYjFgCUrWiHwyWgTeiXtemvBUi4mjMvXo03LSmDbpUifaXJJ7QcE
         Ji1KskUfm0I4/L96lNF9jNHzdWjlZsoKBKocNRRCI7M+YfirbslaEXK+qxUleUy3gkNe
         f9fA==
X-Gm-Message-State: AOJu0YwNQmQFeg9fXUyobTlsF2QYcxIpo1HIDObxdT+CgbN9wVo17mxP
	WVn0ifltiY+l9deKr6UnYS7RykO0d3u2XfM9mRbuUSIWvHYp4V04Ctk=
X-Gm-Gg: AfdE7cnsjFN4zsaP42J/TRHYLhbTWaBCU8ONG6zBcaB5mdqnxnVAgpRtRT/YMo+6Hys
	23Qq6ngG+xjhtDJtadHXykuV+vT6iVkZuNUq5hSqCzOL+qyR0BAv4qJmW+uAdJUlWy4bhd6AFER
	wTy6lyh8b4PmHi8jfL+7fa48SfeuPh7JPd0H/2h0y0vp7x2Ubs4iQvjwCXU25oBp5ZZAq52CdRI
	RwrKR54NT+fZ0B3CjdS5ITiIRq/3O9XkHs7V8poCQ5ghjLASFki+p9891xx5fvL5zxX35mqAjPn
	1JEXW/Lv6f5Unq5K6uKvzLy4P7VNEtinxnd1ZH64rVIh+0OIdikeuOXP+kPi5xT6Xz7C4h/6PLB
	Uu+t6d+3Paa8qnP6oYH+tLy5Hiv2XM4BB3douLwzQZJIiRHbJ6MNfo/Zgg3l1o3M2l02yuYGcQG
	W0NOKj3k+bm3A5CZzDbPC+gHn1hfA8ZZBB9SOb3eLHtLU9+NLyzBYWSdWH/t2IAbyn7QuGtidej
	UW35EfkprL3E6s=
X-Received: by 2002:a17:90b:2f85:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-38e4b3e1015mr6953701a91.1.1784380484477;
        Sat, 18 Jul 2026 06:14:44 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e9bb5sm2706400a91.11.2026.07.18.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:14:43 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v10 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 18 Jul 2026 21:14:29 +0800
Message-Id: <20260718131431.3393-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718131431.3393-1-fourdollars@debian.org>
References: <20260718131431.3393-1-fourdollars@debian.org>
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

