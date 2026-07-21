Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A65B1EB
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595742; cv=none; b=bVoDOXKFEmfgaYS7Fzka6lZIjA5ngeZO9oGVPXrsAdCH3v2M9kg53y3nEg/N+cGyZGXI+s2N7xGlcFfYMIy5Hypr6i0NDQa6Px3vsxIRvOqs7FmMyU5s+xu1uE/lehJyhrC5IsN/FYtEK8/wHQ0kQsISx3A7Chgwt6LZ7SXYaPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595742; c=relaxed/simple;
	bh=Vp7TwwIkC1ySw6IlyKHz6XxaiF7cHfZjYC3myrXyjNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9+Qbuh1aqOIQ4ymQqmgOiSKud0wZw583PrO1IbEeIbanJMlnFrKhai+E4sN8pwEIZ3lxzYYIMXCvHkpTqVBcdV15eZ4nhaLxllEMIu2NArHCMDU8/RgayZjk47Q6tb/kLCqlSDgBB4NSJredj8KYhnPSi3xlsnr7bPfkdM4kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9GHb4G8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9GHb4G8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso8398097a91.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784595739; x=1785200539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xi5tnkVz+PURPr/ufl5NUD3RR317TnWsCpk6GKHXUdE=;
        b=J9GHb4G8GRpk7cugvA0P0BM04BJnEGjhd2EkDrtROxC5CnC0YNSA3d8RMdjmMIq/YY
         kgcLwroXwM/RhZun6FfFfHP2ZxUNeE6eGBpj5s0BWJfuzPych7TjwRo1gn9pDhEPezdl
         erEyMyQZRJTSNJS+oB7/SiMso9JFzOoWYhFeWRngsjaGZ2W1ep+qHeze3lHSwZmNIjfw
         qO+/ST8oEBRp4eAGBBijq8VPGr9cLPHjo8fExRFuQ8eNqiTFG9bZVEO4vgqvGoEDImwQ
         no7h5eI/+9iA736IjeLFwh+uuZg5bzCn7hoIxEC9AERodBUlDsli7f1YJEGR+AAcNWZJ
         9GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784595739; x=1785200539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xi5tnkVz+PURPr/ufl5NUD3RR317TnWsCpk6GKHXUdE=;
        b=c2fVL3yDEoGEjAHS2CUFYv0GWrlj1F9xVZmCdUmTu61MrHEsqIUJdECFxFWxli7xp8
         rhOLcyqNtpIykg5eNM1rs9XZApmExwCLVykNwsB4BmgteeBE24GA70KlIBf962NB8PgN
         Hca6y/8nc7HpZad/b2GcGF6/qHIfXYAo0cV0vOffym+nw+Xw2UoWJaLLTNSE7L1QRd/n
         A64SZLiqoyLHmGcdXasK2Qqn62v4p8hTYca9W//MHs0ezEJSE+XSoa+cqwKRDn1uGvVo
         EUVGt6q3NKc8tDsi5xbHiwrER7e25REMKIX/y0b7BDXB3fxnMJfFIHgFYj2KkNVTe0Im
         KcKQ==
X-Gm-Message-State: AOJu0YzGhJkT/vvJk9tY/cAWV5JCMPlxhEPnuyXbWJklmCAUBEi29Hwy
	kiNvSdewx62ww0BI0iTtv+UyhyRhYFF2ZvLORDnCYSmLMsQxT9hmlfHxoogb6A==
X-Gm-Gg: AR+sD12vaQq6QTvGIK6gz9bpXSEXXFDXo5oaMImbZJjgZlnNTW51HQzzojL0zHog4op
	HYZV8djLRbXDvA5sTW9qGQ4DAQ7jCRpFb19OyUsrRLMc3/e7UhBiABdimXZ1XWo1ZK4EzGjQEu4
	EVRcfXq65t8VY5AzX1qXfUD0Bed0lhtvfxL/cH6cYFEwJG0jxZb3ez8xX5tGaEhSwFI2iIX90C0
	fqyllb/zSk0uiLqfqOfmo1f7trXR4UJB8b3PBjKQlF9f9woa1ft6WbxGr2IKzglGmSnkMez21A1
	kT1kXiET9kkoTMyBgSNj71dIsyauCmL2RDQuxX8/bw8mlYccTkJUe0X8BVpjFVypNfgkVcVhmfE
	yQW5Bz/9PeMXiSjosR0lgfxuSGgAZ7hVPVipoL+YxI8Cv4GoA7z+YPONMD/fvpxAYOzs5Ng2DOK
	U8WuoaRGwfuxDEH7bPUFbpONXpnGsSzrdtJH0TCc0VFL8q9wUpg4i2q0isX2FySpaf7Tg9HyviM
	zZr6wpO4iW63VtNFxfT7LBDUAvfqMA7cZSZiSOMaPVa5hBey45zZ2w=
X-Received: by 2002:a17:90b:3c52:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38e4b431315mr17031556a91.16.1784595739137;
        Mon, 20 Jul 2026 18:02:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e60bc83f6sm1032383a91.3.2026.07.20.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 18:02:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] spi: ppc4xx: devm-ify probe and drop manual resource management
Date: Mon, 20 Jul 2026 18:02:17 -0700
Message-ID: <20260721010217.3385364-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded resource handling with devm helpers:
  - spi_alloc_host -> devm_spi_alloc_host
  - of_address_to_resource + ioremap + request_mem_region
    -> devm_platform_ioremap_resource
  - request_irq -> devm_request_irq
  - remove now-unused mapbase/mapsize fields from struct ppc4xx_spi
  - move of_node_put(opbnp) earlier to simplify error paths
  - delete the entire error-unwinding goto chain

