Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551E3DBD7D;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=aEgda+v8VpLNsBKcBTFWIbzTRkq5353Ga3xXfsNWJs/Iwuvec7gLNIYivWahG1Vk11KpNJKn3yltYN+IUGen7KW22SHP41gOP1LI36sDbwUzobIxJYKLkAEOppiOAP+0MmBHDWvTQOOh0T1icKSOCkyrHwqitkvjxuQIFL4ezoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=/9w8hG4PyTSVacEx8noDFd1xhAl9Ak+DT+AljUSuWSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7DRdhFjyV4MdfsZfGJO0nzah3/0t2YPwVWFdwaZX9XnMKhf6sO6jLtrPblCb0Fjq2pbAUvCbaZE1MGH06KPE0TaNnboa75nUI/+HuUUNfWA3ITv/EQNANJqiKmIlT7naM1I1mVa1amX2EIJ8VvjusXA8rBbk3BXc2wk2DWX8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plhoZy8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plhoZy8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA65C2BCB4;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=/9w8hG4PyTSVacEx8noDFd1xhAl9Ak+DT+AljUSuWSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plhoZy8VDovlJpNiA5FqmGsaiRjJ//VTtVYUO9o8zbkYS/nDHBocaYd+ItVCMPkZ9
	 oWzYrpq5FBMFhZihKnv8XTFouFKPFdGYftA1Opv3RDGF07hWIKZ6P1fQMJe+5Tpzqd
	 xOgOTf3pjN3iLOF9ywzIAyGBHSQpHVz7h6S66aJoct18QBHbFGvomYu0jrncxd+J0v
	 eEpekP1rDtJbxM4bV38IMDG0XQjT/sprJh0gE64B3pnfSSRzlUhXyZICUTzTlhq5dr
	 d1TyoY6h+HDFG0f1VObmcfW6fWu2VgPpfBZOlo+cPOSLysaFaRyJ3AgVww5BOOOLWC
	 Du33ceP3M7ZLQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002at3-2tOE;
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
Subject: [PATCH 08/20] spi: sifive: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:57 +0200
Message-ID: <20260505072909.618363-9-johan@kernel.org>
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
 drivers/spi/spi-sifive.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 74a3e32fd2b5..cee4d92e46f4 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -296,7 +296,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	u32 cs_bits, max_bits_per_word;
 	struct spi_controller *host;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct sifive_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct sifive_spi));
 	if (!host) {
 		dev_err(&pdev->dev, "out of memory\n");
 		return -ENOMEM;
@@ -307,24 +307,19 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	spi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi->regs)) {
-		ret = PTR_ERR(spi->regs);
-		goto put_host;
-	}
+	if (IS_ERR(spi->regs))
+		return PTR_ERR(spi->regs);
 
 	/* Spin up the bus clock before hitting registers */
 	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		dev_err(&pdev->dev, "Unable to find bus clock\n");
-		ret = PTR_ERR(spi->clk);
-		goto put_host;
+		return PTR_ERR(spi->clk);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto put_host;
-	}
+	if (irq < 0)
+		return irq;
 
 	/* Optional parameters */
 	ret =
@@ -339,8 +334,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 
 	if (!ret && max_bits_per_word < 8) {
 		dev_err(&pdev->dev, "Only 8bit SPI words supported by the driver\n");
-		ret = -EINVAL;
-		goto put_host;
+		return -EINVAL;
 	}
 
 	/* probe the number of CS lines */
@@ -350,15 +344,13 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	sifive_spi_write(spi, SIFIVE_SPI_REG_CSDEF, spi->cs_inactive);
 	if (!cs_bits) {
 		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
-		ret = -EINVAL;
-		goto put_host;
+		return -EINVAL;
 	}
 
 	num_cs = ilog2(cs_bits) + 1;
 	if (num_cs > SIFIVE_SPI_MAX_CS) {
 		dev_err(&pdev->dev, "Invalid number of spi targets\n");
-		ret = -EINVAL;
-		goto put_host;
+		return -EINVAL;
 	}
 
 	/* Define our host */
@@ -386,7 +378,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), spi);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
-		goto put_host;
+		return ret;
 	}
 
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
@@ -395,15 +387,10 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_host failed\n");
-		goto put_host;
+		return ret;
 	}
 
 	return 0;
-
-put_host:
-	spi_controller_put(host);
-
-	return ret;
 }
 
 static void sifive_spi_remove(struct platform_device *pdev)
@@ -411,14 +398,10 @@ static void sifive_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct sifive_spi *spi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
-
-	spi_controller_put(host);
 }
 
 static int sifive_spi_suspend(struct device *dev)
-- 
2.53.0

