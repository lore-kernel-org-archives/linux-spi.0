Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADF4CB8A4;
	Fri,  9 Oct 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544581; cv=pass; b=fdyBWL1mjqpLBwgQrkiNLs4ZhpgsZYLwxTZfdMYDuihVOlS8tmhBdVg/peShtq/8xjKMjgMNirpED+TySajsrwN6HjIqPtmHWzwLOcEci/YDUTnJMe98W3umrMxcFDmRyNQRxJ75Z84JK/S8S3H0WveQuCT2quw2/saUiLWba5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544581; c=relaxed/simple;
	bh=yuuTZi5g6+/QEL9mb5ouCnMndqwxHWhCSr6zvL271SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n78UDG6zTqvHPZn+QjBDsg4Al20CrF16Geen4DjG+oVmQNuEFI4Ug5y+UJcybRg3RrTA23wxqS4+V7FeJehWkGNzx7DwnPC+SekykuupuCqLCC8q/f3e4fW4z03XAzheCyyL/2frZ4jJU6aOLQAcx+FVqXUdEfBpFsKdMv+EmEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=c1qBxbUm; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="c1qBxbUm"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DEE6D2025FE;
	Fri, 09 Oct 2026 13:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTxug7Uq1GtluNa9ePgHNiaobPPxzLSeaIvJXt4Iuj8=;
	b=c1qBxbUmaaq+A/zZPcnBPfG2de8/gnwtiZysWtr+cfMB2nnGw42lHzBx0vGmhnR4T1DXBC
	5Ug8GzNTk7jQkIuhVYqGhhbyw0Aggb90UD/fWXKiV9KjAoiOP2anUJfPR1fAH8iTfQNukc
	nq84hnkARKYWy8xSxfTBtzzVvpwK6Lgn/DFNF7+lkvaAShE6APYvNx2ts92ZRkA6RLixVT
	+s6NwEAg9BYW/KfW5yyuH5qxNCV68uuTJ0+24pQ5fD9qgMmo94mYphMTovMwcsvrbH/Iph
	cCn6Em5B8pqhYwzK6EZVZwP+ZFJeB8x1MV70fSHdKYI6Qf8bt8rLMcEPLW8eKg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791544562; a=rsa-sha256;
	cv=none;
	b=DWmXx9vzTMkUsTB4W6hbdQQUjki218BPShT5qFpTGlSMkqD86Pt+kxRfgnCTOKCSY2jmgZ
	BUNY/fIeHUxKsf4QbVNFsUDtthquSE0wRNNhXSw3bzRk2ZdxXAtI5FUCPHMbf5Wp7LrQRm
	hVWkPXAkDVend2I8GkFIROB4Mx+rNyp5VWQFXAS7kM8f7yWjyA5hrpPrTVSpZY1AmisJWh
	S46CzEgPs5VkkhMbw2eu6vXD2KdTAeb8fTD2dkljShHnR0zdrojitp8b0qX0BVLpwshRH5
	9gquka4GeYS5WHliPzaEX5v1g57ESQFOaScIXw6WshCJ+qXj6YZ4Mvlaspr7oA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791544562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTxug7Uq1GtluNa9ePgHNiaobPPxzLSeaIvJXt4Iuj8=;
	b=KtcoMjHY5NYUyWcEW70I9PKYA/HwDitwIZowKY1Hq6GvvDReyP41bZ2uJ6q2/PktHtbWhq
	z0Q8ziRVu61wDUqQM7is1VIBfJGtu+VZxX/Z6KL0d7XYaFtU1CMDEtr0reZKyRt/GUr4Pp
	oY+BQG6O8SpQ4EUNq8q/hLQHJiE4B5kG6I7fQdUrjg528hrPJa7A8J6btUDHheZChxelf6
	sN61ZPWf/f7KW86bg/7gC6OEcEHTlLduzI6JmHOewa+s69af4iaNeGTwRC680HccdaW/tf
	IrGj0fSPxZQWtqpZduuF0yxvujhVqr4DL8Z0p9BNey+ceBIsS9a+LHAvCLL9og==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF8a2-0052MF-2Y;
	Fri, 09 Oct 2026 13:16:02 +0200
Received: from hardanger.blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 74BFA5BD5DB;
	Fri, 09 Oct 2026 10:16:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 09 Oct 2026 12:16:36 +0200
Subject: [PATCH spi-next 2/3] spi: spi-fsl-lpspi: fsl_lpspi_transfer_one():
 directly return ret
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-spi-fsl-lpspi-more-cleanups-v1-2-2d4549d5205e@pengutronix.de>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=yuuTZi5g6+/QEL9mb5ouCnMndqwxHWhCSr6zvL271SA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg6sZ/dp+3JhVffmdgeONv/3MinPys8RT2g08KK/66n+
 b8ntyqcO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRK7oM/6NF5K9oLfilPd1K
 /b+YzAnJKzPsCu9fl3y7d46M/5KYXgNGhjtvtdXO8Gq+bRFQFdHQtMrxLnrLZizjkLT+z+snqb3
 /GAA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Both fsl_lpspi_dma_transfer() and fsl_lpspi_pio_transfer() only return
negative error values in case of error or 0 in case of success.

Directly return ret, there is no need to check for positive error values
and return them as 0.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a3c5bab1acc7..b25f94b2ef73 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -799,10 +799,8 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 		ret = fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
 	else
 		ret = fsl_lpspi_pio_transfer(fsl_lpspi, t);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)

-- 
2.53.0

