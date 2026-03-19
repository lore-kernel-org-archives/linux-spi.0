Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D23F0750
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939375; cv=none; b=KKDeGquKRe8sXbsWBzF9dot952MmzpLnzAALzfmCWhin0u8P8O4cyFJkll9UezIXib+XOS+evW6FDWiePZtHCKkXD85ZUU4E6bfqTwCVFqIPohh1zSsel3yXvi/kfQIWMbQyjc98gxVv+mMoWp0Y4lT1nNfvF+ii7NNCTjXNGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939375; c=relaxed/simple;
	bh=UWUiatWg4MfD0SI42Vpr1GV3NKMVjp3KTsoMTQ9uxyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhs/H0Kjqh9X8xmnXn+rhU0M5OOc1Kw8DYdeOE9rYrE93OSfTtvmuZDbF4eR33M+jUxmvUQhmwHBXsKOfez+ealb86XmP2IWRYiNmmiN3PEIqXWLHSiY3RwgOH9DyhhhKxhgnzEPIq5uoor4YMEjLI71UlJgZAxhqqinAd2IuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf2-00054h-0S; Thu, 19 Mar 2026 17:55:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iN-1M;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EF7F5508785;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:43 +0100
Subject: [PATCH spi-next v2 09/11] spi: spi-fsl-lpspi: fsl_lpspi_reset():
 convert to void function
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-9-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=UWUiatWg4MfD0SI42Vpr1GV3NKMVjp3KTsoMTQ9uxyY=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcozWpkl+1/ebRH46MB/fXN1isunLY9hj3MYZwDZcZm
 5rN3+bu7ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEvNYw/A/r4HnFG5X9xZ35
 S3paarjOTdeHx3S4TE9zJC/w0bvpq8TI8D1z+nePyt/vOY7VaX5bofyxJuhfi77UNIYlzXOM9l/
 /wwUA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The function fsl_lpspi_reset() cannot fail and it's return value is never
checked.

Simplify the code and convert it into a void function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f54b72e3a2aa..9f0d7b9ce2ab 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -578,7 +578,7 @@ static int fsl_lpspi_wait_for_completion(struct spi_controller *controller)
 	return 0;
 }
 
-static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
+static void fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
 
@@ -593,8 +593,6 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 
 	/* W1C for all flags in SR */
 	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
-
-	return 0;
 }
 
 static void fsl_lpspi_dma_rx_callback(void *cookie)

-- 
2.53.0

