Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748543BED1E;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=renowQfAZHZuurQJjABOaV2LHfCNWz5Vyu4x/+SpTdjdWZ/Fwvp77ojYLNoQipyig4BY1ounPjX48gN6vxFMenhn9YZ4CKzrzupjV6zYxq2ePMXN+9s6/7RJJb+04ikEUOXzYrmUVMiyUq45T4MHUKH2zJSNHWSWNOyPfZ2Z5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=nJGFQeuxMxzw7r7T7Rr94re8fzfd2ZqVmgIy8nfVJSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6JvBeOnd9za8IcVHLs29TuJ/0pQ4VwaMJMNBoLCpmxi96QQaX4+39CNoj/lU3AZBA/dUciFYgydLsRnz9id7NIdF63SvkUKFleTefKYsgq/xyXp6shnN/DLetPSVyLxt4lwNC9wx0IKnxb2CSs9PsfXPJDY64CLJol9Ytk208k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrAyXoS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrAyXoS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A0BC2BCC7;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=nJGFQeuxMxzw7r7T7Rr94re8fzfd2ZqVmgIy8nfVJSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrAyXoS9jP0+Y9AP346RYcDN8AQkN68IsnBbuLgf8ZYo0g5WE4upFUKxIJ2V3Ikqm
	 DATJDhiXb9q9rG4+ziQtRLzmabnPIdg/HCL49+t4A+iOm7LtSmExZfSAaBsgDJG4qt
	 cDmnp0tYzfR82DhJRPiEva0v0R42iifWvMYNaXsDWcnuB8NDmW4coCkcE1EOJEGQS5
	 f3J2a232+nU1AIuIe5f8j5Rn+fKlWbAybfMXil33B2N883Yq4Zsxp1JYQn5S1nVfjH
	 oNhMEgU3dVwhokAiWl6uajSQNsIreNScdpXrT6qPYWFy0dKKP9sivv3O5YH4oHvNMD
	 xfQNfFoab+r0w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2j-2RVY;
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
Subject: [PATCH 14/19] spi: lantiq-ssc: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:28 +0200
Message-ID: <20260429091333.165363-15-johan@kernel.org>
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
 drivers/spi/spi-lantiq-ssc.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 75b9af8cb5db..ecae50a50b14 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -913,7 +913,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 
 	hwcfg = of_device_get_match_data(dev);
 
-	host = spi_alloc_host(dev, sizeof(struct lantiq_ssc_spi));
+	host = devm_spi_alloc_host(dev, sizeof(struct lantiq_ssc_spi));
 	if (!host)
 		return -ENOMEM;
 
@@ -923,20 +923,16 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	spi->hwcfg = hwcfg;
 	platform_set_drvdata(pdev, spi);
 	spi->regbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi->regbase)) {
-		err = PTR_ERR(spi->regbase);
-		goto err_host_put;
-	}
+	if (IS_ERR(spi->regbase))
+		return PTR_ERR(spi->regbase);
 
 	err = hwcfg->cfg_irq(pdev, spi);
 	if (err)
-		goto err_host_put;
+		return err;
 
 	spi->spi_clk = devm_clk_get_enabled(dev, "gate");
-	if (IS_ERR(spi->spi_clk)) {
-		err = PTR_ERR(spi->spi_clk);
-		goto err_host_put;
-	}
+	if (IS_ERR(spi->spi_clk))
+		return PTR_ERR(spi->spi_clk);
 
 	/*
 	 * Use the old clk_get_fpi() function on Lantiq platform, till it
@@ -947,10 +943,8 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 #else
 	spi->fpi_clk = clk_get(dev, "freq");
 #endif
-	if (IS_ERR(spi->fpi_clk)) {
-		err = PTR_ERR(spi->fpi_clk);
-		goto err_host_put;
-	}
+	if (IS_ERR(spi->fpi_clk))
+		return PTR_ERR(spi->fpi_clk);
 
 	num_cs = 8;
 	of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
@@ -1006,8 +1000,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	destroy_workqueue(spi->wq);
 err_clk_put:
 	clk_put(spi->fpi_clk);
-err_host_put:
-	spi_controller_put(host);
 
 	return err;
 }
@@ -1016,8 +1008,6 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
-	spi_controller_get(spi->host);
-
 	spi_unregister_controller(spi->host);
 
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
@@ -1028,8 +1018,6 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 
 	destroy_workqueue(spi->wq);
 	clk_put(spi->fpi_clk);
-
-	spi_controller_put(spi->host);
 }
 
 static struct platform_driver lantiq_ssc_driver = {
-- 
2.53.0

