From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: atmel: Make current_remaining_bytes to be int
Date: Thu, 27 Mar 2014 09:26:38 +0800
Message-ID: <1395883598.14364.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Don't use unsigned for current_remaining_bytes so we can check
current_remaining_bytes < 0 case.
Use int is enough for current_remaining_bytes.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 8005f98..485e6cc 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -224,7 +224,7 @@ struct atmel_spi {
 	struct platform_device	*pdev;
 
 	struct spi_transfer	*current_transfer;
-	unsigned long		current_remaining_bytes;
+	int			current_remaining_bytes;
 	int			done_status;
 
 	struct completion	xfer_completion;
@@ -1110,6 +1110,8 @@ static int atmel_spi_one_transfer(struct spi_master *master,
 				atmel_spi_next_xfer_pio(master, xfer);
 			} else {
 				as->current_remaining_bytes -= len;
+				if (as->current_remaining_bytes < 0)
+					as->current_remaining_bytes = 0;
 			}
 		} else {
 			atmel_spi_next_xfer_pio(master, xfer);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
