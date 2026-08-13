Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C43B6E2;
	Thu, 13 Aug 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608054; cv=none; b=fWz9fKEcGt+nlgSOjitVXdOpZuqt0YEvs+5DBoWbDgFQ4hB868P4vupUgcb5iXc8VJFW7k2wvf1WW3iA5zlHvVYLMWDrqm5qwoj41TApBJjHXdyd5hczjnLBH3bdnqUP58aOWbXLXOjT2cIshUC736kZb01kqZkn0vQ+7V8/asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608054; c=relaxed/simple;
	bh=5r10Z5YAkTY7zx2eXhOuwocd6nGgofKPRvCnBmKlQ0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t06M84AzKynQSXXF1q0+eUalYF6HRx4n8hPDokxRUr+9EXv+9vz2XQ8Xe0TELCM795utmXIjKKAcIB6yA6bovrXXUNBljGBhkILPI4yZ7dFi8Kgq8/394wmZYEhtjaHIdQjgQKv0R6kFK8qWIbUtcHOVn/BGOAzKElaw3RGYDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ib4VW7KY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ib4VW7KY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 41D611A15EF;
	Thu, 13 Aug 2026 08:00:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 157C1602B8;
	Thu, 13 Aug 2026 08:00:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 883CC11C4DA87;
	Thu, 13 Aug 2026 10:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N6G3NRNZL8dSdQJqaXUc7ZO7iQogO5DBd4K7lMUQSdA=;
	b=ib4VW7KYU46KzTXHYDafEspQZM4S0cqhD1JqOA6kHiAMR1t96rkndmvEXnUyFyWu62pRvw
	lqseLjWi8grmQtjTm/FNTVZUj3sehmAkn1UxOUrSTFRtUtSg82UETwqqmLLt7lFmMUzzeT
	nVeHPxkpNTBgJo69u9jNbGNpCqnGUrFNfNEWqJlPySsfcixqd7ezWFjkI6HeA85W3WtkFU
	OwLkhSfrxUpptGVFGBuf0v7Z5QcsoVbVe5mqBZXHKTWxqmjTekIp5gsEG1KDdrpS6qrH/x
	4N2lq6qx6jdcW9mgusEZpG3pwMjuIqYZhQM3F7gbxyy1u0p+v8JQ39er7cy1Qg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 13 Aug 2026 10:00:22 +0200
Subject: [PATCH 2/5] spi: ma35d1-qspi: Move speed setting to bus
 configuration
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-2-b217b9870eb1@bootlin.com>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
In-Reply-To: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The speed setting is wrongly placed inside the "setup transfer" helper,
since the bus configuration may require the speed to be correct. Indeed,
DTR mode (not yet available) divides by 2 the bus clock when enabled. As
a result, to remain at a constant clock speed (and improve the data
rate), we must double the bus clock when enabling DTR. In order to
prepare for this change, move all the bus configuration required for
each step of the operation inside a unique helper called
nuvoton_qspi_configure_bus().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 69 +++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 929546dbe38f..b4fd0ab4bd31 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -131,11 +131,15 @@ static int nuvoton_qspi_reset_fifo(struct nuvoton_qspi *qspi)
 					 1, NUVOTON_QSPI_TIMEOUT_US);
 }
 
-static int nuvoton_qspi_set_speed(struct nuvoton_qspi *qspi, u32 speed_hz)
+static int nuvoton_qspi_set_speed(struct spi_device *spi, u32 speed_hz)
 {
+	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	unsigned long clk_rate;
 	u32 div;
 
+	if (!speed_hz)
+		speed_hz = spi->max_speed_hz;
+
 	if (!speed_hz)
 		return -EINVAL;
 
@@ -174,24 +178,16 @@ static int nuvoton_qspi_set_bits_per_word(struct nuvoton_qspi *qspi, u8 bpw)
 	return 0;
 }
 
-static int nuvoton_qspi_setup_transfer(struct spi_device *spi,
-				       u32 speed_hz, u8 bpw)
+static int nuvoton_qspi_setup_transfer(struct spi_device *spi, u8 bpw)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	u32 mode = spi->mode & SPI_MODE_X_MASK;
 	u32 ctl = 0;
 	int ret;
 
-	if (!speed_hz)
-		speed_hz = spi->max_speed_hz;
-
 	if (!bpw)
 		bpw = NUVOTON_QSPI_DEFAULT_BPW;
 
-	ret = nuvoton_qspi_set_speed(qspi, speed_hz);
-	if (ret)
-		return ret;
-
 	ret = nuvoton_qspi_set_bits_per_word(qspi, bpw);
 	if (ret)
 		return ret;
