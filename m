Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5303F0768
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939375; cv=none; b=gUHFis7Q6LO/z2NQuQGUA2iAQdhZOI43zgfFTjEFiGfAEylVkGZXX517R+LQICPcK8/wu9boDMpqTVziaTdwjZgWyd2RQx/93luQF2izUllCuTNoMOe90YSCeCEO7/xHxahE+dsIhnpcIEQfciH2FZzYZDfDYRNeSkGgUP+WLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939375; c=relaxed/simple;
	bh=cewxigfhr8A62nFh2/tWGpwMAz9fbmcaksUZ7wDWT78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5bJ99X3zpSZfdpetMP+qxBnTztZmhbTDpdm/yw71TFDRG8J1HJWhvNBzvbiTcWB4Z+7AjRF/V3Iozsms484WS5vukFlqo2fUFTUfhqmug5nE6Z82LaWkR2hkt+IeQr/Kd8ScFJWbDJiE+g/gwB9xiDJ+Wz5d35du8DjYI3xXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-000547-Ad; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf0-0016i9-2v;
	Thu, 19 Mar 2026 17:55:50 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8AB2650877D;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:35 +0100
Subject: [PATCH spi-next v2 01/11] spi: spi-fsl-lpspi: adapt to kernel
 coding style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-1-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=cewxigfhr8A62nFh2/tWGpwMAz9fbmcaksUZ7wDWT78=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9V53zDzykF/+djlAikzU0/2ci2ONmlveRe7UWPrz
 Zbue26iHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZjIPyZGhp5z9YsMTwdYWDbk
 K12epenaaMzHtUxC84PzdJt33689ecDwv3L5oYRD+ro6rjwnVweYnc6I/cR7jMvA5t7KtTXxeg7
 8LAA=
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
2.53.0

