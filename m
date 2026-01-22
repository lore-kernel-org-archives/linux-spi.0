Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048F38BDD2;
	Thu, 22 Jan 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094870; cv=none; b=gjS6/FLnF7uD7DL8BVz9BOfmKxRKCX92Q3tebrRnBiB6TFfbTRBaU1CEn/WvhQJf9rwUtHIRWJebcK0A4H/x2ikodKj4V+8Zjf4b+9LXNqaJUxlVQcSviSSY0NEFeZQLDYal5auZQ+rSNAyjoqX8jZmjASPB2eTREUQCYYw9pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094870; c=relaxed/simple;
	bh=Kp1EiYbHl52gcoo53/+Mm7ZQjp2iu07iybEcu+QABEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc6N6GE1Y9FzNo0pUfX6VzfxoR/nRje/aq/aPMhzzRJZEUfmBZoG6KssSU4OhAjtr1SUvEzXlfQX+BWizec25LK+cK1ds9A32zqGmh6fq807dBpDs2o0JgfGVGK8XsE9phOgL0gppI2n++jEDTMI6ln7cCJvSasZXxrffkWyImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V+2jLvOd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V+2jLvOd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 541AB1A2AB7;
	Thu, 22 Jan 2026 15:14:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 293E8606B6;
	Thu, 22 Jan 2026 15:14:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87BE9119B82E7;
	Thu, 22 Jan 2026 16:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094865; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WccFrzV37pjQDcMtab7f2QieezsSKecv42H/QrPd54o=;
	b=V+2jLvOdCIbZ3VSaeMDssSrE0IPLb+HflOJb2HR4mDdrM7tEtG937icwwRl0lAKNJE72zR
	62AMP8zsILL7o1iu5ktQC7/+KHZl69WYh5BwQ7Ip1crpsFa8zBlZxFvgUO4LACDv7iSwmD
	46TUpWkZcBiLOdbaLJGyJlmR2tjTXzoeIZCWcsBMt6uoTVtTbI80pBx9CB6qAogTR7cHpL
	WGwvjjAiiXltTvfS8p1xH+o5BPDtZrg7L7FPzz9C8vuCBxxn5pNWe5YJI7GaS4CnDLK1Ke
	IGWSovky8mD0QBsWIPNVj1pfG0PoqaLr5Ed7Npk/kDa/CaIDl+tEV0ebWGAKtw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:40 +0100
Subject: [PATCH v4 15/15] ARM: dts: r9a06g032: Describe the QSPI controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-15-f9c21419a3e6@bootlin.com>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a node describing the QSPI controller.
There are 2 clocks feeding this controller:
- one for the reference clock
- one that feeds both the ahb and the apb interfaces
As the binding expect either the ref clock, or all three (ref, ahb and
apb) clocks, it makes sense to provide the same clock twice.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index 8debb77803bb..47143e6636d2 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -66,6 +66,18 @@ soc {
 		#size-cells = <1>;
 		ranges;
 
+		qspi0: spi@40005000 {
+			compatible = "renesas,r9a06g032-qspi", "renesas,rzn1-qspi";
+			reg = <0x40005000 0x1000>, <0x10000000 0x10000000>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_CLK_QSPI0>, <&sysctrl R9A06G032_HCLK_QSPI0>,
+				 <&sysctrl R9A06G032_HCLK_QSPI0>;
+			clock-names = "ref", "ahb", "apb";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		rtc0: rtc@40006000 {
 			compatible = "renesas,r9a06g032-rtc", "renesas,rzn1-rtc";
 			reg = <0x40006000 0x1000>;

-- 
2.51.1

