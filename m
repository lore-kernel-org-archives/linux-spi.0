Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052C3F075B
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939375; cv=none; b=cKSM+OgjAPT8CduZvQfi7YKYk7APPgOct+s+eG3bvQ4c6w6DQTBTM73DicDOv67ao36e9lGFkX1JDwK6MIsImSDf88TILeurm5CcxE5ZW7ABlQGx4QG/RzyqM6fKuCXAwHh34a6gU8weIJNichyehrzo5ZBwqLtYgt1b9zlIIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939375; c=relaxed/simple;
	bh=LNugL5fW2X1cEj7zjSNuviQZrKi7Wm/l+PYVtQ45H74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGbkn7TvZUfvQX8e/72AvCT/1+65NL94KQrjIbM3+aup/wdKwQdKMb5srb4wacZuROnUG8tbV2RZbYYilgcatCuzX0o1u59VElyhnUYt9ZlLZ3UVeN0HI6HKSmSs8BuJ+zuC7eebH+cywF7wFY2NFb6S0FSdW86NbT/PSqd8jwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054E-P9; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iL-0o;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D127C508783;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:41 +0100
Subject: [PATCH spi-next v2 07/11] spi: spi-fsl-lpspi:
 fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-7-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LNugL5fW2X1cEj7zjSNuviQZrKi7Wm/l+PYVtQ45H74=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9X/dc+TtJzE6dOfXjKTVrnfubD8sYHEJKmPhw+XW
 V3TD5rQ1VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJRB5j+J/62nZ64b1jX1pe
 nv8zq4tjoUH5+u8uEyaY/V8guIXnwj9jRoa+5ZuV4q7qVTYxflFhevXodDtLhsZ82SuOvNMFEk2
 vfeEBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

fsl_lpspi_setup_transfer() is either called via:

| fsl_lpspi_prepare_message()
| -> fsl_lpspi_setup_transfer()

or

| -> spi_transfer_one_message()
| -> controller->transfer_one == fsl_lpspi_transfer_one()
| -> fsl_lpspi_setup_transfer()

The first call path already has a spi_transfer NULL pointer check, the
second one explicitly iterates over all spi_transfer of the spi_message.

Simplify the code by removing the useless NULL pointer check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 38e4e991e97e..15ec7b3a5cd1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -476,9 +476,6 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(spi->controller);
 
-	if (t == NULL)
-		return -EINVAL;
-
 	fsl_lpspi->config.mode = spi->mode;
 	fsl_lpspi->config.bpw = t->bits_per_word;
 	fsl_lpspi->config.speed_hz = t->speed_hz;

-- 
2.53.0

