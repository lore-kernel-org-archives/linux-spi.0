Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB323A7839;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=IP0VY9aaFX1oGs7eDQz6Fl+eQ+9bORQGUjGOehieI4f6xige7MhNCRDbVJDOhWjJ4e/uqdNJaJG1nsmeqNA0lSOQI0zz6cYMrkd7nbwCrsw3A1vtXZY7xSQosAUXdob7sS4bTDX0EMDSr9Fs/2Cus52QI3u550wNomhMX/++28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=JQdycHkp59mSnuurDG+lHrUUoUYhN9XZFgJQoZWMfic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKyl3nvPx/Q8dUoINWs6D6Sd+54P6A7poOGQmqzoP4UDTvQpvkOS9zkCv9dsTWRAITMh6To0QHqmRY3AaJwT9X8DDSfYNV69102XxBlL4Bt3WVv/44rd3D7LLfLVhRD4xWhQtKOs5ApjhdQwG3kmyN4wvNN/dLhNvvQlnAOpFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB+jV2E3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB+jV2E3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2DC19425;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454042;
	bh=JQdycHkp59mSnuurDG+lHrUUoUYhN9XZFgJQoZWMfic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB+jV2E35YueBIUk8ircQ52CtgO6q73oToZMQkg+72K/wNy0QFpON/K8aM52BjcdZ
	 BJvlGqF+4nsOTMBUgGW9/aFzOm+ogmK1stiN+NRYHSJ4CaJTZFF/bG2c1Jjss6LeQW
	 PaXlNwOgntxRPg0gMrBMD3nWuF1ReM6FVV6xvzO9Cs7ZUmZbeiDh5VC4wq8zmEaN7G
	 7UHch1+zYp6KIgRwsWjl8KNSDkLMD7s3wBPG4dkWCd96EhmLUrjYsgOtZiMyHrWjPt
	 FnXBuA+vOS5nmLx0dttRMLV5EO7OwqAXzk+eNKcesMV4gjVBhD1xSmcVuX6qOvAUsr
	 LSdUxsDOM7Jxg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2P-23F1;
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
Subject: [PATCH 04/19] spi: bcm63xx-hsspi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:18 +0200
Message-ID: <20260429091333.165363-5-johan@kernel.org>
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
 drivers/spi/spi-bcm63xx-hsspi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index e935e8ab9cfd..58012e1b5ae7 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -783,7 +783,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 					     "failed get pll clk rate\n");
 	}
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*bs));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
 	if (!host)
 		return dev_err_probe(dev, -ENOMEM, "alloc host no mem\n");
 
@@ -796,10 +796,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
 	bs->wait_mode = HSSPI_WAIT_MODE_POLLING;
 	bs->prepend_buf = devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNEL);
-	if (!bs->prepend_buf) {
-		ret = -ENOMEM;
-		goto out_put_host;
-	}
+	if (!bs->prepend_buf)
+		return -ENOMEM;
 
 	mutex_init(&bs->bus_mutex);
 	mutex_init(&bs->msg_mutex);
@@ -845,7 +843,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 				       pdev->name, bs);
 
 		if (ret)
-			goto out_put_host;
+			return ret;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -869,8 +867,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-out_put_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -880,15 +877,11 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

