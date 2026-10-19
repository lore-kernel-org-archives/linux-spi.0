Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436501;
	b=z5ObO3hkKuajPfno3qTvDdVkKx+mfsooT0jRiRdLlNMf1hCERs3aUiCBf9clYLkT600N
	 0QzzXn142BH/J08DqWZO0nnJcMgcfczjdH10ePTB9382uHGfS3v08WaaEHh+O2ljsLAz3
	 QQbLcyCvlf3nUpRDHUD4rxrudS6EpQN/cXv4pQEm1Ttny1PlaIroCnki4mII4N6YqcFC0
	 +DY2WJO9OsKBRbLBTNqBVGq7hWwlE6Rpe70gHzKSCRXWmrWKywmOlcAt82r98UONmAysI
	 EJLZW109Hny1KydKW0uD+OFKHDEupQtXemU5dPFTrzW2+cHZGPUC+rcSxmiv3QoucTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
	b=x/YsfeQfcuCFQ547SmyAYyIVgEg4OxjmKPjZEqsfEsWoxwoZfdN68H3GS/Rahwk/C6zr
	 VANc3cHb9Ap/1pTUh8fAqCNHTwznHRowpk+DehT9WN6UKVMONoJfw/sN1gQQPLWz//gfY
	 nsPxsBIHp3yBmFly4PfMTfp34suG1u+3mAV37UKhL38UK2jW4K1+z+9G7icwZMFixk214
	 gNAVlvW5NDwA0VEHws3anfHBbEqgnQelMSTDeg4ibAn5i83bntGqj1+0PTqKzG93UeoY6
	 moCwTqAXqbnNwNX7uQLqrstekhsMvCy0xKFDsb3spmDVizGGxaO6X8R9lhX8sRm7Kbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FKnZBbDI;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FB60A2639
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C32FB60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FKnZBbDI
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12250975ad.3
        for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436500; x=1793041300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
        b=FKnZBbDIYTQBI/lm+RY+U0oRYalleczJpRcFVNg7bCE7Qdwt7SyYO3WqHnsbyAaa32
         7hQkmNUlpgAif1RNEClPL6RePrsQvCrylUliDxJ9SLtq4RyICURi1qoyaumv6THWS/pe
         2q30JOR5An753EDkakfdafMgwkUS2CS7EzlXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436500; x=1793041300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
        b=IXxgn/olFqnk6xqZCqfracXWuc6ZNAECOlz+W4/X13Ri2EWpq8qjIdmRfIrvkgyaA/
         OuBxFoV3WRL2wBh41kas8jHFtQMuQWmLFyXZ5ShjMwhyGDrFIv7YOyp+xpybuBIy4CF5
         p14IeXlLCzr/hTac/+W46p3PoQR5yFecTj3I1VLagEeqrY24roo6DIC98li+OLrnIHSc
         jVrR++x0V0Q99C3tiXxHpgy/PUwBPKhfu8K+qL6aSIzkMnyCeGwl1UyMk3kGvm0voa5M
         HMSIXfygydnUnRnkExaeuRnkOzDMnIP1ZiCPQ8IsSP9qf2QcyuPuLo1kIpzJwV8fXyhB
         zdYA==
X-Forwarded-Encrypted: i=1; AKwUvBzG5jiSzHiq5uJYs0rUOSeArc9QB6rd2rdaP3XmJgE9EgkxrM9hLOL1UdYTAU8Wi7je43/MnHRvQ4E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeFUe61gc8b3qwE9xV1LBQY3PoS5VjSHst9+3inApRFRrXMHiF
	fd2um52/jz8ZiESAB1+/6yCdYzVpSd0MZPnZm/QcrPrpvTB1maxjk76wQjHRlhx36g==
X-Gm-Gg: AYBFou1JfrKljOZb740c+hFJfd6K1N+89UaFBKaP7tcAoDLukwvU6MsruTyJBFhLseO
	E1009n9q5J73TVIu2iY4c+TQIRGF70G98Bp/uYNGpSELPeHLchff8EbaME2oiwnXzcu3RX4M54h
	IKDUTT0ooCPhHIGKAsa6BXn2HUvgnTOD6rfYt3hYnAMNbhfPWTEsIxxtFbkoQ8CpUzAVm9IHPEV
	EbJYEvJM1vSkL/zP+EP/3harkn7ZxX1qnd2W3WnELzlX4MyFoTM7IZyFdVplMS440cSbmn3wfV3
	vwGEJEU32r2CCO+mgdylBtYRmnI2b812jyYBozfkRJsv2lIWWM9FXBOKFRL/XYpwvqpsNF7Za3H
	JuM/f63WVcd/G15Wx8vls1ITbCQ3DYWXNVq9xPg4cKCggPxk3JJJQxo19MwxsgERNbMx8DkTWsC
	X+QZPZOgwpY25IdLXm0FbBls0ooZ+2a4EePOjRML2+rgKUarCMGzYoB02FEt0dfhoC+3klc6842
	wlRHjkQvzlsn+H786znes/S0TAhOj8v2AhG/AL5AQDc2nlMYj1SjvaydsNPVThAaqj5IK8qVfBH
	AIJS1FAbgLwvmnH18TDaArtaP9pt+/PHD3DEVjPcmzOfd7nhMJrXdmoqYLNQ8wk=
X-Received: by 2002:a17:902:ea12:b0:2e5:78b1:33fc with SMTP id d9443c01a7336-2e9a705023emr80598155ad.53.1792436500085;
        Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:38 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:20 +0000
Subject: [PATCH v6 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=4977;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=3JV7SIx4Z2hhtNXaNrWUG27kANewD8ikLOOlV/xW+/0=;
 b=lIoWtzK94uJ2CVOcYas1knqxryWopuM6+bcWy1s2MFL43hSH7uhTVG2g2uPlgxQ4yidS0l0qV
 8EEWiL1+FpDD2WJlM4xKES4vF4ZWysNWe9oO4shLMegkzX5e2etMgEc
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

The properties are common to HID over SPI.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..2a5fa0868a09
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over SPI Devices
+
+maintainers:
+  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
+  - Jiri Kosina <jkosina@suse.cz>
+  - Jingyuan Liang <jingyliang@chromium.org>
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  The HID over SPI specification does not define fixed values for the
+  read/write opcodes and the input/output report addresses. The host
+  retrieves them from platform firmware (ACPI _DSM), and they differ
+  between devices. These properties provide the same values on Device
+  Tree systems, so devices that fully comply with the specification work
+  with the "hid-over-spi" fallback compatible.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microsoft,g6-touch-digitizer
+      - const: hid-over-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the device's reset line. The HID over SPI
+      specification requires a dedicated, host-driven, active-low reset
+      line. The line must be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+  input-report-header-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report header to be put on the SPI bus. This address has 24
+      bits.
+
+  input-report-body-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report body to be put on the SPI bus. This address has 24 bits.
+
+  output-report-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Output Report sent by the host, listing an
+      address where the output report on the SPI bus is to be written to. This
+      address has 24 bits.
+
+  read-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Read Approval packets. 1 byte.
+
+  write-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Output Report packets. 1 byte.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid@0 {
+        compatible = "microsoft,g6-touch-digitizer", "hid-over-spi";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_int_bias>;
+        input-report-header-address = <0x1000>;
+        input-report-body-address = <0x1004>;
+        output-report-address = <0x2000>;
+        read-opcode = /bits/ 8 <0x0b>;
+        write-opcode = /bits/ 8 <0x02>;
+      };
+    };

-- 
2.56.0.212.g129ede20d9-goog

