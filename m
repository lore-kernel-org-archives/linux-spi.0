Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A783E2ABA
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917379; cv=none; b=hABzvpv4QamUpn6oSdkZEfcz1tbyaWF/hNLEeZ/snf994n5qJ86Co8hxUCTU36UoZ2EU3apXGqbD+nd4c9MEPemHfGE7SFky5gED3rGb+tzkAJ4ZGmAd8KPG/iz16wxDtxdgAhkgOUsjpPDZvnFmq1bYItNx0J50N1h+xwOzPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917379; c=relaxed/simple;
	bh=/zVpg1CccNxq2uZbj+73+VsP1dk+Mxi9XXjr+VzDYGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DrVDkz787mSPKRvvChK97eBgPkS/z1fbsMtwsBYD1OME2BmbaToknsMmqAqvDKW/GEEW+LGng8+Fmr/jwszM44p93lZcN8UuMqfomSTNKAd/VsChQ4WHhqWCHyqC/Acf4iT2Y8V9BKnLuOG93TmnFGiUkZ2fz60sgnOUgewPy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBCN6hVy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBCN6hVy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d5862bc921so1517215ad.1
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786917377; x=1787522177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O180+pg027B8ZaRGPW3uwegO/XOQQBIPH2jwBsrM9lU=;
        b=YBCN6hVy3AezogqSLC3gh3iGar32yVXD9aKAnwNBpFZuQLTcXWHE2ELfIVBf4LOYPh
         JXmfHzpVTD0vH/+d0z0Ca5Tk+PHfRVlkI48FDhk6Vmp74NPpoNTtqiE0KQzTYVClaHPd
         utORoV2Ju43MeWUeCJXjKfXxeO1o9bTL76LewjnHlT3Mg0X4MxupNsllY8a1zRZzhbTh
         penYQS7V+8BmLvUCb2TXiy/ojYgx2sB1WsSthMXyZ+7KZ3BW0nv18+YpdqzlrqYlW8cu
         /E/Bl5jdV9k57DVO6V5OzIsVkI38NlBffShBuG6KPo+4fSHQ9LPbrQEsbuZo5Jzy7E2y
         Cq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786917377; x=1787522177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O180+pg027B8ZaRGPW3uwegO/XOQQBIPH2jwBsrM9lU=;
        b=WsocBnOzfalgOJabL8RC+sqYN4sW8Pdqxy5TsmJZvmbY1w4LhpkUmTXSOnOGfVm17i
         Fvy6mKbUHbT5cLnFLOKpuWl6A22RzX0rSXA8GoDcOqNrCKIaH8WBAPFwLCcRMjiNT/NH
         aK/fRp47sl+BUDg4rSRlJJCVdlK0A+upPkvcmJaa/+5ie3nUqgeJomSu43MHKMNPHlUv
         H3rl8cVBIHAef4c6h5B+aP7HDzoEd1jd6ZkFIXQ/zRQ73y+lEa1FSyS0hffIJHiZyZix
         1o0d9L+UBdao0m8DrZjQQL1Htt0nDTfgquqXu2bFrGxMUl/a1Lwb8BYEmFCUAoyk+LgD
         3bxQ==
X-Gm-Message-State: AOJu0YzjMbbV5eHfMbgiQnRveEzUbuaK2q0NwHDnroSEgtg9C44E5IV2
	PpkB5/mUDqUWKvvDQ/GypTTScg8ccvsB5jsQAved7q8CjT1FaJ6LRUp8
X-Gm-Gg: AR+sD13Leoe8fuovwJvAId03qRfPzsnQiwbwEkLKPuYwxOoxbodba8vxVXm9ihBbMcC
	MDNQE3FgvILvmFB/I2DvMl4Gc/wP/vbtkZ0wZml2vi0TnCj6h6roFMkAkFWZCzqFuJm0JcttpoO
	4RDF7eScSRtUAHCcxmF+p9ByYx/KWp/Vg4c/Xh+8qBdJr/rhKe8Jc19Zzyp7u8vj29vcUStwS+c
	AyvRUiSBGW0kIWmwOfAIMM5s21rpF9yp0vnb83t9flBApIoUS+Ntvs149fHkHUyFjFCuyzNLJ7G
	O8j76IxdMFYjpnQj6cnZanv4n+dJdNp03ubKZdpCg9TyVmP8OjHlr32enD+HnyX0Hs4Zq94iq+9
	jhSLs50KC8EVRikai2P9NsUJAgf3BXg6NNmy1I40LJWN3OWFEpxqZTR0vu3Klyn9C5lEfmMsu29
	XdmoXPNRN1O0eDym+6dQMItl3ZO07dYIwE8/BT+KvcNU0bnHu1cerbervicHoZNNsykBn2i0WAd
	g==
