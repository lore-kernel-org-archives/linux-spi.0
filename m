Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DE48EC63;
	Mon, 14 Sep 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400177; cv=none; b=GhZ3KHgCr90AsBd19W77/zQ5QO432576dtD9YFf2zEWayKMChTW8u+6gUnH+lFq8gf+QAKywo8Y8iyDGdRVkHYHWFBA3Or080LjoTc4MYu/B+rG5HvvAclN+6an9/bu9rcxH9N1Ypfz2UGtMUiQpop1ehJlhTk6eG1ppnmK4pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400177; c=relaxed/simple;
	bh=wu/+2GSkV2Qc9GppxtVd4a+jeqa89kwJcDEkkOr63nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVzTqbbwUwfi1veCl5MSw5K1YwjT1b2AfpcIASRgDBgtIGvipQltYMLwpGP5GJNXGIWFK/BjYUEuKbX2CRr+SQ0ibvaAPgcCRTyf2zJWVV0aPGqoZFXICQI2ma4gUvWxgIt4hrMRc55yiaWpb2+mqNdGxTVEeFpIPFgfsj9f33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 598C8202892;
	Mon, 14 Sep 2026 17:36:08 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x68j2-000vXD-0u;
	Mon, 14 Sep 2026 17:36:08 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 17:35:59 +0200
Subject: [PATCH v3 5/6] spi: spi-sun4i: sun4i_spi_transfer_one(): add error
 handling at clock setup
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-fixes-v3-5-9fe919d5cecf@pengutronix.de>
References: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=wu/+2GSkV2Qc9GppxtVd4a+jeqa89kwJcDEkkOr63nw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaIZI+8cQtzhkJtoIukyOaX323P3D3x6zK98Hxb1ZmL
 ztl/fHU9I5SFgYxLgZZMUWWWDU5BSFj/+tmlXaxMHNYmUCGMHBxCsBEZvkxMlwTOi6nbTB/1W93
 3SZ7xltBR2dGXsyw27v20PQDci08od2MDHt/GF6/eO/7/amrrqmtnJSofja98uHhF6/LHCJOPOS
 5MpcdAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Bail out if clk_get_rate() or clk_set_rate() fail during
sun4i_spi_transfer_one(). This might happen if the clock isn't known yet
or fails to set the requested rate.

This also ensures that mclk_rate is nonzero and can be safely divided by
in a future commit.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index ea8be0170fbf..94e1c7bbd632 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -279,9 +279,17 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 
 	/* Ensure that we have a parent clock fast enough */
 	mclk_rate = clk_get_rate(sspi->mclk);
+	if (!mclk_rate)
+		return -EINVAL;
+
 	if (mclk_rate < (2 * tfr->speed_hz)) {
-		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
+		ret = clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
+		if (ret)
+			return ret;
+
 		mclk_rate = clk_get_rate(sspi->mclk);
+		if (!mclk_rate)
+			return -EINVAL;
 	}
 
 	/*

-- 
2.55.0.806.gb8242b093d

