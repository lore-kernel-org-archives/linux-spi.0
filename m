Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1E47F2D3;
	Thu, 24 Sep 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257453; cv=pass; b=qYHPgLeSS0zfVAtYWIOHjUwgxkFF6KJ6QiVmAwUzBZhhQ0jI9yadE955BR3ql5nenfAt9A1ZnNssQKXv3suPzAYImcR6XVDHNJyWDbL87QgdZVpJFU9vlyq06UxP44p2h4X4CJQl6tHykK5VC+o/xAHWHNdxwblTSujhnyvNs3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257453; c=relaxed/simple;
	bh=AZdB9mkRmAUjYCAn8bgMb5iizyvkgPePPuy5CHB+F8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iJON48RMXYT1+pga9PTdDhMvdOaTtyvrkasaLQRPAfnukFn97PtCJwZ3QUmewzIdV/qlHO7dQ2QLJnEpPFZosb+uOQKcP2hr6YyCU7H+Z5mcoF89bFTiCCbMnubZt+U/uQhmrqde2E6SMJdmg0A9Oe66717P+w91+QXUiBCCgW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=doCRCnwj; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="doCRCnwj"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A2D1120026F;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Y8+Zge6Z2KmuT9SedZ9K0L9tPzeZzbBxJsDwMAuj8k=;
	b=doCRCnwjcxoXRn6mgJl2jyq56TrTnM+Fevb2KtaL3OCk1ryhu+iakQaXqZoZk4C5F2MlJk
	2W/FP8Uupo3uV9MqsR+C2l/A31pFWzKoSuosiiZA2NkvhlJmi23VHXpQFNu0ya+ZaGzP1V
	qXxtBfIed3AQSDK9vh3aj8zbJ8CZtCJJUo1ZSP9WBQn5vtA1L3U07YBcjnMnvLRlAGwl0J
	TzD77/UNzFVq9uotqtSoCRSOWqwxFaWc08Yqbyms04B78oiCQYWzUaIg5iPOhZIjMocjVb
	LkGK3QuHghtu4s5A4k6P3uo9XexTNa3OeKNHvxQ/Vg4XSXbLyVcW2P7/DI457A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Y8+Zge6Z2KmuT9SedZ9K0L9tPzeZzbBxJsDwMAuj8k=;
	b=Kxoy3a9bN8oTDgr3Cs5UlODcHMAKe4bDP0/xKgrhqZL+RaXv8x55uMy+6qRHARDYkCsh12
	Mp4VYqxDufHpRWhuMbYaTv5+JHsC4sFJHvYxAbL5syvjYT4CzBy7HHgWJ95xtcSFprUzaL
	zcsU3keHPsAXC17QfH+MZI68x+FSsPZDRNRAjiL06+VPMm2ExCVFhl3kVj0wx9WYYr6Www
	m56fC5oEv542kbCzTWH1+W59xRbJnV3SigQYHed/H0rxvqhKl2yH5FgqkuaKqNU3MWJKmT
	O05Y4wuP4GpxFLcq4jk8EZnMw3AO9N3mqWS4tW1hS3zGBuCWzCwkEX+EG5tcpQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=eDpG5dbcOOli/AZM4G4/a+T7wFMhrb2dpfz+MzF1kOKSGcasIqcA4Vu4HIDuSOr14jnRyx
	Cl/qApi5o0foaSda/GhqVt2B3WZl9t0q71hCKaD6vHkHo/j9NJcNlk8rvbwlrPom1O+x3v
	rVMeXtwdEjB3sdruDQNtXE0m9FUP1aFfyi7Zz028o1jri/mZy7VNgU7HivdWiiltYkJZfl
	ULus9cogeIL2/gzMBS2CzU2IyvYEtSNRertuXz6tHKwB8BL2usc6AJqOSysln6d9O4ByT7
	qQsQu5lXgYV3Mq/iBYPSvw9dg/71ncIEviXQ8+jT0F+BkWWiV83Xy2GlPIq6uQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 9398C380182;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v7 00/13] spi: spidev_test: new features
