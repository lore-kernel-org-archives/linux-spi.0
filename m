Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795335787;
	b=sSWhT7qUo7oeUjIyxxIqLdOHDGlDUm8dqtbAgyiM4AyygyqGox7feiORkT6jpTzXJgSI
	 Hki0SvpaosDFJy7MvmZiPuWs60ar47oQolOTcffPHAO90+0RV+McMaySdyVqnu28ek/gY
	 /zIC2r8+sbdk5Gq3DeXyXXYynnFWzxJiOZY4jlv72vdRMY5qNJNN53cgsRZOhdF8BaKyM
	 p/Be6u2KQx9JLQitezYOVQMD0nJokHazxtaejWnyn2wYV0XeMnVEfMcfS05lMewiO/16v
	 4VYPeUBTnWF+V5mJkXj+LaEzNzgf+82mC6a0LbSP9MARZk5cALhLy1MHpIitocdahnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6akX7pzAHH0ivf8SsSGJ7CYw3qAkgFrjvzXEYBsaGuI=;
	b=TXuSFDeYV2FCH643EX80ogetk8j0r3e9PtmZXZBePXInezymvmCf8X/rZR4vanzuQCTE
	 n4E66XSpoA4TUSvmDcTvIitoivWBvZrE52trqe8aaS1EgsYa80VBrlavhvgqMPE1mtnk3
	 1ddU+aF8k1FCHC3BSWb96dwfPY0M52i/dFpcGxKWDEZmIiD/QPlfQwW2ACUZpc+7eCFHD
	 /aA2OC5V5Z3F3/dibPAcXboXMRNqkC/ar5xyd9CUfIsDYI4KsB/6M2F7YJ5AsnRDdbPmG
	 J7yIyeNafkD5o0MEaT73OaNG2FoAOanwf2xNVTWxaMjfYQbVVNDLxGqDGWHjo2nBNuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uy+MW7EX;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B82606A32A
	for <linux-spi@vger.kernel.org>; Sun, 22 Nov 2026 08:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B82606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uy+MW7EX
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1084320a91.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Nov 2026 00:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795335786; x=1795940586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6akX7pzAHH0ivf8SsSGJ7CYw3qAkgFrjvzXEYBsaGuI=;
        b=Uy+MW7EXTLIpQBzhIhKP63fq5Q+zqrn/Jpb0imjgiKMDFrrt+OQ9nVUz/T/afveEGj
         dt/5U+42E9umaWXPuya3mQYpWFCpaS0VvPDOU8HPqIR+df1ib6rmAyZ0TAgwNSTYJ+Sa
         sWlhJTacjQqNDNrIu9oUMs6ub/2QNGLkb6cf2hHNWr+sP3+U3gst3F/IIgdyK6bOucc+
         Kqsx+5olkVWetZ11Cr51mWE04jjGROljhZDU5OJoiKnq1LU/ew/IkZLxEvrX/Vs4P5Jx
         K880+r1RSuaHP+GIVhRtRKgi6EIRdFfQz1PVixhcJxzUbQqEqkh2+KnpYfdp8y+tNT0r
         zKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795335786; x=1795940586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6akX7pzAHH0ivf8SsSGJ7CYw3qAkgFrjvzXEYBsaGuI=;
        b=Ocf4x+qpY3m3GWFeMLs5W8M97UV8ClkPYUVmqdn3z0b5G+Mm7Y+oigRpJtzMqWKKzU
         7+XBOAdu13OXHfotZPuv9i90+yc5UuWAh8mNix6qBvAsEsc5vjwrG1e6qTiLEABWb2oa
         BCD2XmLgUPSZQRlo7Fakk8zCmg2W+OnFmrpWd9Xd02lk+YC/syLuVGjwghf6oJ+phJT1
         RPksvyDB4ihZQsKjbnp2agvojN0A9I2Kfbl5cPBNmbAmQn/kWqHzPlEOyJ3ToLNcRtEB
         xXQFEsuUeZfxDmHktPMXOMCqMZtz8gVd8Z3b4HoQbAg49kTqNeQ/fUCphF/jnH5vdkYZ
         OVAQ==
