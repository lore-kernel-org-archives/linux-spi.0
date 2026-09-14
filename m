Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4433DFC8A;
	Mon, 14 Sep 2026 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397466; cv=none; b=SXhovHAl2CquUoC03s7CrTgYbWPpx1lght83eJts3AZrhMiRfV29VcQHtoakWgkLlSW5xCkPWbuS+joujCzv7ghMxrmBTRstoJSA//lGNMTGmzWjR7acxfDEs0Pvw2D0sj74YAQvE6aqk1E3/E3JuiFCouuyz9JcXVF937pHPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397466; c=relaxed/simple;
	bh=aNw3mMrhimZo+nIt/9/tbqxXXAZz9eqBFXTH/90NG7k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tu2f+ZM2DsmtQaRO8sHPdEbYZyWnOsjkqDp9rEWn9SOSOLXR9DYihk6jLVidQCqbXCy16200F1uXO/9XGhcvyJytVxglYUsXwTmHHzbudFIN0zr97H/ojqLpsaea2T4GqySSsY27dPJP6nZzA0FKzxvdHRrayS+AuHC15YS5Y/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1220C200051;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681G-000v8b-32;
	Mon, 14 Sep 2026 16:50:54 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/7] spi: spidev_test: new features
Date: Mon, 14 Sep 2026 16:50:39 +0200
Message-Id: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8JqGoC/x2MQQqAIBAAvxJ7TtCUsL4SEalb7cXCrQiiv2fdZ
 g4zNzAmQoa2uCHhSUxrzKLKAvwyxhkFhexQyaqWjZKCNxJ8REMfBTyHHXkX1iqn9RS8dgZyuyW
 c6Pq/Xf88L/eRfV5nAAAA
X-Change-ID: 20260910-spi-sun4i-spidev_test-881b33fdc3b4
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2002; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=aNw3mMrhimZo+nIt/9/tbqxXXAZz9eqBFXTH/90NG7k=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXlaw0Nepn3HljV2UQynz+8NftF3RV955+LVF8NcL
 58X37LoT0cpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAiXZqMDM+8tsZ8NJ1uLP13
 bsvfb9vXLJsW9+G+++tNPgf0XlqzfIti+Cvcu2jFiYoglq83ryU4z96ypflTbEHLs57K2dwcrSH
 LajgB
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

A collection of new features for spidev_test which have collected during
testing/development of spi drivers.

Patch 2 is a small preparatory commit to share macro definitions with
the rest of the tools tree instead of keeping local copies.

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

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Jonas Rebmann (1):
      spi: spidev_test: include tools/include

Marc Kleine-Budde (6):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: send predictable data
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error

 tools/spi/Makefile      |   2 +-
 tools/spi/spidev_test.c | 183 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 131 insertions(+), 54 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260910-spi-sun4i-spidev_test-881b33fdc3b4

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

