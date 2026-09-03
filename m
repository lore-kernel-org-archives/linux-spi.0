Received: from mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1E4503EA
	for <linux-spi@vger.kernel.org>; Thu,  3 Sep 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434360; cv=none; b=qCyxHDLut5Z+QwPEadaRXlj/i+s2A45Z+R3zyG67/qSkT4wOBYKI9Bx+Ox11nK/MnYuOJVrLEqnHqxtym9nMpYE6nxEEdYPnAsFBivUgebb1kY5lRztHtFal3ipujV7+RdNOO4SNdPtIYmfpWLMEhIkXgmxJT5U7pxSg682cRe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434360; c=relaxed/simple;
	bh=JBNHhf6nRzYjITskj1JTklJvf9o8qYd23CNS21U+NsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=LdqLUuVqE/sqo3A+48ACXa1+MK+bDUqrl6lnCt3KrQJr+Vu27gp5ny5B8zkO8SmeiowdYcdQVedjPNON+Z+irADLgG9ZjDU6Fu2O66rrC2jKaR8fIfGpNzCyVnXRxeg1RMtFtPg37ysFeGGun0Xt/WVq9kI1V0J9rC+ocgTe2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-spi@vger.kernel.org
X-Envelope-To: linux-spi@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2ef24302bc664fd9;
	Thu, 03 Sep 2026 11:19:09 +0000
X-Mizu-Trace-ID: 2ef24302bc664fd9
X-Migadu-Flow: FLOW_OUT
From: Baoquan He <hebaoquan@kylinos.cn>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hch@lst.de,
	harry@kernel.org,
	Baoquan He <hebaoquan@kylinos.cn>,
	linux-spi@vger.kernel.org
Subject: [PATCH 04/13] spi: spi-ti-qspi: Don't use GFP_DMA when calling dma_alloc_coherent()
Date: Thu,  3 Sep 2026 19:18:27 +0800
Message-ID: <20260903111836.1777265-5-hebaoquan@kylinos.cn>
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
 drivers/spi/spi-ti-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 34b154922ff2..fb0d940883fb 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -855,7 +855,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->rx_bb_addr = dma_alloc_coherent(qspi->dev,
 					      QSPI_DMA_BUFFER_SIZE,
 					      &qspi->rx_bb_dma_addr,
-					      GFP_KERNEL | GFP_DMA);
+					      GFP_KERNEL);
 	if (!qspi->rx_bb_addr) {
 		dev_err(qspi->dev,
 			"dma_alloc_coherent failed, using PIO mode\n");
-- 
2.54.0

