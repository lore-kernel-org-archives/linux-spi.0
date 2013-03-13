From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: remove unused variable in tegra_slink_read_rx_fifo_to_client_rxbuf()
Date: Wed, 13 Mar 2013 21:29:12 +0800
Message-ID: <CAPgLHd8yTotMxH-Rb6UX3bsQrTTUM4SdQWNVDoU_LszgxM_qsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

The variable bits_per_word is initialized but never used
otherwise, so remove the unused variable.

Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index a829563..17224f0 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -375,9 +375,6 @@ static unsigned int tegra_slink_read_rx_fifo_to_client_rxbuf(
 		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 		read_words += tspi->curr_dma_words;
 	} else {
-		unsigned int bits_per_word;
-
-		bits_per_word = t->bits_per_word;
 		for (count = 0; count < rx_full_count; count++) {
 			x = tegra_slink_readl(tspi, SLINK_RX_FIFO);
 			for (i = 0; (i < tspi->bytes_per_word); i++)
