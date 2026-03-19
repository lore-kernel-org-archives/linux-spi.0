Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067E3F075E
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939376; cv=none; b=eJ0renrAG3QMoaDh25Cay8vlLRBqUEnuVJGIW5XXLDaPhhsWPnkx47PgKkeGVvgtIZCUj0OEBtI8tkmFD9GGvB5/g/oj/lkYp/jVZAL//Imqc8H4DTWuyGbH1YPsEuk1YjylcvcmrJG5qEF0avw7XVqi2zwy40dfmf2uuWg9QkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939376; c=relaxed/simple;
	bh=BE/l40T2dZDyBtEpo7B8D85pG0t4e3LG06EbT0RmnJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxdLR33n5mU7QRhWUmbKUl5eqdLlM7RUKV+3rvvNKkkauIUH7SmasRfOIDj66V0HSEq464dUOepSqWSaqPkqnNZL0Sc6ELhohTUk/KWFdv5dASbdsTfu8895KnfVbF43vDBGg4FEs8c+UVJixgBuOyWtm56LDu72k6vEhygndLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054i-VT; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iS-1U;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0AF63508786;
	Thu, 19 Mar 2026 16:55:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:44 +0100
Subject: [PATCH spi-next v2 10/11] spi: spi-fsl-lpspi:
 fsl_lpspi_write_tx_fifo(): simplify while() loop check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-10-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BE/l40T2dZDyBtEpo7B8D85pG0t4e3LG06EbT0RmnJU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcozV59bzffLUKcwTuyQf6PBJx32Jh9m/RQ2UmaQnv6
 f0S/0IbOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRPF1GhsbdzzmcPbu4povI
 suZHb+R9tc9Q8fzq38YG9TyrGrqXhjL8lbulfnhHxeqoI8YNPIbFBrJi62dssLl34LRE0DpJm0U
 pHAA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

To simplify the loop check. Combine both conditions of the while() and the
directly following if() into the while().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 9f0d7b9ce2ab..3265618704b0 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -267,9 +267,7 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 
 	txfifo_cnt = readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
 
-	while (txfifo_cnt < fsl_lpspi->txfifosize) {
-		if (!fsl_lpspi->remain)
-			break;
+	while (txfifo_cnt < fsl_lpspi->txfifosize && fsl_lpspi->remain) {
 		fsl_lpspi->tx(fsl_lpspi);
 		txfifo_cnt++;
 	}

-- 
2.53.0

