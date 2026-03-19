Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504233F075A
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939374; cv=none; b=VcfmhH8wZX60jq6k+jVARb7Abe9Ofnq2QqcBQhfXt7DiRfyEp6RbPHEQ3qCHiswR3nev4CwoZCE94MB+VcQCChPH+XWeQWWiJ3oLNjXDrPCQfAsLnpTWOL7GY3YqrKE1YYX7TXv7NOZzJ/CoEQdNJvvC3+G79PpUPgq9jjcxRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939374; c=relaxed/simple;
	bh=eFJ17SEXA3yxx+mKNJAWcaWMYlO+mNp7CmFTIq8Af3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfXWxFlB7LmD6ie9trjPiiuLLmGLVbmAUMe1f7IP29l/M39QQtHQA2TjIw+FoofZapRL67K/XqhEzphRh1KSRX0QdJBUBaFyNMWqXMhqrmeYSI9zreyWg+YNEjscraixo25oBDR0gWJdQmo1gfZ1C3ut/lWhj93qcXMMyBP6tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-000549-Ac; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iA-01;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 961FD50877E;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:36 +0100
Subject: [PATCH spi-next v2 02/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control
 register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-2-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=eFJ17SEXA3yxx+mKNJAWcaWMYlO+mNp7CmFTIq8Af3Q=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9V1dP+hCQ3z1lSKLPBz11d5I/9oFe+lq/uZvlnf3
 XciyL3Zp6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATeXib4Q+H+G3z52HXTmbe
 CLKVVuAXfVLTU6F2j8WwMF54M/+Lcy8YfrM2FizZZN1ZbHtv+rOvOfxGtWET1STaRGXzs9hYb2/
 1YgEA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Instead of open coding mask and shift operations and to increase
readability use FIELD_PREP() to encode the FIFO Control register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 989d0ffddc25..fdd14caf6659 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -75,6 +75,8 @@
 #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
+#define FCR_RXWATER	GENMASK(18, 16)
+#define FCR_TXWATER	GENMASK(2, 0)
 #define FSR_TXCOUNT	(0xFF)
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
@@ -319,17 +321,18 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 
 static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 {
+	u8 watermark = fsl_lpspi->watermark >> 1;
 	u32 temp;
 
 	if (!fsl_lpspi->usedma)
-		temp = fsl_lpspi->watermark >> 1 |
-		       (fsl_lpspi->watermark >> 1) << 16;
+		temp = FIELD_PREP(FCR_TXWATER, watermark) |
+			FIELD_PREP(FCR_RXWATER, watermark);
 	else
-		temp = fsl_lpspi->watermark >> 1;
+		temp = FIELD_PREP(FCR_TXWATER, watermark);
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
 
-	dev_dbg(fsl_lpspi->dev, "FCR=0x%x\n", temp);
+	dev_dbg(fsl_lpspi->dev, "FCR=0x%08x\n", temp);
 }
 
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)

-- 
2.53.0

