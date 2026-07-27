Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BB3D890B
	for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181641; cv=none; b=Wq2nHAaNS6T88n8nrUaFguz/m8oyTfCDq6ZJFBumhxL/DszO/z+soo41X9j7XHYfShibIDj5LKMR9trn3vF59f4FH5rfWJY05OzTo728mkWwO+XBuOLLy/67XD6aVTMqgWMpe1zC0nN64p3fc05lqc+7NDGOIe9he/+sqg55zGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181641; c=relaxed/simple;
	bh=oFzg3w1o83cUPrm6E2TI1hZm4hbYZedb89KGuqdzWKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMcBEbxznygs8NqPnMrNwLJCC6TkYJ+yn2PCB6xHIO+iqnKzT4Ofuxp4vTUGWKMyJu2R4GCrRrldTGW2S9NL5kDT+m2X2z3slPOpCVe4auctZEgQ/EgcfeR2z0uAxs4oCFdXr+RArRFZIPqE4uujhjirjjN6/xQdB8Rg3EEjRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4zjhzum; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4zjhzum"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso4408635a91.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785181636; x=1785786436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSCXn/eGldKKU2rs41dq3NxOCETw1/WpvSD3oUZHWac=;
        b=n4zjhzumYVNDgBAz/mnf5d7fgGm90Kcajp4lWw0hR0VgfvJ04SCDYvuLcDFEZGH+GX
         iaIxaBFrAe4nuzmfwR5nSToJkhlKofVIAgdyXWr3kQjX5S4b25E7ie2lfZTgf94iPtR0
         vDEo76DHHbbKf2kgFoq5DQgvmTbfXnS6mtFXLAXxdB8Z6dofYwXvzg6XnZu2/8VnXIgm
         xO+Snuab4XydULFd6OLI/4MRNJHLyhiDOR5oUeklULISouzRXa6/gQUEaUYo8LVXTiGT
         ozajlEjpQgX4MAiJ58FHapHYowNNi1bC1HOjqxmy3n4YrJ/SaCYLBMF1SJ1+D6UUvb4M
         giZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785181636; x=1785786436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSCXn/eGldKKU2rs41dq3NxOCETw1/WpvSD3oUZHWac=;
        b=sD8Pi94YMF5UoH6sMcd54a2AV6T9W4XdGhQt2Uwf6VnBlG0gzjA4J1MzjRsImQcQ4L
         HUANfLFB208lNzGnO2SjUPZG0bzLo5rIIQq7YoIBZq/1kj76saQaWsGI65pWpTWpozFw
         2rpb9QMGHUTk372vD11yg7vjBJGA3FeFuUIJr38Fb4+skWjG4wU5ZdcRcZkX51cWXilR
         Prp4nS8F3Nt+W9DzH3+bE8/xshYsu5HD6MIt+cGOvL3a7L9HMl8C1z6mqCvb8t8eFpP1
         UqlwNK35qSUVILlPUwjwjoQtuMHkFUhG7ZihyDiOqIOb7UquKihHJJ/vG7gtv+i0OOsI
         HDHg==
X-Gm-Message-State: AOJu0Yw4lspq+ItaMEreyuC8N1avUB3PwOGfBPItf0UzmNGch0mO0mtf
	BMY5kWBt/b/zFklIVXGAg8Av6SiTVdJH/2GAO1yzx8Trg5ETCEd4oF7H0gw+ZfQY
X-Gm-Gg: AR+sD10Wau5J8F5eu9eUSOhcKZPHN16OfSZvvxnHL1mpGDAOgnL6iozenVLOlhFoyqI
	aw1eKcLVTElf46m+Be0zjrnKlAr3tibCXhppdXe/bckRFbDxTVWjTJCjwgjPTM0iB6+FaJXg/YE
	+4RSfjWkAvrcmnx86K8PLUEpq4HECn0VhFeKcUwWhutKAoLSSqbcWSlXJe9AwsRldfnHTs17lQ7
	RHBrTnoTPRm190wfFPRO1Y8gHuYCaLGcK+jHZbjl5ks/zez1h+0C2ohahz7KN0dPFGaKaLksr+k
	yTI2OvHlY1WT2aucecF75jXkCsp0FYIn4cvlSDmBjlLvrmeFRlkO84h0q8wbqYiAd63KogJu8UT
	qqcqy6UHw8ZvluJ7xoqfPWXPMaTxLvzSoesuWKbsz8SbYVDWGR58O8CeLfXPNa0g0XjiP6cPSa/
	KRabyu00U3eW08AspeD6Z/PAbSo8Nd7NoDwVL0Yam7k6U6WgNXgrFytsi9kiwNQ20ylmdpL0n2I
	WNHoHhiTFXGFMHxmTA2A37n7nEf4RcaRQcewyKzlX7uyZ5Kh0vgxqe1jl8rgh/B2U797kBzamD7
X-Received: by 2002:a17:90b:5750:b0:38e:655c:6516 with SMTP id 98e67ed59e1d1-38f29265995mr9506496a91.0.1785181636524;
        Mon, 27 Jul 2026 12:47:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6410ff7dsm279656a91.4.2026.07.27.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:47:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: spi-mpc52xx: use platform_get_irq_optional for IRQ lookup
Date: Mon, 27 Jul 2026 12:47:14 -0700
Message-ID: <20260727194714.11354-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() calls with platform_get_irq_optional()
to fetch both IRQs in the probe function. This is a more portable
approach that works with both DT and non-DT platforms and follows
modern platform API conventions.

The -EPROBE_DEFER case is handled properly so deferred probe works
as expected, and invalid IRQ numbers are normalized to 0.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-mpc52xx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 70d8e17e8c43..563b1f627be9 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -392,6 +392,18 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	void __iomem *regs;
 	u8 ctrl1;
 	int rc, i = 0;
+	int irq0;
+	int irq1;
+
+	irq0 = platform_get_irq_optional(op, 0);
+	if (irq0 == -EPROBE_DEFER)
+		return irq0;
+	irq0 = max(irq0, 0);
+
+	irq1 = platform_get_irq_optional(op, 1);
+	if (irq1 == -EPROBE_DEFER)
+		return irq1;
+	irq1 = max(irq1, 0);
 
 	/* MMIO registers */
 	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
@@ -436,8 +448,8 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	ms = spi_controller_get_devdata(host);
 	ms->host = host;
 	ms->regs = regs;
-	ms->irq0 = irq_of_parse_and_map(op->dev.of_node, 0);
-	ms->irq1 = irq_of_parse_and_map(op->dev.of_node, 1);
+	ms->irq0 = irq0;
+	ms->irq1 = irq1;
 	ms->state = mpc52xx_spi_fsmstate_idle;
 	ms->ipb_freq = mpc5xxx_get_bus_frequency(&op->dev);
 	ms->gpio_cs_count = gpiod_count(&op->dev, NULL);
-- 
2.55.0

