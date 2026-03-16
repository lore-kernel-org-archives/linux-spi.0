Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03554381B15
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650398; cv=none; b=C7HVxZTJ/mV4atOmaDyCQUhQBBp/KDesPH3X572kru3U4jWlzGG4GYKcewfv12+LnIE9s0jhriS4DBTnlN2uhFUON7YXgoY4YIYXcAHmGb3Ix1KrdFm2W4bYde0O3QCKsk/rxL+uMGsmcy5dbgXrYV+u/UjtS6HHLFYhOWrEk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650398; c=relaxed/simple;
	bh=SHz4NE4IKRYQ0CsRjkTYWjUFChKza2Kx/M8C2LxWvwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGeUNIMUNseIwwbtA4cUyieX/J24Th5xkYx/x3gsRKAKfTaDDOEyRCovZRnD4d2htEbnpaix8wwGSbeGfUhp9tnJyP8am/RAavSKFyHqJJIWjcEsLBYM2zqPuQgLYOHAceA+ugouPnM1mZd0XijzwBYd6ks2Vh8Ah/NDWrW+Qyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Rv-24; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVE-2L;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 69B2E5049BE;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:02 +0100
Subject: [PATCH spi-next 01/11] spi: spi-fsl-lpspi: adapt to kernel coding
 style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-1-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=SHz4NE4IKRYQ0CsRjkTYWjUFChKza2Kx/M8C2LxWvwk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfnDvpAO3+X9F+VUoXd8RXSnHeN+mzU17z3sbh7nG+
 jWv3/GJdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiGjsYGXoTPW2+vIk+dfTS
 r3NlThXdR/a5vT7Ln5t2dqPsfDf1ddKMDNMv2qz6xT7R5J/sG95l7WpcfdkM4SukFuyzmsubsqR
 LkgMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Adapt the driver to current kernel coding style standards.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b361c1bb3e43..989d0ffddc25 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -112,8 +112,8 @@ struct fsl_lpspi_data {
 
 	void *rx_buf;
 	const void *tx_buf;
-	void (*tx)(struct fsl_lpspi_data *);
-	void (*rx)(struct fsl_lpspi_data *);
+	void (*tx)(struct fsl_lpspi_data *fsl_lpspi);
+	void (*rx)(struct fsl_lpspi_data *fsl_lpspi);
 
 	u32 remain;
 	u8 watermark;
@@ -271,8 +271,9 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 		}
 
 		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
-	} else
+	} else {
 		fsl_lpspi_intctrl(fsl_lpspi, IER_TDIE);
+	}
 }
 
 static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
@@ -348,11 +349,10 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 		return -EINVAL;
 	}
 
-	if (config.speed_hz > perclk_rate / 2) {
+	if (config.speed_hz > perclk_rate / 2)
 		div = 2;
-	} else {
+	else
 		div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
-	}
 
 	for (prescale = 0; prescale <= prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;

-- 
2.51.0

