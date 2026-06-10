Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DB40681E
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093918; cv=none; b=idrodb27EA0ZjC0cuREWBKbQmleFR+bcNKOt05Ol8rXtz6Z+OwinKWwS+OLB0lZfV41rnF7CRDvtOucN4kvV8I+Nc8nlLJanarl2bKG3o1RbRrV4cGgnjN5iv5Mf0JrHDz0/OL4/V4xIx5pA+TpNFz4hlVmQc4ABORqBfCLJsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093918; c=relaxed/simple;
	bh=ems2LpTiwpTPgbOwaVQx5TOJZKGRhpPlPNAONUo8hZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZoI1aaWQ6s2SY4A52M94Xqr2tDquTusFr+C9vjyw94WopjMr/h8y+LltW565/JpUvdeaUeRXUgtb7vwPtZvN60/NYxPese6TgXXyEkR2rc/2rc0QsO3x8Cx0EjES+OeIvDVuY4qQTb/nvMAmrVrn9tb64HpHu3iUtHuBEoqspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4ISy8kh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ISy8kh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490af320e2aso73320935e9.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093915; x=1781698715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPfdSQj9vTm35G3KAdx9EH2tKkR1Y8xAGyUsxKN7pqw=;
        b=X4ISy8kh0WIlnIMU+YW+yQEt9VpK+bIC7DxYRmM5lTx1KgJ+SsYNXtGUDz2WaBqwFy
         bYhrejwzKc1DFwLhPRUK3AY5zO//qaUkT6EHeqs+TkkCpBoGUphI7j87lO01rjxJEUeQ
         WrkmptJ3l6K4VYJfaoSO/H9zRP6SPz+6Q8FykTpGJy0j/Ht9+dnAi9vKCdQxFT0UZbrl
         t5V4Yv8AynKgZQdPtxUShRLHt7wNnJBsbrRtQnOJPLT1u8OSKJ8aQ8qrkPnxvWKy+K61
         5mnMnR1NF5xV2E4KAdHij09n7wWdM3KrTL2FrtdlrTck8NkvBiVGvYTQl3I2MxrR/c8k
         3Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093915; x=1781698715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPfdSQj9vTm35G3KAdx9EH2tKkR1Y8xAGyUsxKN7pqw=;
        b=iQCxvA+JhMY4l7tTbV+rcloMBWrWZif9SaFT/pMsPEE7CKTUVGyKTHEf2MYmczRo4U
         YGbwn00Evpop3KOHB16NpXXagn0bb9em+KqqjWvFKh0/jm0W9caXqcCG9/AdoXN7QtiK
         EJlEaUknSMYZWZMS8MRryMbh1R8pEbSSVKjaO1H4mbDuewz1P+jAsc1M7Zo7S6VbX3I5
         uc1VdSwgvr3MQoQVPW4Zr+Y+Jo5+I4qoqDLgOYkGbgALpQykTyF/JqEz39MR/Uh7hSbL
         uilZVnvcO7hagLyO0zRenNVCigh7lNROCnOXCrXGNlivmUtT2Riv8lXaGg/2TT0q/12d
         NSFw==
X-Forwarded-Encrypted: i=1; AFNElJ/sDp+XNdyT6y7twFIwPN5nLp5R6A8spKRPUj4GMC6Mo996l+jHHZqZ/C/13MaSoomwgJeMsuxcrfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CgBcSmyt240aqFWEjAL2u+xG1GIsGdZsNSd0xM3C2iwc4d8H
	hQgFTbqZdr5ZZdfmn5t0WD3anOdsyctiQPlpqAkozH97p2Dno5LzFuO3
X-Gm-Gg: Acq92OFs4pnOAeh/Gx6iSUHBRgbjedw64JI/O+dWS7huYSV4HOj1582Twx0uUBRUHcS
	Xtc4IckJcXWyH5Ir1bVtYKiAUakJewWEVKlR1OK4QZtDxuRRv22LHm7F7cfDDZpi71uOaOARphC
	v8uCGgEjPpjRM2d82BKauGayItBih72et2h2tt5mun/zgHF/VcLrHMIsqhOnXfl2w8X3xO+fkbM
	g0IPazKE+G+F2tqbBQxo4zPeb7GxtiNCop/TjR3KTEga+tncRoAGDVtJ7QTC9bXf2G5KTM0yrqv
	/Ab25C4yakmkITq546Xipvwh8Wt8w7KpBipae0DMvxyW3wzU2kCL2kb7pUVCEupw+zOXd2bjLSX
	PF9Rgmg1sO5swTNwkMs4Kcr42cmXggHvgKLuB058y9tkFXSXik2B1ofF0Zn/OlbfLzEoC1Vtl1X
	OL4DrdW3HqzVepK59PEHL5O5aWHJi7MaFN+eM/h/ebynXlzeGcFnDNRaE=
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:23d0 with SMTP id 5b1f17b1804b1-490c2a32441mr294659765e9.35.1781093915295;
        Wed, 10 Jun 2026 05:18:35 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm566553095e9.15.2026.06.10.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:18:34 -0700 (PDT)
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
Subject: [PATCH v5 1/3] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
Date: Wed, 10 Jun 2026 15:18:20 +0300
Message-Id: <20260610121822.2524634-2-tmaimon77@gmail.com>
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

