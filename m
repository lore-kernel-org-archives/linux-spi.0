From: Christian Eggers <ceggers-Mmb7MZpHnFY@public.gmane.org>
Subject: spi: spi-davinci: Fix direction in dma_map_single()
Date: Thu, 18 Apr 2013 21:44:21 +0200
Message-ID: <8339377.qGdTICXBF1@p2400>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Commit 048177ce3b3962852fd34a7e04938959271c7e70 (spi: spi-davinci: 
convert to DMA engine API) introduced a regression: dma_map_single() 
is called with direction DMA_FROM_DEVICE for rx and for tx.

Signed-off-by: Christian Eggers <ceggers-Mmb7MZpHnFY@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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




------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
