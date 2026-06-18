Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDA30BF66
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805810; cv=none; b=KOlNWitzETrt0n0ej/zEYcNe6clsgr8OQqs2+U3oV7UTzV1ucKgRA16NAMeZJ9wV492ubSN+PZN6nn9yr+hdaJCeuonLrVM63hkmj0Xj7PhRvYeorQBCtqdjAGtoIjgpMuSENPr0P/kjcx+/zjdRvuxLd0QKkNSlfNwga6tzdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805810; c=relaxed/simple;
	bh=oGC7L5TtVt/RanN5pjTzlERB2K6nlzG3KqEBZucZ1/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkAbRR7I7+drXqKaMaRvRKDHpCSbrrdGcUKsMhFpnbqBARmZoJvX0N9fNXs5BaHKxeyx/FoHZYRP1teRLEYgkfToL+Q9EmmURDLJUTo4EsdGnL7QZuq68l11Tr85/VVQQ/3wzUW70++niqWbOxfcCfOKUA/z5ue0y0be8ZTTISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJfdFTfP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJfdFTfP"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c89636920a3so458829a12.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781805808; x=1782410608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grMDKhiWxgS01CbGWcoqJuDZbxUtQgSQcTHTndsyXt4=;
        b=AJfdFTfPwWtd+G/9mPnqx91Dngwnte5ne1crVfz5tTeRPBek3jxgFIQvRlbbxIpvy3
         NiBr8+XhstASGwA7iHGTVTjwjVb3NRy3/H4cXUTksEdSlZhZWMRvtlXDjm1cAtAUh2FO
         kXUmdZNtxc2y44QbwwnKNhnLX4X1AI1NqfWro2P1YOz+6HAVPopDmdVinpgh20rjnecE
         66rdAW7nqSzFF4nEJU7QjeDvvkVy4yeFnfHakq1M6gI1SGOWJyRjwWUwKT73yYD9AE1J
         9kRJxfda5Woe893NdJg1msygIt4QyM3rgopwvEfUREQdUjKIg9DAUYOc/tnqRlY/2d0H
         QIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781805808; x=1782410608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grMDKhiWxgS01CbGWcoqJuDZbxUtQgSQcTHTndsyXt4=;
        b=Ak2HZ1ojWoD4JuKgBbyUqYvSc7pqfm9idXv/cDiz1D4ml8KfNrwisQ+mkRCxLPelsl
         2K3Znee5JAJuUN8qBGiLsWKSQSYcDpUgR8Je8uPUIxKmlLieOaItq/5qLExv9jBDOCrM
         9fvzF1wOJx+HRBN6sdF1lVESaC8kIMtldXFmr9DXd/Zlq0qlDz18/Le6JWOo29Kgc/h7
         76RpK9bvTGUCpBvpLoz73EyvC3VaRkrr5tC1I2Kjk5XJLOJvy1ag/0C0tb5PMDedq7Db
         vktoAwEN/bFeb8k5rxY7EpPAWfzlpjvmO6C3ehTCsgujYqNi2JuPoeAwkNtseNcImUGk
         cvdw==
X-Gm-Message-State: AOJu0Yz7afrakbm34TZkcVuQz3fR/gWmqqE2Ab7QvIZBmoIncmlpD+f9
	+Kkod+wZuVGQ3WMui1xGHjzAZqrx0FTx1H08MS4pjbVxhG2Kn+w3pq5c
X-Gm-Gg: AfdE7cntU5KzBMiktPSEFtaPVNGh8GJWaFhizxbh5MI0WlJnKQdzcGEyyZovY3BmHnu
	yYehEdi85bd/vTt5ioinxQpXN7mBje8EXyPrnL1zxlXHa2m75iINiY3P42o4cvQ95esk13+7hSb
	FK6NxFo+YdTNOvDpnFMyNxQKnJzQIw73n7xS+3Qs2w7/LmTwPFxlD5TgushnIr74ZvAV1iDJrG5
	tiCiCc7MhXSe4DbElqjCPsC4E/pBVbY16LXigetlMZ6y3O1Yl6NVII+RwqJllBAvG+Kgh6FG4dk
	l64/k0B8k07WDWpYabzJdZWMr32IfFcJfTqvia8c+TErXuk3TaPMUnTWFnMm1o0e8mrtUkkkmpB
	8PpVPTMRH2p4qpM6Qd5wqpD8eH7u5lpXjTnE706tmKoFwP2pFjjAyVEMhN8bWsC3oN9uFUaXnSV
	QIflw3ed3UrKGwARRs0bjSu8XcP7tO0GzUBsrQMnT15Q0VH80XCsA5c3Qjgwp/y2YQRfnOXA==
X-Received: by 2002:a17:902:ecc1:b0:2b0:608d:d8a8 with SMTP id d9443c01a7336-2c718cc4b81mr2759425ad.1.1781805808229;
        Thu, 18 Jun 2026 11:03:28 -0700 (PDT)
Received: from fedora ([103.181.54.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6be262b93sm64348865ad.68.2026.06.18.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:03:27 -0700 (PDT)
From: Ninad Naik <ninadnaik07@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	david.daney@cavium.com
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Ninad Naik <ninadnaik07@gmail.com>
Subject: [PATCH v3] spi: dt-bindings: octeon: Convert to DT schema
Date: Thu, 18 Jun 2026 23:31:49 +0530
Message-ID: <20260618180149.475658-1-ninadnaik07@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert octeon-3010 to DT schema

Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
---
Changes in v3:
- Change the maintainer from David Daney to Rob Herring

Changes in v2:
- Change the maintainer from Mark Brown to David Daney.
- Use soc node wrapper instead of root node in the example to handle
address-cells and size-cells requirements.
- Remove interrupt controller provider from the example.

 .../bindings/spi/cavium,octeon-3010-spi.yaml  | 61 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-octeon.txt    | 33 ----------
 2 files changed, 61 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt

diff --git a/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
new file mode 100644
index 000000000000..f0b708e1ccbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cavium,octeon-3010-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cavium, Inc. OCTEON SoC SPI master controller
+
+description:
+  The Cavium OCTEON SPI controller is an SPI master controller found in
+  OCTEON SoCs.
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: cavium,octeon-3010-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@1070000001000 {
+            compatible = "cavium,octeon-3010-spi";
+            reg = <0x10700 0x00001000 0x0 0x100>;
+            interrupts = <0 58>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom@0 {
+                compatible = "st,m95256", "atmel,at25";
+                reg = <0>;
+                spi-max-frequency = <5000000>;
+                spi-cpha;
+                spi-cpol;
+                pagesize = <64>;
+                size = <32768>;
+                address-width = <16>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-octeon.txt b/Documentation/devicetree/bindings/spi/spi-octeon.txt
deleted file mode 100644
index 431add192342..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-octeon.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Cavium, Inc. OCTEON SOC SPI master controller.
-
-Required properties:
-- compatible : "cavium,octeon-3010-spi"
-- reg : The register base for the controller.
-- interrupts : One interrupt, used by the controller.
-- #address-cells : <1>, as required by generic SPI binding.
-- #size-cells : <0>, also as required by generic SPI binding.
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@1070000001000 {
-		compatible = "cavium,octeon-3010-spi";
-		reg = <0x10700 0x00001000 0x0 0x100>;
-		interrupts = <0 58>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		eeprom@0 {
-			compatible = "st,m95256", "atmel,at25";
-			reg = <0>;
-			spi-max-frequency = <5000000>;
-			spi-cpha;
-			spi-cpol;
-
-			pagesize = <64>;
-			size = <32768>;
-			address-width = <16>;
-		};
-	};
-
-- 
2.54.0

