Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B802306B11
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315009; cv=none; b=rak2reULYnC4WUNAegCn5FCBXIlYL55ix9gPwHCIRiF8xPLt+5WEV3RehDm9ZQ9qvIvHRtX8yNl2DLyT6kh1QhiAd533mJBip3y9GrOH2/LDb9N1wfYXTUB7Hfmjq810X5Gz2de+Jfd4DhO0GwELMGPqFw2muSjVfqdIGstc984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315009; c=relaxed/simple;
	bh=f9wCjyOgYjFQjup99ix18a6bRwdRODtlj9r6UbxYREE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MURS4CbvrKvBZjLKLdcXwOLs3wYNi1h09VvUEkFzbI3DBqebqiUTVtqyHNxp3cWwHaM4U4A1vxn5tmLc76l0J7+BnxsvO6Ubi3Ko+n7FKXTl4GK+VR77GUkY3rxlCgQO5fRfo/Mp0BamPDmSdz4szaWxNFI+mpZYQe9GwJC7pZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LWyI/1c/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LWyI/1c/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F09E5C243B2;
	Thu,  5 Feb 2026 18:10:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 990126074D;
	Thu,  5 Feb 2026 18:10:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2903119D170D;
	Thu,  5 Feb 2026 19:10:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770315006; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mFAmsB65RtK0CQGRmtX5ytzmHqud/lNpz+jiSvGf/ko=;
	b=LWyI/1c/7VgCosTmpETi+xQWJ8tSALVDZoCxXwWS+syhw/1jJCloQBnZAg3N2oTo4i/sR0
	WGTNsQEa28CfUzkEweNpZ0Y8Sswhtt5N0x5T+CoOOUyF1J1CcnZMRq+dFVElOXtPkGWw5B
	xRN5+UHdMx8GOC9BkdlW7jEXPFYoh0jc4fyNJJZ7kDRilOTzNfcIrkTFmcn8KkSx2xs5rG
	mYCOfn91BXlDGsw3pj91QpsC1qJGXmFGQISFFhuelu4+G8n1H8eVxeFeXEgWpb+i/4J57F
	AWB6J3xsm8VGKCQYjwmqUyKaM1dCQD0fLr2nNLUOQL7WjaZVMGInqKSrpM3Edw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Subject: [PATCH v5 0/4] spi: cadence-qspi: Add Renesas RZ/N1 support
Date: Thu, 05 Feb 2026 19:09:47 +0100
Message-Id: <20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwYrCMBCA4VeRnM2SSSbJ1tO+h3hI0+l2YG3cR
 IoifXejILho2eM/MN/MRRTKTEVsVheRaeLCaaxh1ysRhzB+k+SuttBKW9DQyBKHkbijLJ2smSP
 I33Jg6aMhsOhD7zpRtw+Zej7d5e2u9sDlmPL5fmiC2/R/cwKp5GforLLgDSF+tSkdf3j8iGkvb
 uqkH5JTAHZZ0lXy5IJyBAS+fZXMk6RhWTJVQkNe9aFFfPcTPkt6WcIq9U3UgNAEQ+6vNM/zFZi
 U1JqeAQAA
X-Change-ID: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d
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

Hello,

This series adds support for the QSPI controller available on Renesas
RZ/N1S and RZ/N1D SoC. It has been tested with a custom board (see last
SPI patch for details), but has been tested by Wolfram (thank you!) on
the DB board.
Link: https://lore.kernel.org/linux-devicetree/20260116114852.52948-2-wsa+renesas@sang-engineering.com/

Adding support for this SoC required a few adaptations to the Cadence
QSPI driver which have already been merged (except one regarding clocks
handling). This series contains the remaining patches, the ones actually
adding support for the RZ/N1 flavour.

Thanks,
Miquèl

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
Changes in v5:
- Rebased on top of spi/for-next, fixed the binding conflict manually.
- Fixed the name of the SoC, as reported by Geert.
- Link to v4: https://lore.kernel.org/r/20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com

Changes in v4:
- Drop two binding patches judged useless.
- Collected Rob's acks.
- Fixed the RZ/N1D400 DTSI (removed the properties no longer relevant
  after my binding changes).
- Link to v3: https://lore.kernel.org/r/20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com

Changes in v3:
- Collected tags from Wolfram and Geert.
- Dropped the Cadence compatible as this fallback would simply not work
  alone.
- Fixed the clock issue reported by Santhosh.
- Fixed the DT snippet following the discussion with Geert.
- Modified more deeply the binding, to no longer expect a fifo
  size/depth nor any trigger address, as these values have no meaning in
  the score of the Renesas implementation.
- Link to v2: https://lore.kernel.org/r/20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com

Changes in v2:
- Fix commit log of DT binding patch, following Krzysztof's comment.
- Fix properties order in DTSI.
- Rebase on top of spi/for-next and fix all conflicts.
- Simplify even further the code in the cleanup patches following
  Pratyush's advices.
- Link to v1: https://lore.kernel.org/r/20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com

---
Miquel Raynal (Schneider Electric) (4):
      spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
      spi: cadence-qspi: Kill cqspi_jh7110_clk_init
      spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
      ARM: dts: r9a06g032: Describe the QSPI controller

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  19 ++-
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  12 ++
 drivers/spi/spi-cadence-quadspi.c                  | 168 +++++++++------------
 3 files changed, 100 insertions(+), 99 deletions(-)
---
base-commit: d248c6d8d9eadcbf60345dc9cd924dc6cc4d9b44
change-id: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

