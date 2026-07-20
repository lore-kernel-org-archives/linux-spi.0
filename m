Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1C3DD853
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544048; cv=none; b=iQQcwXjmQP6N9fS2nRmxGEx2i8sVV0FeXiwBXc77gfZEuHMw8PahxtySEKeTC7pnVCRHlenenepo/E1hxniIJEv3jWxQfr9v5/kJCj+WdFNDe/RmrEzavqZXyZ9w/M4cdh33+/aetFSqJ6Eq7dTiIAvroh8qFuoRKCcNwFtyfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544048; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZueU1bB+CeUszAnJXKWEKv7j4MKgGOT/UcxFtxVgsQJeCMBz5U2Emri3/7omH2yH4R7vaKI15uV4V1AZNxAtLy3bzxbsSmzRO+DinhAGS4mE1zsvT2iMLBtq7SGfNivoQPCWBO3ipdrpbQPTJAknznaI6Rqt6Aw9r5UsW3f1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab973140bso121803865ad.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544046; x=1785148846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=TPKnvJgcjLg7LDX5wBYepTvbJZmaCF3jt6gvlaFa1c0wHMOUy/+s4qWMU/scun3I4e
         +Ez7oMgSE+GKSH9Lmx9oCQsFQ1x650JDbfGoyHGMgqq6T71YDXQVylkml4KyiAALrHgd
         5BOBz1fA3ZYvjcOwiKIWjz/1kfiH2X+O6kJp3DCCrEnuykkdjGlK1t7uyIy8ph063yzN
         kt1beOc0GYLGRwHyhIbkdN/KVGqfLKRMHVFQJq1raSR/NRM6pILDPMpW6uyoKqw1G4d1
         1hAQYb/OTDmu+XOYIrnOEz4ZGSRgE/brOgVfPEC/z04nK3ZeXFCm0fcrA8Dfhys5f4ys
         6ObA==
X-Forwarded-Encrypted: i=1; AHgh+Rqz7GVRyj+dBHY1cSPqHgYNzlpGC0+DxYA+Pc8NcUmSVQyBvw7YX9TsHxxTG6XgdRil5efX/N9Mij0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkna5/lEToxxu40Ign+R9SCo2zZrXHpqu8s3fmc8WJoqytLdaV
	ajF51/LDTg09OoTO3ALSf7zXfLMyo4A5p03bgcUvVXLVxTA5RJDYubo=
X-Gm-Gg: AfdE7ck3XwrdmIXxvPib+RLLLbTrCqWa64B3owI8VzEMjCpQuFSg5Ox7t0BYsYc+Smh
	TWL1a97xkgoAOUZKoKx5iHMFnE01kuTSa3Xud3yiinKlhU5dYWibROKE0OLxo7XhjvoW2GnCHBM
	Kz8n2RMMfRjsAButcR8ZK/gamFw7RXwyJoAPbQEhmKB2MGc1WwGpPqEfYubLVumB+FvCHJcfLGz
	Tc9wg9sdcVztoG9iSihQb5ayJt7YoVxTTyJLM9Oro/gqgwZOh7dsE7RTTEOKtWtZvDnB9MPPqTx
	D3Os1IZgPhalUyg4q7KzPM8Y8kQQXPZV3ghMeW6DG533jTrJZtjDRYRk/PM/JVWy3stpDuV+No0
	CmKcNQSW65e40KgRjMceSc9Psx8Tov6/G520v3eTl6kDJWrUA6zEKDpjFaGYyaVCo7CroR9ud10
	GzgZm0yDiwA3D4TwwJsIPTM6repZkoGgxrUXrpk1sXhYFQU8SVvKPETfOUXkq6NUw4NBdjm8j0S
	IKh1F6uwS8qNMKkxQ==
X-Received: by 2002:a17:903:19cc:b0:2cc:db71:4db5 with SMTP id d9443c01a7336-2cf349d3ee3mr147347175ad.37.1784544046271;
        Mon, 20 Jul 2026 03:40:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:45 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v15 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Mon, 20 Jul 2026 18:40:27 +0800
Message-Id: <20260720104029.13740-6-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720104029.13740-1-fourdollars@debian.org>
References: <20260720104029.13740-1-fourdollars@debian.org>
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

