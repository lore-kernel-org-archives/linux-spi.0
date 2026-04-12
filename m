Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1529B78B
	for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011540; cv=none; b=aYl3/T1JqOTS/Ox8GBI7z//6k5tG1YzW82qyLJhDOfgqKYHJf45CwB+KKStch/YIUyhUi5rFhtBfC6qZbxwP+8DCxo82jKux3S91ReKcpe3GyoO9xd86LaooqTLuOq2GQjyt5JwfRUMp+6idSAiZpJ/z8wFfck0Ft2gXBl+tFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011540; c=relaxed/simple;
	bh=qC/bld90r+ThMcnTaEI8CINzwhOGNircQN5AmvhHCP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JL7Wp/WvP6Kd+r2cpSHExB55JzB2sIcPYo69G4ICyMjGSAlviQK64hl2ofG8SxH15s0VEjqCiMFn/8/bDE1QwtMPyHLlzvr1qCZiNrrFdAHyKuuL6ZbZMSxThHAi6DxBq6iYpLxIc6XAkuy15stt0tjWtJXtPKBFJSljB6spPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1lemTGY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1lemTGY"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b97f9587e6eso476039466b.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011537; x=1776616337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkilzuMUQETyKz1FjFPqWn2VyiH1H/H3jmR+rqzk7H0=;
        b=R1lemTGYVMEfAWjZifZg7CULmonpTMYojK+x8GF+k3EOuW0jeosAybx6vLMP+WGDqZ
         2K8spSvtSocIkQuxRmCt0cIlbFY+9dFhF26DrxlM0BiTGZVDE/HK8+mVgi7haNtf1Tud
         BivJOh4obcobjf+GUaHdfttItb+xwQt8EZpRWsftJFKr0xyqR7OExYFGQKTZ4DelVWHp
         0PB+/NEhJmiqOSeVW57D36p/jMCmtCHMAO4h6FxkRYoOkqqyYONelJnm8qIje7Nb7a2m
         osaRN/ofkfYt/2xgJDGRaQaRBmv/nF9n9pnyKYm85ibT2Vn2Zr2TfJLZa+2Py40kCbF+
         WKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011537; x=1776616337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QkilzuMUQETyKz1FjFPqWn2VyiH1H/H3jmR+rqzk7H0=;
        b=nRHgq5D0xfKCCUMvb0MJH1WDlNfaYQ7qlm7I2RKWwU+oKgKlhQV7yHdY+LZt8CHxN0
         TzCUUY0hZoydjOTG8TQ3BR7uhC4XD7tKCV2w1ePLN2bX6QgQXknVt0sQ8843zfeHbzSp
         Txcj13GJTexhsxjwyusIZvChphWa3B6oW0PQnQ+JzzdXybbyiUDLB9xU5iwvKZ/o0j/o
         wMW7reGIfpc4ZcT60k43eF0IDWcKe+WW2x61AAfH/wzUmhe3cgAICYSSpduM6LOqP79J
         IHylB4c63ft+HSv/Jq2jkmL4avdD3kUzUKL5s2IPi5yM62hHpJUGxjSqaZTlaD6pWzfj
         Oo6w==
X-Forwarded-Encrypted: i=1; AJvYcCX1HhhIoJutTlq6Ggd8IoXMqXUK3DlK2w7qOCcrLOYOPHOHvH+thtITlXEKYHSbrWQDEy4vGONWbMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+qWTMJ5HqnhiNt2YhPVDdgRLoBT/ZlEgRw3nK/rs8QojRrD0O
	e5jPH3LhVOwxMMsoOF3nZRXLsvuhegllINK/dyw7oUlsXFkNa1JBw6Ep
X-Gm-Gg: AeBDiet3MAf2FQsRvOazqGK7+PnXUq9LrBvDBWbgYl9du07zSxo8SzLgnGTCyeNQQ4U
	j5XDT70q6rKwMmabVVmFPcUxMettXAdYYPTxEqB6oIdPJDNzRpKYz3gUYzWW1YLGyUH550KyITj
	m8jJLON7ZN7XbueAysYeIvW+LbhH9d4N5VTals7I1lVIqQr9zVzdIsKpmTtcFeDW0DaXer4b1LH
	LiB2uV9nK6YHuf8VKd2VpFHiSKSAW5JA/vzw17pR53APOz3hTIYgNpErnZKCzs/wuM0enq5cSqZ
	8kCAAny9ruCG5djErseQvJdQZivXM7XzKPEO5S7YW39V+G1cPOsqFfKRciFHZRKpKWubggtducO
	KcjTKtfs5vZVuOYRMM7Uxq5NEA2TleN9mNu+WK26cA/az0zqCHOT1nLDmNfIhBJXbL3G3zMUFab
	/C0Y79ewQ+jg8NXGCdDq6wcA==
X-Received: by 2002:a17:907:6ea7:b0:b8f:f08a:4b80 with SMTP id a640c23a62f3a-b9d724ee4f5mr589125966b.3.1776011536824;
        Sun, 12 Apr 2026 09:32:16 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1a3bsm236468666b.62.2026.04.12.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:32:16 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH 1/3] spi: Preserve preset cs_gpiod in __spi_add_device()
Date: Sun, 12 Apr 2026 18:31:49 +0200
Message-ID: <20260412163151.506282-2-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412163151.506282-1-khalil@rentman.nl>
References: <20260215135524.1171065-2-khalil@rentman.nl>
 <20260412163151.506282-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__spi_add_device() unconditionally overwrites spi->cs_gpiod[] from
ctlr->cs_gpiods[cs], even if the caller has already set a GPIO
descriptor on the device. This prevents drivers like
serial-multi-instantiate from pre-configuring a GPIO chip select
acquired from ACPI before adding the device.

Skip the overwrite when the device already has a cs_gpiod set for
the given index, allowing callers to preset GPIO chip selects that
aren't described in the controller's cs-gpios property.

This is useful on platforms where the ACPI _DSD cs-gpios property
on the SPI controller is incomplete, but the peripheral's ACPI node
does contain the correct GpioIo resource for its chip select.

Suggested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Khalil <khalilst@gmail.com>
---
 drivers/spi/spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a0b2bd3b8..64be99d13 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -734,7 +734,8 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+			if (!spi_get_csgpiod(spi, idx))
+				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
 
-- 
2.43.0

