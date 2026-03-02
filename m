Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EA36308E
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450537; cv=none; b=jViM8MDRtzELtoJE4cDEvaPPwA3+O+GeCoIYa7rVK+OTyj/Dy7660awS6SZ6mYal81nBraNeo3tK9mfBplE+9g7RLyqLY8aQnqVUjgMAhhoKDuPcExvfwc+bYxAmjnx1lBgmi1OvnJldTiv/aifyJYl76zoI2+pDTB/XsLErRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450537; c=relaxed/simple;
	bh=ywFiFc5RyS3hz/312i+vJufPcr/J3YvXgBjF+wxMG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ycx3ZPdXuTtO+8uIJJxFDH6rZmiZcViDJkPf2QlfP4WRRtvM3ApBPO4cVWn9AviTInSYuK9qXz3PygzJplpXmb/fEC57zijankXXDDCks2k6yzQlcZbHd+fBvZiDo+/HB4kaZyrTPc/q6qHlmWpt8TCNcALAi/webCgykl88Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=DreZQ5xY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="DreZQ5xY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so32143885e9.2
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 03:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450529; x=1773055329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrbWY653WsfzoqInQOu5Am3TFi1abpgQkLM/m4XSvUI=;
        b=DreZQ5xYIhpxkCCCHyHfIk6jTaRIr/tIR/v9OCSo3vQ0JX0ocaCb6toR4WkXt3K/rA
         KWr6V2gb6IMY8ZE2iRm8PcdjbxiKiXWMgukw0g9UxS6yow+DKmIX8/s31acljhQJAQcy
         AoHle7fGQODqjwwlDRpw6SNoU2Qc5+8JyFYBPr8Jb1+qbhmmj4Q92oj05tBsBgUDWJHS
         d5IWbeDliNi7DuwNqcLKs+kM4m3NydWLEOIGuiEl81NeqnNgDCEOq7xSKlzen5AbRnxi
         3KDFBxmkcvXgzwA9ZNOY//q1E+TTBFfmvGpXcbZT98ag7gfjZmD9FRccGeqF1OqtOs7q
         mfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450529; x=1773055329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JrbWY653WsfzoqInQOu5Am3TFi1abpgQkLM/m4XSvUI=;
        b=pwxH2x32d6reRhHIR4TO1qDl7bSCPb7X0mW7s7pZ4efR7n9thSwQXyAxmsnUGDfoj/
         h9rJvhfwG+wblXWxoTkvYLTSuCxWPpjdChmkt0CbrBtVVrdVw16m4Q9neWvbXATUPOMZ
         Fp6FOctJkmxXueS5etqN5vSY303mrCeRzKO+ljLuhmBcEH7nwIyt0BAF8cHn1nAtMGTp
         dg2r9fEAcf6kGC2h9RBo3BeRV87tSVYdYNq2z1fbOhhu/8rH0pyGTyi+ot+olingSb6d
         ASPHnwTOJBiL8hfrhAlLqJkDRSnK4G4zRh+Bs58oo4MlJTvImFzf3Ke4HgaXMKR3bnP7
         Zlsg==
X-Forwarded-Encrypted: i=1; AJvYcCUrscVOHOTQClMZZ7TQizp15TcPyxORvyq61ylRh+mtYgLCRZipAmXuLQpHFhCihi/YvYxzSeAgevo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+r3PonOMV7svacYRC0wuoAPxZfCGr4uRca9utuzSVhKEL88OM
	fO9NZ4BR6clt6Gzd6nocYdZyF9JtZYeD9COQxSpvd2u6+eYBZN4lekzoBHlMI07X5e4=
X-Gm-Gg: ATEYQzx9JvWpJgG4kM2CbUy3O+EV99xGh/FKQND1zDbxWlbMtr+avXKb/58S1n7ZJxY
	b3QEZzHtFEGCGBwe3LlK4WdPevX8LVCx+4cC+co6suHVt3kgOwb5o5ARjK0VjJ9glS7+pz/k+Yj
	oRDU0xp33UexxlAKbbEiKYi432bhSZ22c3LpTEvJpGUFWxdYCeObzUupymGJdUlMy0j6g5LbCE5
	0+idS6ZHmfiSOBFFQh2erivUW0r3gLbyGVNWupJCdSNl4bvgO1O2DeZSy2bKALdRvK8yXIkAAqG
	RBxnK38lJkHGfzdeR/VBuEcRobRuVXX0L4kUyJXdFvzdRGEUZehEGaho0axrcn80MFh4H3lKfie
	b2yEi5lgidv+IW6VTIj8cNGgDyWAO9w3kxmaBcdedy1VjHe8xV18JWL5wTO8KTBKXYzc45VD4UT
	bjEXzXL8zCEQwiUkcTGYd+HrNrOqzE6Nk604xpx5EnIwp71zhlmxnMPag8ahrBvK5npRKOAoPTp
	SRSqootj7Ye+RD0kWZNQP5teuQrqx0No1RDvLqlMGw=
