Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493879;
	b=fKNgjUp019T9iwyUpO3X9TxwktW/Cx9Hlhlbs9GLL66FLYdkN5D26wuhpQ2knn5RsN/y
	 O1bdGgsBMdIS94JZuQZPPkKZ8A9eM/kxTEW+iJmRULfVcsdi4Z2wnA6kgSmcZ4Uch1mev
	 MaWYgEffZwi3hK0+qOlXvLLz8aCgMX1028D044X3nnxJRn8bD57008XcPQC7d3D5E9vAN
	 nUAWBW86ilXJr8RjV+1wrO17ycdawlF7fE5bmF74nKHLtnXmVMBsri1++KPQV+9vPMPZg
	 01Jmo7i0huaLFyNawDSnKvD0Bn3Pm0gXEtKGHd1Gb2VQfOcuKvb4XyaYT8vCGHhbWqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493879;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=m43mCr4jXBLQd/wauRzhXN9oFFUI327VR9fiAvjSr6s=;
	b=k1bZKM7s//UC48330NqxJtVkvzWVNUmHLcmCl+xWQ2mSvFgCTbzVynAkzQ75tysCRgyg
	 aY5U6hTXMfrrkOapiSx0XmgAYMLKxnI5ACKH5os6k7WbU7VpBYFGoNm9asZ48GYNlBBRQ
	 ucwIJ2QfNMlUXm8zZvCxn8an52LxCNcZJmUo0crRlXONO6pH8kR40AUII/eb9OsCE2MD4
	 sXKW8/y1Kl1yV9tDjYN8geeZ2Jv/feDpjuuUlgIiQZpFmlG8jHc/kxLIrC3HScefUTeXY
	 qcm/DRPGM4xEpHqWyDrQPHGASctT1R1VxvjeGk40dKV76JxUkiolmgUQ/3jcZoyoSbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TJOzVqxy;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75832606B2E1;
	Thu, 12 Nov 2026 14:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75832606B2E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TJOzVqxy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E84EFC6917C;
	Thu, 12 Nov 2026 14:31:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8BFE5FF85;
	Thu, 12 Nov 2026 14:31:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D14BA11BC0326;
	Thu, 12 Nov 2026 15:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794493869; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=m43mCr4jXBLQd/wauRzhXN9oFFUI327VR9fiAvjSr6s=;
	b=TJOzVqxyF7tLEjuC9m6j6xywYSRcvmIndYOeeX3D9lKnOfRtu+OPW3MSlOSoJ458RHVq8M
	biZkygjMdXrdciXMpeyBKM2HfermG2kSDvjDBe5yem9pms9PDrJFUkIp09E0/9XPY3pRCj
	HDZhcgQzeR58kbwqR/KEGtbC34uLqLDr4DcnwLazucUoOdSSxLZDnVDkK9RH1Q83JmP0Zo
	MUFwxTogrhCrDuwbMnq0Ax01q2SkEmudzYdjSWNGBCNhjW406GIOhujsdTG5X7XOgmSA7t
	Ua8a5wH8b6Ce3tbprm8gqvIuMxOu/rAYZnaOS13JYx+gqcWNUBPUIKbg6+hz8w==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 0/6] spi: cadence-xspi: Fixes and ACPI changes
Date: Thu, 12 Nov 2026 15:30:44 +0100
Message-ID: <20261112143050.53347-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

This is the v3 of my patchset that adds a few fixes to the cadence-xspi
driver, some cleanups, as well as a workaround for probing the Marvell
IP on firmwares that use the base string.

The workaround has been reworked to check the board's compatible string
on DTB and the DSDT table on ACPI.

I am not dismissing Jisheng Zhang's feedback, I had the new workaround
patch ready and thought I'd send it along - with the understanding that
if it's really a deal breaker then you'd skip this one and merge the
rest.

The v3 fixes the patch [6/6] which didn't build with !CONFIG_ACPI.

I also needed to send a v3 anyway because I didn't Cc linux-stable on my
fixes (patches 1-3). Oops.

Changes in v3:

- [6/6]: Wrap ACPI specific code with CONFIG_ACPI guards, as some of
         the functions and structs aren't defined without CONFIG_ACPI.

Changes in v2:

- [1/6] is a new patch to fix the error reporting in
        .transfer_one_message that you reported on the v1.
- [2/6] was adapted slightly to work on top of [1/6].
- [5/6] drops the error messages as devm_ioremap_resource() already
        prints errors.
- [6/6] Replace the workaround based on the presence of the "xfer"
        resource with one that identifies a Marvell SoC based on the
	board's compatible string on DTB, and the DSDT table on ACPI.

Cheers,
-Paul

Tanmay Jagdale (6):
  spi: cadence-xspi: Properly handle errors in .transfer_one_message
  spi: cadence-xspi: Reconfigure to STIG mode before SPI message
  spi: cadence-xspi: Inform SPI core about size transferred
  spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
  spi: cadence-xspi: Rework resource discovery
  spi: cadence-xspi: Add workaround for old Marvell firmwares

 drivers/spi/spi-cadence-xspi.c | 161 ++++++++++++++++++++++-----------
 1 file changed, 108 insertions(+), 53 deletions(-)

-- 
2.47.3

