Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F1283FC8
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135429; cv=none; b=MaPVAnLRrPyM5sTXtZa8vvFqhrs6tOd79QCpN3VI6g0WDtRa7zuQQP5AF77byAWkKMdVu0kLfG5gV/QnKzC99A3JUt+ulIeXrC/676ZJWgO0IB1EDCNcuLhO0XAGqE3VYekf2QUXcSNhxqgH7L+5JvI7NrJdRsuCNbfiyNmbdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135429; c=relaxed/simple;
	bh=MCHqP0/9mKsRGiM8idpPJEeRoId71ghKES3KYS1wrZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdOfBrsxQ9DeJ289Tevd4DDqAwh5Kx/34IL5l0/ODnFoT210Dgs97wZscADUocz+ay2B4tVz2Ep9WoH/f+Okk9e+3GLnEYH9frsrgmt/AWsfl4s1cc5IjXhqwKdQ/j+qI54VqdTIOfUzfTLBnQoAGmQPyeOFPL5KAWP0KG3G6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNzBUd3A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNzBUd3A"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so6311365e9.0
        for <linux-spi@vger.kernel.org>; Thu, 02 Apr 2026 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775135425; x=1775740225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahjbezGoTOSrl9YhAZ/dYPEkMg/P+h9Dme65OO5s5X8=;
        b=gNzBUd3A7ykKBOzSxScHxB4bMc0fIL4gSD0GG8hWynvWbNAFt1ncCvUhpjp/dMeleL
         uczxM9kFIbHLc6bC4Wgk0HI4a4jfqAR6LOPBAHn0M/+63KVeTlEdz/sgQ+vkiOpVAzfF
         q7fqZzG4UE4bsXjnd8kyvYI2wMaDLePN0TU/y1o1xq3bkQ0q7npVss0ncE74dD8pd45u
         uXTugykQUMDk1FN/Ckkgpy82z6m3BrUglYLji7jRthnV7SQ156V6CocJucsRGGwYwFkP
         fJGAZ5M9Z+64QjpYjMqhwOT2sqs31QczpKDqKKnymBFyneJfZewvzb/AfgYryX5KSUhk
         jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135425; x=1775740225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahjbezGoTOSrl9YhAZ/dYPEkMg/P+h9Dme65OO5s5X8=;
        b=APQg0BQnc5QvS5Gmi8YaZECInyIuZ396tUydvKAnnIbnua1XBCsHNsMfEEecHfr23R
         /GXvESbUtfGDhcy17rHGzpswh8ZGEPUzd+f+bnSYAI7t0q2pOYs7tp15I6fUr8oNgBnf
         vIoLdhnVIcUlwH0OMgVKDeNdYD91mDWBh0Q7ppu8NfSrxP6pFLe732JrYbLKqVTHWvfl
         yDMD8WS7qfaQmNJ7rfveZH+toZkBT33wPxQP/GboIhk/xOlqrLYnuRNzIGc+tumSD4pZ
         IFs6C1haxmiljblNDG8mFvfhwdnObofdNpCamkMwqCevu3e74Vfr3ecM/OKKRDR1UI2p
         yLJA==
X-Forwarded-Encrypted: i=1; AJvYcCXx3H4CI4Fh0DW9CrcU4juupO2tcck3GKH4ME8Ohrz+DgIGoqY5mRquIB7N1Jx6cWWLeVlLaAQafx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16h65sIXWSdpdI0ZoNcw5iCr05e76+Mt7yuXdjhwgckV7yzuj
	fGGvfRQNbbnRmLoQwq4UKe2CpctSreshpCu5GC/HrBHDDnvZUzu30cgi
X-Gm-Gg: ATEYQzzF9IDqhwknb11gqWriZEougT6POBB4XE0GNYOQ8aSTaiZmtLPBGlTiMS3jIlF
	SG+YD0F0WWmQ+9q9vab0uK6GA7uHvmLO5v9g8YCkctI3fp15IEtD3svLaciVSJ6l6AmVjycux7K
	p9rf6J4muM8z5RGyI+2KGfgAgiHfLZkp114aAZ9tlHXvFC8yazt7Wu+t5Lqa8DLFVZYeJ9zMOfM
	YkWAuC3kWdo8Jv0nESLWdAK648iIOmcMNQfrE/MkLrB+LvCIXXISjvTslZoGYl28Mv0zoIDxZT5
	rofV/tS3PaeA/7PhYqVc7c2a/lBiVFzETigK6mjXfEZh5IU96464SdVfGQ95dZ46L3ueeIf0/4d
	va5KSNp7bNJPH7X7I244Znvf5p9vxQFXftl2OQm9eRnJxIJFkvqcZLGrYBhk8tnBIcW9Za7ZFUc
	Y4HUZBC7aJV3MFu4wgMwqU1Pv2/oVoya7yGG0QNOUf2QJGgYGV
X-Received: by 2002:a05:600c:ac8:b0:488:7d01:f67b with SMTP id 5b1f17b1804b1-4888e042775mr27766995e9.6.1775135424624;
        Thu, 02 Apr 2026 06:10:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:1526:47aa:5ab6:5a85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm8040753f8f.4.2026.04.02.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:10:24 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
Date: Thu,  2 Apr 2026 14:10:16 +0100
Message-ID: <20260402131020.143123-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
References: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 2c9045fd51de..b4358922487f 100644
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
@@ -90,6 +91,31 @@ required:
 
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
+          maxItems: 2
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

