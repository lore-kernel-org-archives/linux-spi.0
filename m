Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482443E63A2;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=pMrFwwW0CZpqJ4Yy64FJSVFmHwGYTBkmoNCz0KVouRMFGw8ofkCUr84GzPxuNWBrC+s51GxN4edMakYxrTTV+AuuCxUKz2Dqgm2LfqENiiaXaKSzBzGRdVvncTZtAHqLHmsk6Y1cE6toE5rMeYcct9ZXAtX8xhA0GQbZ+UI8+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=V/4sWGPjPeOS41Y/gfE8l4nfBCZcWrpd6y7kmkEGqiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjAOFLQlNc1TRsXGYLCJB1hSFZCzDrzyYQeSi+D13/MYjxBR7mm3hjdX0UbuKLCNlBzy5btPq/YhS3HHYCC/XPS4iSW8iu5qHOesN7RhD3xSokQVuzmfFKcg3Hm+kiXmyckeZVcAIJsDAQJ0zFuzuOPO/+f/Rki64ehFqfIFOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li5MWObn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li5MWObn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02982C2BCB8;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=V/4sWGPjPeOS41Y/gfE8l4nfBCZcWrpd6y7kmkEGqiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li5MWObnWJafL0SiadSmbfBq0wvHP+xVn6tK8+I22mihXCAKSgrhyiD1t5R4lv0vK
	 cOUqpU+drNs5fUmox8Ep5ZLCVU71Rm6+PL5pQyQotrpDXmnXS5GfQgGCrYoujJ4y4i
	 sv5zdtELVCtWmDr7t6kzIYHqyFDb3VqRYvEjDb+kwUuAbIBbyP9rniHYsAZxY77caS
	 HqCAKBxHOy/A8duMIFlu6xtj02sEKmH+pTwt7wfI9rrQVZLxYqoAw93ubcQymKJ97h
	 gHhV3D5t1T/uLqIfvV8Eqn1g6E0BxUqRrVfxEN3p84MnrJ0JNwYFpnhOTkubUEXpA8
	 YMPwxFdyv/X4g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046Vs-2uN0;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Harini Katakam <harinik@xilinx.com>
Subject: [PATCH 1/8] spi: cadence: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:12 +0200
Message-ID: <20260414134319.978196-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: c474b3866546 ("spi: Add driver for Cadence SPI controller")
Cc: stable@vger.kernel.org	# 3.16
Cc: Harini Katakam <harinik@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index caa7a57e6d27..08d7dabe818d 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -777,6 +777,10 @@ static void cdns_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	if (!spi_controller_is_target(ctlr)) {
@@ -784,7 +788,7 @@ static void cdns_spi_remove(struct platform_device *pdev)
 		pm_runtime_set_suspended(&pdev->dev);
 	}
 
-	spi_unregister_controller(ctlr);
+	spi_controller_put(ctlr);
 }
 
 /**
-- 
2.52.0

