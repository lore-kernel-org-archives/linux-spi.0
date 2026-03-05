Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AE39C62F
	for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2026 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713367; cv=none; b=fhifuBIT0/P2Pe51jnuZa10Z+b8gtDAyRgEgvmkpcBgRG4vbfqsShTnnCSAenv7JTz9oTWzBY5Otmi1E/5z/hxiufWxQgj3/v0XoUAXpWjSPFgL4b8o97/fr+gzeYzUw8bqv1Ou9d8Y2ypLPKIbtFL41z5f3+om/YkFOsVHU++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713367; c=relaxed/simple;
	bh=8iORgatfmVP5UgG6g/BlL+aXI02Kvp/zHKVDzC4+mnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hd1XSKhX6Q5uBxKN4HjNuFGY0Xua2+og85wwMbh+DlNMp+Easr2SrvleyKiT4fCLeSnf3f8gA4pGToo+ANmPd/GNOPwW+SDZ5oR2lxskx4olpobmvXQMBCDZNbp5poN30vn9MgJxf8V6qOHvM0FgPTYB4WtWysJYAYxM/LB0yuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCtJMVlg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCtJMVlg"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so4461728a91.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Mar 2026 04:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772713363; x=1773318163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwncuHxUK8rN3Qk5GxAhA3CfVLVPC2HWFVZLds7JF8E=;
        b=eCtJMVlgAKQ4fHqcQVLUND5dOWjJXtlDItjpWgxycL2Q88btEVnRqMGTTD57QauEzl
         n/Whkx1yrMaEFCpWMrLCtkJouhhqyvRr5KY2G2S6zOZmI9YRImT/Cg/eCrvSM75XjbVK
         ur1h842FDxFMAklwxMFZJYwAZwTXgZjN7Te6Ny2cbIVLuVWTHQ0VP3jqRppJOQkW8jaJ
         a6Tv7EDmzFD1qcgf5yeV4wE/+urBrOqYKYLYrEuWc0ZL6ITxbLlSSh+KbXKULN2HI6Kp
         TGCkpz0CLz6/yl2/gOoUMfdI87X0SS9279sOfCNDJKIgllwk/fwPhyRCoDZTok0DdMgH
         Z6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772713363; x=1773318163;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwncuHxUK8rN3Qk5GxAhA3CfVLVPC2HWFVZLds7JF8E=;
        b=SMzDu14s6z6jeiq9yZs5noVdTPX8R1AW+TtXEVMBIRLuMnVvZhSUy9uryJqLanR+5B
         KNLTgnohk9tUR6aSGuP5jt76wQW/A6shL9G5L/f5LCArqsTc7Q9jZkfAlMvnP3SNUq/I
         0lDALRqzeJOrh3tfjWdP2rmvtyqJScsWmuQ50AuN1DgjIwoPO5e4Z1nbNMyIat8KukD2
         SEP87Ynt/QBUDOJtryClW57LdEgUfRXZENayIf6daL2WF9cZgBhyCUVSjcq1OoiF5imD
         PDBdY7MlPp/eIidOEr4wcv7Jr9j9Aa0HrdXXbXGjvz1XNgJuPbk7clQJB3dM/pq4DADS
         zNKA==
X-Gm-Message-State: AOJu0YxhG/C8BRXS7iwFrpQeCUXY5pgUk0nBrHPeC3cN6tzqxzqglf4I
	o/GFaSXUhy1S10LN2+NG2p1WDiNPVa30TqXQh2ClQXashPjr81BU2dj+
