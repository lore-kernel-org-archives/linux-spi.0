Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727F13FEE;
	Wed, 11 Mar 2026 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193947; cv=none; b=g0A7dDKCCS8OTb9Xx16tEfHvSfg3T5DZhyeJ5+jP1Bf4TImX5OhvtyRVEmRXMgTOVRQbcMsAikDUeInBcuJQZW5JJRbiMwoM3lWB6/Tav+XoLxomXGLYHIcs28J1s7TG52O65YJ0jq/lm9VnOhIRvBNdDgG1Et4HijbCsnmHW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193947; c=relaxed/simple;
	bh=VoKNIIpOJGQ4fPt69EJkKn8trrLgK03vK6b59yBpoj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtGplxJMjcIcIN3sJarYSCo4uSR5cJ6HL7hkWXIFm3vCmc+twTFFpzqbPOUJpixZRnChGlmRyxBOV9/xK0W/a4wBJpNZE+vgNc1FFYKcSeVfbikkQSPG1OLMSlGGYl/H/o2mzU8h8FRPDrGzHXjP6fRgKKtoCMxKGaaUjGRbXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=o07oAuXI; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o07oAuXI"
X-UUID: f13fdf7a1cec11f1a39cd589f645bc18-20260311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CHIhPpxedpxUtfuf19NsO6sYd8OBMqAij6YecxTLJjI=;
	b=o07oAuXIdQ/RGN0jFX41RaSmqeXtcZcxwuBIFEtxmN2oySs8KxcvRtgwf8Cw+Xw/JRhUZryyZREVzqZdPVVdZQ+FDPVfGBpPpCjMmZev2ChGNYOzFzYzbSpMlrB2e93TVabGxWbZJqKUIj6X+fXkTYaQr+1+1yKYAG9BhoD6jQg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:a7696750-a506-4bf8-b3ab-8978092e7795,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:54af7ff1-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f13fdf7a1cec11f1a39cd589f645bc18-20260311
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ot_meiker.gao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 866010244; Wed, 11 Mar 2026 09:52:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 11 Mar 2026 09:52:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 11 Mar 2026 09:52:19 +0800
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
Date: Wed, 11 Mar 2026 09:51:27 +0800
Message-ID: <20260311015214.655555-1-ot_meiker.gao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update mediatek,spi-mtk-nor.yaml to add conditional clock and clock-names
bindings for the mt8189-nor platform. The mt8189-nor controller requires
five specific clocks and corresponding clock-names ("spi", "sf", "axi_f",
"axi_h", "axi_p"). This change enforces these requirements in the device
tree binding schema.

For other platforms, the minimum number of clocks and clock-names remains
unchanged. The patch also adds an example for mt8189-nor, illustrating the
new clock configuration.

This update ensures correct hardware description and validation for
mt8189-nor, improving compatibility and reducing configuration errors.

Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
(cherry picked from commit de637a2fea765a92d4b06efef34671c74f8bc109)
---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 71 +++++++++++++++----
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index a453996c13f2..904c25279e2d 100644
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
@@ -27,6 +24,7 @@ properties:
           - mediatek,mt8173-nor
           - mediatek,mt8186-nor
           - mediatek,mt8192-nor
+          - mediatek,mt8189-nor
       - items:
           - enum:
               - mediatek,mt2701-nor
@@ -39,6 +37,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8188-nor
+              - mediatek,mt8189-nor
           - const: mediatek,mt8186-nor
 
   reg:
@@ -56,14 +55,8 @@ properties:
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
@@ -71,6 +64,35 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8189-nor
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
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
+          maxItems: 4
+        clock-names:
+          items:
+            - const: spi
+            - const: sf
+            - const: axi
+
 unevaluatedProperties: false
 
 examples:
@@ -81,7 +103,7 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
 
-      nor_flash: spi@1100d000 {
+      spi@1100d000 {
         compatible = "mediatek,mt8173-nor";
         reg = <0 0x1100d000 0 0xe0>;
         interrupts = <1>;
@@ -97,3 +119,28 @@ examples:
         };
       };
     };
+
+  - |
+    #include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi@11018000 {
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

