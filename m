Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792938;
	b=CnII0RH6NgLSfTyoMy1loRUyvO6bXfhwL0r3aMRtvTB3cDoySLowyEJkH+HE6J0vNWyR
	 IYCG63CixMmcGa8ekrMCsCEZQJs1Qjm0AXdk4nAjToie2fTRWmmW1v79b6x47YJtOc9aw
	 1fK0yUZC56NDTREcWlBUVqMSXbAmZ6i0UGMGrCK0sy7P9WaT62IyR2KO5xGlNxLviLmn2
	 DCM1EEnaU/YPpzAt3ru8hvQH+eOouyjmaLu05GfUNK8j1gbRSpXFdsnAQ/KoygImhxu6l
	 3MPV1QutpfewhGNL3gzX+l6inF0W4cRhyqt4mNTgN9TGD3WkmPL86fdFs0CNk2pFGPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792938;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NoVu7Qr7mpzCqXJ/0i2lPIF/ZqVSTtvTa2MvTuyMJDE=;
	b=hP2P7a1kLlCJqcqke7r0+bv42xjp6BIjl6pXXIfK6TwGm1MJ9WFK+WdxG8AjNMQNRNoz
	 QyoR2/h+Lon88ss5PrhV6vltspgLJrvMjavlhylyFzBzjZoGgXHuqb9VMCyLT4alQDwtf
	 +6BJwWn30qICDYq/17SLdt7Z/M1xgvS8baIjgjqbqEcGR3L0vtNC3BL73EhZNbVVb35pS
	 rCeKHbmcOUcXHpd8w8cLXs2t/XCujZiiecojMC76gs1fPmiJg5b+pdXCwYrccNJCk5G32
	 8uoLwaYsbv8b0vtUxY1Ujfr0S4Yk3t05Sg5Cv8leYOj8P9FgDkZ/y+fEyWUNM4a83kA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqYhe9QF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76021606A33C;
	Fri, 27 Nov 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqYhe9QF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795792937;
	b=ODodhJijAeFfkfnZO4CyjLmxRuUEHmLg9BrECuGDXB0iy5ACF74TnF7U/tQCH+0Efdhq
	 psBZHsBFcdYgVQdKrl6wpV+loOl1FLXr0HsdbJ2jhWAwx5k0LcSNoinCfUVQaMnagcR4C
	 5tkYkH99e0IhVVv5ZJGgjrenTXkPq5QUH++oiKfTgq0FU3fOy9Pfus8LCWQIF4bdtxuoB
	 Z26+lrPQei0o06Xx4UTvvVmXSqanfGjXpEtbJ4dkvheOorwvw9l/r93wVMFpQgmBnd+Pq
	 V/q8bMsZpaX96894bKLktu3idRXSiX3rHBqsqLPXowl+VhlAK3FnphBX+iSEBTXz2pQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792937;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NoVu7Qr7mpzCqXJ/0i2lPIF/ZqVSTtvTa2MvTuyMJDE=;
	b=jBy1Tmd2nVlNvex6aw4tVYS3yjMemzT4Z94N1UlSrwbcUkEf/s8h+xbj2soe1BMiG7bG
	 QrSc4sjG1ur35sfy4S8OeEGYIHbTTFGYIahTXv3e+rSwts5GfdR2sEgHUzbno1dsC8vh5
	 F+qpKidj0SO3q0/GmLyJKQzUJw+uIG1wTWrkfSToosH4JEYOBvCTvZEprJev2Yyb4Rdew
	 PHQxJ3UUCUTcSdgr35cg9ZRZh9O+sNiuEsyoa+8TEiGUiwf/3UsOkrgATEf96CuNiO3+b
	 Q1gPEaUg3v6wZY16XWAsI3nqy0NOFRHv3nZYXZowX9leiZMNgDpSpGXWAiQ+uye9LcA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9EBE81F0089C;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792937;
	bh=NoVu7Qr7mpzCqXJ/0i2lPIF/ZqVSTtvTa2MvTuyMJDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SqYhe9QFHV32lgdHyh48a5j7EFuLWkFx65xfiKMnUX9geBpHRhz3LfB+8eO8qp35g
	 D7+hpfSMQBX7N2TrEwFGmhu3sEKqTyouBUnKppsTFpAIygFWd9nSauDFWmElSfTRD9
	 2FuVfvVjlIh1A0rbw3/j97tEwTGlehukwL5ccGA02YKghTqDGrh89hf0STuRX0/9cI
	 QzzIB4IRtzc7waYqNPbZP5/TObk/oKmrE+hoKc4YzQTctJaPZ/MC8ISuJnijfqzOPH
	 msFk0Fr7EPq6KGIvAwYqDRam6VKkPG/bAEYOr0C4A6EeEV4bL3AUQQs7p5duzDdhDp
	 kdXyq91CnLnNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2FBEF4B85E;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:21:06 +0100
Subject: [PATCH 1/4] spi: dt-bindings: brcm,bcm2835-spi: Add dmas and
 dma-names
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-bcm2835-spi-dma-v1-1-8b134991ba2e@gmail.com>
References: <20261127-bcm2835-spi-dma-v1-0-8b134991ba2e@gmail.com>
In-Reply-To: <20261127-bcm2835-spi-dma-v1-0-8b134991ba2e@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
 Kanak Shilledar <kanakshilledar111@protonmail.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Florian Fanelli <f.fainelli@gmail.com>, 
 Eric Anholt <eric@anholt.net>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Miroslav Ondra <ondra@faster.cz>, 
 =?utf-8?q?Matou=C5=A1_H=C3=BDbl?= <hyblmatous@gmail.com>, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795792928; l=1665;
 i=cleverline1mc@gmail.com; s=20261121; h=from:subject:message-id;
 bh=qVwzj9YtYL53uYDnPyCdzi1pxK78x9hB7h8+EBasjyc=;
 b=W5YThTyWtWNBznWDQ5RjgWHC76GiJzR/P/5D9VGh5DK5IchJJ57bcKp0bmIjCOj6VEYZ+0oVo
 hyr9v1AtyrsC9+0Ean6h/ASIx469R27KQ8kzrpg80JfyYatwJVM7W8e
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=2UEUVmQyfsiFZkNS7dkgFg0rUmhbcMIytM6NYhxFt/Y=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20261121 with
 auth_id=1594
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

The driver requests optional "tx" and "rx" DMA channels, and
bcm2835-common.dtsi has set them on the SPI node since commit
cbbe88333062 ("ARM: bcm283x: Enable DMA support for SPI controller"),
but the schema from the conversion to dtschema does not allow them.
dtbs_check is silent only because no in-tree board enables the node;
with spi0 enabled on a BCM2837 board it reports:

  spi@7e204000 (brcm,bcm2835-spi): Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)

Document both properties.

Fixes: 85ce0dc28ffd ("spi: dt-bindings: brcm,bcm2835-spi: convert to dtschema")
Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
index 94da68792194..8d2919ce6096 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
@@ -30,6 +30,16 @@ properties:
   clocks:
     maxItems: 1
 
+  dmas:
+    items:
+      - description: TX DMA channel
+      - description: RX DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - reg
@@ -45,6 +55,8 @@ examples:
         reg = <0x7e204000 0x1000>;
         interrupts = <2 22>;
         clocks = <&clk_spi>;
+        dmas = <&dma 6>, <&dma 7>;
+        dma-names = "tx", "rx";
         #address-cells = <1>;
         #size-cells = <0>;
     };

-- 
2.47.3


