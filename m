Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C042BEBE
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299612; cv=none; b=VHgTbElsdjJhz6PDB/ou6IAbVccydgRkjkuArQErFH71dRp9QjPH0FTDQtNGTOpmLSnDpjUMO469YuGdPISO7XntoHyXlyKxfs/25HcMXDUZsoGaKtHOcegQTV8go11urU0U8lrsxjeGbwxUvOJ630K5RyN6J9eNCfwlDtN0E8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299612; c=relaxed/simple;
	bh=zySto7zgwUmAkuL3GnzDZtEv31hl9Eyy1aWzZqxzc28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAs7OSL/1wzugJJuo5aNBCUm28S/UUj5SgCU01m+hgmdAsRmiTSux17SaNoj/xKg2h4Kbn4FHG6QRcvwPQfkiRRR6X5rx6cENjmXxuFZrSKcivgKdhyr7vosjWbF6XLQhwEUbz9Zxl2IphtwlhPOKtMqrTNtYtV5nEpO+OO9O3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxim0loD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxim0loD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84847482584so1416590b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299610; x=1784904410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4iqhlVy0zinCT6tWxaIfEaHrxRoNo3m1mEkW0uTKFU=;
        b=gxim0loDmDJDbzz/BhSPLXalVpVlGhU+WHkAg+/Ey6uV9qRTWQPcROHzSK6DxRxIf+
         oBP6k26PWvu3aWqMtaWemqAA4O5z3pDKF99+PCAiJIDMJtHkuZx7wO6+OFO41wrVa48/
         FRVSxjQR1nh7EjxrYRN1wmbzod5t1AOgMLw9cmpEsrb7QBZcmSaPNRLed2Uk+1tvZ5Ai
         SbECiROaa45juhTAAN0P5F1dUhGGOuSt13AuFNz1G+rm+QCvga5cM+K1nKjX3eDNvXam
         nGS7xlD/5EGSutlscmxD5Uk+x2MVR6C2qwrwrRu4icI5iqv+rPYFG60IKo0+A0hpJ62a
         FgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299610; x=1784904410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4iqhlVy0zinCT6tWxaIfEaHrxRoNo3m1mEkW0uTKFU=;
        b=SEAyAF/Q/4TU2Z56tXtfQlSj5SUl2Im0Wm3cr8GWEX8AbSL1GYzF23P/+PpOBLGa3V
         hsOzcDU+wYRFp5XaDMBCoGqOrXEKWO7D9k0abSoQeYeAu7KoX5+llVuSpqcAGND53qFI
         7QFGCVIvzW5yeSTMH/Mfh9cRd6SI5YnEUgGzMSgT+MNYTPB3Am9rJRd16/Z/TSjzEYVz
         kCGd6fpPnUMLgSBEaOLBl8GerSTShr2hXXCWgIhOkIn9zQnWkc3VHLV4lhVnJ2zTBH1J
         VwZPN+8EbPQ0s4MNMKD6LhAynABgQR9M4pBBEbhRDsbdLu7e5PyvLV9/rUP4+RzP+rLn
         k79w==
X-Forwarded-Encrypted: i=1; AHgh+RrPxUMI+Nr/RyJf22KOhKpkyx6cb3PHzrcazIQTUMarSxizsFN48IEC+pA08SHjURIawdZr0L618Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8RSnGc8sK85EFomnAZ9o2vvVqNjmyET9dhk7S2yldnMovV/2
	ZdpkV0WkNkIqAWjHgKpkCagFPE7TwsPx33VdefmUaGQto8YFEFfF0XFZ
X-Gm-Gg: AfdE7cnoyCmccUm6c6En5eyn5wP1iH5JfSbUmT39NhFO8B3WxPnxdZ496xOSGvy/sKy
	2Zz2h8MjX+YKg91ZyFieDRq2m4ldF9/vbEGHQgd/w8aWo5kprPJIG2yeypATBXu/hMq2kbKN2rv
	bW3NHXwnl/XepXrrN20vN/QNgBIrg1F9bsw4/fSMFzCVz2K1tcawHmOKw3VVnSXUIuQTgQFMZ4H
	UZAR9XTFbRT2IqiR0hvFjkhJFBTcqGC9CZYRPRzjuIVOAaHUokc/01k4bV0fqKtdN9eAniPLs5S
	cGrgzJ5tQs9eQ1LEGF6QEy718Te0JdKEdUl8T8BC/n9bio2p3JxvYeSSJozbjovhkQn+nHOTaBK
	F6GYCiUZWD25fqS0ubhCqq5LSSYTt/xfY7qQdqyAn6kPxnBXlL9A402LH7Kyt+QCYBWEkYUNLNR
	rELg==
