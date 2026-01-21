Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE41748C8D2;
	Wed, 21 Jan 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015123; cv=none; b=nj2wHYS2MrPiTgbiDKQZ9VbDFAy8n/XRWVrGYVuaB1z6VMZ+ETk1wm/6T+9tlblDNkk8VudXqQpZ0vNUc3shsnJ+Np43rtl/ynzFoV8wFY7UjoXgVuuMaiCpiNU0DpxQzGyCqFMUZQ9tnO88fDJW+DzbZ+v7JLKlDY6QTMfcQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015123; c=relaxed/simple;
	bh=hV+yMcLikSv6LtJ6DBMweIyTce5pGRA3uSUQWArDX8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMEHJZm2wKEW2s8ax+YGcNQBgmWEes4k1/IwTGfIx21l3MJvtm5AsI7n6n5fCmZz7Ow5ZfUOMqUUUmbbohJMAlGgwU8pML/3pjB3pRkCHV3qm9lFy1AaZwzUOsBo+PH6AwOrIIc9kD9rKAZEdUHZf1cK33NqFAniMLSsg5z6fx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yuERPHQp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yuERPHQp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 677DCC21A90;
	Wed, 21 Jan 2026 17:04:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B8F06070A;
	Wed, 21 Jan 2026 17:05:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51A35119B1874;
	Wed, 21 Jan 2026 18:05:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015118; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5Kj6ETSNf5AkrmQzs+0Qf4EJ+9HnqSnNyo5Un85LJLs=;
	b=yuERPHQp/NwQV2R5l2fwJUWIelMhbBo2r+psMK2XjPFCtl7km9JdQkqMlMx79hL+sw+Q6q
	UbvhHPqP5do8Gw90im/dpoebjPllnMl0ApR+1w5/qX14IxadErbWqTw0619VVOy5N9j2nD
	SpKUqUnwK7cgwZS30bTFOrHBLyH/HM9UFtRPoJo46tZfB81cOawTJ59+7qwKgrPAM8nmDP
	i0PqbIYqJ9nZnKD10YIB+svJ5UTc5fN+ecSr6/NxqBkN3nYvmx7H67dTQZKbZDbDxhiEva
	BR7lyUo9OqrGXmYnSzc64ho8l4VaelTeHyvlL2HAymxDAKFyKru5JOAAfYYoqQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:05:00 +0100
Subject: [PATCH v3 04/17] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-4-43e70fab4444@bootlin.com>
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add support for the Renesas RZ/N1D400 QSPI controller.

This SoC is identified in the bindings with its other name: r9a06g032.
It is part of the RZ/N1 family, which contains a "D" and a "S"
variant. IPs in this SoC are typically described using 2 compatibles:
the SoC specific compatible and the family compatible. The original
Cadence IP compatible is dropped because it is unusable on its own.

Indirect accesses are not supported by this flavour of the Cadence IP,
which means several properties have no meaning in the scope of the
Renesas compatible. Let's make sure they are no longer expected nor
mandatory.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 33 ++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 62b97ab607f3..fdb25d16a8fb 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -61,6 +61,20 @@ allOf:
         cdns,fifo-depth:
           enum: [ 128, 256 ]
           default: 128
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzn1-qspi
+    then:
+      properties:
+        cdns,trigger-address: false
+        cdns,fifo-depth: false
+        cdns,fifo-width: false
+    else:
+      required:
+        - cdns,trigger-address
+        - cdns,fifo-depth
 
 properties:
   compatible:
@@ -80,6 +94,9 @@ properties:
           # controllers are meant to be used with flashes of all kinds,
           # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
+      - items:
+          - const: renesas,r9a06g032-qspi
+          - const: renesas,rzn1-qspi
       - const: cdns,qspi-nor
         deprecated: true
 
@@ -156,8 +173,6 @@ required:
   - reg
   - interrupts
   - clocks
-  - cdns,fifo-width
-  - cdns,trigger-address
   - '#address-cells'
   - '#size-cells'
 
@@ -224,3 +239,17 @@ examples:
         cdns,fifo-width = <4>;
         cdns,trigger-address = <0x7fff0000>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a06g032-sysctrl.h>
+    spi@40005000 {
+        compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi";
+        reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
+        interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
+                 <&sysctrl R9A06G032_HCLK_QSPI0>;
+        clock-names = "ref", "ahb", "apb";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };

-- 
2.51.1

