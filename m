Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CB4963BD
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020497; cv=none; b=pTXNhlsEgUHNJp41OZDIoejE6mqwJFx9rPs1aMVN0WvzSm08M6Dlvij8YFBgQPefA34u4hLLI24mZFT0YmYPjxMbHVdCiP6VxwtTk2VXN6fRIv0WF5cIUstOCl5UNek4pKitwOTzCLrzCio/Ir/K04JASn+TozHNV+oRTOQsxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020497; c=relaxed/simple;
	bh=XQ+Osd1eVbWSATKTXF5HURL8oAvXOjxSQQHOr3GpyMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/FVsT4/O42zxLYmA39tUoCe6MQFtqlD9CFW4JGat0QL9RSoGdmH0LL8//0qRowrkKLt4vR64zyhxz4/X2n0WmJM5fPNAZzUli8JrNZw096DhxzHqNhT8qzbn/iQzSlb3JG5UryVxpc0wGHf+3GD8Le53TDzS19bwjGoLWcHxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQPyTQCh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQPyTQCh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso40779565e9.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020493; x=1781625293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GareA3ERBAa/OnomNTiqG902TF5L3PgbbtUZ1LHV6tA=;
        b=eQPyTQChFja3ZLgSiLVE7NBZ94LK6flUq7xGGb3s8MbxSY+NEX7aVqYHzeMginwLFH
         ZBLiOWot/MI+jUH4JxzDsFmk3PloWHc2y5iAq9IAvaPgbl2f6drVGoG/9gZyukrIJqiz
         8UQUGwipu2O7MZGDpsvb9eO6PyVG1QDuw0OEDyXuJ+kmu4SrW2MMe4fTTWHg5Ho2wg0r
         qeP+ea9gbj/d//HIuAdbdP5KJM0ROv8ebabjDrWR4hZCezwQuWzEP/1aEm8jNhQ6TS0m
         Xe0m643YwCfRkp9gI/nnzytFKN68oG7YrYejR5BVNAc64W6oLOUjtEaOXyLdeHYGQ+tO
         69kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020493; x=1781625293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GareA3ERBAa/OnomNTiqG902TF5L3PgbbtUZ1LHV6tA=;
        b=njkKVo4UqU2ld5/6m2V7NJIynrNdFp0BVapHUCaJB4a1yTjNseFwNrxEiRQDlDCZqX
         M3St8glJ11nn1zkUTaZGdZ5+/TcAw/Ja58ky5fQWeFcMJgM0znzLB7CNufFM3luvjZ6L
         c6avjlC5k76VJjMpbDNedKEna5Ezcr/l7qPL4Hbomgl0OrfUKPNQean2inGrqzCN797J
         E9IpYAKucPH5cAlAa+9kc1jwt1uLOClUsuQdtEoToilM61S2DipaUzi3VcngU9VS8ftG
         uRiFuiV5OZ1X8sTCJSZbtC1IRYx3mzQhUy9MRECP7fmq348TnSq3sJLYe34AVzGKucMb
         X0zw==
X-Forwarded-Encrypted: i=1; AFNElJ/kZhVyFLhuXk/jz6NJPC8Hf9UNXXg5UkX7R6r5iHMKv+KkqyLDym5cf4NEobQ4ro84JGCSia9mGXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VXc5vgOkRyR9yNBrr/8REGGFQCeb6G7WJbEdkmfyBD9qVIzw
	sP/EjnaGMjDZSMiDVpjpmVmBNZWIgc7trm4A2ZfLn/S86RmUUbYJyKhb
X-Gm-Gg: Acq92OHlPSfTzQJjW+OUWHGAikDqAg78mGNf1V5RHv/yR5OEOqyXqXCwd+5092fj9UN
	RKbA1QWGjB2vzUY/vvBSQEtylhuYa5yRK7ZNhCm6ik8277oFXPJwC2mibzrgUgGSeZo6DTxam0f
	eokJa6XdnUrUA+mWI3zpEODt8Fq6g9S6BYTT4Nv6T3xuGX2p5h/U8Cs1ihacC/xXBIGYpjXj8fn
	4C11bUGaIhanHxQi++2YrzXWQEVCD5LF2smD6Dg7c6h4QxKhzOqIiHag1YodNIxOlPRKZuS9HbX
	AxA/WElUNA53aYHaAyNs31eI5JSrHZj/UCn2cEN90S/uvJJ3CaKWKpTGnjrjKyBZQtZfw5puP+7
	0mEA4nuFFHzi2Ia6f7JlI6nnILvhbazRYAVpATXjARcCkhJv/pGiNJxv2Ynkq7C1PXruJg7KOCp
	hB41gnAG4gh4TlrhygHxMlYrwDHBwinKoHSxeFy2oRNjBkYNAjHPUxGQc=
X-Received: by 2002:a05:600c:1d27:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-490c25e10f9mr354300715e9.20.1781020493455;
        Tue, 09 Jun 2026 08:54:53 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm545506645e9.11.2026.06.09.08.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:54:51 -0700 (PDT)
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
Subject: [PATCH v3 2/2] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema
Date: Tue,  9 Jun 2026 18:54:37 +0300
Message-Id: <20260609155437.3285042-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609155437.3285042-1-tmaimon77@gmail.com>
References: <20260609155437.3285042-1-tmaimon77@gmail.com>
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

