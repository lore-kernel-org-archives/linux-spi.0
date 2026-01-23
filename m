Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8A2EF665
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200729; cv=none; b=nDq3PNW7eFTDMh/dNrrQDkN8Ann4sLi/M8kZJeOJIjfojKOgah21mp6d8QzAKzcfrs5WVLOdJKfxz2O/oS27kQ2AiLBPgILe0dJkfEW6oRz6mrdN+9pG4LWDgNdsRPkYRa2DSd/MP972/xCidxO6cEd3Dk0qQpi6aRNpGnRKos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200729; c=relaxed/simple;
	bh=h+Hpg7mAV/rUr3EzlDZhbxTF2vRK/83Uj6sS1/n0P24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jg27wgZgtR0yQxR0ayBzEcKJ9w4OkjJsv4b7Ti8Ro6YZyns1HDMBQ3OM/mCxZ5llifb2egCDvNTfnE7sdj1d7/OaUifFVajC6ikUHTIqjfcfCIM0e/3va/BmqTkFW/fcTHKOgWnyIdriRGiwG3uGzNiwW5+Jn+NBm75Cc8QoMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MfmgT9lw; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MfmgT9lw"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45c8e85deffso835083b6e.1
        for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200725; x=1769805525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X31guPVFU+0+g2QDbsPtzUxPVvF8hORfxCmewEdgT3I=;
        b=MfmgT9lwQxvtgm+ps6d/siwqcHFjIWyMd3uQKQHokY4jF2tvAgj7kUmND01MDZBiQU
         ORy9LHkDY8uGd8UKvR3LXi1H4DkR3RlVQRKab4uE9gnNd03LK8a78dITTYN15/vASIcR
         H0gFWnsGEaBcWHMqmqqu05Ar0Dxjst+gWk5vzOOccu19DsGTyIpovD7/R8Kham9hpfXd
         YnZoaDHIFYk1CA7wifwwU3w91PtS+ZnvfZdjizp0fJ0RYSOgYGHDEKMPc9gsxJDOMMnp
         Sou7u5l22Bh54OliIQTY8BAUhZGVWkPnEAYlIiOX+K5ylpZkLWXmwD0Szf/tg31ff9Az
         AASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200725; x=1769805525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X31guPVFU+0+g2QDbsPtzUxPVvF8hORfxCmewEdgT3I=;
        b=f+v1sbjmcEqcBywzduBeWWlCSjVR7E9b7cZSZ5yBluWx/Y3+iy4ovll/Jqw35el/KS
         xwWdAyYXfsPNaLf1Davfwjtu8wZOWDXnkxFaDpAaIYzrf1FOY3ZFNPR70LFD0IISS4wL
         MUqDR5tnHI+vMnFBy8xC//n3RP837O6pPyHGZ8cFzr7Y1I0AwUF3ukHMuUT9C8zyFQEl
         9EuHJ+Yv+Ir4a3IBcJWekqc53ywY5nZigcyHyYt9btaYrL356KzwSOMQvalWslbg5TIS
         qsxtay08DX0Dsztdom5pWasQIpsb38em+Jf5PB4iN3sDlo3BavQqV7hC30F5iVqCIH4D
         uTJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYc8v9CpDK1nkewbKkBwQulOSW4LkUXGbHYdmEIcomqc+Y3K/xWUH2fk5iAFzxAR1tvHa/IHWntXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlI590TPgUq1fiR+oHpH65BVsJbRgxPEL8fmh2uOQB7AInks9
	LtwPlsp4UtyO0c6Y0L3J7hbSQm2bYN+Evx1Xsvm/6l9MTSR6qmMJdTred/qHD8r1Ab0=
X-Gm-Gg: AZuq6aJe4GdsgZyqmsHGufIAD+Bz21AKmLrI5HO9X9tqpBaIDcB93jy+1AXk4YKINey
	iUmUI1qUnZFpk6dvuTccrLJFHPxkDc0BcUfvzgZYZtouTzCBe4kHQZRXulrNjKMAlo9dBg2qI68
	SdM3CJ4iaJu1iSABZKpR8KlXtviOgo3i3NCdJt4oPcZmBmGks6eRDHJbBF7jhcHQ4INsq2sS2fJ
	AvgA2/TR11edQSZpqGLjN6/HNUAJrXsSR5FhjcndEzIN1I+jNtmEaYCMy7HmCSuGULWQ2rNSzb/
	klBvr+JE3xIIkUvHWW81OwalyQseMBY20FGPKwL+1Pz3GCER6JQ72WUfzgQ19szWfNmeng09yjf
	G9YoGb/o8AaND+5A/TtXwv+NtFgC3RuZ4Kfaa75e2m0ggzjTls6mzA71XYfeW9FeBMNxG1Fo4Oy
	ZOWU0T90af5wu6kg==
X-Received: by 2002:a05:6808:f92:b0:442:2ce:46cf with SMTP id 5614622812f47-45eb1cbd54dmr1926865b6e.34.1769200720002;
        Fri, 23 Jan 2026 12:38:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:24 -0600
