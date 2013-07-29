From: Christian Eggers <ceggers@gmx.de>
Subject: [resubmit2] [PATCH] spi: spi-davinci: Fix direction in dma_map_single()
Date: Mon, 29 Jul 2013 20:54:09 +0200
Message-ID: <1388690.s58sU4PUYE@p2400>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
To: spi-devel-general@lists.sourceforge.net,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following patch I already sent on 2013-04-18 and 2013-06-06. 
Unfortunately it hasn't been committed yet.

Commit 048177ce3b3962852fd34a7e04938959271c7e70 (spi: spi-davinci: 
convert to DMA engine API) introduced a regression: dma_map_single() 
is called with direction DMA_FROM_DEVICE for rx and for tx.

Signed-off-by: Christian Eggers <ceggers@gmx.de>
Cc: stable@vger.kernel.org # v3.7.x+
Acked-by: Matt Porter <mporter@ti.com>
---
--- drivers/spi/spi-davinci.c.orig	2013-04-18 20:54:02.728719412 +0200
+++ drivers/spi/spi-davinci.c	2013-04-18 20:54:51.900623956 +0200
@@ -608,7 +608,7 @@ static int davinci_spi_bufs(struct spi_d
 		else
 			buf = (void *)t->tx_buf;
 		t->tx_dma = dma_map_single(&spi->dev, buf,
-				t->len, DMA_FROM_DEVICE);
+				t->len, DMA_TO_DEVICE);
 		if (!t->tx_dma) {
 			ret = -EFAULT;
 			goto err_tx_map;