Move devm_platform_ioremap_resource() and platform_get_irq() up in order
to avoid doing work if -EPROBE_DEFER is returned.

Sanity check for devm_platform_ioremap_resource removed as it's
unnecessary.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: mention Sanity check removal.
 drivers/spi/spi-ppc4xx.c | 107 ++++++++++-----------------------------
 1 file changed, 27 insertions(+), 80 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 46ac58dfb3fc..7823b3814a17 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -112,8 +112,6 @@ struct ppc4xx_spi {
 	struct spi_bitbang bitbang;
 	struct completion done;
 
-	u64 mapbase;
-	u64 mapsize;
 	int irqnum;
 	/* need this to set the SPI clock */
 	unsigned int opb_freq;
@@ -337,14 +335,24 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	struct ppc4xx_spi *hw;
 	struct spi_controller *host;
 	struct spi_bitbang *bbp;
-	struct resource resource;
 	struct device_node *np = op->dev.of_node;
 	struct device *dev = &op->dev;
 	struct device_node *opbnp;
 	int ret;
-	const unsigned int *clk;
+	unsigned int opb_freq;
+	void __iomem *regs;
+	int irqnum;
+
+	regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
-	host = spi_alloc_host(dev, sizeof(*hw));
+	/* Request IRQ */
+	irqnum = platform_get_irq(op, 0);
+	if (irqnum < 0)
+		return irqnum;
+
+	host = devm_spi_alloc_host(dev, sizeof(*hw));
 	if (host == NULL)
 		return -ENOMEM;
 	host->dev.of_node = np;
@@ -379,88 +387,31 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	opbnp = of_find_compatible_node(NULL, NULL, "ibm,opb");
 	if (opbnp == NULL) {
 		dev_err(dev, "OPB: cannot find node\n");
-		ret = -ENODEV;
-		goto free_host;
+		return -ENODEV;
 	}
 	/* Get the clock (Hz) for the OPB */
-	clk = of_get_property(opbnp, "clock-frequency", NULL);
-	if (clk == NULL) {
-		dev_err(dev, "OPB: no clock-frequency property set\n");
-		of_node_put(opbnp);
-		ret = -ENODEV;
-		goto free_host;
-	}
-	hw->opb_freq = *clk;
-	hw->opb_freq >>= 2;
+	ret = of_property_read_u32(opbnp, "clock-frequency", &opb_freq);
 	of_node_put(opbnp);
-
-	ret = of_address_to_resource(np, 0, &resource);
-	if (ret) {
-		dev_err(dev, "error while parsing device node resource\n");
-		goto free_host;
-	}
-	hw->mapbase = resource.start;
-	hw->mapsize = resource_size(&resource);
-
-	/* Sanity check */
-	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
-		dev_err(dev, "too small to map registers\n");
-		ret = -EINVAL;
-		goto free_host;
-	}
-
-	/* Request IRQ */
-	ret = platform_get_irq(op, 0);
-	if (ret < 0)
-		goto free_host;
-	hw->irqnum = ret;
-
-	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
-			  0, "spi_ppc4xx_of", (void *)hw);
-	if (ret) {
-		dev_err(dev, "unable to allocate interrupt\n");
-		goto free_host;
-	}
-
-	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
-		dev_err(dev, "resource unavailable\n");
-		ret = -EBUSY;
-		goto request_mem_error;
+	if (ret)
+		dev_err(dev, "OPB: no clock-frequency property set\n");
+		return -ENODEV;
 	}
 
-	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
+	hw->opb_freq = opb_freq;
+	hw->opb_freq >>= 2;
+	hw->regs = regs;
+	hw->irqnum = irqnum;
 
-	if (!hw->regs) {
-		dev_err(dev, "unable to memory map registers\n");
-		ret = -ENXIO;
-		goto map_io_error;
-	}
+	ret = devm_request_irq(&op->dev, hw->irqnum, spi_ppc4xx_int,
+			  0, "spi_ppc4xx_of", hw);
+	if (ret)
+		return ret;
 
 	spi_ppc4xx_enable(hw);
 
 	/* Finally register our spi controller */
 	dev->dma_mask = 0;
-	ret = spi_bitbang_start(bbp);
-	if (ret) {
-		dev_err(dev, "failed to register SPI host\n");
-		goto unmap_regs;
-	}
-
-	dev_info(dev, "driver initialized\n");
-
-	return 0;
-
-unmap_regs:
-	iounmap(hw->regs);
-map_io_error:
-	release_mem_region(hw->mapbase, hw->mapsize);
-request_mem_error:
-	free_irq(hw->irqnum, hw);
-free_host:
-	spi_controller_put(host);
-
-	dev_err(dev, "initialization failed\n");
-	return ret;
+	return spi_bitbang_start(bbp);
 }
 
 static void spi_ppc4xx_of_remove(struct platform_device *op)
@@ -469,10 +420,6 @@ static void spi_ppc4xx_of_remove(struct platform_device *op)
 	struct ppc4xx_spi *hw = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&hw->bitbang);
-	release_mem_region(hw->mapbase, hw->mapsize);
-	free_irq(hw->irqnum, hw);
-	iounmap(hw->regs);
-	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_ppc4xx_of_match[] = {
-- 
2.55.0

