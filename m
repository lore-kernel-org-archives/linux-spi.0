Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800C476CDE
	for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938018; cv=none; b=Qq4UqQ78cuAnVfsi2YkLDA7Ons72G51DvCKosr64u24EcI1UlfiEqcJtPdERjlgLve4edEHRwWIkR7lEzaZkYqA8ak9oEZBVy1UMweW/YI8dJjV3dlAERBWiuztrzc/kZ2pVCqUvPWh73Xm4bzcC5Ii3CbhdX3eelZhgEPxg0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938018; c=relaxed/simple;
	bh=tjeFziad/u/dJ8yWqijM0VUOkYWgyCYz1BsP1SGqSnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LdPPmhC0yyonxDBrsnU/2zq2Judj9Hc0ju4HkU1QrFq/L0r2qMrgnejKv/VFO2FSKtsLswxhvuEQS0IBS7g98ZXIwYJZ2s4/YmDdzNDtw6xaqK4QE+yRAJoCAZIcG9BmEdrD4bS1oMYUshF/6XOGWde7/vDpcWJQu6IhrWIrWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=avgcgxDF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="avgcgxDF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so8296295e9.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785938014; x=1786542814; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W+FtOkXSTFNOnduj3n3KSEKK3xwTvAgLSzJMwQ5j5vA=;
        b=avgcgxDFnuJBuhWvZNgMxgECrhGx8ZUvlUi24xO9eydPYd+gkZe/aJtsK9hlA92stp
         YofJys7e7U6ZX++SbIUPeOApAUOwvQo3MK9M+1Hg94S1ulwyhjsBlcoKA4UZcmEq4TuW
         /OdwVPMUNfIR89/vqBWco3URmlTnqhhpS2YQsu2Rd3vTLMUZoM8bNoiu9pMR4dK7/HND
         gEZip7NpsF3y2I9VldXpHiMIhKnmwxXnxzDccZCFLXuWRL4Z+mW+9qwJtY6SiFlZ0MXx
         CVwfGDGD17HYUhjlD06hHQgtTVFwYiSSaxoYlhWwEbyp8KirAIwrWo2kcqv9zXtG3PFa
         cf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938014; x=1786542814;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W+FtOkXSTFNOnduj3n3KSEKK3xwTvAgLSzJMwQ5j5vA=;
        b=bYyDPeT0pFCuHQEr+hay/Rp+2COUlHg5NO4g+qNcs5FIJo2OdIlMe9xox7oQbKmzDD
         XeAYlTBhxA94rwVyG1yvTXOPf4+b5m3w2NzH0aNuLT6brUQ1Xw1V1Vh9Cz4crAJ+mVdy
         52j3cKpa6AWk0cAGE8bZEC3UQOQVs/D+XHKyJ68Xl/1a9AYzL6xoPEcpPlguhdnhHbP7
         PPQbXe1ALx1p7LrzTyfhWERCzaIM+y66mHHFsXx/HMpcvqPo4MGuiCla3S5FBrzp82EQ
         RL8FcQOA1pkk8I/D4ZAhrQfdmkA4EV7KM6pIqp0Ggow/P3YtYWr7cYFQAFEzdeWy3YnY
         SI1A==
X-Gm-Message-State: AOJu0Yweo+kIOGcdPZk+io2h/ksJcUjeF83nuLbmDsUiMm9Ys3sjAxYK
	55aGktzyNI4b4st64klzpGK641m6QO0Aq9OpL5ZKSKYc4mSJvbcPVn/cDXVzZBboCgt+KhkU/pS
	xBK0loyW8+Q==
X-Gm-Gg: AR+sD12+Y275K3Q/XPJuVDhBKHZvnbdYe6LVkFtJ94aAD9zCbuMn8uVqAqz08dg78Jm
	cmZJujELHXk1+l4FyJ4ph+Zmgz0y28ELztk5XJNWS/IaQTOZW+BYKQL7KE+QkiMRsA/tRPJ5G6e
	wFuya3GnqfWeDwetnBgpgfOXCLvzT6l6lazFNr/DNehbxN+pAO25zT5Onp3unKgY+9NEDqunWL6
	EnhMHathgdqirn/eXffGP4ZVvrwnmBc3y1oIRexL/Ye1OA0/mKLMz9BSYIiMCcV1FkL1uee6/px
	5leh/oFYZNcwntAuyGHMgH9m/cSCWd1wWspmk5iSPB9J269DbStIfuhvTIS899F04DJdrhZATC2
	MOUZ0f005Kg1SCwVQTihJAV9W8XehZmZplG/zurPWnsLIZxfIxU9fZgHl59dP7u44Uak3fp48dy
	i59VmuLWVhAfsSWN+IJCKYYcFTTIHE6mGHkWZwUR5ctENxptmm3g1IExkMuaE=
