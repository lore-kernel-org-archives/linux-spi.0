Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D51DC1AB
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388779; cv=none; b=LUKmunwIAT0TX2zB1SOWih6PjHCSW1wO5JOqPxZqYChIi33ihQxKXHIWRTcRh5IDZx3kCZE7q0l1ZknNj/NHxdYqEAjQScyxTxFx40LA+OuLh1OJClGcr6+PFTY2qTgaKNWkn5DIuH3k9gG+Q1n0xD/NRnXNooFLe1kFj/ql0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388779; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHbGjlxG8KGjf5ory3b+u1Vwwf6lgel+dJe911ntDI0y3yy6WpI3VLpdCu5la8kiEghVsZPU/0J5XM35POdg/pFREXamuP3rMjBjjdLsM1IGMwtG2+licaB1Dzu+Fjydt1rebsNU6/y+dFuLA9eiqsyLwQwqnAWLarFm051kmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso98009295ad.1
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 08:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784388777; x=1784993577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=tMteUfKFQkpKueieSLc27HNXoEVFFwVcJ+pUZuT52LPCQ4LtHBUWCvpZbmQ9qY8L6b
         NNIIpKbm2d0QJ/uoCz1DOpZj2tSeD9IRTHUzCzPol61/qZ/O0tcJMJk3m3JKuc1roell
         b63Ps8++C+o55PQRp2qVbWOImdd/ggU7TtN6MXCxxYe0fMK9zdOnmKOsEM0jaE4ApjIL
         prByA/R7cpO4bbmUIUU1KCDolhqanyzaJeIWScnmGU9Nyi0sW/GFZM+V+cPFI1h2TCRE
         xDjl3qr5Iu+zkLz7RZw/2YhKuo99khJ7LXitXFZGpHjk/oHizrjGzsBnzWwA4kc+KjF2
         4Zig==
X-Gm-Message-State: AOJu0YxWo0evw8MKlrqVvdWyOaRJO4acf69nNqEcmmMhPSqdvPpdtiku
	m6fHwV7DgwONQoLZigx5l4c3Kn0WP4b7TBVtxZv4am9FX+GGW145H7s=
X-Gm-Gg: AfdE7clr2Qrvse1FieUBLHvIcSBjKPrnyTwCK3sUJ8yvUiWDjcTSvVF7Bq54OzB1b1U
	+/Au8GYtdlU5lry3iICvdVpw5pL5mGGUSday7wji3D1cejY9uemW22aooq73hYJaDSz1FWa3Jgm
	vKp3GHcvZ1zVcJ3anwqTylgpaFPlTqRUkx2TBNmBbc+gP7EbkqQAiASS9FdQACpgRDLRvkUDKZs
	bravCiClgvRb+lw3whcXw8CHyRLLmuB/GCJK3wwIF5mBa6b6mFeUo5iQC0xwgiWFwE+fou3Z3ei
	SauDzqmUhMekAPFYPM26sqKlqAyqd6ONWC/K+wjTwLKBkaWCv3pFRp3utwCkSlOhtobiF8EMUag
	eXkmPDjeLTadxq10Hh+r/HLopUvWrN61H+FUjSyr6UOAsbR9iVZ4k7dE45/vbADNf8Zqp+m4Kme
	iPyzBSXp6TZ8QqHO5iXfLvoSjCtMQoyeF5rmJ8Acl9m6aRNxkth9JSwmsjpHGrSoKsE0XwRr9S5
	FDOTSewiXhphDY=
X-Received: by 2002:a17:902:ce0d:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2cf349eb316mr75462215ad.45.1784388777183;
        Sat, 18 Jul 2026 08:32:57 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-48-72.dynamic-ip.hinet.net. [61.228.48.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bd3aesm28731535ad.26.2026.07.18.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 08:32:56 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v13 1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 18 Jul 2026 23:32:49 +0800
Message-Id: <20260718153251.7353-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718153251.7353-1-fourdollars@debian.org>
References: <20260718153251.7353-1-fourdollars@debian.org>
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

