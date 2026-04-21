Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E393D0938;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774994; cv=none; b=NZKcyFhD1ogecr7hqK7BVlJpakdfo2R/znO/Hidlf4ckwKswmt5uXK0DjMhHDzKg1sk5n+A68RI4gGOs+6KRI7gT0kUbjBMguFmwjnaT9igmbAqEyNH8nVvPbDJyfjhIh2EJC+J82+mnxckJOO5czHjKfN4gkqZK5W9F0dJKcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774994; c=relaxed/simple;
	bh=cdetVG3iR83UeCj9+yCjdATmJLyhGT47JJFMDyYz61E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHxKhQIEQjb9tfokZUS/7zJzGOrgl1a9L6N16Kqeu9qKuUuF/dmG+qSO9iXJozYCzgJDMW3+MSTQXWLJflUEtI3xWCU3dcZdrupk/gZBNCK6tY4gnJJmEJO1W1oWBXPRtdzBCqbRf7AD4TV0Fk38yTe+HVpwusG5qZfBpfBRt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7G/hrVt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7G/hrVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5CEC2BCB6;
	Tue, 21 Apr 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774993;
	bh=cdetVG3iR83UeCj9+yCjdATmJLyhGT47JJFMDyYz61E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7G/hrVtbYp4Ki6RMP2WpNNZWcSPDzh8B/SdtRTeekfJ5lMAODNv6TDobfjlMhBEm
	 BfC0kufoLtNQSuem1b7i/d3vHSxoeOhadIoJccGQ0iULx28FRb2eu/rLh5WA8VgjF9
	 0ISCvy4Obg5dq8bUROpPyNKT5lN4yFExEJ8/lyPajXhtqdeKX9lqZYdeMnBSoeDcsO
	 19bWLVVLIXh0hn46f7s4Pffjx74gamdGH4JDy/kbhhsF8b7NAvmWfqpsdhmaFRUXCB
	 eQNrsfT5RzQ9asW3OtVVaPXUIBD7aoNGwf6a3hL2u/53aXKdhma4Rp9ZqOaEJYRq7I
	 h7I7BVPUpGEwQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAL9-00000006QyH-2Pq6;
	Tue, 21 Apr 2026 14:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] spi: cadence: rename probe error labels
Date: Tue, 21 Apr 2026 14:36:14 +0200
Message-ID: <20260421123615.1533617-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421123615.1533617-1-johan@kernel.org>
References: <20260421123615.1533617-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "clk_dis_all" error label is not used to disable clocks since commit
f64b1600f92e ("spi: spi-cadence: Use helper function
devm_clk_get_enabled()").

Similarly, "remove_ctlr" drops a reference rather than deregisters the
controller.

Rename the labels after what they do.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 891e2ba36958..f27586151ca9 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -656,21 +656,21 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->regs)) {
 		ret = PTR_ERR(xspi->regs);
-		goto remove_ctlr;
+		goto err_put_ctlr;
 	}
 
 	xspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xspi->pclk);
-		goto remove_ctlr;
+		goto err_put_ctlr;
 	}
 
 	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(xspi->rstc)) {
 		ret = dev_err_probe(&pdev->dev, PTR_ERR(xspi->rstc),
 				    "Cannot get SPI reset.\n");
-		goto remove_ctlr;
+		goto err_put_ctlr;
 	}
 
 	reset_control_assert(xspi->rstc);
@@ -680,7 +680,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(xspi->ref_clk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_ctlr;
+		goto err_put_ctlr;
 	}
 
 	if (!spi_controller_is_target(ctlr)) {
@@ -710,7 +710,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
@@ -718,7 +718,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	ctlr->use_gpio_descriptors = true;
@@ -748,7 +748,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	if (!spi_controller_is_target(ctlr))
@@ -756,14 +756,14 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 	return ret;
 
-clk_dis_all:
+err_disable_rpm:
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
-remove_ctlr:
+err_put_ctlr:
 	spi_controller_put(ctlr);
 	return ret;
 }
-- 
2.52.0

