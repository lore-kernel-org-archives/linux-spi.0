Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4950276F;
	Fri, 18 Sep 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744991; cv=none; b=Jp3d8BJQAn4dawKd1tndu14hkNzFYjBAfP1U2Ynpcc5M4F7HGe9n4ZIL6Dc5SEtdqTHBrLDR/0HMjoILTZv5DApeKUlr5+7ihD7vloXdoP9FNLyrO5dzsllby5/4gs9MEpkX4tqfvQEql2MRhwTFwVKrK9YxmLGZGeKjkSF87fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744991; c=relaxed/simple;
	bh=uAV7oO78xTajCGd3M1OYy2CbTK/UJhpYm9aSZDAQX5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M2ntAnJYck56/7uEhRVZCIfmx9557PoAnjdA3f9KrpLik3jR2Yf7BA23mLtASFnQEXhcU9G3NGlPTaobrGIMpAtInhPXPSboB2QKFSMVK0RyipswPM3j1zJ8Y7rHCee10Jb/MhJPQLyjylo4n8pR92bcftY4x+z9EZGJHlJwqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2646E2004C1;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-07;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v4 0/9] spi: spidev_test: new features
Date: Fri, 18 Sep 2026 17:22:46 +0200
Message-Id: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZXrWoC/3XNSwqDMBCA4atI1k0xj8bYVe9RSlEz2tlESWKwi
 HdvFApC627+gflmJh4cgifXbCYOInrsbQp5ykjzqmwHFE1qwnOu8pLl1A9I/WglrpOB+AzgA9W
 a1UK0phG1JOl2cNDitLn3R+oX+tC79/YmsnX7FeWBGBnNacGNqkQtdANwG8B2Y3C9xelsgKxs5
 HtKHVE8UVAYfqnbUoH8T4k9pY8okSgjmoozbcq2UD/UsiwfdZqW/1UBAAA=
X-Change-ID: 20260910-spi-sun4i-spidev_test-881b33fdc3b4
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4149; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=uAV7oO78xTajCGd3M1OYy2CbTK/UJhpYm9aSZDAQX5k=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaG+5zae6hiOvvNJy1z7X+Mvlf7+u9NKZHK0Z+opWFl
 FpA3wH/jlIWBjEuBlkxRZZYNTkFIWP/62aVdrEwc1iZQIYwcHEKwESmxTEyLNebGreyaPX+muZ/
 FpmFty/nc1qZWivlpFV8/n3p+7U36owMH0M3Te1Kf3r3UFmGmOCuBYd3vlpp4jT/3rKGLkMRVU1
 7BgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

A collection of new features for spidev_test which have collected during
testing/development of spi drivers.

Patch 1 is a small preparatory commit to share macro definitions with
the rest of the tools tree instead of keeping local copies.

Patch 2 improves usage help.

Patches 3 to 8 add the following options:

  -c, --compare        Compare RX against TX without enabling controller
		       loopback mode; useful when TX is physically
		       bridged to RX.
  -t, --no-tx          Do not provide a TX buffer.
  -r, --no-rx          Do not provide an RX buffer.
  -z, --nonzero        Skip 0x00 and 0xff bytes in the generated
                       random TX pattern so that a stuck line (pulled
                       high or low) does not produce a false positive
                       in compare mode.
  -P, --predictable    Send a deterministic byte sequence instead of
                       random data, so that runs can be compared e.g.
                       on an oscilloscope.
  -T, --transfers N    Split the message into N SPI transfers inside a
                       single SPI_IOC_MESSAGE() ioctl, exercising the
                       controller's multi-transfer handling.

Patch 9 resolves out of bounds issues when parsing escape sequences in
the -i (--input) parameter.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v4:
- Add patch 2 to fix help text for --size
- Consistently use initial lower case for help texts
- 3/9: Only make -c, not -l conflict with -2/-4/-8 (sashiko)
- 4/9: Make all supported input data modes work with --no-rx (sashiko)
- 4/9: Make -S conflict with --no-tx (sashiko)
- 5/9: Make --nonzero depend on -S (sashiko)
- 7/9: Guard allocation (sashiko)
- 7/9: Fix double pointer indirection for tr (sashiko)
- Link to v3: https://patch.msgid.link/20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de

Changes in v3:
- 1/8: Remove old obsolete comment (sashiko)
- 2/8: Fix conflict check introduced in v2 (sashiko)
- 3/8: Do not initialise statics to 0 (checkpatch)
- 4/8: Fix typo: "-r (--no-rx)" (not -t)
- 6/8: free() transfer-array heap-allocated since v2 (sashiko)
- 7/8: Insert blank line after declarations (checkpatch)
- Link to v2: https://patch.msgid.link/20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de

Changes in v2:
- Keep options sorted alphabetically in usage help (Thanks, Mark)
- Count mutually exclusive input choices during argparse to avoid
  overwhelmingly cute construct during verification (Thanks, Mark)
- 3/7: Error on conflicting --no-rx --output <file> early (Thanks, Mark)
- 3/7: Make usage error message more clear
- 4/7: Braces for legibility (Thanks, Mark)
- 6/7: Heap-allocate transfer-array tr (Thanks, Mark)
- 6/7: Ensure --bpw is greater than zero, prevents division by zero (Thanks, Mark)
- 6/7: Use roundup instead of ALIGN so -T works when --bpw is no power of two (Thanks, Mark)
- 7/7: Limit hexdump to 256 characters (Thanks, Mark)
- 7/7: Preserve errno (Thanks, Mark)
- Add patch 8 to deal with a preexisting issue (sashiko)
- 2/7: Conflict -c with -2/-4/-8 (sashiko)
- Link to v1: https://patch.msgid.link/20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de

---
Jonas Rebmann (3):
      spi: spidev_test: include tools/include
      spi: spidev_test: clarify help text for --size
      spi: spidev_test: rewrite unescape() to stay in bounds

Marc Kleine-Budde (6):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: send predictable data
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error

 tools/spi/Makefile      |   2 +-
 tools/spi/spidev_test.c | 275 +++++++++++++++++++++++++++++++++---------------
 2 files changed, 194 insertions(+), 83 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260910-spi-sun4i-spidev_test-881b33fdc3b4

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

