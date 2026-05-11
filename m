Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADC2D9EF4;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=LOXYmRqRX6rNQ/lLunBuF7ncfAYQQAGLBt2wB2Kr/PphPLyKqcSacvQaAyI5OMiVIKRFJdr3fJ5vl5kKOhia6Jj5HNSWSXp9mL5SlgFpAyfzV6slOZFFdV4RLQEqXCAeJHzvgylbMrSXpNiY6ul9zFc3wBxI5pJDnmTMaw525Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=71xmPS/mYDfanmj/F+g/504hnZEO3DjMAI7d6O8rprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzicqCt9bf3dgO+qDtPJ6nfF7Dc4Pd5afJaFn9qqtWT9CT0T/BBtSLqyFfLyYg9k+OHb5eUx0S//vZfOUFN6EZFHhMCq+tVauMBrjdRFi36X6k/eUyrGoaz5Tkta0JX3utzyN6V6+FrkGWilS+dk5/d6A8GLFnm9iJ5CWAn7YkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DegN/cn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DegN/cn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA833C2BD00;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=71xmPS/mYDfanmj/F+g/504hnZEO3DjMAI7d6O8rprc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DegN/cn43tuoutf5yJgKVPxjGs/7vilgYfukOxL0JNsWGHU/Z/3PllBzNNoh/7gtv
	 C6NxVd1y+OMYCIhDd1J1L2URs8olruwaggy0L48FNzqb75SvSm9ZPVHxtJi1N8XzPO
	 MlOeO83v8Nb9n4HdUnMVIcb/aEWUzV8pOikChk6w7zQDniUrSzR4WZffk9RhGla6iB
	 qJ39PWkOp8HYiA9AtRARsPPFMpnpq1x1FLPYoyulj7t8EVsnx1rSoUQefyKyVJqNjy
	 HofPjF0isyFWQ2t1Qk71wVbFiAJSk14JKulH1VoIhY5wTx9Nsmop3W3F1rakMRux0q
	 8yY9Ku6k2xD7g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L88-20re;
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
Subject: [PATCH 03/12] spi: clps711x: switch to managed controller allocation
Date: Mon, 11 May 2026 17:03:59 +0200
Message-ID: <20260511150408.796155-4-johan@kernel.org>
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
 drivers/spi/spi-clps711x.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index d6458e59d41b..382c3c81c4b9 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -99,7 +99,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*hw));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*hw));
 	if (!host)
 		return -ENOMEM;
 
@@ -113,22 +113,16 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	hw = spi_controller_get_devdata(host);
 
 	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(hw->spi_clk)) {
-		ret = PTR_ERR(hw->spi_clk);
-		goto err_out;
-	}
+	if (IS_ERR(hw->spi_clk))
+		return PTR_ERR(hw->spi_clk);
 
 	hw->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
-	if (IS_ERR(hw->syscon)) {
-		ret = PTR_ERR(hw->syscon);
-		goto err_out;
-	}
+	if (IS_ERR(hw->syscon))
+		return PTR_ERR(hw->syscon);
 
 	hw->syncio = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hw->syncio)) {
-		ret = PTR_ERR(hw->syncio);
-		goto err_out;
-	}
+	if (IS_ERR(hw->syncio))
+		return PTR_ERR(hw->syncio);
 
 	/* Disable extended mode due hardware problems */
 	regmap_update_bits(hw->syscon, SYSCON_OFFSET, SYSCON3_ADCCON, 0);
@@ -139,16 +133,9 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, spi_clps711x_isr, 0,
 			       dev_name(&pdev->dev), host);
 	if (ret)
-		goto err_out;
+		return ret;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (!ret)
-		return 0;
-
-err_out:
-	spi_controller_put(host);
-
-	return ret;
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 static const struct of_device_id clps711x_spi_dt_ids[] = {
-- 
2.53.0

