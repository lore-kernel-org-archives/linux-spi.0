Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A77382291
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=nRZhyMUMI9a889vIqCGD58n6ZmyfRy8cPgdrxUnsfd8SK77N6DjkrnZmwidPQTmDFclcv7L9Pzrj3CPVQzxelAKYNHzz/Hy0cYZWOt/73jOvGOqUx/rlrQtqETt7jMur63Fy6zTkb2sGh3qIbAwViQZVxg4g3QCdD/vovg7gfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=acNJCA+szzoHf0giaQYVW0RmFvfHGMnhFrTnqnY9u5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIGciIFNwZXH1H5OjeO/kgKZXOrxoera8EJ2TqldsxTRV4ZVO3miQrMDos5jGPCDNfoF3tjxwyoZSTB2DEOYhV5NSb+mNaH5IkihcyUYcMOH7neBO7rELAUUwHuyb5ffJkj3Kkjv3Rd8+i8v6pcN4yozTuEWR5cSo/V2cF169kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005S1-9S; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVN-35;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9E80C5049C3;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:07 +0100
Subject: [PATCH spi-next 06/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma():
 directly assign return value to fsl_lpspi->usedma
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-6-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=acNJCA+szzoHf0giaQYVW0RmFvfHGMnhFrTnqnY9u5I=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvDQu2/l7qGiYVf/dkc6zJ2y2OXQofuL3B54X118a
 86LIxWqvzpKWRjEuBhkxRRZlv44oSgQ6FDa+zJhEswcViaQIQxcnAIwEZ0ehn8KE14wcR1ewKHg
 qzGh2rqk10Cza7XejfqT5+04t2XszmVk+B/yQdSFffaKWa8sor2ili4JVF/LbN2Svvf34zVfzhc
 bKLMCAA==
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
index 1da2084f582d..76dda2c7aa85 100644
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
2.51.0

