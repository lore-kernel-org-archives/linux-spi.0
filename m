Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DE3F0767
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939374; cv=none; b=Q2bQV/4LOmotu0DsFSBZ8mVg9Nem3ksDtncpQ3M/Dnb4oabbrvVPzTaTWpBdMx2amhhsSYDAsKNmVWQi4tvYE9OYSOuF5pAiqLG7sg/jL2vfDfSW7F9LNFYAM3Zsj+zHDqoLIHWUfh/8mACMMFbaZ0mIpPDcCIiShP2FUsMXS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939374; c=relaxed/simple;
	bh=q2mJy7eypUAaxJ3eYEvEi0fYF3PcXvRF1wjPDL8lxOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EtIoJ46ZRaysLMOZcWZbQN9DFsA/Vx2HPvAsmt+hYXTv2sfY/Rq+I8t5UcfB4gC4Pr9gtvNAocM9obrUE5wCfTi1grtro3vqRM1H0KEys5gZ+Qtr81DIyRNdSELzdoEyolfS/Us7DvH2OsdkD9kpd8ofkv4swkhQLns9tRP1+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054D-Hm; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iI-0c;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2E5F508782;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:40 +0100
Subject: [PATCH spi-next v2 06/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 use FIELD_PREP to encode Transmit Command register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-6-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=q2mJy7eypUAaxJ3eYEvEi0fYF3PcXvRF1wjPDL8lxOI=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9XHW7vX9duz/fOFtlsEXZORiXmQ7Xp17TOBh1evu
 dcmP+c+1VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJKDAw/I/Q/s5d5dmzeSfj
 13/lfcavUrI0L9o3pl/M3K6y88VyIRuG/4HibovZfdft2HnWIHv1tLAqrolBnXM9P641Cii6oR2
 wmgsA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Instead of open coding mask and shift operations and to increase
readability use FIELD_PREP() to encode the Transmit Command register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4cf73e56d2f2..38e4e991e97e 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -86,10 +86,14 @@
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
+#define TCR_MODE	GENMASK(31, 30)
+#define TCR_PRESCALE	GENMASK(29, 27)
+#define TCR_PCS		GENMASK(25, 24)
 #define TCR_CONT	BIT(21)
 #define TCR_CONTC	BIT(20)
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
+#define TCR_FRAMESZ	GENMASK(11, 0)
 
 #define SR_CLEAR_MASK	GENMASK(13, 8)
 
@@ -293,10 +297,10 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp = 0;
 
-	temp |= fsl_lpspi->config.bpw - 1;
-	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
+	temp |= FIELD_PREP(TCR_FRAMESZ, fsl_lpspi->config.bpw - 1);
+	temp |= FIELD_PREP(TCR_PCS, fsl_lpspi->config.chip_select);
 	if (!fsl_lpspi->is_target) {
-		temp |= fsl_lpspi->config.prescale << 27;
+		temp |= FIELD_PREP(TCR_PRESCALE, fsl_lpspi->config.prescale);
 		/*
 		 * Set TCR_CONT will keep SS asserted after current transfer.
 		 * For the first transfer, clear TCR_CONTC to assert SS.

-- 
2.53.0

