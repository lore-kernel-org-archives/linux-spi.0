Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795792934;
	b=zEyEjizbczMZD5r95tl9ACl3zCWcv/KOKXdGiFSkjFyji4TSKi1PJzzNFqW/UydCsM6z
	 SxBxWkDweRFpNuK8jV+PEgMZupPxfUHisjOsaK3EJTkQ67s8K0t8I/V+m0Wcmgs28lXXK
	 bPCcTFRTDtQ8BJSS35SUorb+IcCYhXIQkeMHZfE+T4qP2xY7+EJGbjU9zfvmtFtx8uMeV
	 RwxGp7srtPGiBEYzn5mUEpnElivXeqXTTPeYkJG78srpXMB3tzgxhV1r98l2SFZWEra6u
	 55odAiVpmlaPBPePavd5zP+kuknVeZI6L5BVCfnrB6mBoIQSAzHTR7QMc65FRSoE02Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792934;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=CRSjpxH4TNIa5AzUVjH2D42lzo+c5Yov82Bh6OCdY64=;
	b=uupLgss/xPGaKvLXWtsK/OfsOduJrxPYuIxXfxydMSwsskkvqXrvl5+AuaFRd+unH5KL
	 JhhymMsLiofhthe+ksM2i9xVl2/EJzhl5Mc7jTsHQZlbjeN2xJhzTdpFrMUpbeITrp7lP
	 n4i3mS8SQ+lrzPiIeNXPYrn0ntf8yHv7PihbSevw6LnVPBvnnTBOjfsWBXkYNO/jkWfWQ
	 k/9boGJjYAntd7TyEeUU5Fz5SPPTC4C24+zi4PgAXG5WCAVAuz0MNtNKy5qtATJVmTa1T
	 xqXeBOB6tUl3zUGCggoCDST3wVsKJULj8vaA9KyMH2K9MlnVPvkdzb6BLHY6pzuTokg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMla+Kwn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6B606A338;
	Fri, 27 Nov 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMla+Kwn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795792933;
	b=Wf2upP5rkCuGJ4ImXieZt4dsoKV0CLcI68pNQCoXPJAbFo6CpbHJhtu7Kvh2g0QAd85+
	 jVQeX6qluVC+x4zWVugN+cFU9KYp8DON2PkgpA/QJ7xJIhC3gCoDAE2hXg+npD/gZdthf
	 CUhFKAzD5R+n6ao32kqPtitijge7skjcoo8hR89qXyISUOV3zb3qGi5dt9q+l29fdI/9X
	 SMM/2Ju/jw2OZYAvmfV0qm4nvo05wA6Qx+ArLGxWlSnUVb0LzuXR9ls3SQjxhRnhMhAk5
	 HISakIpUZL1wUOqKlveUcVjQepB4ySs7c03RqLOAIhEkY3idDGdDNl//0tidJj3GwwA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795792933;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=CRSjpxH4TNIa5AzUVjH2D42lzo+c5Yov82Bh6OCdY64=;
	b=Z3GPZOv7Xgq/rR+IG8lKS5TrnBcILh49r4H6XUNXvRG7lVX4BKOKEzjsFM/uCnMXOyXg
	 g+j16quOk4Z1apWtp5WrNsU/bq1D1c6Qcr/2/lP+/XIbGBZc4NZutnK407vzMroqWFSHM
	 yMlAo9Y3fuIZzR8NLOWCfhNjRHYxo5u8f1uN9uH00qqCnignNNI0XJJXy0G6Y2Sb+5W84
	 RlKThZEN8cHwOBX92NnY6EC4qUmRKV3RoMTvV0uks/Z+rW+LjqqkokQeY1fIeiNkVodcv
	 duutTdP4DCkgdlCRthiv0bhmUfv+ltWBuaO8NRQQcLPBqyIXnWh1pCEzy6FGh3lkiQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 726A41F0089A;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792933;
	bh=CRSjpxH4TNIa5AzUVjH2D42lzo+c5Yov82Bh6OCdY64=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=AMla+Kwn0sTqr9TuRDdjh2/3xazvTVUbJh4/AEJ+aB+GgUXnT5phWy+T7/YSrwFZ/
	 +1aIeQIevdwM2BhcCDWFs8P5IMKeH3m0JigHeRfPVakv6Rrupk0EeN77qxyvMoXVO5
	 yshjxLp9W+Yx5jo1fudPjvxzZkLCLLQO7slJQNIhmw37IgCyqcTmJYdsfbfMFk0eMO
	 NAKVvi0eTd3mpW30V/3r7MSuMRo5gOsH75XXea8Jmtu2CNP0FanZ1gdgW4OxFiOb45
	 BBVnjXa/NA/hA+9BHO7jkoumfBrntHtyK/c+UXI8nNMToMTuunR0SnzeC9nQxbrCVR
	 o9NNrCw3RIxGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 014774BA74;
	Fri, 27 Nov 2026 15:22:09 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Subject: [PATCH 0/4] spi: dt-bindings: bcm2835-spi, ARM: dts: bcm2711: Add
 DMA to spi0, i2s and sdhost
