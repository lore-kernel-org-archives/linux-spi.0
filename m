Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1322F388
	for <linux-spi@vger.kernel.org>; Sat,  2 May 2026 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728704; cv=none; b=heQ1Q/FfZpxRZJtENNV33gJbxvIvNdL16dE4q6903jPd7tbG1sP24a64a0rlDlEXahwyyuoD8klCihb0Qnlk2WuSe4fO4PmIeUYKK6ungnVfTE9P0b2xibrOMZ4jSdDplmujsoUdWCctn6hJh88DYU5sgREyEFl/Tc4mHHRylJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728704; c=relaxed/simple;
	bh=t/N7N/XSOQKrEzUs/D2pxm3VCD+rv1UW1/RKIJtP2xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRoq7j7CGiNxcO7He6p+Em8i/fEUHXyQ5j8jK2Z8zPuzWglW8m8EN1H9nQipgt6WXVHE+0VnS00krdIbdEvAluPwmHLwEzGvpVjM67C6M4Nw7uiCz6/+P0IdmTBKAFjhjcfqIXlNr0srTOyH5CHy5PHb9FP1C5czKL/YXXGuC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=pawa4wko; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="pawa4wko"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3650a628473so936399a91.3
        for <linux-spi@vger.kernel.org>; Sat, 02 May 2026 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777728703; x=1778333503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc44VxR2FzsNOtDOyeTwEzMXfi//+xA2TCBmgHk8I1I=;
        b=pawa4wkoyH7T4yuRnXttG9Sfb6UNHdBH3nDmeuYOgYnGynkbSOsi5WBEpPGlhlqbzs
         trlJNsGIWDzraEZoxHpWZkXFomQGKNsDA7Ihu9EOu5m2+ABKrTQG1IlcmGuMz+GvFoSS
         ATCDjED9QRs0i8E+80ps6V1XcdmBhOUXE1/SZxFCvi+iJNkZR88gqVWXecyzYvyN+92d
         WhWf2ICSbXT54dPVCiR4Z6m+70vKVtNb79QSi731EV2yk+w3gm//0P+NVZGvKy18XLby
         ZK4oARnbSw25hFy2EscUK27F5i00fx3sH42mNO5d3BCOh8wPfENQkRiARnLkttvIaxDT
         gJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728703; x=1778333503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nc44VxR2FzsNOtDOyeTwEzMXfi//+xA2TCBmgHk8I1I=;
        b=mUMUZzDiwq+TC78wyOg9yGVG4SZuRqerEvY1khndBX6jlLG8utkw9UHtvOMDJY2Fsa
         EVsT5zSu3DuXE7/v7DgSHjpMf40Cdb0fsj9EVKQL6HC8ZPxenJtPuFO5t/kj/qTim72N
         80nqHCoqqvkpd5+KaWzgSIfuCNNZkSwMQ8r/nrH0Uyp+pn3K7TChYeskuHCM9xPl6Nfv
         ioRX99rW9dt0lGGPznXDLmsCpUMKWL/EPDs/y4PXQjpepltuKb06eH8g7HkuVW6oXvRT
         gG32bL9tvuxYGEngpdRuVLll0TMwlqm5Oq4+hFgn4QgG6yLMaKCoTMZeu7YQw8CW+Fya
         QfLg==
X-Gm-Message-State: AOJu0YzQJjUkZdaOHTAFsxCsurf4ymAtHV/78pIwA2p7pQxNg+W1YCXf
	YYJ29K4P20vkZegdOBX9q1i7606wAWl9QIifHMLYm7wWRgVJ4GmZqBFtu4+cFCUEW18=
X-Gm-Gg: AeBDietNTkMJB3TuHFhYbuhV7IeQ8u5/xKlHq0lVfHR/UoiRsH0bhhMD9vTXItMMMrD
	R/0DgVA33F9O8pCV4aQBDw/K4/XjExu6wRleIiwGITS9a06IpRzOk/wfs9sVr4orv7LCnuq7vtF
	lx0eV8Yn3ogiYedC8L6xVxsuE6H6fKcM7CCGdHeLmhyzUS4yu19yOCHJ0fjsybi6INe+K6Wy6o2
	2Urbnl0OZmUkEt8kCD6wenyyY6RtQkTyoLUOeb9E3f360biO9jTGNOqQUVCYwIwie/DaPOThFl8
	Qo/ot9jx2hK8L0EfK2CIwsKAto6PoBDIV9U90xzKZhDmtJnVARhLahppug52/swFR6XyTNmCZQm
	aw1qI3wVqs/aL85i21gKAgn+rxZGlmyQdxYCJQUIJyKzdMhkmlH9ozvBtXXghX/Mg0n/bhP6Ne/
	BrX4ydIHSBA6s35/oniN620Lvz+D3vc1FSerH1Y/uYpUePUYc4kdbcqA==
X-Received: by 2002:a17:90b:530b:b0:35d:a3b4:2f00 with SMTP id 98e67ed59e1d1-3650cdd0ab3mr3593006a91.8.1777728702492;
        Sat, 02 May 2026 06:31:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3016])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec02ab2fsm5647937a91.14.2026.05.02.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:31:42 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 02 May 2026 21:30:51 -0400
Subject: [PATCH v10 1/3] spi: dt-bindings: add SpacemiT K1 SPI support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-spi-spacemit-k1-v10-1-f412e1ae8a34@riscstar.com>
References: <20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com>
In-Reply-To: <20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com>
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
v10: No change
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

