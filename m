Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856D3D75A6
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606540; cv=none; b=OeOIvqKh1f9S4sA+1QU6Ui1+EmFIoDNyvLtRJLfXnpzfV1WTNDp4pYNcNtQlCOl9klYoLtDI5eZbURcF1d8M4GGSQXM9VsChh/gHMtgCBOueNdCYJ/fESdNwkO0a1/MT1n/3984dePRBiJehtn0yRdneLUDkI+bxNqE4U20OyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606540; c=relaxed/simple;
	bh=ea7cuzjVH8l4WaNc0d4fbb0kmTQLbO6kPFR9OFprAfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CldXuGwDzLkTRmI7rpPx1eg6qKMdbjnMzgnG60CxqZmp32Vfnh8iVYHlMUhlKiqbA2J2fL62wSdxmL12vNSGhMmn+5ZRDR0zTyX9oNl4T11GeSI0YXujtuM4e4k6KdHyEtlZiXPSkb3K6vdAjLGQLxUqmIye6PeG1MAuJWlPeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lVLAylAy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lVLAylAy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso8850535e9.3
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780606535; x=1781211335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NJl+VOtJmF26AH7Q6wbNKM2etWMSqxxrEhElEZ90kc=;
        b=lVLAylAyaUuctwWwXM7IxqzBTSZ9VAsUppIvBLn5lK+m1KKmirK1ZXhHjk3esUF8zv
         JQ7YxFbiMuJuY5c9n+0H4G0+H4FWONRJh4h66ePYi+kpxzDj0LgqrDIekF9dPieZDjDe
         dKLLVs+1X6kRgoFanWNJpT9y2BHtIxF8DC+zjE+ezbnROGhg1g94pRdhI61YzozJMaVP
         sVRNQpoJpd8BbdEdbkrAkFjESeGdyH5yfAbDPlVTe9H6RlAIRNZLIPl5947iVgdeD2Er
         eK586pkpWIjJP5zKVH5+lO3VPFzTTswg0PD2blRoz7jDMP1Pxgpf1PeesrPQBrOD3heB
         IGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780606535; x=1781211335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NJl+VOtJmF26AH7Q6wbNKM2etWMSqxxrEhElEZ90kc=;
        b=D/oC0GzGXLFGDHVUYdH4+3gCvpi5ISB6Qg5YU9Z0E+7ukEgdtOsSmKv8gu/Qn+o7ZB
         vK0AJaPzATFapCKFXeTsE2Ghwc7kzhEcwg54ZhrG/OlFJdg7+LI7YMlBkRvLGLuHXXpD
         s4lKyK4VTtSDoPyy+oDUuE0F/v8XBH0g/co54N+QJnYIRhJxJSgx7kX9xHTbTcm0d9XD
         T+xA1BedLpJhYABZ317K+MZKomcA8kl+PyPoBIzLxFA3e/V5KNJploW/P2YWqdbvOiiH
         N8xD5XjnLHVol3MTa5s2Moh6xRJC9seFnDeuhYQ3pKuP8yECbWXHrd37ZJFHPp1ls02D
         EGSA==
X-Forwarded-Encrypted: i=1; AFNElJ8n9sCctfJXBoT0uDdVyvYQCXbGX0XMfmW0IUb1LINS99LVAla6pXIwNnXjbJTtZ3Z2oyDs5OfXfCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AGZJlCYuGBlHnVyWn3k/ghPvxLvAq5yZmahTHd+wX78PEO4R
	yKRCHrHjpmTXbpsWIUvWIMYlAtaz7LKGQZalFWKeZh8kbbMSwGuADpQYyyOYg7F5inc=
X-Gm-Gg: Acq92OGG/QeJpzYVKhG1wPhtVitCnn88ZBd2KsyW8sKsB5b9KVdf1sTCdkYTzu+CHhP
	GvjyJDDy0rkEEzl1QDQzlTj0kHUpBbqAwdlbwtReagXdJMoS4GzC/mb1F+GRls0ojS4wN2ciOLF
	Oz7iSD0OxmXWzMvVelc+CJYPkaxeKLMlxXg/7N1aPlOUSCmP0Dum+q8eHc1vz3JngPfTdFEb4hY
	hbPd8j8nN9oVQTIPDrbYH5leMWHLYYnc1LqxOrbucCGRKGvOz0gkTrKXn4pnin98HFbn7KYRz41
	JudlcZJQ43IMcAiLJ8sDiQ1hERWvWspEO5Er5XeoTd2A76fxWw4L5XJRSl6MImJTiRAPRQjO9/8
	1xV1dCVd6MiXg92pvdHshheEWkQcAI7UppJ+maNp9aLuO/UjfyGaL2lyN0cJPrsqs3xid8/3jO1
	62NmybItFWAJ5iYdo+q9PEm8+cV6Mzit/hlhqvraOmXf9uNtQJ82QRelbvhTABgd9Y5MHOoN2iL
	my1thPDWGg=
