Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194880;
	b=jdIJfBurj8UYqiJCFOIJ0UoVmvsb5IvhJUrl4HNeQwH7PsuG3YM9bYLP8+b7zoAYxeKg
	 2WQ45CWi1pRTVARFUsSBatcqDgi29V2MVA77E2i5iKj5zSHVMDtlF1M8Co3E9KJWPtfg+
	 BbBx0CXbx1DqyoCbrY/8dz73KVkSUt/Q/QY/AU73g9EWjz2XYY9TZo0UIXms2klGVN6zk
	 bIQZogJwJFjOaiY6zLevkHXOObfj0MCniZ2eOkpaSfOUqCWftdcQ9Ymzz+8k38uN72CO5
	 qJmd2vSeXsX7UYv4Wg/vOOx1bdrnefuYVx0dwRFzab+pq3nJZlLi9AQ72wlNoEUohgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194880;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=AfsaK7vstWBR+CIUmGq19kX6RuuD4U+3vDvduSS+ZUA=;
	b=JBMAOwwtvC9Mxw7+j8Oo9yRSmB304YPCplx7n86nGUyfwCHpdpoSkt7LrEe/j3oU3y8d
	 KAT2ZmKSWiQRh1sg8Ny6MLG005S3Nlqxu8HGENrHA6RKC1CJKSRrII6fewY8B0rQBMvUw
	 V5YAXuaJQhYKeoYirRXFAXBfICQ6u0oUxUTKilnUE9MXNB91gF2DUqkLuqWcfxukBUx2e
	 Q+pprE4VU1B8SkxhVsVzj6OD9BLuLjErCYwP0dLqLY/yQ3ZwSTnp/0HGv/gtwg3fGlScw
	 eD5+CdpruwC+V89AM9icB0cjOIIkEP/bFfpsvxhaZ2yNhh3sRzxlhWXCIoSywwK8DkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kaJNstor;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E1606A32C
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2E1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kaJNstor
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CF5BD1A1751;
	Fri, 20 Nov 2026 17:14:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A0AC601B9;
	Fri, 20 Nov 2026 17:14:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96ECC11BC0437;
	Fri, 20 Nov 2026 18:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AfsaK7vstWBR+CIUmGq19kX6RuuD4U+3vDvduSS+ZUA=;
	b=kaJNstorbnqrayLL/98d3HWZsLvpTIcVlH70NLij6H5sSMGM7AyL4RC8pjazgHLM/VMnqm
	NbzayYO5o8bFk0bjYSiYKUwEzMf3z5KmnaNseSWjzzP7yhB/IHtA+VcheGH5+cbt658RC0
	9IfENELf3ZryHLoxyerzSxWzMdmZp1llgPwJpLC2MQgA7L/L25hlWFEhJi8XYz2LLxbe7S
	ifwHiL5WBCdYU1+CYlj0nSA13WHpEjY+rVFdB9Ax9r8d3hoO3HIXqvJTH3+kXmKEga4j2r
	VU6ym60q+Qmq56G0olb5tuRdb5CN/zYhNF8beEZWZ9xE945Xbz40BFwxBH8k4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 00/11] mtd/spi-mem: Enable DQS control
Date: Fri, 20 Nov 2026 18:14:26 +0100
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QTWrDMBAF4KsYrTtGP5Zkm1Jyj9KFbI9j0VhKJ
 cVNCLl7ZWfRli5SEII3i+/Bu5KIwWIkbXElARcbrXc5VE8F6Sfj9gh2yJlwyhXlVMKndZ13Azi
 zfnhOcJwukE7Ouj0Y0+HYU1ZTwUkmjgFHe97417ecJxuTD5etbWHr9Z/wwoCCRD2IRquRjmzXe
 Z8O1pW9n8lKL/ybq6l+wPHMaSEbiXUzKBR/OfGDY/QBJzJnGt0LoxgqLX9zt/sSAT9Oed90n4P
 MGKPZ9m2L57WHMSrzqwUvOROVYAIYRHhXu2RX6GVdtDMRIYfZprZYdFlB6HmuuH0BNF7cmcoBA
 AA=
X-Change-ID: 20260205-winbond-nand-next-phy-tuning-aabefc018032
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

For his PHY tuning series on the Cadence QSPI controller embedded in TI
SoCs, Santhosh initially needed to access the availability of the DQS
(data strobe) signal. This is a chip dependent capability, which may
sometimes be enabled.

The SPI memory flag already exist but is too vague for it. Let the SPI
NAND core and SPI NOR core set this flag when relevant (per-chip for SPI
NAND, always for SPI NOR until we can do better). SPI controllers now
feature a DQS capability that they need to fill. Manufacturer drivers
and SPI controllers can now query the usability of the feature to use
it/enable it.

I contributed the spi-mem bit in the previous cycle but my changes were
too simple, and a more complex approach was actually needed. For
applying this series, I would expect all the spi-mem and spi bits to be
taken by Mark, either based on an immutable branch (in which case the
mtd bits can also get in during the same cycle) or directly through b4
(and we will wait for the next cycle to merge the patches). There will
be a temporary regression if we span those patches over two releases:
the PHY tuning will not be optimal because it won't be using the DQS
capability for a period of time. Hence, merging everything in a
single release would be better, but not stricly needed either.

