Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BC3DDDC3;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=I9KxQgVr4Pbvu+WIaRaN4zigMNy5ReseVbKkwgFoMaJMePnIiWdIZYyL/vl+EsEocYRsAr2mw46akw76wAZzzixq3HXtpSXHNfD9WZ275Quwa18j1dBdvDxi7Ajvwpf40GDAXSYsQF4x27oUc6ACyKm12WBkipIKra+Jy0kYw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=NrO9PilAApo4fMJbaPo7DTWDgUTwAaMZums3CX0M/Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9fBXFLWUqUR6vODGdhgyEoBFS5VBrAppD2OlCNyGkiQaoRmLe2VY5qHmEGeYTLDN5xGoWhuenCczrrwvFrzkNuie5Rhptb3pPmEz+Qq9G7Cq184/F26JDWyoAhTGImpdSuYuBBuqM8l8cb2AicFzHjsQI9Ze9XLVkhmBYttoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlhsUdE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlhsUdE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B91EC2BCFB;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=NrO9PilAApo4fMJbaPo7DTWDgUTwAaMZums3CX0M/Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlhsUdE1ccIj6aqBZlSKUgEaph5Uvx4XLPGgzdZ0UL9m7Xk1Da+M0mLAuvhB4pb+d
	 OEu96LU86cf+2joffrK5SNhDABuXMQyfnLJISM8KENCdWVFzdvWF4m+7Jq+bfnw8T1
	 /Cht9UP49//1NEC6wrMARj9rfhgeALGejcAc9pcqH7zzjolrENMvmMYM2ItcokOwca
	 8NxJMpxdqOQrjM1lH52M8E8oRBEsk7E318edrKVd4qgcxsTr80rf/9AWtB757/OHoQ
	 GBxEAF/+ZR6NXF7PQ55aPx4N7/zfqFvke6P/11WAEwz0lYf3d03EWZ16sGmg+nLNGX
	 /YwQ+3HbL7X4w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asx-2mTj;
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
Subject: [PATCH 05/20] spi: rspi: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:54 +0200
Message-ID: <20260505072909.618363-6-johan@kernel.org>
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
 drivers/spi/spi-rspi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a8180dece716..951e9a8af547 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1171,14 +1171,10 @@ static void rspi_remove(struct platform_device *pdev)
 {
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
-	spi_controller_get(rspi->ctlr);
-
 	spi_unregister_controller(rspi->ctlr);
 
 	rspi_release_dma(rspi->ctlr);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(rspi->ctlr);
 }
 
 static const struct spi_ops rspi_ops = {
@@ -1294,7 +1290,7 @@ static int rspi_probe(struct platform_device *pdev)
 	const struct spi_ops *ops;
 	unsigned long clksrc;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct rspi_data));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(struct rspi_data));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
@@ -1302,7 +1298,7 @@ static int rspi_probe(struct platform_device *pdev)
 	if (ops) {
 		ret = rspi_parse_dt(&pdev->dev, ctlr);
 		if (ret)
-			goto error1;
+			return ret;
 	} else {
 		ops = (struct spi_ops *)pdev->id_entry->driver_data;
 		ctlr->num_chipselect = 2; /* default */
@@ -1314,16 +1310,13 @@ static int rspi_probe(struct platform_device *pdev)
 	rspi->ctlr = ctlr;
 
 	rspi->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(rspi->addr)) {
-		ret = PTR_ERR(rspi->addr);
-		goto error1;
-	}
+	if (IS_ERR(rspi->addr))
+		return PTR_ERR(rspi->addr);
 
 	rspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(rspi->clk)) {
 		dev_err(&pdev->dev, "cannot get clock\n");
-		ret = PTR_ERR(rspi->clk);
-		goto error1;
+		return PTR_ERR(rspi->clk);
 	}
 
 	rspi->pdev = pdev;
@@ -1396,8 +1389,6 @@ static int rspi_probe(struct platform_device *pdev)
 	rspi_release_dma(ctlr);
 error2:
 	pm_runtime_disable(&pdev->dev);
-error1:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
-- 
2.53.0