X-Gm-Gg: ATEYQzxIT4uTxUQl3y+CCRmCFnB4FPj9OMQ2gPPIKHwLgGEB5u9ubJ9Ia0ra57PIHbN
	I+BbiDOPT8GTkair9ehtz+ylcVwtJjLI0sNDhGTVbrkpjpNbbVFcX+x/sUcoOgXR6goUQiKo9UL
	qyrJE8up/GK5Zib+g8qVZr0/GFR3cx8WltB7AjU9oJGdtpfGxa96WuE4ZhjNaSLwJo1+/nXC354
	RaZ7EHAwLyBlVYD58DRqSsaBEkU+QiAgNW/tVqwLZSYDwA9fXaGzImaFh1R50FICtz8lcVjHuyP
	fCu8aKzAWwI2ipens0wlXUAgOJOYan+KQV+cFK4Or2U7O8ORwStsHSTvCvkcpZ0cUFfbxU6iC3W
	O5Aj8nsN70ZKid9RT5VAgMWqTaXj70yfnMdgxmmU80vyhiaW00pnPqMlXoS9iSqR+ED4eD7PkMA
	nczXUH8ywFvwXxwCuBWQ==
X-Received: by 2002:a17:90b:3f86:b0:356:2fc5:30d9 with SMTP id 98e67ed59e1d1-359a69ca6aemr5100049a91.10.1772713362487;
        Thu, 05 Mar 2026 04:22:42 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2::3a87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d407fcsm1880943a91.8.2026.03.05.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:22:42 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 05 Mar 2026 20:22:38 +0800
Subject: [PATCH] spi: atcspi200: Fix double-free in atcspi_configure_dma()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-atcspi2000-v1-1-eafe08dcca60@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI11qWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNT3cSS5OKCTCMDAwPdlFRTCwtLE0tji+QUJaCGgqLUtMwKsGHRsbW
 1AH2S1QNcAAAA
X-Change-ID: 20260305-atcspi2000-de58894938cd
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713361; l=2038;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=8iORgatfmVP5UgG6g/BlL+aXI02Kvp/zHKVDzC4+mnQ=;
 b=vMRyfx3/zILQoCMjgQ3ELPlDxIylxxeiaXj0qqP+KYsGEDh6wjysxWva4RQul+SFvZCNnI1lB
 EKiXOwIupqXBMz/5t0cn1Ca9lIqWfqDm+WJa6NNCM3RqHFdJ+PQ1KYD
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver uses devm_dma_request_chan() which registers automatic cleanup
via devm_add_action_or_reset(). Calling dma_release_channel() manually on
the RX channel when TX channel request fails causes a double-free when
the devm cleanup runs.

Remove the unnecessary manual cleanup and simplify the error handling
since devm will properly release channels on probe failure or driver
detach.

Fixes: 34e3815ea459 ("spi: atcspi200: Add ATCSPI200 SPI controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-atcspi200.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 2075058387f3..dd19fe9f9ee7 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -497,31 +497,17 @@ static int atcspi_init_resources(struct platform_device *pdev,
 
 static int atcspi_configure_dma(struct atcspi_dev *spi)
 {
-	struct dma_chan *dma_chan;
-	int ret = 0;
+	spi->host->dma_rx = devm_dma_request_chan(spi->dev, "rx");
+	if (IS_ERR(spi->host->dma_rx))
+		return PTR_ERR(spi->host->dma_rx);
 
-	dma_chan = devm_dma_request_chan(spi->dev, "rx");
-	if (IS_ERR(dma_chan)) {
-		ret = PTR_ERR(dma_chan);
-		goto err_exit;
-	}
-	spi->host->dma_rx = dma_chan;
+	spi->host->dma_tx = devm_dma_request_chan(spi->dev, "tx");
+	if (IS_ERR(spi->host->dma_tx))
+		return PTR_ERR(spi->host->dma_tx);
 
-	dma_chan = devm_dma_request_chan(spi->dev, "tx");
-	if (IS_ERR(dma_chan)) {
-		ret = PTR_ERR(dma_chan);
-		goto free_rx;
-	}
-	spi->host->dma_tx = dma_chan;
 	init_completion(&spi->dma_completion);
 
-	return ret;
-
-free_rx:
-	dma_release_channel(spi->host->dma_rx);
-	spi->host->dma_rx = NULL;
-err_exit:
-	return ret;
+	return 0;
 }
 
 static int atcspi_enable_clk(struct atcspi_dev *spi)

---
base-commit: fc7b1a72c6cd5cbbd989c6c32a6486e3e4e3594d
change-id: 20260305-atcspi2000-de58894938cd

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

