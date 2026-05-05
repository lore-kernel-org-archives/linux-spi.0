Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5433DEFFF;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=PrftdFSvys4ZTCGnSLuamaanzhagY2uS3pCHV+AA6pvLxvc+rKU+YvGASJ69fGb89BnTt7AtJLTC4HSb9MMkoTrLpNm9LSkjlZNJjwYIkwBnedSekF8TjTT7pKR4CCXQVdIG3xaBprLtPQtB/C1cGmhn5En/WPkTB07t4WaSFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=bYowpJJsuudC4ZaFKGlmSTOhxJ8xTSty1Qz53kn2mxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNILWYpOJrXi1Hwq9FV90XUUA1ldnhMTs3TW4aqaloZP2RhX7MHBrD/AAjJwWh/ueqrQIWEK6XdLBHFTzVAnwB15ibIV4s1ayRTW0q1sKNyqd8YUaLqrfH+v/0Q0UzkG4Y/dLvJ08Of7Y2MnD+LMMj1MQSVR5PsE+DdYAhP04Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFcdTnxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFcdTnxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1686EC4AF09;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=bYowpJJsuudC4ZaFKGlmSTOhxJ8xTSty1Qz53kn2mxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFcdTnxRUjE0xcqN5dZ0eTb+fwhxHV/S/XWIThqEeU4CpwBLtVtk7Osaq0W5p5c5Q
	 hg23MmPOks2UU50OfJUH/EJiaUw4DpX05MCUdaiD6015UteDTLAsB9VfqB3e26DNfw
	 QrZh8obQFzJwE7MW3k3Qpc8V6vnxf547y5wFvCsWoN4OFwuxlhBaeV5sz0EzCrme4F
	 D9XYkcDq3hv1mwLBeNpOPoWmZw3l148O9VLOK9BRtb/tex53edor+8wTR+rO6DvgoW
	 lwg8QRoFMGBl89KdBv3fyMN2gp8FEehJYu4cMbxoXMFyz1IC9GADp2pr2OQPIcQjT4
	 4po6D4ca9ybYg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atG-375x;
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
Subject: [PATCH 14/20] spi: syncuacer: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:03 +0200
Message-ID: <20260505072909.618363-15-johan@kernel.org>
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
 drivers/spi/spi-synquacer.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 290c439897c4..c14225e39fd1 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -605,7 +605,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	int ret;
 	int rx_irq, tx_irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*sspi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sspi));
 	if (!host)
 		return -ENOMEM;
 
@@ -617,10 +617,8 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	init_completion(&sspi->transfer_done);
 
 	sspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sspi->regs)) {
-		ret = PTR_ERR(sspi->regs);
-		goto put_spi;
-	}
+	if (IS_ERR(sspi->regs))
+		return PTR_ERR(sspi->regs);
 
 	sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
 	device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
@@ -637,21 +635,19 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 			sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
 		} else {
 			dev_err(&pdev->dev, "specified wrong clock source\n");
-			ret = -EINVAL;
-			goto put_spi;
+			return -EINVAL;
 		}
 
 		if (IS_ERR(sspi->clk)) {
-			ret = dev_err_probe(&pdev->dev, PTR_ERR(sspi->clk),
-					    "clock not found\n");
-			goto put_spi;
+			return dev_err_probe(&pdev->dev, PTR_ERR(sspi->clk),
+					     "clock not found\n");
 		}
 
 		ret = clk_prepare_enable(sspi->clk);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to enable clock (%d)\n",
 				ret);
-			goto put_spi;
+			return ret;
 		}
 
 		host->max_speed_hz = clk_get_rate(sspi->clk);
@@ -726,8 +722,6 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(sspi->dev);
 disable_clk:
 	clk_disable_unprepare(sspi->clk);
-put_spi:
-	spi_controller_put(host);
 
 	return ret;
 }
@@ -737,15 +731,11 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
-
-	spi_controller_put(host);
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
-- 
2.53.0

