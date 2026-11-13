Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794610832;
	b=pZoJgfsazw4PAkeg0GpySHF7IVUCbtQm832zdsDzJx0vMMNE3UWxM0aLb+CrunPesUC7
	 5sbRuyxhs/MXo4iYXRxaroagcCkK8EAXD0TmD0INgZRyYZrTUXegOHqGWjx3r9iS3WC25
	 dFP11LiRYk/fP09ruBCduFCK9E8BBR9j02euvTdnec7gNcUgnqNN1FerKI/nmxsqPlMW1
	 as5p51GwlQy4JEdXCaXXt+tyY0r/NDbugGjrCQUR43eNMfbxXl2cBqoZ+ihrY0gpMwIqK
	 VeKPDYOzcFCUs2Hrun45aUPc5E9cTuDzbplVBNWZ+InSsw139t5uy5Xp4oBApyMcjXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bPGcYPCmwMihkBZLwcSUA+dmNXWkYkkH9KDah1Pc0QA=;
	b=muXnr6ahQJCzhYvm7jE5SsOJ2u+7gpBwTVnZ0FJnh19/ZKN/d6wsg0tILlREDPLN6aY0
	 mUwMw88IpssZCkeqgqSHw7nVMTjB21pRnwng+QCVumR6kXcsuh2iI7J42uPMJ3OGkqEOn
	 NZR7M9wKWyik2QLNR3L4fOtb7BSaeZm4X+HczsGrMVJownXMKKMY8J+D9BiHtOv+Yo40d
	 1H6IbjLpEPzGEGi5RulZK1koTu/3Gsyn1keUxv3pdtUOHAPzzek40qWoS6zqpie6hLEoW
	 J9ceSPZ9rxop7fy7ZjI672NAE4XFGQdbnjeOuPlPpESsyTD6LxmCrjID6n0CytD1Z6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iu5BU8wH;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCC606A327
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 23:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DCC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Iu5BU8wH
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491971ac844so1643897f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610830; x=1795215630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPGcYPCmwMihkBZLwcSUA+dmNXWkYkkH9KDah1Pc0QA=;
        b=Iu5BU8wH5rngf8NWwij1f77dy1SDpt5FYOrmxsXxBeUnNkEz8auCMpZAlyUuIj+wH9
         jaQcRuB9rhvsxDFaQoUu9LQM6GDVlpg7HvUpXCn0YTO61s9HJB/AaNRXvMUKQRaK7oHc
         AvOsCUUpsCxTtyq6E4w5rp8Nddhwg9g4mZ7Jb51zceTUe9XwPGuUAQAwTqrnHGKb5QCN
         Bl4Ok2WsLf6/r8a9CGEyEsL2kRJ3d+pgqVFj71MpaqMI5YEuoco7efLE0MlG4hZwQdGJ
         gge8ub3AoCdgKWxXV59erZhZkOPM82i0QdIoGg84Any+7CLa7gwESUIiq2A06UCxrArG
         4iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610830; x=1795215630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bPGcYPCmwMihkBZLwcSUA+dmNXWkYkkH9KDah1Pc0QA=;
        b=cKkdvo+lrdlevf1idRMiKx1T5IeKupMr7XBEErFIj3nHTkfEDQbSi3d7OLp8cEHuUL
         LtWU5r1ORA/0d1vF4qXcoewrLO5BnvPHhNs9mf3sxC6CjMcNgrZBYk45DZjZGABDczBo
         /3ARhQcXQa8ANm3mv+hAgn0XmX6iiNdbGr0Zi6xkhxC4fDR/QJG4nRaG3LlLwjW8iyfM
         QaQQWOwVhiGeyFobUqKQnkjkMgS4iobbOtZ1lOFJs5n9yiLw1kbIqpQ/PhKrYXhM8O8W
         Fdb7/dyMmgDRUdI9dO2WBbPtxVlEMvfzZZYBerWtJCMnjHKXeq2D73rPX+1L15OZH5jt
         BK6g==
