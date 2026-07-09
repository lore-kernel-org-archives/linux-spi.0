Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6973ED5C9
	for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596020; cv=none; b=JXNcbCERUZxZP4sMUYlNbI2e2v4lM3JhuNjLORbG+S9b1qxLi7y6AS37uTn321v3cPe/8CHwk7Gf6OMVRf4zFjDOVPvRjFiZfZb3YYsGjOdy99KnQtgSuzBh6hi67RjCIWiasMVHskaCU8gH8OPMmUC14tFdo5DXcT+pG6fu3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596020; c=relaxed/simple;
	bh=6TLG2b1FY7EQoUsyXn/NWLI3stddETx5AFH37jY1Fnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLmN3qEG9/lWPsLAfGJFGjmPp9lmLtixk/Nl8c030PLNk1yQNWG7hXpYTyuEmmbYZS1fRlCUvhiBG4gjBYzS9FGP/68Mhsdw3pu2OvDijadE8K4tTx5aa84ucv0ecmgCbxleiWhF7ZKrAE7J8ip/1Ix8BhhsEG4nSDGJQ8uYrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rkcZ22wQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rkcZ22wQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b966dd74so7094965e9.3
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2026 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1783596018; x=1784200818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtEKXt5Jfmcl2mAH5O82uFyic1vAKOctoaDaAIxBYA8=;
        b=rkcZ22wQyTZyVicG5/UJXYkA0Mkiq/ctcTsqE6rEuI4kbuBwq+kVIgbCaUfR4yUpQl
         ggOFvApJ0qzW/wB22BgNgMPFHiUwkNkbeMGuDShhRB647W9yC9ZU7JtuVP5yDJiGPdY/
         gMX4XQnVxEvurNpoj9YfLnt9Kq1l7jMc+fnNk/WA1oMAfHyUe8KhW/WEgl/ocEClPtxx
         HkXN6yJk5AR1q6Yt2SWr8s9yjVgazARWjt1fmVgVoTql7Vqnq7dqyUP3bjsSh+rGTYp8
         a15giGeRMLjH7xFmeGnUYyXi/ezAxZaowThm3N/3TvHveqWZug5I8dYuY9/uMpzDwbMK
         m45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596018; x=1784200818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtEKXt5Jfmcl2mAH5O82uFyic1vAKOctoaDaAIxBYA8=;
        b=mBwHFL9oEQnviqcdg4KNTmP5vyPrsiDo6SRSWo1gAQgfThIgVXOBdjV4QRWfY8e1eM
         ti5lk7qXPsEVjhifPVXy88MHnHQUX551bAf47jUKUS9gd8dI6l7kKViDhE11BstFbRRd
         Ao//UNOqBMVLtSkER5EQwIFuerU/GBMfcZAEDTRbItgAtomChOIzTEz3okhfZmQ1cSOj
         10UqQW1y4gwAlyr7V+gshf7yKhcATz2HY+NjrRk14pLH3qsjKZIct2G7wSO2sAjjnDwe
         VP4dHrJofBKBH7F95ffywK9m/O9Zqhd1l+i7OQmnQn7UxC9BsguWpSABBh+KNCUglafg
         S6kg==
X-Forwarded-Encrypted: i=1; AHgh+RrF6UFfQalv2rZ4Y5Pbj4NVuOVDa3BkuufvGOMtgLJnb0MxMT2yLnJB5jyZIH3vdiuWK+xYuHR4XZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3w9qO7kGL0VvDOZzdwHk76Cv9vRbPRUyYmAbro9aQFHuN96zk
	ZBrayz/p5k2KU5TEPWE7y1QdebWWVP7/7rpBURrtWrdeQrH6K9pojS+JZO+HO7yXTB8=
X-Gm-Gg: AfdE7ckzw3WPXonM2rlfcX3qJlsHaSNRRlrInpIgFZzPsBquDgg8jXetRiG/gahjYWo
	vjp8MT8SDv1oDe/75ql/KOHbbzrAVj2lazmGgbQM2JgsQC8c8keBPWla+VD1gNieR9q0jEQaMgw
	IJy5www9yARBMjF0pAqCVOjHzY8hp4wOCoUHJSVqcot3ON/8BzjpQsTg3ECpQWIbuMP/y87+BtV
	QausEKn/g2ZEZGAjXNvm/EDdK9OQAREAuPQ86NAhnGzO4wkF4lpaAx3ENwtXrQCZ60cOCo5pNCS
	+4YXANnJokpBxUE52ZMvo+Kojq8zRr5KYjoE/t+eJ2rgGMHCC07rEnamcvPDt9EPhC54UI1lgeZ
	HTsfccsptZSUrEAZyHOAl2kZlIxRHytM+PePHqZxBAy1DnjQ8BP/TmvkjlTfzoNrBl+k3hZQRVV
	SHeMzxfqStL3QcoLGmXPEqjrzY/04iK+N+S1bGH76gaDHEziP0hUI0HJ7PV/HoU6k+ODIyx9wmH
	Ztqnyx04qFh3RyEOAKhULMemcVdM9comU8Yj0ypmhI=
X-Received: by 2002:a05:600c:3b26:b0:493:e3e9:85fb with SMTP id 5b1f17b1804b1-493e685f1f6mr67303175e9.20.1783596017884;
        Thu, 09 Jul 2026 04:20:17 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-57.xnet.hr. [88.207.15.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm53910475e9.1.2026.07.09.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:20:17 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/5] dt-bindings: spi: Document LAN969x QSPI
Date: Thu,  9 Jul 2026 13:19:07 +0200
Message-ID: <20260709112006.390742-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709112006.390742-1-robert.marko@sartura.hr>
References: <20260709112006.390742-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x has 2 QSPI instances, so document their compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index 30ab42c95c08..36c698ced99b 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -22,6 +22,7 @@ properties:
       - microchip,sama7d65-ospi
       - microchip,sama7g5-qspi
       - microchip,sama7g5-ospi
+      - microchip,lan9691-qspi
 
   reg:
     items:
-- 
2.55.0

