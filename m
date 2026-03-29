Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC4302163
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774782853; cv=none; b=irUr5+00Ut3wGnOI5cwv2UDwrq+mYXcrZB6EIo6xx8oYXPWULpQukSqPLgfWxa9A+Ugug3UGJotemWN9Xb0/5k1Y86KhVqnHK7taxa4nNIwO1SjdMFNpqxPc0VG4rnxcTLdxF9qxPmQn1OVitz0aIPKKgYQdx4oWRuXNVqIJcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774782853; c=relaxed/simple;
	bh=u+hbg2H3lOYYW1ebDQugMjdlCQVFZ+T5/ivVf6GLPhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mvgPgYFR2M2MMoBfhxCEL/kEkXOovgaylM9bkuJEw1PM8lEPbnusugdybokJzM14rIQyLaTpNj0HXbOULqkqIaIY64ypC24nIc49rF1txCbpEqJrJtTFcxBQfXiGvLg/3ZVwvZjovVsqIuCrM9YAoDqosgi0oP4j8EEORPB1Wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFB4ahsb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFB4ahsb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so1620411b3a.3
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774782851; x=1775387651; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjoQBkXiGI1oWD/lbihuPbS4PWSjwfos2KaFS/Ehss=;
        b=VFB4ahsbL4hP9rarNw17ILy0GK3Z61xPKH+2vGDAFBLI6V93xFuni46Euau4U/sNYx
         bkaIwqTPoxuhRy3ghgSjYqzJKgtRFUENyxdMDzTPKQ/l7Fv2YcluwfoLr5+EklPtjBcS
         9ktSxziGIJrv5F1csjPQweOcoiIGYP+ySKnY7lp6P4yz2GNeKhXAkoWzTIJye9bxDFCl
         Yg+58pH7ERfyvKuKOQwkjvP9TQ3ry+J6ss7zfB+WNilEkSqRItHYCduIlyiPM8j57nrW
         6vrxCwjT6Q6U9KDKJZ0eKdOBpGviUJkCSV8pgr76zDIaGP1HMVhNHhx0YPzDSjcuOZfr
         b9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774782851; x=1775387651;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVjoQBkXiGI1oWD/lbihuPbS4PWSjwfos2KaFS/Ehss=;
        b=TaMrvBSJAqoKqHfnQSiOPxDDkK/czfOx9QOx0cza3oFi8ltJOXhT4cRwYyHpXZlxP9
         UVVvz0SksSHmDVifEFkQQSeyM206jlOFpEuqYqYC57jJmDHWhljEjbv5UGVpB1dUcJHf
         gpA5meDZjHLto7MqrtJaOPkYhuLRVC8AJ7rKdQIO3WrdxSHts4oGrVmMMFh0lrPrq/5q
         0JqSBiv4a7Gpz8NTfrEWX7TTAxD2XhRMULnrLbC5ux+B038kuETlsY2iFAB3c/pysHQa
         BVgNWBsSfjk2VSg/eRQH53nZsSWKWnS6iFp9KnmonYyqKQtK5g40IBBPgcMhhF5Y1jdX
         Ak5g==
X-Gm-Message-State: AOJu0YyWBNwwKyb9S7HScmRfJxuFKXvymTuAUqYXAV+GS4vaszozajY1
	u4hDzYtuKrxqruYfVG7lkJeUAFHTagh9TUg2hphAw7CE6J8WenUeRBwz
X-Gm-Gg: ATEYQzx4TIxAcLAofD4gkH8FhdYnGcHkZ4JxAZUd4qbk0hRx5sLUuD0aIezULtYywW8
	b6c1ZjqnLkWiNpGmDiF57j2iq3OJOFUnmfeXm97Bj3dcNY7BoI3m6xBwdjes7aPkL0o0fUQUE97
	vZGRXM6zlsI+t7eiiKBmcHsEC5lEaMM1GNLpCHyHIcvionbs2EaEHRUW+LxkNVKPRiOgZW/hN5g
	NTatpSAnarDMYteevwvTXOBqbGfCEqYwpSR4nRbZEQOTNx6GkbHQ4e5gQtz7rlu0uwOMNGDwr5Q
	YVo5IKtefPZhZLMwkCUf6AfcIesROce+XjG5Fm6nltcbPGKbnQaw2tLoIdVrNwfx7ZKQIapCs2O
	FjXxBxubTOmdoXFcZMU+eQj7Vtrcg702SF1ygOySG5LRMfzfbdjk3cGcEyLsawng6F8yaEEh5Us
	KUL3SVha2TYNw3z1tXmLm3PkQFPBh2ikok/Ztq
X-Received: by 2002:a05:6a00:2395:b0:823:ad3:4ff4 with SMTP id d2e1a72fcca58-82c9605da6amr8434908b3a.37.1774782850914;
        Sun, 29 Mar 2026 04:14:10 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm4266744b3a.48.2026.03.29.04.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 04:14:10 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 29 Mar 2026 19:14:05 +0800
Subject: [PATCH] spi: stm32-ospi: Fix resource leak in remove() callback
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-ospi-v1-1-cc8cf1c82c4a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH0JyWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNL3fzigkxds8REUwMzgzQDS4NUJaDSgqLUtMwKsDHRsbW1AK/8AIF
 WAAAA
X-Change-ID: 20260329-ospi-6aa5060f090e
To: Mark Brown <broonie@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774782848; l=1157;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=u+hbg2H3lOYYW1ebDQugMjdlCQVFZ+T5/ivVf6GLPhs=;
 b=Wc+RgivG/glkyD6BlqKjX69NgtVzBwdBy7l8yiL6UpV2oi7bjj4Pt1hW9blTiLqjXXkYTkr2Q
 oNytratwqJCBjE2tZt6rpcUGtyqOf5tFXsRvhdA1IK+XuVfSZ9CeaiD
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The remove() callback returned early if pm_runtime_resume_and_get()
failed, skipping the cleanup of spi controller and other resources.

Remove the early return so cleanup completes regardless of PM resume
result.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-stm32-ospi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index acf2d182e8b1..192a20de1ae6 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -984,11 +984,8 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 static void stm32_ospi_remove(struct platform_device *pdev)
 {
 	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pm_runtime_resume_and_get(ospi->dev);
-	if (ret < 0)
-		return;
+	pm_runtime_resume_and_get(ospi->dev);
 
 	spi_unregister_controller(ospi->ctrl);
 	/* Disable ospi */

---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260329-ospi-6aa5060f090e

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

