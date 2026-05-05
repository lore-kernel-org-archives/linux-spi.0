Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A23A9620
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994269; cv=none; b=TwHV6zfhYs15CD7/PYXtV9y8l0d/EqtcEmT16EdjXu09s7IGnRp4ibzwn6StY+iqRyziXcBWR7+Mk8Yucnq4PaeqECPgZ1LxcvgAZFa6Tq/AKN1rFMGCgmjge+uYsdeDhLC209GiWPWUm3ONKO4sILhXlHzVeoIrBlt8cLR2NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994269; c=relaxed/simple;
	bh=rk6T8FxjphhXuSRWBswXTJVPGsDVT/H8c2OTTEYjHFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImKZyZEEOjOu+G21BbPzmoC6RhAT2nRWoIIofX0DpjgKE/JWyMZvS/jZiVM/OJNMPA3ve3vgPAtl6Qgly27EArEkeSmD//HPx0dJgW0uK1Qb1TDmHZlj1LgqtGSR2RXAcpD1kbPky6c6sBwf4QQCt7Bmx8aL0maGMMbCXOnPrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TO/2sKFX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TO/2sKFX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 008641A3522;
	Tue,  5 May 2026 15:17:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0FDC6053C;
	Tue,  5 May 2026 15:17:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CFF311AD0294;
	Tue,  5 May 2026 17:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777994265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=DJOziYNK85wKAueLIhUm0OYRigtc/n2nqr8Gi1+TtLA=;
	b=TO/2sKFX6i8aL3LKxEBrb33ch+Sb9B1UCGUqpFlZocNQpIN/hzv/wvFTFANg13vaVl8tTW
	M/sReYc57TILRvBrNgJmMkScXjac9EUrlRjTz4Np1LiHrKBFjSthw8oTpyYz80yW0M1jje
	UYmFA8fXaiHzU9NeVn18GJ8NeaqmSTXZuKtD0W4mgqDqHi6nUoouuTXcpGBSg4ejn/oY1Y
	8kvXWzHVSKf5gNa3041XqcuJfSLWaOmBrftsqX02Kpq8cFI3FkRtc0c1CwFntZil26Wbxz
	vg0gmEG/v1Kse9mvEcwQDwUZeWloohye4Isj7mS51pFsehvRGUuADASA/5PH2Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: [GIT PULL] spi-nand/spi-mem changes for 7.2
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 05 May 2026 17:17:42 +0200
Message-ID: <87jythopgp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Mark,

Here is an immutable tag for you to pull into your spi tree with all the
spi-mem changes we agreed upon. I also merged it into nand/next.

Thanks,
Miqu=C3=A8l

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/spi-=
mem-cont-read-for-7.2

for you to fetch changes up to 38fbe4b3f66e5b8e2f2ab8e7ca3d912e1e935fe2:

  spi: spi-mem: Add a no_cs_assertion capability (2026-05-04 15:07:37 +0200)

----------------------------------------------------------------
Aside from preparation changes in the SPI NAND core, the changes carried
here focus on the shared spi-mem layer which is enhanced in order to
bring two new features:

- The possibility to fill a primary and a secondary operation template
  in the direct mapping structure in order to support continuous reads
  in SPI NAND, which may require two different read operations.

- SPI controllers may indicate possible CS instabilities over long
  transfers by setting a boolean. This capability is related to the
  previous one, the need for it has arised while testing SPI NAND
  continuous reads with the Cadence QSPI controller which cannot, under
  certain conditions, keep the CS asserted for the length of
  an eraseblock-large transfer.

----------------------------------------------------------------
Miquel Raynal (6):
      mtd: spinand: Drop a too strong limitation
      mtd: spinand: Expose spinand_op_is_odtr()
      mtd: spinand: Drop ECC dirmaps
      spi: spi-mem: Transform the read operation template
      spi: spi-mem: Create a secondary read operation
      spi: spi-mem: Add a no_cs_assertion capability

 drivers/mtd/nand/spi/core.c   | 76 +++++++++++++++++----------------------=
----
 drivers/mtd/spi-nor/core.c    | 22 +++++++------
 drivers/spi/spi-airoha-snfi.c |  6 ++--
 drivers/spi/spi-aspeed-smc.c  |  4 +--
 drivers/spi/spi-intel.c       |  6 ++--
 drivers/spi/spi-mem.c         | 32 ++++++++++++++----
 drivers/spi/spi-mxic.c        | 18 +++++-----
 drivers/spi/spi-npcm-fiu.c    | 16 ++++-----
 drivers/spi/spi-rpc-if.c      |  8 ++---
 drivers/spi/spi-stm32-ospi.c  |  6 ++--
 drivers/spi/spi-stm32-qspi.c  |  6 ++--
 drivers/spi/spi-wpcm-fiu.c    |  2 +-
 include/linux/mtd/spinand.h   |  4 +--
 include/linux/spi/spi-mem.h   | 12 ++++++-
 14 files changed, 115 insertions(+), 103 deletions(-)
