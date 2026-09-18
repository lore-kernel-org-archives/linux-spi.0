Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F44908A2;
	Fri, 18 Sep 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736018; cv=none; b=XCVRdiF58P/nNGwqsVaA+3P000zLvX5/7SL37hokJORAYC4Ju+RkRxHJNlIzD8EPFPv2IgMsVSujXmeX5HDNk0TKS2z+0hfVK0+JVEpGl7PUlKhe2A36pAPW/IvN1W0DeHlpjNmpx0kd92gxZIoNrDVlAkB/1PmUTJdxtG5Lc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736018; c=relaxed/simple;
	bh=BNnPBNyJAOeGNWOLI5mcXVg7qOAzkY7wc0DE9soaxD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bEo6jOilPcE5SHY9LqA/Lh6gjN3XUCr8P7d+tB195AYYYwCq0kLGsWqrGkRtV2YdXXb0gF7NRwKlqKVjQ6u/UtGrPB8M4bVLB+8W8cBUDVZgHIqdX8oVXM1HZBiX8iUt2p08zq4wvxKwnO/DnEEi8+oNMZzIVWHXMZ6msIOsxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25E0B200582;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-0D;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v3 0/8] spi: spidev_test: new features
Date: Fri, 18 Sep 2026 14:44:54 +0200
Message-Id: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYyrWoC/3XNSwqDMBCA4atI1k3Jq9F21XuUUowZdTZRkhgs4
 t0bhUKhuJt/YL5ZSACPEMitWIiHhAEHl0OeCtL0teuAos1NBBOaXTmjYUQaJqdwmyykV4QQaVV
 xI2VrG2kUybejhxbn3X08c/cY4uDf+5vEt+1XVAdi4pTRUlhdSyOrBuA+guum6AeH89kC2dgkf
 il9RIlMQWnFxbRXDeqfWtf1A78FPxUKAQAA
X-Change-ID: 20260910-spi-sun4i-spidev_test-881b33fdc3b4
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=BNnPBNyJAOeGNWOLI5mcXVg7qOAzkY7wc0DE9soaxD8=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaa+Qfrutx8GDN7uCX56Qzp9yaVu3RWnrcf6KHSHyzU
 brkjPPHO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABN5Ec7IcCste3F88xMfX9vH
 V+9fFDwvM+mN3JJdYi6WBhM7f9qeXM3wV2Bdvfjjiq9O29T6RHYd5WKJmrv7kWhsZ/jF0v36n12
 E+AA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

A collection of new features for spidev_test which have collected during
testing/development of spi drivers.

Patch 1 is a small preparatory commit to share macro definitions with
the rest of the tools tree instead of keeping local copies.

Patches 2 to 7 add the following options:

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

Patch 8 resolves out of bounds issues when parsing escape sequences in
the -i (--input) parameter.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
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
Jonas Rebmann (2):
      spi: spidev_test: include tools/include
      spi: spidev_test: rewrite unescape() to stay in bounds

Marc Kleine-Budde (6):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: send predictable data
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error

 tools/spi/Makefile      |   2 +-
 tools/spi/spidev_test.c | 243 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 173 insertions(+), 72 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260910-spi-sun4i-spidev_test-881b33fdc3b4

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

