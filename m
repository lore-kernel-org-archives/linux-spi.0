Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AD473C75
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270576; cv=none; b=eL7bJZSeTi+p9daWH0squv2SMZm7rZEx4uzuIV4FTW7+1ckQAZAquJIlLwL/7k0zI71OVe03lJVPlNucUY+RBKSVCHnWTqFfVJjzMUA1end5QKa9fo8LOBkEFtbAlqf6S6ONJ/iLpykwjlGB7fWTTkEow6VkcMGVv8jZaTHGTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270576; c=relaxed/simple;
	bh=+f+brJ+RHQlgFtrhfZOGIjOcbp8IZhXW8NZ6FoGa/4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJelHCnB5rrKrYwsbZzKDyGG07FItk3MQMDjodeWaNucN1z8Pcv4TW+b1jlQtclPAwxCSt1dgY6n+Z2YlKOza5Y8RIk0Ga4SvSWfP3U2gY/dwML2SUcwp39mjJFaKuAW0ZjtQrjLT7b6uqM6zRDBz0LCTP82lx7WNai2oIDPLV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx2OyoNB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx2OyoNB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so228855a91.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270575; x=1785875375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kFyoFvNhLgxxtVQuPWo4EPXXXn5eoh7BKQjv6OLB6TU=;
        b=mx2OyoNBK/PIeqnyyZqNq2Xan/Z+AqepBpsbBrQfOUwEI/Qc/vFOU0udV8vdY3mFfZ
         PuHn+7CyeJ/QoynXKQ4DR4KxzNeNsdh1SE5FnnIs1DbwMWcYYtM6tLQnvn+xOk85GV33
         9QnhfFD4zPGOeDV7tjY0jD4uFfEjBpZvxgGbU1bLxC1COZQr9GXiiTevOg1wH3JlDFU+
         bDEwrEoZ7/A7ZmgjXoYoPqdiZgaEBROAdYhKWiCVBDWgF13gVWSjXPeU5gJRNZMTcNr6
         ula179jvrwgZKt86shEGeOq9Ibh46zbZDsgsY1XOLFOlxaSfdNkWKv/zlGGATp5XjbnX
         +uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270575; x=1785875375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kFyoFvNhLgxxtVQuPWo4EPXXXn5eoh7BKQjv6OLB6TU=;
        b=Wsm4YY6yeDd/nZISfsEf9d5t9HFRTpik6CJkVVSEgcvVCnKV9OS2ibzVOTls1b7TyA
         GA66LpYjDZlRsLEjq1veabMTgpuSVlIN3mIMSb6uRegQVZ27N2+VcddMuW/zr3X0E57w
         ALXKodAR5kMjZUdHg1Krw7XKOOVwT+kcvbHQ3Qe3mLVTw8YCtSOinX7WJabNjNZLI/+e
         P1w3L9kTjRjSaUC5P/WKdm0se8Igm6qSToFarZdsozNjK6nSsfxvhyCyOtBzFg/Xb/dH
         LfqHex905X5LGS4SIJBFUtgiUw5EDmbgBSyPu6jMz4ULYZv112FH2XqwiWq/K84YbEtS
         5QzA==
X-Gm-Message-State: AOJu0Yxf0bBGMHiZw5vyrCMEodBgWImB2uD5x4MVpG99bVvhDJ9TVudH
	XKAVeHk6QpLRcIyDTnJHFLXv72HCfNyYW5+D293aZIAkFKN5bsleWghMUXogtkr4
X-Gm-Gg: AR+sD10fvt7wPSAnvq0wrcrRzS1UU62PQ3z0YPGN5N/MgJCfklqTTT9D7f3UN0ufi/W
	w4laE7P1F9Wf2xM5rdsFiKjbCXv/UAPMBZ6tgtrICGxnD9Gy1/lgsG2E/aobDj7zakCGXIO05Fa
	+9DgUKFIRjVK1NAWLeE/GjMSVoLTMT19gI2CvEoNaGz9fJef14vfmBWlpRtXrMfvg33Z4UNAWiy
	Wkqtrw0pdfNAkQBgjdYpCTwUVySWxV1/s2i3rLGK0tEYrVm4IgNePlM55jfEI0eQmelfyAge9uN
	MU4LlXuGpLxoMh2pOXuAumjnZ9nujN+vsikqyqIaZFmhkEp4pcj2O0pF+IAzfo7sCWuvnS4VdTN
	VFM6mhFkfE/6TNLtedrmJt03xAxyrFWhbqejtCvoKe2zwhU3I3JN4zBbMmn3OhKldEsS1i97f+a
	qS8qHHf32THvk9I5oYpWEvJsxonkaIFit+9Hnj/VVtu7F55LcoIWNmsMieekikEH8+FguKVef5p
	c8fOuPtt1kYLje03NaC2xbnzFywYN4pKLiZUGKugjqUPGIzfBgFa7s=
X-Received: by 2002:a17:90b:17c5:b0:38f:1a80:d1e7 with SMTP id 98e67ed59e1d1-38f6a30503dmr4498514a91.13.1785270574991;
        Tue, 28 Jul 2026 13:29:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f8150241fsm51085a91.4.2026.07.28.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:29:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: ppc4xx: use of_property_read_u32 for clock frequency
Date: Tue, 28 Jul 2026 13:29:32 -0700
Message-ID: <20260728202932.16207-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace of_get_property with of_property_read_u32 for the
"clock-frequency" property, which is the modern typed DT accessor
that returns an error code directly and avoids the raw const unsigned
int * pointer dance.

Also drop the dev_err_probe wrapper on devm_request_irq failure,
returning ret directly since the core already logs probe errors.

Get rid of irqnum in the private struct. It's only used in _probe. Was
used in _remove before devm to free the irq.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-ppc4xx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 95c034cf2336..8a7d5aec12c1 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -112,7 +112,6 @@ struct ppc4xx_spi {
 	struct spi_bitbang bitbang;
 	struct completion done;
 
-	int irqnum;
 	/* need this to set the SPI clock */
 	unsigned int opb_freq;
 
@@ -339,7 +338,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	struct device *dev = &op->dev;
 	struct device_node *opbnp;
 	int ret;
-	const unsigned int *clk;
+	unsigned int opb_freq;
 	void __iomem *regs;
 	int irqnum;
 
@@ -390,22 +389,21 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 	/* Get the clock (Hz) for the OPB */
-	clk = of_get_property(opbnp, "clock-frequency", NULL);
+	ret = of_property_read_u32(opbnp, "clock-frequency", &opb_freq);
 	of_node_put(opbnp);
-	if (clk == NULL) {
+	if (ret) {
 		dev_err(dev, "OPB: no clock-frequency property set\n");
 		return -ENODEV;
 	}
-	hw->opb_freq = *clk;
-	hw->opb_freq >>= 2;
 
+	hw->opb_freq = opb_freq;
+	hw->opb_freq >>= 2;
 	hw->regs = regs;
-	hw->irqnum = irqnum;
 
-	ret = devm_request_irq(&op->dev, hw->irqnum, spi_ppc4xx_int,
+	ret = devm_request_irq(&op->dev, irqnum, spi_ppc4xx_int,
 			  0, "spi_ppc4xx_of", hw);
 	if (ret)
-		return dev_err_probe(dev, ret, "unable to allocate interrupt\n");
+		return ret;
 
 	spi_ppc4xx_enable(hw);
 
-- 
2.55.0

