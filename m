Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F540E8DC
	for <linux-spi@vger.kernel.org>; Thu,  3 Sep 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434390; cv=none; b=LdhBbLATKnk1rQ8VP3AtpvIDcxfAoCnFUYHGlKNUNCekfDyKKl8qNaiSfbTq4hB5r1O63+Q7h6gurj5oMMuYHB2F2LW+F5t1M57oNSSPmkCKVZCD6sFDloLbMGJVGe4KeZH1L0DNva2WzQ/SesbrhV0k2GQE7yMNCRqo+uWtwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434390; c=relaxed/simple;
	bh=8PW4m0lVpR5ao3YA9ebVGmJ2rHzmgwXUKgaJC1l0lFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=MaYDqGxdtU5wkXKwTuc+GicxFjQVd5oR7jcsm3WTTdTN6g8j69fRNmPNyg0zHBk+xhuqpqqhJ+hOuhd9ILV1hVbOZveEffZ2iMPi4Mx04rwW4HKHQ7I8aDA88YYmAayOsIQYOzbq1L5INbzvS5f1nNye/TP/5VMbM2hDV3Anh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-spi@vger.kernel.org
X-Envelope-To: linux-spi@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f8566ddbe06af796;
	Thu, 03 Sep 2026 11:19:38 +0000
X-Mizu-Trace-ID: f8566ddbe06af796
X-Migadu-Flow: FLOW_OUT
From: Baoquan He <hebaoquan@kylinos.cn>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hch@lst.de,
	harry@kernel.org,
	Baoquan He <hebaoquan@kylinos.cn>,
	linux-spi@vger.kernel.org
Subject: [PATCH 09/13] spi: atmel: Don't use GFP_DMA when calling dma_alloc_coherent()
Date: Thu,  3 Sep 2026 19:18:32 +0800
Message-ID: <20260903111836.1777265-10-hebaoquan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
References: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

dma_alloc_coherent() allocates the DMA buffer with the device's
addressing limitation in mind; the DMA core picks the zone from the
device's coherent DMA mask and ignores GFP_DMA passed by the caller.
Remove the redundant GFP_DMA flag.

Cc: linux-spi@vger.kernel.org
Signed-off-by: Baoquan He <hebaoquan@kylinos.cn>
---
 drivers/spi/spi-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index c8012c82c3a7..e91e84fdbe8f 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -624,7 +624,7 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
 		as->addr_tx_bbuf = dma_alloc_coherent(dev, SPI_MAX_DMA_XFER,
 						      &as->dma_addr_tx_bbuf,
-						      GFP_KERNEL | GFP_DMA);
+						      GFP_KERNEL);
 		if (!as->addr_tx_bbuf) {
 			err = -ENOMEM;
 			goto err_release_dma;
@@ -632,7 +632,7 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 
 		as->addr_rx_bbuf = dma_alloc_coherent(dev, SPI_MAX_DMA_XFER,
 						      &as->dma_addr_rx_bbuf,
-						      GFP_KERNEL | GFP_DMA);
+						      GFP_KERNEL);
 		if (!as->addr_rx_bbuf) {
 			err = -ENOMEM;
 			goto err_release_dma;
-- 
2.54.0

