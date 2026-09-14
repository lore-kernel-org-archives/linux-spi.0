Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114794756DC;
	Mon, 14 Sep 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400173; cv=none; b=DHZeTVcYggsEuyHsmehYsi+Y2SdDrJ30TPwpydrf/taGAA+AMD61ZUgCKSeTKTYSMDYYM98u9Ccm1N53Rqmyfw8qQ/eZ4QGNQ8OPhp2fgZpcEAJDbwJ5JWTZDj4b7Izw7UlhRJK0cPqpa3pLRyWr4eHY8Ciq2/2ilxErLRPHph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400173; c=relaxed/simple;
	bh=XAmn9nJo7CaPqbqmyZy+QjbGr44QUfm2xQnDLQyNRYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ch1+Q2hRGUTtNYZqUzQ1MZhr5ZqFRhnq3l1aAcsqO8NnXx/8Z/br7AdiVaZIiwL//J4Xjs94t9BaH2iTIsaLtP+IG0ekgLsDCsg/deDD4vJ9iCBS1H5rIv6bFHBJtgWwPziI/dqUYwMdrdzKnfblF2vlf9hHNnzT25x0bFK8Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: t.schramm@manjaro.org
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: o.schinagl@ultimaker.com
X-PTX-Original-Recipient: wens@kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: mripard@kernel.org
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-sunxi@lists.linux.dev
X-PTX-Original-Recipient: jernej.skrabec@gmail.com
X-PTX-Original-Recipient: mr.nuke.me@gmail.com
X-PTX-Original-Recipient: samuel@sholland.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0C6C120098F;
	Mon, 14 Sep 2026 17:36:08 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x68j1-000vXD-36;
	Mon, 14 Sep 2026 17:36:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v3 0/6] spi: spi-sun4i: assorted fixes
Date: Mon, 14 Sep 2026 17:35:54 +0200
Message-Id: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFoUqGoC/3XNTQ6DIBAF4KsY1qUBLH+ueo+mC5VRZ4MGlNgY7
 1501cR0+d7kfbORCAEhkqrYSICEEUefQ3krSDvUvgeKLmcimFDMMkHjhDQu/oG0wxUi5bVkYAx
 zrW5IXk0BzkMevd45DxjnMXzOB4kf7X8rccoot9ZI6LRUunxO4PtlDqPH9e6AHGASv4i+IiIjG
 gyTSonGNu6C7Pv+BczCe1X4AAAA
X-Change-ID: 20260902-spi-sun4i-fixes-1a50e880dc7b
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Jonas Rebmann <jre@pengutronix.de>, Tobias Schramm <t.schramm@manjaro.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XAmn9nJo7CaPqbqmyZy+QjbGr44QUfm2xQnDLQyNRYM=;
 b=kA0DAAoW1JjkDZHO24AByyZiAGqoFGHIiBgsvUs2vKyJyW2LfE5bir6J1Pjem6tNVv3Jb3HnS
 oh1BAAWCgAdFiEEXSYeIBIzT9c2eT5d1JjkDZHO24AFAmqoFGEACgkQ1JjkDZHO24BJ7gEAgC4N
 JVZiAUkMBQfSHKo2hqZifVXU190/CXq8XH2ioPUA/1x3CATD4f2gqIXiKZDEc8x43r6bMP+O+Jt
 yf6zwC7UH
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

This is a series of patches for the spi-sun4i driver, some of which have
been sitting around for a while.

1-4 are fixes and 5 is a small patch that introduces reporting of the
effective SPI speed.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v3:
- 4/6: Explain omission of superfluous TC bit clear in commit message 
- Link to v2: https://patch.msgid.link/20260907-spi-sun4i-fixes-v2-0-7e805662b9bd@pengutronix.de

Changes in v2:
- Add Patch 5/6 to fix division by zero potential in 6/6
- 3/6: Correctly subtract 1 to gain the register value for SUN4I_CLK_CTL_CDR1
- Mitigate race condition potential in 4/6 by disabling and syncing
  interrupts before sun4i_spi_drain_fifo() in the timeout path
- Link to v1: https://patch.msgid.link/20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de

---
Jonas Rebmann (1):
      spi: spi-sun4i: sun4i_spi_transfer_one(): add error handling at clock setup

Marc Kleine-Budde (5):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
      spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

 drivers/spi/spi-sun4i.c | 68 +++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 28 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260902-spi-sun4i-fixes-1a50e880dc7b

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

