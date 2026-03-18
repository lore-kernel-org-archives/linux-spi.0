Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165627B357;
	Wed, 18 Mar 2026 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801629; cv=none; b=tsKgRdyu4Y8k6M8xvP+NjrcVEP2Qa8JQktHq6yA3dZV0I8cPspHI1sW5O52j3208ZNFyEVwUit0fIcnCwf8bRE+UBjTI+yL0k/zOerWjFaKjFl5AQg8leKIcJQqnaFzBYMTkgTRGWTrpghFHCd74QhxXV3WYJ+0wvytlhH6vmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801629; c=relaxed/simple;
	bh=ZKgId+XuKb7dmeAODL3HqlCFsqUj9KiAZsqmGeZ/icc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIfj6jYoXY9GBGn96y5N5eCD2iQPnpMntypN1XP4ee+AJBDDizcHpRkSQWqKsVf0i6jj3aHDYvbjWjtY0691D+kHKYELwsu1ZrN1Vp4tmpX/2EIe35Db5wybXnwFsAF/DX13OkScAwOWPAw8ziAA0/C9mvFRsbdwprW0I17NpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ccd48820227311f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:b56c56ad-e067-4a22-9443-172de1cdf1ce,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:226ddb78f30e53253029e35ee9bdbcfa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ccd48820227311f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1768939720; Wed, 18 Mar 2026 10:40:17 +0800
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
Subject: [PATCH v4 17/17] spi: zynqmp-gqspi: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 18 Mar 2026 10:40:07 +0800
Message-Id: <53b63019d5d59698df7af832e598829d0f268ff8.1773801401.git.xiaopei01@kylinos.cn>
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
devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
the need for explicit clock enable and disable calls, as the managed
API automatically disables the clocks on device removal or probe
failure.

Remove the now-unnecessary clk_disable_unprepare() calls from the
probe error paths and the remove callback.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-zynqmp-gqspi.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 502fd5eccc83..a7e135607e2a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1244,26 +1244,16 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(xqspi->regs))
 		return PTR_ERR(xqspi->regs);
 
-	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk))
 		return dev_err_probe(dev, PTR_ERR(xqspi->pclk),
 				     "pclk clock not found.\n");
 
-	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
+	xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk))
 		return dev_err_probe(dev, PTR_ERR(xqspi->refclk),
 				     "ref_clk clock not found.\n");
 
-	ret = clk_prepare_enable(xqspi->pclk);
-	if (ret)
-		return dev_err_probe(dev, ret, "Unable to enable APB clock.\n");
-
-	ret = clk_prepare_enable(xqspi->refclk);
-	if (ret) {
-		dev_err(dev, "Unable to enable device clock.\n");
-		goto clk_dis_pclk;
-	}
-
 	init_completion(&xqspi->data_completion);
 
 	mutex_init(&xqspi->op_lock);
@@ -1339,9 +1329,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	clk_disable_unprepare(xqspi->refclk);
-clk_dis_pclk:
-	clk_disable_unprepare(xqspi->pclk);
 
 	return ret;
 }
@@ -1368,8 +1355,6 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	clk_disable_unprepare(xqspi->refclk);
-	clk_disable_unprepare(xqspi->pclk);
 }
 
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
-- 
2.25.1

