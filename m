Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2D3C13E3;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=oAJC+Y7DXk7s5ju9+a0ZNv7GPGP5rV3OwFMtbGMObaUw5o+VYc0AInt6CT2YmAN1M7TNHsLPdSsryWDvZtoYgEUuwiCc2hDsCExHoe44lqhr9qCfTw5Ak0XzLU6eFM9AguuTC0fjqDkVZ1l7hBpYmLyE4bixFFP0V0Gc6f0tdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=a6xKSd5zoi2HPbnZ+t/fnsNLvJyQkNXRV2MIagw8iSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euk34rMyEABHTHKr50ohyEr/P/LFGASb8N9CTIJpQvIfOd0webKQP7YxBfg9KcIo3rPwZzgxcqJY0YEHFGmkeb3341B/SbgJxR4clVoVbB+O1BxHRH1k7uc58OkBRrq0wctk8vpiANGjb17JfRU54GrrWQZzMSFicJcXSlWk/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYAXUIbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYAXUIbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D137C4AF0E;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=a6xKSd5zoi2HPbnZ+t/fnsNLvJyQkNXRV2MIagw8iSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYAXUIbmJrry+yb7d7hkLnsG8WDzxQ+vhNlh6oKCVaaeU3RKqbubfnn6/ofI8aBa3
	 oqv1XtesMjtPLrLRZcXnm4s9Bdw6u8AElnijLMavRt0K2Bzq3ImE8GFmCSY3yxvcrQ
	 WXteH3k+nc9VTA/u4u5FSmMKUCaarTZGXL5r/dBsqh+4clyL1Ut18yHg5DWZqo55zE
	 /4sY280Kw5UzyMs0aFd3JiikltbbMepsSobb2tTr1LUyrzSMftt28xWdxlovCKfZj7
	 J/eVw8YZa7FjeULUc7zc9DePV5TeZwNLUgCYwyUNqK3EkIy3WWkUjcrY3ds54iF3W1
	 Hg2+G+qGOic0A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d73-0HoV;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 12/20] spi: ep93xx: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:11 +0200
Message-ID: <20260409120419.388546-13-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 011f23a3c2f2 ("spi/ep93xx: implemented driver for Cirrus EP93xx SPI controller")
Cc: stable@vger.kernel.org	# 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 90d5f3ea6508..db50018050e5 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -689,7 +689,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
-	error = devm_spi_register_controller(&pdev->dev, host);
+	error = spi_register_controller(host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
 		goto fail_free_dma;
@@ -713,7 +713,13 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ep93xx_spi_release_dma(espi);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id ep93xx_spi_of_ids[] = {
-- 
2.52.0

