Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465841161B;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465764; cv=none; b=o3FviKqkE0GSBNPK0bkZXURAGpBnmDaIQpWx6kcfrn6dAtHkp2sB3c+KIYaFIEX6NWwJOKsz70sbaG3KraxpmE2mQBcI+20RA8vK4s+jrYnUirD3ZEg7helks/d+6W1arLw2VOaxmrhmQ0eW+ITKkqMDY5rv7NkcNhHWI/kme4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465764; c=relaxed/simple;
	bh=z/p2kAng0Y5oRilaQCks0dh5WQLuleduc50nf40KO6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO4jzgzmKFn9vcG6UPzQxPk3d7EOxHkaur/KisiLGaUqale59YAGeeU4J4ojPamVTx/jO3y++adR+Eptfvnadg/FmM0K8y44Kz674M3nRkOxVOwWnGUceWy0YnEX2Bbib0Pnrmx2CJQvjOhOxW3cJjXVZnGbazX5p9UHFNNpTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHiUS7wS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHiUS7wS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3EAC4AF0D;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772465764;
	bh=z/p2kAng0Y5oRilaQCks0dh5WQLuleduc50nf40KO6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHiUS7wSLoHxSX4GSlEChP6haEzq9nrYlDDDbes9RRgMy5jutsaPJtocJ6m+CWOo5
	 S7L3lvsxEvz/ViMWRTKOIhA9gh9Uj5r4SIeYGlT+mx9iNYHH6t7qY5D5Y6SAWtaa2v
	 05NdAK/svFGTUNNMuESEwtVmC3kLJ5P6W/RuL+uah8Jfw3O3YH30idKxOJZjmXUqU9
	 cXE4IJlOUGXHL/o9VnFQIeTWe09k8peXTPiF2bO+IAyexKh98WHNTfqF9S+iCIJY1R
	 GOaAB//+NGnpu3qFl9EoPILdYCMsk3E17vCVlHdrXvB0naQMwK0STkUvwHt7GbMv+s
	 D14RAcLsZTX9A==
Received: by wens.tw (Postfix, from userid 1000)
	id 320EB60003; Mon, 02 Mar 2026 23:36:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
Date: Mon,  2 Mar 2026 23:35:58 +0800
Message-ID: <20260302153559.3199783-4-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302153559.3199783-1-wens@kernel.org>
References: <20260302153559.3199783-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Avaota A1 board has a SPI NAND chip connected to spi0 on the PJ
pins with support for QSPI.

Enable spi0 and add a device node for the SPI NAND chip.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 7c24121de88f..474354fbfcec 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -403,6 +403,21 @@ &rtc {
 	assigned-clock-rates = <32768>;
 };
 
+&spi0  {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pj_pins>, <&spi0_cs0_pj_pin>,
+		    <&spi0_hold_pj_pin>, <&spi0_wp_pj_pin>;
+	status = "okay";
+
+	nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.47.3

