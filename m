Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE23EB810
	for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144015; cv=none; b=Ata6R1jsDq3MDdRtn+bw5Dcp5goJd5fShSFwk8Qx+U8gRY5MR9BidBpE934xXKTjXwEZC/dY16PfW8MJ9xE1sXXwwL84i2/SNHZMXoU/HcSFXAYwhb4vYvVWfA1FoE1Rh78JB1hZC7so5jKHSkiddDLt7EGAhjE8PBqN4W43KQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144015; c=relaxed/simple;
	bh=kNtYw02j19lwR8bn7qrwJ4kwUTtXlNX+mFGOd6kbNmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5ihcQnv8aDDoz0Cv6l3yHyUMKUA4LUdSvuxI6zOtXcmeoetjn4y6CZ1OJ8aQFGNHo8q/WYaKr1bqaaKyyEAMAASheqM7JsbWa8HjQ1NTyPlF25zBrBK2nT7COW4OHcOz/uVCP6qqb7sSKIvfINYJgI0XigK9q3uq/CseRQjdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDnlFIr2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDnlFIr2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84830c774a0so2406782b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144012; x=1785748812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBn2jjAskCbGfn7VoZyIaR2lupbEer0VieIcw6uv7AM=;
        b=UDnlFIr2ps/BOZJk1edWrI99nqOckBF5B1kRvUgAGiauiUV5y5wR/mrP5Ts9HFC43W
         y6U483LrZWI8kbT3GtIP30UHWHFF9dOv2ToECt/6sI637bTWLp2Bzrv2iFTqcjuz5vET
         ryFYm45iZo/PipvMjI0+euS5eppbVug1tJQTVMO8qjPXQdhVx3b4K1gIf/czXOG38EJ5
         9Znik2N7heGSLfBBpYVQjJGZzRh/2k27s44595hY/FXwBdD9rbiSiBhkYhsTrgE671L2
         0JYu2ALdCguue4oSSDjLIzNYO4qtDFiHAcBDp3SL1rGVROw1JwUEU7sY0hxec+Yl8ZYo
         Mxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144012; x=1785748812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBn2jjAskCbGfn7VoZyIaR2lupbEer0VieIcw6uv7AM=;
        b=FSCWokYQGlUvmx5N3uqjrNu13fYllYyW84MRV8OWbBRCt7V6u7WHCy1r1yflS/KkR6
         Oy8j+1UaJl0tDGaJS17N7be7NL53muK+EVgOKsX5mkeishOieAq8UQBiXpTDrV2/6Y3D
         47xFKNKqhLM1Y80bMQU8/f/p9Vnu8TM1C5K1XSh0ZVi9tM+WMMJEZueNDvmv9L4GmfLj
         aurCyh45jmEe5tsAO3rM+TjXYoNtdkStXCvpLkj4w5wjB3krRE/9ArbWidPAfHfR99mv
         TFF2daHcTXWfSV5/+Ausq1c3dKElgimhva+ERNRSx9E03krWcxmapklawUIPJemq24Ne
         iPfg==
X-Forwarded-Encrypted: i=1; AHgh+RrcSYbVbsfFHsszLGq0c49s26e+mCGm0CBvlIfb7mysTrXf4qx8JDRJY/qEvJltROsgnlI3oUgFgVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NPESC+a/1JKgg02FkLXTXpnNUFpHHqMiI4B/VSR0hKcbJVT3
	rjbY7wLQwKNO1rgU20l1LJt6vnmfW8gSazBCEUfcPj5UnkUs6MxiPdG4
X-Gm-Gg: AR+sD12Yc/OD4andB57f6vHrr0LIHUrbFdDPSuNLG7CoWtR5ZUI9+xnNjC+EYo00Fmv
	zc+DkG6ndOiWG7i4+0gAEKO8X+fmlUN01B6okXdk8ESOwvwUQxAsfObh11AH5bmbL2VEe7+mIz4
	XAzXV0ikEwWUnncfWnA1LFAjgFn1p9P8vhI11rnNtiRCjrLyqXPXtOKt9tJah7FkrNrG1wE+s46
	7Mp81z3RvIiqGyCik9fM0UW5HtIHlIqSpoGBl4v1NEQSP1M1LWnH6LhIimK17myW1U5P0TQ9ZcX
	v51EPZCl3ONiNWeTJlI99nDw9soN8oR5Arr0H9OpbfAjGNZFVAux47FCmV4PeY7h9vwB9/5+MOu
	hkqokVXldZLn9UYAxdpBoOtzP2pajCDj0+UDbiGSPAnIRA19xIR1awZZe5FPyteXChKK7DMaLqy
	90EkPfJljET/C0oeo2JmxM9+CajzEjD4Z/IoNAQVhKa5tvSizEmsDX9rxNSFDCScsRxO4fnHvgJ
	HQ=
X-Received: by 2002:a05:6a00:2c94:b0:847:97a4:d6b3 with SMTP id d2e1a72fcca58-84e59405415mr6004651b3a.16.1785144012199;
        Mon, 27 Jul 2026 02:20:12 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53253b65sm2802645b3a.8.2026.07.27.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:20:11 -0700 (PDT)
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
	cwweng.linux@gmail.com
Subject: [PATCH v4 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
Date: Mon, 27 Jul 2026 17:18:32 +0800
Message-Id: <20260727091833.750051-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260727091833.750051-1-cwweng.linux@gmail.com>
References: <20260727091833.750051-1-cwweng.linux@gmail.com>
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

