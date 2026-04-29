Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF93BED19;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=j4qs7D45O818ZkS2hq/k3Dx2JwZPH45GjXrQ6oaicoZpvL7tMt+pXVcLU2azpUpe/sKpTmVDQz2BtQmW+5rZyFs6ILcfo4tGue49ZNr8fU6dyc0aTnSdX7c7ZSfCxi3PRexRySXJZmpuCtalWglWa6FLqlYS9xiSt2/fyp/O5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=z3AJQ1t+M6wkvyV2cCLlYXK4JGyFKHkAuQFIZFteRHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIDTQzjZz01TyMNzUHdDecrIvXYklb6bE82s3YjeafCg/yKS8Y4f6hljhhXtrYz94LVvnKT/7wv7Amf6z1aYdTNoP8apJb5+ITRrC81SCiNrgwN7RBg/EevojK5o5QdGdS2yED0nvgcqbGWEUPk5e5CXhu5m9V8rwufXhqgHSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r256sxZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r256sxZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0686CC4AF0C;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=z3AJQ1t+M6wkvyV2cCLlYXK4JGyFKHkAuQFIZFteRHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r256sxZ5+v0ncC5NmztwRFQbq2sv7FEIACl/Qxf6SZxJh/ZngWCFRwflnGu2uLLQZ
	 VRRXPjMdpXRujSHwPYV2m/lTugZpQtA0fI8JstQIrls2Mc0np1zG+m3UZV7YeOTc8C
	 VvJcZ7JvRcqL/vk3Bya+ls6Fb1fxsSWzKar4aqwxFSEbeJ1gPNC8B13ViUaD/bmOCK
	 cJAxhoLGcgeEDzph7paMSvwa7o5U4GFUIdhRDV0N+ZZZuDv9Z4QCq8UyWltYYcwKEQ
	 qYBwT+r8pFrkJWhv406jVPl5nHL+sjRY9ByIhfXouu9ki7/iTVdLlMK63eyxP+p/Rc
	 +6P+U4wgQzcGg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2N-20tE;
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
Subject: [PATCH 03/19] spi: bcm63xx: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:17 +0200
Message-ID: <20260429091333.165363-4-johan@kernel.org>
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
 drivers/spi/spi-bcm63xx.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 40cd7efc4b54..f8cfe535b2a3 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -541,11 +541,9 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-	host = spi_alloc_host(dev, sizeof(*bs));
-	if (!host) {
-		dev_err(dev, "out of memory\n");
+	host = devm_spi_alloc_host(dev, sizeof(*bs));
+	if (!host)
 		return -ENOMEM;
-	}
 
 	bs = spi_controller_get_devdata(host);
 	init_completion(&bs->done);
@@ -554,10 +552,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	bs->pdev = pdev;
 
 	bs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(bs->regs)) {
-		ret = PTR_ERR(bs->regs);
-		goto out_err;
-	}
+	if (IS_ERR(bs->regs))
+		return PTR_ERR(bs->regs);
 
 	bs->irq = irq;
 	bs->clk = clk;
@@ -568,7 +564,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 			       pdev->name, host);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
-		goto out_err;
+		return ret;
 	}
 
 	host->bus_num = bus_num;
@@ -587,7 +583,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	/* Initialize hardware */
 	ret = clk_prepare_enable(bs->clk);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	ret = reset_control_reset(reset);
 	if (ret) {
@@ -615,8 +611,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 out_clk_disable:
 	clk_disable_unprepare(clk);
-out_err:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -625,8 +620,6 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	/* reset spi block */
@@ -634,8 +627,6 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
-
-	spi_controller_put(host);
 }
 
 static int bcm63xx_spi_suspend(struct device *dev)
-- 
2.53.0

