Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354D3431F5;
	Fri, 13 Mar 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382154; cv=none; b=ZWlV4CS88uordLrsTwaMx87nd7NMuLZ1X5ix3GFjidSln5V8Lq0XT9igvB0ZHkwTsfVZbjS+0x0UyFg1jorvLUw8WNIFiP5mwbqB/v1rqmPV2uS17yq7s2ZHGHGUoep+P4SWzhEzxk1lfKtDxvlWRO/PtVnatX2aSVXizTQjyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382154; c=relaxed/simple;
	bh=4v7pXovmm0Civb2RYM3wCdGGjbLZTXRoHwnXU9W1MYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2HExLk0TVfel+IdJnuqcRs0ivTC6bblBg2IbXecfnpgmDYmmt/otdIpYOW5X2n5EP4XkDN08e39wuxcFHlByB9zuv7MS4NdCJBN710rvbnd3MWqERjsfEG//Y4ZxdIQz9rSYuuDCGUNucfYbe+pyGobDqcq2kkDYAKf/3kt62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 211738761ea311f1a21c59e7364eecb8-20260313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:66286e6e-5748-4f72-9176-01267d1bc785,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:b5200ca4ba5764d62dd257f382c7dda6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 211738761ea311f1a21c59e7364eecb8-20260313
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 917641804; Fri, 13 Mar 2026 14:09:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 08/17] spi: rockchip-sfc: Use helper function devm_clk_get_enabled()
Date: Fri, 13 Mar 2026 14:08:24 +0800
Message-Id: <a9c2bedd1232198e2d516623afd5cdf10d60b1a4.1773381582.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773381582.git.xiaopei01@kylinos.cn>
References: <cover.1773381582.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-rockchip-sfc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 174995042f53..ef6956f2c918 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -635,13 +635,13 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 		return PTR_ERR(sfc->regbase);
 
 	if (!has_acpi_companion(&pdev->dev))
-		sfc->clk = devm_clk_get(&pdev->dev, "clk_sfc");
+		sfc->clk = devm_clk_get_enabled(&pdev->dev, "clk_sfc");
 	if (IS_ERR(sfc->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->clk),
 				     "Failed to get sfc interface clk\n");
 
 	if (!has_acpi_companion(&pdev->dev))
-		sfc->hclk = devm_clk_get(&pdev->dev, "hclk_sfc");
+		sfc->hclk = devm_clk_get_enabled(&pdev->dev, "hclk_sfc");
 	if (IS_ERR(sfc->hclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sfc->hclk),
 				     "Failed to get sfc ahb clk\n");
@@ -657,18 +657,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 
-	ret = clk_prepare_enable(sfc->hclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
-		goto err_hclk;
-	}
-
-	ret = clk_prepare_enable(sfc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable interface clk\n");
-		goto err_clk;
-	}
-
 	/* Find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
@@ -730,10 +718,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	pm_runtime_dont_use_autosuspend(dev);
 err_irq:
-	clk_disable_unprepare(sfc->clk);
-err_clk:
-	clk_disable_unprepare(sfc->hclk);
-err_hclk:
 	return ret;
 }
 
-- 
2.25.1

