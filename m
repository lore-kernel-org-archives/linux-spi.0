Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036447;
	b=qWKzOiiOIU9EvMir59MmtBThyMNkHQzFGaZtReEIUxOzQ1j/fkuWJJj9ZU+NIyrkERcL
	 3FuVjESJjc7oC89fjcl7iwE3h0XVHof3ew+Qbq9WzFwEyW4KM7T5o6jwO0ozRbZsotK3C
	 yNUDQ+HsIP3PMebY0rahc1V9eNAN+QG4DREZ9+vU3zswbgRSD9233sq48ZOeWtWk5LZ6J
	 IUFSHMl180V4CSy3g0tQrVG4b/WwTcEgqAjMQhWzz+91o9nl9gJaHe+8DdpZmCxBQEVa7
	 KagubGepfL48UNSfJBmfoidfn7MpVsZpgvEuDTv+P2Eb+ZcKcNvl8Bh0Tsboz1fDrOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VpkuHhPwzWbf6tDZsWXKj1gNOGLkMgtoPlDaCXACNQ8=;
	b=Nan+gLv3Zxb6Fxk7/eBeMHMIcjJ038CDPbvCA132kh2QE+VMDQ3kBvq5cYqZZklPrYIj
	 DsSjIwF2R9aCku0XjdXOx5myKoDWGuwg2uXphEBEGNH0x/n7LeBYZGDv8Cz8TvMumlUMl
	 UbHMrezNsi3I5LJOUT2cobWBDQP3RZNlELb8WO1zX5NfEE+7wgospfb9776y/7eWQ2l+f
	 9x5aMCTgsQsP9OA1MKwbAguIoqPGYP7OX91Tup3mnNS4IRlJOGoaUP8Rw7X5YqvBPKbRS
	 yV5NDCm/HoUaee7tpllk5KW81txwAHKdIHM9/EDYnsMue6220PGbxsS8KVrRj5GZd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIqiDFLQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB086606A326;
	Sat,  7 Nov 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIqiDFLQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4821F0089F;
	Sat,  7 Nov 2026 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794036446;
	bh=VpkuHhPwzWbf6tDZsWXKj1gNOGLkMgtoPlDaCXACNQ8=;
	h=From:To:Cc:Subject:Date;
	b=dIqiDFLQCUnwW5qjLQ7JXyfU/EUcf7RkwYjqfL+uRAaS3YySu9pRwdD3KjB9s597A
	 Z979d35StLZZEyZlbYNqW/4hzWp7EplV0I90z8mzD+UB4Eputa9uTEsWMGHqnp7BOE
	 3Vqr0fehOVPuRHBsW8/Jilm9y7f0JRwaD+s8+jmyXG0NvMTREGP4UY9DhG5WgKV29H
	 17a7OFQcbFkJpu+AIHmQ2xQsDaqQWHVyPkdx0Q0F4xb8QGvgkCIpdlmjSX9a/cfIRm
	 c5WcPe/mpskEL+fTo5rEUd7lVJXrTgdoDDrntNcQgY0dDDypL6ibGxoAAW7M48SyQ/
	 8W6VLDRFQzXEA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Drobot <michael.drobot@garmin.com>
Subject: [PATCH] spi: dw: configure CPOL/CPHA for each message before sending
Date: Sat,  7 Nov 2026 15:07:18 +0800
Message-ID: <20261107070718.17395-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Drobot <michael.drobot@garmin.com>

Configure CPOL and CPHA in CTRLR0 before starting the message sending
procedure. Without this preconfiguration step CPOL and CPHA will be set
in dw_spi_update_config(), which runs after CS is asserted when using
GPIO-controlled CS. This causes framing errors on any SPI mode other
than 0.

Signed-off-by: Michael Drobot <michael.drobot@garmin.com>
Co-authored-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 90af2cc9e17d..2bd4ad0f13ad 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -507,6 +507,33 @@ static int dw_spi_poll_transfer(struct dw_spi *dws,
 	return 0;
 }
 
+static int dw_spi_prepare_message(struct spi_controller *ctlr,
+				  struct spi_message *msg)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
+	struct dw_spi_cfg cfg = {
+		.tmode = DW_SPI_CTRLR0_TMOD_TR,
+		.dfs = spi->bits_per_word,
+		.freq = spi->max_speed_hz,
+		.spi_frf = DW_SPI_CTRLR0_SPI_FRF_STD_SPI,
+	};
+
+	/*
+	 * For GPIO CS case, set CPOL/CPHA before the SPI core asserts GPIO CS.
+	 * transfer_one() will configure any per-transfer word size or speed
+	 * overrides.
+	 */
+	if (spi_is_csgpiod(spi)) {
+		dw_spi_enable_chip(dws, 0);
+		dw_spi_update_config(dws, spi, &cfg, NULL);
+		dw_spi_mask_intr(dws, 0xff);
+		dw_spi_enable_chip(dws, 1);
+	}
+
+	return 0;
+}
+
 static int dw_spi_transfer_one(struct spi_controller *ctlr,
 			       struct spi_device *spi,
 			       struct spi_transfer *transfer)
@@ -1382,6 +1409,7 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 
 	if (!target) {
 		ctlr->use_gpio_descriptors = true;
+		ctlr->prepare_message = dw_spi_prepare_message;
 		ctlr->mode_bits |= SPI_LOOP;
 		if (dws->set_cs)
 			ctlr->set_cs = dws->set_cs;
-- 
2.53.0

