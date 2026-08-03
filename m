Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A673469E7
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738314; cv=none; b=EfnBAuU+9Msk+3v0MScWPeH7jrAcS+KwnO80jFK8WrFq6OhuynesajL8e06VVLS3Kg6/mj5AF+CVshi0MBm9KIHQRJJffr347aOJ9mZn2xZuxq805BaEs/C07wxhy3MwEOMkBAImfcGViEse7qRqa4rOHUoAhyIc4ZczaAttqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738314; c=relaxed/simple;
	bh=zsFePE/nZXgVQXKQXIUqazjLIcytOgC8Mp5TmalG0HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQTHVsTf5Iy6X3cPdDn/fi5YkMSoyAgMLe91/LD2VolDZIkHVVl/oYb6hwB9yL9sA2ZLDIAFeuspjlY+jUtCqW5aXX54bVrfowHK4viQelURJ/xb6KM0poLaqmsfEk1VZ7Ld/XDS40yKL91VJYEXG6YqN4L88g/nDfyoYEgJ3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/OdQiVL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/OdQiVL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848479c9bd5so2418349b3a.3
        for <linux-spi@vger.kernel.org>; Sun, 02 Aug 2026 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785738311; x=1786343111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JTJfnMPbA37cVAyGVvx8GRRhd+dTZCIcUs03TckN6k0=;
        b=A/OdQiVLBzm47Zw/8oiqz2FZqncZB1ZgrkgWoXjNflqrntRYDSxBa9hICbHGm28dFe
         f3jFQFyOoOGn0XQkBnueu4iKQHgYDqpN6NiHG8uj6CBVHc1zuylULwjs+qmoPf5TTE2p
         TktTkKzkhajuPrGwjJ18QY8JKN+5seDsnDB9Wun9V1sKDsa992cCqODSO7f/GEjiNgiZ
         4/gFxnMo61e0t1w5ZbFeP62JqgEwqLMgJhws4MoyFAf6LGCWNZSMudVbbQLVwLof1PJ+
         FvzTuaxAmlvldaI8qoMzAl95AkbhNdkXzmC7Inoaq6Lr6lIMFu6azKPH+rCQLBhtKsSB
         lXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785738311; x=1786343111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JTJfnMPbA37cVAyGVvx8GRRhd+dTZCIcUs03TckN6k0=;
        b=DIyaGe6ZoyVdGus+14PNlSvuKklJt/Clgulw2s0RjenwVXvJLEjEdOEkRnmbaqDCpE
         7VYIvaWxPPJ46UJtbY+VtBC4pyWaVZHez3GJpdtTGOhTErWv4sU2aFs9bp0h42lC4Ztc
         vgY7qWRDhgB1cpBEjmIwp9HqWLLpBlSee7zcyN6/9Mtvqyu/8AXseOmmJWQv6Oo+FauK
         AhB1AqSBT/ifSGINejt4fhnrm1UsFKK/nrbnOqMnb5OUz7ej+kUFm33kY2wyxk3dDfrs
         DDyLGTs9qtyuiqETxTDAtO1HzopJ4rpk7S+5nti42szAEaEnww50QdOdP9f0bbQqvpnS
         5zpQ==
X-Forwarded-Encrypted: i=1; AHgh+RoB2XbdM8ZLsc9sKqv05WeHeUEWrWmZvKee4RAeuGHBapYAtr4eXcZIIFiZqf4kvGtdd6wbBBszYJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluRQz0bDyXfrDZpN1VxMi5F+avr5J15A54INUNfzLeQC/LXWc
	2PGDE/lJKdjvB8EdgVh4b7TZ7Q8EPh3p3GMvFOJaqBXB78oIDx6oJezA
