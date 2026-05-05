Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511833DCDBE;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=uMtPP7zaTuSsT6vf6Ta0nTFuQPFWKJxj2T5e5TOHBt15annnJSyiD+mC+YlL+6SuqN/fBjdB4IIvgyKBZTuIWl+WlfqmNXj+RM5zlch77SfiruxZNnuu3ckOaXJzG6qH2pZ9rpYkBGhogsBDOvW4cY9/Yzl7/hc9Gceo2DWdZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=4JNZiJh6BEu5CJzOX17CyHntpumSLZXeDgoywa7k2Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHyXuE0WTnLqavfdpw5evsVBU73DH7LJ1k18lp4982OYl2Cwh8LwMO1q8BCB7nYOpcICq6E0g1PTFXd6KXq2VtsiroFMVd1yfBiNy9wrtK3ST0UZ3rnpFSRphKNjwOfWaMCZQcwaDyuJiYB4ZXRl9N72bsXjnyPv6ZvWLqSF6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u31f0xV3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u31f0xV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067BCC2BCF6;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=4JNZiJh6BEu5CJzOX17CyHntpumSLZXeDgoywa7k2Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u31f0xV3rFYZvihme7/Pej0j4SMtyiACkHvOyVjSo2gm04DrHq4SVZMkqwRnxpqD0
	 23mseUejeB3J/sxOyXpG/k+XW5dHOPlA1KtUg7UfW2kqxGYjo7kEm48dYal3YhGVEX
	 OUr03ue1Mrhw/yZ32qIFYzU25HRCpqB/CtnLB54bz/JEfUScRFAZCav+qDx7D17Hdq
	 JtvMvIpbX8+tJ4yClyPFN+r7i694vePheH5KVZCMjVpkJB4RQfRZBnVNq7sjccy5Ci
	 3VqnwWcSAeP15tHaMhorZmGa9O/kjtOQ+tDivbhErJl7ms2iaa3vowkGxOtq7UkpoT
	 BvW4FX+4tABhw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002at5-2vjY;
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
Subject: [PATCH 09/20] spi: slave-mt27xx: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:58 +0200
Message-ID: <20260505072909.618363-10-johan@kernel.org>
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
 drivers/spi/spi-slave-mt27xx.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 7aedeaa5889d..e60ab4c18bed 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -388,11 +388,9 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	int irq, ret;
 	const struct of_device_id *of_id;
 
-	ctlr = spi_alloc_target(&pdev->dev, sizeof(*mdata));
-	if (!ctlr) {
-		dev_err(&pdev->dev, "failed to alloc spi target\n");
+	ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*mdata));
+	if (!ctlr)
 		return -ENOMEM;
-	}
 
 	ctlr->auto_runtime_pm = true;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
@@ -406,8 +404,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	of_id = of_match_node(mtk_spi_slave_of_match, pdev->dev.of_node);
 	if (!of_id) {
 		dev_err(&pdev->dev, "failed to probe of_node\n");
-		ret = -EINVAL;
-		goto err_put_ctlr;
+		return -EINVAL;
 	}
 	mdata = spi_controller_get_devdata(ctlr);
 	mdata->dev_comp = of_id->data;
@@ -420,35 +417,31 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	init_completion(&mdata->xfer_done);
 	mdata->dev = &pdev->dev;
 	mdata->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mdata->base)) {
-		ret = PTR_ERR(mdata->base);
-		goto err_put_ctlr;
-	}
+	if (IS_ERR(mdata->base))
+		return PTR_ERR(mdata->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_put_ctlr;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, mtk_spi_slave_interrupt,
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
-		goto err_put_ctlr;
+		return ret;
 	}
 
 	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(mdata->spi_clk)) {
 		ret = PTR_ERR(mdata->spi_clk);
 		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
-		goto err_put_ctlr;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(mdata->spi_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
-		goto err_put_ctlr;
+		return ret;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -465,8 +458,6 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
-err_put_ctlr:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
@@ -475,13 +466,9 @@ static void mtk_spi_slave_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(ctlr);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

