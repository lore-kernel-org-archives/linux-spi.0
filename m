From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/7] spi: atmel: Let spi core validate Tx/Rx buffers for
 non-zero length transfer
Date: Wed, 19 Mar 2014 11:55:13 +0800
Message-ID: <1395201313.16346.3.camel@phoenix>
References: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395201227.16346.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index bda961e..c54492b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1065,11 +1065,6 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 
 	as = spi_master_get_devdata(master);
 
-	if (!(xfer->tx_buf || xfer->rx_buf) && xfer->len) {
-		dev_dbg(&spi->dev, "missing rx or tx buf\n");
-		return -EINVAL;
-	}
-
 	if (xfer->bits_per_word) {
 		asd = spi->controller_state;
 		bits = (asd->csr >> 4) & 0xf;
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
