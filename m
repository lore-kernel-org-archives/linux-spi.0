Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A063456E1E
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702729; cv=none; b=t8NWcVa3cas74UDI5+VHLACwdu7SZc1u1a9g/Vxn6uL+RcTTfekNMBrLzQ5ZMk67VaPNjl5Kt7u0EYkknfq8HtYI/I43tlSyv4kbVTQ05Dm2SiZcXsN2W8VVhb9ChrhnL3t/yK5ggG9+Xuy7iIzTX4BaVZm3G1N2K9z7cjMf9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702729; c=relaxed/simple;
	bh=GCnr4Mvm18woqcPyatGz9lyWobnOtJmYTMXDBVkkUVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TkrnNrtNW13SRviJ2ZQYC3Zdg9fr0kx2+uZbrA479OlnayGZ3xrZp4pPlNgCfO8MAFw8+0XqLFwX2AQ6++tV9QY4CQJYIFn8V/MQMMow8LaqaO8BVFCREXSuNh6bL6yZNknyWvWybE1LbZQum/QB3+ZkkEYoK8vOh+ylxbqw8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSRNdY5c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSRNdY5c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d049069377so9537225ad.0
        for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702721; x=1787307521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SoVS6TyvWyTEmYUl+BaMNjP58PtMCPWRwsnVl6nfaY0=;
        b=FSRNdY5cUjftjEXHR6nwlsxaOEKsW1rKBmmdNZNYZbNET0taa+WJR9UkLTRgm9DTVs
         BufwmboZzKapO6Hn/oo2CIgszxvWpxKhLjBEVgMjdzPuxqMS6hrXfyaCzzNTWzn/Mlrq
         tzVQI6nqtcl1kV8hY/EFFSPrE8okFLZ6X7IsQr+Zvv3Sz7FptqEdgsMpb4xl41wlqjA6
         18EVEwe853+2e7s2XwCgMeVMjxCLMDksJtagBy8JLdiZoJ6tka2wYLchOYWExqqO9Vaf
         6mbqm8406Mi3ssn3ejybO36zvNOvNHoS2m23NfKrM2vQKF9WNnayZWzUTwG49OkbydRq
         YChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702721; x=1787307521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoVS6TyvWyTEmYUl+BaMNjP58PtMCPWRwsnVl6nfaY0=;
        b=B8/cGv264ATaUQDGAv8Ld3UIegcjACj7Jf5axwwNIGLFwIFqkwGD7/gXoAkyOPZ0J/
         nkKto/zVpemd1Zr3pJ5QmkdkmgKA9HsO3O5vVmD6Qock+/y8rpsXL8llAKPV5Px290A0
         +ty2IjkjjyBbkcO5LGAG2scURb9Mdmw9ZbUmCkOQxSYGXJDBSJw5XoGBQ2T9B/pNlG+T
         TEr5Yn3AVI+wJg68fjYy5hTwBHmMvw0cHSEp8HJ2Yg5HbB9qdg8dn9KyJ3mwtzKnhnnI
         DcWib5lCcyw+pvGuxpFtsgp3s5dK6eHFScMxnpceHY8K3TioXq1ML+fw/oPbzdEf0Fzq
         kHpw==
X-Forwarded-Encrypted: i=1; AHgh+RpZWTIv1Dz12TDSBbJkG58AT3HvFZ02O7eWHEkgxpNU/qDYi8T9ac01lcTEzMS4unINo/C19Eih+sY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6bgh+186spo/DLEtCIn6iwaAYLgH3O6uvzZ5jauFYWxGC6Po
	hUuwk5sk2euPtNA+ScjspCWICxwEThKkBC6PN+/+xF/Aqvey5RPUDpHC
