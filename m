Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEE3B9DA8;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=ibm+6Ig3J+bq3pS2ZRsJrg+VYXkB2pDmCKg2vad0EC7vj/p8LzG0LbIZ7LfjYdELMAHjTyPhw5SMKc07HU6jVj40FywZCaYp1neZJMzMcfjD/ur/5Y68/FASmWJhG+vzTJAgfDfy5UVmoofAwaQ0Wd+NORpFaS1jxXULvcka+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=MgRl1avgvjrR1PqONAQsOzEaMdp60oVXMeEFBN4iSIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flAa7zXsewV7pO2sEYHM2i+W8Y/sNgMQFa1CNgRSxCan+KjleJ7vv60ezhkrOEyVgJOmBsPr2LVG2CrzwXHjl5thb5onUGo/s23Ap8mHubpLBaq6YNaeHqSooHJZ74GtSBHU4brjnJuqvm958OK0sQIuckqW0ob8SLBrbqOh5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfhep6DH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfhep6DH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53394C2BCB1;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=MgRl1avgvjrR1PqONAQsOzEaMdp60oVXMeEFBN4iSIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jfhep6DHDK03KfQn5Maub7OxZsfg1dZqY/dcaGetNLaTkqN3clE2n22phWTi2Ck5s
	 d6pyDmhiqrgbMCy3UkO3Bq1t7zzlDlzNqHupIDPrZXi7P2wyki1dRyAs4Hi4xoeJ5j
	 uvLIQLvYJnd+9v1Dozb3kqpydvv1HBj3qxnCZ7OrmPAF82BHIkoQX+mMxVXeBK9v0j
	 eyZaGX9eoMycApixDnx8Rvn7cHOJ45XR/kC6JOj857IUFZxXVj8m+7pY0igkthNgnL
	 iFDm1bA8HxSbRJvyRSGX+ydJ3P0csCR4KdqKHyilCOhsWnyS/RB3STUJuythSq9a9A
	 hy2wmarVVskJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8R-00000001d6j-45pc;
	Thu, 09 Apr 2026 14:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 02/20] spi: aspeed-smc: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:01 +0200
Message-ID: <20260409120419.388546-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling it to allow
SPI device drivers to do I/O during deregistration.

Fixes: e3228ed92893 ("spi: spi-mem: Convert Aspeed SMC driver to spi-mem")
Cc: stable@vger.kernel.org	# 5.19
Cc: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-aspeed-smc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 9c286e534bf0..c21323e07d3c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -972,7 +972,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	aspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, aspi);
+	platform_set_drvdata(pdev, ctlr);
 	aspi->data = data;
 	aspi->dev = dev;
 
@@ -1021,7 +1021,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 
@@ -1030,7 +1030,10 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 
 static void aspeed_spi_remove(struct platform_device *pdev)
 {
-	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	aspeed_spi_enable(aspi, false);
 }
-- 
2.52.0

