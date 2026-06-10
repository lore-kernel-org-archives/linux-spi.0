Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055040682A
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093921; cv=none; b=URmjTrmEOYMvbr4nHI0Qe03Prek8MVe0LRgQsJ3kias2Dc1RHmtfo0GabTnU0/PCYn6tllQ1azebgW0TDCDXZdc8Mf6EmpAM7xr/FzD4A8sfO+5BOpkut+IFRqVEZ/TKVDFpkDyHUchOf5w8xh5jeTdYr1kXTWUKLpZry6NcvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093921; c=relaxed/simple;
	bh=yysbUW3aZgPyrjC1A+db48LbzRljGcyZydolnzYEPR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pm/GDBQM6QJ5bsTyKzkzgIHLekUpRhsW7z+SidYK89bp0KSn+T4mnh7+mcz4ovyyJxRFjuCWRN86+9IFD9Rq/rG722YXtw5hc1Gz+iYPg6MlsxPXxrRvf9ko971A0nGFoyM9aliXaGvyVEGfRhv39WQFr+R5uVyZ1CRaKy8b7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp+XMkQo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp+XMkQo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso52506525e9.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093918; x=1781698718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7tivorkStwB1FS3/hWit3SBK6zemxB0rzwIUjUwnSE=;
        b=Xp+XMkQoK1AdUznczIqALISNLzJ9hxgULuS9WFghNCBtb68CEXAwPVdugSoqcx9k3F
         SEVuZgV1n6BMaO9jitBERr63hM+/dq4rWhib2g2BgJa/J0X62nX3y9NxC577TtOIkI0J
         Pjs+qbEutNdHF7pbdpn3ZDxzdLCX63ZEfo5DnQmyAL89Me068Jghayw5QQSnw7Xvnnxz
         /ECXOqR1qprFRzsmhnFVVkQ9XmG8HciKiamVMaQsYSyyD9q+vvFSJwvhPxmniIg2fBoG
         lYN8Dt08LWKPaC4JUs2iXnYfDAwq6TCWHPP54d39w+9RO2PqW+m5gwAd9HpbBMVbvi6H
         zKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093918; x=1781698718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U7tivorkStwB1FS3/hWit3SBK6zemxB0rzwIUjUwnSE=;
        b=FlI+cj8KPmMLXhUCLoapmLzJilups8EBFlIX2sdthJE8IxaEMTDmW5ytBJKbpVsS45
         PfQyTwXUhx5g/sBBKU0Eahj6stnWUWwWYtUIjU9a0dolfz3pWBwGCf67pIujPXWGtZUC
         DVyMFwTKJkl7KYWCbXYSbWwkJpUMepRAPQqJ7NMvfbU1Q7Mtf1af3YFtGSEWhz3zLmNp
         fUmWqHfHWQ07Sbiji0yRFGuTatXw6muQlAUXHw1bjNc69wkZ1kcVYLuTfNSUW2E/n2jg
         FqGReY7OgQnKKetazmikjCryEMUw2nLaXKEw+S4I7cbbVEgDzllfmoUP8RERrhJFdboq
         xy6A==
X-Forwarded-Encrypted: i=1; AFNElJ9nkwTbbav0P47DBheCNDElPIWd3qcM/poQciOEm3CpHvs5fIYsHt1ZbJ69hg3l5XLFVbRQwYFiRiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOlxu7Oz7REoj3HVkTsD58y++9nkdl+KHjqJXtjc1uaPf+WKP
	x+h5Q0fu++KEEbQYlg0ErnbHDuF1ddfxfD/270I85gu0Gj7pNx0PrYnX
X-Gm-Gg: Acq92OHSLIeMH7js0ch6sF7MwU/ddIclNVfB0L3k8tOcbZhpCLZoMKNCsyqzmnSmAoE
	vgPJfUN5qH2StaCVRTTZyjK7h2X4riM/QZucHgVfG2otOjgaQu15vfMGkkF9Q5y8cPB1f8Gf9YE
	gIh5WHPIDGobybBAp4pqittKe7G3DkN6F7R4juPMc2x7piVJwLT/8ZHsqTVAIeaEvK6yBppWu7k
	mRvm0tk/u5N0Uzi76qi/HOgTPl68subuVvU0ZZIbo82py/dlwT4anvdeAFBYPVG0RiU8ef5Suwp
	dQIuTHeapRwGAbZnCcM4Nx1snfkHHp3TZGBElPR0fxPWa3r2VY4yEsYcdDXQpL+cLRpz0EM9Qr0
	Je7ZVzS8nYDL+Krcr8fogUNe8Uz/iICSdDSF9BN9BQvUFfxbe48OD+Hl2sKbPua06Q62DsIyka8
	k6RCVRWzY2UkYlI0ADae6719GgvE4W1wAGdYHjxP5GFsvxK/TKUcJDTGg=
X-Received: by 2002:a05:600c:4750:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490c2cb81fbmr286119175e9.2.1781093917817;
        Wed, 10 Jun 2026 05:18:37 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm566553095e9.15.2026.06.10.05.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:18:37 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
Date: Wed, 10 Jun 2026 15:18:21 +0300
Message-Id: <20260610121822.2524634-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610121822.2524634-1-tmaimon77@gmail.com>
References: <20260610121822.2524634-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The NPCM7xx FIU controller nodes reference a single clock, but their
clock-names properties are not described by the FIU binding. Drop the
undocumented names so the DTS matches the binding.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>=0D
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/a=
rm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index a16450abea0e..83cd10b47273 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -193,7 +193,6 @@ fiu0: spi@fb000000 {
 			reg =3D <0xfb000000 0x1000>;
 			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPI0>;
-			clock-names =3D "clk_spi0";
 			status =3D "disabled";
 		};
=20
@@ -204,7 +203,6 @@ fiu3: spi@c0000000 {
 			reg =3D <0xc0000000 0x1000>;
 			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPI3>;
-			clock-names =3D "clk_spi3";
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&spi3_pins>;
 			status =3D "disabled";
@@ -217,7 +215,6 @@ fiux: spi@fb001000 {
 			reg =3D <0xfb001000 0x1000>;
 			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPIX>;
-			clock-names =3D "clk_spix";
 			status =3D "disabled";
 		};
=20
--=20
2.34.1

