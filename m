Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC012223DE5
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770608; cv=none; b=p5sab3mwJr1xTMfW/q1d3dvw9sM7zfTA5qBOnj1c0OabLI3Q0A0wAdsfFbwzZHXMCCmzowg6xK+IPcKQY3mj123fYB2yFBEz4O8fb/sNZIw0wroRC7ONqacXEiNBKdmQ6zSpgDB77ksu/5idY83i08BkjtyLFdAsg0ZykD7hCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770608; c=relaxed/simple;
	bh=FImt+bsSj++vXBt8dl06uq7wyPYDWF8eV3nAHecKHCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Riqmlesfq7J0TiJFmslTrmXJcYbwrYFyLnthogOirGX7DTm7KYl2QC9vId+m7MdEuUI/TEzDOkX6F3N7ZcWpkj6tMBIriycmpcy5D09inc4k59DihuqB4/o03UAjMPPR1p9h7i51bnGx3H6Id7zJtLZPLhV4O0g1y+DXeK+pOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2054218a91.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 04:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770606; x=1784375406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HRFub8kSA/fS8InEMuVJNmE6mYQvQVfDODAvVSAOiMA=;
        b=TId+MH9FAnZmZN4D1tGlSdlVqvs9+RjwqXx0isfgFJXYQpFqf+N/6InMlN/1qTKNx3
         Zhyzq2zKfsVgxPCLP+DnAsWmCzhxFg53e1+5UNgELbikISqzpLkMJgFgSx9BjzKZr79G
         RqpBuxlWPT3MQ2mV+LBnQNK+nalC3agbWirCTZ8H4b9fv/iqUkE0rYBhHXWpuRTo2Btd
         8JXG68nxo0YjEGXS9mQkLf5nfWkTOiWliLYuvxYMO947GEFEguUzDghCaOYc9AvvvxQd
         H+FPERHldsLyLViH93Od7i1cbN53nUbDLhu+GJ9iYZor7Xu4fPuNIaaJ/hGnVU673ejS
         sK9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpag4Y56ZCD9oOlMwGgJXm/357WwtEnvw4w4jW5OC1Mf5mTlaozZCm02MQCwB3J1WpAV+hAk2W5vCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kJRqxDUmiwBI31U3CJq2p8XXBa+Lgdf7ft4NzKE3mXaUxKsF
	Pm+/s+2VMHdgp77idk8jQB8Rs9X0ypxCMctbUq3rl7F7UK33w2iZcbg=
X-Gm-Gg: AfdE7cmKMHyaMPdjjmvjDnt5+uDvRG/5JCfV3oDZMlzkIRfrY3f65j28KTcEy5XWWJ9
	DhXGCkdacLPyxzZACCQ3CPwnlgqP5TQ+9i0vkmNSAgKL1SGGg2vpr7WxXU0ULKobdm0UCLAUvfS
	yFLMy2Es7rj6GZdSIHEY7ea///wfzjPYZpgfvdnb/nZ8PCmv+G13BmC3Gxn96wSNs2K6CJ4tSvC
	Rs7TyvyJhlH0ATt29dcjM0CKiIRiAUcv8o/z8Gl0nHaYXNhBb/v4klpokqeuAjnUb3xaM/ohAbg
	GBg478Spu7sMHD1qqVba83XpJJWxRGr2MCVJ+W7ZsYlc8khheMJIiDBkSjLgJo1T990gEX9EKXN
	U7bn/cdMcwSftqQCFQzGPhIjOuurkbX/fbuA4b5sTAauFsAmd7+oE62JMf0l+jCbZBaEXuMfHtk
	VULbkf4RvD55Gio/87w5zjnFz4GjLDSGjxpDoIzVzL4M3VQNfgn0wHRZSBkPJ352yYU2w7QmfbL
	OWH2Ps3fjsPrsO8bxvMmYNiCw==
X-Received: by 2002:a17:90b:3806:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38dc777c6d4mr2735418a91.26.1783770606205;
        Sat, 11 Jul 2026 04:50:06 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:05 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Shih-Yuan Lee <fourdollars@debian.org>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
Date: Sat, 11 Jul 2026 19:49:37 +0800
Message-Id: <20260711114937.16670-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711114937.16670-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx-pci.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index cae77ac18520..96bbc7a7c381 100644
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
 
-- 
2.39.5