This series applies on top of v7.4-rc2 and Santhosh's PHY tuning series.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v4:
- Added a spi-dqs-not-wired DT property to describe boards where the DQS
  line is not routed.
- Parsed the property in spi-mem.
- Renamed several helpers to explain what they do more obviously.
- Added a controller DQS capability;
- Expose that DQS is usable only when the memory supports it, the line
  is wired and the controller supports it as well.
- Advertised the DQS capability in the Cadence QSPI driver.
- Advertised the DQS capability before the SSDR/ODTR variants are
  negotiated.
- Only enabled the Winbond DQS output when spi_mem_dqs_is_usable() reports
  it as usable, to avoid useless power consumption.
- Enabled DQS in SPI NOR (always).
- Dropped the already merged spi-mem capability patch from the series.
- Rebased on v7.4-rc2.
- Link to v3: https://lore.kernel.org/r/20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com

Changes in v3:
- Rebased on top of linux-spi/for-7.3 and dopped all existing
  dependencies on the MTD bits.
- Link to v2: https://lore.kernel.org/r/20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com

Changes in v2:
- Dropped the RFC prefix.
- Rebased on top of v7.2-rc1.
- Dropped the spi patch for now, just allowing to use DQS on a few
  Winbond SPI NANDs (can be improved later).
- Link to v1: https://lore.kernel.org/r/20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com

---
Miquel Raynal (11):
      spi: spi-mem: Rename the DQS setter and pin field
      spi: spi-mem: Clarify the conditions upon which DQS is usable
      dt-bindings: spi: Document the spi-dqs-not-wired property
      spi: spi-mem: Take the DQS wiring into account
      spi: spi-mem: Take the controller DQS support into account
      spi: cadence-quadspi: Advertise DQS support
      spi: cadence-quadspi: Decouple the read capture bypass from DQS
      spi: cadence-quadspi: Check DQS usability before enabling DQS capture
      mtd: spi-nor: Advertise DQS support for octal DTR flashes
      mtd: spi-nand: Set the DQS spi-mem capability if available
      mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series

 .../bindings/spi/spi-peripheral-props.yaml         | 10 ++++++++
 drivers/mtd/nand/spi/core.c                        |  3 +++
 drivers/mtd/nand/spi/winbond.c                     | 10 +++++---
 drivers/mtd/spi-nor/core.c                         |  7 ++++++
 drivers/spi/spi-cadence-quadspi.c                  | 11 +++++---
 drivers/spi/spi-mem.c                              | 29 ++++++++++++++--------
 include/linux/mtd/spinand.h                        |  1 +
 include/linux/spi/spi-mem.h                        | 12 ++++++---
 8 files changed, 61 insertions(+), 22 deletions(-)
---
base-commit: fd9230005e85472b81c1c7c16afe93dd878996b1
change-id: 20260205-winbond-nand-next-phy-tuning-aabefc018032
prerequisite-message-id: <20261105105832.2134313-1-s-k6@ti.com>
prerequisite-patch-id: 7e80450b6b26ac3240d561a7f9f0e5fe177a89b7
prerequisite-patch-id: 865537f117247ff4312d629514dd06f1f38f1d47
prerequisite-patch-id: 5200192ca3b2cc4a2fdf8afff7ee5c757fdb66b5
prerequisite-patch-id: f41f68176da636e14a8221fde30b3a32cd155bdd
prerequisite-patch-id: d23997b62c52e24d7d92a3f795b2d64ad32a6dc7
prerequisite-patch-id: 7d0c439461665f7c41639343042ddb96937d2838
prerequisite-patch-id: d8770bcd1d4f60e882cdd4ad6f35409a08dc2402
prerequisite-patch-id: 5b96154a5b95e52afc0e3f128212921984713615
prerequisite-patch-id: 500bd167644ed25f95ee48bf7992d79d611b036a
prerequisite-patch-id: 65a2ee2f666180289b3c38aef3e238803ba93f27
prerequisite-patch-id: a58a38e05737feb5f097cafe49f814a4f4a1b252
prerequisite-patch-id: d0717fa96dbc2f99111be023238973932a6c59b4
prerequisite-patch-id: 817e0b94d11c4e7884c962781ff20131a9db1aa9
prerequisite-patch-id: 16ba1c3be3824059d975c0e48a7056b061c2d652
prerequisite-patch-id: f7d67c3465c65f61ec878b6d3f049addd44316af
prerequisite-patch-id: d023f74d37fe6be398aa45a5de3cd70f775cb37a
prerequisite-patch-id: c146c437ba46a28dc74dcebe4c66ff8107ce31a3
prerequisite-patch-id: 14cf3f31d431b4622a4f225939b8d3d3eee21085
prerequisite-patch-id: 95db84235391fa3a39c1947f19411634d762e1f9

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

