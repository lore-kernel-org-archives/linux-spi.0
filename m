Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDED3822A0
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=T2VuMTiGzyf/gwT3QJ2Vgm5AkaP0mPISq6O1/8xCewPWq1ifGujBkPdCuwHUKJg50u0P+1QWaKOR1ICyhKBojoK3ZKE/vWGraqTiIERARMnVDX4C/QWokpavhFU4T/k3enoiwsBvRBLCJRjz5WDuDwrPwXB4QWXyKyhNf+OjTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=ZrkmyysVLpLzso4QTKvAnnm8NM+EluwdOKygUeYeVXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nw8OcLi/W0ow+kusR17r1R/yY3nO5Xj+O7QowGpErbh8v2m5YnnH8XqlGgwyeiH3aty6UFdgsuYN4ALwPMQb7j1YFEruu8JbZzRa52a5OCSvKqwEhIJgdlowRCIR2pr2UxaYBS9MSu4xZDVo/tsJYtlti7DRz/EeWxa438nI+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005S4-Gg; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-000XVQ-04;
	Mon, 16 Mar 2026 09:39:44 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B55E95049C5;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:09 +0100
Subject: [PATCH spi-next 08/11] spi: spi-fsl-lpspi:
 fsl_lpspi_write_tx_fifo(): simplify while() loop check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-8-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZrkmyysVLpLzso4QTKvAnnm8NM+EluwdOKygUeYeVXg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvBo5Y6d17I3z9OJlkhYs+una2m8+q4bjg8nzVIol
 8z5HbZ/aUcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmcjGNkWG955+Wj50VEyab
 au17OTHY5cCHLFt2f+1f/55pPErKNchh+GfJ9G+VaN9i5b8ei7sPVF6IOf7r4OUZszUvfFm0W27
 fLgUWAA==
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
index 920748795314..ae06bc06f626 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -265,9 +265,7 @@ static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 
 	txfifo_cnt = readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
 
-	while (txfifo_cnt < fsl_lpspi->txfifosize) {
-		if (!fsl_lpspi->remain)
-			break;
+	while (txfifo_cnt < fsl_lpspi->txfifosize && fsl_lpspi->remain) {
 		fsl_lpspi->tx(fsl_lpspi);
 		txfifo_cnt++;
 	}

-- 
2.51.0

