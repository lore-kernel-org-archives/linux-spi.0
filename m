Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1B542ECC;
	Wed, 14 Oct 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992654; cv=none; b=i5FIZGUsXaJxZsbwazNE6QpkxK3KfZ56YpoUYC6whjIR4m2Zabg2vJ0ezZQkRRXDRUsO44XN3Ui5npYQC6q1HuC378eHTrDAg8BVx59yjBT1TOmJwsBc5vGmVF4KY9/QN0cNoYC68t7zl8TdWEyS0TbmBlvYKVP9L6be2NpPk6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992654; c=relaxed/simple;
	bh=hBMwa/B+aLVSuRnot4gxgHLKyE46De0gqM3s5+wWlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJvryi+QFfg4HU3D7yxh4DSdMpmK5zHALdcm9v6NY4IbI0J3mmCy3zPNx5XS/8MDP8gC1R2VZyLoVwuwZyV0RfMptZm70r4rFLP+vze8xkFc1qkcS+/NvoFbNf7Qfqda6MR7crWhWz/qeOgFdbGiOUujInD99Oz5XLLaSv9jt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ulWYPyiH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ulWYPyiH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E76D4E411FA;
	Wed, 14 Oct 2026 15:44:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4CC660368;
	Wed, 14 Oct 2026 15:44:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F11DE1032806C;
	Wed, 14 Oct 2026 17:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791992646; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=IRNvNHczv/4RYpS6PDlOGN0xfjV5SxkuPqy6rEKMu3g=;
	b=ulWYPyiH4Wb/z63khCUujM0htofB1uPMt4YgtuWc+/m1/owRs4dwBQNJrnOdA6E4ZaYWvQ
	iWITjgyQqNJID6yWxrOGUPZdgfbbpwbvHdbUqRt42uKU+PDDrfUkQllJlOVqEkZBaUUtlL
	tDodv0zDdZQnbxmoav1NAefw7otqrLdaHlpeV1rLHN1c3TU2r9xtQ+2OTdwPBDO0AzPHJ/
	HW9SPbMATKjgSzPGU92ERiY+TA8MSyHnRogi86ciJeayRd5bex4/HaBRbkEQZg1esiGyV5
	F97XJSI7UXpqGFHGGl1mkUAiF6TrT9Fva4y6LQGh7DDBOl0zV4Mewieys1L24Q==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 0/7] spi: Add support for panic mem writes
Date: Wed, 14 Oct 2026 17:42:54 +0200
Message-ID: <20261014154301.157755-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Here is the v3 of my patchset that updates the MTD spi-nor code as well
as the spi-mem code, to add support for panic mem writes to a memory
partition configured as pstore.

Changelog:

 - [1/7]: 
        - Use pm_runtime_active() instead of pm_runtime_get_if_active().
	  The latter cannot be used in a panic context.
        - Forbid fallback to regular SPI on panic

 - [2/7]:
        - Set 'timeout_ms' parameter to u64 to prevent u32 overflow

 - [3/7]:
        - Use GFP_KERNEL xor GFP_ATOMIC

 - Patch 4->7 unchanged.

Cheers,
-Paul

Tanmay Jagdale (7):
  spi: spi-mem: Add support for panic mem writes
  mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
  mtd: spi-nor: Add support for panic writes
  spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
  spi: cadence-xspi: Add irq-less support
  spi: cadence-xspi: Add support for panic writes
  spi: dt-bindings: cadence: Make XSPI's IRQ line optional

 .../devicetree/bindings/spi/cdns,xspi.yaml    |   1 -
 drivers/mtd/spi-nor/core.c                    | 109 +++++++++++++----
 drivers/spi/spi-cadence-xspi.c                | 114 +++++++++++-------
 drivers/spi/spi-mem.c                         |  42 ++++++-
 include/linux/spi/spi-mem.h                   |   5 +
 5 files changed, 194 insertions(+), 77 deletions(-)

-- 
2.47.3