X-Received: by 2002:a17:90b:35c4:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-3933b8c4c87mr15487152a91.3.1786917376578;
        Sun, 16 Aug 2026 14:56:16 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:504e:1c5e:cbdf:b953:2369:869e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm30168318eec.10.2026.08.16.14.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 14:56:16 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Mon, 17 Aug 2026 03:25:26 +0530
Subject: [PATCH v3 2/2] dt-bindings: spi: ti,davinci-spi: convert to DT
 schema
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ti-davinci-spi-v3-2-23844cfb5e6a@gmail.com>
References: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
In-Reply-To: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786917340; l=9742;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=/zVpg1CccNxq2uZbj+73+VsP1dk+Mxi9XXjr+VzDYGI=;
 b=ZliuSqiZHLfwNTHgXM1xP7wJBe0D+XLjexZuqtkvFbJgWUR8nOfdQl5N/B//QqumPoZbyENqv
 Svaujf+lZgYC9AKThC3jLG1nMm1efu9I/AT9OPu8NjvmMbhrgilNANN
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert the TI DaVinci/Keystone SPI controller binding from text format
to DT schema.

Changes during the conversion:
- Create a separate ti,davinci-spi-peripheral-props.yaml schema to
  properly define the ti,spi-wdelay peripheral property.
- Add missing dmas and dma-names properties.
- Add constraints to ti,spi-wdelay based on the 6-bit width
  of the SPIFMTn.WDELAY hardware register field.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 124 +++++++++++++++++++++
 4 files changed, 150 insertions(+), 100 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
