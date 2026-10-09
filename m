Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB04CB8B8;
	Fri,  9 Oct 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544581; cv=pass; b=hhrFKEuJtjQYJj0BOftjVmm4oousBzo+IfDZtOEstdEDKCtv14b+qcyQn6kkJYCfVZ3EsX807pn7gzirCKtJDwF+B1tC1UFDk0PAbRwxKmlCm+0RqzBEEJyE7BiMAYcr0pMNvqd5+AdlXh93/TCTo690B1Bnt0vda5s3rz3s0d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544581; c=relaxed/simple;
	bh=dHwytyeA15MeT0//GiTOOS9A6hm3sL0ydWHgSkt7q4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooAIWO8FtOCjAcxKSFVW7qWXFtm4fzfUUnLzi9/Y01Te1QHDJt2zMWcNg1RxDgQyhm873B8tlosMV9V7g0sAiGRTVwJmhpBBGYDeoH+CHE/vj+V4ViJTCbQcmi9LhjjD9jydodBJaHIDAROkuVdjz81epAp0FNW3BPRep/lg+R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=H65OHf+M; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="H65OHf+M"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D65072025FD;
	Fri, 09 Oct 2026 13:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2ECpc0h8QRZQRyYEuQrJMo+9YeLkbge29KrUiKLjF0=;
	b=H65OHf+MQxyknjhEs4oOyPt7t94S3bgVI1PQfGg34fzjq8TITgziddPXbxHFe0D1jne1mJ
	uRYvR8VpC8eOe4soGo+lGexucjvjdqPCNtyoZcKBn8f4TdwnwkmEoFRudKwZILBHXGvaZL
	u/p8oXHZRyRcpCZ6lBnqpNFd+uFF54pc5kxVOeYTSPbMJrzt9INpskrs+pyrSF0CL5uuo6
	hxwMWjFwfRBBRpcfHFWVVbZbiedz2LJxcbpQKfH/XPwpKjz2Kkxlt9qOmjXje56etTH7XN
	s/UETiVTSmDVUuKTnzcIXbFAiz0UpbSuVrHBkuNvua1LdmX1VGbbzvhuD0UQ7Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791544562; a=rsa-sha256;
	cv=none;
	b=gHtr2goO5267aZCFQ4GhGA06Yu9n2hOT/VrfmJZQMr3LxX8MaXYXjeSeTpdgOflPDIAVcv
	Xu9X+zA3tkvcrwhdyZ7kp3ajzhZA4HuoaJGjAoO3UhBalIApJoj4d/AaFvJNtQr3FmJstb
	3w4asI1rt98y+VVfnCxUOvxfVz62Udu00NUxfYDq6VzpQcvUf378XeHToHS9/Lp0REkgXb
	LsfwefqYNZZtZNSFYUL+F3gy9erR96l8TY7xjW3j/ZVtjYKlJ/W14haKtS707JacSft0lH
	Z4LmmOXkYZAu3IahzbscCVrCYGPrCUVvsd2WKpy2Y9s52IJOSDNxn6SETzpm5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2ECpc0h8QRZQRyYEuQrJMo+9YeLkbge29KrUiKLjF0=;
	b=HPqifyAwl5n1MEJSDDuj9ZnA9AB4NPIh2ubuIjx0pInIgtgomHXxPCLTD7k4/8VexohzKL
	zokJcy4+CVofYVW1WkQvb5q2cTcPeD4SveXfCOi3BatiQRZqtEtnxNYo3ru4v7mYD4RIIo
	SjyzQ2KuwvgGVfrgluil0V2+e2Q7m0a9SvYH0Zp6hbpZr5uP+xBnhURkFJs1L61z/WGdbq
	o+I7FjHODwDb2jDz9KLxLqnoGcChaAoRQdTQQqjPsUajqyiocC61sRBnj0TbXaG8PQFHjT
	Jz6C1LVzeYLM10EZFqcl5vmPsBThyl1vHN6/rS0NoShYx00CG/28QvjcblNa5A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF8a2-0052ME-2Q;
	Fri, 09 Oct 2026 13:16:02 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3DC705BD5D8;
	Fri, 09 Oct 2026 10:16:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 09 Oct 2026 12:16:35 +0200
Subject: [PATCH spi-next 1/3] spi: spi-fsl-lpspi: pass struct
 fsl_lpspi_data instead of struct spi_controller if possible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-spi-fsl-lpspi-more-cleanups-v1-1-2d4549d5205e@pengutronix.de>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dHwytyeA15MeT0//GiTOOS9A6hm3sL0ydWHgSkt7q4g=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6sZ9tn/deE56FUz7HiK/WTdDJ2h9q1b9vlvK2NT4rd
 U1UBJOFOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRr06MDD+2/1zlItv0XKgt
 n49Vzo+177D1odB/dX6ScXa7Ztdk9zL8r5l0eQunAaPlVe41X2IutItxd93dxv5qni3Xh9cVP3k
 /swAA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Instead of passing a spi_controller pointer to functions and using
spi_controller_get_devdata() to get the struct fsl_lpspi_data pointer,
directly pass a struct fsl_lpspi_data pointer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 5aa0a75b4e57..a3c5bab1acc7 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -550,11 +550,8 @@ static int fsl_lpspi_target_abort(struct spi_controller *controller)
 	return 0;
 }
 
-static int fsl_lpspi_wait_for_completion(struct spi_controller *controller)
+static int fsl_lpspi_wait_for_completion(struct fsl_lpspi_data *fsl_lpspi)
 {
-	struct fsl_lpspi_data *fsl_lpspi =
-				spi_controller_get_devdata(controller);
-
 	if (fsl_lpspi->is_target) {
 		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
 			fsl_lpspi->target_aborted) {
@@ -758,11 +755,9 @@ static int fsl_lpspi_dma_init(struct device *dev,
 	return ret;
 }
 
-static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
+static int fsl_lpspi_pio_transfer(struct fsl_lpspi_data *fsl_lpspi,
 				  struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi =
-				spi_controller_get_devdata(controller);
 	int ret;
 
 	fsl_lpspi->tx_buf = t->tx_buf;
@@ -774,7 +769,7 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
-	ret = fsl_lpspi_wait_for_completion(controller);
+	ret = fsl_lpspi_wait_for_completion(fsl_lpspi);
 
 	fsl_lpspi_reset(fsl_lpspi);
 
@@ -803,7 +798,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 	if (fsl_lpspi->usedma)
 		ret = fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
 	else
-		ret = fsl_lpspi_pio_transfer(controller, t);
+		ret = fsl_lpspi_pio_transfer(fsl_lpspi, t);
 	if (ret < 0)
 		return ret;
 

-- 
2.53.0