X-Received: by 2002:a05:6a00:1915:b0:842:4982:82f with SMTP id d2e1a72fcca58-84c28544a68mr3002230b3a.2.1784299610233;
        Fri, 17 Jul 2026 07:46:50 -0700 (PDT)
Received: from [127.0.1.1] ([192.220.14.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6d519sm1166408b3a.40.2026.07.17.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:49 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Date: Fri, 17 Jul 2026 07:45:28 -0700
Subject: [PATCH 4/4] riscv: dts: spacemit: enable SPI0 on K3 CoM260-IFX
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-4-969a1b0f783f@gmail.com>
References: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
In-Reply-To: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Alex Elder <elder@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Zhengyu He <hezhy472013@gmail.com>, 
 wefu@redhat.com, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=zySto7zgwUmAkuL3GnzDZtEv31hl9Eyy1aWzZqxzc28=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqWkA2RyBpFeLk6C50dYyM3otQZs8eLWGMcaVLS
 TzgiIsbV++JAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCalpANgAKCRDN9pw2gLgN
 2JA1D/0U07T9IWK44EpFEGxgmNNcLauxIxXRQDji7kkGmtw00Mrhd3m7oejDYO4T791hp0aJ2Kv
 J2HWV6FZ3dYK4PwyKMkf1K+hbczfdbuRnJLLGXQ6Yobc6zqchOCc6UBGpf1G1SCUiXwExI7CLJK
 bYzmu1L0703CMw9yBW+zO8jGzJvgTjow74li40wpWF1ytGx5olGNLudSRPPcuAXzlFmflztO7IR
 qebXLMSXPnrGyuvP9pkoiU+ho6l8KCqZxHFeScvISY+aKyd7I656GFXbb8tYBY8YkBqdBrr/IFx
 H1JV5+PU14gtXSWbXk72Ew8Mgv2lel9QhclPYsYCJjLpfGSqRPAIIhwMO1gmWnNws+O8/ivurj/
 gHG0xE5bvkfkm3NR7/uUXKHZZu4wxHpb/gtaE04JlLDpJmhqJ8BJ2p4t2Dsjsku/PwD7pknQaPq
 69wj9CpyqefvGXMD3UiywmVfFJYfI551YK1VHIpEH+dTcAvUwYd9iqb3333TOgQxqvdQC3cPfyP
 6UnAJgoxTG+XfrGK7LbX87GmKVW3jjASB0p/EvN4Aj/H7m+4LFG62czoRVFdDrAAv3VdXWYBg6U
 XIbrvWcahUgR7F3U+0xVJsLqjh7hAuDR0HrUPYqOk1HMvWCDu9IRPbe/OxPEpKU2yJ1xiYOU2zw
 JcmkMEaVPd5sWBw==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

SPI0 is the first enabled PDMA consumer on CoM260-IFX, so enable the
PDMA controller together with SPI0.

The board exposes SPI0 on its 40-pin header:

  pin 19: MOSI
  pin 21: MISO
  pin 23: SCLK
  pin 24: CS0

Define the pinctrl state used by this header wiring, and describe the SPI
NOR on chip select 0 for the current validation setup.

(This was tested using a Winbond W25Q64JV SPI NOR chip.)

Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts | 13 ++++++++++++-
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi   | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts b/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
index 238bb03d0e9e..01a7135df864 100644
--- a/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
@@ -11,11 +11,22 @@ / {
 	compatible = "spacemit,k3-com260-ifx", "spacemit,k3-com260", "spacemit,k3";
 
 	aliases {
-		serial0 = &uart0;
 		ethernet0 = &eth1;
+		serial0 = &uart0;
+		spi0 = &spi0;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&pdma {
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssp0_2_cfg>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
index 3ee1471f3798..9b7617f3846c 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -679,6 +679,27 @@ pwm19-2-pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	ssp0_2_cfg: ssp0-2-cfg {
+		ssp0-0-pins {
+			pinmux = <K3_PADCONF(104, 1)>,  /* ssp0 tx */
+				 <K3_PADCONF(105, 1)>,  /* ssp0 rx */
+				 <K3_PADCONF(106, 1)>;  /* ssp0 clk */
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+
+		ssp0-1-pins {
+			pinmux = <K3_PADCONF(107, 1)>;  /* ssp0 frm */
+
+			bias-pull-up = <0>;
+			drive-strength = <25>;
+			power-source = <1800>;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart0_0_cfg: uart0-0-cfg {
 		uart0-0-pins {

-- 
2.53.0

