Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795ED27FB3C;
	Wed, 18 Mar 2026 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801627; cv=none; b=XPn/0yIbPLgMn2kHvrj4wyZJSDKfUcQAc52lEsJm/gvGFh+DZXYX41zhjlhudKY71HSPVmfZDbhQt37vYR3vbFJTgXwkMAMpmVI65JuQbxv+OSH/qCEsZKq53QSd7bYOj0TkUGp+SXq9qDN1WHgJZK0/UzGkaQDUmmojs+cUOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801627; c=relaxed/simple;
	bh=A1MJ9wWkpixAWy8C9s6wEsfvFD7RNOB5Y5hCdpz7UU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qhi/BoDjGP1MYnOMShnD9L7PoSZO55XkNFg5sX3d7rGjOD/UgX2GayXTFegPFCCr3r2YfJpldMgW6aUBELPtYGZupQC31+xVjdcSXPVQ8ky+XxbuuXyOLmuAYE6mkdkKsv8iNLRLmDxX10OaFs8C7D7+8Zvg6/mk5C9hfFyHd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9797834227311f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:af16772b-9312-4293-8750-6a8c73e092ac,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:b031f29c16b08f0b744fb72c088f818d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9797834227311f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 511542544; Wed, 18 Mar 2026 10:40:12 +0800
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
Subject: [PATCH v4 02/17] spi: bcm63xx-hsspi: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 18 Mar 2026 10:39:52 +0800
Message-Id: <774bc1c792c8469914f7192dc7a657fef6d8ccc5.1773801401.git.xiaopei01@kylinos.cn>
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
devm_clk_get_enabled() for both the "hsspi" and "pll" clocks. This
reduces boilerplate code and error handling, as the managed API
automatically disables the clocks when the device is removed or if
probe fails.

Remove the now-unnecessary clk_disable_unprepare() calls from the
probe error paths and the remove callback. Accordingly, adjust the
error handling labels to direct returns where possible.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 46 +++++++++------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 612f8802e690..266eabd3715b 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -758,8 +758,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	clk = devm_clk_get(dev, "hsspi");
-
+	clk = devm_clk_get_enabled(dev, "hsspi");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -767,41 +766,26 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	ret = reset_control_reset(reset);
-	if (ret) {
-		dev_err(dev, "unable to reset device: %d\n", ret);
-		goto out_disable_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to reset device: %d\n", ret);
 
 	rate = clk_get_rate(clk);
 	if (!rate) {
-		pll_clk = devm_clk_get(dev, "pll");
-
-		if (IS_ERR(pll_clk)) {
-			ret = PTR_ERR(pll_clk);
-			goto out_disable_clk;
-		}
-
-		ret = clk_prepare_enable(pll_clk);
-		if (ret)
-			goto out_disable_clk;
+		pll_clk = devm_clk_get_enabled(dev, "pll");
+		if (IS_ERR(pll_clk))
+			return dev_err_probe(dev, PTR_ERR(pll_clk),
+					     "failed enable pll clk\n");
 
 		rate = clk_get_rate(pll_clk);
-		if (!rate) {
-			ret = -EINVAL;
-			goto out_disable_pll_clk;
-		}
+		if (!rate)
+			return dev_err_probe(dev, -EINVAL,
+					     "failed get pll clk rate\n");
 	}
 
 	host = spi_alloc_host(&pdev->dev, sizeof(*bs));
-	if (!host) {
-		ret = -ENOMEM;
-		goto out_disable_pll_clk;
-	}
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM, "alloc host no mem\n");
 
 	bs = spi_controller_get_devdata(host);
 	bs->pdev = pdev;
@@ -887,10 +871,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 out_put_host:
 	spi_controller_put(host);
-out_disable_pll_clk:
-	clk_disable_unprepare(pll_clk);
-out_disable_clk:
-	clk_disable_unprepare(clk);
 	return ret;
 }
 
@@ -902,8 +882,6 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
-	clk_disable_unprepare(bs->pll_clk);
-	clk_disable_unprepare(bs->clk);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 }
 
-- 
2.25.1

