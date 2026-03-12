Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582313B3BF1;
	Thu, 12 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307765; cv=none; b=B//9oNiErrq0W1HilKeL0ON6rRkcuOPoDRNA2IaJvO2IchzKbHgcMW3oN4kiwG+7xOBYsOA7C4rNZfyF6NjntA3IwdU7aoERcnd8UcUkjMxgw1cyJfhx5ak/LWYGYXoquPSih6rXGd5cPtv8oik5u/AxL+r3fMF1k83ZlTSNSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307765; c=relaxed/simple;
	bh=OUjezu6YIiYoeJsh6lGMQhqkVSHLx345coLnThmoBTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B87cVAm30IHE2UwzPQTPaO/iCfBxWHj1g0WqsVUuPH2Ktitr1j2WKveX8A0sVJqwPs+Yynpab2x7U9WX+BYZpZn3Nsni22D6H/f7vqtzVQauisVItcpMCi23ONUVaPnxZM3kEtAlGXEC3LNBHwwYFVHFiea0m4EeA1h/zZVZEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0f875861df511f1a21c59e7364eecb8-20260312
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:df6e7d37-4ee7-47ae-838e-26216254e6fd,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:06b8017193470c8601b0da3b70b68dc2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f0f875861df511f1a21c59e7364eecb8-20260312
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1054376438; Thu, 12 Mar 2026 17:29:17 +0800
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
Subject: [PATCH 01/17] spi: axiado: Use helper function devm_clk_get_enabled()
Date: Thu, 12 Mar 2026 17:28:53 +0800
Message-Id: <d78ba5faa6ed3f5e009b41fc1ee1c2bcdaff882b.1773306858.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773306858.git.xiaopei01@kylinos.cn>
References: <cover.1773306858.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-axiado.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 8cea81432c5b..4ba8f0e6909f 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -770,32 +770,20 @@ static int ax_spi_probe(struct platform_device *pdev)
 		goto remove_ctlr;
 	}
 
-	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	xspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
-		dev_err(&pdev->dev, "pclk clock not found.\n");
+		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
 		ret = PTR_ERR(xspi->pclk);
 		goto remove_ctlr;
 	}
 
-	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref");
+	xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref");
 	if (IS_ERR(xspi->ref_clk)) {
-		dev_err(&pdev->dev, "ref clock not found.\n");
+		dev_err(&pdev->dev, "Unable to enable device clock.\n");
 		ret = PTR_ERR(xspi->ref_clk);
 		goto remove_ctlr;
 	}
 
-	ret = clk_prepare_enable(xspi->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
-	}
-
-	ret = clk_prepare_enable(xspi->ref_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable device clock.\n");
-		goto clk_dis_apb;
-	}
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_get_noresume(&pdev->dev);
@@ -866,9 +854,6 @@ static int ax_spi_probe(struct platform_device *pdev)
 clk_dis_all:
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(xspi->ref_clk);
-clk_dis_apb:
-	clk_disable_unprepare(xspi->pclk);
 remove_ctlr:
 	spi_controller_put(ctlr);
 	return ret;
-- 
2.25.1

