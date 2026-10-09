Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1574E1412
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552983; cv=none; b=DmeHNyh90QYu2Vv7U+tyZXcZQ86JLudY5ylp20mO4UzbWfz23XkV6K6BAzFnlj70jLvj7NwuCNRwEMPvi2OA0pr1FB8GpZDBhYIf9hkijCy551Sa5ZSZDlHODJIdnpceWyM04fUXw1A93iNoHaAeoZMYSkNqSmd0t1X6uduZkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552983; c=relaxed/simple;
	bh=zZet8n0Q5OOAua1rvVURqPRD0By3UNSCDjmnS7Uw6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhpjjWM9aKUFCuy/PNnfoP1j9jr9qtDyb2zYuOZwi0koT8+Z4EMf0ve7WFegn49nn2YBQGdvE7Y7aBq+j/5uaLWtSfhGeo3SdxjCdGV3m5UXMELBj+9kck8NmOfxQ30JHbFe8K70baSukebXa+qVBW9dEvLnDzp9krHwO/0uVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8246b13cbso11977705ad.2
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552981; x=1792157781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HxXmIcoBEJr40/B0k7/txPx8ho1bntDPfNLOQrF4rzg=;
        b=czVnynpR2ZMFwS7ffQCqqvtn/I5HRse6CtUXVcnW5QqXclGiari9g+fkmHnOaTE8hZ
         NOxU4sgTprUjvhVnfV6noBRrPNKxqpPibgeS2dGreksWaEWb1bsOS8poyG//SW8AMQXc
         BGhDdK+/zYA00kBIlgRsqBsB+VUVjmAQGBuZQTI/8GaaxM2N1P4S+PoAEumV9x4tPwFN
         rrVb0e7JkdbLb76awcERl+FxjXJY9BwNIzfgu7dfUyzWp0MANqz0T9yh7/4rwE08mqtV
         oqLavcYdCqXb8Psc3Byywt0ge5WlkxqJycmi8bFmJb0zDGUGnsliaMA3tlECwZkH0JOr
         rVtA==
X-Gm-Message-State: AFq9FYLbQ2kl4m+Zsgx/KEl+RbqkwuUKSa8mb1XMTC3WyDG0OXvXpjiI
	PyCOQQRFNnt06GxkItr7O30pGUvQs0nDn0vUBb3kPZ35FM7cskpLWC84
X-Gm-Gg: AYBFou1uj7QhnO51JvbSmJCFHrc12gfNhfExCZerWcpyeHfY2lgghpH0Cu/VmREckz7
	JDGGS06btZWyrlIHxOC0djCJN4YnJ3HlZOVYsADp0QV3FZ2UBgPtab4Xo+vFhI0xukRtnj1dlRL
	eHL7LYXeCo1Qc/VRnzlz6A/rCaxa8wxwQ6OqIVsoQO3qiZlz6bU5gJFJHs8ANOyKwM0n92L0k94
	sZIKBX9XjgVMh+NFfeV3wxwhCnDvboe37qi9GkK1hov2QkJG+hcEjHYXXVldFRjdSQBs5220xnD
	YrtdRsWbQCzJZSzfU2mm39Zbu3KnGi/4ZarEBI2wmIfjNKLT4WOvay1Tf4ZS6MgOgXs8mbU3LZ/
	hVhls9t4w4V+AogvxQl/Olxl9peQcqdb/CA9wmJ88SA5PdYwIZ8k85QWhZrbYMqiAzwKF6ah1lq
	bdIh7TBjHTBk5PC5tKzrZq/tEkVez0+8/YiJPITwbyFvcbLw1exCZatZTuiat3mcXbR8Bs4w==
X-Received: by 2002:a17:902:ecd1:b0:2dd:7646:35cd with SMTP id d9443c01a7336-2e84271c054mr18115105ad.0.1791552980705;
        Fri, 09 Oct 2026 06:36:20 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm7656985ad.15.2026.10.09.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:20 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 2/5] spi: lm70llp: Use strscpy() instead of strcpy()
Date: Fri,  9 Oct 2026 19:06:06 +0530
Message-ID: <20261009133609.579046-3-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009133609.579046-1-code@aayushk.dev>
References: <20261009133609.579046-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a safer function strscpy() instead of strcpy() for copying to
arrays. Only idiomatic code replacement, and no functional changes.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-lm70llp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index e61e89b41..bd8028892 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -252,7 +252,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * We are binding to the generic drivers/hwmon/lm70.c device
 	 * driver.
 	 */
-	strcpy(pp->info.modalias, "lm70");
+	strscpy(pp->info.modalias, "lm70", sizeof(pp->info.modalias));
 	pp->info.max_speed_hz = 6 * 1000 * 1000;
 	pp->info.chip_select = 0;
 	pp->info.mode = SPI_3WIRE | SPI_MODE_0;
-- 
2.56.0

