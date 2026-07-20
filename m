Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3F28690
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784507448; cv=none; b=hz55mMe2vL1VpcM+tjDYEOdqyUVn1Y4fy8SkmArYhPFcdbn8dMqSPnolvpkyugTvYQ4SkNcy62phMpxtMjlE2rj4mDhGf2TJs1EPWNLJaYPyNXIPQeBCa9aLlUXclFb0pPX4dgBWqZ0X/rZIzd5Nd7BQeKW3S0Au7w/0raQlrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784507448; c=relaxed/simple;
	bh=+Eo5NWVkrzbtPKFw6Lp9lya3M8MKBRSoua+JLpJoOs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJVFdYUizKsMhyPxexY/OWCfIXKvh/4Z+qzDeeSFnbdZlWwnzVvlXXhg2wOQP1WJLpLPUz3tVitUZHTPtZrpKZyUmRXGLySyvzuNMB4Bt2OVt7PkcT0ldCFaYd5UegSy9cZOJWt8p6SFUz+PqLBYbLvY8Icqjs8juXLaokRoW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNjyAg3B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNjyAg3B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84864086bfeso10130078b3a.1
        for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784507446; x=1785112246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbxsCH9pMgD6SOGxQcpGqXiSoFQuY8yErZj8atWFslk=;
        b=bNjyAg3BlOqKRruOZPq0UlQoNvWnG8LCwKcLof1mFNKVUBRmlolvAiM8FY8ZsQY4mj
         hXStf3MBG4kTFz2aAEffpGWAlTfeDpTUUTdzDnIJTO6RtEQkYVU1PBGWpahCMmyAAEXU
         jMF1jihN5o+jf6hkO7jQdU4WEkBuyslRFgkj0hevYaesl0/qK7feopFmumF69RFyxDUx
         vzkAh4yUlbrpiHreP2sn+lH0vordv0QGz/4oyX2CPuqbNWpmNNLkve29koNVOT/JDv2q
         RgQzqtInpLwg297Oisrnth54W5FuRVXTYOAsqaMpBZ+J1NH1wMRQbdKSwY/6hFNXoJTB
         z8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784507446; x=1785112246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbxsCH9pMgD6SOGxQcpGqXiSoFQuY8yErZj8atWFslk=;
        b=Ej4fvNNuCCZc4TwpbJTz/fHME8NYCGZUZl1aCvTJPKhRGWuh8tOIPPTVs+YSiZY4Ca
         fGMxoEyhZ3Jj2psByHK+yWLC/s0PrCt/y2dkwf/PIVYPnCFEh9E7T6r39SM2Zxufcyyj
         oh8cLolZw3ncojVowfUxkA5lKSSbDCNLBLaG1yRHzXXrgYKWb98b3n3ToxbivMREpMcq
         DiCiRnSqyNEolleA18efC3u6VOi8AmLJOwJAv6ixgrlPp//nWRKvR8Y+aT5IA1VA30ZS
         8lpszsRo8O9xxt9HDS8P5Ae8iFmf3Cmhdcwt2XPSbiui/NSqM/HmHsntRZajTcZ/kabG
         7WkA==
X-Gm-Message-State: AOJu0YwUJGViEtvXILwqrLz227hkCfRkRJk3XX+UaXpLQu8gasPTvh+N
	Gj3Fk7jQ+CuZfMYXY5U3xGxXE8uybWfYfjdlzpe9k6IuXANVovtE2urYnmZeGg==
X-Gm-Gg: AfdE7cmeMBMM6PyfipOF1NfvOjwytUXn1eqy8ASFzNro8gSpT/p7vAtpBVMtgLiXLF2
	MCoVeE18eVlBzUoa6D5SaP2V56dIeIjwA6YPkwl2d+AHwH+IKk1QR/E3EQ+YxdFfcsY/HpIvUHI
	KhlmhfKotPqXGUhbeMM55R/6ADuW+XGaozoRd8xSg0Q5TAsJBBvTmaKOXY6k52TKbLkRl1PRJHk
	YYsxIP+sLgOqbVbw4m3KurqKcxvnZ2HR1RuRyiQtfGgVHujVnGwfUFt6Wurmr2Tj+75K98ATMq9
	2fQuEO2FKLzJ0xeXsHEY7Wt/TUUcaxSDxpyL+IbO8uPk+K6A9Lpo+ZZlpU41LaJGw65qRoqoCcL
	halDxXlBFZTb+8KRre18hsIxWoEjd/m2vTcPHf0tF61bvBJqdDKgl7EQdr9UBsY8fYLnKdnfKX1
	2c97MgMyS09eWmSP3LxfbpY9ho3YE1ZFmxYIBJpwCarqY5tPp3nHGjAXXoPOPdQfw2IGpa8tcog
	5Bm0E84aQ5VB/xH8IAOEI3B98ESVvtL2EEno9dBYuiY43N+BQPRLGY=
X-Received: by 2002:a05:6a00:23c8:b0:848:587f:8ac7 with SMTP id d2e1a72fcca58-84c294bbaf0mr12410088b3a.52.1784507446016;
        Sun, 19 Jul 2026 17:30:46 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e9a3sm4639048b3a.41.2026.07.19.17.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 17:30:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] spi: ppc4xx: devm-ify probe and drop manual resource management
Date: Sun, 19 Jul 2026 17:30:43 -0700
Message-ID: <20260720003043.1536358-1-rosenp@gmail.com>
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

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: handle potential -EPROBE_DEFER first.
 drivers/spi/spi-ppc4xx.c | 97 +++++++++-------------------------------
 1 file changed, 22 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 46ac58dfb3fc..95c034cf2336 100644
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
 	const unsigned int *clk;
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
 
-	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
-		dev_err(dev, "resource unavailable\n");
-		ret = -EBUSY;
-		goto request_mem_error;
-	}
+	hw->regs = regs;
+	hw->irqnum = irqnum;
 
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

