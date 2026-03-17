Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149B3932E7;
	Tue, 17 Mar 2026 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733346; cv=none; b=PYqFEl6uszWZMyauvlk2G6Oy48xSzzc8l6uSCLDV2Gcjn6XNkSaUg8y1WQThQPRqloi2B8SjWgMaaEGmJn0BF97J8WcELN9fxryvc99uoltV35bUuWW9/GXFozFQsAEqUmokrmyeRszeU3NIJ4V60EBHlNDowJ/Btmv/iZUpOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733346; c=relaxed/simple;
	bh=DOZv6JfDjAINwWpb5K5n9aIAtOzPWCM1t3stUq7AA+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWmkt5CjyYHslKa72sSOWwBc4ezAh9SR8THO0ViXoE4byX12OWo34AjGYGW72OjNAJFs+BrAUkvk6JrvfJVUYujZfXRNEK4k8f8IhWO3ej6cCUeOPrZ6S5PhmFMpjeAWsePWUzwoyX9cvAo2I4GHizb/KbgWbTV+PzVKwZ514a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cf463bca21d411f1a21c59e7364eecb8-20260317
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:bf44888e-4209-4ca3-b91a-f5dac4e7dbaa,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:daec58fc6affc68bdc57164a0264eb0c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf463bca21d411f1a21c59e7364eecb8-20260317
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1909361626; Tue, 17 Mar 2026 15:42:11 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	broonie@kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v3 16/17] spi: zynq-qspi: Use helper function devm_clk_get_enabled()
Date: Tue, 17 Mar 2026 15:41:58 +0800
Message-Id: <7c4aeb891885c13f5f6aef499ee007b9fd6106c1.1773733017.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773733017.git.xiaopei01@kylinos.cn>
References: <cover.1773733017.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_clk_get() and clk_prepare_enable() can now be replaced by
devm_clk_get_enabled() when driver enables the clocks. Moreover, it is no
longer necessary to unprepare and disable the clocks explicitly.
Simplify code.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-zynq-qspi.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5232483c4a3a..8c3975030d0a 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -661,7 +661,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
-	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
 		ret = PTR_ERR(xqspi->pclk);
@@ -670,36 +670,24 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&xqspi->data_completion);
 
-	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
+	xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
 		ret = PTR_ERR(xqspi->refclk);
 		goto remove_ctlr;
 	}
 
-	ret = clk_prepare_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
-	}
-
-	ret = clk_prepare_enable(xqspi->refclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable device clock.\n");
-		goto clk_dis_pclk;
-	}
-
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq < 0) {
 		ret = xqspi->irq;
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
 			       0, pdev->name, xqspi);
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 
 	ret = of_property_read_u32(np, "num-cs",
@@ -709,7 +697,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
 		ret = -EINVAL;
 		dev_err(&pdev->dev, "only 2 chip selects are available\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	} else {
 		ctlr->num_chipselect = num_cs;
 	}
@@ -728,15 +716,11 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
-		goto clk_dis_all;
+		goto remove_ctlr;
 	}
 
 	return ret;
 
-clk_dis_all:
-	clk_disable_unprepare(xqspi->refclk);
-clk_dis_pclk:
-	clk_disable_unprepare(xqspi->pclk);
 remove_ctlr:
 	spi_controller_put(ctlr);
 
@@ -758,9 +742,6 @@ static void zynq_qspi_remove(struct platform_device *pdev)
 	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
-
-	clk_disable_unprepare(xqspi->refclk);
-	clk_disable_unprepare(xqspi->pclk);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
-- 
2.25.1

