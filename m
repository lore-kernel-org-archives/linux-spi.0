Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAE34CDD;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=JiaYEIhqgziwVxsWgz5Cu+hY2lzUgrMeO0jjaGnAl/BMJZasUTtGb6NJbkQQq1lPGBthwIivUFOGuCjZnQWbSsyItu5FWRkO4Ck1dGiXE4Nrzj4DCKAdYiXslFGRGRF5SP3tz9AYUcMNDyBbt1uC/2TkePoJ8uuMXtkONTGmX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=3U1QY5N85lS4mCVnz/TZvVbzIVXjgbkWXAMpxK9sciY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3nNUK87qOHOdDLPCgevRJG6ku8xJlSJdLZveDRUAGyHnc3SHfXpQaIY2SjxLj8eTEfJKlbidqQjvDltm5EFePgUll4DAzafaTbCt3eH48xrYMtchitp1JKMXPLhWFEwp6AV6r7gfNKqPEdC6u/wcO7CGDEPdEJ1EJvvLnFqkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIwGrDFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIwGrDFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21259C2BCB0;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=3U1QY5N85lS4mCVnz/TZvVbzIVXjgbkWXAMpxK9sciY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIwGrDFJkOwNSkOjZnv6O6KpnbjQaaUt5ZiU8C51+ngYJ3rwwkACbszQQc7MooAdR
	 QzUI0MG7KOR93L5/Z3qXxSY62W34CSeJl/pMp48KCewjOQBdM8ldnE+w4e+dvmpqix
	 QlH6OE/geixGu22/XcUlugbs/VHXV67BPP4XQfZEBsmDQE/b/S5DhjX8mPy7qw1T8g
	 7ddMnfmqo6TXZIpcjt9xjJ42ATxpeGbuAXg3/p2Fu9BLyNGdhK0uHrmlvbRIChjc7e
	 OhTczlpsFLmXVP+xuDHLY4D8Tetw304hiP1vJ1/5iABHgQ7FxpBGBiWpMFuJFn/+rt
	 3vEibbtvKFUMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIO-3qs3;
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
	stable@vger.kernel.org
Subject: [PATCH 1/6] spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
Date: Tue, 21 Apr 2026 14:53:49 +0200
Message-ID: <20260421125354.1534871-2-johan@kernel.org>
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

A recent attempt to fix the probe error handling introduced a runtime PM
disable depth imbalance by incorrectly disabling runtime PM on early
failures (e.g. probe deferral).

Fixes: f18c8cfa4f1a ("spi: cadence-qspi: Fix probe error path and remove")
Cc: stable@vger.kernel.org	# 7.0
Cc: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 50ef65fc5ded..5040e4e1cce0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1871,7 +1871,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clocks.\n");
-		goto disable_rpm;
+		return ret;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1981,7 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
-			goto disable_controller;
+			goto disable_rpm;
 		}
 	}
 
@@ -1999,14 +1999,13 @@ static int cqspi_probe(struct platform_device *pdev)
 release_dma_chan:
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
-disable_controller:
+disable_rpm:
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
-disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		pm_runtime_disable(dev);
 
 	return ret;
 }
-- 
2.52.0

