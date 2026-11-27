Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792941;
	b=Uv/uMrFhYFLWogoIDpfQRr5mHjA7FYjdQS4DKmg1fNqViRWPwfeLCfL0vzKOwhtL99yy
	 Cik53O9Nr0R5v1jZMOMr72ZduEaSq//tbWIlR+iGrvaYfxHm47VFfiLoryQpqeB1s57AU
	 +RQLLD3MKrJsGCscodesaFvIs08EtHNBd3c9perhBaYcpkOPsfAIXsy7Ni5dDlI07yjDT
	 l8xrKjJEq2vUC9oxHqD2RCv6Y9Q1QEsQV3cYwJjfxz6e0+ULsU9YaoypE/ggWAjoj8oV9
	 u4KVT/ZcF3Mp7vmGZofleYPonGBPzirwWs9qtAYyxDYzgXiYdPZluZa9ogPMjo9aSmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792941;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nWJjryyVtq+FaAzNI3kGk19OnO62EvakdwcVei4FTaM=;
	b=4lRHGVm7ghvo4oAFn+ygTObCSxkUR1B/csUJs+mmREmFQbZiipDKE53bLxzOsInd0KVr
	 N+RR+IpDybTYKBYgPiv2Mc81IGKE5kjQVDepqna9SH4zSkk/LdAcdNBVcu7L8BXKv7c6J
	 LMUxRROeIZoWyoOI7/JOBSJqMRJfngspnrqVgRvl5rJpc5oiRYnzqvsmkmFpTi+YOYo8G
	 AKfb4qdiEveLNivK/6sxgsteT2EOssGUK9YjWQOBj6WW0nSyjL4KnkB08VFY50/793VyI
	 KVWHtuXeNhr4FBQK9s4+T3clbvBnxDDoBvO07ulPhgeRxf98HwqwYOGRZvbrK+N+WjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2cFOwQi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEE606A31C;
	Fri, 27 Nov 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2cFOwQi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795792941;
	b=LNf4uxceEpr4kBBg+4UA+nxRXa/b2N8sovS+Dw/cc/cHUgGwawmBusKDfqy9v30M7vON
	 PT9ebkJP9kc5atvbFcBgfluD4NbomveiHEzmrQhgHmnmUjo+PnIh0jTQ58AkF16Vfgidr
	 GaW+RXgDstpvWF+nDL2UhtkEJ8Z/gpIC3UseeBAc4k8YH0+xb+M3dx8Y8c1WwpiC7NVv6
	 qWo0l3L0Z+lIxf3CisGsqy1HGO0jf8baqbv14iZ8nTjOKs1Nfdhj7lqaO0sWfVlP54JKg
	 qUGdJ4cDrV516Rgi+07xUojZZ12ig1mq8ohFbg68vGdFwzGhPyT7Qha9Gi/mD7ikDPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792941;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nWJjryyVtq+FaAzNI3kGk19OnO62EvakdwcVei4FTaM=;
	b=VCIRm1x0F6L6VUXiBT1s21083osuZJIxnLn96gOw5AxGYczgBMwqFJhl5zRqwA3vG+2i
	 fbOilbjivoRQIueWvuPtJ6tciovGrZackiaWiWJUSO9dV1Af0fdcoJCI26mheS3rsuTeZ
	 hiEgdTDKYmwMx3fmzdpr0pQKRhfUxIBVqgtP5nczZK7vof8YRbmVm8MTNLETi8e7VQwUb
	 Tcpa/V+PCEUja+NYOp5phOg1FZngSnPpr9hArec5qsM2d3FTS+JxOT00R4LRmhrbATJWK
	 /xOvRA13kjPhb4tzBcctMbXSOOmLcOIpMf+F0K5Y36DblYu7zKp2zqR6GxTz8971Zgg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 019D71F00893;
	Fri, 27 Nov 2026 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792941;
	bh=nWJjryyVtq+FaAzNI3kGk19OnO62EvakdwcVei4FTaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d2cFOwQiVuxKJLBJ+UcU9nk7Cb9natsyGGYdfBeH3EHOmMkYm75Yu/LkaBTV0c9Ku
	 VU6B1Y38aGHEkGMNFg/A4hV6WYhMIaSy+KlhJL3xsDCh82Pa1KeDMZQApN8bxV3hc4
	 UrnywbU+opk0vKLn5iV8TKwNUTtIbIoRanCXgTKYBpeTi2Wu0m3JhtswWAvDo7jy/l
	 CrNBdeCLlQDEnURey/Yd54XN2HqSmoZioItTlYpxQTUNJVhwNlNq7Hq0/08jurCT4E
	 c8afo2qd7Uq973elNP0l5zyYNCKejdX2PCxZQTTp3dLjsQ0/4W+BAaKphZSOVCD16p
	 ijRMsgw1ZnCYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 802874D11D;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:21:08 +0100
Subject: [PATCH 3/4] ARM: dts: broadcom: bcm2711: Add DMA to i2s
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
Message-Id: <20261127-bcm2835-spi-dma-v1-3-8b134991ba2e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795792928; l=1355;
 i=cleverline1mc@gmail.com; s=20261121; h=from:subject:message-id;
 bh=btPPpOO7EzC2GTVg4V2ShCZQPnjgvV+OMkhhyyjh+9Q=;
 b=l8d0wjig/ng+d2XDHjj1iL8A1oUD0DKMCAGe8OdhNhok7gvQmwrUwtB2du+qBhGkuf7vjsZg9
 MbQ03pmSQI1C+pgbL+v7xuPWC7mXlP+0aONKA/hw0116AeiY5aq90HU
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=2UEUVmQyfsiFZkNS7dkgFg0rUmhbcMIytM6NYhxFt/Y=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20261121 with
 auth_id=1594
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

On BCM2835/6/7, i2s gets its DMA channels from bcm2835-common.dtsi.
Commit 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
added the BCM2711 DMA controller but gave i2s no channels, although the
binding requires them. The driver has no PIO fallback, so on BCM2711
i2s fails to create its PCM and no sound card using it can register:

  bcm2835-i2s fe203000.i2s: Missing dma channel for stream: 0

Add the same dmas as on BCM2835/6/7; the BCM2711 legacy DMA engine uses
the same DREQ numbers.

Tested on a Raspberry Pi 4 B with simple-audio-card and a dummy S/PDIF
codec: 48 kHz/S16 and 192 kHz/S32 stereo play without xruns.

Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index 8ebf52b20c66..0680a0b1ca67 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -1140,6 +1140,11 @@ &i2c1 {
 	interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&i2s {
+	dmas = <&dma 2>, <&dma 3>;
+	dma-names = "tx", "rx";
+};
+
 &mailbox {
 	interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 };

-- 
2.47.3