deleted file mode 100644
index f012888656ec..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Davinci SPI controller device bindings
-
-Links on DM:
-Keystone 2 - https://www.ti.com/lit/ug/sprugp2a/sprugp2a.pdf
-dm644x - https://www.ti.com/lit/ug/sprue32a/sprue32a.pdf
-OMAP-L138/da830 - http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
-
-Required properties:
-- #address-cells: number of cells required to define a chip select
-	address on the SPI bus. Should be set to 1.
-- #size-cells: should be zero.
-- compatible:
-	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
-	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
-	- "ti,keystone-spi" for SPI used similar to that on Keystone2 SoC
-		family
-- reg: Offset and length of SPI controller register space
-- num-cs: Number of chip selects. This includes internal as well as
-	GPIO chip selects.
-- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
-	IP to the interrupt controller within the SoC. Possible values
-	are 0 and 1. Manual says one of the two possible interrupt
-	lines can be tied to the interrupt controller. Set this
-	based on a specific SoC configuration.
-- interrupts: interrupt number mapped to CPU.
-- clocks: spi clk phandle
-          For 66AK2G this property should be set per binding,
-          Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
-
-SoC-specific Required Properties:
-
-The following are mandatory properties for Keystone 2 66AK2G SoCs only:
-
-- power-domains:	Should contain a phandle to a PM domain provider node
-			and an args specifier containing the SPI device id
-			value. This property is as per the binding,
-
-Optional:
-- cs-gpios: gpio chip selects
-	For example to have 3 internal CS and 2 GPIO CS, user could define
-	cs-gpios = <0>, <0>, <0>, <&gpio1 30 0>, <&gpio1 31 0>;
-	where first three are internal CS and last two are GPIO CS.
-
-Optional properties for slave devices:
-SPI slave nodes can contain the following properties.
-Not all SPI Peripherals from Texas Instruments support this.
-Please check SPI peripheral documentation for a device before using these.
-
-- ti,spi-wdelay : delay between transmission of words
-	(SPIFMTn.WDELAY, SPIDAT1.WDEL) must be specified in number of SPI module
-	clock periods.
-
-	delay = WDELAY * SPI_module_clock_period + 2 * SPI_module_clock_period
-
-Below is timing diagram which shows functional meaning of
-"ti,spi-wdelay" parameter.
-
-             +-+ +-+ +-+ +-+ +-+                           +-+ +-+ +-+
-SPI_CLK      | | | | | | | | | |                           | | | | | |
-  +----------+ +-+ +-+ +-+ +-+ +---------------------------+ +-+ +-+ +-
-
-SPI_SOMI/SIMO+-----------------+                           +-----------
-  +----------+ word1           +---------------------------+word2
-             +-----------------+                           +-----------
-                                          WDELAY
-                                <-------------------------->
-
-Example of a NOR flash slave device (n25q032) connected to DaVinci
-SPI controller device over the SPI bus.
-
-spi0:spi@20bf0000 {
-	#address-cells			= <1>;
-	#size-cells			= <0>;
-	compatible			= "ti,dm6446-spi";
-	reg				= <0x20BF0000 0x1000>;
-	num-cs				= <4>;
-	ti,davinci-spi-intr-line	= <0>;
-	interrupts			= <338>;
-	clocks				= <&clkspi>;
-
-	flash: flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "st,m25p32";
-		spi-max-frequency = <25000000>;
-		reg = <0>;
-		ti,spi-wdelay = <8>;
-
-		partition@0 {
-			label = "u-boot-spl";
-			reg = <0x0 0x80000>;
-			read-only;
-		};
-
-		partition@1 {
-			label = "test";
-			reg = <0x80000 0x380000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..cb5d608998e1 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -155,5 +155,6 @@ allOf:
   - $ref: fsl,dspi-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
+  - $ref: ti,davinci-spi-peripheral-props.yaml#
 
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/ti,davinci-spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/ti,davinci-spi-peripheral-props.yaml
new file mode 100644
index 000000000000..1060f176c6cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,davinci-spi-peripheral-props.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,davinci-spi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DaVinci/Keystone SPI Peripheral Properties
+
+maintainers:
+  - Bartosz Golaszewski <brgl@kernel.org>
+
+description:
+  Peripheral-specific properties for SPI devices attached to a TI
+  DaVinci/Keystone SPI controller.
+
+properties:
+  ti,spi-wdelay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 63
+    description:
+      delay between transmission of words (SPIFMTn.WDELAY, SPIDAT1.WDEL)
+      must be specified in number of SPI module clock periods.
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
new file mode 100644
index 000000000000..5bf74f3ca588
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ti,davinci-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DaVinci/Keystone SPI Controller
+
+maintainers:
+  - Bartosz Golaszewski <brgl@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - ti,da830-spi
+          - ti,keystone-spi
+          - ti,dm6441-spi
+      - items:
+          - const: ti,keystone-spi
+          - const: ti,dm6441-spi
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
+  power-domains:
+    maxItems: 1
+    description:
+      Should contain a phandle to a PM domain provider node
+      and an args specifier containing the SPI device id
+      value.
+
+  num-cs:
+    minimum: 1
+    default: 1
+    description:
+      Number of chip selects supported by the controller. This
+      includes both internal and GPIO chip selects.
+
+  ti,davinci-spi-intr-line:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Interrupt line used to connect the SPI IP to the interrupt
+      controller within the SoC.  The SPI peripheral can route its
+      interrupt output to one of two lines (INT0 or INT1). Set
+      this based on the SoC-specific wiring to the interrupt
+      controller.
+
+  dmas:
+    items:
+      - description: RX DMA channel
+      - description: TX DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  "#address-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - ti,davinci-spi-intr-line
+  - num-cs
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          const: ti,keystone-spi
+    then:
+      required:
+        - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@20bf0000 {
+        compatible = "ti,keystone-spi","ti,dm6441-spi";
+        reg = <0x20bf0000 0x1000>;
+        num-cs = <4>;
+        ti,davinci-spi-intr-line = <0>;
+        interrupts = <338>;
+        clocks = <&clkspi>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <25000000>;
+            reg = <0>;
+            ti,spi-wdelay = <8>;
+        };
+    };
+
+  - |
+    spi@41000 {
+        compatible = "ti,da830-spi";
+        reg = <0x41000 0x1000>;
+        num-cs = <6>;
+        ti,davinci-spi-intr-line = <1>;
+        interrupts = <20>;
+        dmas = <&edma0 14 0>, <&edma0 15 0>;
+        dma-names = "rx", "tx";
+        clocks = <&psc0 4>;
+        power-domains = <&psc0 4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.55.0

