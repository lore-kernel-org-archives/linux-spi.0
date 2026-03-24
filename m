Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF43AF65A;
	Tue, 24 Mar 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333729; cv=none; b=WP2wuZqSRq090LDRnBHdrVpe3iTuqnli7a1oIMrEMDYUEr/qpHV8uuaPP4keHsYUul1z25bWsuV8OcGFcTwX4wzthKvnBaGf/SAyxAgn1tMUNfTZZjb5WrDIa33VXau5/K12pJ6gBHVi433mqX70ASPPoqUpdUbP47vWBUY73JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333729; c=relaxed/simple;
	bh=RgazcpxgNV6UefChTRA7FT3xj6F0R4EVVWYK5UXURoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9T/3gyXqdZNIwueB7oMnjNORnloJ0cjFRgLZVGGqAcOUVhlOkqINPdUH0Ll1WQDNjvtFNvRWYnbjfAaZG4RN+RT29T8cH3WX22xA06qxuV9MCXnC/aXUbZFHo49+LQ3mdpEbWfttmf9G7UjI20ioWkTs1nZvNkI4a7vrjUjRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VJoRA5SA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VJoRA5SA"
X-UUID: b4a5f258274a11f1a02d4725871ece0b-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AxNLCKQ9ddz7+TDTiXJxhPHv6/rZ1vPdRVALXT4wAJk=;
	b=VJoRA5SAQC/WFddEmFnRNz9SWxjMQ8ws9we4PGW8YEM0O36QWwIRamgE94P5XGqNjcPQn2ZrdLJIRy3aePdw9dIANQ6EL7dnRHYWMjY7wqBRWSb2gWbhAl5ma9eXnd2qcLVyASI1WtMTdbRKvjmjXP5y8ULS0OME9CYfFRhVxbk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b836b383-2b7c-4929-af71-e7014760d2c9,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:81b8a08e-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4a5f258274a11f1a02d4725871ece0b-20260324
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1897028666; Tue, 24 Mar 2026 14:28:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 14:28:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 14:28:42 +0800
From: Meiker Gao <ot_meiker.gao@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Bayi Cheng <bayi.cheng@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Meiker Gao <ot_meiker.gao@mediatek.com>
Subject: [PATCH 2/2] [v3] spi: spi-mtk-nor: Modify and optimization the SNFC.
Date: Tue, 24 Mar 2026 14:28:25 +0800
Message-ID: <20260324062835.1747943-3-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260324062835.1747943-1-ot_meiker.gao@mediatek.com>
References: <20260324062835.1747943-1-ot_meiker.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Changes in v3:
    -this patch is a further optimization for version v2.

Changes in v2:
    -Use clk_bulk_xxx related functions to enable/disable clocks.

Changes in v1:
    -Add new function mtk_nor_parse_clk() to parse nor clock parameters.

Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
Change-Id: Ifa13f9f08aebf6feb376ca98b0fd69f379037ff3
---
 drivers/spi/spi-mtk-nor.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 702339a6c817..6d24932053e5 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -100,7 +100,6 @@
 
 #define CLK_TO_US(sp, clkcnt)		DIV_ROUND_UP(clkcnt, sp->spi_freq / 1000000)
 
-#define MAX_CLOCK_CNT		6
 
 struct mtk_nor_caps {
 	u8 dma_bits;
@@ -119,8 +118,8 @@ struct mtk_nor {
 	void __iomem *base;
 	u8 *buffer;
 	dma_addr_t buffer_dma;
-	struct clk_bulk_data clocks[MAX_CLOCK_CNT];
-	int clock_cnt;
+	struct clk_bulk_data *clocks;
+	u8 clock_cnt;
 	unsigned int spi_freq;
 	bool wbuf_en;
 	bool has_irq;
@@ -733,19 +732,16 @@ static int mtk_nor_enable_clk(struct mtk_nor *sp)
 static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
 {
 	struct device_node *np = dev->of_node;
-	int ret;
 	const char *name;
-	int cnt,i;
+	int cnt,i,ret;
 
 	cnt = of_property_count_strings(np, "clock-names");
 	if (!cnt || (cnt == -EINVAL)) {
 		dev_err(dev, "Unable to find clocks\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	} else if (cnt < 0) {
 		dev_err(dev, "Count clock strings failed, err %d\n", cnt);
-		ret = cnt;
-		goto out;
+		return cnt;
 	}
 
 	sp->clock_cnt = cnt;
@@ -760,9 +756,10 @@ static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
 	}
 
 	ret = devm_clk_bulk_get(dev, sp->clock_cnt, sp->clocks);
+	if (ret)
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 static void mtk_nor_init(struct mtk_nor *sp)
-- 
2.45.2

