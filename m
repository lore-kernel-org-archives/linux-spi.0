Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9F3CF671
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298525; cv=none; b=HC5VQiimLAv8DivPmjqCO4iBst61Bl8oRIVrdCQstEhrGuGXUfdx598x1gTXtdBxsYTcZdqt5O4EpDxdjyeJXdkXuBTkszNmVIgJuHN0e+s5cSTFYNw7XbhjFlGEYv9F06jFFEbYctnFaXIPRqZaAucgVdVQBmpd0Araqxx4bSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298525; c=relaxed/simple;
	bh=fJhg2u/iTIaljZD3q69iV8pLDNtu38nnqnZrJ0s0POI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apfBoRVvpbcZnaKg318dkM6OMnCg1+rWH00uKlmb3fhEVitsp71vqmeuar/TJ8VB52tFiwmHalzkUwiJKDqOoCJPC8SIXLy4HeX1hOitTCS3LgY8riNyYpKanmUppe+1EZ0GZnxuzLyXgHGu4hBMIZ/VwkHjIpKPiY+2wG+cis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=D/ZOW1AM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="D/ZOW1AM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b9705613ddso4048975ad.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777298524; x=1777903324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0oaBw5eNc2BclV3Ait+0PeOTuCPczoggHsdIRqUpS0=;
        b=D/ZOW1AMf0rANDoVE71Sm5+Z627wVrAIKlwfEqS6pH3arI2ywSd2qgI5uPq1Tt0VhN
         PN1Uq/1RC4DKjb0XTZ13MQICScn9KcKR9kX4PuALJHJc2gZbqHAiwH+OAUF0jadEx9ph
         Ij9l01wVfwsoSXjRKKq86iUBszQFQbuVk6b12YnuLz8ECxRcXfiBGG8drmVuLyu6QREa
         p6JjDydc7b935K/fTOZrcZPlmT9P+sHfMp09amptLHqsw2ULldG2rCbwW4a75rPXUbyh
         vGD8OMMmmQFvXORrRe4juTFZvaLWRlbbxaD2ZtvDXnRNBHrQ8RuHyXGfgwfwHrKokgGV
         sKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298524; x=1777903324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0oaBw5eNc2BclV3Ait+0PeOTuCPczoggHsdIRqUpS0=;
        b=A3lt5YDhJzK39qnIUJ56o0O2tklGhLEPu/OmwIK7Ks1rvxC6re61IR6LeRwY8ehuh0
         ZWUTmZgla5cmdPpn8g+44pLXr3r0hj94e6ZsKSYT9qu6GIIgBCy79u9TFdOC71RypkCp
         v28kuMkl8RH2VbHlguvTchg4OixjHuWLRSOO/1bGARc35iHDBMPtlzXIQRWHQcAYuFpz
         8xr33lB1+idp8ogiRlpGO9aKIoFHueYQNFeFtm4qOxWkgIZe85y4NUaYo+/Mh+tmWP0Z
         AUXitEmWv5LJ/HoCgi1mOfj7HQb75kO192tuuMcT3mLKWQzbqZBBvLOO6toms3PNrq3c
         +CLQ==
X-Gm-Message-State: AOJu0YyYLO7Ox1UoNnUV82mYTCZ53cF81HrbI8U/3FwkKW7zbOSS8Elj
	c6itSu0mBAEN8fI9fxnCv7qA716XCc+fF5qDas/dqFkeJJT0DkK+zGrcoL3ny28IAGQ=
X-Gm-Gg: AeBDiesQJ8VfCWgiYOkpEAODk0AIRlrVIL5xR7xqWFKjbbPxuYtPiaMYwTkszK6m6IW
	WC3/otKUn6PYv+5F0bKxjD0CuqbDfUUAQyyfG+vOMvtySVOnCj9rDb6IsKnfx4X6MKe1eo4xaPo
	AFbvPYTTP6soN/KyOdXjoJp+bzTgS9h0Id37/6QQTOdgJRGCZW0XBgszgd0jyUtprJQVNzgPXFy
	KY8p9ObwUGwP8pCu5OnFULYqq0ndJk6nQCdUDiWlkrs2OKwgOLI1kEKoBcQzmFwoXmdfj7Go/im
	6KOgDeAx9KY3gwV4YmxIZWAwuOoPmvsMYtNCRQyXUuSVqbqClpepGJnxWAkAxIYxkjOOWRlACBc
	q7Mzfmjfe/qk93Jwu0BsUbTpnWyXzm6h+jRzHTZzkd+5vXiFhNyBvX4S+VQBdwdr56ACdSHtFSf
	RfmYSMnpkL0k1Ytg/Ea/5BIB8JhJRKWOCYn+ylcEcM2jTDjyAzQnUirw==
X-Received: by 2002:a17:902:bd44:b0:2b2:5da8:14be with SMTP id d9443c01a7336-2b5f9fcd9eemr318233315ad.41.1777298523356;
        Mon, 27 Apr 2026 07:02:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3016])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff98csm307143625ad.3.2026.04.27.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:02:02 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 27 Apr 2026 22:01:27 -0400
Subject: [PATCH v9 1/3] spi: dt-bindings: add SpacemiT K1 SPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-spi-spacemit-k1-v9-1-ff753b551302@riscstar.com>
References: <20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com>
In-Reply-To: <20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com>
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
v9: Fix commit subject prefix to starting with spi
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

