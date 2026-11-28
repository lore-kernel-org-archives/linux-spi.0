Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875345;
	b=FPpFUmxHMT/702aeyjt2hG+M4tUgoVKhdQNaU66Js+z867O30GkEGOXqSfwMVgvDoGAw
	 O2UCp2iFoyTz6Vhux+bgrGn+O+aEmAjz/x+eqitbhsaPP2sFnvCK9w+Zq4oqiWG+h0qj2
	 5cnX1slzdYOosjjnDEOxUNgNv294AHORhmQeg/sx0ZF9/pMsAA9bCmZk4t+W5rk8xSa+A
	 0RR4fq2rpygE0AwQvcd965vfBkMxE7gU1+B449sGK2wYxc6YAruWurh4A5nRzovSwZM+k
	 Ko4riv2oq4dtsR0VTSEuc/Lj+fJRBUGGGvnKcvkiBFxRTlhYrMbb588sQBTH2S55dLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/byIlVMP9LxJ2ciT0gDQ4yghuuOkdLHgAUlgdYldohc=;
	b=mx9Ju11Q2jBQYnZlzgThCTXaKWnpF+DuKWexuprfWbgu7hpHZhWr2w2Z14ZNc/LBEx8H
	 fQi0Sdi+MORdN5ln3ilSfnNKToiBdNf0P80vBZQtFckwrowvVDqph55vvbO4b/27zj/nB
	 EQBWNCq1+c/stLX2KcbRu2CVjs7RgNu5myW/k/4cAIMcViR/QW4yAtWeVoUDoGkbZba66
	 ePGhO03hH6FfCLyGpUyOR3PtzM28gIRkRkQCMimGuFXijolKY+3ViFXRM8f3eGYySfCFS
	 WHOm5YsXFxG+uiTy4knxPGxFk3Pe4lUhoEFkYWp1B76KOaaO0kwPAYfmdFemcoEepLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZ7xDRcr;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD64606A324
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD64606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZ7xDRcr
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385d8a00598so14488952eec.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875344; x=1796480144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/byIlVMP9LxJ2ciT0gDQ4yghuuOkdLHgAUlgdYldohc=;
        b=wZ7xDRcrEUkK9ZrETumyYvgEHSJSUDnytGdlPort2FAo1vOoKxCRkZT0b0+9wfgJXP
         f1ejAnBqNu2+eQIPPsNQJOrAt/t46OnrS2HjIfTYnBcgdlyRPKTnQqLodLsqh0Q+0CNe
         r4S6Fp0EERvOZMkeUp1wu9vOKxsn24WKgoWtBtLlRPKq0jEyOuA7ElOoaHE7TYFGGRZN
         FlMWfxLggvQ3pUCgGu2CDlsvAlaYIFgxhSIjsvMgbZx0Md508c9/8vfzIRhxjnaJWhi1
         VAFlpTQQxed4yrPMqNL+FU26TjixUXhwSxQKWkVzatIhSidbAQKcEEUuP7lA3mu6CuYQ
         R+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875344; x=1796480144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/byIlVMP9LxJ2ciT0gDQ4yghuuOkdLHgAUlgdYldohc=;
        b=cf/g6ovVWE/3mG92wjlaN7mWqOdeplyPPB89F7u6pR47vBdHl+HI+/xROIJG8gk5OK
         oIZXaffeMjlmLdGndUocpHvOhW4GXfyYq3ZXI9mUMTAaNN6FyXx84PcumzrOwNdHlXyq
         6XVVtLsGIQm4UVJlbY9ZykjoyzPrKW4MCzB5/lsj9jy/vIodr7V1WQsFnA6bcI1R4TGt
         nTV97/TGLU5tnDxqkw9Ymv4HPMq6aw9+Zz8peeWf5qUvG3lJGlawr2pHFB84oL6CSVuO
         pFXZtL26mblJmqA8ASRhwHswye1KPbRkEdBKHHbnLGermfh7KWZrzsg/3yB3Uy+Uop2P
         iBZQ==
