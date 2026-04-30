Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDC40242C;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550599; cv=none; b=qNps6F0KnNjG9Q0MRwVsRCf+fGkDiGX6/vNIqUtjBvDYPYtdr7zqryETnHg14LJxAiO1dPFakhvsAJVjzhSVVvkLr75ZDDV2x5ylJwilzmaRE8FrAhE1RkpwAhEyYKQ3BOwpioSEp+pvoQ5E0hJpRqcPFAUjfK9mFwKc+TDDzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550599; c=relaxed/simple;
	bh=lLfz7qYzWq7gYilZMBVkCQO8ehYw3cSV9/09cE0lJuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+8AsD3d+md+xThX5d/vuQqIInG10Eg5dNE2ATWfATRw0jbVvdumI2lW1cDb49NE/J0/U4ccZinvEEmzcedj6gTUZHzTc7NfFsoYSDHHm/T0ZNSt7y+dYkQOZ1QDTDcx+I5wU7w6IOleafbae4sxuAuwpztI3wQW1Lz9ifHDTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am+uQjYs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am+uQjYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EE6C2BCC6;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550599;
	bh=lLfz7qYzWq7gYilZMBVkCQO8ehYw3cSV9/09cE0lJuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=am+uQjYsxF9QZpTAg0HXJ6oAOX11TZ1/iplZR+f/6TUn+4ytRb/Mb99+Lfrc2XI9d
	 I1CoqoqbIfR1AyvopGJbLxLLdkRw/krzlKD5sIptUDV3h8DBBKkOgl/NTWFvj/73Yu
	 a8y3Ui7okYImPZHSqX+I9gLpynEPosFjHmS69XZZYjOIj/4HxN2AscnayUV2xaG0i8
	 sbpOPYRoXFtbQP3YEqf/SEPNxxH0ZIxtAx9F0NjZTl6pmiGaM/BI/Hz3Oor7DxkU0A
	 vbVAsNTwB4u3+Uev6iN/xFKwxUG/xcpWMlsJzN24zWlrp1ZKGJALKh6p4qVEue9x32
	 oNA6XOdEkNNNA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIQ6v-000000012sv-0jAV;
	Thu, 30 Apr 2026 14:03:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/3] spi: omap2-mcspi: switch to managed controller allocation
Date: Thu, 30 Apr 2026 14:01:58 +0200
Message-ID: <20260430120200.249323-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430120200.249323-1-johan@kernel.org>
References: <20260430120200.249323-1-johan@kernel.org>
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
 drivers/spi/spi-omap2-mcspi.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 56b30ff58771..60c05eb91781 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1484,9 +1484,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	if (of_property_read_bool(node, "spi-slave"))
-		ctlr = spi_alloc_target(&pdev->dev, sizeof(*mcspi));
+		ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*mcspi));
 	else
-		ctlr = spi_alloc_host(&pdev->dev, sizeof(*mcspi));
+		ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*mcspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1530,10 +1530,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(mcspi->base)) {
-		status = PTR_ERR(mcspi->base);
-		goto free_ctlr;
-	}
+	if (IS_ERR(mcspi->base))
+		return PTR_ERR(mcspi->base);
+
 	mcspi->phys = r->start + regs_offset;
 	mcspi->base += regs_offset;
 
@@ -1544,10 +1543,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi->dma_channels = devm_kcalloc(&pdev->dev, ctlr->num_chipselect,
 					   sizeof(struct omap2_mcspi_dma),
 					   GFP_KERNEL);
-	if (mcspi->dma_channels == NULL) {
-		status = -ENOMEM;
-		goto free_ctlr;
-	}
+	if (mcspi->dma_channels == NULL)
+		return -ENOMEM;
 
 	for (i = 0; i < ctlr->num_chipselect; i++) {
 		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
@@ -1604,7 +1601,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 free_ctlr:
 	omap2_mcspi_release_dma(ctlr);
-	spi_controller_put(ctlr);
+
 	return status;
 }
 
@@ -1613,8 +1610,6 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	omap2_mcspi_release_dma(ctlr);
@@ -1622,8 +1617,6 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(ctlr);
 }
 
 /* work with hotplug and coldplug */
-- 
2.53.0