X-Gm-Gg: AR+sD10qKXj+PWsg3Fb5SgBpQp38Sp1UrBv5UkJokCfIwN21AOU+lGh/warw9Fjf5op
	HDp3W+LpYYDCiFG1tEu35tDYy9iVwjXKBErSbZd6pFBw+vhzwYojq+zmTwdxUS2aOnLsb+txCB7
	WFs63PmPnwKve6U6OY04VfnAzHfXN/E4FIqBBMZceifCZbo2TmdcSYEpiOCgZ06G92N1xHeo65E
	s4K9EFVbAVcrXKhY4RUS9wNmD7uGlBsv4SxSFapYb/Qzi+cHCglqtIYNny7zdwtyfJ/sDJB4cDR
	10oNLSYxdL1Qpq8lYkwCc9I2kiypjeoZ4WqlRsvPGV2XntRh1TKHoQIPCXKrJuXIoD+WcdDfK7F
	lvIPgqnxK6ydK4jnOWjgxNLG6AcTp9Oh0sppN6BEZaV4MUx6fAlOuh29XzGEOoQJbIyj6PeYMhT
	GQobouHicpMmwd9zhI/0Z3Nr56Oz7OEAp7cmj9VanuX24l+G+Dki6uNd0qS56YN7FL5GYZmwrqB
	6b8LxU=
X-Received: by 2002:a17:903:360c:b0:2ca:b8fd:f31 with SMTP id d9443c01a7336-2d3b0d5e37amr51097825ad.15.1786702720815;
        Fri, 14 Aug 2026 03:18:40 -0700 (PDT)
Received: from inhnjlux1020.ls.ege.ds ([2406:b400:53:97cb:44f1:865e:4c69:6423])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aebc81a6sm7393685ad.72.2026.08.14.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:18:39 -0700 (PDT)
From: Udaya Kiran Challa <challauday369@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema
Date: Fri, 14 Aug 2026 15:47:33 +0530
Message-Id: <20260814101733.46406-1-challauday369@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Microchip PIC32 Quad SPI controller devicetree binding
from legacy text format to DT schema.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
---
Changelog:
Changes since v2:
- Change maintainer to SPI subsystem maintainer

Link to v2: https://lore.kernel.org/all/20260625060903.14661-1-challauday369@gmail.com/

Changes since v1:
- Drop maxItems and add items list in 'clocks' property
- Remove unsed label from example node

Link to v1: https://lore.kernel.org/all/20260624061329.130468-1-challauday369@gmail.com/
---
 .../bindings/spi/microchip,pic32mzda-sqi.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/spi/sqi-pic32.txt     | 18 ------
 2 files changed, 55 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/sqi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
new file mode 100644
index 000000000000..f684c359a199
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/microchip,pic32mzda-sqi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32MZDA Quad SPI controller
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,pic32mzda-sqi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI source clock
+      - description: SQI register interface clock
+
+  clock-names:
+    items:
+      - const: spi_ck
+      - const: reg_ck
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/microchip,pic32-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@1f8e2000 {
+        compatible = "microchip,pic32mzda-sqi";
+        reg = <0x1f8e2000 0x200>;
+        interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
+        clock-names = "spi_ck", "reg_ck";
+    };
diff --git a/Documentation/devicetree/bindings/spi/sqi-pic32.txt b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
deleted file mode 100644
index c82d021bce50..000000000000
--- a/Documentation/devicetree/bindings/spi/sqi-pic32.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Microchip PIC32 Quad SPI controller
------------------------------------
-Required properties:
-- compatible: Should be "microchip,pic32mzda-sqi".
-- reg: Address and length of SQI controller register space.
-- interrupts: Should contain SQI interrupt.
-- clocks: Should contain phandle of two clocks in sequence, one that drives
-          clock on SPI bus and other that drives SQI controller.
-- clock-names: Should be "spi_ck" and "reg_ck" in order.
-
-Example:
-	sqi1: spi@1f8e2000 {
-		compatible = "microchip,pic32mzda-sqi";
-		reg = <0x1f8e2000 0x200>;
-		clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
-		clock-names = "spi_ck", "reg_ck";
-		interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
-	};
-- 
2.34.1