X-Forwarded-Encrypted: i=1; AL+hErFzOYtO8tgEZUbD4ZxSyMB9LGn+6ylwUZAMwkRN/rC5m2ICMow4yFC2wuAA2Lx3tPeD+72FvRPNJUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/F0wkhuiZGb/xTpoXETKCS2pDEhUQn4hJz5Y2r+lGpys08R6+/
	pFa2wkatZth5mJRijumuToY3nujNWe47p9c+LEmOoKlgy2IPNg2zcWye
X-Gm-Gg: AYBFou1mqnfSm8HnAy+SSiZeJ3atgVpx6oK4cK6HAnjnw2dQeXLCxEde5wbKza+fIJ9
	xBSV52iK41i+JLI//c8DMUYydkGMFSIZ5mM67jy8ilQl9CYgnBFFEfHh1AnjeZGvHwDUGw+I2AE
	gcO1L5lDqT2UCyXpN+0ZEqtbG+hu1S6zQ5k+GUWiqNOnqXLr8TElBmPxyonYqmEbIxTCbnDq/Ag
	c5mk2+8ocApTlrLNRZ8SCSEL+3IbEy8A+RzPvNF24cYDRf9G0FI4D47mYqQxA3WyDQ9vpYkZbrN
	mPqVUQAk8zMpSHwnHQF/sBGmOsHHeH4pqU9KUg7nUUJQpguNQjPvjKmw1AHbfS1FxZtSQw5+Wvq
	rmWxEyGp+F16NNv5LRr5krhAF6ngwbfIoIC63oC2ptVSQxrwUc3YxfIro6XtMrU5AJuj6MWbZO4
	xfV9AoSL8XFvFKPWTZ9kAqRNAHl9HudfrZymjPWTBfxDJpnr29miBiqHXuVmWGcrKUmRJ2ZhEXC
	nApF0OJSCnnnU7t67mcSTiU3taD+9WW9nayQsb3F2Ko9NXwpWzmf/TCVkOXR44xHZNU4VBgmUUZ
	QInEmfZgsntpNK2oPKQe0ZNlJB8c7fJ4PpxNhewgP08aFL71sEN4
X-Received: by 2002:a05:6000:4688:b0:488:7d08:edbc with SMTP id ffacd0b85a97d-49c714a2a99mr5972225f8f.24.1794610830290;
        Fri, 13 Nov 2026 15:00:30 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm8617592f8f.11.2026.11.13.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:00:29 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu.pirea@microchip.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v2 3/3] spi: atmel: allow changing bits_per_word between transfers
Date: Sat, 14 Nov 2026 00:00:16 +0100
Message-ID: <20261113230016.4144717-3-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
References: <20261113230016.4144717-1-angelo.compagnucci@gmail.com>
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

The controller supports 8 to 16 bits per word, as its bits_per_word_mask
says, but the word size is written in the chip select register only by
setup(): a transfer with another word size fails with -ENOPROTOOPT
("you can't yet change bits_per_word in transfers").

The MIPI DBI panel drivers send commands in 8 bit words and pixels in 16
bit words when the controller supports them, so no frame reaches an
ILI9341 panel on an Arietta G25 (SAM9G25):

  ili9341 spi0.0: SPI transfer failed: -92

The DMA and PIO paths already follow the word size of each transfer:
when it differs from the configured one, update the BITS field of the
chip select register instead of failing.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
Changes v1 -> v2:
  - Rebased on spi/for-next

 drivers/spi/spi-atmel.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 08075c9cc07b..0d28c08a85c3 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1402,9 +1402,18 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
 	asd = spi->controller_state;
 	bits = (asd->csr >> 4) & 0xf;
 	if (bits != xfer->bits_per_word - 8) {
-		dev_dbg(&spi->dev,
-			"you can't yet change bits_per_word in transfers\n");
-		return -ENOPROTOOPT;
+		int chip_select;
+
+		if (spi_get_csgpiod(spi, 0))
+			chip_select = as->native_cs_for_gpio;
+		else
+			chip_select = spi_get_chipselect(spi, 0);
+
+		/* The chip select is active: only the word size changes */
+		asd->csr = SPI_BFINS(BITS, xfer->bits_per_word - 8, asd->csr);
+		spi_writel(as, CSR0 + 4 * chip_select, asd->csr);
+		if (atmel_spi_is_v2(as))
+			spi_writel(as, CSR0, asd->csr);
 	}
 
 	/*
-- 
2.53.0

