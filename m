Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC433CF203
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153630; cv=none; b=W9RPg9kaZoyyz5/oZHoYKM0Z6f22zZTLBOF+ZQX8ZBTgKih/rkZS0i3RMbe3gEdfc06qWpFU6rTdvRzDOaINVX5XBprvSyJqFNtmF7GzSwZcshz8/wCTqwTtf+QqrW2zUaAscI49bc2of5XU8RPXvAXvxrQvsLVRZMuA5tByK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153630; c=relaxed/simple;
	bh=xAI4aSvx8toD6uvFflQxRXfUUkOjhwKQLQvQohnKOUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6eltLYaoC38392WQzGyA/J8aAVgxkyXwf8Z+yk4GSTNTRLKvJ+Gdamad/8iJbEhtxiUkncVZDTsQ6qYgztHV6bZK5f3sRFim8vYkGwuBFZZM6/zNY4CL6YsVoycdZduVocxKEjldruI2c8Hb/03RCG7nZmSkF+2Ejr4qIXdBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INUyZ+2K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INUyZ+2K"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381b831d535so3016996a91.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784153628; x=1784758428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S+cmnwHjCLxQUJ1DbHmEfqrymZHn9umz8cSa/aq1fok=;
        b=INUyZ+2KfG3ZkxTGvrd7spXT2qOjwr/V4tkYpQF3Z7BCQsKxCU9Mf4dVHz15KZsG5L
         YAdi3TxjBA2qbMidyZx/Bde9uEWCwkeYpviDWuYHfO9NPblV5aQ7+sxSsrM4g9iwDGtU
         HsJIjAsqS38ugVQaAiRfGWHRZodhR7rrR78iasEkk0Mbuyn7MFK6VEEHs3ph79eAg7Kh
         hG+yfimDBG/qjsFTUSTOl2Cf/qbobiVcRRpriJ6dLh2eC2CBt/X+pOwvTxY4YqqxChvT
         ua483CWY+U4GMcHdU2I6hbiSwLjZrHpzLAY2QR5HSoisQcy1U8dwq+DFSuO1ZELUrXRs
         MTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153628; x=1784758428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+cmnwHjCLxQUJ1DbHmEfqrymZHn9umz8cSa/aq1fok=;
        b=aRHlSYzUoJi70jiiIqelX4RJu1qNNtZEb22moQqYwNYjyjN9asyGyQyi07tuYOJoTV
         ZJVZDbvVwFPnIOU2fBm+ND7UFZTM0xtUiLqzL1GZndT+1KrGr5NPAkp1fXeduO6iBITi
         oKgZo2Uf7BYgXeZH70F/U/VLwY+lhZ6wRa6JjDg9/oQSlRYs2xMnX8EUsqzBzfdtJCU3
         YJ08828yS8abdTOAVU7s3uc1OJ99jsOJK2s0GkWbZ3wwhPJRrkVT84OVIwnG2xJvyvLj
         jbsPQq4QSf69j4EIaihLhe3QgNVdNQO5Uu2Vc5g3vX0oIYyR7AYbHcBrKrhaKJ0NqZUb
         T6fg==
X-Gm-Message-State: AOJu0YyFt50lq1kLQuC68kAimUr43MSNB+3WToBcgJ1W8PUDDK9XAAsy
	4ugrofCMCLBuB/nB8p8C86aknsHgeZBFIMz5oPaCiGSLyNLS2Hz/ZonZoOWi6Q==
X-Gm-Gg: AfdE7clK/NLLzD+sdOv8aL82wFm1bZG1bn/zg9R3vSYUQ0caDXZKDsUZ27JTU8u1uAf
	6jN50oU8mG5tzJuKYX8EWW1KH3I1BQh4h8+WvYgZV8kWh1rxAfip8wTYUknlotwaCRvNZNcyGlj
	RttUKTf809BM/hF5A13gISQbrJ7hk4ZHF8iDrI2JIAgAf6EH8YTk/hYeMyDPD/YQcKFA9FfCK3D
	AAaaItSQkjSjqkF76DfHV2dcfeySReSAa8cIZUyoZ7tJx1rm273JxImOt2eMg2o9ZOt4sSQaDHV
	GlSffk+Rp9zMVsC85J9/ZWtrP/rzllA0DoqO4IPsAcxzIT0g/BkkQ+LPGT0TlR7nJX6cspgxWIa
	Fc88oUQtjX7s0IZ2pWG/Q3lGBj4uRbG/GF+jCtS3gkO1u2xzpIQ5D1wGV1kt9X+3ui8HvFH9g/j
	+9LJPZMN+iHuuJztJZRSY5gS2moQXsbsYr91Q0+ZuWkvRZ61uOujPqBkDuKqi7YAPN7CkWeBLVA
	wwOLFHQfqEwhEpVpu9EpO8aNW+nB/VN49EkmTzINpvwY7mquTpBEPA=
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38dc779ac27mr17745813a91.43.1784153628189;
        Wed, 15 Jul 2026 15:13:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e2a06436asm1078628a91.0.2026.07.15.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:13:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: orion: use devm_clk_get_optional_enabled for axi clock
Date: Wed, 15 Jul 2026 15:13:43 -0700
Message-ID: <20260715221343.474130-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded optional axi clock get/prepare/enable and the
manual cleanup in probe/remove/runtime_resume with the managed helper
devm_clk_get_optional_enabled(). This removes the now-unused
out_rel_axi_clk error path and simplifies the clock lifecycle.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-orion.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 265708a94984..b1049fd66313 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -691,12 +691,9 @@ static int orion_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(spi->clk);
 
 	/* The following clock is only used by some SoCs */
-	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
-	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (!IS_ERR(spi->axi_clk))
-		clk_prepare_enable(spi->axi_clk);
+	spi->axi_clk = devm_clk_get_optional_enabled(&pdev->dev, "axi");
+	if (IS_ERR(spi->axi_clk))
+		return PTR_ERR(spi->axi_clk);
 
 	tclk_hz = clk_get_rate(spi->clk);
 
@@ -719,10 +716,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	host->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
 	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(spi->base)) {
-		status = PTR_ERR(spi->base);
-		goto out_rel_axi_clk;
-	}
+	if (IS_ERR(spi->base))
+		return PTR_ERR(spi->base);
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		struct orion_direct_acc *dir_acc;
@@ -757,9 +752,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 		dir_acc = &spi->child[cs].direct_access;
 		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
 		if (!dir_acc->vaddr) {
-			status = -ENOMEM;
 			of_node_put(np);
-			goto out_rel_axi_clk;
+			return -ENOMEM;
 		}
 		dir_acc->size = PAGE_SIZE;
 
@@ -789,8 +783,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-out_rel_axi_clk:
-	clk_disable_unprepare(spi->axi_clk);
 
 	return status;
 }
@@ -804,7 +796,6 @@ static void orion_spi_remove(struct platform_device *pdev)
 	spi_unregister_controller(host);
 
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spi->axi_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -830,8 +821,7 @@ static int orion_spi_runtime_resume(struct device *dev)
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
-	if (!IS_ERR(spi->axi_clk))
-		clk_prepare_enable(spi->axi_clk);
+	clk_prepare_enable(spi->axi_clk);
 	return clk_prepare_enable(spi->clk);
 }
 #endif
-- 
2.55.0

