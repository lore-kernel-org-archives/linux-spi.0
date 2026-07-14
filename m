Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA24D8DB0
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047443; cv=none; b=QtoTXS6w1gSD9ifs6ioWwOGbAX5kC1bMHWabJ9lgiwD8rUZOLkqvVweO9zN7CVdzJ+DGPwcFcs6HvMLdFYBF81yCTGyUZUTB1raFI0muQ2cVaDzv47HEHfG3pTcEk1w2FRzEkYo3s45OQbu2wxFzyQXi15NzZ4lIyiuhL6JBwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047443; c=relaxed/simple;
	bh=qW96X5+3pvTy2yUg8+tq8uiP36vU8UXZPD0RUS9kypg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCLI7Se8IwaffjJb0xs4h+nvkR0BuKfykWKOayHZ/nEO2OhQL+lGXDPMVVo5wMtE3z1r+u3LzivULWaZlDIqzMvsTaheKge/St4X8j2C4taXyV9CVoHyq/URXyFdpUjUzHBUUXde0V+ZIVeqplzzUqkpNvj54wU+Q3M2oz38I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO1KOJ70; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO1KOJ70"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c733f15aso41173935e9.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784047440; x=1784652240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WS/LG8NLHrxUYbXTyAgZN6AxbMxAGqMIBf9Cy5n0BGk=;
        b=EO1KOJ70agqjN3JkTxr1ou8fiYBH7SxiyORz6m1HwUKmjAkVNiMYvHfSeyLK/4425D
         DJsMgvNhNArIzA52jhG/fTT+GPx2Vu5U0zmPkC67QN4N3PCqlfqHlNWd3/vUoHqWNUed
         nqsedIniRWJW8UckO+U8xzUuXZ+NQxcXyrBABJZvIoQlboZWeESo4P9JhHNGIEqP5ggg
         6a5DvngHLiGewPI3iDZgyzGtnoa+sr7Q9iZDwVw3xoVQhoF5p3MaZKI7LRvyTU4Wt+27
         oj/zdDgopamtwt0o+KQSazmY+KDYWNB0fqsR5l7s1OHdEPkJ/xgMsxkmTQclXj/MU+Gl
         nIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047440; x=1784652240;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WS/LG8NLHrxUYbXTyAgZN6AxbMxAGqMIBf9Cy5n0BGk=;
        b=KU3i7XgqP0n7J0wcMCT47YH+drfpUxS4IP1d3WO3ExomAm8Z9MEGOFMqY72Kw0bC7+
         pzpcpmyWg9Pwfs59vt3MPgtygcoZZZTI0W9ksBTmNgGtz8Y5kg5yTtAv+apymw7VTm+8
         kQmKaic93Uva+0McQTDcMv+StwcSqjplhr6toLFvrHBPwmb+3AFhV8HTdP4B63w2ZrAS
         Cm7yT9MJTBubZo46ayIfxxNpNXfAxIyepLrAGHUnMpmE97StbjJCJjTg6StHzWqSOHjE
         fnnzqK79QD7JcstmQKFut4kq40LWVSBtN1m57+r7uGKDL7n2DeXeaMBu5E8eusS+eiTU
         06Nw==
X-Forwarded-Encrypted: i=1; AHgh+RoiNDKqAHsE9MucAuVzNo2Ih/Q04AQiepGn+5IN4JqHvb0P8NTjTJRrcM341mmELbEt7sfycGGc0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuULsP4SVbU8uC0XOzfRASx0VQqaJnEj/59283oZWT6TV/O667
	9a+PxDzCs1UZJxWfuOTD+3NfXgY7vbmzaXqnB7ZYO25kk0eYQgQqhrbE
X-Gm-Gg: AfdE7ckyUjo6Gf58bRMbCeU/edkRIZ+alE8Ondk4kOqqBiUJ9ZiGoYYiVwlh8yHg4k1
	KsS06wI0GZsu48Xl3Vm/R2ohAaP0svOVXycyCiCRsNUt7iTZm3ZiuZzq/Gi2IlmpehS9SqqsmFa
	AtdMDjxxvz3V2MSOtGfND83HTdl2NPdy+p6HHa2U1Ka0QxchitihOTEYjplxOpv1/mlxOo4jL0B
	F7v3mArkKKoscvYCco5UHdeudGXmm1tzn+t7C07GDouwYl8bQz+JgBtB9VGHOvwdVwOtceqr1hg
	F3aDYbDpkYAsCrbztOTXor/zwN/G93JQbRTzEyaP8jQ24GR6OD68K7b4MFzlskpZmxnVRl598LV
	eLuZMkvDlf2qCLjY2y+OuWGHHl7WhzVM3sKnZ583atxwxrau8/2kbCN9P1WsFpeFo/whwlJNeM7
	d72rvaQh6p6QU+iJXbdne/0A==
X-Received: by 2002:a05:600c:4754:b0:494:ca0e:880a with SMTP id 5b1f17b1804b1-495389d2ba4mr34447785e9.12.1784047440059;
        Tue, 14 Jul 2026 09:44:00 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm92705685e9.14.2026.07.14.09.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:43:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-spi@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: bcm2835: make read-only const array pinctrl_compats static
Date: Tue, 14 Jul 2026 17:42:15 +0100
Message-ID: <20260714164215.183809-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only const array pinctrl_compats on the stack
at run time, instead make it static const char * const

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index ff94482fefcc..3d5255d75ff2 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1226,7 +1226,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
-	const char *pinctrl_compats[] = {
+	static const char * const pinctrl_compats[] = {
 		"brcm,bcm2835-gpio",
 		"brcm,bcm2711-gpio",
 		"brcm,bcm7211-gpio",
-- 
2.53.0

