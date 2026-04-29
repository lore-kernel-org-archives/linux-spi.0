Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941043BFE21;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=J06NXBS678ZdsVtszm0KKCLWpftenZFoOHraz46vKiWNVpw/uLB4XsEQp/Jr3O0vBfwbw/QOj1+0hqF2PEx9VvuYC710QTw2y6hEubG0L+sY5HWAoq3AfH79XJKLjzezOBOyu76N6itHbulD7+/1yxQam3y/GVs+CDnIqqrlgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=5kVNhoS1rCBF1MFLTvrHz0vKfdGlRU+p21hVgX4gDEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dufFrabvpsgEZtlNoSjo6WmWQ9Ta7hgOFWujOZqx+TE9Y0F0GNzxuXXtFUd2Y/irrPO4ryQ21zKtPxcHAwe+O0CUAvITqdSTKbmcCctSBCs+hRSgzTCaG7jzNAv1zvZ99bHWbdiFTZ7cYcEY/Ukpk27uGTZpULPPyWdxbBSRJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY8GGD8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY8GGD8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE3DC2BD00;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=5kVNhoS1rCBF1MFLTvrHz0vKfdGlRU+p21hVgX4gDEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eY8GGD8HIk4u1X/uBBmxa8w85OtdVf5Y/nIoazbHag7iPTt3D+mFYyXeZJdTZMinu
	 ErpVNBq7q9/IOCqgb/foo+OfIlCKE8j80oDDxtAa1uR5srcO4netPnAOsf289qHVyT
	 nSTsbVVxf47vfOVny+kNQxywDBv5SIGOebm35A8PvQVxmgs8Wq27b/UdX5SqeaLrmM
	 ypU6HDjFNI/khX+KjHfXrPVlN+H6XESeeRKCfN414TeWPEctT5WUfN5QQQzYql+TlT
	 xJU1eSOo9RFwqy/popOlsmovCBeGNfVR58pAvyh/1F/LR8jsl/znjNbjBGhtwVZqro
	 4AutZGvJw80TA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2p-2ZEj;
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
Subject: [PATCH 17/19] spi: npcm-pspi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:31 +0200
Message-ID: <20260429091333.165363-18-johan@kernel.org>
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
 drivers/spi/spi-npcm-pspi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index cffef0a5977d..a437a30d636c 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -345,7 +345,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*priv));
 	if (!host)
 		return -ENOMEM;
 
@@ -356,21 +356,18 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	priv->is_save_param = false;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base)) {
-		ret = PTR_ERR(priv->base);
-		goto out_host_put;
-	}
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		ret = PTR_ERR(priv->clk);
-		goto out_host_put;
+		return PTR_ERR(priv->clk);
 	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
-		goto out_host_put;
+		return ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -424,8 +421,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 out_disable_clk:
 	clk_disable_unprepare(priv->clk);
 
-out_host_put:
-	spi_controller_put(host);
 	return ret;
 }
 
@@ -434,14 +429,10 @@ static void npcm_pspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	npcm_pspi_reset_hw(priv);
 	clk_disable_unprepare(priv->clk);
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id npcm_pspi_match[] = {
-- 
2.53.0

