Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AD3DCDBE
	for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865651; cv=none; b=V09Fe3YEUJLdEESP7xv3pAADzkd7akoYpa3XsVqn9DIbE3aPMaD+OMgY26cA/fIe2vQSeIkZ45tTsuKamUfmTZwdXVxfrQs6UzkxpI4GZydUI1vJwMeBR2G6u2zpfbDufJY915JSfyMElv/AOenkWln/7rKIIu+rEpPfnOrsGI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865651; c=relaxed/simple;
	bh=Y4G8qeOAlLyitSmwDgedqstgSrqLdlv00S5ry4Dhr3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXDj6LuYK5sc5TrVTNA1LAmKJyoyMBnD7ZzdM/FeT4UPiguLiTxKkSpGGKBb8Sj2B4Zs5WSAE8hMt4nreYyMU2Oj1KwEN6j+4/NZLXFSDpC+T3PMdCTgbOGR3mWzLXkTodGwqhQ+gApiXVHbf5hMxhUUWpgziqeGgjyjpp6xF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8BI/IGl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8BI/IGl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80167f56cdso7214a12.3
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778865650; x=1779470450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLuPzKvrSzHkaCJJGeMDqoTA3l2mSjliAhV8bnUhOhA=;
        b=O8BI/IGlPM5gCq3yzV6j3VX0tzIK4wLLmwLrf8HPFMog5ByUS5hXgVxBw4tAJ5GQaT
         ZDZkcynXdIsXqC+fckJymwcAJYhavO2oWevqj3CjgeB56NMuH+JHYib6lacsG6CAlx6b
         BXxFlynhfxShaJZ6Jg8rE+46TSojsk+k6GyHld2yowrkK0CRoLi2bBbElkKVH8MBVYw5
         jGBklH6O6ENvzjixyE7TZX/qMv76dfMHG9dsuMUrvIv/+H7bvaxj0q2Ulju/qHoTi0xo
         tIBz0T950/Kwi0ER9MxL0WFkE2Upkrt5wpKSdLyDLIpzr8POnlABz7MxwRl5XyJYfXn5
         GAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865650; x=1779470450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLuPzKvrSzHkaCJJGeMDqoTA3l2mSjliAhV8bnUhOhA=;
        b=CLArhpezYFOCySKaYqn43UWE4ZWQhjBeKEBBRASHYnwk+HP1yLyihMli3BViscaZkt
         yqUg1WoHlKslOKHQ+wmADNUhVVWvQ2iiyyTOuEUZF9ZpVY21KrImjs1eR4T6FHHKGDA9
         ORNNEJwyzv5dHZ8emhrUbAR/xNWp7NOjDOpT5F2h9nQyzLKX8LLqYHnY19G6TfBxynjw
         qmlQGrxXemRTJuDpdLapy70p9d2rd1GPVFY0Ikh3kHkLs3TUe/95EnRWKuiykMPbZmdz
         DH6Gb8urP67KK3iKFmqokG63oPT1/XZYe48geaCSbFSht6+gUc+kKApYAxdlqL+OMOqg
         pAOA==
X-Gm-Message-State: AOJu0YxiZs1ccH/YWVKmqDlWcUKs0VqF9PoexNy4txYuZJR+oMaFg3Lj
	4cBx//HgVh5+QsOWz48qnFylAk8VjH48B9OXc8c8eEJzK8EauH22wtLH6YDMwxRN
X-Gm-Gg: Acq92OE2r/MiVFnPH/Ol65SgNuUuPoMZDLs8R/g/M9ssQe5mv63hnFTMTMKKyh1omgf
	nSD4beXsFiR3liB98pZEHMQcl+85KuGD6WUbE1oknM1NY5lMOcDZ+oLFn0igOpXzdF+x/Y6uB/i
	Yy1ziklZMrcOA7C1mh0lCUYtvlRk2TeyVL6wxfXF62OPZGzFEkP3xHvZPOrBS7a7KXjyH/fU+O4
	YoIVqN+CVZjTAkpb18qWsuS1DOWyY3IV7Fp/mRunxcT43pFiT18pG+vqFvkJk9C8tZQMbEcH0oU
	0gfSH4xTxEFTYDqI5YC/osXKWh0g3+oiIT9G4RpjpeenypNg4FzfrcES19wNmcMB/CKU1g8jbcB
	y3UOyCM0PTfzNmR/z+Md7NrVL8AfRSJwKR+ZI9oUlBe7/NHEm+CdQ5p9du6qvlivNNI8k7OIRIY
	7GID/vEZBHqUmUKp7MSVL0vSdtGLpqztpncps82M6g5mjykrAoIMRLKOaRSdpMob2wouy/f2hFd
	alJwCtEGDPDN1e2Zno=
X-Received: by 2002:a17:902:7688:b0:2ba:22db:e1e0 with SMTP id d9443c01a7336-2bd7e8aad48mr43607435ad.10.1778865649587;
        Fri, 15 May 2026 10:20:49 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600c3sm63151085ad.29.2026.05.15.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:20:49 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 16 May 2026 01:20:35 +0800
Subject: [PATCH 2/2] spi: atmel: fix DMA resource leak on probe error paths
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-atmel-v1-2-674fb4707af6@gmail.com>
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
In-Reply-To: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu.pirea@microchip.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778865636; l=2147;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Y4G8qeOAlLyitSmwDgedqstgSrqLdlv00S5ry4Dhr3o=;
 b=vYNHvbuBkLq8xy1hzqJDfrUoFwFc/yX8ohsH1Ku1L/igMJWL76sCYmv8fpBw6zA8qxw6a1iTU
 C9wu8+ztKqzCZWaWMXRx17ntiRkxLkkTHsfeLpeTZ0bF0iyuliCoVIx
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The DMA resources allocated by atmel_spi_configure_dma() were not
released when devm_request_irq() or clk_prepare_enable() failed.
Route these two error paths through out_free_dma so that
atmel_spi_release_dma() releases the channels.

The same issue existed in the gclk_prepare_enable() failure path,
which jumped to out_disable_clk and returned without DMA cleanup.
The new fall-through from out_disable_clk into out_free_dma now
handles it as well.

Fixes: 1ccc404a7fc4 ("spi/spi-atmel: add dmaengine support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-atmel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index e519a86a2b45..893f7c7ce358 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1625,12 +1625,12 @@ static int atmel_spi_probe(struct platform_device *pdev)
 					0, dev_name(&pdev->dev), host);
 	}
 	if (ret)
-		return ret;
+		goto out_free_dma;
 
 	/* Initialize the hardware */
 	ret = clk_prepare_enable(clk);
 	if (ret)
-		return ret;
+		goto out_free_dma;
 
 	/*
 	 * In cases where the peripheral clock is higher,the FLEX_SPI_CSRx.SCBR
@@ -1661,7 +1661,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	ret = spi_register_controller(host);
 	if (ret)
-		goto out_free_dma;
+		goto out_disable_rpm;
 
 	/* go! */
 	dev_info(&pdev->dev, "Atmel SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
@@ -1670,18 +1670,18 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_free_dma:
+out_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-
-	if (as->use_dma)
-		atmel_spi_release_dma(host, as);
-
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
-	clk_disable_unprepare(as->gclk);
+	if (as->gclk)
+		clk_disable_unprepare(as->gclk);
 out_disable_clk:
 	clk_disable_unprepare(clk);
+out_free_dma:
+	if (as->use_dma)
+		atmel_spi_release_dma(host, as);
 
 	return ret;
 }

-- 
2.43.0

