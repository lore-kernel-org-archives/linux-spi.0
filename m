Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460D48C8A6;
	Wed, 21 Jan 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015122; cv=none; b=BAZp04avYJOZDTtzlo401uSak3eKjBbREn7iyLogJaOoYvycH/91WcDVkUhuNghk7zeLj3kdqxFkgWXh4VrKOb8QfvxxBgF77xIUtJ6AMVZxL+6HFE7M4Lb1fPiyaO2GItn2kan6M3L0m5r2KyfK6FprwvCF3HhC5ifzdPDJ3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015122; c=relaxed/simple;
	bh=JWhcKkvU8yD+gzDYy910G6kF2d2VDDoSVPZaBn7jQ+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mX6KvvciDXOVroNfJ0Yu9zZYKH0xurIav5xwithAOQ/DxSu8MQ712kZKchcJa98mjr21is0QNZ6xHPqOi7QD5tGXXJsKga+ZiisLhHVeNPlS6GBDYZVBOO/J4BrIUAgZ3mtJpTnhtnyM8P28mg9LcPNaz+sBkU3Mqz2c1IDjhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DjKrTtP5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DjKrTtP5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A7E57C21A8F;
	Wed, 21 Jan 2026 17:04:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCE0C6070A;
	Wed, 21 Jan 2026 17:05:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95EDF119B1746;
	Wed, 21 Jan 2026 18:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=x2AlFWyc4Ip33zPaUlGPLmdBouK0MOvwiZBD25BSZIg=;
	b=DjKrTtP5crl1p8AAZ0noKrnf+YJi0CG+AoB1aY7R21kMddxR3QD9V5bIiK8Oz7pRoUNsoY
	3crNIkY/7UTrrEbsaaQ2FX7llN0dDAr88q9qBCPQzgxzcTEDylurK8mFd/JB68EC2NISQ7
	bDOo+tbpM1FfAGFSLQw8gv/QSOQjTuByaxh5ljr8I6oW6HDqQ6pnEHSh0Qu9WoN7OSFCVR
	KT4P3IJdPd3RqzH6iN6vIBP9RskKrlCZik8xG/Hwv94JsP7GJoYm2NhT+YZ6iVWjfJfmC2
	qY7Mefi+yJj8BXNwl8HLNK9cl3WMmmzR7Tna//O1zYSsoHgjIe+QGvXJ+amOIQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:04:59 +0100
Subject: [PATCH v3 03/17] spi: dt-bindings: cdns,qspi-nor: Add examples for
 testing the specific cases
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-3-43e70fab4444@bootlin.com>
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
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

It is very painful to modify this file because the core IP described is
so common, it has been implemented in many SoCs from different
architectures. Both `dtbs_check` and `dt_binding_check` are rather long
commands, even when restricted to a single schema files, and letting
this file evolve without risking to break other DTSs is painful, because
there are arm, arm64 and riscv platforms impacted and no way to check
all of them at the same time.

Instead, we can identify the few specific cases which may need extra
testing, and fill the examples section to cover them all.

Add examples to cover the Starfive (resets) and Pensando (fifo-depth)
cases.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 123caef8f61e..62b97ab607f3 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -189,3 +189,38 @@ examples:
             cdns,tslch-ns = <60>;
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    spi@13010000 {
+        compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
+        reg = <0x13010000 0x10000>, <0x21000000 0x400000>;
+        interrupts = <25>;
+        clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>, <&syscrg JH7110_SYSCLK_QSPI_AHB>,
+                 <&syscrg JH7110_SYSCLK_QSPI_APB>;
+        clock-names = "ref", "ahb", "apb";
+        resets = <&syscrg JH7110_SYSRST_QSPI_APB>, <&syscrg JH7110_SYSRST_QSPI_AHB>,
+                 <&syscrg JH7110_SYSRST_QSPI_REF>;
+        reset-names = "qspi", "qspi-ocp", "rstc_ref";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cdns,fifo-depth = <256>;
+        cdns,fifo-width = <4>;
+        cdns,trigger-address = <0x0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi@2400 {
+        compatible = "amd,pensando-elba-qspi", "cdns,qspi-nor";
+        reg = <0x2400 0x400>, <0x7fff0000 0x1000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&flash_clk>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cdns,fifo-depth = <1024>;
+        cdns,fifo-width = <4>;
+        cdns,trigger-address = <0x7fff0000>;
+    };

-- 
2.51.1

