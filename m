Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2A2248B9
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573881; cv=none; b=Ye6CRb9JZVQPNvmwRMIHNbg6qHbjc71q1NDDZ3LpFmUp0/FQVmfJhtUh2G9vQxRuKgU/uqvAErZDO09amFaALdBmDVEL8Bvfza3RWjj6wqFZt7eSzmwy8BhJpk75NFMr8XDvA3u3W0ZV62Bzc4W7cnlha3qBoCIm/T1u3I7euAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573881; c=relaxed/simple;
	bh=AZKWRwnPcDmGna5D4XqVdcKgsyc23TO/G7JP900AX5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKzYsIeqMIlDuorakYW/xAdcGQvRq8fKPZNyaLkoRNMvPHY6O24oRbO5fVxO527TfSeAtBu/NmPzx0s7cHB84doFp/sf3WWGyOw6ztoVNsSScuGwMy4O9BIkRo6Sd5NnFAHR+F2igK1+fgRXyWVs6+g0VBkWQp/JisX7FysGkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLpRSsKr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLpRSsKr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd832155so3223546f8f.1
        for <linux-spi@vger.kernel.org>; Tue, 07 Apr 2026 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573878; x=1776178678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4X5Ywank+eNVyFO5dPCj1pjA8q43kOKW4mZefNgApY=;
        b=RLpRSsKr+zFaujQTiSvk7F66hu3JKuCAvS+CMYFCS/kS0lW5csqx7xq2K0ZMnSNT6t
         O02Bo/zi9zf1It3ZLYvWTtwjx1R1u9xHfd6YsPZwKrIKinlHXyOtyWUJad6C5OrpMP+N
         aQpu9K6YNB07Z5mC5VJvy4WDG2f/V69N9+8PAAFrkAcva8AQFtmZk/8g8Lb9OSE4A4Cb
         WXdp8iro2K1rOjj8eMTTAtlialPJoJe9RXKmOBhrh+q4biO/Rw2ChDZCF/nV2N+L0Nih
         /w/dkLTQZrJpe0XXBk3OIMtjMHslzQdYQCw6xt7d8Em/t0YQjyQH8mNn9e6qIWxtNddj
         EORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573878; x=1776178678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4X5Ywank+eNVyFO5dPCj1pjA8q43kOKW4mZefNgApY=;
        b=mNiJWUelnjHY6lKk5u+vmoWikIZ9S0LZ8fBCsGcJwcC5GVIr8XupXtXLi/Uo36OaGi
         mTXfuxqFEKE2ZAkL8fBx5ee7J4LadW0ZjKa9lZ1q4rN1Nqi06ISsi6iyK0hrT8p8D6m5
         yZKsNTw7cx4hDTLScxwFWzxRW7R3EUHcP1VWOHFzdaFFWVfeL6VabLLYBkZnksOQl+hX
         KjdtHnHuXJQ/zYZTFl4ArSY2yzQqIqwUsbb5uE4oLXSmmmn8sSeaN/rmlZyaKt27zUQP
         uN8X6SIve6Rv8ZCCZ8jjQ6BDvrqM9tsXSrCOO/YpAc2zTHy/bRdL4XtqqTzT3lFjftRX
         GR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEz8jTu0zR30rrFVk9HzTyTKNKidaljKwdfnGBxwWQVh+oH8WkuClrSVOiQUjB+5Ltt4DD5yNeZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2riIQyPwzxbLHahIu4sKlm6FURC7Q34IM0oeS4l8Cu+CiVuR
	seqV6bdhupG92elQJUojXzwBsQjT7tCOCQvdtdPXy83G89x/iBQBrPOX
X-Gm-Gg: AeBDietkX+OOMqSM8aXOYjrj6YRY3AQ5vnLW6W4ZSLfLgqn5CoPlY+18QCEdH1IWN+K
	044nykinyIJ9Bg6eatcKp9wKEQ4rNpF8v45D1PMvWx7lCOSKwUkYSnx2QR9WGLLqbB5l+Hq+y45
	vGl9EfN5EAWkdPIouK3Lml5xpKePsYujad+ZR+O/PZz0JhNWj0B3yiL28U5CDGEf4qnpAFOFdBA
	AD0XmHQSNTd4Tg06nFNrjcBU9V8w+2d56wXUUTttjl9KLq3Il3CyugkC1/K9CxakkoGBBeUr/eF
	Z1po0H2QV1OsoY2KQHh6CDKNeFKvPOQSZN4Jlw6dzn1l2j3b27X3gIQCeZw9eIKmv8rTDHefjkn
	MwKMO+1ZaoUynB5gJerPunpfQuhOd5jFxu43+7bCMa3+nVMMTAIEvj1yJ38sJ8ahFJphsTr/NBI
	Brzrbwfqj74bxy1UqjaZl8vudgCjsNTY8NvJJ61y8aHkpEl2Q0
X-Received: by 2002:a05:6000:25c6:b0:43c:f49f:9b7d with SMTP id ffacd0b85a97d-43d292a0019mr24536389f8f.17.1775573877995;
        Tue, 07 Apr 2026 07:57:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:3f9a:11a8:20c3:fe58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm45207018f8f.9.2026.04.07.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:57:57 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
Date: Tue,  7 Apr 2026 15:57:50 +0100
Message-ID: <20260407145753.101840-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
References: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added ordered DMA names for the dma-names property.
 * Dropped the tag
v1->v2:
 * Collected tag
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 2c9045fd51de..6f4bb83a549f 100644
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
@@ -90,6 +91,33 @@ required:
 
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

