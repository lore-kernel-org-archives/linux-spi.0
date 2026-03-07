Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1B299959
	for <linux-spi@vger.kernel.org>; Sat,  7 Mar 2026 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772869643; cv=none; b=N9xkHTDN3ys4Izr0DA8DBy34tzk2DKWDf2JhgNVM75lp0oPqtUGMmGhm10uCPoJAd0XoJdoS7BfzAzYKHnoqhD9Ral4+toXXirLIoRZb+6rFi4JXbWQ0WTFTbvQLy9sPZjtNhHtElHalChkrrJcB0IKWn2RKo0Ruuml3SyUACgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772869643; c=relaxed/simple;
	bh=75e1lv9Zspk1Yn0ZaGCEQTR5dnPaiJ708BBDY7KFgho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lnapoq0eUr/cD2EmCEFW1jL1cg22OG+K5EaHE9UY72XtlsYrROdgN1rQyeekahtCALMY3FMYR7349Dv3VJQV0CL+7DXH7PM1yW+s5ymXAotVFuNBns8YQL1IxRVfMCddheGMyZzq1k9Manzq6bHJswCwqdq9FiWaj6+Q8CWmnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HygSlVJS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HygSlVJS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a568f3ccso641861b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Mar 2026 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772869642; x=1773474442; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmJQIvtiaxODiCsUsq3Jno3CVTZP2FwDaPbHG1QOL54=;
        b=HygSlVJSENfv4tgDgb+PBvNdGonPZJ2PIhtl2mgOu8wTLFHwmR0MhCCiKD/LOtVvFQ
         O57YX+iY+OKGpfyuhuaAQGoVLgiY0u/Meaqx0K51wntuhgC1vyfHSuPR+/WZn8fe3f0T
         dMXtlYtbTMMvMwjkSzzRJJfxtUG2z0erIOSDkyA/fwBI72RLm6wH6OsVj1nSbGK9qOdh
         mvCkp5l9SzstjERTaehYwarp4aS3JyhSE7QK9gWXjnC5NqU6SlmaoQ34jY5Wscnu6f/s
         7aJPk8dj7SkeIq9vtVCt2kJnqNuzTc78PoL9G8Tic2PBL6v12MgEctaX0mIBSW6BcqW/
         VYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772869642; x=1773474442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmJQIvtiaxODiCsUsq3Jno3CVTZP2FwDaPbHG1QOL54=;
        b=h5JxW8jhTEZgv1bwzRldOyWcEyr/FMgXKBcsB42WTS3vY5tHNh+cQ2PRLwCFQk1ciT
         v7U475h1v4WFCcQ178vPH4E4IJqank9s9NeZW9VPHef+/tZUNpp2qximyo8MnQWYsRgq
         4LHRW/8g1AU2fcaXaqzPR4Ff34iB8dig0WfHXoTAapV1uEaRSs7fTEDlUxgxVQby16yG
         XOq2mT9uPGM2a1r+sOy8mHfGj872K+CwSDJpAyfmpbD9VpkfkvXRN/AaWDj0fnUrgq9o
         EvMoRy89zN5uUekQ9ggyXjuxBbZ50K8CaxHztj2905hF+6QqXNB8WLu4cMrPZ2qh0BCB
         CtHA==
X-Gm-Message-State: AOJu0YydDb7mOU8jCrF9GXSjX7Fb+4phk/hROZTVJ0L9FKkntguey077
	nJ0rHbe0YSNe8SbKfzITfZUWWrm+lGHXH5nL56hS+ohLZMCaWqe0r/sh
X-Gm-Gg: ATEYQzxU8n9YtON+QY9fyQ0bYITHZxOQGon6QcogcR1M+e/00GZyPjCbFqZQZzNKu3r
	Ak+Bw3RHSW5g3oR5mXK0QkY0VLffhXbcK4iqNcQREKzbsNhb27CmEHKRNRM4DCd5XM68XrAbUjI
	wQzp6nH2cqwl+ks0YubV1Tw3Zvg3IrgieANQckaZB8CzoIQ+Yg0VWnwR3OjBYrafD+nad+BuAQJ
	Sg0vfYzmCU9e4h7cT/CxMJfguXJzvFmzfHi5McVczV2ueglLLiOt2QagIEUjQULhuroyMY23maS
	v5sQmETIFC0fezvr64a7rXFtnrPgWlOw6Ch08g9VZymzQDZyTGblfDoYzWlveKFLN0/t+LdA/86
	pgLzwwDzTPwFtJWom9MyrteltZzQiL65v+i01tAA3pje/zNeHK532vV6uvXHSVsdam9vvfbq1vo
	5oBvA5LvSQEl4J2k1jj2T8WpdvT/SlYKjw1ao=
X-Received: by 2002:a05:6a00:2d19:b0:827:4372:dd1f with SMTP id d2e1a72fcca58-829a2f348e2mr4772406b3a.41.1772869641947;
        Fri, 06 Mar 2026 23:47:21 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:59cb:c81:de53:1143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm3970820b3a.17.2026.03.06.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:47:20 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 07 Mar 2026 15:47:15 +0800
Subject: [PATCH] spi: axiado: Remove redundant pm_runtime_mark_last_busy()
 call
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAALYq2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNz3cSKzMSUfF1DXbNkCxMjS7OkVJNEIyWg8oKi1LTMCrBR0bG1tQD
 gdghEWgAAAA==
X-Change-ID: 20260307-axiado-1-6c84296be4a2
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Harshit Shah <hshah@axiado.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772869637; l=1011;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=75e1lv9Zspk1Yn0ZaGCEQTR5dnPaiJ708BBDY7KFgho=;
 b=2/Bv0N9XW6gxyCPmTUnBk/9Q3k+xdUY5JCrXf/I2nuBVZwXriVFmO+IsoPc5uwksPKv9TisXF
 R712Si5ImMpClUWifArZ2bpP+lMC7Z8XADU8hLFYzsNMod19xsIjdru
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The pm_runtime_mark_last_busy() call is redundant in the probe function
as pm_runtime_put_autosuspend() already calls pm_runtime_mark_last_busy()
internally to update the last access time of the device before queuing
autosuspend.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-axiado.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 8cea81432c5b..bd5f67acc4f6 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -850,7 +850,6 @@ static int ax_spi_probe(struct platform_device *pdev)
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	ctlr->mem_ops = &ax_spi_mem_ops;

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-axiado-1-6c84296be4a2

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

