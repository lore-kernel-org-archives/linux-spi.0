Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7943383318
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367766; cv=none; b=jkC48rYzjm/pRSpGpWXk15d4LjYkVb/rzAw+e7cz07bCEh+ogUZC4shTifVoDeZrdI1x/6DI/GFHQIRqiXWc+VUFan1/U9JYk2iFC9uc3h24sCvEAVDkbpw44yZTjPjRk8J+c64q5KgAkmGjji6KlI+y9Te2Km+ZL2BXxtz9KqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367766; c=relaxed/simple;
	bh=6JPcMabykOtqX++hOdqlmRUh1s0vS6/Z1NJ9AEpBiqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F7dh6jKQ8jdoCZy6Mbwb3aS8w96lW2KO5dE46vkaAuWJMlhdDu16CGtuO8zvxzvm0BECxWAfD6HA96FlSki0aChe8GsHq0DgdpStiv3AApqIguLQs7azE4aLVr3tpPWsCHExKQM5eB5iKzlku1DxcT0aUiv/0R4jZzvTww+/M20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdnvFBej; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdnvFBej"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37d70036426so1030010a91.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2026 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782367764; x=1782972564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqHDk2q3A8EfdVkB44C3YI5+VYcE7QxIsvCqD/cjXJ0=;
        b=cdnvFBejr40dad6Kn8UrREH57UPGsknozMdjcWuaHaBZY52Wjw/yw+Syc7TRXS94Ph
         McWtY2duZn5FY5UnpH7AlkvRpr19izARXw6zUeMkPhwIiiWtvA3W6Uf7tUo9YIM9c8Im
         JDvmynqfe/dE4YP3yb3OYlTkMQBTzeRNo5UxG4HZcWUhCBd9q1LNnglEqCqHDu7qlHpp
         6yLwDnOC7WPs7LvEvBOzRGsV5LnkR/qO/1lROcUfwwyvd2wJALw/Auga+vYJc0LekK5V
         edL9C9RnR8TB15tRm/RRG/UlHubGtMfLXfXXST5sjou7pjk1Gnry9CS9uFzlLZ9cfRG2
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782367764; x=1782972564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqHDk2q3A8EfdVkB44C3YI5+VYcE7QxIsvCqD/cjXJ0=;
        b=PyrsO6bkixjSI0EXSZ1YAJyxd1VLhakcS19UsPgM0WNYmo43o88S2tPAr5sW0G3lPc
         JVBYuAWMlPpFHyp4OhF4uKbfbzPYgWyNddKYR19zNvgRRBhfUwIhE5xDOwWCUEAW1SQw
         lzrsjjEaDtJRMeYTGPfmp+qWbOMfj50WX5D71i2WWHmdsSbiu7VR6+S493B2S8pKdfSs
         vpipI33NgiftZASP+rI03zN7YWCUI0JOkjYiOxDtHzoha1g+SCzyuVl+klPVLL+zEJx9
         n/ewZuW6cNmGbDZY8WEiBV2ts0KlPTF26jz+NnXC1QriasEthoJ9exUxYLujtl+/5p8U
         biQA==
X-Forwarded-Encrypted: i=1; AHgh+RomeAVj/OOsfygqxBmMxTMXTxlBmQBukIee33ix7Ulo249uai+O6DhGNahrfLkxnK+5IxC+h0Knj+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOqscWahMagnc2WfmPmeH09fkbeU2LT5gvRfPPWkYeXcj57Ga
	eaXd3U/WuYSSOzEFD5IX+4vCf/OPeke9PjSh6imQV4/D1jJoBdKZlmv2
X-Gm-Gg: AfdE7cmlAtBWGJvtdOIYBuwVoLywv+Mq60ryIIhMF8t+vDZ7ya55SAbQQbYJdessK8P
	duid1QUzq3XEH2t+LeSAXuhn90GJQAdxzBFCyGSp4aRoZAa8d+o9zGxZ92Jbj8oFkH2YqR8UMJ0
	o1Vl3MxiRdlG/cq0wvSRoP1OwKkN5JT8DUZddt8RshVRnkQB3Fr0sXkO2pyzknSgnQhudXgjXj7
	L4yc3WMoDoC2BMedoGd4CI0IqyaOlqPw8QYF79K+r8tpWICB38Jleg2koREyRt3sZmZMYKkduiC
	Wxdadu9bStt/I0UK4ftBfJAKlzC++RRDHRnXrSnDjUG+0BCdVdxKVl1ygYQwfspTwHVaQNAkmVA
	jj+aIqPHjQwEpR/k9b85qQkzpu7kyjG6Ix/k6MrEB0r40Ssl8jJp1qZzynCuA+aqN42M+/Eqalg
	sDGIzvs+b3g3rflhAh2ZzVc0d2Y8F6uQA=
X-Received: by 2002:a17:903:947:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c7fc755250mr13354805ad.16.1782367764084;
        Wed, 24 Jun 2026 23:09:24 -0700 (PDT)
Received: from inhnjlux1020.ls.ege.ds ([103.28.245.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f650aa8esm12044735ad.82.2026.06.24.23.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 23:09:23 -0700 (PDT)
From: Udaya Kiran Challa <challauday369@gmail.com>
To: tsbogend@alpha.franken.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Udaya Kiran Challa <challauday369@gmail.com>
Subject: [PATCH v2] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema
Date: Thu, 25 Jun 2026 11:39:03 +0530
Message-Id: <20260625060903.14661-1-challauday369@gmail.com>
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

Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>
---
Changelog:
Changes since v1:
- Drop maxItems and add items list in 'clocks' property
- Remove unsed label from example node
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