Date: Fri, 27 Nov 2026 16:21:05 +0100
Message-Id: <20261127-bcm2835-spi-dma-v1-0-8b134991ba2e@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOGfCWsC/yXMywqDQAxA0V+RrBuYTOuD/kpxMY+oKWhlokUQ/
 91pXZ7FvTsoJ2GFZ7FD4q+ofKYMuhUQBjf1jBKzwRpbEVlCH0bb3EvUWTCODr03DcfKUP1wkKs
 5cSfb//hqL+vq3xyW3waO4wTZQaGdcwAAAA==
X-Change-ID: 20261121-bcm2835-spi-dma-bb08ed60174a
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795792928; l=2083;
 i=cleverline1mc@gmail.com; s=20261121; h=from:subject:message-id;
 bh=GPAK2NN455l9SD+f8GSczRZqWij+l+kvBXDhsd9fwxQ=;
 b=vvKn9I4Hb52gOfCftXc+IgXPHf5l8Ol8880tjxh574m4hCmWVSNxE/N128JXpFPkR51lsl46i
 Ed3jpXibhG9AvJZYKcBQiX0J5oo2iiWk6ToQs2s3uqTswf36tBR6bMm
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=2UEUVmQyfsiFZkNS7dkgFg0rUmhbcMIytM6NYhxFt/Y=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20261121 with
 auth_id=1594
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com

I'm moving Unipi devices from the Raspberry Pi downstream kernel
to the CIP kernel and plan to upstream the gaps I find along the way.
This is the first of them.

On BCM2711 (Raspberry Pi 4, CM4), spi0, i2s and sdhost have no DMA
channels in the device tree, although the same controllers get them on
BCM2835/6/7 from bcm2835-common.dtsi. spi0 then runs in PIO mode, and
i2s, which has no PIO fallback, doesn't work.

Patch 1 documents dmas and dma-names in the bcm2835-spi binding. The
driver already requests them and bcm2835-common.dtsi already sets them;
dtbs_check doesn't flag that only because no in-tree board enables
spi0. The i2s and sdhost bindings already describe their channels.

Patches 2-4 add the dmas to bcm2711.dtsi, one controller per patch, so
each can be applied or reverted on its own. spi0 and i2s were tested on
a Raspberry Pi 4 B; sdhost only for probe and DMA binding, because
nothing on that board is wired to its pins.

Patch 1 is for the SPI tree, patches 2-4 for the Broadcom SoC tree.
There is no build dependency: without patch 1, patch 2 only adds a
dtbs_check warning for boards that enable spi0.

Checked with dt_binding_check for brcm,bcm2835-spi.yaml and with
dtbs_check on arm and arm64 (bcm2711-rpi-4-b, bcm2711-rpi-400,
bcm2711-rpi-cm4-io, and on arm also bcm2837-rpi-3-b and bcm2835-rpi-b):
no warnings.

An AI assistant (Claude) helped write the commit messages and this
cover letter.

---
Kryštof Černý (4):
      spi: dt-bindings: brcm,bcm2835-spi: Add dmas and dma-names
      ARM: dts: broadcom: bcm2711: Add DMA to spi0
      ARM: dts: broadcom: bcm2711: Add DMA to i2s
      ARM: dts: broadcom: bcm2711: Add DMA to sdhost

 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml | 12 ++++++++++++
 arch/arm/boot/dts/broadcom/bcm2711.dtsi                     |  9 +++++++++
 2 files changed, 21 insertions(+)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20261121-bcm2835-spi-dma-bb08ed60174a

Best regards,
--  
Kryštof Černý <cleverline1mc@gmail.com>


