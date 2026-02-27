Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8B362149;
	Fri, 27 Feb 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214725; cv=none; b=u2F6U594NET/YxG4PJ/uanQB9BnjzaDjVREeb1+e6riIbhadGzS3nPTzweq5VKE6NB8GEdFb/gfHho5NWihfL8p8ikAW95YzxZAf35h+QeCLT/zq2NAxfIl+u9GNNDqLIZWZnWJX73c6JeOfkg+NvXJslQuiJ1A/Yw8m38G5aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214725; c=relaxed/simple;
	bh=wFLm7k88fcySk3WbqBdNrrXtxAUhx3c2WSVbqeGab6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtaSmFW/PT5ZcBiXOeshf0bdLdMI6rFoVX86IisJxHA/NYWn3LHGpcr+e/zVIGHC5p1zqP/YDx9tNiww1axaYniR1PWNBCxf+A1E4kZUViZvOBdk0Ghyp68Bz1LZMm8YJA3zaLWAUS6XakSLvYJmXpkq9lTOIEhpfMpGc9H2lRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heXXfdoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heXXfdoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E91BC19421;
	Fri, 27 Feb 2026 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772214724;
	bh=wFLm7k88fcySk3WbqBdNrrXtxAUhx3c2WSVbqeGab6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heXXfdoP5arDJG3XvK6VZxm+PHg6R8na5fMOeoSlO2E6O4YGrgRkiBriyJHTSr8bX
	 /R86Tpaugnokera4ihUa40vBWWIz7TRrKhxpJEjvXX8flVv0QoRThSIrMEjFo2XnkC
	 zK5CU8cebHKiUc+b9vp0ekw3EfyRtcOmiNalvLJLxg97tMNa4J0A+C+MtOaVDFmmyl
	 N59oSqG8Zxb4UyVAw/zfertnV0JIdCcedq+fPs3k6JpO+Xf5vmc9YVZ0M9PBgvFVT0
	 T0FA3ylv0Rz6q2tk+pG261JRF2j9fYATOU3+hcfL+BKwB5TUGjWbpBPCrv30SkEF1D
	 sVNE6RmUGJDXQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 1C4DE5F9D2; Sat, 28 Feb 2026 01:52:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
Date: Sat, 28 Feb 2026 01:51:53 +0800
Message-ID: <20260227175157.2339758-2-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227175157.2339758-1-wens@kernel.org>
References: <20260227175157.2339758-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Dual SPI and Quad SPI was added to the Linux driver in
commit 0605d9fb411f ("spi: sun6i: add quirk for dual and quad SPI modes
support") and commit 25453d797d7a ("spi: sun6i: add dual and quad SPI
modes support for R329/D1/R528/T113s").

However the binding was never updated to allow these modes. Allow them
by adding 2 and 4 to the allowed bus widths for the newer variants.

While at it, also add 0 to the allowed bus widths. This signals that
RX or TX is not available, i.e. the MISO or MOSI pin is disconnected.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index a6067030c5ed..2197f65d878b 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner A31 SPI Controller
 
-allOf:
-  - $ref: spi-controller.yaml
-
 maintainers:
   - Chen-Yu Tsai <wens@csie.org>
   - Maxime Ripard <mripard@kernel.org>
@@ -82,11 +79,35 @@ patternProperties:
 
       spi-rx-bus-width:
         items:
-          - const: 1
+          enum: [0, 1, 2, 4]
 
       spi-tx-bus-width:
         items:
-          - const: 1
+          enum: [0, 1, 2, 4]
+
+allOf:
+  - $ref: spi-controller.yaml
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - allwinner,sun50i-r329-spi
+                - allwinner,sun55i-a523-spi
+    then:
+      patternProperties:
+        "^.*@[0-9a-f]+":
+          type: object
+
+          properties:
+            spi-rx-bus-width:
+              items:
+                enum: [0, 1]
+
+            spi-tx-bus-width:
+              items:
+                enum: [0, 1]
 
 required:
   - compatible
-- 
2.47.3

