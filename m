Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA31393DE0;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892014; cv=none; b=G6bqAxF4j9sykcGaQ3ZavTs7nrGjBuDN9jTcIkMS6QC9GJkkk5yuJ0FJ96AYzaoxRBMERRsdn2PfHIY4ZKWVoEdYUzxLVPtDalKXkLiY47CE5zkJs8xZp+AIe4zqGCOM8nWCQbacHPxW9F+J5AmM7Xe8Eqci/O62kqU6cagUWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892014; c=relaxed/simple;
	bh=A7pJRhG7NpywLWWaoMaC1pUfWSZ7AsdAS4qYr97/LYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKd3MzoC+Ss6i6FhS1swIuvwOUjSIROkSq26DpJo02yR+dZRmwoHSKuQ+SrrlwF2evbbN013xIMn8ayhkMSzMl94C472/dnbXjrdNGtGSD88oqOGcOjRHrqX/ImtvStZyuUOp3RN11iEk4cBFuPD8CtHvssnAAEzxZd0SGwaG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKuN9OfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKuN9OfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A3D2C2BCC7;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789892014;
	bh=A7pJRhG7NpywLWWaoMaC1pUfWSZ7AsdAS4qYr97/LYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RKuN9OfJVAus+x3GncSlKwUHl9Jtko/fukCDXJ+70KNll5EXk00FkE2C20JnVbxw+
	 wMcffUT9/jByMBDcOBNcvWYq2kW+AbkgU120JuRSrAaVqiwlO7SOXv3peHPcruxlKT
	 0IORh6+QxIx/PVer5OYX5XVlTI+xY/tlM2q/7s6h9OUQLIgysUziOpTwQFB4qCq69g
	 bHrB9rVevcfe8CQSgpjWQhjRgDZr3V8N/VAP2MUbiGT5jyQF+oMFTafM5bhcH7ixGo
	 UGX9kgt9HcpkhHcbqrvB3OHfMXFD5tlFcZm+94ocOBa+VzmMNuR2KGh6LtMgsOH4Ht
	 S2Zh7iyctz67Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A2C982D0;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Sun, 20 Sep 2026 08:13:28 +0000
Subject: [PATCH 1/3] spi: dt-bindings: amlogic,meson-gx-spicc: add T7
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-t7-node-new-v1-1-e6e0840c1b0b@amlogic.com>
References: <20260920-t7-node-new-v1-0-e6e0840c1b0b@amlogic.com>
In-Reply-To: <20260920-t7-node-new-v1-0-e6e0840c1b0b@amlogic.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789892012; l=1575;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Cr+H2n7PINWdLBG8TQcHVSgRz7Rd2HsUY6kC9/oqBVw=;
 b=tvbgHwq2gJbM4TNfbjMX2pQyDPUy7YneptKtaRKwB+1ToDgPQfn2smAZdxJQlQTmvbLiyZ26l
 5k6PyShz8JiAVIWTe2aD7LDqHucFpEQa9OIFmg0XQui91Nck4YQpAmm
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the Amlogic T7 SPICC compatible to the device tree binding.

The T7 controller is compatible with the existing G12A SPICC
implementation, so require amlogic,meson-g12a-spicc as a fallback
compatible for T7 devices.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml     | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 4e28e6e9d8e0..f0ba15402a4c 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -16,10 +16,15 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
-      - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
-      - amlogic,meson-g12a-spicc # SPICC controller on Amlogic G12A and compatible SoCs
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,t7-spicc
+          - const: amlogic,meson-g12a-spicc
+      - enum:
+          - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
+          - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
+          - amlogic,meson-g12a-spicc # SPICC controller on Amlogic G12A and compatible SoCs
 
   interrupts:
     maxItems: 1

-- 
2.52.0


