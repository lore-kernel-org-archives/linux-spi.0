Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B830567D;
	Mon, 15 Jun 2026 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499596; cv=none; b=RZEj6MTLtmKqu0rLG9Cti2DRkMUl2fRUqBcpz/YTEjdhcrfe5V2peNhW//20yXsU4zs6UrEeyQ0UDWxl1Nl7geckYEo4MXCw+AWXltmJhgbN3cFAqeKC5EZNaeoz8jCQgeAvd8Y4bMKBN3PbUS25vAN/Xy9/LUJYmC/Fm+QHw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499596; c=relaxed/simple;
	bh=3FY+NC0g6Q+RU1leKwt2pnz0cnQZ/pSbcep7II0BipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4ouUojTHriIfvWiJNGWzSYBLwHYP3NiM2DpjqBFl8L6korLdkkNb1lHSkLHOdRZFxxh45JBOpyEynxAImASlG5LH4LzRwqk3bkMcHARbfuwWavMSO9wPtVwXwQoBqsN6ZoCbX25kPgYGEDuwdSofDhm5nr+EUwAzdkfK/o9vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWn4sMFl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWn4sMFl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9594E1F00A3A;
	Mon, 15 Jun 2026 04:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499595;
	bh=cTi/WvQWi7ZCt1F8ZMvykay0af/zDS+beThnnFM0MZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWn4sMFliRw0lcDAUFNKZmkI76AqWyXZBSnI4Hb/M7US8tV4xDrtvKRDNwJ1fBChO
	 uKtWccMETF18/Uu0K3Z42Lv+kjHgyWkyjoGkDkyIM03RagBF0KZINIcf7IgT3jMpJu
	 PFSKa6vfuklJAt+YwOThfptfZtiNk7MyZPeNfSlnJ9hAT+1muw4V+mRBHmdTp84xhk
	 RiIdVAIqdILeJ6L4EpCQrWCiGh0PmZZt5TgfGndsXcPF990Ugg+QK7Q89hWWC9J9Lf
	 9Na4z0XWkhoibHUAcrWkMa7Z9CW2UqrHtq46/zEC4aTcLJDK2AH+A+9weTJW5DQu6Q
	 P08DLJKP7KhkA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] spi: dw: fix first spi transfer with dma always fallback to PIO
Date: Mon, 15 Jun 2026 12:40:35 +0800
Message-ID: <20260615044039.9750-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even with proper dma engine support, the first spi transfer always
fallback to PIO, the reason is the dws->n_bytes is 0 after
initialization, so the dw_spi_can_dma() calling from __spi_map_msg()
return false, thus both tx_sg_mapped and rx_sg_mapped are false, so
for the first spi transfer, the spi_xfer_is_dma_mapped() reports false
thus fallback to PIO.

Although this brings no harm, we can simply fix this issue by
calcuating the "n_bytes" from xfer->bits_per_word.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index fe726b9b1780..bd70a7ed8067 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -247,11 +247,12 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 {
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 	enum dma_slave_buswidth dma_bus_width;
+	u8 n_bytes = roundup_pow_of_two(BITS_TO_BYTES(xfer->bits_per_word));
 
 	if (xfer->len <= dws->fifo_len)
 		return false;
 
-	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
+	dma_bus_width = dw_spi_dma_convert_width(n_bytes);
 
 	return dws->dma_addr_widths & BIT(dma_bus_width);
 }
-- 
2.53.0

