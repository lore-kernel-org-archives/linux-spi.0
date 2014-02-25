From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] spi: orion: Let spi core handle validating transfer
 length
Date: Tue, 25 Feb 2014 19:16:57 +0800
Message-ID: <1393327017.6723.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi core will handle validating transfer length since commit 4d94bd21b333
"spi: core: Validate length of the transfers in message".
So remove the same checking in this driver.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-orion.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 01bd85f..d018a4a 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -295,17 +295,6 @@ static int orion_spi_transfer_one_message(struct spi_master *master,
 		goto msg_done;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		/* make sure buffer length is even when working in 16
-		 * bit mode*/
-		if ((t->bits_per_word == 16) && (t->len & 1)) {
-			dev_err(&spi->dev,
-				"message rejected : "
-				"odd data length %d while in 16 bit mode\n",
-				t->len);
-			status = -EIO;
-			goto msg_done;
-		}
-
 		if (par_override || t->speed_hz || t->bits_per_word) {
 			par_override = 1;
 			status = orion_spi_setup_transfer(spi, t);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
