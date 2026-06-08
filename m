Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330C3358C6
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887024; cv=none; b=bh9FrQUFI8SB5WGIStV6KLVDiPdq8cjTpDKZAzdZv9w4w1A/LXW6m37tJ9cg57CMQY9JyCJzwUqWEfZpGkedLEOW8ww6594/yFdUWviaePU9Lw/DAsUSAT4tWoUaF3Ug1+AlNlLd91DTBbwqZltgIPrQkmK68hT4Qnake9cF/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887024; c=relaxed/simple;
	bh=PXAq5819wTGn0F3nNVbrQuezlvNB6Q+Ykg24neiJW98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkF+JnNh8rdL7rujj75XwlWzibRA8VT9mAE0cxjmJk9Pdguo7mbVKd0uE49gTh9GG/dxMPmxfYpKgmBtrmEqREaKK8V3/HDPLco3HRRxgnlB3ngaE/gYTfRdku2HVQcYJhIwH2Wasgw3B4Jf9F+4yGN6nMKqkETj7hQde+3jh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iju3rkxG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iju3rkxG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c379e8ffso24811445ad.3
        for <linux-spi@vger.kernel.org>; Sun, 07 Jun 2026 19:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780887023; x=1781491823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVfBDie60n2tkYsVA0eLmiW0R8D3OP3qoUkg6UxA748=;
        b=iju3rkxGN39CQNVY9h2e592Wa18NSFC4oSmBa5FaitQrKhWx5k6zFqaz9emy5Xr/2a
         T1vcmHIxQLloWGDXStsBqJCAHt0bWAhHrQjP1EJ14JhvFAr6L2qWkaxec956BgZwexWc
         lGTdUjnnspT3H9xwJmSteRyWjptAnoo0gJTF1bzAmQ0V0id3Dudv/EgdHPJWc4Q1eCxX
         oG1GsV1/bBP6KkaAh2xpYaZ7P7u+lF4u6/uNzD+1u0mP4CsjSO7jIsP6UQhfSQQZRHnq
         dUK8M5xyS90IAK8NpMUtkDEaqfcArWPCR4y/Xon3FPEbgo3Gp0qBo9/QnCgsgQkClAPj
         CCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780887023; x=1781491823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVfBDie60n2tkYsVA0eLmiW0R8D3OP3qoUkg6UxA748=;
        b=tAI8XnJmn+PjQBXu6NPzghnyZtmnco4LcjHh6LLRYAvYJDJFS3Z/itoDRusliAm9Be
         nS1TRwQa3j4Z3csqMxsIkvU36YT8svCAduV9JfttVyOqL0yahBebMmv5v7i8PmQSmjPe
         VyoBBWPe+imUsI8levPgaW4j+3x6+A0SXYMZHMc3immA9HUqAZe+yP2rfVARIDgoXkii
         L1ItdPQWUyytZdO3GGL/wSKJxt+pCyqsLtQ8OLq63nfN1TBy9VkUkwCFXKleXsqUashB
         Ssq2UQZFI8n9RU8f8XTgBG2NTqTFE1WzZdz9L5h+ikpKDU2E136k5jvi/Fl1sb/Ootqm
         Iyxg==
X-Forwarded-Encrypted: i=1; AFNElJ+Hk65ozmsVy+QqqgjlXROB4c8TcDWJVkl0bVBGteHlx2bNkuxCJBfRfwItV3LQ/5sAKbRcTKlfC44=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxxuqDIe5xw3urMdyhSWd/1wsukf7/iVATrwB9J3GeHQFslcX
	izhoG0A/zK1BBZsy0YRCU02G5wNL4LQmjeVw2AfesKYLcJW6wzx0qLrY
X-Gm-Gg: Acq92OEyFd5vrxEasPPeM+mCdXGg2cmT/7xUeXx2O0oahFAtOb2hcWvcG5Oq7RqiA7J
	E7F3DCfIyr9J19+lICLlbHASqGVnAwOtUIp7DskxY7c796b7m6+cFg+kf8qqV3GSMHDAExlf3Bq
	BwdSd5D1Y4tQGtUkzHfltBlOFxqkspGWViC8h/NqNQ8KBuZ2isINLqA644oVEgjOU9Ly4dG20fs
	TxqXY9bBzhuCR0W3e1BfH5tTB/cbBDAN6+pnfh03FiLKdWo73atbHK8BZaiq2QghJNUeg13EMFH
	xz04Z7ij5qD9QGVaioQKSMB4On2qlkOw0s1uZvAfkZjNU1xIKdQzs71PzHDbcQ7qFvnMCwSSJMX
	TBRNlkr6vxX5POdRKsYLPdpHKL5/zgcbXC8kAkAqo/IRczDKDV/uoEmtahEBsJYhdBEOahYGx/7
	bTNnK4Wmm04Bu+lEDqq+XKHGygTM5Io7qYsHXgBl+Eqg7eoG9MXf0b1VD89eTKvTWd4plKOP9Ef
	2Haa0mkE9JWgKA1XBc=
X-Received: by 2002:a17:903:1965:b0:2be:1c3c:72ba with SMTP id d9443c01a7336-2c1e80edc5bmr144390375ad.32.1780887023133;
        Sun, 07 Jun 2026 19:50:23 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm165745555ad.3.2026.06.07.19.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 19:50:21 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
X-Google-Original-From: Chi-Wen Weng <cwweng@nuvoton.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: [PATCH v2 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
Date: Mon,  8 Jun 2026 10:50:08 +0800
Message-Id: <20260608025009.1504971-2-cwweng@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260608025009.1504971-1-cwweng@nuvoton.com>
References: <20260608025009.1504971-1-cwweng@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a devicetree binding for the Quad SPI controller found in
Nuvoton MA35D1 SoCs.

The controller supports SPI memory devices such as SPI NOR and SPI NAND
flashes. It has one register range, one clock input and one reset line,
and supports up to two chip selects.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
new file mode 100644
index 000000000000..68e6d79e6b7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Quad SPI Controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-qspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  num-cs:
+    maximum: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@40680000 {
+            compatible = "nuvoton,ma35d1-qspi";
+            reg = <0 0x40680000 0 0x100>;
+            interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk QSPI0_GATE>;
+            resets = <&sys MA35D1_RESET_QSPI0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
+
-- 
2.25.1

