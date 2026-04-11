Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7E37E2FC
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833504; cv=none; b=tvTEDqW/uWZruZQntznpGiMEPmvfHkKn141XM346loXy00U75GuAmRuraQRTHeAhSWW9vCKxv+bfTVw4ItdkVMBYvbbl4CoWjAofZfISGMN9ve5rgB+88llUaKUnDzDZt4zTCAm1zj9DD1vIJ1tyJkSziWpNR4ocTLqIo7+QxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833504; c=relaxed/simple;
	bh=eheJmdgPgeqGeik3qq47b8UOd+nLsPopHTkXCW3k7Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F37o8+PkNx6/1zC/kfuCvfDmilFxj9/7HGDoWVM3pK07iwyxiAmw4VBZBubCgsO9zSJml2rjEkXe1IdgPv7DZ5/HFJ3oscag4+jNBHWQFNtpldkIOc4aKzctyIhu5nl0dv88XbtzwFdC+t/fpxrE9f0WJJDplKxVnMfapVC+veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hOdpwkyv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hOdpwkyv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso84006b3a.1
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1775833502; x=1776438302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGwxGNzPNhl8p1KQjYaA0p0dmTpV8/UPLRrlCuE9w44=;
        b=hOdpwkyvcmleKgCmxEJkkymEoytEuMuUwIt+HTxyvWLgbX5QhYBC9IS9Tm4VbAzV66
         ONqfT+umnghPWaB3yDs1GwLIUux5ctg/7qi/hWeQezxBJ86IsdQbcdCcMTe9ltSBnQQg
         mPXtTL4UgUaH5L0jkVh/XUygex2GhxOp5c3pVDTlsYZrUqPgy3FY1plapG6G08E0unZA
         OSh8Gqo0HRRPwuhoGC1PKWToTHoFiC4BLhEEnrLJGiic47R9eg0iMGka35IdVcv4/UyJ
         l/Fwpdp5xLu8tXTRhkMHyU2QUmNdrtqC9se3i/FdPKtdBRlNxPkUQQeKpQj+d6MHvRuP
         Uvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833502; x=1776438302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGwxGNzPNhl8p1KQjYaA0p0dmTpV8/UPLRrlCuE9w44=;
        b=lTxJbiJjhGn/ZErCB2rgKPuA3CW9nrNNCFbPcg4sj+5jeJtpmpIOWU1rtFi8ATKbcN
         6LmHvxJ7yxs1Yj7d8p17YtMkNkzBbUeHd+PsZBESXUzvf5EiCadteqW7mFTUQS2pBFTL
         UqINdgEY3AclpTprUPAYaQF8njZjxt0K07pxEZDq7D3AAOE/7xGO4sYBh7afZ2pfBD/7
         D0a/zrwuXzMH8sMmQWWKE6mivjeKzH3eW8ibKWBSHcgxSluB45iQ0hn4BjeZVA8boRI1
         m4OZEAozRAw0kcGEcO6yd/iEnXYTsl0qHyg2JsK1CJPCVhOx2LCTJyy4QIyyGyE0+/0T
         r83A==
X-Gm-Message-State: AOJu0YwkVZzI6fJP/nIHiy0twIDgN5zvt6rYvLk3N/7LLBxnGBpygSow
	mXrFhCgpMg5AK1dxDp+cy8suFaOSAdbrHhZglLZ3Nax/WesW6e7efuKnslJHdFB2eB0=
X-Gm-Gg: AeBDievsTY09a0lYbiXKF+vni50Qw5PLbZyCO+VCmzbMwS9cSLopv3TDrYM5IPKESxA
	nhbhZA0eaUb3jr09Vn/7VtmwcmzKXrRqicqkLJEWCGX5Ou4YBxShNFaVteO87C0p/d9QAnUHeIl
	1UFWEzl8p1no3crzn5r13UJkGRsIa8br1KZ6B5hL+5t7citngnFqhvfAdQx56FGEU6caNiRkBZG
	k6y4mcPbi0bF5+CnjsnQHZ1wHAjAbs53q2w6ljmx9rMYiDLK1R7WcYyV4osApXV4ozcgm4i+DPE
	pkvzV700/2uVjytseaVd4/tYgklfJv3/RYqOBkd9nDQdsLLHXaKbpcwPLR5KOHNhQAjlhKH90U/
	VX1ngKn5s7nVYhvvY8S5aRG5nYrDACAVXdnc05Qg4WmiQjC0dLMiJ0rnqO0nKXP7kTxj+1gHt/s
	Wuwo37XamPYtgwhop10npfxycFuoukxj7yN4JDgS14A4ZbywJNkU+xnydi+oElo7Qv
X-Received: by 2002:a05:6a00:808c:b0:829:8942:2ca4 with SMTP id d2e1a72fcca58-82f0c281379mr3779253b3a.19.1775833501946;
        Fri, 10 Apr 2026 08:05:01 -0700 (PDT)
Received: from [127.0.1.1] ([45.8.220.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4d5413sm2970532b3a.40.2026.04.10.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:05:01 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 10 Apr 2026 23:04:20 -0400
Subject: [PATCH v8 1/3] dt-bindings: spi: add SpacemiT K1 SPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-spi-spacemit-k1-v8-1-53ebb48a4146@riscstar.com>
References: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
In-Reply-To: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Alex Elder <elder@riscstar.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.1

From: Alex Elder <elder@riscstar.com>

Add support for the SPI controller implemented by the SpacemiT K1 SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 .../devicetree/bindings/spi/spacemit,k1-spi.yaml   | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
new file mode 100644
index 0000000000000..e82c7f8d0b981
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spacemit,k1-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 SoC Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Alex Elder <elder@kernel.org>
+
+description:
+  The SpacemiT K1 SoC implements a SPI controller that has two 32-entry
+  FIFOs, for transmit and receive.  Details are currently available in
+  section 18.2.1 of the K1 User Manual, found in the SpacemiT Keystone
+  K1 Documentation[1].  The controller transfers words using PIO.  DMA
+  transfers are supported as well, if both TX and RX DMA channels are
+  specified,
+
+  [1] https://developer.spacemit.com/documentation
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Bus clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    spi@d401c000 {
+        compatible = "spacemit,k1-spi";
+        reg = <0xd401c000 0x30>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&syscon_apbc CLK_SSP3>,
+                 <&syscon_apbc CLK_SSP3_BUS>;
+        clock-names = "core", "bus";
+        resets = <&syscon_apbc RESET_SSP3>;
+        interrupts = <55>;
+        dmas = <&pdma 20>, <&pdma 19>;
+        dma-names = "rx", "tx";
+    };

-- 
2.43.0

