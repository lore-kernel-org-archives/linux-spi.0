Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FA38838F
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675788; cv=none; b=Tm1x60hrdmMe1yUEPd7fwRyZJKvquZIUhoNfi8o9bSdY9YpOmSCc+CrhVdaafOnNZ5hcPthfNoPMrMgP2FsAzHhXAQWZyO2vjeEeSfjMbfOXXpPSivCuxqFBfLTaCFiYajnDqpta3eVpXGxRvOj1vudpA5Xs5fHdv/dRHmLHUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675788; c=relaxed/simple;
	bh=i8eodjsuIdPpCX04HGaCZ6BaFipCim8Lde/X299xfiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMY6vfa4ADjRujRUbHBdnM67C2Pq7YQoaiRbHL2eIdbliqDMLTkt8y9a3S6m6GD1g3niE7dtboGGdFEs1MvvFTTW/8dLxzy7VecXbn/khvuXBsn6AfF3kzpmngZuufnrW5SShPPAlxny9sO5lVu3QzB18JMNE70Vear73N0guqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpOx8Czy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpOx8Czy"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so62410b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675787; x=1788280587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wodm8m2zjhUXQujtK3fCFfHBkirwYTQboCwEV2qWqmc=;
        b=IpOx8Czy11N6uMsdJH25tG+zjCz8mTarfl58DnJ6rnPpwmslXbKLeqaajQnomXgckv
         mu9yW896fikk9wO6xVl9PJSCnO1IUgWvCIEYWE0EWrGvKhQD+RI2Lz+nXelnViA2bapS
         CN31c7si5ofDrvQfLQ2lYlB0qWcXWPKVqcllrJDPtdHM+aKrXh4IXnS3LA4ixNyH+9ne
         u/XIYqA2eJzJj6L3g6DARbJZ0QG6GCApUnAqayTNdzPDeto4uPPvu1u462CP6vb+ukxu
         TpsNVFvBSE/hL/Oku7dntQ567dXIuxTOdp4POfgU7qOZgIAUJzJVa4zdVJpgtHTkyv5d
         GYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675787; x=1788280587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wodm8m2zjhUXQujtK3fCFfHBkirwYTQboCwEV2qWqmc=;
        b=mj2UPjyhQiVj9GeFdQW+nmy7rFBUKeC1FG2afYm+y738XjGZY99ZNTWxHeBCL4dbDN
         UF9RI8W4OHXb8/ZrJxdg5APuJgb+XMIRjfxLRh6K+cVFrs3LATCn7oA4/vUrh8EFL8ad
         X14JMgzuhfeP8bfy1r6RpluZjTbC7AZjkr5HvybGy6wpx5TZZFxZJMIVYJNedfoqpk9b
         Z39Bn6zuGSpcIRi2ZWZgy6To4E4CYjo6GzOITd4Cm5EIOVM/bxuoacL/KBYFjJvpNIXc
         4Djsuu7ayuBdTQsH95WV9c3CZU2Lfg3N2ZBDTA+IyFIwCfivrDTDJ9gGkdKR0WAjMeGY
         5xqA==
X-Forwarded-Encrypted: i=1; AHgh+RoRl/Z5PBz3ItVsdAHqhcCFT0nM9D7h4zYTfW/R9DNt7HeI4ze3081yH+V+pWxHeBpxjsE4Q4txe+c=@vger.kernel.org
X-Gm-Message-State: AFuF++n97M9VDwuy9FQUAMMa1/GtywlTcsOy1PvWRX1aC4dzD5l9l/Sq
	h0B2i/ls9c364atF6lbTn5J4CNYThwflljNcllkEUU+3iKyOVTFrtLdJ
