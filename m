Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E53CE48F
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833525; cv=none; b=GuVRdWXdySPcC6a4vfPnKeFD10qzA7eTmoKtiA+HANrykP6Pu27LPZJDy15wkzT09/O8bL1Xrg2nsJ5Qvcu5SGQuMM3t9NdFFKlyoemtOBqZmBkFEiji82YIpG8A7VBDn8hc4uvlrCCAG4teCSpCerPx0LtzxTTqHVg3E7SSs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833525; c=relaxed/simple;
	bh=kCQLWikKMQAZX52zP7mCbrq1YoM5AGwQQLQGtUCpDU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxpkKr3YvY8i0d1KLyvvex2ILY5BlsiUaQsDIjRN5rIOTXXmpy/0pyFUjSe9t79jjIO0lB1NmTaAYj9FaCy7/nd+EhW8IlSLULKQfK3LqoKCr28RK2eZsO4qlL0n1aO9S+1ATwuaDs7wumbmc0y1AlecraBLnBvvn10VNMma8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=DkXScEmu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="DkXScEmu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso947088a12.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1775833523; x=1776438323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yoe0HYlE0K0NbksazLkXaws1bR4DgN+t36khjDPYQVk=;
        b=DkXScEmujJTa0uFG0dkTlDW6rqHUN3pkTbgRWL2oalJg8aGaj4KTfTTUeE+x0pCgRR
         JH4RactEdl8YGoZfJP+D8lvjHrfW7gf4bSlDrdQx5znth1ctFhW2pvZhXPWKvvV/xSSs
         JZSE6ricCX5LELBOtZQJdPdsWh2pZe8w8ETosSDzy2N3qv/wnBPAg9xRUAEdi+JHMvlm
         g5ZemKHmA0BRhfIx6lOPEPHIPTS7mTXZ79bmNSnTYQJkVKIpa89Klvay2PiYExU/0VpO
         T+rZw2TKLsV14ynnF5hJAJcoyhJ3UV9JUUdNVsroV6zPaL7YQQhfKMh7XNWy4Q51Fwrk
         Y7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833523; x=1776438323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yoe0HYlE0K0NbksazLkXaws1bR4DgN+t36khjDPYQVk=;
        b=Z41C2gPYPIXUZVIOvR9vmyUO7OHjerdR4h6MJfN/1jE8jXlkoEcalpN3/E7DOY8Ci5
         KUOsCA5gwpkEv/19En+nDf3XVdlj0yXxxmGQKxvp+nRAT3aiU5oHh8rEVNJZpTctO1MK
         9li+VxgMgbSx0DG6ZqgyUfM9L9c0/zrXAwL3GABm4LI3WMhI/dyIUfvGo3PB7dBvWpmG
         zoFWYpsRpI+LKvGd9P7PWAzinvQO9UZPzb4LWO3YOPxLNMMZAx+yEiLKDhGGlm3Tz8DA
         tMDNBvJhKuSMzroCsWcxztUmr6xF6wWbFZ0FZBUTRgMU9p7gUEqzMn7hmgX8wwgpEEtF
         s9Qw==
X-Gm-Message-State: AOJu0Yz0z1hraNBLS3mF5ImWmTviGziVkn37BW2JpcuIjGsAwZr4B1wx
	BaHtII/ifsILljyv2Y3RoqOcKPkWn9GwawhhgGzZL9rL0oDhiwDleeLNdkmjyXoKLPY=
X-Gm-Gg: AeBDievFkk6fM3+Pc9kO3vmEpk3DvjcSI5GgokeFUSFSy2r+y55JNvartDGpwC5EeSY
	5mF+ysM7qx4Reux54WpKjlxzrpzzuqGdTND9sqRYxbO2UDkZMGqpL1gO7z96CD62n/+yXKNYrhw
	8LefBJlYdXr3LCqHgSvFPOYDERQBgEuerOstYB9GJwuWUSN7+9/8EijxcQIuqIV6wDnMtqbyNit
	0hOyExMT8R1QXUvrVNthph+3ss+6FP8fLdkZLU7+ykvT834QKRrPP0hMnVgWubvnJuu970JSISE
	cdAMMNwS6y8fPwNXStB9MEZ+qr8d3hvY7ihJQW2gZTisa8PkkZ8mYhwgTJ/GIqhDyZW6NzARd5o
	gpPepMf6roNbdo3QIhS/yqtA2PXThUay08CXVG1F+y1LaDZhuIQ7pbkIUxZia1NJIkl2RNtycLd
	VfPu94IIL9APKi3bKBLvbeVO7feKyohBYnWUI0uxMpkUb84TbALWU9BwuNvTDXTJ3g
X-Received: by 2002:a05:6300:210c:b0:39f:3559:7516 with SMTP id adf61e73a8af0-39fe400f81fmr3967582637.48.1775833522543;
        Fri, 10 Apr 2026 08:05:22 -0700 (PDT)
Received: from [127.0.1.1] ([45.8.220.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4d5413sm2970532b3a.40.2026.04.10.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:05:21 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 10 Apr 2026 23:04:22 -0400
Subject: [PATCH v8 3/3] riscv: dts: spacemit: define a SPI controller node
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-spi-spacemit-k1-v8-3-53ebb48a4146@riscstar.com>
References: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
In-Reply-To: <20260410-spi-spacemit-k1-v8-0-53ebb48a4146@riscstar.com>
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
index 5971605754b35..61b93765f42cf 100644
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
@@ -327,6 +328,12 @@ &pcie2 {
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
index 529ec68e9c23e..1ecb09e58042f 100644
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

