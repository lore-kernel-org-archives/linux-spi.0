Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965183D566E;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=NINHRN0Cc5/I/9FFY17aMCHfNpxxnwD6r0DjmMqVKQibWGsajossyO4BXN7AFO8drS5hNEb9PjYZUqND/cIoKXbbRD4w8o3LK6z2ofVcu7Qex1OP7aZMJj4aJCZk2oTgd4rjTYeJ0/95L/QFYL51NSZhvdKFhLN++eW3Tzl1o0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=5zAv3goxx5vPErOb84fnj3fbuhYFhTR9v/u8V+5xbAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRkNk3AWgwSknb8oBG8KHdeGfK3MDQ2gkHuMe91yXZYsKot7WH9LZoUF+vBe1N+x+oY7nrTHeMarFJJ4/ZOwXEsgCbZ9l4synaeicp0ndc2yzQey6hljWa/RnpK4w69oMsHOYYAoTi7M+1HXCnvltQ6SSVMPt352uwcki0YbML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM/YQ3MC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM/YQ3MC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388BDC2BCC7;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=5zAv3goxx5vPErOb84fnj3fbuhYFhTR9v/u8V+5xbAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aM/YQ3MCjhuJWMoLFZ+14gmyV3VYp0JYHj46rEbgcpJlkapDA+kFti4qeNwVHWdJx
	 SPUSt3sX0J7XYWUyP0Q1Xd5qFhnDuGdzD/Ev10eUtENdvUXqSBEtbfR8wuvbE/80j8
	 rB4FKoHfPfNbdKjebHdyKcKx4KWxtAev2X02xfepAp2muNW6uoxj1C/9LTPga8HIss
	 CqsNZx2s3vEZtFxwFjZP1Oqq06sUGsOW48kkhsauszZ0vpeoaeuSCzEQ/4I/53QDxe
	 owPL/T7+acUU+Zm11uW5JZzQvUqK5PWAT+8K3QoUbfOhQlM+I/0cr0IO0UmoecViGd
	 ks3M5RpeFhI7g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIW-40fT;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH 5/6] spi: cadence-quadspi: clean up disable runtime pm quirk
Date: Tue, 21 Apr 2026 14:53:53 +0200
Message-ID: <20260421125354.1534871-6-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421125354.1534871-1-johan@kernel.org>
References: <20260421125354.1534871-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 30dbc1c8d50f ("spi: cadence-qspi: defer runtime support on
socfpga if reset bit is enabled") fixed a warm reset issue on SoCFPGA by
disabling runtime PM on that platform.

Clean up the quirk implementation by never dropping the runtime PM usage
count on probe instead of sprinkling conditionals throughout the driver
which makes the code unnecessarily hard to read and maintain.

Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Cc: Niravkumar L Rabara <nirav.rabara@altera.com>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 47 +++++++++++++------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1b0d6186c7ef..f9f2313413cb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1478,7 +1478,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
-	const struct cqspi_driver_platdata *ddata = of_device_get_match_data(dev);
 
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
@@ -1494,18 +1493,15 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EBUSY;
 	}
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret) {
-			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-			goto dec_inflight_refcount;
-		}
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+		goto dec_inflight_refcount;
 	}
 
 	ret = cqspi_mem_process(mem, op);
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_put_autosuspend(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1961,13 +1957,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-		pm_runtime_use_autosuspend(dev);
-		pm_runtime_get_noresume(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-	}
+	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 
 	host->num_chipselect = cqspi->num_chipselect;
 
@@ -1997,12 +1991,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_disable(dev);
-		pm_runtime_set_suspended(dev);
-		pm_runtime_put_noidle(dev);
-		pm_runtime_dont_use_autosuspend(dev);
-	}
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
 	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
@@ -2037,12 +2030,10 @@ static void cqspi_remove(struct platform_device *pdev)
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 	}
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
-		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
-	}
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
-- 
2.52.0

