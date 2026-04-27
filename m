Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA33B6365
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307590; cv=none; b=rIauSZWdN82IpqvPhTCsZ5FvSQfejBMF0oPVouiKyy+71IJ7G7xDK7sfGfSs55KY4Z9SEWP7pGVUimjX8hHH01LwfZAKtrdMQhnB0lZv6UPMo53XmjH4KtgyCmutxjxmc9mcZCsvzlqt6OrqxzgDGBNswYB6Ih+ds8rE4JB/AM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307590; c=relaxed/simple;
	bh=8W6ejA4JywJSSKQL7Q25kMUHMTPo2Ypf1rOgcW6fZAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q7jY5ekxvOCBdwz5Ex2NWpn7qRhP88SOXAII/ph/R+OsiMtP0RbQ8SpzyMomGCOwymWruYgUL74GKovsAhUNQHt9UyPyhLGi6GpFbHqu0NwTlcEdDf5iHDJaxrB2Q3eLEJSysOdLWc9IylZKn4QbPkFHQTYPdUkmDkJGL1Talus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlZu9sWr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlZu9sWr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b461310af5so41256405ad.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307589; x=1777912389; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bl/XCw0/NlDvZucl8fmIFkULRBGXTZv9TzNsGmOAeb0=;
        b=FlZu9sWrSuDN3LNguRXMLlDDmIv9/AIrT5EPAXmsLGP9THBgCsFy9nZqX+OD1CC7BY
         cqbnuNclOJM3XLuRKfzyi5lNhQxFWT2HwXJeWV8bsEauxXOVMZ7oTPOBTZHXvEroBDGT
         CWmWEBNawKRPFpOZYw64cf5aPJ39pPUm4ej0QG+YltxZRGv9uikorzWPNgmJ37pahQZt
         hJ2sj5QR9RkEMgKIR+svrdN4sadRns6/J+b4d2Pa8m/UWsoWtpPfUjNQdkMaCYIC5zfe
         rmaJvILWuUP+QyZbDohmlz46VqqRbDYGZQpqzVRY0s82XVwRf60vgNui1PsQ2xRSZ4Ga
         3jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307589; x=1777912389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl/XCw0/NlDvZucl8fmIFkULRBGXTZv9TzNsGmOAeb0=;
        b=B904L4tGWnJbrvdN/WDIEmLG1ftGwju4akyaOX1yxDGU6n4rVDlx4AJNqndPTX+r+l
         L5ksQmWqIBgmsRXWrfcDHZ8OfoWpQZ6tQwcr+tyJWme96kTScQ9WiPB8YDpYW0oGD1H7
         rsvxnJQNWp/3i242ybzU7YdLxPiIB8FXHODG/NHDtR6z8t+0oQqUfbdY7Emc5vwu58TT
         8L+CwX/3Sptp7zibcvZGzCjbbP5N8kgUgtCmTXAKrpUEdBKR0qN+XHAQ3gN7Z4u0wtjo
         pD3FAkJ6/zQbPu8HA1mvdWpkAu8mEU1AMcWzVrpFvcRdHH+DiUh7UBs+7Cj11CAWW9fX
         Knrw==
X-Gm-Message-State: AOJu0YwJhD0ob11VW9E3Q93p5tRwql8feuI4g/6aTPQ/uCXfuRfn2Bs0
	97CU5RHXdCt1nizOswANy5CLpn+SylxXJJ5896ZgqrbfDY+r1Py8Mox12HoduzefsOg=
X-Gm-Gg: AeBDiesKMy3c9FLUF986wZq2pTHVkDAsaYs/MHdd7jyADAQ//yJXKb4gIQcgJOHF+pa
	WO2axLSqhXmkxiqSjRZjII55yXcgbjAfDT9Eet/T0yhCYORAAn6JneoCpAT2FHQCrxtX8Gmnahc
	sgZjS5zLpvbstnFLo4ajuJnpyh9Mh8CB98UdZCEqVwOxChJZQm/jrHsJ/X0we04Ozlc0wpwVAB9
	WVtloCUjU4Ws92CP5o0Sqh03TTEkwnoY4z59UX91OlyMo/Zp5rOBMhG9B/ZLDUtm+VT6JksulN3
	8kcaNfji6UN+y19KX77o+rCN7tDkSbzLetM3ik/N3IPZO/nZ9b2TsbTRlMKMUWIJAJ4nk22p8KF
	z5OdDmUFykL4b/mGArRJ7xLswDphai/y2bMmD2rVbB9FIA/QQkdgYUD/gN4khdJBb5P+YUWtka+
	z9WvhYjViQdh4SfrsHazUbANHa5Jyh+bJ4LQhhqhf4C36JmmVy6fSaI0zmbjX0W4JvRNh4W+MeB
	zfu5i7yOtcf97xZCKOBG/8srewqOu4=
X-Received: by 2002:a17:902:7615:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2b5f9df6fc9mr269245635ad.11.1777307588432;
        Mon, 27 Apr 2026 09:33:08 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa174c3sm309346485ad.21.2026.04.27.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:33:08 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 28 Apr 2026 00:33:04 +0800
Subject: [PATCH] spi: axiado: replace usleep_range() with udelay() in IRQ
 path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-axiado-v1-1-cd767500af72@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL+P72kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3cSKzMSUfF2jJPNUMwNjM9NUy0QloOKCotS0zAqwQdGxtbUAO8K
 1G1gAAAA=
X-Change-ID: 20260428-axiado-2b7e60365e9a
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Harshit Shah <hshah@axiado.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777307586; l=1029;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=8W6ejA4JywJSSKQL7Q25kMUHMTPo2Ypf1rOgcW6fZAM=;
 b=evbJ5bCAUbuUcCQyFS8QvVajCnmBYUG5ma1I9W/857WZuf/FziNv4+AYnXR8V9fsnELVLdqY6
 IGVWiI+OvOoBMcaRfQHvbp9q5ibD0wwzHWa++Qh8GbMwiuDKyEsN4CW
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

ax_spi_fill_tx_fifo() can be called from ax_spi_irq() which is a hard
irq handler. Replace usleep_range(10, 10) with udelay(10) in atomic
context.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-axiado.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 9057a0a8df4a..649f149617ce 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -201,7 +201,7 @@ static void ax_spi_fill_tx_fifo(struct ax_spi *xspi)
 		 * then spi control did't work thoroughly, add one byte delay
 		 */
 		if (ax_spi_read(xspi, AX_SPI_IVR) & AX_SPI_IVR_TFOV)
-			usleep_range(10, 10);
+			udelay(10);
 		if (xspi->tx_buf)
 			ax_spi_write_b(xspi, AX_SPI_TXFIFO, *xspi->tx_buf++);
 		else

---
base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
change-id: 20260428-axiado-2b7e60365e9a

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

