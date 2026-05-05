Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C23DBD5D;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=k7PCW9H46G/o/HDHRFs4iJ9PSrFcVfkzJcGToSrbNr6fq7+TCGspER3h4th0ZVWZwGR1ABMlRMg7KZuagMdjWwCS5VrcYi38uwFcxVZ6nj1FKrtix4Sy5DfAZZhxzfHvH40Ou94664mF2+w/IJezpo1Czk8aMtCyCOtFg3FGJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=/s3D2tA7ijRf5FaUdeNWidN8ycA+zffWi7hwdzUYjNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmUhUgXmfUx1uUk/TuAXS5hpwV2Viww4ViSuQeR9JfaSEGZZKE0sMeZ77fY6x+VbK8pd0KyucMb4y82QbN4trXA/PJ6gCbcEqdp1MKAToH3kX9go6QKCA7/Ehtk0B7s+J6y/LJ8RKulV3ocdshKTikEKeBafGSbxRBcbVlwPTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb5K1DTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb5K1DTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01735C2BCF5;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=/s3D2tA7ijRf5FaUdeNWidN8ycA+zffWi7hwdzUYjNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eb5K1DTIIRuLfnCRFq/EYJqiO572Y77FDnVaygnztZbZS3+PrOlo2GC/lZ+k+hwaW
	 rmKAKYToA1rS6iHR4aoHA5htQsnDsad4eZrSEChSQOBpJVfqIBkcLSBj373ik5vydH
	 8XkWv7YXKCXe2AcLpdm6EcbenapMwcphyznV2dqsHhtBjDnE6pJwbharxmbvPuL0os
	 X9C20bSW2nD1Mful/H12joLVWHcO26kdYOWzEzwrAQeo7JCWgv7XhD8CirfhElCeAW
	 CuB2WG9aup8XPl/tCZBVUKdr9FiS50fycdjp1SmsrwsQ92AGmvEcf7tHFEK0A9UFmc
	 9ha/XlO6oq3kw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asz-2ojd;
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
Subject: [PATCH 06/20] spi: sh-hspi: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:55 +0200
Message-ID: <20260505072909.618363-7-johan@kernel.org>
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
 drivers/spi/spi-sh-hspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 1e3ca718ca73..f840467cfdb2 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -224,15 +224,14 @@ static int hspi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*hspi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*hspi));
 	if (!ctlr)
 		return -ENOMEM;
 
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "couldn't get clock\n");
-		ret = -EINVAL;
-		goto error0;
+		return PTR_ERR(clk);
 	}
 
 	hspi = spi_controller_get_devdata(ctlr);
@@ -269,8 +268,6 @@ static int hspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
  error1:
 	clk_put(clk);
- error0:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
@@ -279,15 +276,11 @@ static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
-	spi_controller_get(hspi->ctlr);
-
 	spi_unregister_controller(hspi->ctlr);
 
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
-
-	spi_controller_put(hspi->ctlr);
 }
 
 static const struct of_device_id hspi_of_match[] = {
-- 
2.53.0

