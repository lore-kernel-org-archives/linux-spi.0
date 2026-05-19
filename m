Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B439F160
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171439; cv=none; b=PgxEXJUmiAkNk1CqzmRjyOvSLsmPkYw5v58APeKf92Vvy/kyPCtRKUO5Lgre9PEeiJzWurErFCKizDY/IBmWLj+qIvT4DytNgn1vrNj01fanGEvchoLpJBy3NfLPKHW/b23PSGbDk3zJyeHRlq9K8zAAZrq3AOOOEjB9/3byla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171439; c=relaxed/simple;
	bh=bU61JmNF1c+b4KWRcgOhA/JRURr6NwQdOpuIqG8oVJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qy5fi/zeKcV/8zpZiM1+LmYZvgDDDudNFGGdRVWcgoVJwVR22/MGftGA5edWjzgvn6qeiLRO145vhpDD7RgyIwDiVUVMz6KgRi/ByYyjtG0CCh9SXd/DFxWXB9yOlHr8uyLY0UideVIJqTQ3ZWH180jwo0OU98NYTJ6imn7om6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqyVZFJ4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqyVZFJ4"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1192724b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171438; x=1779776238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUJ15hFl2aQqTBGBClvDVjCEGpr2/Wz0MRwXGiLFc2Y=;
        b=MqyVZFJ4W7kSPLkm6dFTus5gc1ftpQTHOg1+BfGiqUbg44O+DAql4ECEx8dzoKll3h
         fUpaLb5k3F2SOoDzNeCd/po2z35NeSbwHHTTBsL9gZufPb+ENi9MxRYvWWlDxBjP1W8Y
         jaRTgG3h0PqkyxldpwHFH+uGOuPIUl6TsyTDTq02uWRXZx6Eq+SUudm+GV5QUU4GbCo3
         4zemHBfb7SjN2B32U89NYE8v4r5gu7oIEzYvrjmNm73Jy4qbvhVgFhmC8y3hdxImoiw0
         aN6NdEkxBEl6xKi9VU0f39fXy+dBh5uUXyLg6cnBA9wmsCV+u9nOjclBJkzad2jr98Yj
         QP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171438; x=1779776238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mUJ15hFl2aQqTBGBClvDVjCEGpr2/Wz0MRwXGiLFc2Y=;
        b=QyGsotNV5JJQSWYHmmiGJghIjZSPwD9MCZS1SYfZcMoNHNLDCcDqRzHCK6j0vzR6mE
         n+QDLBsTq3WTwsHWb3K+VLO5yTbEqTXGb9Af/j4ux17R/23uC5j48TCUVeWEShku6dQl
         w6eFZN9aUAVpiI5Exp/6+wNw1/PCZF2PpAaApi/Kh82gvEnZQjoqgemkf3RWYGy6il+O
         04f7rFhnjtQluWKi7WhRt74T4RDTJWTnmrt9o94ts3ug+Fkf5DfM7lvsibio8X31ARtK
         NY6N8Ec7IP0M5KAEsYuSawyxcpHZmlJJjGnZPkQ/4jwy7jgpVZkW/B4eD/hglA9/mDI7
         AB4A==
X-Gm-Message-State: AOJu0YwgifA7JSDyvQJkkHrkrBDzD48Ih5G9NAwvwm8vFmd+yJKTcL2B
	xezKdS69/z5/imzaaLTsCJz41EW5dOdw6YefNX4y/XCW7iTVRcfyR/m/wQdPx0iZUvc11g==
X-Gm-Gg: Acq92OE2s1VRHvbmr0aCZARU8UMZibyvJUfOXkRfyD+eGJp/gYsHKsb/z2tvRmV5OHo
	HBJMYCWEV2gkBWBzPdi5S4IyzKJ1OTsTyk9OWzLB4urjcPIW++MwmxFQO1TjPJWA16xR63g+Jmi
	WzQgFg7roxrc0aIfizzYHgjbn8/aVMc5e8c5rc1Jd9lPzLPlYpjDiXumyrsBhwYLS6Nm7qA7hT+
	NACskbEXdPnDX1hOJOG+CyDSOnyVFJeHpVSADJdchjR4zafHqk4Uar2lNDqvtbqWZEvoWT04alr
	GrkfS+/EMdGbI0oDCev9VDACZyvKCQAPMnnOSD9zHGTrNmGKq/EJgLg5srkKTHPGZzghIZG8vC7
	ux621ToWr+/kJGC1tDxcU0s25kTsJVr1O9/uCT25cEBUAJWhwxzDlx5RKK91LV+YqIJyUsAiIwV
	6BBPCDbjK9AwsMMDsgOldpon8zooxfyA==
X-Received: by 2002:a05:6a00:8c2:b0:835:a682:a6d7 with SMTP id d2e1a72fcca58-83f33bae2camr18840919b3a.4.1779171437826;
        Mon, 18 May 2026 23:17:17 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm16112266b3a.43.2026.05.18.23.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:17:17 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Date: Tue, 19 May 2026 14:15:57 +0800
