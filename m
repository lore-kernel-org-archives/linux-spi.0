Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFC4562A0;
	Fri, 21 Aug 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302864; cv=none; b=MleTdz+DgGNY82dEiHLt4AuOGUbG5K4FUKhT/unWY54Cu/+h+Q9Y/XvF3mPXT26b+NeG9tksdmW4zJHd9yS43nnDT9SDTJ9jamen+TJ8+ZpVxtOERiFUr/+r0s7MzFEeUfnYxeWp2QcT3MQg31X0PRXo8hPep0yfKMt4Dlj/ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302864; c=relaxed/simple;
	bh=aU0WpzL90wOBH6xtKr/BN2jS5vKUIkDatLPG1VwI3NQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5yC14JieahaRabJuqbxZsXCAilXv3tvX3F11S8AVL1iNw3omCKomgCkrNGAuacw9CnkV0cJdxdZlknoEHJx4zOKP17Dks/8FN43AOIbqZHMzowqfvxZxpO8EIS5zty+cYJqv7VlyTDpX9frz3jWRPwaR6brV+d/4i+G+bX/WjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L+IAs+Ui; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L+IAs+Ui"
X-UUID: cf4aab849d3e11f18dc8c9802ae25ab1-20260821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5ZMIgV9sSCRM7UCth/wb9kbNDS9+H51ny5rAs4BFkIM=;
	b=L+IAs+UiuInvI5me+OjvkFTwSKMI2PkAjTFIQJsk5+Uh4DDN8vHQYD+AfcDzX8imF0Em44m7PZRVH1FiJk8Hl1rG/7PorXZAc2fQ5SNWkPDffN6KvPQ0094MP1+S5DQBx3LSc8/80Mveu/hsBB5qVUwcarTPLw+pBnz+D2tnd+E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:92e57cce-1205-47e2-88b6-55a67fb1d2cf,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:4fb1b8fb-8958-4756-89ca-0c20582edcef,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf4aab849d3e11f18dc8c9802ae25ab1-20260821
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ot_jingcheng.ji@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1347553669; Fri, 21 Aug 2026 17:00:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 21 Aug 2026 17:00:50 +0800
Received: from gcnsap21.gcn.mediatek.inc (10.17.81.22) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 21 Aug 2026 17:00:49 +0800
From: Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<jarried.lin@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<justin.yeh@mediatek.com>, Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
Subject: [PATCH] spi: spi-mtk-nor: Get clocks from devicetree in bulk
Date: Fri, 21 Aug 2026 17:00:22 +0800
Message-ID: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The driver currently gets a fixed set of clock inputs by name. This ties
the driver to the clock names used by existing devicetrees and silently
ignores any additional clocks declared by a future platform.

Get every clock described by the devicetree with
devm_clk_bulk_get_all() and enable the resulting set as a group. Keep
looking up the "spi" input to derive the transfer rate, and verify that
the required "sf" input is present. Obtain the clock inputs before
allocating the SPI controller so a deferred clock probe fails early.

This keeps the existing platforms' behavior while allowing the binding to
describe all controller clock inputs without requiring driver changes.

