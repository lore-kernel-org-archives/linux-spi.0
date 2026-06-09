Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5A492526
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023178; cv=none; b=ECbRMQZ4V1c/DV0r0SP/Tzj4BWJAChzs1WCE+5gj6/72myt1LdAzThLnyudhekJh4wV9hPKO3FZoPn5r6jhOD204khChoglM26UOiayuxcowskD50TzdocoDDivlZxoNu/+2cQzrzmr5G9gDSiJcBZybL1FL5HwdJnlsbBr2svg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023178; c=relaxed/simple;
	bh=XQ+Osd1eVbWSATKTXF5HURL8oAvXOjxSQQHOr3GpyMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O17dlgi9YA05cefY7HYSOzPaq3OZvnO2VEB+46ClhWarObHtuQqvkVNH6iyvMXTw6DpbYeOYROMruh0R/ruvjX1JU1NgV6Q81f7lR/GcCwigxE85BtWqxGdKxkbZdtP6FymOFjI9V1rssiLu4EArNwpNKqjThWDzhUwgytPumMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQbBzC9R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQbBzC9R"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so39325585e9.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023175; x=1781627975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GareA3ERBAa/OnomNTiqG902TF5L3PgbbtUZ1LHV6tA=;
        b=MQbBzC9RjkJs99o5ViC2pdQ2UW+hbTkPEtna1lVv5wcV4xz4jdLJ4hnnltwGAgdYl/
         fLrCKPQddUE7T/JiUP/nd80XmNb0F9zJQJo6JViSPv6KQP+Wur3c6XKesYNTB6T5cpg2
         um9jAkkzuQ/iAh9fQ5tXGsJmi2dqn8ZV7al2wr2bPAYDePy+63IQ2qH9LV9OIj611og9
         17m/oJS2ADxu5nNXsgQN+b4G6nEjppDvB6xmU8grrzU6SrMduS8b3nlsfO/HOmHS086f
         2DcdQSRKIYtObakwhjCNLkN8ye8qvE9yoZRL+YdwLPRK6KlZ1H6kS5iC08G3IlM4kxYi
         3e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023175; x=1781627975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GareA3ERBAa/OnomNTiqG902TF5L3PgbbtUZ1LHV6tA=;
        b=rriIL3Js/lXEK4C5NcJnM9Jtez7NfQhZVoZxW2vG+FsXU1ysPFKSsP0NjMOVhe6h3i
         Um7FEN/lB8qR4NWOXU2x3bxeLpdkmcFoAfXEQz7IC1yrBRDVNk+GEN3lUePYS2JmR3WU
         QT2E1mo7aPVnIL5aJR4MdFhWOa3PXRbCwfc5pvrxKdijBCHw17tSJ8wnQKKQFG5a9JFw
         rTH/hvteSbDDticP8AhrbXl3GWvc9kzXfYFVzR1+JTXzclxm9K1gj/9XtBIsvIxPgVyA
         K2GW5iiiBIHHVOmlxyVUkp3Ii1G/LjJfMS3ACz+yKvGorGNlQhb0GaPcdXDal8kh7bdD
         YcRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rGbJmOE2KjA/Y4zoxT1tw3RWO2kGRe8KZzMxTc3ngMewR6ls6REcI+Zp6QmftYlI09qO5b+ZyhUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLc9N2SoJznv1vHZbBI+OAZXfFI5v655rD5Jp85YcOg+4wzLS4
	jW16qzbAO5Z+oeTd1OojCSxuRkjX4GENVxEWC+L8qUEylt8u4CFl5g/8
