Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39C3DC84C;
	Thu, 24 Sep 2026 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219551; cv=none; b=m0kFK4YMa4guzDrzqx49nQm9WGsGCTu+DU/jiBvEOu0nNvlnNRm8VpiT8k5Dm050sX3qJVx4s26Qj7DTMtlGZVvSWJOUn3BeioaZt7WDFjCdGDHn++Uav7Ryzf1DpLK+rYwn9exSU0882dJadNFN0KXbDzbEDGhm0o6vviyytsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219551; c=relaxed/simple;
	bh=Pw2wPuUh3hmwzwnzP7KJBBsVc+vi50sOOxr5oEKvBTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0sWkar8xn0f9zV2jkV+CWcY/9mNz5vdLwfp9eHvcSrq+tRexi/X5b2OdFRS5gki9veTH3lWKDGljHx2RI+JKgxZ0L6+QyC16ZRyQUoEJqWMQOAQ7CljV7fhaYfj/rbv/YVHbVe03Bo53D5VmIOM6+KwhDfYopj3DrUfk2dLeZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XS79sbAB; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XS79sbAB"
X-UUID: bee97e68b7c511f18dc8c9802ae25ab1-20260924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/u5qjt3JlnpUbCIC1OX65QpsoMDXv3YiFnJ8VBu/5D8=;
	b=XS79sbABbaSeSyUQQsFTsiAikxdTQlx6aDFzTP77I770Q1EUYItck4xAvHk4fH5rBDhrSCFy0a0FuEdY9POWB1nOghGDZJgtDZsjXLiZVO3hGKJxddV+MYh9YujTjjrzn90B9oth9w3PXKB691mnSQGRTgPLzsuun9jMhUTe3Dg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:43c11607-04e2-48ec-a55f-6af9e6995bbe,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:d956e6fa-1cb6-4618-8a29-fa072b24d2a9,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bee97e68b7c511f18dc8c9802ae25ab1-20260924
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 115473555; Thu, 24 Sep 2026 11:12:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 24 Sep 2026 11:12:15 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 24 Sep 2026 11:12:15 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>, Tim Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH 2/2] spi: mt65xx: support wider tick delay field on IPM v59
Date: Thu, 24 Sep 2026 11:12:11 +0800
Message-ID: <20260924031211.2199921-2-Tim.Kuo@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
References: <20260924031211.2199921-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The IPM v59 SPI IP widens the tick delay field in SPI_CMD_REG from
3 bits (bits 24:22) to 7 bits (bits 28:22), so the field width can no
longer be hardcoded in mtk_spi_hw_init().

Add a tick_dly_mask member to struct mtk_spi_compatible and use
field_prep() with the per-SoC mask instead of the open-coded
mask-and-shift, then add a mtk_ipm_v59_compat entry carrying the wider
mask along with a "mediatek,spi-ipm-v59" compatible. Any further changes
related to IPM v59 can be modified based on this compatible.

Existing IPM designs keep GENMASK(24, 22) and are functionally
unchanged.

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b845a599f7c6..27ed9be1b121 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -4,6 +4,7 @@
  * Author: Leilk Liu <leilk.liu@mediatek.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -81,6 +82,7 @@
 #define SPI_CMD_IPM_GET_TICKDLY_OFFSET	22
 
 #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
+#define SPI_CMD_IPM_V59_GET_TICKDLY_MASK	GENMASK(28, 22)
 
 #define PIN_MODE_CFG(x)	((x) / 2)
 
@@ -120,6 +122,7 @@
  * @dma_ext:		DMA address extension supported
  * @no_need_unprepare:	Don't unprepare the SPI clk during runtime
  * @ipm_design:		Adjust/extend registers to support IPM design IP features
+ * @tick_dly_mask:	Tick delay field of SPI_CMD_REG, IPM designs only
  */
 struct mtk_spi_compatible {
 	bool need_pad_sel;
@@ -128,6 +131,7 @@ struct mtk_spi_compatible {
 	bool dma_ext;
 	bool no_need_unprepare;
 	bool ipm_design;
+	u32 tick_dly_mask;
 };
 
 /**
@@ -187,6 +191,15 @@ static const struct mtk_spi_compatible mtk_ipm_compat = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_GET_TICKDLY_MASK,
+};
+
+/* Every SoC with IPM v59 or newer shares this */
+static const struct mtk_spi_compatible mtk_ipm_v59_compat = {
+	.enhance_timing = true,
+	.dma_ext = true,
+	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_V59_GET_TICKDLY_MASK,
 };
 
 static const struct mtk_spi_compatible mt6765_compat = {
@@ -226,6 +239,7 @@ static const struct mtk_spi_compatible mt6991_compat = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_GET_TICKDLY_MASK,
 };
 
 /*
@@ -241,6 +255,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,spi-ipm",
 		.data = (void *)&mtk_ipm_compat,
 	},
+	{ .compatible = "mediatek,spi-ipm-v59",
+		.data = (void *)&mtk_ipm_v59_compat,
+	},
 	{ .compatible = "mediatek,mt2701-spi",
 		.data = (void *)&mtk_common_compat,
 	},
@@ -366,7 +383,7 @@ static int mtk_spi_hw_init(struct spi_controller *host,
 			   struct spi_device *spi)
 {
 	u16 cpha, cpol;
-	u32 reg_val;
+	u32 reg_val, mask;
 	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
@@ -443,10 +460,10 @@ static int mtk_spi_hw_init(struct spi_controller *host,
 	/* tick delay */
 	if (mdata->dev_comp->enhance_timing) {
 		if (mdata->dev_comp->ipm_design) {
+			mask = mdata->dev_comp->tick_dly_mask;
 			reg_val = readl(mdata->base + SPI_CMD_REG);
-			reg_val &= ~SPI_CMD_IPM_GET_TICKDLY_MASK;
-			reg_val |= ((chip_config->tick_delay & 0x7)
-				    << SPI_CMD_IPM_GET_TICKDLY_OFFSET);
+			reg_val &= ~mask;
+			reg_val |= field_prep(mask, chip_config->tick_delay);
 			writel(reg_val, mdata->base + SPI_CMD_REG);
 		} else {
 			reg_val = readl(mdata->base + SPI_CFG1_REG);
-- 
2.45.2

