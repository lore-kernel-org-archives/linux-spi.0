Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FD42B75F
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023173; cv=none; b=ptjzjlaHyAC8NiGLzUsxqaQskvz8MI/yVPl8muXVVtttfDysfpKKLR+2R/dBm3W5MLE04t3PoqkkJk+dNorVHwwPpCzkRBD+CjkmPHWzLbLDB8Q89/nIdBATwLbz6o19ZRxwhtJ8BUifw6BOyS42pHuojEALLFbqK3xUj0mpdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023173; c=relaxed/simple;
	bh=ems2LpTiwpTPgbOwaVQx5TOJZKGRhpPlPNAONUo8hZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2R2gDxhIdNjnr/w/N6TrS1AIZdGk/qEcefpwko8CMYG9cqXjDWkzG6sO63e/dOPCUVmzwJWqNXJvnqcbdfgm2SkJOL5RGFl/mbZspmRUtVFfHh5yqsTeSWGnj8AkND3uRHFqHAOhLaK6GEmIdbG6l9LAcPhjwXO1mmvG5ZGMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c03LkUFQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c03LkUFQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b3e03939so48302315e9.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023169; x=1781627969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPfdSQj9vTm35G3KAdx9EH2tKkR1Y8xAGyUsxKN7pqw=;
        b=c03LkUFQyhrcrPPClwpUlac6+lmB8l0CQh6z8Xb8O6ZXbPJl3d1CzrP7iRTIroME7m
         4pNXt3StKwwg/LR6iEIN2qH7524DXy3i1s8ThNLfTLVcMh0jK7D1Nf0tHrQFxx3rIao7
         jD8hjW2F7NTkm1YuydTJ2OjxN4VpUgxFTIQRCMFFvbRZyA/BJbTt7N3o2QBuh1zBL/Zs
         aMC8UMcrxXRJhaSF3EPN2Yp5rHeD0PEqZvrGKlgToGl2oFXpkCvZ6hwe/bjYb7OuJtOa
         Qupjq0CUT+0zxxMjvHFNuTZZHfJlRcWlHWM6i3mR1BCBUEBoCpJVBDlJsHH6B0fpfRnl
         A1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023169; x=1781627969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPfdSQj9vTm35G3KAdx9EH2tKkR1Y8xAGyUsxKN7pqw=;
        b=pJms8rT6aioGkKt7Ni8w7NEXUxeyegEZSG8Ds3J+x0mpDRaUj5h46nu9fr5KAQTAVW
         Qc6ZXpPSxGNXfXP/k/OOeO6Ys1eN3NgOEXWNafSEOVyMdctTo4tzXFVYEL8P+j9dGrMW
         0ysaPp/X+yUD1yxxs2zZFI3tbuC0LCcgfIJ9Q1s/+dVquCmpJcVkGgK1dxVyLNUTAU+W
         AQ0HNnQx/7Sp1iTTJA1ICzzZedqiB+AFinX0WgjPMqcUi4jlK8O8dcBnfVr9kwOzmUDn
         MrkoieT7NwCdXuwnVDD7WfABU9cgzrNJHpvKCPGF7czSOrI+tRxJbJRwRdUDvbhVUCiS
         TMOw==
X-Forwarded-Encrypted: i=1; AFNElJ+y+iryfJgvJmXOuLN2lk4K9jRgEs7HvSTR/aWy15YvfKbIqR6Q2r/Ue59R5NAw2lMyYFJ8sA25toQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvclRsVLFpQy2WrVYDYw4LrSXvvOve3O7Ln/686yDrjBtsfFu
	fNKQWUGqnI0FLrqTPI2ZB67SKTPg1ZCd245bLDdQ7fSzrkBzNerkcoIA
X-Gm-Gg: Acq92OHLyb6eLiRUNKwwCLXNd3UaBIwkwXqyZe0zg6SmCUUFhvsoizU9AYWmE9S8nEj
	6Xg8zliQpEApfCo/l+lvz4P+bEILQKOcea+mEeb7mlztx7tY5XI0JT8pgIBVZ3xwZ4DrMkcZ8ZK
	vUy9mr/FvOLUOpsFcnHiopJT5Bz/RwrRfcDqvKhdk7tiE3YmGMba9xMACJTjHfWomFMEvNF3k4X
	e3090547a/glN8eEAQ1z5X7WYWKXc00ksnuXPjolNOO1Ux/vZZvpI8IC7p9aQ6uNuOR89LnLXIS
	retjLbEHSPPJ0tU7APmXYoDRsNQS3pe+Oiahws9tHBTlmLxWKPJt33PrNKZpMK7CGv48oNhXzuL
	O3K4UwJVP1ODTHJXC7MEONa9d/l1TPXKUsLHV15oKBK482LZGR84h1fyFh4gXAKRHD7W6l5Axju
	d8NhZMRpZHzakVq0g2Jh7EDPFFU28CzIsIQ+t8736DQcGjyilRFfke8KQ=
X-Received: by 2002:a05:600c:3b04:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-490c2cdd2bemr288823845e9.7.1781023168694;
        Tue, 09 Jun 2026 09:39:28 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm440860805e9.1.2026.06.09.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:39:27 -0700 (PDT)
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
Subject: [PATCH v4 1/3] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
Date: Tue,  9 Jun 2026 19:39:17 +0300
Message-Id: <20260609163919.3321228-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163919.3321228-1-tmaimon77@gmail.com>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The NPCM7xx FIU controller nodes only describe the control register block,
but they still advertise a second "memory" entry in reg-names. Drop the
bogus name so the DTS matches the resources actually present in each node.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>=0D
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/a=
rm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index ab3c3c5713ae..a16450abea0e 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -191,7 +191,7 @@ fiu0: spi@fb000000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0xfb000000 0x1000>;
-			reg-names =3D "control", "memory";
+			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPI0>;
 			clock-names =3D "clk_spi0";
 			status =3D "disabled";
@@ -202,7 +202,7 @@ fiu3: spi@c0000000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0xc0000000 0x1000>;
-			reg-names =3D "control", "memory";
+			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPI3>;
 			clock-names =3D "clk_spi3";
 			pinctrl-names =3D "default";
@@ -215,7 +215,7 @@ fiux: spi@fb001000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0xfb001000 0x1000>;
-			reg-names =3D "control", "memory";
+			reg-names =3D "control";
 			clocks =3D <&clk NPCM7XX_CLK_SPIX>;
 			clock-names =3D "clk_spix";
 			status =3D "disabled";
--=20
2.34.1

