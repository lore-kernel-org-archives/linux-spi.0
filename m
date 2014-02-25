From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] spi: s3c64xx: Let spi core handle validating transfer
 length
Date: Tue, 25 Feb 2014 19:18:29 +0800
Message-ID: <1393327109.6723.3.camel@phoenix>
References: <1393327017.6723.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393327017.6723.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi core will handle validating transfer length since commit 4d94bd21b333
"spi: core: Validate length of the transfers in message".
So remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9ad5e3e..f19cd97 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -697,13 +697,6 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	bpw = xfer->bits_per_word;
 	speed = xfer->speed_hz ? : spi->max_speed_hz;
 
-	if (xfer->len % (bpw / 8)) {
-		dev_err(&spi->dev,
-			"Xfer length(%u) not a multiple of word size(%u)\n",
-			xfer->len, bpw / 8);
-		return -EIO;
-	}
-
 	if (bpw != sdd->cur_bpw || speed != sdd->cur_speed) {
 		sdd->cur_bpw = bpw;
 		sdd->cur_speed = speed;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