Date: Thu, 24 Sep 2026 15:43:50 +0200
Message-Id: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABYptWoC/43QTWrDMBAF4KsErasiaWRJ7qr3KCHoZ5RoYxvLE
 SnBd68cKBhqQXfzBt43ME+ScU6YycfpSWYsKadxqEG/nYi/2eGKNIWaiWBCsZ4zmqdE832QaZs
 ClsuCeaHGcAcQgwcnSe1OM8b0eLlf55pvKS/j/P06U/i2/RVlQyycMqpFUBYcGI/4OeFwvS/zO
 KTHe0CysUXsKdWiRKVQB9G52CuUxxTsKdOioFIBvBXchD5qdUjJf1GyUl2M1jtuJbpwSHU7SkC
 L6iolOqO451oKdUypPdV8u6pU7D1Y45wBZv5Q67r+AESnOHk2AgAA
X-Change-ID: 20260910-spi-sun4i-spidev_test-881b33fdc3b4
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7361; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=AZdB9mkRmAUjYCAn8bgMb5iizyvkgPePPuy5CHB+F8I=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqik783HfpaUvA1yulSwQiTywfsuvmQcmq+b9+3LBI
 mPKs/yPth2lLAxiXAyyYoossWpyCkLG/tfNKu1iYeawMoEMYeDiFICJuHxm+GcS9s1h0wbPvu0n
 XyxbceaA49nUKR7H3/WHW9xqyXTnkFdlZLghvl4rcmHskrf5s+J6fcomn0/KKUmvNGgPkpHZ+eR
 GHBsA
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
This patchset has been blown out of proportion quite a bit while trying
to handle corner cases pointed out by the LLM.

I will not try as hard anymore to avoid Sashiko "Regressions" as this is
a tool which should first and foremost be readable above handling cases
such as obvious misuse of the CLI such as passing options multiple times
or with negative numbers as parameters.

If any reviewers find I should honor any specific Sashiko findings,
please point it out to me.

Anticipated LLM-review questions:

Q: Could repeating arguments cause regressions
A: Handling such corner cases of passed commandline arguments is out of
   scope for spidev_test

Q: Does this lack a check for the case where a user provides a zero
   iteration value?
A: Handling such corner cases of passed commandline arguments is out of
   scope for spidev_test

Q: Could the memcmp() in transfer() read uninitialized heap memory from
   the rx buffer if the SPI driver updates mode flags?
A: Unclear. This is preexisting code hence the question is out of scope.
   This should be discussed if the issue arises with a concrete driver.

Q: Could atoi() returning 0 for non-numerical arguments cause unexpected
   behavior?
A: This behavior is well-known to users of spidev_test, change to this
   convention is out of scope of this series.

Changes in v7:
- 3/13: Fix commit message
- 8/13: Remove superfluous check on do_tx for default_tx case
- 11/13: Ensure that _IOC_SIZEBITS is not exceeded by a large number of transfers
- Link to v6: https://patch.msgid.link/20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de

Changes in v6:
- 2/13: Specify that repeating input options is not permitted
- 3/13: Allow zero as transfer size but permit negative numbers
- 3/13: Include fix to hex_dump to dump zero-length arrays
- 4/13: Fix error handling for zero-size transfer and now *permit* them
- 10/13: Add the forgotten longopt argument number for --predictable
- 10/13: Adapt usage error message
- 11/13: Handle zero-length transfers gracefully
- 11/13: Cast effective_transfers from size_t to int only after min()
- Link to v5: https://patch.msgid.link/20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de

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
      spi: spidev_test: allow zero-length transfers
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
 tools/spi/spidev_test.c | 330 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 239 insertions(+), 93 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260910-spi-sun4i-spidev_test-881b33fdc3b4

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

