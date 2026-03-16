Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CD372B51
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650399; cv=none; b=FNQiMQEhWSN5P/tISdTyi18MqANsKJsLEtYozpTRDhCJm22vPjnFO9mkkPG+jHIQpyqsUBm9Ea9ult0GVCfNZj2rTcI59uRrjcP+O1oui4xU9oJELp+PDYa7mPtp3sCbkZzUJtvddI8jCRwHZQFoB/qybu5AkwovqYxmuFqMvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650399; c=relaxed/simple;
	bh=VcVsFXVXdBDU/vd/yvD3vUY6K2KW+9nqzUY0BQPByGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZOoJqAZMS6hwF32e8qB6drC5ijh3ez8gEyDKhSIileq5zW+53HAMALGsJ+JTS3ukkUHMamK8DwPK4rk5MLdLJtUeCxAsKzcEUyFs0HQMnsP6HLA+/JC5mSeA5D5CuIu7yfh3Zc5iSQB81olfLi83rqSmBhMXEfSmqe46Yv/hMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005SL-JD; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-000XVX-0P;
	Mon, 16 Mar 2026 09:39:44 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E19E95049C8;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:12 +0100
Subject: [PATCH spi-next 11/11] spi: spi-fsl-lpspi:
 fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a
 special case
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-11-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2974; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=VcVsFXVXdBDU/vd/yvD3vUY6K2KW+9nqzUY0BQPByGM=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvDEq3eWMtlGthmx6/k/fzkZwF285swiLVsRi7c+9
 xWu+rqe6ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEjssw/FMzjf3CfaR8QllL
 Z7hLc8in1Mnbkk8FHzRZyHtMa76Yjg4jwzlVr+u6v0JTPr3e8XHzGsmfxptWnuK8q9Q+WXnrlO8
 vs5kA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The i.MX93 is affected by erratum ERR051608, the maximum prescaler value is
1 not 7 as in the original datasheet.

On unaffected SoC the maximum prescaler is 7. Commit 783bf5d09f86 ("spi:
spi-fsl-lpspi: limit PRESCALE bit in TCR register") added struct
fsl_lpspi_devtype_data to hold the system dependent prescale_max value.

Commit 9bbfb1ec959c ("spi: spi-fsl-lpspi: Treat prescale_max == 0 as no
erratum") introduced the special value 0 to signal the default and
corresponding run-time check with a conditional operator.

To simplify the code, set the prescale_max of imx7ulp_lpspi_devtype_data
and s32g_lpspi_devtype_data to 7 and in fsl_lpspi_set_bitrate() directly
use the fsl_lpspi->devtype_data->prescale_max.

On ARM64 this leads to a reduction of the code of 52 bytes:

| add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-52 (-52)
| Function                                     old     new   delta
| fsl_lpspi_setup_transfer.isra                956     936     -20
| $x                                          7144    7112     -32
| Total: Before=19675, After=19623, chg -0.26%

This partly reverts commit 9bbfb1ec959ce95f91cfab544f705e5257be3be1.

Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 3a0e9726fa71..f2c7bb3bc4cc 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -96,7 +96,7 @@
 #define SR_CLEAR_MASK	GENMASK(13, 8)
 
 struct fsl_lpspi_devtype_data {
-	u8 prescale_max : 3; /* 0 == no limit */
+	u8 prescale_max : 3;
 	bool query_hw_for_num_cs : 1;
 };
 
@@ -143,8 +143,10 @@ struct fsl_lpspi_data {
 };
 
 /*
- * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise there is
- * no prescale limit: https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
+ * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise use
+ * the register limit of 7.
+ *
+ * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
@@ -152,10 +154,11 @@ static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
-	/* All defaults */
+	.prescale_max = 7,
 };
 
 static const struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
+	.prescale_max = 7,
 	.query_hw_for_num_cs = true,
 };
 
@@ -348,7 +351,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
-	prescale_max = fsl_lpspi->devtype_data->prescale_max ?: 7;
+	prescale_max = fsl_lpspi->devtype_data->prescale_max;
 
 	if (!config.speed_hz) {
 		dev_err(fsl_lpspi->dev,

-- 
2.51.0

