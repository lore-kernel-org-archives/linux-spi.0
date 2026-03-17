Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B0347506;
	Tue, 17 Mar 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733338; cv=none; b=SqQg2cdibAr61AmUPXrrjEfsxh9z8WeDfiTJh2EbF0qtw5FFaDqrlmZexrbNIFM+RFwWBD+7Yt0n67bloZsgRlCulBongaP0XTGI/f0AOoxReg8MeLvqS7AfwfPlO4TJaZ3di3sd1NAuu4urKbIlyq6AijgM05MbyhICf3xle4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733338; c=relaxed/simple;
	bh=82AKwxGM3h3V6OikVGOkF1PbW1cpFTbLGm2ClOl/aEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/YXR7uFylYOY0z2LZ3jjfpoGTa40KK7AxOK5PF1PTNskYoMPOoxNKdg5XIyu2V9qYh7VooUBm03GyZFFxgExbJKQRa500R1XCV7oIVdHWNy7LPPA/D+LNG0c9vBQYl0ENqZfeeyD1UY2UeMoDcJAIlH1jxZOxaNopw0GtlmeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc5be33821d411f1a21c59e7364eecb8-20260317
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:2a675b46-be70-439f-878d-98e808947a62,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:f1df8eb9a1c7ca48c391c346eb9e52a6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc5be33821d411f1a21c59e7364eecb8-20260317
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1196763844; Tue, 17 Mar 2026 15:42:07 +0800
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
Subject: [PATCH v3 07/17] spi: orion: Use helper function devm_clk_get_enabled()
Date: Tue, 17 Mar 2026 15:41:49 +0800
Message-Id: <5727aa84748872059e2a39eb67f1f08c0de6206b.1773733017.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-orion.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7a2186b51b4c..d884a18c95a6 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -695,13 +695,11 @@ static int orion_spi_probe(struct platform_device *pdev)
 	}
 
 	/* The following clock is only used by some SoCs */
-	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
+	spi->axi_clk = devm_clk_get_enabled(&pdev->dev, "axi");
 	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
 		status = -EPROBE_DEFER;
 		goto out;
 	}
-	if (!IS_ERR(spi->axi_clk))
-		clk_prepare_enable(spi->axi_clk);
 
 	tclk_hz = clk_get_rate(spi->clk);
 
@@ -726,7 +724,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(spi->base)) {
 		status = PTR_ERR(spi->base);
-		goto out_rel_axi_clk;
+		goto out;
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
@@ -764,7 +762,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		if (!dir_acc->vaddr) {
 			status = -ENOMEM;
 			of_node_put(np);
-			goto out_rel_axi_clk;
+			goto out;
 		}
 		dir_acc->size = PAGE_SIZE;
 
@@ -788,8 +786,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
-out_rel_axi_clk:
-	clk_disable_unprepare(spi->axi_clk);
 out:
 	spi_controller_put(host);
 	return status;
@@ -802,7 +798,6 @@ static void orion_spi_remove(struct platform_device *pdev)
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spi->axi_clk);
 
 	spi_unregister_controller(host);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

