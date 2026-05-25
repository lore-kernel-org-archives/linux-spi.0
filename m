Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A78462
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731180; cv=none; b=JY8OJQPBPGEhygE4YIW3LRvTV6hDAsKe8Ya3Tajuu/dvnKPFhuABI/y9hN7nVL4S4D9t56FXsh9MGvE8PMrRs0dAxy1rd5kqGzPwuFN+BaImtN38BptUgyPE1TWTO2NRNU85PE3zQaplwsMuYplqchlWFGBnxOAU3tlIaRCsLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731180; c=relaxed/simple;
	bh=n7HVhrncspr10qbBa4sII0538CmxoZUHUMIHIe9Bljg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mx+TCtTHrAjPGgCytgBRl4ob5rEdpQXlAviVB88DnlSyiOMcDsgQJOXB+uWziLMw0cGU1x7vvJOYW4hEUpgRntGN02oj0ppdCzNO1Gt0fmZB9WPxwIfs4fX9aeNIs8Vu6Si6w+Q9fItD3jUKhRrBTpC9sEVHe0SqcjaCB6oXpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/aCjVgd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/aCjVgd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914b5f85129so301744085a.3
        for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779731178; x=1780335978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxCYMuiUoPFXfA4b1WnIaiXxDWxjUVKA/EAz/4H7APs=;
        b=F/aCjVgd526UMK5lAV4SWZ9g14poIunz2UWwCS0TzUyCdniMyx+xbXTTIm8Z/1x94A
         pvKS4tWP5qYR/dHXvciKa1NRgBZ9IXbwbVxQkpRm+sdD5uBPnmaftbGiA8A4lL9u+lI9
         zEhqhq9LWqjRUY4qL1UBOBD8Y8HdknX09bAEYUzYO12exxejSBtkcgvElEikDXJXd6FC
         OF2upgJURwq3qwCcbwibSm8LAQk4LLm20Eb7BmiUA9j6ZhF+OGGGeJR9xsQChqn4vu9X
         y2wPrVK9y+XiosZEgHlUg61IeYrbhdorhKArxfTJLD24ArCAzn0aSSYVW2GkDqQEZwIC
         2kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779731178; x=1780335978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxCYMuiUoPFXfA4b1WnIaiXxDWxjUVKA/EAz/4H7APs=;
        b=pNlxIkeM6xhQSPSnR8mYgU+WqkxfHc9dIoxyzSHK+A8OQtS396qSbbt8C0rkvyAlmI
         wte1jF7HEsfxTzHwirK1s3cmCxpUTNveLdwml1+bZjJOUEKYxe+3agIxLfsXK26oqE0B
         mv82hJC3ET7yeTfirB+amZskXSFsu1wx1rtMi1fZalZJhAGhPEEsmboFxoCQaJ42YTI6
         saUGDG+f+RN6K8n591ek6SU6A0iWuslqjSZJK4Xd9aBBN3gW7eS6ZT2eo0mTA8waguEV
         BV6dGm507AGXO5cnSFOrFqOWb+9ihaqaKP/cClZP4zLoHxD3X0wcf3DxteEoQ58j4hJi
         WpJg==
X-Forwarded-Encrypted: i=1; AFNElJ8G4agk2aV3ryzEdmmApuiyz0HFoOXKHqzQyFmt+Aw1Ai2K0jUwLjNtTCBc7/v7TxIYNsqk2RXGBH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwdClT5qwSwtQvk9GShHSNU/tKonCgsceSPXaAnwSk4J8UHY4
	GL36pEMu/bzIUDUmavP/TRgU/nUq+xZkCdjeHzllRJCj/4dFMxSKfYfz
X-Gm-Gg: Acq92OG2fX0AcgWIdesWZEi7njaoas28TfBVNU9/n7j7KtE8nHEwzjOAVioD1rmBj7L
	TlpjrZAbI7EYPVpMObR40jgmx9WJdwFaKMbJOUkjKWK65Murk4AvpwilgQkQNZ6dNgBSfWB7lRv
	xpqy/d6S4AGl9mGHNdUn+YEhONCl7CxamY+szA1XoE+dmjF+zml4jEgCiocEPtl5IlBkgABwJEj
	PVmbdGJbmvgQMn+bsMxjJM2gWBFpRxw1DrichCp4QEk5klaxlQp0tE1BKxzf/Ry3J3kKL/1vKvS
	q7PnR8q+wwimoojZSx+zw0ZoDgX2yyEAxod1MmJv/jxTKbcFh0P10WKGu7PJzYc1PX0Q2xTM6fv
	+RfkEvu2rKG7/pZkmAVNhRSbclzilNuJVbyKWtnIZJtZKSMhFupp7R9zqi8hKbtOR8e4DFLAbAD
	Lnm48gU/S/x4IjyrRxM1SIBy7ANHNvIugikYXo1HNb
X-Received: by 2002:a05:620a:2a08:b0:8b1:2853:673f with SMTP id af79cd13be357-914b48e5aeemr2262725785a.15.1779731178255;
        Mon, 25 May 2026 10:46:18 -0700 (PDT)
Received: from gfl-XPS-13-9340.xiphos.ca ([99.209.85.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba1b49csm1050653185a.44.2026.05.25.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:46:17 -0700 (PDT)
From: Gaetan Florio <gaetansjo@gmail.com>
To: broonie@kernel.org
Cc: michal.simek@amd.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gaetan Florio <gaetansjo@gmail.com>
Subject: [PATCH] spi: zynq-qspi: Remove redundant clock enables in setup
Date: Mon, 25 May 2026 13:46:14 -0400
Message-ID: <20260525174614.1052191-1-gaetansjo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QSPI clocks are already enabled in probe() with clk_prepare_enable().
zynq_qspi_setup_op() enables them again with clk_enable(), but the extra
enable is never balanced. This leaves the clock enable count elevated and
can trigger warnings when unbinding the driver.

Remove the redundant clock enables from the setup callback.

Signed-off-by: Gaetan Florio <gaetansjo@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5f23e902b..2aa2c9621 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -437,21 +437,10 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
-	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	ret = clk_enable(qspi->refclk);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(qspi->pclk);
-	if (ret) {
-		clk_disable(qspi->refclk);
-		return ret;
-	}
-
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
-- 
2.43.0

