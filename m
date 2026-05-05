Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B73DDDBE;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=dXF/5d6HEwUaHiyFW47P9YKgRnqM08y8ugsqkrvq31gdUdzMIum8gOfF+ExBuXAI7UAlEhYrxnTwHpr/jWGEW9ybbEVRaf4zLKfo1kPxADTzVdIjf9aaU2jw922WOxPcK1Ah74AGgYxtvO3ZpFQILKC5YxAMbYZsmM1vqg9sIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=8Zq3sbnN/60Pokd899geEsRfwmJHRBlxN3C6i2/zPqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7FAfNm93gfXcOF0RzM11IS3Gf/mgbLGs4MPwJnFA3ZP9nZxjA7YkySXte4I/uB14OLnvNbcs20yOC+Lw/2rzeuwFAKI09vxXmdQqKGAlbnUszxqTyMd0jJsYg469yslJR8qHjvgTPkWtSBuSPADrsLGKyDzaLJou3RrbHpc+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Sd9VUG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Sd9VUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FD1C2BCFC;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=8Zq3sbnN/60Pokd899geEsRfwmJHRBlxN3C6i2/zPqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0Sd9VUGXFRGq7nZeg0/vT2z+sD+o0QkNM9+5y7ftSTLSkvSat1UPpAwjpBVKF0rj
	 ORsrTKv3vvET1HXfmAwVLeqZPPgNdvKqtoi/f6GWGufdS5kIEMNvDkEw8cXBF2gIPG
	 vut3KntGiOFGtG05V9gwEnOYq6Ra7NvSBlOvlsHwN7+JZAULP40YVhQmihV07/ezY7
	 SS9kcRpFRNgZ6kbLdMPZAD1ONHZEMl6ZIDBx/1R2SknVcT6W+40U7QvKXMn9jS6iq9
	 JPRcgT+Eth9X86NNSElaZrfE4SakDsWjDNC0pIUWkxCKeBJEJ7vzkBcwwGypqOx32l
	 XqxSsLP55pl7w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002at1-2rBs;
	Tue, 05 May 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/20] spi: sh-msiof: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:56 +0200
Message-ID: <20260505072909.618363-8-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505072909.618363-1-johan@kernel.org>
References: <20260505072909.618363-1-johan@kernel.org>
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
 drivers/spi/spi-sh-msiof.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f114b6313f4f..070e16bc764f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1215,9 +1215,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		info->dtdl = 200;
 
 	if (info->mode == MSIOF_SPI_TARGET)
-		ctlr = spi_alloc_target(dev, sizeof(struct sh_msiof_spi_priv));
+		ctlr = devm_spi_alloc_target(dev, sizeof(struct sh_msiof_spi_priv));
 	else
-		ctlr = spi_alloc_host(dev, sizeof(struct sh_msiof_spi_priv));
+		ctlr = devm_spi_alloc_host(dev, sizeof(struct sh_msiof_spi_priv));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
@@ -1234,26 +1234,21 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p->clk)) {
 		dev_err(dev, "cannot get clock\n");
-		ret = PTR_ERR(p->clk);
-		goto err1;
+		return PTR_ERR(p->clk);
 	}
 
 	i = platform_get_irq(pdev, 0);
-	if (i < 0) {
-		ret = i;
-		goto err1;
-	}
+	if (i < 0)
+		return i;
 
 	p->mapbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(p->mapbase)) {
-		ret = PTR_ERR(p->mapbase);
-		goto err1;
-	}
+	if (IS_ERR(p->mapbase))
+		return PTR_ERR(p->mapbase);
 
 	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(dev), p);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
-		goto err1;
+		return ret;
 	}
 
 	p->pdev = pdev;
@@ -1300,8 +1295,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
  err2:
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(dev);
- err1:
-	spi_controller_put(ctlr);
+
 	return ret;
 }
 
@@ -1309,14 +1303,10 @@ static void sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
-	spi_controller_get(p->ctlr);
-
 	spi_unregister_controller(p->ctlr);
 
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(p->ctlr);
 }
 
 static const struct platform_device_id spi_driver_ids[] = {
-- 
2.53.0

