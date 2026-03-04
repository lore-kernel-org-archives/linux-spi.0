Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08B388369
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610555; cv=none; b=Q/v4uO9FySZ6+WJhUvfVkPXcXhJFSr4A+QGcTNt5OuM8JIRnbiGOEV4gak2zmZ39atfjsCbY1VnM9NKs5cdmKGZCjfIJQDx19s+M3PPmtKTRt+2YFndC8f9MOGiS5XqoUvwiBQkX3sUpgMFicuODIbyyfp7QQnxZVDX5kO/iIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610555; c=relaxed/simple;
	bh=MSzaNuALHMLFQAjDLF5TT6OSC0jpCyqT7K/HEkrOBsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic1MBMq/jkwT14euBygRC7rrWPNdL0fQy5OfuKUdtXtQK5atXi//Jbapflb5fHtD0ozJmJCLhrnojTuWmiovf8qgvPH05x8Vm3YLY3vX9Q90/ThqtKDUEdKO87Y6D0NaKyffFKW8xjhUnc1+0XbLgsZ8rhL9rn7fyGPxIINYtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDwQheJF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDwQheJF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bcec8613so1895197f8f.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Mar 2026 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610550; x=1773215350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h7+v5F+lsgUU3PHsknJQhpHG6M7boIKCxK5QGbGk00=;
        b=HDwQheJF6/36wkOKUHaEFS81N3LrGhAjj9sazJCRLPf2E6W0Aa5f6aDUi752msYH0m
         v/TLti4hTZ6aOkGhi4r6OgtJNZf0edzfsfNJyl6iHmMgaa5SbCHpHdkz3tNwnAg/qB52
         TdN2WqhoPgfqW0QWndyGNa1wRhs5SSZgzDp2ucXqqNB3cON4ztEKQTfz7q/xjyoXq9UB
         emS1/j5jMb827HisCcfOju/7M7Crs+AIg3pWfkxITb4Lday5W9309jfELQYnJ4FEiS3D
         rKKPXthLyAcOXn8ghs58dCGvLSZH/8LztV7i4JfjAEmJgwKaJ6tc95Bzi2HxJwn2j2av
         pWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610550; x=1773215350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8h7+v5F+lsgUU3PHsknJQhpHG6M7boIKCxK5QGbGk00=;
        b=AFQiuEl0wVkYztHu2CB3l+q+AJUFnbVCDoXUpB/wScn6HjOvQIkcttFxPGIx51XCpX
         kj1iqQeWd60tKqzv3j1yD1oyeL5yPyW6y6s5Tc74SYJvKTZo2IIJnCPQznUiIy9qhMXe
         FtYwrXVwbmYrSut0uIiXT/0g047VilDyLTM3y7AtnoDpxYEV2/tvkQLUvAGIWjUUzbge
         /irg56DEF8htdM+yTaBW+2FDOoo+gGue0TOdg50hbJw/GUkUER1s4MjcnxciEPtG+YUs
         5yOSpHn9i37dVhETEMw0+XEXtfzzTpDSxeZl6s6BojrYtW4KUz+sRAP05ofA8hJH5Jvk
         Vk5w==
X-Forwarded-Encrypted: i=1; AJvYcCVY4gmXVceAI9mGei1m6+8dPtXAXh0t+OMu4gv2qTWotzx7fKFXTphrUEhqZtxMQ3VxahT3ngyLrYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kKvPXgwdPwYuafAo092lzlLnF366bzQ3f+02id5uQ/oSZAfo
	pnM2yVBzC7b5KZ7CmD9z539+iG8JoYa+BMJ6rqcs9UD5avmMt5dumyjz
X-Gm-Gg: ATEYQzwcERqrAZ+8Qltq8/QmHbgFtqu2DNLT8rVy7mqpt3pQnncfWNoQ7wPHi1qeddw
	Nxi7ABNlrfUgDCJ48P9vK+/n7zEpegjxxgD4yg2eD/O85ZH9HNHquHhpZ9hf/FJdAhzpLowjcWj
	/olRLwMsLM2q6rKPSyMkBJCHw3YTAK4mNpj3CBX4Xm7gRIy6rzn1Ks4BrDRPq2nhBNPXGbQ0mLm
	PjfuCVag2EmCTkwNt1vXkc4voSDs0FvtroQoF5lTjvY0/O4h/RC8HCNV9Zlada7nCs1ETiASwAa
	GcY7px7ZG1KhSsizmwgEeczOoSVRe0zLuU4iYnrHYM5AMdOMe5AKFdUy33sQC3LV5DtS/MVvxcq
	SBDs2IE1GZKTylJNFWh+yDQTHJH/3AqGxicMzOsjm0pjyvSoQowiD8oM76BpdOEyMOB9crbcQKv
	fBrLC1tFQY7sOAbKdUZOq4se1AIX3eqG0=
X-Received: by 2002:a5d:6851:0:b0:439:ca85:8848 with SMTP id ffacd0b85a97d-439ca858923mr501859f8f.16.1772610550030;
        Tue, 03 Mar 2026 23:49:10 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:de3f:f927:40ff:12a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm39957572f8f.21.2026.03.03.23.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:49:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
Date: Wed,  4 Mar 2026 07:49:02 +0000
Message-ID: <20260304074907.9697-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304074907.9697-1-biju.das.jz@bp.renesas.com>
References: <20260304074907.9697-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3L RSPI. The RZ/G3L variant requires only
2 clocks (pclk + tclk), unlike the RZ/V2H which needs 3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 23f0e92ae208..38ee09e389c9 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -811,6 +811,13 @@ static const struct rzv2h_rspi_info rzv2h_info = {
 	.num_clks = 3,
 };
 
+static const struct rzv2h_rspi_info rzg3l_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
+	.tclk_name = "tclk",
+	.fifo_size = 16,
+	.num_clks = 2,
+};
+
 static const struct rzv2h_rspi_info rzt2h_info = {
 	.find_tclk_rate = rzv2h_rspi_find_rate_variable,
 	.find_pclk_rate = rzv2h_rspi_find_rate_fixed,
@@ -820,6 +827,7 @@ static const struct rzv2h_rspi_info rzt2h_info = {
 };
 
 static const struct of_device_id rzv2h_rspi_match[] = {
+	{ .compatible = "renesas,r9a08g046-rspi", &rzg3l_info },
 	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ .compatible = "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
-- 
2.43.0

