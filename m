Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069D23C39A;
	Thu,  5 Mar 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677675; cv=none; b=XF7oii71YX6h49Ivlr/E071GC6bLrRFH+AS8pWfJ4u1yn1ccFPT9pVdfKPyRPnapsWp8N5yOSH0PnM29joq79yG4Y7lWgG/T9k54RlynMzpIT1iEtAFoILuCXfnu1UWXen6viZDrnbggR9Qr4mFj3nCOTro+J5y+6gtNZw09IN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677675; c=relaxed/simple;
	bh=bB/qm/febIFv9BYbGvAijtJ9QC4L5u6lnb/YhDP82c0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lc05g2l3EENtDBla/WT9PVT/GfON8SB98eIpvau5pwSVrcygXp0UdAZVkx/0vLthKufXFVwzxeU05RFgCwSs7/ezGIY2PHftepMvmAjnpzmm1zc0uUfGvaEtwVXngEre7xuaBM/knetq+dkCz8JaFDZpZAYZ0b7d/IAdUxQzFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lldnF3/K; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lldnF3/K"
X-UUID: e5c6ee60183a11f1bcd7499a721e883d-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TYFn8NiRwsMtMSIwOF/N14WcpCF3yUYWccA9YEno2Pk=;
	b=lldnF3/KIoQOBO+6kPgS8BxLDeZN7ltmcLO1RF2EhNUz4yxkbClvWQcg4BDESAgWXH8kYu8atmfK+KtbSitIcfmZp/VrBAbEpSzM7WJ3L0a+XIvJKVc0wYhX+46pGILprly17EyfxVyrr98r8lmQ+Ny2pIHjO4H/J7C+pUJ3tUw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:1ff79f68-2590-4972-b8b4-6e393c07bdbe,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:bed941ea-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e5c6ee60183a11f1bcd7499a721e883d-20260305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1095631818; Thu, 05 Mar 2026 10:27:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 10:27:45 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 10:27:45 +0800
From: Meiker Gao <ot_meiker.gao@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Bayi Cheng
	<bayi.cheng@mediatek.com>, Chuanhong Guo <gch981213@gmail.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<sirius.wang@mediatek.com>, <vince-wl.liu@mediatek.com>,
	<jh.hsu@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>
Subject: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189
Date: Thu, 5 Mar 2026 10:27:36 +0800
Message-ID: <20260305022740.2334033-1-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update mediatek,spi-mtk-nor.yaml to add conditional clock and
clock-names bindings for the mt8189-nor platform. The mt8189-nor
controller requires five specific clocks and corresponding clock-names
("spi", "sf", "axi_f", "axi_h", "axi_p"). This change enforces these
requirements in the device tree binding schema.

For other platforms, the minimum number of clocks and clock-names
remains unchanged. The patch also adds an example for mt8189-nor,
illustrating the new clock configuration.

This update ensures correct hardware description and validation for
mt8189-nor, improving compatibility and reducing configuration errors.

Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>

---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 78 ++++++++++++++++---
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index a453996c13f2..7e551f2cb52c 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -17,8 +17,6 @@ description: |
   for devices other than SPI NOR flash due to limited transfer
   capability of this controller.
 
-allOf:
-  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
@@ -39,6 +37,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8188-nor
+              - mediatek,mt8189-nor
           - const: mediatek,mt8186-nor
 
   reg:
@@ -56,14 +55,12 @@ properties:
                      design, so this is optional.
       - description: clock used for controller axi slave bus.
                      this depends on hardware design, so it is optional.
-
-  clock-names:
-    minItems: 2
-    items:
-      - const: spi
-      - const: sf
-      - const: axi
-      - const: axi_s
+      - description: clock used for controller axi fast bus (axi_f).
+                     Required for new platforms, such as mt8189.
+      - description: clock used for controller axi high-speed bus (axi_h).
+                     Required for new platforms, such as mt8189.
+      - description: clock used for controller axi peripheral bus (axi_p).
+                     Required for new platforms, such as mt8189.
 
 required:
   - compatible
@@ -71,6 +68,42 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8189-nor
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+        clock-names:
+          minItems: 5
+          maxItems: 5
+          items:
+            - const: spi
+            - const: sf
+            - const: axi_f
+            - const: axi_h
+            - const: axi_p
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            - const: spi
+            - const: sf
+            - const: axi
+            - const: axi_s
+
 unevaluatedProperties: false
 
 examples:
@@ -97,3 +130,28 @@ examples:
         };
       };
     };
+
+  - |
+    #include <dt-bindings/clock/mt8189-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      nor_flash: spi@1100d000 {
+        compatible = "mediatek,mt8189-nor";
+        reg = <0 0x1100d000 0 0xe0>;
+        interrupts = <1>;
+        clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>,
+                 <&pericfg CLK_PERAO_SFLASH_F>, <&topckgen CLK_PERAO_SFLASH_H>,
+                 <&pericfg CLK_PERAO_SFLASH_P>;
+        clock-names = "spi", "sf", "axi_f", "axi_h", "axi_p";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+          compatible = "jedec,spi-nor";
+          reg = <0>;
+        };
+      };
+    };
-- 
2.45.2

