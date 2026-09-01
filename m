Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE24A2051
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290797; cv=none; b=DtEpuZKdxnEO4ffO4Jqfj8JuFhcef5/L8iMLsKR6zNu9MdwHqI6F7kwwo19lzzNBv9CpIF/4S1flDxT+pSPJP3RnrRpt9xdtlc3X4yngVpU4ChqTIFUbkO0qQuo7q8h/bGATwNFea4PbB4SS/35JHa6ECemd49M61+JwYCSJZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290797; c=relaxed/simple;
	bh=Phr/lyT83N6DYL7BdtQd1/VdiLOr4iWUkwC8JFgGLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHMTr6lAOba3flG3dGYXjHl9p5wRurQxi2u1RnbGVTof2JQ3ZErdYirrfePJ7Jr5+AkJVHMqtDO7aCTvFLg5DzrxjS6iOCS2Dyfi3nafNUMZfWTi/u9psUsmC3cFjqFsXpKQuZ4vEd9aYmq6jUVYzbPCWepXZiAdHIDlm3xiJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb0qJvel; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb0qJvel"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a63c610b8dso305878a12.2
        for <linux-spi@vger.kernel.org>; Tue, 01 Sep 2026 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788290793; x=1788895593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jZowfmyKxOguFaJuZq/Bm4rZ+Os6TFRN1DcxWsiy2Q=;
        b=nb0qJvelweh72Eh8xFecIIJGexpOlBTjJnA+Vd56Q5a+sPXa+vgsPG+IWtqei3h9S8
         mI2vZAcPE7GDz07cpSYuIK0BkuNduXvajSkpiEvZRJpepGwsDkM5PwQyzGjwrtjKFSSA
         8h+Hz6JX1sZOlk3hHQO4oFgKu/I7+E+IuCzWhEDGHA5ILfhmtNEBGH0jQIClV/IoYj1p
         Ocy6MwJFaIRrm4CRpFt7eVZyGhNGvAomWh0jiatmVP9vlBjoJLyj4cBtfb0gW8CjtB2a
         CgorVoJsVasH/F/3oCZjmRkbIEAHr1iBICVhTGW3ibHXs6PoUiLytY1SE5srW+rKvtic
         HWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290793; x=1788895593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jZowfmyKxOguFaJuZq/Bm4rZ+Os6TFRN1DcxWsiy2Q=;
        b=socSG97VYnPRrTaE1ijcI/7NCLzKJkQsZN7MLplVU+kHfKRF8C5vbyAJ3Iusa41IFe
         kSxIKyJT84IZc4rrX0Dm9k6KJ5Z9XfjDw+VQJbYADh/Kx6aUamJT1eGQtSR2zVVm1fRN
         AaB9zq9w2TzcPBfZmyT5uTKwqV9KKbECg83uqJGRdhqle9b84dqzGrzXKNdayxtwZA7L
         SsX/oiK8HYju9ky+gZpBQ566iX/V8r44o2vdVJ5mgdmr215G64onA6N5J683g5ki5Iac
         Gd5+iDtktjUjpLHFx9p1cr+F1UeSDLHy+vJSwDiyJXgYFfyD7musTFT6v95h4c6tU/ZS
         V1Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzHvmCf4KM8E/8NV/PNhTPlsG+gwj6gMhk+ExQDYEAo5dOtnqoUDAVyv/ntox3cbeZ8L3DzUc+cuH4=@vger.kernel.org
X-Gm-Message-State: AFuF++nnrGJ8bQoUzQSkkZPKQbxyNfZpTxlMoAanoTlWduXe9x+0DARu
	rI3Q9JrscwBQGrOd32httMR689re42h/zcBLpYfjQyxF5NZEZVWl3sSo
X-Gm-Gg: AYBFou03mmJMNkWDJPg4wQnignFbHFsGaRu6zETl8pAQlGoSQNAejQDtZzZQCipOstO
	jXRsot9IVPnYoq1SIKu8dwfJXNuy/YPTFbT/Cx6YRWRECmt0FKaoL/doi0X+TUilB5EmGETHKv6
	qKsygzGiVfHXc8bBTyA9Lq6GsI0ion8ap+aGEWWaivtyyT9qEfmQQzV7aCaW4aJ04UWESu51wFr
	ikQEmZB9eXdjEiGQRob7RVtJcjBUloJKQqkDRzfKYeLzMT/gdYxQkNWN5jEFemiVliIMxU928Kd
	PxvnK3s7EAqxa0HXRmEOMPoaqXU9+0Fe53Ph+MtUMYjwg7J5CmZPw5/Eiievt6ceRoRlkZldnyP
	PCgok7QvuldUOWfHvHQGQKNYz93G4fbcoPnRaSS5ONb16RIM+9A8rpn2VOoDRlNmu9zdTOLZ1NW
	F4qY8MMYK8EX86WmLxapcCVqC0MRPDIgtMGvuJJFeXoMsM5A4niJj4N5vhWnPZJA==
X-Received: by 2002:a05:6402:5305:b0:6a6:757d:6311 with SMTP id 4fb4d7f45d1cf-6a68257c1eemr63061a12.9.1788290793582;
        Tue, 01 Sep 2026 12:26:33 -0700 (PDT)
Received: from khalil-hp.home ([62.250.116.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f94242csm146373a12.21.2026.09.01.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:26:33 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: Mark Brown <broonie@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH v3 1/3] spi: Preserve preset cs_gpiod in __spi_add_device()
Date: Tue,  1 Sep 2026 21:26:23 +0200
Message-ID: <20260901192625.1497791-2-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901192625.1497791-1-khalil@rentman.nl>
References: <20260901192625.1497791-1-khalil@rentman.nl>
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
index 07c572e1df..fbfb9a1aa2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -924,7 +924,8 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 	if (ctlr->cs_gpiods) {
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
-			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
+			if (!spi_get_csgpiod(spi, idx))
+				spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
 		}
 	}
 
-- 
2.43.0

