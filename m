Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358044F6466;
	Mon,  7 Sep 2026 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795138; cv=none; b=vAsfG/fvw0VF4j49wyp/ps6Xl33tF/64+dOonL16hnDkboxDAhp4SYFTwErgVNrTWTKmdeLaZgN7Vh4xU2sEcE71D8Vx2IdAXQDc8G8rlvRFYvBZ/VVCVW1vEDZj7wNqdNZhrTLMX+ezyRdfVlcbSZPCmNJcPSy3h0IvZ8J4lkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795138; c=relaxed/simple;
	bh=Hn7e423UurP9gdsCG4WE+AxmupgD/lxbCguKwQErUis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1x1mUzxhP/wNS/RGJi8PAvdRXbuGuzqkfhE6kRtnbLWzHsN8FZNwy00g2WJNs4N6YSPA2CJVXk6YckUdtgLVxf8SyZjanvqpIBAe4tY2XcqbEhVv1+EzMAzmRbx0zJ3kw2XsEcNNY+N5DUzm1PffD/7FfkaooYjImIIXVvFL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: samuel@sholland.org
X-PTX-Original-Recipient: linux-sunxi@lists.linux.dev
X-PTX-Original-Recipient: o.schinagl@ultimaker.com
X-PTX-Original-Recipient: broonie@linaro.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: jernej.skrabec@gmail.com
X-PTX-Original-Recipient: mr.nuke.me@gmail.com
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: mripard@kernel.org
X-PTX-Original-Recipient: wens@kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 78A94202013;
	Mon, 07 Sep 2026 17:32:04 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x3bKG-000Ym1-1E;
	Mon, 07 Sep 2026 17:32:04 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 07 Sep 2026 17:31:45 +0200
Subject: [PATCH v2 6/6] spi: spi-sun4i: sun4i_spi_transfer_one(): report
 effectively used speed_hz of transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-spi-sun4i-fixes-v2-6-7e805662b9bd@pengutronix.de>
References: <20260907-spi-sun4i-fixes-v2-0-7e805662b9bd@pengutronix.de>
In-Reply-To: <20260907-spi-sun4i-fixes-v2-0-7e805662b9bd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=3aSZoSVdfFoP0s52cZnANn1FnxYo6HhRQHzmKTWne0U=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsiad+NzwuO7K5dtjcsonh3whTkrXDvU0vuA6cVz9hOib
 isVJW+e11HKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZjIyV6Gf/pvNH34LmSuLhfy
 frzramZ7atpSpR18yTopXwWUF3fMSGb4X161plR75eWFgkFO0uq692RsrqxwnqUrsuj/I+ldTzt
 2swEA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

Report the effectively used speed_hz for the transfer by setting
tfr->effective_speed_hz.

For more information see commit 5d7e2b5ed585 ("spi: core: allow
reporting the effectivly used speed_hz for a transfer"), which adds this
feature to the SPI core.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-sun4i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 94e1c7bbd632..59941b38b757 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -310,9 +310,11 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
 	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
 		reg = SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
+		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
 	} else {
 		div = min(SUN4I_CLK_CTL_CDR1_MASK + 1, order_base_2(div_cdr1));
 		reg = SUN4I_CLK_CTL_CDR1(div - 1);
+		tfr->effective_speed_hz = mclk_rate / (1 << div);
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);

-- 
2.55.0.123.gf60db8d575

