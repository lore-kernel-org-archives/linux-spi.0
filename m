Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF22D7DC4;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=HukyJZK7XK++ZT7ftCFsgL6aLxCGIIhaHkuVdzTgRcAxZrCwGRbxIFBQ6Xb1bIJ/VAVIKCpLz2Hjds7pAZOps17ayVvzq3n3lueD6QOcWqoQ62QWTv1IFYLYKC815pK60fVyNwAYuUWOw3YDEF0QYFylLTvJqWE7pw5EW4ZVvzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=H2FeHAOdv+gnBoc3XnT/OSM2l7x0Wuk4i5L2lZ5BJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4pbG9TciHemU4wKYl/fr5oW1gP++S3uY/mP0YpO+KM4W4kYXj4QF3Wu4R3TxMTaLV4cyuUKWgH51yXWfy11gEHwiJi8kuL+FIy6PIc265Rh+hB8//Ly/RWlUJNinxp5huuy0OgY4YlFc5+NCCaQJ/kjM4XahW3xyZkox4kpNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrGwWo84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrGwWo84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A19C4AF0C;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=H2FeHAOdv+gnBoc3XnT/OSM2l7x0Wuk4i5L2lZ5BJvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrGwWo84teE1gyWYySNgzJmlmEQRvuEyc54Puue18+YQgldxoivIRR9IW9qKD6zeZ
	 PbK/q393E7NjZCa5ZhTqdOWGrvx7zgS1zgVoq95dbOJd8o3GA5TToPZFFIRnbq30DC
	 oco4+35BCYHASyIETidjB33gDe6UO8WwSh7VXIPSsstpE5D5SxqnCnYlFcOWdN9oxq
	 H6f8OOd4GtXy3J4JNwbE/RIaqpMn4zbwsU53OyWbsW+eFCSnSICu0IEq7u4oa9F/by
	 pFz0MZD+bqUttFVa0ca4c7tc/iyKfD6YhvKbXnbVL8C7VZs+EHqe6BxdeoCldQ+cfr
	 tJeo69VRPt+Zw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8Q-2Lvt;
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
Subject: [PATCH 12/12] spi: xlp: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:08 +0200
Message-ID: <20260511150408.796155-13-johan@kernel.org>
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
 drivers/spi/spi-xlp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index be8bbe1cbba3..d014955e6d4b 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -398,7 +398,7 @@ static int xlp_spi_probe(struct platform_device *pdev)
 
 	xspi->spi_clk = clk_get_rate(clk);
 
-	host = spi_alloc_host(&pdev->dev, 0);
+	host = devm_spi_alloc_host(&pdev->dev, 0);
 	if (!host) {
 		dev_err(&pdev->dev, "could not alloc host\n");
 		return -ENOMEM;
@@ -418,7 +418,6 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	err = devm_spi_register_controller(&pdev->dev, host);
 	if (err) {
 		dev_err(&pdev->dev, "spi register host failed!\n");
-		spi_controller_put(host);
 		return err;
 	}
 
-- 
2.53.0

