Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522540FD9B
	for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596025; cv=none; b=arBPV7tbwdiH4N+nkraR1IH4OY1H+/4N2VqDr0RoZnkC3r+j1ZiARfTb0HuUqzWejHySCavszM4Ru6+rGwI/rG4ywUIglZqMAP/1aoXgIV7GTMKSI04vRZaKgqdH8W2QseQBZzbYOn5hBDS/RnzkJAM1fClc4ZnBflc2H5C0Nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596025; c=relaxed/simple;
	bh=wyhKq5giS1/IoMkjpsGRbT+IH8vqF62PQtP170jfxxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjmGuLkaziVTa0kfcdAlPT3we8I1AhFGw5VgeiFgRZg5hdId2A0uYlDfFPi0y09CodfgTMu7kYFDLnrm9WQpVvI4AI1vqbhfvc3QD2bqmIcwdmFqL0/HIVyFLc/MxL7O3PdzsQoMKteOhfPkNxg96YkNpO9O4r4aNYSID/75m6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=DW2150Vu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="DW2150Vu"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so1125481f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2026 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1783596023; x=1784200823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=damSg+KRPsx8cUGtM6YEq9+rU5hH+rbnhhK5WWTTkmU=;
        b=DW2150Vu1HjGk1+rbvLNbgTXoXohF4O4Mx0zTTTymm6X39Gc8Q8A30A8PtFxf4yDeR
         slTY9lL0nkzItkNXb4KLRULJ8aSlbNuBtWpiHJYPswEfbVqkNVdh1GeitZ6K/+N3ca0k
         uLAAbZmMmRhsojejbCD1yZbivNkjOUWWG15ButysotYWxdn3LWNH4/6mqCs04OyqsaTO
         zHwpo2rpqo6f4tsKyfrMu6vind6HeK8eQ+ON/egcVREOAWNlUAtcUx6LNqJQvCFpS+ik
         X2PD/bPcNiZfeVM0kxwk1uJiNZKGxqUEMM0G2SLaT4LqEpg0Q5Wd0yWODGLH9SRe6Fa3
         N80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596023; x=1784200823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=damSg+KRPsx8cUGtM6YEq9+rU5hH+rbnhhK5WWTTkmU=;
        b=oVFlud9xe9j1/7Au8mzDAYsis/Eg7WmoWjcLQXGCKP4jGb/Bf+OzIeN723J8osAq89
         A5N1abFBcTjIPHJ6hHABsdWO4WbDrTgsgMx2Vm90yu219xdKBYzooifSjbyUbxcLw0eL
         atnZa1tjboURxWjRUuIjP0vVJ9plQehwxNwJEs7aGfjF8RSs6WNggqaTpPYm6LYdSebN
         Fpiess+/4RpNf95V1DI8++AobATfTzDSS6uY2j7knLwNiZp+UlfpzbofDkmbnIh0Cb5v
         mMGlMnYWe5lrEmnU3dirj1fk+/SKDYSJqZf0RnuNA4pqFW5YfdZbKV9+TKbPs/TJPJUj
         ktAA==
X-Forwarded-Encrypted: i=1; AHgh+Ro76iMDxz5cU8nHEzcApmdStX6eXCLdaEXhMF6w0qsWL7pPYR+zj0AbcLuiCj4OV2oJl9aQCWSRLj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUCoLDbJo1uE/910iZih68VLup8KskX5YfjK+A2/7q2fMAeqK
	6k2xAd8JtJmyIazZtaXBZYnmgqMrhYHwneQVwYTqwL1QcTk6/BYfUrMaBQWW4yNKVu0sSUxxF5r
	Zm3Dj
