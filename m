Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4223CAE84;
	Thu, 23 Jul 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789035; cv=none; b=PhbIBHJ4euofgdoy44lgKLiP4f3noz2kYYs3boLmLiVBkMkO2jNqHY7whruuimM7+OYho7yYqjFEyyBzJyRzsUjPx45vSCNWmw9DQ+Mq0nz0zFLBWJsmbkmAHAg5X15gGSx7lx/6rJeMeZyuEE+JQ4lDiTsvKoL1KALegTqD6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789035; c=relaxed/simple;
	bh=XQltrhhdDEOv3aEgBjYadnzuNlFB/71hwbYn4rzhXMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzF6Oa8IGWsj1doSL2ILIBMklUbg5oLKnI2fmd+EnOkW2M3ceEPyC+k7G/2NZSLv+HEyKoZX4lGXE2XK/m2yMFEf2CemBefhUyMT6xftbVxVgbBga4JzVgFOC0AvkSLH+6Cn9zikJ0fEEBhP1qQ+GHTi0Z12SSjSB8jr8y/wlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFry3Qcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFry3Qcn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 445A3C2BCC7;
	Thu, 23 Jul 2026 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784789035;
	bh=XQltrhhdDEOv3aEgBjYadnzuNlFB/71hwbYn4rzhXMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gFry3QcnCwvkdi2qBzBIFjd9Ql3ATFJHpLatDTvAYduApTDBQi3/dimZ1FdZ+31EO
	 NcYcAqsGCpe8rvQuifUmrjK+4izhm/6xMOEvln+uX302ZwfKl4jUO5oX5xvxD+T2ii
	 ZmLyMLK1fHgcAcs5qiMBpRz9VpX0z2FAj/BMnvADAlr3A5lPe+75hp4nhiPTRyaNbN
	 ISWkNYUjo1VJKhcPpbXI7IcSWg+ZhyiyER/UX82UMrFLExRGMO4Tydt/0KsSrrJQX8
	 yuuXn9N3W8h+cz5eureSZO7JD9aBOfAVMVtPsPhMQDdkiTUPfiHqB8nX1c2hRXvHEn
	 YsK61Kr/KvJwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A0C531CB;
	Thu, 23 Jul 2026 06:43:55 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 23 Jul 2026 06:43:42 +0000
Subject: [PATCH v2 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>
References: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
In-Reply-To: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784789030; l=2195;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=A2bVyZIU8ueKZKzfA2QNoWvbKtTJ6W1aJGMG6E4FE54=;
 b=AIm5d9oRD0BkkfTz9T/TtZ41z3rKMtlDTNoDIeikQwndF6WXhphmeCUBUwXVK5utHWQKPliUH
 jp/KjYz1l3rDk9TdKThZa8f7XhTRxxVVvfEHmI7Fx7BAd63WOpw/ZAn
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the Amlogic A9 SPISG controller and its additional
Device Tree properties.

Add the "amlogic,a9-spisg" compatible string and define the
A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
properties, which configure the MOSI idle output level and
the inter-word gap, respectively.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 38 +++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
index 9bfb8089f7ea..ddef92f3f3b6 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
@@ -11,12 +11,11 @@ maintainers:
   - Xianwei Zhao <xianwei.zhao@amlogic.com>
   - Sunny Luo <sunny.luo@amlogic.com>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
-    const: amlogic,a4-spisg
+    enum:
+      - amlogic,a4-spisg
+      - amlogic,a9-spisg
 
   reg:
     maxItems: 1
@@ -35,6 +34,23 @@ properties:
   resets:
     maxItems: 1
 
+  amlogic,mo-idle-output:
+    description: |
+      Controls the MOSI output level when the controller is idle.
+      0 - Drive MOSI low
+      1 - Drive MOSI high
+      2 - Follow the last transmitted bit
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+
+  amlogic,word-gap:
+    description: |
+      Number of idle clock cycles inserted between consecutive SPI words.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 1
+
 required:
   - compatible
   - reg
@@ -42,6 +58,20 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - amlogic,a9-spisg
+    then:
+      properties:
+        amlogic,mo-idle-output: false
+        amlogic,word-gap: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0