X-Gm-Gg: Acq92OHJiGz3Kx1brRUjMN4mTkv0PA6RDlBSmsPrALpHwzgQ3xxa4AUfXcJVW8VWSSq
	PRDu/a360VrZ03tzJQfV/YINs8vVzHKaVsuQtwGaDV1NkmBfEUSPfUTjUG22wnLC4DmDU7EGRMQ
	4SKvwzVIYDU42baaksDAPzz972KPr67fpFIVptpSjRA+xamQT6m6/sN3XEY8UoHDBAmbh5zdYNv
	ybnNvln1avV1252BpoNM1JjOGLTcuEUIaYUnJNAXlfcDJ5H3D22VA7TJR+Fjd+vu3aioYLlucB1
	R83A0lRRBSL1ZI6DBEEYlFskeziNKclhgbCUaR1I4wHwfDfL0+9gvlH/kartBnFZ3Gp4pUTZFBg
	HlOq5hbo5rSbl+NnHnHmoRfCr74uvMZplEAJCza2cyCDfA93RTnTEUf85r2u++WdK2wM0TdJMSz
	Heh+2kZsGgxf5QIBQPygAXhs/WpsYsZj3Nf5Mpwjccb3HE
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id 5b1f17b1804b1-490c2508a5emr376584805e9.0.1781023175374;
        Tue, 09 Jun 2026 09:39:35 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm440860805e9.1.2026.06.09.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:39:34 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Subject: [PATCH v4 3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema
Date: Tue,  9 Jun 2026 19:39:19 +0300
Message-Id: <20260609163919.3321228-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163919.3321228-1-tmaimon77@gmail.com>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Nuvoton NPCM FIU binding to DT schema format.

Document the required control registers and the optional direct-
mapped flash window separately, matching the driver behavior
when the direct mapping is not described.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 ------------
 .../bindings/spi/nuvoton,npcm750-fiu.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
deleted file mode 100644
index fb38e96d395f..000000000000
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Nuvoton FLASH Interface Unit (FIU) SPI Controller
-
-NPCM FIU supports single, dual and quad communication interface.
-
-The NPCM7XX supports three FIU modules,
-FIU0 and FIUx supports two chip selects,
-FIU3 support four chip select.
-
-The NPCM8XX supports four FIU modules,
-FIU0 and FIUx supports two chip selects,
-FIU1 and FIU3 supports four chip selects.
-
-Required properties:
-  - compatible : "nuvoton,npcm750-fiu" for Poleg NPCM7XX BMC
-			     "nuvoton,npcm845-fiu" for Arbel NPCM8XX BMC
-  - #address-cells : should be 1.
-  - #size-cells : should be 0.
-  - reg : the first contains the register location and length,
-          the second contains the memory mapping address and length
-  - reg-names: Should contain the reg names "control" and "memory"
-  - clocks : phandle of FIU reference clock.
-
-Required properties in case the pins can be muxed:
-  - pinctrl-names : a pinctrl state named "default" must be defined.
-  - pinctrl-0 : phandle referencing pin configuration of the device.
-
-Optional property:
-  - nuvoton,spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.
-
-Aliases:
-- All the FIU controller nodes should be represented in the aliases node using
-  the following format 'fiu{n}' where n is a unique number for the alias.
-  In the NPCM7XX BMC:
-  		fiu0 represent fiu 0 controller
-  		fiu1 represent fiu 3 controller
-  		fiu2 represent fiu x controller
-
-  In the NPCM8XX BMC:
-  		fiu0 represent fiu 0 controller
-  		fiu1 represent fiu 1 controller
-  		fiu2 represent fiu 3 controller
-  		fiu3 represent fiu x controller
-
-Example:
-fiu3: spi@c00000000 {
-	compatible = "nuvoton,npcm750-fiu";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
-	reg-names = "control", "memory";
-	clocks = <&clk NPCM7XX_CLK_AHB>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi3_pins>;
-	flash@0 {
-			...
-	};
-};
-
diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml
new file mode 100644
index 000000000000..965904a98785
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,npcm750-fiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Flash Interface Unit (FIU) SPI Controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+description: |
+  NPCM FIU supports single, dual and quad communication interface.
+
+  The NPCM7XX supports three FIU modules:
+    FIU0 and FIUx support two chip selects
+    FIU3 supports four chip selects.
+
+  The NPCM8XX supports four FIU modules:
+    FIU0 and FIUx support two chip selects
+    FIU1 and FIU3 support four chip selects.
+
+  The FIU control register block is always required. The direct-mapped
+  flash window is optional because the controller can still access flash
+  through the UMA path when that mapping is not described.
+
+  Alias convention:
+    The '/aliases' node should define:
+      For NPCM7xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux;
+      For NPCM8xx:  fiu0=&fiu0; fiu1=&fiu3; fiu2=&fiux; fiu3=&fiu1;
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-fiu # Poleg NPCM7XX
+      - nuvoton,npcm845-fiu # Arbel NPCM8XX
+
+  reg:
+    description:
+      The first resource is the FIU control register block. An optional second
+      resource describes the direct-mapped flash window used for direct
+      read/write accesses.
+    minItems: 1
+    items:
+      - description: FIU control registers
+      - description: Memory-mapped flash contents
+
+  reg-names:
+    description:
+      Resource names for the control registers and optional direct-mapped
+      flash window.
+    minItems: 1
+    items:
+      - const: control
+      - const: memory
+
+  clocks:
+    maxItems: 1
+    description: FIU reference clock.
+
+  nuvoton,spix-mode:
+    type: boolean
+    description: Enable SPIX mode for an expansion bus to an ASIC or CPLD.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
+    spi@fb000000 {
+        compatible = "nuvoton,npcm750-fiu";
+        reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+        reg-names = "control", "memory";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&clk NPCM7XX_CLK_SPI0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+        };
+    };
-- 
2.34.1

