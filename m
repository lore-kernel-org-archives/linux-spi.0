Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955D37DEAB
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780461369; cv=none; b=KJXmNbqLW64VcQcLwa4wysYPibD7rLNzZZPKCK6joL9b1ascPY0gQqQSC8RlUFxu7fDGCY/aFfNMvT7qCG0ixPiF0DqImsr9+w8RKQfr0JgJL6aKFoeSH1ue6kYOGSY0LgIDSDlW9Ygqoicw5bjrxpT4P0iFgZ1QtBYw4/Rz9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780461369; c=relaxed/simple;
	bh=RsY2oIuWkiPL5Y9qoeuUbOymeqGvcojBKj+xOb2EDc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6/c8hVGUauKlyDMbhA2YMInPWqifpdsp6Fb8CnaRT6Hv3K3Mp/bM/2jqElKjsyjaP/yCl9PVZymNICa/k1ZMgruqA+Qp3Ffl+EuxmWk6WhRTZ7h5xPbIOz5+uZY9yYJe2g+6x4krXJsqeXQa9UmcAa4N329YZl6yFlw1McHVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux9qC+Qn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux9qC+Qn"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c859878eb48so1353251a12.0
        for <linux-spi@vger.kernel.org>; Tue, 02 Jun 2026 21:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780461366; x=1781066166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WhyjqFeKhuYhkhKO1bR1hDfl8+mFdDMpPiPRXHEMcE=;
        b=Ux9qC+QnYBIDaKayaKaAhanqRlgSXNOJ23nv4ywI+xLj97af4B2AE/C0xzBPo2ZVL2
         /iHEZFIvQ1b9GmAJafH1klEQbiJd6dbE7DPNMMK7SIIfRBLqEVSyKg2lkzBm7qPpmfvo
         /14aUaKnOlJuw+aoAgT5CpMu4qEOp9tgSQaaSg9W9qRwjboZ2KlJ8rSXPPz7mGuc0kUI
         96CLTW3BzPtMslTD6gXcHsnGrOWtU7k50X4f3Cc1gLN+P4uG8zeB8p/S8CE/wLNQbLhJ
         hUb2VvtK2KOmgG4QQnrIZEqCRYRJNMlBXOzekLegkbu9J3xhns0sHp3/o9xDL/U7SfJX
         AO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780461366; x=1781066166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WhyjqFeKhuYhkhKO1bR1hDfl8+mFdDMpPiPRXHEMcE=;
        b=TiKkbbQr2SNtYl1TDRTLi5jGfFBica60Ojk3Rbovfk4iLCsS7xHWhOm6xcYK6IrfYb
         nB/keWjwQmDibyn8S0dsqz5d/xPjCr8WchNOgLCE5bj13Pddn3AV/nfN/qlTODxcM7Fg
         L42/7Q4Mekbr91GGOUBobcygmJQ0I4tikedQplG0aBYtpascJlz1QMM+MvABKNH3rwZ2
         M7xkD73W2ou8lfjAMuRNP0YZ01VCsclQmXdEXaUSuJorSPtlHAkZD+VPnJQW2KJ84o2A
         j6bRarWrYYamh9QXCQPxeK2vcTRXmEgcxmtvSIZGUC4QnPf6/2SvNnUSC7UB3V9pDBRK
         N/Rg==
X-Forwarded-Encrypted: i=1; AFNElJ8HMRTeWnDApimtsDtRy4zXfrmsM5HeMd6PhXr0i1++/y1e05ZL4KOs/1yf4SGyQbTfVeqfluVeV1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMzto1Y3EKtOBrY5xAw7ngbEAd/rwKtbLw/O+Gv21TiCVV9Aa
	YQ4jPaccF2gR2TCS+XkGpzvTSrcmcjDweJUohYHggLgzph4ECQC77DZl8Kg2aw==
X-Gm-Gg: Acq92OGXEkskBeTb4Q73M76TjaqIdfyvrmhYriPERwMvt5Xw2YNIJBuT9TQwIsd0v8j
	ZqBxW11vBY4MQcg52L7zId36DBFWw3bu/YQKOJjDdJkdSAlPMTU6FTy5au5PyL5+rU4bAYJ4sbK
	GLNlnqJJ+f94W6t3fAzPh27WlHmZKv8SfK4Gu27Srb9S7qZmPHLmixfbi+hn+aNyP2riCNmQ/Rp
	7/hW+PzL+gVo/tyHLuwprGrHlfEqU1GIFJTsWcGyP1NTD7wQVCc6Fz/S4Wz/KtjqYsT6zT7YCrG
	LP3js/ddFnU+VoIelvHvUwx06sOr7agTc8pRKGUvNzY/sIvI0tNJ335DQYIREMA8Yx9vfTSaaMo
	KrsHh/WapzVAVv9iuRjPk7Y9XlYrMInmgKmqm0UwsxSNH8R1RF3xjlsQI931xleyNQHDrzXJO5h
	BA9/cvJDJI8NRvVGnztcNNbTPcbGPkRcqTMMNCdVhQwccvkHw8gB9whn2RTHj44GPRjBHnE2T1V
	OpuhIjYJliM+khLr5vAEwzv
X-Received: by 2002:a05:6a00:1d9e:b0:82c:e60c:f36d with SMTP id d2e1a72fcca58-84284facfd3mr1597329b3a.48.1780461366633;
        Tue, 02 Jun 2026 21:36:06 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282904889sm1478742b3a.55.2026.06.02.21.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:36:06 -0700 (PDT)
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
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI Controller
Date: Wed,  3 Jun 2026 12:35:50 +0800
Message-Id: <20260603043551.1062112-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603043551.1062112-1-cwweng.linux@gmail.com>
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
---
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
new file mode 100644
index 000000000000..f7b9cb52d8e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -0,0 +1,61 @@
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
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@40680000 {
+            compatible = "nuvoton,ma35d1-qspi";
+            reg = <0x0 0x40680000 0x0 0x100>;
+            interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk QSPI0_GATE>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <30000000>;
+                reg = <0>;
+                spi-rx-bus-width = <4>;
+                spi-tx-bus-width = <1>;
+            };
+        };
+    };
+
-- 
2.25.1