Subject: [PATCH 3/3] riscv: dts: spacemit: add QSPI support for K3 Pico-ITX
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-k3-pico-itx-qspi-v1-v1-3-c32afeeaf741@gmail.com>
References: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
In-Reply-To: <20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Zhengyu He <hezhy472013@gmail.com>, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3723; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=bU61JmNF1c+b4KWRcgOhA/JRURr6NwQdOpuIqG8oVJ4=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDABauY3HTSzF9IaJjmTv1VlCI5XJKn47n09ne
 KmVVyHfeyaJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCagwAWgAKCRDN9pw2gLgN
 2LWxEACmEhpN3JONYcq7jJHX5BvuRUB0L5LCma+xBmD6vLDsejxKAsYsj4bSMJH7uS86Nu93PB6
 rvMXUOwBVqLAnumCrq+tNZFMJhMLQJaxVVf7bh8r6TJZvfbLmCzvl4MuZcBgVqAZqtqfdyBXLL0
 Re9uZbYv6ljHvmt52PZtbP9nj/ubdZ4CmauirDVhKchu9NZr+/ZEWiq5CdfRMhKriMBx6JYkQ5P
 A9tOrxhELRH+pHDWuSpCoMYayyZcFsuj1BbCziBG1/92yLzzjQNtKQFMTLehN3gEmZWBYKoBmBQ
 ja4bHaSYSs1YoLHgKy/G5KeCenUxE2PWEpVRfaWebd4c+tQQCOhx+M/xoRRob+KbS7sY5avYAEL
 Csv1PyAqYa6woB/tm9aaDBxGSR8a7a60q/C7KlYQPFVxF46s+SDr7u/6P76ZlW926hM1EC1WgLu
 4tibWXk8npcEO/rlfVF/QX9HcJn8grFS9ArAoL3C1XWGoIwTEWBsGbGRh64SHYK3pqIPrCG+tMz
 C64OjXm5meqKr3zVeQrAnqyaw4FFtzKdW1Fyi7OV0YXwEOyM+4AH7v4FO7Ij0FMqy7KlBy5+7+J
 YjiaP/FS40AjJTj86I8VSyEYguOroOdif5NVgdJMz6LnZ9Ic2liTq2jYy0AWZtR2jjrTzxuYpiR
 OV9Z1ET8NUMcOQQ==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

Describe the K3 QSPI controller and the pin configuration needed by
boards.

Enable the bus on Pico-ITX because the board wires QSPI to NOR flash
powered from the board 1.8 V QSPI rail.

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
---
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 58 ++++++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi | 21 ++++++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi         | 16 ++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
index 4486dc1fe114..61cbf924830b 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -192,6 +192,64 @@ phy0: phy@1 {
 	};
 };
 
+&pinctrl {
+	qspi-cfg {
+		qspi-pins {
+			power-source = <1800>;
+		};
+
+		qspi-cs0-pins {
+			power-source = <1800>;
+		};
+	};
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		vcc-supply = <&aldo2>; /* PMIC_VCC1V8_QSPI */
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootinfo@0 {
+				reg = <0x0 0x20000>;
+			};
+
+			fsbl@20000 {
+				reg = <0x20000 0x80000>;
+			};
+
+			env@a0000 {
+				reg = <0xa0000 0x10000>;
+			};
+
+			esos@b0000 {
+				reg = <0xb0000 0x100000>;
+			};
+
+			opensbi@1b0000 {
+				reg = <0x1b0000 0x60000>;
+			};
+
+			uboot@210000 {
+				reg = <0x210000 0x5f0000>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_0_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
index 23899d3f308a..5d9763791180 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -56,6 +56,27 @@ i2c8-pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	qspi_cfg: qspi-cfg {
+		qspi-pins {
+			pinmux = <K3_PADCONF(138, 0)>,	/* qspi dat0 */
+				 <K3_PADCONF(139, 0)>,	/* qspi dat1 */
+				 <K3_PADCONF(140, 0)>,	/* qspi dat2 */
+				 <K3_PADCONF(141, 0)>,	/* qspi dat3 */
+				 <K3_PADCONF(144, 0)>;	/* qspi clk */
+
+			bias-disable;
+			drive-strength = <25>;
+		};
+
+		qspi-cs0-pins {
+			pinmux = <K3_PADCONF(142, 0)>;	/* qspi cs0 */
+
+			bias-disable;
+			drive-strength = <25>;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart0_0_cfg: uart0-0-cfg {
 		uart0-0-pins {
diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index 815debd16409..800efc2929a4 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -836,6 +836,22 @@ pll: clock-controller@d4090000 {
 			#clock-cells = <1>;
 		};
 
+		qspi: spi@d420c000 {
+			compatible = "spacemit,k3-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0xd420c000 0x0 0x1000>,
+			      <0x0 0xb8000000 0x0 0xc00000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			clocks = <&syscon_apmu CLK_APMU_QSPI_BUS>,
+				 <&syscon_apmu CLK_APMU_QSPI>;
+			clock-names = "qspi_en", "qspi";
+			resets = <&syscon_apmu RESET_APMU_QSPI>,
+				 <&syscon_apmu RESET_APMU_QSPI_BUS>;
+			interrupts = <117 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		syscon_apmu: system-controller@d4282800 {
 			compatible = "spacemit,k3-syscon-apmu";
 			reg = <0x0 0xd4282800 0x0 0x400>;

-- 
2.53.0

