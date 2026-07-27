Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA86429025
	for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183350; cv=none; b=EKcUAtw0wEnvxuzk99XdJmnRAnp69AMRbMz7kZMTL7HltHg1vpXU8m3Y9GRFnrtAAfPX2RbF9/88v1G5f6qinjsihmMiEvhyJTCztddXl3+4ezNNN+fHZTNHZb3P4FSVz6l612JrvRE/s4n38UlqQaXtzC5DkE34e4WG+lnXQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183350; c=relaxed/simple;
	bh=1GoRFCat+ErrB3hAtE60uqnxLaB3juM+9KFO4jka8VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTeJkekQ8PEX6dHGO69lOhyVuYNcJUYDmMNOGi2SuxR8/3vNu7CtudS2v28Thgyf2cfa7dvPigSnHDPcLJOsMNgf5YGP3IaxIMdZeB8blpDwRPgIa2YsfHkE2iZpgiBLw7Ktfh8LJq4MflC2sBD5dHhBAt9EQ2D2vFRs7xq25hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWHAtIWO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWHAtIWO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930f618435cso234921385a.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183346; x=1785788146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tDME+g3Hpcs7tuajmBtOQU1/TxU8l89I/sLTGgXuXUg=;
        b=MWHAtIWOjr5mq2Qyz3MAvwpKWSj3xbqqY8c2TK8M1foQaleAGr8icAzHeELdsPz+D3
         SH23JyJZJ47U/hjMm+qoa0fI6rQcuHk7ZAoYVrm/HAfDZFSVDA0zBSkQvGUY7rHszQxD
         n+KV1HACM/PYN3LiVNb2CkNXswpPVGxBU2fBodKbs+jcXCKQ7qW7eOMzjL2a9rzd3+b2
         LXUQS0EA8nvkfscNzhjV8nEtI9DqT77nbSMEaoGxfOMI/ykkPcfX8BxcIu0xUVkB7DLI
         +CnAQ7jbNtU2dv4MD3LgfBuvCsCmJa4OMYJcqMPx8OmEJT8gdsdZBeoNCtfl0YeZK0y7
         acrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183346; x=1785788146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDME+g3Hpcs7tuajmBtOQU1/TxU8l89I/sLTGgXuXUg=;
        b=CApYM8l7E8QXpMVZdUvwkf78kwFXtNYHpXnVinf6F4VcVD0z05jSS2oDyE1/FDv3sz
         mDbLf/dFrv+KXbyPM+fWNKmZzYRbFeZt4qd0FonunnmGgoB2aM3XMKnGDVT9cuQJuhOU
         CUb3523ju43jolKsvY7BOjXZ5G7D90PKH/UXC2WY0sVEQ4AeSgJz/Pt6gHAAgzLpQSTs
         SvQl3FAolyhtgLxpWdMJNZL2MFYVhgSkCQqcfI0anr/Z73BpZ6Du1DFDYtOv1ZqHYUEx
         9iGGcs8KoHLrlSM6JhclCyvqGgKtFTsARk8YETqXox8NsEzvaiIDDb+3JWchz4JL2Spc
         IFLA==
X-Gm-Message-State: AOJu0YzlytgfI31kUJtC12D5gKUnZs65GxP8pbDhF51wsUQHjlCDV71F
	8R3tJ549k64tW6wryIluDsgLvqoA3Nnp+3Fd770uOnEnkoLoyEGjLwlEgN2CFEmL
X-Gm-Gg: AR+sD12qk0mh28C1BIXz60f11P4sDkRVzthr0t8/MAYwrQAIv+U2RGLJNjBZhm+hXqE
	VebmnsMa/fAZji3HHZ55ARiAJ4XIZ31Ci3fyFMCGM/XPO0b+/NrH5guYdsxf0TPFJ7+8oxM7AJh
	NP2GwB+w7ewulV2hlZLuHsEsfes5a7VNMISjXyGVVqaO1fiRAbq8oDxKAaIOKHxQyzCscySl7jP
	d7KPckCFaKnWLyzffmca5f4ZjENaFeu7cRE+Le8uyNLn6jHo9TK0VV4tqssBDoybUJm/KpmrA0A
	T5wFDVfiDVpmgzWC0trVj0YgpZZfsoG0qaMIYAPhF+0yCexHCdtOzyfIol+RMTYnijNPVulz7Xl
	zG35+mB62mlqyHS3Z52TzFXWAmAVam2WZug+ovOm0Iq1q042725Thuu33sAv7jOoEejRoyKQ6d3
	1+3wtJbXW885zQ2LvCyjVpTP3cwsQLl2r/5j4uWeEN/Rqoz6XDtkovutk1a05fk1eIdInffwuTB
	TRm/pMa8SprwWe7iLyoK3MId++fU+cg1/NAiq2d9F6VF1CRtptFRoaE9VCXt+BsLw==
X-Received: by 2002:a05:620a:2403:10b0:92e:c197:e9f5 with SMTP id af79cd13be357-932df75c07fmr788497585a.77.1785183345611;
        Mon, 27 Jul 2026 13:15:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de569a84sm697800985a.21.2026.07.27.13.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:15:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: ath79: use devm everywhere in probe
Date: Mon, 27 Jul 2026 13:15:43 -0700
Message-ID: <20260727201543.18857-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_spi_alloc_host() instead of spi_alloc_host() so that the spi
controller is automatically freed on probe failure or device removal.
This lets us eliminate the err_put_host label and goto error path in
probe, as well as the spi_controller_put() call in remove.

It's also a bit weird as everything in probe is using devm except the
first allocating function. Might fix an ordering issue on teardown.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-ath79.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 2f61e5b9943c..1f5d0fb03917 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -173,7 +173,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	unsigned long rate;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*sp));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sp));
 	if (host == NULL) {
 		dev_err(&pdev->dev, "failed to allocate spi host\n");
 		return -ENOMEM;
@@ -194,22 +194,16 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	sp->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sp->base)) {
-		ret = PTR_ERR(sp->base);
-		goto err_put_host;
-	}
+	if (IS_ERR(sp->base))
+		return PTR_ERR(sp->base);
 
 	sp->clk = devm_clk_get_enabled(&pdev->dev, "ahb");
-	if (IS_ERR(sp->clk)) {
-		ret = PTR_ERR(sp->clk);
-		goto err_put_host;
-	}
+	if (IS_ERR(sp->clk))
+		return PTR_ERR(sp->clk);
 
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
-	if (!rate) {
-		ret = -EINVAL;
-		goto err_put_host;
-	}
+	if (!rate)
+		return -EINVAL;
 
 	sp->rrw_delay = ATH79_SPI_RRW_DELAY_FACTOR / rate;
 	dev_dbg(&pdev->dev, "register read/write delay is %u nsecs\n",
@@ -224,9 +218,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 err_disable:
 	ath79_spi_disable(sp);
-err_put_host:
-	spi_controller_put(host);
-
 	return ret;
 }
 
@@ -236,7 +227,6 @@ static void ath79_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
-	spi_controller_put(sp->bitbang.ctlr);
 }
 
 static void ath79_spi_shutdown(struct platform_device *pdev)
-- 
2.55.0

