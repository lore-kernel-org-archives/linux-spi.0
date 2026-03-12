Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6043B892E;
	Thu, 12 Mar 2026 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307775; cv=none; b=bmeo5IifWJnXBo6Foa2cB5k3S0OlupCKQzJNOzy40elskFIvUKuhVzyWGHGJcBFMB0gToXCe51BItT/P9MZr6haLZ7h2Lw/xyAYdCjGhP0voEQDa3UrP4oJcPWLrapA2/ri5fp7Ob/CmjM+tidOIcmXPCmr+ydaqoer7UiITVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307775; c=relaxed/simple;
	bh=AIo/n6yPsVR868Rq/k9w/ggT90lG0bfRj1Rx32Cimg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AF4mNkoLBjOlBqE2TILMVUlYEKD2IQqUGAqd64wOHgbkIreR8T35T0aszp3ejM8UeXLlS6kwlo6qWfx0bb/+VdY8CHGnv3y9coW9jW3RI4wbKZU+5V/DYeqZl6NL/mneeCTbblI1kwxjJuEP6/GjRS0UlsLEVrk6o1HPqBjsNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f3e56b281df511f1a21c59e7364eecb8-20260312
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:30aaff68-b3a0-4a6c-b7ec-9b19efc51e2d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:3e4443aa1e61333fe56bff94d6c99248,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f3e56b281df511f1a21c59e7364eecb8-20260312
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 649171632; Thu, 12 Mar 2026 17:29:22 +0800
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
Subject: [PATCH 04/17] spi: img-spfi: Use helper function devm_clk_get_enabled()
Date: Thu, 12 Mar 2026 17:28:56 +0800
Message-Id: <6891014954a8c121347dbd517b585d5a903e8da4.1773306858.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-img-spfi.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 902fb64815c9..a227cff5da70 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -557,24 +557,17 @@ static int img_spfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_spi;
 
-	spfi->sys_clk = devm_clk_get(spfi->dev, "sys");
+	spfi->sys_clk = devm_clk_get_enabled(spfi->dev, "sys");
 	if (IS_ERR(spfi->sys_clk)) {
 		ret = PTR_ERR(spfi->sys_clk);
 		goto put_spi;
 	}
-	spfi->spfi_clk = devm_clk_get(spfi->dev, "spfi");
+	spfi->spfi_clk = devm_clk_get_enabled(spfi->dev, "spfi");
 	if (IS_ERR(spfi->spfi_clk)) {
 		ret = PTR_ERR(spfi->spfi_clk);
 		goto put_spi;
 	}
 
-	ret = clk_prepare_enable(spfi->sys_clk);
-	if (ret)
-		goto put_spi;
-	ret = clk_prepare_enable(spfi->spfi_clk);
-	if (ret)
-		goto disable_pclk;
-
 	spfi_reset(spfi);
 	/*
 	 * Only enable the error (IACCESS) interrupt.  In PIO mode we'll
@@ -655,9 +648,6 @@ static int img_spfi_probe(struct platform_device *pdev)
 		dma_release_channel(spfi->rx_ch);
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
-	clk_disable_unprepare(spfi->spfi_clk);
-disable_pclk:
-	clk_disable_unprepare(spfi->sys_clk);
 put_spi:
 	spi_controller_put(host);
 
-- 
2.25.1