X-Gm-Gg: AR+sD10DeYOzPj1NgDF47T5vWV6NXv/FpZFfDPJaA0vHKdYyOamg74v3U8Qz37419XM
	o2+IqIMpGZeUd4heLfHsvDyZp3Qj+qKJqkE6ZT0Q9S0KAexyrjhfgPdFPGBVOgbqHmjzhg2JmTb
	332hTKMTk+omHaa+b0lEnPc6IV4Vc0myZK1Gb9yGQdOCsE36ecdvrOsQGjGeoQpBRpSOXBs4eQM
	poCScPMKhhmv0ZbiXGKDebxN7yxe6mpgowfo2znKd5fU4WepFhw/0AUzaZbgYf86zC2ZwU7+zfX
	cDiFAen0omR5NFxaL+5MLc8ibr1Ref05RXPYTEiti5O9cVUEuVu3IDWMRTFlodXjWdlqzD9Owt8
	czN47MYVaP8hm3G3dlPpEia7QOBPYKgGvKUTQ02x6/42z7uuszucf/4emPnvBNBXBwJLCaOi57u
	+X0QA/ArNg4bacJpRvu+gHwqu/0vW+ISZmqIa6sy7PPsJ8GAVdWBgYK0yq+8iAfzjkyhjk4nB6b
	WtRBOEG8jjDYbJzDMsOktxZ9Umla6uE7cxELXHb40Gs5LnK85w=
X-Received: by 2002:a05:6a00:8d6:b0:847:94bb:30db with SMTP id d2e1a72fcca58-84ee48bc6f1mr8775916b3a.49.1785738311301;
        Sun, 02 Aug 2026 23:25:11 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29f312sm3132816b3a.33.2026.08.02.23.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:25:10 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v2] spi: ma35d1-qspi: Enable GPIO chip selects
Date: Mon,  3 Aug 2026 14:24:44 +0800
Message-Id: <20260803062444.1649057-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The generic SPI controller binding allows GPIO-based chip selects, but
the MA35D1 QSPI driver does not currently enable the SPI core's GPIO
descriptor handling.

Enable GPIO chip-select support and specify that the controller provides
two native chip selects. Add a setup callback to reject active-high
polarity only for native chip selects, while allowing GPIO chip selects
to use the polarity handled by the GPIO subsystem.

This keeps the binding capable of describing valid board wiring while
preserving the active-low limitation of the controller's native chip
selects.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
Changes in v2:
- Enable GPIO descriptor-based chip-select handling in the driver
  instead of disallowing cs-gpios in the binding.
- Set the maximum number of native chip selects to two.
- Reject active-high polarity only for native chip selects.

 drivers/spi/spi-ma35d1-qspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 541d5d72484c..60e082de58f5 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -430,13 +430,24 @@ static void nuvoton_qspi_set_cs_level(struct nuvoton_qspi *qspi,
 	spin_unlock_irqrestore(&qspi->ssctl_lock, flags);
 }
 
+static int nuvoton_qspi_setup(struct spi_device *spi)
+{
+	if (!spi_get_csgpiod(spi, 0) && (spi->mode & SPI_CS_HIGH)) {
+		dev_err(&spi->dev,
+			"active-high native chip select is not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void nuvoton_qspi_set_cs(struct spi_device *spi, bool level)
 {
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
 
 	/*
-	 * The SPI core passes the physical CS level to ->set_cs(). This
-	 * initial driver only supports active-low native chip selects.
+	 * The SPI core passes the physical CS level to ->set_cs(). Native
+	 * chip selects are active low.
 	 */
 	nuvoton_qspi_set_cs_level(qspi, spi_get_chipselect(spi, 0), !level);
 }
@@ -613,10 +624,13 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 				     num_cs);
 
 	ctlr->num_chipselect = num_cs;
+	ctlr->max_native_cs = NUVOTON_QSPI_MAX_NUM_CS;
+	ctlr->use_gpio_descriptors = true;
 	ctlr->max_transfer_size = nuvoton_qspi_max_transfer_size;
 	ctlr->max_message_size = nuvoton_qspi_max_message_size;
 	ctlr->mem_ops = &nuvoton_qspi_mem_ops;
 	ctlr->mem_caps = &nuvoton_qspi_mem_caps;
+	ctlr->setup = nuvoton_qspi_setup;
 	ctlr->set_cs = nuvoton_qspi_set_cs;
 	ctlr->transfer_one = nuvoton_qspi_transfer_one;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.25.1

