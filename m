Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CE38BF6A;
	Thu, 19 Mar 2026 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885878; cv=none; b=jrvN8BTs0gQvb7T5Iwx4TKL2fheKWrUZZifDxw4auxkEn0p9+yx6HXfJcsON3ZsKk4AoqOZcCmEzD4DKTitSB4t68CRlXurVb5RmCHmiGWiWd+qwbv5JdwVQTFG8GHmCCZe4w8EhAwX1zqJ7FuxP7ftkominahEuC5Ru5miGm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885878; c=relaxed/simple;
	bh=3l0QCkc9erOyfe7834Hqf9wtBT4G0O2Nx4u50SsO1z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp/1xMJJoRadJxP7V1Dbh/dlyPBt6EhWKXUZp9brddbRL3uUturLUDLZnq3Qf009UgYFujAut6q6X8NKoClsAVz8KwoGtFNwryrVEPodUPyOwIqFET7GkGH3q3YI8LFoaxtzaHc8ahS39kBHMetIgdtCWdA9GjHVe2MUA3gNKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1244d36233711f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:e5ca363b-e0c5-4d6f-80e4-f6f49bb11e45,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:18f254301f3ca4f993d6689c6ba00c6e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1244d36233711f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1102121891; Thu, 19 Mar 2026 10:04:20 +0800
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
Subject: [PATCH v5 03/17] spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
Date: Thu, 19 Mar 2026 10:03:59 +0800
Message-Id: <a3d07ed20d7bdc676fb10c9a73224f80e83b3232.1773885292.git.xiaopei01@kylinos.cn>
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
devm_clk_get_enabled() for both the "hsspi" and "pll" clocks. This
reduces boilerplate code and error handling, as the managed API
automatically disables the clocks when the device is removed or if
probe fails.

Remove the now-unnecessary clk_disable_unprepare() calls from the
probe error paths and the remove callback. Simplify the error handling
by converting to direct returns with dev_err_probe() where appropriate.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-bcmbca-hsspi.c | 49 +++++++++++-----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index ece22260f570..2e22345115fd 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -452,39 +452,30 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(spim_ctrl))
 		return PTR_ERR(spim_ctrl);
 
-	clk = devm_clk_get(dev, "hsspi");
+	clk = devm_clk_get_enabled(dev, "hsspi");
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get hsspi clock\n");
 
 	rate = clk_get_rate(clk);
 	if (!rate) {
-		pll_clk = devm_clk_get(dev, "pll");
+		pll_clk = devm_clk_get_enabled(dev, "pll");
 
 		if (IS_ERR(pll_clk)) {
-			ret = PTR_ERR(pll_clk);
-			goto out_disable_clk;
+			return dev_err_probe(dev, PTR_ERR(pll_clk),
+					     "Failed to get pll clock\n");
 		}
 
-		ret = clk_prepare_enable(pll_clk);
-		if (ret)
-			goto out_disable_clk;
-
 		rate = clk_get_rate(pll_clk);
-		if (!rate) {
-			ret = -EINVAL;
-			goto out_disable_pll_clk;
-		}
+		if (!rate)
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to get pll clock rate\n");
 	}
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
-	if (!host) {
-		ret = -ENOMEM;
-		goto out_disable_pll_clk;
-	}
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed alloc spi host\n");
 
 	bs = spi_controller_get_devdata(host);
 	bs->pdev = pdev;
@@ -535,18 +526,16 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, irq, bcmbca_hsspi_interrupt, IRQF_SHARED,
 			       pdev->name, bs);
 		if (ret)
-			goto out_disable_pll_clk;
+			return dev_err_probe(dev, ret, "Failed request irq\n");
 	}
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
-		goto out_disable_pll_clk;
+		return dev_err_probe(dev, ret, "Failed pm runtime enable\n");
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-	if (ret) {
-		dev_err(&pdev->dev, "couldn't register sysfs group\n");
-		goto out_disable_pll_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "couldn't register sysfs group\n");
 
 	/* register and we are done */
 	ret = devm_spi_register_controller(dev, host);
@@ -559,10 +548,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 out_sysgroup_disable:
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-out_disable_pll_clk:
-	clk_disable_unprepare(pll_clk);
-out_disable_clk:
-	clk_disable_unprepare(clk);
 	return ret;
 }
 
@@ -573,8 +558,6 @@ static void bcmbca_hsspi_remove(struct platform_device *pdev)
 
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
-	clk_disable_unprepare(bs->pll_clk);
-	clk_disable_unprepare(bs->clk);
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 }
 
-- 
2.25.1

