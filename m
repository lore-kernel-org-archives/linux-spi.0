Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393363;
	b=wT6WczSLNNafObdzAlY39FiVFlhOXCfhBzJRbmaolAKNpR9MS0ubbVoC8RLY4SVGCbI2
	 LARKx7jhRY1EMJeCrVY8QnvkW9HwImtnnn8nukRGJ38UF3U277TGKOZyB0yEEv9WczqcC
	 aS2b3J2gydFRNS1CnE6X+w9WH0mVAX7/DWcd0Jk/UJ2/KhFoMOLnEjw3kb/gfvgmhBKyK
	 uQnNCGvFY7qdxYJUDDEPkem2UsqNfoOjmCyYAdNYnr/IdM814lzE+G+kcgGNUbkyPNpoe
	 96gQsYRsa2LcacCqjMpMwuKTJR0b9E3sfLUnJyGjvaSn9Uno/fXlCbDGvOsVndTDTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393363;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=FehRXX4Stph5bNgJRcY2p31MCxiwJdYGLNVrEudx5Og=;
	b=oWsvm6AsFHmrR5K5Cx8c6yg3XmF5smVgW/2zoHKhdGReD7HjrXKVGz8eOcSB2JbCiGFY
	 7daZpfOr53pjypBcTbgRx1ZCuR5Z7A+s9f0guEPJojoYq57JY5nxfD8hbjLH54U/TRyqB
	 14Dst7Bx98nQIZiH17G80YHyHouGfj5IwBCuJOTMNtnP8uMCuCoZQJDQNDsdmsrifwWb4
	 UBG4seCXTh7vwROsqWihgE03dM81PK2lafy+yi2ZUydbzsJixpPgPvyi7JB4LUTrpy+Ga
	 mwuaaD51Q2uygGm1LHYnUogy+1uvO8h6fM5uaXSx/c4Y5vUcpdkLJA0o4SQgtEWa1+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JJal29qh;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55338606A334
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 10:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55338606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JJal29qh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7C314E41571;
	Wed, 11 Nov 2026 10:35:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72C766017E;
	Wed, 11 Nov 2026 10:35:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3002D11BC10EE;
	Wed, 11 Nov 2026 11:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794393353; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=FehRXX4Stph5bNgJRcY2p31MCxiwJdYGLNVrEudx5Og=;
	b=JJal29qh8KxLlwaaeTmgOS1Fa9nzxmHLsa85/cNw7y5y47iR8TYkNNhFfsVf0x7asHyA2a
	Fk13c2vErKUarfzJ0SH8csQh9nBwkINCF8O3lo5eRqZHN3nhN02I3DoLW2BT6pgXJZy78y
	sJCsTq6xUCovUbvcQp2frb8ICe//GIUlZjkjjs/f5pN9rDFyA7wQagZdjpuhyCLEWL3Ita
	+tANQBJ1eaaV2gsiX19tl/t8gHI7C0T/6Wpwg5oPE+s9Oa4/FTUorSfcEL57JzCmdo7Tm9
	tGXqQbTGFBINjBwiUcCFxqFHQ6R3Cxmd5SpWUFUvBQfFTG0jSrK32XWitOsVUA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 0/6] spi: cadence-xspi: Fixes and ACPI changes
Date: Wed, 11 Nov 2026 11:35:35 +0100
Message-ID: <20261111103541.100848-1-paul.cercueil@bootlin.com>
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

This is the v2 of my patchset that adds a few fixes to the cadence-xspi
driver, some cleanups, as well as a workaround for probing the Marvell
IP on firmwares that use the base string.

The workaround has been reworked to check the board's compatible string
on DTB and the DSDT table on ACPI.

I am not dismissing Jisheng Zhang's feedback, I had the new workaround
patch ready and thought I'd send it along - with the understanding that
if it's really a deal breaker then you'd skip this one and merge the
rest.

Changes:

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

 drivers/spi/spi-cadence-xspi.c | 157 ++++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 53 deletions(-)

-- 
2.47.3

