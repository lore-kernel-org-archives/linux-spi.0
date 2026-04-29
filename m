Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF43BED31;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=J675f01inqpu9tpkGDC1eVUHyV/4sJ4bQlh61XLkoMgyhJPehue+GZ46V0NgPFQdIPwJrDWdRJxn/PAZzKDSAqzzPO/SeBOafnrtXCKr5Z4uLe3NSVrX6amLRq0G3T5UvAVNvf0fhTfuwxyEfdFQOz+l2UNTokzYpPe1Dx4nn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=AHjTvIlA2he9Wp9tlUsmw8EJ04LHkkbvc2YRqbAEmmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqPzO6dBGqUuCXCmPxeODFYVCBDnftUJb3ph9l5KBgyzisAKonmpoywOTz53G0iL4lzIQM2r+SECMQhxBxMss6MEwXvaPONoyvrcY4WOg6tCnU/cLyH/WMS2K+WfbkoxZi5lWWNVA3XyAehvNyHMeG7O46ogbL3SEf0VICGe/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itpf5ky6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itpf5ky6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116A8C4AF0F;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=AHjTvIlA2he9Wp9tlUsmw8EJ04LHkkbvc2YRqbAEmmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Itpf5ky6NCQgfRhYBmjMrS9ZjXJhC+zSAMxnkahA4R3MmxQ7RXkSc9VrvM9pMf22J
	 C6HduG98riEUs4+kQEGvyn1W/5EbpSxFCsQLX1/vEZdto5+UFPkZE3mwwUyhLtP5g+
	 g8rUJ3e/hLCRZHvBVP4RkTCKwyztVE8tav9acQoavwlw9ImEAroOPPHVGTLVtd/BE8
	 ipySdCTFcQR1biOspzgrg3RlXcSeslIHXz6XrM3QI9AruSgFCeBqAMb4dRT9/04pWG
	 wWLWn4mUYYIFOmrPoeqGa7szRMNg5rDlpdhr9XPGzB5EXpjU9tuWYZbWuXrS0B8GTS
	 VFXE/gDxwOGwA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2V-2AMD;
	Wed, 29 Apr 2026 11:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/19] spi: cavium-thunderx: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:21 +0200
Message-ID: <20260429091333.165363-8-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091333.165363-1-johan@kernel.org>
References: <20260429091333.165363-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation to simplify error
handling and to avoid having to take another reference during
deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cavium-thunderx.c | 32 ++++++++-----------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index f1a9aa696c87..529b4066c922 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -24,7 +24,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	struct octeon_spi *p;
 	int ret;
 
-	host = spi_alloc_host(dev, sizeof(struct octeon_spi));
+	host = devm_spi_alloc_host(dev, sizeof(struct octeon_spi));
 	if (!host)
 		return -ENOMEM;
 
@@ -32,17 +32,15 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto error;
+		return ret;
 
 	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret)
-		goto error;
+		return ret;
 
 	p->register_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
-	if (!p->register_base) {
-		ret = -EINVAL;
-		goto error;
-	}
+	if (!p->register_base)
+		return -EINVAL;
 
 	p->regs.config = 0x1000;
 	p->regs.status = 0x1008;
@@ -50,10 +48,8 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	p->regs.data = 0x1080;
 
 	p->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		ret = PTR_ERR(p->clk);
-		goto error;
-	}
+	if (IS_ERR(p->clk))
+		return PTR_ERR(p->clk);
 
 	p->sys_freq = clk_get_rate(p->clk);
 	if (!p->sys_freq)
@@ -70,15 +66,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, host);
 
-	ret = spi_register_controller(host);
-	if (ret)
-		goto error;
-
-	return 0;
-
-error:
-	spi_controller_put(host);
-	return ret;
+	return spi_register_controller(host);
 }
 
 static void thunderx_spi_remove(struct pci_dev *pdev)
@@ -90,14 +78,10 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-
-	spi_controller_put(host);
 }
 
 static const struct pci_device_id thunderx_spi_pci_id_table[] = {
-- 
2.53.0

