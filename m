From: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [PATCH 13/17] spi/topcliff-pch: Delete an unnecessary return
 statement in two functions
Date: Fri, 13 Jan 2017 18:23:15 +0100
Message-ID: <64b7bf49-57fc-32a9-17e4-1b26b99bff13@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Date: Fri, 13 Jan 2017 15:57:03 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such statements here.

Signed-off-by: Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 4bba39e70c7b..0a876311b67b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -915,7 +915,6 @@ static void pch_spi_release_dma(struct pch_spi_data *data)
 		dma_release_channel(dma->chan_rx);
 		dma->chan_rx = NULL;
 	}
-	return;
 }
 
 static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
@@ -1292,7 +1291,6 @@ static void pch_free_dma_buf(struct pch_spi_board_data *board_dat,
 	if (dma->rx_buf_dma)
 		dma_free_coherent(&board_dat->pdev->dev, PCH_BUF_SIZE,
 				  dma->rx_buf_virt, dma->rx_buf_dma);
-	return;
 }
 
 static void pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