X-Received: by 2002:a05:600c:b86:b0:483:badb:618a with SMTP id 5b1f17b1804b1-483c9c1525emr197436275e9.27.1772450529074;
        Mon, 02 Mar 2026 03:22:09 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:08 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v6 4/6] arm64: dts: microchip: add LAN969x support
Date: Mon,  2 Mar 2026 12:20:12 +0100
Message-ID: <20260302112153.464422-5-robert.marko@sartura.hr>
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

Add support for Microchip LAN969x switch SoC series by adding the SoC DTSI.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Acked-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v6:
* Pick Acked-by from Daniel

Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v4:
* Adapt to clock indexes now being in a DTS header only

Changes in v2:
* Rename to lan9691
* Split SoC DTSI and evaluation board commits
* Use SoC specific compatibles for devices
* Alphanumerically sort remaining nodes
* Apply DTS coding style

 arch/arm64/boot/dts/microchip/lan9691.dtsi | 488 +++++++++++++++++++++
 1 file changed, 488 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/lan9691.dtsi

diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/boot/dts/microchip/lan9691.dtsi
new file mode 100644
index 000000000000..235e56bebbdb
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <dt-bindings/dma/at91.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mfd/at91-usart.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+
+#include "clk-lan9691.h"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	model = "Microchip LAN969x";
+	compatible = "microchip,lan9691";
+	interrupt-parent = <&gic>;
+
+	clocks {
+		fx100_clk: fx100-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <320000000>;
+		};
+
+		cpu_clk: cpu-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1000000000>;
+		};
+
+		ddr_clk: ddr-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+		};
+
+		fabric_clk: fabric-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&l2_0>;
+		};
+
+		l2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Secure Phys IRQ */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Non-secure Phys IRQ */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virt IRQ */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hyp IRQ */
+	};
+
+	axi: axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		usb: usb@300000 {
+			compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+			reg = <0x300000 0x80000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks GCK_GATE_USB_DRD>,
+				 <&clks GCK_ID_USB_REFCLK>;
+			clock-names = "bus_early", "ref";
+			assigned-clocks = <&clks GCK_ID_USB_REFCLK>;
+			assigned-clock-rates = <60000000>;
+			maximum-speed = "high-speed";
+			dr_mode = "host";
+			status = "disabled";
+		};
+
+		flx0: flexcom@e0040000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0040000 0x100>;
+			ranges = <0x0 0xe0040000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart0: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi0: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c0: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		flx1: flexcom@e0044000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0044000 0x100>;
+			ranges = <0x0 0xe0044000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart1: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi1: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(3)>,
+				       <&dma AT91_XDMAC_DT_PERID(2)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		trng: rng@e0048000 {
+			compatible = "microchip,lan9691-trng", "atmel,at91sam9g45-trng";
+			reg = <0xe0048000 0x100>;
+			clocks = <&fabric_clk>;
+			status = "disabled";
+		};
+
+		aes: crypto@e004c000 {
+			compatible = "microchip,lan9691-aes", "atmel,at91sam9g46-aes";
+			reg = <0xe004c000 0x100>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma AT91_XDMAC_DT_PERID(12)>,
+			       <&dma AT91_XDMAC_DT_PERID(13)>;
+			dma-names = "tx", "rx";
+			clocks = <&fabric_clk>;
+			clock-names = "aes_clk";
+			status = "disabled";
+		};
+
+		flx2: flexcom@e0060000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0060000 0x100>;
+			ranges = <0x0 0xe0060000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart2: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi2: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(7)>,
+				       <&dma AT91_XDMAC_DT_PERID(6)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		flx3: flexcom@e0064000 {
+			compatible = "microchip,lan9691-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe0064000 0x100>;
+			ranges = <0x0 0xe0064000 0x800>;
+			clocks = <&clks GCK_ID_FLEXCOM3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usart3: serial@200 {
+				compatible = "microchip,lan9691-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "usart";
+				atmel,fifo-size = <32>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				status = "disabled";
+			};
+
+			spi3: spi@400 {
+				compatible = "microchip,lan9691-spi", "atmel,at91rm9200-spi";
+				reg = <0x400 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				clock-names = "spi_clk";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				atmel,fifo-size = <32>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@600 {
+				compatible = "microchip,lan9691-i2c", "microchip,sam9x60-i2c";
+				reg = <0x600 0x200>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dma AT91_XDMAC_DT_PERID(9)>,
+				       <&dma AT91_XDMAC_DT_PERID(8)>;
+				dma-names = "tx", "rx";
+				clocks = <&fabric_clk>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		dma: dma-controller@e0068000 {
+			compatible = "microchip,lan9691-dma", "microchip,sama7g5-dma";
+			reg = <0xe0068000 0x1000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <16>;
+			#dma-cells = <1>;
+			clocks = <&fabric_clk>;
+			clock-names = "dma_clk";
+		};
+
+		sha: crypto@e006c000 {
+			compatible = "microchip,lan9691-sha", "atmel,at91sam9g46-sha";
+			reg = <0xe006c000 0xec>;
+			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma AT91_XDMAC_DT_PERID(14)>;
+			dma-names = "tx";
+			clocks = <&fabric_clk>;
+			clock-names = "sha_clk";
+			status = "disabled";
+		};
+
+		timer: timer@e008c000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xe008c000 0x400>;
+			clocks = <&fabric_clk>;
+			clock-names = "timer";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		watchdog: watchdog@e0090000 {
+			compatible = "snps,dw-wdt";
+			reg = <0xe0090000 0x1000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&fabric_clk>;
+		};
+
+		cpu_ctrl: syscon@e00c0000 {
+			compatible = "microchip,lan966x-cpu-syscon", "syscon";
+			reg = <0xe00c0000 0x350>;
+		};
+
+		switch: switch@e00c0000 {
+			compatible = "microchip,lan9691-switch";
+			reg = <0xe00c0000 0x0010000>,
+			      <0xe2010000 0x1410000>;
+			reg-names = "cpu", "devices";
+			interrupt-names = "xtr", "fdma", "ptp";
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&reset 0>;
+			reset-names = "switch";
+			status = "disabled";
+		};
+
+		clks: clock-controller@e00c00b4 {
+			compatible = "microchip,lan9691-gck";
+			reg = <0xe00c00b4 0x30>, <0xe00c0308 0x4>;
+			#clock-cells = <1>;
+			clocks = <&cpu_clk>, <&ddr_clk>, <&fx100_clk>;
+			clock-names = "cpu", "ddr", "sys";
+		};
+
+		reset: reset-controller@e201000c {
+			compatible = "microchip,lan9691-switch-reset",
+				     "microchip,lan966x-switch-reset";
+			reg = <0xe201000c 0x4>;
+			reg-names = "gcb";
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
+		};
+
+		gpio: pinctrl@e20100d4 {
+			compatible = "microchip,lan9691-pinctrl";
+			reg = <0xe20100d4 0xd4>,
+			      <0xe2010370 0xa8>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&gpio 0 0 66>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <2>;
+		};
+
+		mdio0: mdio@e20101a8 {
+			compatible = "microchip,lan9691-miim", "mscc,ocelot-miim";
+			reg = <0xe20101a8 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&fx100_clk>;
+			status = "disabled";
+		};
+
+		mdio1: mdio@e20101cc {
+			compatible = "microchip,lan9691-miim", "mscc,ocelot-miim";
+			reg = <0xe20101cc 0x24>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&fx100_clk>;
+			status = "disabled";
+		};
+
+		sgpio: gpio@e2010230 {
+			compatible = "microchip,lan9691-sgpio", "microchip,sparx5-sgpio";
+			reg = <0xe2010230 0x118>;
+			clocks = <&fx100_clk>;
+			resets = <&reset 0>;
+			reset-names = "switch";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			sgpio_in: gpio@0 {
+				compatible = "microchip,lan9691-sgpio-bank",
+					     "microchip,sparx5-sgpio-bank";
+				reg = <0>;
+				gpio-controller;
+				#gpio-cells = <3>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+			};
+
+			sgpio_out: gpio@1 {
+				compatible = "microchip,lan9691-sgpio-bank",
+					     "microchip,sparx5-sgpio-bank";
+				reg = <1>;
+				gpio-controller;
+				#gpio-cells = <3>;
+			};
+		};
+
+		tmon: hwmon@e2020100 {
+			compatible = "microchip,lan9691-temp", "microchip,sparx5-temp";
+			reg = <0xe2020100 0xc>;
+			clocks = <&fx100_clk>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		serdes: serdes@e3410000 {
+			compatible = "microchip,lan9691-serdes";
+			reg = <0xe3410000 0x150000>;
+			#phy-cells = <1>;
+			clocks = <&fabric_clk>;
+		};
+
+		gic: interrupt-controller@e8c11000 {
+			compatible = "arm,gic-400";
+			reg = <0xe8c11000 0x1000>, /* Distributor GICD_ */
+			      <0xe8c12000 0x2000>, /* CPU interface GICC_ */
+			      <0xe8c14000 0x2000>, /* Virt interface control */
+			      <0xe8c16000 0x2000>; /* Virt CPU interface */
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
-- 
2.53.0

