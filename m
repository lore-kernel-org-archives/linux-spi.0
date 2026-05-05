Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AF3DDDD2;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=rP6Q48fkj1OtJ7vL1rxxv4a2IIgoKuEwywChqw9PHpWicqf0tb3DFtCzcVnk3Z8j53vfCTDB5UBaHMKKRdMHHMTxpGBBq3vqE1NhjJjttsvTGScbUIZwzglpNSVozwZMoY7O54syCHhgJzC5p/XwE85OEET/oqURH2xie58wkLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=+pDDlNoUyaMJ8nEIwN41VKXR7YFinQYO6I+LaCx+orI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8YYOScHPaEdN/H/rYkb3A6LK+yzDLQlvBwG2knHHuWCLHQ7c7/42ieNJl8e9KNjDGjW60J/7h0y4/TwKa5bF1tBK4Bwrh48ktIiGiD6FHBMyUkYVUpSR2VM8kLC+irnjsJDpIibzArjCvEJvyhxOURwPgWJpU2SVDD8Y/Gjwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ+whAVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ+whAVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FEBC2BCFA;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=+pDDlNoUyaMJ8nEIwN41VKXR7YFinQYO6I+LaCx+orI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZ+whAVNuX1lpfc8pD6g0B/WDfQvp+TZX8c05D5AwJHFtcl2M+o+e7ymCM/d/e6tV
	 bvmT95IcrTCYpWqLtU29kQJkSLeUsbiXLrNpXcolf12A+YcTBx1mLCebZexlAIm2bh
	 2X5Uzc4eTkZaYjkx52AFu4B5DzzHGcseJMm3qoBkh8OjCEgMF/Xbiviyb2tQJdd3cB
	 0Z5xqfEKKDCR4O+fy+749dsmry87ncizrWkMWeWvIagZLfc60gvm78dc0TW+koDEN6
	 LXnun9XadzxeHBhuONicQJ2cU+G4cGoRnsqyLTzTEQ42g/WGvuvtvVC+CsHa21+9DZ
	 b/ozdGcKxoAaA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asr-2em6;
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
Subject: [PATCH 02/20] spi: pic32-sqi: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:51 +0200
Message-ID: <20260505072909.618363-3-johan@kernel.org>
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
 drivers/spi/spi-pic32-sqi.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 41662992dbe5..5d3921e29461 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -572,7 +572,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	struct pic32_sqi *sqi;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*sqi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sqi));
 	if (!host)
 		return -ENOMEM;
 
@@ -580,31 +580,25 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	sqi->host = host;
 
 	sqi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sqi->regs)) {
-		ret = PTR_ERR(sqi->regs);
-		goto err_free_host;
-	}
+	if (IS_ERR(sqi->regs))
+		return PTR_ERR(sqi->regs);
 
 	/* irq */
 	sqi->irq = platform_get_irq(pdev, 0);
-	if (sqi->irq < 0) {
-		ret = sqi->irq;
-		goto err_free_host;
-	}
+	if (sqi->irq < 0)
+		return sqi->irq;
 
 	/* clocks */
 	sqi->sys_clk = devm_clk_get_enabled(&pdev->dev, "reg_ck");
 	if (IS_ERR(sqi->sys_clk)) {
-		ret = PTR_ERR(sqi->sys_clk);
 		dev_err(&pdev->dev, "no sys_clk ?\n");
-		goto err_free_host;
+		return PTR_ERR(sqi->sys_clk);
 	}
 
 	sqi->base_clk = devm_clk_get_enabled(&pdev->dev, "spi_ck");
 	if (IS_ERR(sqi->base_clk)) {
-		ret = PTR_ERR(sqi->base_clk);
 		dev_err(&pdev->dev, "no base clk ?\n");
-		goto err_free_host;
+		return PTR_ERR(sqi->base_clk);
 	}
 
 	init_completion(&sqi->xfer_done);
@@ -616,7 +610,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	ret = ring_desc_ring_alloc(sqi);
 	if (ret) {
 		dev_err(&pdev->dev, "ring alloc failed\n");
-		goto err_free_host;
+		return ret;
 	}
 
 	/* install irq handlers */
@@ -656,8 +650,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 err_free_ring:
 	ring_desc_ring_free(sqi);
 
-err_free_host:
-	spi_controller_put(host);
 	return ret;
 }
 
@@ -665,15 +657,11 @@ static void pic32_sqi_remove(struct platform_device *pdev)
 {
 	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
 
-	spi_controller_get(sqi->host);
-
 	spi_unregister_controller(sqi->host);
 
 	/* release resources */
 	free_irq(sqi->irq, sqi);
 	ring_desc_ring_free(sqi);
-
-	spi_controller_put(sqi->host);
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {
-- 
2.53.0

