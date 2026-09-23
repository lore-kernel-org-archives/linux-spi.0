Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990547F3D6
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203387; cv=none; b=UfBLnsBoRnk25Tw2ISKwBv1BwyyvrYAQPkOy83hVrzItjRhRwVVJArCmyeoWzOCE1a0/akVuJEW7aHFJ2zfztL2QSb1pR4xOXT6Jh1BrpvC9uUNqSeP3cAm2n4p0zI9kbHqskG9Fr2pGLAJuwSxO1S9qaIGy9B5ovM0RVDZtpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203387; c=relaxed/simple;
	bh=mlJx9ThzJFLUhajDVUTvdhWrZvQwfqaHhk1+paidAG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n1CjdjtKOFFI1ZxWXJWtPnN+vkJXl6d7Hkl9QTklHac5uDWsXjjPzHD5d3qTXdCqoVZPKYRTxXS2J69uuCmWfFHD+6RWgzJaFE12Tk/O2BqLAbiKtU4PJKvdDL7+UyEuCSHpiFGNE34qimvjoR5oVCRk1qLwJguKe85vB74sDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFjxGyHr; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFjxGyHr"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39e4a0daf4eso232098a91.2
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 15:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790203385; x=1790808185; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CZIA5ePGlTpEIKFyAUN7CPZp3Kr0IYcWKcmwyEbriD4=;
        b=HFjxGyHrzVyPHe2rFKpbebRsMNVsMPczwryJJB+ASN6TihWHHM2bLTd+QEZdbHgKiv
         5GhDiee3VPQ5Xjk/wUA0jnXlmskXqSEh/k/DibolYcQvXdr8Pm/CVWLLqYnfuEthMPzn
         jTyeK5H3z6+650R5z+T7KOBB0WcAg+JyiiiVKK5Z/HxMzKdmISuacBs+he8QquwdfcJC
         OumOctbQN6Wv3u2YpS5791n9rx75634ydk+m71RHBxbadxKdikn7ft+4mbe3oWhnpGbk
         x/5uhNwX1udxRFPp09yeKGNes19LYvS7wcyJ5YSqD+6bAgNVJD5FIeKkqh66W99SaGTh
         UlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203385; x=1790808185;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CZIA5ePGlTpEIKFyAUN7CPZp3Kr0IYcWKcmwyEbriD4=;
        b=eX1lIV/dFNt4ArXE2MkcC1Cfzgi7XQoyPRYydAILj4uhoqHl135c77/92d0sJXX7Zy
         r/il7sTUhlybvhgcPPizH+0jsu89C5ejpAAlSOSpNsK020+fHXx3n6YfncWHpwr5jIGw
         92/l+ExwnF2NwjQCZk8mwChpOICAUlP5Oy36iXLTDLc18kCRwWKWJj59PZDhPlAL+Sck
         cLEbi1N7C2Ay3Gt3vD+RHXYclynuVT8e+ngBa1ZX+t3XCJLW95DQvZGlldvDD9+Ljo7M
         k+1z8E/cpr1c0TvkcmADMr8ZlHNQBOlBlM2otBjHKoUrw7suIrOPsMvcrWhyJJIqgvk5
         MzAQ==
X-Gm-Message-State: AFuF++lFuU777Qu9R/7RvHtgJGK5TOot41lUBYKmTkdTMy4knT9/VZlR
	6YOyymFnUccJeg7viJQyD3QoAgDpVsHzG1pR/3p6x4enhiKJxXDMHdfE
X-Gm-Gg: AYBFou2y5mPQKvg7bpqySqO/u20tYkmCTsLkKolM0FPbKNtvcqzWRj9BCkG2yOTGRFW
	yBy9qDPZnd3h2zg57tMaw83iPGGY7h8peUy4pQXEGi3XFgKOM4ZFGZ8fAVSDhVvVI116n/57l5v
	sxmRhs7+xZBBpX3bVfWuY9Y4GTg7tBEXJuZJL4GMMuxeNLLqynOIhIzKFU/TZ4CmqZtc+EA9bN3
	kuywWVaU0YrKNApF3Cch0zl4tixr1fDvpQx1PdHw157HXn3US4qVtxO16aX0Jm0RcgkS7oVAiuk
	P6VLIQsQ6UNiOfzivTz3U+ey+0T8s1mO8NMWTgUB0dBNLx+36K+Br/t/bAsNvLgF7tvrJj+cF1c
	wv7jjDBlIPXshkvOytugYz4AWI8T1oWLE3Qpk/Z3Mja3lLpQLhb58baHsBBGpZx44/77KFquZNX
	IgmfVMRLy4ZdDP4kNnTYIXaV8UtzJlohbkI4Es7O09bNWfhfpIuWvosQqdtlJg1c5ok8lvKgBDX
	T2XTJE=
