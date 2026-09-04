Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DC2192F9;
	Fri,  4 Sep 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491640; cv=none; b=IesHYV0ss2GHpSzc+Y0bQA+NKDXrA5Yb1esWT5EROk1ITBlNBe01sreQ0WBaFqTh8lldsqaYdGWZTFvzqDCNsbQMPzasY58XVVoi1nY585Qo3oHyXuQcovtU+K7PB1FzIcbVtvqTA8kBtFvNiCZFNfndXeEXHp86O8BQ3GLULgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491640; c=relaxed/simple;
	bh=nayiJLroWhUNX1f+TgRi6MVAcBRcDNFEKkuBlCdFbUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaHIz/U3m+JRvzChZNKWd7bJAI0Hycwlic3SLBsNTEUJD4mYba+GkY0XlpG8fyzYaJju87Z7VM4/D4EWFe3ZnwjUqlqu9RQ0qIwcw8JyGaI7HpbgSzUs0GIFE4dz8A4vYU7LQLDEDGVbpZ2CQo05ZZc29iISYBJGq3U7dwfRibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JAHbXGQk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JAHbXGQk"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6843Cr6W24114209, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788491573; bh=3JdeOwSlxB2bDEfY8MtDSF7Q0CSjNVIMGqVjvLf4tzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JAHbXGQkN+G/s/EL3/r+v6SfI1SKOkasM9HatZ6XQhhT9Y2aQJ08+MnwuHwuB6POU
	 xXmL785O72wE48nuDPcCeo+NS7CMFLN1ABzx9HE2qpoBX5DRoYfn+vVRUVZGwTLFUB
	 Z09ycmxxfQprm2Ma59WrrtFXOu3ePQVRd905o5P2YjDkU6p8JspWnrHiMG1s8Xd/GA
	 9lhWA6Utm6G0A+iCUxbGUpCIi80ke7Egb9N7/olCim/Y2WdT6vcmAGgbfhVjd6/SPO
	 IcIbh2x+YxnSY0Qb6px/vvFmbqb0U1HwOfb3A/VSz+EZzcZ4urnloKw9N6wL4+0PZt
	 k0BpLQKZi7G3Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6843Cr6W24114209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 11:12:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:53 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Fri, 4 Sep 2026 11:12:53 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <afaerber@suse.com>
CC: <bartosz.golaszewski@oss.qualcomm.com>, <james.tai@realtek.com>,
	<cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>, <jyanchou@realtek.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-realtek-soc@lists.infradead.org>
Subject: [PATCH 3/3] arm64: dts: realtek: Add SPI NOR flash node for RTD1625
Date: Fri, 4 Sep 2026 11:12:52 +0800
Message-ID: <20260904031252.244280-4-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260904031252.244280-1-eleanor.lin@realtek.com>
References: <20260904031252.244280-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the SPI NOR flash node for the Realtek RTD1625 SoC.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi | 16 ++++++++++++
 arch/arm64/boot/dts/realtek/kent.dtsi         | 26 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi b/arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi
new file mode 100644
index 000000000000..01df3aa9254a
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Realtek Semiconductor Corp.
+ */
+
+&main2_pinctrl {
+	spi_pins: spi-pins {
+		pins = "gpio_64",
+		       "gpio_65",
+		       "gpio_66",
+		       "gpio_67";
+		function = "spi";
+		realtek,drive-strength-p = <3>;
+		realtek,drive-strength-n = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/realtek/kent.dtsi b/arch/arm64/boot/dts/realtek/kent.dtsi
index 409d46a73c91..e266d62b6527 100644
--- a/arch/arm64/boot/dts/realtek/kent.dtsi
+++ b/arch/arm64/boot/dts/realtek/kent.dtsi
@@ -5,6 +5,8 @@
  * Copyright (c) 2024 Realtek Semiconductor Corp.
  */
 
+#include <dt-bindings/clock/realtek,rtd1625-clk.h>
+#include <dt-bindings/reset/realtek,rtd1625.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
@@ -137,6 +139,7 @@ psci: psci {
 	soc@0 {
 		compatible = "simple-bus";
 		ranges = <0x0 0x0 0x0 0x40000>, /* boot code */
+			 <0x88100000 0x0 0x88100000 0x02000000>, /* NOR flash aperture */
 			 <0x98000000 0x0 0x98000000 0xef0000>, /* rbus */
 			 <0xa0000000 0x0 0xa0000000 0x10000000>, /* PCIE */
 			 <0xff000000 0x0 0xff000000 0x200000>; /* GIC */
@@ -146,6 +149,7 @@ soc@0 {
 		rbus: bus@98000000 {
 			compatible = "simple-bus";
 			ranges = <0x0 0x98000000 0xef0000>,
+				 <0x88100000 0x88100000 0x02000000>, /* NOR flash aperture */
 				 <0xa0000000 0xa0000000 0x10000000>; /* PCIE */
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -199,6 +203,26 @@ iso_s_cc: clock-controller@146310 {
 				#reset-cells = <1>;
 			};
 
+			nor_flash: spi@14b000 {
+				compatible = "realtek,rtd1625-nor";
+				reg = <0x14b000 0x50>, <0x14bf00 0x30>, <0x88100000 0x2000000>;
+				reg-names = "ctrl", "dma", "dirmap";
+				clocks = <&cc RTD1625_CRT_CLK_EN_MD>;
+				resets = <&cc RTD1625_CRT_RSTN_MD>;
+				pinctrl-0 = <&spi_pins>;
+				pinctrl-names = "default";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				flash@0 {
+					compatible = "jedec,spi-nor";
+					reg = <0>;
+					spi-rx-bus-width = <2>;
+					spi-tx-bus-width = <2>;
+					spi-max-frequency = <64000000>;
+				};
+			};
+
 			ve4_pinctrl: pinctrl@14e000 {
 				compatible = "realtek,rtd1625-ve4-pinctrl";
 				reg = <0x14e000 0x84>;
@@ -217,3 +241,5 @@ gic: interrupt-controller@ff100000 {
 		};
 	};
 };
+
+#include "kent-pinctrl.dtsi"
-- 
2.43.0