Signed-off-by: Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
---
 drivers/spi/spi-mtk-nor.c | 106 +++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 5e1fdbb40ffb..2a713d27ae8e 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -116,10 +116,8 @@ struct mtk_nor {
 	void __iomem *base;
 	u8 *buffer;
 	dma_addr_t buffer_dma;
-	struct clk *spi_clk;
-	struct clk *ctlr_clk;
-	struct clk *axi_clk;
-	struct clk *axi_s_clk;
+	struct clk_bulk_data *clks;
+	int num_clks;
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
@@ -703,42 +701,12 @@ static int mtk_nor_transfer_one_message(struct spi_controller *host,
 
 static void mtk_nor_disable_clk(struct mtk_nor *sp)
 {
-	clk_disable_unprepare(sp->spi_clk);
-	clk_disable_unprepare(sp->ctlr_clk);
-	clk_disable_unprepare(sp->axi_clk);
-	clk_disable_unprepare(sp->axi_s_clk);
+	clk_bulk_disable_unprepare(sp->num_clks, sp->clks);
 }
 
 static int mtk_nor_enable_clk(struct mtk_nor *sp)
 {
-	int ret;
-
-	ret = clk_prepare_enable(sp->spi_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(sp->ctlr_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(sp->axi_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(sp->axi_s_clk);
-	if (ret) {
-		clk_disable_unprepare(sp->spi_clk);
-		clk_disable_unprepare(sp->ctlr_clk);
-		clk_disable_unprepare(sp->axi_clk);
-		return ret;
-	}
-
-	return 0;
+	return clk_bulk_prepare_enable(sp->num_clks, sp->clks);
 }
 
 static void mtk_nor_init(struct mtk_nor *sp)
@@ -807,34 +775,47 @@ static const struct of_device_id mtk_nor_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_nor_match);
 
+static struct clk *mtk_nor_get_clk(struct clk_bulk_data *clks, int num_clks,
+				   const char *id)
+{
+	int i;
+
+	for (i = 0; i < num_clks; i++) {
+		if (clks[i].id && !strcmp(clks[i].id, id))
+			return clks[i].clk;
+	}
+
+	return NULL;
+}
+
 static int mtk_nor_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct mtk_nor *sp;
 	struct mtk_nor_caps *caps;
 	void __iomem *base;
-	struct clk *spi_clk, *ctlr_clk, *axi_clk, *axi_s_clk;
-	int ret, irq;
+	struct clk_bulk_data *clks;
+	struct clk *spi_clk;
+	int num_clks, ret, irq;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	spi_clk = devm_clk_get(&pdev->dev, "spi");
-	if (IS_ERR(spi_clk))
-		return PTR_ERR(spi_clk);
-
-	ctlr_clk = devm_clk_get(&pdev->dev, "sf");
-	if (IS_ERR(ctlr_clk))
-		return PTR_ERR(ctlr_clk);
-
-	axi_clk = devm_clk_get_optional(&pdev->dev, "axi");
-	if (IS_ERR(axi_clk))
-		return PTR_ERR(axi_clk);
-
-	axi_s_clk = devm_clk_get_optional(&pdev->dev, "axi_s");
-	if (IS_ERR(axi_s_clk))
-		return PTR_ERR(axi_s_clk);
+	num_clks = devm_clk_bulk_get_all(&pdev->dev, &clks);
+	if (num_clks < 0)
+		return dev_err_probe(&pdev->dev, num_clks,
+				     "failed to get clocks\n");
+	if (!num_clks)
+		return dev_err_probe(&pdev->dev, -EINVAL, "no clocks defined\n");
+
+	spi_clk = mtk_nor_get_clk(clks, num_clks, "spi");
+	if (!spi_clk)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "missing \"spi\" clock\n");
+	if (!mtk_nor_get_clk(clks, num_clks, "sf"))
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "missing \"sf\" clock\n");
 
 	caps = (struct mtk_nor_caps *)of_device_get_match_data(&pdev->dev);
 
@@ -867,10 +848,8 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	sp->wbuf_en = false;
 	sp->ctlr = ctlr;
 	sp->dev = &pdev->dev;
-	sp->spi_clk = spi_clk;
-	sp->ctlr_clk = ctlr_clk;
-	sp->axi_clk = axi_clk;
-	sp->axi_s_clk = axi_s_clk;
+	sp->clks = clks;
+	sp->num_clks = num_clks;
 	sp->caps = caps;
 	sp->high_dma = caps->dma_bits > 32;
 	sp->buffer = dmam_alloc_coherent(&pdev->dev,
@@ -886,9 +865,15 @@ static int mtk_nor_probe(struct platform_device *pdev)
 
 	ret = mtk_nor_enable_clk(sp);
 	if (ret < 0)
-		return ret;
-
-	sp->spi_freq = clk_get_rate(sp->spi_clk);
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable clocks\n");
+
+	sp->spi_freq = clk_get_rate(spi_clk);
+	if (!sp->spi_freq) {
+		dev_err(&pdev->dev, "invalid spi clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	mtk_nor_init(sp);
 
@@ -928,6 +913,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
+err_disable_clk:
 	mtk_nor_disable_clk(sp);
 
 	return ret;
-- 
2.45.2

