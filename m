Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD693496D31;
	Tue, 29 Sep 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685497; cv=none; b=oBu27wt1+irsAs60p+BrcJUJ5VEos+XgBAPk69CWiM3DC5FvFUhUAm5VTdoPLYoIbpY/zlsPpIrjhf5yKx0WEUwu/uzpm3ReZjRn0SiJ15h9F2LFFtnJV2vjvUreJMO9aksdPuuzYhgWaUF6Ijeq5j/ExAV9Th0WeA9vc5RlYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685497; c=relaxed/simple;
	bh=YoBqXSNWbmIJDpbWGo5PSN1FJHiwmzLJwcB374omhe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2cc/XvBL8UtFZJgD5XEljmy+vjXhKhPLfyodXmEfuk+5SVPaWbXPUk8Bzkm8gfuvJQjJtWHL54Mmykkv3mtn4u7I6TSdGbDKqyVtgyKORQw2DpAwsv4g5jDU/TgxkhU5SkL1zHR3XChFPFKzonp9jokrvHcMALa3fBVgMmK+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz3hc+6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz3hc+6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84961F0089A;
	Tue, 29 Sep 2026 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685495;
	bh=yAQ2P8CHyaU39zrns5eUxUPj6PC6Gwq9Dx1e55SbnRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yz3hc+6RgR95Sl4+oLMp7RZZxMmjGQN7yMdN0YehlyDLwa33ThvIFSoVGeev/go+J
	 hIrlFtYWE9gvywxaZlTpLfuOsekIbPGkyodyo32G5VMp6lYbYrGdds394qNF55f5/8
	 IOxre0newjbw3Or+tlEDZyhopp03NpkFfu0JN1xKuBqYWNIYhVwwdxCwlxDP4hGVfK
	 hBRX9TiHe/TcB7DtXWlH/P2svgT0i1cTqy0vdKBFq3Gm7qdEMZp7E3xuvKAyETGgiN
	 dQPYlFholB6mX6cNyNu6X5h6VnN+njzhR55USyMPSxloidpitly1KW+tGf0drK6P0w
	 bXtfs4H5Pa+Ng==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] spi: dw: remove useless dws->transfer_handler check
Date: Tue, 29 Sep 2026 20:18:14 +0800
Message-ID: <20260929121817.20896-3-jszhang@kernel.org>
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

