Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE03B0582
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621317; cv=none; b=kAxRlvp894DwgotC2to5gT8g7pm55skr6mTgI9qUmD8b6FfYruEadjp88AEQYg0yXWfyAmnglYtNr3bWeTnYwQ2qeq9MbrdbOKx8M2ISUPXZOOdzvok29EOygPHtc2bW1oDuDaMFBfhiLhQ5gyCWL2Wilhz/tolrR2dySirupow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621317; c=relaxed/simple;
	bh=UXN9VOFvMq7+7VebCjYri7BEGJJ1i9z2lzXas/g8iW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuS11hSPRLTln+k7R1ynEUd+TIn4lxtpxoyRbxeh1DF9B12ORCZcYA/JmIqlnwbskmLT/rOXRYeGkjjtRCv9J3FVQklGMESf2mAgl2pkeGCm3TG7jsY3/bz6hhB4UkPbRkzh/8V/aybtzX43IavxwiiGpGbyOO9WIksxSdhynGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-351767ef18cso1464606eec.1
        for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621315; x=1792226115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SfwL6+ph0bSPFTbhiSeYF7NW6xzqMXdnkaVOG+wTVF4=;
        b=1IlfGeHTy7o427pZmqQcVUfkU0YOhWFq27N2Gqn8a3RhguTJYwcAm4iNmVDJDc/ebs
         jiWfb0nM8a7T/V2SW2XoxhKyf1YGZ3nUaR2bceIMvUcmshsyPehIhzACdyKPYaEfq6jE
         7pvZ8Rodoso/RnaUk4fdZooC5gJL3kEUQSMtERdOmUg8bOFROKG809oWFp31xhA+TqGC
         RgvP7EQGYfXf0rL4G09x1Z2QhKuWiTx6x+hOx9LIMsTQDfGdCpYg6fZM0046AYN+UZ+C
         8EfUsznxbtyqByNaMnTEESNpiSZnjDkl9aFfBR6Xi5KEdFpSF8qn6E5V/bQfWasQpLxx
         0rTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9Mb6QeWWyTiXCeHxAfMq0UfIEYrEKYnEfeh8qUsqy41guncdxCpYkN569RUOtdAa9onpndo3r1Jw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBOJr3RJ8GYjAXAjj/ULZht+Juy9sRhBgEe1KbQn/KYBlbmw1R
	ZaOqHCRhYuHVU+HYN3LYNZZY7zZOGmAy3CP9f+XB/6Pu4q0EDNSQ7j1/
X-Gm-Gg: AYBFou0y8k71n7MjdpuYuXFbYWO216SqMSlNUBes/msy2eFIYgM2XQlo+jtpjCmD4uT
	ehSbtH/vGBr+yEyh9ZEcats+SiyqNgyAkSEt33diSVdcfYlv+QJSX4j14kilyHmruisixi3mbU0
	sb0AV/76q7sSZYuFuHihgr1I+LNbfwotQ3oaYPUZ6TzQtiJxpoBwdYPN1CLY//FqZsZqv8m1eYn
	r4prYc7ay+p8w7rNb98tVQNSoQXPGpDzR41tyAg31r5mfUyCSgfyOKV6LTOIKnzboHZ17IPnroI
	N3bqNC0oid0GtSfU9E0P1otUdlCx1uyQGaR9QfVBAzhWRO8Gi6432kZbtYyO29boqmW5oxSERC9
	KImYeHIhQkN9ZwSmSoEIJ7fYoQnyMumWCJuTmsmRQfvZEAUVZHSPvOiuPUt9DlXV1ez1/JdZ8Ku
	EkKI4nztXz3Psa53GfoHmzDUZGQVSUcc3l3FFknFG0sX1xfNi4sCtOw6aaOJii6msaG+wVHTQ=
X-Received: by 2002:a05:7301:9f0e:b0:353:417e:aad3 with SMTP id 5a478bee46e88-3537e069fa1mr7792003eec.33.1791621314998;
        Sat, 10 Oct 2026 01:35:14 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm12689858eec.4.2026.10.10.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:35:14 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <aayushkmx@gmail.com>
Subject: [PATCH v2 1/3] spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
Date: Sat, 10 Oct 2026 14:05:02 +0530
Message-ID: <20261010083504.26261-2-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010083504.26261-1-code@aayushk.dev>
References: <20261010083504.26261-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aayush Kumar <aayushkmx@gmail.com>

Use the recommended kstrtoul() instead of the deprecated
simple_strtoul(). Check the return value and reject invalid values.

Signed-off-by: Aayush Kumar <aayushkmx@gmail.com>
---
 drivers/spi/spi-tle62x0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index dd8bfb3f3..986d78ab4 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -151,10 +151,10 @@ static ssize_t tle62x0_gpio_store(struct device *dev,
 	struct tle62x0_state *st = dev_get_drvdata(dev);
 	int gpio_num = to_gpio_num(attr);
 	unsigned long val;
-	char *endp;
+	int ret;
 
-	val = simple_strtoul(buf, &endp, 0);
-	if (buf == endp)
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
 		return -EINVAL;
 
 	dev_dbg(dev, "setting gpio %d to %ld\n", gpio_num, val);
-- 
2.56.0

