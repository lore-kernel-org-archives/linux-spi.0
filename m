Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720289;
	b=PScVIYaWnTcLNmjZeTxa1yiVi4xyAmuX0qk27sR6Qx+DkrvIZnnfd9UTVHCDUYp/1AIA
	 35u5WtYynuKvRDvbw7pPCxiR7/cHQmaEdClGCtKZx42eV2deqDX6uQEkHwIh8zyv8/Ya8
	 uKhmhnRq5/6l127MH6YDrtB75e2yl37ZFHMfr+fazsGzm3aPFISB/YEA8LA31lDhze4T+
	 4SSalr4rYfgNpUiIkxOnwOBAweTnuzM7dI3HUGZb2g1vKu8R5jh3b73pdXALmEnML3/PP
	 HDCOFAW4d82eIwtMEQ+qnpylto0qmqt+Pv9E2K1zBp7e26VsKSTy3TI2UY9FxK4oU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720289;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Z2SDAeMcZbzv6+qb40r4M3IxubYi8XKkur/4WIhWlrI=;
	b=alTowCIhahWk/Mg5gu7dB/Sxz3vEBOGCubQVB7EmFYmo8ScjM8NfX404G6+XQcNvHnNn
	 MU4acYL8fngZQuzUa3xWwD417ek+yq5qmwi23dJ5CHYp6dCZNMftOgaG+IzN5LcKeTrDU
	 fYCgTegjiekv1FNy3pJbr7ayxbtOydhSQKAn0+8Erkg3mLG2Q2R8T1YVkFC07YxAqtG4y
	 YB0Lsh8IN9oy0nUpt2IjPA2Y9lbj4Q4xfLE6aDoDxvL5hBs/Vgyq9OXAu6ndkPpVxKhLP
	 6/ng0rs0fMf8nt1xWQzzZaFFF9A/RuodtVuoZNcSrTe2fcE7WPTRnV1A6T2QUf6TQsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TZNZ44V3;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547B606A323;
	Thu, 26 Nov 2026 19:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8547B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TZNZ44V3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3F0431A181E;
	Thu, 26 Nov 2026 19:11:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B0C160558;
	Thu, 26 Nov 2026 19:11:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F68211E691C6;
	Thu, 26 Nov 2026 20:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z2SDAeMcZbzv6+qb40r4M3IxubYi8XKkur/4WIhWlrI=;
	b=TZNZ44V3iWTnm4oCWdGoYBdBNuawXE6bixpW9HdFtyO39AMlXam6rU2aaC/zRszXEn0uWa
	/OYQXP7kXn8APG7XqjuqfeKVhtzdCq1Oc6ixdWvi05EORBIPfo1YT5oSeIeIrL9O47fugU
	daWTs5T7EyEfj5Pl5ybGTFeabf6ihIndwzC069qI9vAS/DWUGvF4kS8XvRA0LWvJ3ER9ov
	3XqkP6N+WJI4zsH3FK/F2ORO5a5vgNOXbOVH2snB3hXHZxZ0MjBkGhDK5zjGdaShsiPsdE
	qfmsEQw33P5bVKMOnfRnyFB8yizvLl99B9aDZeNIQ1Tjmm9VYXPsRfm3BAGltg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:26 +0100
Subject: [PATCH 07/12] spi: atmel-quadspi: Advertise DTR for the octal
 controller
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-7-ca8e924cca1b@bootlin.com>
References: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
In-Reply-To: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Mark Brown <broonie@kernel.org>, CL Wang <cl634@andestech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Yang Shen <shenyang39@huawei.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The octal SAMA7G5 controller implements DTR transfers, but the driver
never advertised the capability, so the DTR code was unreachable. Set
dtr_caps for the octal controllers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4f3ceef67b40..0b695b0b3c98 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1429,6 +1429,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
 	if (aq->caps->octal)
 		ctrl->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
+	ctrl->dtr_caps = aq->caps->octal;
 
 	if (aq->caps->has_gclk)
 		aq->ops = &atmel_qspi_sama7g5_ops;

-- 
2.56.0

