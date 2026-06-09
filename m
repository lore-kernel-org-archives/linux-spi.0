Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77A42EEBF
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023174; cv=none; b=UGRbrklcrEuivmxRctpe1Eelyf9bfVYLKjjArlG2NuEGHefxwedOPsC3PA35y36iDPxIkrfDM+NvcDb+TiCNH4MTjO8Kxb9BcfPPsP52svLYfW8yFo2DiYfasXNAHDDT+hJ8qxCBns0gB2hX3zCKqn4QKIK3TSxioRMJD9KCUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023174; c=relaxed/simple;
	bh=OpliSXEf6ClkOWJWl4do4W3JZ06bMKfHQs73OZhh8FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ug0vJpDSQOM1EnJXmSz8tdY5844k6GZeiYWwQgCu/ZH4ztCEzilRipkKWyZ4OwMRQUvR5KcpOVoY4W0VlwtMGzQEv+nqYoFTlNRCkB295LgUPvQ6wOA/qrh/NYIDMnx822+kspJ8dIuKO2Ka/1ogkjARYh14rVHlsvnMtzBfeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgytfFbC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgytfFbC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso49421085e9.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023172; x=1781627972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhKTkY+fAoMNRjsm960hiVmd8n0Q73fNbvw+JMhEZdQ=;
        b=EgytfFbCnEv9XryQVJSDIOIjIk6oqPM008xNWv+nFie+pqwDIVyuc80qUIL8epHqMb
         ygjTZ724cZ1loJTemyjM9AH0mpkkFJxU2eFHuXmxWdG4b6IUUpNXAoGgFgbZchFk3FGy
         8hzuJync20O2rhIKOh6vEcxxfhzGkl63u2s6mgthatUrSpgXPT7T1cXilZfI4M0hneoX
         nqwHxdkSZKo4QPpBGzHamOWYa7ipmJDyC+TZlaSJ11BZ5iordKG5WuMORAdTfN1bwUAu
         kszrfKufDBS0KU6Qb1xXtwsZ6l/SnAfzguYuQwYXhm9yNewZhon10q89J9NOtBGsyXYW
         q/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023172; x=1781627972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhKTkY+fAoMNRjsm960hiVmd8n0Q73fNbvw+JMhEZdQ=;
        b=oWHwQ8DeIYfhZF+jhesSNa9XsPS/s9HbYFd68FpcQtzAsDyMGTxNp4uaWWYTxH/Npl
         Yr6aaEv7xH0qM2ycPwqy27XyYbRQqXU8DFm8jT8EHce2XDOP2oDqLdh7Gx+XmZTW5ff4
         e3zkQ4VmNnu/s439rpCJ5aiwZJkBlyHFLRrlnGZpWsk+tAn+Oi+rJ+T6hTW7ave3I24L
         Zp7MXA1JzzB6kksRUrzbU7Z9VfIc654T3tIDCFmWptws6qbwGxcnzbqTfoy50cOKiLZn
         R/TFUUKCOzbumWk0ZJNl3wfa2kFajZ2PV53vfgX+uNdV17kle8mFlPxXOXshQrZjLt2B
         Y00Q==
X-Forwarded-Encrypted: i=1; AFNElJ/FQByREfz5s3Qdc89wB3JC/n55yeHOOHmiMPHlTUhJm7hmNgu7FWugLWlfO5SCSd0GJvs9HeezP1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61n1i+GASEEH8hcpxksjG39RSsvE49+59EjGsd5RmE8jPxYdE
	Ozv0avu2ujFWxZxwRd7TCANLCb3qg/Tz7/zq+WiySdxgCkTxFLcHde5i
X-Gm-Gg: Acq92OHag1IiGO2UW3hUKF5SCH9ztORjAWGkwSdcLH1h8ZlvQek50MwOXOY82rQH3Uy
	WIzMhIlI2vzFcQ4hpMG/4sUEqIgU8GKxtY5AmPtcSvVIEW/9LvQxCysXpI1NxW539F0fYD2Gs1A
	LOsPnXc/BNiR01nup9W6wO8kVPzEeVxwp6d63W1KCWF4JHUMJAW9UTZLumv8um9QMWr6KN+pdeq
	Hr45Ux0yHlnIMaZ+796aYfmOto/GKzu6Vswi51dUrut+q4Vy1GLpXfpBY+CNF6lxQ37OU59YecZ
	TDffDvlHncIpxrskeuVEFhUiSVMg9eok6vr5uHMi8FG14KEP/6V0/JQm2wy9hc+7SknWavL+ReJ
	mlrGQ0+PBaAu7rqryU2XN2pyYOTpGu7rfrQkM/QWf9gLvlMPXjjml5GC4kmBcD0CuLDmcCGTS8j
	ZruEqUmwRcagF/DJiNaOL8E0AYcnS1CTV0O5fw1+k5R4hm
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-490c2616e16mr347140765e9.28.1781023171627;
        Tue, 09 Jun 2026 09:39:31 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm440860805e9.1.2026.06.09.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:39:30 -0700 (PDT)
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
Subject: [PATCH v4 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
Date: Tue,  9 Jun 2026 19:39:18 +0300
Message-Id: <20260609163919.3321228-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163919.3321228-1-tmaimon77@gmail.com>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NPCM7xx FIU controller driver gets its single clock with
devm_clk_get_enabled(dev, NULL) and does not perform a named
clock lookup. Drop the redundant clock-names properties from the
FIU controller nodes so the DTS describes only the resources the
driver actually uses.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index a16450abea0e..83cd10b47273 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -193,7 +193,6 @@ fiu0: spi@fb000000 {
 			reg = <0xfb000000 0x1000>;
 			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI0>;
-			clock-names = "clk_spi0";
 			status = "disabled";
 		};
 
@@ -204,7 +203,6 @@ fiu3: spi@c0000000 {
 			reg = <0xc0000000 0x1000>;
 			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPI3>;
-			clock-names = "clk_spi3";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi3_pins>;
 			status = "disabled";
@@ -217,7 +215,6 @@ fiux: spi@fb001000 {
 			reg = <0xfb001000 0x1000>;
 			reg-names = "control";
 			clocks = <&clk NPCM7XX_CLK_SPIX>;
-			clock-names = "clk_spix";
 			status = "disabled";
 		};
 
-- 
2.34.1

