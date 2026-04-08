Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5344345CBF
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638469; cv=none; b=SReT83Fn51/htonYPdFupGsctflndUrqk2xNdCVjlNj+scXf6lmrCpICeUntRcYsRd3BivHMCu3LsIWy9c1i9SzTFgDYy7nPslmfoNt4uy+IuPbT6pCYhomKvhidmysTGdlMD/yePyH2oayWV5kQkuTCUNXOA7K9MyrrUFuEG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638469; c=relaxed/simple;
	bh=6hgrXq69GCUKWlQaQ7SWZ6JWGUmF0JVirVlDe/CQUrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9+7FwFOnWq8oS4xV4PzDxgg6apotDSeKtk3s3y6QGPmI9mOY879Mhfn2GqJK06Q4gNAf0NXULQMxOX/v/aNmuzSqIN5iTKQ+goCotb/JuuMPLkRA7AvLZDfCTKRc7NLhKXGOqq/Wu2iPtPf9sHy7kyx0//rkbe5W3yoRElT8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS6PduTQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS6PduTQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso54537635e9.1
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775638463; x=1776243263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3C1NsEd8WD8aDITqUFHuUeRrOmqKY8E222OL3+PqW8U=;
        b=kS6PduTQTvZTSTjUWpC1yOrIO+G5oiM/JwHplJz41+KMLKe1gpVOTa/eumM8eAOyJB
         ePrlnta2nF9b1E6h4ArB/hdmsiFINyw2OMcHW/VNiGJ4R7aeMwWO3t3sEVQ6FDzoF7wP
         3D9Z6iNf2mZ72+eywbFUNNKgtJP5aHrPCW2uHVzeLU4OIP1HUYxFwFuWj1PjaEvtGaQs
         S9l/HYLKjFfsigVUdaFrYHXHZs/7ExaiZX20xhLGpBUOIcZMu7QbA+hbQL6Ei2h6MRFy
         Di69Fj4TYh1YP9iGi2D1hzbntF7NuHm9jLEyOJSs7Nx7RCULC7SOEe4fB0BuhEAxmH7m
         MpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638463; x=1776243263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3C1NsEd8WD8aDITqUFHuUeRrOmqKY8E222OL3+PqW8U=;
        b=ASQoIFufdepXwpqnp+nBfsCvBJ7yfgqNnO9CAl320JYU/iG2LlicK6zdF7ArUz2kL0
         kzBQGN7YWAm5bVWXVt2U3Ju8aiSyw0c+i/b7b7UUvtuaQ7AfWuW1MAKOamlaKDzK2m4m
         ETYCjXZ8Aq8yUKTJvEH9p94hjNYfHW3H1nfEvenyhDQQEvOqkv5RMV0+AObzEJQ/GW/J
         +vYB5waeJTkI3ICHlQjuztRDSqtVzvw1vq5V3cFSKzYWs6QrluU76Fqrm4hwPI9a8Uvu
         U7mSOVUyqDKSYZbXswxIry8s0YCaAfCktgO6UbXIVTVJi0u0ww3IYsV/2n3dyg6biYDT
         nbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9sf1gygfvdMululRJcePwDrPIMQC3nAf9R0+UJNH0AykkzhrSFFE8WANklK7ARSeoyDely+nlHDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonrG3Hd6Ruc9pcSL1EJbqqv8lpakBEe3MzqNFzzFzVQmkH0wk
	Vort13VYEqQ6cG1HUU2f2VqiOffbcEttLkrMyRqGExNzT5RKQNl/l81h
X-Gm-Gg: AeBDieuqoTSbvpHimdSBFEHSpyxR5l1dhDJEPSIeAn23B/ANebX5p55SXC12g0oxCbX
	1xrYconB4NdIFi1Hrk9jjJqAaiDMK4L22cQtiWuuh//IPdwy8o/NmhWRDIY4s5G1HOd7vsYfsgC
	2s14zBWW0inVBSgo8XGELBDumjo+NKjyZmd38dxeVJ5vpBldW+G4O9U7IOvfrEz6gW64bnPlAKu
	xSRJ4oV38/I4uh/WMKYisbGjeKZCRlfTr4rk7y0/9PTJAW/DqZ0Qf560YdkWjIIBX9Ak6f4VWUn
	B9sYA3NmWnDcWlZwX+7R5W7ei7pU0s7/glvqhq/SAPDC2sohA+KiGCNloTaAqpon61zUIC0eliH
	HvUfNaLKS2XNsARUjxwVMz4Xo4L143OJh4wJF+jJNVYnNAQhL2FwhgrXqNIk2XL27Q0o9P2S6IT
	rBptFMnDe3uIf1zjulBwJu81zhZwTFbIy6vyuFDC65KLW45QM=
X-Received: by 2002:a05:600c:3105:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-4889975f7ccmr280966105e9.13.1775638462848;
        Wed, 08 Apr 2026 01:54:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c50a7sm56437678f8f.15.2026.04.08.01.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:54:22 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
Date: Wed,  8 Apr 2026 09:54:14 +0100
Message-ID: <20260408085418.18770-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408085418.18770-1-biju.das.jz@bp.renesas.com>
References: <20260408085418.18770-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document RSPI IP found on the RZ/G3L SoC. The RSPI IP is compatible with
the RZ/V2H RSPI IP, but has 2 clocks compared to 3 on RZ/V2H.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Added a blank line before the dmas property.
 * Collected tags.
v2->v3:
 * Added ordered DMA names for the dma-names property.
 * Dropped the tag
v1->v2:
 * Collected tag
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 2c9045fd51de..f40f316943ba 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - renesas,r9a08g046-rspi # RZ/G3L
           - renesas,r9a09g057-rspi # RZ/V2H(P)
           - renesas,r9a09g077-rspi # RZ/T2H
       - items:
@@ -90,6 +91,34 @@ required:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a08g046-rspi
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: pclk
+            - const: tclk
+
+        dmas:
+          maxItems: 2
+
+        dma-names:
+          items:
+            - const: rx
+            - const: tx
+
+      required:
+        - resets
+        - reset-names
+
   - if:
       properties:
         compatible:
-- 
2.43.0

