Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E733876CC
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610554; cv=none; b=Lg9Ly7G5edttD4By3rZYquMMP7FAOuz0Jy60kcVI0PErFtxoL8wjODTzzZD6rc7l4x8u3g+g+EdolHMBE3NmESPnEvPw7LWXNOqzo83Q2ipE9QaiHypHAcc6ljZtDBqf6y2b/AmiawbI+3rtJLl/B7IVlqrnBSjyYqC8gD/IliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610554; c=relaxed/simple;
	bh=W/gkJJRsBNmmDGEZrfvnRL/7vtpQ92mBjqKdv38MaT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn3BcQ02O+pYWYAmMO4D1zwtvqLFkxH2zPlcdZyWDHjK727CMN7FeBqMgWv9EzTv7IB53M/Nso3Zn+L6NKm9i0i3O0mZczBA4UsXCee2Ii6vof+rukMmQZff+96kAR6DboKgNcJeCsPAIxprEcF0YmWoQ/5NR1ofwhuxOU6bZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfihW+zb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfihW+zb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b94a19fdso2857827f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Mar 2026 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610549; x=1773215349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k/AXbMZKCU8LZhAaykl/fQ4j352Dp/B/wMW93JEDnY=;
        b=DfihW+zbG4T8ZR9+nHidpJaXkDZszekspwv3Il8QeymShqAt29F1A7PAxfuMcBYsl6
         jy2NSZ0EaR+85mRS7Q3J+mOxuezYIdRahCmtF966bO1pK30NBAPqaP9W6QjShNNkq2v9
         QUk74LgSsK2NoWYziCBz8ntLAdN/S0LHLzTHt1Lzzs7VFgkGzOF/6ZQdd+zxfubtajAr
         nQdObtYGHhyZk7QRZS6YpvO0oxhZCqYj9UqVU7bVAKSBd1VDvDsHINYPqYJXP8WqyL97
         uWI7dF1unYDQWlEIjy+wbceIgKxrf+aWcoBkJhqvzeteZk9+zuNhV4qXGy80ZCRn01Zo
         69AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610549; x=1773215349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6k/AXbMZKCU8LZhAaykl/fQ4j352Dp/B/wMW93JEDnY=;
        b=pDW5S5wJYkB6RZqzC0jpsgpG64dyiVBjYe8O9hyxr9Kdymr7UpZjMVPafAMavfXbiT
         eGqZJkvRlxZPrxnO8LB5wMJ8/PQzMP52BF+kBOMoKjRMPb+Yx/6iDgBhNDwTgweL1woD
         q6mvsfBnor436kssS7jsX8XAeamfEm4gkAusFdvJYdYJiYk0A1etvixYYGbHXy938b3M
         znGXCYOX34yQqUEMtZKHg+2VvtOIbzahJbhAB76Dt5ZPQlKzO9nw17Rf20URydHn89Uf
         VeglhU2iaW5gadZrHGQP5GGFBLr+slKEH/KLSxxaMaMlemMVQyJyLJsnk003XOljeiOJ
         jj0g==
X-Forwarded-Encrypted: i=1; AJvYcCW3nwwR3Ro1IIT6+eq6f6UK9GonXDD5X+G5q9PEgL9NwnkiMmOlWS7tA8isWLea944+1zpbipG0kBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DYsnWJQGhL3edLbPad6HEtGoU5H71WnjANAt5KhyPefYlyfP
	GGhTMEhmSHQjEM5nptfEo1K8m0dU2Ez8Ixvr8TG9E4rk7QoeU9D14+KR
X-Gm-Gg: ATEYQzxMbD3hDlOhr3QPW7wNK/zaBxhfySWwRctGAH5lSJL6U2EHdPky7uw88e34Wtx
	aoSmp+LnkqkuXNkbur3nvsdqmLVXctAYkdTn/Cuw/mMJrFYXpmad/QJY1IiV2qj7aPQbUxR3CKz
	HS5J7LdO8Xpv/NxHM5iPGv8oH6TBoDOyrBhzqJJe/x5kq8MFnKtuiO/KG33NIdAdhoVkl7RN/Xy
	oPTM/mqJYqp+OnPM2RKDrSCu8LV3WM4Mnmf0JrsPLk1rZbXVR4esu5i+ZSJBNBi1ezsZ6RWefG8
	4WyU5JxA2AC1WABaXQvTjNVcS39r+zM0T6UJXan6yrFOU+i83u5typHfU6Sx4DNecYDf0AaQWUk
	uqE9tGoWQFAbkGdAKfBC4O9w8R9Yh1/NIV5S53DHMHqbnIFXx/OwaZv1PJ/nWWQMZ+DyYf/l//V
	X/SSk3wpWTAiU+w0eCmLdE8zaZs3BT9S6U9cMzOb0Q3A==
X-Received: by 2002:a05:6000:420f:b0:439:b715:6f4b with SMTP id ffacd0b85a97d-439c7ffcdd8mr1915714f8f.57.1772610549469;
        Tue, 03 Mar 2026 23:49:09 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:de3f:f927:40ff:12a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm39957572f8f.21.2026.03.03.23.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:49:09 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
Date: Wed,  4 Mar 2026 07:49:01 +0000
Message-ID: <20260304074907.9697-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304074907.9697-1-biju.das.jz@bp.renesas.com>
References: <20260304074907.9697-1-biju.das.jz@bp.renesas.com>
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
 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index cf8b733b766d..599c06ff08e5 100644
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
@@ -85,6 +86,31 @@ required:
 
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

