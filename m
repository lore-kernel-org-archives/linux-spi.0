Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE83D3CF2
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298542; cv=none; b=LFgyN4MU7/FUUxaipQXY25TjvQwbXF9ia1+wfTbd6PB0mSMar4cvCdxDF3GMg+Jmf2slLJdqpgJoCdeX4vSbsOaf0WI++1Z2Vwl/zT3r7efMPLyM4ZNS9JauSOGveY9gRNusvPXIO412iPIrNgnFWGybR1tXtA6Iy8aNOpuES3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298542; c=relaxed/simple;
	bh=DL7WXDFY1O5eBh2tmSI3Zsd/h0SrUvqrCzd486m+vE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLECoZ5LugkDAWYOjyFXlgNJftnkMjdLU3qSBWNEJp3HXWOLVQuJDSf32850hbWrIeI6rbGFlG0Mt7AMfviEDONdOM8dLVCyuM4R8fqDV9TzgUIeuaKQBp3ygWTrmTOcLTyiH9S7MsAQsovfkybjlwyZWfmXc9LsFPc0ahZT3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GKkemFHd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GKkemFHd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2addb31945aso64868545ad.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 07:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777298540; x=1777903340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zn1VHf2vGq/Rgp6tmVMmYAtaKJKXMEkXpNhjeJ8VMM=;
        b=GKkemFHd+RZyEWGbir64WPIi7wKWUu2IoBYL7safr3T1j34Ps51hF/6GKW7IxuQRlj
         uN4IUh/UzSHgCQIPkEcjk0SOyvVcFJb6VAyPgGMb5T7rE4ENHsLGisIajoxS50uUvDie
         /oZ0NvcCvPO63bmT7BmsByPuT6L6l3B7ZsptJObuO+Bc618+qelaWSYqe2MNpK3IMlRq
         rq2Tg+NM2EzTCTyCNeSoHrjYMA/0faSPydcQKpcFPuAfFEcyv5Aqm0zgy8d111pQXYR9
         NOaS1U+HysVCJm2w9br3lLYhB8qrW+OJKhZiciypfDyGsG2leWlAoPC5qaZ29HWX3kaK
         za0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298540; x=1777903340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Zn1VHf2vGq/Rgp6tmVMmYAtaKJKXMEkXpNhjeJ8VMM=;
        b=b0xKNgMlGD4fLZaAcnMqZp29kUAz+oA89BFR2J47R11asnQh8KUeo+g/eQG7xVaBV0
         3+LrRZBC96+mYDxtMuhMOnF9s9aFNQpbeW5zBqLOihh1DAX57EakRHSzOLr86LIaHqUU
         JargwdRqBa/+cgMXMm6F7MoIm/ElWGQM7fi5meCzC7X89ZkvPHUhY+Yw67qbcKMWgUYi
         f5ny5QaZK66Gqf86cUarXk6rdbiolllh+f91p5AL441bc2c45p7WkLD9HcJtWS4pi+at
         AlViuPvyXMB1hSNcaVgr91iBmbqnynvWk0xDTBTcG1YUQmDApxPrNYdojaOviIMV/VFc
         CXeg==
X-Gm-Message-State: AOJu0YwnzXtGANnDBEiuSt1sssJEEJ+P5KTU7sZ4AbvQe/bhlcW6edBa
	nQr8w6UiZZrIilJvp7M9eQsCoaKkVgRG2INbNr+VxSwIYgNV0PZ9yF0RoYp+V+yohrc=
X-Gm-Gg: AeBDiesvcpTruuG4ddC1965pc9llbVPRlJ0JCQEvUJqc1INLR68HT9E7Gy7zgyPp/ec
	p/AaTU7hP5kR+vcI33E6HxxAFB/WDWyXmFf1pqzcCjZXE9M5rp8ZK7dF9ejuYkFOs8QUTPFWJ0Y
	Kxr2omhkkr8wkXGORsZhQfcitqPr2y1PXNl3o51dV9zxNNzbV6OyKrs/fZj/OVdtUuwuWiHkRy0
	r1j6XVMK0pbuDvfxImwU3zMS3lK87ik6ITzhkw1s+2nK9AgQZXUb8Ga6s2CZ0VD25kLd/4ADx4D
	jExcghL7o4nOMS0pZK+Q8eDtsnwIVnJZov1SvlGYEXMBvvMB598sIoKBo2Uo0aAbTzBm42Xm2on
	0d5gX096pxbeH6DebWo5hXF335Pp7zKdBrDD4ujSNCrlm7jCjurIxxDhWlYMkKoxeBz3IB+XG5v
	k3nG/kEQhEb9gp3ZFwslnssPFJpQk8zrYSZCTtzffT8/kYcRiu4k0qlA==
X-Received: by 2002:a17:903:3db3:b0:2b2:58a2:c8a with SMTP id d9443c01a7336-2b5f9d68827mr300145985ad.0.1777298539927;
        Mon, 27 Apr 2026 07:02:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::3016])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff98csm307143625ad.3.2026.04.27.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:02:19 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 27 Apr 2026 22:01:29 -0400
Subject: [PATCH v9 3/3] riscv: dts: spacemit: define a SPI controller node
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-spi-spacemit-k1-v9-3-ff753b551302@riscstar.com>
References: <20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com>
In-Reply-To: <20260427-spi-spacemit-k1-v9-0-ff753b551302@riscstar.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Guodong Xu <guodong@riscstar.com>, 
 Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.1

From: Alex Elder <elder@riscstar.com>

Define a node for the fourth SoC SPI controller (number 3) on the
SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Reviewed-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    | 20 ++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 5790d927b93db..9429189354d6a 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
 	};
@@ -335,6 +336,12 @@ &pcie2 {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index b13dcb10f4d66..34d88334e95e4 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -570,4 +570,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index f0bad6855c970..f8747190d2e12 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -983,6 +983,21 @@ qspi: spi@d420c000 {
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>, <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 

-- 
2.43.0

