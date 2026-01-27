Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84968361651;
	Tue, 27 Jan 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552647; cv=none; b=s3b4caASgguAiJDKm8c7Y7lnwhqOUrIvuLpqg4Zo38jk56XxLazGbtPfawz91qmkeVVh18TU0UE343u+yarhE28Uk0ArzaDNjvdbGdExBf9JZ2Tz+x6AT4nXhob6En7ivE79JCDzANRlMlIEvECWSw3awMVXx43mj1Xi0new7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552647; c=relaxed/simple;
	bh=PDIffGg5mTwgDaVwOj88KJryy7AtMfaNluPWiO3tzQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LogFf67pzPJaMXjgLprpUO1p9O2xH1FPr9L4NwtAStTZlcT4h8qsR05ieJE7w7T3eQDONQxYJ022wr04WCFoI7RMx0oV98OyM1nvgEKka4wPo4v8VsfoQdglj6PN+WTCcHUAbxrlnubm/bTU18bCdU6ts9dNz+2mcyIr5QrMuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DwL3L4WG; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DwL3L4WG"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAD5210F57B;
	Tue, 27 Jan 2026 23:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769552642; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=aFM6i5j9oKGcf+q/y0Fmaw5LFu1bzegCECvjhnapYtI=;
	b=DwL3L4WGThecycxpf1Odgj0TsZjTg/PAHOi+3PffCchGgB9KLEXknRcQDwKdgy5v+HrA1C
	1MkASpFHRhcjAC5mi7wpkZ58WYihu5f+u+tSu+V0nVoS6Zozo6YHokdRpzEOpe9aeimzAS
	4p3ItJv8e8lfVjveAKiwjNk8+OJCUR01oV/1lw1K/p5pgvG/zUeZhS0phZDnpXYo/eSBLj
	H0J5GELMbJXUoC4zUxZ00qAw+UCIUzlAt64roaDsMcPJ0gKA/K5jeS4LqowUqFtxDHEhcM
	okjtUZZe0ZroLNULrTzEwnZzxswIpEfYaIn2xRStL67LvmQdF4yzhbxFxqCzVg==
From: Marek Vasut <marex@nabladev.com>
To: linux-spi@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Fedor Ross <fedor.ross@ifm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-lpspi: Handle clock polarity and phase
Date: Tue, 27 Jan 2026 23:23:22 +0100
Message-ID: <20260127222353.1452003-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The LPSPI driver currently does not support setting SPI bus clock
polarity and phase, add support for it.

It is important to configure correct initial clock polarity and phase
before the GPIO chipselect toggles, otherwise a chip attached to the
bus might recognize the first change of clock signal as the first
clock cycle and get confused.

In order to set up the correct polarity and phase on the clock signal
before the GPIO chipselects get configured by the SPI core, the
controller has to be briefly brought up in fsl_lpspi_prepare_message().
The fsl_lpspi_prepare_message() behaves like a zero-length transfer
which always uses PIO and never DMA, and which leaves the clock signal
in the correct state at the end of such transfer, which happens before
the GPIO chipselect toggles.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Fedor Ross <fedor.ross@ifm.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/spi-fsl-lpspi.c | 54 ++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 6c692568bdf58..b361c1bb3e431 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -281,7 +281,8 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi->rx(fsl_lpspi);
 }
 
-static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
+			      struct spi_device *spi)
 {
 	u32 temp = 0;
 
@@ -303,6 +304,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 				temp |= TCR_CONTC;
 		}
 	}
+
+	if (spi->mode & SPI_CPOL)
+		temp |= TCR_CPOL;
+
+	if (spi->mode & SPI_CPHA)
+		temp |= TCR_CPHA;
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
 
 	dev_dbg(fsl_lpspi->dev, "TCR=0x%x\n", temp);
@@ -488,12 +496,45 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 
 	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
 
+	return fsl_lpspi_config(fsl_lpspi);
+}
+
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+				     struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+	struct spi_device *spi = msg->spi;
+	struct spi_transfer *t;
+	int ret;
+
+	t = list_first_entry_or_null(&msg->transfers, struct spi_transfer,
+				     transfer_list);
+	if (!t)
+		return 0;
+
+	fsl_lpspi->is_first_byte = true;
+	fsl_lpspi->usedma = false;
+	ret = fsl_lpspi_setup_transfer(controller, spi, t);
+
 	if (fsl_lpspi_can_dma(controller, spi, t))
 		fsl_lpspi->usedma = true;
 	else
 		fsl_lpspi->usedma = false;
 
-	return fsl_lpspi_config(fsl_lpspi);
+	if (ret < 0)
+		return ret;
+
+	fsl_lpspi_set_cmd(fsl_lpspi, spi);
+
+	/* No IRQs */
+	writel(0, fsl_lpspi->base + IMX7ULP_IER);
+
+	/* Controller disable, clear FIFOs, clear status */
+	writel(CR_RRF | CR_RTF, fsl_lpspi->base + IMX7ULP_CR);
+	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
+
+	return 0;
 }
 
 static int fsl_lpspi_target_abort(struct spi_controller *controller)
@@ -753,14 +794,18 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 					spi_controller_get_devdata(controller);
 	int ret;
 
-	fsl_lpspi->is_first_byte = true;
+	if (fsl_lpspi_can_dma(controller, spi, t))
+		fsl_lpspi->usedma = true;
+	else
+		fsl_lpspi->usedma = false;
+
 	ret = fsl_lpspi_setup_transfer(controller, spi, t);
 	if (ret < 0)
 		return ret;
 
 	t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
 
-	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi_set_cmd(fsl_lpspi, spi);
 	fsl_lpspi->is_first_byte = false;
 
 	if (fsl_lpspi->usedma)
@@ -944,6 +989,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	}
 
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	controller->prepare_message = fsl_lpspi_prepare_message;
 	controller->transfer_one = fsl_lpspi_transfer_one;
 	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
-- 
2.51.0

