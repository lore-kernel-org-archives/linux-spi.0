Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9F4A0149;
	Tue,  8 Sep 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866226; cv=none; b=esaneuBj7uaj5pmn6dyEOq4iUJB1oHj7y5s9nSQFyccpWCXoCC/2cxJ3hb4oANM6hK4Uf7dUae7QjqtdsFany8Y7eElQXuppzj7sea/tdO0cGmLyB1KUPaWN3nQeShiY4AMf4HQQTwyYHFIPjZfga2dPsulGVPNsR61DoAr/H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866226; c=relaxed/simple;
	bh=+ZgcgINZMt5fgN9PW4jZBcvjsV9cpo6ZnTZP9cw43S4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK+ug4NXKMzVm6X2yngOKY6UwPF+9cyKi9hg9V4fqtrZNRSSbk//ll4s1jX88AL51Am6WzfEOcfz/j+0OiJRUQzSqXNzDiXQf6TKn139CM5hquHOPBI730pSOdOJ5iTV3eLD3mPXr1tRB48JE4O18rCuzjM4j5RR+0JIx2YfoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IXXqpYVW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IXXqpYVW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 688BGfaX63868339, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788866201; bh=dK6Bjnh1qhOqIOlSU69clsXh2g8xHnJ7DzatohDDhe4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IXXqpYVWha/UMSWZbMrlKIO+/MibDCNSLGe3YvBezv3P+o5Gn5kmdiYzy7ORhDODU
	 tvmQrSCoO0t4S5pJ4zpnARQPvHMKiHkWmBaPnNav1D/TzSmMvTr7c2QwaeCGIRzx3K
	 AcyW0fKwlo85TL2VfD+wea0jiwAAvDdB9nQsPc0vzJWZ/htBoyl1lmXjlRQN2lPZyb
	 AAsUVLTQf7SoAbRk4jz/F7wpIlZ6k0uKygdkSZR2kWGRcDH7LKxcQJDEKQnnqb/B0S
	 HBcU+WtFxoQaSHEp7SQHu9DTjfqDsJlyvgUDniGccVIL2hyPG89Pfni6P8k9oGUiJb
	 i4AehN49xw88w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 688BGfaX63868339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Sep 2026 19:16:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 19:16:41 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Tue, 8 Sep 2026 19:16:40 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: spi: Add Realtek RTD1625 SPI support
Date: Tue, 8 Sep 2026 19:16:39 +0800
Message-ID: <20260908111640.2032749-2-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260908111640.2032749-1-eleanor.lin@realtek.com>
References: <20260908111640.2032749-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Jyan Chou <jyanchou@realtek.com>

Add DT binding schema for Realtek RTD1625 SPI Flash Controller

Signed-off-by: Jyan Chou <jyanchou@realtek.com>
Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
- Add Conor's acked-by tag.
- Add "NOR" in commit message and binding title.
---
 .../bindings/spi/realtek,rtd1625-nor.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
new file mode 100644
index 000000000000..b967fdac333f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/realtek,rtd1625-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTD1625 SPI Flash Controller
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

