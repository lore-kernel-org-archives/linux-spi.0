Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435E2D5C83;
	Thu,  3 Sep 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422997; cv=none; b=m1w8ZV77FnWuQy41QQ0c6puKK98XqxtdcfwBLr0B2VbZZuMFvyVS5hSZooT9gE/D7k/3LqFtfQlBNmOusksfWsOXoAp+sWfBhxstaHeV3AVxGZfJB1nXG9XKUcs3l3ILJJRi0hAZIZY19r/0WqZAq6NxZX3Z+p+tLUv3AjSqktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422997; c=relaxed/simple;
	bh=beIb62cHVy+CYxcQZM1LJlMfrvDjLbcIGieklNMDGhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0dgEn759o8+nkBXwOqM0UirMPAd/jOuasPnNbamEeYjSWSb0Xx86I1/a8XmcYYX4Hu0TD773MmvzB5q7weh6KKznKJaw3PN78PWID+rhTpIe2AGk/JdNN9k2OPR8rMdAov7E40N9nMoGlIss0TxApwtfh/mXZbv2zD6PgNW2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DoIW6Bea; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DoIW6Bea"
X-UUID: d3e00bbea76e11f1b1788b6acf885367-20260903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VUxWm/z7xLtLP5dz8f8UFkQB4ImA8Yg4bPohYdRPwwA=;
	b=DoIW6Beanz9UUrohSgtAE20Yt8bqRnCP0s9LaYALJjcM6rCEEQEWPURhB2rC2n48TuXtC45iA1DA3TP+tOhzPCv4ayXcFtu0YEs/z7CpIW6XlSIR+VarBUkdDSmydgfevGrIVov3EoeCI5fJLIwp2J+ehSj9oZ74o879es1te3g=;
X-CID-CACHE: Type:Local,Time:202609031556+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5d43f65e-cca4-4e01-9bd9-7949f0309295,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:cb35c60b-079b-435d-86f5-6a8271106506,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d3e00bbea76e11f1b1788b6acf885367-20260903
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ot_jingcheng.ji@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1329234165; Thu, 03 Sep 2026 16:09:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 3 Sep 2026 16:09:45 +0800
Received: from gcnsap21.gcn.mediatek.inc (10.17.81.22) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 3 Sep 2026 16:09:45 +0800
From: Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jingcheng Ji
	<ot_jingcheng.ji@mediatek.com>
Subject: [PATCH v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk
Date: Thu, 3 Sep 2026 16:09:32 +0800
Message-ID: <20260903080932.3049888-1-ot_jingcheng.ji@mediatek.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
References: <20260821090046.2353986-1-ot_jingcheng.ji@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The driver currently gets a fixed set of clock inputs by name. This ties
the driver to the clock names used by existing devicetrees. It also means
that a future binding extension which adds controller clock inputs needs a
matching driver change to enable them.

Get every clock described by the devicetree with
devm_clk_bulk_get_all() and enable the resulting set as a group. Keep
looking up the "spi" input to derive the transfer rate, and verify that
the required "sf" input is present. Obtain the clock inputs before
allocating the SPI controller so a deferred clock probe fails early.

For non-DT platform devices, retain the existing named clock lookups so
clkdev users continue to work.

This prepares the driver for future binding extensions without requiring
another driver change. Existing platforms' behavior is unchanged.

Signed-off-by: Jingcheng Ji <ot_jingcheng.ji@mediatek.com>
---
v2:
- Rebase onto current spi/for-next and reuse its existing IRQ error cleanup
  path.
- Preserve named clock lookup for non-DT platform devices.
- Clarify that this prepares for a future binding extension.

 drivers/spi/spi-mtk-nor.c | 151 +++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 60 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 63f5139176c8..c0a47f3a8dbd 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/string.h>
@@ -116,10 +117,8 @@ struct mtk_nor {
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
@@ -703,42 +702,12 @@ static int mtk_nor_transfer_one_message(struct spi_controller *host,
 
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
@@ -807,34 +776,92 @@ static const struct of_device_id mtk_nor_match[] = {
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
+static int mtk_nor_get_named_clks(struct device *dev,
+				  struct clk_bulk_data **clks)
+{
+	struct clk_bulk_data *bulk;
+	struct clk *clk;
+	int num_clks = 2;
+
+	bulk = devm_kcalloc(dev, 4, sizeof(*bulk), GFP_KERNEL);
+	if (!bulk)
+		return -ENOMEM;
+
+	bulk[0].id = "spi";
+	bulk[0].clk = devm_clk_get(dev, bulk[0].id);
+	if (IS_ERR(bulk[0].clk))
+		return PTR_ERR(bulk[0].clk);
+
+	bulk[1].id = "sf";
+	bulk[1].clk = devm_clk_get(dev, bulk[1].id);
+	if (IS_ERR(bulk[1].clk))
+		return PTR_ERR(bulk[1].clk);
+
+	clk = devm_clk_get_optional(dev, "axi");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	if (clk) {
+		bulk[num_clks].id = "axi";
+		bulk[num_clks++].clk = clk;
+	}
+
+	clk = devm_clk_get_optional(dev, "axi_s");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	if (clk) {
+		bulk[num_clks].id = "axi_s";
+		bulk[num_clks++].clk = clk;
+	}
+
+	*clks = bulk;
+
+	return num_clks;
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
+	if (dev_of_node(&pdev->dev))
+		num_clks = devm_clk_bulk_get_all(&pdev->dev, &clks);
+	else
+		num_clks = mtk_nor_get_named_clks(&pdev->dev, &clks);
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
 
@@ -867,10 +894,8 @@ static int mtk_nor_probe(struct platform_device *pdev)
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
@@ -886,9 +911,15 @@ static int mtk_nor_probe(struct platform_device *pdev)
 
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
 
-- 
2.45.2
