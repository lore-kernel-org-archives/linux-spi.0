Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803123;
	b=ISALbynVjHB0X0YKxA7g3IkHm1q65lp4gE7lIYPL+KHFuqG999fvvjkLjGoeH8hpORZB
	 W2TmuxtdAIylLRju/avmVhE8OHD2ZAT/kp4CtIsXkoK9Q3b3W1tWOQxwdPqbsh4hrs2P3
	 2s4PBKaycb+jD7jTq8t6E3PQAZl85eA4dzjYeJtGOVE2zaizsUBxK+5j5zMX2n38McZqs
	 Hk4kYh/HU8DvAJ/nRQEYh4pHGD7OXtYJd/yo3cu0XuGNsamUA0FjGrVE+ItT8k/BfvmDd
	 JjROQhRL8faUyFASrH7csvTJ4tS8LxeK1KiloOmV9Oc2AcDci12/wdaOTWs1Nr61VaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
	b=WA+YIzcDCKFqonOnbyGjqe4yqLsSc2rpZYfRbQlmt2d7eHevvBcO1dWZuvwRUVNLp3yg
	 RWCXTKsyk/S5byXRBiZaSQJMNLkPa9gMsIT3NxKbNc1oDD/rsBU2biYsP/QCZiU0qEfmV
	 v2bNMlE+FlVWIGsEfxhhjKntsjNHGrkxoxZffoHMh7XcCZ2H1/p3rACq0VBgeiuM/xRkT
	 jKdnVJ+e9OanMB96UsWc5qCC5FHNXs4261Z2ryR0Q36klFIjtl9DlvTmHq6xk/YIlaT3O
	 0p/eIN3YDrOG05P/09fIk2aO0ooYIJhkLnwBU59tKzXnyVlk82o1BmCY9lCMhekQn+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dXuB4Hch;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A2606A31E
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dXuB4Hch
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9cf928dc9so11670105ad.0
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803118; x=1793407918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
        b=dXuB4Hchn949TxwwrxnOqWrN7tFQqf8FYrosr0zcDvftQEXUenfgHn60BVKN0n3e9j
         fPhI1ylzo3uVaSGq2wfYuA5lesY5wZNd6r+UxMymP/Ln7yips+8XEPVeWsE2gJD6dApk
         CrJKThWRC/bMhsVKBj5xusQaQGD3wp7ppjIc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803118; x=1793407918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOqWh0YVIMqSNQR+C9AUSAav6J63QCzsPs/EWmskesI=;
        b=vOe3Vvgcu/cTW8zmtbMCLnqu06fHt4pNENNMip+Z5PvQ4U2uDqXGeX4wHMwZiq4BdA
         QLKm0QZLnP7PsS1b8YcKu960qvUtXxPwUAn9dRCd9QdiLYX9C7rEh+NtYIwPKgg3oyg7
         b9HMkEuqKCfquOci8O3tDzYbrVjli2BHEVKznTHhiV+XSm51+CTe1s4XWwZCXKjkXypf
         /qdpRcIrPJovhF+TZBhObdhTKORK7khL7zHuqoQsDDvbaie47WOh8fPdh2F0y5/MyI5M
         zF6IxKOhTwQO03CqINkUfwB2vSsgdUqbX+eeQ+ZXx2yKebbFmi9xsnlN3CiNj6zg6DgN
         lRAw==
X-Forwarded-Encrypted: i=1; AKwUvBxxnO2a78SDfkt+YdEGKW55tCG6GTf4oHEpfWEk1K1B+rLP0yhQ1XDPiruaafxIQLP7h0O4hhGiRCE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+kLH/iBnd5PIXHVbkzLszearlZ/DHnZkHNcQKh6cJud+35r8P
	aF8i0hADUkNJdFRvTEBhk94akr1kPnnOXkocShgwzuscbMX6mi7OBpHQKo+JrN5S5Q==
X-Gm-Gg: AYBFou0K0SPaOCMp40/HI+0zsPcNcu0kfB0utuoOQluuqKCEZEN9MeChx89GRDepfCE
	N6OjdYLwNLRLnGH2QK8If7rEqPsQT0hYr7ZovZau/2dpl9kwfgJ5AmwvL4ShCwk6sZI6v7HvdFy
	BV6FKSCqbUTDPLznOoaFRhnLy/pEZA3QVrfrjESr290YyLS0cXEzHJLlCQZkZqEUWvo/ZJnAIv+
	41/8TVfbLM/m7EWhf8uHmm6a/7vieppbxx6JelATecQ6geH+AdDOHpohkerLJLpcZi0y1w7YRrt
	JO0Ks0fmkrBTEB5/f31Ui4Yr8j2e+bkDJpI06pZsk1rPtas9oqljyJ+O9PLZGIAeGwSmAGNz7ac
	Gl/rHSv/tYI2Aw3+y8fuLW8Olvmge/sMuKiVIYGYFP7imlRcaCQZPmK1zVfeVADFhZEqkX8OR9R
	p6C2naZj0N/DWE38B3YbbEKerb8xt8HMpmYxceHAN6gKc2/zpHqcr8oLU+Ayo+hBkQvzo+AzU9S
	gtX6qLqL5+zHCx8KvMVWSM4PNp9hvtPYYF/LrkpBefO4LplG/hXollZ2UW/pXZu8hlun+gGSWse
	/Zdifqjcad1wlFmJL5T5rsb9V36JjBTlTU1AREFgo5fpm9v+MRx/VZmF8PLX6bM=
X-Received: by 2002:a17:90b:6c8:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3adeb3aa756mr451535a91.1.1792803117836;
        Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:42 +0000
Subject: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT
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
Message-Id: <20261024-send-upstream-v7-8-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=2819;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=LKvYa/CLhKW+YzjSrs/NoZ9wb/gOcKYEJBUJ8orknbs=;
 b=dsZaqSkAfRPlQsBnAlhhKrVeQzXIS3bZOeQJ5YOz7fnco+9KGbTAo5yazXZtfLMbg3/nVpvgb
 XOaIb5Tfds/C784G7HjUd9pqWsagfxfpzdw8j+o9DFF+ntj2LIpYQjX
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Dmitry Antipov <dmanti@microsoft.com>

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..bed0746f004c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over SPI Devices
+
+maintainers:
+  - Benjamin Tissoires <bentiss@kernel.org>
+  - Jiri Kosina <jikos@kernel.org>
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
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - microsoft,g6-touch-digitizer
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
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
+        compatible = "microsoft,g6-touch-digitizer";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_int_bias>;
+      };
+    };

-- 
2.56.0.257.gf7497c7d27-goog

