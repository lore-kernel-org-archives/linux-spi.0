Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473123BE162;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=DTcwar4fyug43y7M5Kk10Tp7GF+N2Na/+siDz7CinjszCHGeseZS22zDFBR8RZqtjRP92ffegxODSNJ21DjNxmJVEOHGoc89lZ4vciYLmqBN1CRlHNRImSYu6/Vy+Nla8UHuaQEMiF2KDiGmLV9dSxBKmQZtfvQIsppalKjw9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=dgIC/M2uDGgZ6C94zEb11iAxtgokUzUiRJjjHpLAgmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrREm0AdHlzDZ0Z6zy7np4qSmz+MRG6HXRbgqFOf+VMiwyfdV7uuMwygw8F0FpNHdcl5976sCdDDr3rkELjBhX/ajmV1XNa1rQMaCxpOpdBln2w/AEr0Lf0Y0Sb40dT+G7kSH1Ba+UqrU5IzRzWC4pjF8ZI/nEBAy7FkGm+Cb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFwMEYjz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFwMEYjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DC6C4AF0B;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=dgIC/M2uDGgZ6C94zEb11iAxtgokUzUiRJjjHpLAgmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFwMEYjz2N0E8ROL1g3r9XA46gKoNXnb6ak2t2+XDX4YI7WRwY8OhZho6f2H+QMsX
	 ZRNFj/3routSFa8xitANEX347fkRZhTUK9CFl274MX3dimA6e8Bb055S+pwMYEjLGd
	 3UDr3nWbeYh5Zn7AUHksrvRlzZLnC+Il3BmaJp/KUphBfs1cq71qsXi5MKmYur00Iu
	 118cTU0g1MoeMYrO1EvEXAyeTkPKDn09GmGGiHaAi/p76d0xtQyaOqVfEzs1NfkomE
	 R8xLUBBmAoPpLpLqDYTXGMR1xuYaLKif47vQ6NbNOKbpbxI6jdOcJb0w8gHDzQAoda
	 TYa5Tl04TGhgQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2J-1vY3;
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
Subject: [PATCH 01/19] spi: at91-usart: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:15 +0200
Message-ID: <20260429091333.165363-2-johan@kernel.org>
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
 drivers/spi/spi-at91-usart.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 79edc1cd13c0..32fee5a7ffdf 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -496,14 +496,13 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = -ENOMEM;
-	controller = spi_alloc_host(&pdev->dev, sizeof(*aus));
+	controller = devm_spi_alloc_host(&pdev->dev, sizeof(*aus));
 	if (!controller)
-		goto at91_usart_spi_probe_fail;
+		return -ENOMEM;
 
 	ret = at91_usart_gpio_setup(pdev);
 	if (ret)
-		goto at91_usart_spi_probe_fail;
+		return ret;
 
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	controller->dev.of_node = pdev->dev.parent->of_node;
@@ -525,10 +524,8 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 
 	aus->dev = &pdev->dev;
 	aus->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(aus->regs)) {
-		ret = PTR_ERR(aus->regs);
-		goto at91_usart_spi_probe_fail;
-	}
+	if (IS_ERR(aus->regs))
+		return PTR_ERR(aus->regs);
 
 	aus->irq = irq;
 	aus->clk = clk;
@@ -536,11 +533,11 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, at91_usart_spi_interrupt, 0,
 			       dev_name(&pdev->dev), controller);
 	if (ret)
-		goto at91_usart_spi_probe_fail;
+		return ret;
 
 	ret = clk_prepare_enable(clk);
 	if (ret)
-		goto at91_usart_spi_probe_fail;
+		return ret;
 
 	aus->spi_clk = clk_get_rate(clk);
 	at91_usart_spi_init(aus);
@@ -571,8 +568,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	at91_usart_spi_release_dma(controller);
 at91_usart_fail_dma:
 	clk_disable_unprepare(clk);
-at91_usart_spi_probe_fail:
-	spi_controller_put(controller);
+
 	return ret;
 }
 
@@ -634,14 +630,10 @@ static void at91_usart_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
-
-	spi_controller_put(ctlr);
 }
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {
-- 
2.53.0

