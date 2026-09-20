Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99F33E36A;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892014; cv=none; b=iYTY92CxDvTo2lBMWk8COPE2fYXBhggIC6sLsAHH9F4JxgzSk+WkxrJHOneJUNDiGjY0M/IIMC3DPWyg0u0fuF33z53Da84+Zb8YHj0Sqi9UdpviTvzkKBsi8kkFzwyzmjoMYdsHQ6obX8R07709Hv09/esXR+JGB75w+rC+OEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892014; c=relaxed/simple;
	bh=zJ4Kq0ilfuKS6ulNMZMQIAYed/md/A689VodwX/hPzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cwh6Mg0ejf7DZMou/ZPDh5KErPN/Mp677jogJsqqzcLp/wm576IDKviw5eqkMgUn1v6zM+GUhIpaaxEFG1oxIYdSOO9Ub3Ik9ealr0FDNNCJSsV33/XHNCY6HxCt+xzASdLXArpTSci924bejrlPALXshaYpmbuxTfnFrSxGoWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6SyDQS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6SyDQS8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58B79C2BCFB;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789892014;
	bh=zJ4Kq0ilfuKS6ulNMZMQIAYed/md/A689VodwX/hPzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M6SyDQS8Snru8vjucK4v7O4WRsM1gD300q/JYXyIsM2gcOm/OvKd53Jr8juTiZsrD
	 WBPVVmkqopihFl9v1BhYpeOu7nFtvo0XuWFYE0oImf5SgaYwPqTiFNQmcFeuXo/j8a
	 +NbByStJZ4R7gw0Cj6dBi9e7RWxD6iNhSVUMG0TpIsJ9PC2Q7cws4pVzbp0QSEiOtk
	 vCoNondtGjtuXxfs1TZeAwHtdzPDOD12slhjruifvY0gqOAPh18xxYpACW6VKN4Ymy
	 MZTQ3nPkba1mOwwC3sn6u3yplZCrfiIcKDkCJPl/PILi3TQ5qUStWABw57gjRzha/v
	 GCp3wwoZtNitQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEBC982E6;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Sun, 20 Sep 2026 08:13:29 +0000
Subject: [PATCH 2/3] dt-bindings: net: meson-dwmac: add T7 support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-t7-node-new-v1-2-e6e0840c1b0b@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789892012; l=1537;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=abTtflC0UcLD+x5kKzaRfULETMk7wpSe7VhzrgrkyKk=;
 b=Xcjkq4cXvlSWwCECEchY3frjVxn0apaxGFXF2H1YZnqGdeP0qtqcPy2fGBF3YbMQaLZhc1VPM
 75XgH1ade34C1T7656apcYR9pzp5XdTv6rBpsQq5G0yHbxF0IiyuR3m
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
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 5c91716d1f21..f75a275e2d75 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -28,6 +28,18 @@ select:
 
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
@@ -139,8 +151,10 @@ properties:
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