Subject: [PATCH v6 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-1-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9966; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=h+Hpg7mAV/rUr3EzlDZhbxTF2vRK/83Uj6sS1/n0P24=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wQqZDKLcDnrd9zEHZlWK7sz4Ww9Io0Qzt/M
 zWhNrfZjIiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcEAAKCRDCzCAB/wGP
 wLoRB/9XMTjSOrAEY36OQZc/Jvqp2t8wG2+pZqUiEg5iibEFWrwvkqbaCp+PvRWJm9BswMRWqJ+
 A8eYOIm6WYbp6WjaowfkT6B38kqVuwdwtIU1WqEmLARZVFzJ4AHe2qYg/U7sY0kRVCemj/2gOqP
 7vaTf68UpDe0Tp57aZDLUAygTMMvxeFhjfO718dE8PqrN7DTK8PbcNtEAkTmqOBUj3pgwQVCJkE
 Vb3vImkqkDzgedxFqA0Zz2pt0wJvuXOJLE8Ab05KnIPfu4U/iaDPysJ6cwxMmzMtxKk66RmfM/x
 iBXwKAuTIzGV0feHJR28DG+uv2nWjCx3FFvyRmgqn0u7vvmb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change spi-rx-bus-width and spi-tx-bus-width properties from single
uint32 values to arrays of uint32 values. This allows describing SPI
peripherals connected to controllers that have multiple data lanes for
receiving or transmitting two or more words in parallel.

Each index in the array corresponds to a physical data lane (one or more
wires depending on the bus width). Additional mapping properties will be
needed in cases where a lane on the controller or peripheral is skipped.

Bindings that make use of this property are updated in the same commit
to avoid validation errors.

The adi,ad4030 binding can now better describe the chips multi-lane
capabilities, so that binding is refined and gets a new example.

Converting from single uint32 to array of uint32 does not break .dts/
.dtb files since there is no difference between specifying a single
uint32 value and an array with a single uint32 value in devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes:
- Added change for andestech,ae350-spi.yaml (recently new file).

v4 changes:
- New patch to replace data-lanes property patch.

In v3, Rob suggested possibly splitting the spi-controller.yaml file
to have a way to make most SPI controllers have maxItems: 1 for these
properties. I would like to avoid that because it doesn't seem scalable,
e.g. if we need another similar split in the future, the number of
combinations would grow exponentially (factorially?). I have an idea to
instead do this using $dynamicAnchor and $dynamicRef, but dt-schema
doesn't currently support that. So I propose we do the best we can for
now with the current dt-schema and make further improvements later.

Also, in v3, I suggested that we could have leading 0s in the arrays
to indicate unused lanes. But after further consideration, I think it's
better to have separate lane-mapping properties for that purpose. It
will be easier to explain and parse and be a bit more flexible that way.
---
 .../bindings/display/panel/sitronix,st7789v.yaml   |  5 +--
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 42 +++++++++++++++++++++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  5 +--
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  6 ++--
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  6 ++--
 .../bindings/spi/andestech,ae350-spi.yaml          |  6 ++--
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  6 ++--
 .../bindings/spi/spi-peripheral-props.yaml         | 26 ++++++++++----
 8 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 0ce2ea13583d..c35d4f2ab9a4 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -34,8 +34,9 @@ properties:
   spi-cpol: true
 
   spi-rx-bus-width:
-    minimum: 0
-    maximum: 1
+    items:
+      minimum: 0
+      maximum: 1
 
   dc-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..e22d518135f2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -37,7 +37,15 @@ properties:
     maximum: 102040816
 
   spi-rx-bus-width:
-    enum: [1, 2, 4]
+    maxItems: 2
+    # all lanes must have the same width
+    oneOf:
+      - contains:
+          const: 1
+      - contains:
+          const: 2
+      - contains:
+          const: 4
 
   vdd-5v-supply: true
   vdd-1v8-supply: true
@@ -88,6 +96,18 @@ oneOf:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad4030-24
+            - adi,ad4032-24
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -108,3 +128,23 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4630-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <4>, <4>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index cbde7a0505d2..ae8d0b5f328b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -38,8 +38,9 @@ properties:
   spi-cpha: true
 
   spi-rx-bus-width:
-    minimum: 1
-    maximum: 4
+    items:
+      minimum: 1
+      maximum: 4
 
   avdd-supply:
     description: Analog power supply.
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index e1ab3f523ad6..a34e6471dbe8 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -55,10 +55,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 1b91d1566c95..a6067030c5ed 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -81,10 +81,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 78093468dd5e..8e441742cee6 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -45,10 +45,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
       spi-tx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 8b3640280559..909c204b8adf 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -54,10 +54,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
       spi-tx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009db..59ddead7da14 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -64,9 +64,16 @@ properties:
     description:
       Bus width to the SPI bus used for read transfers.
       If 0 is provided, then no RX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      receiving two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-rx-delay-us:
     description:
@@ -81,9 +88,16 @@ properties:
     description:
       Bus width to the SPI bus used for write transfers.
       If 0 is provided, then no TX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      transmitting two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-tx-delay-us:
     description:

-- 
2.43.0

