Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF028506B;
	Thu, 26 Mar 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543653; cv=none; b=E1ZOcll4R9umZkXxQrTg3r7g9UTf6Ew+rum3BRleYd29CMHFcGNe+TFpVj5HP113rycptsvvp/9rM/aRYdgmntOWuZaRFXN1n8ve6+hX6vzOVTqddua3BqGZnUpQR4qXpi9HDyFFkg5sBBEigJWigv3wY4CTcgasGXib7IDFh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543653; c=relaxed/simple;
	bh=8aN5l69aHzRRx26Tanxr4+e+J+1a3kwh5985ylNttvI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9Cf93RnnFd8ka0xpgcluldRgov0Iw5nogT5tarh34xa8o79mEZNPYYtGi164anjflUyrF2bMmbjK8f6AR6165IBVM/n4lARurKmEnVSYx9JMFUtLR5dMJXJtgassBiq7Os4l6eOj3iuGxOBAGssGdhN3ZxdIJPXAYna9X5c70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LdEJu+h1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LdEJu+h1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 238331A3002;
	Thu, 26 Mar 2026 16:47:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAF6F601FA;
	Thu, 26 Mar 2026 16:47:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EA7A10450015;
	Thu, 26 Mar 2026 17:47:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774543647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EJ0tmG/r18aHIsnITrtWSsimMVlxSd7Er0oGFR29yU0=;
	b=LdEJu+h1wzwehlFX9SxFug+9N+HuqfhOoIZRRtcYRKtP+LRC7QEkUacsA11uWGcBfhkD/L
	p35DQoyoWRv1hFmSktdRIe/DTg7J/EWjz1PM5hckZdYNZjYDa12eaX/UW2cr00ws9Vxu6l
	MWjHyLJTqq6IbYyEJ/l3yqeyBOvtM8DI2rIcNViZeieu7/Tf9nDt9FsEYM2m1lhNTg59yM
	9qI7LEqrmhgqVHdMxlt48MjXjgK4CHE209lxO7xrihNQWeQTP+SuEHjNpGOlqBNMy2BLT7
	5Bu/JjgG09UOS2SSMQwl5QWAF2hnb2Sq+IgbHhnN11SWX8MRIbOvavEJrc0iAQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND continuous
 reads on am65/am62
Date: Thu, 26 Mar 2026 17:47:14 +0100
Message-Id: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WQy07DMBBFfyXymok8jh+JhRD/gbpw4ilYShxqp
 wFU9d9xE1FWiOUdac69OheWKQXKzFYXlmgNOcyxBHyo2PDm4itB8CUzwYXmDbbwEWI/Rw+rAQ5
 pQBicpzgQDHNcIJHz0B8d90aoVnaaFdB7omP43EpeDntOdDqXrmU/st7lG2CawmKr1dQb+fY6U
 c5uG2Grx58NyKVRvFYtqk4DwhROZxrr5L6iG5/7eV7GEOuCe/oDIRQaLgsCEdtGyH8ZdxW2KgS
 FgstfEWVCu5u4G9Bamg6974Vu7CrY4Xr9BpLwUbZqAQAA
X-Change-ID: 20260318-winbond-v7-0-rc1-cadence-cont-read-bfa0d7258496
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Steam Lin <STLin2@winbond.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

TI errata i2351 explains there is a problem with CS handling, SPI NOR
are immune to the problem, but the CS being deasserted spuriously when
there is DMA arbitration on long accesses (every 1023 bytes), SPI NAND
continuous reads cannot be leveraged.

Link: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

I created a 2-page read setup for testing all variants available on a
W35N chip wired to this controller. I reliably observed all variants to
always (in my tests) report correct data, except the 8D-8D-8D
variant *when setting an extended number of dummy cycles* (>= 12, so 24
dummy bytes). In this case, I got the first 6144 bytes correct (over
8192), the rest being full of ones (0xFF), indicating the CS has likely
been deasserted there. This is not exactly 6 x 1023 bytes (?), but
close.

This series shall be applied on top of the SPI NAND continuous read
series that I am also carrying, but ideally not too far in the future
because there are Winbond (continuous read capable) NAND chips mounted
on TI platforms AM62 based which could make use of that new feature and
expose the issue described above.

I am expecting feedback on:
- the approach: is a controller capability flag relevant? if not, what
  else could be?
- the naming: is the name of the flag explicit enough/relevant?

Mark, as agreed for the continuous read series, I will offer to you an
immutable tag with the spi-mem patches, if you agree I can include the
spi-mem patch from this series as well (once the discussion on the
approach/naming settled).

To: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Steam Lin <STLin2@winbond.com>
Cc: Santhosh Kumar K <s-k6@ti.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (4):
      spi: spi-mem: Add a no_cs_assertion capability
      mtd: spinand: Make sure continuous read is always disabled during probe
      mtd: spinand: Prevent continuous reads on some controllers
      spi: cadence-qspi: Prevent SPI NAND continuous reads

 drivers/mtd/nand/spi/core.c       | 12 +++++++-----
 drivers/spi/spi-cadence-quadspi.c |  8 ++++++++
 include/linux/spi/spi-mem.h       |  6 +++++-
 3 files changed, 20 insertions(+), 6 deletions(-)
---
base-commit: 559f264e403e4d58d56a17595c60a1de011c5e20
change-id: 20260318-winbond-v7-0-rc1-cadence-cont-read-bfa0d7258496
prerequisite-message-id: <20260318104750.581596-1-miquel.raynal@bootlin.com>
prerequisite-patch-id: e403edd76450cac2c2bca0e261e20654445bc9ac
prerequisite-message-id: <20260325170450.1118324-1-miquel.raynal@bootlin.com>
prerequisite-patch-id: bab6ebb9d753ab004f259843daebf3e13c838c85
prerequisite-change-id: 20251204-winbond-v6-18-rc1-cont-read-664791ddb263:v2
prerequisite-patch-id: 23bdb7fca293bc75c7a071352c791984e3e10819
prerequisite-patch-id: 51b67ce47dc7dd35e658a80933d3e0537deb1710
prerequisite-patch-id: 1d0ea4a7e4adf9f01c1673c25c1bf30599d8c99d
prerequisite-patch-id: 632c50a86db5d2c71a554787bdb3c587bb392627
prerequisite-patch-id: 487ce86af2f5e5e477b03790b8c3d96cfe3d13d7
prerequisite-patch-id: 5abac789e99db720c4ef1b5d0794ec96caeb418f
prerequisite-patch-id: 8ab6698328813504dfd8055548b888938809ee09
prerequisite-patch-id: d65ae506d7df43532be29e189baf5d0d52150bd9
prerequisite-patch-id: c050d153bd677e8d9d424109569cb1a38c07a109
prerequisite-patch-id: b207d31ea2d2bc3318696e0563fd4d9a85d0389d
prerequisite-patch-id: c268dcd6b16b440b1d82388d0ecfc982d36e1c59

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

