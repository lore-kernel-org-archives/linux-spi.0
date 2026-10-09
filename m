Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B24519A0
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553001; cv=none; b=TFxpIs0Vw44r1DYxV8z2Wv0EjxBmWOJdCw7L8Mt4LBI0Y+xu+J6URbmQXvpZAHYh7dQ7lNjiz7t4MRrTrMckJmnAAk4lUOw1xiNsCT/j3nm7sFf3Ej5chPzUEY4RbGGVSMLfgmKRwD58G038qDfi9IScIdi8WOOh0tPhxTUGgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553001; c=relaxed/simple;
	bh=sJuIhL4gV1KuB8hdYwpWXl2+91IwJSqat64ie0u/Gfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGtWexneSnwswbtMXJsxuriV2HmzUhZhDwfNX8BWTV1AT9MkctCoips856EfBGyIaTtsqtr0y7MX2520F2dn5x5+SV3ESHVZykU062wx4eh+/EsAHBCMCOqPNzV/EhfwWBqPn+Pzp3EwqrA2ETd1zAe/0YtDlRTk4bahINpAwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8246b13cbso11983465ad.2
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552999; x=1792157799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yReOBWtsExLC9kimiZKgObiHOUZQvX8Kxe/YILGNqpM=;
        b=MWhs2X4Gnq7O+uDwJZTp4W5jX75VunQkAoJMupPxcl2oiiVsgCrHeXXuG2SOIS3IGg
         dFhNLSR4dnPzig1adM8W6DGfDSQ5HAbG533kwOUvdLG98cP8wrWFFM3pXikVFOAr+9QX
         +lTgS7/5sbUE1OGbPqZ0DuIH7mfFcUAb8adFZmIzunJ27hM4WP4RYqC4lv3VvRlZS+ui
         qyoUN4fPIYLpWKzeUdQe3gvAe2LvIYeVRtaQb7mWnH+W/j39IzFeiiqQqlP2ZXa1Yb9f
         nIaSTi1pY1H3Ef8lyK4HKrEz6Rakzi0AvqACQgOlHCS1VIhkfmgdKEZnGll49KuA7X0u
         sBHA==
X-Forwarded-Encrypted: i=1; AKwUvBzWdASNvgNu34VFoI8Nkdp2IUFUekE0iO8BNFoM5UIJx+Me21n+MvqGzOtaZklZaAooSb6/OH/Xmqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/ULFShH2oraAP0Fu4SJa6PXDH2gdUoOwCHdbosnxrGD0Wkd3a
	chWddrCZ0bv+eb4Dh1GuxCqn+tJ2Nf3xkdbXx3qMAlq+5VYLxNUe6m+R
X-Gm-Gg: AYBFou1M8LHV8aIE09mrGVGV50J9SBRP0/AqeqM4RbSgAcrz0qX6dBIrH/+LNza47HQ
	Bom2JDmMEeynct3KOZcA8bV85qm6WipMnmulu+caS/h6QdqBButYKv16mbvyNRBEjUsdbRZjkfR
	xFTJNuJ8Ycz24KcUxgXlhUWNnLHiu5wC56K3OYrZOhyVhAboDJAE+XobXfk9ged9wGAGaLdzjVQ
	3Bt6ZcEG0Cylha0mnolJm/amMFWgKuv6o1Ma0R2DpEaU4jXTz3lk60v/BaIo0OxFonXOLJKyIam
	7Sq9gZNQhAntP7t2u4Vi9yr8/HOmigxVqUMYbO6c/RD8wRZAJTXLQ4mTGHq5BuIVjlXtog5ER+2
	M1Bc4fg8FHd51dXVcjNjk4zlijaPZdS5atN8Jjn28odUBTV2zjaOa4QLooEwTOq+fO8vTJJp92x
	Sw5QTiOEZg2v5edEow9notOgIm2mmoz3stKxRRSvvES36Ud1eoufmK7ZqfRxY=
X-Received: by 2002:a17:902:f683:b0:2dd:ad74:ac7f with SMTP id d9443c01a7336-2e842aafe0amr17988715ad.26.1791552998873;
        Fri, 09 Oct 2026 06:36:38 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a05f70sm9260455ad.7.2026.10.09.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:38 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 0/2] spi: use sysfs_emit() in bcm63xx-hsspi and bcmbca-hsspi
Date: Fri,  9 Oct 2026 19:06:29 +0530
Message-ID: <20261009133631.579644-1-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the sysfs show() functions to use sysfs_emit() instead of
sprintf().

Aayush Kumar (2):
  spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
  spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()

 drivers/spi/spi-bcm63xx-hsspi.c | 4 ++--
 drivers/spi/spi-bcmbca-hsspi.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.56.0

