Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492713F0754
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939375; cv=none; b=V8T/cxNxeDy97hwCUmAHjxKCBvfQ0e73wChUJ3uyTh1w/ts9EqeMQy754vEBtPiTB1F7SAhH55zDFQeXkQgAZ08RX9J6HPDn2HWlArsMI+zIypwt4oQo55QCstGtm88C3rkc/paHddzSazU9ojYqyOZ/AVBSd0xr6ikGHJgD/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939375; c=relaxed/simple;
	bh=ZlPwpl16UHpdcmGdEM2Pg3oWIFE6Wu98DdD6pPcKcVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+08yh39On3k4+ix7m/9hJdwRbkinA/oFfg+NDo26SlDUr/10MKYFkvN7SyUo97uBw4eOniWLthNiAxO8s2yD+HlCci/vhagAgXPQI82alHFHX6g3u2eh1Rf6rm8hbazUhUSogl8I1tJGpY22BO4I5S2Nb07EkjMdk1Idy1/QxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054A-Ed; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iE-0X;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ACAFA508780;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:38 +0100
Subject: [PATCH spi-next v2 04/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 use mode from struct fsl_lpspi_data::config::mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-4-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZlPwpl16UHpdcmGdEM2Pg3oWIFE6Wu98DdD6pPcKcVk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9WzJtNL8eObx54unZuOq3jO+Wb7M1QtUM3p+60F3
 aUWVx86d5SyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiDHKMDNMfxhr9mt9ybvE8
 u9bfMunHBG7+Xf+u3PHIpACm9oTwFdoM/8z5jI3lmL2mX3843Zn/Pf+Sr+kCx5Lmdxg3f+UVE7E
 1YgQA
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
Reviewed-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 75f4e0e9acee..c20376da1d37 100644
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
@@ -533,7 +532,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
 	if (ret < 0)
 		return ret;
 
-	fsl_lpspi_set_cmd(fsl_lpspi, spi);
+	fsl_lpspi_set_cmd(fsl_lpspi);
 
 	/* No IRQs */
 	writel(0, fsl_lpspi->base + IMX7ULP_IER);
@@ -813,7 +812,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 
 	t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
 
-	fsl_lpspi_set_cmd(fsl_lpspi, spi);
+	fsl_lpspi_set_cmd(fsl_lpspi);
 	fsl_lpspi->is_first_byte = false;
 
 	if (fsl_lpspi->usedma)

-- 
2.53.0

