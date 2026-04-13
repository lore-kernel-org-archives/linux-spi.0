Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7453361666
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074747; cv=none; b=lGo0oCH6GFtbPYpmIXcZ2wzHgwBqglj4BKdTq/Hu45i4OjT8udON5dIR8x1cuom3vuKq+r2KfqV8CiehcB6PchF0kulevfrns3Pi4v7UOyzpdNsq9O1gbdRDFjf91pxQ5pgkniKfMzM9GlSUQq5puRxJ4A40FGsUK9tp6ABxsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074747; c=relaxed/simple;
	bh=qC/bld90r+ThMcnTaEI8CINzwhOGNircQN5AmvhHCP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8pz8u4m1sgzrpLz4EU1z8UWkX5Oh658HmMkowKg7C0WJS6cL8Z218YPIr0LIY2JXa1Amww8DDbQo0V9u6JZfoZfimaCKTollKGf8KwZbiFeimSSpht1zkodtk7agPPBYJLeR1+cSpQEd2mX+24oQcG3nt6beCT2GuGPtKKN+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2oGpWnX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2oGpWnX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c04152730so638455266b.0
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074744; x=1776679544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkilzuMUQETyKz1FjFPqWn2VyiH1H/H3jmR+rqzk7H0=;
        b=E2oGpWnXUS9eehh2Me/Z19v8vqAUo2Fu7QOT0nwGAXJHZdzSW0OlLXpQZVXeRrdPxK
         VaKL0Pw4bXnuoDYPNTxByXzU6lF7XumZpK+Ygvmqoku83rx3XpPj8OPputHMWm5axM4P
         dAgZSHPdpYyOY3VY40nk//AucxNhztV0y5Z88PI4lChyAsa2Cs5U8LQqrzF5z7Bp8rhz
         MJokAemsJ45kzzvUnXMTmH4zJCosW0rV0nUlvD7nz1GKHUobAmf+77vx2xjSs9AvQgQp
         NUHewz7YrMrHGJZW5C2X9CoPd8zKokSOjWRLYw+AZwxfLX9K1yPTJZ7eA2Sf3QUEJi2n
         WQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074744; x=1776679544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QkilzuMUQETyKz1FjFPqWn2VyiH1H/H3jmR+rqzk7H0=;
        b=WS8xkfv0b1XWm2jQ0jt3LEXpcUUVnYaCwT2sd/zAloTZsKneDN67t7kfEhe9dbPtw3
         svV++aOAHthm3OBCpJ6shJVaucfGtNe14ycau83G30AAbAHOgxLYxLTXQovLt05nReWj
         pICQlL6UR+EE2bzhzSgWrRbGTC414G9IDl4MH4vfW0vAg5umQgHo+AfcT6WntiGbt+dq
         LcbxKjXUvqAr3cDbCsicKuTOIX94uS9DYy9DnIms+Nzu8JuOnGf3oC0l9paousnWW3Yw
         4wNNJhTf2NFqn5tuG/5I0C2mBj873trikCJC5Td4CNKTUs2GosC07dCgGpN645nq8ZVx
         F+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOtozwW/89gcZs02Evohzq8sUDp+nJ9uzaDNVQFbIk3+g8ZD65PFqD/RUb7FkvVPo6eRjqchQLMPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wLvTYjZtSofeKpnyF7H00jse80hJVJEmyEeYx88by6Hh4q5Y
	+ln3d0QnRa2KOlbQrJ/UEU+aNd71YEKUGThOvjib4bPT0o3/3a3jm0CZ
X-Gm-Gg: AeBDietXQsM+cUF8Na998go5DgduqlLkV4JALjSEoQ6dL43fITHVhOpx8dJzFSRmBiy
	zuQJdFUsUgAyJuipvup6Ew4oNCpAxcK72sczRw4j9DjqJaGUvRdXZv5OFQbdXbZCzJVmFQTq1Wg
	TWHFMy26Jd00Y+YvTfvakMSivZvv25U78/j9UKwO319ir01gx0fVx+nqvBhxD0hWxB5BYFS+n8i
	VV5JOTPxcbiXoseQXJredM2D1+aFSNnRQ6t6gWjsGHDRhkWY+kLtNTVKi2o8DV/DS45KMrnJmrT
	Tf8dQedBDtZF2OdYz8mRchJr3RS1bXO2O1YzRjcSJDbumbb47+m1vcA8A4uYoIJtwMgZS28uOka
	JQbfH6UV8HLXA3mntVwpd54ENiudKkUEdAEsK1drePDJpHK4G3NM67m9DD2xOdcljgTFNu2G4UG
	Cd6yvCd4qudXocnhiyVSnSfQ==
X-Received: by 2002:a17:907:e11a:b0:b97:a1ca:e100 with SMTP id a640c23a62f3a-b9d7279ae3bmr479411866b.32.1776074743885;
        Mon, 13 Apr 2026 03:05:43 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm297805066b.38.2026.04.13.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:05:43 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH v2 1/3] spi: Preserve preset cs_gpiod in __spi_add_device()
Date: Mon, 13 Apr 2026 12:05:28 +0200
Message-ID: <20260413100530.580649-2-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413100530.580649-1-khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
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

