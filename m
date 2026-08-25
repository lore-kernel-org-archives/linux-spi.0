Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C23515C9
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675008; cv=none; b=R7cgJc0iCXOyDrlkqMxWr5ZSxxoG9c5N+e1VocwsWfA3fnQfiUFFbAudJ8Lo0DYHRi89Ilh41zcR/R/nHSmELiVvv6tE2K0uXabSBEuVrJYzxqe0vK+9lIMbBfBT8SfKA7LJMgP8woEFvxf3Jr/SSP6ouhC8pyVTRSDCvUWz9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675008; c=relaxed/simple;
	bh=ysoHY3SLi8Xlfwy2rIEXN2Q/taJhPUpIC77tj83FcYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7mUO94zK3BWi90nD4o7XxfHx5jHeWOu36G6UqC+Ce0iHwyCrH7V3gjbh/KMd7hY8fIGJQICJkex4Nph31P44IEygjIUjw2jWF4qsEfYLLo9a0q6sql9o5/q1eT1IJ1o21Fz3fEYh8Zffyrfj4iVB37WGCquaJXhysJljmpgnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJkxLZ5e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJkxLZ5e"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d560775ca2so467235ad.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675007; x=1788279807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WQ9kthHmMpag/c69Wm9Q+6Otvy5A1GAgbAGrjlGGoE=;
        b=ZJkxLZ5eGpqqdoOsh5D2mHWmP1B75jx5A0wtOtjJFzzwiCBxe4pl7PPGTA+K2K4XCJ
         cdgVOWcMvV5Fn3fQJUW/TboBcsvYn4Im86Hpbq6cXvUr7sYrXLAP6GvuhD6UbtBu4NDh
         GEPZcwuaEhiNcF91mhgus6kOJ8yd9vbKWnDmbHR9edTXLeQQwUkc3AV9Bxn/XwjSlusz
         P52YSWNaE3uyAJE2wc3komRBuPQBidpYiWmWDYrCn3HSBohV5VXSbhm/7DKyk28o6U44
         IdH5Hyo3HYPNaxYmx3EocNnVXhQ5ilbNhrUgIaR8w1hjM1BjkSkpnbdTdvnviU44r2+t
         xkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675007; x=1788279807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WQ9kthHmMpag/c69Wm9Q+6Otvy5A1GAgbAGrjlGGoE=;
        b=Y+2qJ/f+qt65bEjgCs6A8xI6ortmTosr6OAg3j7BB3Ij63JDLjQj+vbU/VkNtkNl+g
         P1R79iRNJMJbQ8PvuYY++msMM9pcHvhTfasUpDWpqcEUtLJMy/Qq910T+Ra/ET5mmcyz
         5F8xayevhUix5NdAVzMOka9ciEdEzTe6egktSVmXJQJhngirCXAjxmOdQkFJzVxzBs+A
         dYxPGiRnnduRyfXdcp3IyNLsEjiVUucxl62YOJmuACKqZn0Q9OENirDXb4cqIHpgP1o+
         VjlNwPPwaIEfkJSmM6trM9pkfKaQY28fURiwbJzdoZ0sqCum0rjG09KtBsBYynYCHsk2
         gvRg==
X-Forwarded-Encrypted: i=1; AHgh+RrDP2dC+gdipJEeK/f8vGmJ/I66QiVvmz3gdlDoQoOfm1cBSssrpruBq2ZMd+HPN6WH+zrnqYDECkU=@vger.kernel.org
X-Gm-Message-State: AFuF++l3ONG5NyIxLd//OwpaELbBH8K2+uxdkA4CP7fkV4p0rA3QjUYP
	qfCNxryGxO04AXMNnzWBtYb3nYOnz9IZFvR7nFGoh4bJ216avcu2ckaK
X-Gm-Gg: AR+sD13Tf1PrUh/VKaqIMLdLtauzfDBeIfj/js+h66+jifHocqWtUSoiWbrw+PActii
	n5RPERyRkZzC2lDL5FgMtjhSebogpiZZQV/xOhrNNbSCkggKeUFEWZ2AFXW61lwSYgxD1R8fqKH
	oJrzRUCCFR/uq0o3C3ENiDefgAntyz5KjKwfQy54KQO6eaBUP5ulvPJWkG48rbgJmjHBJKq0Iky
	fpa/oSrOPGgB8mUxrKrnDbXEG5KUNySVHQCSdxRAWqoPrsWnRUcCzIwm/qBHpAkrwIyJkvHh2TF
	3I1Bdtzkp8m7P1DIxheAkM2Gvxjt6r23g5n/7xKIlM++NH2/+f+bxxKec2LTCt7LbJ9qH9o87bY
	gRV33VPNN0sUhlA0erT3+hqZ+Y8kw4PqsJuQW4opKKR3KA4L3gZtcUfvHfTtEFcKrYYViLkNoJZ
	uI3MYznaAqyzZZs06yrDCLZbsjCeKYU2xfEgiIYo30CEZf2SgCP/JjCqeTwXZz+8yJ3tovOSmEe
	+mr9w==
