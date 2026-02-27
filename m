Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEB36213E;
	Fri, 27 Feb 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214725; cv=none; b=Lhm6bu/C/C3eBaqO7surmycxQalIvOXs39xGLI+R/mPozKP2A6SozygU9v2fV0cHTRn1Or7X1WJXU+f6Er6Cl9cfqjKO3NSkwA1Qxwx3+jDwVHMt/d6X+WN88q58KE01A8mZqPT3lOSW2SKF8KCByzwLbj2B8VS3Nxp8SuLdO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214725; c=relaxed/simple;
	bh=tKKtBVOvZWHv6aIPkC7sIoW5DK8EutIUgmSN3eswTBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu8HqSLDG6BhBzrahnbK42FgIhLtcp7sJ3wrbCPRs+2GZYNVuIOCbLG2OE2/kuYLiprLjZ9tjnsZURzd3DjXcmO6mU46Jjfkg3sAHDLprveoUZAzbGcraAVzz/uDyVrd/otjGXRZvhHumIE1vrp1RyiD0PGlBwCqWsFyg09wvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G81d3nso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G81d3nso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAF7C116C6;
	Fri, 27 Feb 2026 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772214724;
	bh=tKKtBVOvZWHv6aIPkC7sIoW5DK8EutIUgmSN3eswTBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G81d3nsoIkSP4l8EnshSuzG53FbA2uBKo7cHmYqM4QAN9wBs6KEUmqrXchmKOEmeA
	 GtIfbAnXwStm69ApGhzxRvzH/Ah+R/2n9A/UQM/0aBGnqQXEuwhJYe1SAXIx6pIEQJ
	 araXge3dpXQ7YTPJ6aGk2YEA2t2AKgwgVGTYGdsNGufsh8aKTmV4OB2zf/ukUfSK3h
	 AJBCxCUPnEHqgENsX/+mtyE6pykB+LDjg7cIg6l3RqB0QQQgkuNUImoHyU0Zyo7hvJ
	 MMElxskvLzf5mAHWn8SxZIh/sztYhv69LIqUtgTtgsRxodmdaE0n6Fg8NlHACTZ9pa
	 O+vhlqHBX1oSw==
Received: by wens.tw (Postfix, from userid 1000)
	id 2E4965FEC0; Sat, 28 Feb 2026 01:52:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
Date: Sat, 28 Feb 2026 01:51:55 +0800
Message-ID: <20260227175157.2339758-4-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227175157.2339758-1-wens@kernel.org>
References: <20260227175157.2339758-1-wens@kernel.org>
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