X-Forwarded-Encrypted: i=1; AL+hErH3j0vz6GIovBFt1X+iHjAgK3cLfJHxyEPSFBdFsCbexrSo3qQCc9qf8wJddsCzZeG+xmN5JhfC23w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9RQ7/KA8taVSi1+rsMbXx2a29zI0El4qaYLzfr4aisw9mZ8TJ
	MR3TRSdp3YfK7uy3Vq6hoRQWYVJopypn4tT0+MwhddsDfWMQ3Czkeb6/
X-Gm-Gg: AZFdTZfEYcEOIq3sAtA06WaTvuUyLVo8JbycbIf6AF17WG/9Rqpmg8OvvyVJjKDmZBX
	ecBZBbnHw+4R3YtlSQ7di7X8M3Lpq2bdG+x6DuGdPla5SLwwKQhX/U9W2st/ZBjj9Xdnuwc2qom
	xOEBeyfjkKy2jQIMFzBxOovKixFTTFHeTSFqQUh4BVRQn83gjLMJXuGpaBmyguUMpYJ3KxercTv
	0GoJLXzy8FpIpfxEcP/zk8V2f5NEFZxsvN6g7gbt6qicRaxQ/yIjc28SUPkM5chKaJ4rqumG47i
	49a5xV+i7MtqoR3bB14Xb0Sw9a1Mpbno+ZRPDVtyryZ46dI2/pgZ/oMN7FLdvm3FioSo6AUi/Rz
	DkKjaywAyvg7KwNxrj9yFxbaD5C5Cs69W9EMy+dNZKs8tytcL1oIfJJun7m+Ta7Y1jLBVC9I7Bk
	j6tz6k08QjL5WS2KU5Y4KBP25hZfG/BcXGIWdHj41ELWF7Hs/JHwMgqt0zjn3dbTWHhKKg8CY8m
	gUvWh/tipu+d7VEFxa+eZ/IiDnNwBHnV4rWB4gAMA1fcZIT1c0a8OmBN7btu1HjPjaBpEsJUTwp
	QPtI0oxO+94K/KN7cCKVulvksQKqfYkcXreTwyzOEN6vLF3hYg==
X-Received: by 2002:a17:90b:2f8c:b0:3b4:1997:3495 with SMTP id 98e67ed59e1d1-3b41c9613bbmr7277675a91.57.1795335785650;
        Sun, 22 Nov 2026 00:23:05 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm11723350a91.4.2026.11.22.00.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 00:23:05 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: broonie@kernel.org
Cc: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] spi: bcm2835: clarify native chip-select fallback
Date: Sun, 22 Nov 2026 02:23:02 -0600
Message-ID: <20261122082302.170387-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Document why the driver uses GPIO-controlled chip-select instead of
the hardware-controlled native chip-select.

Also explain how the temporary GPIO lookup table is used when the
device tree does not provide a CS GPIO descriptor, and document the
fallback's limitation regarding the alternate GPIOs 36/35.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cc5748973281..d4c938fa3a23 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1310,13 +1310,16 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		return 0;
 
 	/*
-	 * TODO: The code below is a slightly better alternative to the utter
-	 * abuse of the GPIO API that I found here before. It creates a
-	 * temporary lookup table, assigns it to the SPI device, gets the GPIO
-	 * descriptor and then releases the lookup table.
+	 * The hardware-controlled native chip-select can produce short
+	 * glitches during transfers, so use GPIO-controlled chip-select
+	 * instead.
 	 *
-	 * More on the problem that it addresses:
-	 *   https://www.spinics.net/lists/linux-gpio/msg36218.html
+	 * If the device tree doesn't provide a CS GPIO descriptor, create a
+	 * temporary lookup table to obtain the GPIO through the consumer API.
+	 * This fallback assumes GPIOs 8/7 and doesn't detect whether the
+	 * alternate GPIOs 36/35 are configured.
+	 *
+	 * See https://www.spinics.net/lists/linux-gpio/msg36218.html
 	 */
 	lookup = kzalloc_flex(*lookup, table, 2);
 	if (!lookup) {
-- 
2.56.1

