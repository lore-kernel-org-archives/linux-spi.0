Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0944A8FF2;
	Wed,  2 Sep 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363375; cv=none; b=cuJMRZiSG0kYeMqrwaIIW4cvTXxdZ6kbzLWa5Tq5MO1dlDiYtaEV4u5t4U0nESoufVaooa0xu0AAC0IgfbAjOgEC0/hIoQSL1L+6FB1xEhtDHj5IMIttSF17R2EljpGerk2/LPVxOWHd0aYoCpNGUyGtXVORtUVaBHhL6hb4gJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363375; c=relaxed/simple;
	bh=au5eMP/naxrcGstXPZpXtyykJRGjSGrWTPNZekscycM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=flzEa5Ppjjp0vpQe8IExsmZlNvjtggywSuAeeB1AoDSJIdJUUgCl+ZwQJmPm89LV5uqY7iazutBJMFP1kZVAQdgcUozNNbl4PIhfjzPwSq1Q2+qlrGJM6d67kdkKtPGvU5B7O5c24vIU229KIaeINVG8d4f0EK0VaXzOdhW4F5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E88AD200F45;
	Wed, 02 Sep 2026 17:35:53 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x1n0D-004bxm-2n;
	Wed, 02 Sep 2026 17:35:53 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/5] spi: spi-sun4i: assorted fixes
Date: Wed, 02 Sep 2026 17:35:42 +0200
Message-Id: <20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9CmGoC/x3LSwqAMAwA0atI1gbS4qd6FXFRa9RsqjQognh3i
 8vHMA8oJ2GFvngg8SUqe8wwZQFh83FllDkbLNmGOrKoh6CesRJc5GZF42ti52gO7QT5OhL/IU/
 D+L4f3zMtSmEAAAA=
X-Change-ID: 20260902-spi-sun4i-fixes-1a50e880dc7b
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Jonas Rebmann <jre@pengutronix.de>, 
 Tobias Schramm <t.schramm@manjaro.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=au5eMP/naxrcGstXPZpXtyykJRGjSGrWTPNZekscycM=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsia4RRmtklk5lf3xCsGe9gk46aaO2uZcecVfToiWRZ02
 8H/mnBYRykLgxgXg6yYIkusmpyCkLH/dbNKu1iYOaxMIEMYuDgFYCKzpzP8d6xV28Gyy9f0kvXi
 K4u48qYwrHnZvm3JtgqT1BYWt5YN/Az/sxrKNWv6NeoPr1mhkRHh/aVC6F93rZR4UcycxNK7uvN
 YAQ==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

This is a series of patches for the spi-sun4i driver, some of which have
been sitting around for a while.

1-4 are fixes and 5 is a small patch that introduces reporting of the
effective SPI speed.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Marc Kleine-Budde (5):
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
      spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

 drivers/spi/spi-sun4i.c | 51 ++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)
---
base-commit: 89a312991dc6e638a36adc43ccb91dbc25504c04
change-id: 20260902-spi-sun4i-fixes-1a50e880dc7b

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>

