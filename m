Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44883D522F
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154270; cv=none; b=hHNdip/1oPAYakN9R/xdA/m85m5TYmzfXWf8w3znyIjefKyMQfDRict2epszSziTJ/rVAUskqqP1Gf8Q12saCk0cLetpi8MF29aQcdXpzHY3ZZbhWZK5aTNDXdrUPAQr9nBtBfUXr2AYnMQFVLyay6a5pSi83A7cCI4M1QFw24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154270; c=relaxed/simple;
	bh=boNJ69izu4Po85DlR23ZFlw+FQnVPLgobCBMIw4FxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqqsKyn4sLo6DisK7ctfbIdo6938ZI/YYUSAL8H/VLym3D28haDCHTr/iWSJPRjnuBByMMIfrkxxrQYM+uDdQFk7zYUHpMfPDTTYmFMxYBo31w8zQWxsHm1KsCnHBh7Orm2cWI+Ge1uIcSpDj3JZhjzlWtqfQRekLgRNLcsnvdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQYpkkWq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQYpkkWq"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso4091937f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154265; x=1784759065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ayVRODy6318qyfpX2UfGYb1K/edgs5jcIKghZ58HX3c=;
        b=mQYpkkWq+AKlfhwMACdvwCwmpaQODcb3ZZ610rNTEs5ThGWeJlFnDHcXQHaKiKs9gG
         exqPAfVqNGnSJFZEVkbXJ6V70YtQitrqBC0oDxoorLLrVy9rI9bF9+CezqLzpA3lIJI3
         DEB1c8jhIPR+UGWFd/0DrM+HcwTRn3iB1kx1JdYe1VLLs+mQt+QV6lSq9pTqBddhYiil
         R6fMz2ujbSSQHTU/vNZfcMpe9bUx3sqZTOIZAF3ebigc/KbnIbirL2WIuMWGQvxSYZUr
         D5/uAWL4vEi2jHUFBZRlLyGYBHNREDM7mvluTuuG85VoHLkbTlQEB8z4ZYnfxKw0VA0A
         XcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154265; x=1784759065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ayVRODy6318qyfpX2UfGYb1K/edgs5jcIKghZ58HX3c=;
        b=lWwD828FOTcZn+VUpROBmZOZEwnUEtB3N/9SexcOqaGewHohtW2gZzrMuwXXTNfDct
         U5S3pkuoTP9tRWGCzbBfC2dNEH1iZQdb8sD9PaSs2o8uMEN+zUlPlF8n7lHu2Xr8HG0k
         /uGrH+l9FFy8W9wY8hqv15wJIq/DRjFabacR0j1KP6O+ezLgzR75AkeSI9swnhplCytU
         oA/bkktfuI9KL8Z8XiEH68ZCxFS6TeDwglZ/LrmzO2G7V1oU9T4h+FZMjH7/W9fFed9c
         WuQXofP0BhrfBpngVf7oQ2r2At32/H+pCEHU2XI4bqx3X8UtkOojpuFsBH3L9uNWcYv6
         tBPg==
X-Forwarded-Encrypted: i=1; AHgh+RpzG/5/ie4lH2UeGg32zixUFVdbBri2Y9DcOQ7n8QXvgVfPjgSHmBxNfztXOyFx0FE5IZ2pyM2pIdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziB6ZmoRkEH0EMYurWOxOe0FdXTtNxUUlfA5ShqZF79H8if+FK
	MPl+jrCSF9pBGcarqf5zFsG6YtDiJSjeif6mYicpX0e+z+Cf073kmVEV
X-Gm-Gg: AfdE7cl2WZl0FXvbhzgnpAS1VnD6cFdARgld4SmCt+KUEyDpEz8Ei0SWEcZTJmWT1tf
	Gwn5U8QlfhkpLNbb98XhZcz0GTdjFmF5Zd8UbnB4FqqNqLpBBeL++5wbflsqpoCm+r1PNhFfsGJ
	mtZbhb+wdRSoHISkHa56nxYQ6kFb+O9L2zjVBma7I+MuH7fQ4MS6ADB0Z9nWw8YZMjZ13HSwPHq
	EU5ah3d+thz5xAlEHfbVyY7rsCNLPqfhT8PraCQGwYoFZKw/JjQqX6e06jEMZD7+NL3JLxsfPGO
	Hz9apfmP00qZCnYWbWpyf9scnDP3T8M0Adjtn9BcVzgtAQOefo7+QrSB+nhCSxLOfKgDs8Rz85q
	xnMkqeqltMU9/ds9KH5dMHzgcjTePadBhAuBPh5JTTK7qoOHpqzy1NGhOKSTeiEgbZ4p5aA/jkC
	K1Ak41jmVO6Pbx668k5fwh43RS1D15E9yRqcehaGBsZOeYbzcPM9CJ7E1FFuXaf9GuNK4vVeqvy
	3q+nmcfQElewDkOxhRWnHs5Jts=
X-Received: by 2002:a05:6000:d4b:b0:47f:45b1:128c with SMTP id ffacd0b85a97d-47f463b03c9mr9604047f8f.58.1784154264805;
        Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/7] memory: renesas-rpc-if: Consolidate command setup register programming
Date: Wed, 15 Jul 2026 23:24:15 +0100
Message-ID: <20260715222417.2997712-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Simplify the command setup sequence in xspi_manual_xfer_impl() by
combining updates to XSPI_CDCTL0 and XSPI_CDTBUF0.

Clear the TRNUM and TRREQ fields in XSPI_CDCTL0 with a single
regmap_update_bits() call. Likewise, program the command, command size
and address size fields in XSPI_CDTBUF0 with a single regmap_write(),
eliminating the subsequent ADDSIZE update. The intermediate write of
zero to XSPI_CDABUF0 is also redundant, as the register is immediately
programmed with the transfer address.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index c768e9c18556..d98991266887 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -636,18 +636,14 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *xspi)
 	u32 pos = 0, max = 8;
 	int ret = 0;
 
-	regmap_update_bits(xspi->regmap, XSPI_CDCTL0, XSPI_CDCTL0_TRNUM(0x3),
+	/* Clear transaction number and request */
+	regmap_update_bits(xspi->regmap, XSPI_CDCTL0,
+			   XSPI_CDCTL0_TRNUM(0x3) | XSPI_CDCTL0_TRREQ,
 			   XSPI_CDCTL0_TRNUM(0));
 
-	regmap_update_bits(xspi->regmap, XSPI_CDCTL0, XSPI_CDCTL0_TRREQ, 0);
-
 	regmap_write(xspi->regmap, XSPI_CDTBUF0,
-		     XSPI_CDTBUF_CMDSIZE(0x1) | XSPI_CDTBUF_CMD_FIELD(xspi->command));
-
-	regmap_write(xspi->regmap, XSPI_CDABUF0, 0);
-
-	regmap_update_bits(xspi->regmap, XSPI_CDTBUF0, XSPI_CDTBUF_ADDSIZE(0x7),
-			   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
+		     XSPI_CDTBUF_CMDSIZE(0x1) | XSPI_CDTBUF_CMD_FIELD(xspi->command) |
+		     XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
 
 	regmap_write(xspi->regmap, XSPI_CDABUF0, xspi->smadr);
 
-- 
2.54.0

