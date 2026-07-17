Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65537997E;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274578; cv=none; b=nEZb0TyvEwAWWNXc/b8S2vX9PKJ6P+JXsXHvxk7/lki5G186Wiqmdpe2TgVeMrtN5FqF6feNEYFgxppmM6FYF3KPCf2c3IjoZDbkbN/KxJvfH+Pjk45c9sRWGl2mmILT/tFLSAbVBvVEJlUpmwxp4FTYW783Ey2eMBVuTjqReQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274578; c=relaxed/simple;
	bh=kH1x/C+bNVBFlqTXRh62APgCks1TYJKRNSlv2U2wXio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k55EW/fJLdrAMbLN4DPf/eA92lW+Q3XmbUlP9b1l0hkSsH1TN5OEF6i34Q+sDd8A9gFR7qcU09Qxld5eLK4U1dbDW5qrB14WUcLCFuD1DxJzeHC1YD+K+6o+SBrbHWJaIc/O9/DgfZ5R8Y60/arVy0Rt1vAOCH+7YREuYGmQxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZn+1La8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZn+1La8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879C8C2BCB8;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784274577;
	bh=kH1x/C+bNVBFlqTXRh62APgCks1TYJKRNSlv2U2wXio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SZn+1La8IZHMj/F+Hft3XimmAhNKNBbBpY7btB2nCkYzh5uASuYLZCLE0ENd+fKFM
	 hLCcGPga89ooNFyPAyyJZRrmKSWi44Erww+XM0IOqA+KgHfrKmlVHeDmsDarY2jS3g
	 acI83Xe7Vfl5sYCeUa/+WoJuMZVc1WuhM5+RwZYK6ZmsFgbHHnkWl3hHRr1ty3pY0P
	 AAE2g/LLq0uTWmY3UC+deytZfXFP58pRC0XTG6KdS/ESDzb8OGc8cdFT5XTKKOxpEl
	 TkfeEdxImARuwBu9QAnvwjVF7Q/78L14vJWDU7gdAkqLhqNVGX7X9YS5NruwMCds/i
	 cUBw6dqwl25Nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BB0C44514;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 17 Jul 2026 07:49:33 +0000
Subject: [PATCH 1/3] spi: dt-bindings: amlogic: spisg: Document A9-specific
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-a9-spisg-v1-1-2eeea77be19f@amlogic.com>
References: <20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com>
In-Reply-To: <20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784274574; l=2098;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=S01FdKqQU8iANSc5yRkrElydRThefyYyd4gl5octfjc=;
 b=RG0aRoS+AIlkg4WEA5oEP0heq1kmYDL6XWlS3kIBwjMtntWgPInjtakXqV/ijUzySpVddZLBU
 g1Na4VBY1l6CqcEd8EvWb2p+bXp+8rqZwcb9IglYC6vBAwyXTkrYxvV
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
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 36 +++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
index 9bfb8089f7ea..7efdc748d566 100644
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
@@ -42,6 +41,35 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,a9-spisg
+    then:
+      properties:
+        amlogic,mo-idle-output:
+          description: |
+            Controls the MOSI output level when the controller is idle.
+
+            0 - Drive MOSI low
+            1 - Drive MOSI high
+            2 - Follow the last transmitted bit
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 1, 2]
+          default: 0
+
+        amlogic,word-gap:
+          description: |
+            Number of idle clock cycles inserted between consecutive SPI
+            words.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 1, 2, 3]
+          default: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0


