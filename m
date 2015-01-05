From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: dw: Fix detecting FIFO depth
Date: Mon, 05 Jan 2015 09:32:56 +0800
Message-ID: <1420421576.6968.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current code tries to find the highest valid fifo depth by checking the value
it wrote to DW_SPI_TXFLTR. There are a few problems in current code:
1) There is an off-by-one in dws->fifo_len setting because it assumes the latest
   register write fails so the latest valid value should be fifo - 1.
2) We know the depth could be from 2 to 256 from HW spec, so it is not necessary
   to test fifo == 257. In the case fifo is 257, it means the latest valid
   setting is fifo = 256. So after the for loop iteration, we should check
   fifo == 2 case instead of fifo == 257 if detecting the FIFO depth fails.
This patch fixes above issues.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Reviewed-and-tested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index d0d5542..1a0f266 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -621,13 +621,13 @@ static void spi_hw_init(struct dw_spi *dws)
 	if (!dws->fifo_len) {
 		u32 fifo;
 
-		for (fifo = 2; fifo <= 257; fifo++) {
+		for (fifo = 2; fifo <= 256; fifo++) {
 			dw_writew(dws, DW_SPI_TXFLTR, fifo);
 			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
 				break;
 		}
 
-		dws->fifo_len = (fifo == 257) ? 0 : fifo;
+		dws->fifo_len = (fifo == 2) ? 0 : fifo - 1;
 		dw_writew(dws, DW_SPI_TXFLTR, 0);
 	}
 }
-- 
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
