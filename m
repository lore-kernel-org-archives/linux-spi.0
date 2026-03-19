Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22339389DEA;
	Thu, 19 Mar 2026 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885876; cv=none; b=GVoFknwVw6C/GsJOFV0txfefjO3MwPzCgMYiwncf4Hvw33keBtwcNw4AG3d8wyItg5zSWpIFjIig3GQcZmUe///5HGzI5D5ukd4v6uI4MFt9N+cSmFhYtQ/QuN3pyPCbQvRg+Shfok/di21/ZrAySAPst5IVDZRxECntSAZXzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885876; c=relaxed/simple;
	bh=jXsq/KxvAiUCk/gtZLvEXHI3HJN2Pi5g/h/N/dcDRPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dq47isQojMwgnpsjp3sQbHqfR2sOJ8DxcUNQxecO//nE7A7pE2u+Oukcuz53+TyWFVA+hwhih/opmfRvRYCGXiJP7kW2Q/YXMnTJ8VB+pmQ1nmo37yrAVXCu0q0Wd32fxIKzgG+8lJ4ZcXT2YY2ESIyRCZoRo51BW8ZbR0X811Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f3dfb48e233711f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:894a37cd-df95-4e48-8c82-7a1a88eac4bb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:95ecb3f7b199b64be66d2642ee368a1d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f3dfb48e233711f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 952281194; Thu, 19 Mar 2026 10:04:24 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	broonie@kernel.org,
	Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v5 11/17] spi: st: Simplify clock handling with devm_clk_get_enabled()
Date: Thu, 19 Mar 2026 10:04:07 +0800
Message-Id: <383814750ad46181fd4199b3c6cec4767d480075.1773885292.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773885292.git.xiaopei01@kylinos.cn>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for the clock. This removes the need for
explicit clock enable and disable calls, as the managed API automatically
handles clock disabling on device removal or probe failure.

Remove the now-unnecessary clk_disable_unprepare() calls from the probe
error path and the remove callback. Adjust error labels accordingly.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-st-ssc4.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index b173ef70d77e..a0ae0c885669 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -293,24 +293,20 @@ static int spi_st_probe(struct platform_device *pdev)
 	host->use_gpio_descriptors	= true;
 	spi_st				= spi_controller_get_devdata(host);
 
-	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
+	spi_st->clk = devm_clk_get_enabled(&pdev->dev, "ssc");
 	if (IS_ERR(spi_st->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		ret = PTR_ERR(spi_st->clk);
 		goto put_host;
 	}
 
-	ret = clk_prepare_enable(spi_st->clk);
-	if (ret)
-		goto put_host;
-
 	init_completion(&spi_st->done);
 
 	/* Get resources */
 	spi_st->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spi_st->base)) {
 		ret = PTR_ERR(spi_st->base);
-		goto clk_disable;
+		goto put_host;
 	}
 
 	/* Disable I2C and Reset SSC */
@@ -333,14 +329,14 @@ static int spi_st_probe(struct platform_device *pdev)
 	if (!irq) {
 		dev_err(&pdev->dev, "IRQ missing or invalid\n");
 		ret = -EINVAL;
-		goto clk_disable;
+		goto put_host;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, spi_st_irq, 0,
 			       pdev->name, spi_st);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq %d\n", irq);
-		goto clk_disable;
+		goto put_host;
 	}
 
 	/* by default the device is on */
@@ -359,8 +355,6 @@ static int spi_st_probe(struct platform_device *pdev)
 
 rpm_disable:
 	pm_runtime_disable(&pdev->dev);
-clk_disable:
-	clk_disable_unprepare(spi_st->clk);
 put_host:
 	spi_controller_put(host);
 	return ret;
@@ -369,12 +363,9 @@ static int spi_st_probe(struct platform_device *pdev)
 static void spi_st_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 
-	clk_disable_unprepare(spi_st->clk);
-
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-- 
2.25.1

