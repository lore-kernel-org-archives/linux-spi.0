Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0F28751B;
	Wed, 18 Mar 2026 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801628; cv=none; b=nWwuzaAOfsouNQbEk+GU/n6Kt10bC/WN2O1sgvQOulMcW4zdkgb95CBfkiH6BLrHUyZ1vKhdA4VgDwwUVJHW4sgnzejfYpItZyOeYCAxoZzfGuqRggMB8tJEQ3sGYjEm9zn0gESFoDWhm7HfNX/gE6s1y5pF/HTvxlvSqh4Lkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801628; c=relaxed/simple;
	bh=YoGA5aJowGGpP+PaNmTT3oymVeJj3nwzRoBx3s+MCL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnVI3NviM4hPBK104O8loHZBOtVDyQ5edKApvtlHIATT7wKB2wwQppZVh7XmRuSncOMqLa9mZc+Pg0sfr3RpOp+ZOsEfL/8FP6xHzIIaICgorqht99KN8RBPnmVANW7IODhe6bHdqTJKXBBuVTJeH14/abENMo9irxEkyX5Z8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb7e1ab8227311f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:e46d18cf-e8a5-4d59-9e7b-bda6df9eb506,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:e1c521adc400ff51785a2be84135d7dc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cb7e1ab8227311f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1343014953; Wed, 18 Mar 2026 10:40:15 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v4 11/17] spi: st: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 18 Mar 2026 10:40:01 +0800
Message-Id: <d2a55c36daf32e0fc6c3e5d3bbddd8c757c45f17.1773801401.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773801401.git.xiaopei01@kylinos.cn>
References: <cover.1773801401.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-st-ssc4.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index b173ef70d77e..0d653986499c 100644
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
@@ -373,8 +367,6 @@ static void spi_st_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	clk_disable_unprepare(spi_st->clk);
-
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
-- 
2.25.1

