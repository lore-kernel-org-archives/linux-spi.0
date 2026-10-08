Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EE47209F;
	Thu,  8 Oct 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449627; cv=none; b=gVpDrXVnu8PQU9WWXpGNnbY76UX4FOcu6mmKxyFcstN3GexyTUQ2W/M2aZ7HT4o3ibOnu+Qb5IENzItcQGL7V3LvnA3LMWchW89OxW3gFLttrAEqPxEQyYRjzv/uoX30Q4VeUaP6WCQDA3voAZ+iFa49gMg/x7SoZY1Df5jJPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449627; c=relaxed/simple;
	bh=LA4fDF9BplPPgGkz5iJDTFLtks9svHDAM/NEHzN9LpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8HiaDB/F5pXlBL2ZT0KyRCJxDmVkjAIC+eXI5RNkcgpcuKDpvG+POh+VdvHkgXXLOUbteFGrurwKcaiCjjog67s8x9RwbnbdaYtbJn9rYloOMTMingrge9zAphCpfYhH1UFW+g3AeaVQZT2AROtRHWqv+v1rvSccwyJxfM1UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DIVk3fho; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DIVk3fho"
X-UUID: bf1507fac2f511f1b1788b6acf885367-20261008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jGdz7yLAg+mrvuFLQWM7yy6NK755mXWFHUSIqMTw69A=;
	b=DIVk3fhoVRf5HnQ8d5hgar0cfOevqlZAGccPWHa9c3fxyLYfs2zb9gnDriRHSzvY4sg4OyGLjAFs6qiYNCycMiY884Mx5UX17psRWtX/KwkvQjYK4OrNQOLB9fdf3WMY5rqfhhJ8hLhLI1KM8gMiqrw5vel+m8/VWgUpk/BeeiQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:c8922fc0-eae1-4d4d-a13b-99e8e8441c99,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:291e20b,CLOUDID:769b59ec-a538-4631-9c6c-6898e3cb1d37,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bf1507fac2f511f1b1788b6acf885367-20261008
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <tim.kuo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1188297454; Thu, 08 Oct 2026 16:53:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Oct 2026 16:53:34 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 8 Oct 2026 16:53:34 +0800
From: Tim Kuo <Tim.Kuo@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>,
	Sky Huang <Skylake.Huang@mediatek.com>, Sam Shih <Sam.Shih@mediatek.com>, Tim
 Kuo <Tim.Kuo@mediatek.com>
Subject: [PATCH v3 2/2] spi: mt65xx: support wider tick delay field on MT7987/MT7989
Date: Thu, 8 Oct 2026 16:53:32 +0800
Message-ID: <20261008085332.802898-2-Tim.Kuo@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261008085332.802898-1-Tim.Kuo@mediatek.com>
References: <20261008085332.802898-1-Tim.Kuo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The MT7987 and MT7989 SPI IPs widen the tick delay field in SPI_CMD_REG
from 3 bits (bits 24:22) to 7 bits (bits 28:22), so the field width can
no longer be hardcoded in mtk_spi_hw_init().

Add a tick_dly_mask member to struct mtk_spi_compatible and use
field_prep() with the per-SoC mask instead of the open-coded
mask-and-shift, then add a mt7987_compat entry carrying the wider mask
and match it against both "mediatek,mt7987-spi" and
"mediatek,mt7989-spi".

Existing IPM designs keep GENMASK(24, 22) and are functionally
unchanged.

Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
---
v2: remove unused tickdly offset deadcode
v3: 
  - remove spi-ipm-v59 compatible
  - add mt7987 and mt7989 compatible

 drivers/spi/spi-mt65xx.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b845a599f7c6..0603c9f051a8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -4,6 +4,7 @@
  * Author: Leilk Liu <leilk.liu@mediatek.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -78,9 +79,9 @@
 #define SPI_CMD_PAUSE_IE		BIT(17)
 #define SPI_CMD_IPM_NONIDLE_MODE	BIT(19)
 #define SPI_CMD_IPM_SPIM_LOOP		BIT(21)
-#define SPI_CMD_IPM_GET_TICKDLY_OFFSET	22
 
 #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
+#define SPI_CMD_IPM_V59_GET_TICKDLY_MASK	GENMASK(28, 22)
 
 #define PIN_MODE_CFG(x)	((x) / 2)
 
@@ -120,6 +121,7 @@
  * @dma_ext:		DMA address extension supported
  * @no_need_unprepare:	Don't unprepare the SPI clk during runtime
  * @ipm_design:		Adjust/extend registers to support IPM design IP features
+ * @tick_dly_mask:	Tick delay field of SPI_CMD_REG, IPM designs only
  */
 struct mtk_spi_compatible {
 	bool need_pad_sel;
@@ -128,6 +130,7 @@ struct mtk_spi_compatible {
 	bool dma_ext;
 	bool no_need_unprepare;
 	bool ipm_design;
+	u32 tick_dly_mask;
 };
 
 /**
@@ -187,6 +190,14 @@ static const struct mtk_spi_compatible mtk_ipm_compat = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_GET_TICKDLY_MASK,
+};
+
+static const struct mtk_spi_compatible mt7987_compat = {
+	.enhance_timing = true,
+	.dma_ext = true,
+	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_V59_GET_TICKDLY_MASK,
 };
 
 static const struct mtk_spi_compatible mt6765_compat = {
@@ -226,6 +237,7 @@ static const struct mtk_spi_compatible mt6991_compat = {
 	.enhance_timing = true,
 	.dma_ext = true,
 	.ipm_design = true,
+	.tick_dly_mask = SPI_CMD_IPM_GET_TICKDLY_MASK,
 };
 
 /*
@@ -262,6 +274,12 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt7629-spi",
 		.data = (void *)&mt7622_compat,
 	},
+	{ .compatible = "mediatek,mt7987-spi",
+		.data = (void *)&mt7987_compat,
+	},
+	{ .compatible = "mediatek,mt7989-spi",
+		.data = (void *)&mt7987_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
@@ -366,7 +384,7 @@ static int mtk_spi_hw_init(struct spi_controller *host,
 			   struct spi_device *spi)
 {
 	u16 cpha, cpol;
-	u32 reg_val;
+	u32 reg_val, mask;
 	struct mtk_chip_config *chip_config = spi->controller_data;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 
@@ -443,10 +461,10 @@ static int mtk_spi_hw_init(struct spi_controller *host,
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