X-Forwarded-Encrypted: i=1; AL+hErFta41Po+PVNSKrNU+boW/xlanxqb7QrJensTqes1MEMQ3+nEQXKDwR9CUuJHB9ZWsm6snvxVdZmQU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zXY3u7ZTCHB31XLYZIGcHDn7TEQd+Kwkk8urugHTGYvx6iPZv
	4iRMfXIpalX1Q7ix07WL3SfxaA1e+8oBBXEVzMq0/raFxi62UhFXzYf3
X-Gm-Gg: AZFdTZciAUdER0NohIkO5AxMh2CGyxdCUEVGnesPmnVpVyTfjczaSfh6zBFJ5EAe/5H
	saWJ1ccdxKUjbfcJSfMSm/HoKui88e1172fsG9Jvbd+bqUKLBzleICen3KNdZ2Em4HxRv1rmRoH
	4/G9FIaxqxcFzUw/QDVEJCAo/gAfe9FprZ1NyDD2XktOgloH+Wr937/7mZXQdO/LFAiJwnHKSPq
	CPjeWGnPrCWfgVKild1FJ3fO6xQzG21bwkcbEWkMTCOiHAEW3XziTvg+6ZQmB60Ywjh5NBrLpnX
	tWN6GN+Nyly8vVFLJU/7EBrBxgPQXTNdjwdjMQ7ksLobaJ23IRZSklU1jadVYRJRpw1tNO5I6Ey
	G0j4taIFbFrtai0MJPTQ194hn9V3XkVeLIKXpAqbEX7a6W+cM2o3CgbmN8C2zVGqAFCUe5U3Wbs
	vugEN7gBsh3MxgCzgmIdhcJn4xqfBxq/WvrFjL+XHBf+Ubew7JETqjv0GgeItImyFtBX7tna+YU
	qeqbOFm9UDCqZFs9InOXa1a+qbIxe151Xgj/T2MkMcGKp3yIyn/nsBDQYg+ggLDaWvhQ3w1q45K
	+0+2QX/Tr2WCOm7uu1WiLamwV5I8G4uuZovhnVCeXGWikvdLqG/amF5ApeC3MLSgTSD7SgFM8sd
	v3AZI90UdDFpDPpyi+cbdkjG3sgSO
X-Received: by 2002:a05:7301:4704:b0:383:729:cabe with SMTP id 5a478bee46e88-3856f8519ecmr28974642eec.19.1795875343193;
        Sat, 28 Nov 2026 06:15:43 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.15.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:15:42 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Leilk Liu <leilk.liu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH 5/6] arm64: dts: mediatek: Add MT8189 Skywalker platform based Tarkin
Date: Sat, 28 Nov 2026 19:44:29 +0530
Message-ID: <20261128141443.13065-6-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261128141443.13065-1-sinha.aryan03@gmail.com>
References: <20261128141443.13065-1-sinha.aryan03@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tarkin is an ASUS Chromebook (CM1405, CM1406) built on Google's MT8189
Skywalker reference design. Add the common Skywalker dtsi and a board
file for Tarkin.

This covers what the MT8189 bindings support today: the debug UART,
eMMC and the SD slot, the PMIC, the EC on SPI0 with the keyboard,
battery and Type-C ports, the GSC TPM and the trackpad. Tarkin can have
a HID over I2C trackpad at 0x15 or an Elan one at 0x2c, so both are
marked fail-needs-probe and left to the ChromeOS hardware prober.

The EC resets the PMIC on these boards, so the watchdog external reset
is disabled, as on the other MediaTek Chromebooks.

Display, GPU, audio, USB, UFS and PCIe are left out until the SoC side
for them is upstream.

The Skywalker and Tarkin descriptions are based on mt8189-skywalker.dtsi
and mt8189-skywalker-tarkin.dts from the ChromeOS kernel.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8189-skywalker-tarkin.dts  |  62 +++
 .../boot/dts/mediatek/mt8189-skywalker.dtsi   | 453 ++++++++++++++++++
 3 files changed, 516 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-skywalker-tarkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-skywalker.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e6a8109ff..cb8c01ea8 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8189-skywalker-tarkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8189-skywalker-tarkin.dts b/arch/arm64/boot/dts/mediatek/mt8189-skywalker-tarkin.dts
