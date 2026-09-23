Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81F40DB55;
	Wed, 23 Sep 2026 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194219; cv=pass; b=n4uiJvmVGx0CcZRJq6u1erYEqJUUvntU79iOsuH5INfuOzD1matQ6qHepg9kBql4k4OmVe29pifAb3mh+Z3r94MbvrXVGJUSBgFQwgfS4Q15qG49a0vlOhl0ziROW7jljWw69G2Blc/YheEeyPjaYSp76rz0zaVDAIlKIApQ5Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194219; c=relaxed/simple;
	bh=q2VRyjYgEfkHE6W2rvJ/eHmeLnKQSzBsqz6o1+pdy1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kjmt96dMesISS0jt4c2C75xGiPkHT4zmlvTGtxKwBGSGMKWrw1WVSzHcWMhtZFaEkPcSn5fSgjCCLL81LRZuMcWwB4DN/gyjmjN7w1RBGECWJuOzp5YgejEx11Vp/PUif+39w9hNpgHdIzmYhWd4Q6G6heV4A7rL6jwZzOvTXRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=d3f59K4V; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="d3f59K4V"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6B274201DA2;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/OhB/cNFvYdc1PrtqQx/TpsQQr/hbT4UUANT+9XPx8=;
	b=d3f59K4Vug5Ad8/vOdDDWuf2BouLyQ76nig8YmEcWo8XBXoRkiMAWCf2KcP6QbiXcPy3Z2
	UsdP5VL1yZcNERLHUgjgN3hKszMnUF2gMngDbBuk1c58wdWlEPoWQ51yKxcw3q3Gvp/XaJ
	OdHaLJbCUxTxMxbX+ABfFkZZNPbd1s7pWAe8mMs5jiYg+qf1S0cMT7DnyslKVdmQl7XvF7
	gWKziFm/1b93PvpoGqJjI98ATUlfLdSBWbDLhDfYfqXQGnEkR/X3MF51nTGg+l8hnMnSpw
	aYyNmXpp5Ivf4R86Y/LTqlybDOtcQlqiSiM6iAmjYuMzA0ZBFw5A9QxHq6uW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/OhB/cNFvYdc1PrtqQx/TpsQQr/hbT4UUANT+9XPx8=;
	b=AeuGhgC1rDqHov5XJ4o9gIhzz5TmwskpHZ3rmiwIGzvbAQK6qOGXymRRF/MCn6fA5TatxQ
	iIesTI+kPpxGKetUmbOHguQlTsCeUt/ed5zQAOROZioly/xKDTGbO3iICSJfqyzvBrkE3w
	8LyZA5zBe4A4zUNJLCBGplk3UGrWKjJHIPQKcCkDWy1wj8AfKr/+mDu1sWB4qPkvCwYxqj
	hce6GGAjgXxAdipSZsLb5kuGMFyLWT7flmc1Ky4IZcvhf4+nqZ8Mzf3NWCzzWsTNaO/bYH
	F3vPbMSL0PKidUPNHFmvGXu+ovCmsPPJHSZzhoznbxg7JKJoMMSFGzbe3/RQ8A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=GhSyxyq6tUtoHSU1+4QB3XNpC+xGiZ3ZuJFdI0IlGUdV96cu5BDtN9BM7z56M1rybxA6fd
	qghCsAWt2VHmMsSCxpLb/dwerDAJKNqrFdEsguXhpphjBHgLVC5oOIuXexmMLrfj3PfZiW
	szCZ+AdOUjntUG+ql8OhvpFdhQBarpTzT7WLXENDID5LDblrwRMtp7ymoe6l7dyf+Er9g7
	Ed8waU5jEuxovrUYoEsT26MJv4AD3wt5zyFwXnGf0mDDmuIMB4313ygHxYyWkW0hJeZlVv
	dEGW8qQCC4PecathGBMwKo7qSaYHmrT7J1Snv8glg3tPKc5tfoAp3gLesSZaWA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-18;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v5 00/13] spi: spidev_test: new features
Date: Wed, 23 Sep 2026 22:09:55 +0200
Message-Id: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQytGoC/43NzWrDMAzA8VcpPs8j/ojj7LT3GKXYltzq4gQ7N
 R0l7z6nMCisgd30F+inOyuYCQv7ONxZxkqFptSifzuwcHHpjJygNZOdNN0oOl5m4uWaNG0TYD0
 tWBZurfBKRQjKa9Zu54yRbg/369j6QmWZ8vfjTRXb9lfUO2IVvOODBOOUVzYgfs6YztclT4lu7
 4BsY6t8psweJRuFA8jex9Ggfk2pZ8ruUapRoIKTwsIYB/OS0v+idKP6GF3wwmn08Ida1/UH3DA
 iPqABAAA=
X-Change-ID: 20260910-spi-sun4i-spidev_test-881b33fdc3b4
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5106; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=q2VRyjYgEfkHE6W2rvJ/eHmeLnKQSzBsqz6o1+pdy1w=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiQhIVihtDJ+DUvAzDsvjKrljG5Ud37YmLw2gX3Cb
 zNxPomJHSUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIncWcHwPf3L5ve3K2OV/iX/
 Y1hStSbitmCg8Wm3uLx+jfeGCxreMTLsOqvAp85Rxzt5YuK5BbniCd2fLkRzF34P952j7uyn3M0
 EAA==
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
Changes in v5:
- Add patch 3 to make size argument mandatory for --size
- Add patch 4 to reject transfers of size 0
- Add patch 5 to abort when -I is selected without -S
- Add patch 6 to always compare rx and tx in loopback mode
- 7/13: always compare rx and tx in compare mode
- 8/13: Conflict --no-tx only with input options other than -S to allow specifying size
- 8/13: Move conflict check between -S and other input options to 2/10
- 10/13: make -S and -P are mutually exclusive, -P now takes a mandatory size argument
- 10/13: make -P compatible with -z
- 11/13: Avoid zero-size corner case via patch 4
- Link to v4: https://patch.msgid.link/20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de

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
Jonas Rebmann (8):
      spi: spidev_test: include tools/include
      spi: spidev_test: clarify usage for --size
      spi: spidev_test: make size argument mandatory for --size
      spi: spidev_test: reject zero-length transfers
      spi: spidev_test: abort when -I is selected without -S
      spi: spidev_test: always compare loopback data
      spi: spidev_test: send predictable data
      spi: spidev_test: rewrite unescape() to stay in bounds

Marc Kleine-Budde (5):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error

 tools/spi/Makefile      |   2 +-
 tools/spi/spidev_test.c | 309 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 220 insertions(+), 91 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260910-spi-sun4i-spidev_test-881b33fdc3b4

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

