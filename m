Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F253BED18;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=lqFbu8zVoOgPTBsvydB3I4QQhCMXrMxI8k5t5LmkyY7rJLG83iDSGhWghY1BOqHxiWiZ5QyX+Q4uqNVXL+qfX2fOJIj3GQM7CG0pT+eDuVIb4ckh3si9TD1yeO1bYIJ6EVLmemFtA/004xJRVL4JS0iWSG2udvUQH9PTx3KhoeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=Th7jOuMXosTk+gCTCfiGghylv7IKAs87fp7y7wXBqwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVZ6lJgGNG4O4a0RmGx6Pf2BhOxACyUR0rTn5H0yc2BIaWtRhzHuPGmEjHmt/4a+zyD50vR2UHLj4R6YcENauwPElbjx1L/XvY/YsF38bloftDKsbkUIIHydlct4drGCihnGcY/Yw9q5NrwgG08JhTUzp31lkOTUlZocdlLXJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp6htS4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp6htS4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1159FC4AF0E;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=Th7jOuMXosTk+gCTCfiGghylv7IKAs87fp7y7wXBqwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gp6htS4iNs9bvrCvDxAu4M3Fvx2bflXj1QuejAi/Id1ryQ1GyZlv0T4VPUHc2o3NV
	 7fkUmV+EkBpxmlxS+k+0dRXHq2Qv+6T2KCOOnH/5/ugOjRYi+dkxLWh+/ZhVEPUAvL
	 LiM8hX7OJvZ7RW697ElEE2soSu1kLwFp3w6MRK7IZ6mFd6xx0m6uvrwVRufa/xAEDh
	 nkfivqmY+ldBby01D1BSn7jNLmsuWx6wHK9iPcuLCmrkvJXlUcQztK9VrPRkrbJ5vK
	 ieDZ78MsqRgQyLNl9tiGqVRJL7ixITjdbkspPKTE/ytej5bntHXWg+McEOByj1wA7I
	 sEJlEFGyhbvWQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2t-2e71;
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
Subject: [PATCH 19/19] spi: orion: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:33 +0200
Message-ID: <20260429091333.165363-20-johan@kernel.org>
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
 drivers/spi/spi-orion.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 64bf215c1804..265708a94984 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -651,11 +651,9 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int status;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
-	if (host == NULL) {
-		dev_dbg(&pdev->dev, "host allocation failed\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (host == NULL)
 		return -ENOMEM;
-	}
 
 	if (pdev->id != -1)
 		host->bus_num = pdev->id;
@@ -689,17 +687,14 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->devdata = devdata;
 
 	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(spi->clk)) {
-		status = PTR_ERR(spi->clk);
-		goto out;
-	}
+	if (IS_ERR(spi->clk))
+		return PTR_ERR(spi->clk);
 
 	/* The following clock is only used by some SoCs */
 	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
-	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
-		status = -EPROBE_DEFER;
-		goto out;
-	}
+	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!IS_ERR(spi->axi_clk))
 		clk_prepare_enable(spi->axi_clk);
 
@@ -796,8 +791,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
-out:
-	spi_controller_put(host);
+
 	return status;
 }
 
@@ -807,15 +801,11 @@ static void orion_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
 
-	spi_controller_put(host);
-
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.53.0

