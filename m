Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C973D3D1A
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941282; cv=none; b=EbDQgAa1qEaW1TTc9M6IQhXnFrDUPuO6LLhHxoJE0aFUPnd0rx2AX+y0r/LdWut7mMZc4s90WHHSS7CjVijLJPO3QyNDLEAefl31skLh0lJ+AF6mOpunUt41osSBjlOUWpOVAvap4LM+ETI86a/H/r0Rtjggx05tGje4EiKBQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941282; c=relaxed/simple;
	bh=5ATDP0Fa1namVVx89i/v7abPP2oKXg8sfyEzbceXXZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3ucSUsTY035m5K1KYmT+/3dFKmN+M90PrmVT4yhikAZqgwsi9cCp3XVqWnZBFz3YDPtyW8Tl1Muy1J4/VD+FOY//qmNP2xlTmo6VcM2nLjl4No2rj1suKH8dYt0mp6T25FW2yimBPDXpNWgLJClqbymUtrn83ks/VePXahcLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWkZJoPc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWkZJoPc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c1915793so29586305e9.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941280; x=1781546080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW4LY2YSpBNnXpOBaug9Vu5LiIFIUWmfv77D+R+pYHs=;
        b=nWkZJoPcpF5MIWVUXZ5K9mQe7AipT1k2mPKrlVjmZSSLgTlvktw2EmCyhTgUZHPBSN
         Or830ObVMz/qsR24fRSx5sszqdEUU1MaZwWxfzRfgeK2o2fJAKTqOGO7FmUEjqYMaKxj
         d8KQZoU+oqiDobEDF5h8h8HGeY6VkcAt5N4GUk6iBU0eboq40lWfgYDVqk8w5QUhT5uM
         MbML0u1J8Za1UMHyM+Pq1VfP6EuwtCCjGyx7Aqru/+VM82XGcoAB2FYcZAd7Y9DRWR12
         k3hdS0CGRMnLz7Ho5w0Z0gvDPZRTVAUPtCj52PK4JhUrI0caUmVKDH/Rn9QIrvVcHsXm
         glVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941280; x=1781546080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mW4LY2YSpBNnXpOBaug9Vu5LiIFIUWmfv77D+R+pYHs=;
        b=QWjWjSRgEJwukIGawvjfXt5JjJqVj1D2EJIQjUPxNM1iYj0LKuXmaCeKKHa+U5iDH4
         J5ii8D42xav8JahQhiSFWXZlbwEiYbAX6hfU9KIyv6U/p/FoXmsoVYVrGDzRMUKYKAZX
         pwZ8NNeYxnHbTn2LUWsmZ4K4iu/2DHCGGZHMycnBZ436Dj8RTRqgHmUHlJq17WybU7zk
         zqawFx1TAOdqp3/392cAA4o2OPDVHlnjtz3puoqeOgWhSYnh8yi5muetmwn3U+q20Rgh
         xoFTwsuK/Q593Pa5ty51hxSR6AUpgx/FavAGOl0n/W4zO9J32y6E2CqADoYWau5Kswhz
         7/JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H6hZyOhexeAgbR2zrJbgxqHU/0N6NWLdiTtrXJtJs7Zk0JS9Mzsc/1K7DWqIcvdwW7iZuhbSMh/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mpaa45zYgNzc8CsGPywNVnZ+TJpbDLoMukCju7N8m2vhFmIT
	WZqT1OJqwzfihfFNmPkU8Jhl8qIPURpWI7BnVE/RxvH3VLh0z4Y7aomW
X-Gm-Gg: Acq92OEiZvH8RP9l3eRgGW7iXh4IBnN4AVFz5jty0HlZwV8lBTcDH5Ej0EVBRtJPu8h
	RSewliWZ3jhOndhVhzLJD/oqoLL2DxKl1nmPNjhdYCk3jhEAKsx/5SnbmOqSNB/+jOzdHuvjOeX
	bjYmkRwqBkcurWp5Al1DmU5GPmBDS4MTqt1XUTH5w4VMmgRxZkx0pG6vFbAw277AFhXoIM9KSFi
	EIHiu7vtUxkCsh7aeXpzHvvwbeNU8Q0VS5CRFwYxTFkF/V7G+FoNk7VvvYexky/1sZhw0c/j/k0
	yq8DDS2gOwDGk2KR6KAwnZAOIK8X6zZXxyMXDr9krAHZlPQxUe65QWOmtALEPUtpu5x3nA85bLI
	cqcyEY6XZX3ygja6lKlniGHDwpsNqkMf3Dke4z7nFNSh4OUmN2zqzJdaVWOYF26SEoNDJ3I/Mrn
	tQ7XoLTLWovTRbNfg2Bip0wkRCcQxvsjTV+i6I755Hu4NG
X-Received: by 2002:a05:600d:4453:10b0:490:c2a3:3301 with SMTP id 5b1f17b1804b1-490c2a33392mr188853685e9.34.1780941279609;
        Mon, 08 Jun 2026 10:54:39 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm56269275f8f.28.2026.06.08.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:54:39 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Subject: [PATCH v2 1/2] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
Date: Mon,  8 Jun 2026 20:54:17 +0300
Message-Id: <20260608175418.1936892-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608175418.1936892-1-tmaimon77@gmail.com>
References: <20260608175418.1936892-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NPCM7xx FIU controller nodes only describe the control register block,
but they still advertise a second "memory" entry in reg-names. Drop the
bogus name so the DTS matches the resources actually present in each node.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index ab3c3c5713ae..a16450abea0e 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -191,7 +191,7 @@ fiu0: spi@fb000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfb000000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI0>;
 			clock-names = "clk_spi0";
 			status = "disabled";
@@ -202,7 +202,7 @@ fiu3: spi@c0000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xc0000000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI3>;
 			clock-names = "clk_spi3";
 			pinctrl-names = "default";
@@ -215,7 +215,7 @@ fiux: spi@fb001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfb001000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPIX>;
 			clock-names = "clk_spix";
 			status = "disabled";
-- 
2.34.1

