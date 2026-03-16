Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD4383C7A
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650401; cv=none; b=hss9QiR3OvDhEIOj+43/T8BQy7Q/Sx6rUzWHXHnisRLbRwEABJc0imsd0HnvOA6/A+G73I82QLE56bJF/WpaFxgeUfcIbE5/oeSHfzXjpyIvk0sY/nrdRoGeeY/HDsn9H+Zq35g4C0OUn2fArfj0dT5FGNSYBnrtqBvBaojBJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650401; c=relaxed/simple;
	bh=Xl/Vup7v7SMiBJVnSPHfx+fZf3L1th1+3qi6PfO90BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b94zYtSlibcH5wwL9Vp9in11H7fYjPSUsA11Pu7P3D/e5g1nbTWzYVjEo5PapUx1DlMl4OEvc2guhfa1jsA4U7PiH5+tYocPu51ZMrU/DXSIl4+AkSSb5Vm0sbtBWW/2uh+V70dyCXcQN2DKvt4o2DFB1BnzoYwf+fz5Vsk/WZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005SO-ML; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-000XVV-0R;
	Mon, 16 Mar 2026 09:39:44 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C9FA75049C7;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:11 +0100
Subject: [PATCH spi-next 10/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 use mode from (struct fsl_lpspi_data::config::mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-10-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Marek Vasut <marex@nabladev.com>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Xl/Vup7v7SMiBJVnSPHfx+fZf3L1th1+3qi6PfO90BE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvB4ZuYJnYeCaWqv+RgZrj0Urz9fEWSxK6znw+7Dl
 8xZL2e/6yhlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEzt9mZFgXHyPAzJCfFLXv
 /PV5R1J237pfcV22JudW0F3DWyeX7l7P8D8sf1V76ef0ogXF2bkMoZ3iv4rMFvbuF9i/bJp7/UL
 zeewA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Commit 7ae4d097b752 ("spi: spi-fsl-lpspi: Handle clock polarity and phase")
enhances the driver with clock polarity and phase handling. That commit
adds a 2nd argument ("struct spi_device *spi") to the fsl_lpspi_set_cmd()
function.

The "spi" pointer is used to access the "mode" of the current transfer.
However the mode is already available via "fsl_lpspi->config.mode".

To simplify the driver remove the 2nd argument and use
"fsl_lpspi->config.mode" to access the mode.

Cc: Marek Vasut <marex@nabladev.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9ec5554b4fc0..3a0e9726fa71 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -289,8 +289,7 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi->rx(fsl_lpspi);
 }
 
-static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
-			      struct spi_device *spi)
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp = 0;
 
@@ -313,10 +312,10 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 		}
 	}
 
-	if (spi->mode & SPI_CPOL)
+	if (fsl_lpspi->config.mode & SPI_CPOL)
 		temp |= TCR_CPOL;
 
-	if (spi->mode & SPI_CPHA)
+	if (fsl_lpspi->config.mode & SPI_CPHA)
 		temp |= TCR_CPHA;
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
@@ -527,7 +526,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
 	if (ret < 0)
 		return ret;
 
-	fsl_lpspi_set_cmd(fsl_lpspi, spi);
+	fsl_lpspi_set_cmd(fsl_lpspi);
 
 	/* No IRQs */
 	writel(0, fsl_lpspi->base + IMX7ULP_IER);
@@ -802,7 +801,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 
 	t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
 
-	fsl_lpspi_set_cmd(fsl_lpspi, spi);
+	fsl_lpspi_set_cmd(fsl_lpspi);
 	fsl_lpspi->is_first_byte = false;
 
 	if (fsl_lpspi->usedma)

-- 
2.51.0

