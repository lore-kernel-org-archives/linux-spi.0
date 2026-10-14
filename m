Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F097B4915B1
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962600; cv=none; b=OCmJsoAL6w6Ky1mFzwlA6exR89gKINxAjWuA6+UmuJHyuqrhqqwwfUZX6XA6OttG6j85s7KWcBsTDNAL7k/41kQ4ubWKFMJNMSvZHHY+0nudBf+gzEPUljjWEDXeFKPUuLByIPZfyRAhWw6AOEhudMEyT20g5fqMrSXgqW/KlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962600; c=relaxed/simple;
	bh=CeyU9HOfdIbNHxLPEk/FyCv98GowCMXlUEEA/1i+ud8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEwspoBVZQsgn+RHL7WMdt6fBZGpjZQYOU7Yj22l5HjsjzArCXT3JLvtyMZ7rJpgw02bS7P4MFNkJOwNS5N6EqiGQDqwFNgB283H9/mkQAjChQzjtp8wWMpJys3/fFtcRLW6d4K0EhC+FQWjcSzLoR4QbGmqJEjW09eaL4D7AjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKjHhe8z; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKjHhe8z"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b060ec084so2417608f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962594; x=1792567394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7VKM0kGySt6jsEqGEdmnsrJTxTzNoBKKYUnpSNyRaA=;
        b=sKjHhe8zrM4SDZBtePkpBGaONTOifz6eRBsHidFxPYnmcoIiOcKtzcFT5sgwxsaC6Z
         BJQ3LVzU/lJB/+z//iB/phhQGmMRJJMpyRkGkbrgm+ND67WNXrH2zrNmqsMjK7YNTtz2
         uJI4bBCHFCBvcRNBGg16GYVuTGWu5n01h/znObUNI8ascYru5YsHfpRQ65CDFKmDs5QX
         Ooxp0PiD70vlFz3FBPGgozgOmCv6hpFEqJipynd0hZB2RTNXpZlyAZrUmKTg3I/HTD4j
         FJH0k2bDju62p+2LaqEGJI6zJDOelukJ8k4/iXNT34pRyksM+JU071jx1UG8Q7fWhOIC
         RNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962594; x=1792567394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7VKM0kGySt6jsEqGEdmnsrJTxTzNoBKKYUnpSNyRaA=;
        b=sMK92lCsHs5nO8JU1hBIK5zvsclKRkx+homLBPkDJN8q/1YwkGUq108snxkq1tYNN0
         xFWI3CCJRIz5o7075/tbOzRNXvpPCzcUGNfbB8iyzuzMhrvC/bXK/WitkoXfTu8M0Zrl
         452GIudAFsVSBmyIh2W6OhqXTnxi2QP4xVRxCU4cVGvSvhibrbrBKo51ZtrlMMOIRhTV
         hh+TAd6vASJBWw+F5K7r2KsF9S946m3SCfj7nfolCnMQlXu9/+Xm8XiZalgMq/KlJTOB
         m7j2/ceKF/ZHXy3SYYYVBK/4Kceaid35NlI3dmB8OlG6skrw+RUl4HcP/60io5Yp1JAd
         DrsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx131gRcyIGmMR3zT71PCGU0CfP5tbN+zGVt4AedUzDYtn0JnwudU8jHs1ouy4t7arUiIFGoLKBgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbR1l4LN9XrLZdcnD4r0x7I4DYnM/AOW14eJD2CwMqtuMny2MD
	fWO7GlAyD2N6DlzQn5uC1qFBDbnagFPcIUJCcBFPWrp1pwRSUZolVyJk
X-Gm-Gg: AYBFou0RmxG18K64Hwx0gUQbGbiaUBE8qVAu1UYuaME7AmDW5S1SAv1pP9WmbxunFO+
	8FkS5Lp90QYhz/gewbDIHduuFrc+Us3IyTyZ+mogSSgpNkm+JlRWmuAsgk/lcTBvJQSrlFFxuaP
	T4jNP1Fv/igG06sGmWggudPA5DfOby1ySLZK+YXWOe8CJ9x1yUb6CMwU44RwnYyF+g+PqSFVFgz
	V3BsMT3hu1JnS3lgjOa6RWI0Dp4KODrvyhOmWk202GoX8DwndS3JBbI4P5g18uUsmXpnzCgz+O0
	WyTpxtjHo2befKLpUbCeKbHdmuPIPukam1CvlTMWoZrUIKdlmgA/LyH0SxisNFRuJDHjqNSGxar
	BhFp415J8w2lPEHsrCTq4yRbNQOidVqTknoiYmH/+m2NPTRYnK9qqCz1Azga1U9ePrf9etrUYyz
	a/p6iaWXrteiqO/Gmu8eHCNO4Th704CS1Sgpp5b9zDmd7PDoL2SgdQrnvpw6LhIPymfccV2aNUJ
	OS0rLVbrfH2k8OkGQz+FFt+J1K7LUBesM4LI1dP0/NGCp6HMp+WgFhAx8l/02XTRWvMDDt8AEMW
	6KsYKW3nEmoNildZNHeJgJ9xHMS0qUj7bxBuu73lGBePkttXI1sh2+TTFNMY0g==
X-Received: by 2002:adf:e80b:0:b0:487:342:d141 with SMTP id ffacd0b85a97d-48dbaae8b8dmr21050586f8f.23.1791962593943;
        Wed, 14 Oct 2026 00:23:13 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:13 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash controller binding
Date: Wed, 14 Oct 2026 08:20:59 +0100
Message-ID: <20261014072109.1759502-20-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Device Tree binding for the ZTE ZX family SPI flash controller,
supporting both ZX29 and ZX279128S SoCs.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 .../bindings/spi/zte,zx279128s-spifc.yaml     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/zte,zx279128s-spifc.yaml

diff --git a/Documentation/devicetree/bindings/spi/zte,zx279128s-spifc.yaml b/Documentation/devicetree/bindings/spi/zte,zx279128s-spifc.yaml
new file mode 100644
index 0000000000..201fe46b2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/zte,zx279128s-spifc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/zte,zx279128s-spifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE zx279128s SPI flash controller
+
+maintainers:
+  - Stefan Dösinger <stefandoesinger@gmail.com>
+  - Navid Ghahremani <ghahramani.navid@gmail.com>
+
+description:
+  The SPI flash controller of the ZTE zx279128s runs flash operations (an
+  opcode with optional address, dummy and data phases) on one chip select.
+  The data phase can use one, two or four lines.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - zte,zx29-qspi
+      - zte,zx279128s-spifc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: work clock, the source of the SPI clock
+      - description: register (APB) clock
+
+  clock-names:
+    items:
+      - const: wclk
+      - const: pclk
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/zte,zx279128s-crm.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@94406000 {
+        compatible = "zte,zx279128s-spifc";
+        reg = <0x94406000 0x1000>;
+        interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&lsp0crpm ZX279128S_LSP0_SPI_WCLK>,
+                 <&lsp0crpm ZX279128S_LSP0_SPI_PCLK>;
+        clock-names = "wclk", "pclk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "spi-nand";
+            reg = <0>;
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
+        };
+    };
-- 
2.55.0

