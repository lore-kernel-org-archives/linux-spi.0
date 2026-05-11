Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E72D9EE4;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=qVglIv3PY9khaXRrWA9D/mBDooS/wUYKfPE+w1Z5l7f/4YAdszW0N+6Oe0H+LuqVKij+FQF3AGKtFEfxBRi3uzCAsHFIJRgyTFvYFC1+ji+qStBF2nrbxiop+S+hjWBdaO4EnG6qmlu/L637QKVenopk2PQal4/CxkcmSATPn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=ttUs7m5ZQ5FprrDT6/Nmw1TW6ryE8eHJS6OclJj5qC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYIJsJ1uQZ8xA+QLt5qG5h7dGJgk3TRd9hQLvPoJn9XnpxP3cuNuHMzXkSo9vzXcV3foLgmgNzJO9yU2hrLIneCWmIM80NIL/LYw1RI41x6W+3AGVpDVupSbPQ6Fv+a/HZpMvPPjbWom9HAgv/l+0IVV8h72psu9irLtNXITmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW+n8UPB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW+n8UPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D6FC32782;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=ttUs7m5ZQ5FprrDT6/Nmw1TW6ryE8eHJS6OclJj5qC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XW+n8UPBGsYvlFNomuZacW3yFwhWJtXWvr275/Ji0uuodEBAmfcXd+1+rQFu1Sf6k
	 UqmIANJ4o2oyz5S7BKKgJeWd0JViCGPKehyRcTiDzEWgPvuayJxRmCBntvJKJMDflQ
	 31l82VgK+dTEfTcyG99Xw/rpI2BL5Q+Hx6w7XLM7QN49B9gwlMJEYtDPJ3HM8Uu0PS
	 i7wyzydB3P200xLbjDH4Ovn0qwQRvVNfISYXBlrGSkxQDPvZ4dnOUEz78VSQJ6mRS9
	 fY1XPHXUnJXJr8EsGDTVfpsCTMzZs+7tvRFtOxqVr6E9W66wYUm5aw6QinsoEbCT/q
	 csCcG9HTfJOCg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8O-2Jjz;
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
Subject: [PATCH 11/12] spi: mux: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:07 +0200
Message-ID: <20260511150408.796155-12-johan@kernel.org>
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
 drivers/spi/spi-mux.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index bd122de152c0..08fe1fa32dea 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -127,9 +127,8 @@ static int spi_mux_probe(struct spi_device *spi)
 {
 	struct spi_controller *ctlr;
 	struct spi_mux_priv *priv;
-	int ret;
 
-	ctlr = spi_alloc_host(&spi->dev, sizeof(*priv));
+	ctlr = devm_spi_alloc_host(&spi->dev, sizeof(*priv));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -146,9 +145,8 @@ static int spi_mux_probe(struct spi_device *spi)
 
 	priv->mux = devm_mux_control_get(&spi->dev, NULL);
 	if (IS_ERR(priv->mux)) {
-		ret = dev_err_probe(&spi->dev, PTR_ERR(priv->mux),
-				    "failed to get control-mux\n");
-		goto err_put_ctlr;
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->mux),
+				     "failed to get control-mux\n");
 	}
 
 	priv->current_cs = SPI_MUX_NO_CS;
@@ -164,16 +162,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->must_async = true;
 	ctlr->defer_optimize_message = true;
 
-	ret = devm_spi_register_controller(&spi->dev, ctlr);
-	if (ret)
-		goto err_put_ctlr;
-
-	return 0;
-
-err_put_ctlr:
-	spi_controller_put(ctlr);
-
-	return ret;
+	return devm_spi_register_controller(&spi->dev, ctlr);
 }
 
 static const struct spi_device_id spi_mux_id[] = {
-- 
2.53.0

