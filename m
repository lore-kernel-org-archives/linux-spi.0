Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43943E4B5
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564498; cv=none; b=mbnnfKqmpDeCs600gWrPU1OffPSqI/DBq4uT+zFQcZjMTcTHZ4LrOWgZ4nj9LgkcTsc18SHYkkIrzuq6yV2WT/vukfBw7pCmjUpndQWdbyyEEfCxcEtw+9/IJjPjgeQW6QQFq5p+KYMfm+6t6B6vynd0zkB4IkJzpQRUtlqKWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564498; c=relaxed/simple;
	bh=vMxi0GBCmk6kSxxY3msXn6b8DUdRebKtLoidNsiWryg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPC1UPRWFGf7t1oE+lxLe2q2KNSgEZjhOGb/CKJQ6Hw6XWT00QH1as/y49tSRqoEJwkg0EpRa9vvmbJZTux3zEkd+kKdPBDkE+UcJxBA02HqTbNTl+unUOGHIlg7XYJ4kCzsZG/jxU2QBatVBfTa6F7YUrxbom5c6Rk67Fl+btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso75452435ad.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564496; x=1785169296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lgLs8NK0XHHTysnGduh8WTtXMi/Zls+hjiJh2kwYBOI=;
        b=KwfA2DjuJlGT/YpXVPgjgc+M+oj8VJXJkdAkTdIDQpbFA6RsTBCoZauWoWKH8+7jWz
         XF4aAIWxh2/vIBpcSct5ObOLiVUkeuTj1tUYVFK4dSj2hxNMPFo8ijLJEsPRDMKpG8re
         ZGLTdBQRbaT4RHep/12MES5d+i9bH6HdoDA8QBBoM1SI2Mr8EOVfokIXv4cOiD6hMG8j
         yjZHUDABMIj4GoDTIwCvjHl6dSJZ4EmgTKvFuUeRtPM1mRieAiaYWSyTU/5LjpEctatW
         3aCu1Ln85J5nq2ESwNhPnmHFyIc5qlWasRZUqrNRoZ9hGlv++jljWjKsuAoU1rr0zcre
         trkA==
X-Forwarded-Encrypted: i=1; AHgh+RrNQevgPR5QdmrKWIRbP2tNPlTz7YLT7kZVODgnJxjMNJXWlERUrHMsG2ltPOYS+5kb00hMLJQ1t5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbREolwQ6ub7XJFRY2cP4IyrOInZJvnsiWa3vSTelbDI1tTk+s
	QQubcC8SITjEDeteHMVvH39fjzpGuWQ0g2xp39mHBCMk6LFIs/YnLyk=
X-Gm-Gg: AR+sD12eD+BAXFk/i+c5heEia25ublvs8HBIDo2mgvBfk43/4HyFrwzXZRLDKZ5bqRL
	N5Ig/epHKCY524fB747Pl8x3EMBnEkWdWxy/+fXwMdKOkXOjBRIJJqYHrSEu9FGa5YnLC2QmANw
	9R1ghiwiA+9+5GFUx6BorJ2HBaSCzPQK1kbBLViOoPRyg7XmI80IzZzeClodAKPDPdltDv/1HzY
	zpk8iaNthz1q2rBdWbkG60yPJ3HadY6CvxpSYKBKXmwKr8rZm4cus5ew5h/wis6K5CfZpAgoYHH
	iXxtGJpUY0LaESS3VoYOEFjxrkdJPAlbxAcK7YFXPNGpZlowPH6SCFOVaTk8WgVzXTS02g+HbSP
	Y1/zfvQBoL4NXcz0cI7AXq161AH8An0GxLLIsh3Y7kmwjH+eZsqe0imzT/75b0bnb0waXgXaQpv
	mMFWUEdOwChPogTrtlJJJe9qtzAI5Ue+sXRLPF1lHAQpp4djNA2WM0jHv6GCXr2611IEZ3wDn7W
	gLw36rE1u/3a3j5pQ==
X-Received: by 2002:a17:903:2350:b0:2c6:a981:b591 with SMTP id d9443c01a7336-2cf349961dcmr158135355ad.30.1784564495679;
        Mon, 20 Jul 2026 09:21:35 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:35 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Tue, 21 Jul 2026 00:21:14 +0800
Message-Id: <20260720162117.32304-6-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162117.32304-1-fourdollars@debian.org>
References: <20260720162117.32304-1-fourdollars@debian.org>
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

