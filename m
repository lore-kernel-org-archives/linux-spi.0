Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185B318EE2;
	Fri, 31 Jul 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488910; cv=none; b=d9tD9QTEwf0hb+tH+VSoSuvTAcuD5XkQoXaK/aOEGllObob15Nb5VaoIdu8m3H3FVNI1G7gu7os3pnvGMypCTjI3jh4NkCb2Pvotx+M7x4IA9RMVY47DrjzFaPLVDMPULfpao19o5QjOQL528lCDpFQBf9RacOY446sEcwvi5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488910; c=relaxed/simple;
	bh=Mmb3oMAuheR21ckKDdPOPrg5ggrRiQ6j9iZ1meDpgMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CD3jJo3aoGTmy1KiCrzY5xEgmyvUaj5OXCqkaLth7TGTuviA8NhzOjxOB3895N+zkek4ywbxZ5cZbEpAi5m4nWe8yMnJi2/OGEcCKx+QTRWN4g8Ka/mr10wjT19T1nssIvm6Z9Z3CJmPjRH1SLeBf+8nx+xuIHF6MgDuH6W3wHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ud8y8e/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ud8y8e/r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011C3C2BCF4;
	Fri, 31 Jul 2026 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785488910;
	bh=Mmb3oMAuheR21ckKDdPOPrg5ggrRiQ6j9iZ1meDpgMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ud8y8e/rOWlmmYP4+3ZmilFqCfz4oLvEn+kEJ+jiYL6k4qWiOjwb/Ygwjd5Pwot//
	 kDJhgdzY9GnC76gOftXclMlvNjE8YYEnpIgdpBSo+goFPPJu4w1JMmaRTwaZb2oUV3
	 jvYLjqxBQg+D7QTpBTmafxMuHnzHuerK1Pgh+5MKL9p5Lv0GVw/7DqJUbZylUd19u7
	 o9dTcpoJio5etOiCr36nDHzM55lrCdLq4SAFAqdr9F0Eva2+T46y0eNsTfIVr58lU+
	 +PNerP3W7B85PMAXDGCWPAFI5UYR3WZAj1if0buuM+afVkdZhVatrkQIvIS9eb7mEd
	 SjN+G37LyyxSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6698C5516D;
	Fri, 31 Jul 2026 09:08:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 31 Jul 2026 09:08:25 +0000
Subject: [PATCH v3 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-a9-spisg-v3-1-a15da3f70029@amlogic.com>
References: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
In-Reply-To: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785488907; l=1955;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=QmBAAmHCz75ak/gTg3Z9nJO6Jq52E/H1aEusSVZgdR4=;
 b=6bqBPyY+DBxWpopJLpgnlBtH3rVrZ5+pz5Wlt8IJ1ilczXy3WgZjCdg9Gjx4dtyQzwq4Fyv+6
 yK3E5ed6SLFBwOJq2eLWHDSc2TherqH/VVAuog4cO1XYJs5L8vxb1U8
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the Amlogic A9 SPISG controller and its additional Device Tree
properties.

Add the "amlogic,a9-spisg" compatible string and define the A9-specific
"amlogic,mo-idle-output" property, which configure the MOSI idle output
level.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
index 9bfb8089f7ea..427d8883009c 100644
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
@@ -35,6 +34,16 @@ properties:
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
 required:
   - compatible
   - reg
@@ -42,6 +51,19 @@ required:
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
+
 unevaluatedProperties: false
 
 examples:

-- 
2.52.0


