Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B5405F7;
	Mon, 15 Jun 2026 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490865; cv=none; b=o/FfazcbEshckJooR3wKaIzwN5f+p/+hIHWMZdDQIuje1RUFCPxHrM7BJYoPUmK1uSESXRm4KQrcICE2hdR4KU02NcfScAmBBJO3IsFyR1dDZOMwk5HP+Xqvs6+fYb+bc69f+QrG9N2V1Lr0i2I+mU/9ljayQHsqi8g+gz2TTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490865; c=relaxed/simple;
	bh=+v8B5Ir/Fx4AHoAqbNBrPrLrKanjwd/fYNLCeTr2dXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=loVVHEeb4av6NRgI0y5QHFTjctRxDW1Xt9X8H8CdA6vtPZs/qSWx5U5g96OIEJVeEyT27sIIbpb5UTWQ/mkZDIqhAyYSEBzyqH4+B9eZzS+7QrBgpqOh9LwLJVwFQVhSD0rdRhbggxhOOiTb+sC12I8b3ruuqxvF6N9bpeSCyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Jun 2026 11:34:22 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 00AD92068E61;
	Mon, 15 Jun 2026 11:34:21 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 15 Jun 2026 11:34:21 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan3.css.socionext.com (Postfix) with ESMTP id 7727C15FF;
	Mon, 15 Jun 2026 11:34:21 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RESEND PATCH v1] spi: uniphier: Fix completion initialization order before devm_request_irq()
Date: Mon, 15 Jun 2026 11:34:15 +0900
Message-Id: <20260615023415.190655-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver calls devm_request_irq() before initializing the completion
used by the interrupt handler. Because the interrupt may occur immediately
after devm_request_irq(), the handler may execute before init_completion().

This may result in calling complete() on an uninitialized completion,
causing undefined behavior. This has been observed with KASAN.

Fix this by initializing the completion before registering the IRQ.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Fixes: 5ba155a4d4cc ("spi: add SPI controller driver for UniPhier SoC")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-uniphier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index cc20fd11f03f..86fce9a571da 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -656,6 +656,8 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	priv->host = host;
 	priv->is_save_param = false;
 
+	init_completion(&priv->xfer_done);
+
 	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -679,8 +681,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	init_completion(&priv->xfer_done);
-
 	clk_rate = clk_get_rate(priv->clk);
 
 	host->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
-- 
2.34.1

