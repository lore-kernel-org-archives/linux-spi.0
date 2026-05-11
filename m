Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363528505E;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=gxuQlYdtShAiH/oSwI2DFTTERZTvlDOWvcjEdRBPYaLLGZtn3NJMgY2XxyotMUlq2YwbJ7yF/8lJrVzPPGVV00BbmEoOalr0sneTcwCS7u2p8ZJ1ydzNXdHyWpbJBVAR4fGx1JEqSBb6csQtjdK0GBbYHLJokEigw32izzSODpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=F+/vOrWe9CA914KkC5AHAdpy7vRxRKNrJ6Fu2fb0kFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYNbwekg5oCKKVaf0iTtaeBMGjN8layU2u4S4t74BEceUpFBCxaSfUGzjxxPT/qPB/g/HU+M4yWMbqMPqJkqY4zxJyuW5gi2hotekB7Cv6CHRf99CFvdQQqU3Lgko9OfyDmvTzbM+06cxPnqRMAeDSFvA0n3yehNsWpIJHZ9sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJKvf2Ie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJKvf2Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ECEC2BCC9;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=F+/vOrWe9CA914KkC5AHAdpy7vRxRKNrJ6Fu2fb0kFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJKvf2IeYA3eAKyU3a3DV2C6gWwCHMOBfiFhNPK7my6kRO7r5ImU1cFF6XXW1jR4O
	 mc3XutkG1fWOg4glRcrTNhNMimIpf+qWpLpNdvMls6a+4Q7GZ/Hys/FC9WUCTKpg7L
	 kMFGgs/wAVNwmx8ogTuJu7csj29YCltzkEySnyxa5LYokCtRGVMj/1dVQdNOLwVW8Q
	 2wLDAcPCGP0OyEsUn5zbzVFprz6isDOKzbMUFY8blhmr8X+WGjIhsz1zGGth5RGE9d
	 GEGuUS4QYkCF1RuN7Edk/oFvhpuphMbJ1GZC9cv2Ltn6T7oNdaA8wAPlfsESSC5lCd
	 f7PquarKqz/zQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8A-237F;
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
Subject: [PATCH 04/12] spi: falcon: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:00 +0200
Message-ID: <20260511150408.796155-5-johan@kernel.org>
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
 drivers/spi/spi-falcon.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index cb15faabd88f..e00e808eafee 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -392,9 +392,8 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 {
 	struct falcon_sflash *priv;
 	struct spi_controller *host;
-	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*priv));
 	if (!host)
 		return -ENOMEM;
 
@@ -406,10 +405,7 @@ static int falcon_sflash_probe(struct platform_device *pdev)
 	host->setup = falcon_sflash_setup;
 	host->transfer_one_message = falcon_sflash_xfer_one;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (ret)
-		spi_controller_put(host);
-	return ret;
+	return devm_spi_register_controller(&pdev->dev, host);
 }
 
 static const struct of_device_id falcon_sflash_match[] = {
-- 
2.53.0

