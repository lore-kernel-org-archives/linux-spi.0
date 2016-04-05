From: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: Fix cs_change handling in message transfer
Date: Tue,  5 Apr 2016 15:33:14 +0300
Message-ID: <1459859594-3414-1-git-send-email-andrey.vostrikov@cogentembedded.com>
Cc: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There are use cases when chip select should be triggered between transfers
in single SPI message. Current implementation does this only on last
transfer in message ignoring cs_change value provided in current transfer.

Signed-off-by: Andrey Vostrikov <andrey.vostrikov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 39412c9..c1a2d74 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -385,8 +385,8 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->cur_chip = spi_get_ctldata(spi);
 		dspi->cs = spi->chip_select;
 		dspi->cs_change = 0;
-		if (dspi->cur_transfer->transfer_list.next
-				== &dspi->cur_msg->transfers)
+		if (list_is_last(&dspi->cur_transfer->transfer_list,
+				 &dspi->cur_msg->transfers) || transfer->cs_change)
 			dspi->cs_change = 1;
 		dspi->void_write_data = dspi->cur_chip->void_write_data;
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
