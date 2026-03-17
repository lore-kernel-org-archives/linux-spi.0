Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063873932F0;
	Tue, 17 Mar 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733341; cv=none; b=mEyzUuZcRiwetEf+asq6mq788x8NOVzrgCi+lAVp6RL0u5+mSi4dYsL6vfjtGWLvARWR9kGWUcvzZeByo8gQHRvI3OxVZhDvdtHUgWr3GCA+P3tDi79/DvkXo1rKMJIypO1Rkn0oJRto9uRmZDRZmmVEkJKl7ofb+kAUt4Xl5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733341; c=relaxed/simple;
	bh=Y5piE1nBnd7tD4C3JSkJbXg8bUIcLfzWqCneIBW2R2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDhniRieNTu45lSYMmHzTkj2gplNTg6vQOY7k1gF3MQcaOPFwuEyi2UR+RCJmQ4uIkAQXg1S6jIm1SHl4MB46zz8yAU+Ir/yQXudw+PP7FwVeX6iSZAX6Max2P2rxegT9TFRNhctB3JNqEDM0urX59XxIW4I1y8cH9nTaeaZvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cbc21cc621d411f1a21c59e7364eecb8-20260317
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:411e6a02-8d0b-4e4c-84bd-7ef9f369b108,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:cbcfd85ecb1818866de2a169f6ff5070,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cbc21cc621d411f1a21c59e7364eecb8-20260317
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 377488289; Tue, 17 Mar 2026 15:42:06 +0800
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
Subject: [PATCH v3 05/17] spi: imx: Use helper function devm_clk_get_enabled()
Date: Tue, 17 Mar 2026 15:41:47 +0800
Message-Id: <96d35448e9d667243ede30ef15e1fa7b84046df2.1773733017.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-imx.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 64c6c09e1e7b..a01c466818de 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2323,26 +2323,18 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_controller_put;
 	}
 
-	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	spi_imx->clk_ipg = devm_clk_get_enabled(&pdev->dev, "ipg");
 	if (IS_ERR(spi_imx->clk_ipg)) {
 		ret = PTR_ERR(spi_imx->clk_ipg);
 		goto out_controller_put;
 	}
 
-	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
+	spi_imx->clk_per = devm_clk_get_enabled(&pdev->dev, "per");
 	if (IS_ERR(spi_imx->clk_per)) {
 		ret = PTR_ERR(spi_imx->clk_per);
 		goto out_controller_put;
 	}
 
-	ret = clk_prepare_enable(spi_imx->clk_per);
-	if (ret)
-		goto out_controller_put;
-
-	ret = clk_prepare_enable(spi_imx->clk_ipg);
-	if (ret)
-		goto out_put_per;
-
 	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(spi_imx->dev);
 	pm_runtime_get_noresume(spi_imx->dev);
@@ -2386,9 +2378,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
-	clk_disable_unprepare(spi_imx->clk_ipg);
-out_put_per:
-	clk_disable_unprepare(spi_imx->clk_per);
 out_controller_put:
 	spi_controller_put(controller);
 
-- 
2.25.1

