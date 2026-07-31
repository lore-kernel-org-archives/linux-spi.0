Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45F330D29
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465513; cv=none; b=dahxyvv7CbANWvlMN7bB4+R2IbNEKBlfbg9wB1/4GWj6Eyh/2OLws+0Ux5RrXAsSx2nGz4Dd3USTRWizLpHBgzZEoDUyXDtamSg3N19pMOPyUlobaSRgTQi042rhNd+9fHj+NNwMXcAmVTy9I0eggG1DbFgctwg22pZNER2SKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465513; c=relaxed/simple;
	bh=9/LoeI+/IuoG2Uexy61PZsKhk2Qa8plLvXsvIoDhxN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrLr4hdYjJEDxQFchMlJKD9xOuzlkSEk56sLMRMyUAppysnPGzsz7B41F9kXckYiKlkx/uGOQNW2N0nLhY1b34g57/FuafT5zt+pplnh8Lb7ObkYEUbolMrTEgQQmrkmIxSAMW9KGpcjb3B+iFZfTLpjb9HJhYd18K5oUaaqpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcHyvEQn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcHyvEQn"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9aea40d799so245900a12.0
        for <linux-spi@vger.kernel.org>; Thu, 30 Jul 2026 19:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785465511; x=1786070311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfzAVera8YPzEZfXN0c8xQO741Yx6s8VOLnFqWs4cSQ=;
        b=EcHyvEQnDk2BaiKM8f0xaUM6f3BU5RL9XZ+W9N0XC39H4WsB6mCdKaC88EYKas84DK
         PnGapf8XttTTkBULEogMUnopbfArzR9v056k0Vyy2Kj/OlYsvz/AEOKHToEfDwclYbJt
         Sjcd1UXd/qF+ITcLe4zAi8mhKgNe28bLr3yfXphL57oPgw+/Eu28L8XW3U00O8wfcjpl
         CzpulVbk4qoGK7ddGZ9+Vr0WXSjAe9Ml0/mSu85ijdKee6rS+Nm/Rq3znFcHOqjaBUzq
         YOu3lvchWVHx0h3enthe1SezxXZACiF3tcktwyEgQAn4/8wp4lWZEask9vg36NOwkp95
         KsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785465511; x=1786070311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YfzAVera8YPzEZfXN0c8xQO741Yx6s8VOLnFqWs4cSQ=;
        b=e7yqFczBE5ifieSD7/Fd2IauH5SF3Nql+oAmdViWc+IRn2uDaD5hNqg+Te4o5tmugq
         ZEXZNmNbX+HYsXK5UqG1uAHNFVidUVt+63WNsVlWPdeKp6ddqCZJx0/1rvUwiRhjI55q
         0vXY5Ca1zcuqt16+FB4EoLM0fsy5elZS34/K8Hvu7/OadHFLm1k9SeKdOBvjpjwI2rWg
         oM2SN8ljC3c9Ygak7zJ3WcJu2/Q+I04bFPpWn/Ercynp3+tbB94tCkfwTWZGfXmVM9gl
         WjKKqhK0azZTEdtoO+f8n/exQFBHVEyPdsvwvt7q9rIjK04i2aXkwU/Rv+DEwTkOcYoT
         LO0w==
X-Forwarded-Encrypted: i=1; AHgh+RoYw5I8ao03DoHl+NhUhLK7f5Lh8+rG/5F077aIF8ct2H81p+57pDMiAqlgcO4TaL4TPJxtx9K72HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnnZwqol3Ml4pq/KvszsNxDVpGLtea+pO6x1CnLEP9EvdzdE1
	7YYaA/x0sTy5GrY7nE1LC7nH4QCGpifoH0zYDE4+783qR0u2iEEObvHU
X-Gm-Gg: AR+sD11TrhF7d+W/0na5DQ8CXltDv6gs/0trxMxZHFWNaN0WXPIFi4sl/AE5ienOKt9
	SqAvttt6tP7Lpyb/PEYrAItlmafoo6WrxGZg+War4FEs6SVZF6TNIuZLtJTlD1VloBdTztf1SNf
	c7ST01Haik3uG2PdPRPxEQFKlbTFUI/xsrDgf8Rt82LK0SfqBYxs/E1FnqRlTYBHEjQQdsRoV4B
	H7lDHrlEm/EZJK7fOVzhvozjcrypIVYKxLkH/QswFG1uI2XmCXJ6fvEPKtbMH+ZmCmlWn6LDJ1O
	xlTHvRlxV4G0ZzrlH7N3SgltMPcLXoT66ECBmH+nH2P81FjxBAhstF7FTcDH0ZeFIISDwlQ6mHx
	N+McB0mqsL9ONUlnQwK2CthynDXjoFeDGiZ5JJs7UjIPL0oCLlNeZHdmNT41kGNyXF0fqsFS/0R
	YXvwOWTbn1CgCA/VLN+K8c3Jgh0zW4EcnyoydpSWi+QCAnre9pNG10tlDdNB29E69BGXU+SpWnw
	o4OsOIJblXvHgKB4Tr8UNP2Iivr8WQGVWu4tJODnUobJJmS034=
X-Received: by 2002:a05:6a21:6f8c:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3c91b12935cmr74236637.9.1785465510997;
        Thu, 30 Jul 2026 19:38:30 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3808a8d9sm81938a12.7.2026.07.30.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:38:30 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
Date: Fri, 31 Jul 2026 10:38:17 +0800
Message-Id: <20260731023818.1626075-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260731023818.1626075-1-cwweng.linux@gmail.com>
References: <20260731023818.1626075-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add a devicetree binding for the Quad SPI controller found in
Nuvoton MA35D1 SoCs.

The controller supports SPI memory devices such as SPI NOR and SPI NAND
flashes. It has one register range, one clock input and one reset line,
and supports up to two chip selects.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
new file mode 100644
index 000000000000..377ccf4fb224
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -0,0 +1,63 @@
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
+  - $ref: /schemas/spi/spi-controller.yaml#
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
+    minimum: 1
+    maximum: 2
+    default: 2
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
-- 
2.25.1

