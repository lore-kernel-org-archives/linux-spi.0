Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA5351C3C
	for <linux-spi@vger.kernel.org>; Sun, 28 Jun 2026 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688587; cv=none; b=e9eso7tKnShEOKCZTNYg07HILBlBhpmUjWUHgXl7+lsabXQjlaUb1F7g3AnIgwV6L2Bk+d6i7THahY+ls+wpqekxPHwY7aGeMfEsnhm2KIV4UCMyt8rhNlu6tVJ8KV1XHamT/NQrwKZHpUf1vszJH6RdZcUDvO3KYOir3NgRG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688587; c=relaxed/simple;
	bh=jcq+RmnlUoHQi9v6Kz2MHeMq4r5if5JpMdKd73GLlss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRD7qKdbJLKuSd3UlwlraiZNCobx1Jn4EpCDJsrrRmnjD1v7Eryw6dmnhcqNgE3j8bWIr2cbpxkiAEkaaVImH5Uowx2nuEJSxMavzujYhjM6rR3nt2du4apQigoBcFN3kVeuKg8qxda1EchBXfzkVZPbVyNWzTGS4i1C5zOOS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGeNp79v; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGeNp79v"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845b733e82cso1622075b3a.2
        for <linux-spi@vger.kernel.org>; Sun, 28 Jun 2026 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688584; x=1783293384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=387efM+Hy7Mrl2ogW+DfnTyNvODV7uhBbTi6N852WdQ=;
        b=kGeNp79vrQ0hkexAC6jACdUDsubLfP/skHrnXQghY/EWTdlGcJ0y1FhdXRJ32qUumu
         Fipz94WZPPqsgifZnvN8x+RLlo7kWe9w/e9U6y3GZVKl9sGvKydsvy6sdZHhqfWWzbkT
         a3C1gKTdH+949twJH4uMybb4ESWGvow/HDUC1sMVJiFvWag+bheSmMHOBlqWJpqcGRNI
         40b6rUHK64YNvqV8Ifnalm48v1IkasyL0MC+r8ii0KPRFz5+Tbq87fLqRQWIDJPwMlal
         NbLyKVPqFsCA5iKy9dG7liJE9ujZ6vh/cDxD72VShj8x9B7E6ww0RWIQl/YqPC81oOnb
         Qxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688584; x=1783293384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=387efM+Hy7Mrl2ogW+DfnTyNvODV7uhBbTi6N852WdQ=;
        b=MD+1ovblL/tcXno95XPZnRPWtwnPDR0DovKOjU04D3Izn8NkrgOukMiA1pEYi4ZwZp
         NAygjw3GGF2n9tOUb2L4Zn0j5gkudeDlV7WPjmWaKVlh73pL3JHHQEaNPn+QXnHzLGgZ
         IaRQBK/aUiKyqIJQD5lMvKjyv5vjm5LcNLe99r6+DfBf9CardW0bTFzdKy+GSIsV7a3n
         1ejdySY+9iX2LHf6dQUsW8anDQGyrV+r/yEXuOGIWALCgI6fS7847VFWChGMOEsbDktX
         wOiu5mCo5gE/GUE6ZmfPMXOiUN+JWNjotJHGzmg2zVVie8K8NVMaGoUMgn2Q6uQ+753V
         r9Sg==
X-Gm-Message-State: AOJu0YyU84UNh8GSDtbX0uFDLSpbm1Uv2VIKRiDwuGNx6JyKm/noo2Hh
	kY9wNNMf2Sk+VJVFNKjzQSSrhGWIdDP25LXwD+BYHkIVy5zfi8iUcwoyivf6/w==