X-Gm-Gg: AR+sD10P+cjjVkQBfLNhXRVajuAz4Tl7telmtrI/LZCW4THIvY0/L8lSQUcZC0IauL1
	A5UfXrjRTcqRMERJOgWihIF8BuY3E/VH/gA+6zIQrouP1wmK34h6zAEn5Ap6qXTdQGH/79NS4fq
	S34WtRQh1kTCVR0Uu1kcbqgfQLmvWUKzFVRJOsWPwZikAeeHFsH6ZGmJQPK4+Ml5tuhmFxW9U5O
	pgQfgNZrr8z6tWkiN+YjObLoTWXyLlCkUJvLdijb7FLgnBfiDtrzOOrnSXPbISo/ORwYZLTjXoL
	yF1yNF7UOKldJJv3pG7u+G+orZHOT5+4tDgoBrvi2LD3aTzzGVf0Ep0QQescCFX79Uapm4b1mJX
	BgRkDkudJ9jF8VWbopTB0v2FA4TqnjaNTs+5TM9o1K92r0nmRTZv7mvg3eYquAWM3ViDHVdfdrE
	YeiLQfWlKPckxXI0YEPWB0PTLir2s7nM8S2KQc6YFjmhCKB6/bhniV2E/CqsT8oy1b7GJlA/gSi
	gkwSw==
X-Received: by 2002:a05:6a00:7488:b0:853:2e35:ad84 with SMTP id d2e1a72fcca58-8532e35bfd2mr3411792b3a.14.1787675786854;
        Tue, 25 Aug 2026 09:36:26 -0700 (PDT)
Received: from inhnjlux1020.ls.ege.ds ([2406:b400:53:dfb:c17a:6cf8:3d2c:cd28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc03d6sm88527b3a.32.2026.08.25.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:36:26 -0700 (PDT)
From: Udaya Kiran Challa <challauday369@gmail.com>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema
Date: Tue, 25 Aug 2026 22:05:51 +0530
Message-Id: <20260825163551.79603-1-challauday369@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Microchip PIC32 Quad SPI controller devicetree binding
from legacy text format to DT schema.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
---
Changelog:
Changes since v3:
- Update the binding maintainer to Thomas Bogendoerfer

Link to v3: https://lore.kernel.org/all/20260814101733.46406-1-challauday369@gmail.com/

Changes since v2:
- Change maintainer to SPI subsystem maintainer

Link to v2: https://lore.kernel.org/all/20260625060903.14661-1-challauday369@gmail.com/

Changes since v1:
- Drop maxItems and add items list in 'clocks' property
- Remove unsed label from example node

Link to v1: https://lore.kernel.org/all/20260624061329.130468-1-challauday369@gmail.com/
---
 .../bindings/spi/microchip,pic32mzda-sqi.yaml | 55 +++++++++++++++++++
 .../devicetree/bindings/spi/sqi-pic32.txt     | 18 ------
 2 files changed, 55 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/sqi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
new file mode 100644
index 000000000000..c8f58c506087
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,pic32mzda-sqi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/microchip,pic32mzda-sqi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC32MZDA Quad SPI controller
+
+maintainers:
+  - Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: microchip,pic32mzda-sqi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI source clock
+      - description: SQI register interface clock
+
+  clock-names:
+    items:
+      - const: spi_ck
+      - const: reg_ck
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/microchip,pic32-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@1f8e2000 {
+        compatible = "microchip,pic32mzda-sqi";
+        reg = <0x1f8e2000 0x200>;
+        interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
+        clock-names = "spi_ck", "reg_ck";
+    };
diff --git a/Documentation/devicetree/bindings/spi/sqi-pic32.txt b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
deleted file mode 100644
index c82d021bce50..000000000000
--- a/Documentation/devicetree/bindings/spi/sqi-pic32.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Microchip PIC32 Quad SPI controller
------------------------------------
-Required properties:
-- compatible: Should be "microchip,pic32mzda-sqi".
-- reg: Address and length of SQI controller register space.
-- interrupts: Should contain SQI interrupt.
-- clocks: Should contain phandle of two clocks in sequence, one that drives
-          clock on SPI bus and other that drives SQI controller.
-- clock-names: Should be "spi_ck" and "reg_ck" in order.
-
-Example:
-	sqi1: spi@1f8e2000 {
-		compatible = "microchip,pic32mzda-sqi";
-		reg = <0x1f8e2000 0x200>;
-		clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
-		clock-names = "spi_ck", "reg_ck";
-		interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
-	};
-- 
2.34.1

