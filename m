Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8102D94BA;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=XBEd1HX0GuUC7j85+f9fgZjBJr+8Y/YOEbvPdD5zFI7hQMWiW2I9XxQjBGs9W4CxR7VHznQv00h0EsoiU4DNYU4MWjmIMXjErlVU3cNxgftMdyGX/f53flhFDWr+vufv9exw8Bqbiue1CXTYGMfQdoUK0l0/qcseuqy0HqtRs3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=u4BX8owGs/FlxIt9J8XNjTjKc3B7/YxCjfSf/JynjM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3jJq1Ts8+RnfKy9ADw8o8AJ5jYWUTFQCMM9zE+0k81foj3i4SV0wMBfJPFMxAGFoXP4HB1IbiON6eq092TrZsxP9Tqq+cEtPX6IAQz8EvLWxnRrWRHhTIPwd8t4SMGM5oou+oZwmqZ7oLZ1Eeq279mbpQ9pttvsnYMorCKvbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maEbirDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maEbirDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6EFC2BD04;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=u4BX8owGs/FlxIt9J8XNjTjKc3B7/YxCjfSf/JynjM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maEbirDQR07dNrieSauEB4J78f5fsPCeRAUgvPiWtEhtYXFcNUCVKPN0JK7gtZBB4
	 trfou195TYVuINRYWHkVoF/cqpt/yI9gFWwr1JYTBqFPMyEe2KcCN29B2elXZ6re0G
	 4P/zfzi7izCURzcHe1e4tvn0/TYKdsj7Gg9+/YqLt0HHQxfW58YW3zYgGRZm+FRQPU
	 im6jrsg5KIgmceupmctT1bybtisbXGGr7xlxCJT+AjlxyQGvsOcVrlJxMsFclDQLcl
	 F8diJGCyvVEFimJhOqYyM1KnP+Tst9AUo/zS4nN6ShW53G8/DrZJG4/7QJe8/yL2b0
	 XG9oz6vqeUhpQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8M-2HMG;
	Mon, 11 May 2026 17:04:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>,
	Yang Shen <shenyang39@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/12] spi: meson-spifc: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:06 +0200
Message-ID: <20260511150408.796155-11-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511150408.796155-1-johan@kernel.org>
References: <20260511150408.796155-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation for consistency and to
simplify error handling.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-meson-spifc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index b818950a8cb7..d700fa315223 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -288,9 +288,9 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	struct meson_spifc *spifc;
 	void __iomem *base;
 	unsigned int rate;
-	int ret = 0;
+	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct meson_spifc));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct meson_spifc));
 	if (!host)
 		return -ENOMEM;
 
@@ -300,23 +300,18 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	spifc->dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto out_err;
-	}
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	spifc->regmap = devm_regmap_init_mmio(spifc->dev, base,
 					      &spifc_regmap_config);
-	if (IS_ERR(spifc->regmap)) {
-		ret = PTR_ERR(spifc->regmap);
-		goto out_err;
-	}
+	if (IS_ERR(spifc->regmap))
+		return PTR_ERR(spifc->regmap);
 
 	spifc->clk = devm_clk_get_enabled(spifc->dev, NULL);
 	if (IS_ERR(spifc->clk)) {
 		dev_err(spifc->dev, "missing clock\n");
-		ret = PTR_ERR(spifc->clk);
-		goto out_err;
+		return PTR_ERR(spifc->clk);
 	}
 
 	rate = clk_get_rate(spifc->clk);
@@ -342,8 +337,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	return 0;
 out_pm:
 	pm_runtime_disable(spifc->dev);
-out_err:
-	spi_controller_put(host);
+
 	return ret;
 }
 
-- 
2.53.0