@@ -216,11 +212,18 @@ static int nuvoton_qspi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
-static void nuvoton_qspi_set_bus_width(struct nuvoton_qspi *qspi,
-				       unsigned int buswidth,
-				       enum spi_mem_data_dir dir)
+static int nuvoton_qspi_configure_bus(struct spi_device *spi,
+				      unsigned int buswidth,
+				      enum spi_mem_data_dir dir,
+				      u32 speed_hz)
 {
+	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 	u32 ctl = 0;
+	int ret;
+
+	ret = nuvoton_qspi_set_speed(spi, speed_hz);
+	if (ret)
+		return ret;
 
 	if (buswidth == 4)
 		ctl |= NUVOTON_QSPI_CTL_QUADIOEN_MASK;
@@ -234,6 +237,8 @@ static void nuvoton_qspi_set_bus_width(struct nuvoton_qspi *qspi,
 				 NUVOTON_QSPI_CTL_QUADIOEN_MASK |
 				 NUVOTON_QSPI_CTL_DUALIOEN_MASK |
 				 NUVOTON_QSPI_CTL_DATDIR_MASK, ctl);
+
+	return 0;
 }
 
 static u32 nuvoton_qspi_tx_byte(const void *txbuf, unsigned int idx)
@@ -459,14 +464,17 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 	int ret;
 	int i;
 
-	ret = nuvoton_qspi_setup_transfer(spi, op->max_freq,
-					  NUVOTON_QSPI_DEFAULT_BPW);
+	ret = nuvoton_qspi_setup_transfer(spi, NUVOTON_QSPI_DEFAULT_BPW);
 	if (ret)
 		return ret;
 
 	nuvoton_qspi_mem_set_cs(spi, true);
 
-	nuvoton_qspi_set_bus_width(qspi, op->cmd.buswidth, SPI_MEM_DATA_OUT);
+	ret = nuvoton_qspi_configure_bus(spi, op->cmd.buswidth, SPI_MEM_DATA_OUT,
+					 op->max_freq);
+	if (ret)
+		goto out_deassert_cs;
+
 	ret = nuvoton_qspi_txrx(qspi, &opcode, NULL, 1);
 	if (ret)
 		goto out_deassert_cs;
@@ -475,24 +483,33 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 		for (i = 0; i < op->addr.nbytes; i++)
 			addr[i] = op->addr.val >> (8 * (op->addr.nbytes - i - 1));
 
-		nuvoton_qspi_set_bus_width(qspi, op->addr.buswidth,
-					   SPI_MEM_DATA_OUT);
+		ret = nuvoton_qspi_configure_bus(spi, op->addr.buswidth, SPI_MEM_DATA_OUT,
+						 op->max_freq);
+		if (ret)
+			goto out_deassert_cs;
+
 		ret = nuvoton_qspi_txrx(qspi, addr, NULL, op->addr.nbytes);
 		if (ret)
 			goto out_deassert_cs;
 	}
 
 	if (op->dummy.nbytes) {
-		nuvoton_qspi_set_bus_width(qspi, op->dummy.buswidth,
-					   SPI_MEM_DATA_OUT);
+		ret = nuvoton_qspi_configure_bus(spi, op->dummy.buswidth, SPI_MEM_DATA_OUT,
+						 op->max_freq);
+		if (ret)
+			goto out_deassert_cs;
+
 		ret = nuvoton_qspi_txrx(qspi, NULL, NULL, op->dummy.nbytes);
 		if (ret)
 			goto out_deassert_cs;
 	}
 
 	if (op->data.nbytes) {
-		nuvoton_qspi_set_bus_width(qspi, op->data.buswidth,
-					   op->data.dir);
+		ret = nuvoton_qspi_configure_bus(spi, op->data.buswidth, op->data.dir,
+						 op->max_freq);
+		if (ret)
+			goto out_deassert_cs;
+
 		ret = nuvoton_qspi_txrx(qspi,
 					op->data.dir == SPI_MEM_DATA_OUT ?
 					op->data.buf.out : NULL,
@@ -528,8 +545,7 @@ static int nuvoton_qspi_transfer_one(struct spi_controller *ctlr,
 	unsigned int buswidth = 1;
 	int ret;
 
-	ret = nuvoton_qspi_setup_transfer(spi, xfer->speed_hz,
-					  xfer->bits_per_word);
+	ret = nuvoton_qspi_setup_transfer(spi, xfer->bits_per_word);
 	if (ret)
 		return ret;
 
@@ -552,7 +568,10 @@ static int nuvoton_qspi_transfer_one(struct spi_controller *ctlr,
 			buswidth = 2;
 	}
 
-	nuvoton_qspi_set_bus_width(qspi, buswidth, dir);
+	ret = nuvoton_qspi_configure_bus(spi, buswidth, dir, xfer->speed_hz);
+	if (ret)
+		return ret;
+
 	ret = nuvoton_qspi_txrx(qspi, xfer->tx_buf, xfer->rx_buf,
 				xfer->len);
 

-- 
2.54.0

