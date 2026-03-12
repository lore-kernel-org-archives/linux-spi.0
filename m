Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D131717C;
	Thu, 12 Mar 2026 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311374; cv=none; b=opJTPmRcX6ys1717b/AnKLsrzBkTrDpRE9EruXiHNVOSOFIUAAStWYP/uRweg0lq6xR++01PHxk0vcYYLMobsp0toXeK2pmBcRDHu82S54kG7WCCszVI9dCH3/1BgW0TOL/Q4hYL3ef/6tWlGElef0Wj8MrUJ/gwCxZxaLu8eqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311374; c=relaxed/simple;
	bh=9y3cOzUo2200F+loQU7fes4jT/LC+DsP42o28Zpd/Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1uhI81CE0ZgjkyEouEdH9KSxkXRPDxiYSOqThxQCKaCQlUhYprntVmiarJTHUYouA/F9JUDv8YhDn7Wm/8jHMJJxUSHgSG8TbH9i73NvEVjC2IHk6OGlHo2l3OTI93jJWcCYv1ROaI8QYFLf3BpnDRmMoyyT1XXlS8BnidUthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebuMVO3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebuMVO3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDC8C4CEF7;
	Thu, 12 Mar 2026 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773311374;
	bh=9y3cOzUo2200F+loQU7fes4jT/LC+DsP42o28Zpd/Vs=;
	h=From:To:Cc:Subject:Date:From;
	b=ebuMVO3j0wZDz2eNPYVnDeWEsozj3lNiXAakckQvkoDb1mqKelSZf04WmiIQj10MS
	 JAHhH9ztHaU5wy2LMOAceGud1LztI3nFHKW/mAN4wOu/vhLFWWG8sH23MZHOq2Ksgv
	 LwKM9xpe6Dn6OlKkxHmlrDttYkyjYTca+fvXZ2rLQjWQsiC/V8eYc3s3N3vT6iM/D4
	 N9VwDQZegYVTwqFPsYEaE3prZRzgRQHMdZrQrUpymmQ6XWA+JGwGf1PEUO3Xxz9CbU
	 b1k/UGS1Rf8TGZMx0Aw2wDae06/7lU15y27rUfN3SfzS/ww7mmhl7jQVL5n7bWN/P8
	 vX2pMvmDHN2EQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0dIJ-000000007dq-2xOO;
	Thu, 12 Mar 2026 11:29:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Mark Brown <broonie@kernel.org>
Cc: Harshit Shah <hshah@axiado.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: axiado: fix use-after-free on probe failure
Date: Thu, 12 Mar 2026 11:28:11 +0100
Message-ID: <20260312102811.29223-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI controller allocation is device managed and must not be released
before returning on probe failures (e.g. probe deferral) to avoid
use-after-free.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>
Cc: Prasad Bolisetty <pbolisetty@axiado.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-axiado.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 8cea81432c5b..a7665cf42c29 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -765,29 +765,25 @@ static int ax_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctlr);
 
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xspi->regs)) {
-		ret = PTR_ERR(xspi->regs);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xspi->regs))
+		return PTR_ERR(xspi->regs);
 
 	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xspi->pclk);
-		goto remove_ctlr;
+		return PTR_ERR(xspi->pclk);
 	}
 
 	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref");
 	if (IS_ERR(xspi->ref_clk)) {
 		dev_err(&pdev->dev, "ref clock not found.\n");
-		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_ctlr;
+		return PTR_ERR(xspi->ref_clk);
 	}
 
 	ret = clk_prepare_enable(xspi->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(xspi->ref_clk);
@@ -869,8 +865,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
-remove_ctlr:
-	spi_controller_put(ctlr);
+
 	return ret;
 }
 
-- 
2.52.0

