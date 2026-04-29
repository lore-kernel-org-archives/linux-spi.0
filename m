Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB333BED01;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=Lj6E+TQyeUCRsZo6+e0kM7GtR2AO5wlXfRJ4NBrxt3tMrLkWA8IqLdV0VSzpCbu7xtC9ZcvNo9uaOVOMlK7+mO2009Y2+E0hPIMLuU0g459ZzNPKCi8afdEsry26UsGVE0Zfs5/G/pEf8tmBQQ6zSX1kActBPCeSJ+2gVOtHL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=gfjTEguMoiutCVH4/SZdDjr6O5nH9rTa9Fh1KfDNv7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IazokO/heLPuxOpSbkDqKO2T1Vlwad4HZtRttgM5i8pIxg8bb1ZCI4Jf68zO/vXwJTjyfUdn/YXR7HfdJqiWWQjWKhvq4Ve1X8oGDXfqf4DB5xI6//RkSr/D/FiUewNl8YodcNqvyAPMbUIhLSICltYNWZ6HerRcD1f957UfGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLAQ+HmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLAQ+HmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E7C2BCF6;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=gfjTEguMoiutCVH4/SZdDjr6O5nH9rTa9Fh1KfDNv7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLAQ+HmKN46lpDLr/qfJWlnGZzc/608gqctjdBfJnImOkMkmFf1vpANAhnDrteiI3
	 x6VxUAIaSlhmRyuNzUpTy0S4/7ATe4F/kwLAAE/ojkq6rQ8TlMN5op9LwaEceAQvIc
	 hyZf2PEzvlwvpASsKhG6Hp/1vmHisigmRYe0AQYCzOaTNM5Qgb0i7rZg/tnfd8goWb
	 I3RHoFDojQyfAXy9rLrtxieRQ8ZM4l0JWgDbKUGcjsJUmxdKOzxbIDmZ/9T7jAKsde
	 R6h7O71j72BN+9QJKRzUS33I2w8xfvOyA45zVsIzEvE7rJKfBDNFOsqtX14eXVO2S6
	 o7booSRQkRLFQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2h-2P6g;
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
Subject: [PATCH 13/19] spi: img-spfi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:27 +0200
Message-ID: <20260429091333.165363-14-johan@kernel.org>
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
 drivers/spi/spi-img-spfi.c | 40 ++++++++++++++------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 57625a3ce2f2..aec724e3f824 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -530,7 +530,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	int ret;
 	u32 max_speed_hz;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spfi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spfi));
 	if (!host)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, host);
@@ -541,36 +541,32 @@ static int img_spfi_probe(struct platform_device *pdev)
 	spin_lock_init(&spfi->lock);
 
 	spfi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(spfi->regs)) {
-		ret = PTR_ERR(spfi->regs);
-		goto put_spi;
-	}
+	if (IS_ERR(spfi->regs))
+		return PTR_ERR(spfi->regs);
+
 	spfi->phys = res->start;
 
 	spfi->irq = platform_get_irq(pdev, 0);
-	if (spfi->irq < 0) {
-		ret = spfi->irq;
-		goto put_spi;
-	}
+	if (spfi->irq < 0)
+		return spfi->irq;
+
 	ret = devm_request_irq(spfi->dev, spfi->irq, img_spfi_irq,
 			       IRQ_TYPE_LEVEL_HIGH, dev_name(spfi->dev), spfi);
 	if (ret)
-		goto put_spi;
+		return ret;
 
 	spfi->sys_clk = devm_clk_get(spfi->dev, "sys");
-	if (IS_ERR(spfi->sys_clk)) {
-		ret = PTR_ERR(spfi->sys_clk);
-		goto put_spi;
-	}
+	if (IS_ERR(spfi->sys_clk))
+		return PTR_ERR(spfi->sys_clk);
+
 	spfi->spfi_clk = devm_clk_get(spfi->dev, "spfi");
-	if (IS_ERR(spfi->spfi_clk)) {
-		ret = PTR_ERR(spfi->spfi_clk);
-		goto put_spi;
-	}
+	if (IS_ERR(spfi->spfi_clk))
+		return PTR_ERR(spfi->spfi_clk);
 
 	ret = clk_prepare_enable(spfi->sys_clk);
 	if (ret)
-		goto put_spi;
+		return ret;
+
 	ret = clk_prepare_enable(spfi->spfi_clk);
 	if (ret)
 		goto disable_pclk;
@@ -658,8 +654,6 @@ static int img_spfi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(spfi->spfi_clk);
 disable_pclk:
 	clk_disable_unprepare(spfi->sys_clk);
-put_spi:
-	spi_controller_put(host);
 
 	return ret;
 }
@@ -669,8 +663,6 @@ static void img_spfi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	if (spfi->tx_ch)
@@ -683,8 +675,6 @@ static void img_spfi_remove(struct platform_device *pdev)
 		clk_disable_unprepare(spfi->spfi_clk);
 		clk_disable_unprepare(spfi->sys_clk);
 	}
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0