X-Received: by 2002:a05:600c:8b83:b0:490:b106:4fe8 with SMTP id 5b1f17b1804b1-490c25e268dmr4427955e9.33.1780606534635;
        Thu, 04 Jun 2026 13:55:34 -0700 (PDT)
Received: from localhost (cust-east-par-46-193-69-147.cust.wifirst.net. [46.193.69.147])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f345209sm19050059f8f.17.2026.06.04.13.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:55:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] spi: Use named initializers for platform_device_id arrays
Date: Thu,  4 Jun 2026 22:55:26 +0200
Message-ID:  <3fcd432a505bb1bb7f8ef0fba9162243200b3347.1780606153.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ea7cuzjVH8l4WaNc0d4fbb0kmTQLbO6kPFR9OFprAfk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqIeY+OnML+6BoYUWkNCcBW4CCesKWtAUwtH7M1 CmI8V/tdnuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaiHmPgAKCRCPgPtYfRL+ ToUeB/9Ds3iuojuAku3iJ0znnvPHYZeMZmNwhkINjPq7CaINJ7JSSTyEpswyNm8rlz0f3IVltgG X9FN32hGno1eod3IWEdXziUvimgNDfm+qys7MJ19RMbC6O9cM0qWH6C9itsGBh65JGITdDOy1BT rq/uQnuBCGD3Jtmj40WqMfGiAyWwFXPTlg6bKMl6D50jYoQRL6GtCnS7jwJiF3jazUVHOmWkbKR aOUfXFLmbLIUxNMXk7A1eK9qDN7j6YP1DwbM8tPr7aDcibwnH4SQtyO/44gnPf9NNktZivcxQMu RDWOo7FyPzJwfsbv35FnUs3qqloZfoa2bHv7I7dqpjHrMANr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct platform_device_id replacing .driver_data by an anonymous union.

While touching these arrays unify spacing and usage of commas.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

see e.g.
https://lore.kernel.org/all/cover.1779893336.git.u.kleine-koenig@baylibre.com/
for details about my quest to modify platform_device_id.

Best regards
Uwe

 drivers/spi/spi-altera-platform.c | 4 ++--
 drivers/spi/spi-bcm63xx.c         | 3 +--
 drivers/spi/spi-cs42l43.c         | 4 ++--
 drivers/spi/spi-rspi.c            | 4 ++--
 drivers/spi/spi-s3c64xx.c         | 6 +++---
 drivers/spi/spi-sh-msiof.c        | 4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 3ee5d3480bb4..3de7df73f216 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -139,8 +139,8 @@ MODULE_DEVICE_TABLE(of, altera_spi_match);
 #endif /* CONFIG_OF */
 
 static const struct platform_device_id altera_spi_ids[] = {
-	{ DRV_NAME,		ALTERA_SPI_TYPE_UNKNOWN },
-	{ "subdev_spi_altera",	ALTERA_SPI_TYPE_SUBDEV },
+	{ .name = DRV_NAME,		.driver_data = ALTERA_SPI_TYPE_UNKNOWN },
+	{ .name = "subdev_spi_altera",	.driver_data = ALTERA_SPI_TYPE_SUBDEV },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, altera_spi_ids);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index f8cfe535b2a3..43d7b54e3ae8 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -477,8 +477,7 @@ static const struct platform_device_id bcm63xx_spi_dev_match[] = {
 		.name = "bcm6358-spi",
 		.driver_data = (unsigned long)bcm6358_spi_reg_offsets,
 	},
-	{
-	},
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, bcm63xx_spi_dev_match);
 
diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 68f208ef1e01..6961e36b89d1 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -438,8 +438,8 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id cs42l43_spi_id_table[] = {
-	{ "cs42l43-spi", },
-	{}
+	{ .name = "cs42l43-spi" },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, cs42l43_spi_id_table);
 
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a0c77e02bc90..38df676774ee 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1377,8 +1377,8 @@ static int rspi_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id spi_driver_ids[] = {
-	{ "rspi",	(kernel_ulong_t)&rspi_ops },
-	{},
+	{ .name = "rspi", .driver_data = (kernel_ulong_t)&rspi_ops },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 37176e557099..28c56b06fa99 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1613,10 +1613,10 @@ static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
 
 static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{
-		.name		= "s3c6410-spi",
-		.driver_data	= (kernel_ulong_t)&s3c6410_spi_port_config,
+		.name = "s3c6410-spi",
+		.driver_data = (kernel_ulong_t)&s3c6410_spi_port_config,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, s3c64xx_spi_driver_ids);
 
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 070e16bc764f..f23db85a1889 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1310,8 +1310,8 @@ static void sh_msiof_spi_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id spi_driver_ids[] = {
-	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
-	{},
+	{ .name = "spi_sh_msiof", .driver_data = (kernel_ulong_t)&sh_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 

base-commit: a225caacc36546a09586e3ece36c0313146e7da9
-- 
2.47.3

