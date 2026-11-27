Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792944;
	b=2ZI5UwQlwzeRCn1g6D5Cy8+s31M68gSLt1m6X+hUDBn7ltYKEXtDtTZ5Yvtb2eyb6tTX
	 JyPIztlWVjpleGoOGsxs0ZbcagizxMAbvzam9q9fEEp0279iLGEMcdu+87r81GLh4C+tJ
	 sBiyuNZ85xXbQR6eU5HamG4uBfwWkEw4aPHAaVUSaQj6YRbG+kECcVvEg6h8zbOjn14Se
	 Aa1RbAJag5JZGL8sFI092szloDgT+IHA4UYnMIEjU6PQPwF4sdPMp3tascEA9CsTopKro
	 K4U2LrMcVNqA51hHw6C/2L5sy8FSewIfxy5QgC62kEzXTuQMiyWRMt0Z2zmjZ0gOlVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792944;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fW3fLuV6AYBNo+1+NsPV3NuNvPOuvM4541C3Z2tQ3FE=;
	b=pDSKXvnKh7xzYmIxzGfbscFrltoczCbtqh1WFlLApQcLcipfUfw9JNh7+VO+KXGvrF7t
	 ZE5By4iGZG13Wi1+g1NdkVqTZ1fpMDm6zrRd8zzENhIAfg1ZZ6QKtG4hYujvhj7M5EIj6
	 5yFqEot7WQ9DqYMUDggn1QAejSqh8TNms7dDwgyWzv+Y0Q5/zvYitZJshGaDe1AD3RCFc
	 tzmyAdigYqUoOBuLkZRe5gQPvLwKKHERZlmjOQi9kv6Fx8/fX3jTflNrG2Cuj+eg6dSfg
	 byIlsW0ENa/cA07dH4pLmpD8zxXJPSup3uMrJLLYIUmoaQCdlDiG/wS9N117oilCdTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jgn2YCCi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EB606A31C;
	Fri, 27 Nov 2026 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jgn2YCCi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795792943;
	b=oA23ru9VpMGwJeHgQTgGh14BLwexGbHp04fqbCiAI95dyb0tj8/Hp+Lj7jx+pPrZATR8
	 lQidwj2zaGR5mnhRq5jlncvMGxR1vBfWbUkpWGe4V2SSWMgr5dAk0a9XyNDr//aK2qOnA
	 wNt1HjZJU+HjP81visbEn66vw8WTjzPLdoEE9hoYYTgbNPLShKmTjxjJ6FzFsAlPBgiGW
	 AqvrZs2TZt7kEAKoX71bhcCemMQoQjXWZh/hCzwxSTFcV47UaJ+jhO7iDyHMU60WKehT0
	 xltYZsOxlscZLMKs5RUQ/Yx2+FIUEZcjLLHMB17qzFQZcISO+Ke+1KcAfEcsw+lN/Dw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792943;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fW3fLuV6AYBNo+1+NsPV3NuNvPOuvM4541C3Z2tQ3FE=;
	b=uqkqp9zTvvdD/KCXdZrXqUpIJcZj1NxC0uu8Hm9RwRVYXlQl3TNtYnO5VZFPOd470bn2
	 noQYp9V48w5lTlchJbboNn1ovhJx61HL3N0OY12PV+QPDR1GEHJ1wKPAkSD3rh6ZGE4xq
	 BeVxEfPXSA3p6s3MeBHE/ZTakFIc4hwFBptnVM1sgiyi44IbkuBsYr02thvcu4GpTYuo6
	 E5dBVQTPINJAoecocoEX6harMxfsDo8F2M/7JYJ4tPX5VUCGEB3EWW7PHs23I5pclL236
	 gQBkF/8pcZ0d7d+DDJksDAdoZ7XjHEMkwTQP/IMY9NVUL1TEJvBREIFW5hmlDwHYsCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 212541F00898;
	Fri, 27 Nov 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792943;
	bh=fW3fLuV6AYBNo+1+NsPV3NuNvPOuvM4541C3Z2tQ3FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jgn2YCCiuvRvk7hWoKQ1tb0DVpg3GbCNKOkJhrMfl5RN6GrQiPu9EAmfjm2eVBxBk
	 gq3Fysq1USeqyM8DQnc0DcFS8fLkUURh0ML6HNEhMnyYgrIj9DEsAKnOzE9frTyFRo
	 ftQ496aGGl5mr59f9e+BQ2CpM5Fw9GI4RbzQFYupZasCE1q+TghD8w/kvgsK/7nooc
	 MIqWXCvyjq2nqOV9LcsyG6/bhUePnNnYLGd5EbPYteabXgaJvlhciWVCD3RomK+iQT
	 IrT24azqk7S9EYVDG9YDL4UnTwlVHfHegZ5Ko/fBrkprRvFNEW7jVYgA609B54UIZK
	 wFdAzOZ2ryL0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A263D4D853;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:21:09 +0100
Subject: [PATCH 4/4] ARM: dts: broadcom: bcm2711: Add DMA to sdhost
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
Message-Id: <20261127-bcm2835-spi-dma-v1-4-8b134991ba2e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795792928; l=1245;
 i=cleverline1mc@gmail.com; s=20261121; h=from:subject:message-id;
 bh=/3A1iVIGEOw8HTcWNipf4TWXImmbOVBsqjUojsiUWt4=;
 b=VCfdHD94pBgq/9ZwoeVithEmUptRa44rd0G0LBgq5ZCYGee/qKBnsr7Q5Dnues8r6YQKBlxjj
 cXOmfx7dOBlDojaQA6Cz4l1rfPKOkeQM0VWyJuqBez2grlZjLIv0At8
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=2UEUVmQyfsiFZkNS7dkgFg0rUmhbcMIytM6NYhxFt/Y=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20261121 with
 auth_id=1594
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

On BCM2835/6/7, sdhost gets its DMA channel from bcm2835-common.dtsi.
Commit 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
added the BCM2711 DMA controller but gave sdhost no channel, so a
BCM2711 board that enables sdhost runs it in PIO mode:

  sdhost-bcm2835 fe202000.mmc: unable to initialise DMA channel. Falling back to PIO

Add the same dmas as on BCM2835/6/7; the BCM2711 legacy DMA engine uses
the same DREQ number.

Tested on a Raspberry Pi 4 B: the driver gets its channel and reports
"DMA enabled". Nothing on that board is wired to the sdhost pins, so
transfers are untested.

Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index 0680a0b1ca67..e18f11fb7f00 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -1155,6 +1155,8 @@ &sdhci {
 
 &sdhost {
 	interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&dma 13>;
+	dma-names = "rx-tx";
 };
 
 &spi {

-- 
2.47.3


