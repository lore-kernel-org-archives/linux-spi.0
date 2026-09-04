Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2C37F73A;
	Fri,  4 Sep 2026 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491641; cv=none; b=Fs4Rq0bBsq9WQFuDt1rM9Y4wxYjM2p0i5WQdxBu+J/wBgqCxf+dIbrGvWm2lTz7UKb9R4YWO66pootVGI9C7PuOC6OAanyfmBlTgidnSWqrDNjlVvPhMw+0V/ZiVvQNYBaonndaQn1j65gCfzBjroL4c6/IUv7U5ii4Tw1pGVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491641; c=relaxed/simple;
	bh=vbCzgFDrDA92CVVj/xQMQsYqUkMR6a6sGFb4Tgs9kRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1Sn7oUy/lNQTjRzXhoPQqYhqSo8n+um1JAZp8bNFNQjLeTUyIyOVaKBgZiDa5JS4jOGTNu6NNxo4C5PJRSlg/lsvbX7l3uvp4Frnjy5BN0mS8wefzJ0kXNuKfMhA9ZN/+6nFjVhXIBXB6yJiL5sFyab++HcrJE7p5xnxoS1Qhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=StYNBLrt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="StYNBLrt"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6843CrAjA4114201, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788491573; bh=RzoDT/PRwDCtqMjDceenSWphVxRlBV2GwUms0t3AvAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=StYNBLrtcVS4gHkELc+RWNnqWj+mJ6xkstXljvlgZhLtyLUr2awySuZJdtAjPXU4t
	 Z2tp+tgjI3s/Lzw5GEgSL1+4n7sWUbzc5VYapTyeVTDuqCJuJX9JrHzXjMaT3ZrKEa
	 CVvgggKUEtQulq3gymSrgpAYNmOKpr4My+K5m3INANFCvbMDrZ8r1d6X/9dJAq2M2H
	 6+OeDI7vCN84eIW8td8qeGWJiEatUxkOGtoXwZsIcMSKYJOgmHSm+mMyYQPFWkO81c
	 Sz9g2MVt+G6oGl/Oxu5wVexctFd2RTwyD+wkw2wUYmBDFlto6w2nD8r/Msaau0e3KF
	 YOWy/6gy06hCQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6843CrAjA4114201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 11:12:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:52 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Fri, 4 Sep 2026 11:12:52 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <afaerber@suse.com>
CC: <bartosz.golaszewski@oss.qualcomm.com>, <james.tai@realtek.com>,
	<cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>, <jyanchou@realtek.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-realtek-soc@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: spi: Add Realtek RTD1625 SPI support
Date: Fri, 4 Sep 2026 11:12:50 +0800
Message-ID: <20260904031252.244280-2-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260904031252.244280-1-eleanor.lin@realtek.com>
References: <20260904031252.244280-1-eleanor.lin@realtek.com>
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
---
 .../bindings/spi/realtek,rtd1625-nor.yaml     | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
new file mode 100644
index 000000000000..2685ca3f851c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
@@ -0,0 +1,68 @@
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
+    #include <dt-bindings/clock/realtek,rtd1625-clk.h>
+    #include <dt-bindings/reset/realtek,rtd1625.h>
+
+    spi@14b000 {
+      compatible = "realtek,rtd1625-nor";
+      reg = <0x14b000 0x50>, <0x14bf00 0x30>, <0x88100000 0x2000000>;
+      reg-names = "ctrl", "dma", "dirmap";
+      clocks = <&cc RTD1625_CRT_CLK_EN_MD>;
+      resets = <&cc RTD1625_CRT_RSTN_MD>;
+      pinctrl-0 = <&spi_pins>;
+      pinctrl-names = "default";
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
-- 
2.43.0

