Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF5363091
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450537; cv=none; b=teOApRbtMTastYyY1s3buvXYiZMmJdWQ3onr3afXL/ruDc+HRGeegKN7C3hahBnXAkPzv1fhqhQdH8q1tMcmU5nV/3TEsg1AFoNsvGCUjtL9gZFAvdlArBp+NTaSb9WhMjICl7RmTH2fa2ZKAj1qjh2/yAUrxHIQkREmmKHznCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450537; c=relaxed/simple;
	bh=5YXoza1npYaJ9tc4xJEPvhZRjZCxh9QfUM1VALrscjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtcoUs28aQPDNK4PecpdzcwAgEK6ao6tWtXBO2b4oNTVfiZgbex5ha2CRZ08pnVrVECtJeWG8uGj1q9CeqpmL1uK70XjN059XMPEB+bZNAT4nskUjUgSGM9Ov9M6Wv0H8zYsdKuMyBYKIfyWsQT7Tw1dnBXWelmeg3N6CiWl/Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lTTzIgpT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lTTzIgpT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso36407885e9.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 03:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450531; x=1773055331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ESgBMDji8rov6yYhnHGaS+/+l3/SjDdxdOhefVJEU4=;
        b=lTTzIgpTiNx0t+9SMh3MlGQYkXFZy15WCA27C9rEH091hqDRqfkh8C0o/9AE5HcYe/
         dDpN4OL6ea6MDTatMK5gxWagxQNrHP1qKpvK2Q/0EWHM8aYDLPheH6h8lnZfWL3q0Q6v
         LPlUAlkFznXbOzlro0zXoOl3xcBIVDgAkdk18UU/gMmwXDzAlAUsTXSWDTHDEY/5RuCD
         x9pOz/iUN59iKNG9DV54hfNS6AKu1IDBMrtgSIaA785Y7m95k2CVQMeXm37evukqRP3E
         Lm/djHE9I+YubkAcxBkHKSBhMbIvQai3cm1gyxHtbnLcpnNfmtkCwaiBrvQar4vFV2rF
         AwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450531; x=1773055331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ESgBMDji8rov6yYhnHGaS+/+l3/SjDdxdOhefVJEU4=;
        b=a+zUm2JL3+/fWzIpClz3ydb6+MZZ3cg4afV89c+Ehd9coiSVDUagG2WcO7lShJaygL
         bqKBbjr9igTZmm37rRKvoFeJPBjpCZYiKu/BQmuemvRicyizOnoM7XWnegvgIXpKkxd5
         MknfqO4CqyeWeO3H+CFCQ/laSGxBeRL452HT7kBokisMJ0EYYzxy2osQqaiQVyzvnYMl
         mjDJJDQZyQAaqT8hqykzcHlJecMJrfvcruYDoZp5PlZHglGBuxGuVPVA3S2oxOEHaM5p
         DVy1bJibDZz+LBApSkGpZp4ZSKvA0DoL6LKohfJ/uFbi/nCJLNW8gsRDrDKk5SVwTybP
         gMvw==
X-Forwarded-Encrypted: i=1; AJvYcCWo9RK06Q1LXSPq7r2/ueMPiddxq0Hg1tISniQqKXChicM4LeGVqbh8tNrwysdWT5I9/b9x7+/gla4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJr/nKDEX+dygJPrkZ/lGJyN1eblPKXSFVCHgid8pMV5hR6W++
	VfT3EM4tDzCX1F8tvbuganeHNAeg/OxRL3ppHTUN8Ztd+F4eBGzf6jntFu0smOstCQI=
X-Gm-Gg: ATEYQzy17gttkExW9FdNl2mEjpuzBIbmBV4ViFogkx7wcjmh1HRrc2kLle+u6Z3vNa5
	SQfXyZ9HVaREGbmO8LdpFJqAuO3EQqFNt/Ks/mtn+jWSQ6kvWu/y8M0PTTUfGwcOcEjbgEr984z
	/VxZK3ICRsJ2dAMXzIGuccjl6XPSani8vFd6Sfk2u4Sod4XWnek+3NjBddvusjfwIJwG2+4Dprs
	C7RNgZRVhKHKHwWhyX8SMXlv52Lrp1EyOjNhj/dP21QZTT18Wda817VJt0ls81UO8b4o5iO0Fyf
	PwnxWyliemSUy9HRL3l3EfsmWlmuYCj9OghFtwk4o6Szn8t9JGvGWsCVDYnHbjAH3ThCB5Kb3SO
	o+wGANM74TY74JxKUNVdXr6kJJaTPaN5bdzeRh0hxMRguJliouCfjYCDPiCaqF5J+nYKOYtI9O9
	SIo9Lu45hXaBoyE+v/P4ut7tMy2QSy+saKefyFsZ+PAN/YJN7Rjw3zrfNasJ1pw79fIRBXz3P3u
	cBLEvAguGVjpKF4zpCKE9Ge4fFBcXvLso4Tm55mmCU=
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr247748075e9.19.1772450530729;
        Mon, 02 Mar 2026 03:22:10 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:10 -0800 (PST)
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
Subject: [PATCH v6 5/6] dt-bindings: arm: AT91: document EV23X71A board
Date: Mon,  2 Mar 2026 12:20:13 +0100
Message-ID: <20260302112153.464422-6-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Acked-by from Conor
* Pick Reviewed-by from Claudiu

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 68d306d17c2a..bf161e0950ea 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -243,6 +243,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.53.0

