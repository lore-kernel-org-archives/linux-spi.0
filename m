Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9609E34EF01
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=EXU58/ia5oGxx3PK7MSIb+iwS2p3q8vkYxFWNcr2QatalauVnayizkSbAQFEjknRh6PP/Ts//lkP7XTJRlL3rQxSue1+UovJZpEJiUG1vngHopx+llUiagt9+o7V56AoOEn3+bLMy8JAllhQR40ND6OeqG/xAz9KW6qQZm/2+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=5rydyZLGpSkjEvcQg7H2/5j0Nfc28QBa1MSkF9ckga4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOhlRRpjpxJ7QkzFwEHg7gzaVLwDG9HU9/G27yUo1pfX3isjn7wnqrilI87RR5rOovGCiDAd6dHUwHhbbWPLEPdFpmzlMix5IlCFSBPqjPk19UQQ1B7qTSmXVt5hHT52GGX091ChLG/qKXrZe5yMYjCqVqmFb3hh6icwgZbZYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005S2-DT; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVO-3B;
	Mon, 16 Mar 2026 09:39:44 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AA7B65049C4;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:08 +0100
Subject: [PATCH spi-next 07/11] spi: spi-fsl-lpspi: fsl_lpspi_reset():
 convert to void
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-7-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5rydyZLGpSkjEvcQg7H2/5j0Nfc28QBa1MSkF9ckga4=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvCw7LFA3/UPGhQ5/9c3em37nbpzq+1J2WJdRnWbX
 8ZhrdkbOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCR3fsY/uklLuGwSW9JlhJy
 lK+ts/Jnre8Lnvrl/LwfKmVuSSLnyxgZfm+95L/0bnW5jL3p7alfb+5hVrxX82JaxJX8/Iabdcf
 K2AA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The function fsl_lpspi_reset() cannot fail and it's return value is never
checked.

Simplify the code and convert it into a bool returning function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 76dda2c7aa85..920748795314 100644
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
2.51.0

