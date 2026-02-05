Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0776301024;
	Thu,  5 Feb 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315013; cv=none; b=g1z8EA+TZrrbPkJinp1eKQVa9l7ZATor9xATw6i/bqJiNbm50Vx6Prxn9+jl13o7wixRDAJMJZMaPxFbxOjzY4jwsqoRXUssLEUQjoxDE7IYcq5/OlQjq+4eW82UUsChln/jeLCdjD7smyPN67DlIx/CRjGeNZc38/oXfI2aTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315013; c=relaxed/simple;
	bh=Pt5FlRkEKwzIGfewhqHR8A78kJ71IAiCm7pqKrlRxSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUYiCsBhkSjfJyhVcOogUaNzxRbkRTa8y/PGTw3+FViYmKkif6mggw51owjkVaKo5E2TX34LgH5NPe+OisZkO+IIXvi6QZnIMzmLvTmLbwMGqK8hG0kCTlYIe+Xqu82Bf9aUL53bdKc/VMMWBSAIm6BLJfdB7kVXdn8rkgozFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UG56/n9M; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UG56/n9M"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 55F00C243B3;
	Thu,  5 Feb 2026 18:10:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E8876074D;
	Thu,  5 Feb 2026 18:10:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A15F119D170F;
	Thu,  5 Feb 2026 19:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770315009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/HEikuqB/j/cT8sdeHhmkNX1YhSQzvZ02fJms5jDTDI=;
	b=UG56/n9MAsv6+BVZf65cGqC0f/P7AUdvq2+qZgk2Sd4Kmax4ic8lB51b1x3Sn34NWufGaw
	R8roi8wqwrHRo7IXwOlMBPG7XDXQyRyjeuzGBDXNiG5BAecknhLoSC9dpML4lqNofO01xm
	K3VfL1lkhraiwTDVJXJkcg6IuA9De9nQH85gu8cWEUMb5llFCX1RdRECi5DHCLKJunB92D
	+OyzBSv7Jwcz/5zvo3w0NKWpox1HTYcZtFK/1RhzshOMiCXjaXvhhZLaTGBVODc+howbsZ
	+W3TZPTq+sLIux+C7kpubyO6XObmCHiag4VQm+Qno4VzSAbeFzOhNS8EK6HBlw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 05 Feb 2026 19:09:48 +0100
Subject: [PATCH v5 1/4] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-schneider-6-19-rc1-qspi-v5-1-843632b3c674@bootlin.com>
References: <20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com>
In-Reply-To: <20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add support for the Renesas RZ/N1D400 QSPI controller.

This SoC is identified in the bindings with its other name: r9a06g032.
It is part of the RZ/N1 family, which contains a "D" and a "S"
variant. IPs in this SoC are typically described using 2 compatibles:
the SoC specific compatible and the family compatible. The original
Cadence IP compatible is dropped because it is unusable on its own.

Indirect accesses are not supported by this flavour of the Cadence IP,
which means several properties have no meaning in the scope of the
Renesas compatible. Let's make sure they are no longer expected nor
mandatory.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml        | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0d47bd94d67e..891f578b5ac4 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -61,6 +61,20 @@ allOf:
         cdns,fifo-depth:
           enum: [ 128, 256 ]
           default: 128
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzn1-qspi
+    then:
+      properties:
+        cdns,trigger-address: false
+        cdns,fifo-depth: false
+        cdns,fifo-width: false
+    else:
+      required:
+        - cdns,trigger-address
+        - cdns,fifo-depth
 
 properties:
   compatible:
@@ -80,6 +94,9 @@ properties:
           # controllers are meant to be used with flashes of all kinds,
           # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
+      - items:
+          - const: renesas,r9a06g032-qspi
+          - const: renesas,rzn1-qspi
       - const: cdns,qspi-nor
         deprecated: true
 
@@ -163,8 +180,6 @@ required:
   - reg
   - interrupts
   - clocks
-  - cdns,fifo-width
-  - cdns,trigger-address
   - '#address-cells'
   - '#size-cells'
 

-- 
2.51.1

