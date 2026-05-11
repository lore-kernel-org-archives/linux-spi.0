Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7522D94A0;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=CBotDtq9e3izjzeDVkqKtOP0P4q4gkmlECPyzoIumwQcKX/uTg6jgDBXfrBkZ7fGJrtbWVP/qq8M5BRjTsedHPyKeqTunEyLi7wDOK/xVw16yX3tSvsKXdfeBV3VzyRpH9q1UYguNHjzgbfVl7SmDduecWXj3Upb6rIt+Kxg/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=muTdyb/wzzKlqyCEw77kYvwGAS2c+HJt1sdcQI9Shhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTI0hF5IgStSJ1NqgTfRqYEk6wOxD7Yvqyd5Vey2mV3RcZEKVtQRLoomOH6NJOk9ioTSO7uzF+GmEl+8y2ACh5IkUj3tQ5/2iLXjN3PVDZSLhI0sG726+j5+2ozQIYyb1pnS1vJ0dfmfJxKwMnY91Yw0m1f8lIahjwYR+VKhwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxfHnTEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxfHnTEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0139C2BCFF;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=muTdyb/wzzKlqyCEw77kYvwGAS2c+HJt1sdcQI9Shhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxfHnTEBqFv926rHq4QPHP0TY55wpw/JrdvkSDnZ/Fgz5xh6vY6OzR7Hdb2o8gEFm
	 Eiw2d748VUTPbXkBSxHqXaeDvwuPMqVAyUliUYMIksGSPQmxbO/dgMIygfdYyxI20k
	 7yz1Io0HAA1U2CvFkZInNTt9SezP76fF5Hz0zbB1+PCpDA8tuLvw+5iJCm2eAX4Xyy
	 GRZsxkMaJ7tUBm8AVDtru5pcnPqe5VD8j0yFwyStSQ0lFH/6wjxVLPCEeRd3ItZV8m
	 qcxsXoUl59AHO3L4c7RBeuOfubDh4MBqQB5sMz0Mc7I5cVDDZWRziHyZ9j8vbV3dKe
	 ewCB4wwSIkVJQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8G-2ALr;
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
Subject: [PATCH 07/12] spi: jcore: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:03 +0200
Message-ID: <20260511150408.796155-8-johan@kernel.org>
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
 drivers/spi/spi-jcore.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index e37ca22e04ba..a75cd61ec7a3 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -146,11 +146,10 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 clock_freq;
 	struct clk *clk;
-	int err = -ENODEV;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct jcore_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct jcore_spi));
 	if (!host)
-		return err;
+		return -ENOMEM;
 
 	/* Setup the host state. */
 	host->num_chipselect = 3;
@@ -167,14 +166,14 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	/* Find and map our resources */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-		goto exit_busy;
+		return -EBUSY;
 	if (!devm_request_mem_region(&pdev->dev, res->start,
 				     resource_size(res), pdev->name))
-		goto exit_busy;
+		return -EBUSY;
 	hw->base = devm_ioremap(&pdev->dev, res->start,
 					resource_size(res));
 	if (!hw->base)
-		goto exit_busy;
+		return -EBUSY;
 
 	/*
 	 * The SPI clock rate controlled via a configurable clock divider
@@ -200,17 +199,7 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	jcore_spi_baudrate(hw, 400000);
 
 	/* Register our spi controller */
-	err = devm_spi_register_controller(&pdev->dev, host);
-	if (err)
-		goto exit;
-
-	return 0;
-
-exit_busy:
-	err = -EBUSY;
-exit:
-	spi_controller_put(host);
-	return err;
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 static const struct of_device_id jcore_spi_of_match[] = {
-- 
2.53.0

