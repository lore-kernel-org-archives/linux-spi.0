Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411632;
	b=DUk3R2tltuWEuiODp1VhgibEoqgXlvJ/KUW8BOZtK/ELZ5i6u5T1pnK7ztPEBvZA2FMF
	 NRKsFggVSX3oKSV7lTx4YW0+M3kk+sv5TVYbfgZkxlMhkS46/R8IJWPoRu+1rKBq8yW87
	 7qsvo6PazOEvdqOPK4m/ZOyQY6KusmLD1sGCkBuklWljkWH0ac6HhvjZj6hGShc8GGj3l
	 20TTX337mbKWmdd6hvoAiLM2IcohCv1iV7k6FQyzPWcZg9Z0XOSr0Wn4dYRxr+L1M0wlB
	 no4i5vjQaJxQuWI3S0XQ+pt+nlydeqPjksu1VrD4eGQjhHyMuSc8NuiM1y3RJSib1EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2omuyWc3BcEiakZH/Yss8XMSoMevM/dIwNnIr3lE09g=;
	b=J7cPiYP2K2V5CsIsMjEDGNIRxs0xLjYOtpJ7GKOxCh5N/lRghpb6yLXzqNfu4cAr0g6Z
	 EL6eLpIUlfVNt/gZztROxginnmdIcvi0Wp8a5urchB6ehVMr0jsCRxWfiANDGUF2tjd9H
	 v6diWsbwf8W8438tN74GZtn7GGa+NaUDaoIojY5rBZsDs5w6AJqeqhz8NHST7a17AX+TP
	 HwVG+Oh0gUCKqJ6O+URLnGNc67vjHueQjoAwI4lPWqTv3GD2rj00lp+sZuYVj+LNBg8qm
	 x2kAaKeg72YEg9YTUzB+6Eu4aH24HUmvE4eQVJE/VOPWw/RdqLTheJaHz7o9Nsyj64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEZ3S44f;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2F606A88E
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 15:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E2F606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEZ3S44f
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so38974305e9.2
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411630; x=1795016430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2omuyWc3BcEiakZH/Yss8XMSoMevM/dIwNnIr3lE09g=;
        b=dEZ3S44ftYn4JlaHv0mTncnMz5fnq+yluf71Xl8jyY+kV+5/y8pT4lElZIbQE4JJ6s
         uBgPmxdhlm5TOPAwjv0bwTmi5iRKD1/8oBprkZsI06SdS0yZRnsDq0VJCuWFyCHoPrPE
         0AamlfowednDnA/MhJxhP9dLFRjMTiuvt2hrgb/Z2xk7pVyNQHfMxOoxemkyJuV4yHz3
         IVRkLmdh1NgmGGPJ1gNe8IOXSPacs7w5yJadLCf4pX5F0iUm7WdQ6juGzKu6BEE2IgWs
         BFx9E5q/y1+VPjMA8oU0Wq8PD0FKfNJH+k/z4BSqFPszRas+xUIHmPDHBgHTL1jWPzab
         bGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411630; x=1795016430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2omuyWc3BcEiakZH/Yss8XMSoMevM/dIwNnIr3lE09g=;
        b=yJOw8CDwJD/Afr2XatcDHqCHzOeU6jMPyMtlXpjqq6rTTXXY0+RkK1HVU7Wde/1Veg
         I6xA4HabARlLql3x+WyWT4ZEvQBFBVaADA4bbHIDqjkPaIHauJ1Cn5KaWrQpD9EV4Zel
         wzBsOHb6WDWCmvEUOycNvWhHecqP8HhRgRAa6JtD+HDu6VYALAMqBV7KcV8Faexfg0/4
         Awk3Hi6e3UVJqF4SLkxBw7yQIVv3m7e96qMGtnvOzC3P/FKhhgRIx3aq0ZwWpLYSmST/
         iBrXCXuRvCn4EXJu6JBQBmkbGM93B0UG39dXe8JvoBc6MZnOEZOXtmvwFJN5fiw3XTb1
         KJfg==
X-Forwarded-Encrypted: i=1; AL+hErGRUKt0At3m3r6N6dFl1HxeouqxohQzcvkN0/OooB3+ZTNzvRlXHa+4fgp5Fe5a3sWvaC9Ltd/kvbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LW4HpP4hjZSHj7jCV1j2N7xWfGQbGRyoMpcynJx6T31LSAP1W
	0c5wYTgdKrDxNMuqYW3/TsH9s0swAzVHjyPBr2EHkIF26fV3tGC38WP9
X-Gm-Gg: AYBFou3k2y8mfJG9RdXrDG90dDCu5EVx3LBpe3DbWZtEP+KStGJtahOfZCxiO4eZCzK
	PJjfBLS1V2p1VHx6NTqabW73qqm3fmGbBOA18BfhLfFo7ncxLlDlPV9UAXceJv7SrQHHPNd7BOT
	bfYGhBJrFvmoQzOJSJM+VLA3CIYqK9N/LSeJd/4mL5oSOyw6fLQYVp9gTwB+xYttK+DKevvNS7W
	3cs62Y0TG5cqmULu7opc6a0xYU0gIDgF+C0CYm3HY8UZwX0qE4Ekfxpe1hkMnH5jnXbVSd2WLht
	YTxzEhcxDiNSym6aeADdnvUwLtYAERd10WlL4K7J9dSsmdLcR172Fx9EOX6XqnP4Xze/u2N+FEs
	218YEtoD1BdUrFKyJC9ov4mzvSWmQz2rIKqKozmsKPxGDIQZQPC26QpwsIn7GrIAEWv5zx1+fn2
	lTZasn/Id2M5OgY8YDS9LEL5iB+RaPpjL9SG63oV87OAlWZnpXfJqCpqSwUIJlm0wsVrR9POoSE
	FzTJNAjTOWumnJUVpctK4FwYrgDiJq621C68kN2jtMtoP/hslhMZNt7oR2ICSDGJ2x+y/dF7N4+
	3bfaeNccANroG/BlbiM+F0xOtJYJy+qwrqPhoPXidFsvaKhr4AXA
X-Received: by 2002:a05:600c:6089:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4ba09376ccfmr49761395e9.16.1794411630115;
        Wed, 11 Nov 2026 07:40:30 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5d831esm3899675e9.9.2026.11.11.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:40:29 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH 2/2] spi: atmel: allow changing bits_per_word between transfers
Date: Wed, 11 Nov 2026 16:40:24 +0100
Message-ID: <20261111154024.543546-2-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
References: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
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
 drivers/spi/spi-atmel.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index fb8d4c7c9..c02a364fa 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1401,9 +1401,18 @@ static int atmel_spi_one_transfer(struct spi_controller *host,
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

