Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7A39B4AA;
	Tue,  3 Feb 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113095; cv=none; b=FiF/5/XjTpxpYLQ6JPBzceSzvp1wyHwcVc79WJHw5l3eZ8O3OXf3csNCOCJ3TNDVYQP+v+oA65ApDe5D2f+WyiTYv9e6suLJFBXnVoBkKpNvWdejOGxyBKdKLvTKWTlJqk42+04mLPLUCtxYUIEwIiHocFvuPTHkvyiUYd8wpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113095; c=relaxed/simple;
	bh=cCc3RPrMLTwTgTOa+BQG6iu6tz4SnNTh7rKUlCzcrfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B+BlhoGankumZWFSEjm4Y7qQFKcq00p8JPlw5ktmxQ6uBGDAd702nZROaHtk56FdYl9ZHTC98RHaNjWHdDqOYPxvH5j6IMlHiZSX4pjjKgxSx5FDSLMZnxVmMKXeWXkMuLQtxSin5BxI4sq0+kkh85INMqrfVHn+w3mww2cC3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItKIC6TZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItKIC6TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC36AC116D0;
	Tue,  3 Feb 2026 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113095;
	bh=cCc3RPrMLTwTgTOa+BQG6iu6tz4SnNTh7rKUlCzcrfg=;
	h=From:Date:Subject:To:Cc:From;
	b=ItKIC6TZ1SCDFaceV76fUbbRV1xfNl8K9ikKnAULfC41+8gNvKMQm91FhoKWoYyea
	 xoK5/iFxVeIAjYbbytI4OVU18D4G9gvrq2Cnq1Y/dcrkt0H6XpPyoYO+2Se7sRphfL
	 kIsc5mqoQ1QAo04p09rlSKib7CwqYa0AzKO2PKB8xknMyxQa8HZUDj0g8+EYt4qrNL
	 c6d6hrtI4fOOJr9A0fHOoKGV7hJl6/5aPlqGpAwQ3E9pvuOHZ9706kTczUy4fj5j/T
	 oRCJsBXJ+5dAUt/ciiTcPd1b8OnXOcMryFWb7C5M6bVsQkrs/jcrDlh4RfefouZYDf
	 qbviO1RF+xikQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Feb 2026 11:04:51 +0100
Subject: [PATCH] dt-bindings: spi: Add binding for Faraday FTSSP010
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-gemini-ssp-bindings-v1-1-6d85c9c72371@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB2IsRX0KuIiTabpv3CUDEhBv
 LvB5bd47ySTAjGampOKHDBsWtG1DcVf0CyMVE3e+cF513OWFQo22/kDTdBs3MVXSJL8O8SRark
 X+eL/XOflum47e5C0ZQAAAA==
X-Change-ID: 20260203-gemini-ssp-bindings-1c4aded25ac9
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This adds a binding for the Faraday FTSSP010 SSP controller,
a pretty straight-forward syncronous serial port and SPI
controller.

The bindings are submitted separately because the one device
that has this is using it in a "nonstandard way" with regards
to the electronics, and does not make it possible to develop
or test a proper driver. However we want to be able to add
this resource to the device trees and it's not complex.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/spi/faraday,ftssp010.yaml  | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/faraday,ftssp010.yaml b/Documentation/devicetree/bindings/spi/faraday,ftssp010.yaml
new file mode 100644
index 000000000000..678598de3400
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/faraday,ftssp010.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/faraday,ftssp010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday FTSSP010 SPI Controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+properties:
+  compatible:
+    const: faraday,ftssp010
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  cs-gpios: true
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi@4a000000 {
+        compatible = "faraday,ftssp010";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x4a000000 0x1000>;
+        interrupts = <0>;
+    };

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260203-gemini-ssp-bindings-1c4aded25ac9

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

