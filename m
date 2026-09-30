Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A454582D3;
	Wed, 30 Sep 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751634; cv=none; b=cFoe17lTXx56gTvZMGIpHERyN/mSfZwi8P02yTAQ3DWalhywpWaw9PWdmXUoOE9jDHkHngEv3eXR8B56ZSvmxmfNmXnkukbb8VChEP/fiwCqHXqScig/vmwkeWbtjWZZ1qaENCe4U6lo0STs9hh6Ze/jKg6Nzvi8pKhVDwbTeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751634; c=relaxed/simple;
	bh=KComuNXu70cXTm4t3jYVgcf1DyHtHuy5wxQiLi/Demc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loVA+HMgoagESMsHkoMeAKK7ieCSfbkNYLg5basflLUdUkDgO+O6bq5ysTOeDGCmLKcMktiln4RxHdpwt8yebhegBJhsstmmFTp4sT/1k8o9SqTfpqawZ6qg6m6scW07TBxW4TyAbfEhxfo4GIGtHwXNdow8uFHhexQCO8Y9NgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SyMntcJS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SyMntcJS"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68U6xkiC71887169, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790751586; bh=9g6JD99rwwHLKY50yk+QMnDmcgfWYtpoLfh2639h7Vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SyMntcJSr4I6HxechgX72bBJrbUyxF1johWqv+4Lh/yxfUwUAbLxYHLVK8OOVw3hE
	 ZfsGUGkbGHHNRJW+xPzGULVgBXYk4qVvNk7QM4DKO2A1OTPI3jfoDPVbgceXyUT1bg
	 87YunnqGo8vROsKyqhwUtIKbxr3TPuyCB3saJmueQZ2Q9U6ZkrVUa/qZVTfVccSfAi
	 iXH3N2TfCDQ7u3eIIhQv5DvL6WxCtAKr1rCILnsinBPuN9WFpPVWddWrx8mge5/p2E
	 ot0L2l7gWTjxxPEHQQtvZvLk5KbB7tFk/3YbNOeZFRoty7I2oKOmJqj6irGkdNsFDH
	 8yX8jbCQ+Zn7Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68U6xkiC71887169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Sep 2026 14:59:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 14:59:46 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 14:59:46 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
Date: Wed, 30 Sep 2026 14:59:44 +0800
Message-ID: <20260930065945.88008-2-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260930065945.88008-1-eleanor.lin@realtek.com>
References: <20260930065945.88008-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jyan Chou <jyanchou@realtek.com>

Add DT binding schema for Realtek RTD1625 SPI NOR Flash Controller

Signed-off-by: Jyan Chou <jyanchou@realtek.com>
Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v5:
- None.
---
 .../bindings/spi/realtek,rtd1625-nor.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
new file mode 100644
index 000000000000..014ddfe0f421
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,rtd1625-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTD1625 SPI NOR Flash Controller
+
+maintainers:
+  - Jyan Chou <jyanchou@realtek.com>
+  - Yu-Chun Lin <eleanor.lin@realtek.com>
+
+properties:
+  compatible:
+    enum:
+      - realtek,rtd1625-nor
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: ctrl
+      - const: dma
+      - const: dirmap
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@14b000 {
+      compatible = "realtek,rtd1625-nor";
+      reg = <0x14b000 0x50>, <0x14bf00 0x30>, <0x88100000 0x2000000>;
+      reg-names = "ctrl", "dma", "dirmap";
+      clocks = <&cc 18>;
+      resets = <&cc 26>;
+      pinctrl-0 = <&spi_pins>;
+      pinctrl-names = "default";
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.43.0

