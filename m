Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAA30C62D;
	Thu,  5 Mar 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694963; cv=none; b=b7wEg5QtGOsKsiw/9Jzle/jIZurYvURp/xdxEI3qYaoSjoIdYh1PpDDQp2s1IWOfuODvDQeGDu4cF2S8rSWN/Hww9g3mBTTokhF+gGaAB/hJO5SNKTT/TmTBXqD1f2F0B3gdBOcVMngoWZfq+xDYAukA7+536YyM0V6JaqvT+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694963; c=relaxed/simple;
	bh=fYhKUJF3oaLR4akuniouuHVW8lVuDqzwj0GKB6Gbtak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBuEmXO6YrAwFcZyrgYFtqpEoeQNcJQRZNK9zDxMAFKvVbMLi4oUko3QcMM8WEaJj9qGr+rrrEMjCKspfghB5wDYd8YCmzlTMxG8I0g3kjhIoegU7eOUXWJyl2v5zkjhYnCsRotnyzA70QZP6q2AMtsV/KK7MkUtYJctsohTMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OyCZjFKe; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OyCZjFKe"
X-UUID: 27e2ef1a186311f1bcd7499a721e883d-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hwgqbmMSY3cSHc4GhC0gL/PpPTLaj95cN2wGFjzRcWI=;
	b=OyCZjFKeBhT/nNH7LIWcilCg5loHiWpyweuJkc2HPaZpQ/+4pCnZ5BPhTxbOmws2YyniFU2XDX+eJ7x0brFx7lGSZKiYbyV8t+exfNvTAzyM0YNGS2E4UjWnjB+TZXL7tWqPZO8jEp1XE+I7ngHkJs37sAnvgTlqXFq62Yhw/4w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ea6cafec-8f25-4ff3-90ac-27c5058f4db8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:ba18e35b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 27e2ef1a186311f1bcd7499a721e883d-20260305
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 977209944; Thu, 05 Mar 2026 15:15:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 15:15:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 15:15:55 +0800
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
Date: Thu, 5 Mar 2026 15:15:42 +0800
Message-ID: <20260305071546.2603378-1-ot_meiker.gao@mediatek.com>
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
(cherry picked from commit c3180d35e52b5213764a89403e71f9a34d7bb842)
---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 69 ++++++++++++++++---
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index a453996c13f2..587f77d3f8d1 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -17,9 +17,6 @@ description: |
   for devices other than SPI NOR flash due to limited transfer
   capability of this controller.
 
-allOf:
-  - $ref: /schemas/spi/spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -39,6 +36,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8188-nor
+              - mediatek,mt8189-nor
           - const: mediatek,mt8186-nor
 
   reg:
@@ -56,14 +54,8 @@ properties:
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
+      - description: clock used for controller axi_f, axi_h, and
+                     axi_p to support the new platform.
 
 required:
   - compatible
@@ -71,6 +63,37 @@ required:
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
+        clock-names:
+          minItems: 5
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
+        clock-names:
+          items:
+            - const: spi
+            - const: sf
+            - const: axi
+            - const: axi_s
+
 unevaluatedProperties: false
 
 examples:
@@ -97,3 +120,27 @@ examples:
         };
       };
     };
+
+  - |
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

