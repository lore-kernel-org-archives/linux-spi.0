Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AD3126C2;
	Thu, 24 Sep 2026 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229074; cv=none; b=YtGS36o04KphiBa6F6a4mLj+8rlVYiKOJK7CiFbG1BTHB2siKDmTtpN/k4PGVvonFQCyTLjOiiYr5c9mZoEVbui6izo9oMjKrlvs6kcYWda3XsYqoqaChut74hOCktUtwo5B1audS+Q1LHx1L8fhJPX8NCENSkkfrohNwlsG0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229074; c=relaxed/simple;
	bh=l41JS5K56S3JMbzVD/c0nALjK4wnkjK4/XwAbncRLKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/lyF4sAnxAeaAk1uhbZ5D2y+i0WDttQXN9XmjBf4OMNcjrenWfME9ymZYIgE6ol7V0rJjtjvu3YL0xmNCN1cJxTde6IorrFpLN/041WVvUSjgUIPKJqJLpqDsQ/FSISw9ZLZS6kLfONLKR0WptHkrLBTCYaLlc0WnG4WkiyN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIdPA8G+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIdPA8G+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1085DC2BCF6;
	Thu, 24 Sep 2026 05:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790229074;
	bh=l41JS5K56S3JMbzVD/c0nALjK4wnkjK4/XwAbncRLKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XIdPA8G+vv0RpHabyNFHTKbIjxeM0ZClNzAaqxDlurMYVKrI0LDCYRuohYwNwwfbG
	 20EDKdTw0ZGcDXSdmz2rHanrZuvNU0vJVC1LTfHw2vKAG8u4HwtVSlVDU8AtSbtpT+
	 J/ZKrvAhNI5Cu5xXNrvbRYj4164PT0QyvXXEuQPqgTmziyiFK6jWDuaVZ/FoZpupEl
	 QZl1QHXNVFashO1QVRL9gHx4QRLgwwC97XqxoH13xaiBBBG5SroDCvv3UCg2zGh1/S
	 l2dl5BsunVuGoZ/76I1gC/hBVgMTUJkdQ9p7m8SzG1Z+m+QT6dd4bdY9hbUJtFLRvG
	 dw3SIGJ14h4aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD8C982FD;
	Thu, 24 Sep 2026 05:51:13 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 24 Sep 2026 05:51:09 +0000
Subject: [PATCH v2 2/3] dt-bindings: net: meson-dwmac: add T7 support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-t7-node-new-v2-2-319d3c19b4b2@amlogic.com>
References: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
In-Reply-To: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790229071; l=2194;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=OuWtCvG4zrP01yJiFjTkY4chxxarHmWUIHB1zdrvrrw=;
 b=uOsEnSyIlN8J9zL2lHAk+qTRy4/RCF3TeOmRM09rdTe4uQU0D49uiM6TE1HvbeeTvVGRUoVG1
 mGboAlM++RIA2XI3U47qg+ULRzkuiibd1WI5B66c3AlVk/+ne+Kisgr
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add the T7 compatible to the Meson DWMAC binding.

The T7 DWMAC controller requires the following compatible combination:

amlogic,t7-dwmac
amlogic,meson-axg-dwmac
snps,dwmac-4.00

Add a conditional schema check to enforce this compatible combination
when amlogic,t7-dwmac is used.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 5c91716d1f21..b529ca5577a9 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -23,11 +23,24 @@ select:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
   required:
     - compatible
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-dwmac
+    then:
+      properties:
+        compatible:
+          items:
+            - const: amlogic,t7-dwmac
+            - const: amlogic,meson-axg-dwmac
+            - const: snps,dwmac-4.00
   - if:
       properties:
         compatible:
@@ -38,6 +51,7 @@ allOf:
               - amlogic,meson-gxbb-dwmac
               - amlogic,meson-axg-dwmac
               - amlogic,meson-g12a-dwmac
+              - amlogic,t7-dwmac
 
     then:
       properties:
@@ -93,6 +107,7 @@ allOf:
               - amlogic,meson8m2-dwmac
               - amlogic,meson-gxbb-dwmac
               - amlogic,meson-axg-dwmac
+              - amlogic,t7-dwmac
     then:
       properties:
         rx-internal-delay-ps:
@@ -139,8 +154,10 @@ properties:
           - amlogic,meson-gxbb-dwmac
           - amlogic,meson-axg-dwmac
           - amlogic,meson-g12a-dwmac
+          - amlogic,t7-dwmac
     contains:
       enum:
+        - snps,dwmac-4.00
         - snps,dwmac-3.70a
         - snps,dwmac
 

-- 
2.52.0