X-Received: by 2002:a05:600c:1991:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4994e7448d9mr86632895e9.2.1785938014491;
        Wed, 05 Aug 2026 06:53:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b779:ffeb:9b9b:3a9b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49949fcb0c5sm159237985e9.4.2026.08.05.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:53:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 05 Aug 2026 15:53:26 +0200
Subject: [PATCH] spi: dt-bindings: sun6i: Add compatibles for A733's SPI
 controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-allwinner-a733-spi-support-v1-1-7bfd1141ebc9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFVAc2oC/yXMQQ6CQAwAwK+Qnm1S2SDqVwyHslatIcumBSUh/
 N1Vj3OZFVxMxeFcrWDyUtcxFex3FcQHp7ugXouhpvpAR2qQh+GtKYkhtyGgZ0Wfcx5tQgnEJ47
 UtBygBNnkpssvv3R/+9w/JU7fEbbtA4Ss/Np+AAAA
X-Change-ID: 20260805-allwinner-a733-spi-support-e30a9ac057a3
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=tjeFziad/u/dJ8yWqijM0VUOkYWgyCYz1BsP1SGqSnQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqc0BbXNtMYSp16a3Hz5iAvHlZOspwok4eoydFh
 URQ8+kp5z6JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCanNAWwAKCRDm/A8cN/La
 hSnHD/9bg4eJC/YmvFzaaazakPMmXy47hHzZTMg8/pNF4kPFEnlvM9fslRS0ZwyjuRtEbXsaB69
 wVGH4/Jv9q0Yi3S2CsCLjgoPpVpNuD+cAk0FG4tC1EKhUyNQ1FYRPQGsT83ZvKeQU4Ex2La07Yz
 /NfEwieKVxTMURRYa2m6EcCAY8NSUfvpXI8ha+RhOiiCyFe6Yjf+IEIicp7UVTu9XCAnoSMeCQ2
 nBBCsShgom54uci+PwscGsy0D4024hWtAhMbRMLR/bUbLjuF5XCnFXByOQ3w+gcl2y+7EXU8uww
 AJfKY4FjoAroPWc+mjtVfDfVzMOCNhgNGz46AEg0fHyGf5ovPYN/tO4yheAsQymjj+Dn17I6UeR
 fV6p9r8eWz1/w3YdeQkpjX0jwkMvdH6RIsoi9VZmW5t+xdb1avkA6OZiMg5JDBdLa8RKTuBUju1
 lnzq4gt+yuYMAgqgLzvxaqFTM65nGlk8a5tDuqR0lWIPOoHi4CukQVK5yKDXXpQs8AvInYlJ0WD
 fWYlKQkWeqlyNihvdD6CALUD0nS+dQwpy6kqkEOxzsVtFD3M/PBM9C4ZVJM4aCf09KLdjj8pl+6
 PSzYzxo7OdBJHYyDXWdb1yddEjF9y60nSF8OdxNxvEaplgnryawqp7Ub9myQdCSAembuM5VKCg9
 1T5laTUca2aNlTQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 has six SPI controllers with the same IP as the A523.
Like the A523, one of them (spi1) also supports DBI mode.

Add SoC specific compatible strings, falling back to the A523 ones.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 6af4ff233158..be47c6e00409 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -36,6 +36,13 @@ properties:
       - items:
           - const: allwinner,sun55i-a523-spi-dbi
           - const: allwinner,sun55i-a523-spi
+      - items:
+          - const: allwinner,sun60i-a733-spi
+          - const: allwinner,sun55i-a523-spi
+      - items:
+          - const: allwinner,sun60i-a733-spi-dbi
+          - const: allwinner,sun55i-a523-spi-dbi
+          - const: allwinner,sun55i-a523-spi
 
   reg:
     maxItems: 1

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260805-allwinner-a733-spi-support-e30a9ac057a3

Best regards,
--  
Jerome