X-Received: by 2002:a17:903:b85:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2d6ccc5a4dbmr260612805ad.4.1787675006324;
        Tue, 25 Aug 2026 09:23:26 -0700 (PDT)
Received: from inhnjlux1020.ls.ege.ds ([2406:b400:53:dfb:c17a:6cf8:3d2c:cd28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704c11ac2sm540925ad.68.2026.08.25.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:23:24 -0700 (PDT)
From: Udaya Kiran Challa <challauday369@gmail.com>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema
Date: Tue, 25 Aug 2026 21:52:57 +0530
Message-Id: <20260825162257.77042-1-challauday369@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Microchip PIC32 SPI controller devicetree binding
from legacy text format to DT schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
---
Changelog:
Changes since v4:
- Update the binding maintainer to Thomas Bogendoerfer

Link to v4: https://lore.kernel.org/all/20260814083221.34606-1-challauday369@gmail.com/

Changes since v3:
- Change maintainer to SPI subsystem maintainer

Link to v3: https://lore.kernel.org/all/20260617101009.148851-1-challauday369@gmail.com/

Changes since v2:
- Add cs-gpios to required property

Link to v2: https://lore.kernel.org/all/20260615115311.515404-1-challauday369@gmail.com/

Changes since v1:
- Rename schema file to microchip,pic32mzda-spi.yaml
- Update subject prefix to match SPI DT binding conventions

Link to v1: https://lore.kernel.org/all/20260614175005.435826-1-challauday369@gmail.com/
---
 .../bindings/spi/microchip,pic32mzda-spi.yaml | 82 +++++++++++++++++++
 .../bindings/spi/microchip,spi-pic32.txt      | 34 --------
 2 files changed, 82 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml
new file mode 100644
index 000000000000..4669b521fa1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/microchip,pic32mzda-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32MZDA SPI Controller
+
+maintainers:
+  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,pic32mzda-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Fault interrupt
+      - description: Receive interrupt
+      - description: Transmit interrupt
+
+  interrupt-names:
+    items:
+      - const: fault
+      - const: rx
+      - const: tx
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mck0
+
+  cs-gpios:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: RX DMA channel
+      - description: TX DMA channel
+
+  dma-names:
+    items:
+      - const: spi-rx
+      - const: spi-tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - cs-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi@1f821000 {
+        compatible = "microchip,pic32mzda-spi";
+        reg = <0x1f821000 0x200>;
+        interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
+                     <110 IRQ_TYPE_LEVEL_HIGH>,
+                     <111 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fault", "rx", "tx";
+        clocks = <&PBCLK2>;
+        clock-names = "mck0";
+        cs-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+        dmas = <&dma 134>, <&dma 135>;
+        dma-names = "spi-rx", "spi-tx";
+    };
diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
deleted file mode 100644
index 79de379f4dc0..000000000000
--- a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Microchip PIC32 SPI Master controller
-
-Required properties:
-- compatible: Should be "microchip,pic32mzda-spi".
-- reg: Address and length of register space for the device.
-- interrupts: Should contain all three spi interrupts in sequence
-              of <fault-irq>, <receive-irq>, <transmit-irq>.
-- interrupt-names: Should be "fault", "rx", "tx" in order.
-- clocks: Phandle of the clock generating SPI clock on the bus.
-- clock-names: Should be "mck0".
-- cs-gpios: Specifies the gpio pins to be used for chipselects.
-            See: Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-- dmas: Two or more DMA channel specifiers following the convention outlined
-        in Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: Names for the dma channels. There must be at least one channel
-             named "spi-tx" for transmit and named "spi-rx" for receive.
-
-Example:
-
-spi1: spi@1f821000 {
-        compatible = "microchip,pic32mzda-spi";
-        reg = <0x1f821000 0x200>;
-        interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
-                     <110 IRQ_TYPE_LEVEL_HIGH>,
-                     <111 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-names = "fault", "rx", "tx";
-        clocks = <&PBCLK2>;
-        clock-names = "mck0";
-        cs-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
-        dmas = <&dma 134>, <&dma 135>;
-        dma-names = "spi-rx", "spi-tx";
-};
-- 
2.34.1

