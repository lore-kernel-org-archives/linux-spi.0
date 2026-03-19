Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499923F0757
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939374; cv=none; b=VZiDw/g0oHjsDW1jyK9LnkLts2mLZQSlPJ7gUhseIX5KAj+EVPpnz0RH9KEFHGgmZWuoNqerDYTyNqMI6nhtoncMwkxmEKUHNw14eWSXWX/GPK9uTsTDWYd4svGa2jXG2euKRdHz08e4aq+hsyExQ49wuOko/mZubw5twwKavrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939374; c=relaxed/simple;
	bh=tvBQXKhpDbXnkhHjloEEnk1mbMC1sz0squTl51pxRAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAGLrEVK4pkRoxgVUbhjZ/JmKlDa9gkwdyezK14oGXbN5mkX58OW8YwqMM9S8PucSxS+oS/kWkB3e9G8IxffEH5kQx2hoDUCSOw1auP+yS9/cIAE1FiCkKUM8CylGWFWkwgA7qbd87CKTHnpRL4CVeg8XX9Gu3lTc9x+FcFA85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054J-OR; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iM-10;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E009B508784;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:42 +0100
Subject: [PATCH spi-next v2 08/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma():
 directly assign return value to fsl_lpspi->usedma
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-8-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=tvBQXKhpDbXnkhHjloEEnk1mbMC1sz0squTl51pxRAg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcozVRf5OfkmnhpX350ibBIvc2Tvtx7fRrXgXO6BuRo
 U8CtneldZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiVWsZGW7vyV6qv3m6y5SS
 tNreQO6q+54z363paxbL5vCJcJstKMTwP7/wndyZt9o7PmWZf9L5I9+iKa2xctd94ZijTmmcH9e
 +4wQA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The function fsl_lpspi_can_dma() returns a bool.

Simplify the code, remove the if/else and assign the return value of
fsl_lpspi_can_dma() directly to fsl_lpspi->usedma.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 15ec7b3a5cd1..f54b72e3a2aa 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -524,10 +524,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
 	fsl_lpspi->usedma = false;
 	ret = fsl_lpspi_setup_transfer(controller, spi, t);
 
-	if (fsl_lpspi_can_dma(controller, spi, t))
-		fsl_lpspi->usedma = true;
-	else
-		fsl_lpspi->usedma = false;
+	fsl_lpspi->usedma = fsl_lpspi_can_dma(controller, spi, t);
 
 	if (ret < 0)
 		return ret;
@@ -801,10 +798,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 					spi_controller_get_devdata(controller);
 	int ret;
 
-	if (fsl_lpspi_can_dma(controller, spi, t))
-		fsl_lpspi->usedma = true;
-	else
-		fsl_lpspi->usedma = false;
+	fsl_lpspi->usedma = fsl_lpspi_can_dma(controller, spi, t);
 
 	ret = fsl_lpspi_setup_transfer(controller, spi, t);
 	if (ret < 0)

-- 
2.53.0