X-Gm-Gg: AfdE7clwuvNIo7bZj4IThNNA95dJtOEYvWikndnLka9qwu5vR2vb5OaHkp2k7XRyvA3
	a0L6sCBqFHIXjBQYwgy4Jo1DHMh8qZ0ck4Xa2cbAEjCtnYMKn+g4rqv6Lz78r6/ko+kyLcqfHXh
	YCPZ5uFwHFW70FuzG6vCNLh+lN1cZNwpSbH/UPPI6fRkR5YThndKyAoyLcnBVtdlNagDYj+nf1o
	UhL1d5EhTORlkUBlMX/1gnp0nBnYDdF6lSxE/KaRp073Pvh5/cvapO42/TFJwcRLd2Xjk/An+t3
	lvARYO24R8qaHra6KmVax9zEfJoBRnJFrViWms8AJTRBspXjOGcKrwCrSyOTkBaI3r4cTHsoaBG
	dEjbL7e8BHi5gRyNr5FB3v2yodFNWnNxnufilTqRF3Kp/haypn6FQKoa/HPXWsJ60o0MeiTrBz4
	MUtMDAVMifnwWqxxdnD9Y5HLUpUPAAnJix0u4kGR6ryWTCDlHeGc8tSJjOvcTmql3lj3gW8T1L5
	gK/FBlnjQ==
X-Received: by 2002:a05:6a00:94f2:b0:845:bcf0:118 with SMTP id d2e1a72fcca58-845bcf00accmr11968079b3a.41.1782688584343;
        Sun, 28 Jun 2026 16:16:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8477d93c895sm1229143b3a.60.2026.06.28.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:16:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: ppc4xx: devm-ify probe and drop manual resource management
Date: Sun, 28 Jun 2026 16:16:22 -0700
Message-ID: <20260628231622.1272243-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-ppc4xx.c | 83 +++++++---------------------------------
 1 file changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 46ac58dfb3fc..91d7d2071a8d 100644
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
@@ -337,14 +335,13 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	struct ppc4xx_spi *hw;
 	struct spi_controller *host;
 	struct spi_bitbang *bbp;
-	struct resource resource;
 	struct device_node *np = op->dev.of_node;
 	struct device *dev = &op->dev;
 	struct device_node *opbnp;
 	int ret;
 	const unsigned int *clk;
 
-	host = spi_alloc_host(dev, sizeof(*hw));
+	host = devm_spi_alloc_host(dev, sizeof(*hw));
 	if (host == NULL)
 		return -ENOMEM;
 	host->dev.of_node = np;
@@ -379,88 +376,38 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	opbnp = of_find_compatible_node(NULL, NULL, "ibm,opb");
 	if (opbnp == NULL) {
 		dev_err(dev, "OPB: cannot find node\n");
-		ret = -ENODEV;
-		goto free_host;
+		return -ENODEV;
 	}
 	/* Get the clock (Hz) for the OPB */
 	clk = of_get_property(opbnp, "clock-frequency", NULL);
+	of_node_put(opbnp);
 	if (clk == NULL) {
 		dev_err(dev, "OPB: no clock-frequency property set\n");
-		of_node_put(opbnp);
-		ret = -ENODEV;
-		goto free_host;
+		return -ENODEV;
 	}
 	hw->opb_freq = *clk;
 	hw->opb_freq >>= 2;
-	of_node_put(opbnp);
 
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
+	hw->regs = devm_platform_ioremap_resource(op, 0);
+	if (IS_ERR(hw->regs))
+		return PTR_ERR(hw->regs);
 
 	/* Request IRQ */
 	ret = platform_get_irq(op, 0);
 	if (ret < 0)
-		goto free_host;
+		return ret;
 	hw->irqnum = ret;
 
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
-	}
-
-	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
-
-	if (!hw->regs) {
-		dev_err(dev, "unable to memory map registers\n");
-		ret = -ENXIO;
-		goto map_io_error;
-	}
+	ret = devm_request_irq(&op->dev, hw->irqnum, spi_ppc4xx_int,
+			  0, "spi_ppc4xx_of", hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to allocate interrupt\n");
 
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
@@ -469,10 +416,6 @@ static void spi_ppc4xx_of_remove(struct platform_device *op)
 	struct ppc4xx_spi *hw = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&hw->bitbang);
-	release_mem_region(hw->mapbase, hw->mapsize);
-	free_irq(hw->irqnum, hw);
-	iounmap(hw->regs);
-	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_ppc4xx_of_match[] = {
-- 
2.54.0

