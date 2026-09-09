Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4D5592E7;
	Wed,  9 Sep 2026 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958640; cv=none; b=Olgxf3f6fjHhhBRjsSRYp2vZJML9ySPPtQXncZAVFK/BJbHd9rnSZqARkV2GUPYGL7LkCZHM5rrij4eqjPdISQbdL7NV8W4H0kRVRF8XlltJq7QNFfFdVedA4LGwE73BSHq04vW7ryEEfoz6MzECTIxyq0ER3POsBZ4/M+c9/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958640; c=relaxed/simple;
	bh=pg4Z2aSFmAbUBEghLQTaLGxlX6jySBBp16Cm2/SwMUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4+8UQmwrm8nYPvvRE5vOVQNq7SeiPgDCel4DdGR8FKuWQyu6E3ZQIYqpHeMITn9KIe+I8WWSdcqNLVYk1rd3dUmTotaih2Kz5NC8A5O+aBbdV/p6Iong+0J+cA0m3GTQ2jQrz3JbKY2XYmEpc/lHBEe7GCAJD+HuXJLavo96NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=E7B9bqT/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="E7B9bqT/"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 689Cv2JJ1624292, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788958622; bh=dYT+FrnrCTFCvz3l8ZG/tw+l1LHXjLQmRhnldpmJyb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=E7B9bqT/2BmSqzXqaCPD44FNgzox2mIlYxkFqh5bkUPjoiglAnQ5IG0u2wVx79daQ
	 guuFTUBUvXeE4DnqhFugVwKhZYGLD1FedHcfsF7fTiX8GJcXa/JuXS3u9zarTLolf6
	 Kg1Zh8f5YN/fxSa0Mcsn5SACEoG+BV0/3U3pv8BI0EEFULKHt3Z/v8Iz/FYrj8lJ5u
	 mNY4q29Nny0X4jJNQ6xer49VdAg6+ryTQRit6ytDH/+3YYNbtrIrD/P9WuASDvJr4P
	 MxTR3dkwMkzew/Wmu8+slMwcwvVUfeWGlCwdf4J4pdof/B1Z6cHnN9l7yb0iZWsvQC
	 JHWsLVMamGnOA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 689Cv2JJ1624292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 20:57:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 20:57:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 20:57:02 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 9 Sep 2026 20:57:02 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
Date: Wed, 9 Sep 2026 20:57:00 +0800
Message-ID: <20260909125701.273314-2-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260909125701.273314-1-eleanor.lin@realtek.com>
References: <20260909125701.273314-1-eleanor.lin@realtek.com>
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
Changes since v2:
- Add Conor's acked-by tag.
- Add "NOR" in commit message and binding title.
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

