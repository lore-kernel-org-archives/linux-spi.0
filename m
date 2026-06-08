Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3E3B71DB
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941286; cv=none; b=XvhT3MOPYX9Imagf+MKDrxJ9lpkCGfx6xWfaSAdFn0LSVc7ZQvPjDaFFWGg458iBlftNnVaLHd3PJAdhI0HEWx2YH/bElxz6AvdI8fOsPfzuoeWqKAD8ZqQFCGxX3KDakHjh5IIfZ18iSsczrvD/pIG5vRRj61ML6SMM1REzzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941286; c=relaxed/simple;
	bh=XayICwFkwW/+7qGqZ2kcYZqH/kP1XVeb1pbxcTbir+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/Lq9gU9wZPqFwzLaIXDtyxs1vk4+/0zOQmFh0rK2+0Mi5jCUJg9VhIF8d+ekOgosDs2b6XyCUaXIgCTvMd9wFaNK73XRDLXS2r7lbimECB+OrrtVj6srhDPd1qkk+eYMyjpMx2jihx7AyBlijkkAfEgW41X+joNf38bvl83PTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq9N/DYU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq9N/DYU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2147561f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941282; x=1781546082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQnDKAgbConHDQBUycm84vQeAcwqNLay1jFwOQCu2Sg=;
        b=fq9N/DYUWBbkV6ARncoyoN/WZ7SdHEYBN/Xyd7BxNCkJK+kUgxYxL553dsQpW8qaTE
         ZjF8x9qqIrp/IcUmbff6/zBaBZ2YGa0JJVj4kYIABVqRW6kkTD+lN3dq9DUcLtrhVrq4
         Sk7cd92fqutwYNiJzhha2t1s8bR2HJRevMlHiws8tP+toEkFSmIFlJPW7HqpdouVKAHO
         r5++xZLiPR89wRaSUheICbK5Kh9qDlKQeRcT1RGl9FiTBVBfC57sEyC08FZvtYwPp2r4
         6j5TJbCRN0cPKVN9Wor12woOw9gjhtaZzH9D93DW3V1QomtXOW1KDSAgjFL8ifpU0hUe
         bZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941282; x=1781546082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQnDKAgbConHDQBUycm84vQeAcwqNLay1jFwOQCu2Sg=;
        b=dVt0uGfrAx5vxv7N0Hal/C+4imZv7jJGgu/bQu1Q924IK1FiIg1E5many0ZEdlIdq1
         oOqckKqJxwTrfk+Jtdxqx1H2z4b8qQaCk0A/w3FDDl19KbgKW5uLPkwmjVzTYnzO9qm4
         vCq2dR4KKbnibRkgJeGBKhiLwCjabnJgfoNQtw+6MnFhuHjQ8LwoCYd/91p/oUArKmDK
         zT6vhcIk/SUI6AH3CC1WsaJmFMrILPTMphOhIy7jdtR7FWlm2KGyDjJGTPUBTYmDM8bo
         U2ynZBjKiAOvEmpFihGw8OITmZpHFKE+4OeiqWPAIr9M8Hf5W/zlEcfgyyD6bqctmFCi
         NIhg==
X-Forwarded-Encrypted: i=1; AFNElJ/zQ+CpZnVf/Bz17yb55Rah+ot9CPB9vWjjJDp8VgYOObnnsH/U6d1ymn6xDcfAQqFZ34KMpSfRk+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88c7UWtF9RULNvx/A1Tw0hpGNJaoAVUR/TYuV8VveLFJj10sm
	oswKG7seggluz9AtBBvOADGnVd7PTGbzVZV80luvimXx1jrOOG0eSW4l
X-Gm-Gg: Acq92OEFdisqIEk4CJNB92hq6r4iNe32EuAgQRePfDmh/HAZoGhPf4sdi6SK9BGsdDI
	11X5/NzTIxvDUcNODcCBwRWh4n25+D47oY6U5J3cCSVPkMElBSEw1TWUO1TXrpmAdIill1HZIY5
	pHQmbSN7M7zw5QuzT3zgKHaAAQZWnbeJuF3yrI6ckfrZLZiqVV79JcgydlUkGZECTZwtvoTqZ/d
	DHuNmCuyev+iPiVdtRERuiCy8JiNccaqAZRMGPrMoN/mwIXyji4APKKl822v/qfz6v4DBTDeEmO
	u68c5UZkzmXgIcT3JUCoiS+jANy9+VaQB6PaxDd9CdgLteeclYcBNc9uoYJfYx7LHnsmr0FN9tl
	mz6RieVlVlYcI1r1s/usujcXP/vPab1P79JDKikw6LfjvNe/gFPj5oCrBBXTWX5fF5YByyLIHOQ
	oruTKJAZ2NrTF5C6kcO0QSrJokFWN/NpygYjLorY9IIAMot0dvDo41Rok=
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr16901396f8f.34.1780941282010;
        Mon, 08 Jun 2026 10:54:42 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm56269275f8f.28.2026.06.08.10.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:54:41 -0700 (PDT)
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
Subject: [PATCH v2 2/2] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT schema
Date: Mon,  8 Jun 2026 20:54:18 +0300
Message-Id: <20260608175418.1936892-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608175418.1936892-1-tmaimon77@gmail.com>
References: <20260608175418.1936892-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Nuvoton NPCM FIU binding to DT schema format.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 ------------
 .../bindings/spi/nuvoton,npcm-fiu.yaml        | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml

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
diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml
new file mode 100644
index 000000000000..0f95def01910
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,npcm-fiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Flash Interface Unit (FIU) SPI Controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
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
+    minItems: 1
+    items:
+      - description: FIU registers
+      - description: Memory-mapped flash contents (optional)
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: control
+      - const: memory
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - enum:
+          - clk_spi0
+          - clk_spi1
+          - clk_spi3
+          - clk_spix
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+        reg-names = "control", "memory";
+        clocks = <&clk NPCM7XX_CLK_AHB>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi3_pins>;
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

