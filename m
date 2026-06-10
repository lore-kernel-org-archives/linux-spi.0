Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D5406833
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093924; cv=none; b=nRGX3QrCOt+tpO6E8e7tXyKUtjwOxw4CEBx4BsNg9wvLXTPKnXpZTurII7IJsPvB2ATcWOS3YJLoBSHr8XzpCq6iMglmdlg2hT6EFE+HvDLmQbAq+iygVeAU6k9ox0OMYkzxaBVdWvTIJin2afaWhyep3HoCURZO10uuRY79qZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093924; c=relaxed/simple;
	bh=JsztznW3Xmh/xeI6ZlgYjv1v61PArbh6D8QyccieYy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1K7KuQFIZzUesN1qKRhFoPYN+Y7paIOc+HJjAw0MQ/Phk1mg+1aFUoWwmxatBBuv05qHb7dZxLFi7aWRcqJhMRQe94KhzsCdnoqZcTa0Os2jHMwGEOFExnkii+SE7rzZcIOIcTM1CgNVWtAfTgEZEPbB4k6+KFTysFDNvrD9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcmjuJ91; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcmjuJ91"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso35262815e9.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093920; x=1781698720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVBJJGFYjcbuEOi6xjg9aXQreuuYV6xXp7Ov8MwZ6W0=;
        b=AcmjuJ91/vEPVNZVsA9ynB/T1eoWWt1qJ8U29dNiGoltyEN3nZkSmQJJCzj3cFIOHH
         5iVxg8+iNbN+Ho8pahfSXKr+MMOC78j7Jo1bH/idRxo0QpGMizDbpajiPyLpZ+qrtYnP
         qO6I/x8jdJS6ZNL7bdgGPdp1OUORyfoAZNBaawQ1SclDkgMtG+78uiJxUbfa32dn8Qz5
         WKwCtKciPQUwbJob5Tw0rqEjSu37l5CCWr+mNSOUXMZM/9nTK3WufkmtZ4K6Cle3j/SE
         vj+Rqjt16booH6N0vjnhJKow61s2Pp9Eqf/J5GgJFh0umeA3b5aFQN8gxkM7Thw3fPz6
         nsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093920; x=1781698720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hVBJJGFYjcbuEOi6xjg9aXQreuuYV6xXp7Ov8MwZ6W0=;
        b=s8wUHM3GxKguutjnWmxZ2XxkMObYTALmWzXrTQqMLiwyvtt7uzoeJdcdbApNEzZ8as
         pYvoozxkckvOnUfFOaoKUdJt0gbaOl/AxCXW0bamMrAk8DFJ6c3IMdCvJHlJMtMOzSZy
         i+q9TrTSqsNUIKVE53hVrL23GwSXxjP6TW1TdcF4elpYdOROiOkLH0145Pgr3srltre9
         qsLLrSYoaTNK9Yf9fGZs8K6thzuGqIsFl3C8BaaZMZXmPcdgwOvw9LyrhesHQmCugH18
         dIQejytlzu5vuXXPCkgEQ9NFvDmqbi6JH94rjmxvGq77lGVz/ltwqPQifDhlHFO6tQuo
         ZTLg==
X-Forwarded-Encrypted: i=1; AFNElJ9yeWRoyuOq3ZKWpDm/OtMw1LGYRXzV8qtgMV8gc6fl9bMCyJxcK//sfEesAO/kk/dsu8evr8+iPGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzBr7rvALTiaoscMcnWMXVuuyyMMltZEqq0V4F0t7SMQ0hrJp
	4CsUY/ttX2U1FZXgSIuF2tE/NO0Cg0+mwqtDBOiMP5P/yh8SWwrC6hFz
X-Gm-Gg: Acq92OGFU3U8bh/Prsg8pupcXSIVRC9xPbPz4JmxkHcd1XhYMXa+cYrZlj8ApEmvJi4
	InVOWSTfUuN2HXco7lCtxa3N5Q+1K9snm2LHSNAkmbsbsNsT+vPCic8nMItAjx7CF4zCR3jNx/f
	BBMDegdrxnVbzHQLXDo8mI9FVdkAZxrLi2iZ00lWjH76RYO8H9xQTUbYGn/xeg+o/jEFcs49qYT
	gD59PUBBaNVPZxaBz11EXLANqZOP9BqOleUjhOoSNLws89tlmBxeLBr8s65BdgqYEfLPhbPueIq
	Mvw1CmcH/ctxROf9S+s4Gw4Z9EBwM1amBwGhnK6k0YkklRp4zi1GTtLP4s4UqHK6U3d3zrPsgoB
	r/SYj1Q2nmUUuKqZxXKUHIHJnRPzhM/8/3+x8kBGXxUC2/wAs2WRTR2iXZQGZ7xdylyqn5462sp
	tHJAFpys2lDqpt49X6QZo7S2gxnF8qf0kCxRor+obGoycp
X-Received: by 2002:a05:600c:8519:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490c2d0e9a2mr302554865e9.13.1781093920430;
        Wed, 10 Jun 2026 05:18:40 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm566553095e9.15.2026.06.10.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:18:40 -0700 (PDT)
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
	benjaminfair@google.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema
Date: Wed, 10 Jun 2026 15:18:22 +0300
Message-Id: <20260610121822.2524634-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610121822.2524634-1-tmaimon77@gmail.com>
References: <20260610121822.2524634-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert the Nuvoton NPCM FIU binding to DT schema format.

Document the required control registers and the optional direct-
mapped flash window separately, matching the driver behavior
when the direct mapping is not described.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>=0D
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 ------------
 .../bindings/spi/nuvoton,npcm750-fiu.yaml     | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.=
txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm750-f=
iu.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/D=
ocumentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
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
-  - nuvoton,spix-mode: enable spix-mode for an expansion bus to an ASIC or=
 CPLD.
-
-Aliases:
-- All the FIU controller nodes should be represented in the aliases node u=
sing
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
-	compatible =3D "nuvoton,npcm750-fiu";
-	#address-cells =3D <1>;
-	#size-cells =3D <0>;
-	reg =3D <0xfb000000 0x1000>, <0x80000000 0x10000000>;
-	reg-names =3D "control", "memory";
-	clocks =3D <&clk NPCM7XX_CLK_AHB>;
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&spi3_pins>;
-	flash@0 {
-			...
-	};
-};
-
diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml=
 b/Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml
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
+      For NPCM7xx:  fiu0=3D&fiu0; fiu1=3D&fiu3; fiu2=3D&fiux;
+      For NPCM8xx:  fiu0=3D&fiu0; fiu1=3D&fiu3; fiu2=3D&fiux; fiu3=3D&fiu1;
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-fiu # Poleg NPCM7XX
+      - nuvoton,npcm845-fiu # Arbel NPCM8XX
+
+  reg:
+    description:
+      The first resource is the FIU control register block. An optional se=
cond
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
+        compatible =3D "nuvoton,npcm750-fiu";
+        reg =3D <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+        reg-names =3D "control", "memory";
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        clocks =3D <&clk NPCM7XX_CLK_SPI0>;
+
+        flash@0 {
+            compatible =3D "jedec,spi-nor";
+            reg =3D <0>;
+            #address-cells =3D <1>;
+            #size-cells =3D <1>;
+        };
+    };
--=20
2.34.1

