Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A03BE144;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=Zb4TpEpQlXqnZBFDvC9ZTP6ntmhHdoYO5nDzny6VfoYS+FzfNlu/Kp5NdKBejdcwiauz3C7N1HlRLIbg4uAvCe338PqHkyOtxvoYuX9skZtizUe0MOaJKeCmi8pSf0aqAggaVcYCZTLx1hWogdNS+BFQu6MvnZVMwyV8rqOjqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=LDwQkSwf8ouoar1VNvhck2E/6Fj5n+vx7fYiXrs8Dyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEcjMDAFn46X3uYsnQRvTqQ34ppcPPjSV2ZT/wFZJPt+8whvL1ZXH+JHdlXSdnAOIWAqtH15iBjJdzGmc7oiwBd6gKp1u8HJxFZnAHJad1LnM1eHLyhsuDNAMgMd6q7qe4y6qRWK18hLTj6lljWudv9Wpg9Lpx1eEvb265MwCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9K23y1G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9K23y1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A36C2BCC9;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=LDwQkSwf8ouoar1VNvhck2E/6Fj5n+vx7fYiXrs8Dyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9K23y1GvSMGdrO5f83e1Ay6cqy6aSz8XLcJi4yIJX3RmKdNO4ZIPznxcU9iGa+6D
	 TetAEYNeewImEG+azsVY4llE9ZFrP5Ia6W9Wa9hylNw0NFzt3/fktx6sYqQ5NpGIL5
	 eyofg3ffuOoS+3fBrA1SIxWkmyAXse/sADNZiVU1SWvnXbY7x7M6+hIceNwPHnYDnx
	 H2WFx83pYEA1BFmnPYtAVBSeLLfYeksG8UvNyL7yMPzbjhi//6LWDhsSytq9yOIKgO
	 VXSkngUrr91ofASq2LYobCYlQmHoWtEGAVdwNsGFowpAYomkPNzYkV9sygxyuovgGs
	 d9EitWdZ3DKbg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2Z-2FW3;
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
Subject: [PATCH 09/19] spi: dln2: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:23 +0200
Message-ID: <20260429091333.165363-10-johan@kernel.org>
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
 drivers/spi/spi-dln2.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 392f0d05f508..8333dda7d1e8 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -684,7 +684,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*dln2));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*dln2));
 	if (!host)
 		return -ENOMEM;
 
@@ -693,10 +693,8 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	dln2 = spi_controller_get_devdata(host);
 
 	dln2->buf = devm_kmalloc(&pdev->dev, DLN2_SPI_BUF_SIZE, GFP_KERNEL);
-	if (!dln2->buf) {
-		ret = -ENOMEM;
-		goto exit_free_host;
-	}
+	if (!dln2->buf)
+		return -ENOMEM;
 
 	dln2->host = host;
 	dln2->pdev = pdev;
@@ -709,13 +707,13 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	ret = dln2_spi_enable(dln2, false);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	ret = dln2_spi_get_cs_num(dln2, &host->num_chipselect);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get number of CS pins\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	ret = dln2_spi_get_speed_range(dln2,
@@ -723,20 +721,20 @@ static int dln2_spi_probe(struct platform_device *pdev)
 				       &host->max_speed_hz);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read bus min/max freqs\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	ret = dln2_spi_get_supported_frame_sizes(dln2,
 						 &host->bits_per_word_mask);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read supported frame sizes\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	ret = dln2_spi_cs_enable_all(dln2, true);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable CS pins\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	host->bus_num = -1;
@@ -749,7 +747,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	ret = dln2_spi_enable(dln2, true);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable SPI module\n");
-		goto exit_free_host;
+		return ret;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
@@ -772,8 +770,6 @@ static int dln2_spi_probe(struct platform_device *pdev)
 
 	if (dln2_spi_enable(dln2, false) < 0)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-exit_free_host:
-	spi_controller_put(host);
 
 	return ret;
 }
@@ -783,16 +779,12 @@ static void dln2_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(&pdev->dev);
 
 	if (dln2_spi_enable(dln2, false) < 0)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

