Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750C2BE034;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=E+3MhyWjKhxC9fKHaLK3/YbV+YetH8XlDDJ6OWqWZo+UcI7P6vRIK2MmXy6mNb6DqyURXE8DVvoRwBvk/s59swLU1ytEYb91m4Or9vCL8YZdbyHcaHOYSqu+D4po+qME7tYJKGWxzF+65sVWWAX77juoPXB7QAwH3kWxPp+Bpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=6xhTPY7jlW/618vCQblUb8mivxbPw/JihIrlcs6Bv50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU7MVY1Xs5e3hkSHJ3B08dJXNwcUKjrCPD/oE6Q/5UKndYM/q1MTGH6YqaZy1iiMcmJV66700mzeQojQuhGm+zjQFUC4kIWXy3rQBJ/m9qHAa5AEVQKxLzxvy0Xeyf8EZpHogqyU1luE57eXGEKGEvuQUEFDexoJwW6m/kbqsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jnyjk9VO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnyjk9VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9679C2BCFB;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=6xhTPY7jlW/618vCQblUb8mivxbPw/JihIrlcs6Bv50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnyjk9VO4L9tMU+Fc/b5PldTQ8yfabORWb/QyDKjbQBAX0UYqS0IOJjnii0wKG1Cr
	 FXmFu+sfgLd3Xyf7lJPw28B7587dZh0J7Byh/1x+RDXH0fwNhS7zmorTQSy5gXMb4J
	 Qj75npDDpecNTjbdY6bXgUkg8SH+fX3cd3OztBaWNbN/20s+M+Gy99y6kl5X1ZwGNk
	 PRjGhrKlCSHYkJnVUsYcpQeREZbuVh4pHPrXcZ/QAneuznO+IFx7LvtI7bT7edtiAE
	 wlpwL95oCOuwwSLgFYMP+BGi089Fas9y1y5CspCGGwHEdb2iKIrrfQz1rJ+Cy7IqLd
	 omQq9A+Gz5lLw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L84-1w6o;
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
Subject: [PATCH 01/12] spi: altera-platform: switch to managed controller allocation
Date: Mon, 11 May 2026 17:03:57 +0200
Message-ID: <20260511150408.796155-2-johan@kernel.org>
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
 drivers/spi/spi-altera-platform.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index fc81de2610ef..3ee5d3480bb4 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -39,12 +39,12 @@ static int altera_spi_probe(struct platform_device *pdev)
 	enum altera_spi_type type = ALTERA_SPI_TYPE_UNKNOWN;
 	struct altera_spi *hw;
 	struct spi_controller *host;
-	int err = -ENODEV;
+	int err;
 	u16 i;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct altera_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct altera_spi));
 	if (!host)
-		return err;
+		return -ENOMEM;
 
 	/* setup the host state. */
 	host->bus_num = -1;
@@ -54,8 +54,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"Invalid number of chipselect: %u\n",
 				pdata->num_chipselect);
-			err = -EINVAL;
-			goto exit;
+			return -EINVAL;
 		}
 
 		host->num_chipselect = pdata->num_chipselect;
@@ -80,7 +79,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 		if (!hw->regmap) {
 			dev_err(&pdev->dev, "get regmap failed\n");
-			goto exit;
+			return -ENODEV;
 		}
 
 		regoff = platform_get_resource(pdev, IORESOURCE_REG, 0);
@@ -90,17 +89,14 @@ static int altera_spi_probe(struct platform_device *pdev)
 		void __iomem *res;
 
 		res = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(res)) {
-			err = PTR_ERR(res);
-			goto exit;
-		}
+		if (IS_ERR(res))
+			return PTR_ERR(res);
 
 		hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
 						   &spi_altera_config);
 		if (IS_ERR(hw->regmap)) {
 			dev_err(&pdev->dev, "regmap mmio init failed\n");
-			err = PTR_ERR(hw->regmap);
-			goto exit;
+			return PTR_ERR(hw->regmap);
 		}
 	}
 
@@ -112,12 +108,12 @@ static int altera_spi_probe(struct platform_device *pdev)
 		err = devm_request_irq(&pdev->dev, hw->irq, altera_spi_irq, 0,
 				       pdev->name, host);
 		if (err)
-			goto exit;
+			return err;
 	}
 
 	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err)
-		goto exit;
+		return err;
 
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++) {
@@ -131,9 +127,6 @@ static int altera_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "regoff %u, irq %d\n", hw->regoff, hw->irq);
 
 	return 0;
-exit:
-	spi_controller_put(host);
-	return err;
 }
 
 #ifdef CONFIG_OF
-- 
2.53.0