X-Gm-Gg: AfdE7cnKiSQFhBidELlMQmKzRd9cC/dB9s7aJD9aN+jPICpRdrnnSYcrgozGEMJw6a7
	bkQ8ncI4xr0yDl+y2uiMCsEC0+vXZpfi4YP8eC1HnnGH3xShwhmCy9SO8kPtlUt2k8Mi8X9sMVv
	AqLKXotUNT2dVL4bifeBfjJ8z0GjoiSFLYExWNbmmsUMvi0Nwy1yO15/dYcd1vhcvAPeTMPsK+g
	HRvYpIf/tWDNEKlMznw4CSciGA5rW8pG+rOktsQYiAJwJXD9Wv7rMdW8nP/ITKVVMyM5jEtq0eK
	G76vWkJV3/O+0iAXKzXO6jpTfmSE9cCuVCgxr3YZnunqj5LB2/6ARU50ZrUIE7dEtII1WOPgoag
	UnkBPHokKV5k/pGZzTkBHNcMWCWTphaUQlnl4SDdRDjigQJLd2isSh1E7WADa6ZDl/VkA5Z5/w/
	uQxX4WJrIzeJT/s9yL0wz/wd9psSlt5mqu8gUCWwa0c9ItGr06tDjFIbUV5+slPniAMrJd0xiUR
	fFLc5ja2qgwcZ2cAIJbYifgohiTHX77NoKuAjA3Btc=
X-Received: by 2002:a05:600c:6286:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-493e6892d8bmr65828845e9.8.1783596022660;
        Thu, 09 Jul 2026 04:20:22 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-57.xnet.hr. [88.207.15.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm53910475e9.1.2026.07.09.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:20:22 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 4/5] spi: atmel-quadspi: add LAN969x QSPI support
Date: Thu,  9 Jul 2026 13:19:10 +0200
Message-ID: <20260709112006.390742-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709112006.390742-1-robert.marko@sartura.hr>
References: <20260709112006.390742-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip LAN969x has two QSPI controllers based on SAMA7G5 QSPI.

It requires pad calibration, supports DMA, and supports 100 MHz operation.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/spi/Kconfig         |  2 +-
 drivers/spi/atmel-quadspi.c | 66 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8782514bb89b..bb3773f99ad9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -189,7 +189,7 @@ config SPI_AT91_USART
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d1aec14e3978..f05e2617fa89 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1152,6 +1152,58 @@ static int atmel_qspi_sama7g5_init(struct atmel_qspi *aq)
 	return ret;
 }
 
+static int atmel_qspi_lan969x_init(struct atmel_qspi *aq)
+{
+	u32 val;
+	int ret;
+
+	atmel_qspi_write(QSPI_CR_DLLOFF, aq, QSPI_CR);
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_DLOCK), 40,
+				 ATMEL_QSPI_TIMEOUT);
+	if (ret)
+		return ret;
+
+	ret = atmel_qspi_set_gclk(aq);
+	if (ret)
+		return ret;
+
+	/* Start the DLL before resetting the controller. */
+	atmel_qspi_write(QSPI_CR_DLLON | QSPI_CR_STPCAL, aq, QSPI_CR);
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 (val & QSPI_SR2_DLOCK) &&
+				 !(val & QSPI_SR2_CALBSY), 40,
+				 ATMEL_QSPI_TIMEOUT);
+	if (ret)
+		return ret;
+
+	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+
+	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+
+	ret = atmel_qspi_set_pad_calibration(aq);
+	if (ret)
+		return ret;
+
+	aq->mr = 0;
+	aq->scr = 0;
+
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret)
+		return ret;
+
+	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
+	return readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				  (val & QSPI_SR2_QSPIENS), 40,
+				  ATMEL_QSPI_TIMEOUT);
+}
+
 static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
 {
 	struct atmel_qspi *aq = spi_controller_get_devdata(spi->controller);
@@ -1679,6 +1731,15 @@ static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
 	.has_dllon = true,
 };
 
+static const struct atmel_qspi_caps atmel_lan969x_qspi_caps = {
+	.max_speed_hz = SAM9X7_QSPI_MAX_SPEED_HZ,
+	.init = atmel_qspi_lan969x_init,
+	.has_gclk = true,
+	.has_dma = true,
+	.has_padcalib = true,
+	.has_dllon = true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] = {
 	{
 		.compatible = "atmel,sama5d2-qspi",
@@ -1708,7 +1769,10 @@ static const struct of_device_id atmel_qspi_dt_ids[] = {
 		.compatible = "microchip,sama7d65-qspi",
 		.data = &atmel_sama7d65_qspi_caps,
 	},
-
+	{
+		.compatible = "microchip,lan9691-qspi",
+		.data = &atmel_lan969x_qspi_caps,
+	},
 
 	{ /* sentinel */ }
 };
-- 
2.55.0