X-Received: by 2002:a17:90b:3143:b0:3a0:60c0:7f8f with SMTP id 98e67ed59e1d1-3a098643a13mr786844a91.0.1790203385314;
        Wed, 23 Sep 2026 15:43:05 -0700 (PDT)
Received: from [10.197.48.252] ([2409:40c2:5047:8a3f:9ef:734:1515:aac8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09738f2absm1106830a91.14.2026.09.23.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:43:03 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 24 Sep 2026 04:12:40 +0530
Subject: [PATCH v5] spi: dt-bindings: ti,davinci-spi: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-ti-davinci-spi-v5-1-ed811dc6cd89@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Mz4rCMBDH8VeRnDeSTJNp62nfY/GQPxMdWFtpJ
 CjSdzftRVF2mdNv4PO9i0wTUxa7zV1MVDjzONRhvzYiHN1wIMmxbgEKUHUa5YVldIWHwDKfWRI
 aqtd59CgqOk+U+LoGf/Z1Hzlfxum29otevn+mipZKujbZNqZoAeH7cHL8uw3jSSypAv9zqBwDJ
 qtbbQD8O29eefvBm8qh6YwJyVtC987Nk/dKf3BTeQ/UB+WBdDSvfJ7nBxbqHohpAQAA
X-Change-ID: 20260816-ti-davinci-spi-e64e4e48b6b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790203367; l=11160;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=mlJx9ThzJFLUhajDVUTvdhWrZvQwfqaHhk1+paidAG8=;
 b=ybD9wA5D8ZVdWrWWvhexlX1Z2bDFJJt/EfuOXmMAk0ig5EeGChOs3c57muOtvruVAkjExsm1R
 W1S/2UXJ5ZHADbUVHS8YvxgToHmOvzhF5NILBgESrxIuTs53PEr61MY
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v5:
- Drop applied patch 1.
- Use items in compatibles in if/then for ti,keystone-spi.
- Rebased to latest mainline RC
- Link to v4: https://lore.kernel.org/r/20260901-ti-davinci-spi-v4-0-92e9c0b2e1d4@gmail.com

Changes in v4:
- Fixed spacing in example.
- Fixed commit title.
- Rebasesd to latest mainline rc.
- Link to v3: https://lore.kernel.org/r/20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com

Changes in v3:
- patch 2: since old text binding required num-cs, #address-cells, and
  #size-cells mark them as required
- patch 2: davinci-spi don't work as spi-slave i.e address-cells 0 is
  not applicable and spi-controller permits both 0 and 1 so explicitely
  define #address-cells as 1
- Link to v2: https://lore.kernel.org/r/20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com

Changes in v2:

- patch 1: Instead of deleting ti,davinci-spi-num-cs, renamed it to
  num-cs to properly preserve the hardware's intended chip select
  limits 
- patch 2: Removed  maximum: 6 constraint from num-cs.
- patch 2: Add standalone support for ti,dm6441-spi in compatibles.
- Link to v1: https://lore.kernel.org/r/20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com
---
 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 125 +++++++++++++++++++++
 4 files changed, 151 insertions(+), 100 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
deleted file mode 100644
index f012888656eca..0000000000000
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
index 880a9f6245667..cb5d608998e18 100644
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
index 0000000000000..1060f176c6cbd
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
index 0000000000000..1c7544d31fb96
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
@@ -0,0 +1,125 @@
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
+          items:
+            - const: ti,keystone-spi
+    then:
+      required:
+        - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@20bf0000 {
+        compatible = "ti,keystone-spi", "ti,dm6441-spi";
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

---
base-commit: fe2ec83746e501645709761605c2464a44fd2929
change-id: 20260816-ti-davinci-spi-e64e4e48b6b6

Best regards,
-- 
Bhargav

