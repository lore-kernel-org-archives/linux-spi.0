Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32554A99CF;
	Wed,  2 Sep 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363385; cv=none; b=K4tcYmE0teXZVIVWttnR8+8vIUahh5xPiFUHQKR4emvmxshZOgsfvNApaCo/EP2NW5eYtezSghmr0MfU4fItf8ayqxsZl7DQ85f55jHRyPVMLiBiikkbkNKE9kuk+NH3y2JelmOh9fUcNjgpV3hCWc1ORG2/N9mj9JPBxXdtcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363385; c=relaxed/simple;
	bh=R3ZU8/kS8Pob+4N3MgpaA3ZAKG703jFLtNJQzuFDIEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhAn+Wsd+bPqzvWoN1ikYTY20kuS+DTZDtHnGUkmxhNlErvtbcCARg8Jm3KL1MXbAr+3K47tBnvZIQGRlukGn/HtDh10iBsvuH41qhrywiP2k81kAnKDWHMC0N1Y/aaCjg/n0zwtVWkIXYMQKKeV3i0mc9gcQmDfAQD7QF2+K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 48E442058E6;
	Wed, 02 Sep 2026 17:35:54 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x1n0E-004bxm-0Y;
	Wed, 02 Sep 2026 17:35:54 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 02 Sep 2026 17:35:47 +0200
Subject: [PATCH 5/5] spi: spi-sun4i: sun4i_spi_transfer_one(): report
 effectively used speed_hz of transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-spi-sun4i-fixes-v1-5-19985ef75673@pengutronix.de>
References: <20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de>
In-Reply-To: <20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=N+Ets8Mcr9PVPdeJK43FhH+k+VNCJ0EXzg70tuLR/+g=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsia4RT5J/Roz9vH3723sjVKP+hi52X4tmJxT9yaVZ+5l
 5lNMN2+vKOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRvdEM/8xnxBe9m9x41/Cw
 Yf2fkD+m2w3Ylou7exXcu1XM1nuzK4ORYfLE8s2TWJTN968unPXiidzEdGVlVqVN89xDDB2nnJx
 4hBUA
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
index 18951c1972da..fff0065ce9af 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -300,9 +300,11 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
 	if (div_cdr2 <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
 		reg = SUN4I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN4I_CLK_CTL_DRS;
+		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
 	} else {
 		div = min(SUN4I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
 		reg = SUN4I_CLK_CTL_CDR1(div);
+		tfr->effective_speed_hz = mclk_rate / (1 << div);
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);

-- 
2.55.0.123.gf60db8d575

