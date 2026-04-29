Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75E3BE65F;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=Nhj0GnI9HUtITnUhwSLaYPmQP4k1KIFu2ytVAD+qKo9u2oz+PDEMtDfB6HauA5nwlMRw/msEfCbxWD1XYaqYDNPzCZqGD+Lr1aqDtPEfhMXvCDfMWEfZ2kbka4cW6sPfy4Jv2pKy1TQOB8xxVqeZn1hmXWXAYyXUIPqbtwj9VCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=DRUiIELEdUGN2kcabL+yNHvhS2yDxJWIatRvNuD0olI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+59ebShSh5opbybCmnmemsXg5iNPUPFCNgwMGe0O7VBoJwcGpRKs/2cqEW+DN3EcHTbLdqUWS4qtOqIb0XfJeDPz7p8wbpNKfWgJviKQGP6eym3TESd7k6EZgAUc4qnpI3R9UWPyT97CN44pcIxU3kjsUzRwWpGZqqF+sdwocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEGOkJL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEGOkJL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB90CC2BCC6;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=DRUiIELEdUGN2kcabL+yNHvhS2yDxJWIatRvNuD0olI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEGOkJL/2GKsreIUkRCrxyy+xXFTz0LnujhsmwPWbAMB/X6dXy+f1qbJWTnEYNHh8
	 w682AjSm6DxgXVgkRR4ralYpLYYEQUbA6y5A1kR5IZE8Rpa2Hak6of73qMs1uFLTOH
	 WQmt3SnLrUEqJLgDdCptLs4dUaEZYJJEwYvVb/9dUBX1aJlimsmRzbviX8jcCag3vq
	 91vg/Dt0pY/D49Ye/pTzu1yy2gIFxfSu3Ju3unHztvFYhZj9kO8tvczxGzT99KSic5
	 nroXOrg+brCeq+wZkonJPQgmQ73MlCc0HsEAEFLaS1eneNYH3AB+uQIV9+4iyiYd0A
	 mDECKlK3cqRSw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2T-281W;
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
Subject: [PATCH 06/19] spi: octeon: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:20 +0200
Message-ID: <20260429091333.165363-7-johan@kernel.org>
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
 drivers/spi/spi-cavium-octeon.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index b95bfa6a3013..28c922c72068 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -23,17 +23,15 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	struct octeon_spi *p;
 	int err = -ENOENT;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct octeon_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct octeon_spi));
 	if (!host)
 		return -ENOMEM;
 	p = spi_controller_get_devdata(host);
 	platform_set_drvdata(pdev, host);
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(reg_base)) {
-		err = PTR_ERR(reg_base);
-		goto fail;
-	}
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
 
 	p->register_base = reg_base;
 	p->sys_freq = octeon_get_io_clock_rate();
@@ -57,15 +55,12 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "register host failed: %d\n", err);
-		goto fail;
+		return err;
 	}
 
 	dev_info(&pdev->dev, "OCTEON SPI bus driver\n");
 
 	return 0;
-fail:
-	spi_controller_put(host);
-	return err;
 }
 
 static void octeon_spi_remove(struct platform_device *pdev)
@@ -73,14 +68,10 @@ static void octeon_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id octeon_spi_match[] = {
-- 
2.53.0

