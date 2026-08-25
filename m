Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED17081E
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677726; cv=none; b=RLcQf8pd9sQRweYpaLoTN+aFVo1NX5kRuk4kjgDGaiC3R2n3bXlLNO7aONRqIYdKMUOe/Wi7fKwV1EGu1UYvf8jEQz8VV5gb7vxJBJ/wYJylUH3knewi0AXw3UUn07SVnBI2FjE//D72pXP4ydAg+DD7e0xQwBfJRT5j2kV6r38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677726; c=relaxed/simple;
	bh=Xvaq8VLclZFsF7ONpOkzrQreRGL3wzOnpj01sXNQJr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YiDVTbs8JifZ3PexS3+UdSGklkY525fkdrJ/CJJUTx832faoEO57vY6MNJQ4tqwqQMv/3AHkTrEwk0tLZsQW+T34lR70tFj5bYxuPKRTwd/wGLlnBUEeS/ZC9TmiVzm4K46UHxNt9dNBWgfwO18jLadE14HdhYqUdw4z6jSbsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSOtAWoL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSOtAWoL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso1350375ad.0
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 10:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787677724; x=1788282524; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C3u4gdJ6kfWoZyC9nziT14jM6ipfa7mB5oczy1v2tX4=;
        b=dSOtAWoLvUdG9ChJhOawsbIiB+EhlFNy+q3c01tMQNN7WxpC6/TvtjXTuV9WWewv1q
         jgqfsFt81HONjc1/PkCRjjBb6wpOEitPA0yp00OjfMKpYw3tWJgY5EgFydu4psp2tJBQ
         NdN2URn2kMFQtSRPm/PxoMmXMwZo8WINfoDInMJLFvbKv79sO3x5QNR+Qnhz8u5zWAHs
         SCsGmvXFkB+rvW6QYHUA0Z4kCE5qjFRGz1QUfnW0yzXpyWqZhLIdDI7QfTiBQq+SVbtS
         GF8asRefijRN3a5KZ9rqMMwvvpI+m/gQC8e0euvhF9ahbclGyoRbUtCdcUu7/LgMhvBb
         XL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787677724; x=1788282524;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C3u4gdJ6kfWoZyC9nziT14jM6ipfa7mB5oczy1v2tX4=;
        b=eFYtbwurDb848bvhvWsKH+WIKYkoeWvS5z3sm7tMNOuyOXYd/8Umtil3xAcrJTC9FT
         oQOro0hk6Ijc83fdxYR+HGxiAWbXk5JWDVn9BjnJHRujiYDVZr0/XMcDHEx0A6B/3o/1
         WqHCKQqhgYEEQjyX95j7whwJdMsIwHwcmkoqXzM5ZvhXQ9K0gkIwYQxK9/ZfzA0azclE
         W+uKyUI1I6jQVv2rxUgH4zP88EMqmDZ/WaJNiXy9GbIRyBKhv8VwyQXjkOmckGh2+lPK
         IuOMs4lVdyxOKjg61TThP/pxny4I06Yd73CXAFVR5mnubwxxMONH+qXWc1GgIlr5dVl+
         dTpw==
X-Gm-Message-State: AFuF++nJm57Q+7q5JfjLBJ9qI+G13Il3C+8c4RCU/N/vo6OxGZPqOTbH
	Ve1rpgaraa77y/MJ6B3Asq1RhWk7nbCEOQVEGrn0d5CkiuZ6D6R+YXC9Gn8zAZ/w
X-Gm-Gg: AR+sD10UZjruVOup55WGlVoYjR+puA5V042iFT8HncXhNG6W2oz+grLuu+V/tDaWDUF
	sgmM5N0sMieodQtbENIQdY1ymPDyRE9RxrwIrLCwFmLJrIbIzQscdmPWQyMvzJe3Ee78wSw1WQ6
	IY+nu2IBwwMCuebSrwiKZGkGSbNnRTU1wW9Mt6e/OTM8/SccdPmMGzNkVfHvWa6ixKPyQx+TnSE
	6JC6uOeqopVva+PSHgVSFDuC9keG3GPH/ZUt2y7Sdicp/B8xPDDoW6qi9l8McKW+p3EnU+sQh2U
	ERJjPGXh5ZV9PRmZzqNW4Mdfz09kQ9hqVGB/6HT0UJEb/aZDnKmOm3vniLpkSrF1ARc9azAot7N
	pII7mFaL5BkuoUulq9tCVsF73A4SkuE5c7Xenqqtmdyt53JvnSIvEfEw6I294/kyPGESkC/gyU8
	h1CC88PSdH9qtEEoP9mKAfCBfm4JwSelliP/ZKVIGygEKav5ve/ei3CpVUoD/vdiKHgeuERfkrM
	DEeperxE2puc9RG79ZP6rnIvIfjxIVB9urtowFtf2Gqen4iqaiJwZ/9dk2xvw==
X-Received: by 2002:a17:903:b0c:b0:2d3:160b:c01f with SMTP id d9443c01a7336-2d6dcaae0dcmr171175295ad.6.1787677724282;
        Tue, 25 Aug 2026 10:08:44 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d70497711csm914055ad.19.2026.08.25.10.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:08:43 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 26 Aug 2026 01:08:40 +0800
Subject: [PATCH] spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync()
 calls
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-mcspi-v1-1-0a8dd7f6dd56@gmail.com>
X-B4-Tracking: v=1; b=H4sIABfMjWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNT3dzk4oJMXXNzM0NLsxRj45RkCyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQC878e8aQAAAA==
X-Change-ID: 20260825-mcspi-776196d33dc8
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787677722; l=1256;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Xvaq8VLclZFsF7ONpOkzrQreRGL3wzOnpj01sXNQJr0=;
 b=SnK8BNw/J7ufpju6TwYuMtiVhoAD+iB/EVixlRlE98po5/qpekrx/uMSxSbmpc4xehK2GxqW3
 fKnJyqJJ7YABlyHzCChaXB8vcoKTbsJdosSgvYOZzDRoxXEbSxWN4yQ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

pm_runtime_put_sync() is called in the probe error path and in remove
when nothing holds a runtime PM reference anymore, so it underflows
the usage count.

Fixes: 0e6f357a5deb ("spi: omap2-mcspi: Fix PM regression with deferred probe for pm_runtime_reinit")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a3355147f5de..82c8b91e504e 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1595,7 +1595,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 err_disable_rpm:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 err_release_dma:
 	omap2_mcspi_release_dma(ctlr);
@@ -1613,7 +1612,6 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	omap2_mcspi_release_dma(ctlr);
 
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
-	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
 }
 

---
base-commit: 4b18edbd8e70f7e6860d56370f13244896d0f95c
change-id: 20260825-mcspi-776196d33dc8

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

