Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5041322B;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465764; cv=none; b=tsSi+udY5/BfPvgPRu8iNtUxn2dEXsz6jVinj6zmbHEPrAjpVD4KdC3eZy29MJA04eB5l93bd599LTYLcTH/2WjmcbU1J2+HXL/Jgs930zqMQcsJmX6LCfRcWxnPyP4KWHxxyxnXtyKfeF7xK/LmsgnT7Oeyl64Mxi8pmYLpgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465764; c=relaxed/simple;
	bh=ZFP8AgDDMVfbo9xqlz0itL+nVBZ/DmygRhjGTRlxnaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCFEYEei0ulbSPdAW3r44kI7pWyyuUWp+Lw1f5xKFNotzoe9gifEfdNy8DaG8SWmdvwumxkO9LTOUVGErTMdgQFnSuuhM5g1xRV10uy0HmLQYj31Jb386IObRJBBg7GCfTMvHl+Gr/MQHb+7BKRMHqSe1fqKS0zuGw0garH8kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUKUPOKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUKUPOKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E77C2BCB8;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772465764;
	bh=ZFP8AgDDMVfbo9xqlz0itL+nVBZ/DmygRhjGTRlxnaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUKUPOKSEw2QrjbLIUX5PdGoJl6Zt1RtTXw7ts9d3g/Q4ztW1uVASry/JZs+9lrn8
	 pQLFpsH3zBYKShW98dRSGnO/LxiOjMfmeJGp7T/IdWo31nDEIvKHYeUHpVblXQlWtW
	 OlwAcqJPgV8N1yQu1bbB9fc8fcxq6npDvA8FMJEt+KFyyayk9m5rK8dtQHfG83zl+7
	 DjMAYir0Ib2AENMNigw7POnXcKvQA2yJMxQ92tzGppUp67Z007auvaMqGetfhyAiFi
	 Bq6v3VNnaEjtc8WfRX3VnenZyvhKpRHnjVvl75hXzsrVN9VKsiDaaAHXyp20ei7gAb
	 0Q/d9sW1TOxTQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 210375FF08; Mon, 02 Mar 2026 23:36:02 +0800 (CST)
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
Subject: [PATCH v2 2/3] arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ pins
Date: Mon,  2 Mar 2026 23:35:57 +0800
Message-ID: <20260302153559.3199783-3-wens@kernel.org>
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

The Avaota A1 board uses spi0 on the PJ pins to connect a SPI NAND
chip.

Add the full set of pins. Even though this board doesn't use CS1, other
boards may do so in the future.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 92aecb90d4e1..da85cecb66c0 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -228,6 +228,13 @@ spi0_pc_pins: spi0-pc-pins {
 				allwinner,pinmux = <4>;
 			};
 
+			/omit-if-no-ref/
+			spi0_pj_pins: spi0-pj-pins {
+				pins = "PJ21", "PJ22", "PJ23";
+				function = "spi0";
+				allwinner,pinmux = <5>;
+			};
+
 			/omit-if-no-ref/
 			spi0_cs0_pc_pin: spi0-cs0-pc-pin {
 				pins = "PC3";
@@ -235,6 +242,13 @@ spi0_cs0_pc_pin: spi0-cs0-pc-pin {
 				allwinner,pinmux = <4>;
 			};
 
+			/omit-if-no-ref/
+			spi0_cs0_pj_pin: spi0-cs0-pj-pin {
+				pins = "PJ20";
+				function = "spi0";
+				allwinner,pinmux = <5>;
+			};
+
 			/omit-if-no-ref/
 			spi0_cs1_pc_pin: spi0-cs1-pc-pin {
 				pins = "PC7";
@@ -242,6 +256,13 @@ spi0_cs1_pc_pin: spi0-cs1-pc-pin {
 				allwinner,pinmux = <4>;
 			};
 
+			/omit-if-no-ref/
+			spi0_cs1_pj_pin: spi0-cs1-pj-pin {
+				pins = "PJ24";
+				function = "spi0";
+				allwinner,pinmux = <5>;
+			};
+
 			/omit-if-no-ref/
 			spi0_hold_pc_pin: spi0-hold-pc-pin {
 				/* conflicts with eMMC D7 */
@@ -250,6 +271,13 @@ spi0_hold_pc_pin: spi0-hold-pc-pin {
 				allwinner,pinmux = <4>;
 			};
 
+			/omit-if-no-ref/
+			spi0_hold_pj_pin: spi0-hold-pj-pin {
+				pins = "PJ26";
+				function = "spi0";
+				allwinner,pinmux = <5>;
+			};
+
 			/omit-if-no-ref/
 			spi0_wp_pc_pin: spi0-wp-pc-pin {
 				/* conflicts with eMMC D2 */
@@ -258,6 +286,13 @@ spi0_wp_pc_pin: spi0-wp-pc-pin {
 				allwinner,pinmux = <4>;
 			};
 
+			/omit-if-no-ref/
+			spi0_wp_pj_pin: spi0-wp-pj-pin {
+				pins = "PJ25";
+				function = "spi0";
+				allwinner,pinmux = <5>;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				allwinner,pinmux = <2>;
-- 
2.47.3

