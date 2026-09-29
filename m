Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55D524AF4;
	Tue, 29 Sep 2026 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685499; cv=none; b=YAsXbv3vhbTQFaREt25IdFBdVuWe1tCjFrgRPJdE57tggx6KSDNzzya5rVx2Ft4f9e8TWohpHwEK0ZLzcnrT31T+rx+A8jTs7alh9bazdNxFWn+DJrC4k3xDFfqCRL4pqos+WRBCrY+B4R+DHZE9xaQMpPO04ggQDc2UtSpJ3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685499; c=relaxed/simple;
	bh=s9t9vqFss4fnL6PsVZLuhqTrhB4WXEejgasTPMs2yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4Ev3PjX6YOg3rD9ONpV2XgNpRYejSV2pp13/siKjUE4f0jSf8Gt7quXvSbVGmKnQYJbQooLET/wPgi4y4NSkwMWAoTMDkv23M/4hB7bT7rDmWY5bLdjchZ+c8EUiEgaP38uCfcbRKhAr41wYMR1VCyTIkruLm+tahPUKjBsUto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxs21gkd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxs21gkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C3A1F00898;
	Tue, 29 Sep 2026 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685498;
	bh=ov9JwG7dTxYqZs760mQ1kon32dW5uXkE9+e7+SDMk24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxs21gkdX6rAPQH7a9fsAlBEu1oEvWxE+vvfllmHdUyl3P9REdXWaTlh2woFWtcrg
	 lbC66DaQ+bDgppbMmB49UQdxnu3WMzAA8Yf/eB4fryFtWF4s+tcrS7gaJvggLuIKo9
	 4OpmkQghX6GAGo+yIqlfm1DCkyhuJPQfkuraqQW7lxNm/4ikrV0JAWD3lP3+Y9ou5F
	 KCegNbweTBSeDdGO90Gm/2xQzY8DHEGdd8YS6Z4j5ZNdSMMV30Y3MdH9AB+b90RZ/P
	 1Un2U+jzHEx+OYlJFrZuTG2UfOL/BM9IqZvM8c0K8te1+BR4hyoSOb6k6UiTXTKHQb
	 gOhwxzJ5oGBzg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
Date: Tue, 29 Sep 2026 20:18:16 +0800
Message-ID: <20260929121817.20896-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929121817.20896-1-jszhang@kernel.org>
References: <20260929121817.20896-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent "enhanced" support changes the dw_spi_irq() behavior a bit
when !!ctlr->cur_msg:

    if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
            dw_spi_mask_intr(dws, 0xff);
            return IRQ_HANDLED;
    }

But it misses the dma case, where the transfer_handler ==
dw_spi_dma_transfer_handler, so this changes the previous long time
working behavior, let's restore the previous handling by only filtering
out the dw_spi_enh_handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 91de357f97f3..da7d4872e513 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -280,7 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
+	if (!ctlr->cur_msg && dws->transfer_handler != dw_spi_enh_handler) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-- 
2.53.0

