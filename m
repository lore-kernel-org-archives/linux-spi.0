From: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v1 3/3] spi: spi-fsl-dspi: Bug fix incorrect CS de-assert
Date: Wed, 13 May 2015 18:12:15 +0800
Message-ID: <1431511935-19820-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI chip select signal need to keep asserted between several
spi_transfer in the same spi_message usually.
But the driver will de-assert CS signal and the assert it between
serval spi_transfer in the same spi_message under some condiations.
This patch fix the bug.

Here is an example:
Assume you have two variables like the following,
struct spi_transfer a;
struct spi_transfer b;
if you send a spi_message only includes 'a' first,
and then you send a spi_message includes 'a' and 'b'
but without resetting 'a'.
Driver will de-assert CS and then assert CS between 'a' and 'b'.

Signed-off-by: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f6e2ef9..557842a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -365,10 +365,10 @@ static int dspi_transfer_one_message(struct spi_master *master,
 		dspi->cur_msg = message;
 		dspi->cur_chip = spi_get_ctldata(spi);
 		dspi->cs = spi->chip_select;
+		dspi->cs_change = 0;
 		if (dspi->cur_transfer->transfer_list.next
 				== &dspi->cur_msg->transfers)
-			transfer->cs_change = 1;
-		dspi->cs_change = transfer->cs_change;
+			dspi->cs_change = 1;
 		dspi->void_write_data = dspi->cur_chip->void_write_data;
 
 		dspi->dataflags = 0;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