new file mode 100644
index 000000000..5b76d0ca9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189-skywalker-tarkin.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Google Inc.
+ */
+
+/dts-v1/;
+#include "mt8189-skywalker.dtsi"
+
+/ {
+	model = "Google Tarkin board";
+	chassis-type = "laptop";
+	compatible = "google,tarkin", "mediatek,mt8189";
+};
+
+&i2c7 {
+	trackpad@2c {
+		compatible = "elan,ekth3000";
+		reg = <0x2c>;
+		interrupts-extended = <&pio 125 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+		vcc-supply = <&pp3300_s3>;
+		wakeup-source;
+
+		status = "fail-needs-probe";
+	};
+};
+
+&i2c_tunnel {
+	/delete-node/ sbs-battery@b;
+
+	battery: sbs-battery@f {
+		compatible = "sbs,sbs-battery";
+		reg = <0xf>;
+		sbs,i2c-retry-count = <2>;
+		sbs,poll-retry-count = <10>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+
+	status = "okay";
+};
+
+&mmc1 {
+	status = "disabled";
+};
+
+&mt6359_vpa_buck_reg {
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1000000>;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&trackpad {
+	status = "fail-needs-probe";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8189-skywalker.dtsi b/arch/arm64/boot/dts/mediatek/mt8189-skywalker.dtsi
new file mode 100644
index 000000000..f0c5a0da7
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189-skywalker.dtsi
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Google Inc.
+ */
+
+#include "mt8189.dtsi"
+#include "mt6359.dtsi"
+#include "mt8189-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	aliases {
+		i2c3 = &i2c3;
+		i2c7 = &i2c7;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ppvar_sys: regulator-ppvar-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* system wide 3.3V rail, controlled by the EC */
+	pp3300_z1: regulator-pp3300-z1 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_z1";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V rail, controlled by the PMIC */
+	pp3300_s3: regulator-pp3300-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&pp3300_z1>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	status = "okay";
+
+	tpm@50 {
+		compatible = "google,cr50";
+		reg = <0x50>;
+		interrupts-extended = <&pio 138 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gsc_int_pin>;
+	};
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+
+	status = "okay";
+
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		hid-descr-addr = <0x0001>;
+		interrupts-extended = <&pio 125 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+		post-power-on-delay-ms = <10>;
+		vdd-supply = <&pp3300_s3>;
+		wakeup-source;
+	};
+};
+
+&mmc0 {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x1481b>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	supports-cqe;
+};
+
+&mmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 136 GPIO_ACTIVE_LOW>;
+	max-frequency = <200000000>;
+	no-mmc;
+	no-sdio;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&mt6359_vpa_buck_reg>;
+	vqmmc-supply = <&mt6359_vsim1_ldo_reg>;
+	mediatek,tuning-step = <64>;
+
+	status = "okay";
+};
+
+/*
+ * Rails the bootloader turns on that no driver here claims. Keep them on
+ * so they survive the regulator core disabling unused supplies.
+ */
+&mt6359_va09_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vaux18_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vmodem_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpa_buck_reg {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+};
+
+&mt6359_vproc2_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrfck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_proc2_ldo_reg {
+	regulator-always-on;
+};
+
+&pio {
+	uart0_pins: uart0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO31__FUNC_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_URXD0>;
+			bias-pull-up;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO57__FUNC_SCL3>,
+				 <PINMUX_GPIO58__FUNC_SDA3>;
+			bias-disable;
+		};
+	};
+
+	i2c7_pins: i2c7-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO65__FUNC_SCL7>,
+				 <PINMUX_GPIO66__FUNC_SDA7>;
+			bias-disable;
+			drive-strength = <4>;
+		};
+	};
+
+	spi0_pins: spi0-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO69__FUNC_SPIM0_CSB>,
+				 <PINMUX_GPIO70__FUNC_SPIM0_CLK>,
+				 <PINMUX_GPIO71__FUNC_SPIM0_MO>,
+				 <PINMUX_GPIO72__FUNC_SPIM0_MI>;
+		};
+	};
+
+	ec_int_pins: ec-int-pins {
+		pins-int {
+			pinmux = <PINMUX_GPIO132__FUNC_GPIO132>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	gsc_int_pin: gsc-int-pins {
+		pins-int {
+			pinmux = <PINMUX_GPIO138__FUNC_GPIO138>;
+			input-enable;
+		};
+	};
+
+	trackpad_pins: trackpad-pins {
+		pins-int {
+			pinmux = <PINMUX_GPIO125__FUNC_GPIO125>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO166__FUNC_MSDC0_DAT0>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <6>;
+			input-enable;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <6>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+			drive-strength = <6>;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO166__FUNC_MSDC0_DAT0>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <8>;
+			input-enable;
+		};
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+		pins-ds {
+			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <8>;
+			input-enable;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO136__FUNC_GPIO136>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins{
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO168__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			drive-strength = <8>;
+			input-enable;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+			drive-strength = <8>;
+		};
+	};
+
+};
+
+&pmic {
+	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	mediatek,pad-select = <0>;
+
+	status = "okay";
+
+	cros_ec: ec@0 {
+		compatible = "google,cros-ec-spi";
+		reg = <0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupts-extended = <&pio 132 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ec_int_pins>;
+		spi-max-frequency = <3000000>;
+
+		i2c_tunnel: i2c-tunnel {
+			compatible = "google,cros-ec-i2c-tunnel";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			google,remote-bus = <4>;
+		};
+
+		typec {
+			compatible = "google,cros-ec-ucsi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_c0: connector@0 {
+				compatible = "usb-c-connector";
+				reg = <0>;
+				data-role = "host";
+				label = "left";
+				power-role = "dual";
+				try-power-role = "source";
+			};
+
+			usb_c1: connector@1 {
+				compatible = "usb-c-connector";
+				reg = <1>;
+				data-role = "host";
+				label = "right";
+				power-role = "dual";
+				try-power-role = "source";
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+
+	status = "okay";
+};
+
+&watchdog {
+	mediatek,disable-extrst;
+};
+
+#include <arm/cros-ec-keyboard.dtsi>
+#include <arm/cros-ec-sbs.dtsi>
+
+&keyboard_controller {
+	keypad,num-columns = <15>;
+
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+		MATRIX_KEY(0x00, 0x01, 0)	/* T11 */
+		MATRIX_KEY(0x01, 0x05, 0)	/* T12 */
+	>;
+
+	linux,keymap = <
+		CROS_STD_MAIN_KEYMAP
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)		/* T1 */
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)		/* T2 */
+		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)		/* T3 */
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)		/* T4 */
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)		/* T5 */
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)		/* T8 */
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)		/* T9 */
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)		/* T10 */
+		MATRIX_KEY(0x00, 0x01, KEY_MICMUTE)		/* T11 */
+		MATRIX_KEY(0x01, 0x05, KEY_CONTROLPANEL)	/* T12 */
+		MATRIX_KEY(0x03, 0x05, KEY_PREVIOUSSONG)	/* T13 */
+		MATRIX_KEY(0x00, 0x09, KEY_PLAYPAUSE)		/* T14 */
+		MATRIX_KEY(0x00, 0x0b, KEY_NEXTSONG)		/* T15 */
+		MATRIX_KEY(0x03, 0x00, KEY_LEFTMETA)		/* Search */
+		MATRIX_KEY(0x01, 0x0e, KEY_LEFTCTRL)		/* Left Control */
+		MATRIX_KEY(0x06, 0x0d, KEY_LEFTALT)		/* Left Alt */
+		MATRIX_KEY(0x03, 0x0e, KEY_RIGHTCTRL)		/* Right Control */
+		MATRIX_KEY(0x06, 0x0a, KEY_BACKSLASH)		/* Backslash */
+	>;
+};
-- 
2.46.0

