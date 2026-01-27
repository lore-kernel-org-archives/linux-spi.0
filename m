Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B0265CC2;
	Tue, 27 Jan 2026 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545101; cv=none; b=Wl3xpzeTa5oNRwONH4FDieD60UJ2Y7SM4faKo6pIPqpP/T01VB/yqLM4RiLaRib3gP154o03yHTGBjFGnFXC2iHelbGeSCH28k0RJ2dPqNeIQFL3C5m+HFx0gowld3Ua4lCEnn2THE/3Sw229pZ7eGPrRHH9yqcBB5j6i4n6Igw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545101; c=relaxed/simple;
	bh=vqM/AQoYvDn10JpUAvxzI5uTGLi1XLccpPDYZLLj7Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym81mN7sEW+fiOyniYsQYUi5T1aNyKeLTd8cIBYdeQf/4Z/xUZJ3gwr/VihlkjzDPRXLkSxzrW8aep3aTaOK55zflP0o2kQtU8RsLlFoIGkJ7zjUY/ngWjT9eNCveZrORJOCgyaqQ86fXFHvdB9jb6sWpcuTfRyQE+oPIWP9Yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Sy30TNNERDC3npRWBWs+rg==
X-CSE-MsgGUID: P7IvSMygReGxHnthAJNOrw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jan 2026 05:18:12 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.69])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C98840869DB;
	Wed, 28 Jan 2026 05:18:08 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 2/3] arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
Date: Tue, 27 Jan 2026 22:17:05 +0200
Message-ID: <20260127201706.616374-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127201706.616374-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260127201706.616374-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RZ/T2H (R9A09G077) has three DMA controllers that can be used by
peripherals like SPI to offload data transfers from the CPU.

Wire up the DMA channels for the SPI peripherals.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

V2:
 * wire up all DMA controllers

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 14d7fb6f8952..0e44b01a56c7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -200,6 +200,10 @@ rspi0: spi@80007000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 104>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267a>, <&dmac0 0x267b>,
+			       <&dmac1 0x267a>, <&dmac1 0x267b>,
+			       <&dmac2 0x267a>, <&dmac2 0x267b>;
+			dma-names = "rx", "tx", "rx", "tx", "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -218,6 +222,10 @@ rspi1: spi@80007400 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 105>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x267f>, <&dmac0 0x2680>,
+			       <&dmac1 0x267f>, <&dmac1 0x2680>,
+			       <&dmac2 0x267f>, <&dmac2 0x2680>;
+			dma-names = "rx", "tx", "rx", "tx", "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -236,6 +244,10 @@ rspi2: spi@80007800 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 106>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2684>, <&dmac0 0x2685>,
+			       <&dmac1 0x2684>, <&dmac1 0x2685>,
+			       <&dmac2 0x2684>, <&dmac2 0x2685>;
+			dma-names = "rx", "tx", "rx", "tx", "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -254,6 +266,10 @@ rspi3: spi@81007000 {
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKM>,
 				 <&cpg CPG_MOD 602>;
 			clock-names = "pclk", "pclkspi";
+			dmas = <&dmac0 0x2689>, <&dmac0 0x268a>,
+			       <&dmac1 0x2689>, <&dmac1 0x268a>,
+			       <&dmac2 0x2689>, <&dmac2 0x268a>;
+			dma-names = "rx", "tx", "rx", "tx", "rx", "tx";
 			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.52.0
