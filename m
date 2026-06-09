Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFC4963CE
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020492; cv=none; b=spekmSKv8/I5ihooLOrGUc+uoQoSTX7nMyj28qUM0i+BUrMt0MZ7Bl3+uO8l+kNe+QXGspljvYVfbY5OqGSSjPImLFb+/yYGHU5CnQJx+eCtMM6f9Q89Z3wTHpK89H8ktO21dHq7IrL9JyXiJajbw4L1yOVxdvL6dSF+aXu20SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020492; c=relaxed/simple;
	bh=9SF/jX8GOiX2deBZMN+oVb0daB6JW8wK1yNsTM/SK2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aam0ciCTn0LYEG6tzykfMl0oCCpB/lqIwqfsjNy7/l7LgjfuoDKATsA78AYGZbUzrsUYAKh2tk7vVU4tOYbGqmFhBJdRnTSm697s/oKgSsydCz1mgPZsFyGVgyrR6avvWyrsaHAr8AgMBKUew3SdUVeaM+YN3Bd5vszf1w3FA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6I8d02s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6I8d02s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b64c8311so63973665e9.3
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020490; x=1781625290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWwFGlSUcw639N/YKTjCDkqA0Z4pIkuOoAAVpcehPeE=;
        b=g6I8d02s3GXTsXz1IH9xywGoHpwKbaFwaVyIK6GkThumZcpzIxJkmDbRHdmhFuPPi3
         nnhZE+zqaNpDG00d44Ett9+jNoyE5WNqe/LVSJvctHCY1PDuJ5FtW8e+jlxExk4OP36k
         UqdexYj/ezHWQJGxKD3Lcfjx5JQZMnGJEzclcK6VnpNJPjYGo9PkwOrJAK6K3Yskq5vr
         M4R5E1MNncOea4rHz3dRqLUFWZVVReFEqTBvS0dMYUnqHpJxHY8G+rUmXfGL7P9wbI2t
         zjL46zsVxlhdktUUxGKMXNkibb8qkhPLWIlwZZkji90dAXQlHXjca135qqka9dxIt2Yy
         xDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020490; x=1781625290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWwFGlSUcw639N/YKTjCDkqA0Z4pIkuOoAAVpcehPeE=;
        b=kKZbW0ZNCnldZwabWh9k2XX6WwQohfQ4hXnYQ+N6jTbX7JI0DI+PZkJHK+f9mcoVDX
         z47Yxb6155d/kfmLhSa0btz1yE2AOIlAMw7LrQkn936BmsfyNNctZ6ofgYxXtCzFX2pY
         YLT1JXFcevHE9lZiBO3vJ0WaEc/xs6jPF07dimn1oHc1UwKRsKgdO6Liuh1o2RYVCanf
         9ykoJPFbJu7exoyy1zpAC9i0RQz0ISNOFi9k/hrVD6H8un6j6UZaJfaCU6r9BAvVS1Qv
         1OQpeaIHkx6OrjWN9uBmeXLCPaUm9DH6Za6S1niLebNMATjVOUHqgNQy1a2vrw2GKuew
         +jDg==
X-Forwarded-Encrypted: i=1; AFNElJ8Xxal7vd1mYVwiVQ38jfM+cnSqYbgM8KS3PHpttmwo/7zQaUOu7uQRQlAooiCGtJz22lAizHdngiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8belxFGPMMZBV4yZb4M+tUM+jNPs/5PTlQzeVv55JBZMZMUC
	tYEqkhsHCW3d1t4MskPVwaf4GTZaOaAAlZQOzlTUfI7PNKWvC26W65M5
X-Gm-Gg: Acq92OH+y5Vv2+w5kz/4N1ZZSsN5U4sMznh4XZVSuJOhr5xPivl5AI/Em2/OWWWs8Mu
	X09gohT3EGJS4CWk2E+U7Nv5l29J7JP2LYgOOIyFR3aqkkufN/TzDAQWqIndu7+BGt8QlORWhP8
	beQtXtYxAEw4Uk0RyvyULj+M+3+oPCPe9ZnyHHk1lBg3HYhQan07ynVS9hQfTVTUjVaUYHNwKNi
	NNjg4ddob4MeFXbMFTqh0yh6+97oqRxG7NmQp9CqREcX2wUVD8FPNymTEdBsHhuIOk6IpE9P+Jp
	dU559l5AaqZDmPIFQAeaSIBDekt+N/BtPqehVMR7Wj63YuDB20GxOC4gE66rBFRZcprayYu24Ap
	6CHraKlOSuibZfmWJm0l0XJKc08Ymq2luTS0xVcyRFHcnw2WeyGLCP7+JITPHVa7szw8rUB4f4n
	EzlNWeAru6w/NYk07yQvJnznCnAF9vDP7N/WldcrXxbUml
X-Received: by 2002:a05:600c:458a:b0:48f:e518:d110 with SMTP id 5b1f17b1804b1-490c2614beemr300545925e9.32.1781020489356;
        Tue, 09 Jun 2026 08:54:49 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm545506645e9.11.2026.06.09.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:54:48 -0700 (PDT)
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
Subject: [PATCH v3 1/2] arm: dts: nuvoton: npcm7xx: Drop bogus FIU reg-names and clock-names
Date: Tue,  9 Jun 2026 18:54:36 +0300
Message-Id: <20260609155437.3285042-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609155437.3285042-1-tmaimon77@gmail.com>
References: <20260609155437.3285042-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NPCM7xx FIU controller nodes only describe the control
register block and reference a single unnamed clock. The
second "memory" name in reg-names is bogus because there is no
matching second reg entry, and the clock-names strings are
redundant because spi-npcm-fiu gets the sole clock with
devm_clk_get_enabled(dev, NULL) rather than a named lookup.

Drop both so the DTS matches the resources actually consumed by
the driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index ab3c3c5713ae..83cd10b47273 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -191,9 +191,8 @@ fiu0: spi@fb000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfb000000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI0>;
-			clock-names = "clk_spi0";
 			status = "disabled";
 		};
 
@@ -202,9 +201,8 @@ fiu3: spi@c0000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xc0000000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI3>;
-			clock-names = "clk_spi3";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi3_pins>;
 			status = "disabled";
@@ -215,9 +213,8 @@ fiux: spi@fb001000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0xfb001000 0x1000>;
-			reg-names = "control", "memory";
+			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPIX>;
-			clock-names = "clk_spix";
 			status = "disabled";
 		};
 
-- 
2.34.1

