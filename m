Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C02D8376;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=t9kHsuXUUwzKtB9NhHIy3obPOODMB/Hh+H3yxs7OxKx1CtHdGcnEDOA51uapUB/ePpwVYRFO5knrxbmOx1Dn54OL3fWmk+3vg6FYr5qL2was1I9/s2dcPmFrDmjp7N3kkF7hKuQi8Oso3T73dWzPv4NBPRM+1DSOpzGGNRmiM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=VRJIJ3/EPqkJ30de0FOlvglJtF0ufrqGGJ5aLvFGicU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqH3vVOwCIYDK0lfvM61Rx8nw8ksmCnOtQdWypfbnrdxOdybGKuQFau29dE3oMIGnFXlSN68XGzJi0Y8G4LY9nq4BHYn62L3ERaV5IAfGTdDfklsV/vOgxf+dQWcaiOaNssGFWIn9ZB3M1f0aoXPQl8ep+IGSzd3AH31M8nlTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9D5DypD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9D5DypD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84C1C4AF10;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=VRJIJ3/EPqkJ30de0FOlvglJtF0ufrqGGJ5aLvFGicU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9D5DypD7IESjrMJqKCLUAC1EWch+iSrMtQkzO5Zg1R4tKZH1TrFtGbgnc6gzQMHo
	 fKXV+nZC34Yvpv5aU1DZELFmnaMPVPhGZBp4vykNj+wv+gzjWBkqas9M4AEZYwU9US
	 2/uHqk2WcIAuv3r347mMy7La5o0xgZP+n/2/oAdmRXkK9OXtaWAj6i9R0DKJ2cnvcd
	 bQzgEf92vykJ/QDraRNXvALbjXjzTv39nHPutaHBDgza3f98aRxxWCK2SSP/315c3t
	 FaphIH/sXGfZyRfjEAPkoJhJ3q+bmHYz1sOjva8TBhWrIwL8lnUzqZopq6yqlqtGS1
	 T5ejZ8b5BxmbA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8I-2Cfi;
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
Subject: [PATCH 08/12] spi: lp8841-rtc: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:04 +0200
Message-ID: <20260511150408.796155-9-johan@kernel.org>
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
 drivers/spi/spi-lp8841-rtc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index e466866d5e80..355d9df4d1be 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -185,7 +185,7 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	struct spi_controller		*host;
 	struct spi_lp8841_rtc		*data;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*data));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*data));
 	if (!host)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, host);
@@ -208,23 +208,17 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	ret = PTR_ERR_OR_ZERO(data->iomem);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get IO address\n");
-		goto err_put_host;
+		return ret;
 	}
 
 	/* register with the SPI framework */
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot register spi host\n");
-		goto err_put_host;
+		return ret;
 	}
 
-	return ret;
-
-
-err_put_host:
-	spi_controller_put(host);
-
-	return ret;
+	return 0;
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.53.0

