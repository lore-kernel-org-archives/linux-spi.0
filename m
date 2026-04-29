Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B73BED37;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=pZ/v1DR4e2Zr640cn9c/9LH0WDxFDC5JfcyIdKrxKhcPlZlVK28rLEaC4OvRlVT9ufCvZXPl7qxMOUfVbnEccIXXXwX+6U3+ScFlUSZVSlWmS5HvtrCeeJFzEhSorgbgIjCVBvkO6oZd3mfY9cmr5BS+ie2PvEQ3GldgzuWacas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=Eyb1Nu+90yTZ5mu01NjCfMd+AV0IXHjBMn+fGTS2nsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu+sYwxs1IuSxr2PV4P8HJumVh2pkY78gnJQuqj2xcF87lR/DSC4vbd6IXjon4EMbQO2AqYewk27M9Wo3b/LpE0zIFO/pdOyFuOkE3Cwm15ZBTKhcaOzPBVZVSMqVbbwB5lWtVU/iWX13iTswW6nt7ljT5+/95O1M+tSEnhZSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1B7McZq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1B7McZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDE0C2BCFD;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=Eyb1Nu+90yTZ5mu01NjCfMd+AV0IXHjBMn+fGTS2nsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1B7McZqqC7egMVkVokuWlq16nDirBechwCenP4MC8PPsqj5xC5hTYRzva6defBN1
	 6OqB2PE/oGmdU0lDKGjYKl1jwZgAEMM5pVR5vy4qfEDDqeHCrKsYzWlTqwMT3/qoqy
	 GEnFALjMvOTo8nxgJP6cNlIkKhg/a42HD78GBOetm6L9o4oT8Za6f0PUcXpt9y2uE1
	 p/rQ3FKKzi7Tml9vppAfVKtK4nQfNQvSwNCyhhv4KY3J+9ywzQJdwSIKslberVvFFL
	 RAkYHDCvO884emllUnJQlhfDQI8FxrxtLGpE0zZvg6CpB9ALGOiMlX91OLVy5XaULx
	 FCYbKYqiGDmkA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2f-2MlT;
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
Subject: [PATCH 12/19] spi: fsl-espi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:26 +0200
Message-ID: <20260429091333.165363-13-johan@kernel.org>
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
 drivers/spi/spi-fsl-espi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 45b9974ae911..f560bd537f7d 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -667,7 +667,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	struct fsl_espi *espi;
 	int ret;
 
-	host = spi_alloc_host(dev, sizeof(struct fsl_espi));
+	host = devm_spi_alloc_host(dev, sizeof(struct fsl_espi));
 	if (!host)
 		return -ENOMEM;
 
@@ -690,8 +690,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	espi->spibrg = fsl_get_sys_freq();
 	if (espi->spibrg == -1) {
 		dev_err(dev, "Can't get sys frequency!\n");
-		ret = -EINVAL;
-		goto err_probe;
+		return -EINVAL;
 	}
 	/* determined by clock divider fields DIV16/PM in register SPMODEx */
 	host->min_speed_hz = DIV_ROUND_UP(espi->spibrg, 4 * 16 * 16);
@@ -700,15 +699,13 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	init_completion(&espi->done);
 
 	espi->reg_base = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(espi->reg_base)) {
-		ret = PTR_ERR(espi->reg_base);
-		goto err_probe;
-	}
+	if (IS_ERR(espi->reg_base))
+		return PTR_ERR(espi->reg_base);
 
 	/* Register for SPI Interrupt */
 	ret = devm_request_irq(dev, irq, fsl_espi_irq, 0, "fsl_espi", espi);
 	if (ret)
-		goto err_probe;
+		return ret;
 
 	fsl_espi_init_regs(dev, true);
 
@@ -732,8 +729,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-err_probe:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -784,13 +780,9 @@ static void of_fsl_espi_remove(struct platform_device *dev)
 {
 	struct spi_controller *host = platform_get_drvdata(dev);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(&dev->dev);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

