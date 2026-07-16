Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35303D668F
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243656; cv=none; b=Z3YEozJc+Q9BHREbhOfx4ql4BqhPkk0tM8Te84Ze1xEoRbMBa8LIrRIld1VrESe6NrWMT5kMwrBFpaDlgxeRus/HKfaSh0mH2cAOCnnpETd9OTjDmE6X6bmdFj0wnZYdNWCPpfjL3i2bE6LzxuGTG5NsMwmKc20dhECR4WKIW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243656; c=relaxed/simple;
	bh=u1lauwnzqGu846U7dPmC6XN+XAibMfUvyWar/SpcygU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dqs/QQELkog1aLWIgEnqGGpCoirSrr3jvrgXmz3sYph+VyyyP0cdO7xKj29lm0XG6lDPQjHdlReOyJVcXhB68xnav+rsbjFyhCl4KrSiTYQNvHwqZv4k8C6pQkQyhJ24ruM4cYBpU3PPgxHOSXwu9y2+0UEGPDhCauAVch/qUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BidBRyKY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BidBRyKY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so1679653a91.3
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784243654; x=1784848454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dOT3Xr5HlD4/j+jQBz5vkm8ZOFN6tCVQYHYgeHCzw3g=;
        b=BidBRyKYLAlcgHkf5tgdaCJk+RvU/z0VS2WCfIrtjEHF3hiLBnDlo5mGmVaYweD435
         zV0eWbGI+cdc9lMLG1jCBXriQ4GLeUNGji5cGqtcUdkW+SlH4o5V3gDDQ4fFyZeY+o0n
         NDD98TEHx2upZvn1cb2X+UUyEgmqJgV26mh59X6nY2LLTITqfoSc7KY5Nix+MsrKcV4j
         F23mAW4p8PHvcgUbeIgfzFU0x7huBo/c2S2A4Og9h3RhB6fjlPOmPkRz1dYS3u6vlYE8
         JcHkmqJwpBE5BMh43CVmVVCq4d4MuJzItNCTTXbidH701VaJxEAad+eqvweZd1T4PKy9
         ksNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243654; x=1784848454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dOT3Xr5HlD4/j+jQBz5vkm8ZOFN6tCVQYHYgeHCzw3g=;
        b=ZRXE51MOy1mpU1GM8Sa+JotEa0+Aiqc8sRFWTN1fC3PCZyp6ZnbDWvNDYbub1yr/ON
         iUNSs135TqLJUSxto4UUjhJEO9wZ4CtTu43DY9FuxHrWX2mRj6TQN+2sMpfwTBx+iLCA
         mC5nYgdwWBUWTkq3QM+vLl/4Y8rSvlsDzAy29bnSQf3S8AUD0c4Yw0voBAMMuVHoSXO4
         F8ho+8AbQbNrXf3THipoEZCoGn3RmtVQVdtbqnmnsLgqchejPzn3c7RLfIrkEyGI+dCw
         U8UhGrNiCugxI0T8pzx5VlBT7BbgmNoxWjl/COqqttpP4Ki3yO880xxkV0wdQx9krah4
         MaYA==
X-Gm-Message-State: AOJu0YyMuElRnLdqdtgJsx3GOhpSXMPC/g5uw8DbUnncKauePls1zoRG
	B0iYspti3wjlxFl0uv8E+e+dYIBXMfYJC3MSRsR/tW5zodR/VHjZtQ7JbN1qNA==
X-Gm-Gg: AfdE7cmz1Tr1DgVASM+FOJUCVP9tWxeUjsnzmxNRGTFSBuICDE+LhSXxTKeF+4IMSrU
	iUDtSKyzSbvkeSl2GgAMk+weQM3X2d1zN4snkNxzZ781+VR/xhmSYVtTNIotG02mTSQjI8z7Gtk
	LL1t3shChsIZlx5EHDIMFR+0PJpGDTfbmni8uunT4N/1Hsd03d3r7GYRg9CT89eXFUWqf/GU3IJ
	2qqAaumm5t+saerIZIorXOSVBynRJwqyZTF7KY2s3OjDbUJm/9By5jHguqoRbacD7190p1ritZv
	vdsuASds1nQUivaE52fzUxUca5cw4hifKmfziZ1Tp4ArfceRrO5BdeioRvnFkFNN2EtXdF9B8Ka
	A7lUKFD5f38bLDDJYqAqddEyuSetjKJgbz1WWedcbExbt5aLt8nxpfhERSMpYtmVkSrPGfRIIem
	a6rEnj+6oj20vPmkcRfF16HnYQ4WaVziMT9UOnEThUOG96tLiInqryLnDpv3N5MD18qmZBFhr9i
	nTXETjpLmk6FaaZQekFOVXkjVvFF7Cv0oOSAPvrz4hRY3XlRfWhQx0eHWqHUxW1Yg==
X-Received: by 2002:a17:90b:4c0a:b0:37f:9ce1:7367 with SMTP id 98e67ed59e1d1-38e4b5455a7mr85129a91.29.1784243654033;
        Thu, 16 Jul 2026 16:14:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d7a5bsm1979941a91.9.2026.07.16.16.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:14:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] spi: orion: use devm_clk_get_optional_enabled for axi clock
Date: Thu, 16 Jul 2026 16:14:11 -0700
Message-ID: <20260716231411.1737001-1-rosenp@gmail.com>
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
 v2: remove unused variable
 drivers/spi/spi-orion.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 265708a94984..e5e05512a1fd 100644
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
@@ -799,12 +791,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 static void orion_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	spi_unregister_controller(host);
 
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spi->axi_clk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -830,8 +820,7 @@ static int orion_spi_runtime_resume(struct device *dev)
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

