Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7B5505DA;
	Wed,  9 Sep 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965804; cv=none; b=IlOXfXGlUvztNRlTVhbeG50GUu/KiNUThhvMJjH8SD6FAyK42/vjDp3zxAbaAuhENZtciy5XPh8J3L17CtLKBmlvV9v5jwx3u2lUsWy0jCCNxlnoAGuZoBd04+pY3pjUMhTEuZaoIRLOj5+vk/QID3HlFEQB64kXh8Q4xSYN+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965804; c=relaxed/simple;
	bh=YoBqXSNWbmIJDpbWGo5PSN1FJHiwmzLJwcB374omhe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kul5zMdVyp4WJEmx+s2qLqUdE+OKKqq+/Lgs6c9AteWT0ZSHMe5wqu6Sl7oMMjWiYm7AzTKXMMtoSB5OPzMeLL8HLo/DjUftjrrNzMbM+7rwQae5aNdBoNgPGIyWHO+EKjZ9b1EkP7npz6uZRRWeC6sbD/rM2HEO+nXmKS1woDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q80N7y6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q80N7y6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E821F00A3E;
	Wed,  9 Sep 2026 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965802;
	bh=yAQ2P8CHyaU39zrns5eUxUPj6PC6Gwq9Dx1e55SbnRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q80N7y6jZkn00QJfFwdbi/QK0AnCiZmPSjikaWZumx8C18H6jr7frrV8B4jEX5sUj
	 SLLfrx2u4MGGVBKOgERWjVzW7AkbQZuzhb1Yn8jcMg9WUmzU5yAMNewOaqR7hsbNRF
	 nrfm8e/BbiRnFIAXS4/ISjMaQIfEGqhW4vq037UgzpTwED+fbCUQ+sEPn9dFEscS2p
	 H18Js/Jyahm/9zKieMmt+6rG10Y+RXJazxZQQ/Nf8gybOJzXv7oT64cBF2LiAiC6cp
	 cNin4shA/SCDtRoGYE0wlcHgd0vJUSRPJUU7fWC/rxGRUc5Xc0YJGkjatZeqRI8MXg
	 /24HpqlPE2KBw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] spi: dw: remove useless dws->transfer_handler check
Date: Wed,  9 Sep 2026 22:36:49 +0800
Message-ID: <20260909143652.9234-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909143652.9234-1-jszhang@kernel.org>
References: <20260909143652.9234-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

transfer_handler is initialized before any DW SPI interrupt is
unmasked. While the IRQ is registered but the handler is NULL,
dw_spi_hw_init() has all DW SPI interrupts disabled. Therefore
dw_spi_irq() cannot observe a DW SPI interrupt with a NULL
transfer_handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 1c060f0ec50c..f4c4e9dae25e 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -280,8 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!dws->transfer_handler ||
-	    (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler)) {
+	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-- 
2.53.0

