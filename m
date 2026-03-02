Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9C363084
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450529; cv=none; b=FzspFYmTMgPMVnm6DyIy51hBWe/YQ5bafxgUkxN2brWPTjrpr2MCe/WABckcnDiRz+MbBh1taQJWifCFKJIWv/fSsuHE+E63VWseu97CL5y7/epn78ETddRfrLkyTsQiU0gSER+MPoJfm/Ol5bMOR7mzXp/IK1QX+ZGURZGJhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450529; c=relaxed/simple;
	bh=to/yxjGiw472A4w/ZG9L65B9irkFq8+kpamX0PwYXGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6EooMvIQYYzSKiVfDTj/BPJ9+hJoJMoiGZ9Z0Rp8ElCoJIAekLj0BEGEh7HhJRnjLMkL64a8vEBoh6ur0BqSIJMz3PhG4FYN3IX37gE69kw4eGiwBCYiXW2+gN5+CxHGFVdMvEAuq8bs7pjZRJ9ONkxHP7cfb6jSVn3Fhx6RV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=hA/l9mY9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="hA/l9mY9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371bb515eso66268915e9.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450526; x=1773055326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOxR18o2+9ulYS4r73qXsZYgHJUpIGAEfbN7mi92aLE=;
        b=hA/l9mY9+sPJtrOeUv4fy4/o0mHnE5p/ulkXMbzB6jYdBNjEkROdCVi0Mx1p0bxAUS
         4GGvk/wlxvYP3/Ym6XEZYzGwN5ez0E27/AcIDCOay/KA/9uWJZuyTiwX56cGiHulakdE
         arZSRh//NnI0479BIEXTbiwYUUcagWai2wW0+F0baQgCwAeeSIO8yonEl/FAkmejimVh
         ljQqCJ+spXhLAyky3GTJNfaYhs+kjSEvbnv3KqfTKn1xxmu22yJAiF98/JoJDmUzHZoc
         MOV2CNLkorlzlvb0OALEa5nReobkDHldQoRpEiDBhNn3Dhd60XlyBVgRSbVWkFg/Dkhr
         Fixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450526; x=1773055326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOxR18o2+9ulYS4r73qXsZYgHJUpIGAEfbN7mi92aLE=;
        b=jEt1v7CziRnSO9zHTDXK4MViMNkjeyR+qXEeQgkA09Tlk/jHhXPTkZi9/pc8meZDps
         75l25ph8s/Bo5UpJ8yFqmtgHb5h1mRLY3HxOEvbwODSTEkY+sJWbGA+C1BV38sySVf0Y
         D7Sz/HZqgRFEmjuOjQdIiz6mbhyBph9kZKpI6s+5DRy0Qtlwt9O3ucNpE/BW6Uo5GYNF
         lMOgQcRLWUjgWemysjV5CF9uSbJzYJPom4Gjn9ewtdlS2d7cjXVh1qokIc9ahqsMh6ma
         hRwB/A5fXGaZiHREIdu31aaRFNVJzmyXfRR7vmq+jCZXDyOJbdIYdGSi/wkCG6fzaaPm
         /YOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCGootUUd2o9FzP0l0aG7kB/8tFC0+MsXRErqLH9RALblFG6JRiwwTuNvpGnEbEcv2fMT4qmtzLaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9y6oS5uSke8P1io0GNIlavfs1UWje0veVly2Nh/0UaiShsop
	Ct3Ynle+URE1X9puRe5uLZrHyUgLE+hNvyySCpEViZq3zTPImo56syaYBs08xvbI7/8=
X-Gm-Gg: ATEYQzxdsJogXRTPUelUm8nR/GAhpkIudCq8dGzHUpxO45BjD3pqs65a0pJAbY2fGOG
	ZjKyIGVTKN9D00bvnQ7ZBIT3McGCzSen6f6Sd2Iw1KzxagrHSKqCBrF6va+sm/mwIoANMUxXLm8
	jcZ8BVFbut6DSO1wq+Op6eHaZLfWHtNUlCwtWilichIoVaUcNHSUpiysldySo91Z0LxYZ9h22JW
	89dmMbfftULzR16S1m9b3YTxTkFwTFZwH+TEzgm2Y4qp11Sm9Q7dUIebkneXlHzyIOYOzax1kfK
	t6UvmwGXp1iSJGIjU25He07ZLn96ULpdn6Pfxba6W6KK82CQ9WSUBoRbhV3F7o2CnJdmF//ocZX
	lGqnpWF+QP+AumzZD6T1otHmD6Uo8e6vwfxQLkDL2shEONgbHRzQsCljhWG1cggEehU8ikQCEYy
	WFq3vajlXnudDcYVwfgwn8TGkWNXzY2xJHxEOha7Zo6zinNnWvE9QFbe1OIdHf98JGenEmyRkUj
	GQJFmE4WuMFNsRazuBldx5OS0bxg7fpSMjFrRww7y4=
X-Received: by 2002:a05:600c:8b53:b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-483c9c0bce5mr211979425e9.19.1772450525627;
        Mon, 02 Mar 2026 03:22:05 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:05 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 2/6] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Mon,  2 Mar 2026 12:20:10 +0100
Message-ID: <20260302112153.464422-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.53.0

